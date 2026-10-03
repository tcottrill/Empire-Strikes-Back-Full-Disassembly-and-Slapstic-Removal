"""Make a ROM set of The Empire Strikes Back for a real Star Wars board with no
slapstic and no expansion board: the four pages in ONE 27256 EPROM in socket
1H/J, paged by two outputs of the board's own output latch.

    python pcb27256.py

The slapstic 137412-101 pages four 8K ROM pages into $8000-$9FFF (slapstic.py).
A 27256 holds all four; its two top address lines choose the page:

    27256 A13 (pin 26)  <-  output latch $4682 (LED 3, D7)   page bit 0
    27256 A14 (pin 27)  <-  output latch $4683 (LED 2, D7)   page bit 1

The output latch at $4680-$4687 is the one that already holds W_BANK ($4684);
the two LED outputs only drive the diagnostic LEDs.  So the paging needs two
wires and no new part.  unslap.py (the $43F0 latch for an emulator or an added
decoder) is a separate set and is not changed by this one.

What is changed (every patch is checked against the bytes it expects):

  1. The four page-select stubs, on every page.  $8080+16n becomes
         PSHS Y / LDY #page bits / STY $4682 / PULS Y / BRA $80C0
     ($80C0 is one of the unused BITA $8000 / RTS copies).  STY writes $4682
     and then $4683 in consecutive cycles; the code is the same on all four
     pages, so the switch can happen under it.  A, B, X, U and the carry are
     as the caller left them, and the BITA leaves N, Z and V as the original
     stub does.  The stub is 28 cycles longer than the original.
  2. The two decoy calls and 3. the three selects after the alternate
     sequence: the same five page selects unslap.py redirects, found the same
     way (the chip's 'bitwise' and 'alternate' modes have no equivalent here).
  4. The self test.  Its ROM test selects the pages with data reads of the stub
     addresses while S holds the error bits (no stack), so it cannot call a
     stub.  It now loads the page bits from its table and stores them with
     STY $4682; the table at $EEFE holds the page bits instead of the stub
     addresses; and the two reads that select page 0 after the test become
     CLR $4682 / CLR $4683.
  5. Checksums: the page sum (page 0 $9941/$9942) and ROM 104's sum (bank 0
     $FFB3/$FFB4), as in unslap.py.

Not changed: RESET writes $00 to all three LEDs (page 0) and, before the
mainline starts, $FF (page 3, the slapstic's page at reset), so the latch's
state at power-on does not matter.  The diagnostics still flash the LEDs; no
page code runs then.

Then every call into the maze that the traced program makes, from every page it
can be made from, is run twice - original ROMs under the slapstic model, the new
image under the two latch bits, executing the new stubs' own bytes - and must
call the same routine on the same page and leave the same page selected.

Writes build/pcb27256/: esb_1hj.27256 (the EPROM for socket 1H/J, page 0 at
$0000), 136031-104.1m (the patched program ROM for 1M), esb_pcb_bank0.bin (the
emulator's bank 0 image; it uses esb_1hj.27256 as the pages) and
pcb27256_report.txt.  Every other chip is the original.
"""
import os, sys
import paths, image, esb, slapstic
from unslap import check, put, sum16, fix_sum

LATCH_A13 = 0x4682              # W_LED3: page bit 0
LATCH_A14 = 0x4683              # W_LED2: page bit 1
TAIL = 0x80C0                   # an unused BITA $8000 / RTS
STUB = {0x80: 0, 0x90: 1, 0xA0: 2, 0xB0: 3}

def bits(n):
    """The two bytes STY $4682 writes for page n: $4682 (A13), then $4683 (A14)."""
    return (0x80 if n & 1 else 0x00), (0x80 if n & 2 else 0x00)

def stub_bytes(n):
    s = 0x8080 + 0x10 * n
    hi, lo = bits(n)
    code = [0x34, 0x20,                         # PSHS Y
            0x10, 0x8E, hi, lo,                 # LDY  #page bits
            0x10, 0xBF, LATCH_A13 >> 8, LATCH_A13 & 0xFF,   # STY $4682: A13, then A14
            0x35, 0x20]                         # PULS Y
    bra = TAIL - (s + len(code) + 2)
    assert -128 <= bra < 128
    code += [0x20, bra & 0xFF]                  # BRA $80C0 (BITA $8000 / RTS)
    return code + [0x12] * (16 - len(code))     # NOPs, never reached

def walk(sl, entry, page, limit=800):
    """Run the maze on the new image: the latch bits are written by the stubs' own
    STY.  -> calls, final page, how it ended, and the page selects it executed."""
    stack, ystack = ["OUT"], []
    y = None
    latch = {LATCH_A13: 0x80 if page & 1 else 0, LATCH_A14: 0x80 if page & 2 else 0}
    pc = entry
    calls, selects = [], []
    for _ in range(limit):
        if pc >= slapstic.MAZE_END:                 # a routine of the page: the call lands here
            calls.append((page, pc))
            r = stack.pop()
            if r == "OUT":
                return dict(calls=calls, page=page, end="ret", selects=selects)
            pc = r
            continue
        o = page * 0x2000 + pc - 0x8000
        op = sl[o]
        if op in (0xBD, 0x7E):                      # JSR / JMP extended
            t = (sl[o + 1] << 8) | sl[o + 2]
            if t >> 8 == 0x80 and (t & 0xFF) in STUB:
                selects.append((page, pc))
            if op == 0xBD:
                stack.append(pc + 3)
            if not slapstic.in_window(t):
                return dict(calls=calls, page=page, end="leaves the window", selects=selects)
            pc = t
        elif op == 0x34 and sl[o + 1] == 0x20:      # PSHS Y
            ystack.append(y)
            pc += 2
        elif op == 0x35 and sl[o + 1] == 0x20:      # PULS Y
            y = ystack.pop()
            pc += 2
        elif op == 0x10 and sl[o + 1] == 0x8E:      # LDY #
            y = (sl[o + 2] << 8) | sl[o + 3]
            pc += 4
        elif op == 0x10 and sl[o + 1] == 0xBF:      # STY extended
            t = (sl[o + 2] << 8) | sl[o + 3]
            for a, v in ((t, y >> 8), (t + 1, y & 0xFF)):
                if a in latch:
                    latch[a] = v
                    page = (2 if latch[LATCH_A14] & 0x80 else 0) | (1 if latch[LATCH_A13] & 0x80 else 0)
            pc += 4
        elif op == 0x20:                            # BRA
            d = sl[o + 1]
            pc += 2 + (d - 256 if d > 127 else d)
        elif op == 0xB5:                            # BITA extended
            pc += 3
        elif op == 0x80:                            # SUBA #
            pc += 2
        elif op == 0x39:                            # RTS
            r = stack.pop()
            if r == "OUT":
                return dict(calls=calls, page=page, end="ret", selects=selects)
            pc = r
        else:
            return dict(calls=calls, page=page, end="opcode $%02X at $%04X" % (op, pc), selects=selects)
    return dict(calls=calls, page=page, end="does not end", selects=selects)

def maze_sites(tr, b0, b1, sl0):
    """(space, address, entry, chip state, pages it can run from) of every call into the maze."""
    pg = lambda page, a: page * 0x2000 + a - 0x8000
    sites = []
    for r in tr["code"]:
        sp, a, n, mn, slap, maze = r[:6]
        if not maze or (sp[0] == "P" and a < slapstic.MAZE_END):
            continue
        o = (b0 if sp == "B0" else b1 if sp == "B1" else sl0)
        base = a if sp[0] == "B" else pg(int(sp[1]), a)
        entry = (o[base + 1] << 8) | o[base + 2]
        state = "EN"
        if slap and "state " in slap:
            state = slap.split("state ")[1].split(":")[0]
        starts = [int(sp[1])] if sp[0] == "P" else [0, 1, 2, 3]
        sites.append((sp, a, entry, state, starts))
    return sites

def redirect(sl, page, addr, want, why, log):
    o = page * 0x2000 + addr - 0x8000
    t = 0x8080 + 0x10 * want
    put(sl, o, [sl[o], sl[o + 1], sl[o + 2]], [sl[o], t >> 8, t & 0xFF],
        "page %d $%04X: %s, page %d" % (page, addr, why, want), log)

def main(argv):
    sl0 = image.load("esb_slapstic.bin")
    b0 = bytearray(image.load("esb_main_bank0.bin"))
    b1 = image.load("esb_main_bank1.bin")
    sl = bytearray(sl0)
    tr = esb.load_trace("main")
    log = []

    pages_total = lambda: sum16(sl, 0x8000)
    rom4_total = lambda: sum16(bytes(b0[0xE000:0x10000]), sum16(b1[0xE000:0x10000], 0xE000))
    if pages_total() != 0xFFFF or rom4_total() != 0xFFFF:
        sys.exit("!! the original ROMs do not sum to $FFFF: the checksum model is wrong")

    # 1. the page-select stubs, the same on every page; the tail they branch to is left as it is
    for page in range(4):
        check(sl, page * 0x2000 + TAIL - 0x8000, [0xB5, 0x80, 0x00, 0x39], "page %d $%04X" % (page, TAIL))
        for n in range(4):
            s = 0x8080 + 0x10 * n
            put(sl, page * 0x2000 + s - 0x8000, [0xB5, 0x80, 0x00, 0x39] * 4, stub_bytes(n),
                "page %d $%04X: stub selects page %d" % (page, s, n), log)

    sites = maze_sites(tr, b0, b1, sl0)
    if sum(1 for s in sites if s[3] != "EN") != 2:
        sys.exit("!! expected two decoy calls (maze entered with the chip in its bitwise state)")

    # 2. the decoy calls: the first select on the path must keep the page
    for sp, a, entry, state, starts in sites:
        if state == "EN":
            continue
        page = starts[0]
        r = slapstic.run_maze(sl0, entry, page, state)
        if r["end"] != "ret" or len(r["calls"]) != 1 or r["calls"][0][0] != page or r["page"] != page:
            sys.exit("!! decoy call at %s $%04X does not stay on its page" % (sp, a))
        sel = walk(sl, entry, page)["selects"]
        if not sel or sel[0][0] != page:
            sys.exit("!! decoy call at %s $%04X: no page select on its own page to correct" % (sp, a))
        redirect(sl, page, sel[0][1], page, "the select the decoy call at $%04X skips" % a, log)

    # 3. the selects after the alternate-sequence routines: the last select must name the chip's page
    for _ in range(8):
        changed = False
        for sp, a, entry, state, starts in sites:
            if state != "EN":
                continue
            for page in starts:
                want = slapstic.run_maze(sl0, entry, page, state)
                got = walk(sl, entry, page)
                if want["calls"] != got["calls"]:
                    sys.exit("!! entry $%04X from page %d calls %s on the new image, %s with the slapstic" % (
                        entry, page, got["calls"], want["calls"]))
                if want["page"] != got["page"]:
                    if not got["selects"]:
                        sys.exit("!! entry $%04X from page %d: no page select to correct" % (entry, page))
                    cp, ca = got["selects"][-1]
                    redirect(sl, cp, ca, want["page"], "select after the alternate sequence", log)
                    changed = True
        if not changed:
            break

    # 4. the self test's ROM test (bank 0, in ROM 104)
    put(b0, 0xF0AA,
        [0x7D, 0x80, 0x00, 0x1C, 0xFE, 0x6D, 0xD4, 0x8E, 0x80, 0x00, 0xE3, 0x81, 0xC9, 0x00, 0x89, 0x00, 0x6D, 0xD1],
        [0x10, 0xAE, 0xC1,                      # LDY ,U++    the page bits from the table
         0x10, 0xBF, LATCH_A13 >> 8, LATCH_A13 & 0xFF,   # STY $4682   select the page
         0x8E, 0x80, 0x00,                      # LDX #$8000
         0x1C, 0xFE,                            # ANDCC #$FE
         0x20, 0x04,                            # BRA $F0BC   the summing loop, from the first word
         0x12, 0x12, 0x12, 0x12],               # NOPs, never reached
        "bank 0 $F0AA: select each page by STY $4682, then sum it", log)
    put(b0, 0xF0E3, [0xB6, 0x80, 0x00, 0xB6, 0x80, 0x80],
        [0x7F, LATCH_A13 >> 8, LATCH_A13 & 0xFF, 0x7F, LATCH_A14 >> 8, LATCH_A14 & 0xFF],
        "bank 0 $F0E3: LDA $8000 / LDA $8080 become CLR $4682 / CLR $4683", log)
    tab = []
    for n in range(4):
        tab += list(bits(n))
    put(b0, 0xEEFE, [0x80, 0x80, 0x80, 0x90, 0x80, 0xA0, 0x80, 0xB0], tab,
        "bank 0 $EEFE: the ROM test's table: page bits for $4682/$4683", log)

    # 5. checksums
    fix_sum(pages_total, sl, 0x1941, 0x1942, "page 0 $9941/$9942: checksum of the four pages", log)
    fix_sum(rom4_total, b0, 0xFFB3, 0xFFB4, "bank 0 $FFB3/$FFB4: checksum of the ROM at 1M", log)

    # the proof: every call, from every page, on the slapstic and on the two latch bits
    n = 0
    for sp, a, entry, state, starts in sites:
        for page in starts:
            want = slapstic.run_maze(sl0, entry, page, state)
            got = walk(sl, entry, page)
            if (want["calls"], want["page"], want["end"]) != (got["calls"], got["page"], got["end"]):
                sys.exit("!! %s $%04X entry $%04X from page %d: %s with the slapstic, %s on the new image" % (
                    sp, a, entry, page, (want["calls"], want["page"]), (got["calls"], got["page"])))
            n += 1

    out = os.path.join(paths.BUILD, "pcb27256")
    os.makedirs(out, exist_ok=True)
    files = {
        "esb_1hj.27256": bytes(sl),
        "136031-104.1m": bytes(b0[0xE000:0x10000]) + bytes(b1[0xE000:0x10000]),
        "esb_pcb_bank0.bin": bytes(b0),
    }
    for name, data in files.items():
        with open(os.path.join(out, name), "wb") as f:
            f.write(data)
    changed = sum(1 for i in range(len(sl)) if sl[i] != sl0[i])
    with open(os.path.join(out, "pcb27256_report.txt"), "w", newline="\n") as f:
        f.write("The Empire Strikes Back on a Star Wars board: the four pages in one 27256 at 1H/J\n")
        f.write("page bits: 27256 A13 <- latch $4682 (LED 3) D7, A14 <- latch $4683 (LED 2) D7\n\n")
        f.write("%d patches, %d bytes changed in the pages\n" % (len(log), changed))
        for l in log:
            f.write("  " + l + "\n")
        f.write("\n%d maze calls run on the slapstic and on the two latch bits: all agree\n" % n)
    print("  %d patches, %d bytes changed in the pages; %d maze calls agree with the slapstic" % (len(log), changed, n))
    print("  wrote %s: %s, pcb27256_report.txt" % (out, ", ".join(sorted(files))))
    return 0

if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
