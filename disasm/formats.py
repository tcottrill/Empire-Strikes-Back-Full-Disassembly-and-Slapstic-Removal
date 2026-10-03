"""Typed data: the program's own table formats, as lines for the listings.

Each function yields (address, unit, size, comment):
  unit 'b'  bytes, 'w' words in hex, 'p' words that are ROM addresses (labels)
emit.py lays them out in place of plain .byte rows.  The formats were read from
the code that uses the tables; hints.TYPED says where each table is.
"""

import objects

def text_of(bs):
    s = ""
    for b in bs:
        c = b & 0x7F
        s += chr(c) if 32 <= c < 127 else "?"
    return s

def msgtab(im, sp, start, count):
    """The message table: per message a line count and the address of its text
    (VWMESS: LDX #table, ABX three times, LDB ,X / LDX 1,X).  A count of zero
    or less is a message with nothing to show.  Followed into the texts: each
    line is colour index, y/4, x/4 (signed), then characters, the last with bit
    7 set (MESOUT)."""
    seen = {}
    for i in range(count):
        a = start + 3 * i
        n = im.rd(sp, a)
        p = im.word(sp, a + 1)
        yield a, "b", 1, "message $%02X: %d line%s" % (i, n if n < 0x80 else n - 256, "" if n == 1 else "s")
        yield a + 1, "p", 2, None
        if 0 < n < 0x80 and p not in seen:
            seen[p] = i
            for ln in message(im, sp, p, n, i):
                yield ln

def sx8(b):
    return b - 256 if b & 0x80 else b

def message(im, sp, p, n, num):
    for k in range(n):
        col, y, x = im.rd(sp, p), sx8(im.rd(sp, p + 1)), sx8(im.rd(sp, p + 2))
        yield p, "b", 3, "message $%02X line %d: colour %d, y %d, x %d" % (num, k + 1, col // 2, y * 4, x * 4)
        p += 3
        e = p
        while not im.rd(sp, e) & 0x80:
            e += 1
        e += 1
        txt = text_of(im.rd(sp, a) for a in range(p, e))
        first = True
        while p < e:
            m = min(8, e - p)
            yield p, "b", m, ('"%s"' % txt) if first else None
            first = False
            p += m

def words(im, sp, start, count, per=1, comment=None):
    for i in range(0, count, per):
        yield start + 2 * i, "w", 2 * min(per, count - i), comment(i) if comment else None

def pointers(im, sp, start, count, comment=None):
    for i in range(count):
        yield start + 2 * i, "p", 2, comment(i) if comment else None

def s16(w):
    return w - 0x10000 if w & 0x8000 else w

def objtab(im, sp, counts, ptrs, n):
    """The 3-D objects: a table of point counts (one byte per object), a table
    of point-table addresses, and the point tables themselves - x, y, z words
    per point, as Star Wars' .P macro laid them out (JINOBJ / the object
    transform: LDX #counts ... LDX #pointers 'POINTER TO 6 BYTE ROM POINTS')."""
    for i in range(0, n, 8):
        m = min(8, n - i)
        yield counts + i, "b", m, "points per object, objects %d-%d" % (i, i + m - 1)
    seen = set()
    for i in range(n):
        p = im.word(sp, ptrs + 2 * i)
        yield ptrs + 2 * i, "p", 2, "object %d: %d points - %s" % (i, im.rd(sp, counts + i), objects.NAMES.get(i, "?"))
    for i in range(n):
        p = im.word(sp, ptrs + 2 * i)
        if p in seen:
            continue
        seen.add(p)
        users = [j for j in range(n) if im.word(sp, ptrs + 2 * j) == p]
        cnt = max(im.rd(sp, counts + j) for j in users)
        for k in range(cnt):
            a = p + 6 * k
            x, y, z = (s16(im.word(sp, a + 2 * q)) for q in range(3))
            yield a, "w", 6, "object %s point %d: %d, %d, %d" % (
                "/".join(str(j) for j in users), k, x, y, z)

def bytes_(im, sp, start, count, per=8, comment=None):
    for i in range(0, count, per):
        yield start + i, "b", min(per, count - i), comment(i) if comment else None

def spktab(im, sp, start, count):
    """The speech phrase table of the sound program: for each phrase the first
    and last address of its TMS5220 data (the Star Wars SPKVTB layout), and
    the phrase data itself."""
    spans = []
    for i in range(count):
        a = start + 4 * i
        s0, e0 = im.word(sp, a), im.word(sp, a + 2)
        yield a, "p", 4, "phrase %d: %d bytes" % (i, e0 - s0 + 1)
        spans.append((s0, e0, i))
    seen = set()
    for s0, e0, i in sorted(spans):
        if s0 in seen or e0 < s0:
            continue
        seen.add(s0)
        a = s0
        first = True
        while a <= e0:
            m = min(8, e0 + 1 - a)
            yield a, "b", m, "phrase %d, TMS5220 speech data" % i if first else None
            first = False
            a += m

def outlines(im, sp, table, count):
    """The title logo (bank 1): a table of outline addresses, and each outline a
    list of 5-byte records - 1 move or 2 draw, x word, y word - ended by a 0."""
    seen = set()
    for i in range(count):
        yield table + 2 * i, "p", 2, "outline %d" % i
    for i in range(count):
        p = im.word(sp, table + 2 * i)
        if p in seen:
            continue
        seen.add(p)
        while True:
            op = im.rd(sp, p)
            if op == 0:
                yield p, "b", 1, "end of outline %d" % i
                break
            x, y = s16(im.word(sp, p + 1)), s16(im.word(sp, p + 3))
            yield p, "b", 5, "%s %d, %d" % ({1: "move to", 2: "draw to"}.get(op, "op %d" % op), x, y)
            p += 5

def rows(im, sp, start, count, layout, comment=None):
    """A table of fixed rows; layout is one letter per field: b byte, w word,
    p word that is a ROM address.  A row is listed as one line per run of like
    fields, the comment on the first."""
    size = sum(1 if c == "b" else 2 for c in layout)
    for r in range(count):
        a = start + r * size
        first = True
        i = 0
        while i < len(layout):
            j = i
            while j < len(layout) and layout[j] == layout[i]:
                j += 1
            n = (j - i) * (1 if layout[i] == "b" else 2)
            yield a, layout[i], n, (comment % r if comment and "%" in comment else comment) if first else None
            first = False
            a += n
            i = j

def rings(im, sp, spec):
    """Keyframe rings: rows of three words and a count byte; the row with count
    0 ends the ring and is followed by the address of the ring's first row."""
    for k, (start, n) in enumerate(spec):
        a = start
        for r in range(n):
            x, y, z = (s16(im.word(sp, a + 2 * q)) for q in range(3))
            c = im.rd(sp, a + 6)
            yield a, "w", 6, "ring %d key %d: offset %d, %d, %d" % (k, r, x, y, z)
            yield a + 6, "b", 1, "for %d frames" % c if c else "end of ring %d" % k
            a += 7
        yield a, "p", 2, "back to the ring's first key"

FORMATS = dict(spktab=spktab, outlines=outlines, rows=rows, rings=rings, msgtab=msgtab, words=words, pointers=pointers, objtab=objtab, bytes=bytes_)
