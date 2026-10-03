"""Print the numbers the README and the survey quote, measured from the current
outputs, so that they are copied and not remembered.

    python stats.py [--readme]      --readme also writes them into README.md
"""
import collections, glob, json, os, re
import paths, esb, emit, hints, slapstic, image, verify

def main():
    import io, sys
    buf = io.StringIO()
    out, sys.stdout = sys.stdout, buf
    try:
        report()
    finally:
        sys.stdout = out
    text = buf.getvalue()
    print(text, end="")
    if "--readme" in sys.argv:
        p = os.path.join(paths.HERE, "README.md")
        r = open(p).read()
        a, b = r.index("<!-- stats:begin -->"), r.index("<!-- stats:end -->")
        nl = chr(10)
        table = text.split(nl + nl)[0]
        rest = [l for l in text.split(nl + nl, 1)[1].splitlines() if l.strip()]
        body = table + nl + nl + nl.join("- " + l for l in rest) + nl
        open(p, "w", newline=nl).write(r[:a] + "<!-- stats:begin -->" + nl + body + r[b:])
        print("README.md updated")

def report():
    carry = json.load(open(os.path.join(paths.HERE, "sw_carry.json")))["carry"]
    rows = []
    tot = collections.Counter()
    for sp, fname in emit.LISTINGS.items():
        text = open(os.path.join(paths.HERE, fname)).read().splitlines()
        insn = data = 0
        for ln in text:
            m = verify.LINE.match(ln)
            if not m:
                continue
            if m.group(2) in (".byte", ".word"):
                n = len(verify.strip_comment(m.group(3)).split(","))
                data += n * (2 if m.group(2) == ".word" else 1)
            else:
                insn += 1
        heads = desc = 0
        for i, ln in enumerate(text):
            if ln == emit.DASH and i + 1 < len(text) and text[i + 1].startswith("; "):
                if i and text[i - 1] == "":
                    heads += 1
                    if " - " in text[i + 1] or (i + 2 < len(text) and text[i + 2].startswith(";   ")):
                        desc += 1
        matched = sum(1 for k in carry if k.startswith(sp + ":") and not carry[k].get("data"))
        cdata = sum(carry[k]["size"] for k in carry if k.startswith(sp + ":") and carry[k].get("data"))
        size = sum(hi - lo for lo, hi in esb.RANGES[sp])
        rows.append((fname, size, insn, matched, data, cdata, heads, desc))
        for k, v in zip("size insn matched data cdata heads desc".split(), rows[-1][1:]):
            tot[k] += v
    print("| listing | bytes | instructions | matched to Star Wars | data bytes | Star Wars data carried | routine headers | described |")
    print("|---|---|---|---|---|---|---|---|")
    for r in rows:
        print("| `%s` | %s | %s | %s | %s | %s | %d | %d |" % ((r[0],) + tuple("{:,}".format(x) for x in r[1:6]) + r[6:]))
    print("| total | %s | %s | %s | %s | %s | %d | %d |" % tuple(
        ["{:,}".format(tot[k]) for k in "size insn matched data cdata".split()] + [tot["heads"], tot["desc"]]))
    print()
    for f in ("esb_defines.asm", "esb_sound_defines.asm"):
        t = open(os.path.join(paths.HERE, f)).read().splitlines()
        al = [l for l in t if l.startswith(".alias")]
        print("%s: %d aliases, %d without a description" % (f, len(al), sum(1 for l in al if ";" not in l)))
    n = collections.Counter()
    for path in glob.glob(os.path.join(paths.HERE, "notes", "*.json")):
        j = json.load(open(path, encoding="utf-8"))
        for k in ("routines", "comments", "ram", "labels"):
            n[k] += len(j.get(k, {}))
    print("notes: %d files; in effect %d names, %d routine descriptions, %d line comments, %d RAM names" % (
        len(glob.glob(os.path.join(paths.HERE, "notes", "*.json"))), len(hints.NAMES), len(hints.HEADERS),
        len(hints.COMMENTS), len(hints.RAM["main"]) + len(hints.RAM["sound"])))
    sl = image.load("esb_slapstic.bin")
    ents = slapstic.maze_entries(sl)
    print("maze: %d entries, %d routines" % (len(ents), len({(r["page"], r["target"]) for r in ents.values()})))
    for cpu in ("main", "sound"):
        tr = esb.load_trace(cpu)
        print("trace %s: %d instructions, %d jump tables, %d orphan runs, %d notes" % (
            cpu, len(tr["code"]), len(tr["tables"]), len(tr["orphans"]), len(tr["notes"])))

if __name__ == "__main__":
    main()
