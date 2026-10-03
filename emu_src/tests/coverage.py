"""Hold what the machine executed against what the disassembly lists.

    python coverage.py            (after run_tests.py, which writes out/coverage.bin)

The test runs record every address an instruction was executed at, by bank,
page and CPU.  The disassembly's tracer (disasm/trace.py) decided which bytes
are instructions without running anything.  Two questions:

  1. Was anything executed that the listings do not show as an instruction
     starting at that address?  That would be code the tracer missed, or took
     for data, or decoded from the wrong byte.  There must be none.
  2. How much of what the listings show as instructions did the runs reach?
     The rest is not proven dead - the runs play a few games and step through
     the self test - but the stale image the annotators found should be in it.
"""
import json, os, sys

HERE = os.path.dirname(os.path.abspath(__file__))
DISASM = os.path.normpath(os.path.join(HERE, "..", "..", "disasm"))
sys.path.insert(0, DISASM)
import hints

SPACES = ["B0", "B1", "P0", "P1", "P2", "P3", "S"]

def main():
    cov = open(os.path.join(HERE, "out", "coverage.bin"), "rb").read()
    hit = {}
    for i, sp in enumerate(SPACES):
        m = cov[i * 0x2000:(i + 1) * 0x2000]
        hit[sp] = {a for a in range(0x10000) if m[a >> 3] & (1 << (a & 7))}
    code = {sp: {} for sp in SPACES}
    for cpu in ("main", "sound"):
        tr = json.load(open(os.path.join(DISASM, "build", "trace_%s.json" % cpu)))
        for row in tr["code"]:
            code[row[0]][row[1]] = row[2]
    # the stubs were booked on page 0 by the runner
    bad = 0
    out = []
    dead = getattr(hints, "DEAD_RANGES", [])
    for sp in SPACES:
        listed = set(code[sp])
        strays = sorted(hit[sp] - listed)
        reached = hit[sp] & listed
        in_dead = {a for a in listed if any(s == sp and lo <= a < hi for s, lo, hi in dead)}
        out.append("%-3s executed %5d addresses, all listed as instructions: %s;  listed %5d, reached %5d (%4.1f%%)"
                   "%s" % (sp, len(hit[sp]), "yes" if not strays else "NO, %d are not" % len(strays),
                           len(listed), len(reached), 100.0 * len(reached) / max(1, len(listed)),
                           ";  stale image: %d listed, %d reached" % (len(in_dead), len(in_dead & reached)) if in_dead else ""))
        if strays:
            bad += len(strays)
            out.append("    not listed: " + " ".join("$%04X" % a for a in strays[:24]))
        if in_dead & reached:
            # the one live thing in the stale image is the slapstic helper on page 1
            live = sorted(in_dead & reached)
            out.append("    reached inside the stale image: " + " ".join("$%04X" % a for a in live[:16]))
    text = "\n".join(out)
    print(text)
    with open(os.path.join(HERE, "coverage.txt"), "w", newline="\n") as f:
        f.write(text + "\n")
    print("\n%s" % ("!! %d executed addresses are not instructions in the listings" % bad if bad
                    else "everything executed is an instruction in the listings"))
    return 1 if bad else 0

if __name__ == "__main__":
    sys.exit(main())
