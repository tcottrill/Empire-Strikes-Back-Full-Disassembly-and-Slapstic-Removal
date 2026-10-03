# The Empire Strikes Back (Atari, 1985) - annotated disassembly

Byte-exact, labelled and commented listings of every program ROM of The Empire
Strikes Back (MAME `esb`): the two banks of the main program, the four pages
behind the slapstic, the vector ROM and the sound program. The format follows
the [Star Wars disassembly](https://github.com/tcottrill/Star-Wars-Full-Disassembly-and-C-Port),
which ESB was written on top of and from which a good part of the names and
comments here come.

[`shapes_preview.html`](shapes_preview.html) draws what the listings describe:
the character set, the vector ROM pictures, the display lists the program
copies to vector RAM, the title logo, and the 35 3-D objects with the lines
their draw routines draw.

## Regenerate and verify

```
cd disasm
python gen_from_roms.py --check                  # ROMs from ../roms
python gen_from_roms.py ../roms/esb.zip --check  # or a zip / directory
```

Only a ROM set is needed. `gen_from_roms.py` finds the chips by CRC32 (a MAME
zip, a directory of zips or loose files all work), writes the working images to
`build/`, then runs:

1. `image.py` - the images
2. `slapstic.py` - resolves the maze; every entry must call one routine on one page
3. `trace.py` - separates code from data in both banks, the four pages and the
   sound program; fails if code is reached with two direct-page values, or if
   slapstic code is reached with bank 1 selected
4. `emit.py` - the eight listings
5. `emit_defines.py` - the two defines files
6. `verify.py` - must print `MISMATCHES : 0` for all eight listings
7. `emit_shapes.py` - `shapes_preview.html`
8. with `--check`: steps 3-7 again, and the output must be byte-identical

Any failing step prints `!!` and the exit status is 1.

Current result (`python stats.py`):

<!-- stats:begin -->
| listing | bytes | instructions | matched to Star Wars | data bytes | Star Wars data carried | routine headers | described |
|---|---|---|---|---|---|---|---|
| `esb_bank0_rom.asm` | 32,768 | 7,333 | 3,465 | 15,386 | 2,654 | 459 | 459 |
| `esb_bank1_rom.asm` | 32,768 | 8,518 | 3,936 | 14,572 | 1,466 | 256 | 256 |
| `esb_slapstic0_rom.asm` | 8,192 | 2,743 | 712 | 1,535 | 42 | 79 | 79 |
| `esb_slapstic1_rom.asm` | 8,192 | 3,115 | 583 | 789 | 20 | 90 | 90 |
| `esb_slapstic2_rom.asm` | 8,192 | 3,001 | 468 | 1,103 | 20 | 99 | 99 |
| `esb_slapstic3_rom.asm` | 8,192 | 2,732 | 1,358 | 1,732 | 218 | 77 | 77 |
| `esb_vector_rom.asm` | 4,096 | 0 | 0 | 4,096 | 1,888 | 0 | 0 |
| `esb_sound_rom.asm` | 32,768 | 1,032 | 926 | 30,361 | 2,451 | 127 | 127 |
| total | 135,168 | 28,474 | 11,448 | 69,574 | 8,759 | 1187 | 1187 |

- esb_defines.asm: 805 aliases, 0 without a description
- esb_sound_defines.asm: 131 aliases, 0 without a description
- notes: 30 files; in effect 1346 names, 873 routine descriptions, 3455 line comments, 262 RAM names
- maze: 84 entries, 61 routines
- trace main: 27442 instructions, 21 jump tables, 182 orphan runs, 18 notes
- trace sound: 1032 instructions, 2 jump tables, 2 orphan runs, 0 notes
<!-- stats:end -->

There is no assembler round trip: no source exists to assemble. `verify.py` is
the check on the listings. It reads only the text files, encodes every line
again at the address its label states, with the operand sizes an assembler
would choose, and compares with the ROM; the lines must cover each ROM range
exactly once.

## Files

| File | What |
|---|---|
| `esb_bank0_rom.asm` | main program, bank 0: `$6000-$7FFF`, `$A000-$FFFF` (labels `L`) - generated |
| `esb_bank1_rom.asm` | main program, bank 1, same addresses (labels `K`) - generated |
| `esb_slapstic0_rom.asm` .. `3` | the four pages of `$8000-$9FFF` (labels `P0_` .. `P3_`) - generated |
| `esb_vector_rom.asm` | vector ROM `$3000-$3FFF` - generated |
| `esb_sound_rom.asm` | sound program `$4000-$7FFF`, `$C000-$FFFF` on the sound CPU - generated |
| `esb_defines.asm`, `esb_sound_defines.asm` | memory map, hardware registers, RAM variables, constants - generated |
| `shapes_preview.html` | every vector object, drawn from the ROM - generated |
| `gen_from_roms.py` | driver (above) |
| `image.py` | ROM set to working images, by CRC32 |
| `slapstic.py` | the slapstic 137412-101 as a state machine, and the maze resolver |
| `trace.py` | code / data separation by recursive traversal |
| `emit.py`, `formats.py`, `drawcode.py`, `objects.py` | listing generator; the program's own table formats; the object draw routines read back as vectors; what each object is |
| `emit_defines.py` | defines generator |
| `verify.py` | independent read-back |
| `avg.py`, `emit_shapes.py` | AVG display-list decoder and the preview page |
| `hints.py`, `notes/*.json` | what cannot be derived: entry points and tables the tracer cannot see, and every name, description and comment written for this disassembly |
| `sw_carry.json` | the names, operand expressions and comments carried over from Star Wars - written by `swmatch.py` |
| `swmatch.py`, `swlist.py` | one-off: match ESB against the Star Wars listings (needs that project; not run by the driver) |
| `unslap.py` | writes a ROM set that needs no slapstic, paged through a latch at `$43F0` that an emulator provides (see `../docs/SLAPSTIC.md`) |
| `pcb27256.py` | writes the set for a real Star Wars board with no slapstic: the four pages in one 27256 paged by two outputs of the board's output latch (see `../docs/PCB_27256.md`) |
| `peek.py`, `stats.py` | working tools: look at the images through the trace; the numbers quoted here |
| `_survey/esb_inputs.md` | the survey: ROM set, layout, what is shared with Star Wars |

Inputs, not distributed here: a ROM set (`../roms/*.zip`, or the path given on
the command line).

## Where the names come from

**Star Wars.** ESB has no surviving source, but it was built on the Star Wars
program, whose source does survive. `swmatch.py` lines the two programs up
instruction by instruction - same mnemonic, addressing mode and index
postbyte, operand values free because everything moved - and where they agree
the ESB line takes the Star Wars line's label, operand expression and comment.
A call matches only a call to the same routine. An operand expression is used
only if, with this program's values for its symbols, it gives exactly the
bytes in the ROM; each symbol's value here is decided by the majority of the
matched instructions that use it. Data statements carry over where the bytes
are identical or are addresses that relocate consistently.

**Reading.** Everything else was read: each stretch of code by one reader, the
results reconciled afterwards so that a variable has one name. Those names
and texts are in `notes/`, one file per stretch, and are in lower case.

So in the listings and the defines:

- **UPPER CASE** names and comments are Atari's, from the Star Wars source.
  A carried comment describes the Star Wars line; where ESB changed what the
  code is for, the routine header has an `in ESB:` line saying so.
- **lower case** names, routine descriptions and comments were written for
  this disassembly, from the code.

A carried name is a claim that the code descends from that Star Wars routine,
checked instruction by instruction. A lower-case description is a reading, and
can be wrong; the readers were told to describe what the code does and not to
guess what it is for, and their open questions are kept in the notes files.

## Conventions (listings)

As the Star Wars disassembly, with these additions:

- Labels: every code and data line starts with its address label - `Lxxxx` in
  bank 0, the vector ROM and the sound program, `Kxxxx` in bank 1,
  `P0_xxxx` .. `P3_xxxx` in the slapstic pages. A listing may refer to labels
  of the other main-CPU listings. Code in the pages always runs with bank 0
  selected, so an `L` operand there is a bank 0 address.
- `JSR MZ_xxxx` is a call of a maze entry; the line's comment names the page
  and routine it calls. In the page listings each maze instruction is marked
  `live` (fetched on some path from an entry the program uses) or `decoy`.
- `JSR L60xx` to an entry of the cross-bank table calls a routine of the other
  bank; the entry's comment names it.
- `.dpage $xx` gives the direct page in force; it changes to `$4E` inside the
  object draw routines of bank 1. An address whose high byte is that page is
  direct, any other is extended; `<` and `>` force the short and the long form
  where the ROM holds the other, and `+` before an indexed offset forces the
  5-bit form for an offset of zero.
- Directives: `.org`, `.include`, `.dpage`, `.alias NAME $VALUE`, `.byte`,
  `.word` (big-endian). `( )` groups expressions; `~` is one's complement, `|`
  OR, `^` exclusive OR.
- Routine headers (a `;----` block): `; name - description`. `(no caller
  found)` means no call, jump or table known to the tracer reaches the code:
  it is reached through data the tracer does not follow, or it is dead, and
  the description says which where that is known. The ROMs hold a good deal of
  stale image from earlier builds; it is disassembled where it decodes, and
  its headers say that nothing reaches it.
- Data keeps the Star Wars statement layout where it was carried; the
  program's own tables (messages, object points, title logo outlines, speech
  phrases, display lists copied to vector RAM) are typed by `formats.py` with
  a comment per line saying what the line is.

## Conventions (defines)

Sections: `Memory map`, `Hardware registers`, the RAM regions, `Slapstic` (the
page-select stubs and the maze entries, each saying which routine it calls)
and `Constants`. Format `.alias NAME $VALUE ;description`. Every identifier
the listings use is defined and every alias has a description: upper case is
Atari's comment on the Star Wars definition, lower case was written for the
Star Wars disassembly or for this one, and `In ESB:` adds what a carried
variable holds here when that differs.

## The slapstic

`../docs/SLAPSTIC.md` describes the chip, the maze of jumps the program
reaches its paged routines through, the two other chip modes the program
uses, and `unslap.py`, which writes a ROM set that runs the pages from a
plain latch instead. `../docs/PCB_27256.md` describes `pcb27256.py`, which
puts the four pages in one 27256 for a real board.

## Credits

- **The Empire Strikes Back** program: Atari Games, 1985. The game's own
  credits screen names Mike Hally (product manager), Greg Rivera and Norm
  Avellar (programmers), Rob Rowe (technician), and thanks Brad Fuller, Jed
  Margolin, Dave Ralston, Doug Snyder and Earl Vickers.
- **Star Wars** source code: Atari, Inc., 1983, archive
  [historicalsource/star-wars](https://github.com/historicalsource/star-wars);
  the names and upper-case comments here are from it, by way of the
  [Star Wars disassembly](https://github.com/tcottrill/Star-Wars-Full-Disassembly-and-C-Port).
- Slapstic state machine: MAME (`slapstic.c`, Aaron Giles and Frank Palazzolo).
  Hardware notes: the Star Wars driver of the
  [AAE emulator](https://github.com/tcottrill/AAE).
- Listing format and tooling pattern: the Tempest and Star Wars disassembly
  projects.
