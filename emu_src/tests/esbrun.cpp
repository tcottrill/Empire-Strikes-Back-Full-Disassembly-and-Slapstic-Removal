/* esbrun.cpp - run the Empire Strikes Back machine without a window, and
 * compare two runs.
 *
 *   esbrun --set slapstic|noslap|pcb27256 [--romdir DIR] [--cycles N]
 *          [--script FILE] [--trace FILE] [--dsw0 X] [--dsw1 X] [--quiet]
 *          [--expect-hang] [--selftest-ok] [--coverage FILE] [--reset-page N]
 *
 * --reset-page (pcb27256 only) starts the two page bits of the output latch at
 * page N after every RESET instead of cleared, as a latch whose /CLR is not on
 * RESET might.
 *   esbrun --compare A.trc B.trc
 *
 * A run powers the machine on, runs it for N CPU cycles (default 30 s of
 * machine time) under a script of switch and yoke changes, and prints what
 * happened: resets, watchdog bites, unmapped accesses, traps, the game phases
 * it went through, how often each page of $8000-$9FFF was selected.  Exit
 * status 1 if anything went wrong.
 *
 * --trace writes one record at every interrupt entry: the cycle count, the
 * 6809's registers, the bank and page, a CRC of all RAM, and a running hash of
 * every instruction address executed since power-on.  Two runs that agree in
 * every record executed the same instructions at the same cycles with the same
 * RAM.  --compare says whether two traces agree and, if not, where they part.
 *
 * --coverage adds to FILE (made if it is not there) one bit for every address
 * an instruction was executed at, kept apart for bank 0, bank 1, the four
 * pages and the sound CPU: seven maps of 8K bytes.  tests/coverage.py holds
 * the maps against the disassembly's own list of instructions.
 *
 * Script lines (tests/scenarios): "<pass> <name> <value>", applied when the
 * mainline starts game frame <pass>, or "t<ms> <name> <value>", applied at
 * that many milliseconds of machine time (the self test has no game frames;
 * a script uses one kind or the other).  Names: in0 in1 dsw0 dsw1 pitch yaw
 * (bytes); coinr coinl coinaux slam test firer firel diag thumbr thumbl
 * sndtest (1 = pressed); reset; end.
 */
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <string>
#include <vector>
#include "../board.h"

#define CPU_HZ      1512000.0
#define PHASE       0x4848u
#define PASS_PC     0x6226u             /* the mainline starting a game frame (bank 0) */
#define STACK_TOP   0x4FFFu
#define HANG_PC     0xF392u             /* where SWI, NMI, FIRQ and the SWI traps end up (bank 0) */

static std::vector<uint8_t> rom_main, rom_bank1, rom_slap, rom_snd, rom_mb, rom_avg;

static int load(const std::string &dir, const char *name, std::vector<uint8_t> &v, size_t want)
{
    std::string path = dir + "\\" + name;
    FILE *f = fopen(path.c_str(), "rb");
    if (!f) { fprintf(stderr, "!! cannot open %s\n", path.c_str()); return 1; }
    v.resize(want);
    size_t n = fread(v.data(), 1, want, f);
    fclose(f);
    if (n != want) { fprintf(stderr, "!! %s is %u bytes, expected %u\n", path.c_str(), (unsigned)n, (unsigned)want); return 1; }
    return 0;
}

/* ---------------------------------------------------------------- script */
enum { SC_BYTE, SC_BIT_LOW, SC_RESET, SC_END };
struct script_line { unsigned pass; int kind; uint8_t *port; uint8_t mask, val; };
static std::vector<script_line> script, tscript;        /* by game frame, by millisecond */
static size_t script_pos, tscript_pos;
static int script_ended, reset_request;

static int load_script(const char *path)
{
    static const struct { const char *name; int kind; uint8_t *port; uint8_t mask; } ports[] = {
        { "in0", SC_BYTE, &ESB.in0, 0 },       { "in1", SC_BYTE, &ESB.in1, 0 },
        { "dsw0", SC_BYTE, &ESB.dsw0, 0 },     { "dsw1", SC_BYTE, &ESB.dsw1, 0 },
        { "pitch", SC_BYTE, &ESB.adc_in[0], 0 }, { "yaw", SC_BYTE, &ESB.adc_in[1], 0 },
        { "coinr", SC_BIT_LOW, &ESB.in0, 0x01 }, { "coinl", SC_BIT_LOW, &ESB.in0, 0x02 },
        { "coinaux", SC_BIT_LOW, &ESB.in0, 0x04 }, { "slam", SC_BIT_LOW, &ESB.in0, 0x08 },
        { "test", SC_BIT_LOW, &ESB.in0, 0x10 },
        { "firer", SC_BIT_LOW, &ESB.in0, 0x40 }, { "firel", SC_BIT_LOW, &ESB.in0, 0x80 },
        { "diag", SC_BIT_LOW, &ESB.in1, 0x04 },
        { "thumbr", SC_BIT_LOW, &ESB.in1, 0x10 }, { "thumbl", SC_BIT_LOW, &ESB.in1, 0x20 },
        { "sndtest", SC_BIT_LOW, &ESB.snd_test, 0x10 },
        { "reset", SC_RESET, nullptr, 0 },    { "end", SC_END, nullptr, 0 },
    };
    char line[256], port[32];
    FILE *f = fopen(path, "r");
    if (!f) { fprintf(stderr, "!! cannot open script %s\n", path); return 1; }
    while (fgets(line, sizeof line, f)) {
        unsigned pass;
        int a = 0;
        char *h = strchr(line, '#');
        if (h) *h = 0;
        char *p0 = line;
        while (*p0 == ' ' || *p0 == '\t') p0++;
        int timed = *p0 == 't';
        int nf = sscanf(p0 + timed, "%u %31s %i", &pass, port, &a);
        if (nf < 2) continue;
        int found = 0;
        for (const auto &p : ports)
            if (!strcmp(port, p.name)) {
                (timed ? tscript : script).push_back({ pass, p.kind, p.port, p.mask, (uint8_t)a });
                found = 1;
            }
        if (!found) { fprintf(stderr, "!! bad script line: %s\n", line); fclose(f); return 1; }
    }
    fclose(f);
    return 0;
}

static void apply_line(const script_line &s);

static void apply_script(unsigned pass)
{
    while (script_pos < script.size() && script[script_pos].pass <= pass) apply_line(script[script_pos++]);
}

static void apply_timed(uint64_t cyc)
{
    while (tscript_pos < tscript.size() && (uint64_t)tscript[tscript_pos].pass * 1512u <= cyc)
        apply_line(tscript[tscript_pos++]);
}

static void apply_line(const script_line &s)
{
    {
        switch (s.kind) {
        case SC_BYTE:    *s.port = s.val; break;
        case SC_BIT_LOW: *s.port = (uint8_t)(s.val ? (*s.port & ~s.mask) : (*s.port | s.mask)); break;
        case SC_RESET:   reset_request = 1; break;
        default:         script_ended = 1; break;
        }
    }
}

/* ---------------------------------------------------------------- trace */
#pragma pack(push, 1)
struct trace_rec {
    uint64_t cyc;
    uint32_t pass, pchash, ramcrc;
    uint16_t pc, s, u, x, y, d;
    uint8_t  dp, cc, bank, page, phase, pad[3];
};
#pragma pack(pop)

static uint32_t crc_table[256];
static void crc_init(void)
{
    for (uint32_t i = 0; i < 256; i++) {
        uint32_t c = i;
        for (int k = 0; k < 8; k++) c = (c & 1) ? 0xEDB88320u ^ (c >> 1) : c >> 1;
        crc_table[i] = c;
    }
}
static uint32_t crc_add(uint32_t c, const uint8_t *p, size_t n)
{
    while (n--) c = crc_table[(c ^ *p++) & 0xff] ^ (c >> 8);
    return c;
}

static int compare(const char *pa, const char *pb)
{
    FILE *a = fopen(pa, "rb"), *b = fopen(pb, "rb");
    if (!a || !b) { fprintf(stderr, "!! cannot open the traces\n"); return 1; }
    trace_rec ra, rb;
    unsigned long n = 0;
    for (;;) {
        size_t na = fread(&ra, sizeof ra, 1, a), nb = fread(&rb, sizeof rb, 1, b);
        if (!na && !nb) break;
        if (na != nb) {
            printf("  the traces have different lengths: one ends after %lu records\n", n);
            fclose(a); fclose(b);
            return 1;
        }
        if (memcmp(&ra, &rb, sizeof ra)) {
            printf("  the runs part at record %lu (interrupt %lu):\n", n, n);
            printf("    A: cycle %llu pass %u PC $%04X S $%04X D $%04X X $%04X Y $%04X U $%04X DP $%02X CC $%02X bank %u page %u phase $%02X ram %08X pcs %08X\n",
                   (unsigned long long)ra.cyc, ra.pass, ra.pc, ra.s, ra.d, ra.x, ra.y, ra.u, ra.dp, ra.cc, ra.bank, ra.page, ra.phase, ra.ramcrc, ra.pchash);
            printf("    B: cycle %llu pass %u PC $%04X S $%04X D $%04X X $%04X Y $%04X U $%04X DP $%02X CC $%02X bank %u page %u phase $%02X ram %08X pcs %08X\n",
                   (unsigned long long)rb.cyc, rb.pass, rb.pc, rb.s, rb.d, rb.x, rb.y, rb.u, rb.dp, rb.cc, rb.bank, rb.page, rb.phase, rb.ramcrc, rb.pchash);
            fclose(a); fclose(b);
            return 1;
        }
        n++;
    }
    fclose(a); fclose(b);
    printf("  the two runs agree in all %lu records: same instructions, same cycles, same registers, same RAM\n", n);
    return 0;
}

/* ---------------------------------------------------------------- main */
int main(int argc, char **argv)
{
    std::string romdir = "..\\..\\disasm\\build", set = "slapstic";
    const char *script_path = nullptr, *trace_path = nullptr, *cov_path = nullptr;
    static uint8_t cov[7][0x2000];
    uint64_t cycles = (uint64_t)(30 * CPU_HZ);
    int dsw0 = -1, dsw1 = -1, quiet = 0, expect_hang = 0, selftest_ok = 0, reset_page = 0;

    for (int i = 1; i < argc; i++) {
        std::string a = argv[i];
        if (a == "--compare" && i + 2 < argc) return compare(argv[i + 1], argv[i + 2]);
        else if (a == "--set" && i + 1 < argc) set = argv[++i];
        else if (a == "--romdir" && i + 1 < argc) romdir = argv[++i];
        else if (a == "--cycles" && i + 1 < argc) cycles = strtoull(argv[++i], nullptr, 0);
        else if (a == "--seconds" && i + 1 < argc) cycles = (uint64_t)(atof(argv[++i]) * CPU_HZ);
        else if (a == "--script" && i + 1 < argc) script_path = argv[++i];
        else if (a == "--trace" && i + 1 < argc) trace_path = argv[++i];
        else if (a == "--coverage" && i + 1 < argc) cov_path = argv[++i];
        else if (a == "--dsw0" && i + 1 < argc) dsw0 = (int)strtol(argv[++i], nullptr, 0);
        else if (a == "--dsw1" && i + 1 < argc) dsw1 = (int)strtol(argv[++i], nullptr, 0);
        else if (a == "--quiet") quiet = 1;
        else if (a == "--expect-hang") expect_hang = 1;
        else if (a == "--selftest-ok") selftest_ok = 1;
        else if (a == "--reset-page" && i + 1 < argc) reset_page = atoi(argv[++i]) & 3;
        else { fprintf(stderr, "usage: see the head of tests/esbrun.cpp\n"); return 2; }
    }
    if (set != "slapstic" && set != "noslap" && set != "pcb27256") {
        fprintf(stderr, "!! --set slapstic|noslap|pcb27256\n");
        return 2;
    }

    esb_roms roms;
    memset(&roms, 0, sizeof roms);
    roms.set = set == "slapstic" ? ESB_SET_SLAPSTIC : set == "pcb27256" ? ESB_SET_PCB : ESB_SET_NOSLAP;
    if (roms.set == ESB_SET_SLAPSTIC) {
        if (load(romdir, "esb_main_bank0.bin", rom_main, 0x10000) || load(romdir, "esb_slapstic.bin", rom_slap, 0x8000)) return 2;
    } else if (roms.set == ESB_SET_PCB) {
        std::string sub = romdir + "\\pcb27256";
        if (load(sub, "esb_pcb_bank0.bin", rom_main, 0x10000) || load(sub, "esb_1hj.27256", rom_slap, 0x8000)) return 2;
    } else {
        std::string sub = romdir + "\\" + set;
        if (load(sub, "esb_noslap_bank0.bin", rom_main, 0x10000) || load(sub, "esb_noslap_slapstic.bin", rom_slap, 0x8000)) return 2;
    }
    if (load(romdir, "esb_main_bank1.bin", rom_bank1, 0x10000) || load(romdir, "esb_sound.bin", rom_snd, 0x10000) ||
        load(romdir, "esb_mathbox.bin", rom_mb, 0x1000) || load(romdir, "esb_avgprom.bin", rom_avg, 0x100)) return 2;
    roms.main_rom = rom_main.data();
    roms.bank1 = rom_bank1.data();
    roms.slapstic = rom_slap.data();
    roms.sound_rom = rom_snd.data();
    roms.mathbox_proms = rom_mb.data();
    roms.avg_prom = rom_avg.data();

    crc_init();
    esb_init(&roms);
    if (dsw0 >= 0) ESB.dsw0 = (uint8_t)dsw0;
    if (dsw1 >= 0) ESB.dsw1 = (uint8_t)dsw1;
    if (script_path && load_script(script_path)) return 2;
    apply_script(0);
    apply_timed(0);
    ESB.pcb_reset_page = reset_page;
    esb_power_on();

    FILE *trc = trace_path ? fopen(trace_path, "wb") : nullptr;
    if (trace_path && !trc) { fprintf(stderr, "!! cannot write %s\n", trace_path); return 2; }

    unsigned long passes = 0, n_trace = 0;
    uint32_t pchash = 2166136261u;
    std::vector<std::pair<unsigned long, int>> phases;
    int last_phase = -1;
    unsigned long page_time[4] = { 0, 0, 0, 0 };

    uint64_t last_lost_cyc = 0;
    uint32_t lost_seen = 0, lost_after_start = 0;
    while (ESB.cyc < cycles && !script_ended) {
        if (tscript_pos < tscript.size()) apply_timed(ESB.cyc);
        int irq = esb_begin_step();
        if (ESB.n_irq_lost != lost_seen) {
            lost_seen = ESB.n_irq_lost;
            last_lost_cyc = ESB.cyc;
            if (passes) lost_after_start++;         /* requests lost once the mainline runs are a fault */
        }
        unsigned pc = esb_pc(ESB_MAIN);
        if (irq) {
            if (trc) {
                uint16_t r[8];
                trace_rec t;
                esb_regs(ESB_MAIN, r);
                memset(&t, 0, sizeof t);
                t.cyc = ESB.cyc; t.pass = (uint32_t)passes; t.pchash = pchash;
                /* all RAM, except the dead bytes below the stack pointer in the
                 * stack's page: an interrupt taken inside a stub leaves the
                 * stub's address there, and which stub it was may differ (below) */
                unsigned live = (r[1] >= 0x4f00 && r[1] <= 0x4fff) ? r[1] : 0x4f00;
                uint32_t c = 0xffffffffu;
                c = crc_add(c, ESB.mem, 0x3000);
                c = crc_add(c, ESB.mem + 0x4800, 0x700);
                c = crc_add(c, ESB.mem + live, 0x6000 - live);
                c = crc_add(c, ESB.snd, 0x4000);
                t.ramcrc = ~c;
                t.pc = r[0]; t.s = r[1]; t.u = r[2]; t.x = r[3]; t.y = r[4]; t.d = r[5];
                t.dp = (uint8_t)r[6]; t.cc = (uint8_t)r[7];
                /* an interrupt that lands in a stub: neither which stub nor the
                 * page is compared (see below) */
                int in_stub = r[0] >= 0x8000 && r[0] < 0x8100;
                t.bank = (uint8_t)ESB.bank;
                t.page = (uint8_t)(in_stub ? 0xff : ESB.page);
                if (in_stub) t.pc = (uint16_t)(0x8000 | (r[0] & 3));
                t.phase = ESB.mem[PHASE];
                fwrite(&t, sizeof t, 1, trc);
                n_trace++;
            }
        } else {
            /* The stubs ($8000-$80FF, the same on every page) are left out of
             * the hash: which stub runs is exactly what the no-slapstic set
             * changes in five places (a select that the chip would swallow or
             * redirect names the page it really gives), and the chip has
             * switched by the time a stub's first instruction runs, the latch
             * only once it has run.  The stub's two instructions and their
             * cycles are the same either way, and the cycle count is compared. */
            if (pc < 0x8000 || pc >= 0x8100) {
                uint32_t pg = (pc >= 0x8100 && pc < 0xa000) ? (uint32_t)ESB.page + 1 : 0;
                pchash = (pchash ^ pc ^ ((uint32_t)ESB.bank << 16) ^ (pg << 17)) * 16777619u;
            }
            if (pc == PASS_PC && !ESB.bank) {
                uint16_t r[8];
                esb_regs(ESB_MAIN, r);
                if (r[1] == STACK_TOP) {
                    passes++;
                    apply_script((unsigned)passes);
                    int ph = ESB.mem[PHASE];
                    if (ph != last_phase) { phases.push_back({ passes, ph }); last_phase = ph; }
                }
            }
            if (pc == HANG_PC && !ESB.bank) ESB.n_hang++;
            {
                int sp = (pc >= 0x8000 && pc < 0xa000) ? 2 + (ESB.page & 3) : ESB.bank;
                /* a stub is the same on every page and the chip has switched before
                 * its first instruction: book it on page 0 */
                if (pc >= 0x8000 && pc < 0x8100) sp = 2;
                cov[sp][pc >> 3] |= (uint8_t)(1u << (pc & 7));
            }
            if (pc >= 0x8000 && pc < 0xa000) page_time[ESB.page & 3]++;
        }
        if (reset_request) {
            reset_request = 0;
            esb_machine_reset(ESB_RST_SCRIPT);
            continue;
        }
        esb_exec_step();
    }
    if (trc) fclose(trc);
    if (cov_path) {
        static uint8_t old[7][0x2000];
        FILE *f = fopen(cov_path, "rb");
        if (f) { if (fread(old, 1, sizeof old, f) != sizeof old) memset(old, 0, sizeof old); fclose(f); }
        for (int s = 0; s < 6; s++) for (int i = 0; i < 0x2000; i++) old[s][i] |= cov[s][i];
        for (int i = 0; i < 0x2000; i++) old[6][i] |= ESB.pc_hit[ESB_SOUND][i];
        f = fopen(cov_path, "wb");
        if (!f) { fprintf(stderr, "!! cannot write %s\n", cov_path); return 2; }
        fwrite(old, 1, sizeof old, f);
        fclose(f);
    }

    unsigned long unmapped = ESB.n_unmapped_r[0] + ESB.n_unmapped_w[0] + ESB.n_unmapped_r[1] + ESB.n_unmapped_w[1];
    int bad = ESB.n_wd_bites || unmapped || ESB.n_hang || ESB.n_cpu_log || lost_after_start;
    /* leaving the self test is done by hanging until the watchdog bites: one bite is then right */
    if (expect_hang) bad = unmapped || ESB.n_cpu_log || ESB.n_wd_bites != 1 || !ESB.n_hang;
    /* the self test held on its results: the ROM test must have read the window
     * and left no error bit and six zero checksums */
    if (selftest_ok) {
        int cells = 0;
        for (int i = 0; i < 14; i++) cells |= ESB.mem[0x48d7 + (i < 2 ? i : i + 3)];
        bad = unmapped || ESB.n_cpu_log || ESB.n_wd_bites || cells || ESB.n_window_data < 0x8000;
    }
    printf("set %s: %.1f s of machine time, %llu cycles, %llu + %llu instructions\n", set.c_str(),
           (double)ESB.cyc / CPU_HZ, (unsigned long long)ESB.cyc,
           (unsigned long long)ESB.n_steps[0], (unsigned long long)ESB.n_steps[1]);
    printf("  game frames %lu   interrupts %u (lost %u)   watchdog bites %u   resets %u   sound resets %u\n",
           passes, ESB.n_irq, ESB.n_irq_lost, ESB.n_wd_bites, ESB.n_reset[ESB_RST_SCRIPT], ESB.n_snd_resets);
    printf("  unmapped accesses %lu   traps (HANG) %lu   core messages %u   longest watchdog gap %llu cycles\n",
           unmapped, ESB.n_hang, ESB.n_cpu_log, (unsigned long long)ESB.max_kick_gap);
    for (int c = 0; c < 2; c++) {
        for (unsigned i = 0; i < ESB.n_unmapped_r[c] && i < 8; i++)
            printf("    %s CPU read of $%04X at PC $%04X\n", c ? "sound" : "main", ESB.first_unmapped_r[c][i], ESB.first_unmapped_pc[c][i]);
        for (unsigned i = 0; i < ESB.n_unmapped_w[c] && i < 8; i++)
            printf("    %s CPU write to $%04X\n", c ? "sound" : "main", ESB.first_unmapped_w[c][i]);
    }
    for (unsigned i = 0; i < ESB.n_cpu_log && i < 4; i++) printf("    core: %s\n", ESB.first_log[i]);
    if (ESB.n_irq_lost) {
        printf("    interrupt requests that found the last one still waiting: %u, the last at cycle %llu; first at PC:",
               ESB.n_irq_lost, (unsigned long long)last_lost_cyc);
        for (unsigned i = 0; i < ESB.n_irq_lost && i < 8; i++) printf(" $%04X", ESB.first_lost_pc[i]);
        printf("\n");
    }
    if (ESB.set == ESB_SET_SLAPSTIC)
        printf("  slapstic: %lu addresses seen, page selects %lu / %lu / %lu / %lu, %lu by the alternate sequence, bitwise entered %lu completed %lu\n",
               ESB.slapstic.n_tweak, ESB.slapstic.n_select[0], ESB.slapstic.n_select[1], ESB.slapstic.n_select[2],
               ESB.slapstic.n_select[3], ESB.slapstic.n_alt, ESB.slapstic.n_bitwise_entered, ESB.slapstic.n_bitwise_done);
    else if (ESB.set == ESB_SET_PCB)
        printf("  LED latch page bits: writes leaving page 0 / 1 / 2 / 3: %lu / %lu / %lu / %lu\n", ESB.n_page_latch[0],
               ESB.n_page_latch[1], ESB.n_page_latch[2], ESB.n_page_latch[3]);
    else
        printf("  page latch: selects %lu / %lu / %lu / %lu\n", ESB.n_page_latch[0], ESB.n_page_latch[1],
               ESB.n_page_latch[2], ESB.n_page_latch[3]);
    printf("  instructions executed on page 0 / 1 / 2 / 3: %lu / %lu / %lu / %lu   data accesses in the window %lu\n",
           page_time[0], page_time[1], page_time[2], page_time[3], ESB.n_window_data);
    printf("  commands to the sound board %u (overrun %u), replies %u, POKEY writes %u, speech writes %u\n",
           ESB.n_main_cmds, ESB.n_cmd_overrun, ESB.n_snd_replies, ESB.n_pokey_w, ESB.n_tms_w);
    if (!quiet) {
        printf("  phases (game frame: phase):");
        for (size_t i = 0; i < phases.size(); i++) printf(" %lu:$%02X", phases[i].first, phases[i].second);
        printf("\n");
    }
    if (trc) printf("  trace: %lu records\n", n_trace);
    /* the self test's results, if it ran: ERRORS (one bit per failed RAM or ROM,
     * BITS in the bank 0 listing) and the six checksums it left, which are zero
     * for a ROM that sums right */
    printf("  self test cells: ERRORS $%02X%02X, checksums", ESB.mem[0x48d7], ESB.mem[0x48d8]);
    for (int i = 0; i < 12; i += 2) printf(" %02X%02X", ESB.mem[0x48dc + i], ESB.mem[0x48dd + i]);
    printf("\n");
    printf("  %s\n", bad ? "!! FAULTS" : "no faults");
    return bad ? 1 : 0;
}
