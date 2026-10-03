"""Write the test scenarios (tests/scenarios/*.txt) for esbrun.

A scenario is a list of switch and yoke changes by game frame.  The play
scenarios are made from a fixed pseudo-random sequence, so they are the same
every time: a coin, a start, then a yoke that wanders and triggers and thumb
buttons that are pulled often, with more coins and starts now and then so the
run keeps playing after a game ends.
"""
import os

HERE = os.path.dirname(os.path.abspath(__file__))
OUT = os.path.join(HERE, "scenarios")

class Rng:
    def __init__(self, seed):
        self.s = seed
    def next(self):
        self.s = (self.s * 1103515245 + 12345) & 0x7FFFFFFF
        return self.s >> 16

def play(seed, frames, steady):
    r = Rng(seed)
    out = ["# a game played by a fixed pseudo-random hand (seed %d)" % seed]
    pitch = yaw = 0x80
    t = 120
    next_coin = t
    while t < frames:
        if t >= next_coin:
            out += ["%d coinl 1" % t, "%d coinl 0" % (t + 2), "%d coinl 1" % (t + 20), "%d coinl 0" % (t + 22),
                    "%d firel 1" % (t + 60), "%d firel 0" % (t + 64)]
            t += 70
            next_coin = t + 900 + r.next() % 400
            continue
        k = r.next()
        if steady:
            # aim near the centre, where targets come from, with small moves
            pitch = min(0xD0, max(0x30, pitch + (k % 33) - 16))
            yaw = min(0xD0, max(0x30, yaw + ((k >> 5) % 33) - 16))
        else:
            pitch = (k * 7) & 0xFF
            yaw = (k * 13) & 0xFF
        out.append("%d pitch 0x%02X" % (t, pitch))
        out.append("%d yaw 0x%02X" % (t, yaw))
        if k & 1:
            out += ["%d firel 1" % t, "%d firel 0" % (t + 2)]
        if (k & 6) == 6:
            out += ["%d firer 1" % (t + 1), "%d firer 0" % (t + 3)]
        if (k & 0x38) == 0x38:
            out += ["%d thumbl 1" % t, "%d thumbl 0" % (t + 3)]
        if (k & 0x1C0) == 0x1C0:
            out += ["%d thumbr 1" % (t + 1), "%d thumbr 0" % (t + 4)]
        t += 3 + k % 5
    return out

def selftest():
    out = ["# the self test: switch on at power-on, step through every screen with the aux coin switch,",
           "# move the yoke and pull the triggers on the way, then switch off.  Times are milliseconds",
           "# of machine time: the self test has no game frames.",
           "t0 test 1"]
    t = 6000
    for screen in range(16):
        out += ["t%d pitch 0x%02X" % (t, 0x20 + screen * 13), "t%d yaw 0x%02X" % (t, 0xE0 - screen * 11),
                "t%d firel 1" % (t + 500), "t%d firel 0" % (t + 800),
                "t%d thumbr 1" % (t + 1200), "t%d thumbr 0" % (t + 1500),
                "t%d coinaux 1" % (t + 4000), "t%d coinaux 0" % (t + 4300)]
        t += 6000
    out += ["t%d test 0" % t]
    return out

def main():
    os.makedirs(OUT, exist_ok=True)
    files = {
        "attract.txt": ["# nothing touched: the attract mode"],
        "play_steady.txt": play(1985, 30000, True),
        "play_wild.txt": play(4242, 30000, False),
        "selftest.txt": selftest(),
        "selftest_hold.txt": ["# the self test left on its first screen (the RAM and ROM test results)", "t0 test 1"],
    }
    for name, lines in files.items():
        with open(os.path.join(OUT, name), "w", newline="\n") as f:
            f.write("\n".join(lines) + "\n")
        print("  %s: %d lines" % (name, len(lines)))

if __name__ == "__main__":
    main()
