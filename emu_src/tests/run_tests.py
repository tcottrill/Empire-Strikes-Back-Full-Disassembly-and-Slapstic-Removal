"""Run the Empire Strikes Back machine through its scenarios on each ROM set and
compare the sets.

    python run_tests.py            (after build_tests.bat, disasm/unslap.py and
                                    disasm/pcb27256.py)

The three sets:
  slapstic     the original ROMs, paged by the slapstic chip model
  noslap       disasm/unslap.py: no chip; the page latch at $43F0; the
               page-select stubs are the original's length and cycle count
  pcb27256     disasm/pcb27256.py: no chip; the four pages in one 27256 whose
               A13/A14 are the output latch's LED 3 / LED 2 bits; the stubs are
               28 cycles longer

selftest_hold leaves the self test on its first screen and requires the ROM
test to have summed the four pages and all ROMs to zero error bits - which, for
the two no-slapstic sets, checks the patched self test and the adjusted
checksum bytes.  selftest steps through every test screen and leaves by the
watchdog, as the program does.

For every other scenario each set must run without a fault (no watchdog bite, no
access to an unmapped address, no arrival at a trap, no lost interrupt once the
mainline runs).  The slapstic and noslap sets must also agree in every
trace record - one per interrupt, 246 a second: cycle count, registers, bank
and page, a CRC of all RAM, and a hash of every instruction address executed.
The pcb27256 set cannot agree cycle for cycle, since its stubs are longer; it
is only required to run without a fault.

The pcb27256 set has two more checks: the attract mode from each of the other
three states the two latch bits could hold at power-on (if RESET does not
clear the latch); and the self test with one bit of the 27256 flipped, which
must report the expansion ROM (error bit $4000) and nothing else.
"""
import os, shutil, subprocess, sys

HERE = os.path.dirname(os.path.abspath(__file__))
EXE = os.path.join(HERE, "esbrun.exe")
OUT = os.path.join(HERE, "out")
# scenario, seconds of machine time, compared cycle for cycle
RUNS = [("attract", 300, True), ("play_steady", 900, True), ("play_wild", 900, True),
        ("selftest_hold", 60, False), ("selftest", 130, False)]

def run(args):
    p = subprocess.run([EXE] + args, capture_output=True, text=True, cwd=HERE)
    return p.returncode, p.stdout + p.stderr

def main():
    os.makedirs(OUT, exist_ok=True)
    if os.path.exists(os.path.join(OUT, "coverage.bin")):
        os.remove(os.path.join(OUT, "coverage.bin"))
    bad = 0
    log = []
    for name, seconds, exact in RUNS:
        script = os.path.join("scenarios", name + ".txt")
        for s in ("slapstic", "noslap", "pcb27256"):
            trc = os.path.join("out", "%s_%s.trc" % (name, s))
            args = ["--set", s, "--seconds", str(seconds), "--script", script, "--trace", trc, "--quiet"]
            if s == "slapstic":
                args += ["--coverage", os.path.join("out", "coverage.bin")]
            if name == "selftest":
                args.append("--expect-hang")        # the self test ends by letting the watchdog bite
            if name == "selftest_hold":
                args.append("--selftest-ok")        # the RAM and ROM tests must find nothing
            rc, text = run(args)
            head = "== %s, set %s" % (name, s)
            print(head)
            print(text.rstrip())
            log += [head, text.rstrip()]
            bad += rc != 0
        if exact:
            rc, text = run(["--compare", os.path.join("out", name + "_slapstic.trc"),
                            os.path.join("out", name + "_noslap.trc")])
            head = "== %s: slapstic against noslap" % name
            print(head)
            print(text.rstrip())
            log += [head, text.rstrip()]
            bad += rc != 0
    # the 27256 set: the power-on state of the page bits must not matter
    for p in (1, 2, 3):
        rc, text = run(["--set", "pcb27256", "--seconds", "300", "--script", os.path.join("scenarios", "attract.txt"),
                        "--reset-page", str(p), "--quiet"])
        head = "== attract, set pcb27256, page bits at power-on give page %d" % p
        print(head)
        print(text.rstrip())
        log += [head, text.rstrip()]
        bad += rc != 0
    # ... and its self test must find a flipped bit in the 27256
    build = os.path.join(HERE, "..", "..", "disasm", "build")
    flip = os.path.join(OUT, "flip")
    os.makedirs(os.path.join(flip, "pcb27256"), exist_ok=True)
    for f in ("esb_main_bank1.bin", "esb_sound.bin", "esb_mathbox.bin", "esb_avgprom.bin"):
        shutil.copy(os.path.join(build, f), flip)
    shutil.copy(os.path.join(build, "pcb27256", "esb_pcb_bank0.bin"), os.path.join(flip, "pcb27256"))
    eprom = bytearray(open(os.path.join(build, "pcb27256", "esb_1hj.27256"), "rb").read())
    eprom[0x5123] ^= 0x10                           # page 2, $9123
    open(os.path.join(flip, "pcb27256", "esb_1hj.27256"), "wb").write(eprom)
    rc, text = run(["--set", "pcb27256", "--romdir", flip, "--seconds", "60",
                    "--script", os.path.join("scenarios", "selftest_hold.txt"), "--quiet"])
    head = "== selftest_hold, set pcb27256, one bit of the 27256 flipped: must report $4000 only"
    print(head)
    print(text.rstrip())
    log += [head, text.rstrip()]
    bad += "ERRORS $4000" not in text
    with open(os.path.join(HERE, "results.txt"), "w", newline="\n") as f:
        f.write("\n".join(log) + "\n")
    print("\n%s" % ("!! %d runs or comparisons failed" % bad if bad else "all runs clean, all comparisons agree"))
    return 1 if bad else 0

if __name__ == "__main__":
    sys.exit(main())
