"""Build the working ROM images from a MAME `esb` ROM set.

Chips are found by CRC32, not by file name, in every zip under ../roms (or in the
zip / directory given on the command line).  Writes to build/:

  esb_main_bank0.bin, esb_main_bank1.bin   64K main CPU space with W_BANK D7 = 0 / 1:
                                           vector ROM at $3000, the selected halves of
                                           the four 16K program ROMs at $6000 and
                                           $A000-$FFFF; $8000-$9FFF is left $FF
  esb_slapstic.bin                         32K, the four 8K pages the slapstic maps
                                           at $8000-$9FFF, page 0 first
  esb_sound.bin                            64K sound CPU space: the first halves of
                                           the two 16K sound ROMs at $4000 and
                                           $6000, the second halves at $C000 and
                                           $E000
  esb_mathbox.bin, esb_avgprom.bin         the PROMs

Each 16K program ROM holds its bank-0 half first and its bank-1 half second.
"""
import os, sys, zipfile, zlib
import paths

# part -> (crc32, size)
CHIPS = {
    "136031-101.1f": (0xEF1E3AE5, 0x4000),      # $6000, bank 0 / bank 1
    "136031-102.1jk": (0x62CE5C12, 0x4000),     # $A000, bank 0 / bank 1
    "136031-203.1kl": (0x27B0889B, 0x4000),     # $C000, bank 0 / bank 1
    "136031-104.1m": (0xFD5C725E, 0x4000),      # $E000, bank 0 / bank 1
    "136031-105.3u": (0xEA9E4DCE, 0x4000),      # slapstic pages 0, 1
    "136031-106.2u": (0x76D07F59, 0x4000),      # slapstic pages 2, 3
    "136031-111.1l": (0xB1F9BD12, 0x1000),      # vector ROM $3000
    "136031-113.1jk": (0x24AE3815, 0x4000),     # sound $4000 and $C000
    "136031-112.1h": (0xCA72D341, 0x4000),      # sound $6000 and $E000
    "136031-110.7h": (0xB8D0F69D, 0x0400),      # mathbox PROMs
    "136031-109.7j": (0x6A2A4D98, 0x0400),
    "136031-108.7k": (0x6A76138F, 0x0400),
    "136031-107.7l": (0xAFBF6E01, 0x0400),
    "136021-109.4b": (0x82FC3EB2, 0x0100),      # AVG state PROM (the Star Wars part)
}

def scan(where):
    """Yield (label, bytes) for every file in a zip, a directory, or the zips of a directory."""
    if os.path.isdir(where):
        for n in sorted(os.listdir(where)):
            p = os.path.join(where, n)
            if n.lower().endswith(".zip"):
                yield from scan(p)
            elif os.path.isfile(p):
                yield p, open(p, "rb").read()
    else:
        with zipfile.ZipFile(where) as z:
            for n in z.namelist():
                if not n.lower().endswith(".zip"):
                    yield "%s:%s" % (os.path.basename(where), n), z.read(n)

def find_chips(where):
    by_crc = {}
    seen_sizes = {}
    for label, data in scan(where):
        by_crc.setdefault(zlib.crc32(data) & 0xFFFFFFFF, (label, data))
        seen_sizes.setdefault(len(data), []).append((label, zlib.crc32(data) & 0xFFFFFFFF))
    found, missing = {}, []
    for part, (crc, size) in CHIPS.items():
        if crc in by_crc:
            found[part] = by_crc[crc]
        else:
            missing.append(part)
    return found, missing, seen_sizes

def build(where=None, verbose=True):
    where = where or paths.need(paths.ROMS_DIR, "ROM directory")
    paths.need(where, "ROM set")
    found, missing, sizes = find_chips(where)
    if verbose:
        for part in CHIPS:
            if part in found:
                print("  %-15s %08X  %s" % (part, CHIPS[part][0], found[part][0]))
    if missing:
        for p in missing:
            crc, size = CHIPS[p]
            cands = ", ".join("%s has %08X" % c for c in sizes.get(size, [])[:6]) or "no file of that size"
            print("!! %s not found: need CRC %08X (%d bytes); %s" % (p, crc, size, cands))
        sys.exit(1)
    rom = {p: found[p][1] for p in found}
    def main(bank):
        o = bank * 0x2000
        m = bytearray(b"\xFF" * 0x10000)
        m[0x3000:0x4000] = rom["136031-111.1l"]
        m[0x6000:0x8000] = rom["136031-101.1f"][o:o + 0x2000]
        m[0xA000:0xC000] = rom["136031-102.1jk"][o:o + 0x2000]
        m[0xC000:0xE000] = rom["136031-203.1kl"][o:o + 0x2000]
        m[0xE000:0x10000] = rom["136031-104.1m"][o:o + 0x2000]
        return m
    out = {"esb_main_bank0.bin": main(0), "esb_main_bank1.bin": main(1)}
    out["esb_slapstic.bin"] = bytearray(rom["136031-105.3u"] + rom["136031-106.2u"])
    s = bytearray(b"\xFF" * 0x10000)
    s[0x4000:0x6000] = rom["136031-113.1jk"][:0x2000]
    s[0xC000:0xE000] = rom["136031-113.1jk"][0x2000:]
    s[0x6000:0x8000] = rom["136031-112.1h"][:0x2000]
    s[0xE000:0x10000] = rom["136031-112.1h"][0x2000:]
    out["esb_sound.bin"] = s
    out["esb_mathbox.bin"] = bytearray(b"".join(
        rom[p] for p in ("136031-110.7h", "136031-109.7j", "136031-108.7k", "136031-107.7l")))
    out["esb_avgprom.bin"] = bytearray(rom["136021-109.4b"])
    for n, data in out.items():
        with open(paths.build(n), "wb") as f:
            f.write(data)
    if verbose:
        print("  images written to %s" % paths.BUILD)
    return out

def load(name):
    return open(paths.need(paths.build(name), "image (run image.py)"), "rb").read()

if __name__ == "__main__":
    build(sys.argv[1] if len(sys.argv) > 1 else None)
