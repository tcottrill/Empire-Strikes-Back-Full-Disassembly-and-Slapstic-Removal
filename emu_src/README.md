# esb_emu — The Empire Strikes Back on its chips

`esb_emu.exe` runs the Empire Strikes Back ROMs on two 6809 cores and models of
the board's chips, in a window with sound and controls. It is the Star Wars
project's emulator twin with ESB's differences: two full program banks, the
four ROM pages behind the slapstic, a 32K sound program.

It runs **three ROM sets**:

| `rom_set` / `--set` | ROMs | how `$8000-$9FFF` is paged |
|---|---|---|
| `slapstic` (default) | the original set, as dumped | a model of the slapstic 137412-101 (`slapstic101.c`) watches the bus |
| `noslap` | the set [`tools/esb_unslap.py`](../tools/esb_unslap.py) writes (the emulator-only set) | no chip: an access to `$43F0+n` selects page n; a read returns `$B5` |
| `pcb27256` | the set [`tools/esb_pcb27256.py`](../tools/esb_pcb27256.py) writes, for a real board ([`docs/PCB_27256.md`](../docs/PCB_27256.md)) | no chip: the four pages are one 27256 whose A13 / A14 are the output latch's `$4682` / `$4683` (the LED 3 / LED 2 outputs) |

Nothing is decrypted in any of them. The expansion ROMs hold plain code; the
slapstic only decides which 8K page is visible, and the no-slapstic sets have
the program select the page itself. See [`docs/SLAPSTIC.md`](../docs/SLAPSTIC.md).

## Files

| file | |
|---|---|
| `emu_main.cpp` | the machine for the host: runs the board up to the wall clock, makes the picture from the vector generator's display list and the sound from the four POKEYs and the speech chip, reads the switches and the yoke, keeps the NOVRAM |
| `board.cpp`, `board.h` | the two 6809s on the hardware: memory maps, the two banks, the page window and what the slapstic sees of the bus, the 246 Hz interrupt, one timeline |
| `hw.cpp` | the hardware without the CPUs: ports, latches, the link between the boards, RESET, the page latch of the no-slapstic sets. Its header is the hardware model |
| `slapstic101.c` | the slapstic as a state machine (MAME's, chip 101's parameters) |
| `avg.c`, `mathbox.c`, `x2212.c`, `riot6532.c`, `tms5220.cpp`, `c012294.c` | vector generator (from its state PROM), matrix processor (from its microcode PROMs), NOVRAM, 6532, speech chip, POKEY — the Star Wars project's models, unchanged |
| `cpu/` | the 6809 core, vendored from the [AAE emulator](https://github.com/tcottrill/AAE), unmodified |
| `platform/` | the platform contract and the Windows backend (window, OpenGL beam renderer, XAudio2 stream, raw input, joystick, ini, log, screenshots) |
| `build_emu.bat` | builds `esb_emu.exe`; objects in `obj\` |
| `tests/` | the machine without a window, the scenarios, and the comparison of the ROM sets (below) |

## Build and run

    cmd /c ".\build_emu.bat"        (Visual Studio 2022, x64)
    esb_emu.exe

The set that runs is `rom_set` in `[main]` of `esb_emu.ini` (`slapstic`,
`noslap` or `pcb27256`; `slapstic` if it is not there). `--set` overrides it
for one run, e.g. `esb_emu.exe --set noslap`.

It reads the ROM images from `..\disasm\build`. Build them once from your own
MAME `esb` set in `..\roms`:

    python ..\disasm\gen_from_roms.py          the original set's images
    python ..\disasm\unslap.py                 the no-slapstic set (noslap)
    python ..\disasm\pcb27256.py               the 27256 set for a real board

(`unslap.py --stub write` makes the other form of the no-slapstic set, into
`build\noslap_write`: stubs that write the latch, five cycles longer. It is
kept as an option of the tool and is not one of the emulator's sets.)

No ROM data is in the exe. Settings are in `esb_emu.ini` and the NOVRAM in
`esb.nv`, both next to the exe.

Keys: mouse / arrows / stick = yoke, left button or Ctrl and right button or
Alt = triggers, Space / Shift = thumb buttons, 5 / 6 coins, 7 aux coin, F2 self
test, F1 diagnostic step, F4 sound test, F8 mouse capture, Esc quit.

## Tests

    cmd /c tests\build_tests.bat
    python tests\make_scenarios.py
    python tests\run_tests.py
    python tests\coverage.py

`tests\esbrun.exe` is the same board with no window. `run_tests.py` runs five
scenarios — the attract mode, two games played by a fixed pseudo-random hand,
the self test held on its results, and the self test stepped through every
screen — on each of the three ROM sets, and writes `tests\results.txt`.

What is required, and what the last run gave:

- **No faults on any set**: no watchdog bite (but the one the self test leaves
  by), no access to an unmapped address, no arrival at a trap, no interrupt
  lost once the mainline runs. All 15 scenario runs are clean. In the games every wave
  part the hand reaches is played, on all four pages; the chip's alternate
  sequence is used hundreds of times and its bitwise decoy several.
- **The original set and the noslap set agree record for record.** A trace
  record is written at every interrupt, 246 a second: cycle count, registers,
  bank and page, a CRC of all RAM, and a hash of every instruction address
  executed since power-on. Over the attract mode (5 minutes) and the two games
  (15 minutes each) the two sets agree in all 515,790 records: the program
  executes the same instructions at the same cycles with the same RAM whether
  the chip pages the ROMs or the program does. (Which of the four stubs runs
  is left out of the comparison: that is the one thing the no-slapstic set
  changes on purpose.) Screenshots of the two sets at the same game frames are
  identical files.
- **The self test passes on the patched sets**: with the ROM test's page
  selects rewritten and the checksum bytes adjusted, it reports no error and
  six zero checksums; with one bit flipped in a page it reports the expansion
  board, on every set.
- **Everything executed is in the listings.** `coverage.py` holds the
  addresses the runs executed against the disassembly's list of instructions:
  every one is the start of a listed instruction, in both banks, the four
  pages and the sound program. None of the stale image the listings mark as
  never reached was executed, except the three instructions of the slapstic
  helper at `$9DFE`. The runs reach 49-76% of the listed instructions per
  listing (`tests\coverage.txt`).

The 27256 set cannot agree cycle for cycle (its stubs are 28 cycles longer),
so it is held to "no faults". The longer stubs shift the timing enough that the
scripted games play out differently, but every run is clean and the games run
code on all four pages. For the 27256 set `run_tests.py` adds four runs: the
attract mode starting from each other value the two latch bits could hold at
power-on, and the self test with one bit of the 27256 flipped, which must report
the expansion ROM ($4000) and nothing else. All 19 runs and the three
comparisons pass.

The self test's first screen shows VERISUM B735 on the original set, the value
a 1996 conversion guide gives for a real ESB board, and VERISUM 2915 on the
27256 set.

What the tests do not show: the scenarios do not reach every part of the
game (the asteroid field only with the option switches at `$FA`, tried by
hand), the sound has not been listened to, and the slapstic model is MAME's,
not checked against a real chip here.
