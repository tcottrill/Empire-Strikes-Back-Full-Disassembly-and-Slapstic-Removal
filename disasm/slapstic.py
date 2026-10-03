"""The slapstic 137412-101 as The Empire Strikes Back uses it, and the resolver
for the maze the program reaches its paged routines through.

The chip sits on $8000-$9FFF and selects one of four 8K pages.  It watches the
addresses in that window (offset = address & $1FFF):

  $0000            arms the chip
  armed, then $0080 / $0090 / $00A0 / $00B0     selects page 0 / 1 / 2 / 3, disarms
  armed, then $1DFE, $1B5C+n, a page address    'alternate': selects page n
  armed, then $154x, a page address, then
      $1540 / $1541 / $1542 / $1543 (bit 0 clear, set; bit 1 clear, set; each
      use flips the low two address bits the next one must show), $1550-$1557,
      a page address                            'bitwise': selects the edited page

The state machine is MAME's (slapstic.c, by Aaron Giles and Frank Palazzolo).
Which bus cycles count is the driver's rule: the address of a jump into the
window, the address of the instruction a jump leaves the window from (except
the four page addresses), and every data access in the window; instruction
fetches do not count.

In the ROMs $8000-$80FF is the same on every page: 64 stubs of BITA $8000 / RTS.
A JSR or JMP to $8080, $8090, $80A0 or $80B0 therefore selects a page (if the
chip is armed), arms it again and returns.  $8100-$85EB is a maze of JSR and JMP
instructions that differs from page to page; entered at one of its entry points
on any page, it ends up calling one routine on one page.
"""

PAGE_ADDR = {0x0080: 0, 0x0090: 1, 0x00A0: 2, 0x00B0: 3}
WINDOW = (0x8000, 0xA000)
STUBS_END = 0x8100          # $8000-$80FF: BITA $8000 / RTS, the same on every page
MAZE_END = 0x85EC           # $8100-$85EB: the maze; real routines start here

def in_window(a):
    return 0x8000 <= a < 0xA000

class Slapstic:
    def __init__(self, page=3, state="DIS"):
        self.page, self.state = page, state
        self.bit_page = self.bit_xor = self.alt_page = 0

    def tweak(self, addr):
        off = addr & 0x1FFF
        if off == 0:
            self.state = "EN"
            return self.page
        st = self.state
        if st == "EN":
            if off & 0x1FF0 == 0x1540:
                self.state = "BIT1"
            elif off == 0x1DFE:
                self.state = "ALT2"
            elif off in PAGE_ADDR:
                self.page, self.state = PAGE_ADDR[off], "DIS"
        elif st == "ALT2":
            if off & 0x1FFC == 0x1B5C:
                self.state, self.alt_page = "ALT3", off & 3
            else:
                self.state = "EN"
        elif st == "ALT3":
            if off in PAGE_ADDR:
                self.page, self.state = self.alt_page, "DIS"
        elif st == "BIT1":
            if off in PAGE_ADDR:
                self.state, self.bit_page, self.bit_xor = "BIT2", self.page, 0
        elif st == "BIT2":
            x = (off ^ self.bit_xor) & 0x1FF3
            if x == 0x1540:
                self.bit_page &= ~1; self.bit_xor ^= 3
            elif x == 0x1541:
                self.bit_page |= 1; self.bit_xor ^= 3
            elif x == 0x1542:
                self.bit_page &= ~2; self.bit_xor ^= 3
            elif x == 0x1543:
                self.bit_page |= 2; self.bit_xor ^= 3
            elif off & 0x1FF8 == 0x1550:
                self.state = "BIT3"
        elif st == "BIT3":
            if off in PAGE_ADDR:
                self.page, self.state = self.bit_page, "DIS"
        return self.page

ALT_HELPER = 0x9DFE         # LDA 0,X / ASLA / RTS, the same on every page

def routine_effect(sl, page, addr):
    """Four routines on page 1 start with LDX #$9B5C+n / JSR $9DFE: the jump
    to $9DFE and the read of $9B5C+n are the chip's alternate sequence, which
    arms a switch to page n that the next page address commits.  So the page
    select the maze makes after such a routine returns selects page n, whatever
    it names.  -> n, or None for an ordinary routine."""
    o = page * 0x2000 + addr - 0x8000
    for k in range(0, 8):
        b = sl[o + k:o + k + 6]
        if len(b) == 6 and b[0] == 0x8E and b[1] == 0x9B and (b[2] & 0xFC) == 0x5C                 and b[3] == 0xBD and b[4] == 0x9D and b[5] == 0xFE:
            return b[2] & 3
    return None

def run_maze(sl, entry, page, state="EN", jump=False, limit=600):
    """Follow the stubs and the maze from a JSR (or, with jump=True, a JMP that
    has a return address above it) to `entry` with `page` selected.  A routine
    at or above MAZE_END is taken to return with the page and the chip state it
    was entered with.  Returns dict(calls=[(page, address)...], page=final page,
    state=final state, path=[(page, address)...] of maze instructions executed,
    end='ret' or a problem)."""
    s = Slapstic(page, state)
    stack = ["OUT"]
    pc = entry
    s.tweak(pc)
    calls, path = [], []

    def ret(prev):
        nonlocal pc
        r = stack.pop()
        if r == "OUT":
            if (prev & 0x1FFF) not in PAGE_ADDR:
                s.tweak(prev)
            return True
        pc = r
        s.tweak(pc)
        return False

    def out(end):
        return dict(calls=calls, page=s.page, state=s.state, path=path, end=end)

    for _ in range(limit):
        o = s.page * 0x2000 + (pc - 0x8000)
        op = sl[o]
        if pc >= MAZE_END:
            calls.append((s.page, pc))
            eff = routine_effect(sl, s.page, pc)
            if eff is not None:
                s.state, s.alt_page = "ALT3", eff
            if ret(pc):
                return out("ret")
            continue
        path.append((s.page, pc))
        if op in (0xBD, 0x7E):                      # JSR / JMP extended
            t = (sl[o + 1] << 8) | sl[o + 2]
            if op == 0xBD:
                stack.append(pc + 3)
            if not in_window(t):
                return out("leaves the window to $%04X" % t)
            pc = t
            s.tweak(pc)
        elif op == 0xB5:                            # BITA extended
            t = (sl[o + 1] << 8) | sl[o + 2]
            if in_window(t):
                s.tweak(t)
            pc += 3
        elif op == 0x80:                            # SUBA # (a stub entered one byte late)
            pc += 2
        elif op == 0x39:                            # RTS
            if ret(pc):
                return out("ret")
        else:
            return out("opcode $%02X at $%04X" % (op, pc))
    return out("does not end")

def resolve_entry(sl, entry):
    """What a JSR to maze address `entry` does, if it does the same thing from
    every page.  -> dict(page, target, restores) or None.  restores: the page
    selected on return is the caller's; otherwise it is `page`."""
    rs = [run_maze(sl, entry, p) for p in range(4)]
    if any(r["end"] != "ret" or len(r["calls"]) != 1 for r in rs):
        return None
    if len({r["calls"][0] for r in rs}) != 1:
        return None
    pg, tgt = rs[0]["calls"][0]
    if all(r["page"] == p for p, r in enumerate(rs)):
        return dict(page=pg, target=tgt, restores=True, leaves=None)
    if len({r["page"] for r in rs}) == 1:
        return dict(page=pg, target=tgt, restores=False, leaves=rs[0]["page"])
    return None

def maze_entries(sl):
    """Every address in the maze that resolves, -> {entry: dict}."""
    out = {}
    for e in range(STUBS_END, MAZE_END):
        r = resolve_entry(sl, e)
        if r:
            out[e] = r
    return out

if __name__ == "__main__":
    import image
    sl = image.load("esb_slapstic.bin")
    ents = maze_entries(sl)
    for e, r in sorted(ents.items()):
        print("$%04X  page %d $%04X  %s" % (e, r["page"], r["target"],
              "restores the caller's page" if r["restores"] else "leaves page %d selected" % r["leaves"]))
    print("%d entries, %d routines" % (len(ents), len({(r["page"], r["target"]) for r in ents.values()})))
