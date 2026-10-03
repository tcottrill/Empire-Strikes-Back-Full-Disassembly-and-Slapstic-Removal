"""Build the working images from a ROM set and regenerate and verify every listing.

    python gen_from_roms.py                     # ROMs from ../roms
    python gen_from_roms.py PATH [--check]      # a MAME zip, or a directory of zips / loose files

Steps, in order; any failing step prints `!!` and the exit status is 1:

  1. image.py        find the chips by CRC32 and build the images
  2. slapstic.py     resolve the maze: every entry must call one routine on one page
  3. trace.py        separate code from data in both banks, the four slapstic
                     pages and the sound program
  4. emit.py         the eight listings
  5. emit_defines.py the two defines files
  6. verify.py       independent read-back; every listing must show MISMATCHES : 0
  7. emit_shapes.py  shapes_preview.html

--check runs steps 3-7 a second time and requires byte-identical output.

Only a ROM set is needed.  The names and comments carried over from Star Wars
are in sw_carry.json, which swmatch.py wrote from the Star Wars disassembly;
it is not run here.
"""
import hashlib, os, sys
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)

OUTPUTS = ["esb_bank0_rom.asm", "esb_bank1_rom.asm", "esb_slapstic0_rom.asm", "esb_slapstic1_rom.asm",
           "esb_slapstic2_rom.asm", "esb_slapstic3_rom.asm", "esb_vector_rom.asm", "esb_sound_rom.asm",
           "esb_defines.asm", "esb_sound_defines.asm", "shapes_preview.html"]

def digest():
    h = {}
    for n in OUTPUTS:
        p = os.path.join(HERE, n)
        if os.path.exists(p):
            h[n] = hashlib.sha1(open(p, "rb").read()).hexdigest()
    return h

def step(title):
    print("\n== %s" % title)

def fail(msg):
    print("!! " + msg)
    sys.exit(1)

def generate():
    import trace, emit, emit_defines, verify
    step("trace.py")
    for cpu in ("main", "sound"):
        print(cpu)
        t = trace.trace(cpu)
        trace.save(t, "trace_%s.json" % cpu)
        trace.report(t, verbose=False)
        if t.dp_conflicts:
            fail("trace.py: code reached with two different direct pages")
        if any(len(b) > 1 for b in t.pctx.values()):
            fail("trace.py: slapstic code reached with both banks selected")
    step("emit.py")
    emit.main()
    step("emit_defines.py")
    if emit_defines.main():
        fail("emit_defines.py: define_docs.py has notes that are not used")
    step("verify.py")
    bad = sum(verify.run(*L) for L in verify.LISTINGS)
    if bad:
        fail("verify.py: %d mismatches" % bad)
    try:
        import emit_shapes
    except ImportError:
        emit_shapes = None
    if emit_shapes:
        step("emit_shapes.py")
        emit_shapes.emit()

def main(argv):
    check = "--check" in argv
    args = [a for a in argv if not a.startswith("--")]
    import image, slapstic
    step("image.py")
    image.build(args[0] if args else None)
    step("slapstic.py")
    sl = image.load("esb_slapstic.bin")
    ents = slapstic.maze_entries(sl)
    print("  %d maze entries resolve, to %d routines" % (
        len(ents), len({(r["page"], r["target"]) for r in ents.values()})))
    if not ents:
        fail("slapstic.py: the maze does not resolve")
    generate()
    if check:
        first = digest()
        step("second run (--check)")
        generate()
        diff = [n for n, h in digest().items() if first.get(n) != h]
        if diff:
            fail("output differs between two runs: %s" % ", ".join(diff))
        print("\nreproducible: %d files byte-identical over two runs" % len(first))
    print("\nall steps passed")
    return 0

if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
