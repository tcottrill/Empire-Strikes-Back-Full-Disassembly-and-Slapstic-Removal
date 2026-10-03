#!/usr/bin/env python3
"""esb_unslap.py - make a ROM set of The Empire Strikes Back (Atari, 1985) that
runs without the slapstic.

    python esb_unslap.py esb.zip [out.zip] [--stub read|write] [--latch 43F0]

One file, no dependencies.  Give it your own MAME `esb` ROM set; it writes a
copy in which three ROMs are patched (the two expansion ROMs 136031-105 and
-106, and the program ROM 136031-104) and the rest are as they were.

Nothing in the ROMs is encrypted, and this does not decrypt anything.  The
slapstic 137412-101 is a paging chip: the two expansion ROMs hold four 8K pages
of plain code, and the chip decides which one is visible at $8000-$9FFF by
watching the addresses the CPU uses.  The program selects a page by jumping to
one of four stubs in that window, and the chip sees the jump.  This tool makes
the stubs select the page themselves, through a plain latch:

    an access to LATCH+n selects page n (n = 0..3); page 3 at reset

so the patched set needs, in place of the chip, something that provides that
latch: an emulator, or a small board in the slapstic's socket plus a decoder.
LATCH is $43F0 unless --latch says otherwise ($43F0-$43F3 is not used by the
Star Wars board).

Two forms of the stub:

  --stub read   (default)  BITA LATCH+n / RTS
                The latch must select on a READ and return $B5 (the byte the
                original stub reads at $8000).  Then the stub has the
                original's length, timing and flags, and the game runs cycle
                for cycle as it does with the chip.
  --stub write  STA LATCH+n / BITA $8000 / RTS
                The latch only has to answer writes.  The stub is five CPU
                cycles longer than the original.

For a real Star Wars board use esb_pcb27256.py instead: nothing on the board
answers at LATCH.

What is patched, and why (the analysis and its proof are in the disassembly
project this tool comes from - disasm/unslap.py and docs/SLAPSTIC.md):

  1. the four page-select stubs on each page ($8080, $8090, $80A0, $80B0);
  2. two page selects on page 3 that the program relies on the chip to
     swallow (it puts the chip in its 'bitwise' mode first): they now select
     page 3, the page that is already there;
  3. three page selects on page 1 that the chip redirects (its 'alternate'
     mode): they now name the page the chip would give;
  4. the self test's ROM check, which selects the pages by reading the stub
     addresses: it now writes the latch;
  5. the two pairs of spare bytes that make the self test's checksums come out,
     for the pages and for the patched program ROM.

Every patch is applied only if the bytes it expects are there, and the input
ROMs are checked by CRC32, so a different ROM revision is refused rather than
damaged.
"""
import sys, zipfile, zlib

CRC = {"105": 0xEA9E4DCE, "106": 0x76D07F59, "104": 0xFD5C725E}
PAGE_STUB = {0: 0x8080, 1: 0x8090, 2: 0x80A0, 3: 0x80B0}

# page selects that are redirected: (page, address of the JSR/JMP, the stub it names, the page it must select)
CELLS = [
    (3, 0x82F8, 0x8090, 3, "select the bitwise decoy at $9875/$987C skips"),
    (3, 0x8220, 0x80A0, 3, "select the bitwise decoy at $98B1/$98B8 skips"),
    (1, 0x829B, 0x8090, 2, "select after the alternate-sequence routine $9063"),
    (1, 0x84F6, 0x8090, 0, "select after the alternate-sequence routine $8F8B"),
    (1, 0x8580, 0x8090, 3, "select after the alternate-sequence routine $8F16"),
]

def die(msg):
    sys.exit("esb_unslap: " + msg)

def put(img, off, old, new, what, log):
    if bytes(img[off:off + len(old)]) != bytes(old):
        die("%s: expected %s, found %s - not the ROM set this tool knows" % (
            what, bytes(old).hex().upper(), bytes(img[off:off + len(old)]).hex().upper()))
    img[off:off + len(new)] = bytes(new)
    log.append("%-58s %s -> %s" % (what, bytes(old).hex().upper(), bytes(new).hex().upper()))

def sum16(data, seed):
    """The self test's sum: 16-bit words, end-around carry."""
    d = seed
    for i in range(0, len(data), 2):
        d += (data[i] << 8) | data[i + 1]
        if d > 0xFFFF:
            d = (d & 0xFFFF) + 1
    return d & 0xFFFF

def fix_sum(total, img, lo, hi, what, log):
    """Set the two spare bytes (the low byte of one word, the high byte of the
    next) so that total() is $FFFF, which is what the self test wants."""
    old = (img[lo], img[hi])
    img[lo] = img[hi] = 0
    base = total()
    for v in ((0xFFFF - base % 0xFFFF) % 0xFFFF, 0xFFFF):
        img[lo], img[hi] = v & 0xFF, v >> 8
        if total() == 0xFFFF:
            log.append("%-58s %02X %02X -> %02X %02X" % (what, old[0], old[1], img[lo], img[hi]))
            return
    die("%s: no pair of bytes restores the checksum" % what)

def unslap(rom105, rom106, rom104, stub="read", latch=0x43F0):
    """-> (new 105, new 106, new 104, log).  The pages are 105 (pages 0, 1) and
    106 (pages 2, 3); 104 holds $E000-$FFFF of bank 0 in its first half and of
    bank 1 in its second."""
    pages = bytearray(rom105 + rom106)
    prog = bytearray(rom104)
    log = []
    pg = lambda page, addr: page * 0x2000 + addr - 0x8000
    b0 = lambda addr: addr - 0xE000                      # bank 0 half of 104

    if sum16(pages, 0x8000) != 0xFFFF or sum16(prog[:0x2000], sum16(prog[0x2000:], 0xE000)) != 0xFFFF:
        die("the ROMs do not sum the way the self test expects")

    for page in range(4):
        for n, stub_addr in PAGE_STUB.items():
            t = latch + n
            o = pg(page, stub_addr)
            if stub == "read":
                put(pages, o, [0xB5, 0x80, 0x00, 0x39], [0xB5, t >> 8, t & 0xFF, 0x39],
                    "page %d $%04X: stub BITA $%04X / RTS" % (page, stub_addr, t), log)
            else:
                put(pages, o, [0xB5, 0x80, 0x00, 0x39, 0xB5, 0x80, 0x00, 0x39],
                    [0xB7, t >> 8, t & 0xFF, 0xB5, 0x80, 0x00, 0x39, 0x39],
                    "page %d $%04X: stub STA $%04X / BITA $8000 / RTS" % (page, stub_addr, t), log)

    for page, addr, old_stub, want, why in CELLS:
        o = pg(page, addr)
        t = PAGE_STUB[want]
        put(pages, o + 1, [old_stub >> 8, old_stub & 0xFF], [t >> 8, t & 0xFF],
            "page %d $%04X: %s: page %d" % (page, addr, why, want), log)

    put(prog, b0(0xF0AF), [0x6D, 0xD4], [0xA7, 0xD4], "self test $F0AF: TST [,U] -> STA [,U]", log)
    put(prog, b0(0xF0BA), [0x6D, 0xD1], [0xA7, 0xD1], "self test $F0BA: TST [,U++] -> STA [,U++]", log)
    put(prog, b0(0xF0E6), [0xB6, 0x80, 0x80], [0xB7, latch >> 8, latch & 0xFF],
        "self test $F0E6: LDA $8080 -> STA $%04X" % latch, log)
    table = []
    for n in range(4):
        table += [(latch + n) >> 8, (latch + n) & 0xFF]
    put(prog, b0(0xEEFE), [0x80, 0x80, 0x80, 0x90, 0x80, 0xA0, 0x80, 0xB0], table,
        "self test $EEFE: the table of page selects", log)

    fix_sum(lambda: sum16(pages, 0x8000), pages, pg(0, 0x9941), pg(0, 0x9942),
            "page 0 $9941/$9942: checksum of the four pages", log)
    fix_sum(lambda: sum16(prog[:0x2000], sum16(prog[0x2000:], 0xE000)), prog, b0(0xFFB3), b0(0xFFB4),
            "$FFB3/$FFB4 (bank 0): checksum of the ROM at 1M", log)
    return bytes(pages[:0x4000]), bytes(pages[0x4000:]), bytes(prog), log

def main(argv):
    args = [a for a in argv if not a.startswith("--")]
    stub, latch = "read", 0x43F0
    for i, a in enumerate(argv):
        if a == "--stub" and i + 1 < len(argv):
            stub = argv[i + 1]
            args.remove(stub)
        elif a == "--latch" and i + 1 < len(argv):
            latch = int(argv[i + 1], 16)
            args.remove(argv[i + 1])
    if not args or stub not in ("read", "write"):
        print(__doc__)
        return 2
    src = args[0]
    out = args[1] if len(args) > 1 else src[:-4] + ("_noslap.zip" if stub == "read" else "_noslap_write.zip")

    with zipfile.ZipFile(src) as z:
        files = [(i.filename, z.read(i.filename)) for i in z.infolist()]
    by_crc = {zlib.crc32(d) & 0xFFFFFFFF: n for n, d in files}
    names = {}
    for key, crc in CRC.items():
        if crc not in by_crc:
            die("136031-%s (CRC %08X) is not in %s" % (key, crc, src))
        names[key] = by_crc[crc]
    data = dict(files)
    n105, n106, n104, log = unslap(data[names["105"]], data[names["106"]], data[names["104"]], stub, latch)
    data[names["105"]], data[names["106"]], data[names["104"]] = n105, n106, n104

    with zipfile.ZipFile(out, "w", zipfile.ZIP_DEFLATED) as z:
        for n, _ in files:
            z.writestr(n, data[n])
    print("wrote %s" % out)
    print("page latch: %s $%04X+n selects page n of $8000-$9FFF; page 3 at reset" % (
        "a write to" if stub == "write" else "an access to (a read must return $B5)", latch))
    print("%d patches:" % len(log))
    for l in log:
        print("  " + l)
    for key in ("105", "106", "104"):
        print("  %s  new CRC32 %08X" % (names[key], zlib.crc32(data[names[key]]) & 0xFFFFFFFF))
    return 0

if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
