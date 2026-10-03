# emu_src/cpu — the 6809 core

`cpu_m6809.cpp` and `cpu_m6809.h` are the MC6809 core of the
[AAE emulator](https://github.com/tcottrill/AAE) (Tim Cottrill, 2026), copied
unmodified, as vendored for the Star Wars project.

The other three files exist so the core compiles outside AAE:

| file | what |
|---|---|
| `deftypes.h` | AAE's integer types and memory-handler structs |
| `sys_log.h` | `LOG_INFO` and friends forwarded to `esb_cpu_log()`, which the board implements; the test runner treats any core message as a fault |
| `timer.h` | `timer_update()` as a no-op; the board keeps the timeline from the cycle count `step()` returns |

What the board relies on from the core:

- `step()` executes one instruction, or takes one pending interrupt, and
  returns its cycle count. Interrupts are taken only at the top of `step()`.
- `irq_line(true)` latches a request that the core clears when it takes the
  interrupt.
- `opbase_override` is called at every change of the program counter, with
  `pc_change_reason()` saying why, and `in_opcode_fetch()` says whether a bus
  read is an instruction fetch. The slapstic's view of the bus is built from
  these three (`board.cpp`).
- Documented opcodes only; cycle counts are the datasheet's, including the
  indexed-mode extras.
