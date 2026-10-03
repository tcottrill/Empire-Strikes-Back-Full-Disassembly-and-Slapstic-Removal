"""Listing generator for The Empire Strikes Back.

Reads the images, the trace (trace.py), the names and comments carried from
Star Wars (sw_carry.json, written by swmatch.py) and hints.py, and writes the
eight listings.  Every instruction line is encoded again with verify.py's
encoder as it is written: an operand text that does not give the ROM's bytes is
never emitted - the generator falls back from the carried Star Wars expression
to its own symbolic operand to plain hex.

Also writes build/used_main.json and build/used_sound.json for emit_defines.py:
the aliases the listings use, the labels, and the routine list.
"""
import collections, json, os, re, sys
import paths, esb, m6809, slapstic, verify, avg, formats
from m6809 import INH, IMM8, IMM16, DIR, IDX, EXT, REL8, REL16, REGS, STK

try:
    import hints
except ImportError:
    hints = None

def H(name, default):
    return getattr(hints, name, default) if hints else default

DASH = ";" + "-" * 78
EQUAL = ";" + "=" * 78
SUFFIX = {"B0": "_B0", "B1": "_B1", "P0": "_P0", "P1": "_P1", "P2": "_P2", "P3": "_P3", "V": "_V", "S": "_S"}
IDENT = re.compile(r"(?<![$0-9A-Za-z_])[A-Za-z_][A-Za-z0-9_]*")
ADDRLAB = re.compile(r"^(?:[LK]|P[0-3]_)[0-9A-F]{4}$")
RAM_SECTIONS = ("Hardware registers", "CPU RAM", "Math RAM", "RAM", "6532 RAM", "Program RAM")

LISTINGS = collections.OrderedDict([
    ("B0", "esb_bank0_rom.asm"), ("B1", "esb_bank1_rom.asm"),
    ("P0", "esb_slapstic0_rom.asm"), ("P1", "esb_slapstic1_rom.asm"),
    ("P2", "esb_slapstic2_rom.asm"), ("P3", "esb_slapstic3_rom.asm"),
    ("V", "esb_vector_rom.asm"), ("S", "esb_sound_rom.asm"),
])

class Syms(dict):
    """Symbol table that also knows every address label by its spelling."""
    def __missing__(self, k):
        if ADDRLAB.match(k):
            return int(k[-4:], 16)
        raise KeyError(k)
    def __contains__(self, k):
        return dict.__contains__(self, k) or bool(ADDRLAB.match(k))

class Gen:
    def __init__(self, cpu):
        self.cpu = cpu
        self.im = esb.Images()
        self.spaces = ["S"] if cpu == "sound" else esb.MAIN_SPACES
        self.dpage = esb.DPAGE[cpu]
        tr = esb.load_trace(cpu)
        self.tr = tr
        self.code = {}                                  # (sp, a) -> len
        self.slapnote = {}
        self.thunk = {}
        self.dp_of = {}                                 # (sp, a) -> direct page the instruction runs with
        for sp, a, n, mn, slap, maze, thunk, dp in tr["code"]:
            self.code[(sp, a)] = n
            self.dp_of[(sp, a)] = dp
            if slap:
                self.slapnote[(sp, a)] = (slap, maze)
            if thunk is not None:
                self.thunk[(sp, a)] = thunk
        self.entries = {(sp, a): set(w) for sp, a, w in tr["entries"]}
        self.calls = {(sp, a): f for sp, a, f in tr["calls"]}
        self.tables = {(sp, a): (n, bank, page) for sp, a, n, bounded, bank, page in tr["tables"]}
        self.orphans = {(sp, a) for sp, a, n in tr.get("orphans", [])}
        cpath = os.path.join(paths.HERE, "sw_carry.json")
        cj = json.load(open(cpath)) if os.path.exists(cpath) else dict(carry={}, symbols={"main": {}, "sound": {}},
                                                                     sw_defines={"main": {}, "sound": {}})
        self.carry = {}
        for k, rec in cj["carry"].items():
            sp, a = k.split(":")
            if sp in self.spaces:
                self.carry[(sp, int(a, 16))] = rec
        drop = H("SW_DROP_SYMBOLS", {}).get(cpu, set())
        for sp, lo, hi in H("SW_DROP_DATA", []):
            for key in [k for k, r in self.carry.items() if k[0] == sp and lo <= k[1] < hi and r.get("data")]:
                del self.carry[key]
        self.swsym = {k: v for k, v in cj["symbols"][cpu].items() if k not in drop}
        self.swdef = {k: v for k, v in cj["sw_defines"][cpu].items() if k not in drop}
        for key in H("SW_DROP_NAMES", set()):
            if key in self.carry:
                rec = dict(self.carry[key])
                for f in ("names", "header", "inner", "name_comments", "pre"):
                    rec.pop(f, None)
                self.carry[key] = rec
        for key in H("SW_DROP_COMMENTS", set()):
            if key in self.carry:
                rec = dict(self.carry[key])
                rec.pop("comment", None)
                rec.pop("pre", None)
                self.carry[key] = rec
        self.maze = slapstic.maze_entries(self.im.slap) if cpu == "main" else {}
        self.used = collections.OrderedDict()           # alias name -> value
        self.auto_comments = {}
        if cpu == "main":
            import drawcode
            cm, self.draw_routines = drawcode.annotate(self.im, tr["code"])
            self.auto_comments = {("B1", a): t for a, t in cm.items()}
        self.maze_live = set()
        self.xtable = {}                                # bank space -> end of the cross-bank table
        if cpu == "main":
            self.find_maze_paths()
            for sp in ("B0", "B1"):
                a = 0x6018
                while True:
                    b = self.im.rd(sp, a)
                    if b == 0x3F:
                        a += 1
                    elif b == 0x7E or (b == 0xBD and self.im.word(sp, a + 1) == 0x600B):
                        a += 3
                    else:
                        break
                self.xtable[sp] = a
        self.build_symbols()

    def find_maze_paths(self):
        """Which maze instructions are fetched on a path from an entry the
        program really uses: (page, address)."""
        for (sp, a), n in self.code.items():
            if sp[0] == "P" and a < slapstic.MAZE_END:
                continue
            d = self.im.decode(sp, a)
            if d["mn"] not in ("JSR", "JMP") or d["mode"] != EXT:
                continue
            v = d["value"]
            if not (slapstic.STUBS_END <= v < slapstic.MAZE_END):
                continue
            if sp[0] == "P":
                st = "EN"
                note = self.slapnote.get((sp, a), ("", None))[0]
                if "state " in note:
                    st = note.split("state ")[1].split(":")[0]
                runs = [slapstic.run_maze(self.im.slap, v, int(sp[1]), st)]
            else:
                runs = [slapstic.run_maze(self.im.slap, v, p) for p in range(4)]
            for r in runs:
                self.maze_live.update(r["path"])

    # ------------------------------------------------------------ symbols
    def build_symbols(self):
        syms = Syms()
        self.cands = collections.defaultdict(list)      # source name -> [(printed, space or None, value)]
        self.named = collections.defaultdict(list)      # (sp, a) -> [printed names]
        self.alias_origin = {}                          # printed alias -> (value, origin)
        # labels placed by matched Star Wars lines
        place = collections.defaultdict(list)
        self.moved_to = {}                              # where a carried routine head went
        self.moved_from = {}
        for (sp, a), rec in sorted(self.carry.items()):
            if (sp, a) not in self.code and not rec.get("data"):
                continue
            if rec.get("header") and rec.get("names") and (sp, a) in self.code and (sp, a) not in self.calls:
                # ESB put instructions in front of a Star Wars routine (PSHS X ...):
                # the name belongs on the entry the callers use
                b = a
                for _ in range(3):
                    p = next((b - k for k in range(1, 6) if self.code.get((sp, b - k)) == k), None)
                    if p is None or (sp, p) in self.carry:
                        break
                    b = p
                    if (sp, b) in self.calls:
                        self.moved_to[(sp, a)] = (sp, b)
                        self.moved_from[(sp, b)] = (sp, a)
                        break
            ta = self.moved_to.get((sp, a), (sp, a))[1]
            for nm in rec.get("names", []):
                place[nm].append((sp, ta, bool(rec.get("same"))))
            for nm, off in rec.get("inner", []):
                place[nm].append((sp, a + off, bool(rec.get("same"))))
        hint_names = H("NAMES", {})
        for nm, where in sorted(place.items()):
            if any(x[2] for x in where):
                # a byte-identical placement wins over like-shaped ones in the same space
                keep = []
                for sp, a, same in where:
                    if same or not any(s2 == sp and same2 for s2, a2, same2 in where):
                        keep.append((sp, a, same))
                where = keep
            prim = self.swsym.get(nm, {})
            dead = lambda w: any(s2 == w[0] and lo <= w[1] < hi for s2, lo, hi in H("DEAD_RANGES", []))
            order = sorted(where, key=lambda w: (dead(w),
                                                 not (w[0] == prim.get("space") and w[1] == prim.get("value")),
                                                 self.spaces.index(w[0]), w[1]))
            seen_space = collections.Counter()
            for i, (sp, a, same) in enumerate(order):
                if i == 0:
                    printed = nm
                else:
                    seen_space[sp] += 1
                    if sp == order[0][0]:
                        continue                        # a second, weaker claim in the same space: no name
                    printed = nm + SUFFIX[sp] + ("" if seen_space[sp] == 1 else "_%d" % seen_space[sp])
                self.cands[nm].append((printed, sp, a))
                self.named[(sp, a)].append(printed)
                syms[printed] = a
        # labels the matched code names by operand (LDX #TABLE, JSR ROUTINE) whose own
        # line was not matched: place the name where the votes agree
        for nm, rec in sorted(self.swsym.items()):
            if "space" not in rec or nm in self.cands or rec["votes"] < 2 or rec["votes"] != rec["total"]:
                continue
            sp, a = rec["space"], rec["value"]
            if sp not in self.spaces or (sp, a) in hint_names or nm in syms:
                continue
            if (sp, a) in self.named:
                continue
            self.cands[nm].append((nm, sp, a))
            self.named[(sp, a)].append(nm)
            syms[nm] = a
        self.note_problems = list(H("NOTE_PROBLEMS", []))
        for (sp, a), nm in sorted(hint_names.items()):
            if sp in self.spaces:
                if nm in syms or (nm in self.swsym and "space" not in self.swsym[nm]):
                    self.note_problems.append("name %s for %s $%04X is already in use" % (nm, sp, a))
                    continue
                self.named[(sp, a)].insert(0, nm)
                self.cands[nm].append((nm, sp, a))
                syms[nm] = a
        # aliases: voted values first, then the Star Wars value for what never got a vote
        for nm, rec in sorted(self.swsym.items()):
            if nm in self.cands or "space" in rec:
                continue
            self.cands[nm].append((nm, None, rec["value"]))
            syms[nm] = rec["value"]
            self.alias_origin[nm] = (rec["value"], "voted %d/%d" % (rec["votes"], rec["total"]))
        for a, (nm, desc) in sorted(H("RAM", {}).get(self.cpu, {}).items()):
            if nm in syms:
                self.note_problems.append("RAM name %s for $%04X is already in use" % (nm, a))
                continue
            self.cands[nm] = [(nm, None, a)]
            syms[nm] = a
            self.alias_origin[nm] = (a, "hint")
        self.ram_blocks = []
        for start, end, nm, desc in H("RAM_BLOCKS", {}).get(self.cpu, []):
            if nm not in syms:
                syms[nm] = start
                self.alias_origin[nm] = (start, "hint")
                self.cands[nm] = [(nm, None, start)]
            self.ram_blocks.append((start, end, nm))
        for nm, (v, sec, cm) in sorted(self.swdef.items()):
            if nm in self.cands or not v.startswith("$"):
                continue
            if "ROM" in sec or sec == "Memory map":
                continue                                # Star Wars ROM addresses do not carry over
            val = int(v[1:], 16)
            self.cands[nm].append((nm, None, val))
            syms[nm] = val
            self.alias_origin[nm] = (val, "star wars value")
        if self.cpu == "main":
            for e, r in sorted(self.maze.items()):
                nm = "MZ_%04X" % e
                syms[nm] = e
                self.alias_origin[nm] = (e, "maze")
            for off, pg in sorted(slapstic.PAGE_ADDR.items()):
                syms["SLAP_PAGE%d" % pg] = 0x8000 + off
                self.alias_origin["SLAP_PAGE%d" % pg] = (0x8000 + off, "slapstic")
            syms["SLAP_ARM"] = 0x8000
            self.alias_origin["SLAP_ARM"] = (0x8000, "slapstic")
        self.syms = syms
        # value -> name for RAM and hardware addresses, best voted first
        best = {}
        for nm, rec in self.swsym.items():
            if "space" in rec or nm not in self.alias_origin:
                continue
            sec = self.swdef.get(nm, ("", "", ""))[1]
            if sec not in RAM_SECTIONS:
                continue
            v = rec["value"]
            if v not in best or rec["votes"] > best[v][0]:
                best[v] = (rec["votes"], nm)
        self.ram_name = {v: nm for v, (k, nm) in best.items()}
        for nm, (v, sec, cm) in self.swdef.items():
            if sec == "Hardware registers" and v.startswith("$"):
                val = int(v[1:], 16)
                if val not in self.ram_name and nm in self.alias_origin:
                    self.ram_name[val] = nm
        for a, (nm, desc) in H("RAM", {}).get(self.cpu, {}).items():
            if self.alias_origin.get(nm, (None, ""))[1] == "hint" and a not in self.ram_name:
                self.ram_name[a] = nm

    def use(self, text):
        for nm in IDENT.findall(text):
            if nm in self.alias_origin and nm not in self.used:
                self.used[nm] = self.alias_origin[nm][0]

    # ------------------------------------------------------------ layout
    def layout(self, sp):
        """Line starts of a space: instructions as traced, data broken at every
        referenced address.  -> ordered list of (addr, kind, size, extra)."""
        refs = self.refs[sp]
        lines = []
        for lo, hi in esb.RANGES[sp]:
            a = lo
            while a < hi:
                n = self.code.get((sp, a))
                if n:
                    lines.append((a, "code", n, None))
                    a += n
                    continue
                e = a
                while e < hi and (sp, e) not in self.code:
                    e += 1
                # statements carried from Star Wars keep their own layout
                x = s = a
                while x < e:
                    rec = self.carry.get((sp, x))
                    ty = self.typed.get((sp, x))
                    if ty and x + ty[1] <= e:
                        if s < x:
                            lines += self.data_lines(sp, s, x, refs)
                        lines.append((x, "typed", ty[1], ty))
                        x += ty[1]
                        s = x
                    elif rec and rec.get("data") and x + rec["size"] <= e:
                        if s < x:
                            lines += self.data_lines(sp, s, x, refs)
                        lines.append((x, "sw", rec["size"], rec))
                        x += rec["size"]
                        s = x
                    else:
                        x += 1
                if s < e:
                    lines += self.data_lines(sp, s, e, refs)
                a = e
        return lines

    def data_lines(self, sp, a, e, refs):
        out = []
        while a < e:
            reg = self.region_at(sp, a)
            if reg:
                kind, end = reg[0], min(reg[1], e)
            else:
                kind, end = "bytes", e
                nxt = self.next_region(sp, a)
                if nxt is not None:
                    end = min(end, nxt)
            if kind == "ptrs":
                while a + 2 <= end:
                    out.append((a, "ptr", 2, None))
                    a += 2
            elif kind == "words":
                while a + 2 <= end:
                    n = 2
                    while n < 8 and a + n + 2 <= end and (a + n) not in refs:
                        n += 2
                    out.append((a, "words", n, None))
                    a += n
            elif kind == "avg":
                while a + 2 <= end:
                    if self.im.word(sp, a) == 0xFFFF and a + 16 <= end and                             all(self.im.rd(sp, a + i) == 0xFF for i in range(16)):
                        break                           # ROM fill: left to the plain-bytes code below
                    d = avg.decode(self.im.view(sp), a)
                    n = d["len"] if a + d["len"] <= end else 2      # a VCTR is never split at a stray reference
                    out.append((a, "avg" if n == d["len"] else "words", n, d if n == d["len"] else None))
                    a += n
            elif kind == "text":
                out.append((a, "text", end - a, None))
                a = end
            if a < end or kind == "bytes":
                kind = "bytes"
                # plain bytes; a run of one value is fill
                while a < end:
                    b = self.im.rd(sp, a)
                    r = a
                    while r < end and self.im.rd(sp, r) == b and (r == a or r not in refs):
                        r += 1
                    if r - a >= 16:
                        total = r - a
                        while a < r:
                            n = min(16, r - a)
                            out.append((a, "fill", n, total))
                            total = None
                            a += n
                        continue
                    n = 1
                    while n < 8 and a + n < end and (a + n) not in refs:
                        if n >= 1 and a + n + 16 <= end and len({self.im.rd(sp, a + n + k) for k in range(16)}) == 1:
                            break
                        n += 1
                    out.append((a, "bytes", n, None))
                    a += n
        return out

    def build_typed(self):
        """Lines of the typed tables (hints.TYPED), by (space, address)."""
        self.typed = {}
        for spec in H("TYPED", []):
            sp, kind, args = spec[0], spec[1], spec[2:]
            if sp not in self.spaces:
                continue
            for a, unit, size, comment in formats.FORMATS[kind](self.im, sp, *args):
                if any((sp, a + i) in self.code for i in range(size)):
                    print("!! typed %s line at %s $%04X overlaps code" % (kind, sp, a))
                    continue
                self.typed[(sp, a)] = (unit, size, comment)

    def build_regions(self):
        self.regions = collections.defaultdict(list)    # sp -> sorted [(start, end, kind)]
        for (sp, a), (n, bank, page) in self.tables.items():
            self.regions[sp].append((a, a + 2 * n, "ptrs"))
        self.region_base = {}                           # (sp, start) -> address the list runs at
        for spec in H("REGIONS", []):
            sp, a, e, kind = spec[:4]
            if len(spec) > 4:
                self.region_base[(sp, a)] = spec[4]
            if sp in self.spaces:
                self.regions[sp] = [r for r in self.regions[sp] if r[1] <= a or r[0] >= e]
                self.regions[sp].append((a, e, kind))
        if self.cpu == "main":
            self.regions["V"].append((0x3000, 0x3002, "words"))     # the checksum word
            self.regions["V"].append((0x3002, 0x4000, "avg"))
        for sp in self.regions:
            self.regions[sp].sort()

    def region_at(self, sp, a):
        for s, e, k in self.regions.get(sp, ()):
            if s <= a < e:
                return k, e
        return None

    def avg_target(self, sp, a, tgt):
        """Where a JSRL / JMPL at ROM address a lands: (space, address, the
        region's start and run address if it is a list copied to vector RAM)."""
        for s, e, k in self.regions.get(sp, ()):
            if s <= a < e and (sp, s) in self.region_base:
                base = self.region_base[(sp, s)]
                if base <= tgt < base + (e - s):
                    return sp, s + (tgt - base), (s, base)
        if 0x3000 <= tgt < 0x4000:
            return "V", tgt, None
        return None

    def next_region(self, sp, a):
        for s, e, k in self.regions.get(sp, ()):
            if s > a:
                return s
        return None

    # ------------------------------------------------------------ references
    def target_space(self, sp, v):
        return esb.space_seen_from(sp, v)

    def collect_refs(self):
        """Every ROM address an operand or a pointer table refers to."""
        self.refs = collections.defaultdict(set)
        for (sp, a), n in self.code.items():
            d = self.im.decode(sp, a)
            self.dpage = self.dp_of[(sp, a)]
            v = None if self.is_vg_word(sp, a, d) else self.ref_value(d)
            if v is not None:
                t = self.target_space(sp, v)
                if t:
                    self.refs[t].add(v)
        for sp in self.spaces:
            for s, e, k in self.regions.get(sp, ()):
                self.refs[sp].add(s)
                self.refs[sp].add(e)
                if k == "ptrs":
                    for a in range(s, e, 2):
                        w = self.im.word(sp, a)
                        t = self.target_space(sp, w)
                        if t:
                            self.refs[t].add(w)
                        self.refs[sp].add(a)
                elif k == "avg":
                    a = s
                    while a < e:
                        d = avg.decode(self.im.view(sp), a)
                        if d["op"] in ("JSRL", "JMPL") and self.im.word(sp, a) != 0xFFFF:
                            t = self.avg_target(sp, a, d["target"])
                            if t:
                                self.refs[t[0]].add(t[1])
                        a += d["len"]
        for sp, a, f in self.tr["drefs"]:
            self.refs[sp].add(a)
        for (sp, a), (unit, size, comment) in self.typed.items():
            if unit == "p":
                for i in range(0, size, 2):
                    w = self.im.word(sp, a + i)
                    t = self.target_space(sp, w)
                    if t:
                        self.refs[t].add(w)
        for (sp, a) in list(self.named):
            self.refs[sp].add(a)
        for (sp, a) in self.entries:
            self.refs[sp].add(a)

    def is_vg_word(self, sp, pc, d):
        """LDX #word / STX ,Y++ (or LDU): a display-list word on its way into the
        list through Y, not an address."""
        if d["mode"] != IMM16 or d["mn"] not in ("LDX", "LDU"):
            return False
        n = self.im.decode(sp, pc + d["len"]) if (sp, pc + d["len"]) in self.code else None
        return bool(n and n["mn"] == "ST" + d["mn"][2] and n["mode"] == IDX and ((n["post"] >> 5) & 3) == 1)

    def ref_value(self, d):
        """The address an instruction's operand names, if it names one."""
        mode, mn, v = d["mode"], d["mn"], d["value"]
        if mode in (REL8, REL16, EXT):
            return v
        if mode == DIR:
            return (self.dpage << 8) | v
        if mode == IMM16 and mn in ("LDX", "LDY", "LDU", "CMPX", "CMPY", "CMPU"):
            return v
        if mode == IDX and d["post"] & 0x80:
            t = d["post"] & 0x0F
            if t in (0x0C, 0x0D) or d["post"] == 0x9F:
                return v
            if t == 0x09 and v >= 0x3000:
                return v
        return None

    # ------------------------------------------------------------ operands
    def lab(self, sp, v, here_sp=None):
        """Text for ROM address v in space sp: its name, its address label, or
        label+offset when it falls inside a line."""
        if (sp, v) in self.named:
            return self.named[(sp, v)][0]
        s = self.start_of.get((sp, v))
        if s is None:
            return None
        if s == v:
            return esb.label(sp, v)
        return "%s+%d" % (self.named[(sp, s)][0] if (sp, s) in self.named else esb.label(sp, s), v - s)

    def addr_text(self, sp, v, code_target=False):
        """Symbolic text for an address operand of code in space sp, or None."""
        if self.cpu == "main" and slapstic.in_window(v) and sp[0] != "P":
            if v in self.maze:
                return "MZ_%04X" % v
            if (v & 0x1FFF) in slapstic.PAGE_ADDR:
                return "SLAP_PAGE%d" % slapstic.PAGE_ADDR[v & 0x1FFF]
            if v == 0x8000:
                return "SLAP_ARM"
            return None
        t = self.target_space(sp, v)
        if t:
            return self.lab(t, v)
        if code_target:
            return None
        if v in self.ram_name:
            return self.ram_name[v]
        for start, end, nm in self.ram_blocks:
            if start <= v < end:
                return nm if v == start else "%s+$%02X" % (nm, v - start)
        return None

    def own_value(self, sp, pc, d):
        """Our own text for the operand's value (no prefix, no index part)."""
        mode, mn, v = d["mode"], d["mn"], d["value"]
        if mode in (REL8, REL16):
            return self.addr_text(sp, v, True) or "$%04X" % v
        if mode == EXT:
            return self.addr_text(sp, v, mn in ("JSR", "JMP")) or "$%04X" % v
        if mode == DIR:
            full = (self.dpage << 8) | v
            return self.addr_text(sp, full) or "$%04X" % full
        if mode == IMM8:
            return "$%02X" % v
        if mode == IMM16:
            if mn in ("LDX", "LDY", "LDU", "CMPX", "CMPY", "CMPU") and not self.is_vg_word(sp, pc, d):
                t = self.addr_text(sp, v)
                if t and (v >= 0x3000):
                    return t
            return "$%04X" % v
        if mode == IDX:
            p = d["post"]
            if not p & 0x80:
                return "%d" % v
            t = p & 0x0F
            if t in (0x0C, 0x0D) or p == 0x9F:
                return self.addr_text(sp, v) or "$%04X" % v
            if t == 0x08:
                return "%d" % v if -10 < v < 10 else ("-$%02X" % -v if v < 0 else "$%02X" % v)
            if t == 0x09:
                if v >= 0x3000:
                    s = self.addr_text(sp, v)
                    if s:
                        return s
                return "$%04X" % v
        return ""

    def operand(self, d, val, force=""):
        mode, mn, v = d["mode"], d["mn"], d["value"]
        if mode == INH:
            return ""
        if mode == REGS:
            return m6809.fmt_regs(v)
        if mode == STK:
            return m6809.fmt_stack(v, mn)
        if mode in (IMM8, IMM16):
            return "#" + val
        if mode in (REL8, REL16):
            return val
        if mode in (EXT, DIR):
            return force + val
        p = d["post"]
        if not p & 0x80:
            return "%s%s,%s" % (force, val, m6809.IDX_NAME[(p >> 5) & 3])
        r = m6809.IDX_NAME[(p >> 5) & 3]
        t = p & 0x0F
        s = {0x0: ",%s+" % r, 0x1: ",%s++" % r, 0x2: ",-%s" % r, 0x3: ",--%s" % r,
             0x4: ",%s" % r, 0x5: "B,%s" % r, 0x6: "A,%s" % r, 0xB: "D,%s" % r,
             0x8: "%s%s,%s" % (force, val, r), 0x9: "%s%s,%s" % (force, val, r),
             0xC: "%s%s,PCR" % (force, val), 0xD: "%s%s,PCR" % (force, val),
             0xF: "%s" % val}[t]
        return "[%s]" % s if p & 0x10 else s

    def has_value(self, d):
        mode = d["mode"]
        if mode in (IMM8, IMM16, REL8, REL16, EXT, DIR):
            return True
        if mode == IDX:
            p = d["post"]
            return (not p & 0x80) or (p & 0x0F) in (0x8, 0x9, 0xC, 0xD) or p == 0x9F
        return False

    def encode_ok(self, mn, oper, pc, want):
        try:
            return verify.encode(mn, oper, self.syms, self.dpage, pc) == want
        except (verify.EvalError, KeyError, ValueError):
            return False

    def try_text(self, d, mn, val, pc, want):
        if d["mode"] in (DIR, EXT):
            # the expression must be the address itself: "<" would let any value
            # with the right low byte pass for a direct operand
            real = d["value"] | (self.dpage << 8 if d["mode"] == DIR else 0)
            try:
                if verify.evaluate(val, self.syms) & 0xFFFF != real:
                    return None
            except (verify.EvalError, KeyError):
                return None
        for force in ("", ">", "<", "+"):
            if force == "+" and (d["mode"] != IDX or d["post"] & 0x80):
                continue
            o = self.operand(d, val, force)
            if self.encode_ok(mn, o, pc, want):
                return o
        return None

    def carried_values(self, sp, rec, d):
        """Candidate value texts from the Star Wars operand, names resolved for this space."""
        import swmatch
        ex = swmatch.operand_expr(rec["oper"], d)
        if not ex or d["mode"] in (REL8, REL16):
            return []
        return self.resolve_expr(sp, ex)

    def resolve_expr(self, sp, ex):
        """A Star Wars expression with its names replaced by the names they have
        here, as seen from space sp: up to six candidate texts."""
        ids = IDENT.findall(ex)
        if any(re.match(r"^[LK][0-9A-F]{4}$", i) for i in ids):
            return []
        choices = []
        for i in ids:
            c = [p for p, s, v in self.cands.get(i, []) if s is None or self.target_space(sp, v) == s]
            if not c:
                return []
            choices.append(c)
        outs = []
        def sub(k, text_parts):
            if k == len(ids):
                outs.append("".join(text_parts))
                return
            for c in choices[k][:3]:
                sub(k + 1, text_parts + [c, tails[k]])
        # split the expression around its identifiers
        pos, heads, tails = 0, [], []
        pieces = []
        for m in IDENT.finditer(ex):
            pieces.append(ex[pos:m.start()])
            pos = m.end()
        pieces.append(ex[pos:])
        tails = pieces[1:]
        if not ids:
            return [ex]
        sub(0, [pieces[0]])
        return outs[:6]

    def instruction(self, sp, pc):
        d = self.im.decode(sp, pc)
        self.dpage = self.dp_of[(sp, pc)]
        want = [self.im.rd(sp, pc + i) for i in range(d["len"])]
        rec = self.carry.get((sp, pc))
        mn = d["mn"]
        if rec and rec["mn"] in m6809.TAB and m6809.canonical(rec["mn"]) == d["mn"]:
            mn = rec["mn"]
        if not self.has_value(d):
            o = self.operand(d, "")
            assert self.encode_ok(mn, o, pc, want), (sp, hex(pc), mn, o)
            return mn, o, "plain"
        hv = H("OPERANDS", {}).get((sp, pc))
        if hv:
            o = self.try_text(d, mn, hv, pc, want)
            if o is not None:
                self.use(o)
                return mn, o, "own"
            self.note_problems.append("operand %s for %s $%04X does not give the ROM bytes" % (hv, sp, pc))
        if rec:
            for val in self.carried_values(sp, rec, d):
                o = self.try_text(d, mn, val, pc, want)
                if o is not None:
                    self.use(o)
                    return mn, o, "carried"
        val = self.own_value(sp, pc, d)
        o = self.try_text(d, mn, val, pc, want)
        if o is not None:
            self.use(o)
            return mn, o, "own"
        # plain numbers
        v = d["value"]
        if d["mode"] == DIR:
            v |= self.dpage << 8
        if d["mode"] == IDX and v is not None and v < 0:
            val = "-$%X" % -v
        else:
            val = "$%04X" % v if d["mode"] != IMM8 else "$%02X" % v
        o = self.try_text(d, mn, val, pc, want)
        assert o is not None, "cannot express %s $%04X %s %s" % (sp, pc, mn, val)
        return mn, o, "hex"

    # ------------------------------------------------------------ output
    def emit_space(self, sp):
        pre = esb.PREFIX[sp]
        width = len(pre) + 4
        out = []
        w = out.append
        w(self.heading(sp))
        lines = self.lines[sp]
        org = None
        stats = collections.Counter()
        routines = []
        prev_kind = None
        for (a, kind, size, extra) in lines:
            if org is None or a != org:
                w("")
                w(".org $%04X" % a)
                if org is None:
                    w("")
                    w('.include "%s"' % ("esb_sound_defines.asm" if self.cpu == "sound" else "esb_defines.asm"))
                    w("")
                    cur_dp = esb.DPAGE[self.cpu]
                    w(".dpage $%02X" % cur_dp)
            org = a + size
            if kind == "code" and self.dp_of[(sp, a)] != cur_dp:
                cur_dp = self.dp_of[(sp, a)]
                pending_dp = cur_dp
            else:
                pending_dp = None
            key = (sp, a)
            rec = self.carry.get(key)
            names = self.named.get(key, [])
            head_rec = rec
            if key in self.moved_from:
                head_rec = self.carry[self.moved_from[key]]
            elif key in self.moved_to:
                head_rec = None
            is_entry = kind == "code" and (key in self.entries or (head_rec and head_rec.get("header")))
            if key in self.moved_to or key in H("NO_HEADER", set()):
                is_entry = False
            if sp in self.xtable and 0x6018 <= a < self.xtable[sp]:
                is_entry = False
            for b in H("BLOCKS", {}).get(key, []):
                w("" if not b else ";" + b)
            hint_head = H("HEADERS", {}).get(key)
            if sp in self.xtable and 0x6018 <= a < self.xtable[sp]:
                hint_head = None
            if key in H("NO_HEADER", set()):
                is_entry, hint_head = False, None
            if is_entry or hint_head:
                w("")
                w(DASH)
                head = None
                if head_rec and head_rec.get("header") and names:
                    head = list(head_rec["header"])
                    src = head_rec["names"][0] if head_rec.get("names") else None
                    if src and names[0] != src and head and head[0].strip().startswith(src):
                        head[0] = head[0].replace(src, names[0], 1)
                    desc = "sw"
                if hint_head and not (head_rec and head_rec.get("header") and names):
                    import textwrap
                    wrapped = textwrap.wrap("%s - %s" % (names[0] if names else esb.label(sp, a), hint_head), 110)
                    head = [" " + wrapped[0]] + ["   " + x for x in wrapped[1:]]
                    desc = "hint"
                if head is None:
                    head = [" %s" % (names[0] if names else esb.label(sp, a))]
                    desc = "none"
                    if key in self.orphans:
                        head.append("   (no caller found)")
                en = H("ESB_NOTES", {}).get(key)
                if en and desc == "sw":
                    import textwrap
                    for x in textwrap.wrap("in ESB: " + en, 106):
                        head.append("   " + x)
                for h in head:
                    w(";" + h)
                w(DASH)
                routines.append((names[0] if names else esb.label(sp, a), a, desc))
            elif names and prev_kind is not None:
                w("")
            if head_rec:
                for p in head_rec.get("pre", []):
                    w(";" + p)
            for nm in names:
                cm = (head_rec or {}).get("name_comments", {}).get(nm.split("_B")[0]) if head_rec else None
                w("%s:" % nm + ("          ;" + cm if cm else ""))
            if pending_dp is not None:
                w(".dpage $%02X" % pending_dp)
            lab = "%s%04X:" % (pre, a)
            comment = None
            if kind == "code":
                mn, oper, how = self.instruction(sp, a)
                stats[how] += 1
                stats["insn"] += 1
                if rec:
                    stats["matched"] += 1
                    comment = rec.get("comment")
                note = self.auto_note(sp, a)
                hc = H("COMMENTS", {}).get(key) or self.auto_comments.get(key)
                comment = "  ".join(x for x in (comment, hc, note) if x) or None
                text = "%-4s %s" % (mn, oper) if oper else mn
            else:
                text, comment = self.data_text(sp, a, kind, size, extra)
                stats["data"] += size
                hc = H("COMMENTS", {}).get(key)
                if hc:
                    comment = "  ".join(x for x in (comment, hc) if x)
            line = "%s  %s" % (lab.ljust(width + 1), text)
            if comment:
                line = "%s ;%s" % (line.ljust(35 + width - 5), comment)
            w(line.rstrip())
            prev_kind = kind
        with open(os.path.join(paths.HERE, LISTINGS[sp]), "w", newline="\n") as f:
            f.write("\n".join(out) + "\n")
        return stats, routines

    def auto_note(self, sp, a):
        key = (sp, a)
        notes = []
        if sp[0] == "P" and a < slapstic.MAZE_END:
            d = self.im.decode(sp, a)
            v = d["value"]
            if d["mn"] == "BITA":
                return "arms the slapstic" if a in (0x8080, 0x8090, 0x80A0, 0x80B0, 0x8000) else None
            if a < slapstic.STUBS_END or d["mn"] not in ("JSR", "JMP"):
                return None
            live = (int(sp[1]), a) in self.maze_live
            if (v & 0x1FFF) in slapstic.PAGE_ADDR and v < slapstic.STUBS_END:
                what = "select page %d" % slapstic.PAGE_ADDR[v & 0x1FFF]
            elif v < slapstic.STUBS_END:
                what = "a stub: no effect"
            elif v < slapstic.MAZE_END:
                what = None
            else:
                what = "the routine"
            return ("live" if live else "decoy") + (": " + what if what and live else "")
        if key in self.slapnote:
            slap, maze = self.slapnote[key]
            if maze:
                slap = slap.replace("maze: ", "").replace("maze entered", "entered")
                txt = []
                for pg, tg in maze:
                    t = self.lab("P%d" % pg, tg) or esb.label("P%d" % pg, tg)
                    txt.append("page %d %s" % (pg, t))
                extra = ""
                if "leaves" in slap:
                    extra = slap[slap.index("; leaves"):]
                if "state" in slap:
                    extra += "; chip was in state %s" % slap.split("state ")[1].split(":")[0]
                notes.append("calls " + ", ".join(txt) + extra)
            else:
                notes.append(slap)
        if key in self.thunk:
            ob = "B%d" % self.thunk[key]
            tgt = self.im.word(ob, a + 4)
            notes.append("bank %d: %s" % (self.thunk[key], self.lab(ob, tgt) or "$%04X" % tgt))
        return "; ".join(notes) if notes else None

    def data_text(self, sp, a, kind, size, extra):
        rd = lambda x: self.im.rd(sp, x)
        if kind == "sw":
            return self.sw_data(sp, a, size, extra)
        if kind == "typed":
            unit, size, comment = extra
            if unit == "b":
                return ".byte " + ", ".join("$%02X" % rd(a + i) for i in range(size)), comment
            out = []
            for i in range(0, size, 2):
                w = self.im.word(sp, a + i)
                t = None
                if unit == "p":
                    ts = self.target_space(sp, w)
                    t = self.lab(ts, w) if ts else None
                out.append(t or "$%04X" % w)
            return ".word " + ", ".join(out), comment
        if kind == "ptr":
            w = self.im.word(sp, a)
            t = self.addr_text(sp, w, not (self.cpu == "main" and slapstic.in_window(w) and sp[0] != "P"))
            if t is None:
                t = "$%04X" % w
            self.use(t)
            return ".word %s" % t, None
        if kind == "words":
            return ".word " + ", ".join("$%04X" % self.im.word(sp, a + i) for i in range(0, size, 2)), None
        if kind == "avg":
            ws = ", ".join("$%04X" % self.im.word(sp, a + i) for i in range(0, size, 2))
            d = extra
            cm = avg.text(d)
            if d["op"] in ("JSRL", "JMPL"):
                tg = self.avg_target(sp, a, d["target"])
                t = self.lab(tg[0], tg[1]) if tg else None
                cm = "%s %s" % (d["op"], t or "$%04X" % d["target"])
                if tg and tg[2]:
                    cm += " (at $%04X in vector RAM)" % d["target"]
                sym = self.avg_jump(sp, a)
                if sym:
                    ws = sym
            return ".word " + ws, cm
        if kind == "fill":
            # one line per 8 bytes would bury the listing: say it once, then the bytes
            return (".byte " + ", ".join("$%02X" % rd(a + i) for i in range(size)),
                    "ROM fill, %d bytes of $%02X" % (extra, rd(a)) if extra else None)
        if kind == "text":
            return ".byte " + ", ".join("$%02X" % rd(a + i) for i in range(size)), None
        return ".byte " + ", ".join("$%02X" % rd(a + i) for i in range(size)), None

    def avg_jump(self, sp, a):
        """Symbolic form of a JSRL / JMPL word whose target has a label."""
        w = self.im.word(sp, a)
        tgt = (w & 0x1FFF) * 2
        tg = self.avg_target(sp, a, tgt)
        t = self.lab(tg[0], tg[1]) if tg else None
        if not t or "+" in t:
            return None
        if tg[2]:
            start = self.lab(sp, tg[2][0])
            text = "(((%s-%s+$%04X-VGBASE)/2)&$1FFF)+$%04X" % (t, start, tg[2][1], w & 0xE000)
        else:
            text = "(((%s-VGBASE)/2)&$1FFF)+$%04X" % (t, w & 0xE000)
        try:
            if verify.evaluate(text, self.syms) & 0xFFFF != w:
                return None
        except (verify.EvalError, KeyError):
            return None
        self.use(text)
        return text

    def sw_data(self, sp, a, size, rec):
        """A data statement carried from Star Wars: each item keeps Atari's
        expression if that gives the ROM's bytes, else becomes a label or hex."""
        mn = rec["mn"]
        step = 2 if mn == ".word" else 1
        items = [x.strip() for x in rec["oper"].split(",")]
        want = [self.im.rd(sp, a + i) for i in range(size)]
        comment = rec.get("comment")
        if len(items) * step != size:
            items = [None] * (size // step)
        out, all_carried = [], True
        for k, it in enumerate(items):
            w = want[k * step:(k + 1) * step]
            val = (w[0] << 8) | w[1] if step == 2 else w[0]
            done = None
            if it is not None:
                for cand in self.resolve_expr(sp, it):
                    try:
                        v = verify.evaluate(cand, self.syms)
                    except (verify.EvalError, KeyError):
                        continue
                    if (v & (0xFFFF if step == 2 else 0xFF)) == val and -32768 <= v <= 65535:
                        if step == 1 and not -128 <= v <= 255:
                            continue
                        done = cand
                        break
            if done is None:
                all_carried = False
                done = None
                if step == 2 and it and "VGBASE" in it:
                    done = self.avg_jump(sp, a + k * step)
                elif step == 2 and it and IDENT.search(it):
                    t = self.target_space(sp, val)
                    done = self.lab(t, val) if t else None
                if done is None:
                    done = ("$%04X" if step == 2 else "$%02X") % val
            self.use(done)
            out.append(done)
        if not all_carried and comment and comment.split(" ")[0] in ("JSRL", "JMPL"):
            d = avg.decode(self.im.view(sp), a)
            t = self.lab("V", d["target"]) if 0x3000 <= d["target"] < 0x4000 else None
            comment = "%s %s" % (d["op"], t or "$%04X" % d["target"])
        return "%s %s" % (mn, ", ".join(out)), comment

    def heading(self, sp):
        common = [
            ";Names and upper-case comments are Atari's, carried over from the Star Wars",
            ";source wherever this code is the same instruction for instruction (swmatch.py);",
            ";everything in lower case was written for this disassembly.",
            ";Every line below was re-encoded and byte-compared with the ROM (verify.py).",
            ";Syntax: Motorola 6809 mnemonics and operands; .alias, .byte, .word (big-endian);",
            ";( ) groups expressions; ~ is one's complement, | is OR, ^ is exclusive OR.",
            ";.dpage gives the direct page the assembler assumed; < and > before an operand",
            ";force the short and the long form.",
        ]
        if sp in ("B0", "B1"):
            n = int(sp[1])
            head = [
                ";The Empire Strikes Back (Atari, 1985) - annotated disassembly of the main",
                ";program ROM, bank %d: $6000-$7FFF and $A000-$FFFF with W_BANK D7 = %d" % (n, n),
                ";(MAME 'esb': the %s halves of 136031-101.1f, -102.1jk, -203.1kl, -104.1m)." % ("first", "second")[n],
                ";Bank %d is in %s; $8000-$9FFF is the slapstic window, in" % (1 - n, LISTINGS["B%d" % (1 - n)]),
                ";esb_slapstic0_rom.asm .. esb_slapstic3_rom.asm; the vector ROM is in",
                ";esb_vector_rom.asm.  Labels: L = bank 0, K = bank 1, P0_ .. P3_ = slapstic pages.",
            ]
        elif sp[0] == "P":
            n = int(sp[1])
            head = [
                ";The Empire Strikes Back (Atari, 1985) - annotated disassembly of slapstic",
                ";page %d of $8000-$9FFF (MAME 'esb': the %s half of 136031-%s)." % (
                    n, ("first", "second")[n & 1], ("105.3u", "106.2u")[n >> 1]),
                ";The slapstic 137412-101 selects one of four pages here; see slapstic.py and",
                ";docs/SLAPSTIC.md.  $8000-$80FF (the page-select stubs) is the same on every",
                ";page; $8100-$85EB is the maze, different on every page.  Code here runs with",
                ";bank 0 selected, so L labels are bank 0's.",
            ]
        elif sp == "V":
            head = [
                ";The Empire Strikes Back (Atari, 1985) - annotated disassembly of the vector",
                ";ROM $3000-$3FFF (136031-111.1l): AVG display-list subroutines.",
                ";AVG words are big-endian here, as the 6809 stores them:",
                ";  $0yyy $zxxx  VCTR  draw to dx,dy (13-bit signed), intensity z (0-7)",
                ";  $4...        short VCTR: dy in bits 12-8, z in bits 7-5, dx in bits 4-0 (x2)",
                ";  $2000 HALT   $6ccc STAT/COLOR (colour in bits 10-8, brightness in bits 7-0)",
                ";  $7sll SCAL   $8040 CNTR   $Annn JSRL   $C000 RTSL   $Ennn JMPL",
                ";JSRL/JMPL operands are word addresses: address/2.",
            ]
        else:
            head = [
                ";The Empire Strikes Back (Atari, 1985) - annotated disassembly of the sound",
                ";program ROM on the sound board's 6809: $4000-$7FFF and $C000-$FFFF (the first",
                ";and second halves of 136031-113.1jk and 136031-112.1h).",
            ]
        return "\n".join(head + common)

    def run(self):
        self.build_typed()
        self.build_regions()
        self.collect_refs()
        self.lines = {}
        self.start_of = {}
        for sp in self.spaces:
            self.lines[sp] = self.layout(sp)
            for a, kind, size, extra in self.lines[sp]:
                for i in range(size):
                    self.start_of[(sp, a + i)] = a
        allr = {}
        for sp in self.spaces:
            st, routines = self.emit_space(sp)
            allr[sp] = routines
            print("  %-22s %5d instructions (%5d matched to Star Wars; operands %d carried, %d own, %d hex)  %5d data bytes  %4d routines, %d described" % (
                LISTINGS[sp], st["insn"], st["matched"], st["carried"], st["own"], st["hex"], st["data"],
                len(routines), sum(1 for r in routines if r[2] != "none")))
        for p in self.note_problems:
            print("  note: " + p)
        with open(paths.build("used_%s.json" % self.cpu), "w") as f:
            json.dump(dict(used=self.used, origin={k: list(v) for k, v in self.alias_origin.items()},
                           routines=allr), f, indent=0)

def main():
    for cpu in ("main", "sound"):
        Gen(cpu).run()
    return 0

if __name__ == "__main__":
    sys.exit(main())
