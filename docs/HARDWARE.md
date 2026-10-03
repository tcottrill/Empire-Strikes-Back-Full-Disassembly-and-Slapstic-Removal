# The Empire Strikes Back — the hardware, as the listings assume it

ESB is a conversion kit for the Star Wars board: the same main and sound
boards, new ROMs and PROMs, and a small expansion board with two more ROMs
behind a slapstic. This page says what differs from Star Wars; for everything
else — clocks, the I/O map, the matrix processor, the vector generator, the
link between the boards — see the Star Wars project's `docs/HARDWARE.md`,
which this program's own code agrees with wherever the two programs share it.

Every statement below was read from the ROMs with the tools in `disasm/`, or is
the emulator drivers' (MAME, AAE) and is marked so.

## Main CPU memory map

| Address | |
|---|---|
| `$0000-$2FFF` | vector RAM; from `$2800` up, display lists copied from the program ROM |
| `$3000-$3FFF` | vector ROM (136031-111) |
| `$4300-$47FF` | inputs, sound latch, NOVRAM, output latches, matrix processor — as Star Wars |
| `$4800-$4FFF` | CPU RAM; direct page `$48`, stack from `$4FFF` down |
| `$5000-$5FFF` | math RAM |
| `$6000-$7FFF` | program ROM, bank 0 or 1 |
| `$8000-$9FFF` | one of four pages of the expansion ROMs, chosen by the slapstic |
| `$A000-$FFFF` | program ROM, bank 0 or 1 |

## Two banks, not one overlay

In Star Wars `W_BANK` D7 swaps 8K at `$6000`. In ESB the same bit swaps
`$6000-$7FFF` **and** `$A000-$FFFF`: each of the four 16K program ROMs
(136031-101, -102, -203, -104) holds its bank-0 half first and its bank-1 half
second, and each bank is a complete 32K program with its own 6809 vectors.
(That `$A000-$FFFF` is banked is the drivers' statement; the ROMs agree — the
two halves are different code and each carries vectors.)

Bank 0 holds the game; bank 1 holds the 3-D object point tables and draw
routines, object and math support, and data. Reset and all interrupts are
handled in bank 0: bank 1's vectors point at entries of its cross-bank table.

**Cross-bank calls.** Both banks have a table from `$6018`. A routine callable
from the other bank has, at the same address in both banks,

```
        bank that holds the routine          the other bank
$60xx:  SWI / SWI / SWI                      JSR  $600B
$60xx+3: JMP  routine                        SWI / SWI / SWI
```

and `$600B` flips `W_BANK` by rotating the carry into D7 (`ROR W_BANK`), calls
the address on the stack — the `JMP` three bytes after the caller's `JSR`, now
fetched from the other bank — flips the bank back and returns. The three `SWI`
bytes catch a call made in the wrong bank.

**Direct page.** The program runs with the direct page at `$48`, except the
object draw routines of bank 1, which set it to `$4E`, the buffer of projected
points, for the length of one object. The listings mark each change with
`.dpage`; the tracer follows the value along the code and fails if any
instruction is reached with two different values.

## The slapstic window

See [SLAPSTIC.md](SLAPSTIC.md). Code in the window always runs with bank 0
selected.

## Sound CPU

As Star Wars, but with twice the ROM: the two 16K sound ROMs (136031-113,
-112) appear with their first halves at `$4000` and `$6000` and their second
halves at `$C000` and `$E000`. Star Wars' 8K ROMs are mirrored there; ESB's
are not, so A15 reaches the ROMs. `$4000-$7CF6` is speech (41 phrases of
TMS5220 data behind a table of start and end addresses); the program, the
music and the sound effects are in the upper half.

## PROMs

The AVG state PROM is the Star Wars part (136021-109). The four matrix
processor microcode PROMs are new (136031-110, -109, -108, -107): 887 of the
1,024 microcode steps are the same as in Star Wars; the first difference is at
step 200. The microcode has not been disassembled here.

## Checksums

The self test sums each 16K program ROM (both halves, 16-bit words with
end-around carry, starting from the ROM's address) and the four slapstic
pages together, and expects `$FFFF`. Each ROM has a pair of spare bytes that
were set to make the sum come out — for example `$FFB3/$FFB4` in bank 0 and
`$9941/$9942` on page 0 — and with no errors the test shows those bytes XORed
together as a two-byte signature.
