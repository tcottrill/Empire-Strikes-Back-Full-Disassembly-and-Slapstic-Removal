/* esb_platform.h - the platform contract for the Empire Strikes Back host
 * (the Star Wars project's, after the Tempest port's tempest_platform.h).
 *
 * The machine behind it is emu_main.cpp: the ROMs on two 6809 cores
 * (esb_emu.exe).  It calls only these functions for video, input, audio, time
 * and storage.  A backend under platform/<name>/ implements them;
 * platform/windows/plat_win.c is the one there is.
 *
 * Hardware truth (which port bit is which switch, the POKEY and speech chip
 * clocks, the vector generator) is on the machine's side.  Key bindings are
 * backend policy.
 */
#ifndef ESB_PLATFORM_H
#define ESB_PLATFORM_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

/* ---- video: one picture per display list the vector generator draws ------
 * Coordinates are the vector generator's (avg.c): x 0..250 left to right,
 * y 0..280 TOP to bottom, the beam centre at (125, 140); the tube shows exactly
 * that window, on a 4:3 monitor in landscape.  Only lit vectors are sent.
 * rgb: R | G << 8 | B << 16 | 0xFF << 24, each 0 or 255 (the 3-bit colour
 * latch).  intensity: 0..255, ((intensity latch >> 1) * vector brightness) >> 3. */
void plat_video_begin(void);
void plat_video_line(float x0, float y0, float x1, float y1, uint32_t rgb, int intensity);
void plat_video_present(void);

/* ---- input ------------------------------------------------------------
 * pitch, yaw: the flight yoke through the A-to-D converter, 0..255, $80 at
 * rest.  Everything else 0/1, 1 = pressed / switch closed.  test, diag and
 * snd_test are latching switches on the boards. */
typedef struct {
    uint8_t pitch, yaw;
    uint8_t fire_l, fire_r, thumb_l, thumb_r;
    uint8_t coin_l, coin_r, coin_aux, slam;
    uint8_t test, diag, snd_test;
    uint8_t quit;
} plat_inputs;
void plat_input_poll(plat_inputs *in);

/* The two option switch banks, raw as the board reads them ($4340, $4360). */
uint8_t plat_dsw0(void);
uint8_t plat_dsw1(void);

/* ---- audio: one mono signed 16-bit stream ------------------------------ */
#define ESB_AUDIO_RATE 44100
int  plat_audio_open(int sample_rate);          /* 0 = ok */
void plat_audio_push(const int16_t *pcm, int frames);
void plat_audio_close(void);

/* ---- time, storage, status ----------------------------------------------- */
double plat_now_ms(void);
int  plat_nvram_read(void *buf, unsigned len);  /* the X2212's 256 nibbles; 0 = ok */
int  plat_nvram_write(const void *buf, unsigned len);
void plat_log(const char *text);

/* ---- the machine ---------------------------------------------------------- */
typedef struct {
    int         rev;            /* the ROM set: 0 original (slapstic), 1 noslap, 2 pcb27256 */
    const char *rom_dir;        /* where disasm/image.py wrote the images */
    const char *script;         /* a tests/scenarios script, or NULL: live input */
    int         turbo;          /* 1 = no pacing: esb_app_run advances a fixed slice */
    int         pokey_volume, speech_volume;    /* percent */
} esb_app_opts;

typedef struct {
    uint64_t      cycles;       /* machine time, CPU cycles (1.512 MHz) */
    unsigned long passes;       /* mainline passes (arrivals at $602F) */
    unsigned long pictures;     /* display lists presented */
    unsigned long irqs, irqs_lost;
    unsigned long resets, watchdog_bites, snd_resets, swi;
    unsigned      phase;        /* the game's PHASE cell */
    int           points;       /* vectors in the last picture */
    int           script_ended;
} esb_app_stats;

int  esb_app_init(const esb_app_opts *o);         /* 0 = ok; power-on done */
void esb_app_run(double now_ms);                 /* run the machine up to the wall clock */
void esb_app_exit(void);
void esb_app_get_stats(esb_app_stats *s);
const char *esb_app_error(void);
const char *esb_app_name(void);                  /* which ROM set runs */

#ifdef __cplusplus
}
#endif
#endif
