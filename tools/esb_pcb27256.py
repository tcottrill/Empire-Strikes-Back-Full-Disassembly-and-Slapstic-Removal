#!/usr/bin/env python3
"""esb_pcb27256.py - make the two EPROM images that run The Empire Strikes Back
(Atari, 1985) on a Star Wars board with no slapstic and no expansion board.

    python esb_pcb27256.py esb.zip [outdir]

One file, no dependencies.  Give it your own MAME `esb` ROM set; it writes to
outdir (default: esb_pcb27256 next to the zip):

    esb_1hj.27256   32K, for a 27256 / 27C256 in socket 1H/J: the four 8K pages
                    of the two expansion ROMs 136031-105 and -106, patched
    136031-104.1m   16K, the program ROM for socket 1M, patched (self test)

Every other ROM and PROM of the ESB set is used as it is.  The board work this
needs is written up in docs/PCB_27256.md of the disassembly project this tool
comes from; in short:

    27256 pin 26 (A13)  <-  output latch $4682 (the LED 3 output)   page bit 0
    27256 pin 27 (A14)  <-  output latch $4683 (the LED 2 output)   page bit 1

with pins 26 and 27 kept out of the board's socket.  The latch is the one that
already holds W_BANK ($4684); nothing new is added to the board.

Nothing in the ROMs is encrypted.  The slapstic 137412-101 is a paging chip: it
decides which of the four pages is visible at $8000-$9FFF by watching the
addresses the CPU uses.  The program selects a page by jumping to one of four
stubs; here each stub writes the page number to the two latch bits itself:

    PSHS Y / LDY #bits / STY $4682 / PULS Y / BRA $80C0 (BITA $8000 / RTS)

What is patched, and why (the analysis and its proof are in the disassembly
project - disasm/pcb27256.py and docs/SLAPSTIC.md):

  1. the four page-select stubs on each page ($8080, $8090, $80A0, $80B0);
  2. two page selects on page 3 that the program relies on the chip to
     swallow (it puts the chip in its 'bitwise' mode first): they now select
     page 3, the page that is already there;
  3. three page selects on page 1 that the chip redirects (its 'alternate'
     mode): they now name the page the chip would give;
  4. the self test's ROM check, which selected the pages by reading the stub
     addresses: it now stores the page bits with STY $4682, from its table;
  5. the two pairs of spare bytes that make the self test's checksums come out,
     for the pages and for the patched program ROM.

The other chips can be the unpatched ESB ones (136031-101, -102, -203 on the
main board, the sound and vector ROMs, the PROMs).  The input ROMs are checked
by CRC32 and every patch only goes where the bytes it expects are, so another
ROM revision is refused rather than damaged.  Not tried on a real board.
"""
import os, sys, zipfile, zlib

CRC = {"105": 0xEA9E4DCE, "106": 0x76D07F59, "104": 0xFD5C725E}
LATCH_A13, LATCH_A14 = 0x4682, 0x4683
TAIL = 0x80C0

# page selects that are redirected: (page, address of the JSR/JMP, the stub it names, the page it must select)
CELLS = [
    (3, 0x82F8, 0x8090, 3, "select the bitwise decoy at $9875/$987C skips"),
    (3, 0x8220, 0x80A0, 3, "select the bitwise decoy at $98B1/$98B8 skips"),
    (1, 0x829B, 0x8090, 2, "select after the alternate-sequence routine $9063"),
    (1, 0x84F6, 0x8090, 0, "select after the alternate-sequence routine $8F8B"),
    (1, 0x8580, 0x8090, 3, "select after the alternate-sequence routine $8F16"),
]

def die(msg):
    sys.exit("esb_pcb27256: " + msg)

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

def bits(n):
    """The two bytes STY $4682 writes for page n: to $4682 (A13), then to $4683 (A14)."""
    return (0x80 if n & 1 else 0x00), (0x80 if n & 2 else 0x00)

def stub(n):
    s = 0x8080 + 0x10 * n
    hi, lo = bits(n)
    code = [0x34, 0x20, 0x10, 0x8E, hi, lo, 0x10, 0xBF, LATCH_A13 >> 8, LATCH_A13 & 0xFF, 0x35, 0x20]
    code += [0x20, (TAIL - (s + len(code) + 2)) & 0xFF]
    return code + [0x12] * (16 - len(code))

def pcb27256(rom105, rom106, rom104):
    """-> (27256 image, new 104, log).  The pages are 105 (pages 0, 1) and 106
    (pages 2, 3); 104 holds $E000-$FFFF of bank 0 in its first half and of
    bank 1 in its second."""
    pages = bytearray(rom105 + rom106)
    prog = bytearray(rom104)
    log = []
    pg = lambda page, addr: page * 0x2000 + addr - 0x8000
    b0 = lambda addr: addr - 0xE000                      # bank 0 half of 104

    if sum16(pages, 0x8000) != 0xFFFF or sum16(prog[:0x2000], sum16(prog[0x2000:], 0xE000)) != 0xFFFF:
        die("the ROMs do not sum the way the self test expects")

    for page in range(4):
        if bytes(pages[pg(page, TAIL):pg(page, TAIL) + 4]) != bytes([0xB5, 0x80, 0x00, 0x39]):
            die("page %d $%04X is not the stub this tool knows" % (page, TAIL))
        for n in range(4):
            s = 0x8080 + 0x10 * n
            put(pages, pg(page, s), [0xB5, 0x80, 0x00, 0x39] * 4, stub(n),
                "page %d $%04X: stub selects page %d" % (page, s, n), log)

    for page, addr, old_stub, want, why in CELLS:
        t = 0x8080 + 0x10 * want
        put(pages, pg(page, addr) + 1, [old_stub >> 8, old_stub & 0xFF], [t >> 8, t & 0xFF],
            "page %d $%04X: %s: page %d" % (page, addr, why, want), log)

    put(prog, b0(0xF0AA),
        [0x7D, 0x80, 0x00, 0x1C, 0xFE, 0x6D, 0xD4, 0x8E, 0x80, 0x00, 0xE3, 0x81, 0xC9, 0x00, 0x89, 0x00, 0x6D, 0xD1],
        [0x10, 0xAE, 0xC1, 0x10, 0xBF, LATCH_A13 >> 8, LATCH_A13 & 0xFF, 0x8E, 0x80, 0x00, 0x1C, 0xFE,
         0x20, 0x04, 0x12, 0x12, 0x12, 0x12],
        "self test $F0AA: LDY ,U++ / STY $4682 selects each page", log)
    put(prog, b0(0xF0E3), [0xB6, 0x80, 0x00, 0xB6, 0x80, 0x80],
        [0x7F, LATCH_A13 >> 8, LATCH_A13 & 0xFF, 0x7F, LATCH_A14 >> 8, LATCH_A14 & 0xFF],
        "self test $F0E3: CLR $4682 / CLR $4683 selects page 0", log)
    table = []
    for n in range(4):
        table += list(bits(n))
    put(prog, b0(0xEEFE), [0x80, 0x80, 0x80, 0x90, 0x80, 0xA0, 0x80, 0xB0], table,
        "self test $EEFE: the table of page bits", log)

    fix_sum(lambda: sum16(pages, 0x8000), pages, pg(0, 0x9941), pg(0, 0x9942),
            "page 0 $9941/$9942: checksum of the four pages", log)
    fix_sum(lambda: sum16(prog[:0x2000], sum16(prog[0x2000:], 0xE000)), prog, b0(0xFFB3), b0(0xFFB4),
            "$FFB3/$FFB4 (bank 0): checksum of the ROM at 1M", log)
    return bytes(pages), bytes(prog), log

def main(argv):
    args = [a for a in argv if not a.startswith("--")]
    if not args:
        print(__doc__)
        return 2
    src = args[0]
    out = args[1] if len(args) > 1 else os.path.join(os.path.dirname(os.path.abspath(src)), "esb_pcb27256")

    with zipfile.ZipFile(src) as z:
        files = {zlib.crc32(z.read(i.filename)) & 0xFFFFFFFF: z.read(i.filename) for i in z.infolist()}
    for key, crc in CRC.items():
        if crc not in files:
            die("136031-%s (CRC %08X) is not in %s" % (key, crc, src))
    eprom, rom104, log = pcb27256(files[CRC["105"]], files[CRC["106"]], files[CRC["104"]])

    os.makedirs(out, exist_ok=True)
    for name, data in (("esb_1hj.27256", eprom), ("136031-104.1m", rom104)):
        with open(os.path.join(out, name), "wb") as f:
            f.write(data)
    print("wrote %s" % out)
    print("page bits: 27256 A13 (pin 26) <- latch $4682 (LED 3), A14 (pin 27) <- latch $4683 (LED 2)")
    print("%d patches:" % len(log))
    for l in log:
        print("  " + l)
    print("  esb_1hj.27256  for socket 1H/J  CRC32 %08X" % (zlib.crc32(eprom) & 0xFFFFFFFF))
    print("  136031-104.1m  for socket 1M    CRC32 %08X" % (zlib.crc32(rom104) & 0xFFFFFFFF))
    return 0

if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
