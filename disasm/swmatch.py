"""One-off: carry names and Atari's comments from the Star Wars disassembly to
the code The Empire Strikes Back shares with it.

    python swmatch.py [PATH-TO-STAR-WARS-disasm]

Needs the Star Wars project's listings, defines and build/ images.  Writes
sw_carry.json, which is checked in, so the listings regenerate from an ESB ROM
set alone.

Method.  Both programs are taken as streams of instructions.  Two instructions
are alike when mnemonic, addressing mode and index postbyte agree; operand
values are free, because everything was relocated.  Runs of like instructions
are found from 5-instruction seeds and extended; a run is kept if it is long, or
short but with operands that agree byte for byte.  Each ESB instruction takes
the best run that covers it.

A matched pair gives the Star Wars line's label, mnemonic spelling, operand
expression and comment.  Operand expressions that are one symbol (plus or minus
a number) vote on that symbol's value in ESB; the majority wins.  emit.py then
uses a carried expression only if it evaluates to the bytes in the ROM.

Data is carried where a run of 12 or more bytes is identical in both programs
and covers whole Star Wars statements.
"""
import collections, json, os, re, sys
import paths, esb, m6809, swlist, verify
from m6809 import INH, IMM8, IMM16, DIR, IDX, EXT, REL8, REL16, REGS, STK

SEED = 5

def sw_dir(argv):
    cands = argv[1:] + [os.path.join(paths.ROOT, "..", n, "disasm") for n in
                        ("Star Wars Arcade Dissasembly", "Star-Wars-Full-Disassembly-and-C-Port")]
    for c in cands:
        if os.path.exists(os.path.join(c, "starwars_program_rom.asm")):
            return os.path.normpath(c)
    sys.exit("!! Star Wars disasm directory not found; give its path as the argument")

class SW:
    """One Star Wars listing with its image."""
    def __init__(self, d, name, fname, image, off, end, others):
        self.name = name
        self.lines = swlist.listing(os.path.join(d, fname), end)
        rom = open(os.path.join(d, "build", image), "rb").read()
        mem = {}
        for o_img, o_off, lo, hi in others:
            data = open(os.path.join(d, "build", o_img), "rb").read()
            for a in range(lo, hi):
                mem[a] = data[a - o_off]
        for L in self.lines:
            for i in range(L.size):
                mem[L.addr + i] = rom[L.addr + i - off]
        self.mem = mem
        self.insn = []                      # (line, decoded) in address order, None for data
        for L in self.lines:
            d6 = m6809.decode(mem, L.addr) if not L.mn.startswith(".") else None
            if d6 is not None and d6["len"] != L.size:
                d6 = None
            self.insn.append(d6)

def tok(d):
    return d.get("tok") or (d["mn"], d["mode"], d["post"])

def call_tokens(cpu, spaces, streams, taken_by, sws, lists, im, tr):
    """Give every JSR / BSR / JMP to a fixed address a token that names its
    target: the Star Wars routine, where the first pass matched the target."""
    at = {k: {L.addr: j for j, L in enumerate(sws[k].lines)} for k in lists}
    rev = {}
    for sp in spaces:
        for (a, d), tk in zip(streams[sp], taken_by[sp]):
            if tk:
                rev[(sp, a)] = (tk[0], sws[tk[0]].lines[tk[1]].addr)
    maze = {(r[0], r[1]): r[5] for r in tr["code"] if r[5]}
    index_of = {sp: {a: i for i, (a, d) in enumerate(streams[sp])} for sp in spaces}

    def target_id(sp, a, d):
        t = d["value"]
        if (sp, a) in maze:
            tsp, t = "P%d" % maze[(sp, a)][0][0], maze[(sp, a)][0][1]
        else:
            tsp = esb.space_seen_from(sp, t)
            if tsp is None:
                return ("esb", sp, t)
            if tsp in ("B0", "B1") and 0x6018 <= t < 0x6200 and im.rd(tsp, t) == 0xBD                     and im.word(tsp, t + 1) == 0x600B:
                tsp = "B1" if tsp == "B0" else "B0"         # cross-bank table entry
                t = im.word(tsp, t + 4)
        if (tsp, t) in rev:
            return ("sw",) + rev[(tsp, t)]
        idx = index_of.get(tsp, {}).get(t)                  # instructions put in front of the routine
        if idx is not None:
            for k in range(1, 4):
                if idx + k < len(streams[tsp]):
                    a2 = streams[tsp][idx + k][0]
                    if (tsp, a2) in rev:
                        key, swa = rev[(tsp, a2)]
                        if sws[key].lines[at[key][swa]].names:
                            return ("sw", key, swa)
        return ("esb", tsp, t)

    def is_call(d):
        return d is not None and ((d["mn"] in ("JSR", "JMP") and d["mode"] == EXT) or d["mn"] in ("BSR", "LBSR"))

    for sp in spaces:
        for a, d in streams[sp]:
            if is_call(d):
                d["tok"] = (d["mn"], d["mode"], d["post"], target_id(sp, a, d))
    for key in lists:
        for d in sws[key].insn:
            if is_call(d):
                t = d["value"]
                if cpu == "sound":
                    k2 = "sound"
                else:
                    k2 = "overlay" if key == "overlay" and 0x6000 <= t < 0x8000 else "program"
                d["tok"] = (d["mn"], d["mode"], d["post"], ("sw", k2, t))

def ident(mem_a, a, mem_b, b, n):
    return all(mem_a[a + i] == mem_b[b + i] for i in range(n))

def simple(expr):
    """'NAME', 'NAME+n', 'NAME-n' -> (name, n) else None."""
    m = re.match(r"^([A-Za-z_][A-Za-z0-9_]*)(?:([+-])(\$[0-9A-F]+|\d+))?$", expr.strip())
    if not m:
        return None
    n = 0
    if m.group(2):
        n = int(m.group(3)[1:], 16) if m.group(3).startswith("$") else int(m.group(3))
        if m.group(2) == "-":
            n = -n
    return m.group(1), n

def operand_expr(oper, d):
    """The expression part of a listing operand, for the value the decoder reports."""
    o = oper.strip()
    mode = d["mode"]
    if mode in (IMM8, IMM16):
        return o[1:] if o.startswith("#") else None
    if mode in (EXT, DIR, REL8, REL16):
        return o.lstrip("<>")
    if mode == IDX:
        if o.startswith("[") and o.endswith("]"):
            o = o[1:-1]
        k = verify.last_comma(o)
        if k < 0:
            return o
        left = o[:k].strip().lstrip("<>")
        if left in ("", "A", "B", "D"):
            return None
        return left
    return None

def make_rec(key, L, same):
    rec = dict(sw="%s:%04X" % (key, L.addr), mn=L.mn, oper=L.oper)
    if same:
        rec["same"] = True
    if L.comment:
        rec["comment"] = L.comment
    if L.names:
        rec["names"] = L.names
        if L.name_comments:
            rec["name_comments"] = L.name_comments
    if L.pre:
        rec["pre"] = L.pre
    if L.header:
        rec["header"] = L.header
    if L.inner:
        rec["inner"] = [[nm, v - L.addr] for nm, v in L.inner]
    return rec

def fill_gaps(seq, taken, sws, mem_e, reach=80):
    """ESB often adds, drops or changes a few instructions inside a Star Wars
    routine.  Between two matched runs that are close in both programs, and
    for a stretch before the first and after the last, align the unmatched
    instructions with a diff and take what lines up."""
    import difflib
    n = len(seq)

    def align(i_lo, i_hi, key, j_lo, j_hi, anchored):
        s = sws[key]
        if i_hi <= i_lo or j_hi <= j_lo:
            return
        js = [j for j in range(j_lo, j_hi)]
        if any(s.insn[j] is None for j in js):
            # stop at data on the Star Wars side: keep the part next to the anchor
            return
        ta = [tok(seq[i][1]) for i in range(i_lo, i_hi)]
        tb = [tok(s.insn[j]) for j in js]
        sm = difflib.SequenceMatcher(None, ta, tb, autojunk=False)
        for blk in sm.get_matching_blocks():
            if not blk.size:
                continue
            same = sum(1 for k in range(blk.size)
                       if seq[i_lo + blk.a + k][1]["len"] >= 2 and
                       ident(mem_e, seq[i_lo + blk.a + k][0], s.mem, s.lines[j_lo + blk.b + k].addr,
                             seq[i_lo + blk.a + k][1]["len"]))
            if blk.size >= (2 if anchored else 4) or (anchored and same):
                for k in range(blk.size):
                    if taken[i_lo + blk.a + k] is None:
                        taken[i_lo + blk.a + k] = (key, j_lo + blk.b + k)

    # runs of matched instructions in ESB order
    runs = []
    i = 0
    while i < n:
        if taken[i] is None:
            i += 1
            continue
        e = i
        while e + 1 < n and taken[e + 1] is not None and taken[e + 1][0] == taken[i][0] \
                and taken[e + 1][1] == taken[e][1] + 1:
            e += 1
        runs.append((i, e))
        i = e + 1
    for r, (i0, i1) in enumerate(runs):
        key, j1 = taken[i1]
        # between this run and the next
        if r + 1 < len(runs):
            n0, n1 = runs[r + 1]
            key2, j2 = taken[n0]
            if key2 == key and 0 < j2 - j1 <= reach and 0 < n0 - i1 <= reach and (j2 - j1 > 1 and n0 - i1 > 1):
                jj = j1 + 1
                while jj < j2 and sws[key].insn[jj] is not None:
                    jj += 1
                if jj == j2:
                    align(i1 + 1, n0, key, j1 + 1, j2, True)
                    continue
        # after this run, up to the next data on the Star Wars side
        s = sws[key]
        jj = j1 + 1
        while jj < len(s.insn) and jj - j1 <= 40 and s.insn[jj] is not None:
            jj += 1
        ii = i1 + 1
        while ii < n and ii - i1 <= 40 and taken[ii] is None:
            ii += 1
        align(i1 + 1, ii, key, j1 + 1, jj, False)
    for (i0, i1) in runs:
        key, j0 = taken[i0]
        s = sws[key]
        jj = j0
        while jj > 0 and j0 - jj < 40 and s.insn[jj - 1] is not None:
            jj -= 1
        ii = i0
        while ii > 0 and i0 - ii < 40 and taken[ii - 1] is None:
            ii -= 1
        align(ii, i0, key, jj, j0, False)

IDENT = re.compile(r"(?<![$0-9A-Za-z_])[A-Za-z_][A-Za-z0-9_]*")
GRAM = 12

def carry_data(cpu, im, sws, lists, spaces, reloc, codebytes, carry, votes, ends):
    """Carry Star Wars data statements to ESB.  Starting from places known to
    correspond - the statement after or before a matched instruction, a data
    label a matched instruction names, a run of 12 identical bytes - walk both
    programs statement by statement while the bytes are identical or the words
    are pointers that relocate consistently."""
    at = {k: {L.addr: j for j, L in enumerate(sws[k].lines)} for k in lists}
    owner = {}
    for k in lists:
        o = {}
        for j, L in enumerate(sws[k].lines):
            for i in range(L.size):
                o[L.addr + i] = j
        owner[k] = o
    taken = set()
    count = [0, 0]

    def sw_lists(key, ws):
        if cpu == "sound":
            return ["sound"]
        if 0x3000 <= ws < 0x4000:
            return ["vector"]
        if 0x6000 <= ws < 0x8000:
            return ["overlay", "program"] if key == "overlay" else ["program", "overlay"]
        if ws >= 0x8000:
            return ["program"]
        return []

    def free(sp, a, n):
        return all(esb.in_space(sp, a + i) and (sp, a + i) not in codebytes and (sp, a + i) not in taken
                   for i in range(n))

    def similar(k2, ts, tsp, te):
        m = sws[k2].mem
        try:
            same = sum(1 for i in range(8) if m.get(ts + i) == im.rd(tsp, te + i))
        except KeyError:
            return False
        if same >= 6:
            return True
        a, b = ts, te
        for _ in range(3):
            d1, d2 = m6809.decode(m, a), im.decode(tsp, b)
            if d1 is None or d2 is None or tok(d1) != tok(d2):
                return False
            a += d1["len"]; b += d2["len"]
        return (tsp, te) in codebytes

    def pointer(key, sp, ts, te, new):
        tsp = esb.space_seen_from(sp, te)
        if tsp is None:
            return False
        for k2 in sw_lists(key, ts):
            if (tsp, te) in reloc.get((k2, ts), ()):
                return True
        for k2 in sw_lists(key, ts):
            if ts in owner.get(k2, {}) and similar(k2, ts, tsp, te):
                new.append((k2, ts, tsp, te))
                return True
        return False

    def corresponds(key, j, sp, a):
        if not 0 <= j < len(sws[key].lines):
            return None
        L = sws[key].lines[j]
        if L.mn not in (".byte", ".word") or not free(sp, a, L.size):
            return None
        sb = [sws[key].mem[L.addr + i] for i in range(L.size)]
        eb = [im.rd(sp, a + i) for i in range(L.size)]
        if sb == eb:
            return []
        if L.mn != ".word" or not IDENT.search(L.oper):
            return None
        new = []
        for i in range(0, L.size, 2):
            ws, we = (sb[i] << 8) | sb[i + 1], (eb[i] << 8) | eb[i + 1]
            if ws == we:
                continue
            if "VGBASE" in L.oper and (ws & 0xE000) in (0xA000, 0xE000) and (ws & 0xE000) == (we & 0xE000):
                if not pointer(key, sp, (ws & 0x1FFF) * 2, (we & 0x1FFF) * 2, new):
                    return None
            elif not pointer(key, sp, ws, we, new):
                return None
        return new

    queue = collections.deque()

    def take(key, j, sp, a, new):
        L = sws[key].lines[j]
        sb = all(sws[key].mem[L.addr + i] == im.rd(sp, a + i) for i in range(L.size))
        rec = make_rec(key, L, sb)
        rec["data"] = True
        rec["size"] = L.size
        if L.mn == ".word" and IDENT.search(L.oper):
            # which words point at code in Star Wars: the tracer follows them here
            items = [x.strip() for x in L.oper.split(",")]
            cp = []
            for k, it in enumerate(items):
                if 2 * k + 1 < L.size and IDENT.fullmatch(it):
                    ws = (sws[key].mem[L.addr + 2 * k] << 8) | sws[key].mem[L.addr + 2 * k + 1]
                    for k2 in sw_lists(key, ws):
                        if ws in at.get(k2, {}) and sws[k2].insn[at[k2][ws]] is not None:
                            cp.append(k)
                            break
            if cp:
                rec["cptr"] = cp
        carry["%s:%04X" % (sp, a)] = rec
        for i in range(L.size):
            taken.add((sp, a + i))
        reloc[(key, L.addr)].add((sp, a))
        for nm in L.names:
            votes[(cpu, nm)][(sp, a)] += 3
        count[0] += 1
        count[1] += L.size
        for k2, ts, tsp, te in new:
            reloc[(k2, ts)].add((tsp, te))
            if ts in at[k2]:
                queue.append((k2, at[k2][ts], tsp, te, 0))

    def walk(key, j, sp, a, direction):
        got = 0
        if direction >= 0:
            jj, aa = j, a
            while True:
                new = corresponds(key, jj, sp, aa)
                if new is None:
                    break
                take(key, jj, sp, aa, new)
                got += 1
                aa += sws[key].lines[jj].size
                jj += 1
        if direction <= 0:
            jj = j - 1
            while jj >= 0:
                aa = a - sws[key].lines[jj].size
                new = corresponds(key, jj, sp, aa)
                if new is None:
                    break
                take(key, jj, sp, aa, new)
                got += 1
                a = aa
                jj -= 1
        return got

    for key, j, sp, a, n in ends:
        if key in lists:
            queue.append((key, j + 1, sp, a + n, 1))
            queue.append((key, j, sp, a, -1))
    for (k2, ts), tg in list(reloc.items()):
        if k2 in lists and ts in at[k2] and sws[k2].lines[at[k2][ts]].mn in (".byte", ".word"):
            for tsp, te in tg:
                queue.append((k2, at[k2][ts], tsp, te, 0))
    while queue:
        key, j, sp, a, direction = queue.popleft()
        walk(key, j, sp, a, direction)

    # runs of identical bytes
    index = collections.defaultdict(list)
    for k in lists:
        s = sws[k]
        for L in s.lines:
            if L.mn not in (".byte", ".word"):
                continue
            for a in range(L.addr, L.addr + L.size):
                g = bytes(s.mem.get(a + i, 256) & 0xFF if a + i in s.mem else 0 for i in range(GRAM))
                if all(a + i in s.mem for i in range(GRAM)) and len(set(g)) > 3:
                    index[g].append((k, a))
    for sp in spaces:
        for lo, hi in esb.RANGES[sp]:
            a = lo
            while a < hi - GRAM:
                if not free(sp, a, GRAM):
                    a += 1
                    continue
                g = bytes(im.rd(sp, a + i) for i in range(GRAM))
                hit = False
                for k, sa in index.get(g, ())[:8]:
                    j = owner[k][sa]
                    L = sws[k].lines[j]
                    start = a - (sa - L.addr)
                    if walk(k, j, sp, start, 0) or walk(k, j + 1, sp, start + L.size, 0):
                        hit = True
                        while queue:
                            key2, j2, sp2, a2, d2 = queue.popleft()
                            walk(key2, j2, sp2, a2, d2)
                        break
                a += 1
    return count

def main(argv):
    d = sw_dir(argv)
    print("Star Wars listings: %s" % d)
    im = esb.Images()
    MAINROM = [("starwars_main_rev2.bin", 0, 0x3000, 0x4000), ("starwars_main_rev2.bin", 0, 0x6000, 0x10000)]
    sws = {
        "program": SW(d, "program", "starwars_program_rom.asm", "starwars_main_rev2.bin", 0, 0x10000, MAINROM),
        "overlay": SW(d, "overlay", "starwars_overlay_rom.asm", "starwars_bank1.bin", 0x6000, 0x8000, MAINROM),
        "vector": SW(d, "vector", "starwars_vector_rom.asm", "starwars_main_rev2.bin", 0, 0x4000, MAINROM),
        "sound": SW(d, "sound", "starwars_sound_rom.asm", "starwars_sound.bin", 0, 0x8000, []),
    }
    defs = {"main": swlist.defines(os.path.join(d, "starwars_defines.asm")),
            "sound": swlist.defines(os.path.join(d, "starwars_sound_defines.asm"))}

    # Star Wars symbol values, per CPU
    swsym = {"main": {}, "sound": {}}
    swkind = {"main": {}, "sound": {}}              # name -> section, or 'label:<listing>'
    for cpu in ("main", "sound"):
        for nm, (v, sec, cm) in defs[cpu].items():
            if v.startswith("$"):
                swsym[cpu][nm] = int(v[1:], 16)
                swkind[cpu][nm] = sec
    for key, s in sws.items():
        cpu = "sound" if key == "sound" else "main"
        for L in s.lines:
            swsym[cpu]["%s%04X" % (L.prefix, L.addr)] = L.addr
            for nm in L.names:
                swsym[cpu][nm] = L.addr
                swkind[cpu][nm] = "label:" + key
            for nm, v in L.inner:
                swsym[cpu][nm] = v
                swkind[cpu][nm] = "label:" + key

    carry = {}                                      # "SPACE:ADDR" -> record
    votes = collections.defaultdict(collections.Counter)    # (cpu, name) -> {(space or '', value): n}
    stats = collections.OrderedDict()

    for cpu, spaces, lists in (("main", ["B0", "B1", "P0", "P1", "P2", "P3"], ["program", "overlay"]),
                               ("sound", ["S"], ["sound"])):
        tr = esb.load_trace(cpu)
        reloc = collections.defaultdict(set)        # (listing, Star Wars address) -> {(space, ESB address)}
        codebytes = set()
        dpmap = {(r[0], r[1]): r[7] for r in tr["code"]}    # direct page each instruction runs with
        ends = []                                   # matched instructions: (listing, line index, space, address, length)
        # ESB instruction streams, broken where the addresses are not contiguous
        streams = {}
        for sp in spaces:
            ads = sorted(a for s, a, n, *_ in tr["code"] if s == sp)
            seq = []
            for a in ads:
                seq.append((a, im.decode(sp, a)))
            streams[sp] = seq
        taken_by = {}
        for pas in (1, 2):
            if pas == 2:
                # second pass: a call matches only a call to the same routine,
                # as far as the first pass identified the routines
                call_tokens(cpu, spaces, streams, taken_by, sws, lists, im, tr)
            # seed index over the Star Wars instructions
            index = collections.defaultdict(list)
            for key in lists:
                s = sws[key]
                ins = s.insn
                for j in range(len(ins) - SEED + 1):
                    if all(ins[j + k] is not None for k in range(SEED)):
                        index[tuple(tok(ins[j + k]) for k in range(SEED))].append((key, j))
            for sp in spaces:
                seq = streams[sp]
                mem_e = im.view(sp)
                n = len(seq)
                contig = [i + 1 < n and seq[i][0] + seq[i][1]["len"] == seq[i + 1][0] for i in range(n)]
                runs = {}
                for i in range(n - SEED + 1):
                    if not all(contig[i + k] for k in range(SEED - 1)):
                        continue
                    t = tuple(tok(seq[i + k][1]) for k in range(SEED))
                    for key, j in index.get(t, ()):
                        s = sws[key]
                        # extend to the maximal run on this diagonal
                        i0, j0 = i, j
                        while i0 > 0 and j0 > 0 and contig[i0 - 1] and s.insn[j0 - 1] is not None \
                                and tok(seq[i0 - 1][1]) == tok(s.insn[j0 - 1]):
                            i0 -= 1; j0 -= 1
                        if (key, i0, j0) in runs:
                            continue
                        i1, j1 = i0, j0
                        while i1 < n and j1 < len(s.insn) and s.insn[j1] is not None \
                                and tok(seq[i1][1]) == tok(s.insn[j1]):
                            i1 += 1; j1 += 1
                            if not contig[i1 - 1]:
                                break
                        ln = i1 - i0
                        same = strong = 0
                        for k in range(ln):
                            a_e, d_e = seq[i0 + k]
                            L = s.lines[j0 + k]
                            if ident(mem_e, a_e, s.mem, L.addr, d_e["len"]):
                                same += 1
                                if d_e["len"] >= 3 or (d_e["len"] == 2 and d_e["mode"] in (IMM8, DIR)):
                                    strong += 1
                        runs[(key, i0, j0)] = (ln, same, strong)
                cand = []
                for (key, i0, j0), (ln, same, strong) in runs.items():
                    if ln >= 12 or (ln >= SEED and strong >= 2 and same * 2 >= ln) or (ln >= 8 and strong >= 3):
                        cand.append((strong * 2 + ln, ln, key, i0, j0))
                cand.sort(reverse=True)
                taken = [None] * n
                for score, ln, key, i0, j0 in cand:
                    # take the free stretches of this run that are still long enough
                    k = 0
                    while k < ln:
                        if taken[i0 + k] is not None:
                            k += 1
                            continue
                        e = k
                        while e < ln and taken[i0 + e] is None:
                            e += 1
                        if e - k >= SEED or (e - k == ln):
                            for q in range(k, e):
                                taken[i0 + q] = (key, j0 + q)
                        k = e
                fill_gaps(seq, taken, sws, mem_e)
                taken_by[sp] = taken
        for sp in spaces:
            seq = streams[sp]
            mem_e = im.view(sp)
            n = len(seq)
            taken = taken_by[sp]
            got = 0
            for i, tk in enumerate(taken):
                if tk is None:
                    continue
                key, j = tk
                got += 1
                a_e, d_e = seq[i]
                L = sws[key].lines[j]
                rec = make_rec(key, L, ident(mem_e, a_e, sws[key].mem, L.addr, d_e["len"]))
                if L.names and d_e["mode"] == IMM8 and "same" not in rec:
                    # a named line that loads a different constant - a row of LDA #n / JMP
                    # stubs matched by position: the name belongs to the constant
                    for f in ("names", "name_comments", "header", "comment", "pre", "inner"):
                        rec.pop(f, None)
                    rec["nameless"] = True
                carry["%s:%04X" % (sp, a_e)] = rec
                reloc[(key, L.addr)].add((sp, a_e))
                ends.append((key, j, sp, a_e, d_e["len"]))
                # votes
                ex = operand_expr(L.oper, d_e)
                sm = simple(ex) if ex else None
                if sm:
                    nm, off = sm
                    v = d_e["value"]
                    if d_e["mode"] == DIR:
                        v |= dpmap.get((sp, a_e), esb.DPAGE[cpu]) << 8
                    if v is not None:
                        v = (v - off) & 0xFFFF
                        if d_e["mode"] == IMM8:
                            v &= 0xFF
                        tsp = esb.space_seen_from(sp, v) if d_e["mode"] != IMM8 else None
                        kind = swkind[cpu].get(nm, "")
                        if not kind.startswith("label:") and not re.match(r"^[LK][0-9A-F]{4}$", nm):
                            tsp = None
                        votes[(cpu, nm)][(tsp or "", v)] += 1
                if "nameless" not in rec:
                    for nm in L.names:
                        votes[(cpu, nm)][(sp, a_e)] += 3
            stats[sp] = (got, n)
            print("  %-3s %5d of %5d instructions matched to Star Wars" % (sp, got, n))
        for s, a, n2, *_ in tr["code"]:
            for i2 in range(n2):
                codebytes.add((s, a + i2))
        # data labels the matched code names: Star Wars label -> where ESB's operand points
        for (c2, nm), c in votes.items():
            if c2 != cpu:
                continue
            kind = swkind[cpu].get(nm, "")
            if kind.startswith("label:") and nm in swsym[cpu]:
                (tsp, v), k = c.most_common(1)[0]
                if tsp:
                    reloc[(kind[6:], swsym[cpu][nm])].add((tsp, v))
        nd = carry_data(cpu, im, sws, lists + (["vector"] if cpu == "main" else []),
                        spaces + (["V"] if cpu == "main" else []), reloc, codebytes, carry, votes, ends)
        print("  %s: %d data lines carried (%d bytes)" % (cpu, nd[0], nd[1]))

    # resolve the votes
    symbols = {"main": {}, "sound": {}}
    conflicts = []
    dropped = []
    for (cpu, nm), c in sorted(votes.items()):
        if re.match(r"^[LK][0-9A-F]{4}$", nm):
            continue
        best = c.most_common()
        (tsp, v), nvotes = best[0]
        total = sum(c.values())
        rec = dict(value=v, votes=nvotes, total=total, sw=swsym[cpu].get(nm), kind=swkind[cpu].get(nm, ""))
        if not tsp and rec["sw"] is not None and v != rec["sw"]:
            ramkind = rec["kind"] not in ("Constants", "") and not rec["kind"].startswith("label:")
            if nvotes == 1 and not ramkind:
                dropped.append((cpu, nm, v, "one vote for a changed constant"))
                continue
            if ramkind and v >= 0x6000 and cpu == "main":
                dropped.append((cpu, nm, v, "a RAM or register name voted onto a ROM address"))
                continue
        if tsp:
            rec["space"] = tsp
            # the same routine found in other spaces
            others = {}
            for (s2, v2), k in best[1:]:
                if s2 and s2 != tsp and s2 not in others:
                    others[s2] = v2
            if others:
                rec["also"] = others
        if nvotes < total:
            conflicts.append((cpu, nm, best[:4]))
        symbols[cpu][nm] = rec
    out = dict(carry=carry, symbols=symbols,
               sw_defines={cpu: {nm: [v, sec, cm] for nm, (v, sec, cm) in defs[cpu].items()} for cpu in defs})
    with open(os.path.join(paths.HERE, "sw_carry.json"), "w") as f:
        json.dump(out, f, indent=0, sort_keys=True)
    print("  %d lines carried, %d symbols voted (%d main, %d sound), %d with dissent" % (
        len(carry), len(symbols["main"]) + len(symbols["sound"]), len(symbols["main"]),
        len(symbols["sound"]), len(conflicts)))
    print("  %d votes dropped (build/swmatch_conflicts.txt)" % len(dropped))
    with open(paths.build("swmatch_conflicts.txt"), "w") as f:
        for cpu, nm, v, why in dropped:
            f.write("dropped %s %s = $%04X: %s\n" % (cpu, nm, v, why))
        for cpu, nm, best in conflicts:
            f.write("%s %s: %s\n" % (cpu, nm, ", ".join("%s$%04X x%d" % (s + ":" if s else "", v, k) for (s, v), k in best)))
    return 0

if __name__ == "__main__":
    sys.exit(main(sys.argv))
