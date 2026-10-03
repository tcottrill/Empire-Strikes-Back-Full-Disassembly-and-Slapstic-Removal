/* slapstic101.c - the slapstic 137412-101 (slapstic101.h). */
#include <string.h>
#include "slapstic101.h"

static int page_of(unsigned off)
{
    switch (off) {
    case 0x0080: return 0;
    case 0x0090: return 1;
    case 0x00a0: return 2;
    case 0x00b0: return 3;
    default:     return -1;
    }
}

void slap_reset(slapstic101 *s)
{
    s->state = SLAP_DISABLED;
    s->page = 3;
    s->alt_page = s->bit_page = s->bit_xor = 0;
}

int slap_tweak(slapstic101 *s, unsigned addr)
{
    unsigned off = addr & 0x1fff;
    int pg = page_of(off);

    s->n_tweak++;
    if (off == 0x0000) {                        /* reset is universal */
        s->state = SLAP_ENABLED;
        return s->page;
    }
    switch (s->state) {
    case SLAP_DISABLED:
        break;
    case SLAP_ENABLED:
        if ((off & 0x1ff0) == 0x1540) {
            s->state = SLAP_BIT1;
            s->n_bitwise_entered++;
        } else if (off == 0x1dfe) {
            s->state = SLAP_ALT2;
        } else if (pg >= 0) {
            s->state = SLAP_DISABLED;
            s->page = pg;
            s->n_select[pg]++;
        }
        break;
    case SLAP_ALT2:
        if ((off & 0x1ffc) == 0x1b5c) {
            s->state = SLAP_ALT3;
            s->alt_page = (int)(off & 3);
        } else {
            s->state = SLAP_ENABLED;
        }
        break;
    case SLAP_ALT3:
        if (pg >= 0) {
            s->state = SLAP_DISABLED;
            s->page = s->alt_page;
            s->n_select[s->page]++;
            s->n_alt++;
        }
        break;
    case SLAP_BIT1:
        if (pg >= 0) {
            s->state = SLAP_BIT2;
            s->bit_page = s->page;
            s->bit_xor = 0;
        }
        break;
    case SLAP_BIT2: {
        unsigned x = (off ^ (unsigned)s->bit_xor) & 0x1ff3;
        if (x == 0x1540)      { s->bit_page &= ~1; s->bit_xor ^= 3; }
        else if (x == 0x1541) { s->bit_page |= 1;  s->bit_xor ^= 3; }
        else if (x == 0x1542) { s->bit_page &= ~2; s->bit_xor ^= 3; }
        else if (x == 0x1543) { s->bit_page |= 2;  s->bit_xor ^= 3; }
        else if ((off & 0x1ff8) == 0x1550) s->state = SLAP_BIT3;
        break;
    }
    case SLAP_BIT3:
        if (pg >= 0) {
            s->state = SLAP_DISABLED;
            s->page = s->bit_page;
            s->n_select[s->page]++;
            s->n_bitwise_done++;
        }
        break;
    default:
        break;
    }
    return s->page;
}
