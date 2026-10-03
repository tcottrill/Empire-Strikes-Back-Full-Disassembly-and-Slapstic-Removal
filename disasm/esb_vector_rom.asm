;The Empire Strikes Back (Atari, 1985) - annotated disassembly of the vector
;ROM $3000-$3FFF (136031-111.1l): AVG display-list subroutines.
;AVG words are big-endian here, as the 6809 stores them:
;  $0yyy $zxxx  VCTR  draw to dx,dy (13-bit signed), intensity z (0-7)
;  $4...        short VCTR: dy in bits 12-8, z in bits 7-5, dx in bits 4-0 (x2)
;  $2000 HALT   $6ccc STAT/COLOR (colour in bits 10-8, brightness in bits 7-0)
;  $7sll SCAL   $8040 CNTR   $Annn JSRL   $C000 RTSL   $Ennn JMPL
;JSRL/JMPL operands are word addresses: address/2.
;Names and upper-case comments are Atari's, carried over from the Star Wars
;source wherever this code is the same instruction for instruction (swmatch.py);
;everything in lower case was written for this disassembly.
;Every line below was re-encoded and byte-compared with the ROM (verify.py).
;Syntax: Motorola 6809 mnemonics and operands; .alias, .byte, .word (big-endian);
;( ) groups expressions; ~ is one's complement, | is OR, ^ is exclusive OR.
;.dpage gives the direct page the assembler assumed; < and > before an operand
;force the short and the long form.

.org $3000

.include "esb_defines.asm"

.dpage $48
L3000:  .word $A2BC

;.SBTTL CHARACTER TABLE
VGMSGA:
L3002:  .word (((CHAR_-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR.  ADDRESS OF LETTER ROUTINES
L3004:  .word (((CHAR_O-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR_O
L3006:  .word (((CHAR_1-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR.1
L3008:  .word (((CHAR_2-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR.2
L300A:  .word (((CHAR_3-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR.3
L300C:  .word (((CHAR_4-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR.4
L300E:  .word (((CHAR_S-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR_S
L3010:  .word (((CHAR_6-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR.6
L3012:  .word (((CHAR_7-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR.7
L3014:  .word (((CHAR_8-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR.8
L3016:  .word (((CHAR_9-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR.9
L3018:  .word (((CHAR_A-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR.A
L301A:  .word (((CHAR_B-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR.B
L301C:  .word (((CHAR_C-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR.C
L301E:  .word (((CHAR_D-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR.D
L3020:  .word (((CHAR_E-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR.E
L3022:  .word (((CHAR_F-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR.F
L3024:  .word (((CHAR_G-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR.G
L3026:  .word (((CHAR_H-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR.H
L3028:  .word (((CHAR_I-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR.I
L302A:  .word (((CHAR_J-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR.J
L302C:  .word (((CHAR_K-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR.K
L302E:  .word (((CHAR_L-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR.L
L3030:  .word (((CHAR_M-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR.M
L3032:  .word (((CHAR_N-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR.N
L3034:  .word (((CHAR_O-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR.O
L3036:  .word (((CHAR_P-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR.P
L3038:  .word (((CHAR_Q-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR.Q
L303A:  .word (((CHAR_R-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR.R
L303C:  .word (((CHAR_S-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR.S
L303E:  .word (((CHAR_T-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR.T
L3040:  .word (((CHAR_U-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR.U
L3042:  .word (((CHAR_V-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR.V
L3044:  .word (((CHAR_W-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR.W
L3046:  .word (((CHAR_X-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR.X
L3048:  .word (((CHAR_Y-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR.Y
L304A:  .word (((CHAR_Z-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR.Z
L304C:  .word (((CH_CLN-VGBASE)/2)&$1FFF)+$A000 ;JSRL CH_CLN
L304E:  .word (((CHAR_-VGBASE)/2)&$1FFF)+$A000 ;JSRL CHAR_
L3050:  .word (((CH_PER-VGBASE)/2)&$1FFF)+$A000 ;JSRL CH_PER
L3052:  .word (((CH_PER-VGBASE)/2)&$1FFF)+$A000 ;JSRL CH_PER
L3054:  .word (((CH_COP-VGBASE)/2)&$1FFF)+$A000 ;JSRL CH_COP
L3056:  .word (((CH_PER-VGBASE)/2)&$1FFF)+$A000 ;JSRL CH_PER
L3058:  .word (((CH_HLF-VGBASE)/2)&$1FFF)+$A000 ;JSRL CH_HLF
L305A:  .word (((CH_PER-VGBASE)/2)&$1FFF)+$A000 ;JSRL CH_PER
L305C:  .word (((CH_APO-VGBASE)/2)&$1FFF)+$A000 ;JSRL CH_APO
L305E:  .word (((vg_ch_lparen-VGBASE)/2)&$1FFF)+$A000 ;JSRL vg_ch_lparen
L3060:  .word (((vg_ch_rparen-VGBASE)/2)&$1FFF)+$A000 ;JSRL vg_ch_rparen
L3062:  .word (((vg_ch_star-VGBASE)/2)&$1FFF)+$A000 ;JSRL vg_ch_star
L3064:  .word (((CH_PER-VGBASE)/2)&$1FFF)+$A000 ;JSRL CH_PER
L3066:  .word (((CH_CMA-VGBASE)/2)&$1FFF)+$A000 ;JSRL CH_CMA
L3068:  .word (((CH_HYP-VGBASE)/2)&$1FFF)+$A000 ;JSRL CH_HYP
L306A:  .word (((CH_PER-VGBASE)/2)&$1FFF)+$A000 ;JSRL CH_PER
L306C:  .word (((UNDERL-VGBASE)/2)&$1FFF)+$A000 ;JSRL UNDERL
;;; JSRL CH.LPN ;LEFT PAREN
;;; JSRL CH.RPN ;RIGHT PAREN
L306E:  .word $C000                 ;RTSL

;.SBTTL CHARACTER DEFINITIONS
CHAR_A:
L3070:  .word $48E0                 ;VCTR 0,16,.BRITE
L3072:  .word $44E4                 ;VCTR 8,8,.BRITE
L3074:  .word $5CE4                 ;VCTR 8,-8,.BRITE
L3076:  .word $58E0                 ;VCTR 0,-16,.BRITE
L3078:  .word $4518                 ;VCTR -16,10,0
L307A:  .word $40E8                 ;VCTR 16,0,.BRITE
L307C:  .word $5B04                 ;VCTR 8,-10,0
L307E:  .word $C000                 ;RTSL

CHAR_B:
L3080:  .word $4CE0                 ;VCTR 0,24,.BRITE
L3082:  .word $40E5                 ;VCTR 10,0,.BRITE
L3084:  .word $5DE2                 ;VCTR 4,-6,.BRITE
L3086:  .word $5DFE                 ;VCTR -4,-6,.BRITE
L3088:  .word $40FB                 ;VCTR -10,0,.BRITE
L308A:  .word $4006                 ;VCTR 12,0,0
L308C:  .word $5DE2                 ;VCTR 4,-6,.BRITE
L308E:  .word $5DFE                 ;VCTR -4,-6,.BRITE
L3090:  .word $40FA                 ;VCTR -12,0,.BRITE
L3092:  .word (((CHAR_-VGBASE)/2)&$1FFF)+$E000 ;JMPL CHAR.

CHAR_C:
L3094:  .word $4CE0                 ;VCTR 0,24,.BRITE
L3096:  .word $40E8                 ;VCTR 16,0,.BRITE
L3098:  .word $5418                 ;VCTR -16,-24,0
L309A:  .word (((UNDERL-VGBASE)/2)&$1FFF)+$E000 ;JMPL UNDERL

CHAR_D:
L309C:  .word $40E5                 ;VCTR 10,0,.BRITE
L309E:  .word $44E3                 ;VCTR 6,8,.BRITE
L30A0:  .word $44E0                 ;VCTR 0,8,.BRITE
L30A2:  .word $44FD                 ;VCTR -6,8,.BRITE
L30A4:  .word $40FB                 ;VCTR -10,0,.BRITE
L30A6:  .word $54E0                 ;VCTR 0,-24,.BRITE
L30A8:  .word (((CHAR_-VGBASE)/2)&$1FFF)+$E000 ;JMPL CHAR.

CHAR_E:
L30AA:  .word $40E8                 ;VCTR 16,0,.BRITE

CHARE1:
L30AC:  .word $4018                 ;VCTR -16,0,0

CHAR_F:
L30AE:  .word $4600                 ;VCTR 0,12,0
L30B0:  .word $40E6                 ;VCTR 12,0,.BRITE  MIDLINE
L30B2:  .word $5A1A                 ;VCTR -12,-12,0

CHARF1:
L30B4:  .word $4CE0                 ;VCTR 0,24,.BRITE
L30B6:  .word $40E8                 ;VCTR 16,0,.BRITE
L30B8:  .word (((CHARU2-VGBASE)/2)&$1FFF)+$E000 ;JMPL CHARU2
L30BA:  .word $C000                 ;RTSL

CHAR_G:
L30BC:  .word $4504                 ;VCTR 8,10,0
L30BE:  .word $40E4                 ;VCTR 8,0,.BRITE
L30C0:  .word $5BE0                 ;VCTR 0,-10,.BRITE
L30C2:  .word $4018                 ;VCTR -16,0,0
L30C4:  .word (((CHAR_C-VGBASE)/2)&$1FFF)+$E000 ;JMPL CHAR.C

CHAR_H:
L30C6:  .word $4CE0                 ;VCTR 0,24,.BRITE
L30C8:  .word $5A00                 ;VCTR 0,-12,0
L30CA:  .word $40E8                 ;VCTR 16,0,.BRITE
L30CC:  .word $5A00                 ;VCTR 0,-12,0
L30CE:  .word (((CHARU1-VGBASE)/2)&$1FFF)+$E000 ;JMPL CHARU1

CHAR_I:
L30D0:  .word $40E8                 ;VCTR 16,0,.BRITE
L30D2:  .word $4C18                 ;VCTR -16,24,0

CHARI1:
L30D4:  .word $40E8                 ;VCTR 16,0,.BRITE
L30D6:  .word $401C                 ;VCTR -8,0,0
L30D8:  .word (((CHAR11-VGBASE)/2)&$1FFF)+$E000 ;JMPL CHAR11

CHAR_J:
L30DA:  .word $4400                 ;VCTR 0,8,0
L30DC:  .word $5CE4                 ;VCTR 8,-8,.BRITE
L30DE:  .word $40E4                 ;VCTR 8,0,.BRITE
L30E0:  .word (((CHARU1-VGBASE)/2)&$1FFF)+$E000 ;JMPL CHARU1

CHAR_K:
L30E2:  .word $4CE0                 ;VCTR 0,24,.BRITE
L30E4:  .word $5A00                 ;VCTR 0,-12,0
L30E6:  .word $46E8                 ;VCTR 16,12,.BRITE
L30E8:  .word $5A18                 ;VCTR -16,-12,0
L30EA:  .word $5AE8                 ;VCTR 16,-12,.BRITE
L30EC:  .word (((CHAR73-VGBASE)/2)&$1FFF)+$E000 ;JMPL CHAR73

CHAR_L:
L30EE:  .word $4C00                 ;VCTR 0,24,0
L30F0:  .word $54E0                 ;VCTR 0,-24,.BRITE

UNDERL:
L30F2:  .word $40E8                 ;VCTR 16,0,.BRITE
L30F4:  .word (((CHAR73-VGBASE)/2)&$1FFF)+$E000 ;JMPL CHAR73

CHAR_M:
L30F6:  .word $4CE0                 ;VCTR 0,24,.BRITE
L30F8:  .word $5CE4                 ;VCTR 8,-8,.BRITE
L30FA:  .word $44E4                 ;VCTR 8,8,.BRITE
L30FC:  .word (((CHAR72-VGBASE)/2)&$1FFF)+$E000 ;JMPL CHAR72

CHAR_N:
L30FE:  .word $4CE0                 ;VCTR 0,24,.BRITE
L3100:  .word $54E8                 ;VCTR 16,-24,.BRITE
L3102:  .word (((CHARU1-VGBASE)/2)&$1FFF)+$E000 ;JMPL CHARU1

CHAR_O:
L3104:  .word $40E8                 ;VCTR 16,0,.BRITE
L3106:  .word $4CE0                 ;VCTR 0,24,.BRITE

CHARO2:
L3108:  .word $5418                 ;VCTR -16,-24,0
L310A:  .word (((CHARF1-VGBASE)/2)&$1FFF)+$E000 ;JMPL CHARF1

CHAR_:
L310C:  .word $400C                 ;VCTR 24,0,0  BLANK
L310E:  .word $C000                 ;RTSL

CHAR_P:
L3110:  .word $4600                 ;VCTR 0,12,0
L3112:  .word $40E8                 ;VCTR 16,0,.BRITE
L3114:  .word $46E0                 ;VCTR 0,12,.BRITE
L3116:  .word (((CHARO2-VGBASE)/2)&$1FFF)+$E000 ;JMPL CHARO2

CHAR_Q:
L3118:  .word $4404                 ;VCTR 8,8,0
L311A:  .word $5CE4                 ;VCTR 8,-8,.BRITE
L311C:  .word $4018                 ;VCTR -16,0,0
L311E:  .word $40E4                 ;VCTR 8,0,.BRITE
L3120:  .word $44E4                 ;VCTR 8,8,.BRITE
L3122:  .word $48E0                 ;VCTR 0,16,.BRITE
L3124:  .word $5418                 ;VCTR -16,-24,0
L3126:  .word (((CHARF1-VGBASE)/2)&$1FFF)+$E000 ;JMPL CHARF1

CHAR_R:
L3128:  .word $4600                 ;VCTR 0,12,0
L312A:  .word $5AE8                 ;VCTR 16,-12,.BRITE
L312C:  .word $4018                 ;VCTR -16,0,0
L312E:  .word (((CHAR_P-VGBASE)/2)&$1FFF)+$E000 ;JMPL CHAR.P

CHAR_S:
L3130:  .word $4008                 ;VCTR 16,0,0
L3132:  .word $46E0                 ;VCTR 0,12,.BRITE
L3134:  .word $4018                 ;VCTR -16,0,0
L3136:  .word $46E0                 ;VCTR 0,12,.BRITE
L3138:  .word (((CHAR33-VGBASE)/2)&$1FFF)+$E000 ;JMPL CHAR33

CHAR_T:
L313A:  .word $4C00                 ;VCTR 0,24,0
L313C:  .word (((CHARI1-VGBASE)/2)&$1FFF)+$E000 ;JMPL CHARI1

CHAR_U:
L313E:  .word $4C00                 ;VCTR 0,24,0
L3140:  .word $54E0                 ;VCTR 0,-24,.BRITE
L3142:  .word $40E8                 ;VCTR 16,0,.BRITE

CHARU1:
L3144:  .word $4CE0                 ;VCTR 0,24,.BRITE

CHARU2:
L3146:  .word $5404                 ;VCTR 8,-24,0
L3148:  .word $C000                 ;RTSL

CHAR_V:
L314A:  .word $4C00                 ;VCTR 0,24,0
L314C:  .word $54E4                 ;VCTR 8,-24,.BRITE
L314E:  .word $4CE4                 ;VCTR 8,24,.BRITE
L3150:  .word (((CHARU2-VGBASE)/2)&$1FFF)+$E000 ;JMPL CHARU2

CHAR_W:
L3152:  .word $4C00                 ;VCTR 0,24,0
L3154:  .word $54E0                 ;VCTR 0,-24,.BRITE
L3156:  .word $44E4                 ;VCTR 8,8,.BRITE
L3158:  .word $5CE4                 ;VCTR 8,-8,.BRITE
L315A:  .word (((CHARU1-VGBASE)/2)&$1FFF)+$E000 ;JMPL CHARU1

CHAR_X:
L315C:  .word $4CE8                 ;VCTR 16,24,.BRITE
L315E:  .word $4018                 ;VCTR -16,0,0
L3160:  .word $54E8                 ;VCTR 16,-24,.BRITE
L3162:  .word (((CHAR73-VGBASE)/2)&$1FFF)+$E000 ;JMPL CHAR73

CHAR_Y:
L3164:  .word $4004                 ;VCTR 8,0,0
L3166:  .word $48E0                 ;VCTR 0,16,.BRITE
L3168:  .word $44FC                 ;VCTR -8,8,.BRITE
L316A:  .word $5C04                 ;VCTR 8,-8,0
L316C:  .word $44E4                 ;VCTR 8,8,.BRITE
L316E:  .word (((CHARU2-VGBASE)/2)&$1FFF)+$E000 ;JMPL CHARU2

CHAR_Z:
L3170:  .word $4C00                 ;VCTR 0,24,0
L3172:  .word $40E8                 ;VCTR 16,0,.BRITE
L3174:  .word $54F8                 ;VCTR -16,-24,.BRITE
L3176:  .word (((UNDERL-VGBASE)/2)&$1FFF)+$E000 ;JMPL UNDERL

CHAR_1:
L3178:  .word $40E8                 ;VCTR 16,0,.BRITE
L317A:  .word $4A1A                 ;VCTR -12,20,0
L317C:  .word $42E2                 ;VCTR 4,4,.BRITE

CHAR11:
L317E:  .word $54E0                 ;VCTR 0,-24,.BRITE

CHAR12:
L3180:  .word $4008                 ;VCTR 16,0,0
L3182:  .word $C000                 ;RTSL

CHAR_2:
L3184:  .word $46E0                 ;VCTR 0,12,.BRITE
L3186:  .word $4008                 ;VCTR 16,0,0
L3188:  .word $46E0                 ;VCTR 0,12,.BRITE
L318A:  .word (((CHAR32-VGBASE)/2)&$1FFF)+$E000 ;JMPL CHAR32

CHAR_3:
L318C:  .word $4008                 ;VCTR 16,0,0

CHAR31:
L318E:  .word $4CE0                 ;VCTR 0,24,.BRITE

CHAR32:
L3190:  .word $4018                 ;VCTR -16,0,0

CHAR33:
L3192:  .word $40E8                 ;VCTR 16,0,.BRITE
L3194:  .word $5A18                 ;VCTR -16,-12,0
L3196:  .word $40E8                 ;VCTR 16,0,.BRITE
L3198:  .word $5A18                 ;VCTR -16,-12,0
L319A:  .word (((UNDERL-VGBASE)/2)&$1FFF)+$E000 ;JMPL UNDERL

CHAR_4:
L319C:  .word $4C00                 ;VCTR 0,24,0
L319E:  .word $5AE0                 ;VCTR 0,-12,.BRITE
L31A0:  .word $40E8                 ;VCTR 16,0,.BRITE
L31A2:  .word $4600                 ;VCTR 0,12,0
L31A4:  .word (((CHAR72-VGBASE)/2)&$1FFF)+$E000 ;JMPL CHAR72

CHAR_6:
L31A6:  .word $4600                 ;VCTR 0,12,0
L31A8:  .word $40E8                 ;VCTR 16,0,.BRITE
L31AA:  .word $5AE0                 ;VCTR 0,-12,.BRITE
L31AC:  .word $4018                 ;VCTR -16,0,0
L31AE:  .word (((CHAR_L-VGBASE)/2)&$1FFF)+$E000 ;JMPL CHAR.L

CHAR_7:
L31B0:  .word $4C00                 ;VCTR 0,24,0

CHAR71:
L31B2:  .word $40E8                 ;VCTR 16,0,.BRITE

CHAR72:
L31B4:  .word $54E0                 ;VCTR 0,-24,.BRITE

CHAR73:
L31B6:  .word $4004                 ;VCTR 8,0,0
L31B8:  .word $C000                 ;RTSL

CHAR_8:
L31BA:  .word $4CE0                 ;VCTR 0,24,.BRITE
L31BC:  .word $5408                 ;VCTR 16,-24,0
L31BE:  .word (((CHAR31-VGBASE)/2)&$1FFF)+$E000 ;JMPL CHAR31

CHAR_9:
L31C0:  .word $4C00                 ;VCTR 0,24,0
L31C2:  .word $5AE0                 ;VCTR 0,-12,.BRITE
L31C4:  .word $40E8                 ;VCTR 16,0,.BRITE
L31C6:  .word $4618                 ;VCTR -16,12,0
L31C8:  .word (((CHAR71-VGBASE)/2)&$1FFF)+$E000 ;JMPL CHAR71

CH_PER:
L31CA:  .word $0000, (ON*$2000)+(0&$1FFF) ;VCTR 0,0,ON  PERIOD
L31CE:  .word (((CHAR_-VGBASE)/2)&$1FFF)+$E000 ;JMPL CHAR.

CH_CLN:
L31D0:  .word $4000+(OFF*$20)+((8/2)&$1F)+((10*$80)&$1F00) ;VCTR 8,10,OFF
L31D2:  .word $0000, (ON*$2000)+(0&$1FFF) ;VCTR 0,0,ON
L31D6:  .word $4000+(OFF*$20)+((0/2)&$1F)+((-10*$80)&$1F00) ;VCTR 0,-10,OFF
L31D8:  .word $0000, (ON*$2000)+(0&$1FFF) ;VCTR 0,0,ON
L31DC:  .word (((CHAR12-VGBASE)/2)&$1FFF)+$E000 ;JMPL CHAR12

CH_APO:
L31DE:  .word $4000+(OFF*$20)+((10/2)&$1F)+((24*$80)&$1F00) ;VCTR 10,24,OFF  APOSTROPHE
L31E0:  .word (((CH_TIC-VGBASE)/2)&$1FFF)+$A000 ;JSRL CH.TIC
L31E2:  .word $4000+(OFF*$20)+((14/2)&$1F)+((-24*$80)&$1F00) ;VCTR 14,-24,OFF
L31E4:  .word $C000                 ;RTSL

CH_CMA:
L31E6:  .word $4000+(OFF*$20)+((4/2)&$1F)+((0*$80)&$1F00) ;VCTR 4,0,OFF
L31E8:  .word (((CH_TIC-VGBASE)/2)&$1FFF)+$A000 ;JSRL CH.TIC  COMMA
L31EA:  .word $4000+(OFF*$20)+((20/2)&$1F)+((0*$80)&$1F00) ;VCTR 20,0,OFF
L31EC:  .word $C000                 ;RTSL

CH_TIC:
L31EE:  .word $4000+(ON*$20)+((-4/2)&$1F)+((-10*$80)&$1F00) ;VCTR -4,-10,ON
L31F0:  .word $4000+(ON*$20)+((6/2)&$1F)+((10*$80)&$1F00) ;VCTR 6,10,ON
L31F2:  .word $0000, (ON*$2000)+(-2&$1FFF) ;VCTR -2,0,ON
L31F6:  .word $C000                 ;RTSL

CH_HLF:
L31F8:  .word $4000+(OFF*$20)+((4/2)&$1F)+((16*$80)&$1F00) ;VCTR 4,16,OFF  ONE
L31FA:  .word $4000+(ON*$20)+((0/2)&$1F)+((8*$80)&$1F00) ;VCTR 0,8,ON
L31FC:  .word $4000+(OFF*$20)+((-4/2)&$1F)+((-24*$80)&$1F00) ;VCTR -4,-24,OFF
L31FE:  .word $4000+(ON*$20)+((12/2)&$1F)+((24*$80)&$1F00) ;VCTR 12,24,ON  SLASH
L3200:  .word $4000+(OFF*$20)+((-4/2)&$1F)+((-12*$80)&$1F00) ;VCTR -4,-12,OFF
L3202:  .word $4000+(ON*$20)+((8/2)&$1F)+((0*$80)&$1F00) ;VCTR 8,0,ON  TWO ON BOTTOM
L3204:  .word $4000+(ON*$20)+((0/2)&$1F)+((-6*$80)&$1F00) ;VCTR 0,-6,ON
L3206:  .word $4000+(ON*$20)+((-10/2)&$1F)+((0*$80)&$1F00) ;VCTR -10,0,ON
L3208:  .word $4000+(ON*$20)+((0/2)&$1F)+((-6*$80)&$1F00) ;VCTR 0,-6,ON
L320A:  .word $4000+(ON*$20)+((10/2)&$1F)+((0*$80)&$1F00) ;VCTR 10,0,ON
L320C:  .word $4000+(OFF*$20)+((8/2)&$1F)+((0*$80)&$1F00) ;VCTR 8,0,OFF
L320E:  .word $C000                 ;RTSL

CH_COP:          ;COPYRIGHT CIRCLE C
L3210:  .word $4000+(OFF*$20)+((8/2)&$1F)+((-6*$80)&$1F00) ;VCTR 8,-6,OFF
L3212:  .word $4000+(ON*$20)+((-8/2)&$1F)+((10*$80)&$1F00) ;VCTR -8,10,ON
L3214:  .word $4000+(ON*$20)+((0/2)&$1F)+((16*$80)&$1F00) ;VCTR 0,16,ON
L3216:  .word $4000+(ON*$20)+((8/2)&$1F)+((10*$80)&$1F00) ;VCTR 8,10,ON
L3218:  .word $4000+(ON*$20)+((16/2)&$1F)+((0*$80)&$1F00) ;VCTR 16,0,ON
;START OF C
L321A:  .word $4000+(OFF*$20)+((-2/2)&$1F)+((-10*$80)&$1F00) ;VCTR -2,-10,OFF
L321C:  .word $4000+(ON*$20)+((-10/2)&$1F)+((0*$80)&$1F00) ;VCTR -10,0,ON
L321E:  .word $4000+(ON*$20)+((0/2)&$1F)+((-18*$80)&$1F00) ;VCTR 0,-18,ON
L3220:  .word $4000+(ON*$20)+((10/2)&$1F)+((0*$80)&$1F00) ;VCTR 10,0,ON
;END OF C
L3222:  .word $4000+(OFF*$20)+((-14/2)&$1F)+((-8*$80)&$1F00) ;VCTR -14,-8,OFF
L3224:  .word $4000+(ON*$20)+((16/2)&$1F)+((0*$80)&$1F00) ;VCTR 16,0,ON
L3226:  .word $4000+(ON*$20)+((8/2)&$1F)+((10*$80)&$1F00) ;VCTR 8,10,ON
L3228:  .word $4000+(ON*$20)+((0/2)&$1F)+((16*$80)&$1F00) ;VCTR 0,16,ON
L322A:  .word $4000+(ON*$20)+((-8/2)&$1F)+((10*$80)&$1F00) ;VCTR -8,10,ON
L322C:  .word $4000+(OFF*$20)+((0/2)&$1F)+((-30*$80)&$1F00) ;VCTR 0,-30,OFF
L322E:  .word $C000                 ;RTSL

CH_HYP:
L3230:  .word $4000+(OFF*$20)+((2/2)&$1F)+((12*$80)&$1F00) ;VCTR 2,12,OFF
L3232:  .word $4000+(ON*$20)+((12/2)&$1F)+((0*$80)&$1F00) ;VCTR 12,0,ON
L3234:  .word $4000+(OFF*$20)+((10/2)&$1F)+((-12*$80)&$1F00) ;VCTR 10,-12,OFF
L3236:  .word $C000                 ;RTSL

vg_ch_lparen:
L3238:  .word $4C06                 ;SVEC 12,24,0  left parenthesis, 3 vectors in a cell 24 wide. entry $2E of the character table VGMSGA
L323A:  .word $5CFE                 ;SVEC -4,-8,7
L323C:  .word $5CE0                 ;SVEC 0,-8,7
L323E:  .word $5CE2                 ;SVEC 4,-8,7
L3240:  .word $4006                 ;SVEC 12,0,0
L3242:  .word $C000                 ;RTSL

vg_ch_rparen:
L3244:  .word $4C04                 ;SVEC 8,24,0  right parenthesis, 3 vectors in a cell 24 wide. entry $2F of VGMSGA
L3246:  .word $5CE2                 ;SVEC 4,-8,7
L3248:  .word $5CE0                 ;SVEC 0,-8,7
L324A:  .word $5CFE                 ;SVEC -4,-8,7
L324C:  .word $4008                 ;SVEC 16,0,0
L324E:  .word $C000                 ;RTSL

vg_ch_star:
L3250:  .word $4CE8                 ;SVEC 16,24,7  asterisk: two diagonals, an upright and a bar, 4 vectors in a cell 24 wide. entry $30 of VGMSGA
L3252:  .word $401C                 ;SVEC -8,0,0
L3254:  .word $54E0                 ;SVEC 0,-24,7
L3256:  .word $4004                 ;SVEC 8,0,0
L3258:  .word $4CF8                 ;SVEC -16,24,7
L325A:  .word $5A00                 ;SVEC 0,-12,0
L325C:  .word $40E8                 ;SVEC 16,0,7
L325E:  .word $5A04                 ;SVEC 8,-12,0
L3260:  .word $C000                 ;RTSL

vg_num_sep:
L3262:  .word $5D1E                 ;SVEC -4,-6,0  numeral separator, a slanted stroke 10 high set low between two digits (the same words as the Star Wars list that VJNUMS calls). view_4dig calls it for the comma of 4,321
L3264:  .word $45E1                 ;SVEC 2,10,7
L3266:  .word $5E03                 ;SVEC 6,-4,0
L3268:  .word $C000                 ;RTSL

vg_jedi_mark:
L326A:  .word $48E0                 ;SVEC 0,16,7  the Jedi mark: a slanted box 24 wide and 24 high in the caller's colour with three strokes in colour 3 inside, 7 vectors. bank 1 hs_view draws it beside JEDI KNIGHT and beside the high score entries that earned it
L326C:  .word $44EC                 ;SVEC 24,8,7
L326E:  .word $58E0                 ;SVEC 0,-16,7
L3270:  .word $5CF4                 ;SVEC -24,-8,7
L3272:  .word $0005, $0003          ;VCTR 3,5,0
L3276:  .word $6380                 ;STAT colour 3, brightness $80
L3278:  .word $43E9                 ;SVEC 18,6,7
L327A:  .word $0005, $0000          ;VCTR 0,5,0
L327E:  .word $5DF7                 ;SVEC -18,-6,7
L3280:  .word $4303                 ;SVEC 6,6,0
L3282:  .word $41E3                 ;SVEC 6,2,7
L3284:  .word $C000                 ;RTSL

VGINIT:
L3286:  .word VGCNTR                ;CNTR
L3288:  .word VGSCAL                ;SCAL
L328A:  .word $6180                 ;COLOR VGCBLU
L328C:  .word VGRW0&$1FFF, (OFF*$2000)+(VGLIMR&$1FFF) ;VOFF VGLIMR,VGRW0
L3290:  .word $0000, $E000          ;VON 0,0  DO A DOT
L3294:  .word (VGLIMB-VGRW0)&$1FFF, (OFF*$2000)+(0&$1FFF) ;VOFF 0,VGLIMB-VGRW0
L3298:  .word $0000, $E000          ;VON 0,0
L329C:  .word $0000, (OFF*$2000)+((VGLIML-VGLIMR)&$1FFF) ;VOFF VGLIML-VGLIMR,0
L32A0:  .word $0000, $E000          ;VON 0,0
L32A4:  .word (VGRW0-VGLIMB)&$1FFF, (OFF*$2000)+(0&$1FFF) ;VOFF 0,VGRW0-VGLIMB
L32A8:  .word $0000, $E000          ;VON 0,0

vg_scal_cntr:
L32AC:  .word $7200                 ;SCAL 2,$00  the tail of VGINIT used as a list of its own: SCAL 2,$00, centre, return. the pictures of sets 0 and 2 end with a JMPL to it and bank 1 obj_beam_home calls it after every object

vg_cntr:
L32AE:  .word VGCNTR                ;CNTR  centre and return: the exit most pictures of this ROM and all of set 1 take with a JMPL
L32B0:  .word $C000                 ;RTSL

VGFCWN:
L32B2:  .word VGRW0&$1FFF, (OFF*$2000)+(VGLIMR&$1FFF) ;VOFF VGLIMR,VGRW0
L32B6:  .word (VGLIMB-VGRW0)&$1FFF, $E000 ;VON 0,VGLIMB-VGRW0
L32BA:  .word $0000, $FC40          ;VON VGLIML-VGLIMR,0
L32BE:  .word (VGRW0-VGLIMB)&$1FFF, $E000 ;VON 0,VGRW0-VGLIMB
L32C2:  .word $0000, $E3C0          ;VCTR 960,0,7
L32C6:  .word (((vg_cntr-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_cntr

vg_dot:
L32C8:  .word $0000, $E000          ;VCTR 0,0,7  a dot (a vector of no length at intensity 7) and return, in the caller's colour. bank 1 JVWSTAR and JVWSTRG call it for each star
L32CC:  .word $C000                 ;RTSL

;.SBTTL LAZAR FIRE COLORS
;LAZAR FIRE
LZF0:
L32CE:  .word $63FF                 ;COLOR VGCTRQ,0FF
L32D0:  .word $C000                 ;RTSL

LZF1:
L32D2:  .word $61FF                 ;COLOR VGCBLU,0FF
L32D4:  .word $C000                 ;RTSL

LZF2:
L32D6:  .word $61CC                 ;COLOR VGCBLU,0CC
L32D8:  .word $C000                 ;RTSL

LZF3:
L32DA:  .word $6180                 ;COLOR VGCBLU,080
L32DC:  .word $C000                 ;RTSL

LZF4:
L32DE:  .word $6140                 ;COLOR VGCBLU,40
L32E0:  .word $C000                 ;RTSL

LZF5:
L32E2:  .word $6100                 ;COLOR VGCBLU,00
L32E4:  .word $C000                 ;RTSL

;LAZAR SPLASH
LZS0:
L32E6:  .word $67FF                 ;COLOR VGCWHT,0FF
L32E8:  .word (((VGLZS0-VGBASE)/2)&$1FFF)+$E000 ;JMPL VGLZS0

LZS1:
L32EA:  .word $67FF                 ;COLOR VGCWHT,0FF
L32EC:  .word (((VGLZS1-VGBASE)/2)&$1FFF)+$E000 ;JMPL VGLZS1

LZS2:
L32EE:  .word $66FF                 ;COLOR VGCYLW,0FF
L32F0:  .word (((VGLZS2-VGBASE)/2)&$1FFF)+$E000 ;JMPL VGLZS2

LZS3:
L32F2:  .word $66FF                 ;COLOR VGCYLW,0FF
L32F4:  .word (((VGLZS3-VGBASE)/2)&$1FFF)+$E000 ;JMPL VGLZS3

vg_site:
L32F6:  .word $000F, $000A          ;VCTR 10,15,0  the gun sight: four corner marks of 4 vectors each round the centre, 60 wide and 90 high, then centre and return. VWCURC calls it after the JSRL to the sight position kept in vector RAM
L32FA:  .word $4FE5                 ;SVEC 10,30,7
L32FC:  .word $1FF1, $E00A          ;VCTR 10,-15,7
L3300:  .word $1FF1, $FFEC          ;VCTR -20,-15,7
L3304:  .word $0016, $E00F          ;VCTR 15,22,7
L3308:  .word $1FCC, $1FF1          ;VCTR -15,-52,0
L330C:  .word $51E5                 ;SVEC 10,-30,7
L330E:  .word $000F, $E00A          ;VCTR 10,15,7
L3312:  .word $000F, $FFEC          ;VCTR -20,15,7
L3316:  .word $1FEA, $E00F          ;VCTR 15,-22,7
L331A:  .word $0016, $1FDD          ;VCTR -35,22,0
L331E:  .word $51FB                 ;SVEC -10,-30,7
L3320:  .word $000F, $FFF6          ;VCTR -10,15,7
L3324:  .word $000F, $E014          ;VCTR 20,15,7
L3328:  .word $1FEA, $FFF1          ;VCTR -15,-22,7
L332C:  .word $0034, $000F          ;VCTR 15,52,0
L3330:  .word $4FFB                 ;SVEC -10,30,7
L3332:  .word $1FF1, $FFF6          ;VCTR -10,-15,7
L3336:  .word $1FF1, $E014          ;VCTR 20,-15,7
L333A:  .word $0016, $FFF1          ;VCTR -15,22,7
L333E:  .word (((vg_cntr-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_cntr

VGLZD:
L3340:  .word $6180                 ;STAT colour 1, brightness $80  Star Wars VGLZD, the same words: colour 1 and a dot. no caller found in ESB
L3342:  .word $0000, $E000          ;VCTR 0,0,7
L3346:  .word $C000                 ;RTSL

VGLZS0:          ;LINE LEFT TO RIGHT
L3348:  .word $0000, (OFF*$2000)+(-7&$1FFF) ;VOFF -7.,0  LEFT MID
L334C:  .word $40E7                 ;VON 14.,0  RIGHT, MID
L334E:  .word $0000, (OFF*$2000)+(-7&$1FFF) ;VOFF -7.,0  CENTRAL
L3352:  .word $C000                 ;RTSL

VGLZS1:          ;PLUS SIGN
L3354:  .word $0000, (OFF*$2000)+(-7&$1FFF) ;VOFF -7.,0  LEFT
L3358:  .word $40E7                 ;VON 14.,0  RIGHT
L335A:  .word $0007, (OFF*$2000)+(-7&$1FFF) ;VOFF -7.,7.  TOP
L335E:  .word $59E0                 ;VON 0,-14.  BOTTOM
L3360:  .word $0007, (OFF*$2000)+(0&$1FFF) ;VOFF 0,7.  CENTRAL
L3364:  .word $C000                 ;RTSL

VGLZS2:          ;SMALL CIRCLE
L3366:  .word $0000, (OFF*$2000)+(-7&$1FFF) ;VOFF -7.,0  LEFT
L336A:  .word $0005, $E002          ;VON 2,5  UP LEFT
L336E:  .word $0002, $E005          ;VON 5,2  UP
L3372:  .word $1FFE, $E005          ;VON 5,-2  UP RIGHT
L3376:  .word $1FFB, $E002          ;VON 2,-5  RIGHT
L337A:  .word $1FFB, $FFFE          ;VON -2,-5  DN RIGHT
L337E:  .word $1FFE, $FFFB          ;VON -5,-2  DN
L3382:  .word $0002, $FFFB          ;VON -5,2  DN LEFT
L3386:  .word $0005, $FFFE          ;VON -2,5  LEFT
L338A:  .word $0000, (OFF*$2000)+(7&$1FFF) ;VOFF 7,0  CENTRAL
L338E:  .word $C000                 ;RTSL

VGLZS3:          ;LARGER LAZAR SPLASH CIRCLE
L3390:  .word $4019                 ;VOFFM -7.,0  LEFT
L3392:  .word $000F, $E004          ;VCTR 4,15,7
L3396:  .word $43E5                 ;SVEC 10,6,7
L3398:  .word $5DE5                 ;SVEC 10,-6,7
L339A:  .word $1FF1, $E004          ;VCTR 4,-15,7
L339E:  .word $1FF1, $FFFC          ;VCTR -4,-15,7
L33A2:  .word $5DFB                 ;SVEC -10,-6,7
L33A4:  .word $43FB                 ;SVEC -10,6,7
L33A6:  .word $000F, $FFFC          ;VCTR -4,15,7
L33AA:  .word $4007                 ;SVEC 14,0,0
L33AC:  .word $C000                 ;RTSL

vg_cockpit0l:
L33AE:  .word $1DB0, $0000          ;VCTR 0,-592,0  cockpit of craft type 0 (probot and walker parts), left half: 27 vectors hanging 260 to the left and 682 below the start point, in the caller's colour with the last 10 in colour 4. first picture word of cockpit_list_0
L33B2:  .word $1FC4, $0000          ;VCTR 0,-60,0
L33B6:  .word $0000, $FFC4          ;VCTR -60,0,7
L33BA:  .word $003C, $FF7E          ;VCTR -130,60,7
L33BE:  .word $1FC4, $0082          ;VCTR 130,-60,0
L33C2:  .word $51F1                 ;SVEC -30,-30,7
L33C4:  .word $0000, $1FA6          ;VCTR -90,0,0
L33C8:  .word $005A, $FFEC          ;VCTR -20,90,7
L33CC:  .word $40E5                 ;SVEC 10,0,7
L33CE:  .word $4FE5                 ;SVEC 10,30,7
L33D0:  .word $4FFB                 ;SVEC -10,30,7
L33D2:  .word $40F1                 ;SVEC -30,0,7
L33D4:  .word $51F6                 ;SVEC -20,-30,7
L33D6:  .word $51E5                 ;SVEC 10,-30,7
L33D8:  .word $4F1B                 ;SVEC -10,30,0
L33DA:  .word $003C, $E014          ;VCTR 20,60,7
L33DE:  .word $4FEA                 ;SVEC 20,30,7
L33E0:  .word $40EF                 ;SVEC 30,0,7
L33E2:  .word $51E5                 ;SVEC 10,-30,7
L33E4:  .word $1FC4, $FFEC          ;VCTR -20,-60,7
L33E8:  .word $001E, $1FD8          ;VCTR -40,30,0
L33EC:  .word $003C, $E014          ;VCTR 20,60,7
L33F0:  .word $1FC4, $000A          ;VCTR 10,-60,0
L33F4:  .word $003C, $E014          ;VCTR 20,60,7
L33F8:  .word $6480                 ;STAT colour 4, brightness $80
L33FA:  .word $4FE5                 ;SVEC 10,30,7
L33FC:  .word $1FD3, $1FF6          ;VCTR -10,-45,0
L3400:  .word $000F, $E00A          ;VCTR 10,15,7
L3404:  .word $4FE0                 ;SVEC 0,30,7
L3406:  .word $40F6                 ;SVEC -20,0,7
L3408:  .word $51FB                 ;SVEC -10,-30,7
L340A:  .word $1F2E, $1FBA          ;VCTR -70,-210,0
L340E:  .word $0078, $E028          ;VCTR 40,120,7
L3412:  .word $40EA                 ;SVEC 20,0,7
L3414:  .word $51E0                 ;SVEC 0,-30,7
L3416:  .word $1FA6, $FFE2          ;VCTR -30,-90,7
L341A:  .word $401B                 ;SVEC -10,0,0
L341C:  .word $0078, $E028          ;VCTR 40,120,7
L3420:  .word (((vg_cntr-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_cntr

vg_cockpit0r:
L3422:  .word $1DB0, $0000          ;VCTR 0,-592,0  cockpit of craft type 0, right half: the mirror image of vg_cockpit0l. second picture word of cockpit_list_0
L3426:  .word $1FC4, $0000          ;VCTR 0,-60,0
L342A:  .word $0000, $E03C          ;VCTR 60,0,7
L342E:  .word $003C, $E082          ;VCTR 130,60,7
L3432:  .word $1FC4, $1F7E          ;VCTR -130,-60,0
L3436:  .word $51EF                 ;SVEC 30,-30,7
L3438:  .word $0000, $005A          ;VCTR 90,0,0
L343C:  .word $005A, $E014          ;VCTR 20,90,7
L3440:  .word $40FB                 ;SVEC -10,0,7
L3442:  .word $4FFB                 ;SVEC -10,30,7
L3444:  .word $4FE5                 ;SVEC 10,30,7
L3446:  .word $40EF                 ;SVEC 30,0,7
L3448:  .word $51EA                 ;SVEC 20,-30,7
L344A:  .word $51FB                 ;SVEC -10,-30,7
L344C:  .word $4F05                 ;SVEC 10,30,0
L344E:  .word $003C, $FFEC          ;VCTR -20,60,7
L3452:  .word $4FF6                 ;SVEC -20,30,7
L3454:  .word $40F1                 ;SVEC -30,0,7
L3456:  .word $51FB                 ;SVEC -10,-30,7
L3458:  .word $1FC4, $E014          ;VCTR 20,-60,7
L345C:  .word $001E, $0028          ;VCTR 40,30,0
L3460:  .word $003C, $FFEC          ;VCTR -20,60,7
L3464:  .word $1FC4, $1FF6          ;VCTR -10,-60,0
L3468:  .word $003C, $FFEC          ;VCTR -20,60,7
L346C:  .word $6480                 ;STAT colour 4, brightness $80
L346E:  .word $4FFB                 ;SVEC -10,30,7
L3470:  .word $1FD3, $000A          ;VCTR 10,-45,0
L3474:  .word $000F, $FFF6          ;VCTR -10,15,7
L3478:  .word $4FE0                 ;SVEC 0,30,7
L347A:  .word $40EA                 ;SVEC 20,0,7
L347C:  .word $51E5                 ;SVEC 10,-30,7
L347E:  .word $1F2E, $0046          ;VCTR 70,-210,0
L3482:  .word $0078, $FFD8          ;VCTR -40,120,7
L3486:  .word $40F6                 ;SVEC -20,0,7
L3488:  .word $51E0                 ;SVEC 0,-30,7
L348A:  .word $1FA6, $E01E          ;VCTR 30,-90,7
L348E:  .word $4005                 ;SVEC 10,0,0
L3490:  .word $0078, $FFD8          ;VCTR -40,120,7
L3494:  .word (((vg_cntr-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_cntr

vg_cockpit1l:
L3496:  .word $1DA0, $0000          ;VCTR 0,-608,0  cockpit of craft type 1 (TIE fighter and asteroid parts), left half: a move 608 down, then vg_ckpt1_l. first picture word of cockpit_list_1
L349A:  .word (((vg_ckpt1_l-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_ckpt1_l

vg_cockpit1r:
L349C:  .word $1DA0, $0000          ;VCTR 0,-608,0  cockpit of craft type 1, right half: a move 608 down, then vg_ckpt1_r. second picture word of cockpit_list_1
L34A0:  .word (((vg_ckpt1_r-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_ckpt1_r

vg_ship_tl:
L34A2:  .word $6180                 ;STAT colour 1, brightness $80  first of the seven pieces of the picture that vw_shrink_pic draws shrinking away at the end of the asteroid part: colour 1, then the left cockpit frame that follows

vg_ckpt1_l:
L34A4:  .word $0000, $FF6A          ;VCTR -150,0,7  left window frame of the type 1 cockpit: 15 vectors, 650 wide and 449 high, the 8 inner ones in the caller's colour and the 7 of the outer frame in colour 4
L34A8:  .word $1F90, $0032          ;VCTR 50,-112,0
L34AC:  .word $0070, $E028          ;VCTR 40,112,7
L34B0:  .word $1F90, $1F42          ;VCTR -190,-112,0
L34B4:  .word $0070, $E064          ;VCTR 100,112,7
L34B8:  .word $1F90, $FF6A          ;VCTR -150,-112,7
L34BC:  .word $1F6A, $FF6A          ;VCTR -150,-150,7
L34C0:  .word $019C, $E113          ;VCTR 275,412,7
L34C4:  .word $0000, $FFCE          ;VCTR -50,0,7
L34C8:  .word $1EFA, $FF06          ;VCTR -250,-262,7
L34CC:  .word $6480                 ;STAT colour 4, brightness $80
L34CE:  .word $004B, $0113          ;VCTR 275,75,0
L34D2:  .word $00E0, $E04B          ;VCTR 75,224,7
L34D6:  .word $1FDB, $0019          ;VCTR 25,-37,0
L34DA:  .word $1F6A, $FFCE          ;VCTR -50,-150,7
L34DE:  .word $0000, $0019          ;VCTR 25,0,0
L34E2:  .word $004B, $E019          ;VCTR 25,75,7
L34E6:  .word $004B, $E000          ;VCTR 0,75,7
L34EA:  .word $0025, $FFE7          ;VCTR -25,37,7
L34EE:  .word $0000, $FF83          ;VCTR -125,0,7
L34F2:  .word $1E3F, $FE70          ;VCTR -400,-449,7
L34F6:  .word (((vg_cntr-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_cntr

vg_ship_tr:
L34F8:  .word $6180                 ;STAT colour 1, brightness $80  second piece of the vw_shrink_pic picture: colour 1, then the right cockpit frame that follows

vg_ckpt1_r:
L34FA:  .word $0000, $E096          ;VCTR 150,0,7  right window frame of the type 1 cockpit, the mirror image of vg_ckpt1_l
L34FE:  .word $1F90, $1FCE          ;VCTR -50,-112,0
L3502:  .word $0070, $FFD8          ;VCTR -40,112,7
L3506:  .word $1F90, $00BE          ;VCTR 190,-112,0
L350A:  .word $0070, $FF9C          ;VCTR -100,112,7
L350E:  .word $1F90, $E096          ;VCTR 150,-112,7
L3512:  .word $1F6A, $E096          ;VCTR 150,-150,7
L3516:  .word $019C, $FEED          ;VCTR -275,412,7
L351A:  .word $0000, $E032          ;VCTR 50,0,7
L351E:  .word $1EFA, $E0FA          ;VCTR 250,-262,7
L3522:  .word $6480                 ;STAT colour 4, brightness $80
L3524:  .word $004B, $1EED          ;VCTR -275,75,0
L3528:  .word $00E0, $FFB5          ;VCTR -75,224,7
L352C:  .word $1FDB, $1FE7          ;VCTR -25,-37,0
L3530:  .word $1F6A, $E032          ;VCTR 50,-150,7
L3534:  .word $0000, $1FE7          ;VCTR -25,0,0
L3538:  .word $004B, $FFE7          ;VCTR -25,75,7
L353C:  .word $004B, $E000          ;VCTR 0,75,7
L3540:  .word $0025, $E019          ;VCTR 25,37,7
L3544:  .word $0000, $E07D          ;VCTR 125,0,7
L3548:  .word $1E3F, $E190          ;VCTR 400,-449,7
L354C:  .word (((vg_cntr-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_cntr

vg_ship_sl:
L354E:  .word $6480                 ;STAT colour 4, brightness $80  third piece of the vw_shrink_pic picture: the left side of the outline in colour 4, 11 vectors reaching 750 to the left and 1312 below the start point
L3550:  .word $1F90, $1F9C          ;VCTR -100,-112,0
L3554:  .word $1F01, $FFCE          ;VCTR -50,-255,7
L3558:  .word $1FD3, $1FCE          ;VCTR -50,-45,0
L355C:  .word $0096, $FE3E          ;VCTR -450,150,7
L3560:  .word $1E89, $FF9C          ;VCTR -100,-375,7
L3564:  .word $1FDA, $E000          ;VCTR 0,-38,7
L3568:  .word $1ED4, $E064          ;VCTR 100,-300,7
L356C:  .word $1ED4, $E0C8          ;VCTR 200,-300,7
L3570:  .word $1FDB, $0000          ;VCTR 0,-37,0
L3574:  .word $004B, $E000          ;VCTR 0,75,7
L3578:  .word $012C, $FF38          ;VCTR -200,300,7
L357C:  .word $012C, $FF9C          ;VCTR -100,300,7
L3580:  .word $1ED4, $0064          ;VCTR 100,-300,0
L3584:  .word $00E1, $E15E          ;VCTR 350,225,7
L3588:  .word $1F1F, $0064          ;VCTR 100,-225,0
L358C:  .word $1ED4, $FF06          ;VCTR -250,-300,7
L3590:  .word (((vg_cntr-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_cntr

vg_ship_sr:
L3592:  .word $6480                 ;STAT colour 4, brightness $80  fourth piece of the vw_shrink_pic picture: the right side of the outline, the mirror image of vg_ship_sl
L3594:  .word $1F90, $0064          ;VCTR 100,-112,0
L3598:  .word $1F01, $E032          ;VCTR 50,-255,7
L359C:  .word $1FD3, $0032          ;VCTR 50,-45,0
L35A0:  .word $0096, $E1C2          ;VCTR 450,150,7
L35A4:  .word $1E89, $E064          ;VCTR 100,-375,7
L35A8:  .word $1FDA, $E000          ;VCTR 0,-38,7
L35AC:  .word $1ED4, $FF9C          ;VCTR -100,-300,7
L35B0:  .word $1ED4, $FF38          ;VCTR -200,-300,7
L35B4:  .word $1FDB, $0000          ;VCTR 0,-37,0
L35B8:  .word $004B, $E000          ;VCTR 0,75,7
L35BC:  .word $012C, $E0C8          ;VCTR 200,300,7
L35C0:  .word $012C, $E064          ;VCTR 100,300,7
L35C4:  .word $1ED4, $1F9C          ;VCTR -100,-300,0
L35C8:  .word $00E1, $FEA2          ;VCTR -350,225,7
L35CC:  .word $1F1F, $1F9C          ;VCTR -100,-225,0
L35D0:  .word $1ED4, $E0FA          ;VCTR 250,-300,7
L35D4:  .word (((vg_cntr-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_cntr

vg_ship_bot:
L35D6:  .word $64FF                 ;STAT colour 4, brightness $FF  fifth piece of the vw_shrink_pic picture: the bottom of the outline, a double V 900 wide in colour 4 at full brightness, 8 vectors, 1575 below the start point
L35D8:  .word $1AE0, $1E3E          ;VCTR -450,-1312,0
L35DC:  .word $1F1F, $E12C          ;VCTR 300,-225,7
L35E0:  .word $0000, $E12C          ;VCTR 300,0,7
L35E4:  .word $00E1, $E12C          ;VCTR 300,225,7
L35E8:  .word $1FF1, $1FEC          ;VCTR -20,-15,0
L35EC:  .word $1FDA, $E000          ;VCTR 0,-38,7
L35F0:  .word $1F2E, $FEE8          ;VCTR -280,-210,7
L35F4:  .word $0000, $FED4          ;VCTR -300,0,7
L35F8:  .word $00D2, $FEE8          ;VCTR -280,210,7
L35FC:  .word $0026, $E000          ;VCTR 0,38,7
L3600:  .word (((vg_cntr-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_cntr

vg_ship_mid:
L3602:  .word $6180                 ;STAT colour 1, brightness $80  sixth piece of the vw_shrink_pic picture: a six-sided panel in the middle in colour 1, 600 wide, 13 vectors. what it stands for is not shown by the data
L3604:  .word $1C57, $00C8          ;VCTR 200,-937,0
L3608:  .word $004B, $E000          ;VCTR 0,75,7
L360C:  .word $0000, $1E70          ;VCTR -400,0,0
L3610:  .word $1FB5, $E000          ;VCTR 0,-75,7
L3614:  .word $012C, $1F9C          ;VCTR -100,300,0
L3618:  .word $1F1F, $E064          ;VCTR 100,-225,7
L361C:  .word $0000, $E190          ;VCTR 400,0,7
L3620:  .word $00E1, $E064          ;VCTR 100,225,7
L3624:  .word $1FB5, $E000          ;VCTR 0,-75,7
L3628:  .word $1F1F, $FF9C          ;VCTR -100,-225,7
L362C:  .word $0000, $FE70          ;VCTR -400,0,7
L3630:  .word $00E1, $FF9C          ;VCTR -100,225,7
L3634:  .word $004B, $E000          ;VCTR 0,75,7
L3638:  .word $010E, $E078          ;VCTR 120,270,7
L363C:  .word $0000, $E168          ;VCTR 360,0,7
L3640:  .word $1EF2, $E078          ;VCTR 120,-270,7
L3644:  .word (((vg_cntr-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_cntr

vg_ship_det:
L3646:  .word $6480                 ;STAT colour 4, brightness $80  seventh piece of the vw_shrink_pic picture: detail on the left side in colours 4, 1 and 6, 20 vectors
L3648:  .word $1D56, $1DDA          ;VCTR -550,-682,0
L364C:  .word $002D, $E032          ;VCTR 50,45,7
L3650:  .word $004B, $E01E          ;VCTR 30,75,7
L3654:  .word $1FB5, $E00A          ;VCTR 10,-75,7
L3658:  .word $1FB5, $FFEC          ;VCTR -20,-75,7
L365C:  .word $40F1                 ;SVEC -30,0,7
L365E:  .word $4FFB                 ;SVEC -10,30,7
L3660:  .word $40F1                 ;SVEC -30,0,7
L3662:  .word $6180                 ;STAT colour 1, brightness $80
L3664:  .word $1FE2, $FF9C          ;VCTR -100,-30,7
L3668:  .word $0096, $E032          ;VCTR 50,150,7
L366C:  .word $004B, $E032          ;VCTR 50,75,7
L3670:  .word $004B, $E064          ;VCTR 100,75,7
L3674:  .word $1F6A, $FFCE          ;VCTR -50,-150,7
L3678:  .word $1FB5, $FFCE          ;VCTR -50,-75,7
L367C:  .word $1FB5, $FF9C          ;VCTR -100,-75,7
L3680:  .word $0096, $0032          ;VCTR 50,150,0
L3684:  .word $1FE2, $E032          ;VCTR 50,-30,7
L3688:  .word $4F0A                 ;SVEC 20,30,0
L368A:  .word $004B, $FFEC          ;VCTR -20,75,7
L368E:  .word $004B, $0064          ;VCTR 100,75,0
L3692:  .word $1F6A, $FFEC          ;VCTR -20,-150,7
L3696:  .word $6680                 ;STAT colour 6, brightness $80
L3698:  .word $1FF1, $1FD8          ;VCTR -40,-15,0
L369C:  .word $000F, $FFE2          ;VCTR -30,15,7
L36A0:  .word $1FF1, $FFF6          ;VCTR -10,-15,7
L36A4:  .word $1FD3, $E00A          ;VCTR 10,-45,7
L36A8:  .word (((vg_cntr-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_cntr

;.SBTTL GUNSHOT PICTURES
vg_gnb0:
L36AA:  .word $64FF                 ;COLOR VGCRED,0FF  enemy shot picture 0 of 4, Star Wars GNB0 moved here from the pseudo ROM with its tip call changed to JSRL $001C: 16 vectors in colour 4 at full brightness radiating from the start point, with the tip picture drawn in the flash colour (JSRL $0026) at six of the ends. every fourth frame the IRQ puts a JMPL to the next of the four in vector RAM $001A (table VTGNB), which slapstic page 1 calls for a shot in flight
L36AC:  .word $0078, $E00A          ;AON 2,16
L36B0:  .word $1FD3, $001E          ;AOFF 8,10
L36B4:  .word $1FB5, $FFD8          ;AON 0,0
L36B8:  .word $003C, $E04B          ;AON 15,8
L36BC:  .word $A013                 ;JSRL $0026
L36BE:  .word $A00E                 ;JSRL $001C
L36C0:  .word $64FF
L36C2:  .word $1FD3, $1FFB          ;AOFF 14,2
L36C6:  .word $1FF1, $FFBA          ;AON 0,0
L36CA:  .word $1FD3, $E050          ;AON 16,-6
L36CE:  .word $A013                 ;JSRL $0026
L36D0:  .word $A00E                 ;JSRL $001C
L36D2:  .word $64FF
L36D4:  .word $1FD3, $1FEC          ;AOFF 12,-12
L36D8:  .word $005A, $FFC4          ;AON 0,0
L36DC:  .word $1FB5, $E01E          ;AON 6,-10
L36E0:  .word $5116                 ;AOFF 2,-14
L36E2:  .word $0069, $FFF6          ;AON 0,0
L36E6:  .word $1F88, $FFE2          ;AON -6,-16
L36EA:  .word $A013                 ;JSRL $0026
L36EC:  .word $A00E                 ;JSRL $001C
L36EE:  .word $64FF
L36F0:  .word $002D, $1FF6          ;AOFF -8,-10
L36F4:  .word $004B, $E028          ;AON 0,0
L36F8:  .word $1FC4, $FFC4          ;AON -12,-8
L36FC:  .word $002D, $000A          ;AOFF -10,-2
L3700:  .word $000F, $E032          ;AON 0,0
L3704:  .word $000F, $FFB0          ;AON -16,2
L3708:  .word $A013                 ;JSRL $0026
L370A:  .word $A00E                 ;JSRL $001C
L370C:  .word $64FF
L370E:  .word $002D, $0000          ;AOFF -16,8
L3712:  .word $1FC4, $E050          ;AON 0,0
L3716:  .word $003C, $FFE2          ;AON -6,8
L371A:  .word $003C, $0000          ;AOFF -6,16
L371E:  .word $A013                 ;JSRL $0026
L3720:  .word $A00E                 ;JSRL $001C
L3722:  .word $64FF                 ;STAT colour 4, brightness $FF
L3724:  .word $1F88, $E01E          ;VCTR 30,-120,7
L3728:  .word $A013                 ;JSRL $0026
L372A:  .word $A00E                 ;JSRL $001C
L372C:  .word $64FF
L372E:  .word $C000                 ;RTSL

vg_gnb1:
L3730:  .word $64FF                 ;COLOR VGCRED,0FF  enemy shot picture 1 of 4, Star Wars GNB1 moved here from the pseudo ROM with its tip call changed to JSRL $001C: 16 vectors in colour 4 at full brightness radiating from the start point, with the tip picture drawn in the flash colour (JSRL $0026) at six of the ends
L3732:  .word $005A, $E00F          ;AON 3,12
L3736:  .word $1FF1, $000F          ;AOFF 6,10
L373A:  .word $1FB5, $FFE2          ;AON 0,0
L373E:  .word $002D, $E050          ;AON 16,6
L3742:  .word $A013                 ;JSRL $0026
L3744:  .word $A00E                 ;JSRL $001C
L3746:  .word $64FF
L3748:  .word $1FCC, $0005          ;AOFF 17,-1
L374C:  .word $0007, $FFAB          ;AON 0,0
L3750:  .word $1FB5, $E046          ;AON 14,-10
L3754:  .word $A013                 ;JSRL $0026
L3756:  .word $A00E                 ;JSRL $001C
L3758:  .word $64FF
L375A:  .word $1FF1, $1FCE          ;AOFF 4,-12
L375E:  .word $005A, $FFEC          ;AON 0,0
L3762:  .word $1F88, $E000          ;AON 0,-16
L3766:  .word $4F16                 ;AOFF -4,-12
L3768:  .word $005A, $E014          ;AON 0,0
L376C:  .word $1F90, $FFCE          ;AON -10,-15
L3770:  .word $A013                 ;JSRL $0026
L3772:  .word $A00E                 ;JSRL $001C
L3774:  .word $64FF
L3776:  .word $003C, $1FF1          ;AOFF -13,-7
L377A:  .word $0034, $E041          ;AON 0,0
L377E:  .word $1FE2, $FFB0          ;AON -16,-4
L3782:  .word $002D, $0014          ;AOFF -12,2
L3786:  .word $1FF1, $E03C          ;AON 0,0
L378A:  .word $002D, $FFB0          ;AON -16,6
L378E:  .word $A013                 ;JSRL $0026
L3790:  .word $A00E                 ;JSRL $001C
L3792:  .word $64FF
L3794:  .word $4F05                 ;AOFF -14,10
L3796:  .word $1FB5, $E046          ;AON 0,0
L379A:  .word $005A, $FFE2          ;AON -6,12
L379E:  .word $0025, $001E          ;AOFF 0,17
L37A2:  .word $A013                 ;JSRL $0026
L37A4:  .word $A00E                 ;JSRL $001C
L37A6:  .word $64FF                 ;STAT colour 4, brightness $FF
L37A8:  .word $1F81, $E000          ;VCTR 0,-127,7
L37AC:  .word $A013                 ;JSRL $0026
L37AE:  .word $A00E                 ;JSRL $001C
L37B0:  .word $64FF
L37B2:  .word $C000                 ;RTSL

vg_gnb2:
L37B4:  .word $64FF                 ;COLOR VGCRED,0FF  enemy shot picture 2 of 4, Star Wars GNB2 moved here from the pseudo ROM with its tip call changed to JSRL $001C: 16 vectors in colour 4 at full brightness radiating from the start point, with the tip picture drawn in the flash colour (JSRL $0026) at six of the ends
L37B6:  .word $005A, $E00A          ;AON 2,12
L37BA:  .word $4B0F                 ;AOFF 8,15
L37BC:  .word $A013                 ;JSRL $0026
L37BE:  .word $A00E                 ;JSRL $001C
L37C0:  .word $64FF
L37C2:  .word $1F90, $FFD8          ;AON 0,0
L37C6:  .word $004B, $E03C          ;AON 12,10
L37CA:  .word $1FD3, $1FF6          ;AOFF 10,4
L37CE:  .word $1FE2, $FFCE          ;AON 0,0
L37D2:  .word $000F, $E055          ;AON 17,2
L37D6:  .word $A013                 ;JSRL $0026
L37D8:  .word $A00E                 ;JSRL $001C
L37DA:  .word $64FF
L37DC:  .word $1FE2, $1FF1          ;AOFF 14,-2
L37E0:  .word $000F, $FFBA          ;AON 0,0
L37E4:  .word $1FC4, $E046          ;AON 14,-8
L37E8:  .word $1FD3, $1FEC          ;AOFF 10,-14
L37EC:  .word $A013                 ;JSRL $0026
L37EE:  .word $A00E                 ;JSRL $001C
L37F0:  .word $64FF
L37F2:  .word $0069, $FFCE          ;AON 0,0
L37F6:  .word $1F97, $FFF6          ;AON -2,-14
L37FA:  .word $4F16                 ;AOFF -6,-10
L37FC:  .word $004B, $E01E          ;AON 0,0
L3800:  .word $1FA6, $FFBA          ;AON -14,-12
L3804:  .word $0026, $1FF6          ;AOFF -16,-7
L3808:  .word $A013                 ;JSRL $0026
L380A:  .word $A00E                 ;JSRL $001C
L380C:  .word $64FF
L380E:  .word $0034, $E050          ;AON 0,0
L3812:  .word $1FF1, $FFA6          ;AON -18,-2
L3816:  .word $002D, $0028          ;AOFF -10,4
L381A:  .word $1FE2, $E032          ;AON 0,0
L381E:  .word $005A, $FFC4          ;AON -12,12
L3822:  .word $A013                 ;JSRL $0026
L3824:  .word $A00E                 ;JSRL $001C
L3826:  .word $64FF                 ;STAT colour 4, brightness $FF
L3828:  .word $002D, $0032          ;VCTR 50,45,0
L382C:  .word $1F79, $E00A          ;VCTR 10,-135,7
L3830:  .word $A013                 ;JSRL $0026
L3832:  .word $A00E                 ;JSRL $001C
L3834:  .word $64FF                 ;STAT colour 4, brightness $FF
L3836:  .word $C000                 ;RTSL

vg_gnb3:
L3838:  .word $64FF                 ;STAT colour 4, brightness $FF  enemy shot picture 3 of 4, Star Wars GNB3 moved here from the pseudo ROM with its tip call changed to JSRL $001C: 16 vectors in colour 4 at full brightness radiating from the start point, with the tip picture drawn in the flash colour (JSRL $0026) at six of the ends
L383A:  .word $1F81, $E00F          ;VCTR 15,-127,7
L383E:  .word $A013                 ;JSRL $0026
L3840:  .word $A00E                 ;JSRL $001C
L3842:  .word $64FF
L3844:  .word $0034, $0019          ;AOFF 8,-10
L3848:  .word $004B, $FFD8          ;AON 0,0
L384C:  .word $1FB5, $E03C          ;AON 12,-10
L3850:  .word $0035, $0005          ;AOFF 13,-3
L3854:  .word $0016, $FFBF          ;AON 0,0
L3858:  .word $1FF1, $E055          ;AON 17,-2
L385C:  .word $A013                 ;JSRL $0026
L385E:  .word $A00E                 ;JSRL $001C
L3860:  .word $64FF
L3862:  .word $002D, $1FF1          ;AOFF 14,4
L3866:  .word $1FE2, $FFBA          ;AON 0,0
L386A:  .word $004B, $E046          ;AON 14,10
L386E:  .word $0016, $1FF1          ;AOFF 11,13
L3872:  .word $A013                 ;JSRL $0026
L3874:  .word $A00E                 ;JSRL $001C
L3876:  .word $64FF
L3878:  .word $1F9F, $FFC9          ;AON 0,0
L387C:  .word $0069, $FFF1          ;AON -3,14
L3880:  .word $4011                 ;AOFF -9,14
L3882:  .word $A013                 ;JSRL $0026
L3884:  .word $A00E                 ;JSRL $001C
L3886:  .word $64FF
L3888:  .word $1F97, $E02D          ;AON 0,0
L388C:  .word $004B, $FFBA          ;AON -14,10
L3890:  .word $1FDA, $1FF6          ;AOFF -16,5
L3894:  .word $1FDB, $E050          ;AON 0,0
L3898:  .word $0000, $FFAB          ;AON -17,0
L389C:  .word $A013                 ;JSRL $0026
L389E:  .word $A00E                 ;JSRL $001C
L38A0:  .word $64FF
L38A2:  .word $1FE2, $0023          ;AOFF -10,-4
L38A6:  .word $001E, $E032          ;AON 0,0
L38AA:  .word $1FA6, $FFC4          ;AON -12,-12
L38AE:  .word $1FE2, $0028          ;AOFF -4,-16
L38B2:  .word $0078, $E014          ;AON 0,0
L38B6:  .word $A013                 ;JSRL $0026
L38B8:  .word $A00E                 ;JSRL $001C
L38BA:  .word $64FF
L38BC:  .word $C000                 ;RTSL

GNT0:
L38BE:  .word $4FE0                 ;AON 0,2  Star Wars GNT0, the same words, moved here from the pseudo ROM: shot tip fuse picture 0 of 4, three lines crossing at the start point, 6 vectors. every frame the IRQ puts a JMPL to the next of the four in vector RAM $001C (table VTGNT), which the vg_gnb and vg_gnx pictures call
L38C0:  .word $0000, $003C          ;AOFF 6,2
L38C4:  .word $1FE2, $FFC4          ;AON 0,0
L38C8:  .word $1FE2, $E028          ;AON 4,-2
L38CC:  .word $1FE2, $1FD8          ;AOFF 0,-4
L38D0:  .word $003C, $E000          ;AON 0,0
L38D4:  .word $1FE2, $FFD8          ;AON -4,-2
L38D8:  .word $005A, $0000          ;AOFF -4,4
L38DC:  .word $1FC4, $E028          ;AON 0,0
L38E0:  .word $C000                 ;RTSL

GNT1:
L38E2:  .word $40F6                 ;AON -2,0  Star Wars GNT1, the same words, moved here from the pseudo ROM: shot tip fuse picture 1 of 4, three lines crossing at the start point, 6 vectors
L38E4:  .word $005A, $0000          ;AOFF -2,6
L38E8:  .word $1FA6, $E014          ;AON 0,0
L38EC:  .word $003C, $E014          ;AON 2,4
L38F0:  .word $1FC4, $0014          ;AOFF 4,0
L38F4:  .word $0000, $FFD8          ;AON 0,0
L38F8:  .word $1FC4, $E014          ;AON 2,-4
L38FC:  .word $0000, $1FC4          ;AOFF -4,-4
L3900:  .word $003C, $E028          ;AON 0,0
L3904:  .word $C000                 ;RTSL

GNT2:
L3906:  .word $51E0                 ;AON 0,-2  Star Wars GNT2, the same words, moved here from the pseudo ROM: shot tip fuse picture 2 of 4, three lines crossing at the start point, 6 vectors
L3908:  .word $0000, $1FC4          ;AOFF -6,-2
L390C:  .word $001E, $E03C          ;AON 0,0
L3910:  .word $001E, $FFD8          ;AON -4,2
L3914:  .word $001E, $0028          ;AOFF 0,4
L3918:  .word $1FC4, $E000          ;AON 0,0
L391C:  .word $001E, $E028          ;AON 4,2
L3920:  .word $1FA6, $0000          ;AOFF 4,-4
L3924:  .word $003C, $FFD8          ;AON 0,0
L3928:  .word $C000                 ;RTSL

GNT3:
L392A:  .word $40EA                 ;AON 2,0  Star Wars GNT3, the same words, moved here from the pseudo ROM: shot tip fuse picture 3 of 4, three lines crossing at the start point, 6 vectors
L392C:  .word $1FA6, $0000          ;AOFF 2,-6
L3930:  .word $005A, $FFEC          ;AON 0,0
L3934:  .word $1FC4, $FFEC          ;AON -2,-4
L3938:  .word $003C, $1FEC          ;AOFF -4,0
L393C:  .word $0000, $E028          ;AON 0,0
L3940:  .word $003C, $FFEC          ;AON -2,4
L3944:  .word $0000, $003C          ;AOFF 4,4
L3948:  .word $1FC4, $FFD8          ;AON 0,0
L394C:  .word $C000                 ;RTSL

vg_gnx0:
L394E:  .word $00B4, $00E1          ;VCTR 225,180,0  shot explosion picture 0 of 4, the moves of Star Wars GNX0 with the calls changed to $001C and the last one made a JMPL: draws nothing itself, the tip picture at five places round the start point. every fourth frame the IRQ puts a JMPL to the next of the four in vector RAM $001E (table VTGNX), which slapstic page 1 GN1DRW and GLOWVW call for a shot that was hit or reached the player
L3952:  .word $A00E                 ;JSRL $001C
L3954:  .word $1EC5, $000F          ;VCTR 15,-315,0
L3958:  .word $A00E                 ;JSRL $001C
L395A:  .word $1F1F, $1EB6          ;VCTR -330,-225,0
L395E:  .word $A00E                 ;JSRL $001C
L3960:  .word $0195, $1F6A          ;VCTR -150,405,0
L3964:  .word $A00E                 ;JSRL $001C
L3966:  .word $013B, $0096          ;VCTR 150,315,0
L396A:  .word $E00E                 ;JMPL $001C

vg_gnx1:
L396C:  .word $0087, $00F0          ;VCTR 240,135,0  shot explosion picture 1 of 4, the moves of Star Wars GNX1 with the calls changed to $001C and the last one made a JMPL: draws nothing itself, the tip picture at five places round the start point
L3970:  .word $A00E                 ;JSRL $001C
L3972:  .word $1E98, $1FE2          ;VCTR -30,-360,0
L3976:  .word $A00E                 ;JSRL $001C
L3978:  .word $1F90, $1E98          ;VCTR -360,-112,0
L397C:  .word $A00E                 ;JSRL $001C
L397E:  .word $01D8, $1FA6          ;VCTR -90,472,0
L3982:  .word $A00E                 ;JSRL $001C
L3984:  .word $00F7, $00F0          ;VCTR 240,247,0
L3988:  .word $E00E                 ;JMPL $001C

vg_gnx2:
L398A:  .word $0151, $0078          ;VCTR 120,337,0  shot explosion picture 2 of 4, the moves of Star Wars GNX2 with the calls changed to $001C and the last one made a JMPL: draws nothing itself, the tip picture at five places round the start point
L398E:  .word $A00E                 ;JSRL $001C
L3990:  .word $1EDC, $0087          ;VCTR 135,-292,0
L3994:  .word $A00E                 ;JSRL $001C
L3996:  .word $1E98, $1F97          ;VCTR -105,-360,0
L399A:  .word $A00E                 ;JSRL $001C
L399C:  .word $009E, $1E7A          ;VCTR -390,158,0
L39A0:  .word $A00E                 ;JSRL $001C
L39A2:  .word $01AB, $003C          ;VCTR 60,427,0
L39A6:  .word $E00E                 ;JMPL $001C

vg_gnx3:
L39A8:  .word $1E82, $002D          ;VCTR 45,-382,0  shot explosion picture 3 of 4, the moves of Star Wars GNX3 with the calls changed to $001C and the last one made a JMPL: draws nothing itself, the tip picture at five places round the start point
L39AC:  .word $A00E                 ;JSRL $001C
L39AE:  .word $0151, $00D2          ;VCTR 210,337,0
L39B2:  .word $A00E                 ;JSRL $001C
L39B4:  .word $0151, $1FA6          ;VCTR -90,337,0
L39B8:  .word $A00E                 ;JSRL $001C
L39BA:  .word $0017, $1ED4          ;VCTR -300,23,0
L39BE:  .word $A00E                 ;JSRL $001C
L39C0:  .word $1EC5, $1F88          ;VCTR -120,-315,0
L39C4:  .word $E00E                 ;JMPL $001C

vg_spark3:
L39C6:  .word $0022, $FFF3          ;VCTR -13,34,7  sparkle picture 3 of 4: a jagged star of 18 vectors about 150 wide and 230 high round the start point, in the caller's colour
L39CA:  .word $0056, $E00D          ;VCTR 13,86,7
L39CE:  .word $1FAA, $E00D          ;VCTR 13,-86,7
L39D2:  .word $1FDE, $1FF3          ;VCTR -13,-34,0
L39D6:  .word $0022, $E00D          ;VCTR 13,34,7
L39DA:  .word $001A, $E038          ;VCTR 56,26,7
L39DE:  .word $1FC4, $FFD6          ;VCTR -42,-60,7
L39E2:  .word $0000, $1FE5          ;VCTR -27,0,0
L39E6:  .word $0000, $E01B          ;VCTR 27,0,7
L39EA:  .word $1FC4, $E02A          ;VCTR 42,-60,7
L39EE:  .word $001A, $FFC8          ;VCTR -56,26,7
L39F2:  .word $0022, $1FF3          ;VCTR -13,34,0
L39F6:  .word $1FDE, $E00D          ;VCTR 13,-34,7
L39FA:  .word $1FAA, $FFF3          ;VCTR -13,-86,7
L39FE:  .word $0056, $FFF3          ;VCTR -13,86,7
L3A02:  .word $0022, $000D          ;VCTR 13,34,0
L3A06:  .word $1FDE, $FFF3          ;VCTR -13,-34,7
L3A0A:  .word $1FE6, $FFC8          ;VCTR -56,-26,7
L3A0E:  .word $003C, $E02A          ;VCTR 42,60,7
L3A12:  .word $0000, $001B          ;VCTR 27,0,0
L3A16:  .word $0000, $FFE5          ;VCTR -27,0,7
L3A1A:  .word $003C, $FFD6          ;VCTR -42,60,7
L3A1E:  .word $1FE6, $E038          ;VCTR 56,-26,7
L3A22:  .word $1FDE, $000D          ;VCTR 13,-34,0
L3A26:  .word $C000                 ;RTSL

vg_spark2:
L3A28:  .word $001C, $FFED          ;VCTR -19,28,7  sparkle picture 2 of 4: a jagged star of 18 vectors about 150 wide and 230 high round the start point, in the caller's colour
L3A2C:  .word $0057, $FFFF          ;VCTR -1,87,7
L3A30:  .word $1FB4, $E01B          ;VCTR 27,-76,7
L3A34:  .word $1FD9, $1FF9          ;VCTR -7,-39,0
L3A38:  .word $0027, $E007          ;VCTR 7,39,7
L3A3C:  .word $002D, $E031          ;VCTR 49,45,7
L3A40:  .word $1FB6, $FFE2          ;VCTR -30,-74,7
L3A44:  .word $5B13                 ;SVEC -26,-10,0
L3A46:  .word $45ED                 ;SVEC 26,10,7
L3A48:  .word $1FD8, $E033          ;VCTR 51,-40,7
L3A4C:  .word $0002, $FFC6          ;VCTR -58,2,7
L3A50:  .word $001C, $1FED          ;VCTR -19,28,0
L3A54:  .word $1FE4, $E013          ;VCTR 19,-28,7
L3A58:  .word $1FA9, $E001          ;VCTR 1,-87,7
L3A5C:  .word $004C, $FFE5          ;VCTR -27,76,7
L3A60:  .word $0027, $0007          ;VCTR 7,39,0
L3A64:  .word $1FD9, $FFF9          ;VCTR -7,-39,7
L3A68:  .word $1FD3, $FFCF          ;VCTR -49,-45,7
L3A6C:  .word $004A, $E01E          ;VCTR 30,74,7
L3A70:  .word $450D                 ;SVEC 26,10,0
L3A72:  .word $5BF3                 ;SVEC -26,-10,7
L3A74:  .word $0028, $FFCD          ;VCTR -51,40,7
L3A78:  .word $1FFE, $E03A          ;VCTR 58,-2,7
L3A7C:  .word $1FE4, $0013          ;VCTR 19,-28,0
L3A80:  .word $C000                 ;RTSL

vg_spark1:
L3A82:  .word $0013, $FFE9          ;VCTR -23,19,7  sparkle picture 1 of 4: a jagged star of 18 vectors about 150 wide and 230 high round the start point, in the caller's colour
L3A86:  .word $0054, $FFEF          ;VCTR -17,84,7
L3A8A:  .word $1FC1, $E028          ;VCTR 40,-63,7
L3A8E:  .word $1FD8, $0000          ;VCTR 0,-40,0
L3A92:  .word $0028, $E000          ;VCTR 0,40,7
L3A96:  .word $003F, $E028          ;VCTR 40,63,7
L3A9A:  .word $1FAC, $FFEF          ;VCTR -17,-84,7
L3A9E:  .word $1FED, $1FE9          ;VCTR -23,-19,0
L3AA2:  .word $0013, $E017          ;VCTR 23,19,7
L3AA6:  .word $1FED, $E039          ;VCTR 57,-19,7
L3AAA:  .word $1FED, $FFC7          ;VCTR -57,-19,7
L3AAE:  .word $0013, $1FE9          ;VCTR -23,19,0
L3AB2:  .word $1FED, $E017          ;VCTR 23,-19,7
L3AB6:  .word $1FAC, $E011          ;VCTR 17,-84,7
L3ABA:  .word $003F, $FFD8          ;VCTR -40,63,7
L3ABE:  .word $0028, $0000          ;VCTR 0,40,0
L3AC2:  .word $1FD8, $E000          ;VCTR 0,-40,7
L3AC6:  .word $1FC1, $FFD8          ;VCTR -40,-63,7
L3ACA:  .word $0054, $E011          ;VCTR 17,84,7
L3ACE:  .word $0013, $0017          ;VCTR 23,19,0
L3AD2:  .word $1FED, $FFE9          ;VCTR -23,-19,7
L3AD6:  .word $0013, $FFC7          ;VCTR -57,19,7
L3ADA:  .word $0013, $E039          ;VCTR 57,19,7
L3ADE:  .word $1FED, $0017          ;VCTR 23,-19,0
L3AE2:  .word $C000                 ;RTSL

vg_spark0:
L3AE4:  .word $45F3                 ;SVEC -26,10,7  sparkle picture 0 of 4: a jagged star of 18 vectors about 150 wide and 230 high round the start point, in the caller's colour. every second frame the IRQ puts a JMPL to the next of the four in vector RAM $0020 (table spark_tab), which page 1 GN1DRW calls for a walker's shot and the vg_sparks pictures call six times
L3AE6:  .word $004A, $FFE2          ;VCTR -30,74,7
L3AEA:  .word $1FD3, $E031          ;VCTR 49,-45,7
L3AEE:  .word $1FD9, $0007          ;VCTR 7,-39,0
L3AF2:  .word $0027, $FFF9          ;VCTR -7,39,7
L3AF6:  .word $004C, $E01B          ;VCTR 27,76,7
L3AFA:  .word $1FA9, $FFFF          ;VCTR -1,-87,7
L3AFE:  .word $1FE4, $1FED          ;VCTR -19,-28,0
L3B02:  .word $001C, $E013          ;VCTR 19,28,7
L3B06:  .word $0002, $E03A          ;VCTR 58,2,7
L3B0A:  .word $1FD8, $FFCD          ;VCTR -51,-40,7
L3B0E:  .word $4513                 ;SVEC -26,10,0
L3B10:  .word $5BED                 ;SVEC 26,-10,7
L3B12:  .word $1FB6, $E01E          ;VCTR 30,-74,7
L3B16:  .word $002D, $FFCF          ;VCTR -49,45,7
L3B1A:  .word $0027, $1FF9          ;VCTR -7,39,0
L3B1E:  .word $1FD9, $E007          ;VCTR 7,-39,7
L3B22:  .word $1FB4, $FFE5          ;VCTR -27,-76,7
L3B26:  .word $0057, $E001          ;VCTR 1,87,7
L3B2A:  .word $001C, $0013          ;VCTR 19,28,0
L3B2E:  .word $1FE4, $FFED          ;VCTR -19,-28,7
L3B32:  .word $1FFE, $FFC6          ;VCTR -58,-2,7
L3B36:  .word $0028, $E033          ;VCTR 51,40,7
L3B3A:  .word $5B0D                 ;SVEC 26,-10,0
L3B3C:  .word $C000                 ;RTSL

vg_sparks3:
L3B3E:  .word $0168, $0000          ;VCTR 0,360,0  ring of sparkles 3 of 4: draws nothing itself, the sparkle picture (JSRL $0020) at six places on an oval 480 wide and 720 high round the start point, each of the four turned about 15 degrees further
L3B42:  .word $A010                 ;JSRL $0020
L3B44:  .word $1F4C, $00CF          ;VCTR 207,-180,0
L3B48:  .word $A010                 ;JSRL $0020
L3B4A:  .word $1E98, $0000          ;VCTR 0,-360,0
L3B4E:  .word $A010                 ;JSRL $0020
L3B50:  .word $1F4C, $1F31          ;VCTR -207,-180,0
L3B54:  .word $A010                 ;JSRL $0020
L3B56:  .word $00B4, $1F31          ;VCTR -207,180,0
L3B5A:  .word $A010                 ;JSRL $0020
L3B5C:  .word $0168, $0000          ;VCTR 0,360,0
L3B60:  .word $A010                 ;JSRL $0020
L3B62:  .word $C000                 ;RTSL

vg_sparks2:
L3B64:  .word $015A, $1FC4          ;VCTR -60,346,0  ring of sparkles 2 of 4: draws nothing itself, the sparkle picture (JSRL $0020) at six places on an oval 480 wide and 720 high round the start point, each of the four turned about 15 degrees further
L3B68:  .word $A010                 ;JSRL $0020
L3B6A:  .word $1FA2, $00E4          ;VCTR 228,-94,0
L3B6E:  .word $A010                 ;JSRL $0020
L3B70:  .word $1EAA, $003F          ;VCTR 63,-342,0
L3B74:  .word $A010                 ;JSRL $0020
L3B76:  .word $1F00, $1F55          ;VCTR -171,-256,0
L3B7A:  .word $A010                 ;JSRL $0020
L3B7C:  .word $005E, $1F1C          ;VCTR -228,94,0
L3B80:  .word $A010                 ;JSRL $0020
L3B82:  .word $0156, $1FC1          ;VCTR -63,342,0
L3B86:  .word $A010                 ;JSRL $0020
L3B88:  .word $C000                 ;RTSL

vg_sparks1:
L3B8A:  .word $0136, $1F88          ;VCTR -120,310,0  ring of sparkles 1 of 4: draws nothing itself, the sparkle picture (JSRL $0020) at six places on an oval 480 wide and 720 high round the start point, each of the four turned about 15 degrees further
L3B8E:  .word $A010                 ;JSRL $0020
L3B90:  .word $0000, $00F0          ;VCTR 240,0,0
L3B94:  .word $A010                 ;JSRL $0020
L3B96:  .word $1ECA, $0078          ;VCTR 120,-310,0
L3B9A:  .word $A010                 ;JSRL $0020
L3B9C:  .word $1ECA, $1F88          ;VCTR -120,-310,0
L3BA0:  .word $A010                 ;JSRL $0020
L3BA2:  .word $0000, $1F10          ;VCTR -240,0,0
L3BA6:  .word $A010                 ;JSRL $0020
L3BA8:  .word $0136, $1F88          ;VCTR -120,310,0
L3BAC:  .word $A010                 ;JSRL $0020
L3BAE:  .word $C000                 ;RTSL

vg_sparks0:
L3BB0:  .word $00FC, $1F58          ;VCTR -168,252,0  ring of sparkles 0 of 4: draws nothing itself, the sparkle picture (JSRL $0020) at six places on an oval 480 wide and 720 high round the start point, each of the four turned about 15 degrees further. every frame the IRQ puts a JMPL to the next of the four in vector RAM $0022 (table sparks_tab), which page 1 GN1DRW and GLOWVW call for a walker's shot that was hit or reached the player
L3BB4:  .word $A010                 ;JSRL $0020
L3BB6:  .word $005E, $00E4          ;VCTR 228,94,0
L3BBA:  .word $A010                 ;JSRL $0020
L3BBC:  .word $1F00, $00AB          ;VCTR 171,-256,0
L3BC0:  .word $A010                 ;JSRL $0020
L3BC2:  .word $1EAA, $1FC1          ;VCTR -63,-342,0
L3BC6:  .word $A010                 ;JSRL $0020
L3BC8:  .word $1FA2, $1F1C          ;VCTR -228,-94,0
L3BCC:  .word $A010                 ;JSRL $0020
L3BCE:  .word $0100, $1F55          ;VCTR -171,256,0
L3BD2:  .word $A010                 ;JSRL $0020
L3BD4:  .word $C000                 ;RTSL

vg_box_6dig:
L3BD6:  .word $0000, $E078          ;VCTR 120,0,7  box 120 wide and 36 high, 4 vectors, back at its start. vw_score_ladder draws it in the flash colour round a 6-digit score
L3BDA:  .word $0024, $E000          ;VCTR 0,36,7
L3BDE:  .word $0000, $FF88          ;VCTR -120,0,7
L3BE2:  .word $1FDC, $E000          ;VCTR 0,-36,7
L3BE6:  .word $C000                 ;RTSL

vg_box_8dig:
L3BE8:  .word $0000, $E0A0          ;VCTR 160,0,7  box 160 wide and 36 high, 4 vectors. vw_score_ladder draws it round an 8-digit score
L3BEC:  .word $0024, $E000          ;VCTR 0,36,7
L3BF0:  .word $0000, $FF60          ;VCTR -160,0,7
L3BF4:  .word $1FDC, $E000          ;VCTR 0,-36,7
L3BF8:  .word $C000                 ;RTSL

vg_shld_l0:
L3BFA:  .word $0000, $FF97          ;VCTR -105,0,7  shield gauge segment 0 left of centre: a triangle 105 wide hanging 70 below the baseline, 3 vectors, then a move to the start of the next segment. the five are called through shield_segs_left, one for each shield left
L3BFE:  .word $1FBA, $E000          ;VCTR 0,-70,7
L3C02:  .word $0046, $E069          ;VCTR 105,70,7
L3C06:  .word $0000, $1F97          ;VCTR -105,0,0
L3C0A:  .word $C000                 ;RTSL

vg_shld_l1:
L3C0C:  .word $0000, $FFCE          ;VCTR -50,0,7  shield gauge segment 1 left of centre: a triangle 50 wide hanging 105 below the baseline, 3 vectors, then a move to the start of the next segment
L3C10:  .word $1F97, $E000          ;VCTR 0,-105,7
L3C14:  .word $0023, $E032          ;VCTR 50,35,7
L3C18:  .word $0046, $1FCE          ;VCTR -50,70,0
L3C1C:  .word $C000                 ;RTSL

vg_shld_l2:
L3C1E:  .word $0000, $FFE7          ;VCTR -25,0,7  shield gauge segment 2 left of centre: a triangle 25 wide hanging 121 below the baseline, 3 vectors, then a move to the start of the next segment
L3C22:  .word $1F87, $E000          ;VCTR 0,-121,7
L3C26:  .word $0010, $E019          ;VCTR 25,16,7
L3C2A:  .word $0069, $1FE7          ;VCTR -25,105,0
L3C2E:  .word $C000                 ;RTSL

vg_shld_l3:
L3C30:  .word $0000, $FFF1          ;VCTR -15,0,7  shield gauge segment 3 left of centre: a triangle 15 wide hanging 132 below the baseline, 3 vectors, then a move to the start of the next segment
L3C34:  .word $1F7C, $E000          ;VCTR 0,-132,7
L3C38:  .word $000B, $E00F          ;VCTR 15,11,7
L3C3C:  .word $0079, $1FF1          ;VCTR -15,121,0
L3C40:  .word $C000                 ;RTSL

vg_shld_l4:
L3C42:  .word $0000, $FFF1          ;VCTR -15,0,7  shield gauge segment 4 left of centre: a triangle 15 wide hanging 142 below the baseline, 3 vectors, then a move to the start of the next segment
L3C46:  .word $1F72, $E000          ;VCTR 0,-142,7
L3C4A:  .word $000A, $E00F          ;VCTR 15,10,7
L3C4E:  .word $0084, $1FF1          ;VCTR -15,132,0
L3C52:  .word $C000                 ;RTSL

vg_shld_r0:
L3C54:  .word $0000, $E069          ;VCTR 105,0,7  shield gauge segment 0 right of centre, the mirror image of vg_shld_l0. called through shield_segs_right
L3C58:  .word $1FBA, $E000          ;VCTR 0,-70,7
L3C5C:  .word $0046, $FF97          ;VCTR -105,70,7
L3C60:  .word $0000, $0069          ;VCTR 105,0,0
L3C64:  .word $C000                 ;RTSL

vg_shld_r1:
L3C66:  .word $0000, $E032          ;VCTR 50,0,7  shield gauge segment 1 right of centre, the mirror image of vg_shld_l1
L3C6A:  .word $1F97, $E000          ;VCTR 0,-105,7
L3C6E:  .word $0023, $FFCE          ;VCTR -50,35,7
L3C72:  .word $0046, $0032          ;VCTR 50,70,0
L3C76:  .word $C000                 ;RTSL

vg_shld_r2:
L3C78:  .word $0000, $E019          ;VCTR 25,0,7  shield gauge segment 2 right of centre, the mirror image of vg_shld_l2
L3C7C:  .word $1F87, $E000          ;VCTR 0,-121,7
L3C80:  .word $0010, $FFE7          ;VCTR -25,16,7
L3C84:  .word $0069, $0019          ;VCTR 25,105,0
L3C88:  .word $C000                 ;RTSL

vg_shld_r3:
L3C8A:  .word $0000, $E00F          ;VCTR 15,0,7  shield gauge segment 3 right of centre, the mirror image of vg_shld_l3
L3C8E:  .word $1F7C, $E000          ;VCTR 0,-132,7
L3C92:  .word $000B, $FFF1          ;VCTR -15,11,7
L3C96:  .word $0079, $000F          ;VCTR 15,121,0
L3C9A:  .word $C000                 ;RTSL

vg_shld_r4:
L3C9C:  .word $0000, $E00F          ;VCTR 15,0,7  shield gauge segment 4 right of centre, the mirror image of vg_shld_l4
L3CA0:  .word $1F72, $E000          ;VCTR 0,-142,7
L3CA4:  .word $000A, $FFF1          ;VCTR -15,10,7
L3CA8:  .word $0084, $000F          ;VCTR 15,132,0
L3CAC:  .word $C000                 ;RTSL

;.SBTTL SELFTEST-COLOR BARS
vg_six_bars:
L3CAE:  .word $0000, (2*$2000)+(INLEN&$1FFF) ;VCTR INLEN,0,2  six bars 256 long and 16 apart at intensities 2 to 7, in the caller's colour (Star Wars SEVEN with a JMPL to vg_cntr for its exit). vg_colorbars calls it seven times
L3CB2:  .word SEPY&$1FFF, (OFF*$2000)+(-INLEN&$1FFF) ;VCTR -INLEN,SEPY,OFF
L3CB6:  .word $0000, (3*$2000)+(INLEN&$1FFF) ;VCTR INLEN,0,3
L3CBA:  .word SEPY&$1FFF, (OFF*$2000)+(-INLEN&$1FFF) ;VCTR -INLEN,SEPY,OFF
L3CBE:  .word $0000, (4*$2000)+(INLEN&$1FFF) ;VCTR INLEN,0,4
L3CC2:  .word SEPY&$1FFF, (OFF*$2000)+(-INLEN&$1FFF) ;VCTR -INLEN,SEPY,OFF
L3CC6:  .word $0000, (5*$2000)+(INLEN&$1FFF) ;VCTR INLEN,0,5
L3CCA:  .word SEPY&$1FFF, (OFF*$2000)+(-INLEN&$1FFF) ;VCTR -INLEN,SEPY,OFF
L3CCE:  .word $0000, (6*$2000)+(INLEN&$1FFF) ;VCTR INLEN,0,6
L3CD2:  .word SEPY&$1FFF, (OFF*$2000)+(-INLEN&$1FFF) ;VCTR -INLEN,SEPY,OFF
L3CD6:  .word $0000, (7*$2000)+(INLEN&$1FFF) ;VCTR INLEN,0,7
L3CDA:  .word (((vg_cntr-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_cntr

vg_colorbars:
L3CDC:  .word (((BONDRY-VGBASE)/2)&$1FFF)+$A000 ;JSRL BONDRY  self test colour bar picture: BONDRY, vg_six_bars in colours 4, 1, 2, 6, 3, 5 and 7, then nine white bars at brightness $00 to $80. SINTEN calls it
L3CDE:  .word $8040                 ;CNTR
L3CE0:  .word $0040, $1E80          ;VCTR -384,64,0
L3CE4:  .word $6480                 ;STAT colour 4, brightness $80
L3CE6:  .word (((vg_six_bars-VGBASE)/2)&$1FFF)+$A000 ;JSRL vg_six_bars
L3CE8:  .word $0040, $1F80          ;VCTR -128,64,0
L3CEC:  .word $6180                 ;STAT colour 1, brightness $80
L3CEE:  .word (((vg_six_bars-VGBASE)/2)&$1FFF)+$A000 ;JSRL vg_six_bars
L3CF0:  .word $0040, $0080          ;VCTR 128,64,0
L3CF4:  .word $6280                 ;STAT colour 2, brightness $80
L3CF6:  .word (((vg_six_bars-VGBASE)/2)&$1FFF)+$A000 ;JSRL vg_six_bars
L3CF8:  .word $1F60, $1E80          ;VCTR -384,-160,0
L3CFC:  .word $6680                 ;STAT colour 6, brightness $80
L3CFE:  .word (((vg_six_bars-VGBASE)/2)&$1FFF)+$A000 ;JSRL vg_six_bars
L3D00:  .word $1F60, $1F80          ;VCTR -128,-160,0
L3D04:  .word $6380                 ;STAT colour 3, brightness $80
L3D06:  .word (((vg_six_bars-VGBASE)/2)&$1FFF)+$A000 ;JSRL vg_six_bars
L3D08:  .word $1F60, $0080          ;VCTR 128,-160,0
L3D0C:  .word $6580                 ;STAT colour 5, brightness $80
L3D0E:  .word (((vg_six_bars-VGBASE)/2)&$1FFF)+$A000 ;JSRL vg_six_bars
L3D10:  .word $1FD0, $1F80          ;VCTR -128,-48,0
L3D14:  .word $6780                 ;STAT colour 7, brightness $80
L3D16:  .word (((vg_six_bars-VGBASE)/2)&$1FFF)+$A000 ;JSRL vg_six_bars
;NOW DO 9 BARS USING COLOR Z= 0 TO 80
L3D18:  .word (-SEPY*12)&$1FFF, (OFF*$2000)+((INLEN/2)&$1FFF) ;VCTR <INLEN/2>,-SEPY*12.,OFF  BELOW AND TO THE RIGHT
L3D1C:  .word $6700                 ;COLOR VGCWHT,00
L3D1E:  .word $0000, (ON*$2000)+(INLEN&$1FFF) ;VCTR INLEN,0,ON
L3D22:  .word (-SEPY-4)&$1FFF, (OFF*$2000)+(-INLEN&$1FFF) ;VCTR -INLEN,-SEPY-4,OFF
L3D26:  .word $6710                 ;COLOR VGCWHT,10
L3D28:  .word $0000, (ON*$2000)+(INLEN&$1FFF) ;VCTR INLEN,0,ON
L3D2C:  .word (-SEPY-4)&$1FFF, (OFF*$2000)+(-INLEN&$1FFF) ;VCTR -INLEN,-SEPY-4,OFF
L3D30:  .word $6720                 ;COLOR VGCWHT,20
L3D32:  .word $0000, (ON*$2000)+(INLEN&$1FFF) ;VCTR INLEN,0,ON
L3D36:  .word (-SEPY-4)&$1FFF, (OFF*$2000)+(-INLEN&$1FFF) ;VCTR -INLEN,-SEPY-4,OFF
L3D3A:  .word $6730                 ;COLOR VGCWHT,30
L3D3C:  .word $0000, (ON*$2000)+(INLEN&$1FFF) ;VCTR INLEN,0,ON
L3D40:  .word (-SEPY-4)&$1FFF, (OFF*$2000)+(-INLEN&$1FFF) ;VCTR -INLEN,-SEPY-4,OFF
L3D44:  .word $6740                 ;COLOR VGCWHT,40
L3D46:  .word $0000, (ON*$2000)+(INLEN&$1FFF) ;VCTR INLEN,0,ON
L3D4A:  .word (-SEPY-4)&$1FFF, (OFF*$2000)+(-INLEN&$1FFF) ;VCTR -INLEN,-SEPY-4,OFF
L3D4E:  .word $6750                 ;COLOR VGCWHT,50
L3D50:  .word $0000, (ON*$2000)+(INLEN&$1FFF) ;VCTR INLEN,0,ON
L3D54:  .word (-SEPY-4)&$1FFF, (OFF*$2000)+(-INLEN&$1FFF) ;VCTR -INLEN,-SEPY-4,OFF
L3D58:  .word $6760                 ;COLOR VGCWHT,60
L3D5A:  .word $0000, (ON*$2000)+(INLEN&$1FFF) ;VCTR INLEN,0,ON
L3D5E:  .word (-SEPY-4)&$1FFF, (OFF*$2000)+(-INLEN&$1FFF) ;VCTR -INLEN,-SEPY-4,OFF
L3D62:  .word $6770                 ;COLOR VGCWHT,70
L3D64:  .word $0000, (ON*$2000)+(INLEN&$1FFF) ;VCTR INLEN,0,ON
L3D68:  .word (-SEPY-4)&$1FFF, (OFF*$2000)+(-INLEN&$1FFF) ;VCTR -INLEN,-SEPY-4,OFF
L3D6C:  .word $6780                 ;COLOR VGCWHT,80
L3D6E:  .word $0000, (ON*$2000)+(INLEN&$1FFF) ;VCTR INLEN,0,ON
L3D72:  .word (-SEPY-4)&$1FFF, (OFF*$2000)+(-INLEN&$1FFF) ;VCTR -INLEN,-SEPY-4,OFF
L3D76:  .word (((vg_cntr-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_cntr

;.SBTTL SELFTEST-CROSSHATCH AND ALPHA/NUMERICS
vg_hatch:
L3D78:  .word (((BONDRY-VGBASE)/2)&$1FFF)+$A000 ;JSRL BONDRY  EDGE OF SCREEN (END UP IN LOWER LEFT CORNER)  self test crosshatch picture: BONDRY, a grid over the whole screen, then at SCAL 2,$40 a jump into VGMSGA so that every character is drawn. the same as the Star Wars list but for the addresses it calls. SHATCH calls it
L3D7A:  .word VGCNTR                ;CNTR
L3D7C:  .word $1DD8, $1E20          ;SCVEC -MAX,-MAY,OFF
L3D80:  .word $0450, $E2D0          ;SCVEC MAX/2,MAY,ON
L3D84:  .word $1E90, $E0F0          ;SCVEC MAX,MAY/3,ON
L3D88:  .word $1D20, $FE20          ;SCVEC 0,-MAY,ON
L3D8C:  .word $02E0, $FE20          ;SCVEC -MAX,MAY/3,ON
L3D90:  .word $0170, $E0F0          ;SCVEC -MAX/2,MAY,ON
L3D94:  .word $1BB0, $E2D0          ;SCVEC MAX,-MAY,ON
L3D98:  .word $0450, $0000          ;SCVEC MAX,MAY,OFF
L3D9C:  .word $1BB0, $FD30          ;SCVEC -MAX/2,-MAY,ON
L3DA0:  .word $0170, $FF10          ;SCVEC -MAX,-MAY/3,ON
L3DA4:  .word $02E0, $E1E0          ;SCVEC 0,MAY,ON
L3DA8:  .word $1D20, $E1E0          ;SCVEC MAX,-MAY/3,ON
L3DAC:  .word $1E90, $FF10          ;SCVEC MAX/2,-MAY,ON
L3DB0:  .word $0450, $FD30          ;SCVEC -MAX,MAY,ON
L3DB4:  .word VGCNTR                ;CNTR
L3DB6:  .word $1E9A, (OFF*$2000)+(-480&$1FFF) ;VCTR -480.,-358.,OFF
L3DBA:  .word $7240                 ;SCAL 2,40
L3DBC:  .word (((VGMSGA-VGBASE)/2)&$1FFF)+$E000 ;JMPL VGMSGA  GO DO ALPHABET

;.SBTTL SELFTEST-CHECKERBOARD PIC.
vg_checker:
L3DBE:  .word VGSCAL                ;SCAL  self test checkerboard picture: 12 horizontal and 16 vertical lines, each drawn from the centre. the same words as in Star Wars. SCHKR calls it
L3DC0:  .word VGCNTR                ;.REPT NLINES
L3DC2:  .word $1DF1, (OFF*$2000)+(XSCRN&$1FFF)
L3DC6:  .word $0000, (ON*$2000)+((-2*XSCRN)&$1FFF)
L3DCA:  .word VGCNTR
L3DCC:  .word $1E51, (OFF*$2000)+(XSCRN&$1FFF)
L3DD0:  .word $0000, (ON*$2000)+((-2*XSCRN)&$1FFF)
L3DD4:  .word VGCNTR
L3DD6:  .word $1EB1, (OFF*$2000)+(XSCRN&$1FFF)
L3DDA:  .word $0000, (ON*$2000)+((-2*XSCRN)&$1FFF)
L3DDE:  .word VGCNTR
L3DE0:  .word $1F11, (OFF*$2000)+(XSCRN&$1FFF)
L3DE4:  .word $0000, (ON*$2000)+((-2*XSCRN)&$1FFF)
L3DE8:  .word VGCNTR
L3DEA:  .word $1F71, (OFF*$2000)+(XSCRN&$1FFF)
L3DEE:  .word $0000, (ON*$2000)+((-2*XSCRN)&$1FFF)
L3DF2:  .word VGCNTR
L3DF4:  .word $1FD1, (OFF*$2000)+(XSCRN&$1FFF)
L3DF8:  .word $0000, (ON*$2000)+((-2*XSCRN)&$1FFF)
L3DFC:  .word VGCNTR
L3DFE:  .word $0031, (OFF*$2000)+(XSCRN&$1FFF)
L3E02:  .word $0000, (ON*$2000)+((-2*XSCRN)&$1FFF)
L3E06:  .word VGCNTR
L3E08:  .word $0091, (OFF*$2000)+(XSCRN&$1FFF)
L3E0C:  .word $0000, (ON*$2000)+((-2*XSCRN)&$1FFF)
L3E10:  .word VGCNTR
L3E12:  .word $00F1, (OFF*$2000)+(XSCRN&$1FFF)
L3E16:  .word $0000, (ON*$2000)+((-2*XSCRN)&$1FFF)
L3E1A:  .word VGCNTR
L3E1C:  .word $0151, (OFF*$2000)+(XSCRN&$1FFF)
L3E20:  .word $0000, (ON*$2000)+((-2*XSCRN)&$1FFF)
L3E24:  .word VGCNTR
L3E26:  .word $01B1, (OFF*$2000)+(XSCRN&$1FFF)
L3E2A:  .word $0000, (ON*$2000)+((-2*XSCRN)&$1FFF)
L3E2E:  .word VGCNTR
L3E30:  .word $0211, (OFF*$2000)+(XSCRN&$1FFF)
L3E34:  .word $0000, (ON*$2000)+((-2*XSCRN)&$1FFF)
L3E38:  .word VGCNTR                ;.REPT NLINES
L3E3A:  .word YSCRN&$1FFF, $1E21
L3E3E:  .word (-2*YSCRN)&$1FFF, (ON*$2000)+(0&$1FFF)
L3E42:  .word VGCNTR
L3E44:  .word YSCRN&$1FFF, $1E61
L3E48:  .word (-2*YSCRN)&$1FFF, (ON*$2000)+(0&$1FFF)
L3E4C:  .word VGCNTR
L3E4E:  .word YSCRN&$1FFF, $1EA1
L3E52:  .word (-2*YSCRN)&$1FFF, (ON*$2000)+(0&$1FFF)
L3E56:  .word VGCNTR
L3E58:  .word YSCRN&$1FFF, $1EE1
L3E5C:  .word (-2*YSCRN)&$1FFF, (ON*$2000)+(0&$1FFF)
L3E60:  .word VGCNTR
L3E62:  .word YSCRN&$1FFF, $1F21
L3E66:  .word (-2*YSCRN)&$1FFF, (ON*$2000)+(0&$1FFF)
L3E6A:  .word VGCNTR
L3E6C:  .word YSCRN&$1FFF, $1F61
L3E70:  .word (-2*YSCRN)&$1FFF, (ON*$2000)+(0&$1FFF)
L3E74:  .word VGCNTR
L3E76:  .word YSCRN&$1FFF, $1FA1
L3E7A:  .word (-2*YSCRN)&$1FFF, (ON*$2000)+(0&$1FFF)
L3E7E:  .word VGCNTR
L3E80:  .word YSCRN&$1FFF, $1FE1
L3E84:  .word (-2*YSCRN)&$1FFF, (ON*$2000)+(0&$1FFF)
L3E88:  .word VGCNTR
L3E8A:  .word YSCRN&$1FFF, $0021
L3E8E:  .word (-2*YSCRN)&$1FFF, (ON*$2000)+(0&$1FFF)
L3E92:  .word VGCNTR
L3E94:  .word YSCRN&$1FFF, $0061
L3E98:  .word (-2*YSCRN)&$1FFF, (ON*$2000)+(0&$1FFF)
L3E9C:  .word VGCNTR
L3E9E:  .word YSCRN&$1FFF, $00A1
L3EA2:  .word (-2*YSCRN)&$1FFF, (ON*$2000)+(0&$1FFF)
L3EA6:  .word VGCNTR
L3EA8:  .word YSCRN&$1FFF, $00E1
L3EAC:  .word (-2*YSCRN)&$1FFF, (ON*$2000)+(0&$1FFF)
L3EB0:  .word VGCNTR
L3EB2:  .word YSCRN&$1FFF, $0121
L3EB6:  .word (-2*YSCRN)&$1FFF, (ON*$2000)+(0&$1FFF)
L3EBA:  .word VGCNTR
L3EBC:  .word YSCRN&$1FFF, $0161
L3EC0:  .word (-2*YSCRN)&$1FFF, (ON*$2000)+(0&$1FFF)
L3EC4:  .word VGCNTR
L3EC6:  .word YSCRN&$1FFF, $01A1
L3ECA:  .word (-2*YSCRN)&$1FFF, (ON*$2000)+(0&$1FFF)
L3ECE:  .word VGCNTR
L3ED0:  .word YSCRN&$1FFF, $01E1
L3ED4:  .word (-2*YSCRN)&$1FFF, (ON*$2000)+(0&$1FFF)
L3ED8:  .word $C000                 ;RTSL

;.SBTTL SELFTEST-HYSTERESIS PIC
BONDRY:
L3EDA:  .word $6250                 ;COLOR VGCGRN,50  SCREEN BOUNDARY  Star Wars BONDRY, the same words: colour 2 at brightness $50, then BOX. VJBONDRY is the JSRL to it

BOX:
L3EDC:  .word VGSCAL                ;SCAL  Star Wars BOX, the same words: default scale, centre, a move to the lower left corner and the four sides of the screen, 960 by 1104. SSCAL and vg_raster call it
L3EDE:  .word VGCNTR                ;CNTR
L3EE0:  .word -MAY&$1FFF, (OFF*$2000)+(-MAX&$1FFF) ;VCTR -MAX,-MAY,OFF

vg_box_sides:
L3EE4:  .word $0000, (ON*$2000)+((2*MAX)&$1FFF) ;VCTR 2*MAX,0,ON  the four sides of BOX alone, with no scale, centre or move before them. SBIP calls it for the box without centers
L3EE8:  .word (2*MAY)&$1FFF, (ON*$2000)+(0&$1FFF) ;VCTR 0,2*MAY,ON
L3EEC:  .word $0000, (ON*$2000)+((-2*MAX)&$1FFF) ;VCTR -2*MAX,0,ON
L3EF0:  .word (-2*MAY)&$1FFF, (ON*$2000)+(0&$1FFF) ;VCTR 0,-2*MAY,ON
L3EF4:  .word $C000                 ;RTSL

;.SBTTL SELFTEST-SCALE PIC
vg_scale_sq:
L3EF6:  .word $008A, $005C          ;AOFF 92,92  LETS DRAW A SQUARE  square for the scale test: a move up and right, a box 184 wide and 276 high round the start point, then centre and return. SSCAL calls it at each scale
L3EFA:  .word $0000, $FF48          ;AON -92,92
L3EFE:  .word $1EEC, $E000          ;AON -92,-92
L3F02:  .word $0000, $E0B8          ;AON 92,-92
L3F06:  .word $0114, $E000          ;AON 92,92
L3F0A:  .word (((vg_cntr-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_cntr

;.SBTTL SELFTEST-RASTER PICS
vg_raster:
L3F0C:  .word (((BOX-VGBASE)/2)&$1FFF)+$A000 ;JSRL BOX  DRAW BOX, AND GOTO LEFT SIDE OF SCREEN  start of the raster test: BOX, centre, a move to the left edge 256 above the centre, then it runs on into vg_raster_ln. SRASTR calls it once
L3F0E:  .word VGCNTR                ;CNTR
L3F10:  .word $0100, (OFF*$2000)+(-MAX&$1FFF) ;VCTR -MAX,100,OFF

vg_raster_ln:
L3F14:  .word $0000, (ON*$2000)+((2*MAX)&$1FFF) ;VCTR 2*MAX,0,ON  DRAW LINE FROM LEFT TO RIGHT SIDE OF SCREEN  one pair of raster lines: across the screen to the right, 5 down, back to the left, 5 down. SRASTR calls it for each pair
L3F18:  .word $1FFB, (OFF*$2000)+(0&$1FFF) ;VCTR 0,-5,OFF  DOWN
L3F1C:  .word $0000, (ON*$2000)+((-2*MAX)&$1FFF) ;VCTR -2*MAX,0,ON  AND RETURN TO LEFT SIDE
L3F20:  .word $1FFB, (OFF*$2000)+(0&$1FFF) ;VCTR 0,-5,OFF  DOWN
L3F24:  .word $C000                 ;RTSL

;.SBTTL SELFTEST-POT TEST PATTERN
vg_pot_test:
L3F26:  .word $000C, (OFF*$2000)+(((256+64-8)*M_/D_)&$1FFF) ;VOFFM 256.+64.-8,8  pattern round the pot test line: a red box 16 wide and 24 high, a green box 192 wide and 288 high with its corners left open and a white box 256 wide and 384 high, then centre and return. SSWTCH calls it
L3F2A:  .word $6480                 ;COLOR VGCRED  VERY SMALL BOX, CENTERED CONTROL MUST BE WITHIN
L3F2C:  .word $54E0                 ;AON -8,-8
L3F2E:  .word $40E8                 ;AON 8,-8
L3F30:  .word $4CE0                 ;AON 8,8
L3F32:  .word $40F8                 ;AON -8,8
L3F34:  .word $6280                 ;COLOR VGCGRN  INSIDE SEMI-BOX, MUST REACH PAST HERE
L3F36:  .word $006C, $1FA8          ;AOFF -96,80
L3F3A:  .word $1F10, $E000          ;AON -96,-80
L3F3E:  .word $5408                 ;AOFF -80,-96
L3F40:  .word $0000, $E0A0          ;AON 80,-96
L3F44:  .word $4C08                 ;AOFF 96,-80
L3F46:  .word $00F0, $E000          ;AON 96,80
L3F4A:  .word $4C18                 ;AOFF 80,96
L3F4C:  .word $0000, $FF60          ;AON -80,96
L3F50:  .word $6780                 ;COLOR VGCWHT  OUTSIDE BOX, MAXIMUM VALUES
L3F52:  .word $0030, $1FD0          ;AOFF -128,128
L3F56:  .word $1E80, $E000          ;AON -128,-128
L3F5A:  .word $0000, $E100          ;AON 128,-128
L3F5E:  .word $0180, $E000          ;AON 128,128
L3F62:  .word $0000, $FF00          ;AON -128,128
L3F66:  .word (((vg_cntr-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_cntr
L3F68:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;ROM fill, 90 bytes of $FF
L3F78:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L3F88:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L3F98:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L3FA8:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L3FB8:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L3FC2:  .byte $FF
L3FC3:  .byte $FF
L3FC4:  .byte $FF
L3FC5:  .byte $FF
L3FC6:  .byte $FF
L3FC7:  .byte $FF
L3FC8:  .byte $FF
L3FC9:  .byte $FF
L3FCA:  .byte $FF
L3FCB:  .byte $FF
L3FCC:  .byte $FF
L3FCD:  .byte $FF
L3FCE:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;ROM fill, 41 bytes of $FF
L3FDE:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L3FEE:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L3FF7:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF
L3FFE:  .byte $FF, $FF
