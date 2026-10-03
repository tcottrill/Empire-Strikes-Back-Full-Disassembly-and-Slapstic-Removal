"""Make a ROM set of The Empire Strikes Back that needs no slapstic.

    python unslap.py [--latch 43F0] [--stub read|write]

The slapstic 137412-101 pages four 8K ROM pages into $8000-$9FFF by watching the
address bus (slapstic.py).  This tool rewrites the few places that depend on
it, so that the same pages can be selected by a plain latch:

    an access to LATCH+n selects page n (n = 0..3); page 3 at reset

which is what an emulator, or a small daughterboard in the slapstic's socket
plus one address decoder, would have to provide instead of the chip.  Two
forms of the page-select stub are offered:

  --stub read    (default)  BITA LATCH+n / RTS.  The latch must select on a
                 read and return $B5, the byte at $8000 of every page.  Then
                 the stub is the original's length, cycle count and flags, and
                 the program runs instruction for instruction and cycle for
                 cycle as it does with the chip - which is what lets an
                 emulator prove the set against the original (emu_src/tests).
                 This is the no-slapstic set the emulator runs (--set noslap).
  --stub write   STA LATCH+n / BITA $8000 / RTS.  The latch only has to answer
                 writes.  The BITA leaves the flags as the original stub does;
                 the stub is five cycles longer than the original.

What is changed (every patch is checked against the bytes it expects):

  1. The four page-select stubs.  $8080/$8090/$80A0/$80B0 hold BITA $8000 / RTS
     on every page, followed by three more copies that nothing calls; each
     becomes one of the two forms above (the write form runs over the first
     unused copy behind it).
  2. The two decoy calls.  On page 3, LDB $954x / JMP maze-entry relies on the
     chip swallowing the entry's page select (its 'bitwise' mode), so that the
     routine called is page 3's.  The page select the entry executes on page 3
     is pointed at page 3's stub, so the path keeps its length and the page
     stays.  (Only the decoys use those two entries from page 3.)
  3. The four routines on page 1 that begin LDX #$9B5C+n / JSR $9DFE.  That is
     the chip's 'alternate' mode: it makes the maze's page select after the
     routine choose page n instead of the page the select names.  The select
     the maze executes there is pointed at page n's stub.
  4. The self test.  It selects the pages with data reads (TST [,U] through a
     table of the stub addresses) to checksum them; the reads become writes to
     the latch (STA [,U], table changed to the latch addresses).
  5. Checksums.  The page ROMs and the ROM holding the self test are brought
     back to the sum the self test expects by adjusting the two spare bytes
     each has for that purpose.

Then every call into the maze that the traced program makes, from every page it
can be made from, is simulated twice - original ROMs under the slapstic model,
patched ROMs under the plain latch - and must call the same routine on the same
page and leave the same page selected.

Writes build/noslap/ (or build/noslap_write/ for --stub write): the three
changed chips (136031-105.3u, -106.2u, -104.1m), the two images the emulator
in emu_src loads (esb_noslap_bank0.bin, esb_noslap_slapstic.bin) and
noslap_report.txt.  The other chips are unchanged.
"""
import json, os, sys
import paths, image, esb, slapstic

def check(img, off, want, what):
    got = bytes(img[off:off + len(want)])
    if got != bytes(want):
        sys.exit("!! %s: expected %s, found %s" % (what, bytes(want).hex(), got.hex()))

def put(img, off, old, new, what, log):
    check(img, off, old, what)
    img[off:off + len(new)] = bytes(new)
    log.append("%-52s %s -> %s" % (what, bytes(old).hex().upper(), bytes(new).hex().upper()))

def run_plain(sl, entry, page, latch, limit=600):
    """The maze under the plain latch: a write to latch+n selects page n."""
    stack = ["OUT"]
    pc = entry
    calls = []
    for _ in range(limit):
        o = page * 0x2000 + pc - 0x8000
        op = sl[o]
        if pc >= slapstic.MAZE_END:
            calls.append((page, pc))
            r = stack.pop()
            if r == "OUT":
                return dict(calls=calls, page=page, end="ret")
            pc = r
            continue
        if op in (0xBD, 0x7E):
            t = (sl[o + 1] << 8) | sl[o + 2]
            if op == 0xBD:
                stack.append(pc + 3)
            if not slapstic.in_window(t):
                return dict(calls=calls, page=page, end="leaves the window")
            pc = t
        elif op in (0xB7, 0xB5):                            # STA / BITA extended: the latch
            t = (sl[o + 1] << 8) | sl[o + 2]
            if latch <= t < latch + 4:
                page = t - latch
            pc += 3
        elif op == 0x80:
            pc += 2
        elif op == 0x39:
            r = stack.pop()
            if r == "OUT":
                return dict(calls=calls, page=page, end="ret")
            pc = r
        else:
            return dict(calls=calls, page=page, end="opcode $%02X at $%04X" % (op, pc))
    return dict(calls=calls, page=page, end="does not end")

def last_select(sl, entry, page, latch, first=False):
    """(page, address) of the last (or first) JSR/JMP to a page stub executed on the plain path."""
    stack = ["OUT"]
    pc = entry
    last = None
    for _ in range(600):
        o = page * 0x2000 + pc - 0x8000
        op = sl[o]
        if pc >= slapstic.MAZE_END:
            r = stack.pop()
            if r == "OUT":
                return last
            pc = r
            continue
        if op in (0xBD, 0x7E):
            t = (sl[o + 1] << 8) | sl[o + 2]
            if (t & 0x1FFF) in slapstic.PAGE_ADDR:
                last = (page, pc)
                if first:
                    return last
            if op == 0xBD:
                stack.append(pc + 3)
            pc = t
        elif op in (0xB7, 0xB5):
            t = (sl[o + 1] << 8) | sl[o + 2]
            if latch <= t < latch + 4:
                page = t - latch
            pc += 3
        elif op == 0x80:
            pc += 2
        elif op == 0x39:
            r = stack.pop()
            if r == "OUT":
                return last
            pc = r
        else:
            return last
    return last

def sum16(data, seed):
    """The self test's sum: 16-bit add with end-around carry."""
    d = seed
    for i in range(0, len(data), 2):
        d += (data[i] << 8) | data[i + 1]
        if d > 0xFFFF:
            d = (d & 0xFFFF) + 1
    return d & 0xFFFF

def fix_sum(total, img, lo_off, hi_off, what, log):
    """Choose the two spare bytes (low byte of one word, high byte of the next)
    so that total() is $FFFF again."""
    old = (img[lo_off], img[hi_off])
    img[lo_off] = img[hi_off] = 0
    base = total()
    # end-around carry is arithmetic modulo $FFFF, where $FFFF stands for zero
    for v in ((0xFFFF - base % 0xFFFF) % 0xFFFF, 0xFFFF):
        img[lo_off], img[hi_off] = v & 0xFF, v >> 8
        if total() == 0xFFFF:
            log.append("%-52s %02X %02X -> %02X %02X" % (what, old[0], old[1], img[lo_off], img[hi_off]))
            return
    sys.exit("!! %s: no pair of bytes restores the checksum" % what)

def main(argv):
    latch = 0x43F0
    if "--latch" in argv:
        latch = int(argv[argv.index("--latch") + 1], 16)
    stub = "read"
    if "--stub" in argv:
        stub = argv[argv.index("--stub") + 1]
    if stub not in ("read", "write"):
        sys.exit("!! --stub read or --stub write")
    sl0 = image.load("esb_slapstic.bin")
    b0 = bytearray(image.load("esb_main_bank0.bin"))
    b1 = image.load("esb_main_bank1.bin")
    sl = bytearray(sl0)
    tr = esb.load_trace("main")
    log = []
    pg = lambda page, a: page * 0x2000 + a - 0x8000

    # the self test's sums must be right before anything is changed
    pages_total = lambda: sum16(sl, 0x8000)
    rom4_total = lambda: sum16(bytes(b0[0xE000:0x10000]), sum16(b1[0xE000:0x10000], 0xE000))
    if sum16(sl0, 0x8000) != 0xFFFF or rom4_total() != 0xFFFF:
        sys.exit("!! the original ROMs do not sum to $FFFF: the checksum model is wrong")

    # 1. the page-select stubs
    for page in range(4):
        for off, n in sorted(slapstic.PAGE_ADDR.items()):
            t = latch + n
            if stub == "read":
                put(sl, page * 0x2000 + off, [0xB5, 0x80, 0x00, 0x39], [0xB5, t >> 8, t & 0xFF, 0x39],
                    "page %d $%04X: stub selects page %d by BITA $%04X" % (page, 0x8000 + off, n, t), log)
            else:
                put(sl, page * 0x2000 + off, [0xB5, 0x80, 0x00, 0x39, 0xB5, 0x80, 0x00, 0x39],
                    [0xB7, t >> 8, t & 0xFF, 0xB5, 0x80, 0x00, 0x39, 0x39],
                    "page %d $%04X: stub selects page %d by STA $%04X" % (page, 0x8000 + off, n, t), log)

    # the calls into the maze that the traced program makes
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

    if sum(1 for s in sites if s[3] != "EN") != 2:
        sys.exit("!! expected two decoy calls (maze entered with the chip in its bitwise state)")

    # 2. the decoy calls
    for sp, a, entry, state, starts in sites:
        if state == "EN":
            continue
        page = starts[0]
        r = slapstic.run_maze(sl0, entry, page, state)
        if r["end"] != "ret" or len(r["calls"]) != 1 or r["calls"][0][0] != page or r["page"] != page:
            sys.exit("!! decoy call at %s $%04X does not stay on its page" % (sp, a))
        cell = last_select(sl, entry, page, latch, first=True)
        if cell is None or cell[0] != page:
            sys.exit("!! decoy call at %s $%04X: no page select on its own page to correct" % (sp, a))
        o = pg(page, cell[1])
        t = 0x8080 + 0x10 * page
        put(sl, o, [sl[o], sl[o + 1], sl[o + 2]], [sl[o], t >> 8, t & 0xFF],
            "page %d $%04X: the select the decoy call at $%04X skips now keeps page %d" % (
                page, cell[1], a, page), log)

    # 3. the page selects after the alternate-sequence routines
    for _ in range(8):
        changed = False
        for sp, a, entry, state, starts in sites:
            if state != "EN":
                continue
            for page in starts:
                want = slapstic.run_maze(sl0, entry, page, state)
                got = run_plain(sl, entry, page, latch)
                if want["calls"] != got["calls"]:
                    sys.exit("!! entry $%04X from page %d calls %s without the slapstic, %s with it" % (
                        entry, page, got["calls"], want["calls"]))
                if want["page"] != got["page"]:
                    cell = last_select(sl, entry, page, latch)
                    if cell is None:
                        sys.exit("!! entry $%04X from page %d: no page select to correct" % (entry, page))
                    cp, ca = cell
                    o = pg(cp, ca)
                    t = 0x8080 + 0x10 * want["page"]
                    put(sl, o, [sl[o], sl[o + 1], sl[o + 2]], [sl[o], t >> 8, t & 0xFF],
                        "page %d $%04X: select after the alternate sequence, page %d" % (cp, ca, want["page"]), log)
                    changed = True
        if not changed:
            break

    # 4. the self test
    put(b0, 0xF0AF, [0x6D, 0xD4], [0xA7, 0xD4], "bank 0 $F0AF: TST [,U] becomes STA [,U]", log)
    put(b0, 0xF0BA, [0x6D, 0xD1], [0xA7, 0xD1], "bank 0 $F0BA: TST [,U++] becomes STA [,U++]", log)
    put(b0, 0xF0E6, [0xB6, 0x80, 0x80], [0xB7, latch >> 8, latch & 0xFF],
        "bank 0 $F0E6: LDA $8080 becomes STA $%04X" % latch, log)
    tab = []
    for n in range(4):
        tab += [(latch + n) >> 8, (latch + n) & 0xFF]
    put(b0, 0xEEFE, [0x80, 0x80, 0x80, 0x90, 0x80, 0xA0, 0x80, 0xB0], tab,
        "bank 0 $EEFE: table of page selects for the ROM test", log)

    # 5. checksums
    fix_sum(pages_total, sl, pg(0, 0x9941), pg(0, 0x9942), "page 0 $9941/$9942: checksum of the four pages", log)
    fix_sum(rom4_total, b0, 0xFFB3, 0xFFB4, "bank 0 $FFB3/$FFB4: checksum of the ROM at 1M", log)

    # the proof: every call, from every page, with and without the chip
    n = 0
    for sp, a, entry, state, starts in sites:
        for page in starts:
            want = slapstic.run_maze(sl0, entry, page, state)
            got = run_plain(sl, entry, page, latch)
            if (want["calls"], want["page"], want["end"]) != (got["calls"], got["page"], got["end"]):
                sys.exit("!! %s $%04X entry $%04X from page %d: %s with the slapstic, %s without" % (
                    sp, a, entry, page, (want["calls"], want["page"]), (got["calls"], got["page"])))
            n += 1

    out = os.path.join(paths.BUILD, "noslap" if stub == "read" else "noslap_write")
    os.makedirs(out, exist_ok=True)
    chips = {
        "136031-105.3u": bytes(sl[:0x4000]),
        "136031-106.2u": bytes(sl[0x4000:]),
        "136031-104.1m": bytes(b0[0xE000:0x10000]) + bytes(b1[0xE000:0x10000]),
    }
    chips["esb_noslap_bank0.bin"] = bytes(b0)
    chips["esb_noslap_slapstic.bin"] = bytes(sl)
    for name, data in chips.items():
        with open(os.path.join(out, name), "wb") as f:
            f.write(data)
    with open(os.path.join(out, "noslap_report.txt"), "w") as f:
        f.write("The Empire Strikes Back without the slapstic\n")
        f.write("page latch: %s $%04X+n selects page n of $8000-$9FFF; page 3 at reset\n\n" % (
            "a write to" if stub == "write" else "an access to (a read returns $B5)", latch))
        f.write("%d patches\n" % len(log))
        for l in log:
            f.write("  " + l + "\n")
        f.write("\n%d maze calls simulated with and without the slapstic: all agree\n" % n)
    changed = sum(1 for i in range(len(sl)) if sl[i] != sl0[i])
    print("  %d patches, %d bytes changed in the pages; %d maze calls agree with and without the slapstic" % (
        len(log), changed, n))
    print("  wrote %s: %s, noslap_report.txt" % (out, ", ".join(sorted(chips))))
    return 0

if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
