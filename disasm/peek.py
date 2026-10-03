"""Working tool: look at the images through the trace.

    python peek.py gaps [main|sound]         regions not reached as code
    python peek.py dis SPACE ADDR [N]        disassemble N instructions linearly (* = traced code)
    python peek.py hex SPACE ADDR [N]        hex + ASCII dump
    python peek.py refs SPACE ADDR           who refers to an address

SPACE is B0, B1, P0..P3, V or S.
"""
import json, sys
import paths, image, m6809

def load(cpu):
    return json.load(open(paths.build("trace_%s.json" % cpu)))

class Img:
    def __init__(s):
        s.b = [image.load("esb_main_bank0.bin"), image.load("esb_main_bank1.bin")]
        s.sl = image.load("esb_slapstic.bin")
        s.snd = image.load("esb_sound.bin")
    def rd(s, sp, a):
        a &= 0xFFFF
        if sp == "S":
            return s.snd[a]
        if sp[0] == "P":
            if 0x8000 <= a < 0xA000:
                return s.sl[int(sp[1]) * 0x2000 + a - 0x8000]
            return s.b[0][a]
        return s.b[0 if sp == "V" else int(sp[1])][a]
    def view(s, sp):
        class V:
            def __getitem__(_, a):
                return s.rd(sp, a)
        return V()

RANGES = {"B0": [(0x6000, 0x8000), (0xA000, 0x10000)], "B1": [(0x6000, 0x8000), (0xA000, 0x10000)],
          "P0": [(0x8000, 0xA000)], "P1": [(0x8000, 0xA000)], "P2": [(0x8000, 0xA000)], "P3": [(0x8000, 0xA000)],
          "S": [(0x4000, 0x8000), (0xC000, 0x10000)], "V": [(0x3000, 0x4000)]}

def text(d, a):
    mn, mode, v = d["mn"], d["mode"], d["value"]
    if mode == m6809.INH:
        return mn
    if mode == m6809.IMM8:
        return "%s #$%02X" % (mn, v)
    if mode == m6809.IMM16:
        return "%s #$%04X" % (mn, v)
    if mode == m6809.DIR:
        return "%s <$%02X" % (mn, v)
    if mode in (m6809.EXT, m6809.REL8, m6809.REL16):
        return "%s $%04X" % (mn, v)
    if mode == m6809.REGS:
        return "%s %s" % (mn, m6809.fmt_regs(v))
    if mode == m6809.STK:
        return "%s %s" % (mn, m6809.fmt_stack(v, mn))
    p = d["post"]
    if not p & 0x80:
        o = "%d" % v
    elif (p & 0x0F) in (8, 9):
        o = ("$%04X" % (v & 0xFFFF)) if (p & 0x0F) == 9 else "%d" % v
    elif v is not None:
        o = "$%04X" % v
    else:
        o = ""
    return "%s %s" % (mn, m6809.fmt_idx(p, o))

def covered(tr):
    cov = {}
    for sp, a, n, mn, slap, maze, thunk, *_ in tr["code"]:
        for i in range(n):
            cov[(sp, a + i)] = a
    return cov

def gaps(cpu):
    tr = load(cpu); im = Img(); cov = covered(tr)
    for sp in (["B0", "B1", "P0", "P1", "P2", "P3"] if cpu == "main" else ["S"]):
        for lo, hi in RANGES[sp]:
            a = lo
            while a < hi:
                if (sp, a) in cov:
                    a += 1; continue
                e = a
                while e < hi and (sp, e) not in cov:
                    e += 1
                bs = [im.rd(sp, x) for x in range(a, e)]
                fill = len(set(bs)) == 1
                # how far does a linear decode get
                v = im.view(sp); p = a; ok = 0
                while p < e:
                    d = m6809.decode(v, p)
                    if d is None:
                        break
                    ok += 1; p += d["len"]
                print("%s $%04X-$%04X %5d  %s  %s" % (sp, a, e - 1, e - a,
                      "fill %02X" % bs[0] if fill else "decodes %3d insns to $%04X" % (ok, p),
                      " ".join("%02X" % b for b in bs[:16])))
                a = e

def dis(sp, a, n=30):
    im = Img(); v = im.view(sp)
    cov = {}
    for cpu in ("main", "sound"):
        try:
            cov.update(covered(load(cpu)))
        except FileNotFoundError:
            pass
    for _ in range(n):
        d = m6809.decode(v, a)
        mark = "*" if cov.get((sp, a)) == a else " "
        if d is None:
            print("%s%04X: %02X           ???" % (mark, a, im.rd(sp, a))); a += 1; continue
        bs = " ".join("%02X" % im.rd(sp, a + i) for i in range(d["len"]))
        print("%s%04X: %-14s %s" % (mark, a, bs, text(d, a)))
        a += d["len"]

def hexd(sp, a, n=128):
    im = Img()
    for s in range(a, a + n, 16):
        bs = [im.rd(sp, s + i) for i in range(16)]
        print("%04X: %s  %s" % (s, " ".join("%02X" % b for b in bs),
              "".join(chr(b & 0x7F) if 32 <= (b & 0x7F) < 127 else "." for b in bs)))

def refs(sp, a):
    for cpu in ("main", "sound"):
        tr = load(cpu)
        for kind in ("calls", "jumps", "drefs", "entries", "tables"):
            for row in tr[kind]:
                if row[0] == sp and row[1] == a:
                    print(kind, row[2:])

def datablocks(listing, minsize=24):
    """Plain .byte blocks of a listing with who refers to their labels."""
    import re, collections
    refs = collections.defaultdict(list)
    lines = open(listing).read().splitlines()
    lab = re.compile(r"^((?:[LK]|P\d_)[0-9A-F]{4}):\s+(\S+)\s*([^;]*)(;.*)?$")
    cur_r = None
    for ln in lines:
        m = lab.match(ln)
        if m and not m.group(2).startswith("."):
            for t in re.findall(r"(?:[LK]|P\d_)[0-9A-F]{4}", m.group(3)):
                refs[t].append("%s %s %s" % (m.group(1), m.group(2), m.group(3).strip()))
    blocks = []
    cur = None
    for ln in lines:
        m = lab.match(ln)
        if not m:
            continue
        plain = m.group(2) == ".byte" and not (m.group(4) or "").strip(";").strip()[:1].isupper() \
            and '"' not in (m.group(4) or "") and "message" not in (m.group(4) or "")
        if plain and "fill" not in (m.group(4) or ""):
            n = m.group(3).count("$")
            a = int(m.group(1)[-4:], 16)
            if cur and cur[0] + cur[1] == a:
                cur[1] += n
                cur[2].append(m.group(1))
            else:
                cur = [a, n, [m.group(1)], m.group(3)[:60]]
                blocks.append(cur)
        else:
            cur = None
    for a, n, labs, first in blocks:
        if n < minsize:
            continue
        print("$%04X +%d  %s" % (a, n, first))
        for l in labs:
            if l in refs:
                print("      %s <- %s" % (l, "; ".join(refs[l][:4])))


if __name__ == "__main__":
    c = sys.argv[1]
    if c == "gaps":
        gaps(sys.argv[2] if len(sys.argv) > 2 else "main")
    elif c == "data":
        datablocks(sys.argv[2], int(sys.argv[3]) if len(sys.argv) > 3 else 24)
    else:
        sp, a = sys.argv[2], int(sys.argv[3], 16)
        n = int(sys.argv[4]) if len(sys.argv) > 4 else None
        if c == "dis":
            dis(sp, a, n or 30)
        elif c == "hex":
            hexd(sp, a, n or 128)
        else:
            refs(sp, a)
