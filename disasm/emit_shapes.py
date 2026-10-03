"""Generate disasm/shapes_preview.html: one self-contained page showing

  1. the character set (the VGMSGA table of the vector ROM)
  2. every picture in the vector ROM $3000-$3FFF
  3. the pictures of the three display-list sets the program copies from the
     program ROM to vector RAM $2800
  4. the 3-D objects of bank 1: their point tables, and the lines their draw
     routines draw between the points where drawcode.py can read them
  5. the messages with their position and colour

Names and addresses come from the listings' own symbol table; nothing is drawn
that is not in the ROM.  The renderer (avg.py) follows JSRL/JMPL, applies SCAL
and tracks the STAT colour.
"""
import html, json, os, sys
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import avg, esb, formats, drawcode, objects
import emit as listing

OUT = os.path.join(HERE, "shapes_preview.html")
E = html.escape
RGB = ["#555", "#4a7dff", "#3fd45a", "#35d6d6", "#ff4b3e", "#d65cff", "#ffe03a", "#f4f4f4"]
SETS = [(0xB97C, 0xBE1C), (0xBE1C, 0xC074), (0xC074, 0xC4CA)]     # hints.REGIONS: lists run at $2800
MSGTAB, MSGS = 0xE7E3, 0xDF
LOGO_TAB, LOGO_N = 0x675B, 27
OBJ_COUNTS, OBJ_PTRS, OBJ_BUF, OBJECTS = 0xD713, 0xD736, 0xD77C, 35

def svg(segs, size=150, pad=6):
    if not segs:
        return '<svg viewBox="0 0 10 10" width="%d" height="%d"></svg>' % (size, size)
    xs = [v for s in segs for v in (s[0], s[2])]
    ys = [v for s in segs for v in (s[1], s[3])]
    x0, x1, y0, y1 = min(xs), max(xs), min(ys), max(ys)
    w, h = max(x1 - x0, 1e-6), max(y1 - y0, 1e-6)
    sc = (size - 2 * pad) / max(w, h)
    ox = pad + ((size - 2 * pad) - w * sc) / 2
    oy = pad + ((size - 2 * pad) - h * sc) / 2
    out = ['<svg viewBox="0 0 %d %d" width="%d" height="%d">' % (size, size, size, size)]
    for a, b, c, d, col, br in segs:
        out.append('<line x1="%.1f" y1="%.1f" x2="%.1f" y2="%.1f" stroke="%s" stroke-opacity="%.2f"/>' % (
            ox + (a - x0) * sc, oy + (y1 - b) * sc, ox + (c - x0) * sc, oy + (y1 - d) * sc,
            RGB[col], 0.35 + 0.65 * br / 255.0))
    out.append("</svg>")
    return "".join(out)

def card(title, sub, body, note=""):
    return ('<div class="card">%s<div class="nm">%s</div><div class="sub">%s</div>%s</div>' % (
        body, E(title), E(sub), ('<div class="note">%s</div>' % E(note)) if note else ""))

def starts_of(mem, lo, hi):
    """Addresses in lo..hi that a JSRL or JMPL in the same list names."""
    out = set()
    a = lo
    while a < hi - 1:
        d = avg.decode(mem, a)
        if d["op"] in ("JSRL", "JMPL") and ((mem[a] << 8) | mem[a + 1]) != 0xFFFF:
            out.add(d["target"])
        a += d["len"]
    return out

def emit(verbose=True):
    g = listing.Gen("main")
    g.build_typed()
    g.build_regions()
    g.collect_refs()
    im = g.im
    name = lambda sp, a: (g.named.get((sp, a)) or [esb.label(sp, a)])[0]

    # display lists the program itself calls: LDD #JSRL-word / STD ,Y++
    called = set()
    from m6809 import IMM16
    for (sp, a), n in g.code.items():
        d = im.decode(sp, a)
        if d["mode"] == IMM16 and d["mn"] in ("LDD", "LDX", "LDU") and (d["value"] & 0xE000) in (0xA000, 0xE000):
            called.add((d["value"] & 0x1FFF) * 2)

    # ---- 1/2. the vector ROM
    mem = bytearray(0x4000)
    for a in range(0x3000, 0x4000):
        mem[a] = im.rd("V", a)
    tab = next((a for (sp, a), ns in g.named.items() if sp == "V" and "VGMSGA" in ns), 0x3002)
    chars = []
    a = tab
    while True:
        d = avg.decode(mem, a)
        if d["op"] != "JSRL":
            break
        segs, _ = avg.render(mem, d["target"])
        chars.append(card(name("V", d["target"]), "$%04X  code %d" % (d["target"], (a - tab) // 2), svg(segs, 70, 8)))
        a += 2
    char_targets = {avg.decode(mem, x)["target"] for x in range(tab, a, 2)}
    real = []
    ends = [x for x in range(0x3000, 0x4000) if all(mem[x + i] == 0xFF for i in range(min(16, 0x4000 - x)))]
    end = ends[0] if ends else 0x4000
    for t in sorted(starts_of(mem, 0x3002, end) | {a2 for (sp, a2) in g.named if sp == "V"} |
                    {t for t in called if 0x3000 <= t < 0x4000}):
        if not 0x3002 <= t < end or t == tab or t in char_targets:
            continue
        segs, notes = avg.render(mem, t, lo=0x3000)
        if segs:
            real.append(card(name("V", t), "$%04X  %d vectors" % (t, len(segs)), svg(segs),
                             "; ".join(sorted(set(notes)))[:120]))

    # ---- 3. the display-list sets copied to $2800
    sets = []
    for k, (lo, hi) in enumerate(SETS):
        m2 = bytearray(mem)
        for i in range(hi - lo):
            m2[0x2800 + i] = im.rd("B0", lo + i)
        cards = []
        own = starts_of(m2, 0x2800, 0x2800 + hi - lo)
        for t in sorted(own | called):
            if not 0x2800 <= t < 0x2800 + hi - lo or t & 1:
                continue
            segs, notes = avg.render(m2, t, lo=0x2800)
            if segs:
                rom = lo + t - 0x2800
                cards.append(card(name("B0", rom), "$%04X in vector RAM  %d vectors" % (t, len(segs)), svg(segs),
                                  "; ".join(sorted(set(notes)))[:120]))
        sets.append((k, lo, hi, cards))

    # ---- 4. the 3-D objects
    comments, routines = drawcode.annotate(im, g.tr["code"])
    objcards, objdata = [], {}
    for i in range(OBJECTS):
        n = im.rd("B1", OBJ_COUNTS + i)
        p = im.word("B1", OBJ_PTRS + 2 * i)
        base = (im.word("B1", OBJ_BUF + 2 * i) - drawcode.POINTS) // 5
        s16 = formats.s16
        pts = [[s16(im.word("B1", p + 6 * k + 2 * q)) for q in range(3)] for k in range(n)]
        rt = im.word("B1", drawcode.DRAW_TABLE + 2 * i)
        lines = []
        for frm, to, z in routines.get(rt, []):
            if frm is not None and z and 0 <= frm - base < n and 0 <= to - base < n:
                lines.append([frm - base, to - base])
        objdata[i] = dict(p=pts, l=lines)
        objcards.append('<div class="card obj"><canvas width="220" height="220" data-o="%d"></canvas>'
                        '<div class="nm">object %d &mdash; %s</div><div class="sub">%d points at $%04X, draw routine %s'
                        '</div><div class="note">%s</div></div>' % (
                            i, i, E(objects.NAMES.get(i, "")), n, p, E(name("B1", rt)),
                            "%d lines read from the draw routine" % len(lines) if lines
                            else "points only: the draw routine is not in the simple form"))

    # ---- the title logo (bank 1): outlines of move / draw records
    logo = []
    for i in range(LOGO_N):
        p = im.word("B1", LOGO_TAB + 2 * i)
        cur = None
        while im.rd("B1", p):
            op = im.rd("B1", p)
            x, y = formats.s16(im.word("B1", p + 1)), formats.s16(im.word("B1", p + 3))
            if op == 2 and cur:
                logo.append((cur[0], cur[1], x, y, 1 if i < 6 else 3, 255))
            cur = (x, y)
            p += 5
    logo_svg = svg(logo, 640, 10)

    # ---- 5. messages
    rows = []
    for i in range(MSGS):
        a = MSGTAB + 3 * i
        n = im.rd("B0", a)
        p = im.word("B0", a + 1)
        if not 0 < n < 0x80:
            rows.append("<tr><td>$%02X</td><td></td><td></td><td></td><td></td><td class=t>(nothing)</td></tr>" % i)
            continue
        for k in range(n):
            col, y, x = im.rd("B0", p), formats.sx8(im.rd("B0", p + 1)), formats.sx8(im.rd("B0", p + 2))
            e = p + 3
            while not im.rd("B0", e) & 0x80:
                e += 1
            txt = formats.text_of(im.rd("B0", q) for q in range(p + 3, e + 1))
            rows.append("<tr><td>%s</td><td>$%04X</td><td>%d</td><td>%d</td><td>%d</td><td class=t>%s</td></tr>" % (
                "$%02X" % i if k == 0 else "", p, x * 4, y * 4, col // 2, E(txt)))
            p = e + 1

    page = TEMPLATE % dict(
        nchar=len(chars), chars="".join(chars), nreal=len(real), real="".join(real),
        sets="".join('<h3>Set %d &mdash; %d pictures (bank 0 $%04X-$%04X)</h3><div class="grid">%s</div>' % (
            k, len(c), lo, hi - 1, "".join(c)) for k, lo, hi, c in sets),
        nobj=OBJECTS, objs="".join(objcards), objdata=json.dumps(objdata, separators=(",", ":")),
        nmsg=MSGS, msgs="".join(rows), logo=logo_svg, nlogo=LOGO_N)
    with open(OUT, "w", newline="\n", encoding="utf-8") as fp:
        fp.write(page)
    if verbose:
        print("wrote shapes_preview.html: %d characters, %d vector ROM pictures, %s set pictures, "
              "%d objects (%d with lines), %d messages" % (
                  len(chars), len(real), "+".join(str(len(c)) for _, _, _, c in sets), OBJECTS,
                  sum(1 for o in objdata.values() if o["l"]), MSGS))

TEMPLATE = """<!doctype html>
<html lang="en"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>The Empire Strikes Back (Atari, 1985) - vector shapes</title>
<style>
:root{color-scheme:dark}
body{background:#0b0d12;color:#cfd6e4;font:14px/1.45 system-ui,Segoe UI,sans-serif;margin:0;padding:16px}
h1{font-size:20px;margin:0 0 4px}h2{font-size:16px;margin:28px 0 4px;color:#fff}
h3{font-size:14px;margin:16px 0 4px;color:#cfd6e4}
p{max-width:900px;margin:4px 0 12px;color:#9aa5b8}
.grid{display:flex;flex-wrap:wrap;gap:8px}
.card{background:#12151d;border:1px solid #232838;border-radius:6px;padding:6px;width:150px}
.card.obj{width:220px}.card.logo{width:auto;max-width:652px}.card.logo svg{width:100%%;height:auto}.chars .card{width:70px}
.card svg,.card canvas{display:block;background:#000;border-radius:4px}
.card line{stroke-width:1.2;stroke-linecap:round}
.nm{font:12px/1.3 ui-monospace,Consolas,monospace;color:#fff;margin-top:4px;word-break:break-all}
.sub,.note{font-size:11px;color:#7f8aa0}.note{color:#b08a4a}
table{border-collapse:collapse;font:12px ui-monospace,Consolas,monospace}
td,th{border-bottom:1px solid #232838;padding:2px 8px;text-align:left;white-space:nowrap}
td.t{white-space:normal;color:#fff}
.wrap{overflow-x:auto}
</style></head><body>
<h1>The Empire Strikes Back (Atari, 1985) &mdash; vector shapes</h1>
<p>Generated from the ROM by <code>disasm/emit_shapes.py</code>. Upper-case names are Atari's,
carried over from the Star Wars source where the display list is the same; the rest are the
listings' address labels. Colours are the AVG's eight: the STAT instruction carries red, green
and blue bits and a brightness.</p>

<h2>Character set &mdash; %(nchar)d characters (VGMSGA)</h2>
<div class="grid chars">%(chars)s</div>

<h2>Vector ROM pictures &mdash; %(nreal)d ($3000-$3FFF)</h2>
<p>Each display list that another one calls or jumps to, or that has a name, run as a
subroutine from the default scale. A call into vector RAM (the program's own colour and
position variables) is skipped and noted.</p>
<div class="grid">%(real)s</div>

<h2>Display lists copied to vector RAM</h2>
<p>Three sets of display lists are stored in bank 0 of the program ROM. The program copies
one of them to vector RAM $2800, where the vector generator runs it like ROM; which set
depends on the part of the game. Shown is every list of a set that the set itself or the
program calls or jumps to. The program's calls are plain addresses in vector RAM, so an address
used with one set is tried in all three, and in a set it was not meant for it draws whatever
starts there.</p>
%(sets)s

<h2>Title logo &mdash; %(nlogo)d outlines (bank 1)</h2>
<p>Not a display list: each outline is a list of records - move or draw, x, y - that the banner
routine turns into vectors at the size and brightness of the moment. The first six outlines
(STAR WARS) are drawn in blue, the rest (THE EMPIRE STRIKES BACK and two bars) in turquoise.</p>
<div class="card logo">%(logo)s</div>

<h2>3-D objects &mdash; %(nobj)d (bank 1)</h2>
<p>Point tables (x, y, z words). The lines are not data: each object is drawn by a routine
that writes vectors between the projected points. Where that routine is in the simple
point-to-point form, its lines are shown; otherwise only the points. Drag to turn an
object.</p>
<div class="grid">%(objs)s</div>

<h2>Messages &mdash; %(nmsg)d</h2>
<div class="wrap"><table><tr><th>#</th><th>address</th><th>x</th><th>y</th>
<th>colour</th><th>text</th></tr>%(msgs)s</table></div>

<script>
const OBJ=%(objdata)s;
document.querySelectorAll('canvas[data-o]').forEach(cv=>{
  const o=OBJ[cv.dataset.o],g=cv.getContext('2d');let ax=-1.1,az=0.6,drag=null;
  let r=1;for(const p of o.p)r=Math.max(r,Math.hypot(p[0],p[1],p[2]));
  function pr(p){const x=p[0],y=p[1],z=p[2];
    const x1=x*Math.cos(az)-y*Math.sin(az),y1=x*Math.sin(az)+y*Math.cos(az);
    const y2=y1*Math.cos(ax)-z*Math.sin(ax);const z2=y1*Math.sin(ax)+z*Math.cos(ax);
    const s=100/r;return[110+x1*s,110-z2*s]}
  function draw(){g.clearRect(0,0,220,220);g.strokeStyle='#3fd45a';g.lineWidth=1.1;g.beginPath();
    for(const l of o.l){const a=pr(o.p[l[0]]),b=pr(o.p[l[1]]);g.moveTo(a[0],a[1]);g.lineTo(b[0],b[1])}
    g.stroke();g.fillStyle='#ffe03a';if(!o.l.length){for(const p of o.p){const a=pr(p);g.fillRect(a[0]-1,a[1]-1,2,2)}}}
  cv.onpointerdown=e=>{drag=[e.clientX,e.clientY];cv.setPointerCapture(e.pointerId)};
  cv.onpointerup=()=>drag=null;
  cv.onpointermove=e=>{if(!drag)return;az+=(e.clientX-drag[0])*0.01;ax+=(e.clientY-drag[1])*0.01;
    drag=[e.clientX,e.clientY];draw()};
  draw()});
</script>
</body></html>
"""

if __name__ == "__main__":
    emit()
