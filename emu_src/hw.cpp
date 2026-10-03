/* hw.cpp - the Empire Strikes Back hardware without its 6809s (board.h): the
 * chips, the ports and latches, the link between the boards, RESET and
 * power-on.  board.cpp puts the two 6809 cores and the slapstic on it.
 *
 * It is the Star Wars board's model (that project's hw.cpp) with ESB's
 * differences: W.BANK switches $6000-$7FFF and $A000-$FFFF together;
 * $8000-$9FFF is one of four pages; the sound ROMs are 32K, at $4000 and
 * $C000, so the sound CPU's A15 is decoded for ROM; RESET puts the slapstic on
 * page 3, disarmed.  With the no-slapstic ROM set there is no chip, and an
 * access to $43F0+n selects page n (a read returns $B5).  With the 27256 set
 * (disasm/pcb27256.py) there is no chip either: the page is the D7 latches
 * $4683 (A14) and $4682 (A13), the outputs that drive LED 2 and LED 3.
 *
 * Hardware model.  Atari's names are from the Star Wars source
 * (disasm/esb_defines.asm).
 *
 * Time
 *  - Master clock 12.096 MHz.  Both 6809s run at master / 8 = 1.512 MHz; a CPU
 *    cycle is 8 ticks.  Cycle counts are the core's (datasheet values).
 *  - A bus access is taken to happen at the START of its instruction: every
 *    hardware read sees the state as of that cycle, every write acts at it.
 *  - The sound CPU is stepped after each main-CPU step until it has caught up,
 *    so it is never more than one instruction behind.
 *
 * Main CPU, address by address
 *  $0000-$2FFF  vector RAM (read and write)
 *  $3000-$3FFF  vector ROM
 *  $4300-$431F  IN0   D0 right coin, D1 left coin, D2 aux coin, D3 slam,
 *                     D4 self test, D6 right fire, D7 left fire; all active low
 *  $4320-$433F  IN1   D2 diagnostic step, D4 right thumb, D5 left thumb (active
 *                     low); D6 VGHALT (1 = halted); D7 M.BUSY (1 = running)
 *  $4340-$435F  option bank 1       $4360-$437F  option bank 2
 *  $4380-$439F  R.CHN: the A-to-D converter's last result
 *  $4400        read: byte from the sound board, and clears the sound flag;
 *               write: byte to the sound board, and sets the main flag
 *  $4401        D7 main flag (our byte not yet read), D6 sound flag (a byte waits)
 *  $4500-$45FF  X2212 NOVRAM, low nibble; the high nibble reads as ones
 *  $4600-$461F  VGGO      $4620-$463F  VGSTOP
 *  $4640-$465F  WTCHDG: the watchdog bites after 32 IRQ periods without a write
 *  $4660-$467F  IRCLR: clears the IRQ request
 *  $4680-$469F  eight D7 latches, address & 7: 0,1 coin counters, 2 LED 3,
 *               3 LED 2, 4 W.BANK (0 root, 1 overlay), 5 P.IRND (0 holds the
 *               random generator at zero, 1 runs it), 6 LED 1, 7 NVRRCL (the
 *               NOVRAM recalls on its rising edge)
 *               A read of these addresses returns $00 (nothing drives the bus;
 *               the program only does it inside ROR and CLR on W.BANK).
 *  $46A0-$46BF  NSTORE: NOVRAM store strobe
 *  $46C0-$46DF  W.CHNn, address & 3: start a conversion of channel n (0 pitch,
 *               1 yaw); the converter samples the input at this write
 *  $46E0-$46FF  W.RSTS: reset the sound 6809 and clear both flags
 *  $4700-$4707  write: 0 M.PCGO, 1-2 M.BIC, 4-5 divisor (5 starts), 6-7 dividend
 *               read: 0-1 quotient, 3 random byte
 *  $4800-$5FFF  RAM; $5000-$5FFF is also the matrix processor's
 *  $6000-$7FFF  ROM, bank 0 or 1          $A000-$FFFF  ROM, bank 0 or 1
 *  $8000-$9FFF  expansion ROM, page 0-3 (board.cpp)
 *  $43F0-$43F3  no-slapstic set only: any access selects page 0-3
 *  Anything else is unmapped: it reads $00, is counted, and fails the run.
 *
 *  - IRQ: requested every 6,144 cycles from power-on (246.09 Hz); the request
 *    stays until the 6809 takes it or IRCLR is written.  One request can wait;
 *    a second one arriving meanwhile is counted as lost.
 *  - RESET (power-on, watchdog bite, script): both CPUs, the bank latch, the
 *    matrix processor's counters, the 6532 and both flags.  RAM, the NOVRAM,
 *    the matrix registers, the vector generator and the timeline are kept (the
 *    vector generator is not on the RESET line; the program writes VGSTOP).
 *    Power-on also clears RAM and vector RAM to zero, sets the NOVRAM RAM side
 *    to ones, holds the random generator at zero and halts the vector
 *    generator.
 *
 * Sound CPU ($8000-$BFFF is unmapped)
 *  $0000-$07FF  write SOUT: byte to the main CPU, and sets the sound flag
 *  $0800-$0FFF  read SIN: byte from the main CPU, and clears the main flag
 *  $1000-$107F  6532 RAM            $1080-$109F  6532 registers
 *  $1800-$183F  four POKEYs, write only here; writes are recorded
 *  $2000-$27FF  RAM                 $4000-$7FFF and $C000-$FFFF  ROM
 *  6532 port A: D7 main flag, D6 sound flag (inputs); D5 speech power; D4 self
 *  test switch (1 = off); D3 FM; D2 TMS5220 not-ready; D1 /RS; D0 /WS.  A
 *  falling edge on /WS writes port B to the TMS5220; a falling edge on /RS
 *  latches its status for port B to read.  The 6532's /IRQ is the 6809's IRQ.
 *  The TMS5220 is clocked one sample every 189 cycles (8 kHz).
 */
#include <cstdarg>
#include <cstdio>
#include <cstring>
#include "board.h"
#include "tms5220.h"

esb_board ESB;

static esb_roms roms;
static uint8_t *main_mem = ESB.mem;     /* what the vector generator and the matrix processor work on */

static inline uint64_t ticks_now() { return ESB.cyc * 8; }

static void unmapped(int cpu, int write, unsigned a)
{
    uint32_t *n = write ? &ESB.n_unmapped_w[cpu] : &ESB.n_unmapped_r[cpu];
    if (*n < 8) {
        (write ? ESB.first_unmapped_w : ESB.first_unmapped_r)[cpu][*n] = (uint16_t)a;
        if (!write) ESB.first_unmapped_pc[cpu][*n] = (uint16_t)(ESB.pc_hook ? ESB.pc_hook(cpu) : 0);
    }
    (*n)++;
}

/* ------------------------------------------------------------------ */
/* sound board side of the link, the 6532 and the speech chip          */
/* ------------------------------------------------------------------ */

static uint8_t riot_in_a(void *)
{
    /* D7, D6: the flags; D4: self-test switch; D2: TMS5220 not ready */
    int readyq = tms5220_ready_read() ? 0 : 1;
    return (uint8_t)((riot_porta_in_get(&ESB.riot) & 0xc0) | (ESB.snd_test & 0x10) | (readyq << 2));
}

static void riot_out_a(void *, uint8_t data)
{
    uint8_t prev = ESB.riot_pa_prev;

    if ((prev & 0x01) && !(data & 0x01)) {              /* /WS falls: write */
        uint8_t v = riot_portb_out_get(&ESB.riot);
        tms5220_data_write(v);
        ESB.n_tms_w++;
        if (ESB.io_hook) ESB.io_hook(ESB_SOUND, 1, 0x5220, v);
    }
    if ((prev & 0x02) && !(data & 0x02)) {              /* /RS falls: latch status */
        ESB.tms_status = (uint8_t)tms5220_status_read();
        ESB.n_tms_r++;
    }
    ESB.riot_pa_prev = data;
}

static uint8_t riot_in_b(void *) { return ESB.tms_status; }

static void sound_reset_chips(void)
{
    riot_reset(&ESB.riot, ESB.snd_cyc);
    ESB.riot_pa_prev = 0;
    ESB.tms_status = 0;
    ESB.main_data = ESB.sound_data = 0;
}

/* ------------------------------------------------------------------ */
/* main CPU bus                                                         */
/* ------------------------------------------------------------------ */

uint8_t esb_hw_read(unsigned a)
{
    uint8_t v;

    if (ESB.set == ESB_SET_NOSLAP && a >= ESB_PAGE_LATCH && a < ESB_PAGE_LATCH + 4) {
        ESB.page = (int)(a - ESB_PAGE_LATCH);
        ESB.n_page_latch[ESB.page]++;
        v = ESB_PAGE_LATCH_READS;
    } else if (a >= 0x4300 && a < 0x43a0) {
        switch ((a >> 5) & 7) {
        case 0: v = ESB.in0; break;
        case 1:
            v = (uint8_t)(ESB.in1 & 0x3f);
            if (mb_busy(&ESB.mb, ticks_now())) v |= 0x80;
            if (avg_halted(&ESB.vg, ticks_now())) v |= 0x40;
            break;
        case 2: v = ESB.dsw0; break;
        case 3: v = ESB.dsw1; break;
        default: v = ESB.adc_latch; break;
        }
    } else if (a == 0x4400) {
        riot_porta_in_set(&ESB.riot, 0x00, 0x40);
        v = ESB.main_data;
    } else if (a == 0x4401) {
        v = (uint8_t)(riot_porta_in_get(&ESB.riot) & 0xc0);
    } else if (a >= 0x4500 && a < 0x4600) {
        v = x2212_read(&ESB.nv, (uint8_t)a);
    } else if (a == 0x4700) {
        v = mb_quotient_hi(&ESB.mb);
    } else if (a == 0x4701) {
        v = mb_quotient_lo(&ESB.mb);
    } else if (a == 0x4703) {
        v = mb_random(&ESB.mb, ticks_now());
    } else if (a >= 0x4680 && a < 0x46a0) {
        /* the D7 latches are write only.  The bank switch is "SEC / ROR W.BANK"
         * and "CLR W.BANK": read-modify-write instructions whose read finds
         * nothing driving the bus and whose result does not depend on it. */
        ESB.n_latch_reads++;
        return 0;
    } else {
        unmapped(ESB_MAIN, 0, a);
        return 0;
    }
    if (ESB.io_hook) ESB.io_hook(ESB_MAIN, 0, a, v);
    return v;
}

void esb_hw_write(unsigned a, uint8_t d)
{
    if (ESB.set == ESB_SET_NOSLAP && a >= ESB_PAGE_LATCH && a < ESB_PAGE_LATCH + 4) {
        ESB.page = (int)(a - ESB_PAGE_LATCH);
        ESB.n_page_latch[ESB.page]++;
    } else if (a == 0x4400) {
        if (riot_porta_in_get(&ESB.riot) & 0x80) ESB.n_cmd_overrun++;
        riot_porta_in_set(&ESB.riot, 0x80, 0x80);
        ESB.sound_data = d;
        ESB.n_main_cmds++;
    } else if (a >= 0x4500 && a < 0x4600) {
        x2212_write(&ESB.nv, (uint8_t)a, d);
    } else if (a >= 0x4600 && a < 0x4700) {
        switch ((a >> 5) & 7) {
        case 0:
            avg_run(&ESB.vg, ticks_now());
            if (ESB.vg_hook) ESB.vg_hook(1);
            avg_go(&ESB.vg, ticks_now());
            break;
        case 1:
            avg_run(&ESB.vg, ticks_now());
            if (ESB.vg_hook) ESB.vg_hook(0);
            avg_reset(&ESB.vg, ticks_now());
            break;
        case 2: {
            uint64_t gap = ESB.cyc - ESB.last_kick;
            if (gap > ESB.max_kick_gap) ESB.max_kick_gap = gap;
            ESB.last_kick = ESB.cyc;
            ESB.n_wd_kicks++;
            break;
        }
        case 3:
            if (ESB.irq_ack_hook) ESB.irq_ack_hook();
            ESB.irq_pending = 0;
            break;
        case 4:
            ESB.out_latch[a & 7] = d;
            switch (a & 7) {
            case 2: case 3:
                if (ESB.set == ESB_SET_PCB) {                /* the 27256's A13 / A14 */
                    ESB.page = ((ESB.out_latch[3] & 0x80) ? 2 : 0) | ((ESB.out_latch[2] & 0x80) ? 1 : 0);
                    ESB.n_page_latch[ESB.page]++;
                }
                break;
            case 4: ESB.bank = (d & 0x80) != 0; break;
            case 5: mb_random_ctl(&ESB.mb, d, ticks_now()); break;
            case 7: x2212_recall(&ESB.nv, d & 0x80); break;
            default: break;
            }
            break;
        case 5: x2212_store(&ESB.nv); break;
        case 6: ESB.adc_latch = ESB.adc_in[a & 3]; break;
        default:
            riot_porta_in_set(&ESB.riot, 0x00, 0xc0);
            ESB.snd_cyc = ESB.cyc;
            ESB.tms_next = ESB.snd_cyc + ESB_TMS_CYCLES;
            ESB.n_snd_resets++;
            if (ESB.cpu_reset_hook) ESB.cpu_reset_hook(ESB_SOUND);
            break;
        }
    } else if (a >= 0x4700 && a < 0x4708) {
        mb_write(&ESB.mb, (int)(a & 7), d, ticks_now());
    } else {
        unmapped(ESB_MAIN, 1, a);
        return;
    }
    if (ESB.io_hook) ESB.io_hook(ESB_MAIN, 1, a, d);
}

/* ------------------------------------------------------------------ */
/* sound CPU bus                                                        */
/* ------------------------------------------------------------------ */

uint8_t esb_snd_hw_read(unsigned a)
{
    uint8_t v;

    if (a >= 0x0800 && a < 0x1000) {
        riot_porta_in_set(&ESB.riot, 0x00, 0x80);
        v = ESB.sound_data;
    } else if (a >= 0x1080 && a < 0x10a0) {
        v = riot_read(&ESB.riot, (uint8_t)(a & 0x1f), ESB.snd_cyc);
    } else {
        unmapped(ESB_SOUND, 0, a);
        return 0;
    }
    if (ESB.io_hook) ESB.io_hook(ESB_SOUND, 0, a, v);
    return v;
}

void esb_snd_hw_write(unsigned a, uint8_t d)
{
    if (a < 0x0800) {
        riot_porta_in_set(&ESB.riot, 0x40, 0x40);
        ESB.main_data = d;
        ESB.n_snd_replies++;
    } else if (a >= 0x1080 && a < 0x10a0) {
        riot_write(&ESB.riot, (uint8_t)(a & 0x1f), d, ESB.snd_cyc);
    } else if (a >= 0x1800 && a < 0x1840) {
        /* four POKEYs, registers interleaved: A5 = register bit 3, A4-A3 = chip */
        int chip = (a >> 3) & 3, reg = (a & 7) | ((a >> 2) & 8);
        ESB.pokey[chip][reg] = d;
        ESB.n_pokey_w++;
        if (ESB.pokey_hook) ESB.pokey_hook(chip, reg, d);
    } else {
        unmapped(ESB_SOUND, 1, a);
        return;
    }
    if (ESB.io_hook) ESB.io_hook(ESB_SOUND, 1, a, d);
}

/* ------------------------------------------------------------------ */
/* machine                                                              */
/* ------------------------------------------------------------------ */

void esb_hw_init(const esb_roms *r)
{
    roms = *r;
    memset(&ESB, 0, sizeof ESB);
    memcpy(ESB.mem + 0x3000, r->main_rom + 0x3000, 0x1000);
    memcpy(ESB.mem + 0x6000, r->main_rom + 0x6000, 0x2000);
    memcpy(ESB.mem + 0xa000, r->main_rom + 0xa000, 0x6000);
    memcpy(ESB.mem1 + 0x6000, r->bank1 + 0x6000, 0x2000);
    memcpy(ESB.mem1 + 0xa000, r->bank1 + 0xa000, 0x6000);
    memcpy(ESB.slap, r->slapstic, 0x8000);
    memcpy(ESB.snd + 0x4000, r->sound_rom + 0x4000, 0x4000);
    memcpy(ESB.snd + 0xc000, r->sound_rom + 0xc000, 0x4000);
    ESB.set = r->set;

    ESB.in0 = 0xdf;                /* every switch open; D5 is not connected */
    ESB.in1 = 0x34;                /* diagnostic step and both thumbs open */
    ESB.dsw0 = 0xff;               /* 4 shields, moderate, Jedi letters by increment, attract sound, no freeze */
    ESB.dsw1 = 0xe2;               /* 1 coin 1 credit, no multipliers, no bonus coins */
    ESB.adc_in[0] = ESB.adc_in[1] = 0x80;
    ESB.snd_test = 0x10;
    ESB.wd_cycles = ESB_WD_CYCLES;

    x2212_init(&ESB.nv);
    riot_init(&ESB.riot);
    ESB.riot.in_a = riot_in_a;
    ESB.riot.out_a = riot_out_a;
    ESB.riot.in_b = riot_in_b;
    avg_init(&ESB.vg, r->avg_prom, main_mem);
    mb_init(&ESB.mb, r->mathbox_proms, main_mem + 0x5000);
}

void esb_bind_memory(uint8_t *mem)
{
    main_mem = mem;
    avg_init(&ESB.vg, roms.avg_prom, main_mem);
    mb_init(&ESB.mb, roms.mathbox_proms, main_mem + 0x5000);
}

void esb_machine_reset(int cause)
{
    ESB.n_reset[cause]++;
    ESB.bank = 0;
    slap_reset(&ESB.slapstic);
    ESB.page = 3;                  /* the chip's page at reset; the latch of the no-slapstic set likewise */
    memset(ESB.out_latch, 0, sizeof ESB.out_latch);
    if (ESB.set == ESB_SET_PCB) {
        /* the page is whatever the two latch bits hold: 0 if RESET clears the
         * latch.  A test can start from any other value to show it does not matter */
        ESB.out_latch[2] = (ESB.pcb_reset_page & 1) ? 0x80 : 0;
        ESB.out_latch[3] = (ESB.pcb_reset_page & 2) ? 0x80 : 0;
        ESB.page = ESB.pcb_reset_page & 3;
    }
    mb_reset(&ESB.mb);
    /* the vector generator is not on the RESET line ("GATE ARRAY ONLY LISTENS
     * TO STOP, NOT RESET LINE", at RESET in WSINT): the program stops it itself */
    ESB.irq_pending = 0;
    ESB.snd_cyc = ESB.cyc;
    ESB.tms_next = ESB.snd_cyc + ESB_TMS_CYCLES;
    sound_reset_chips();
    tms5220_reset();
    if (ESB.cpu_reset_hook) {
        ESB.cpu_reset_hook(ESB_MAIN);
        ESB.cpu_reset_hook(ESB_SOUND);
    }
    ESB.last_kick = ESB.cyc;
}

void esb_power_on(void)
{
    memset(ESB.mem, 0, 0x3000);
    memset(ESB.mem + 0x4800, 0, 0x1800);
    memset(ESB.snd, 0, 0x4000);
    memset(ESB.pokey, 0, sizeof ESB.pokey);
    x2212_power_on(&ESB.nv);
    ESB.cyc = ESB.snd_cyc = 0;
    ESB.next_irq = ESB_IRQ_CYCLES;
    ESB.adc_latch = ESB.adc_in[0];
    mb_random_ctl(&ESB.mb, 0, 0);
    avg_init(&ESB.vg, roms.avg_prom, main_mem);
    esb_machine_reset(ESB_RST_POWERON);
}

void esb_snd_chips_advance(void)
{
    while (ESB.snd_cyc >= ESB.tms_next) {
        short s;
        tms5220_process(&s, 1);
        if (ESB.tms_hook) ESB.tms_hook(s);
        ESB.tms_next += ESB_TMS_CYCLES;
    }
    riot_advance(&ESB.riot, ESB.snd_cyc);
}

int esb_snd_irq(void) { return riot_irq(&ESB.riot) != 0; }

uint64_t esb_ticks(void) { return ticks_now(); }
