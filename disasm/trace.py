"""Code / data separation for The Empire Strikes Back by recursive traversal.

Spaces of the main CPU:
  B0, B1    the two banks W_BANK selects: $6000-$7FFF and $A000-$FFFF
  P0 .. P3  the four slapstic pages of $8000-$9FFF
  V         the vector ROM $3000-$3FFF (data only)
and of the sound CPU:
  S         $4000-$7FFF and $C000-$FFFF

A work item is (bank, page, address): the bank selected, the slapstic page
selected if it is known, and where to decode.  Calls across the banks go
through the table at $6018 (JSR $600B in the calling bank, the JMP at the same
address + 3 in the other); calls into the window go through the maze
(slapstic.py).  Jump tables come from the code pattern (LDX #table ... JSR
[A,X]) or from hints.py.

Writes build/trace_main.json and build/trace_sound.json and prints a report.
"""
import json, sys, collections
import paths, image, m6809, slapstic
from m6809 import INH, IMM8, IMM16, DIR, IDX, EXT, REL8, REL16, REGS, STK

try:
    import hints
except ImportError:
    hints = None

def H(name, default):
    return getattr(hints, name, default) if hints else default

ENDS = {"RTS", "RTI", "SWI", "SWI2", "SWI3"}

class Tracer:
    def __init__(self, cpu):
        self.cpu = cpu
        if cpu == "main":
            self.banks = [image.load("esb_main_bank0.bin"), image.load("esb_main_bank1.bin")]
            self.sl = image.load("esb_slapstic.bin")
            self.maze = slapstic.maze_entries(self.sl)
        else:
            self.snd = image.load("esb_sound.bin")
        self.code = {}                  # (space, addr) -> insn
        self.seen = set()               # (space, addr, bank, page)
        self.entries = collections.defaultdict(set)     # (space, addr) -> {why}
        self.calls = collections.defaultdict(set)       # (space, addr) -> {(space, from)}
        self.jumps = collections.defaultdict(set)       # branch / jump targets -> {from}
        self.tables = {}                # (space, addr) -> dict(count, kind, from)
        self.drefs = collections.defaultdict(set)       # (space, addr) -> {(space, from, how)}
        self.notes = []
        self.pctx = collections.defaultdict(set)        # P-space code -> banks it runs under
        self.winrefs = []               # data accesses in the slapstic window
        self.st = "EN"
        self.cover = {}                 # (space, byte address) -> start of the instruction holding it
        self.default_dp = 0x48 if cpu == "main" else 0x10
        self.cur_dp = None
        self.work_dp = []
        self.dp_conflicts = set()
        self.orphans = {}               # (space, addr) -> size, code found without a caller
        self.leafs = []
        self.work = []

    # ------------------------------------------------------------ memory
    def space(self, bank, page, a):
        if self.cpu == "sound":
            return "S" if (0x4000 <= a < 0x8000 or 0xC000 <= a < 0x10000) else None
        if 0x8000 <= a < 0xA000:
            return None if page is None else "P%d" % page
        if 0x6000 <= a < 0x8000 or 0xA000 <= a < 0x10000:
            return "B%d" % bank
        if 0x3000 <= a < 0x4000:
            return "V"
        return None

    def rd_space(self, sp, a):
        if sp == "S":
            return self.snd[a]
        if sp[0] == "P":
            return self.sl[int(sp[1]) * 0x2000 + a - 0x8000]
        if sp == "V":
            return self.banks[0][a]
        return self.banks[int(sp[1])][a]

    def word(self, sp, a):
        return (self.rd_space(sp, a) << 8) | self.rd_space(sp, a + 1)

    class View:
        def __init__(s, t, bank, page):
            s.t, s.bank, s.page = t, bank, page
        def __getitem__(s, a):
            sp = s.t.space(s.bank, s.page, a)
            if sp is None:
                raise KeyError(a)
            return s.t.rd_space(sp, a)

    # ------------------------------------------------------------ traversal
    def add(self, bank, page, pc, why, frm=None, call=False):
        sp = self.space(bank, page, pc)
        if sp is None:
            self.notes.append("target $%04X outside ROM or page unknown (%s, from %s)" % (pc, why, frm))
            return
        key = (sp, pc)
        if why in ("call", "vector", "table", "maze", "thunk", "hint"):
            self.entries[key].add(why)
        if frm is not None:
            (self.calls if call else self.jumps)[key].add(frm)
        dp = self.cur_dp if self.cur_dp is not None else self.default_dp
        (self.work if dp == self.default_dp else self.work_dp).append((bank, page, pc, dp))

    def run(self):
        # code reached with the usual direct page first: an instruction keeps
        # the direct page it was first reached with
        while self.work or self.work_dp:
            bank, page, pc, dp = (self.work or self.work_dp).pop()
            self.flow(bank, page, pc, dp)
            self.cur_dp = None

    def flow(self, bank, page, pc, dp):
        """Decode straight-line code from pc until it ends or joins code already seen."""
        hist = []                                   # recent instructions, for table detection
        self.cur_dp = dp
        self.st = "EN"                              # slapstic state along this flow
        while True:
            sp = self.space(bank, page, pc)
            if sp is None:
                self.notes.append("flow runs out of ROM at $%04X (bank %d)" % (pc, bank))
                return
            key = (sp, pc)
            tag = (sp, pc, bank, page if sp[0] == "B" else None)
            if sp[0] == "P":
                tag = (sp, pc, bank, None)
                self.pctx[key].add(bank)
            if tag in self.seen:
                old = self.code.get(key)
                if old and old.get("dp") != dp:
                    self.dp_conflicts.add((sp, pc, old.get("dp"), dp))
                return
            self.seen.add(tag)
            d = m6809.decode(self.View(self, bank, page), pc)
            if d is None:
                self.notes.append("undefined opcode at %s $%04X: %02X" % (sp, pc, self.rd_space(sp, pc)))
                self.code[key] = None
                return
            # an instruction must not run across the end of its space's range
            if self.space(bank, page, pc + d["len"] - 1) != sp:
                self.notes.append("instruction at %s $%04X runs out of its space" % (sp, pc))
                return
            d["space"] = sp
            d["dp"] = dp
            self.code[key] = d
            for i in range(d["len"]):
                self.cover.setdefault((sp, pc + i), pc)
            hist.append((pc, d))
            mn, mode, v = d["mn"], d["mode"], d["value"]
            nxt = pc + d["len"]
            here = (sp, pc)

            if self.cpu == "main" and mn == "JSR" and mode == EXT and v == 0x600B and sp[0] == "B" \
                    and 0x6018 <= pc < 0x6200 and self.rd_space("B%d" % (1 - bank), nxt) == 0x7E:
                # cross-bank table entry: run the JMP at pc+3 of the other bank
                d["thunk"] = 1 - bank
                self.add(1 - bank, page, nxt, "thunk", here)
                return
            if mode in (REL8, REL16):
                if mn in ("BSR", "LBSR"):
                    page = self.call(bank, page, v, here)
                elif mn in ("BRA", "LBRA"):
                    self.goto(bank, page, v, here)
                    return
                elif mn in ("BRN", "LBRN"):
                    pass
                else:
                    self.goto(bank, page, v, here)
            elif mn == "JSR" and mode in (EXT, DIR):
                t = v if mode == EXT else None
                if t is None:
                    self.notes.append("JSR direct at %s $%04X" % here)
                else:
                    page = self.call(bank, page, t, here)
                    if self.cpu == "main" and t == slapstic.ALT_HELPER and sp[0] == "P":
                        x = [h for _, h in hist[:-1][-3:] if h["mn"] == "LDX" and h["mode"] == IMM16]
                        if x and (x[-1]["value"] & 0xFFFC) == 0x9B5C:
                            d["slap"] = "slapstic alternate sequence: the next page select will select page %d" % (
                                x[-1]["value"] & 3)
                    if (sp, t) in H("NORETURN", set()) or t in H("NORETURN_ADDR", set()):
                        return
            elif mn == "JMP" and mode in (EXT, DIR):
                if mode == EXT:
                    self.goto(bank, page, v, here, jmp=True)
                else:
                    self.notes.append("JMP direct at %s $%04X" % here)
                return
            elif mn in ("JSR", "JMP") and mode == IDX:
                self.indirect(bank, page, hist, here, d)
                if mn == "JMP":
                    return
            elif mn in ENDS:
                return
            elif mn in ("PULS", "PULU") and v & 0x80:
                return
            elif mn in ("TFR", "EXG") and (v & 0x0F) == 5 or (mn == "EXG" and (v >> 4) == 5):
                self.notes.append("PC loaded by %s at %s $%04X" % (mn, sp, pc))
                return
            if mn in ("TFR", "EXG") and (v & 0x0F) == 0x0B:
                prev = hist[-2][1] if len(hist) > 1 else None
                src = {8: "LDA", 9: "LDB"}.get(v >> 4)
                if prev and src and prev["mn"] == src and prev["mode"] == IMM8:
                    dp = self.cur_dp = prev["value"]
                else:
                    self.notes.append("direct page set from an unknown value at %s $%04X" % here)
            elif mn in ("PULS", "PULU") and v & 0x08:
                dp = self.cur_dp = self.default_dp
            self.dref(bank, page, here, d)
            if self.cpu == "main" and mode == EXT and mn not in ("JSR", "JMP") and slapstic.in_window(v):
                c = slapstic.Slapstic(page if page is not None else 0, self.st)
                c.tweak(v)
                self.winrefs.append((sp, pc, v, self.st, c.state))
                if c.state != self.st:
                    d["slap"] = "slapstic: %s -> %s" % (self.st, c.state)
                self.st = c.state
            if here in H("STOP_AFTER", set()):
                return
            pc = nxt

    def trial(self, bank, page, pc, limit=600):
        """Would code at pc decode cleanly?  Follows branches without recording
        anything.  -> None, or dict(insns={addr: d}, calls=[targets], known=n)
        where known counts calls and jumps that land on code already traced."""
        sp0 = self.space(bank, page, pc)
        if sp0 is None:
            return None
        view = self.View(self, bank, page)
        insns, own = {}, {}
        calls, known = [], 0
        todo = [pc]

        def target_ok(t):
            nonlocal known
            if self.cpu == "main" and slapstic.in_window(t) and t < slapstic.MAZE_END:
                if t < slapstic.STUBS_END:
                    return (t & 3) == 0
                if sp0[0] == "P":
                    return slapstic.run_maze(self.sl, t, page)["end"] == "ret"
                return t in self.maze
            sp = self.space(bank, page, t)
            if sp is None or sp == "V":
                return False
            c = self.cover.get((sp, t))
            if c is not None:
                if c != t:
                    return False
                known += 1
                return True
            if sp == sp0:
                if own.get(t, t) != t:
                    return False
                todo.append(t)
                return True
            return m6809.decode(view, t) is not None

        while todo:
            a = todo.pop()
            while True:
                if a in insns:
                    break
                sp = self.space(bank, page, a)
                if sp != sp0:
                    return None
                c = self.cover.get((sp, a))
                if c is not None:
                    if c != a:
                        return None
                    break                               # joins traced code
                if own.get(a, a) != a:
                    return None
                d = m6809.decode(view, a)
                if d is None or self.space(bank, page, a + d["len"] - 1) != sp0:
                    return None
                for i in range(d["len"]):
                    if own.get(a + i, a) != a or (i and (sp, a + i) in self.cover):
                        return None
                    own[a + i] = a
                insns[a] = d
                if len(insns) > limit:
                    return dict(insns=insns, calls=calls, known=known)
                mn, mode, v = d["mn"], d["mode"], d["value"]
                if mn in ("SWI", "SWI2", "SWI3", "SYNC", "CWAI"):
                    return None
                if mode in (REL8, REL16):
                    if mn in ("BRN", "LBRN"):
                        return None
                    if not target_ok(v):
                        return None
                    if mn in ("BSR", "LBSR"):
                        calls.append(v)
                    if mn in ("BRA", "LBRA"):
                        break
                elif mn in ("JSR", "JMP") and mode == EXT:
                    if mn == "JSR" and v == 0x600B and self.cpu == "main":
                        break
                    if not target_ok(v):
                        return None
                    if mn == "JSR":
                        calls.append(v)
                    else:
                        break
                elif mn in ("JSR", "JMP") and mode == DIR:
                    return None
                elif mn == "JMP":
                    break
                elif mn in ENDS or (mn in ("PULS", "PULU") and v & 0x80):
                    break
                elif mode == DIR and d["op"] < 0x10 and v == 0 and d["op"] == 0:
                    return None                         # NEG <$00: zeros, not code
                a += d["len"]
        return dict(insns=insns, calls=calls, known=known)

    def find_orphans(self):
        """Code in the gaps that nothing traced reaches: accept a run that
        decodes cleanly to its ends and calls or joins code already known."""
        found = 0
        if self.cpu == "main":
            spaces = [("B0", 0, None, [(0x6000, 0x8000), (0xA000, 0x10000)]),
                      ("B1", 1, None, [(0x6000, 0x8000), (0xA000, 0x10000)])] + \
                     [("P%d" % p, 0, p, [(slapstic.MAZE_END, 0xA000)]) for p in range(4)]
        else:
            spaces = [("S", 0, None, [(0x4000, 0x8000), (0xC000, 0x10000)])]
        for sp, bank, page, ranges in spaces:
            for lo, hi in ranges:
                a = lo
                while a < hi:
                    if (sp, a) in self.cover or any(s2 == sp and lo2 <= a < hi2
                                                    for s2, lo2, hi2 in H("NOT_CODE_RANGES", []))                             or any(s2 == sp and b2 <= a < b2 + 2 * v["count"]
                                   for (s2, b2), v in self.tables.items()):
                        a += 1
                        continue
                    r = self.trial(bank, page, a)
                    ok = False
                    if r and self.rd_space(sp, a) not in (0x00, 0xFF) and (sp, a) not in H("NOT_CODE", set()):
                        if len(r["insns"]) >= 3 and (r["known"] >= 1 or len(r["calls"]) >= 1):
                            ok = True
                        elif len(r["insns"]) == 2 and r["known"] >= 1 and (sp, a - 1) in self.cover                                 and self.rd_space(sp, a) in (0x86, 0xC6, 0xCC):
                            ok = True                       # LDA #n / JMP: a stub in a row of stubs
                        elif (sp, a - 1) in self.cover and len(r["insns"]) >= 2:
                            # a leaf routine right behind traced code: it must be one
                            # unbroken run that ends in a return
                            ads = sorted(r["insns"])
                            last = r["insns"][ads[-1]]
                            ok = all(ads[i] + r["insns"][ads[i]]["len"] == ads[i + 1] for i in range(len(ads) - 1)) \
                                and (last["mn"] in ("RTS", "RTI") or (last["mn"] == "PULS" and last["value"] & 0x80)) \
                                and not any(d["mode"] == DIR and d["op"] < 0x10 for d in r["insns"].values())
                            if ok:
                                self.leafs.append((sp, a))
                    if ok:
                        self.orphans[(sp, a)] = len(r["insns"])
                        self.entries[(sp, a)].add("orphan")
                        self.work.append((bank, page, a, self.default_dp))
                        self.run()
                        found += 1
                        continue
                    # try again at the next address after a byte that could end code
                    a += 1
                    while a < hi and (sp, a) not in self.cover and \
                            self.rd_space(sp, a - 1) not in (0x39, 0x3B) and \
                            not (a >= lo + 3 and self.rd_space(sp, a - 3) == 0x7E) and \
                            not (a >= lo + 2 and self.rd_space(sp, a - 2) in (0x20, 0x35)) and \
                            not (a >= lo + 3 and self.rd_space(sp, a - 3) == 0x16):
                        a += 1
        return found

    def dref(self, bank, page, here, d):
        """Record ROM addresses an instruction refers to as data."""
        mn, mode, v = d["mn"], d["mode"], d["value"]
        if mode == EXT and mn not in ("JSR", "JMP"):
            sp = self.space(bank, page, v)
            if sp:
                self.drefs[(sp, v)].add(here + ("ext",))
        elif mode == IMM16 and mn in ("LDX", "LDY", "LDU", "CMPX", "CMPY", "CMPU", "LDD", "LEAX"):
            sp = self.space(bank, page, v)
            if sp:
                self.drefs[(sp, v)].add(here + ("imm:" + mn,))
        elif mode == IDX and d["post"] is not None and d["post"] & 0x80:
            t = d["post"] & 0x0F
            if t in (0x0C, 0x0D) or (d["post"] == 0x9F):
                sp = self.space(bank, page, v)
                if sp:
                    self.drefs[(sp, v)].add(here + ("pcr" if t != 0xF else "ind",))
            elif t == 0x09 and mn not in ("JSR", "JMP"):
                sp = self.space(bank, page, v)             # 16-bit offset: usually a table base
                if sp and v >= 0x3000:
                    self.drefs[(sp, v)].add(here + ("idx16",))

    def goto(self, bank, page, t, here, jmp=False):
        if self.cpu == "main" and slapstic.in_window(t) and t < slapstic.MAZE_END:
            self.into_maze(bank, page, t, here, jump=True)
            return
        self.add(bank, page, t, "jump", here)

    def call(self, bank, page, t, here):
        """Queue the target of a call; returns the page selected after it."""
        if self.cpu == "main" and slapstic.in_window(t) and t < slapstic.MAZE_END:
            return self.into_maze(bank, page, t, here, jump=False)
        self.add(bank, page, t, "call", here, call=True)
        return page

    def into_maze(self, bank, page, t, here, jump):
        code = self.code[here]
        if t == 0x8000:
            code["slap"] = "arms the slapstic"
            return page
        if (t & 0x1FFF) in slapstic.PAGE_ADDR and t < slapstic.STUBS_END:
            n = slapstic.PAGE_ADDR[t & 0x1FFF]
            code["slap"] = "selects page %d" % n
            return n
        if t < slapstic.STUBS_END:
            code["slap"] = "stub: arms the slapstic"
            return page
        if here[0][0] == "P" or (self.st != "EN" and page is not None):
            st, self.st = self.st, "EN"
            r = slapstic.run_maze(self.sl, t, page, st)
            if r["end"] != "ret":
                self.notes.append("maze from %s $%04X to $%04X: %s" % (here + (t, r["end"])))
                return page
            for pg, tg in r["calls"]:
                self.add(bank, pg, tg, "maze", here, call=True)
            code["slap"] = "maze%s: " % ("" if st == "EN" else " entered in state " + st) + \
                ", ".join("page %d $%04X" % c for c in r["calls"]) + \
                ("" if r["page"] == page else "; leaves page %d" % r["page"])
            code["maze"] = [list(c) for c in r["calls"]]
            if jump and r["page"] != page:
                self.notes.append("JMP into the maze at %s $%04X changes the page" % here)
            return r["page"]
        if self.st != "EN":
            self.notes.append("maze entered in state %s with the page unknown at %s $%04X" % (self.st, here[0], here[1]))
            self.st = "EN"
        e = self.maze.get(t)
        if e is None:
            self.notes.append("maze entry $%04X from %s $%04X does not resolve" % (t, here[0], here[1]))
            return page
        self.add(bank, e["page"], e["target"], "maze", here, call=True)
        code["slap"] = "maze: page %d $%04X%s" % (e["page"], e["target"],
                                                 "" if e["restores"] else "; leaves page %d" % e["leaves"])
        code["maze"] = [[e["page"], e["target"]]]
        return page if e["restores"] else e["leaves"]

    def indirect(self, bank, page, hist, here, d):
        post = d["post"]
        key_hint = H("TABLES", {}).get(here)
        if key_hint:
            base, count = key_hint
            self.table(bank, page, base, count, here)
            return
        reg = m6809.IDX_NAME[(post >> 5) & 3]
        t = post & 0x1F
        back = hist[:-1][-12:]

        def last_imm(r, upto):
            for pc, h in reversed(back[:upto]):
                if h["mn"] == "LD" + r and h["mode"] == IMM16:
                    return h["value"]
                if h["mn"] in ("LD" + r, "LEA" + r) and not (h["mn"] == "LEA" + r):
                    return None
            return None

        def bound_of():
            shifted = False
            for pc, h in reversed(back):
                if h["mn"] in ("ASLA", "ASLB"):
                    shifted = True
                if h["mn"] in ("CMPA", "CMPB") and h["mode"] == IMM8:
                    return h["value"] if shifted or any(x["mn"] == "ABX" for _, x in back) else None
                if h["mn"] in ("ANDA", "ANDB") and h["mode"] == IMM8 and h["value"] in (2, 6, 0x0E, 0x1E, 0x3E, 0x7E):
                    return h["value"] // 2 + 1
            return None

        base = None
        if post & 0x80 and t in (0x15, 0x16, 0x1B, 0x14):            # [B,R] [A,R] [D,R] [,R]
            base = last_imm(reg, len(back))
        elif post & 0x80 and t == 0x04:                              # ,R : R from LDR acc,R'
            for i in range(len(back) - 1, -1, -1):
                h = back[i][1]
                if h["mn"] == "LD" + reg:
                    if h["mode"] == IDX and h["post"] & 0x80 and (h["post"] & 0x1F) in (0x05, 0x06, 0x0B):
                        base = last_imm(m6809.IDX_NAME[(h["post"] >> 5) & 3], i)
                    break
        if base is not None:
            self.table(bank, page, base, bound_of(), here)
            return
        if post == 0x9F:                                             # [address]
            sp = self.space(bank, page, d["value"])
            if sp:
                self.table(bank, page, d["value"], 1, here)
                return
        self.notes.append("indirect %s at %s $%04X not resolved (post $%02X)" % (d["mn"], here[0], here[1], post))
        d["unresolved"] = True

    def table(self, bank, page, base, count, here):
        sp = self.space(bank, page, base)
        if sp is None:
            self.notes.append("jump table at $%04X from %s $%04X is not in ROM" % (base, here[0], here[1]))
            return
        n = 0
        a = base
        limit = count if count else 128
        targets = []
        while n < limit:
            if self.space(bank, page, a + 1) != sp:
                break
            w = self.word(sp, a)
            tsp = self.space(bank, page, w)
            if tsp is None or tsp == "V":
                break
            if not count:
                # without a bound: stop at the first target, at code, or at a bad target
                above = [x for x in targets if x > base and self.space(bank, page, x) == sp]
                if (sp, a) in self.code or (above and a >= min(above)):
                    break
                if (sp, a) in self.jumps or (sp, a) in self.calls or (sp, a) in self.drefs and a != base:
                    break
                if not (slapstic.in_window(w) and w < slapstic.MAZE_END and self.cpu == "main") \
                        and self.trial(bank, page, w) is None:
                    break
            targets.append(w)
            a += 2
            n += 1
        if not n:
            self.notes.append("empty jump table at %s $%04X from %s $%04X" % (sp, base, here[0], here[1]))
            return
        old = self.tables.get((sp, base))
        if old and old["count"] >= n:
            return
        self.tables[(sp, base)] = dict(count=n, bounded=bool(count), frm=here, bank=bank, page=page)
        for i, w in enumerate(targets):
            if self.cpu == "main" and slapstic.in_window(w) and w < slapstic.MAZE_END:
                self.notes.append("table %s $%04X entry %d points into the maze ($%04X)" % (sp, base, i, w))
                continue
            self.add(bank, page, w, "table", (sp, base + 2 * i), call=True)

    # ------------------------------------------------------------ results
    def coverage(self):
        cov = collections.defaultdict(set)
        for (sp, a), d in self.code.items():
            if d:
                for i in range(d["len"]):
                    cov[sp].add(a + i)
        return cov

def seed_main(t):
    for bank in (0, 1):
        sp = "B%d" % bank
        for va, nm in ((0xFFF2, "SWI3"), (0xFFF4, "SWI2"), (0xFFF6, "FIRQ"), (0xFFF8, "IRQ"),
                       (0xFFFA, "SWI"), (0xFFFC, "NMI"), (0xFFFE, "RESET")):
            t.add(bank, None, t.word(sp, va), "vector", (sp, va), call=True)
        t.add(bank, None, 0x6000, "vector", None)
        t.add(bank, None, 0x600B, "hint", None)
        a = 0x6018
        while a < 0x6400:                           # the cross-bank table: JMPs are entry points
            b = t.rd_space(sp, a)
            if b == 0x3F:
                a += 1
            elif b == 0x7E:
                t.add(bank, None, a, "thunk", None)
                a += 3
            elif b == 0xBD and t.word(sp, a + 1) == 0x600B:
                t.add(bank, None, a, "thunk", None)
                a += 3
            else:
                break
        t.thunk_end = getattr(t, "thunk_end", {})
        t.thunk_end[bank] = a
    for page in range(4):                           # the stubs and the maze: straight-line code
        sp = "P%d" % page
        a = 0x8000
        while a < slapstic.MAZE_END:
            d = m6809.decode(t.View(t, 0, page), a)
            d["space"] = sp
            d["dp"] = 0x48
            t.code[(sp, a)] = d
            for i in range(d["len"]):
                t.cover[(sp, a + i)] = a
            a += d["len"]
        assert a == slapstic.MAZE_END
    seed_carry(t, {"B0": (0, None), "B1": (1, None), "P0": (0, 0), "P1": (0, 1), "P2": (0, 2), "P3": (0, 3)})
    for (bank, page, a) in H("ENTRIES_MAIN", []):
        t.add(bank, page, a, "hint", None)
    for (bank, page, base, count) in H("TABLES_MAIN", []):
        t.table(bank, page, base, count, ("hint", base))

def seed_carry(t, ctx):
    """Tables of code addresses carried from Star Wars (sw_carry.json, written
    by swmatch.py from an earlier trace): their targets are entry points."""
    import os
    p = os.path.join(paths.HERE, "sw_carry.json")
    if not os.path.exists(p):
        return
    for k, rec in sorted(json.load(open(p))["carry"].items()):
        sp, a = k.split(":")
        if sp in ctx and rec.get("cptr"):
            a = int(a, 16)
            bank, page = ctx[sp]
            for i in rec["cptr"]:
                w = t.word(sp, a + 2 * i)
                if t.space(bank, page, w) and t.trial(bank, page, w) is not None:
                    t.add(bank, page, w, "table", (sp, a + 2 * i), call=True)
                    t.run()

def seed_sound(t):
    for va in range(0xFFF2, 0x10000, 2):
        t.add(0, None, t.word("S", va), "vector", ("S", va), call=True)
    seed_carry(t, {"S": (0, None)})
    for a in H("ENTRIES_SOUND", []):
        t.add(0, None, a, "hint", None)
    for (base, count) in H("TABLES_SOUND", []):
        t.table(0, None, base, count, ("hint", base))

def trace(cpu):
    t = Tracer(cpu)
    (seed_main if cpu == "main" else seed_sound)(t)
    t.run()
    t.traced = len(t.code)
    if H("ORPHANS", True):
        while t.find_orphans():
            pass
    return t

SIZES = {"B0": 0x8000, "B1": 0x8000, "P0": 0x2000, "P1": 0x2000, "P2": 0x2000, "P3": 0x2000,
         "S": 0x8000, "V": 0x1000}

def save(t, name):
    out = dict(
        code=[[sp, a, d["len"], d["mn"], d.get("slap"), d.get("maze"), d.get("thunk"), d.get("dp", t.default_dp)]
              for (sp, a), d in sorted(t.code.items()) if d],
        entries=[[sp, a, sorted(w)] for (sp, a), w in sorted(t.entries.items())],
        calls=[[sp, a, sorted([list(f) for f in fs if f])] for (sp, a), fs in sorted(t.calls.items())],
        jumps=[[sp, a, sorted([list(f) for f in fs if f])] for (sp, a), fs in sorted(t.jumps.items())],
        tables=[[sp, a, v["count"], v["bounded"], v["bank"], v["page"]] for (sp, a), v in sorted(t.tables.items())],
        drefs=[[sp, a, sorted([list(f) for f in fs])] for (sp, a), fs in sorted(t.drefs.items())],
        pctx=[[sp, a, sorted(b)] for (sp, a), b in sorted(t.pctx.items())],
        winrefs=[list(w) for w in sorted(set(t.winrefs))],
        orphans=[[sp, a, n] for (sp, a), n in sorted(t.orphans.items())],
        notes=t.notes,
    )
    with open(paths.build(name), "w") as f:
        json.dump(out, f)

def report(t, verbose=True):
    cov = t.coverage()
    for sp in sorted(cov):
        print("  %-3s code bytes %5d of %5d   instructions %5d" % (
            sp, len(cov[sp]), SIZES[sp], sum(1 for (s, a), d in t.code.items() if s == sp and d)))
    print("  entries %d   jump tables %d   notes %d   instructions traced %d + %d in %d orphan runs" % (
        len(t.entries), len(t.tables), len(t.notes), t.traced, len(t.code) - t.traced, len(t.orphans)))
    if verbose:
        seen = collections.Counter(t.notes)
        for n, c in seen.items():
            print("     " + n + ("  (x%d)" % c if c > 1 else ""))
        for (sp, a), v in sorted(t.tables.items()):
            print("     table %s $%04X  %3d entries%s  from %s" % (
                sp, a, v["count"], "" if v["bounded"] else " (guessed)", "%s $%04X" % v["frm"] if v["frm"][0] != "hint" else "hint"))
        print("     leaf orphans: " + " ".join("%s:%04X" % x for x in t.leafs))
        print("  instructions reached with two different direct pages: %d" % len(t.dp_conflicts))
        for sp, a, d1, d2 in sorted(t.dp_conflicts)[:40]:
            print("     %s $%04X  first $%02X, also $%02X" % (sp, a, d1, d2))
        both = [(k, b) for k, b in t.pctx.items() if len(b) > 1]
        print("  slapstic code reached under both banks: %d instructions" % len(both))

if __name__ == "__main__":
    v = "-q" not in sys.argv
    for cpu in ("main", "sound"):
        print(cpu)
        t = trace(cpu)
        save(t, "trace_%s.json" % cpu)
        report(t, v)
