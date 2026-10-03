/* slapstic101.h - the slapstic 137412-101 of The Empire Strikes Back.
 *
 * The chip watches the addresses of $8000-$9FFF (offset = address & $1FFF) and
 * selects one of four 8K ROM pages:
 *
 *   $0000                                   arms the chip
 *   armed: $0080 / $0090 / $00A0 / $00B0    page 0 / 1 / 2 / 3, disarmed
 *   armed: $1DFE, $1B5C+n, a page address   'alternate': page n
 *   armed: $154x, a page address, then $1540-$1543 (clear / set bit 0, clear /
 *          set bit 1 of the page number; each use flips the low two address
 *          bits the next must show), $1550-$1557, a page address
 *                                           'bitwise': the edited page
 *
 * The state machine is MAME's (slapstic.c, Aaron Giles and Frank Palazzolo),
 * with the parameters of chip 101; ../disasm/slapstic.py is the same model in
 * Python.  Which bus cycles are shown to the chip is the board's business
 * (board.cpp).
 */
#ifndef SLAPSTIC101_H
#define SLAPSTIC101_H

#ifdef __cplusplus
extern "C" {
#endif

enum { SLAP_DISABLED, SLAP_ENABLED, SLAP_ALT2, SLAP_ALT3, SLAP_BIT1, SLAP_BIT2, SLAP_BIT3 };

typedef struct {
    int state;
    int page;
    int alt_page, bit_page, bit_xor;
    /* statistics */
    unsigned long n_tweak, n_select[4], n_alt, n_bitwise_entered, n_bitwise_done;
} slapstic101;

void slap_reset(slapstic101 *s);                    /* power-on and RESET: page 3, disarmed */
int  slap_tweak(slapstic101 *s, unsigned addr);     /* one address seen; returns the page */

#ifdef __cplusplus
}
#endif
#endif
