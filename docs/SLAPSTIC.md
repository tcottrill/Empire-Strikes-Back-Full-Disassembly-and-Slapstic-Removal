# The Empire Strikes Back — the slapstic, and how to do without it

ESB was sold as a conversion kit for Star Wars. The kit's new program is much
larger than the Star Wars board has ROM space for, and Atari did not want the
kit copied, so the extra ROM hangs behind a **slapstic** (137412-101): a
20-pin chip between the address bus and two 16K ROMs that decides, from the
addresses it has seen go by, which 8K page of them appears at `$8000-$9FFF`.

Everything here was measured on the ROMs with the tools in `disasm/`
(`slapstic.py`, `trace.py`, `unslap.py`). The state machine is MAME's
(`slapstic.c`, Aaron Giles and Frank Palazzolo); which bus cycles reach it is
the rule of the MAME and AAE drivers. None of it has been checked against a
real chip here.

## The chip

Offsets are the address with the top three bits dropped (`address & $1FFF`).

| mode | sequence | effect |
|---|---|---|
| arm | `$0000` | the chip is armed; nothing else happens until it is |
| simple | armed, then `$0080` / `$0090` / `$00A0` / `$00B0` | page 0 / 1 / 2 / 3 selected, chip disarmed; other addresses in between do not matter |
| alternate | armed, then `$1DFE`, then `$1B5C+n`, then any of the four page addresses | page *n* selected |
| bitwise | armed, then `$154x`, a page address, then `$1540-$1543` to clear or set bit 0 or bit 1 of the page number, `$1550-$1557`, a page address | the edited page selected |

Reset selects page 3 and leaves the chip disarmed.

What counts as "an address it has seen": the address a jump into the window
lands on, the address of the instruction a jump leaves the window from (except
the four page addresses), and every data read or write in the window.
Instruction fetches inside the window do not count.

## How the program uses it

**The stubs.** `$8000-$80FF` is the same on all four pages: sixty-four copies of

```
BITA $8000
RTS
```

`JSR $8090` therefore lands on a page address (page 1 selected, chip
disarmed), reads `$8000` (armed again) and returns. Only `$8080`, `$8090`,
`$80A0` and `$80B0` are ever called. The chip is armed whenever the program is
running normally, because every select re-arms it.

**The maze.** `$8100-$85EB` is 1,260 bytes of `JSR` and `JMP` that are
different on every page. Code outside the window never selects a page itself.
It calls an **entry** of the maze, and from whichever page happens to be
selected, the chain of jumps through the four pages' copies ends up

1. selecting the page the wanted routine is on,
2. calling the routine,
3. selecting the caller's page again, and returning.

For example entry `$8103`, called with page 1 selected: page 1 has `JSR $8100`
there; page 1's `$8100` is `JSR $8080` (page 0); the return address `$8103` is
now fetched from page 0, where it is `JMP $85EC` — the routine; its `RTS` goes
to `$8106` on page 0, `JMP $8090`, which puts page 1 back and returns to the
caller. Called with page 0 selected, the same entry is just `JMP $85EC`.

`slapstic.py` follows every address of the maze from all four pages: **84
addresses** behave as entries (one routine, the same from every page),
reaching **61 routines**. The traced program uses 62 of the entries, at 190
call sites, for 59 routines. Of the maze's 420 instructions per page, between
119 and 192 are ever fetched from that page; the rest are decoys. In the listings an
entry is `MZ_xxxx`, the line says which routine it calls, and each maze
instruction is marked `live` (on a path from an entry the program uses) or
`decoy`.

**Decoys by the bitwise mode.** On page 3, two calls are made like this:

```
P3_9875:  LDB  $9548        ; a read of $154x: the chip enters its bitwise mode
          ...
P3_987C:  JMP  $82F8        ; a maze entry that would go to page 1
```

In bitwise mode the entry's page select is taken as the start of a bit-twiddle
sequence instead of a select, the following read of `$8000` arms the chip
afresh, and the routine the maze then calls is page **3**'s — not page 1's,
which is what a reader of the maze, or a copy without the chip, would run.
The other one is `P3_98B1` / `P3_98B8` (`$9540`, entry `$8220`).

**The alternate mode.** Four routines on page 1 (`$8F16`, `$8F8B`, `$8FF7`,
`$9063`) begin

```
LDX  #$9B5C+n
JSR  $9DFE          ; LDA 0,X / ASLA / RTS, the same on every page
```

The jump to `$9DFE` and the read of `$9B5C+n` are the alternate sequence: the
next page address the chip sees selects page *n*, whatever page it names.
These routines are entered through maze entries whose return path — executed
on page 1 — says "select page 1"; it selects page *n* instead, which is the
page of the routine's one caller (page 3, 0, 1 and 2 for the four).

**The self test.** It arms the chip and selects each page with a data read
through a table of the four stub addresses, sums all four pages into one
checksum, and finally selects page 0 to read the two signature bytes at
`$9941`.

**The tail, and other leftovers.** `$9DCD-$9FFF` is identical on all pages. It
is the back part of a second copy of bank 0's IRQ handler, assembled to run at
`$9CA7`, with its own copies of the switch debounce, pot and rheostat
routines; the last of them is cut off by the end of the page. Nothing runs it:
the IRQ goes to bank 0, and no table or call on any page or in either bank
points into it. The one live thing in it is the helper at `$9DFE`, which sits
where 27 bytes of the copy were overwritten by `LDX #$9E02 / LDB / ABX /
LDA 0,X / ASLA / RTS` and a 16-byte table — so the alternate sequence's
address `$1DFE` is the return of something that looks like ordinary code.
`$952B-$9560`, also identical on all pages, is a dead remnant of a Star Wars
view routine that starts in the middle of an instruction; it is there to give
the bitwise addresses `$9540-$955F` something to be. Other stretches of the
pages are stale image as well (pages 2 and 3 are byte-identical over
`$9361-$9561`, live only on page 3; pages 0 and 2 carry old wave tables and
more of the IRQ copy from `$9C1A`). The listings disassemble such stretches
where they decode and say in the routine header that nothing reaches them.

**Bank.** All code in the window is reached with bank 0 selected (`W_BANK`
D7 = 0); the tracer fails the build if it ever finds otherwise.

## ROM sets without the slapstic

Nothing in the ROMs is encrypted, so "decrypting" them means changing the few
places that depend on the chip, so that something simpler can do its paging.
There are two such sets:

| set | made by | pages selected by | for |
|---|---|---|---|
| no-slapstic | `disasm/unslap.py`, or standalone `tools/esb_unslap.py` | a page latch at `$43F0-$43F3` | emulators |
| 27256 | `disasm/pcb27256.py`, or standalone `tools/esb_pcb27256.py` | two outputs of the Star Wars board's own output latch | a real board ([PCB_27256.md](PCB_27256.md)) |

Both change the same places, in the same way except for what a page select
does:

| | |
|---|---|
| the 16 stubs (4 per page) | each selects its page without the chip (below) |
| the 2 decoy calls | the first page select the maze entry executes on page 3 (P3 `$82F8`, `$8220`) is pointed at page 3's own stub, so the path keeps its length and page 3 stays, as the bitwise mode made it |
| the 3 selects after an alternate-sequence routine that name the wrong page | pointed at the stub of the page the chip gives: P1 `$829B` page 2, `$84F6` page 0, `$8580` page 3 (the fourth routine's caller is on page 1, which the select already names) |
| the self test | its ROM test selects each page without the chip |
| checksums | the spare bytes at `$9941/$9942` (pages) and `$FFB3/$FFB4` (ROM at 1M) are set so the self test's sums come out at `$FFFF` again |

Each tool then runs every maze call the traced program makes, from every page
it can be made from (676 cases), on the original ROMs under the slapstic model
and on the patched ROMs, and requires the same routine on the same page and the
same page left selected. Every patch is checked against the bytes it expects,
and the standalone tools check the input ROMs by CRC32.

### The no-slapstic set (`unslap.py`)

`python unslap.py` writes `disasm/build/noslap/`: the three ROMs that change
(136031-105.3u and -106.2u, the pages; 136031-104.1m, which holds the self
test), the emulator's images and a report. In place of the chip it needs

> a page latch: an access to `$43F0+n` selects page *n* of `$8000-$9FFF`, a
> read returns `$B5`; page 3 at reset

Each stub becomes `BITA $43F0+n / RTS`: the original's length, cycle count and
flags, so the program runs instruction for instruction and cycle for cycle as
it does with the chip. The self test's `TST [,U]` / `TST [,U++]` become `STA`,
its `LDA $8080` becomes `STA $43F0`, and its table holds the latch addresses.
27 patches, 39 bytes in the pages.

`--stub write` makes the other form, into `disasm/build/noslap_write/`: stubs
`STA $43F0+n / BITA $8000 / RTS` (running over the unused copy behind each
stub), so the latch only has to answer writes, at five more cycles per select.
`--latch` chooses another address.

In the emulator (`emu_src`, set `noslap`) the set runs with no slapstic model
and agrees with the original set, under the chip model, in every one of 515,790
trace records over the attract mode and two 15-minute games: same instructions,
same cycles, same registers, same RAM. Its self test reports no errors, and
reports the expansion ROM when a bit of a page is flipped.

It is **not** for a real board: nothing on the Star Wars board answers at
`$43F0`, and the slapstic's socket on the kit's daughterboard sees only A0-A12
of the address bus (according to Cliff Koch's 1996 conversion guide), so a
replacement there cannot decode it either.

### The 27256 set (`pcb27256.py`)

All four pages in one 27256 in socket 1H/J, its A13 and A14 driven by the
output latch's `$4682` and `$4683` (the outputs of LED 3 and LED 2; the same
latch holds `W_BANK`). Each stub becomes `PSHS Y / LDY #bits / STY $4682 /
PULS Y / BRA $80C0`, 28 cycles longer than the original; the self test stores
the page bits from its table with `STY $4682`. The board work, the checks and
what is not known are in [PCB_27256.md](PCB_27256.md).

**What none of this proves.** The slapstic model is MAME's, and the proof
rests on it being right about the original. The simulation covers the maze; it
rests on the tracer having found every call into it (calls through a table or a
computed jump into the maze would be missed; none were found, and the
emulator's runs executed nothing outside the listings). Neither set has been
run on hardware.

