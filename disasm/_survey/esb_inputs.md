# The Empire Strikes Back — survey of the inputs

What the disassembly started from, measured on 2026-10-02. Every number here is
printed by a tool in `disasm/` (`image.py`, `slapstic.py`, `trace.py`,
`swmatch.py`, `stats.py`); none is taken from memory.

## ROM set

MAME `esb`. Chips are found by CRC32 (`image.py`), not by file name.

| part | CRC32 | size | where |
|---|---|---|---|
| 136031-101.1f | EF1E3AE5 | 16K | `$6000`: bank 0 (first half), bank 1 (second half) |
| 136031-102.1jk | 62CE5C12 | 16K | `$A000`: bank 0, bank 1 |
| 136031-203.1kl | 27B0889B | 16K | `$C000`: bank 0, bank 1 |
| 136031-104.1m | FD5C725E | 16K | `$E000`: bank 0, bank 1 |
| 136031-105.3u | EA9E4DCE | 16K | slapstic pages 0 and 1 of `$8000` |
| 136031-106.2u | 76D07F59 | 16K | slapstic pages 2 and 3 of `$8000` |
| 136031-111.1l | B1F9BD12 | 4K | vector ROM `$3000` |
| 136031-113.1jk | 24AE3815 | 16K | sound `$4000` (first half), `$C000` (second half) |
| 136031-112.1h | CA72D341 | 16K | sound `$6000`, `$E000` |
| 136031-110.7h, -109.7j, -108.7k, -107.7l | B8D0F69D, 6A2A4D98, 6A76138F, AFBF6E01 | 1K × 4 bits | matrix processor microcode |
| 136021-109.4b | 82FC3EB2 | 256 × 4 bits | AVG state PROM, the Star Wars part |

There is no Atari source for ESB. The Star Wars source
([historicalsource/star-wars](https://github.com/historicalsource/star-wars))
is what ESB was written on top of, and the
[Star Wars disassembly](https://github.com/tcottrill/Star-Wars-Full-Disassembly-and-C-Port)
made from it is where the names here come from.

## Layout

| space | range | bytes | what |
|---|---|---|---|
| bank 0 | `$6000-$7FFF`, `$A000-$FFFF` | 32,768 | the game; 2,839 bytes of `$FF` fill |
| bank 1 | `$6000-$7FFF`, `$A000-$FFFF` | 32,768 | 3-D objects and their draw routines, support code, title logo, bookkeeping; 8,206 bytes of fill |
| slapstic pages 0-3 | `$8000-$9FFF` | 4 × 8,192 | one object type each, more or less: AT-AT walkers and tow cable; AT-ST walkers, enemy shots, Jedi letters, indicators; probots and asteroids; TIE fighters, lasers, transmissions |
| vector ROM | `$3000-$3FFF` | 4,096 | display-list subroutines; 152 bytes of fill |
| sound | `$4000-$7FFF`, `$C000-$FFFF` | 32,768 | speech in the lower half, program, music and effects in the upper; 2,264 bytes of fill |

The two banks are complete programs with their own vectors: `$6000-$7FFF` and
`$A000-$FFFF` switch together, and the banks have 608 + 842 + 36 + 906 bytes in
common at the same addresses out of 32,768. `$8000-$80FF` and `$9DCD-$9FFF`
are identical on all four slapstic pages; see `docs/SLAPSTIC.md`.

## What is shared with Star Wars

Counted by `swmatch.py`: two instructions match when mnemonic, addressing mode
and index postbyte agree, in runs found from five-instruction seeds, with a
call matching only a call to the same routine.

| | instructions | matched to a Star Wars line |
|---|---|---|
| bank 0 | 7,333 | 3,465 |
| bank 1 | 8,507 | 3,930 |
| page 0 | 2,743 | 712 |
| page 1 | 3,115 | 583 |
| page 2 | 3,001 | 468 |
| page 3 | 2,732 | 1,358 |
| sound | 1,032 | 926 |

Bank 1's count is inflated by the object draw routines, about 5,000
instructions of one repeated pattern, which Star Wars uses for its ground
objects and ESB for every object. The maze (`$8000-$85EB` of each page, 548
instructions) is in the page counts and matches nothing.

Data: 8,759 bytes of Star Wars data statements carry over unchanged or with
only their addresses relocated — 1,888 of the vector ROM's 4,096 (the
character set and test patterns), 2,654 in bank 0, 1,466 in bank 1, 2,451 in
the sound ROM.

## What the tracer found

27,431 main-CPU instructions and 1,032 sound-CPU instructions, from the 6809
vectors, the cross-bank table, the maze, 23 jump tables, the code-pointer
tables carried from Star Wars, and the entry points listed in `hints.py`. 184
runs of code have no caller the tracer can see: handlers reached through
tables in data, library routines nothing uses, and stale image left in the
ROMs from earlier builds. Eighteen computed jumps are not resolved (the
cross-bank call itself, the self test's `JMP ,S` returns, a few dispatches
through tables in data, and five in threaded draw primitives that nothing
runs); `trace.py` lists them.

No instruction is reached with two different direct-page values, and no code
in the slapstic window is reached with bank 1 selected. The build fails if
either stops being true.

## Hardware, as the code and the emulator drivers give it

As Star Wars (see that project's survey and `docs/HARDWARE.md`), with the
differences in this project's `docs/HARDWARE.md`: two full banks, the slapstic
window, a 32K sound program, new matrix processor microcode.
