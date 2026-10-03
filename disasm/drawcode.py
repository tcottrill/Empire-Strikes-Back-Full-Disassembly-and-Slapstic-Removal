"""The 3-D object draw routines of bank 1, read back as point-to-point vectors.

Each of the 35 objects has a draw routine (table DRAW_TABLE, dispatched at
$DA2A).  A routine runs with the direct page on the buffer of projected
points - 5 bytes per point from $4E00: x word, y word, a flag byte - and writes
AVG vectors straight into the display list at Y:

    LDD  <y of point j        LDD  <x of point j
    SUBD <y of point i        SUBD <x of point i
    ANDA #$1F                 ANDA #$1F   (beam off)   or   ORA #$E0   (intensity 7)
    STD  n,Y                  STD  n+2,Y              or   ORA <flag of j / ADDA <flag of i
                                                           (the intensity bits the perspective
                                                           routine left in each point's flag byte)

The first vector of a run subtracts the beam position BJ_CY / BJ_CX instead of
a point.  annotate() finds these pairs and returns a comment for the first
instruction of each, and the vector list of every routine for the shape preview.
"""
import m6809
from m6809 import DIR, EXT, IMM8, IDX

DRAW_TABLE = 0xD6CD
OBJECTS = 35
POINTS = 0x4E00
BJ_CX, BJ_CY = 0x48BA, 0x48BC

def annotate(im, code_rows):
    """code_rows: the trace's rows for space B1.  -> (comments {addr: text},
    routines {start: [(from point or None, to point, intensity)]})."""
    ins = []
    for r in code_rows:
        if r[0] != "B1":
            continue
        d = im.decode("B1", r[1])
        d["a"], d["dp"] = r[1], r[7]
        ins.append(d)
    ins.sort(key=lambda d: d["a"])
    starts = sorted({im.word("B1", DRAW_TABLE + 2 * i) for i in range(OBJECTS)})

    def addr(d):
        if d["mode"] == DIR:
            return (d["dp"] << 8) | d["value"]
        if d["mode"] == EXT:
            return d["value"]
        return None

    def half(k):
        """A LDD / SUBD / mask group at index k -> (to, from, intensity, next index) or None."""
        if k + 2 >= len(ins):
            return None
        a, b = ins[k], ins[k + 1]
        if a["mn"] != "LDD" or b["mn"] != "SUBD":
            return None
        pa, pb = addr(a), addr(b)
        if pa is None or pb is None or not POINTS <= pa < POINTS + 0x100:
            return None
        z = None
        n = k + 2
        while n < len(ins) and ins[n]["mn"] in ("ANDA", "ORA", "ADDA"):
            if ins[n]["mode"] == IMM8 and ins[n]["mn"] != "ADDA":
                v = ins[n]["value"]
                if ins[n]["mn"] == "ANDA":
                    z = 0 if z is None else z
                else:
                    z = v >> 5
            elif ins[n]["mode"] in (DIR, EXT) and ins[n]["mn"] != "ANDA":
                f = addr(ins[n])                        # ORA / ADDA with the points' flag bytes
                if f is None or not POINTS <= f < POINTS + 0x100 or (f - POINTS) % 5 != 4:
                    return None
                z = "flags"
            else:
                return None
            n += 1
        if z is None:
            return None
        while n < len(ins) and ins[n]["mn"] == "LEAY":
            n += 1
        if n >= len(ins) or ins[n]["mn"] != "STD" or ins[n]["mode"] != IDX:
            return None
        return pa, pb, z, n + 1

    comments, routines = {}, {s: [] for s in starts}
    k = 0
    while k < len(ins):
        h1 = half(k)
        if not h1:
            k += 1
            continue
        h2 = half(h1[3])
        if not h2:
            k += 1
            continue
        ya, yb, _, _ = h1
        xa, xb, z, nxt = h2
        if (ya - POINTS) % 5 != 2 or (xa - POINTS) % 5 != 0 or (ya - 2) != xa:
            k += 1
            continue
        to = (xa - POINTS) // 5
        if xb == BJ_CX and yb == BJ_CY:
            frm = None
        elif POINTS <= xb < POINTS + 0x100 and (xb - POINTS) % 5 == 0 and yb == xb + 2:
            frm = (xb - POINTS) // 5
        else:
            k += 1
            continue
        if frm is None:
            text = "beam to point %d" % to if not z else "draw from the beam to point %d" % to
        elif z == "flags":
            text = "draw point %d to %d, intensity from the two points' flag bytes" % (frm, to)
            z = 7
        elif z:
            text = "draw point %d to %d" % (frm, to)
        else:
            text = "move point %d to %d" % (frm, to)
        comments[ins[k]["a"]] = text
        owner = max((s for s in starts if s <= ins[k]["a"]), default=None)
        if owner is not None:
            routines[owner].append((frm, to, z))
        k = nxt
    return comments, routines
