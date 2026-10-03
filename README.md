# The Empire Strikes Back — full disassembly and slapstic removal

A disassembly of The Empire Strikes Back (Atari, 1985), with notes and tools
for running it without its slapstic. ESB hides a third of its program behind
Atari's slapstic 137412-101, the copy-protection chip often called its
"encryption". This project describes how the program uses the chip and
includes patchers that make ROM sets, from your own ROMs, that run without it.
They have been checked against a model of the chip and run in an emulator.
There is also an untested suggestion for running them on a Star Wars board
using one 27256 EPROM and two wires.

The disassembly covers both banks of the main 6809 program, the four ROM pages
behind the slapstic, the vector ROM and the sound board's 6809 program, as
plain assembler source in which every line is encoded again and compared with
the ROMs, byte for byte. The work was done with an AI assistant (Anthropic's
Claude).

- **How the slapstic is used.** The slapstic is a paging chip rather than
  encryption: it shows one of four 8K pages at `$8000-$9FFF`, chosen by
  watching the address bus. The program reaches its paged code through a maze
  of jumps that differs on every page, and uses two of the chip's special
  modes. [`docs/SLAPSTIC.md`](docs/SLAPSTIC.md) describes what we found.
- **Patchers.** Two patchers, in the disassembly and as standalone one-file
  tools, change the few places that depend on the chip. The calls the program
  makes into the maze were checked against a model of the chip, and the
  emulator set matched the original in the test runs.
- **A suggested real-board version, untested.** All four pages in one 27256
  EPROM in place of the kit's daughterboard, paged by two outputs of a latch
  already on the Star Wars board. [`docs/PCB_27256.md`](docs/PCB_27256.md)
  describes it. It has only been tried in the emulator.
- **An emulator**, [`emu_src/`](emu_src/README.md): `esb_emu.exe` can run the
  original ROMs with a slapstic model, the patched set, or the 27256 set,
  chosen in its ini file. See [The emulator](#the-emulator) below.

ESB was a conversion kit for Star Wars, and its program was written on top of
the Star Wars program. **No source for ESB survives**, but the source for Star
Wars does. Where ESB's code is still Star Wars code, instruction for
instruction, the listings carry Atari's own names and comments (upper case),
by way of the
[Star Wars disassembly](https://github.com/tcottrill/Star-Wars-Full-Disassembly-and-C-Port).
Everything else (the probots, the walkers and the tow cable, the asteroid
field, the Jedi letters, the training manual) was read and described from the
code, and is in lower case.

**[See every vector object in the game](https://tcottrill.github.io/Empire-Strikes-Back-Full-Disassembly-and-Slapstic-Removal/disasm/shapes_preview.html)**
(`disasm/shapes_preview.html`, drawn from the ROM): the character set, the
vector ROM pictures, the title logo, and the 35 three-dimensional objects with
the lines their draw routines draw.

## Quick start

Nothing here runs without a ROM set, and none is included.

1. Put a MAME `esb` set (a zip, or loose files) in `roms/`.
2. `python disasm/gen_from_roms.py --check` finds the chips by CRC32 and
   writes the working images to `disasm/build/`, where the emulator reads
   them. It then rebuilds every listing and checks that each one reproduces its
   ROM byte for byte. Only Python 3 is needed.
3. Optionally, `python disasm/unslap.py` and `python disasm/pcb27256.py` write
   the two slapstic-free sets.
4. Run [`emu_src/esb_emu.exe`](#the-emulator) (included, Windows; it builds
   from source with Visual Studio 2022, `emu_src/build_emu.bat`).

The standalone patchers in [`tools/`](tools/) need nothing but Python and your
`esb.zip`:

```bash
python tools/esb_unslap.py esb.zip        # the no-slapstic set, for emulators
python tools/esb_pcb27256.py esb.zip      # the two EPROM images for a real board
```

## The emulator

`emu_src/esb_emu.exe` is the Empire Strikes Back board in software: the main
and sound 6809s, the vector generator run from its state PROM, the matrix
processor from its microcode PROMs, four POKEYs, the speech chip, the NOVRAM,
and a model of the slapstic. It plays the game in a window with sound, the
flight yoke on the mouse, arrow keys or a joystick. It contains no ROM data and
reads the images the tools above make from your own set.

It can run any of the three ROM sets, chosen by one line in
`emu_src/esb_emu.ini`:

```ini
[main]
rom_set=slapstic      ; slapstic | noslap | pcb27256
```

| `rom_set` | what runs | how `$8000-$9FFF` is paged | made by |
|---|---|---|---|
| `slapstic` (default) | the original ROMs | the slapstic chip, modelled as MAME has it | `disasm/gen_from_roms.py` |
| `noslap` | the patched ROMs | no chip: the program writes a page latch at `$43F0` (emulator only) | `disasm/unslap.py`, `tools/esb_unslap.py` |
| `pcb27256` | the suggested real-board ROMs: one 27256 for socket 1H/J, patched ROM 104 (untested on hardware) | no chip: the program writes two outputs of the board's own LED latch, wired to the 27256's A13/A14 | `disasm/pcb27256.py`, `tools/esb_pcb27256.py` |

`--set slapstic|noslap|pcb27256` on the command line overrides the ini for
one run. Run the self test (F2) on each to see it pass: VERISUM B735 on the
original, the value a real ESB board shows, and VERISUM 2915 on the 27256 set.

Controls: mouse, arrows or stick for the yoke; left button or Ctrl and right
button or Alt for the triggers; Space and Shift for the thumb buttons; 5 and 6
for coins; F2 for the self test; F8 toggles mouse capture; Esc quits. The ini
also holds the option switches (`[dips]`), mouse sensitivity, brightness, line
width and volumes. See [`emu_src/README.md`](emu_src/README.md).

`emu_src/tests/` runs each set through the attract mode, two 15-minute
scripted games and the self test, with no window. In those runs the patched
set's trace matched the original's, and no run showed a fault.

## What's in the repository

| where | what |
|-------|------|
| [`disasm/`](disasm/README.md) | the eight listings, two defines files, the shape preview page, and the Python tools that generate and verify all of it from a ROM set: the slapstic model, the tracer, the Star Wars matcher, the emitters, the independent verifier, and the two patchers |
| [`disasm/shapes_preview.html`](https://tcottrill.github.io/Empire-Strikes-Back-Full-Disassembly-and-Slapstic-Removal/disasm/shapes_preview.html) | one self-contained page drawn from the ROM: the character set, the pictures, the logo, the 35 3-D objects |
| [`disasm/_survey/esb_inputs.md`](disasm/_survey/esb_inputs.md) | the survey the work started from: the ROM set, its layout, what is shared with Star Wars |
| [`emu_src/`](emu_src/README.md) | **the emulator** (`esb_emu.exe`): the ROMs on two 6809 cores, the slapstic model, the Star Wars project's chip models and Windows host; and `tests/`, the same board without a window, with scenarios that run every ROM set and compare them |
| [`tools/`](tools/) | `esb_unslap.py` and `esb_pcb27256.py`: one-file versions of the two patchers, which work on a ROM zip and give byte for byte what the disassembly's tools give |
| [`docs/`](docs/) | [the slapstic](docs/SLAPSTIC.md), how the program uses it and the ROM sets without it; [the real-board conversion](docs/PCB_27256.md) (untested); [the hardware](docs/HARDWARE.md), what differs from the Star Wars board |

## No ROMs included — bring your own

Atari's ROM images are not distributed, in any form: not the set, not the
working images, not the patched ROMs. Every tool here makes what it needs from
your own MAME `esb` set. The chips are found by CRC32, not by file name, so a
MAME zip, a directory of zips or a directory of loose files all work, and the
patchers refuse any other ROM revision.

## The listings

| | |
|---|---|
| listings re-encoded from their text and compared with the ROMs | **135,168 bytes, 0 mismatches** (eight listings; two runs byte-identical) |
| instructions | **28,474**, of which **11,448** are matched instruction for instruction to Star Wars and carry its names and comments |
| data bytes | **69,574**, of which **8,759** carried over from Star Wars |
| routine headers, each with a description | **1,187 of 1,187** |
| hardware registers, RAM variables and equates in the two defines files, each with a description | **936**: upper case Atari's, lower case written here |
| the slapstic maze | **84** entries reaching **61** routines; the program uses 62 entries at 190 call sites |

There is no assembler round trip, because there is no source to assemble.
`disasm/verify.py` reads only the listing text, encodes each line again at the
address its label states, and compares with the ROM. The lines must cover each
ROM range exactly once. A carried upper-case name is a claim that the code
descends from that Star Wars routine, checked instruction by instruction; a
lower-case description is a reading of the code, and can be wrong. See
[`disasm/README.md`](disasm/README.md#where-the-names-come-from).

## The slapstic and the ROM sets

The slapstic 137412-101 sits on the kit's expansion board between the address
bus and two 16K ROMs. It decides which 8K page of them appears at
`$8000-$9FFF` from the addresses it sees. The program reaches its paged
routines through a 1,260-byte maze of jumps that is different on every page,
uses the chip's "bitwise" mode as a decoy twice, and uses its "alternate"
mode in four routines. All of it is in [`docs/SLAPSTIC.md`](docs/SLAPSTIC.md).

The emulator runs three ROM sets:

| set | ROMs | paged by | for |
|---|---|---|---|
| `slapstic` | the original set | the slapstic (a model of it) | the original |
| `noslap` | `unslap.py` / `tools/esb_unslap.py` | a page latch at `$43F0` | emulators |
| `pcb27256` | `pcb27256.py` / `tools/esb_pcb27256.py` | two outputs of the board's own output latch | a real board (untested) |

Both patchers change the same places: the 16 page-select stubs, the five page
selects the chip's two modes redirect, the self test's ROM check, and two
checksum pairs. Each then simulates the 676 calls the traced program makes into
the maze, on the original under the slapstic model and on the patched set, and
checks that they reach the same routine on the same page. In the emulator
tests:

- `noslap` agreed with the original set in all 515,790 trace records over the
  attract mode and two 15-minute games (registers, cycle count, a CRC of RAM,
  a hash of the instructions executed).
- `pcb27256` ran without faults in every scenario, from each power-on state of
  its two latch bits. Its stubs are 28 cycles longer, so its games play out a
  little differently.
- The self test reported no errors on both patched sets, and reported a
  flipped bit in the paged ROMs. It shows VERISUM B735 on the original set
  (the value a 1996 conversion guide gives for a real ESB board) and VERISUM
  2915 on the 27256 set.
- Everything the runs executed was an instruction in the listings.

These are emulator results; the slapstic model is MAME's and has not been
checked against a real chip here.

## Running it on a real Star Wars board (untested)

The usual conversion of a Star Wars board to ESB plugs Atari's daughterboard,
with its slapstic, into ROM socket 1H/J (or a hand-built copy with a PAL in
place of the slapstic). [`docs/PCB_27256.md`](docs/PCB_27256.md) replaces that
daughterboard:

- one 27256 in socket 1H/J holding all four pages, from `esb_pcb27256.py`;
- its A13 and A14 wired to the latch outputs that drive diagnostic LEDs 3 and
  2 (`$4682`, `$4683`), on the same latch as the ROM bank bit;
- the patched program ROM 136031-104 at 1M; everything else is the standard
  conversion.

It has been run in the emulator only. The latch's position and pin-out on the
board come from MAME's model and the board details from a 1996 conversion
guide, not from a checked schematic; the write-up says how to confirm them
before wiring. If you build it, please report how it went.

## Hardware, briefly

- **Main CPU:** 6809, as on Star Wars, but `W_BANK` switches `$6000-$7FFF` and
  `$A000-$FFFF` together: two 32K programs, each with its own vectors, calling
  each other through a table at `$6018`.
- **The window:** `$8000-$9FFF` is one of four 8K pages behind the slapstic.
  All code there runs with bank 0 selected.
- **Display, matrix processor, sound board:** Star Wars', with new vector ROM,
  mathbox PROMs and a 32K sound program (`$4000-$7FFF` speech,
  `$C000-$FFFF` program, music and effects).

See [`docs/HARDWARE.md`](docs/HARDWARE.md).

## Status

1. **Disassembly**: done ([`disasm/`](disasm/README.md)).
2. **ROM sets without the slapstic**: written, checked against the chip model
   and run in the emulator. The 27256 set is untested on hardware.
3. **Emulator**: done ([`emu_src/`](emu_src/README.md)), with tests that run
   every ROM set. Not judged by a player yet: how the yoke feels, the sound by
   ear. The slapstic model is MAME's, not checked against a real chip.

Unlike the Star Wars project, this one has no C port, and none is planned.

## Related projects

Disassemblies, C ports and emulators of other Atari vector games, by the same method:
[Star Wars](https://github.com/tcottrill/Star-Wars-Full-Disassembly-and-C-Port),
[Tempest](https://github.com/tcottrill/Tempest-Full-Disassembly-and-C-Port),
[Gravitar](https://github.com/tcottrill/Gravitar-Full-Disassembly-and-C-Port),
[Space Duel](https://github.com/tcottrill/Space-Duel-Full-Disassembly-and-C-Port),
[Asteroids](https://github.com/tcottrill/Asteroids-Full-Disassembly-and-C-Port),
[Asteroids Deluxe](https://github.com/tcottrill/Asteroids-Deluxe-Full-Disassembly-and-C-Port),
[Lunar Lander](https://github.com/tcottrill/Lunar-Lander-Full-Disassembly-and-C-Port),
[BattleZone](https://github.com/tcottrill/BattleZone-Full-Disassembly-and-C-Port)
and [Omega Race](https://github.com/tcottrill/Omega-Race-Full-Disassembly-and-C-Port).

## Credits

The Empire Strikes Back program is Atari Games', 1985; the game's credits
screen names Mike Hally, Greg Rivera, Norm Avellar and Rob Rowe. The names and
upper-case comments come from Atari's Star Wars source
([historicalsource/star-wars](https://github.com/historicalsource/star-wars)).
The slapstic state machine is MAME's (Aaron Giles and Frank Palazzolo). The
6809 core and hardware notes are from the [AAE emulator](https://github.com/tcottrill/AAE).
The board-level conversion details used in `docs/PCB_27256.md` are from Cliff
Koch's 1996 Star Wars to ESB conversion guide. Full credits are in
[`disasm/README.md`](disasm/README.md#credits).

## License

The disassembly, the tools and the emulator are released under the **GNU
General Public License, version 2 or later**, the same terms as MAME. The names
and comments recovered from Atari's Star Wars source remain Atari's. The Empire
Strikes Back and Star Wars are trademarks of their owner, and no ROM images are
included.
