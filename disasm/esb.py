"""The Empire Strikes Back address spaces, shared by the tools.

  B0, B1    main CPU, the two banks W_BANK selects: $6000-$7FFF and $A000-$FFFF
  P0 .. P3  main CPU, the four slapstic pages of $8000-$9FFF
  V         main CPU, the vector ROM $3000-$3FFF
  S         sound CPU, $4000-$7FFF and $C000-$FFFF

A reference from one space to an address in another is resolved by where the
referring code runs: bank code sees its own bank; slapstic code runs under
bank 0 (the tracer checks that no page code is reached with bank 1 selected)
and sees its own page.
"""
import json
import paths, image, m6809

RANGES = {
    "B0": [(0x6000, 0x8000), (0xA000, 0x10000)],
    "B1": [(0x6000, 0x8000), (0xA000, 0x10000)],
    "P0": [(0x8000, 0xA000)], "P1": [(0x8000, 0xA000)],
    "P2": [(0x8000, 0xA000)], "P3": [(0x8000, 0xA000)],
    "V": [(0x3000, 0x4000)],
    "S": [(0x4000, 0x8000), (0xC000, 0x10000)],
}
MAIN_SPACES = ["B0", "B1", "P0", "P1", "P2", "P3", "V"]
PREFIX = {"B0": "L", "B1": "K", "P0": "P0_", "P1": "P1_", "P2": "P2_", "P3": "P3_", "V": "L", "S": "L"}
DPAGE = {"main": 0x48, "sound": 0x10}

def cpu_of(sp):
    return "sound" if sp == "S" else "main"

def label(sp, a):
    return "%s%04X" % (PREFIX[sp], a)

def in_space(sp, a):
    return any(lo <= a < hi for lo, hi in RANGES[sp])

class Images:
    def __init__(self):
        self.bank = [image.load("esb_main_bank0.bin"), image.load("esb_main_bank1.bin")]
        self.slap = image.load("esb_slapstic.bin")
        self.sound = image.load("esb_sound.bin")

    def rd(self, sp, a):
        """Byte at address a as code in space sp sees it."""
        a &= 0xFFFF
        if sp == "S":
            return self.sound[a]
        if 0x8000 <= a < 0xA000:
            if sp[0] != "P":
                raise KeyError(a)
            return self.slap[int(sp[1]) * 0x2000 + a - 0x8000]
        return self.bank[1 if sp == "B1" else 0][a]

    def word(self, sp, a):
        return (self.rd(sp, a) << 8) | self.rd(sp, a + 1)

    def view(self, sp):
        im = self
        class V:
            def __getitem__(_, a):
                return im.rd(sp, a)
        return V()

    def decode(self, sp, a):
        try:
            return m6809.decode(self.view(sp), a)
        except KeyError:
            return None

def space_seen_from(sp, a):
    """The space that address a belongs to for code running in space sp, or None."""
    if sp == "S":
        return "S" if in_space("S", a) else None
    if 0x3000 <= a < 0x4000:
        return "V"
    if 0x8000 <= a < 0xA000:
        return sp if sp[0] == "P" else None
    if in_space("B0", a):
        return "B1" if sp == "B1" else "B0"
    return None

def load_trace(cpu):
    return json.load(open(paths.need(paths.build("trace_%s.json" % cpu), "trace (run trace.py)")))
