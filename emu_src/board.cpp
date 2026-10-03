/* board.cpp - the Empire Strikes Back machine: the two 6809 cores
 * (cpu/cpu_m6809.cpp) on the hardware of hw.cpp, one timeline.
 *
 * The hardware model is the header of hw.cpp.  What is here is the 6809s'
 * side of it:
 *  - each CPU's memory map: RAM and ROM here, everything else in hw.cpp;
 *  - the main CPU's ROM: W.BANK D7 switches $6000-$7FFF and $A000-$FFFF
 *    together; $8000-$9FFF is the selected page of the expansion ROMs;
 *  - what the slapstic sees (original set): the address a jump into
 *    $8000-$9FFF lands on, the address of the instruction a jump leaves that
 *    window from (except the four page addresses), and every data read or
 *    write in the window.  Instruction fetches inside the window are not shown
 *    to it.  Taking an interrupt is not a jump for this purpose, and a return
 *    from one does not count as a jump into the window.  This is the rule of
 *    the MAME and AAE drivers; the 6809 core reports each change of PC and
 *    whether a bus read is a fetch.
 *  - a bus access is taken to happen at the START of its instruction;
 *  - the sound CPU is stepped after each main-CPU step until it has caught up,
 *    so it is never more than one instruction behind;
 *  - the IRQ is requested every 6,144 cycles; the request stays until the 6809
 *    takes it or IRCLR is written.
 */
#include <cstdarg>
#include <cstdio>
#include <cstring>
#include "cpu/cpu_m6809.h"
#include "board.h"

static cpu_m6809 *cpu0, *cpu1;

extern "C" void esb_cpu_log(const char *fmt, ...)
{
    if (ESB.n_cpu_log < 4) {
        va_list ap;
        va_start(ap, fmt);
        vsnprintf(ESB.first_log[ESB.n_cpu_log], sizeof ESB.first_log[0], fmt, ap);
        va_end(ap);
    }
    ESB.n_cpu_log++;
}

/* ------------------------------------------------------------------ */
/* the two memory maps                                                  */
/* ------------------------------------------------------------------ */

static UINT8 main_read(UINT32 a, struct MemoryReadByte *)
{
    if (a < 0x4000) {                                       /* vector RAM, vector ROM */
        if (ESB.mem_hook && a < 0x3000) ESB.mem_hook(a, 0);
        return ESB.mem[a];
    }
    if (a >= 0xa000) return ESB.bank ? ESB.mem1[a] : ESB.mem[a];
    if (a >= 0x8000) {
        uint8_t v = ESB.slap[(unsigned)ESB.page * 0x2000u + (a - 0x8000)];
        if (!cpu0->in_opcode_fetch()) {
            ESB.n_window_data++;
            if (ESB.set == ESB_SET_SLAPSTIC) ESB.page = slap_tweak(&ESB.slapstic, a);
        }
        return v;
    }
    if (a >= 0x6000) return ESB.bank ? ESB.mem1[a] : ESB.mem[a];
    if (a >= 0x4800) {
        if (ESB.mem_hook) ESB.mem_hook(a, 0);
        return ESB.mem[a];
    }
    return esb_hw_read(a);
}

static void main_write(UINT32 a, UINT8 d, struct MemoryWriteByte *)
{
    if (a < 0x3000 || (a >= 0x4800 && a < 0x6000)) {
        if (ESB.mem_hook) ESB.mem_hook(a, 1);
        ESB.mem[a] = d;
        return;
    }
    if (a >= 0x8000 && a < 0xa000) {                        /* a write into the window: the chip sees it */
        ESB.n_window_data++;
        if (ESB.set == ESB_SET_SLAPSTIC) ESB.page = slap_tweak(&ESB.slapstic, a);
        return;
    }
    esb_hw_write(a, d);
}

/* Every change of the main CPU's PC (the core calls this with the new PC). */
static int main_pc_change(int address)
{
    if (ESB.set != ESB_SET_SLAPSTIC) return address;
    cpu_m6809::PcChangeReason why = cpu0->pc_change_reason();
    if (why == cpu_m6809::PcChangeReason::Interrupt || why == cpu_m6809::PcChangeReason::Reset) return address;
    unsigned prev = cpu0->GetPPC();
    if (why != cpu_m6809::PcChangeReason::Rti && ((unsigned)address & 0xe000) == 0x8000) {
        ESB.page = slap_tweak(&ESB.slapstic, (unsigned)address);        /* a jump into the window */
    } else if ((prev & 0xe000) == 0x8000) {
        if (prev != 0x8080 && prev != 0x8090 && prev != 0x80a0 && prev != 0x80b0)
            ESB.page = slap_tweak(&ESB.slapstic, prev);                  /* a jump out of it */
    }
    return address;
}

static UINT8 snd_read(UINT32 a, struct MemoryReadByte *)
{
    if (a >= 0xc000 || (a >= 0x4000 && a < 0x8000)) return ESB.snd[a];
    if ((a >= 0x2000 && a < 0x2800) || (a >= 0x1000 && a < 0x1080)) {
        if (ESB.snd_mem_hook) ESB.snd_mem_hook(a, 0);
        return ESB.snd[a];
    }
    return esb_snd_hw_read(a);
}

static void snd_write(UINT32 a, UINT8 d, struct MemoryWriteByte *)
{
    if ((a >= 0x2000 && a < 0x2800) || (a >= 0x1000 && a < 0x1080)) {
        if (ESB.snd_mem_hook) ESB.snd_mem_hook(a, 1);
        ESB.snd[a] = d;
        return;
    }
    esb_snd_hw_write(a, d);
}

static MemoryReadByte main_r[] = { { 0x0000, 0xffff, main_read, nullptr }, { 0xffffffff, 0, nullptr, nullptr } };
static MemoryWriteByte main_w[] = { { 0x0000, 0xffff, main_write, nullptr }, { 0xffffffff, 0, nullptr, nullptr } };
static MemoryReadByte snd_r[] = { { 0x0000, 0xffff, snd_read, nullptr }, { 0xffffffff, 0, nullptr, nullptr } };
static MemoryWriteByte snd_w[] = { { 0x0000, 0xffff, snd_write, nullptr }, { 0xffffffff, 0, nullptr, nullptr } };

/* ------------------------------------------------------------------ */
/* machine                                                              */
/* ------------------------------------------------------------------ */

static void cpu_reset(int cpu)
{
    if (cpu == ESB_MAIN) {
        cpu0->reset();
        cpu0->irq_line(false);
    } else {
        cpu1->reset();
    }
}
static void irq_ack(void) { cpu0->irq_line(false); }
static unsigned last_pc(int cpu) { return cpu ? cpu1->GetPPC() : cpu0->GetPPC(); }

void esb_init(const esb_roms *r)
{
    static uint8_t dummy[0x10000];

    esb_hw_init(r);
    cpu0 = new cpu_m6809(dummy, main_r, main_w, 0);
    cpu1 = new cpu_m6809(dummy, snd_r, snd_w, 1);
    cpu0->mame_memory_handling(true);
    cpu1->mame_memory_handling(true);
    cpu0->opbase_override = main_pc_change;
    ESB.cpu_reset_hook = cpu_reset;
    ESB.irq_ack_hook = irq_ack;
    ESB.pc_hook = last_pc;
}

static void sound_catch_up(void)
{
    while (ESB.snd_cyc < ESB.cyc) {
        esb_snd_chips_advance();
        cpu1->irq_line(riot_irq(&ESB.riot) != 0);
        if (ESB.snd_step_hook)
            ESB.snd_step_hook(riot_irq(&ESB.riot) != 0 && !(cpu1->GetCC() & cpu_m6809::CC_I));
        unsigned pc = cpu1->GetPC();
        ESB.pc_hit[ESB_SOUND][pc >> 3] |= (uint8_t)(1u << (pc & 7));
        ESB.snd_cyc += (uint64_t)cpu1->step();
        ESB.n_steps[ESB_SOUND]++;
    }
}

/* Everything that is due before the main CPU's next step: the watchdog, the
 * periodic interrupt, the vector generator.  Returns 1 if that step will be
 * the 6809 taking the interrupt and not the instruction at PC. */
int esb_begin_step(void)
{
    if (ESB.cyc - ESB.last_kick > ESB.wd_cycles) {
        ESB.n_wd_bites++;
        ESB.wd_bite_pc = (uint16_t)cpu0->GetPC();
        esb_machine_reset(ESB_RST_WATCHDOG);
    }
    while (ESB.cyc >= ESB.next_irq) {
        if (ESB.irq_pending) {
            if (ESB.n_irq_lost < 8) ESB.first_lost_pc[ESB.n_irq_lost] = (uint16_t)cpu0->GetPC();
            ESB.n_irq_lost++;
        }
        cpu0->irq_line(true);
        ESB.irq_pending = 1;
        ESB.n_irq++;
        ESB.next_irq += ESB_IRQ_CYCLES;
    }
    avg_run(&ESB.vg, esb_ticks());
    return ESB.irq_pending && !(cpu0->GetCC() & cpu_m6809::CC_I);
}

int esb_exec_step(void)
{
    int c, irq = ESB.irq_pending && !(cpu0->GetCC() & cpu_m6809::CC_I);
    unsigned pc = cpu0->GetPC();

    if (irq) {
        ESB.irq_pending = 0;               /* the core lowers the request as it takes it */
        ESB.n_irq_taken++;
    } else {
        ESB.pc_hit[ESB_MAIN][pc >> 3] |= (uint8_t)(1u << (pc & 7));
    }
    c = cpu0->step();
    ESB.cyc += (uint64_t)c;
    ESB.n_steps[ESB_MAIN]++;
    sound_catch_up();
    return c;
}

int esb_step(void)
{
    esb_begin_step();
    return esb_exec_step();
}

unsigned esb_pc(int cpu) { return cpu ? cpu1->GetPC() : cpu0->GetPC(); }

void esb_regs(int cpu, uint16_t out[8])
{
    cpu_m6809 *c = cpu ? cpu1 : cpu0;
    out[0] = c->GetPC(); out[1] = c->GetS(); out[2] = c->GetU(); out[3] = c->GetX();
    out[4] = c->GetY();  out[5] = c->GetD(); out[6] = c->GetDP(); out[7] = c->GetCC();
}

