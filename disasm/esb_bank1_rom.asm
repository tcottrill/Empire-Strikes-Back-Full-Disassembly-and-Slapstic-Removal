;The Empire Strikes Back (Atari, 1985) - annotated disassembly of the main
;program ROM, bank 1: $6000-$7FFF and $A000-$FFFF with W_BANK D7 = 1
;(MAME 'esb': the second halves of 136031-101.1f, -102.1jk, -203.1kl, -104.1m).
;Bank 0 is in esb_bank0_rom.asm; $8000-$9FFF is the slapstic window, in
;esb_slapstic0_rom.asm .. esb_slapstic3_rom.asm; the vector ROM is in
;esb_vector_rom.asm.  Labels: L = bank 0, K = bank 1, P0_ .. P3_ = slapstic pages.
;Names and upper-case comments are Atari's, carried over from the Star Wars
;source wherever this code is the same instruction for instruction (swmatch.py);
;everything in lower case was written for this disassembly.
;Every line below was re-encoded and byte-compared with the ROM (verify.py).
;Syntax: Motorola 6809 mnemonics and operands; .alias, .byte, .word (big-endian);
;( ) groups expressions; ~ is one's complement, | is OR, ^ is exclusive OR.
;.dpage gives the direct page the assembler assumed; < and > before an operand
;force the short and the long form.

.org $6000

.include "esb_defines.asm"

.dpage $48

;------------------------------------------------------------------------------
; prog_start_b1 - bank 1's copy of prog_start: a jump to the cross-bank entry that leads to RESET in bank 0
;   (K601E), then the address of the IRQ entry. bank 1's RESET vector points at K601E itself, so nothing comes
;   here
;------------------------------------------------------------------------------
prog_start_b1:
K6000:  JMP  K601E
K6003:  .word irq_entry_b1

;------------------------------------------------------------------------------
; irq_entry_b1 - bank 1's copy of irq_entry, where the IRQ vector of both banks points: U = the interrupted
;   frame, the cross-bank entry K6018 runs irq_handler in bank 0 and comes back, then RTI
;------------------------------------------------------------------------------
irq_entry_b1:
K6005:  LEAU ,S
K6007:  JSR  K6018
K600A:  RTI

;------------------------------------------------------------------------------
; xbank_call_b1 - bank 1's copy of xbank_call, the cross-bank call described at bank 0's copy: this one clears
;   W_BANK D7, on the way out of bank 1 and on the way back to bank 0, where bank 0's copy sets it. the
;   instruction after each ROR is fetched from the other bank's copy
;------------------------------------------------------------------------------
xbank_call_b1:
K600B:  ANDCC #$FE                  ;carry = 0: bank 0
K600D:  ROR  W_BANK                 ;into W_BANK D7, the next instruction comes from bank 0
K6010:  JSR  [,S++]                 ;(arriving from bank 0) call the JMP after the caller's table entry
K6012:  ANDCC #$FE                  ;carry = 0: back to bank 0
K6014:  ROR  W_BANK
K6017:  RTS                         ;(in bank 0 again) return to the original caller
K6018:  JSR  xbank_call_b1          ;bank 0: irq_handler
K601B:  .byte $3F, $3F, $3F         ;the JMP of this entry is in bank 0. three SWI opcodes fill its place here, as in every entry of the table
K601E:  JSR  xbank_call_b1          ;bank 0: RESET
K6021:  .byte $3F, $3F, $3F
K6024:  JSR  xbank_call_b1          ;bank 0: HANG
K6027:  .byte $3F, $3F, $3F
K602A:  JSR  xbank_call_b1          ;bank 0: WAITFRAME
K602D:  .byte $3F, $3F, $3F
K6030:  JSR  xbank_call_b1          ;bank 0: MESSON
K6033:  .byte $3F, $3F, $3F
K6036:  JSR  xbank_call_b1          ;bank 0: MESSOFF
K6039:  .byte $3F, $3F, $3F
K603C:  JSR  xbank_call_b1          ;bank 0: ALLOFF
K603F:  .byte $3F, $3F, $3F
K6042:  JSR  xbank_call_b1          ;bank 0: VWMESS
K6045:  .byte $3F, $3F, $3F
K6048:  JSR  xbank_call_b1          ;bank 0: VWMES2
K604B:  .byte $3F, $3F, $3F
K604E:  JSR  xbank_call_b1          ;bank 0: SPMON
K6051:  .byte $3F, $3F, $3F
K6054:  JSR  xbank_call_b1          ;bank 0: SPMOFF
K6057:  .byte $3F, $3F, $3F
K605A:  JSR  xbank_call_b1          ;bank 0: VWSPMS
K605D:  .byte $3F, $3F, $3F
K6060:  JSR  xbank_call_b1          ;bank 0: BGBNNR
K6063:  .byte $3F, $3F, $3F
K6066:  JSR  xbank_call_b1          ;bank 0: spmess_entry
K6069:  .byte $3F, $3F, $3F
K606C:  JSR  xbank_call_b1          ;bank 0: view_8dig
K606F:  .byte $3F, $3F, $3F
K6072:  JSR  xbank_call_b1          ;bank 0: view_6dig
K6075:  .byte $3F, $3F, $3F
K6078:  JSR  xbank_call_b1          ;bank 0: view_4dig
K607B:  .byte $3F, $3F, $3F
K607E:  JSR  xbank_call_b1          ;bank 0: VWBYTE
K6081:  .byte $3F, $3F, $3F
K6084:  JSR  xbank_call_b1          ;bank 0: VWBYT1
K6087:  .byte $3F, $3F, $3F
K608A:  JSR  xbank_call_b1          ;bank 0: VWBYT1
K608D:  .byte $3F, $3F, $3F
K6090:  JSR  xbank_call_b1          ;bank 0: do_message
K6093:  .byte $3F, $3F, $3F
K6096:  JSR  xbank_call_b1          ;bank 0: do_message_nc
K6099:  .byte $3F, $3F, $3F
K609C:  JSR  xbank_call_b1          ;bank 0: VWCURC
K609F:  .byte $3F, $3F, $3F, $3F, $3F, $3F ;from here on the entries are bank 1 routines: the JSR xbank_call is in bank 0 and the JMP is here
K60A5:  JMP  obj_list_init          ;JINOBJ with X saved: clear the object list of the math box and reset its fill pointers
K60A8:  .byte $3F, $3F, $3F
K60AB:  JMP  obj_load_b             ;B = object number: copy that object's points into math RAM unless they are there already (BJ_ID = B, then JADOBJ)
K60AE:  .byte $3F, $3F, $3F
K60B1:  JMP  obj_load               ;the same for the object already in BJ_ID. no call through this entry was found
K60B4:  .byte $3F, $3F, $3F
K60B7:  JMP  BJCNTR_6761            ;perspective of the object's centre and a blank vector to it from the screen centre
K60BA:  .byte $3F, $3F, $3F
K60BD:  JMP  obj_beam_home          ;object draw position to 0,$68 and a JSRL $32AC into the display list
K60C0:  .byte $3F, $3F, $3F
K60C3:  JMP  BJLNV_6782             ;visible line from the current object draw position to the point just divided
K60C6:  .byte $3F, $3F, $3F
K60C9:  JMP  BJLNB_67AA             ;the same as a blank line
K60CC:  .byte $3F, $3F, $3F
K60CF:  JMP  pnt_buf_reset          ;reset the pointer for perspected points to the start of BJ_PNT
K60D2:  .byte $3F, $3F, $3F
K60D5:  JMP  JOBJBPNT               ;B = object number: transform and perspect all its points into BJ_PNT
K60D8:  .byte $3F, $3F, $3F
K60DB:  JMP  obj_points             ;the same for the object already in BJ_ID. no call through this entry was found
K60DE:  .byte $3F, $3F, $3F
K60E1:  JMP  pnt_add_scratch        ;one more point: MS_PAD with block index $0F, reciprocal and perspective, stored at the BJ_PNT pointer, which moves on 5 bytes
K60E4:  .byte $3F, $3F, $3F
K60E7:  JMP  obj_draw               ;draw the object in BJ_ID through its draw routine in the table KD6CD
K60EA:  .byte $3F, $3F, $3F
K60ED:  JMP  obj_draw_b             ;B = object number: draw that object (BJ_ID = B, then KDA2C)
K60F0:  .byte $3F, $3F, $3F
K60F3:  JMP  view_title_logo        ;view_title_logo: the title of the banner phase, then bank 0's special messages
K60F6:  .byte $3F, $3F, $3F
K60F9:  JMP  hs_view                ;view the high score table, Star Wars' VWHSCR (called by PHEHIS and PHEENT)
K60FC:  .byte $3F, $3F, $3F
K60FF:  JMP  hs_rank_step           ;step the player's place in the high score table up when the score has reached the next entry (called by IFRAME)
K6102:  .byte $3F, $3F, $3F
K6105:  JMP  hs_insert              ;end of game: look for the score's place in the high score table and make room for it, Star Wars' UPDATE
K6108:  .byte $3F, $3F, $3F
K610B:  JMP  GETINT                 ;take the player's initials with the sight
K610E:  .byte $3F, $3F, $3F
K6111:  JMP  hs_load                ;high scores and initials from the EEROM image to INITLS, then the check at KE400
K6114:  .byte $3F, $3F, $3F
K6117:  JMP  hs_validate            ;check the high score table for reasonableness, defaults (DOINTS) when it fails
K611A:  .byte $3F, $3F, $3F
K611D:  JMP  hs_nv_defaults         ;copy the default high score table into the EEROM image at $4D04. no call through this entry was found
K6120:  .byte $3F, $3F, $3F
K6123:  JMP  acct_page_view         ;draw the statistics page of the self test (PHESTS), Star Wars' EEACC
K6126:  .byte $3F, $3F, $3F
K6129:  JMP  coin_acct_upd          ;coin counter accounting, called by COINS: Star Wars' EEACCU
K612C:  .byte $3F, $3F, $3F
K612F:  JMP  EEACCT                 ;end of game accounting: game time and counts into the EEROM image
K6132:  .byte $3F, $3F, $3F
K6135:  JMP  time_on_upd            ;update the total time on, the second half of Star Wars' EEUTIM (called by PHIBNR)
K6138:  .byte $3F, $3F, $3F
K613B:  JMP  EECKSM                 ;set the checksum of EEROM area A and write the area to the NVRAM as nibbles. no call through this entry was found
K613E:  .byte $3F, $3F, $3F
K6141:  JMP  ee_area_sum            ;checksum of EEROM area A: Z set when it matches the stored one. no call through this entry was found
K6144:  .byte $3F, $3F, $3F
K6147:  JMP  ee_init                ;called once by RESET: builds the EEROM image from the NVRAM nibbles and recalls the non-volatile memory, descends from Star Wars' EEINIT
K614A:  .byte $3F, $3F, $3F
K614D:  JMP  ee_area_check          ;check EEROM area A and restore it when its checksum is bad, Star Wars' CHKEE. no call through this entry was found
K6150:  .byte $3F, $3F, $3F
K6153:  JMP  ee_opts_check          ;check EEROM area 3 and re-init it when its checksum is bad (called by PHIOPT)
K6156:  .byte $3F, $3F, $3F
K6159:  JMP  opt_page_view          ;draw the option page of the self test (PHEOPT), Star Wars' EEOPT
K615C:  .byte $3F, $3F, $3F
K615F:  JMP  opt_page_change        ;option page input (PHEOPT): carries out the resets chosen in RESETS, then Star Wars' EEOPT1, select and change an option with the sight and the left fire button
K6162:  .byte $3F, $3F, $3F
K6165:  JMP  EEOPT3                 ;A = option number: display its value. no call through this entry was found
K6168:  .byte $3F, $3F, $3F
K616B:  JMP  EETMP2                 ;copy 4 bytes from X to U (in Star Wars it moved EEROM nibbles to bytes)
K616E:  .byte $3F, $3F, $3F
K6171:  JMP  ISTAR                  ;set up the stars
K6174:  .byte $3F, $3F, $3F
K6177:  JMP  ISTARG                 ;set up the ground stars
K617A:  .byte $3F, $3F, $3F
K617D:  JMP  JVWSTAR                ;view the stars
K6180:  .byte $3F, $3F, $3F
K6183:  JMP  JVWSTRG                ;view the ground stars
K6186:  .byte $3F, $3F, $3F
K6189:  JMP  expl_clear             ;clear byte 13 of every 14-byte slot of the explosion queue XPQUE, called by the setup of each part of a wave and of a manual page
K618C:  .byte $3F, $3F, $3F
K618F:  JMP  tie_expl_begin         ;X = alien parms: clear its byte 3 and begin the alien explosion BGAXP (called by CPHTSA on page 3)
K6192:  .byte $3F, $3F, $3F
K6195:  JMP  atat_expl_begin        ;BGTWXP with X and U saved: begin a three-piece explosion (called by page 0 P0_9006)
K6198:  .byte $3F, $3F, $3F
K619B:  JMP  probot_expl_begin      ;BGBKXP with X and U saved: begin the explosion of a probot, two pieces (called by page 2 probot_shot_down)
K619E:  .byte $3F, $3F, $3F
K61A1:  JMP  expl_stub_rts          ;KE59C is an RTS: an entry with nothing behind it. no call through it was found
K61A4:  .byte $3F, $3F, $3F
K61A7:  JMP  atst_expl_begin        ;KE718 with X and U saved: begin a three-piece explosion with piece types 3, 4 and 5 (called by page 1 P1_8E33)
K61AA:  .byte $3F, $3F, $3F
K61AD:  JMP  DOXPLD                 ;process the explosions in progress
K61B0:  .byte $3F, $3F, $3F
K61B3:  JMP  VWXPLD                 ;view the explosions

;------------------------------------------------------------------------------
; IPGEN_B1 - INIT GENERAL PARMS
;   in ESB: bank 1's copy of bank 0's routine. nothing in bank 1 calls it and no entry of the cross-bank table
;   leads to it, so it is unused
;------------------------------------------------------------------------------
IPGEN_B1:
K61B6:  LDA  P_RND1
K61B9:  SUBA P_RND1                 ;rev 2 patch: Atari's 22-JUN-83 source and rev 1 have CMPA here ($B1)
K61BC:  BNE  IMATH_B1               ;IFEQ  ?# GENERATOR STUCK?
K61BE:  STA  P_IRND                 ;INIT POLY COUNTER
K61C1:  LDA  #$80                   ;START IT RUNNING
K61C3:  STA  P_IRND

;------------------------------------------------------------------------------
; IMATH_B1 - RESTORE MATH BOX  (comment at the calls)
;   in ESB: bank 1's copy of bank 0's routine. it is reached only from IPGEN_B1, which nothing calls, so it is
;   unused
;------------------------------------------------------------------------------
IMATH_B1:
K61C6:  LDD  #$0000
K61C9:  STD  M_ZRO
K61CC:  LDD  #$4000
K61CF:  STD  M_ONE                  ;CONSTANT '1'
K61D2:  LDD  #$E000                 ;CONSTANT DIVIDE BY 2
K61D5:  STD  M_HLF
K61D8:  LDD  #$0080                 ;ROUNDING CONSTANTS
K61DB:  STD  M_C80                  ;0080
K61DE:  LDD  #$0040
K61E1:  STD  M_C40                  ;0040
K61E4:  LDD  #$021F                 ;SIN,COS ANGLES
K61E7:  STD  M_SINH                 ;FOR .895 DEGREES
K61EA:  LDD  #$3FF7
K61ED:  STD  M_COS
K61F0:  LDD  #$4000                 ;SCALE
K61F3:  STD  M_SCL
K61F6:  LDD  #$0200
K61F9:  STD  M_DVN                  ;RECIPROCAL PERSPECTIVE
K61FC:  RTS

;------------------------------------------------------------------------------
; asrd12_b1 - bank 1's copy of asrd12: arithmetic shift right of D by 12 bits, done as a byte move, sign
;   extension and 4 shifts of B. first of five such entries (12 to 8 bits) in front of Atari's ASRD chain. no
;   caller found in bank 1, unused as far as can be seen
;------------------------------------------------------------------------------
asrd12_b1:
K61FD:  TFR  A,B
K61FF:  SEX
K6200:  ASRB
K6201:  ASRB
K6202:  ASRB
K6203:  ASRB
K6204:  RTS

;------------------------------------------------------------------------------
; asrd11_b1 - bank 1's copy of asrd11: arithmetic shift right of D by 11 bits. no caller found, unused as far as
;   can be seen
;------------------------------------------------------------------------------
asrd11_b1:
K6205:  TFR  A,B
K6207:  SEX
K6208:  ASRB
K6209:  ASRB
K620A:  ASRB
K620B:  RTS

;------------------------------------------------------------------------------
; asrd10_b1 - bank 1's copy of asrd10: arithmetic shift right of D by 10 bits. no caller found, unused as far as
;   can be seen
;------------------------------------------------------------------------------
asrd10_b1:
K620C:  TFR  A,B
K620E:  SEX
K620F:  ASRB
K6210:  ASRB
K6211:  RTS

;------------------------------------------------------------------------------
; asrd9_b1 - bank 1's copy of asrd9: arithmetic shift right of D by 9 bits. no caller found, unused as far as
;   can be seen
;------------------------------------------------------------------------------
asrd9_b1:
K6212:  TFR  A,B
K6214:  SEX
K6215:  ASRB
K6216:  RTS

;------------------------------------------------------------------------------
; asrd8_b1 - bank 1's copy of asrd8: arithmetic shift right of D by 8 bits, A to B and sign extend. no caller
;   found, unused as far as can be seen. the two bytes after its RTS are the ASRD7 entry of the chain that follows
;------------------------------------------------------------------------------
asrd8_b1:
K6217:  TFR  A,B
K6219:  SEX
K621A:  RTS

;------------------------------------------------------------------------------
; ASRD7_B1 - bank 1's copy of the ASRD7 entry of the shift library. nothing calls it
;------------------------------------------------------------------------------
ASRD7_B1:
K621B:  ASRA                        ;really code: ASRA RORB, the ASRD7 entry of Atari's chain, falling into ASRD6_B1. nothing calls it
K621C:  RORB

;------------------------------------------------------------------------------
; ASRD6_B1 - [note] Entry point: arithmetic shift D right 6 bits (falls through ASRD5..ASRD1 to the RTS at ASRD0)
;------------------------------------------------------------------------------
ASRD6_B1:
K621D:  ASRA
K621E:  RORB

;------------------------------------------------------------------------------
; ASRD5 - [note] Entry point: arithmetic shift D right 5 bits (falls through ASRD4..ASRD1 to the RTS at ASRD0)
;------------------------------------------------------------------------------
ASRD5:
K621F:  ASRA
K6220:  RORB

;------------------------------------------------------------------------------
; ASRD4 - [note] Entry point: arithmetic shift D right 4 bits (falls through ASRD3..ASRD1 to the RTS at ASRD0)
;------------------------------------------------------------------------------
ASRD4:
K6221:  ASRA
K6222:  RORB

;------------------------------------------------------------------------------
; ASRD3_B1 - [note] Entry point: arithmetic shift D right 3 bits (falls through ASRD2, ASRD1 to the RTS at ASRD0)
;------------------------------------------------------------------------------
ASRD3_B1:
K6223:  ASRA
K6224:  RORB

ASRD2_B1:
K6225:  ASRA
K6226:  RORB

;------------------------------------------------------------------------------
; ASRD1_B1 - entry point: arithmetic shift D right 1 bit, then the RTS at ASRD0_B1. called at KE8BE
;------------------------------------------------------------------------------
ASRD1_B1:
K6227:  ASRA
K6228:  RORB

ASRD0_B1:
K6229:  RTS

;------------------------------------------------------------------------------
; lsrd12_b1 - bank 1's copy of lsrd12: logical shift right of D by 12 bits, A to B, clear A, 4 shifts of B.
;   first of the logical shift right library (12 to 8 bits as short routines, then the chain at lsrd7_b1). no
;   caller found for any of them in bank 1
;------------------------------------------------------------------------------
lsrd12_b1:
K622A:  TFR  A,B
K622C:  CLRA
K622D:  LSRB
K622E:  LSRB
K622F:  LSRB
K6230:  LSRB
K6231:  RTS

;------------------------------------------------------------------------------
; lsrd11_b1 - bank 1's copy of lsrd11: logical shift right of D by 11 bits. no caller found, unused as far as
;   can be seen
;------------------------------------------------------------------------------
lsrd11_b1:
K6232:  TFR  A,B
K6234:  CLRA
K6235:  LSRB
K6236:  LSRB
K6237:  LSRB
K6238:  RTS

;------------------------------------------------------------------------------
; lsrd10_b1 - bank 1's copy of lsrd10: logical shift right of D by 10 bits. no caller found, unused as far as
;   can be seen
;------------------------------------------------------------------------------
lsrd10_b1:
K6239:  TFR  A,B
K623B:  CLRA
K623C:  LSRB
K623D:  LSRB
K623E:  RTS

;------------------------------------------------------------------------------
; lsrd9_b1 - bank 1's copy of lsrd9: logical shift right of D by 9 bits. no caller found, unused as far as can
;   be seen
;------------------------------------------------------------------------------
lsrd9_b1:
K623F:  TFR  A,B
K6241:  CLRA
K6242:  LSRB
K6243:  RTS

;------------------------------------------------------------------------------
; lsrd8_b1 - bank 1's copy of lsrd8: logical shift right of D by 8 bits, A to B and clear A. no caller found,
;   unused as far as can be seen
;------------------------------------------------------------------------------
lsrd8_b1:
K6244:  TFR  A,B
K6246:  CLRA
K6247:  RTS

;------------------------------------------------------------------------------
; lsrd7_b1 - logical shift right of D by 7 bits: seven LSRA RORB pairs and an RTS, the fall-through chain whose
;   4 bit entry is lsrd4 in bank 0 (there the first three pairs are listed as data at LB2FC). the entries for 6 to
;   1 bits are every two bytes inside it. no caller of any of them was found in bank 1
;------------------------------------------------------------------------------
lsrd7_b1:
K6248:  LSRA
K6249:  RORB
K624A:  LSRA
K624B:  RORB
K624C:  LSRA
K624D:  RORB
K624E:  LSRA
K624F:  RORB
K6250:  LSRA
K6251:  RORB
K6252:  LSRA
K6253:  RORB
K6254:  LSRA
K6255:  RORB
K6256:  RTS

;------------------------------------------------------------------------------
; lsld12_b1 - bank 1's copy of lsld12: shift D left 12 bits, B to A, clear B, 4 shifts of A. first of five such
;   entries (12 to 8 bits) in front of Atari's LSLD chain. no caller found, unused as far as can be seen
;------------------------------------------------------------------------------
lsld12_b1:
K6257:  TFR  B,A
K6259:  CLRB
K625A:  ASLA
K625B:  ASLA
K625C:  ASLA
K625D:  ASLA
K625E:  RTS

;------------------------------------------------------------------------------
; lsld11_b1 - bank 1's copy of lsld11: shift D left 11 bits. no caller found, unused as far as can be seen
;------------------------------------------------------------------------------
lsld11_b1:
K625F:  TFR  B,A
K6261:  CLRB
K6262:  ASLA
K6263:  ASLA
K6264:  ASLA
K6265:  RTS

;------------------------------------------------------------------------------
; lsld10_b1 - bank 1's copy of lsld10: shift D left 10 bits. no caller found, unused as far as can be seen
;------------------------------------------------------------------------------
lsld10_b1:
K6266:  TFR  B,A
K6268:  CLRB
K6269:  ASLA
K626A:  ASLA
K626B:  RTS

;------------------------------------------------------------------------------
; lsld9_b1 - bank 1's copy of lsld9: shift D left 9 bits. no caller found, unused as far as can be seen
;------------------------------------------------------------------------------
lsld9_b1:
K626C:  TFR  B,A
K626E:  CLRB
K626F:  ASLA
K6270:  RTS

;------------------------------------------------------------------------------
; lsld8_b1 - bank 1's copy of lsld8: shift D left 8 bits, B to A and clear B. no caller found, unused as far as
;   can be seen. the ten bytes after its RTS are the LSLD7 to LSLD3 entries of the chain that follows
;------------------------------------------------------------------------------
lsld8_b1:
K6271:  TFR  B,A
K6273:  CLRB
K6274:  RTS

;------------------------------------------------------------------------------
; LSLD7_B1 - [note] Entry point: shift D left 7 bits (falls through LSLD6..LSLD1 to the RTS at LSLD0)
;------------------------------------------------------------------------------
LSLD7_B1:
K6275:  LSLB                        ;really code: LSLB ROLA five times, the LSLD7 to LSLD3 entries of Atari's chain, falling into LSLD2. nothing calls them
K6276:  ROLA

LSLD6_B1:
K6277:  LSLB
K6278:  ROLA

LSLD5_B1:
K6279:  LSLB
K627A:  ROLA

;------------------------------------------------------------------------------
; LSLD4_B1 - [note] Entry point: shift D left 4 bits (falls through LSLD3..LSLD1 to the RTS at LSLD0)
;------------------------------------------------------------------------------
LSLD4_B1:
K627B:  LSLB
K627C:  ROLA

LSLD3_B1:
K627D:  LSLB
K627E:  ROLA

;------------------------------------------------------------------------------
; LSLD2 - [note] Entry point: shift D left 2 bits (falls through LSLD1 to the RTS at LSLD0)
;------------------------------------------------------------------------------
LSLD2:
K627F:  LSLB
K6280:  ROLA

LSLD1_B1:
K6281:  LSLB
K6282:  ROLA

LSLD0_B1:
K6283:  RTS

;------------------------------------------------------------------------------
; MGOWT_B1 - MATH SUBROUTINES
;   START THE MATH BOX, AND WAIT
;------------------------------------------------------------------------------
MGOWT_B1:
K6284:  STA  M_PCGO

MWAIT_B1:
MWAIT_10_B1:
K6287:  TST  M_BUSY                 ;SLOW BUT SAFE
K628A:  BMI  MWAIT_B1
K628C:  RTS

;------------------------------------------------------------------------------
; UNITV_B1 - SETUP UNIT VECTORS
;------------------------------------------------------------------------------
UNITV_B1:
K628D:  LDD  #$0000
K6290:  STD  MS_VX,U                ;VELOCITY VECTORS
K6292:  STD  MS_VY,U
K6294:  STD  MS_VZ,U
K6296:  STD  MS_TX,U                ;TRANSLATION COORDS
K6298:  STD  MS_TY,U
K629A:  STD  MS_TZ,U
;STD M$AX(U) ;IDENTITY MATRIX
K629C:  STD  MS_AY,U
K629E:  STD  MS_AZ,U
K62A0:  STD  MS_BX,U
;STD M$BY(U)
K62A2:  STD  MS_BZ,U
K62A4:  STD  ,U                     ;MS_CX,U
K62A6:  STD  MS_CY,U
;STD M$CZ(U)
K62A8:  LDA  #$40                   ;IDENTITY VALUE FOR 1.
K62AA:  STD  MS_AX,U
K62AC:  STD  MS_BY,U
K62AE:  STD  MS_CZ,U
K62B0:  RTS

;------------------------------------------------------------------------------
; tranu1_entry_b1 - bank 1's copy of tranu1_entry, the real entry of ESB's TRANU1: it saves U, which the
;   transpose uses as its second scratch register, and the code ends with PULS U,PC. the TRANU1_B1 label two bytes
;   further on must not be called by itself. no call to either address was found in bank 1
;------------------------------------------------------------------------------
tranu1_entry_b1:
K62B1:  PSHS U

;------------------------------------------------------------------------------
; TRANU1_B1 - TRANSPOSE U1 UNIT VECTORS
;   in ESB: bank 1's copy, with its real entry at tranu1_entry_b1 two bytes before. no call to either address
;   was found, so it is unused
;------------------------------------------------------------------------------
TRANU1_B1:
K62B3:  LDD  (MS_AY+M_U1)&$FFFF
K62B6:  LDU  (MS_BX+M_U1)&$FFFF
K62B9:  STD  (MS_BX+M_U1)&$FFFF
K62BC:  STU  (MS_AY+M_U1)&$FFFF
K62BF:  LDD  (MS_AZ+M_U1)&$FFFF
K62C2:  LDU  MS_CX+M_U1
K62C5:  STD  MS_CX+M_U1
K62C8:  STU  (MS_AZ+M_U1)&$FFFF
K62CB:  LDD  (MS_BZ+M_U1)&$FFFF
K62CE:  LDU  MS_CY+M_U1
K62D1:  STD  MS_CY+M_U1
K62D4:  STU  (MS_BZ+M_U1)&$FFFF
K62D7:  PULS U,PC

;------------------------------------------------------------------------------
; store_u1_blk_b1 - bank 1's copy of store_u1_block: copies the ship 1 download block of the math box (the nine
;   matrix terms, the three spare words and the position) into the unit vector block whose middle U points at. no
;   caller found in bank 1
;------------------------------------------------------------------------------
store_u1_blk_b1:
K62D9:  LDD  M_AX1
K62DC:  STD  -16,U
K62DE:  LDD  M_AY1
K62E1:  STD  -14,U
K62E3:  LDD  M_AZ1
K62E6:  STD  -12,U
K62E8:  LDD  M_BX1
K62EB:  STD  -8,U
K62ED:  LDD  M_BY1
K62F0:  STD  -6,U
K62F2:  LDD  M_BZ1
K62F5:  STD  -4,U
K62F7:  LDD  M_CX1
K62FA:  STD  ,U
K62FC:  LDD  M_CY1
K62FF:  STD  2,U
K6301:  LDD  M_CZ1
K6304:  STD  4,U
K6306:  LDD  M_XT1
K6309:  STD  8,U
K630B:  LDD  M_YT1
K630E:  STD  10,U
K6310:  LDD  M_ZT1
K6313:  STD  12,U
K6315:  LDD  m_vx1
K6318:  STD  -10,U
K631A:  LDD  m_vy1
K631D:  STD  -2,U
K631F:  LDD  m_vz1
K6322:  STD  6,U
K6324:  RTS

;------------------------------------------------------------------------------
; IS1UV_B1 - MATH BOX, PRIMARY INIT  (comment at the calls)
;   DOWNLOAD LATEST UNIT VECTOR  (another call)
;   DOWNLOAD VECTORS  (another call)
;   in ESB: bank 1's copy of bank 0's routine. nothing in bank 1 calls it and no entry of the cross-bank table
;   leads to it, so it is unused
;------------------------------------------------------------------------------
IS1UV_B1:
K6325:  STA  M_BICL
K6328:  CLR  M_BICH
K632B:  LDA  #MS_DLD1
K632D:  JSR  MGOWT_B1
K6330:  RTS

;------------------------------------------------------------------------------
; IS2UV_B1 - DOWNLOAD SHIP 2 UNIT VECTORS  (comment at the call)
;   DOWNLOAD DESTINATION MATRIX  (another call)
;------------------------------------------------------------------------------
IS2UV_B1:
K6331:  STA  M_BICL
K6334:  CLR  M_BICH
K6337:  LDA  #MS_DLD2
K6339:  JSR  MGOWT_B1
K633C:  RTS

;------------------------------------------------------------------------------
; presub_via_u2_b1 - bank 1's copy of presub_via_u2: swaps the ship 1 and ship 2 download blocks, runs math box
;   program $67 for the block index in M_BIC and waits, then swaps the blocks back. no caller found in bank 1
;------------------------------------------------------------------------------
presub_via_u2_b1:
K633D:  JSR  swap_u1_u2_b1
K6340:  LDA  #$67                   ;MS_PSB2, the 15-bit pre-subtract, for the block index in M_BIC
K6342:  JSR  MGOWT_B1
K6345:  JSR  swap_u1_u2_b1
K6348:  RTS

;------------------------------------------------------------------------------
; swap_u1_u2_b1 - bank 1's copy of swap_u1_u2: exchanges the ship 1 download block with the ship 2 block word by
;   word, the nine matrix terms and the position. U is saved and used as the second scratch register. the three
;   headers that follow are parts of this one routine. called only by presub_via_u2_b1
;------------------------------------------------------------------------------
swap_u1_u2_b1:
K6349:  PSHS U
K634B:  LDD  M_AX1
K634E:  LDU  M_AX2
K6351:  STD  M_AX2
K6354:  STU  M_AX1

swap_u1_u2_b1_b:
K6357:  LDD  (MS_AY+M_U1)&$FFFF
K635A:  LDU  M_AY2
K635D:  STD  M_AY2
K6360:  STU  (MS_AY+M_U1)&$FFFF
K6363:  LDD  (MS_AZ+M_U1)&$FFFF
K6366:  LDU  M_AZ2
K6369:  STD  M_AZ2
K636C:  STU  (MS_AZ+M_U1)&$FFFF
K636F:  LDD  M_BX1
K6372:  LDU  M_BX2
K6375:  STD  M_BX2
K6378:  STU  M_BX1
K637B:  LDD  M_BY1
K637E:  LDU  M_BY2
K6381:  STD  M_BY2
K6384:  STU  M_BY1
K6387:  LDD  (MS_BZ+M_U1)&$FFFF
K638A:  LDU  M_BZ2
K638D:  STD  M_BZ2
K6390:  STU  (MS_BZ+M_U1)&$FFFF
K6393:  LDD  M_CX1
K6396:  LDU  M_CX2
K6399:  STD  M_CX2
K639C:  STU  M_CX1

swap_u1_u2_b1_c:
K639F:  LDD  M_CY1
K63A2:  LDU  M_CY2
K63A5:  STD  M_CY2
K63A8:  STU  M_CY1
K63AB:  LDD  M_CZ1
K63AE:  LDU  M_CZ2
K63B1:  STD  M_CZ2
K63B4:  STU  M_CZ1

swap_u1_u2_b1_d:
K63B7:  LDD  M_XT1
K63BA:  LDU  M_XT2
K63BD:  STD  M_XT2
K63C0:  STU  M_XT1
K63C3:  LDD  M_YT1
K63C6:  LDU  M_YT2
K63C9:  STD  M_YT2
K63CC:  STU  M_YT1
K63CF:  LDD  M_ZT1
K63D2:  LDU  M_ZT2
K63D5:  STD  M_ZT2
K63D8:  STU  M_ZT1
K63DB:  PULS U,PC

;------------------------------------------------------------------------------
; S1RL_B1 - ROLL PLAYER SHIP
;   in ESB: bank 1's copy of bank 0's routine. nothing calls it, so it is unused
;------------------------------------------------------------------------------
S1RL_B1:
K63DD:  LDD  #MS_S1BC
K63E0:  STD  M_BIC
K63E3:  LDA  #MS_ROLL
K63E5:  JMP  MGOWT_B1               ;RTS

;------------------------------------------------------------------------------
; S1PT_B1 - PITCH PLAYER SHIP
;   in ESB: bank 1's copy of bank 0's routine. nothing calls it, so it is unused
;------------------------------------------------------------------------------
S1PT_B1:
K63E8:  LDD  #MS_S1BC
K63EB:  STD  M_BIC
K63EE:  LDA  #MS_PTCH
K63F0:  JMP  MGOWT_B1               ;RTS

;------------------------------------------------------------------------------
; S1YW_B1 - YAW PLAYER SHIP
;   in ESB: bank 1's copy of bank 0's routine. nothing calls it, so it is unused
;------------------------------------------------------------------------------
S1YW_B1:
K63F3:  LDD  #MS_S1BC
K63F6:  STD  M_BIC
K63F9:  LDA  #MS_YAW
K63FB:  JMP  MGOWT_B1               ;RTS

;------------------------------------------------------------------------------
; roll_by_angle_b1 - bank 1's copy of roll_by_angle: B = angle (256 to the full turn), block index already in
;   M_BIC. sets M_SIN and M_COS from the sine table and runs math box program MS_ROLL. no caller found in bank 1
;------------------------------------------------------------------------------
roll_by_angle_b1:
K63FE:  JSR  set_sin_cos_b1
K6401:  LDA  #$00                   ;MS_ROLL
K6403:  JMP  MGOWT_B1

;------------------------------------------------------------------------------
; pitch_by_angle_b1 - bank 1's copy of pitch_by_angle: as roll_by_angle_b1 with math box program MS_PTCH. no
;   caller found in bank 1
;------------------------------------------------------------------------------
pitch_by_angle_b1:
K6406:  JSR  set_sin_cos_b1
K6409:  LDA  #$0E                   ;MS_PTCH
K640B:  JMP  MGOWT_B1

;------------------------------------------------------------------------------
; yaw_by_angle_b1 - bank 1's copy of yaw_by_angle: as roll_by_angle_b1 with math box program MS_YAW. no caller
;   found in bank 1
;------------------------------------------------------------------------------
yaw_by_angle_b1:
K640E:  JSR  set_sin_cos_b1
K6411:  LDA  #$1C                   ;MS_YAW
K6413:  JMP  MGOWT_B1

;------------------------------------------------------------------------------
; set_sin_cos_b1 - bank 1's copy of set_sin_cos: B = angle (256 to the full turn), writes its sine to M_SIN and
;   its cosine to M_COS for the math box rotate programs. X is saved, D returns the cosine. used only by the three
;   unused rotate entries in front of it
;------------------------------------------------------------------------------
set_sin_cos_b1:
K6416:  PSHS X
K6418:  STB  M_COS                  ;the angle is parked in the high byte of M_COS
K641B:  JSR  sine_b1
K641E:  STD  M_SIN
K6421:  LDB  M_COS
K6424:  ADDB #$40                   ;a quarter turn on: the cosine
K6426:  JSR  sine_b1
K6429:  STD  M_COS
K642C:  PULS X,PC

;------------------------------------------------------------------------------
; sine_b1 - bank 1's copy of sine: B = angle (256 to the full turn), returns D = sine as a signed fraction with
;   $4000 = 1.0. looks the first quadrant up in the 65-word table sine_tab_b1, reads the table backwards for the
;   second quadrant and negates the value for angles $80-$FF. uses X
;------------------------------------------------------------------------------
sine_b1:
K642E:  LDX  #sine_tab_b1
K6431:  BITB #$40                   ;second or fourth quadrant?
K6433:  BEQ  K643A
K6435:  EORB #$3F                   ;then count back from 90 degrees
K6437:  LDX  #sine_tab_b1+2
K643A:  ASLB                        ;word index, and bit 7 of the angle goes to carry
K643B:  ANDB #$7F
K643D:  ABX                         ;carry set, angle $80-$FF: the sine is negative
K643E:  BCC  K6447
K6440:  LDD  #$0000
K6443:  SUBD ,X
K6445:  BRA  K6449
K6447:  LDD  ,X
K6449:  RTS

sine_tab_b1:
K644A:  .word $0000                 ;sine table: 65 words, 0 to 90 degrees in steps of 1/256 turn, $4000 = 1.0
K644C:  .word $0192, $0324
K6450:  .word $04B5, $0646, $07D6, $0964
K6458:  .word $0AF1, $0C7C, $0E06, $0F8D
K6460:  .word $1112, $1294, $1413, $1590
K6468:  .word $1709, $187E, $19EF, $1B5D
K6470:  .word $1CC6, $1E2B, $1F8C, $20E7
K6478:  .word $223D, $238E, $24DA, $2620
K6480:  .word $2760, $289A, $29CE, $2AFB
K6488:  .word $2C21, $2D41, $2E5A, $2F6C
K6490:  .word $3076, $3179, $3274, $3368
K6498:  .word $3453, $3537, $3612, $36E5
K64A0:  .word $37AF, $3871, $392B, $39DB
K64A8:  .word $3A82, $3B21, $3BB6, $3C42
K64B0:  .word $3CC5, $3D3F, $3DAF, $3E15
K64B8:  .word $3E72, $3EC5, $3F0F, $3F4F
K64C0:  .word $3F85, $3FB1, $3FD4, $3FEC
K64C8:  .word $3FFB, $4000

;------------------------------------------------------------------------------
; BINBCD - BIN TO BCD, BCD TO BIN, AND VIEW BYTES
;   CONVERT POSITIVE BINARY TO BCD
;   INPUT BINARY IN D, NUMBER OF SHIFTS IN X
;   OUTPUT IS BCD IN BCD,BCD+1,BCD+2
;------------------------------------------------------------------------------
BINBCD:
K64CC:  STD  BIN
K64CF:  LDD  #$0000
K64D2:  STD  BCD
K64D5:  STA  BCD+2
K64D8:  ASL  BIN+1
K64DB:  ROL  BIN
K64DE:  LDA  BCD+2
K64E1:  ADCA BCD+2
K64E4:  DAA
K64E5:  STA  BCD+2
K64E8:  LDA  BCD+1
K64EB:  ADCA BCD+1
K64EE:  DAA
K64EF:  STA  BCD+1
K64F2:  ROL  BCD
K64F5:  LEAX -$1,X
K64F7:  BNE  K64D8                  ;EQEND
K64F9:  RTS

;------------------------------------------------------------------------------
; BCDBIN_B1 - CONVERT 2 POSITIVE BCD DIGITS TO BINARY
;   INPUT A, OUTPUT BIN
;   in ESB: bank 1's copy of bank 0's routine. nothing calls it, so it is unused
;------------------------------------------------------------------------------
BCDBIN_B1:
K64FA:  STA  BIN
K64FD:  ANDA #$F0                   ;USE FIRST NYBBLE
K64FF:  LDB  #$A0
K6501:  MUL                         ;ACC A CONTAINS FIRST DIGIT*10.
K6502:  LDB  BIN
K6505:  ANDB #$0F
K6507:  STB  BIN
K650A:  ADDA BIN
K650D:  STA  BIN
K6510:  RTS

;------------------------------------------------------------------------------
; rnd_set_b1 - bank 1's copy of rnd_set, ESB's form of the Star Wars RND8: moves RND_S1 and RND_S2 down to
;   RND_S3 and the byte after it, then reads two new bytes from the pokey random register P_RND1 into RND_S2 and
;   RND_S1. called by the star code at K7D0F and K7D50
;------------------------------------------------------------------------------
rnd_set_b1:
K6511:  LDD  RND_S1                 ;the last two bytes move down to RND_S3 and $4855
K6513:  STD  RND_S3
K6515:  LDA  P_RND1                 ;two new random bytes
K6518:  STA  RND_S2
K651A:  LDA  P_RND1
K651D:  STA  RND_S1
K651F:  RTS

;------------------------------------------------------------------------------
; DOXMT_B1 - DOXMT - XMT TO SOUND BOARD
;   A := ID OF REQUESTED SOUND
;   ALL INDEX REGS MUST BE SAVED
;   ABOUT 50 CYCLE LATENCY FOR SOUND BOARD
;   USE SAFETY FACTOR OF 4 FOR 200 CYCLES
;   15 CYCLES PER FOLLOWING LOOP*14. IS 210.
;------------------------------------------------------------------------------
DOXMT_B1:
K6520:  LDB  #$0E                   ;TIME OUT THE SOUND BOARD
K6522:  TST  R_STAS                 ;D7 HI SAYS PREVIOUS XMT STILL THERE
K6525:  BPL  DOXMT_30_B1            ;SKIP OUT WHEN ROOM FOR MORE DATA
K6527:  DECB
K6528:  BNE  K6522                  ;EQEND
K652A:  LDA  #$00                   ;TOOK TOO LONG TO PROCESS,

;SO SOFTWARE RESET SOUND BOARD
DOXMT_30_B1:
K652C:  STA  W_XMTS                 ;SHIP IT OUT
K652F:  RTS

;------------------------------------------------------------------------------
; doxmt_gated_b1 - bank 1's copy of doxmt_gated: sends sound command A through DOXMT_B1 only while snd_mute is
;   zero
;------------------------------------------------------------------------------
doxmt_gated_b1:
K6530:  LDB  snd_mute
K6533:  BEQ  DOXMT_B1
K6535:  RTS

;------------------------------------------------------------------------------
; AUDTST_B1 - SNDPBX - XMT,RCV ROUTINE TAGS
;   USE POKEY AND SPEECH RIGHT AWAY FOR IMPATIENT TECHS
;   in ESB: bank 1's copy of bank 0's stub. nothing calls it
;------------------------------------------------------------------------------
AUDTST_B1:
K6536:  LDA  #IDATST                ;AUD TST  SOUND EFFECT POKEY TEST TONES
K6538:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; PMTST_B1 - [note] Request music channel POKEY test tones: A = IDPTST, jump to DOXMT
;   in ESB: bank 1's copy of bank 0's stub. nothing calls it
;------------------------------------------------------------------------------
PMTST_B1:
K653B:  LDA  #IDPTST                ;PM TST  MUSIC CHANNEL POKEY TEST TONES
K653D:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_03_b1 - bank 1's copy of spk_cmd_03: sends sound command $03 through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_03_b1:
K6540:  LDA  #$03                   ;of bank 1's copies of the sound stubs only aud_cmd_38_b1, aud_cmd_3b_b1 and aud_cmd_3f_b1 are called (by GETINT, the initials entry). nothing calls the others, AUDTST_B1 and PMTST_B1 included: bank 0 and the pages use bank 0's stubs
K6542:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_04_b1 - bank 1's copy of spk_cmd_04: sends sound command $04 through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_04_b1:
K6545:  LDA  #$04
K6547:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_05_b1 - bank 1's copy of spk_cmd_05: sends sound command $05 through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_05_b1:
K654A:  LDA  #$05
K654C:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_06_b1 - bank 1's copy of spk_cmd_06: sends sound command $06 through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_06_b1:
K654F:  LDA  #$06
K6551:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_07_b1 - bank 1's copy of spk_cmd_07: sends sound command $07 through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_07_b1:
K6554:  LDA  #$07
K6556:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_08_b1 - bank 1's copy of spk_cmd_08: sends sound command $08 through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_08_b1:
K6559:  LDA  #$08
K655B:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_09_b1 - bank 1's copy of spk_cmd_09: sends sound command $09 through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_09_b1:
K655E:  LDA  #$09
K6560:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_0a_b1 - bank 1's copy of spk_cmd_0a: sends sound command $0A through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_0a_b1:
K6563:  LDA  #$0A
K6565:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_0b_b1 - bank 1's copy of spk_cmd_0b: sends sound command $0B through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_0b_b1:
K6568:  LDA  #$0B
K656A:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_0c_b1 - bank 1's copy of spk_cmd_0c: sends sound command $0C through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_0c_b1:
K656D:  LDA  #$0C
K656F:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_0d_b1 - bank 1's copy of spk_cmd_0d: sends sound command $0D through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_0d_b1:
K6572:  LDA  #$0D
K6574:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_0e_b1 - bank 1's copy of spk_cmd_0e: sends sound command $0E through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_0e_b1:
K6577:  LDA  #$0E
K6579:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_0f_b1 - bank 1's copy of spk_cmd_0f: sends sound command $0F through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_0f_b1:
K657C:  LDA  #$0F
K657E:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_10_b1 - bank 1's copy of spk_cmd_10: sends sound command $10 through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_10_b1:
K6581:  LDA  #$10
K6583:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_11_b1 - bank 1's copy of spk_cmd_11: sends sound command $11 through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_11_b1:
K6586:  LDA  #$11
K6588:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_12_b1 - bank 1's copy of spk_cmd_12: sends sound command $12 through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_12_b1:
K658B:  LDA  #$12
K658D:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_13_b1 - bank 1's copy of spk_cmd_13: sends sound command $13 through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_13_b1:
K6590:  LDA  #$13
K6592:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_14_b1 - bank 1's copy of spk_cmd_14: sends sound command $14 through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_14_b1:
K6595:  LDA  #$14
K6597:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_15_b1 - bank 1's copy of spk_cmd_15: sends sound command $15 through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_15_b1:
K659A:  LDA  #$15
K659C:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_16_b1 - bank 1's copy of spk_cmd_16: sends sound command $16 through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_16_b1:
K659F:  LDA  #$16
K65A1:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_17_b1 - bank 1's copy of spk_cmd_17: sends sound command $17 through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_17_b1:
K65A4:  LDA  #$17
K65A6:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_18_b1 - bank 1's copy of spk_cmd_18: sends sound command $18 through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_18_b1:
K65A9:  LDA  #$18
K65AB:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_19_b1 - bank 1's copy of spk_cmd_19: sends sound command $19 through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_19_b1:
K65AE:  LDA  #$19
K65B0:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_1a_b1 - bank 1's copy of spk_cmd_1a: sends sound command $1A through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_1a_b1:
K65B3:  LDA  #$1A
K65B5:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_1b_b1 - bank 1's copy of spk_cmd_1b: sends sound command $1B through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_1b_b1:
K65B8:  LDA  #$1B
K65BA:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_1c_b1 - bank 1's copy of spk_cmd_1c: sends sound command $1C through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_1c_b1:
K65BD:  LDA  #$1C
K65BF:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_1d_b1 - bank 1's copy of spk_cmd_1d: sends sound command $1D through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_1d_b1:
K65C2:  LDA  #$1D
K65C4:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_1e_b1 - bank 1's copy of spk_cmd_1e: sends sound command $1E through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_1e_b1:
K65C7:  LDA  #$1E
K65C9:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_1f_b1 - bank 1's copy of spk_cmd_1f: sends sound command $1F through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_1f_b1:
K65CC:  LDA  #$1F
K65CE:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_20_b1 - bank 1's copy of spk_cmd_20: sends sound command $20 through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_20_b1:
K65D1:  LDA  #$20
K65D3:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_21_b1 - bank 1's copy of spk_cmd_21: sends sound command $21 through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_21_b1:
K65D6:  LDA  #$21
K65D8:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_22_b1 - bank 1's copy of spk_cmd_22: sends sound command $22 through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_22_b1:
K65DB:  LDA  #$22
K65DD:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_23_b1 - bank 1's copy of spk_cmd_23: sends sound command $23 through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_23_b1:
K65E0:  LDA  #$23
K65E2:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_24_b1 - bank 1's copy of spk_cmd_24: sends sound command $24 through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_24_b1:
K65E5:  LDA  #$24
K65E7:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_25_b1 - bank 1's copy of spk_cmd_25: sends sound command $25 through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_25_b1:
K65EA:  LDA  #$25
K65EC:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_26_b1 - bank 1's copy of spk_cmd_26: sends sound command $26 through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_26_b1:
K65EF:  LDA  #$26
K65F1:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_27_b1 - bank 1's copy of spk_cmd_27: sends sound command $27 through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_27_b1:
K65F4:  LDA  #$27
K65F6:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; spk_cmd_28_b1 - bank 1's copy of spk_cmd_28: sends sound command $28 through DOXMT_B1
;------------------------------------------------------------------------------
spk_cmd_28_b1:
K65F9:  LDA  #$28
K65FB:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; tune_cmd_29_b1 - bank 1's copy of tune_cmd_29: sends sound command $29 through DOXMT_B1
;------------------------------------------------------------------------------
tune_cmd_29_b1:
K65FE:  LDA  #$29
K6600:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; tune_cmd_2a_b1 - bank 1's copy of tune_cmd_2a: sends sound command $2A through DOXMT_B1
;------------------------------------------------------------------------------
tune_cmd_2a_b1:
K6603:  LDA  #$2A
K6605:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; tune_cmd_2b_b1 - bank 1's copy of tune_cmd_2b: sends sound command $2B through DOXMT_B1
;------------------------------------------------------------------------------
tune_cmd_2b_b1:
K6608:  LDA  #$2B
K660A:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; tune_cmd_2c_b1 - bank 1's copy of tune_cmd_2c: sends sound command $2C through DOXMT_B1
;------------------------------------------------------------------------------
tune_cmd_2c_b1:
K660D:  LDA  #$2C
K660F:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; tune_cmd_2d_b1 - bank 1's copy of tune_cmd_2d: sends sound command $2D through DOXMT_B1
;------------------------------------------------------------------------------
tune_cmd_2d_b1:
K6612:  LDA  #$2D
K6614:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; tune_cmd_2e_b1 - bank 1's copy of tune_cmd_2e: sends sound command $2E through DOXMT_B1
;------------------------------------------------------------------------------
tune_cmd_2e_b1:
K6617:  LDA  #$2E
K6619:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; tune_cmd_2f_b1 - bank 1's copy of tune_cmd_2f: sends sound command $2F through DOXMT_B1
;------------------------------------------------------------------------------
tune_cmd_2f_b1:
K661C:  LDA  #$2F
K661E:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; tune_cmd_30_b1 - bank 1's copy of tune_cmd_30: sends sound command $30 through DOXMT_B1
;------------------------------------------------------------------------------
tune_cmd_30_b1:
K6621:  LDA  #$30
K6623:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; tune_cmd_31_b1 - bank 1's copy of tune_cmd_31: sends sound command $31 through DOXMT_B1
;------------------------------------------------------------------------------
tune_cmd_31_b1:
K6626:  LDA  #$31
K6628:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; aud_cmd_32_b1 - bank 1's copy of aud_cmd_32: sends sound command $32 through doxmt_gated_b1
;------------------------------------------------------------------------------
aud_cmd_32_b1:
K662B:  LDA  #$32
K662D:  JMP  doxmt_gated_b1

;------------------------------------------------------------------------------
; aud_cmd_33_b1 - bank 1's copy of aud_cmd_33: sends sound command $33 through doxmt_gated_b1
;------------------------------------------------------------------------------
aud_cmd_33_b1:
K6630:  LDA  #$33
K6632:  JMP  doxmt_gated_b1

;------------------------------------------------------------------------------
; aud_cmd_34_b1 - bank 1's copy of aud_cmd_34: sends sound command $34 through DOXMT_B1
;------------------------------------------------------------------------------
aud_cmd_34_b1:
K6635:  LDA  #$34
K6637:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; aud_cmd_35_b1 - bank 1's copy of aud_cmd_35: sends sound command $35 through doxmt_gated_b1
;------------------------------------------------------------------------------
aud_cmd_35_b1:
K663A:  LDA  #$35
K663C:  JMP  doxmt_gated_b1

;------------------------------------------------------------------------------
; aud_cmd_36_b1 - bank 1's copy of aud_cmd_36: sends sound command $36 through DOXMT_B1
;------------------------------------------------------------------------------
aud_cmd_36_b1:
K663F:  LDA  #$36
K6641:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; aud_cmd_37_b1 - bank 1's copy of aud_cmd_37: sends sound command $37 through doxmt_gated_b1
;------------------------------------------------------------------------------
aud_cmd_37_b1:
K6644:  LDA  #$37
K6646:  JMP  doxmt_gated_b1

;------------------------------------------------------------------------------
; aud_cmd_38_b1 - bank 1's copy of aud_cmd_38: sends sound command $38 through doxmt_gated_b1
;------------------------------------------------------------------------------
aud_cmd_38_b1:
K6649:  LDA  #$38
K664B:  JMP  doxmt_gated_b1

;------------------------------------------------------------------------------
; aud_cmd_39_b1 - bank 1's copy of aud_cmd_39: sends sound command $39 through doxmt_gated_b1
;------------------------------------------------------------------------------
aud_cmd_39_b1:
K664E:  LDA  #$39
K6650:  JMP  doxmt_gated_b1

;------------------------------------------------------------------------------
; aud_cmd_3a_b1 - bank 1's copy of aud_cmd_3a: sends sound command $3A through doxmt_gated_b1
;------------------------------------------------------------------------------
aud_cmd_3a_b1:
K6653:  LDA  #$3A
K6655:  JMP  doxmt_gated_b1

;------------------------------------------------------------------------------
; aud_cmd_3b_b1 - bank 1's copy of aud_cmd_3b: sends sound command $3B through doxmt_gated_b1
;------------------------------------------------------------------------------
aud_cmd_3b_b1:
K6658:  LDA  #$3B
K665A:  JMP  doxmt_gated_b1

;------------------------------------------------------------------------------
; aud_cmd_3c_b1 - bank 1's copy of aud_cmd_3c: sends sound command $3C through doxmt_gated_b1
;------------------------------------------------------------------------------
aud_cmd_3c_b1:
K665D:  LDA  #$3C
K665F:  JMP  doxmt_gated_b1

;------------------------------------------------------------------------------
; aud_cmd_3d_b1 - bank 1's copy of aud_cmd_3d: sends sound command $3D through doxmt_gated_b1
;------------------------------------------------------------------------------
aud_cmd_3d_b1:
K6662:  LDA  #$3D
K6664:  JMP  doxmt_gated_b1

;------------------------------------------------------------------------------
; aud_cmd_3e_b1 - bank 1's copy of aud_cmd_3e: sends sound command $3E through doxmt_gated_b1
;------------------------------------------------------------------------------
aud_cmd_3e_b1:
K6667:  LDA  #$3E
K6669:  JMP  doxmt_gated_b1

;------------------------------------------------------------------------------
; aud_cmd_3f_b1 - bank 1's copy of aud_cmd_3f: sends sound command $3F through doxmt_gated_b1
;------------------------------------------------------------------------------
aud_cmd_3f_b1:
K666C:  LDA  #$3F
K666E:  JMP  doxmt_gated_b1

;------------------------------------------------------------------------------
; aud_cmd_40_b1 - bank 1's copy of aud_cmd_40: sends sound command $40 through DOXMT_B1
;------------------------------------------------------------------------------
aud_cmd_40_b1:
K6671:  LDA  #$40
K6673:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; aud_cmd_41_b1 - bank 1's copy of aud_cmd_41: sends sound command $41 through doxmt_gated_b1
;------------------------------------------------------------------------------
aud_cmd_41_b1:
K6676:  LDA  #$41
K6678:  JMP  doxmt_gated_b1

;------------------------------------------------------------------------------
; aud_cmd_42_b1 - bank 1's copy of aud_cmd_42: sends sound command $42 through doxmt_gated_b1
;------------------------------------------------------------------------------
aud_cmd_42_b1:
K667B:  LDA  #$42
K667D:  JMP  doxmt_gated_b1

;------------------------------------------------------------------------------
; aud_cmd_43_b1 - bank 1's copy of aud_cmd_43: sends sound command $43 through doxmt_gated_b1
;------------------------------------------------------------------------------
aud_cmd_43_b1:
K6680:  LDA  #$43
K6682:  JMP  doxmt_gated_b1

;------------------------------------------------------------------------------
; aud_cmd_44_b1 - bank 1's copy of aud_cmd_44: sends sound command $44 through DOXMT_B1
;------------------------------------------------------------------------------
aud_cmd_44_b1:
K6685:  LDA  #$44
K6687:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; aud_cmd_45_b1 - bank 1's copy of aud_cmd_45: sends sound command $45 through doxmt_gated_b1
;------------------------------------------------------------------------------
aud_cmd_45_b1:
K668A:  LDA  #$45
K668C:  JMP  doxmt_gated_b1

;------------------------------------------------------------------------------
; aud_cmd_46_b1 - bank 1's copy of aud_cmd_46: sends sound command $46 through doxmt_gated_b1
;------------------------------------------------------------------------------
aud_cmd_46_b1:
K668F:  LDA  #$46
K6691:  JMP  doxmt_gated_b1

;------------------------------------------------------------------------------
; aud_cmd_47_b1 - bank 1's copy of aud_cmd_47: sends sound command $47 through doxmt_gated_b1
;------------------------------------------------------------------------------
aud_cmd_47_b1:
K6694:  LDA  #$47
K6696:  JMP  doxmt_gated_b1

;------------------------------------------------------------------------------
; aud_cmd_48_b1 - bank 1's copy of aud_cmd_48: sends sound command $48 through doxmt_gated_b1
;------------------------------------------------------------------------------
aud_cmd_48_b1:
K6699:  LDA  #$48
K669B:  JMP  doxmt_gated_b1

;------------------------------------------------------------------------------
; aud_cmd_49_b1 - bank 1's copy of aud_cmd_49: sends sound command $49 through doxmt_gated_b1
;------------------------------------------------------------------------------
aud_cmd_49_b1:
K669E:  LDA  #$49
K66A0:  JMP  doxmt_gated_b1

;------------------------------------------------------------------------------
; aud_cmd_4a_b1 - bank 1's copy of aud_cmd_4a: sends sound command $4A through doxmt_gated_b1
;------------------------------------------------------------------------------
aud_cmd_4a_b1:
K66A3:  LDA  #$4A
K66A5:  JMP  doxmt_gated_b1

;------------------------------------------------------------------------------
; aud_cmd_4b_b1 - bank 1's copy of aud_cmd_4b: sends sound command $4B through doxmt_gated_b1
;------------------------------------------------------------------------------
aud_cmd_4b_b1:
K66A8:  LDA  #$4B
K66AA:  JMP  doxmt_gated_b1

;------------------------------------------------------------------------------
; aud_cmd_4c_b1 - bank 1's copy of aud_cmd_4c: sends sound command $4C through doxmt_gated_b1
;------------------------------------------------------------------------------
aud_cmd_4c_b1:
K66AD:  LDA  #$4C
K66AF:  JMP  doxmt_gated_b1

;------------------------------------------------------------------------------
; aud_cmd_4d_b1 - bank 1's copy of aud_cmd_4d: sends sound command $4D through doxmt_gated_b1
;------------------------------------------------------------------------------
aud_cmd_4d_b1:
K66B2:  LDA  #$4D
K66B4:  JMP  doxmt_gated_b1

;------------------------------------------------------------------------------
; aud_cmd_4e_b1 - bank 1's copy of aud_cmd_4e: sends sound command $4E through doxmt_gated_b1
;------------------------------------------------------------------------------
aud_cmd_4e_b1:
K66B7:  LDA  #$4E
K66B9:  JMP  doxmt_gated_b1

;------------------------------------------------------------------------------
; aud_cmd_4f_b1 - bank 1's copy of aud_cmd_4f: sends sound command $4F through doxmt_gated_b1
;------------------------------------------------------------------------------
aud_cmd_4f_b1:
K66BC:  LDA  #$4F
K66BE:  JMP  doxmt_gated_b1

;------------------------------------------------------------------------------
; aud_cmd_50_b1 - bank 1's copy of aud_cmd_50: sends sound command $50 through doxmt_gated_b1
;------------------------------------------------------------------------------
aud_cmd_50_b1:
K66C1:  LDA  #$50
K66C3:  JMP  doxmt_gated_b1

;------------------------------------------------------------------------------
; aud_cmd_51_b1 - bank 1's copy of aud_cmd_51: sends sound command $51 through doxmt_gated_b1
;------------------------------------------------------------------------------
aud_cmd_51_b1:
K66C6:  LDA  #$51
K66C8:  JMP  doxmt_gated_b1

;------------------------------------------------------------------------------
; aud_cmd_52_b1 - bank 1's copy of aud_cmd_52: sends sound command $52 through DOXMT_B1
;------------------------------------------------------------------------------
aud_cmd_52_b1:
K66CB:  LDA  #$52
K66CD:  JMP  DOXMT_B1

;------------------------------------------------------------------------------
; view_title_logo - ESB's VWBNNR, rewritten: views the title of the banner phase, called once a frame by PHEBNR
;   through the cross-bank entry L60F0 with Y = display list pointer. counts BN_CNT up. for the first $20 frames
;   the logo brightens in place (bn_brite up 5 a frame, linear scale $20), then it dims by 2 a frame and shrinks
;   (linear scale up 3 a frame) towards a point 358 units above the screen centre, and from frame $68 it is not
;   drawn. the logo is 27 outlines listed in ttl_outline_tab, each drawn by title_outline: the first six, STAR
;   WARS, in colour 1 and the others, THE EMPIRE STRIKES BACK and two bars, in colour 3. where Star Wars called
;   six vector ROM pictures, ESB builds the vectors from point lists. ends by jumping to bank 0's spmess_entry,
;   the special messages part of the Star Wars routine
;------------------------------------------------------------------------------
view_title_logo:
K66D0:  PSHS X,U
K66D2:  LDD  BN_CNT                 ;frames of banner so far, counted here
K66D5:  ADDD #$0001
K66D8:  STD  BN_CNT
K66DB:  CMPD #$0068                 ;from frame $68 on the title is gone: only the special messages are left
K66DF:  BCC  K6756
K66E1:  CMPD #$0020                 ;first $20 frames: the title brightens in place
K66E5:  BCC  K66F3
K66E7:  LDB  bn_brite
K66EA:  ADDB #$05                   ;brightness up 5 a frame
K66EC:  STB  bn_brite
K66EF:  LDB  #$20                   ;linear scale $20 while it brightens
K66F1:  BRA  K670C
K66F3:  LDB  bn_brite               ;after that it dims by 2 a frame, not below 0
K66F6:  BEQ  K6701
K66F8:  SUBB #$02
K66FA:  BCC  K66FE
K66FC:  LDB  #$00
K66FE:  STB  bn_brite
K6701:  LDB  bn_scale_lo            ;and it shrinks: linear scale up 3 a frame, $F8 at most
K6704:  ADDB #$03
K6706:  CMPB #$F8
K6708:  BLS  K670C
K670A:  LDB  #$F8
K670C:  LDA  #$72                   ;$72xx: scale instruction, binary scale 2
K670E:  STD  bn_scale
K6711:  LDB  bn_brite               ;brightness 0: nothing to draw
K6714:  BEQ  K6756
K6716:  LDA  #$61                   ;$61bb: colour 1, blue, for STAR WARS
K6718:  STD  ,Y++
K671A:  LDX  #ttl_outline_tab       ;X = table of the 27 outlines
K671D:  LDD  #$0166                 ;per outline: blank vector 358 up from the screen centre, to the point the title shrinks towards
K6720:  STD  ,Y++
K6722:  LDD  #$0000
K6725:  STD  ,Y++
K6727:  LDD  bn_scale               ;the title's scale
K672A:  STD  ,Y++
K672C:  LDD  #$1D6C                 ;blank vector dy -660, dx -425 at that scale, to x 0, y $198 of the outline coordinates
K672F:  STD  ,Y++
K6731:  LDD  #$1E57
K6734:  STD  ,Y++
K6736:  LDU  ,X++                   ;U = the next outline's records
K6738:  JSR  title_outline
K673B:  LDD  #$7200                 ;back to the normal scale and the centre
K673E:  STD  ,Y++
K6740:  LDD  #$8040
K6743:  STD  ,Y++
K6745:  CMPX #ttl_tab_esb           ;after the sixth outline: colour 3, turquoise, for THE EMPIRE STRIKES BACK
K6748:  BNE  K6751
K674A:  LDB  bn_brite
K674D:  LDA  #$63
K674F:  STD  ,Y++
K6751:  CMPX #ttl_outline_tab+54    ;until X reaches the end of the table, which is the address of the code after it
K6754:  BCS  K671D
K6756:  PULS X,U
K6758:  JMP  K6066                  ;bank 0 spmess_entry: the special messages that go with the banner

ttl_outline_tab:
K675B:  .word ttl_sw_st             ;outline 0  the 27 outlines of the title logo, in drawing order. first the six of STAR WARS
K675D:  .word ttl_sw_w              ;outline 1
K675F:  .word ttl_sw_a1             ;outline 2
K6761:  .word ttl_sw_a2             ;outline 3
K6763:  .word ttl_sw_r              ;outline 4
K6765:  .word ttl_sw_rs             ;outline 5

ttl_tab_esb:
K6767:  .word ttl_the_th            ;outline 6  the 21 of THE EMPIRE STRIKES BACK: TH, E, bar, EMPIRE, STRIKES, BACK, underline. the last four lists are past $7000
K6769:  .word ttl_the_e             ;outline 7
K676B:  .word ttl_the_bar           ;outline 8
K676D:  .word ttl_emp_e1            ;outline 9
K676F:  .word ttl_emp_m             ;outline 10
K6771:  .word ttl_emp_p             ;outline 11
K6773:  .word ttl_emp_i             ;outline 12
K6775:  .word ttl_emp_r             ;outline 13
K6777:  .word ttl_emp_e2            ;outline 14
K6779:  .word ttl_str_s1            ;outline 15
K677B:  .word ttl_str_t             ;outline 16
K677D:  .word ttl_str_r             ;outline 17
K677F:  .word ttl_str_i             ;outline 18
K6781:  .word ttl_str_k             ;outline 19
K6783:  .word ttl_str_e             ;outline 20
K6785:  .word ttl_str_s2            ;outline 21
K6787:  .word ttl_bck_b             ;outline 22
K6789:  .word bnr_back_a            ;outline 23
K678B:  .word bnr_back_c            ;outline 24
K678D:  .word bnr_back_k            ;outline 25
K678F:  .word bnr_bar               ;outline 26

;------------------------------------------------------------------------------
; title_outline - draws one outline of the title logo: U = list of 5-byte records (flag byte, x word, y word, a
;   flag of 0 ends the list), Y = display list pointer. the pen starts at x 0, y $198. for each record it writes a
;   long vector from the last point to this one, blank when bit 0 of the flag is set (flag 1) and at intensity 7
;   otherwise (flag 2). called only by view_title_logo
;------------------------------------------------------------------------------
title_outline:
K6791:  LDD  #$0198                 ;pen position: $4803 = last y, starts at $198
K6794:  STD  scratch_3
K6796:  LDD  #$0000                 ;scratch_1 = last x, starts at 0
K6799:  STD  scratch_1
K679B:  LDA  ,U                     ;flag byte of the record
K679D:  BITA #$01                   ;bit 0 set (flag 1): move without drawing
K679F:  BEQ  K67A4
K67A1:  CLRA
K67A2:  BRA  K67A6
K67A4:  LDA  #$E0                   ;else (flag 2) intensity 7
K67A6:  STA  scratch_5
K67A8:  LDD  3,U                    ;dy = y - last y, 13 bits
K67AA:  SUBD scratch_3
K67AC:  ANDA #$1F
K67AE:  STD  ,Y++
K67B0:  LDD  1,U                    ;dx = x - last x, with the intensity bits
K67B2:  SUBD scratch_1
K67B4:  ANDA #$1F
K67B6:  ORA  scratch_5
K67B8:  STD  ,Y++
K67BA:  LDD  1,U
K67BC:  STD  scratch_1
K67BE:  LDD  3,U
K67C0:  STD  scratch_3
K67C2:  LEAU 5,U                    ;next 5-byte record, a flag of 0 ends the outline
K67C4:  LDA  ,U
K67C6:  BNE  K679D
K67C8:  RTS

ttl_sw_st:
K67C9:  .byte $01, $00, $04, $00, $24 ;move to 4, 36  title logo outlines: 5-byte records - flag (1 move, 2 draw, 0 end of outline), x word, y word. x runs 0 to 850, y 18 to 906. this one: the ST of STAR, the S drawn out down the left edge of the logo
K67CE:  .byte $02, $00, $00, $00, $39 ;draw to 0, 57
K67D3:  .byte $02, $00, $00, $02, $37 ;draw to 0, 567
K67D8:  .byte $02, $00, $02, $02, $49 ;draw to 2, 585
K67DD:  .byte $02, $00, $08, $02, $55 ;draw to 8, 597
K67E2:  .byte $02, $00, $12, $02, $5E ;draw to 18, 606
K67E7:  .byte $02, $00, $50, $02, $76 ;draw to 80, 630
K67EC:  .byte $02, $00, $52, $02, $79 ;draw to 82, 633
K67F1:  .byte $02, $00, $48, $02, $82 ;draw to 72, 642
K67F6:  .byte $02, $00, $46, $02, $91 ;draw to 70, 657
K67FB:  .byte $02, $00, $4C, $02, $A0 ;draw to 76, 672
K6800:  .byte $02, $00, $8E, $02, $B8 ;draw to 142, 696
K6805:  .byte $02, $00, $8E, $02, $A9 ;draw to 142, 681
K680A:  .byte $02, $00, $7E, $02, $A3 ;draw to 126, 675
K680F:  .byte $02, $00, $7E, $02, $79 ;draw to 126, 633
K6814:  .byte $02, $00, $70, $02, $73 ;draw to 112, 627
K6819:  .byte $02, $00, $70, $02, $9D ;draw to 112, 669
K681E:  .byte $02, $00, $54, $02, $94 ;draw to 84, 660
K6823:  .byte $02, $00, $52, $02, $8E ;draw to 82, 654
K6828:  .byte $02, $00, $5E, $02, $82 ;draw to 94, 642
K682D:  .byte $02, $00, $60, $02, $76 ;draw to 96, 630
K6832:  .byte $02, $00, $5A, $02, $6A ;draw to 90, 618
K6837:  .byte $02, $00, $18, $02, $52 ;draw to 24, 594
K683C:  .byte $02, $00, $10, $02, $4C ;draw to 16, 588
K6841:  .byte $02, $00, $0C, $02, $43 ;draw to 12, 579
K6846:  .byte $02, $00, $0A, $02, $34 ;draw to 10, 564
K684B:  .byte $02, $00, $0A, $00, $3C ;draw to 10, 60
K6850:  .byte $02, $00, $0C, $00, $2D ;draw to 12, 45
K6855:  .byte $00                   ;end of outline 0

ttl_sw_w:
K6856:  .byte $01, $00, $04, $00, $24 ;move to 4, 36  the W of WARS, drawn out to the left along the bottom of the logo
K685B:  .byte $02, $00, $12, $00, $12 ;draw to 18, 18
K6860:  .byte $02, $00, $20, $00, $12 ;draw to 32, 18
K6865:  .byte $02, $02, $50, $00, $E4 ;draw to 592, 228
K686A:  .byte $02, $02, $5A, $00, $BA ;draw to 602, 186
K686F:  .byte $02, $02, $64, $00, $BD ;draw to 612, 189
K6874:  .byte $02, $02, $6A, $00, $E1 ;draw to 618, 225
K6879:  .byte $02, $02, $70, $00, $C3 ;draw to 624, 195
K687E:  .byte $02, $02, $78, $00, $C6 ;draw to 632, 198
K6883:  .byte $02, $02, $84, $01, $05 ;draw to 644, 261
K6888:  .byte $02, $02, $7A, $01, $02 ;draw to 634, 258
K688D:  .byte $02, $02, $74, $00, $E7 ;draw to 628, 231
K6892:  .byte $02, $02, $70, $00, $FF ;draw to 624, 255
K6897:  .byte $02, $02, $62, $00, $F9 ;draw to 610, 249
K689C:  .byte $02, $02, $5E, $00, $DE ;draw to 606, 222
K68A1:  .byte $02, $02, $58, $00, $F6 ;draw to 600, 246
K68A6:  .byte $02, $00, $20, $00, $21 ;draw to 32, 33
K68AB:  .byte $02, $00, $16, $00, $21 ;draw to 22, 33
K68B0:  .byte $02, $00, $0C, $00, $2D ;draw to 12, 45
K68B5:  .byte $00                   ;end of outline 1

ttl_sw_a1:
K68B6:  .byte $01, $00, $8A, $02, $7C ;move to 138, 636  the A of STAR, outline and hole
K68BB:  .byte $02, $00, $96, $02, $BB ;draw to 150, 699
K68C0:  .byte $02, $00, $AA, $02, $C1 ;draw to 170, 705
K68C5:  .byte $02, $00, $B2, $02, $8B ;draw to 178, 651
K68CA:  .byte $02, $00, $A4, $02, $85 ;draw to 164, 645
K68CF:  .byte $02, $00, $A2, $02, $91 ;draw to 162, 657
K68D4:  .byte $02, $00, $9A, $02, $8E ;draw to 154, 654
K68D9:  .byte $02, $00, $98, $02, $82 ;draw to 152, 642
K68DE:  .byte $02, $00, $8A, $02, $7C ;draw to 138, 636
K68E3:  .byte $01, $00, $9C, $02, $9A ;move to 156, 666
K68E8:  .byte $02, $00, $A0, $02, $AF ;draw to 160, 687
K68ED:  .byte $02, $00, $A2, $02, $9D ;draw to 162, 669
K68F2:  .byte $02, $00, $9C, $02, $9A ;draw to 156, 666
K68F7:  .byte $00                   ;end of outline 2

ttl_sw_a2:
K68F8:  .byte $01, $02, $80, $00, $C9 ;move to 640, 201  the A of WARS, outline and hole
K68FD:  .byte $02, $02, $8C, $01, $08 ;draw to 652, 264
K6902:  .byte $02, $02, $A0, $01, $11 ;draw to 672, 273
K6907:  .byte $02, $02, $A8, $00, $D8 ;draw to 680, 216
K690C:  .byte $02, $02, $9A, $00, $D2 ;draw to 666, 210
K6911:  .byte $02, $02, $98, $00, $DE ;draw to 664, 222
K6916:  .byte $02, $02, $90, $00, $DB ;draw to 656, 219
K691B:  .byte $02, $02, $8E, $00, $CF ;draw to 654, 207
K6920:  .byte $02, $02, $80, $00, $C9 ;draw to 640, 201
K6925:  .byte $01, $02, $92, $00, $E7 ;move to 658, 231
K692A:  .byte $02, $02, $96, $00, $FC ;draw to 662, 252
K692F:  .byte $02, $02, $98, $00, $EA ;draw to 664, 234
K6934:  .byte $02, $02, $92, $00, $E7 ;draw to 658, 231
K6939:  .byte $00                   ;end of outline 3

ttl_sw_r:
K693A:  .byte $01, $03, $52, $01, $65 ;move to 850, 357  the R of STAR, drawn out along the top and down the right edge of the logo
K693F:  .byte $02, $03, $52, $03, $63 ;draw to 850, 867
K6944:  .byte $02, $03, $4E, $03, $78 ;draw to 846, 888
K6949:  .byte $02, $03, $40, $03, $8A ;draw to 832, 906
K694E:  .byte $02, $00, $D6, $02, $A6 ;draw to 214, 678
K6953:  .byte $02, $00, $D4, $02, $A9 ;draw to 212, 681
K6958:  .byte $02, $00, $DC, $02, $AF ;draw to 220, 687
K695D:  .byte $02, $00, $DE, $02, $BE ;draw to 222, 702
K6962:  .byte $02, $00, $DA, $02, $CA ;draw to 218, 714
K6967:  .byte $02, $00, $D2, $02, $D0 ;draw to 210, 720
K696C:  .byte $02, $00, $BA, $02, $C7 ;draw to 186, 711
K6971:  .byte $02, $00, $BA, $02, $8E ;draw to 186, 654
K6976:  .byte $02, $00, $C6, $02, $94 ;draw to 198, 660
K697B:  .byte $02, $00, $C6, $02, $A3 ;draw to 198, 675
K6980:  .byte $01, $00, $C6, $02, $AF ;move to 198, 687
K6985:  .byte $02, $00, $C6, $02, $BE ;draw to 198, 702
K698A:  .byte $02, $00, $D0, $02, $C1 ;draw to 208, 705
K698F:  .byte $02, $00, $D2, $02, $BE ;draw to 210, 702
K6994:  .byte $02, $00, $D2, $02, $B8 ;draw to 210, 696
K6999:  .byte $02, $00, $CC, $02, $B2 ;draw to 204, 690
K699E:  .byte $02, $00, $C6, $02, $AF ;draw to 198, 687
K69A3:  .byte $01, $00, $C6, $02, $A3 ;move to 198, 675
K69A8:  .byte $02, $00, $CE, $02, $97 ;draw to 206, 663
K69AD:  .byte $02, $00, $D4, $02, $97 ;draw to 212, 663
K69B2:  .byte $02, $03, $34, $03, $7B ;draw to 820, 891
K69B7:  .byte $02, $03, $3C, $03, $7B ;draw to 828, 891
K69BC:  .byte $02, $03, $46, $03, $6F ;draw to 838, 879
K69C1:  .byte $02, $03, $48, $03, $60 ;draw to 840, 864
K69C6:  .byte $02, $03, $48, $01, $68 ;draw to 840, 360
K69CB:  .byte $00                   ;end of outline 4

ttl_sw_rs:
K69CC:  .byte $01, $03, $52, $01, $65 ;move to 850, 357  the RS of WARS at the lower right
K69D1:  .byte $02, $03, $50, $01, $53 ;draw to 848, 339
K69D6:  .byte $02, $03, $4A, $01, $47 ;draw to 842, 327
K69DB:  .byte $02, $03, $40, $01, $3E ;draw to 832, 318
K69E0:  .byte $02, $02, $EA, $01, $1D ;draw to 746, 285
K69E5:  .byte $02, $02, $E8, $01, $17 ;draw to 744, 279
K69EA:  .byte $02, $02, $F4, $01, $0B ;draw to 756, 267
K69EF:  .byte $02, $02, $F6, $00, $FF ;draw to 758, 255
K69F4:  .byte $02, $02, $F0, $00, $F3 ;draw to 752, 243
K69F9:  .byte $02, $02, $C8, $00, $E4 ;draw to 712, 228
K69FE:  .byte $02, $02, $C4, $00, $E4 ;draw to 708, 228
K6A03:  .byte $02, $02, $BC, $00, $F0 ;draw to 700, 240
K6A08:  .byte $01, $02, $BC, $00, $FF ;move to 700, 255
K6A0D:  .byte $02, $02, $BC, $01, $0E ;draw to 700, 270
K6A12:  .byte $02, $02, $C6, $01, $11 ;draw to 710, 273
K6A17:  .byte $02, $02, $C8, $01, $0E ;draw to 712, 270
K6A1C:  .byte $02, $02, $C8, $01, $08 ;draw to 712, 264
K6A21:  .byte $02, $02, $C2, $01, $02 ;draw to 706, 258
K6A26:  .byte $02, $02, $BC, $00, $FF ;draw to 700, 255
K6A2B:  .byte $01, $02, $BC, $00, $F0 ;move to 700, 240
K6A30:  .byte $02, $02, $BC, $00, $E1 ;draw to 700, 225
K6A35:  .byte $02, $02, $B0, $00, $DB ;draw to 688, 219
K6A3A:  .byte $02, $02, $B0, $01, $17 ;draw to 688, 279
K6A3F:  .byte $02, $02, $C8, $01, $20 ;draw to 712, 288
K6A44:  .byte $02, $02, $D0, $01, $1A ;draw to 720, 282
K6A49:  .byte $02, $02, $D4, $01, $0E ;draw to 724, 270
K6A4E:  .byte $02, $02, $D2, $00, $FF ;draw to 722, 255
K6A53:  .byte $02, $02, $CA, $00, $F9 ;draw to 714, 249
K6A58:  .byte $02, $02, $CC, $00, $F6 ;draw to 716, 246
K6A5D:  .byte $02, $02, $E6, $00, $FF ;draw to 742, 255
K6A62:  .byte $02, $02, $E8, $01, $02 ;draw to 744, 258
K6A67:  .byte $02, $02, $DE, $01, $0B ;draw to 734, 267
K6A6C:  .byte $02, $02, $DC, $01, $1A ;draw to 732, 282
K6A71:  .byte $02, $02, $E2, $01, $29 ;draw to 738, 297
K6A76:  .byte $02, $03, $3A, $01, $4A ;draw to 826, 330
K6A7B:  .byte $02, $03, $42, $01, $50 ;draw to 834, 336
K6A80:  .byte $02, $03, $46, $01, $59 ;draw to 838, 345
K6A85:  .byte $02, $03, $48, $01, $68 ;draw to 840, 360
K6A8A:  .byte $00                   ;end of outline 5

ttl_the_th:
K6A8B:  .byte $01, $01, $72, $02, $88 ;move to 370, 648  TH of THE, one outline
K6A90:  .byte $02, $01, $72, $02, $AF ;draw to 370, 687
K6A95:  .byte $02, $01, $62, $02, $A9 ;draw to 354, 681
K6A9A:  .byte $02, $01, $62, $02, $B8 ;draw to 354, 696
K6A9F:  .byte $02, $01, $A2, $02, $D0 ;draw to 418, 720
K6AA4:  .byte $02, $01, $A2, $02, $BB ;draw to 418, 699
K6AA9:  .byte $02, $01, $B0, $02, $C1 ;draw to 432, 705
K6AAE:  .byte $02, $01, $B0, $02, $D3 ;draw to 432, 723
K6AB3:  .byte $02, $01, $BE, $02, $D9 ;draw to 446, 729
K6AB8:  .byte $02, $01, $BE, $02, $A6 ;draw to 446, 678
K6ABD:  .byte $02, $01, $B0, $02, $A0 ;draw to 432, 672
K6AC2:  .byte $02, $01, $B0, $02, $B5 ;draw to 432, 693
K6AC7:  .byte $02, $01, $A2, $02, $AF ;draw to 418, 687
K6ACC:  .byte $02, $01, $A2, $02, $9A ;draw to 418, 666
K6AD1:  .byte $02, $01, $92, $02, $94 ;draw to 402, 660
K6AD6:  .byte $02, $01, $92, $02, $BB ;draw to 402, 699
K6ADB:  .byte $02, $01, $82, $02, $B5 ;draw to 386, 693
K6AE0:  .byte $02, $01, $82, $02, $8E ;draw to 386, 654
K6AE5:  .byte $02, $01, $72, $02, $88 ;draw to 370, 648
K6AEA:  .byte $00                   ;end of outline 6

ttl_the_e:
K6AEB:  .byte $01, $01, $C4, $02, $A9 ;move to 452, 681  E of THE
K6AF0:  .byte $02, $01, $C4, $02, $DC ;draw to 452, 732
K6AF5:  .byte $02, $01, $EE, $02, $EB ;draw to 494, 747
K6AFA:  .byte $02, $01, $EE, $02, $DC ;draw to 494, 732
K6AFF:  .byte $02, $01, $D6, $02, $D3 ;draw to 470, 723
K6B04:  .byte $02, $01, $D6, $02, $CD ;draw to 470, 717
K6B09:  .byte $02, $01, $EE, $02, $D6 ;draw to 494, 726
K6B0E:  .byte $02, $01, $EE, $02, $CD ;draw to 494, 717
K6B13:  .byte $02, $01, $D6, $02, $C4 ;draw to 470, 708
K6B18:  .byte $02, $01, $D6, $02, $BE ;draw to 470, 702
K6B1D:  .byte $02, $01, $EE, $02, $C7 ;draw to 494, 711
K6B22:  .byte $02, $01, $EE, $02, $B8 ;draw to 494, 696
K6B27:  .byte $02, $01, $C4, $02, $A9 ;draw to 452, 681
K6B2C:  .byte $00                   ;end of outline 7

ttl_the_bar:
K6B2D:  .byte $01, $01, $F6, $02, $BB ;move to 502, 699  the bar to the right of THE, 4 corners
K6B32:  .byte $02, $01, $F6, $02, $EE ;draw to 502, 750
K6B37:  .byte $02, $03, $3C, $03, $69 ;draw to 828, 873
K6B3C:  .byte $02, $03, $3C, $03, $36 ;draw to 828, 822
K6B41:  .byte $02, $01, $F6, $02, $BB ;draw to 502, 699
K6B46:  .byte $00                   ;end of outline 8

ttl_emp_e1:
K6B47:  .byte $01, $00, $14, $01, $1D ;move to 20, 285  EMPIRE: E
K6B4C:  .byte $02, $00, $14, $02, $3A ;draw to 20, 570
K6B51:  .byte $02, $01, $5A, $02, $B5 ;draw to 346, 693
K6B56:  .byte $02, $01, $5A, $02, $7F ;draw to 346, 639
K6B5B:  .byte $02, $00, $50, $02, $1C ;draw to 80, 540
K6B60:  .byte $02, $00, $50, $01, $FE ;draw to 80, 510
K6B65:  .byte $02, $00, $A0, $02, $1C ;draw to 160, 540
K6B6A:  .byte $02, $00, $A0, $01, $C8 ;draw to 160, 456
K6B6F:  .byte $02, $00, $50, $01, $AA ;draw to 80, 426
K6B74:  .byte $02, $00, $50, $01, $8C ;draw to 80, 396
K6B79:  .byte $02, $00, $A0, $01, $AA ;draw to 160, 426
K6B7E:  .byte $02, $00, $A0, $01, $50 ;draw to 160, 336
K6B83:  .byte $02, $00, $14, $01, $1D ;draw to 20, 285
K6B88:  .byte $00                   ;end of outline 9

ttl_emp_m:
K6B89:  .byte $01, $00, $AC, $01, $56 ;move to 172, 342  M
K6B8E:  .byte $02, $00, $AC, $02, $22 ;draw to 172, 546
K6B93:  .byte $02, $00, $DC, $02, $34 ;draw to 220, 564
K6B98:  .byte $02, $00, $F8, $01, $EC ;draw to 248, 492
K6B9D:  .byte $02, $01, $10, $02, $46 ;draw to 272, 582
K6BA2:  .byte $02, $01, $44, $02, $5B ;draw to 324, 603
K6BA7:  .byte $02, $01, $44, $01, $8F ;draw to 324, 399
K6BAC:  .byte $02, $01, $10, $01, $7A ;draw to 272, 378
K6BB1:  .byte $02, $01, $10, $01, $C2 ;draw to 272, 450
K6BB6:  .byte $02, $00, $F8, $01, $71 ;draw to 248, 369
K6BBB:  .byte $02, $00, $E0, $01, $B0 ;draw to 224, 432
K6BC0:  .byte $02, $00, $E0, $01, $68 ;draw to 224, 360
K6BC5:  .byte $02, $00, $AC, $01, $56 ;draw to 172, 342
K6BCA:  .byte $00                   ;end of outline 10

ttl_emp_p:
K6BCB:  .byte $01, $01, $50, $01, $92 ;move to 336, 402  P, outline and hole
K6BD0:  .byte $02, $01, $50, $02, $5E ;draw to 336, 606
K6BD5:  .byte $02, $01, $A8, $02, $7F ;draw to 424, 639
K6BDA:  .byte $02, $01, $BE, $02, $82 ;draw to 446, 642
K6BDF:  .byte $02, $01, $CC, $02, $7C ;draw to 460, 636
K6BE4:  .byte $02, $01, $D8, $02, $6D ;draw to 472, 621
K6BE9:  .byte $02, $01, $DE, $02, $55 ;draw to 478, 597
K6BEE:  .byte $02, $01, $DE, $02, $40 ;draw to 478, 576
K6BF3:  .byte $02, $01, $DA, $02, $22 ;draw to 474, 546
K6BF8:  .byte $02, $01, $CE, $02, $07 ;draw to 462, 519
K6BFD:  .byte $02, $01, $B4, $01, $F2 ;draw to 436, 498
K6C02:  .byte $02, $01, $84, $01, $E0 ;draw to 388, 480
K6C07:  .byte $02, $01, $84, $01, $A7 ;draw to 388, 423
K6C0C:  .byte $02, $01, $50, $01, $92 ;draw to 336, 402
K6C11:  .byte $01, $01, $84, $02, $16 ;move to 388, 534
K6C16:  .byte $02, $01, $84, $02, $3A ;draw to 388, 570
K6C1B:  .byte $02, $01, $A6, $02, $46 ;draw to 422, 582
K6C20:  .byte $02, $01, $B0, $02, $46 ;draw to 432, 582
K6C25:  .byte $02, $01, $B4, $02, $40 ;draw to 436, 576
K6C2A:  .byte $02, $01, $B4, $02, $37 ;draw to 436, 567
K6C2F:  .byte $02, $01, $B2, $02, $2E ;draw to 434, 558
K6C34:  .byte $02, $01, $AA, $02, $25 ;draw to 426, 549
K6C39:  .byte $02, $01, $84, $02, $16 ;draw to 388, 534
K6C3E:  .byte $00                   ;end of outline 11

ttl_emp_i:
K6C3F:  .byte $01, $01, $E6, $01, $CB ;move to 486, 459  I
K6C44:  .byte $02, $01, $E6, $02, $97 ;draw to 486, 663
K6C49:  .byte $02, $02, $16, $02, $A9 ;draw to 534, 681
K6C4E:  .byte $02, $02, $16, $01, $DD ;draw to 534, 477
K6C53:  .byte $02, $01, $E6, $01, $CB ;draw to 486, 459
K6C58:  .byte $00                   ;end of outline 12

ttl_emp_r:
K6C59:  .byte $01, $02, $22, $01, $E3 ;move to 546, 483  R, outline and hole
K6C5E:  .byte $02, $02, $22, $02, $AC ;draw to 546, 684
K6C63:  .byte $02, $02, $7A, $02, $CD ;draw to 634, 717
K6C68:  .byte $02, $02, $90, $02, $D0 ;draw to 656, 720
K6C6D:  .byte $02, $02, $9E, $02, $CA ;draw to 670, 714
K6C72:  .byte $02, $02, $AA, $02, $BB ;draw to 682, 699
K6C77:  .byte $02, $02, $B0, $02, $A9 ;draw to 688, 681
K6C7C:  .byte $02, $02, $B0, $02, $97 ;draw to 688, 663
K6C81:  .byte $02, $02, $AC, $02, $79 ;draw to 684, 633
K6C86:  .byte $02, $02, $A4, $02, $64 ;draw to 676, 612
K6C8B:  .byte $02, $02, $90, $02, $4C ;draw to 656, 588
K6C90:  .byte $02, $02, $80, $02, $46 ;draw to 640, 582
K6C95:  .byte $02, $02, $86, $02, $3D ;draw to 646, 573
K6C9A:  .byte $02, $02, $90, $02, $3D ;draw to 656, 573
K6C9F:  .byte $02, $02, $B0, $02, $49 ;draw to 688, 585
K6CA4:  .byte $02, $02, $B0, $02, $16 ;draw to 688, 534
K6CA9:  .byte $02, $02, $88, $02, $07 ;draw to 648, 519
K6CAE:  .byte $02, $02, $7C, $02, $07 ;draw to 636, 519
K6CB3:  .byte $02, $02, $72, $02, $0A ;draw to 626, 522
K6CB8:  .byte $02, $02, $56, $02, $34 ;draw to 598, 564
K6CBD:  .byte $02, $02, $56, $01, $F5 ;draw to 598, 501
K6CC2:  .byte $02, $02, $22, $01, $E3 ;draw to 546, 483
K6CC7:  .byte $01, $02, $56, $02, $61 ;move to 598, 609
K6CCC:  .byte $02, $02, $56, $02, $88 ;draw to 598, 648
K6CD1:  .byte $02, $02, $78, $02, $94 ;draw to 632, 660
K6CD6:  .byte $02, $02, $82, $02, $94 ;draw to 642, 660
K6CDB:  .byte $02, $02, $86, $02, $8E ;draw to 646, 654
K6CE0:  .byte $02, $02, $86, $02, $85 ;draw to 646, 645
K6CE5:  .byte $02, $02, $84, $02, $7C ;draw to 644, 636
K6CEA:  .byte $02, $02, $7C, $02, $70 ;draw to 636, 624
K6CEF:  .byte $02, $02, $56, $02, $61 ;draw to 598, 609
K6CF4:  .byte $00                   ;end of outline 13

ttl_emp_e2:
K6CF5:  .byte $01, $02, $BC, $02, $1C ;move to 700, 540  E
K6CFA:  .byte $02, $02, $BC, $02, $E5 ;draw to 700, 741
K6CFF:  .byte $02, $03, $3C, $03, $15 ;draw to 828, 789
K6D04:  .byte $02, $03, $3C, $02, $E2 ;draw to 828, 738
K6D09:  .byte $02, $02, $F0, $02, $C4 ;draw to 752, 708
K6D0E:  .byte $02, $02, $F0, $02, $A9 ;draw to 752, 681
K6D13:  .byte $02, $03, $3C, $02, $C7 ;draw to 828, 711
K6D18:  .byte $02, $03, $3C, $02, $9A ;draw to 828, 666
K6D1D:  .byte $02, $02, $F0, $02, $7F ;draw to 752, 639
K6D22:  .byte $02, $02, $F0, $02, $64 ;draw to 752, 612
K6D27:  .byte $02, $03, $3C, $02, $7F ;draw to 828, 639
K6D2C:  .byte $02, $03, $3C, $02, $4C ;draw to 828, 588
K6D31:  .byte $02, $02, $BC, $02, $1C ;draw to 700, 540
K6D36:  .byte $00                   ;end of outline 14

ttl_str_s1:
K6D37:  .byte $01, $00, $14, $00, $72 ;move to 20, 114  STRIKES: S
K6D3C:  .byte $02, $00, $14, $00, $90 ;draw to 20, 144
K6D41:  .byte $02, $00, $34, $00, $9C ;draw to 52, 156
K6D46:  .byte $02, $00, $38, $00, $A2 ;draw to 56, 162
K6D4B:  .byte $02, $00, $38, $00, $A8 ;draw to 56, 168
K6D50:  .byte $02, $00, $18, $00, $D5 ;draw to 24, 213
K6D55:  .byte $02, $00, $14, $00, $E1 ;draw to 20, 225
K6D5A:  .byte $02, $00, $14, $00, $F0 ;draw to 20, 240
K6D5F:  .byte $02, $00, $1A, $01, $02 ;draw to 26, 258
K6D64:  .byte $02, $00, $24, $01, $0B ;draw to 36, 267
K6D69:  .byte $02, $00, $5A, $01, $20 ;draw to 90, 288
K6D6E:  .byte $02, $00, $5A, $01, $02 ;draw to 90, 258
K6D73:  .byte $02, $00, $3A, $00, $F6 ;draw to 58, 246
K6D78:  .byte $02, $00, $36, $00, $F0 ;draw to 54, 240
K6D7D:  .byte $02, $00, $36, $00, $EA ;draw to 54, 234
K6D82:  .byte $02, $00, $56, $00, $BD ;draw to 86, 189
K6D87:  .byte $02, $00, $5A, $00, $B1 ;draw to 90, 177
K6D8C:  .byte $02, $00, $5A, $00, $A2 ;draw to 90, 162
K6D91:  .byte $02, $00, $54, $00, $90 ;draw to 84, 144
K6D96:  .byte $02, $00, $4A, $00, $87 ;draw to 74, 135
K6D9B:  .byte $02, $00, $14, $00, $72 ;draw to 20, 114
K6DA0:  .byte $00                   ;end of outline 15

ttl_str_t:
K6DA1:  .byte $01, $00, $74, $00, $96 ;move to 116, 150  T
K6DA6:  .byte $02, $00, $74, $01, $0B ;draw to 116, 267
K6DAB:  .byte $02, $00, $60, $01, $05 ;draw to 96, 261
K6DB0:  .byte $02, $00, $60, $01, $23 ;draw to 96, 291
K6DB5:  .byte $02, $00, $A2, $01, $3B ;draw to 162, 315
K6DBA:  .byte $02, $00, $A2, $01, $1D ;draw to 162, 285
K6DBF:  .byte $02, $00, $8C, $01, $14 ;draw to 140, 276
K6DC4:  .byte $02, $00, $8C, $00, $9F ;draw to 140, 159
K6DC9:  .byte $02, $00, $74, $00, $96 ;draw to 116, 150
K6DCE:  .byte $00                   ;end of outline 16

ttl_str_r:
K6DCF:  .byte $01, $00, $A8, $00, $AB ;move to 168, 171  R, outline and hole
K6DD4:  .byte $02, $00, $A8, $01, $3E ;draw to 168, 318
K6DD9:  .byte $02, $00, $D2, $01, $4D ;draw to 210, 333
K6DDE:  .byte $02, $00, $E2, $01, $4A ;draw to 226, 330
K6DE3:  .byte $02, $00, $EE, $01, $3B ;draw to 238, 315
K6DE8:  .byte $02, $00, $F2, $01, $26 ;draw to 242, 294
K6DED:  .byte $02, $00, $F2, $01, $0E ;draw to 242, 270
K6DF2:  .byte $02, $00, $EE, $00, $FC ;draw to 238, 252
K6DF7:  .byte $02, $00, $E0, $00, $ED ;draw to 224, 237
K6DFC:  .byte $02, $00, $D8, $00, $EA ;draw to 216, 234
K6E01:  .byte $02, $00, $DE, $00, $E1 ;draw to 222, 225
K6E06:  .byte $02, $00, $E4, $00, $DE ;draw to 228, 222
K6E0B:  .byte $02, $00, $F2, $00, $E4 ;draw to 242, 228
K6E10:  .byte $02, $00, $F2, $00, $C6 ;draw to 242, 198
K6E15:  .byte $02, $00, $DC, $00, $BD ;draw to 220, 189
K6E1A:  .byte $02, $00, $D4, $00, $C0 ;draw to 212, 192
K6E1F:  .byte $02, $00, $C0, $00, $DB ;draw to 192, 219
K6E24:  .byte $02, $00, $C0, $00, $B4 ;draw to 192, 180
K6E29:  .byte $02, $00, $A8, $00, $AB ;draw to 168, 171
K6E2E:  .byte $01, $00, $C0, $00, $FF ;move to 192, 255
K6E33:  .byte $02, $00, $C0, $01, $26 ;draw to 192, 294
K6E38:  .byte $02, $00, $D0, $01, $2C ;draw to 208, 300
K6E3D:  .byte $02, $00, $D6, $01, $29 ;draw to 214, 297
K6E42:  .byte $02, $00, $DA, $01, $20 ;draw to 218, 288
K6E47:  .byte $02, $00, $DA, $01, $17 ;draw to 218, 279
K6E4C:  .byte $02, $00, $D8, $01, $0E ;draw to 216, 270
K6E51:  .byte $02, $00, $D0, $01, $05 ;draw to 208, 261
K6E56:  .byte $02, $00, $C0, $00, $FF ;draw to 192, 255
K6E5B:  .byte $00                   ;end of outline 17

ttl_str_i:
K6E5C:  .byte $01, $00, $F8, $00, $C9 ;move to 248, 201  I
K6E61:  .byte $02, $00, $F8, $01, $5C ;draw to 248, 348
K6E66:  .byte $02, $01, $10, $01, $65 ;draw to 272, 357
K6E6B:  .byte $02, $01, $10, $00, $D2 ;draw to 272, 210
K6E70:  .byte $02, $00, $F8, $00, $C9 ;draw to 248, 201
K6E75:  .byte $00                   ;end of outline 18

ttl_str_k:
K6E76:  .byte $01, $01, $16, $00, $D2 ;move to 278, 210  K
K6E7B:  .byte $02, $01, $16, $01, $65 ;draw to 278, 357
K6E80:  .byte $02, $01, $2E, $01, $6E ;draw to 302, 366
K6E85:  .byte $02, $01, $2E, $01, $41 ;draw to 302, 321
K6E8A:  .byte $02, $01, $44, $01, $77 ;draw to 324, 375
K6E8F:  .byte $02, $01, $60, $01, $83 ;draw to 352, 387
K6E94:  .byte $02, $01, $38, $01, $20 ;draw to 312, 288
K6E99:  .byte $02, $01, $4C, $01, $05 ;draw to 332, 261
K6E9E:  .byte $02, $01, $50, $01, $05 ;draw to 336, 261
K6EA3:  .byte $02, $01, $60, $01, $0B ;draw to 352, 267
K6EA8:  .byte $02, $01, $60, $00, $ED ;draw to 352, 237
K6EAD:  .byte $02, $01, $4A, $00, $E7 ;draw to 330, 231
K6EB2:  .byte $02, $01, $40, $00, $EA ;draw to 320, 234
K6EB7:  .byte $02, $01, $2E, $01, $02 ;draw to 302, 258
K6EBC:  .byte $02, $01, $2E, $00, $DB ;draw to 302, 219
K6EC1:  .byte $02, $01, $16, $00, $D2 ;draw to 278, 210
K6EC6:  .byte $00                   ;end of outline 19

ttl_str_e:
K6EC7:  .byte $01, $01, $66, $00, $F0 ;move to 358, 240  E
K6ECC:  .byte $02, $01, $66, $01, $83 ;draw to 358, 387
K6ED1:  .byte $02, $01, $AA, $01, $9E ;draw to 426, 414
K6ED6:  .byte $02, $01, $AA, $01, $80 ;draw to 426, 384
K6EDB:  .byte $02, $01, $7E, $01, $6E ;draw to 382, 366
K6EE0:  .byte $02, $01, $7E, $01, $50 ;draw to 382, 336
K6EE5:  .byte $02, $01, $AA, $01, $62 ;draw to 426, 354
K6EEA:  .byte $02, $01, $AA, $01, $4A ;draw to 426, 330
K6EEF:  .byte $02, $01, $7E, $01, $38 ;draw to 382, 312
K6EF4:  .byte $02, $01, $7E, $01, $17 ;draw to 382, 279
K6EF9:  .byte $02, $01, $AA, $01, $29 ;draw to 426, 297
K6EFE:  .byte $02, $01, $AA, $01, $0B ;draw to 426, 267
K6F03:  .byte $02, $01, $66, $00, $F0 ;draw to 358, 240
K6F08:  .byte $00                   ;end of outline 20

ttl_str_s2:
K6F09:  .byte $01, $01, $B0, $01, $0E ;move to 432, 270  S
K6F0E:  .byte $02, $01, $B0, $01, $2C ;draw to 432, 300
K6F13:  .byte $02, $01, $D0, $01, $38 ;draw to 464, 312
K6F18:  .byte $02, $01, $D4, $01, $3E ;draw to 468, 318
K6F1D:  .byte $02, $01, $D4, $01, $44 ;draw to 468, 324
K6F22:  .byte $02, $01, $B4, $01, $6E ;draw to 436, 366
K6F27:  .byte $02, $01, $B0, $01, $7A ;draw to 432, 378
K6F2C:  .byte $02, $01, $B0, $01, $89 ;draw to 432, 393
K6F31:  .byte $02, $01, $B6, $01, $9B ;draw to 438, 411
K6F36:  .byte $02, $01, $C0, $01, $A4 ;draw to 448, 420
K6F3B:  .byte $02, $01, $F6, $01, $B9 ;draw to 502, 441
K6F40:  .byte $02, $01, $F6, $01, $9B ;draw to 502, 411
K6F45:  .byte $02, $01, $D6, $01, $8F ;draw to 470, 399
K6F4A:  .byte $02, $01, $D2, $01, $89 ;draw to 466, 393
K6F4F:  .byte $02, $01, $D2, $01, $83 ;draw to 466, 387
K6F54:  .byte $02, $01, $F2, $01, $56 ;draw to 498, 342
K6F59:  .byte $02, $01, $F6, $01, $4A ;draw to 502, 330
K6F5E:  .byte $02, $01, $F6, $01, $3B ;draw to 502, 315
K6F63:  .byte $02, $01, $F0, $01, $29 ;draw to 496, 297
K6F68:  .byte $02, $01, $E6, $01, $20 ;draw to 486, 288
K6F6D:  .byte $02, $01, $B0, $01, $0E ;draw to 432, 270
K6F72:  .byte $00                   ;end of outline 21

ttl_bck_b:
K6F73:  .byte $01, $02, $10, $01, $2F ;move to 528, 303  BACK: B, outline and two holes. the list runs on to $7013
K6F78:  .byte $02, $02, $10, $01, $C2 ;draw to 528, 450
K6F7D:  .byte $02, $02, $3A, $01, $D4 ;draw to 570, 468
K6F82:  .byte $02, $02, $46, $01, $D4 ;draw to 582, 468
K6F87:  .byte $02, $02, $52, $01, $CB ;draw to 594, 459
K6F8C:  .byte $02, $02, $58, $01, $BC ;draw to 600, 444
K6F91:  .byte $02, $02, $58, $01, $AA ;draw to 600, 426
K6F96:  .byte $02, $02, $54, $01, $9B ;draw to 596, 411
K6F9B:  .byte $02, $02, $4E, $01, $95 ;draw to 590, 405
K6FA0:  .byte $02, $02, $54, $01, $8F ;draw to 596, 399
K6FA5:  .byte $02, $02, $5A, $01, $80 ;draw to 602, 384
K6FAA:  .byte $02, $02, $5A, $01, $6E ;draw to 602, 366
K6FAF:  .byte $02, $02, $56, $01, $59 ;draw to 598, 345
K6FB4:  .byte $02, $02, $4E, $01, $4D ;draw to 590, 333
K6FB9:  .byte $02, $02, $42, $01, $44 ;draw to 578, 324
K6FBE:  .byte $02, $02, $10, $01, $2F ;draw to 528, 303
K6FC3:  .byte $01, $02, $28, $01, $5C ;move to 552, 348
K6FC8:  .byte $02, $02, $28, $01, $7A ;draw to 552, 378
K6FCD:  .byte $02, $02, $38, $01, $80 ;draw to 568, 384
K6FD2:  .byte $02, $02, $3C, $01, $80 ;draw to 572, 384
K6FD7:  .byte $02, $02, $40, $01, $7A ;draw to 576, 378
K6FDC:  .byte $02, $02, $40, $01, $6E ;draw to 576, 366
K6FE1:  .byte $02, $02, $38, $01, $62 ;draw to 568, 354
K6FE6:  .byte $02, $02, $28, $01, $5C ;draw to 552, 348
K6FEB:  .byte $01, $02, $28, $01, $92 ;move to 552, 402
K6FF0:  .byte $02, $02, $28, $01, $AD ;draw to 552, 429
K6FF5:  .byte $02, $02, $38, $01, $B3 ;draw to 568, 435
K6FFA:  .byte $02, $02, $3C, $01, $B3 ;draw to 572, 435
K6FFF:  .byte $02, $02, $40, $01, $AD ;draw to 576, 429
K7004:  .byte $02, $02, $40, $01, $A4 ;draw to 576, 420
K7009:  .byte $02, $02, $38, $01, $98 ;draw to 568, 408
K700E:  .byte $02, $02, $28, $01, $92 ;draw to 552, 402
K7013:  .byte $00                   ;end of outline 22

bnr_back_a:
K7014:  .byte $01, $02, $5C, $01, $4D ;move to 604, 333
K7019:  .byte $02, $02, $72, $01, $E9 ;draw to 626, 489
K701E:  .byte $02, $02, $92, $01, $F5 ;draw to 658, 501
K7023:  .byte $02, $02, $A6, $01, $68 ;draw to 678, 360
K7028:  .byte $02, $02, $8E, $01, $5F ;draw to 654, 351
K702D:  .byte $02, $02, $8A, $01, $7A ;draw to 650, 378
K7032:  .byte $02, $02, $78, $01, $74 ;draw to 632, 372
K7037:  .byte $02, $02, $74, $01, $56 ;draw to 628, 342
K703C:  .byte $02, $02, $5C, $01, $4D ;draw to 604, 333
K7041:  .byte $01, $02, $7C, $01, $8C ;move to 636, 396
K7046:  .byte $02, $02, $82, $01, $B6 ;draw to 642, 438
K704B:  .byte $02, $02, $88, $01, $8F ;draw to 648, 399
K7050:  .byte $02, $02, $7C, $01, $8C ;draw to 636, 396
K7055:  .byte $00                   ;end of outline 23

bnr_back_c:
K7056:  .byte $01, $02, $EC, $01, $83 ;move to 748, 387
K705B:  .byte $02, $02, $D4, $01, $7A ;draw to 724, 378
K7060:  .byte $02, $02, $C4, $01, $7A ;draw to 708, 378
K7065:  .byte $02, $02, $B6, $01, $80 ;draw to 694, 384
K706A:  .byte $02, $02, $AC, $01, $8C ;draw to 684, 396
K706F:  .byte $02, $02, $A6, $01, $A4 ;draw to 678, 420
K7074:  .byte $02, $02, $A6, $01, $B9 ;draw to 678, 441
K7079:  .byte $02, $02, $AA, $01, $DA ;draw to 682, 474
K707E:  .byte $02, $02, $B8, $01, $F8 ;draw to 696, 504
K7083:  .byte $02, $02, $CC, $02, $0A ;draw to 716, 522
K7088:  .byte $02, $02, $EC, $02, $16 ;draw to 748, 534
K708D:  .byte $02, $02, $EC, $01, $F8 ;draw to 748, 504
K7092:  .byte $02, $02, $D4, $01, $EF ;draw to 724, 495
K7097:  .byte $02, $02, $C6, $01, $E0 ;draw to 710, 480
K709C:  .byte $02, $02, $BE, $01, $C5 ;draw to 702, 453
K70A1:  .byte $02, $02, $BE, $01, $AD ;draw to 702, 429
K70A6:  .byte $02, $02, $C2, $01, $9E ;draw to 706, 414
K70AB:  .byte $02, $02, $CA, $01, $98 ;draw to 714, 408
K70B0:  .byte $02, $02, $D4, $01, $98 ;draw to 724, 408
K70B5:  .byte $02, $02, $EC, $01, $A1 ;draw to 748, 417
K70BA:  .byte $02, $02, $EC, $01, $83 ;draw to 748, 387
K70BF:  .byte $00                   ;end of outline 24

bnr_back_k:
K70C0:  .byte $01, $02, $F2, $01, $86 ;move to 754, 390
K70C5:  .byte $02, $02, $F2, $02, $19 ;draw to 754, 537
K70CA:  .byte $02, $03, $0A, $02, $22 ;draw to 778, 546
K70CF:  .byte $02, $03, $0A, $01, $F5 ;draw to 778, 501
K70D4:  .byte $02, $03, $20, $02, $28 ;draw to 800, 552
K70D9:  .byte $02, $03, $3C, $02, $34 ;draw to 828, 564
K70DE:  .byte $02, $03, $14, $01, $D4 ;draw to 788, 468
K70E3:  .byte $02, $03, $28, $01, $B9 ;draw to 808, 441
K70E8:  .byte $02, $03, $2C, $01, $B9 ;draw to 812, 441
K70ED:  .byte $02, $03, $3C, $01, $BF ;draw to 828, 447
K70F2:  .byte $02, $03, $3C, $01, $A1 ;draw to 828, 417
K70F7:  .byte $02, $03, $28, $01, $9B ;draw to 808, 411
K70FC:  .byte $02, $03, $1E, $01, $9E ;draw to 798, 414
K7101:  .byte $02, $03, $0A, $01, $B6 ;draw to 778, 438
K7106:  .byte $02, $03, $0A, $01, $8F ;draw to 778, 399
K710B:  .byte $02, $02, $F2, $01, $86 ;draw to 754, 390
K7110:  .byte $00                   ;end of outline 25

bnr_bar:
K7111:  .byte $01, $00, $14, $00, $30 ;move to 20, 48  piece 26, the last: a thin slanted bar from (20,48) to (828,396) across the whole picture
K7116:  .byte $02, $00, $14, $00, $5D ;draw to 20, 93
K711B:  .byte $02, $03, $3C, $01, $8C ;draw to 828, 396
K7120:  .byte $02, $03, $3C, $01, $5F ;draw to 828, 351
K7125:  .byte $02, $00, $14, $00, $30 ;draw to 20, 48
K712A:  .byte $00                   ;end of outline 26

;------------------------------------------------------------------------------
; acct_page_view - ESB's version of Star Wars' EEACC: draws the accounting page of the self test for PHESTS
;   (phase $4A, through L6120). turns on message $78 (the texts) and $D5, then outputs through Y in red the aux,
;   left and right coin counts, games played and add-a-coin games, the highest wave, total coins (left plus
;   right), total game time and total time on in seconds (the 4 second counts times 4), the average game time,
;   play time as a percentage of time on, add-a-coin games as a percentage of games played, and the 18 bins of the
;   game time histogram. the NVRAM image at EEROM holds whole bytes in ESB, so the values are read straight from
;   it
;------------------------------------------------------------------------------
acct_page_view:
K712B:  LDB  #$78                   ;message $78: the texts of the accounting page
K712D:  JSR  K6030
K7130:  LDB  #$D5                   ;message $D5: PRESS AUX COIN TO CONTINUE
K7132:  JSR  K6030
K7135:  LDD  #$6480                 ;red, for the numbers
K7138:  STD  ,Y++
K713A:  LDU  #AMECH                 ;five 3-byte BCD counts follow one another from AMECH: aux, left and right mech coins, games played, add-a-coin games
K713D:  LDX  #acct_ypos_tab         ;their y positions
K7140:  LDD  ,X++
K7142:  STD  ,Y++
K7144:  LDD  #$0030                 ;x 48
K7147:  STD  ,Y++
K7149:  LDB  #$05                   ;blank up to 5 leading zeros
K714B:  STB  BT_SUP
K714D:  JSR  K6072                  ;view_6dig: the three BCD bytes at U
K7150:  LDD  #$8040
K7153:  STD  ,Y++
K7155:  LEAU 3,U
K7157:  CMPU #TTIME                 ;TTIME is the end of the five counts
K715B:  BCS  K7140
K715D:  LDD  K7A40                  ;y 400
K7160:  STD  ,Y++
K7162:  LDD  #$013C                 ;x 316: under the words HIGH WAVE
K7165:  STD  ,Y++
K7167:  LDA  #$01
K7169:  STA  BT_SUP
K716B:  LDA  high_wave              ;the highest wave reached, BCD
K716E:  JSR  K607E                  ;VWBYTE
K7171:  LDD  #VGCNTR
K7174:  STD  ,Y++
K7176:  LDA  rmech_2                ;3 BYTE ADD, RESULT IN TEMP
K7179:  ADDA lmech_2
K717C:  DAA
K717D:  STA  acc_tmp_2              ;acc_tmp = right mech coins + left mech coins
K7180:  LDA  rmech_1
K7183:  ADCA lmech_1
K7186:  DAA
K7187:  STA  acc_tmp_1
K718A:  LDA  RMECH                  ;NOW THE MSB
K718D:  ADCA LMECH
K7190:  DAA
K7191:  STA  acc_tmp
;DISPLAY TOTAL COINS
K7194:  LDD  K7A48                  ;POSITION
K7197:  STD  ,Y++
K7199:  LDD  #$0030
K719C:  STD  ,Y++
K719E:  LDB  #$05
K71A0:  STB  BT_SUP
K71A2:  LDU  #acc_tmp
K71A5:  JSR  K6072                  ;view_6dig
K71A8:  LDD  #VGCNTR                ;CENTER
K71AB:  STD  ,Y++
K71AD:  LDX  #TTIME                 ;DISPLAY TOTAL GAME TIME
K71B0:  LDU  #acc_tmp
K71B3:  JSR  EETMP2                 ;four bytes to acc_tmp
K71B6:  JSR  TMPMUL                 ;GOT TO MULTIPLY BY 4 FOR SECONDS
K71B9:  LDD  K7A4E                  ;POSITION IT
K71BC:  STD  ,Y++
K71BE:  LDD  #$0030
K71C1:  STD  ,Y++
K71C3:  LDB  #$07
K71C5:  STB  BT_SUP
K71C7:  LDU  #acc_tmp
K71CA:  JSR  K606C                  ;view_8dig
K71CD:  LDD  #$8040
K71D0:  STD  ,Y++
K71D2:  LDX  #TIMEON                ;total time on, the same way
K71D5:  LDU  #acc_tmp
K71D8:  JSR  EETMP2
K71DB:  LDA  acc_tmp                ;ESB: hold the top byte at $24 so that four times the value still fits in 8 digits
K71DE:  CMPA #$25
K71E0:  BCS  K71E7
K71E2:  LDA  #$24
K71E4:  STA  acc_tmp
K71E7:  JSR  TMPMUL                 ;GOT TO MULTIPLY BY 4 FOR SECONDS
K71EA:  LDD  K7A50                  ;POSITION IT
K71ED:  STD  ,Y++
K71EF:  LDD  #$0030
K71F2:  STD  ,Y++
K71F4:  LDB  #$07
K71F6:  STB  BT_SUP
K71F8:  LDU  #acc_tmp
K71FB:  JSR  K606C
K71FE:  LDD  #VGCNTR
K7201:  STD  ,Y++
;CALCULATE AND SHOW AVERAGE GAME TIME
K7203:  LDX  #GAMES-1               ;MOVE NUMBER OF GAMES PLAYED TO TEMP+1
K7206:  LDU  #TEMP
K7209:  JSR  EETMP2
K720C:  CLR  TEMP                   ;LEADING 0
K720F:  LDA  TEMP+1                 ;NUMBER OF GAMES = 00?
K7212:  ORA  TEMP+2
K7215:  ORA  TEMP+3
K7218:  STA  ee_tmp                 ;0 when no game has been played
K721B:  BEQ  K724B                  ;IFNE  NO, THEN I GUESS I WON'T DIVIDE BY 0
K721D:  LDX  #TTIME                 ;GET TOTAL GAME TIME TO TEMP2
K7220:  LDU  #TEMP2
K7223:  JSR  EETMP2
K7226:  JSR  DIVIDE                 ;TEMP2/TEMP RESULT IN TEMP ( GAME TIME/# OF GAMES)
K7229:  STB  ee_tmp                 ;B = the quotient, in 4 second units. made into minutes in the high nibble and 4 second units in the low one
K722C:  ANDB #$0F
K722E:  CMPB #$0F
K7230:  LDB  ee_tmp
K7233:  BLO  K7238                  ;IFHS  60 SECONDS GETS ADDED IN AS A MINUTE (HI NIBBLE)
K7235:  INC  ee_tmp
K7238:  LSRB
K7239:  LSRB
K723A:  LSRB
K723B:  LSRB
K723C:  ADDB ee_tmp
K723F:  STB  ee_tmp
K7242:  ANDB #$0F
K7244:  CMPB #$0F
K7246:  BLO  K724B                  ;IFHS  IF 60 SECONDS ADD 1 TO MINUTES
K7248:  INC  ee_tmp                 ;0F+1=10
K724B:  LDD  K7A4A                  ;SHOW IT
K724E:  STD  ,Y++
K7250:  LDD  #$0030
K7253:  STD  ,Y++
K7255:  LDA  ee_tmp
K7258:  JSR  vw_min_sec             ;vw_min_sec: shown as m:ss
K725B:  LDD  #VGCNTR
K725E:  STD  ,Y++
;CALCULATE AND SHOW PERCENTAGE OF PLAY/TIMEON
K7260:  LDX  #TIMEON                ;GET TOTAL TIME ON TO TEMP
K7263:  LDU  #TEMP
K7266:  JSR  EETMP2
K7269:  LDB  TEMP                   ;no time on at all?
K726C:  ORB  temp_1
K726F:  ORB  temp_2
K7272:  ORB  temp_3
K7275:  BEQ  K7286                  ;IFNE  WON'T DIVIDE BY ZERO
K7277:  LDX  #ttime_1               ;GET PLAY TIME ON TO TEMP2 ( 2 LSD IGNORED )
K727A:  LDU  #TEMP2
K727D:  JSR  EETMP2
K7280:  CLR  TEMP2+3                ;* 100.
K7283:  JSR  DIVIDE
K7286:  LDX  K7A4C                  ;y 40
K7289:  STX  ,Y++
K728B:  LDX  #$0030
K728E:  STX  ,Y++
K7290:  CLRA                        ;D = the quotient in B, the percentage, to BCD
K7291:  LDX  #$0010
K7294:  JSR  BINBCD
K7297:  LDB  #$01
K7299:  STB  BT_SUP
K729B:  LDA  BCD+2
K729E:  JSR  K607E
K72A1:  LDD  #VGCNTR
K72A4:  STD  ,Y++
K72A6:  LDX  #GAMES-1               ;add-a-coin games as a percentage of games played: the games count to TEMP+1
K72A9:  LDU  #TEMP
K72AC:  JSR  EETMP2
K72AF:  CLR  TEMP                   ;leading 0
K72B2:  LDB  temp_1
K72B5:  ORB  temp_2
K72B8:  ORB  temp_3
K72BB:  BEQ  K72CC                  ;IFNE  WON'T DIVIDE BY ZERO
K72BD:  LDX  #cont_games            ;the count of continued games moved up a byte (times 100) to TEMP2
K72C0:  LDU  #TEMP2
K72C3:  JSR  EETMP2
K72C6:  CLR  TEMP2+3                ;* 100.
K72C9:  JSR  DIVIDE
K72CC:  LDX  K7A46                  ;y 240
K72CF:  STX  ,Y++
K72D1:  LDX  #$010C                 ;x 268: on the ADD-A-COIN GAMES line, before PERCENT
K72D4:  STX  ,Y++
K72D6:  CLRA
K72D7:  LDX  #$0010
K72DA:  JSR  BINBCD
K72DD:  LDB  #$01
K72DF:  STB  BT_SUP
K72E1:  LDA  BCD+2
K72E4:  JSR  K607E
K72E7:  LDD  #VGCNTR
K72EA:  STD  ,Y++
;DISPLAY HISTOGRAM OF GAME TIMES
K72EC:  LDB  #$11                   ;START AT LARGEST TIME ( 6:00 )
K72EE:  STB  TMPCNT                 ;TMPCNT = bin number, 17 down to 0
K72F1:  LDU  #hist_pos_tab          ;y and x of each bin, the largest time first
K72F4:  LDD  ,U++                   ;Y POSITION
K72F6:  STD  ,Y++
K72F8:  LDD  ,U++                   ;x position
K72FA:  STD  ,Y++
K72FC:  LDX  #T_HIST                ;TIME SLOT TIME
K72FF:  LDB  TMPCNT
K7302:  LDA  B,X
K7304:  JSR  vw_min_sec             ;vw_min_sec: the upper time limit of the bin
K7307:  LDD  VGMSGA                 ;2 BLANKS
K730A:  STD  ,Y++
K730C:  STD  ,Y++
K730E:  LDX  #HISTOG                ;HISTOGRAM DATA
K7311:  LDB  TMPCNT
K7314:  LDA  B,X                    ;HIGH NIBBLE
K7316:  JSR  K607E                  ;VWBYTE: the bin's count, one BCD byte in ESB
K7319:  LDD  #VGCNTR                ;CENTER INSTRUCTION
K731C:  STD  ,Y++
K731E:  DEC  TMPCNT
K7321:  BPL  K72F4                  ;MIEND
K7323:  RTS

;------------------------------------------------------------------------------
; DIVIDE - DIVIDE
;------------------------------------------------------------------------------
DIVIDE:
K7324:  LDX  #TEMP+4                ;PERFORM DECIMAL NEGATE OF DENOMINATOR
K7327:  LDA  #$01
K7329:  STA  scratch_1
K732B:  LDB  #$03                   ;4 BYTES WORTH
K732D:  LDA  #$99
K732F:  SUBA ,-X
K7331:  ADDA scratch_1
K7333:  DAA
K7334:  STA  ,X
K7336:  BCS  K733C                  ;IFCC  PROPAGATE THE CARRY
K7338:  CLR  scratch_1
K733A:  BRA  K7340                  ;ELSE
K733C:  LDA  #$01
K733E:  STA  scratch_1
K7340:  DECB
K7341:  BPL  K732D                  ;MIEND
K7343:  LDB  #$FF
K7345:  INCB
K7346:  CMPB #$EF
K7348:  BEQ  K7374                  ;OVERFLOW---LEAVE AT MAX
K734A:  LDA  TEMP2+3                ;START WITH LSB
K734D:  ADDA TEMP+3                 ;SUBTRACT DENOMINATOR ( ADD NEGATIVE IN DECIMAL)
K7350:  DAA
K7351:  STA  TEMP2+3
K7354:  LDA  TEMP2+2
K7357:  ADCA TEMP+2
K735A:  DAA
K735B:  STA  TEMP2+2
K735E:  LDA  TEMP2+1
K7361:  ADCA TEMP+1
K7364:  DAA
K7365:  STA  TEMP2+1
K7368:  LDA  TEMP2+0
K736B:  ADCA TEMP+0
K736E:  DAA
K736F:  STA  TEMP2+0
K7372:  BCS  K7345                  ;CCEND  DONE WHEN STAYS NEGATIVE ( DECIMAL ) NO CARRY
K7374:  RTS

;------------------------------------------------------------------------------
; TMPMUL - TMPMUL
;------------------------------------------------------------------------------
TMPMUL:
K7375:  BSR  TMPML2                 ;DO IT TWICE

;------------------------------------------------------------------------------
; TMPML2 - ADD TEMP TO TEMP IN DECIMAL
;------------------------------------------------------------------------------
TMPML2:
K7377:  ANDCC #$FE                  ;CLC  START WITH CARRY CLEAR
K7379:  LDB  #$03                   ;4 BYTES WORTH
K737B:  LDX  #acc_tmp+4             ;START WITH LSD
K737E:  LDA  ,-X
K7380:  ADCA ,X
K7382:  DAA
K7383:  STA  ,X
K7385:  DECB
K7386:  BPL  K737E                  ;MIEND
K7388:  RTS

;------------------------------------------------------------------------------
; coin_acct_upd - ESB's version of Star Wars' EEACCU, called by the coin routine every fourth interrupt (bank 0
;   LC6BF, through L6126): collects the top bits of the three coin counter timers S_CCTIM and compares them with
;   EECOIN, their state at the last call. for the first counter whose bit went from 1 to 0 it adds 1 to that
;   counter's 3-byte BCD count (RMECH, LMECH, AMECH in that order of testing) and renews the checksum of area 2.
;   nothing is counted when area 2's checksum is bad
;------------------------------------------------------------------------------
coin_acct_upd:
K7389:  CLRA                        ;START WITH 0
K738A:  LDB  >S_CCTIM               ;GET COIN COUNTER DATA-ALL 3
K738D:  ASLB                        ;ASLD  GET COUNTER DATA INTO A
K738E:  ROLA
K738F:  LDB  >S_CCTIM+1
K7392:  ASLB                        ;ASLD
K7393:  ROLA
K7394:  LDB  >S_CCTIM+2
K7397:  ASLB                        ;ASLD
K7398:  ROLA
K7399:  TFR  A,B                    ;NEW DATA IN B
K739B:  EORB EECOIN                 ;1=CHANGE IN STATE
K739E:  ANDB EECOIN                 ;1=COIN COUNTER JUST TURNED ON
K73A1:  STA  EECOIN                 ;NEW STATE
K73A4:  LDX  #RMECH
K73A7:  LSRB
K73A8:  BCC  K73D1                  ;IFCS
K73AA:  LDA  #$02                   ;area 2
K73AC:  PSHS X
K73AE:  JSR  ee_area_sum            ;its checksum must be good
K73B1:  PULS X
K73B3:  BNE  K73CF                  ;bad: count nothing
K73B5:  LDA  2,X                    ;the 3 BCD bytes at X plus 1
K73B7:  ADDA #$01
K73B9:  DAA
K73BA:  STA  2,X
K73BC:  LDA  1,X
K73BE:  ADCA #$00
K73C0:  DAA
K73C1:  STA  1,X
K73C3:  LDA  ,X
K73C5:  ADCA #$00
K73C7:  DAA
K73C8:  STA  ,X
K73CA:  LDA  #$02                   ;CALCULATE CHECKSUM FOR AREA 2
K73CC:  JSR  EECKSM
K73CF:  BRA  K73D8                  ;one counter a call
K73D1:  LEAX -3,X                   ;next counter down: LMECH, then AMECH
K73D3:  CMPX #AMECH                 ;DONE?
K73D6:  BHS  K73A7                  ;LOEND
K73D8:  RTS

;------------------------------------------------------------------------------
; EEACCT - UPDATE TOTAL GAME TIME
;   in ESB: ESB works on whole bytes of the NVRAM image and adds a count of the games started from the
;   continue offer (cont_used, cont_games). the histogram has one BCD byte a bin. the loop that halves the
;   bins when one reaches 100 tests U, which it does not step, so as written it does not end (K747A-K7489)
;------------------------------------------------------------------------------
EEACCT:
K73D9:  LDA  #$02                   ;area 2
K73DB:  JSR  ee_area_check          ;ee_area_check: make sure area 2 is valid
K73DE:  LDA  ttime_3                ;ADD GAME TIME TO TOTAL
K73E1:  ADDA >GTIME+1
K73E4:  DAA
K73E5:  STA  ttime_3
K73E8:  LDA  ttime_2
K73EB:  ADCA >GTIME+0
K73EE:  DAA
K73EF:  STA  ttime_2
K73F2:  LDA  ttime_1
K73F5:  ADCA #$00
K73F7:  DAA
K73F8:  STA  ttime_1
K73FB:  LDA  TTIME
K73FE:  ADCA #$00
K7400:  DAA                         ;9999 * 16 ms = 666.6 MINS = 11.11 HOURS
K7401:  BCS  K7406                  ;IFCC  DON'T OVERFLOW TIME, MORE THAN 11 HOURS !!WOW!!
K7403:  STA  TTIME
K7406:  LDA  games_lo               ;games played plus 1: 3 BCD bytes, $4D58-$4D5A
K7409:  ADDA #$01
K740B:  DAA
K740C:  STA  games_lo
K740F:  LDA  games_mid
K7412:  ADCA #$00
K7414:  DAA
K7415:  STA  games_mid
K7418:  LDA  GAMES
K741B:  ADCA #$00
K741D:  DAA
K741E:  STA  GAMES
K7421:  LDA  cont_used              ;was this game started from the continue offer?
K7424:  BEQ  K7444
K7426:  CLR  cont_used
K7429:  LDA  cont_games_2           ;yes: the add-a-coin games count, 3 BCD bytes, plus 1
K742C:  ADDA #$01
K742E:  DAA
K742F:  STA  cont_games_2
K7432:  LDA  cont_games_1
K7435:  ADCA #$00
K7437:  DAA
K7438:  STA  cont_games_1
K743B:  LDA  cont_games
K743E:  ADCA #$00
K7440:  DAA
K7441:  STA  cont_games
K7444:  LDA  wave_bcd               ;the wave this game reached, BCD
K7447:  CMPA high_wave              ;higher than the highest on record?
K744A:  BLS  K744F
K744C:  STA  high_wave
K744F:  LDX  #hist_last             ;the last bin, for the longest games
K7452:  LDA  >GTIME                 ;top byte of the game time: not 0 is 400 seconds or more
K7455:  BNE  K7470
K7457:  LDA  >gtime_1               ;the game time in 4 second units, BCD
K745A:  LDX  #HISTOG
K745D:  LDB  #$9A                   ;$9A - 5: adding it takes 5 units, 20 seconds, off in BCD
K745F:  SUBB T_HIST
K7462:  STB  scratch_1
K7464:  ADDA scratch_1
K7466:  DAA
K7467:  BCC  K7470                  ;no carry: the time belongs in this bin
K7469:  LEAX 1,X                    ;next bin
K746B:  CMPX #hist_last
K746E:  BCS  K7464
K7470:  LDA  ,X                     ;the bin's count plus 1
K7472:  ADDA #$01
K7474:  DAA
K7475:  BNE  K748D                  ;not past 99: store it
K7477:  LDU  #HISTOG                ;the bin has reached 100: halve the bins
K747A:  LDA  ,X
K747C:  BITA #$10                   ;will divide by 2 work in BCD?
K747E:  BEQ  K7482
K7480:  SUBA #$06                   ;this corrects it
K7482:  LSRA
K7483:  STA  ,X+
K7485:  CMPU #HISTOG+18             ;the limit is tested on U, which stays at HISTOG, while the loop steps X from the full bin: as written the loop does not end
K7489:  BCS  K747A
K748B:  LDA  #$50                   ;1/2 of 100 is 50
K748D:  STA  ,X
;SAVE POT VALUES
K748F:  LDA  >RHEOP+RHS_LO
K7492:  STA  POTSAV
K7495:  LDA  >RHEOP+RHS_SP
K7498:  STA  potsav_1
K749B:  LDA  >RHEOY+RHS_LO
K749E:  STA  potsav_2
K74A1:  LDA  >RHEOY+RHS_SP
K74A4:  STA  potsav_3

;------------------------------------------------------------------------------
; time_on_upd - ESB's version of Star Wars' EEUTIM: the tail of EEACCT, also called by itself from the attract
;   mode when TIMER+2 has changed (bank 0 L6424, through L6132). reads the RAM based time TIMER with interrupts
;   off and, if it is not lower than TIMEON in the NVRAM image, copies it to TIMEON, otherwise TIMER is put back
;   from TIMEON. then renews the checksum of area 2, which also writes the area to the NVRAM
;------------------------------------------------------------------------------
time_on_upd:
K74A7:  ORCC #$10                   ;SEI  STOPS INTERRUPT INTERACTION
K74A9:  LDU  TIMER+2                ;RAM BASED TIME
K74AC:  LDD  TIMER
K74AF:  ANDCC #$EF                  ;CLI
K74B1:  CMPD TIMEON                 ;NEW TIME SHOULD BE LARGER THAN OLD
K74B5:  BNE  K74BB                  ;top words equal: compare the low words
K74B7:  CMPU timeon_2
K74BB:  BCS  EEUTIM_50              ;the RAM time is lower: do not use it
K74BD:  STD  TIMEON                 ;TIMEON = the RAM time
K74C0:  STU  timeon_2
K74C3:  BRA  EEUTIM_60

EEUTIM_50:
K74C5:  LDD  TIMEON                 ;RESTORE TIME FROM TIMEON
K74C8:  STD  TIMER
K74CB:  LDD  timeon_2
K74CE:  STD  TIMER+2

EEUTIM_60:
K74D1:  LDA  #$02                   ;SET NEW CHECKSUM
K74D3:  JSR  EECKSM
K74D6:  RTS

;------------------------------------------------------------------------------
; EECPY - SET EEROM AREA TO DEFAULT VALUES
;   in ESB: in ESB area 0 takes R_OPT1 as read and R_OPT2 with bits 0, 3 and 4 inverted and bit 7 set, area 1
;   is filled by KE47D with the default high score table, area 2 comes from T_DFLT, and an area number of 3 or
;   more only gets its checksum renewed. EECKSM, which every path ends in, also writes the area to the NVRAM
;------------------------------------------------------------------------------
EECPY:
K74D7:  CMPA #NAREA                 ;LEGAL?
K74D9:  BHS  EECKSM                 ;IFLO  YES, GO AHEAD PLEASE
K74DB:  CMPA #$02                   ;AREAS 0 AND 1 GET DEFAULTS DIFFERENTLY
K74DD:  BLO  K7506                  ;IFHS  GET DEFAULTS FROM T.DFLT
K74DF:  LDX  #T_AREA+1              ;GET END OF AREA
K74E2:  LDB  A,X                    ;POINTS TO SOMEWHERE IN EEROM PAGE
K74E4:  DECB
K74E5:  LDX  #EEROM
K74E8:  ABX
K74E9:  STX  area_end               ;area_end = the area's checksum byte, where the copy stops
K74EC:  LDX  #T_AREA
K74EF:  LDB  A,X                    ;GET START OF AREA
K74F1:  LDX  #T_DFLT-$4B            ;DEFAULT TABLE STARTS WITH AREA 2
K74F4:  ABX
K74F5:  LEAU ,X
K74F7:  LDX  #EEROM
K74FA:  ABX
K74FB:  LDB  ,U+
K74FD:  STB  ,X+
K74FF:  CMPX area_end
K7502:  BLO  K74FB                  ;HSEND
K7504:  BRA  EECKSM                 ;ELSE  ELSE GET DEFAULTS FROM ELSEWHERE
K7506:  TSTA                        ;area 0, the backup of the options, is set from the option switches
K7507:  BNE  K751E
K7509:  LDB  R_OPT1                 ;coin options as the switches read
K750B:  STB  EEROM
K750E:  LDB  R_OPT2
K7510:  EORB #$19                   ;game options: bits 0, 3 and 4 inverted
K7512:  ORB  #$80                   ;and bit 7 always set
K7514:  STB  dup_opts1
K7517:  LDB  #$00                   ;misc. options
K7519:  STB  dup_opts2
K751C:  BRA  EECKSM
K751E:  JSR  hs_nv_defaults         ;area 1: KE47D copies the default high score table in

;------------------------------------------------------------------------------
; EECKSM - checksum an EEROM area: forms the checksum of area A with ee_area_sum and stores it in the area's
;   last byte, then writes the whole area from the RAM image at EEROM to the NVRAM, each byte as two nibbles with
;   the high nibble first. A, X and U are preserved. bank 0 reaches it through L6138
;------------------------------------------------------------------------------
EECKSM:
K7521:  PSHS A,X,U
K7523:  JSR  ee_area_sum
K7526:  STB  ,X                     ;store the checksum in the area's last byte
K7528:  LDX  #area_end_tab          ;then write the area to the NVRAM: B = its length, checksum included
K752B:  LDB  A,X
K752D:  LEAX -1,X
K752F:  SUBB A,X
K7531:  LDA  A,X
K7533:  EXG  A,B                    ;A = length, B = start
K7535:  LDX  #NVRAM                 ;U = NVRAM + 2 * start, two nibbles a byte
K7538:  ABX
K7539:  ABX
K753A:  LEAU ,X
K753C:  LDX  #EEROM
K753F:  ABX
K7540:  LDB  ,X+
K7542:  STB  1,U                    ;low nibble second
K7544:  LSRB
K7545:  LSRB
K7546:  LSRB
K7547:  LSRB
K7548:  STB  ,U++                   ;high nibble first
K754A:  DECA
K754B:  BNE  K7540
K754D:  PULS A,X,U,PC

;------------------------------------------------------------------------------
; ee_area_sum - ESB's version of Star Wars' SUMMIT: adds up the bytes of area A of the NVRAM image (start and
;   end from T_AREA, the area's last byte is the stored checksum and is left out), starting from $11 and with the
;   carries added back in. returns the sum in B, X pointing at the stored checksum and Z set when the two are
;   equal. A is preserved. bank 0 reaches it through L613E
;------------------------------------------------------------------------------
ee_area_sum:
K754F:  LEAS -2,S                   ;two bytes on the stack, the first is the count
K7551:  LDX  #area_end_tab
K7554:  LDB  A,X
K7556:  LEAX -1,X
K7558:  SUBB A,X
K755A:  DECB                        ;do not checksum the checksum
K755B:  STB  ,S
K755D:  LDB  A,X                    ;GET START OF AREA
K755F:  LDX  #EEROM
K7562:  ABX                         ;POINTS TO START OF AREA TO CHECKSUM
K7563:  ANDCC #$FE
K7565:  LDB  #$11                   ;the sum starts at $11
K7567:  ADCB ,X+
K7569:  DEC  ,S
K756B:  BNE  K7567                  ;EQEND
K756D:  ADCB #$00                   ;GET ALL THE CARRIES IN
K756F:  STB  NEWSUM,S
K7571:  CMPB ,X                     ;X is at the stored checksum: Z = 1 if it is the same
K7573:  LEAS 2,S
K7575:  RTS

;------------------------------------------------------------------------------
; ee_init - ESB's version of Star Wars' EEINIT, called once by the power-on code (bank 0 LEEA4, through L6144):
;   packs the NVRAM nibbles as they stand into the byte-wide image at EEROM, recalls the NVRAM, then checks the
;   option area 3 and its backup, area 0. if both are bad they are loaded from the recalled NVRAM and checked
;   again, and if they are still bad the backup is set from the option switches (EEINI0). a good one is copied
;   over the other, areas 2 and 1 are checked, reloaded or set to defaults, the image is written to the NVRAM and
;   TIMER is set from TIMEON
;------------------------------------------------------------------------------
ee_init:
K7576:  STA  WTCHDG
K7579:  LDX  #NVRAM                 ;pack the NVRAM nibbles as they stand, before the recall, into the RAM image
K757C:  LDU  #EEROM
K757F:  LDA  ,X+
K7581:  ASLA
K7582:  ASLA
K7583:  ASLA
K7584:  ASLA
K7585:  STA  scratch_1
K7587:  LDA  ,X+
K7589:  ANDA #$0F
K758B:  ORA  scratch_1
K758D:  STA  ,U+
K758F:  CMPX #EEROMZ
K7592:  BLO  K757F                  ;HSEND
K7594:  LDA  #$FF                   ;PERFORM A RECALL OF THE NON-VOLATILE MEMORY
K7596:  STA  NVRRCL
K7599:  LDX  #$0100                 ;WAIT FOR THE CAP TO DISCHARGE
K759C:  STA  WTCHDG
K759F:  LEAX -$1,X
K75A1:  BNE  K759C                  ;EQEND
K75A3:  LDA  #$00                   ;TURN OFF RECALL LINE
K75A5:  STA  NVRRCL
K75A8:  LDX  #$A000                 ;NOW WAIT FOR THE CAP TO CHARGE BACK UP
K75AB:  STA  WTCHDG
K75AE:  LEAX -$1,X
K75B0:  BNE  K75AB                  ;EQEND
K75B2:  LDA  #$03                   ;check the option area 3 of the image
K75B4:  JSR  ee_area_sum
K75B7:  BEQ  EEINIT_20
K75B9:  LDA  #$00                   ;primary bad: check the backup, area 0
K75BB:  JSR  ee_area_sum
K75BE:  BEQ  EEINIT_15
K75C0:  JSR  ee_area_load           ;both bad: load both from the recalled NVRAM
K75C3:  LDA  #$03
K75C5:  JSR  ee_area_load
K75C8:  JSR  ee_area_sum            ;check the recalled primary
K75CB:  BEQ  EEINIT_20
K75CD:  LDA  #$00                   ;and the recalled backup
K75CF:  JSR  ee_area_sum
K75D2:  BEQ  EEINIT_15

;------------------------------------------------------------------------------
; EEINI0 - THEN RE-INIT IT  (comment at the call)
;------------------------------------------------------------------------------
EEINI0:
K75D4:  STA  WTCHDG
K75D7:  JSR  EECPY                  ;RESTORE FROM ROM TABLE

EEINIT_15:          ;PRIMARY BAD, BUT BACKUP OK
K75DA:  LDX  #T_AREA                ;MOVE BACKUP TO PRIMARY
K75DD:  LDB  >NAREA,X
K75E1:  LDX  #EEROM
K75E4:  ABX                         ;POINTER TO BAD AREA
K75E5:  LDU  #EEROM                 ;POINTER TO GOOD AREA (BACKUP)
K75E8:  BRA  K7609                  ;FIX IT FROM BACKUP

EEINIT_20:          ;PRIMARY GOOD
K75EA:  LDA  #$00                   ;CHECK THE BACKUP AREA
K75EC:  JSR  ee_area_sum
K75EF:  BNE  ee_backup_opts         ;backup bad: fix it from primary
K75F1:  LDA  EECK3                  ;both good: their checksums must be the same too
K75F4:  CMPA EECK0
K75F7:  BEQ  K7619                  ;they are: go check the other areas

;------------------------------------------------------------------------------
; ee_backup_opts - ESB's version of Star Wars' EEINI1: copies the four bytes of the option area 3 over its
;   backup, area 0, then goes on with the rest of ee_init - checks areas 2 and 1, loading a bad one from the NVRAM
;   and setting it to defaults if it is still bad, writes the whole image to the NVRAM as nibbles and sets TIMER
;   from TIMEON. opt_page_change calls it after an option has been changed
;------------------------------------------------------------------------------
ee_backup_opts:
K75F9:  LDX  #T_AREA
K75FC:  LDB  >$0003,X
K7600:  LDX  #EEROM
K7603:  ABX
K7604:  LEAU ,X                     ;U = the option area 3, X = its backup at the start of the image
K7606:  LDX  #EEROM
K7609:  STA  WTCHDG
K760C:  LDB  area_end_tab           ;length of the option areas, 4 bytes
K760F:  STB  scratch_2              ;$4802 is the byte counter
K7611:  LDB  ,U+
K7613:  STB  ,X+
K7615:  DEC  scratch_2
K7617:  BNE  K7611
K7619:  LDA  #$02                   ;areas 2 and 1
K761B:  JSR  ee_area_sum
K761E:  BEQ  K7631
K7620:  STA  WTCHDG
K7623:  JSR  ee_area_load           ;no good: load it from the NVRAM
K7626:  JSR  ee_area_sum
K7629:  BEQ  K7631
K762B:  STA  WTCHDG
K762E:  JSR  EECPY                  ;really bad: use defaults
K7631:  DECA
K7632:  BNE  K761B
K7634:  STA  WTCHDG
K7637:  LDX  #EEROM                 ;write the whole image to the NVRAM, two nibbles a byte
K763A:  LDU  #NVRAM
K763D:  LDA  ,X+
K763F:  STA  1,U
K7641:  LSRA
K7642:  LSRA
K7643:  LSRA
K7644:  LSRA
K7645:  STA  ,U++
K7647:  CMPX #ST_QU
K764A:  BCS  K763D
K764C:  LDD  TIMEON                 ;the RAM based time on starts from TIMEON
K764F:  STD  TIMER
K7652:  LDD  timeon_2
K7655:  STD  timer_2
K7658:  STA  WTCHDG
K765B:  RTS

;------------------------------------------------------------------------------
; ee_area_load - ESB's version of Star Wars' EEINI2: loads area A of the image at EEROM from the NVRAM, packing
;   two nibbles (high first) into each byte, the checksum byte included. A is preserved, area_end and scratch_1
;   are used
;------------------------------------------------------------------------------
ee_area_load:
K765C:  LDX  #area_end_tab
K765F:  LDB  A,X
K7661:  LDX  #EEROM
K7664:  ABX
K7665:  STX  area_end               ;area_end = start of the next area
K7668:  LDX  #T_AREA
K766B:  LDB  A,X
K766D:  LDX  #NVRAM
K7670:  ABX
K7671:  ABX
K7672:  LEAU ,X                     ;U = the area's nibbles in the NVRAM
K7674:  LDX  #EEROM
K7677:  ABX
K7678:  LDB  ,U+                    ;high nibble
K767A:  ASLB
K767B:  ASLB
K767C:  ASLB
K767D:  ASLB
K767E:  STB  scratch_1
K7680:  LDB  ,U+                    ;low nibble
K7682:  ANDB #$0F
K7684:  ORB  scratch_1
K7686:  STB  ,X+
K7688:  CMPX area_end
K768B:  BCS  K7678
K768D:  RTS

;------------------------------------------------------------------------------
; ee_area_check - ESB's version of Star Wars' CHKEE: checks the checksum of area A and, if it is bad, recalls
;   the NVRAM (NOVRCL, which waits 33 frames) and loads the area from it. if it is still bad the area is set to
;   its defaults with EECPY. called for area 2 by EEACCT, for area 1 by KE3E8, and by bank 0 through L614A
;------------------------------------------------------------------------------
ee_area_check:
K768E:  JSR  ee_area_sum
K7691:  BEQ  K76A1
K7693:  JSR  NOVRCL                 ;bad: recall the NVRAM
K7696:  JSR  ee_area_load           ;and load the area from it
K7699:  JSR  ee_area_sum
K769C:  BEQ  K76A1
K769E:  JSR  EECPY                  ;still bad: defaults
K76A1:  RTS

;------------------------------------------------------------------------------
; ee_opts_check - called by PHIOPT when the option page is entered (bank 0 L7613, through L6150): if the
;   checksum of the option area 3 is bad, goes through EEINI0 with A = 3, which renews that checksum, then copies
;   the backup area 0 over area 3, rechecks areas 2 and 1 and writes the image to the NVRAM
;------------------------------------------------------------------------------
ee_opts_check:
K76A2:  LDA  #$03                   ;the option area
K76A4:  JSR  ee_area_sum
K76A7:  BEQ  K76AC
K76A9:  JSR  EEINI0
K76AC:  RTS

;------------------------------------------------------------------------------
; opt_page_view - ESB's version of Star Wars' EEOPT, without the resets (they are in opt_page_change): draws the
;   option page of the self test for PHEOPT (through L6156). turns on message $79 (the option names) and $D6,
;   draws the value message of each of the 12 options in green, reports the NVRAM test (EETSTR), then shows in red
;   the coin option byte OPTS0 as the switch pack 10EF and the game option byte OPTS1 as the switch pack 10D,
;   eight letters each
;------------------------------------------------------------------------------
opt_page_view:
K76AD:  LDB  #$79                   ;message $79: the names of the options
K76AF:  JSR  K6030
K76B2:  LDB  #$D6                   ;message $D6: PRESS AUX COIN FOR SELF TEST
K76B4:  JSR  K6030
K76B7:  LDD  #$6280                 ;green, for the option values
K76BA:  STD  ,Y++
K76BC:  LDA  #$0B                   ;all 12 options, the last first
K76BE:  STA  TMPCNT
K76C1:  LDA  TMPCNT
K76C4:  JSR  EEOPT3                 ;B = the message of the option's current value
K76C7:  JSR  K6096                  ;do_message_nc: drawn in the colour set above
K76CA:  DEC  TMPCNT
K76CD:  BPL  K76C1
K76CF:  JSR  EETSTR                 ;report the result of the NVRAM test
K76D2:  LDD  #$6480                 ;red
K76D5:  STD  ,Y++
K76D7:  LDD  #$0032                 ;y 50
K76DA:  STD  ,Y++
K76DC:  LDD  #$1EA2                 ;x -350, beam off
K76DF:  STD  ,Y++
K76E1:  LDD  L3006                  ;the characters 1 0 E F, the name of a switch pack
K76E4:  STD  ,Y++
K76E6:  LDD  L3004
K76E9:  STD  ,Y++
K76EB:  LDD  L3020
K76EE:  STD  ,Y++
K76F0:  LDD  L3022
K76F3:  STD  ,Y++
K76F5:  LDB  OPTS0                  ;the coin options, one letter a bit
K76F8:  BSR  vw_dip_bits
K76FA:  LDD  #$0032                 ;y 50, x 50
K76FD:  STD  ,Y++
K76FF:  LDD  #$0032
K7702:  STD  ,Y++
K7704:  LDD  L3006                  ;the characters 1 0 D, the other switch pack
K7707:  STD  ,Y++
K7709:  LDD  L3004
K770C:  STD  ,Y++
K770E:  LDD  L301E
K7711:  STD  ,Y++
K7713:  LDB  OPTS1                  ;the game options turned back into switch positions: bits 0, 3 and 4 inverted, bit 7 set
K7716:  EORB #$19
K7718:  ORB  #$80

;------------------------------------------------------------------------------
; vw_dip_bits - outputs through Y a colon and the eight bits of B, bit 0 first, as letters - F for a 1, N for a
;   0 - then a centre instruction. uses TMPCNT
;------------------------------------------------------------------------------
vw_dip_bits:
K771A:  STB  TMPCNT
K771D:  LDD  #$B8E8                 ;a colon
K7720:  STD  ,Y++
K7722:  LDX  #$0008                 ;8 bits, bit 0 first
K7725:  LSR  TMPCNT
K7728:  BCC  K772F
K772A:  LDD  L3022                  ;1: the letter F
K772D:  BRA  K7732
K772F:  LDD  L3032                  ;0: the letter N
K7732:  STD  ,Y++
K7734:  LEAX -1,X
K7736:  BNE  K7725
K7738:  LDD  #$8040
K773B:  STD  ,Y++
K773D:  RTS

;------------------------------------------------------------------------------
; opt_page_change - ESB's version of Star Wars' EEOPT1 with the resets of EEOPT in front, called by PHEOPT every
;   frame (through L615C): while RESETS is not 0 it shows message $D7 and on the right fire edge performs the
;   flagged resets - high scores, accounting from the games count up, options from the option switches, NVRAM test
;   - and clears the flags. then it draws the selected option's value in white, steps the selection with the stick
;   (up or down past $50, 8 frames between steps) and on the left fire edge steps the selected option's value,
;   stores it in its bit field, renews checksum and backup and draws the new value. a change of option 4, 5 or 6
;   (starting shields, difficulty, Jedi-letter mode) also puts the high score table back to its defaults
;------------------------------------------------------------------------------
opt_page_change:
K773E:  LDA  RESETS                 ;any reset flagged?
K7741:  BEQ  K77C0
K7743:  LDB  #$D7                   ;message $D7: PULL RIGHT FIRE TO PERFORM RESETS
K7745:  JSR  K6090
K7748:  LDA  GN_SWE
K774A:  ANDA #$40                   ;right fire just pulled?
K774C:  BEQ  K77C0
K774E:  LDA  RESETS
K7751:  ANDA #$80                   ;reset high scores?
K7753:  BEQ  K7769
K7755:  LDA  #$01                   ;area 1 to its defaults
K7757:  JSR  EECPY
K775A:  JSR  hs_load                ;KE3E8: and the table in RAM from it
K775D:  LDD  #$0000                 ;clear the top four bytes of the score and rank_index
K7760:  STD  >S_SC87
K7763:  STD  >S_SC43
K7766:  STA  rank_index
K7769:  LDA  RESETS
K776C:  ANDA #$40                   ;reset accounting info?
K776E:  BEQ  K778A
K7770:  LDX  #GAMES                 ;clear area 2 from the games played count to its checksum - the pot limits and coin counts stay
K7773:  LDA  #$00
K7775:  STA  ,X+
K7777:  CMPX #EECK2
K777A:  BCS  K7775
K777C:  LDA  #$02
K777E:  JSR  EECKSM
K7781:  LDD  #$0000                 ;and the RAM based time on
K7784:  STD  timer_2
K7787:  STD  TIMER
K778A:  LDA  RESETS
K778D:  ANDA #$20                   ;RESET OPTIONS TO DEFAULT?
K778F:  BEQ  K77B1                  ;IFNE  YES
K7791:  LDA  #$00                   ;SET AREA 0 TO DEFAULT
K7793:  JSR  EECPY
K7796:  LDX  #T_AREA                ;COPY BACKUP AREA TO PRIMARY AREA
K7799:  LDB  >NAREA,X
K779D:  LDX  #EEROM
K77A0:  ABX
K77A1:  LDU  #EEROM
K77A4:  LDB  T_AREA+1
K77A7:  STB  scratch_2              ;$4802 is the byte counter
K77A9:  LDB  ,U+
K77AB:  STB  ,X+
K77AD:  DEC  scratch_2
K77AF:  BNE  K77A9                  ;EQEND
K77B1:  LDA  RESETS
K77B4:  ANDA #$10                   ;TEST NOVRAM?
K77B6:  BEQ  K77BB                  ;IFNE  YES
K77B8:  JSR  EETST                  ;TEST STORE-ABILITY OF NOVRAM
K77BB:  LDA  #$00                   ;clear the reset flags
K77BD:  STA  RESETS
K77C0:  LDD  #$6780                 ;white: the selected option's value, over the green one
K77C3:  STD  ,Y++
K77C5:  LDA  EEINDX
K77C8:  JSR  EEOPT3
K77CB:  JSR  K6096                  ;do_message_nc
K77CE:  LDA  sel_delay              ;frames to wait before the stick may step the selection again
K77D1:  BEQ  K77DF
K77D3:  DECA
K77D4:  CMPA #$08                   ;count it down, never more than 8
K77D6:  BCS  K77DA
K77D8:  LDA  #$08
K77DA:  STA  sel_delay
K77DD:  BRA  K780E
K77DF:  LDB  >SI_RSY                ;sight up/down position
K77E2:  CMPB #$B0                   ;below -$50: the next option
K77E4:  BGE  K77FA
K77E6:  LDB  EEINDX
K77E9:  INCB
K77EA:  CMPB #T_OPTZ-T_OPT-1
K77EC:  BLS  K77F0                  ;IFHI  WRAP
K77EE:  LDB  #$00
K77F0:  STB  EEINDX
K77F3:  LDA  #$08                   ;8 frames to the next step
K77F5:  STA  sel_delay
K77F8:  BRA  K780E
K77FA:  CMPB #$50                   ;above $50: the previous option
K77FC:  BLE  K780E
K77FE:  LDB  EEINDX
K7801:  DECB
K7802:  BPL  K7806                  ;IFMI  WRAP WHEN BELOW 0
K7804:  LDB  #T_OPTZ-T_OPT-1
K7806:  STB  EEINDX
K7809:  LDA  #$08
K780B:  STA  sel_delay
K780E:  LDX  #T_OPT                 ;GET OPTION DESCRIPTOR
K7811:  LDA  EEINDX
K7814:  LDB  A,X
K7816:  STB  opt_desc
K7819:  LSRB
K781A:  LSRB
K781B:  LSRB
K781C:  ANDB #$03                   ;FIELD SIZE
K781E:  LDX  #EEMASK
K7821:  LDA  B,X                    ;MASK FOR THIS FIELD SIZE
K7823:  STA  opt_mask               ;ALSO MAX VALUE FOR CURRENT OPTION
;LEFT FIRE BUTTON CHANGES THE OPTION
K7826:  LDB  GN_SWE                 ;LOOK FOR EDGE OF LEFT FIRE BUTTON
K7828:  ANDB #LFIRBT
K782A:  BEQ  K788A                  ;IFNE  FOUND AN EDGE
K782C:  LDB  EEVAL                  ;CURRENT VALUE
K782F:  INCB                        ;NEXT VALUE, MAYBE
K7830:  CMPB opt_mask               ;PAST MAX?
K7833:  BLS  K7837                  ;IFHI  YES, WRAP BACK TO LOWEST VALUE
K7835:  LDB  #$00
K7837:  STB  EEVAL
K783A:  LDA  opt_desc               ;OPTION DESCRIPTOR
K783D:  ROLA                        ;GET BIT POSITION
K783E:  ROLA
K783F:  ROLA
K7840:  ROLA
K7841:  ANDA #$07
K7843:  DECA
K7844:  BMI  EEOPT1_20
K7846:  ASLB                        ;SHIFT DATA
K7847:  ASL  opt_mask               ;SHIFT MASK
K784A:  BRA  K7843                  ;LOOP

EEOPT1_20:
K784C:  LDA  opt_desc               ;OPTION DESCRIPTOR
K784F:  ANDA #$07                   ;INDEX INTO OPTION SWITCH AREA
K7851:  LDX  #OPTS0
K7854:  LEAX A,X                    ;POINTER TO OPTION SWITCH DATA
K7856:  LDA  ,X                     ;GET THE DATA INTO TEMP STORAGE
K7858:  STA  opt_old
K785B:  EORB opt_old                ;PUT NEW DATA INTO TEMP
K785E:  ANDB opt_mask
K7861:  EORB opt_old
K7864:  STB  ,X                     ;back into the RAM image
K7866:  LDA  #NAREA                 ;SET CHECKSUM
K7868:  JSR  EECKSM
K786B:  JSR  ee_backup_opts         ;SETUP BACKUP AND CHECK OTHER AREAS
K786E:  LDA  EEINDX                 ;DISPLAY THE NEW VALUE
K7871:  JSR  EEOPT3
K7874:  JSR  K6090                  ;do_message
K7877:  LDB  EEINDX                 ;options 4 to 6 - starting shields, difficulty, Jedi-letter mode - changed:
K787A:  CMPB #$04
K787C:  BCS  K788A
K787E:  CMPB #$06
K7880:  BHI  K788A
K7882:  LDA  #$01                   ;the high score table goes back to its defaults
K7884:  JSR  EECPY
K7887:  JSR  hs_load
K788A:  RTS

;------------------------------------------------------------------------------
; EEOPT3 - DISPLAY OPTION VALUE
;------------------------------------------------------------------------------
EEOPT3:
K788B:  LDX  #T_OPT
K788E:  LDB  A,X                    ;OPTION SWITCH DESCRIPTOR
K7890:  STB  ee_tmp                 ;SAVE IT
K7893:  ANDB #$07                   ;WHICH WORD?
K7895:  LDX  #OPTS0
K7898:  ABX                         ;POINTER TO OPTION SWITCHES
K7899:  LDB  ee_tmp                 ;SWITCH DESCRIPTOR
K789C:  LSRB
K789D:  LSRB
K789E:  LSRB
K789F:  STB  ee_tmp                 ;SAVE IT
K78A2:  ANDB #$03                   ;WHAT IS THE FIELD SIZE?
K78A4:  LDU  #EEMASK
K78A7:  LEAU B,U                    ;ADD B TO U, POINTS TO FIELD MASK
K78A9:  LDB  ee_tmp
K78AC:  LSRB
K78AD:  LSRB
K78AE:  STB  ee_tmp                 ;BIT POSITION OF FIELD
K78B1:  LDB  ,X                     ;GET OPTION SWITCH DATA (BOTH NIBBLES)
K78B3:  DEC  ee_tmp
K78B6:  BMI  EEOPT3_20
K78B8:  LSRB
K78B9:  BRA  K78B3                  ;LOOP

EEOPT3_20:
K78BB:  ANDB ,U                     ;MASK FOR FIELD
K78BD:  STB  EEVAL
K78C0:  LDX  #T_MOPV                ;OPTION SWITCH VALUE MESSAGE TABLE
K78C3:  ADDB A,X                    ;B = the message number of that value
K78C5:  RTS

;------------------------------------------------------------------------------
; EETST - TEST EEROM STORE
;   TEST STORE-ABILITY OF EEROM (NOVRAM)
;   in ESB: in ESB the test runs between the byte-wide image at EEROM and the NVRAM itself, which is what
;   EEBUF addresses here: the complement of the image is written to the NVRAM as nibbles, stored, cleared and
;   recalled, complemented in place, stored again and compared with the image by EECMP, then cleared, recalled
;   and compared once more. on a mismatch (K7932) NVADDR gets the NVRAM address of the nibble, NVTSTR is $FF
;   and the image is written to the NVRAM again
;------------------------------------------------------------------------------
EETST:
K78C6:  LDX  #EEROM                 ;COPY CURRENT DATA TO BUFFER
K78C9:  LDU  #EEBUF
K78CC:  LDA  ,X+
K78CE:  COMA                        ;the complement of every byte of the image goes to the NVRAM as two nibbles
K78CF:  STA  1,U
K78D1:  LSRA
K78D2:  LSRA
K78D3:  LSRA
K78D4:  LSRA
K78D5:  STA  ,U++
K78D7:  CMPX #ST_QU
K78DA:  BLO  K78CC                  ;HSEND
K78DC:  STA  NSTORE                 ;STORE IT OUT TO ROM PORTION OF EEROM
K78DF:  JSR  EEWAIT                 ;WAIT 10 MS FOR THE STORE
K78E2:  JSR  EECLR                  ;CLEAR IT OUT TO TEST THE RECALL
K78E5:  JSR  NOVRCL                 ;RECALL THE DATA
;DATA IN RAM SHOULD BE COMPLIMENT OF BUFFER DATA
K78E8:  LDX  #NVRAM                 ;COMPLIMENT IT AGAIN
K78EB:  LDA  ,X
K78ED:  COMA
K78EE:  STA  ,X+
K78F0:  CMPX #EEROMZ
K78F3:  BLO  K78EB                  ;HSEND
;SHOULD BE THE ORIGINAL DATA AGAIN
K78F5:  STA  NSTORE                 ;STORE IT OUT AGAIN
K78F8:  JSR  EEWAIT                 ;WAIT 10 MS FOR STORE
K78FB:  JSR  EECMP                  ;COMPARE DATA TO BUFFER
K78FE:  BNE  K7932                  ;BAD DATA--SET FLAG AND RESTORE WITH BUFFER DATA
;TWICE COMPLIMENTED DATA LOOKS OK, TRY RECALLING THE DATA AGAIN
K7900:  JSR  EECLR                  ;CLEAR IT TO TEST RECALL
K7903:  JSR  NOVRCL                 ;RECALL THE DATA AGAIN
K7906:  JSR  EECMP                  ;ONE LAST COMPARE
K7909:  BNE  K7932
K790B:  RTS

;------------------------------------------------------------------------------
; EECMP - COMPARE EEROM DATA TO BUFFER DATA
;   in ESB: in ESB this compares each byte of the image at EEROM with its two nibbles in the NVRAM (EEBUF), up
;   to the end of the image at ST_QU
;------------------------------------------------------------------------------
EECMP:
K790C:  LDX  #EEROM
K790F:  LDU  #EEBUF
K7912:  LDA  ,X
K7914:  LSRA
K7915:  LSRA
K7916:  LSRA
K7917:  LSRA
K7918:  EORA ,U+
K791A:  ANDA #$0F
K791C:  BNE  EECMP_10
K791E:  LDA  ,X+
K7920:  EORA ,U+
K7922:  ANDA #$0F                   ;LOW NIBBLE ONLY
K7924:  BNE  EECMP_10
K7926:  CMPX #ST_QU
K7929:  BLO  K7912                  ;HSEND
K792B:  LDA  #$01                   ;SET FLAG TO SAY NOVRAM OK
K792D:  STA  NVTSTR
K7930:  CLRA                        ;SET CONDTION CODE FOR NO ERROR ( Z=1 )

EECMP_10:
K7931:  RTS
K7932:  LEAU -1,U                   ;bad: note the NVRAM address of the nibble that differs
K7934:  STU  NVADDR
K7937:  LDA  #$FF                   ;FLAG SAYING NOVRAM BAD
K7939:  STA  NVTSTR                 ;TEST RESULTS
K793C:  LDX  #EEROM                 ;COPY BUFFER TO EEROM RAM
K793F:  LDU  #EEBUF
K7942:  LDA  ,X+                    ;low nibble at 1, high nibble at 0
K7944:  STA  1,U
K7946:  LSRA
K7947:  LSRA
K7948:  LSRA
K7949:  LSRA
K794A:  STA  ,U++
K794C:  CMPX #ST_QU
K794F:  BLO  K7942                  ;HSEND
K7951:  RTS

;------------------------------------------------------------------------------
; EECLR - CLEAR RAM PORTION OF EEROM ( NOVRAM )
;------------------------------------------------------------------------------
EECLR:
K7952:  LDX  #NVRAM
K7955:  LDD  #$0000
K7958:  STD  ,X++
K795A:  CMPX #EEROMZ
K795D:  BLO  K7958                  ;HSEND
K795F:  RTS

;------------------------------------------------------------------------------
; EEWAIT - WAIT AT LEAST 10 MS FOR NOVRAM STORE CYCLE
;------------------------------------------------------------------------------
EEWAIT:
K7960:  LDX  #$07D0                 ;10. MS = 15000. CYCLES/8 CYCLES = 1875.
K7963:  LEAX -$1,X                  ;DEX
K7965:  BNE  K7963                  ;EQEND
K7967:  RTS

;------------------------------------------------------------------------------
; EETSTR - REPORT EETST RESULTS
;------------------------------------------------------------------------------
EETSTR:
K7968:  LDA  NVTSTR                 ;RESULTS OF NOVRAM ( EEROM ) TEST
;0 MEANS NO TEST PERFORMED
;1 MEANS NO ERRORS DETECTED
;ANYTHING ELSE MEANS ERRORS DETECTED
K796B:  BEQ  K798F                  ;IFNE  TEST WAS PERFORMED - TELL RESULTS
K796D:  CMPA #$01
K796F:  BNE  K7975                  ;IFEQ  NO ERRORS -- GOOD EEROM
K7971:  LDB  #$A2                   ;"NO ERRORS" ( GOOD NOVRAM )
K7973:  BRA  K798C                  ;ELSE  THERE WERE ERRORS
K7975:  LDD  #$1F06                 ;y -250
K7978:  STD  ,Y++
K797A:  LDD  #$01A4                 ;x 420
K797D:  STD  ,Y++
K797F:  LDA  NVADDR+1               ;LOW BYTE OF ADDRESS OF ERROR
K7982:  JSR  K607E
K7985:  LDD  #VGCNTR
K7988:  STD  ,Y++
K798A:  LDB  #$A3                   ;"ERROR AT" ( BAD NOVRAM )
K798C:  JSR  K6090
K798F:  RTS

;------------------------------------------------------------------------------
; NOVRCL - RECALL NON-VOLATILE MEMORY
;------------------------------------------------------------------------------
NOVRCL:
K7990:  LDA  #$FF                   ;D7 = 1 PUTS NOVRAM IN RECALL MODE
K7992:  STA  NVRRCL
K7995:  JSR  K602A
K7998:  LDA  #$00                   ;D7 = 0 BRINGS US OUT OF RECALL MODE
K799A:  STA  NVRRCL
K799D:  LDU  #$0000
K79A0:  JSR  K602A
K79A3:  LEAU 1,U
K79A5:  CMPU #$0020
K79A9:  BLO  K79A0                  ;HSEND  NOW THE NOVRAM SHOULD BE USABLE
K79AB:  RTS

;------------------------------------------------------------------------------
; EETMP2 - copies 4 bytes from X to U and leaves X and U as they were. the accounting page uses it to move a
;   value of the NVRAM image to a temp, bank 0 calls it through L6168
;------------------------------------------------------------------------------
EETMP2:
K79AC:  LDA  #$04                   ;4 bytes

;------------------------------------------------------------------------------
; EETMP3 - [note] Move EEROM nibbles at (X) to bytes at (U): A = number of bytes less one, two nibbles (upper, lower)
;   per byte; uses TMPCNT; ends with LEAX -8,X (restores X only for the 8-nibble EETEMP case)
;   in ESB: in ESB the image at EEROM holds whole bytes: this copies A bytes from X to U and then moves both
;   pointers back by 4, which restores them only for the 4 bytes of EETMP2. the loop ends when the count
;   reaches 0, so A is the number of bytes
;------------------------------------------------------------------------------
EETMP3:
K79AE:  STA  TMPCNT
K79B1:  LDA  ,X+                    ;UPPER NIBBLE
K79B3:  STA  ,U+
K79B5:  DEC  TMPCNT
K79B8:  BNE  K79B1
K79BA:  LEAX -4,X                   ;pointers back to the start, right for 4 bytes only
K79BC:  LEAU -4,U
K79BE:  RTS

;------------------------------------------------------------------------------
; vw_min_sec - ESB's version of Star Wars' TIME: outputs through Y the time in A as m:ss - the high nibble is
;   minutes (shown as 9 at most), the low nibble counts 4 second units and is turned into BCD seconds. keeps A in
;   sel_delay ($4C2B) meanwhile, clears BT_SUP and ends in VWBYTE
;------------------------------------------------------------------------------
vw_min_sec:
K79BF:  STA  sel_delay              ;keep the time byte
K79C2:  CLR  BT_SUP
K79C4:  LSRA
K79C5:  LSRA
K79C6:  LSRA
K79C7:  LSRA
K79C8:  CMPA #$0A
K79CA:  BLO  K79CE                  ;IFHS  MAX OF 9
K79CC:  LDA  #$09
K79CE:  JSR  K6084                  ;MINUTES
K79D1:  LDD  #$B8E8                 ;a colon
K79D4:  STD  ,Y++
K79D6:  CLRA
K79D7:  LDB  sel_delay
K79DA:  ANDB #$0F                   ;SECONDS
K79DC:  BEQ  K79E4                  ;IFNE
K79DE:  ADDA #$04
K79E0:  DAA
K79E1:  DECB
K79E2:  BNE  K79DE                  ;EQEND
K79E4:  JMP  K607E                  ;AND RETURN

;.SBTTL TABLES
EEMASK:
K79E7:  .byte $01, $03, $07, $0F

T_DFLT:
K79EB:  .byte $80                   ;defaults of area 2, 46 bytes for $4D4B-$4D78: the four pot limits $80, then zeros. one byte each in ESB - the .word rows and their comments are Star Wars' nibble layout
K79EC:  .byte $80
K79ED:  .byte $80
K79EE:  .byte $80
K79EF:  .byte $00
K79F0:  .byte $00
K79F1:  .byte $00
K79F2:  .byte $00
K79F3:  .byte $00
K79F4:  .byte $00
K79F5:  .byte $00
K79F6:  .byte $00
K79F7:  .byte $00
K79F8:  .byte $00
K79F9:  .byte $00
K79FA:  .byte $00
K79FB:  .byte $00
K79FC:  .byte $00
K79FD:  .byte $00
K79FE:  .byte $00
K79FF:  .byte $00
K7A00:  .byte $00
K7A01:  .byte $00
K7A02:  .byte $00
K7A03:  .byte $00
K7A04:  .byte $00
K7A05:  .byte $00
K7A06:  .byte $00
K7A07:  .byte $00
K7A08:  .byte $00
K7A09:  .byte $00
K7A0A:  .byte $00
K7A0B:  .byte $00
K7A0C:  .byte $00
K7A0D:  .byte $00
K7A0E:  .byte $00
K7A0F:  .byte $00
K7A10:  .byte $00
K7A11:  .byte $00
K7A12:  .byte $00
K7A13:  .byte $00
K7A14:  .byte $00
K7A15:  .byte $00
K7A16:  .byte $00
K7A17:  .byte $00
K7A18:  .byte $00                   ;the last default byte, for high_wave, then one zero byte that nothing reads. area 2's checksum is worked out, not copied
K7A19:  .byte $00

T_OPT:          ;OPTION DESCRIPTOR TABLE
K7A1A:  .byte $08                   ;SPEC 0,2,0  COIN VALUE
K7A1B:  .byte $80                   ;SPEC 0,1,4  LEFT MECH MULT
K7A1C:  .byte $48                   ;SPEC 0,2,2  RIGHT MECH MULT
K7A1D:  .byte $B0                   ;SPEC 0,3,5  BONUS ADDER
K7A1E:  .byte $09                   ;SPEC 1,2,0 starting shields ( 2 to 5 )
K7A1F:  .byte $49                   ;SPEC 1,2,2  PLAY DIFFICULTY
K7A20:  .byte $89                   ;SPEC 1,2,4 Jedi-letter mode
K7A21:  .byte $C1                   ;SPEC 1,1,6  MUSIC IN ATTRACT
;SPEC 1,1,7 ;FREEZE MODE, NOT USABLE HERE
K7A22:  .byte $E4                   ;SPEC 4,1,7  RESET HIGH SCORES
K7A23:  .byte $C4                   ;SPEC 4,1,6  RESET ACCOUNTING TIMING INFO
K7A24:  .byte $A4                   ;SPEC 4,1,5  RESET COIN OPTIONS TO DEFAULT
K7A25:  .byte $84                   ;SPEC 4,1,4  TEST NOVRAM

T_OPTZ:
K7A26:  .byte $00                   ;HISTORY OF GAME TIMES DATA

T_HIST:
K7A27:  .byte $05, $0A, $10
K7A2A:  .byte $15, $1A, $20
K7A2D:  .byte $25, $2A, $30
K7A30:  .byte $35, $3A, $40
K7A33:  .byte $45, $4A, $50
K7A36:  .byte $55, $5A, $60

T_AREA:          ;STARTING ADDRESS FOR EACH AREA
K7A39:  .byte $00

area_end_tab:
K7A3A:  .byte $04, $4B, $7A, $7E    ;end of areas 0 to 3 as offsets in the image: options backup $00-$03, high scores $04-$4A, accounting $4B-$79, options $7A-$7D. the last byte of each is its checksum

acct_ypos_tab:
K7A3E:  .word $01B8                 ;y positions of the accounting page: aux coins 440, left coins 400 (also the high wave), right coins 360, games played 280, add-a-coin games and their percentage 240, total coins 320, average game time 140, percentage of play 40, total game time 180, time on 80
K7A40:  .word $0190, $0168, $0118
K7A46:  .word $00F0
K7A48:  .word $0140
K7A4A:  .word $008C
K7A4C:  .word $0028
K7A4E:  .word $00B4
K7A50:  .word $0050

hist_pos_tab:
K7A52:  .word $1E43, $0046, $1E70, $0046 ;histogram positions, a y word and an x word for each of the 18 bins from the largest time down: nine at x 70 with y -445 to -85, then nine at x -270
K7A5A:  .word $1E9D, $0046, $1ECA, $0046
K7A62:  .word $1EF7, $0046, $1F24, $0046
K7A6A:  .word $1F51, $0046, $1F7E, $0046
K7A72:  .word $1FAB, $0046, $1E43, $1EF2
K7A7A:  .word $1E70, $1EF2, $1E9D, $1EF2
K7A82:  .word $1ECA, $1EF2, $1EF7, $1EF2
K7A8A:  .word $1F24, $1EF2, $1F51, $1EF2
K7A92:  .word $1F7E, $1EF2, $1FAB, $1EF2

T_MOPV:
K7A9A:  .byte $7A, $7E, $80, $84, $8C, $90, $94, $98 ;first value message of each of the 12 options: $7A coin value, $7E left mech, $80 right mech, $84 bonus adder, $8C starting shields, $90 difficulty, $94 Jedi-letter mode, $98 music in attract, $9A, $9C, $9E and $A0 the four resets
K7AA2:  .byte $9A, $9C, $9E, $A0

;------------------------------------------------------------------------------
; ISTAR - SETUP STARS  (comment at the call)
;------------------------------------------------------------------------------
ISTAR:
K7AA6:  LDA  #$80
K7AA8:  STA  ST_BRT                 ;INITIAL BRITENESS
K7AAA:  LDX  #M_STAD

ISTAR_10:
K7AAD:  LDA  P_RND2                 ;REVERSE OF INITING ORDER FOR RANDOMNESS
K7AB0:  LDB  P_RND1                 ;TRY TO POPULATE EVENLY
K7AB3:  STD  ,X
K7AB5:  MUL
K7AB6:  LDA  P_RND2
K7AB9:  STD  2,X
K7ABB:  MUL
K7ABC:  LDA  P_RND2
K7ABF:  STD  4,X
K7AC1:  LEAX 8,X
K7AC3:  CMPX #M_STAZ
K7AC6:  BLO  ISTAR_10
K7AC8:  RTS

;------------------------------------------------------------------------------
; ISTARG - [note] Setup stars for the ground: each 8-byte block M_STAD..M_STAZ gets random X,Y (P_RND1/P_RND2) and Z = 0
;------------------------------------------------------------------------------
ISTARG:
K7AC9:  LDX  #M_STAD

ISTARG_10:
K7ACC:  LDA  P_RND2                 ;REVERSE OF INITING ORDER FOR RANDOMNESS
K7ACF:  LDB  P_RND1                 ;TRY TO POPULATE EVENLY
K7AD2:  STD  ,X
K7AD4:  MUL
K7AD5:  LDA  P_RND2
K7AD8:  STD  2,X
K7ADA:  LDD  #$0000                 ;CLRD
K7ADD:  STD  4,X
K7ADF:  LEAX 8,X
K7AE1:  CMPX #M_STAZ
K7AE4:  BLO  ISTARG_10
K7AE6:  RTS

;------------------------------------------------------------------------------
; JVWSTAR - STARS--VWSTAR,STARGN,STARNW
;   (also: VWSTAR_7D9A)
;   in ESB: ESB sets the star colour by the Jedi force: white normally, purple while jedi_on is set, and
;   purple and white in turn on bit 3 of jedi_time once less than $60 of it is left. the brightness is ST_BRT
;   as before
;------------------------------------------------------------------------------
JVWSTAR:
VWSTAR_7D9A:
K7AE7:  LDD  ST_UX                  ;STARS RELATIVE MOVEMENT
K7AE9:  STD  MS_TX+M_U1
K7AEC:  LDD  ST_UY
K7AEF:  STD  MS_TY+M_U1
K7AF2:  LDD  ST_UZ
K7AF5:  STD  MS_TZ+M_U1
K7AF8:  LDX  #ST_QU
K7AFB:  LDD  #$0000

JVWSTA_4:
K7AFE:  STD  ,X++                   ;CLEAR OUT STAR QUE
K7B00:  CMPX #ST_QUZ
K7B03:  BLO  JVWSTA_4
K7B05:  STA  ST_GNB                 ;NO STAR TO GEN YET
K7B07:  LDA  jedi_on                ;ESB: the star colour follows the Jedi force
K7B0A:  BNE  K7B10
K7B0C:  LDA  #$67                   ;off: white
K7B0E:  BRA  K7B23
K7B10:  LDD  jedi_time              ;on: purple, and for the last $60 of its time
K7B13:  CMPD #$0060
K7B17:  BCC  K7B1D
K7B19:  ANDB #$08                   ;purple and white in turn on bit 3 of the time
K7B1B:  BNE  K7B21
K7B1D:  LDA  #$65                   ;purple
K7B1F:  BRA  K7B23
K7B21:  LDA  #(((VGCWHT*$100)+VGCOPC)&$FF00)/$100
K7B23:  LDB  ST_BRT                 ;INCLUDE OUTSIDE BRITENESS
K7B25:  STD  ,Y++
K7B27:  LDD  #MS_STBC
K7B2A:  STD  M_BIC
K7B2D:  STB  ST_BIC
K7B2F:  NEGB
K7B30:  ADDB #MS_STBZ&$FF           ;ZBIC-START= BIC GIVES COUNT OF STARS
K7B32:  STB  ST_CNT
K7B34:  LDU  #ST_PNT                ;BEGIN OF CONVERTED STAR POINTS
K7B37:  LDX  #M_STAD                ;STAR ADDRESS

JVWSTA_10:
K7B3A:  STX  ST_RAM                 ;MATH RAM POINTER

JVWSTA_14:
K7B3C:  LDA  #MS_PSB2
K7B3E:  JSR  MGOWT_B1
K7B41:  LDD  M_XP                   ;X
K7B44:  CMPD #$0100
K7B48:  LBLE JVWSTA_90              ;B ?TOO CLOSE OR IN BACK? THEN NEW STAR
K7B4C:  CMPD #$0FFF
K7B50:  LBHI JVWSTA_90              ;B ?TOO FAR IN FRONT OR IN BACK?
K7B54:  STD  M_DVD
K7B57:  LDD  M_YPS                  ;?WIDTH IN VIEW ?
K7B5A:  SUBD M_XPS                  ;ELSE BEYOND VIEW
K7B5D:  LBHS JVWSTA_90              ;B ?BEYOND NORMAL VIEW ALSO? THEN GEN NEW STAR
K7B61:  LDD  M_ZPS                  ;?HITE IN VIEW ?
K7B64:  SUBD M_XPS                  ;ELSE OUT OF VIEW
K7B67:  LBHS JVWSTA_90              ;B IF OUT OF NORMAL VIEW ALSO, GEN NEW STAR
K7B6B:  LDD  M_QUO                  ;(PLUS 4.5 CYCLES BEFORE READ)
K7B6E:  STD  M_XP
K7B71:  LDA  #MS_PERS
K7B73:  JSR  MGOWT_B1
K7B76:  CLRB                        ;NO SECTOR YET
K7B77:  LDA  M_ZP
K7B7A:  LSRA
K7B7B:  ROLB                        ;EVERY 256 Y
K7B7C:  LSRA
K7B7D:  ROLB                        ;SIDE FOR +-512.
K7B7E:  LDA  M_YP
K7B81:  LSRA
K7B82:  ROLB                        ;EVERY 256 X
K7B83:  LSRA
K7B84:  ROLB                        ;SIDE FOR +-512.
K7B85:  LDA  #STS_IZQ
K7B87:  MUL
K7B88:  LDX  #ST_QU
K7B8B:  ABX                         ;X-->QUE BLOCK
K7B8C:  LDD  STS_QHD,X
K7B8E:  BNE  JVWSTA_72              ;?FIRST IN THIS QU?
K7B90:  STU  STS_QHD,X              ;POINT TO FIRST STAR
K7B92:  BRA  JVWSTA_73              ;B NO PREVIOUS STAR

JVWSTA_72:
K7B94:  STU  [,X]                   ;INITS FORWARD POINTER IN LAST (OR ONLY) ENTRY

JVWSTA_73:
K7B96:  STU  ,X                     ;TAIL POINTS TO LAST (OR ONLY)ENTRY
K7B98:  LDD  #$0000
K7B9B:  STD  ,U                     ;LAST ENTRY HAS ZERO POINTER
K7B9D:  LDD  M_ZP
K7BA0:  SUBD STS_QCY,X              ;GET RELATIVE OFFSET
K7BA2:  ANDA #$1F
K7BA4:  STD  STS_PY,U               ;Y LONG VECTOR
K7BA6:  LDD  M_YP
K7BA9:  SUBD STS_QCX,X              ;ANOTHER RELATIVE OFFSET
K7BAB:  ANDA #$1F                   ;X LONG VECTOR

JVWSTA_74:
K7BAD:  STD  STS_PX,U
K7BAF:  LDD  M_ZP
K7BB2:  STD  STS_QCY,X              ;NEW Y ABSOLUTE
K7BB4:  LDD  M_YP
K7BB7:  STD  STS_QCX,X              ;NEXT X ABSOLUTE
K7BB9:  LEAU STS_IZP,U              ;NEXT STAR ENTRY
K7BBB:  BRA  JVWSTA_95

JVWSTA_90:
K7BBD:  LDX  ST_RAM
K7BBF:  JSR  STARNW                 ;STARNW: a new star in its place

JVWSTA_95:
K7BC2:  INC  ST_BIC
K7BC4:  LDX  ST_RAM
K7BC6:  LEAX 8,X
K7BC8:  DEC  ST_CNT
K7BCA:  LBNE JVWSTA_10
;DISPLAY QUEUED STARS BY SECTOR LOCATION
K7BCE:  LDX  #ST_QU

JVWSTA_110:          ;LOOP THRU QUEUES
K7BD1:  LDU  STS_QHD,X
K7BD3:  BEQ  JVWSTA_160             ;?STARS IN THIS SECTOR?
K7BD5:  LDD  #VGOFFY&$1FFF
K7BD8:  STD  ,Y++
K7BDA:  LDD  #$0000                 ;OFFSET X
K7BDD:  STD  ,Y++

JVWSTA_120:          ;---LOOP THRU STARS
K7BDF:  LDD  STS_PY,U               ;Y PORTION
K7BE1:  STD  ,Y++
K7BE3:  LDD  STS_PX,U               ;X PORTION
K7BE5:  STD  ,Y++
K7BE7:  LDD  #$B964                 ;JSRL $32C8 in the vector ROM, the dot
K7BEA:  STD  ,Y++                   ;DRAW STAR SHAPE
K7BEC:  LDU  ,U                     ;POINTER TO NEXT STAR
K7BEE:  BNE  JVWSTA_120             ;B LOOP IF MORE STARS
K7BF0:  LDD  #VGCNTR
K7BF3:  STD  ,Y++                   ;CENTER AFTER SECTOR OF STARS

JVWSTA_160:
K7BF5:  LEAX STS_IZQ,X              ;NEXT SECTOR'S QUEUE
K7BF7:  CMPX #ST_QUZ
K7BFA:  BLO  JVWSTA_110
K7BFC:  LDD  MS_TX+M_S1
K7BFF:  STD  MS_TX+M_U1             ;RESTORE POSITION
K7C02:  LDD  MS_TY+M_S1
K7C05:  STD  MS_TY+M_U1
K7C08:  LDD  MS_TZ+M_S1
K7C0B:  STD  MS_TZ+M_U1
K7C0E:  RTS

;------------------------------------------------------------------------------
; JVWSTRG - [note] View ground stars: as JVWSTAR but in green, with no far limit and without moving the M_U1 position;
;   stars out of view are regenerated with STRNWG. Stars are queued by screen sector, then drawn
;   (also: VWSTRG_7EAF)
;   in ESB: in ESB the ground stars are not green: they are white at full brightness, or purple under the same
;   Jedi force test as in JVWSTAR. stars out of view are regenerated with star_new_gnd (K7D50), ESB's STRNWG
;------------------------------------------------------------------------------
JVWSTRG:
VWSTRG_7EAF:
K7C0F:  LDX  #ST_QU
K7C12:  LDD  #$0000

JVWSTR_4:
K7C15:  STD  ,X++                   ;CLEAR OUT STAR QUE
K7C17:  CMPX #ST_QUZ
K7C1A:  BLO  JVWSTR_4
K7C1C:  STA  ST_GNB                 ;NO STAR TO GEN YET
K7C1E:  LDA  jedi_on                ;ESB: the colour follows the Jedi force as in JVWSTAR
K7C21:  BNE  K7C28
K7C23:  LDD  #$6780                 ;off: white, full brightness
K7C26:  BRA  K7C3D
K7C28:  LDD  jedi_time
K7C2B:  CMPD #$0060
K7C2F:  BCC  K7C35
K7C31:  ANDB #$08
K7C33:  BNE  K7C3A
K7C35:  LDD  #$6580                 ;purple
K7C38:  BRA  K7C3D
K7C3A:  LDD  #$6780                 ;white
K7C3D:  STD  ,Y++
K7C3F:  LDD  #MS_STBC
K7C42:  STD  M_BIC
K7C45:  STB  ST_BIC
K7C47:  NEGB
K7C48:  ADDB #MS_STBZ&$FF           ;ZBIC-START= BIC GIVES COUNT OF STARS
K7C4A:  STB  ST_CNT
K7C4C:  LDU  #ST_PNT                ;BEGIN OF CONVERTED STAR POINTS
K7C4F:  LDX  #M_STAD                ;STAR ADDRESS

JVWSTR_10:
K7C52:  STX  ST_RAM                 ;MATH RAM POINTER

JVWSTR_14:
K7C54:  LDA  #MS_PSB2
K7C56:  JSR  MGOWT_B1
K7C59:  LDD  M_XP                   ;X
K7C5C:  CMPD #$0100
K7C60:  LBLE JVWSTR_90              ;B ?TOO CLOSE OR IN BACK? THEN NEW STAR
K7C64:  STD  M_DVD
K7C67:  LDD  M_YPS                  ;?WIDTH IN VIEW ?
K7C6A:  SUBD M_XPS                  ;ELSE BEYOND VIEW
K7C6D:  LBHS JVWSTR_90              ;B ?BEYOND NORMAL VIEW ALSO? THEN GEN NEW STAR
K7C71:  LDD  M_ZPS                  ;CHECK HITE ALSO
K7C74:  SUBD M_XPS
K7C77:  LBHS JVWSTR_90
K7C7B:  LDD  M_QUO                  ;(PLUS 4.5 CYCLES BEFORE READ)
K7C7E:  STD  M_XP
K7C81:  LDA  #MS_PERS
K7C83:  JSR  MGOWT_B1
K7C86:  CLRB                        ;NO SECTOR YET
K7C87:  LDA  M_ZP
K7C8A:  LSRA
K7C8B:  ROLB                        ;EVERY 256 Y
K7C8C:  LSRA
K7C8D:  ROLB                        ;SIDE FOR +-512.
K7C8E:  LDA  M_YP
K7C91:  LSRA
K7C92:  ROLB                        ;EVERY 256 X
K7C93:  LSRA
K7C94:  ROLB                        ;SIDE FOR +-512.
K7C95:  LDA  #STS_IZQ
K7C97:  MUL
K7C98:  LDX  #ST_QU
K7C9B:  ABX                         ;X-->QUE BLOCK
K7C9C:  LDD  STS_QHD,X
K7C9E:  BNE  JVWSTR_72              ;?FIRST IN THIS QU?
K7CA0:  STU  STS_QHD,X              ;POINT TO FIRST STAR
K7CA2:  BRA  JVWSTR_73              ;B NO PREVIOUS STAR

JVWSTR_72:
K7CA4:  STU  [,X]                   ;INITS FORWARD POINTER IN LAST (OR ONLY) ENTRY

JVWSTR_73:
K7CA6:  STU  ,X                     ;TAIL POINTS TO LAST (OR ONLY)ENTRY
K7CA8:  LDD  #$0000
K7CAB:  STD  ,U                     ;LAST ENTRY HAS ZERO POINTER
K7CAD:  LDD  M_ZP
K7CB0:  SUBD STS_QCY,X              ;GET RELATIVE OFFSET
K7CB2:  ANDA #$1F
K7CB4:  STD  STS_PY,U               ;Y LONG VECTOR
K7CB6:  LDD  M_YP
K7CB9:  SUBD STS_QCX,X              ;ANOTHER RELATIVE OFFSET
K7CBB:  ANDA #$1F                   ;X LONG VECTOR

JVWSTR_74:
K7CBD:  STD  STS_PX,U
K7CBF:  LDD  M_ZP
K7CC2:  STD  STS_QCY,X              ;NEW Y ABSOLUTE
K7CC4:  LDD  M_YP
K7CC7:  STD  STS_QCX,X              ;NEXT X ABSOLUTE
K7CC9:  LEAU STS_IZP,U              ;NEXT STAR ENTRY
K7CCB:  BRA  JVWSTR_95

JVWSTR_90:
K7CCD:  LDX  ST_RAM
K7CCF:  JSR  star_new_gnd           ;star_new_gnd: a new ground star in its place

JVWSTR_95:
K7CD2:  INC  ST_BIC
K7CD4:  LDX  ST_RAM
K7CD6:  LEAX 8,X
K7CD8:  DEC  ST_CNT
K7CDA:  LBNE JVWSTR_10
;DISPLAY QUEUED STARS BY SECTOR LOCATION
K7CDE:  LDX  #ST_QU

JVWSTR_110:          ;LOOP THRU QUEUES
K7CE1:  LDU  STS_QHD,X
K7CE3:  BEQ  JVWSTR_160             ;?STARS IN THIS SECTOR?
K7CE5:  LDD  #VGOFFY                ;GROUND HORIZON DROPPED(INCLUDES VGOFFY)
K7CE8:  ANDA #$1F
K7CEA:  STD  ,Y++
K7CEC:  LDD  #$0000                 ;OFFSET X
K7CEF:  STD  ,Y++

JVWSTR_120:          ;---LOOP THRU STARS
K7CF1:  LDD  STS_PY,U               ;Y PORTION
K7CF3:  STD  ,Y++
K7CF5:  LDD  STS_PX,U               ;X PORTION
K7CF7:  STD  ,Y++
K7CF9:  LDD  #$B964                 ;JSRL $32C8 in the vector ROM, the dot
K7CFC:  STD  ,Y++                   ;DRAW STAR SHAPE
K7CFE:  LDU  ,U                     ;POINTER TO NEXT STAR
K7D00:  BNE  JVWSTR_120             ;B LOOP IF MORE STARS
K7D02:  LDD  #VGCNTR
K7D05:  STD  ,Y++                   ;CENTER AFTER SECTOR OF STARS

JVWSTR_160:
K7D07:  LEAX STS_IZQ,X              ;NEXT SECTOR'S QUEUE
K7D09:  CMPX #ST_QUZ
K7D0C:  BLO  JVWSTR_110
K7D0E:  RTS

;------------------------------------------------------------------------------
; STARNW - Star Wars' STARNW, the same instruction for instruction (the matcher missed it): new star at math RAM
;   X. random visual x, y, z from the saved random bytes (K6511, Star Wars' RND8), y and z with the sign opposite
;   to the current M_YPH and M_ZPH, converted to universe coordinates by MS_S1UN with ST_BIC as the block index
;   and stored at 0, 2 and 4 of X. JVWSTAR calls it for a star that has left the view
;------------------------------------------------------------------------------
STARNW:
K7D0F:  JSR  rnd_set_b1             ;K6511: shift the three saved random bytes and read a new one
K7D12:  LDA  RND_S1
K7D14:  ANDA #$1F
K7D16:  LDB  RND_S2
K7D18:  STD  ,X
K7D1A:  MUL
K7D1B:  TST  M_YPH                  ;B SELECT SIGN OPPOSITE OF CURRENT
K7D1E:  BMI  STARNW_20
K7D20:  NEGA

STARNW_20:
K7D21:  STD  2,X
K7D23:  LDA  RND_S1
K7D25:  ANDA #$1F
K7D27:  LDB  RND_S3
K7D29:  MUL
K7D2A:  TST  M_ZPH
K7D2D:  BMI  STARNW_30
K7D2F:  NEGA

STARNW_30:
K7D30:  STD  4,X
K7D32:  LDA  ST_BIC                 ;REDO CURRENT STAR
K7D34:  STA  M_BICL
K7D37:  LDA  #MS_S1UN               ;DO POST ADD
K7D39:  JSR  MGOWT_B1
K7D3C:  LDD  M_XP                   ;STORE UNIVERSE COORDINATES
K7D3F:  STD  ,X
K7D41:  LDD  M_YP
K7D44:  STD  2,X
K7D46:  LDD  M_ZP
K7D49:  ANDA #$FF
K7D4B:  ANDB #$FF
K7D4D:  STD  4,X
;RESTORE MATH BOX
;BIC ALREADY UPDATED BY PREVIOUS OP
K7D4F:  RTS

;------------------------------------------------------------------------------
; star_new_gnd - ESB's version of Star Wars' STRNWG: new ground star at math RAM X, called by JVWSTRG for a star
;   that has left the view. visual x is 15 random bits, y the product of two of the saved random bytes with the
;   sign opposite to the current M_YPH, z the same product. MS_S1UN with ST_BIC as the block index converts them
;   to universe coordinates, of which x and y are stored and z is set to 0
;------------------------------------------------------------------------------
star_new_gnd:
K7D50:  JSR  rnd_set_b1
K7D53:  LDA  RND_S1                 ;x: 15 random bits
K7D55:  ANDA #$7F
K7D57:  LDB  RND_S2
K7D59:  STD  ,X
K7D5B:  MUL                         ;y: the product of the two bytes
K7D5C:  TST  M_YPH                  ;B SELECT SIGN OPPOSITE OF CURRENT
K7D5F:  BMI  K7D62
K7D61:  NEGA
K7D62:  STD  2,X
K7D64:  LDA  RND_S1                 ;z: the same product once more
K7D66:  ANDA #$7F
K7D68:  LDB  RND_S2
K7D6A:  MUL
K7D6B:  STD  4,X
K7D6D:  LDA  ST_BIC                 ;REDO CURRENT STAR
K7D6F:  STA  M_BICL
K7D72:  LDA  #MS_S1UN               ;DO POST ADD
K7D74:  JSR  MGOWT_B1
K7D77:  LDD  M_XP                   ;STORE UNIVERSE COORDINATES
K7D7A:  STD  ,X
K7D7C:  LDD  M_YP
K7D7F:  STD  2,X
K7D81:  LDD  #$0000                 ;on the ground
K7D84:  STD  4,X
K7D86:  RTS
K7D87:  .byte $02, $BB, $5A, $30, $5F, $EE, $05, $A8 ;8 bytes that no code was found to read
K7D8F:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;ROM fill, 466 bytes of $FF
K7D9F:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7DAF:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7DBF:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7DCF:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7DDF:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7DEF:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7DFF:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7E0F:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7E1F:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7E2F:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7E3F:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7E4F:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7E5F:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7E6F:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7E7F:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7E8F:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7E9F:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7EAF:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7EBF:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7ECF:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7EDF:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7EEF:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7EFF:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7F0F:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7F1F:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7F2F:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7F3F:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7F4F:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7F5F:  .byte $FF, $FF

FILL0_B1:
K7F61:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;.REPT 73  FILL WITH FF'S
K7F69:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7F71:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7F79:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7F81:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7F89:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7F91:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7F99:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7FA1:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7FA9:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7FB1:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7FB9:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7FC1:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7FC9:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
K7FD1:  .byte $FF, $FF, $FF

CPYRT0_B1:
K7FD4:  .byte $43, $4F, $50, $59, $52, $49, $47, $48 ;.ASCII /COPYRIGHT 1983 ATARI/
K7FDC:  .byte $54, $20, $31, $39, $38, $34, $20, $41
K7FE4:  .byte $54, $41, $52, $49, $B1, $B0, $AD, $B2
K7FEC:  .byte $DF, $BE, $A9, $BA, $B3, $B3, $BE, $AD
K7FF4:  .byte $DF, $BB, $B6, $BB, $DF, $B6, $AB, $DF
K7FFC:  .byte $AB, $B0, $B0, $96

.org $A000
KA000:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;ROM fill, 19 bytes of $FF
KA010:  .byte $FF, $FF, $FF
KA013:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;ROM fill, 890 bytes of $FF
KA023:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA033:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA043:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA053:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA063:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA073:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA083:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA093:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA0A3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA0B3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA0C3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA0D3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA0E3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA0F3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA103:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA113:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA123:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA133:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA143:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA153:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA163:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA173:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA183:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA193:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA1A3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA1B3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA1C3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA1D3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA1E3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA1F3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA203:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA213:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA223:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA233:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA243:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA253:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA263:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA273:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA283:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA293:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA2A3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA2B3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA2C3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA2D3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA2E3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA2F3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA303:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA313:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA323:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA333:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA343:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA353:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA363:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA373:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA383:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF

FILL0_B1_2:
KA38D:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;.REPT 73  FILL WITH FF'S
KA395:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA39D:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA3A5:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA3AD:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA3B5:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA3BD:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA3C5:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA3CD:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA3D5:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA3DD:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA3E5:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA3ED:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA3F5:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KA3FD:  .byte $FF, $FF, $FF

CPYRT0_B1_2:
KA400:  .byte $43, $4F, $50, $59, $52, $49, $47, $48 ;.ASCII /COPYRIGHT 1983 ATARI/
KA408:  .byte $54, $20, $31, $39, $38, $34, $20, $41
KA410:  .byte $54, $41, $52, $49, $1B, $2D, $7C, $DC
KA418:  .byte $D2, $4F, $57, $45, $20, $47, $4F, $54
KA420:  .byte $20, $57, $49, $52, $45, $44

TD0PC:
TPNT:
KA426:  .word $0000, $0000, $0000   ;object 0 point 0: 0, 0, 0
KA42C:  .word $FF7E, $FF30, $00EA   ;object 0 point 1: -130, -208, 234
KA432:  .word $0068, $FF30, $00EA   ;object 0 point 2: 104, -208, 234
KA438:  .word $00B6, $FF30, $0000   ;object 0 point 3: 182, -208, 0
KA43E:  .word $0068, $FF30, $FF16   ;object 0 point 4: 104, -208, -234
KA444:  .word $FF7E, $FF30, $FF16   ;object 0 point 5: -130, -208, -234
KA44A:  .word $FF30, $FF30, $0000   ;object 0 point 6: -208, -208, 0
KA450:  .word $FFE6, $FF30, $001A   ;object 0 point 7: -26, -208, 26
KA456:  .word $0000, $FF30, $001A   ;object 0 point 8: 0, -208, 26
KA45C:  .word $000D, $FF30, $0000   ;object 0 point 9: 13, -208, 0
KA462:  .word $0000, $FF30, $FFE6   ;object 0 point 10: 0, -208, -26
KA468:  .word $FFE6, $FF30, $FFE6   ;object 0 point 11: -26, -208, -26
KA46E:  .word $FFD9, $FF30, $0000   ;object 0 point 12: -39, -208, 0
KA474:  .word $FF7E, $00D0, $00EA   ;object 0 point 13: -130, 208, 234
KA47A:  .word $0068, $00D0, $00EA   ;object 0 point 14: 104, 208, 234
KA480:  .word $00B6, $00D0, $0000   ;object 0 point 15: 182, 208, 0
KA486:  .word $0068, $00D0, $FF16   ;object 0 point 16: 104, 208, -234
KA48C:  .word $FF7E, $00D0, $FF16   ;object 0 point 17: -130, 208, -234
KA492:  .word $FF30, $00D0, $0000   ;object 0 point 18: -208, 208, 0
KA498:  .word $FFE6, $00D0, $001A   ;object 0 point 19: -26, 208, 26
KA49E:  .word $0000, $00D0, $001A   ;object 0 point 20: 0, 208, 26
KA4A4:  .word $000D, $00D0, $0000   ;object 0 point 21: 13, 208, 0
KA4AA:  .word $0000, $00D0, $FFE6   ;object 0 point 22: 0, 208, -26
KA4B0:  .word $FFE6, $00D0, $FFE6   ;object 0 point 23: -26, 208, -26
KA4B6:  .word $FFD9, $00D0, $0000   ;object 0 point 24: -39, 208, 0
KA4BC:  .word $FFE6, $FFB2, $001A   ;object 0 point 25: -26, -78, 26
KA4C2:  .word $0000, $FFB2, $001A   ;object 0 point 26: 0, -78, 26
KA4C8:  .word $000D, $FFB2, $0000   ;object 0 point 27: 13, -78, 0
KA4CE:  .word $0000, $FFB2, $FFE6   ;object 0 point 28: 0, -78, -26
KA4D4:  .word $FFE6, $FFB2, $FFE6   ;object 0 point 29: -26, -78, -26
KA4DA:  .word $FFD9, $FFB2, $0000   ;object 0 point 30: -39, -78, 0
KA4E0:  .word $FFE6, $004E, $001A   ;object 0 point 31: -26, 78, 26
KA4E6:  .word $0000, $004E, $001A   ;object 0 point 32: 0, 78, 26
KA4EC:  .word $000D, $004E, $0000   ;object 0 point 33: 13, 78, 0
KA4F2:  .word $0000, $004E, $FFE6   ;object 0 point 34: 0, 78, -26
KA4F8:  .word $FFE6, $004E, $FFE6   ;object 0 point 35: -26, 78, -26
KA4FE:  .word $FFD9, $004E, $0000   ;object 0 point 36: -39, 78, 0
KA504:  .word $FFCC, $FFE6, $004E   ;object 0 point 37: -52, -26, 78
KA50A:  .word $001A, $FFE6, $004E   ;object 0 point 38: 26, -26, 78
KA510:  .word $004E, $FFE6, $0027   ;object 0 point 39: 78, -26, 39
KA516:  .word $004E, $FFCC, $0000   ;object 0 point 40: 78, -52, 0
KA51C:  .word $004E, $FFE6, $FFD9   ;object 0 point 41: 78, -26, -39
KA522:  .word $001A, $FFE6, $FFB2   ;object 0 point 42: 26, -26, -78
KA528:  .word $FFCC, $FFE6, $FFB2   ;object 0 point 43: -52, -26, -78
KA52E:  .word $FF98, $FFE6, $0000   ;object 0 point 44: -104, -26, 0
KA534:  .word $FFCC, $001A, $004E   ;object 0 point 45: -52, 26, 78
KA53A:  .word $001A, $001A, $004E   ;object 0 point 46: 26, 26, 78
KA540:  .word $004E, $001A, $0027   ;object 0 point 47: 78, 26, 39
KA546:  .word $004E, $0034, $0000   ;object 0 point 48: 78, 52, 0
KA54C:  .word $004E, $001A, $FFD9   ;object 0 point 49: 78, 26, -39
KA552:  .word $001A, $001A, $FFB2   ;object 0 point 50: 26, 26, -78
KA558:  .word $FFCC, $001A, $FFB2   ;object 0 point 51: -52, 26, -78
KA55E:  .word $FF98, $001A, $0000   ;object 0 point 52: -104, 26, 0

TD1PC:
KA564:  .word $0000, $0000, $0000   ;object 1 point 0: 0, 0, 0
KA56A:  .word $FF7E, $FFE6, $00EA   ;object 1 point 1: -130, -26, 234
KA570:  .word $0068, $FFE6, $00EA   ;object 1 point 2: 104, -26, 234
KA576:  .word $00B6, $FFE6, $0000   ;object 1 point 3: 182, -26, 0
KA57C:  .word $0068, $FFE6, $FF16   ;object 1 point 4: 104, -26, -234
KA582:  .word $FF7E, $FFE6, $FF16   ;object 1 point 5: -130, -26, -234
KA588:  .word $FF30, $FFE6, $0000   ;object 1 point 6: -208, -26, 0
KA58E:  .word $FFE6, $FFE6, $001A   ;object 1 point 7: -26, -26, 26
KA594:  .word $0000, $FFE6, $001A   ;object 1 point 8: 0, -26, 26
KA59A:  .word $000D, $FFE6, $0000   ;object 1 point 9: 13, -26, 0
KA5A0:  .word $0000, $FFE6, $FFE6   ;object 1 point 10: 0, -26, -26
KA5A6:  .word $FFE6, $FFE6, $FFE6   ;object 1 point 11: -26, -26, -26
KA5AC:  .word $FFD9, $FFE6, $0000   ;object 1 point 12: -39, -26, 0
KA5B2:  .word $FFE6, $0082, $001A   ;object 1 point 13: -26, 130, 26
KA5B8:  .word $0000, $0082, $001A   ;object 1 point 14: 0, 130, 26
KA5BE:  .word $000D, $0082, $0000   ;object 1 point 15: 13, 130, 0
KA5C4:  .word $0000, $0082, $FFE6   ;object 1 point 16: 0, 130, -26
KA5CA:  .word $FFE6, $0082, $FFE6   ;object 1 point 17: -26, 130, -26
KA5D0:  .word $FFD9, $0082, $0000   ;object 1 point 18: -39, 130, 0

TD2PC:
KA5D6:  .word $0000, $0000, $0000   ;object 2 point 0: 0, 0, 0
KA5DC:  .word $FF7E, $00EA, $001A   ;object 2 point 1: -130, 234, 26
KA5E2:  .word $0068, $00EA, $001A   ;object 2 point 2: 104, 234, 26
KA5E8:  .word $00B6, $0000, $001A   ;object 2 point 3: 182, 0, 26
KA5EE:  .word $0068, $FF16, $001A   ;object 2 point 4: 104, -234, 26
KA5F4:  .word $FF7E, $FF16, $001A   ;object 2 point 5: -130, -234, 26
KA5FA:  .word $FF30, $0000, $001A   ;object 2 point 6: -208, 0, 26
KA600:  .word $FFE6, $001A, $001A   ;object 2 point 7: -26, 26, 26
KA606:  .word $0000, $001A, $001A   ;object 2 point 8: 0, 26, 26
KA60C:  .word $000D, $0000, $001A   ;object 2 point 9: 13, 0, 26
KA612:  .word $0000, $FFE6, $001A   ;object 2 point 10: 0, -26, 26
KA618:  .word $FFE6, $FFE6, $001A   ;object 2 point 11: -26, -26, 26
KA61E:  .word $FFD9, $0000, $001A   ;object 2 point 12: -39, 0, 26
KA624:  .word $FFE6, $001A, $FF7E   ;object 2 point 13: -26, 26, -130
KA62A:  .word $0000, $001A, $FF7E   ;object 2 point 14: 0, 26, -130
KA630:  .word $000D, $0000, $FF7E   ;object 2 point 15: 13, 0, -130
KA636:  .word $0000, $FFE6, $FF7E   ;object 2 point 16: 0, -26, -130
KA63C:  .word $FFE6, $FFE6, $FF7E   ;object 2 point 17: -26, -26, -130
KA642:  .word $FFD9, $0000, $FF7E   ;object 2 point 18: -39, 0, -130

TD3PC:
KA648:  .word $0000, $0000, $0000   ;object 3 point 0: 0, 0, 0
KA64E:  .word $FFE6, $FFB2, $001A   ;object 3 point 1: -26, -78, 26
KA654:  .word $0000, $FFB2, $001A   ;object 3 point 2: 0, -78, 26
KA65A:  .word $000D, $FFB2, $0000   ;object 3 point 3: 13, -78, 0
KA660:  .word $0000, $FFB2, $FFE6   ;object 3 point 4: 0, -78, -26
KA666:  .word $FFE6, $FFB2, $FFE6   ;object 3 point 5: -26, -78, -26
KA66C:  .word $FFD9, $FFB2, $0000   ;object 3 point 6: -39, -78, 0
KA672:  .word $FFE6, $004E, $001A   ;object 3 point 7: -26, 78, 26
KA678:  .word $0000, $004E, $001A   ;object 3 point 8: 0, 78, 26
KA67E:  .word $000D, $004E, $0000   ;object 3 point 9: 13, 78, 0
KA684:  .word $0000, $004E, $FFE6   ;object 3 point 10: 0, 78, -26
KA68A:  .word $FFE6, $004E, $FFE6   ;object 3 point 11: -26, 78, -26
KA690:  .word $FFD9, $004E, $0000   ;object 3 point 12: -39, 78, 0
KA696:  .word $FFCC, $FFE6, $004E   ;object 3 point 13: -52, -26, 78
KA69C:  .word $001A, $FFE6, $004E   ;object 3 point 14: 26, -26, 78
KA6A2:  .word $004E, $FFE6, $0027   ;object 3 point 15: 78, -26, 39
KA6A8:  .word $004E, $FFCC, $0000   ;object 3 point 16: 78, -52, 0
KA6AE:  .word $004E, $FFE6, $FFD9   ;object 3 point 17: 78, -26, -39
KA6B4:  .word $001A, $FFE6, $FFB2   ;object 3 point 18: 26, -26, -78
KA6BA:  .word $FFCC, $FFE6, $FFB2   ;object 3 point 19: -52, -26, -78
KA6C0:  .word $FF98, $FFE6, $0000   ;object 3 point 20: -104, -26, 0
KA6C6:  .word $FFCC, $001A, $004E   ;object 3 point 21: -52, 26, 78
KA6CC:  .word $001A, $001A, $004E   ;object 3 point 22: 26, 26, 78
KA6D2:  .word $004E, $001A, $0027   ;object 3 point 23: 78, 26, 39
KA6D8:  .word $004E, $0034, $0000   ;object 3 point 24: 78, 52, 0
KA6DE:  .word $004E, $001A, $FFD9   ;object 3 point 25: 78, 26, -39
KA6E4:  .word $001A, $001A, $FFB2   ;object 3 point 26: 26, 26, -78
KA6EA:  .word $FFCC, $001A, $FFB2   ;object 3 point 27: -52, 26, -78
KA6F0:  .word $FF98, $001A, $0000   ;object 3 point 28: -104, 26, 0
KA6F6:  .word $0014, $0000, $0000   ;object 4 point 0: 20, 0, 0
KA6FC:  .word $000A, $0014, $0000   ;object 4 point 1: 10, 20, 0
KA702:  .word $FFF6, $0014, $0000   ;object 4 point 2: -10, 20, 0
KA708:  .word $FFEC, $0000, $0000   ;object 4 point 3: -20, 0, 0
KA70E:  .word $FFF6, $FFEC, $0000   ;object 4 point 4: -10, -20, 0
KA714:  .word $000A, $FFEC, $0000   ;object 4 point 5: 10, -20, 0
KA71A:  .word $003C, $0000, $FFE2   ;object 4 point 6: 60, 0, -30
KA720:  .word $001E, $003C, $FFE2   ;object 4 point 7: 30, 60, -30
KA726:  .word $FFE2, $003C, $FFE2   ;object 4 point 8: -30, 60, -30
KA72C:  .word $FFC4, $0000, $FFE2   ;object 4 point 9: -60, 0, -30
KA732:  .word $FFE2, $FFC4, $FFE2   ;object 4 point 10: -30, -60, -30
KA738:  .word $001E, $FFC4, $FFE2   ;object 4 point 11: 30, -60, -30
KA73E:  .word $0014, $0000, $FFC4   ;object 4 point 12: 20, 0, -60
KA744:  .word $000A, $0014, $FFC4   ;object 4 point 13: 10, 20, -60
KA74A:  .word $FFF6, $0014, $FFC4   ;object 4 point 14: -10, 20, -60
KA750:  .word $FFEC, $0000, $FFC4   ;object 4 point 15: -20, 0, -60
KA756:  .word $FFF6, $FFEC, $FFC4   ;object 4 point 16: -10, -20, -60
KA75C:  .word $000A, $FFEC, $FFC4   ;object 4 point 17: 10, -20, -60
KA762:  .word $0000, $0000, $FFF1   ;object 4 point 18: 0, 0, -15
KA768:  .word $0014, $0000, $0000   ;object 5 point 0: 20, 0, 0
KA76E:  .word $000A, $0014, $0000   ;object 5 point 1: 10, 20, 0
KA774:  .word $FFF6, $0014, $0000   ;object 5 point 2: -10, 20, 0
KA77A:  .word $FFEC, $0000, $0000   ;object 5 point 3: -20, 0, 0
KA780:  .word $FFF6, $FFEC, $0000   ;object 5 point 4: -10, -20, 0
KA786:  .word $000A, $FFEC, $0000   ;object 5 point 5: 10, -20, 0
KA78C:  .word $0014, $0000, $0000   ;object 6/7 point 0: 20, 0, 0
KA792:  .word $000A, $0014, $0000   ;object 6/7 point 1: 10, 20, 0
KA798:  .word $FFF6, $0014, $0000   ;object 6/7 point 2: -10, 20, 0
KA79E:  .word $FFEC, $0000, $0000   ;object 6/7 point 3: -20, 0, 0
KA7A4:  .word $FFF6, $FFEC, $0000   ;object 6/7 point 4: -10, -20, 0
KA7AA:  .word $000A, $FFEC, $0000   ;object 6/7 point 5: 10, -20, 0
KA7B0:  .word $003C, $0000, $0016   ;object 6/7 point 6: 60, 0, 22
KA7B6:  .word $000A, $003C, $0016   ;object 6/7 point 7: 10, 60, 22
KA7BC:  .word $FFD3, $0028, $0016   ;object 6/7 point 8: -45, 40, 22
KA7C2:  .word $FFC4, $0000, $0016   ;object 6/7 point 9: -60, 0, 22
KA7C8:  .word $FFD3, $FFD8, $0016   ;object 6/7 point 10: -45, -40, 22
KA7CE:  .word $000A, $FFC4, $0016   ;object 6/7 point 11: 10, -60, 22
KA7D4:  .word $0014, $0000, $002D   ;object 6/7 point 12: 20, 0, 45
KA7DA:  .word $000A, $0014, $002D   ;object 6/7 point 13: 10, 20, 45
KA7E0:  .word $FFF6, $0014, $002D   ;object 6/7 point 14: -10, 20, 45
KA7E6:  .word $FFEC, $0000, $002D   ;object 6/7 point 15: -20, 0, 45
KA7EC:  .word $FFF6, $FFEC, $002D   ;object 6/7 point 16: -10, -20, 45
KA7F2:  .word $000A, $FFEC, $002D   ;object 6/7 point 17: 10, -20, 45
KA7F8:  .word $0023, $0000, $0025   ;object 6/7 point 18: 35, 0, 37
KA7FE:  .word $0000, $0000, $0004   ;object 6/7 point 19: 0, 0, 4
KA804:  .word $003C, $0000, $0000   ;object 8 point 0: 60, 0, 0
KA80A:  .word $001E, $003C, $0000   ;object 8 point 1: 30, 60, 0
KA810:  .word $FFE2, $003C, $0000   ;object 8 point 2: -30, 60, 0
KA816:  .word $FFC4, $0000, $0000   ;object 8 point 3: -60, 0, 0
KA81C:  .word $FFE2, $FFC4, $0000   ;object 8 point 4: -30, -60, 0
KA822:  .word $001E, $FFC4, $0000   ;object 8 point 5: 30, -60, 0
KA828:  .word $000E, $0000, $FFC4   ;object 9 point 0: 14, 0, -60
KA82E:  .word $0014, $0014, $FF63   ;object 9 point 1: 20, 20, -157
KA834:  .word $0028, $FFD8, $FF45   ;object 9 point 2: 40, -40, -187
KA83A:  .word $FFEC, $0000, $FF1F   ;object 9 point 3: -20, 0, -225
KA840:  .word $FFF2, $0000, $FFC4   ;object 10 point 0: -14, 0, -60
KA846:  .word $FFEC, $FFEC, $FF4C   ;object 10 point 1: -20, -20, -180
KA84C:  .word $FFD8, $0028, $FF1F   ;object 10 point 2: -40, 40, -225
KA852:  .word $0014, $0000, $FED4   ;object 10 point 3: 20, 0, -300
KA858:  .word $0008, $000E, $FFC4   ;object 11 point 0: 8, 14, -60
KA85E:  .word $000A, $000A, $FFA6   ;object 11 point 1: 10, 10, -90
KA864:  .word $0014, $0014, $FF79   ;object 11 point 2: 20, 20, -135
KA86A:  .word $001E, $001E, $FF4C   ;object 11 point 3: 30, 30, -180
KA870:  .word $FFF8, $000E, $FFC4   ;object 12 point 0: -8, 14, -60
KA876:  .word $FFF6, $FFF6, $FFA6   ;object 12 point 1: -10, -10, -90
KA87C:  .word $FFEC, $FFEC, $FF88   ;object 12 point 2: -20, -20, -120
KA882:  .word $FFE2, $FFE2, $FF6A   ;object 12 point 3: -30, -30, -150
KA888:  .word $0008, $FFF2, $FFC4   ;object 13 point 0: 8, -14, -60
KA88E:  .word $000A, $FFEC, $FFB5   ;object 13 point 1: 10, -20, -75
KA894:  .word $000A, $000A, $FFA6   ;object 13 point 2: 10, 10, -90
KA89A:  .word $0014, $FFF6, $FF97   ;object 13 point 3: 20, -10, -105
KA8A0:  .word $FFF8, $FFF2, $FFC4   ;object 14 point 0: -8, -14, -60
KA8A6:  .word $FFE2, $0014, $FF88   ;object 14 point 1: -30, 20, -120
KA8AC:  .word $FFD8, $0000, $FF6A   ;object 14 point 2: -40, 0, -150
KA8B2:  .word $FFF6, $FFEC, $FF4C   ;object 14 point 3: -10, -20, -180
KA8B8:  .word $0000, $0000, $FFC4   ;object 15 point 0: 0, 0, -60
KA8BE:  .word $0000, $000A, $FF90   ;object 15 point 1: 0, 10, -112
KA8C4:  .word $000A, $0000, $FF5B   ;object 15 point 2: 10, 0, -165
KA8CA:  .word $000A, $000A, $FF2E   ;object 15 point 3: 10, 10, -210
KA8D0:  .word $0000, $0000, $FFC4   ;object 16 point 0: 0, 0, -60
KA8D6:  .word $FFE2, $FFEC, $FF85   ;object 16 point 1: -30, -20, -123
KA8DC:  .word $FFD8, $FFE2, $FF45   ;object 16 point 2: -40, -30, -187
KA8E2:  .word $FFEC, $FFF6, $FF01   ;object 16 point 3: -20, -10, -255
KA8E8:  .word $00DC, $0032, $FF97   ;object 17/18 point 0: 220, 50, -105
KA8EE:  .word $00DC, $FFCE, $FF97   ;object 17/18 point 1: 220, -50, -105
KA8F4:  .word $008C, $003C, $FF97   ;object 17/18 point 2: 140, 60, -105
KA8FA:  .word $008C, $FFC4, $FF97   ;object 17/18 point 3: 140, -60, -105
KA900:  .word $0064, $0050, $FFF1   ;object 17/18 point 4: 100, 80, -15
KA906:  .word $0064, $FFB0, $FFF1   ;object 17/18 point 5: 100, -80, -15
KA90C:  .word $FF9C, $005A, $000F   ;object 17/18 point 6: -100, 90, 15
KA912:  .word $FF9C, $FFA6, $000F   ;object 17/18 point 7: -100, -90, 15
KA918:  .word $FFC4, $006E, $013B   ;object 17/18 point 8: -60, 110, 315
KA91E:  .word $FFC4, $FF92, $013B   ;object 17/18 point 9: -60, -110, 315
KA924:  .word $00B4, $0046, $00E1   ;object 17/18 point 10: 180, 70, 225
KA92A:  .word $00B4, $FFBA, $00E1   ;object 17/18 point 11: 180, -70, 225
KA930:  .word $00B4, $0032, $00E1   ;object 17/18 point 12: 180, 50, 225
KA936:  .word $00B4, $FFCE, $00E1   ;object 17/18 point 13: 180, -50, 225
KA93C:  .word $00BE, $0028, $0087   ;object 17/18 point 14: 190, 40, 135
KA942:  .word $00BE, $FFD8, $0087   ;object 17/18 point 15: 190, -40, 135
KA948:  .word $000A, $0000, $0096   ;object 17/18 point 16: 10, 0, 150
KA94E:  .word $006E, $0000, $003C   ;object 17/18 point 17: 110, 0, 60
KA954:  .word $0000, $0000, $0000   ;object 19 point 0: 0, 0, 0
KA95A:  .word $FFC4, $006E, $013B   ;object 20 point 0: -60, 110, 315
KA960:  .word $FF9C, $005A, $000F   ;object 20 point 1: -100, 90, 15
KA966:  .word $0064, $0050, $FFF1   ;object 20 point 2: 100, 80, -15
KA96C:  .word $008C, $003C, $FF97   ;object 20 point 3: 140, 60, -105
KA972:  .word $00DC, $0032, $FF97   ;object 20 point 4: 220, 50, -105
KA978:  .word $00DC, $0000, $FF97   ;object 20 point 5: 220, 0, -105
KA97E:  .word $00BE, $0028, $0087   ;object 20 point 6: 190, 40, 135
KA984:  .word $00BE, $0000, $0087   ;object 20 point 7: 190, 0, 135
KA98A:  .word $FFC4, $006E, $013B   ;object 21 point 0: -60, 110, 315
KA990:  .word $FFC4, $FF92, $013B   ;object 21 point 1: -60, -110, 315
KA996:  .word $00B4, $0046, $00E1   ;object 21 point 2: 180, 70, 225
KA99C:  .word $00B4, $FFBA, $00E1   ;object 21 point 3: 180, -70, 225
KA9A2:  .word $00BE, $0028, $0087   ;object 21 point 4: 190, 40, 135
KA9A8:  .word $00BE, $FFD8, $0087   ;object 21 point 5: 190, -40, 135
KA9AE:  .word $FFC4, $FF92, $013B   ;object 22 point 0: -60, -110, 315
KA9B4:  .word $FF9C, $FFA6, $000F   ;object 22 point 1: -100, -90, 15
KA9BA:  .word $0064, $FFB0, $FFF1   ;object 22 point 2: 100, -80, -15
KA9C0:  .word $008C, $FFC4, $FF97   ;object 22 point 3: 140, -60, -105
KA9C6:  .word $00DC, $FFCE, $FF97   ;object 22 point 4: 220, -50, -105
KA9CC:  .word $00DC, $0000, $FF97   ;object 22 point 5: 220, 0, -105
KA9D2:  .word $00BE, $FFD8, $0087   ;object 22 point 6: 190, -40, 135
KA9D8:  .word $00BE, $0000, $0087   ;object 22 point 7: 190, 0, 135
KA9DE:  .word $FA24, $0271, $0000   ;object 23 point 0: -1500, 625, 0
KA9E4:  .word $FA24, $FD8F, $0000   ;object 23 point 1: -1500, -625, 0
KA9EA:  .word $FE0C, $02EE, $0000   ;object 23 point 2: -500, 750, 0
KA9F0:  .word $FE0C, $FD12, $0000   ;object 23 point 3: -500, -750, 0
KA9F6:  .word $01F4, $02EE, $0000   ;object 23 point 4: 500, 750, 0
KA9FC:  .word $01F4, $FD12, $0000   ;object 23 point 5: 500, -750, 0
KAA02:  .word $05DC, $0271, $0177   ;object 23 point 6: 1500, 625, 375
KAA08:  .word $05DC, $FD8F, $0177   ;object 23 point 7: 1500, -625, 375
KAA0E:  .word $05DC, $01F4, $0753   ;object 23 point 8: 1500, 500, 1875
KAA14:  .word $05DC, $FE0C, $0753   ;object 23 point 9: 1500, -500, 1875
KAA1A:  .word $01F4, $0271, $0A41   ;object 23 point 10: 500, 625, 2625
KAA20:  .word $01F4, $FD8F, $0A41   ;object 23 point 11: 500, -625, 2625
KAA26:  .word $FE0C, $0271, $0A41   ;object 23 point 12: -500, 625, 2625
KAA2C:  .word $FE0C, $FD8F, $0A41   ;object 23 point 13: -500, -625, 2625
KAA32:  .word $FA24, $0271, $08CA   ;object 23 point 14: -1500, 625, 2250
KAA38:  .word $FA24, $FD8F, $08CA   ;object 23 point 15: -1500, -625, 2250
KAA3E:  .word $05DC, $0271, $0177   ;object 23 point 16: 1500, 625, 375
KAA44:  .word $05DC, $FD8F, $0177   ;object 23 point 17: 1500, -625, 375
KAA4A:  .word $05DC, $023F, $03CF   ;object 23 point 18: 1500, 575, 975
KAA50:  .word $05DC, $FDC1, $03CF   ;object 23 point 19: 1500, -575, 975
KAA56:  .word $0000, $0000, $0753   ;object 23 point 20: 0, 0, 1875
KAA5C:  .word $0000, $0000, $02EE   ;object 23 point 21: 0, 0, 750
KAA62:  .word $02EE, $0000, $0465   ;object 23 point 22: 750, 0, 1125
KAA68:  .word $FD12, $0000, $0465   ;object 23 point 23: -750, 0, 1125
KAA6E:  .word $00FA, $0271, $012C   ;object 24/25/26 point 0: 250, 625, 300
KAA74:  .word $00FA, $FD8F, $012C   ;object 24/25/26 point 1: 250, -625, 300
KAA7A:  .word $00FA, $023F, $FED4   ;object 24/25/26 point 2: 250, 575, -300
KAA80:  .word $00FA, $FDC1, $FED4   ;object 24/25/26 point 3: 250, -575, -300
KAA86:  .word $01F4, $0258, $FED4   ;object 24/25/26 point 4: 500, 600, -300
KAA8C:  .word $01F4, $FDA8, $FED4   ;object 24/25/26 point 5: 500, -600, -300
KAA92:  .word $02EE, $023F, $FD5D   ;object 24/25/26 point 6: 750, 575, -675
KAA98:  .word $02EE, $FDC1, $FD5D   ;object 24/25/26 point 7: 750, -575, -675
KAA9E:  .word $05DC, $01C2, $FD5D   ;object 24/25/26 point 8: 1500, 450, -675
KAAA4:  .word $05DC, $FE3E, $FD5D   ;object 24/25/26 point 9: 1500, -450, -675
KAAAA:  .word $05DC, $0190, $004B   ;object 24/25/26 point 10: 1500, 400, 75
KAAB0:  .word $05DC, $FE70, $004B   ;object 24/25/26 point 11: 1500, -400, 75
KAAB6:  .word $03E8, $01F4, $01C2   ;object 24/25/26 point 12: 1000, 500, 450
KAABC:  .word $03E8, $FE0C, $01C2   ;object 24/25/26 point 13: 1000, -500, 450
KAAC2:  .word $00FA, $023F, $01C2   ;object 24/25/26 point 14: 250, 575, 450
KAAC8:  .word $00FA, $FDC1, $01C2   ;object 24/25/26 point 15: 250, -575, 450
KAACE:  .word $05DC, $00AF, $FFDB   ;object 24/25/26 point 16: 1500, 175, -37
KAAD4:  .word $05DC, $FF51, $FFDB   ;object 24/25/26 point 17: 1500, -175, -37
KAADA:  .word $05DC, $00AF, $004B   ;object 24/25/26 point 18: 1500, 175, 75
KAAE0:  .word $05DC, $FF51, $004B   ;object 24/25/26 point 19: 1500, -175, 75
KAAE6:  .word $036B, $0000, $FF90   ;object 24/25/26 point 20: 875, 0, -112
KAAEC:  .word $0000, $0000, $0000   ;object 27 point 0: 0, 0, 0
KAAF2:  .word $05DC, $0271, $0177   ;object 28 point 0: 1500, 625, 375
KAAF8:  .word $05DC, $FD8F, $0177   ;object 28 point 1: 1500, -625, 375
KAAFE:  .word $05DC, $01F4, $0753   ;object 28 point 2: 1500, 500, 1875
KAB04:  .word $05DC, $FE0C, $0753   ;object 28 point 3: 1500, -500, 1875
KAB0A:  .word $01F4, $0271, $0A41   ;object 28 point 4: 500, 625, 2625
KAB10:  .word $01F4, $FD8F, $0A41   ;object 28 point 5: 500, -625, 2625
KAB16:  .word $01F4, $02EE, $0000   ;object 28 point 6: 500, 750, 0
KAB1C:  .word $01F4, $FD12, $0000   ;object 28 point 7: 500, -750, 0
KAB22:  .word $01F4, $02EE, $0000   ;object 29 point 0: 500, 750, 0
KAB28:  .word $01F4, $FD12, $0000   ;object 29 point 1: 500, -750, 0
KAB2E:  .word $01F4, $0271, $0A41   ;object 29 point 2: 500, 625, 2625
KAB34:  .word $01F4, $FD8F, $0A41   ;object 29 point 3: 500, -625, 2625
KAB3A:  .word $FE0C, $0271, $0A41   ;object 29 point 4: -500, 625, 2625
KAB40:  .word $FE0C, $FD8F, $0A41   ;object 29 point 5: -500, -625, 2625
KAB46:  .word $FE0C, $02EE, $0000   ;object 29 point 6: -500, 750, 0
KAB4C:  .word $FE0C, $FD12, $0000   ;object 29 point 7: -500, -750, 0
KAB52:  .word $FE0C, $02EE, $0000   ;object 30 point 0: -500, 750, 0
KAB58:  .word $FE0C, $FD12, $0000   ;object 30 point 1: -500, -750, 0
KAB5E:  .word $FE0C, $0271, $0A41   ;object 30 point 2: -500, 625, 2625
KAB64:  .word $FE0C, $FD8F, $0A41   ;object 30 point 3: -500, -625, 2625
KAB6A:  .word $FA24, $0271, $08CA   ;object 30 point 4: -1500, 625, 2250
KAB70:  .word $FA24, $FD8F, $08CA   ;object 30 point 5: -1500, -625, 2250
KAB76:  .word $FA24, $0271, $0000   ;object 30 point 6: -1500, 625, 0
KAB7C:  .word $FA24, $FD8F, $0000   ;object 30 point 7: -1500, -625, 0
KAB82:  .word $01F4, $0000, $0000   ;object 31 point 0: 500, 0, 0
KAB88:  .word $0190, $0014, $0014   ;object 31 point 1: 400, 20, 20
KAB8E:  .word $0190, $FFEC, $0014   ;object 31 point 2: 400, -20, 20
KAB94:  .word $0190, $0014, $FFEC   ;object 31 point 3: 400, 20, -20
KAB9A:  .word $0190, $FFEC, $FFEC   ;object 31 point 4: 400, -20, -20
KABA0:  .word $FED4, $0032, $0032   ;object 31 point 5: -300, 50, 50
KABA6:  .word $FED4, $FFCE, $0032   ;object 31 point 6: -300, -50, 50
KABAC:  .word $FED4, $0032, $FFCE   ;object 31 point 7: -300, 50, -50
KABB2:  .word $FED4, $FFCE, $FFCE   ;object 31 point 8: -300, -50, -50
KABB8:  .word $03E8, $0190, $0190   ;object 32 point 0: 1000, 400, 400
KABBE:  .word $03E8, $FE70, $0190   ;object 32 point 1: 1000, -400, 400
KABC4:  .word $03E8, $0190, $FE70   ;object 32 point 2: 1000, 400, -400
KABCA:  .word $03E8, $FE70, $FE70   ;object 32 point 3: 1000, -400, -400
KABD0:  .word $0190, $0190, $03E8   ;object 32 point 4: 400, 400, 1000
KABD6:  .word $0190, $FE70, $03E8   ;object 32 point 5: 400, -400, 1000
KABDC:  .word $0190, $03E8, $0190   ;object 32 point 6: 400, 1000, 400
KABE2:  .word $0190, $FC18, $0190   ;object 32 point 7: 400, -1000, 400
KABE8:  .word $0190, $03E8, $FE70   ;object 32 point 8: 400, 1000, -400
KABEE:  .word $0190, $FC18, $FE70   ;object 32 point 9: 400, -1000, -400
KABF4:  .word $0190, $0190, $FC18   ;object 32 point 10: 400, 400, -1000
KABFA:  .word $0190, $FE70, $FC18   ;object 32 point 11: 400, -400, -1000
KAC00:  .word $FE70, $0190, $03E8   ;object 32 point 12: -400, 400, 1000
KAC06:  .word $FE70, $FE70, $03E8   ;object 32 point 13: -400, -400, 1000
KAC0C:  .word $FE70, $03E8, $0190   ;object 32 point 14: -400, 1000, 400
KAC12:  .word $FE70, $FC18, $0190   ;object 32 point 15: -400, -1000, 400
KAC18:  .word $FE70, $03E8, $FE70   ;object 32 point 16: -400, 1000, -400
KAC1E:  .word $FE70, $FC18, $FE70   ;object 32 point 17: -400, -1000, -400
KAC24:  .word $FE70, $0190, $FC18   ;object 32 point 18: -400, 400, -1000
KAC2A:  .word $FE70, $FE70, $FC18   ;object 32 point 19: -400, -400, -1000
KAC30:  .word $FC18, $0190, $0190   ;object 32 point 20: -1000, 400, 400
KAC36:  .word $FC18, $FE70, $0190   ;object 32 point 21: -1000, -400, 400
KAC3C:  .word $FC18, $0190, $FE70   ;object 32 point 22: -1000, 400, -400
KAC42:  .word $FC18, $FE70, $FE70   ;object 32 point 23: -1000, -400, -400
KAC48:  .word $01F4, $00C8, $00C8   ;object 33 point 0: 500, 200, 200
KAC4E:  .word $01F4, $FF38, $00C8   ;object 33 point 1: 500, -200, 200
KAC54:  .word $01F4, $00C8, $FF38   ;object 33 point 2: 500, 200, -200
KAC5A:  .word $01F4, $FF38, $FF38   ;object 33 point 3: 500, -200, -200
KAC60:  .word $00C8, $00C8, $01F4   ;object 33 point 4: 200, 200, 500
KAC66:  .word $00C8, $FF38, $01F4   ;object 33 point 5: 200, -200, 500
KAC6C:  .word $00C8, $01F4, $00C8   ;object 33 point 6: 200, 500, 200
KAC72:  .word $00C8, $FE0C, $00C8   ;object 33 point 7: 200, -500, 200
KAC78:  .word $00C8, $01F4, $FF38   ;object 33 point 8: 200, 500, -200
KAC7E:  .word $00C8, $FE0C, $FF38   ;object 33 point 9: 200, -500, -200
KAC84:  .word $00C8, $00C8, $FE0C   ;object 33 point 10: 200, 200, -500
KAC8A:  .word $00C8, $FF38, $FE0C   ;object 33 point 11: 200, -200, -500
KAC90:  .word $FF38, $00C8, $01F4   ;object 33 point 12: -200, 200, 500
KAC96:  .word $FF38, $FF38, $01F4   ;object 33 point 13: -200, -200, 500
KAC9C:  .word $FF38, $01F4, $00C8   ;object 33 point 14: -200, 500, 200
KACA2:  .word $FF38, $FE0C, $00C8   ;object 33 point 15: -200, -500, 200
KACA8:  .word $FF38, $01F4, $FF38   ;object 33 point 16: -200, 500, -200
KACAE:  .word $FF38, $FE0C, $FF38   ;object 33 point 17: -200, -500, -200
KACB4:  .word $FF38, $00C8, $FE0C   ;object 33 point 18: -200, 200, -500
KACBA:  .word $FF38, $FF38, $FE0C   ;object 33 point 19: -200, -200, -500
KACC0:  .word $FE0C, $00C8, $00C8   ;object 33 point 20: -500, 200, 200
KACC6:  .word $FE0C, $FF38, $00C8   ;object 33 point 21: -500, -200, 200
KACCC:  .word $FE0C, $00C8, $FF38   ;object 33 point 22: -500, 200, -200
KACD2:  .word $FE0C, $FF38, $FF38   ;object 33 point 23: -500, -200, -200
KACD8:  .word $00FA, $0064, $0064   ;object 34 point 0: 250, 100, 100
KACDE:  .word $00FA, $FF9C, $0064   ;object 34 point 1: 250, -100, 100
KACE4:  .word $00FA, $0064, $FF9C   ;object 34 point 2: 250, 100, -100
KACEA:  .word $00FA, $FF9C, $FF9C   ;object 34 point 3: 250, -100, -100
KACF0:  .word $0064, $0064, $00FA   ;object 34 point 4: 100, 100, 250
KACF6:  .word $0064, $FF9C, $00FA   ;object 34 point 5: 100, -100, 250
KACFC:  .word $0064, $00FA, $0064   ;object 34 point 6: 100, 250, 100
KAD02:  .word $0064, $FF06, $0064   ;object 34 point 7: 100, -250, 100
KAD08:  .word $0064, $00FA, $FF9C   ;object 34 point 8: 100, 250, -100
KAD0E:  .word $0064, $FF06, $FF9C   ;object 34 point 9: 100, -250, -100
KAD14:  .word $0064, $0064, $FF06   ;object 34 point 10: 100, 100, -250
KAD1A:  .word $0064, $FF9C, $FF06   ;object 34 point 11: 100, -100, -250
KAD20:  .word $FF9C, $0064, $00FA   ;object 34 point 12: -100, 100, 250
KAD26:  .word $FF9C, $FF9C, $00FA   ;object 34 point 13: -100, -100, 250
KAD2C:  .word $FF9C, $00FA, $0064   ;object 34 point 14: -100, 250, 100
KAD32:  .word $FF9C, $FF06, $0064   ;object 34 point 15: -100, -250, 100
KAD38:  .word $FF9C, $00FA, $FF9C   ;object 34 point 16: -100, 250, -100
KAD3E:  .word $FF9C, $FF06, $FF9C   ;object 34 point 17: -100, -250, -100
KAD44:  .word $FF9C, $0064, $FF06   ;object 34 point 18: -100, 100, -250
KAD4A:  .word $FF9C, $FF9C, $FF06   ;object 34 point 19: -100, -100, -250
KAD50:  .word $FF06, $0064, $0064   ;object 34 point 20: -250, 100, 100
KAD56:  .word $FF06, $FF9C, $0064   ;object 34 point 21: -250, -100, 100
KAD5C:  .word $FF06, $0064, $FF9C   ;object 34 point 22: -250, 100, -100
KAD62:  .word $FF06, $FF9C, $FF9C   ;object 34 point 23: -250, -100, -100

;------------------------------------------------------------------------------
; draw_tie - draw routine of object 0, the TIE fighter of Star Wars (53 points, 88 lines at full brightness,
;   points 1 to 51). like all 22 draw routines it is entered from obj_draw with A, B, X and U stacked, sets the
;   direct page to the point buffer BJ_PNT, writes one vector per line into the display list at Y - the first one
;   a blank move from the beam position BJ_CX, BJ_CY - then restores the direct page, leaves the last point in
;   BJ_CX, BJ_CY and returns to obj_draw's caller
;------------------------------------------------------------------------------
draw_tie:
KAD68:  LDA  #$4E
KAD6A:  TFR  A,DP
.dpage $4E
KAD6C:  LDD  BJ_PNT+$07             ;beam to point 1
KAD6E:  SUBD BJ_CY
KAD71:  ANDA #$1F
KAD73:  STD  ,Y
KAD75:  LDD  BJ_PNT+$05
KAD77:  SUBD BJ_CX
KAD7A:  ANDA #$1F
KAD7C:  STD  2,Y
KAD7E:  LDD  BJ_PNT+$0C             ;DRAWTO 0,2,3,1,5,4,0  draw point 1 to 2
KAD80:  SUBD BJ_PNT+$07
KAD82:  ANDA #$1F
KAD84:  STD  4,Y
KAD86:  LDD  BJ_PNT+$0A
KAD88:  SUBD BJ_PNT+$05
KAD8A:  ORA  #$E0
KAD8C:  STD  6,Y
KAD8E:  LDD  BJ_PNT+$11             ;draw point 2 to 3
KAD90:  SUBD BJ_PNT+$0C
KAD92:  ANDA #$1F
KAD94:  STD  8,Y
KAD96:  LDD  BJ_PNT+$0F
KAD98:  SUBD BJ_PNT+$0A
KAD9A:  ORA  #$E0
KAD9C:  STD  $A,Y
KAD9E:  LDD  BJ_PNT+$16             ;draw point 3 to 4
KADA0:  SUBD BJ_PNT+$11
KADA2:  ANDA #$1F
KADA4:  STD  $C,Y
KADA6:  LDD  BJ_PNT+$14
KADA8:  SUBD BJ_PNT+$0F
KADAA:  ORA  #$E0
KADAC:  STD  $E,Y
KADAE:  LDD  BJ_PNT+$1B             ;draw point 4 to 5
KADB0:  SUBD BJ_PNT+$16
KADB2:  ANDA #$1F
KADB4:  LEAY $20,Y
KADB7:  STD  -16,Y
KADB9:  LDD  BJ_PNT+$19
KADBB:  SUBD BJ_PNT+$14
KADBD:  ORA  #$E0
KADBF:  STD  -14,Y
KADC1:  LDD  BJ_PNT+$20             ;draw point 5 to 6
KADC3:  SUBD BJ_PNT+$1B
KADC5:  ANDA #$1F
KADC7:  STD  -12,Y
KADC9:  LDD  BJ_PNT+$1E
KADCB:  SUBD BJ_PNT+$19
KADCD:  ORA  #$E0
KADCF:  STD  -10,Y
KADD1:  LDD  BJ_PNT+$07             ;draw point 6 to 1
KADD3:  SUBD BJ_PNT+$20
KADD5:  ANDA #$1F
KADD7:  STD  -8,Y
KADD9:  LDD  BJ_PNT+$05
KADDB:  SUBD BJ_PNT+$1E
KADDD:  ORA  #$E0
KADDF:  STD  -6,Y
KADE1:  LDD  BJ_PNT+$25             ;draw point 1 to 7
KADE3:  SUBD BJ_PNT+$07
KADE5:  ANDA #$1F
KADE7:  STD  -4,Y
KADE9:  LDD  BJ_PNT+$23
KADEB:  SUBD BJ_PNT+$05
KADED:  ORA  #$E0
KADEF:  STD  -2,Y
KADF1:  LDD  BJ_PNT+$2A             ;draw point 7 to 8
KADF3:  SUBD BJ_PNT+$25
KADF5:  ANDA #$1F
KADF7:  STD  ,Y
KADF9:  LDD  BJ_PNT+$28
KADFB:  SUBD BJ_PNT+$23
KADFD:  ORA  #$E0
KADFF:  STD  2,Y
KAE01:  LDD  BJ_PNT+$2F             ;DRAWTO 0,2,3,1,5,4,0  draw point 8 to 9
KAE03:  SUBD BJ_PNT+$2A
KAE05:  ANDA #$1F
KAE07:  STD  4,Y
KAE09:  LDD  BJ_PNT+$2D
KAE0B:  SUBD BJ_PNT+$28
KAE0D:  ORA  #$E0
KAE0F:  STD  6,Y
KAE11:  LDD  BJ_PNT+$34             ;draw point 9 to 10
KAE13:  SUBD BJ_PNT+$2F
KAE15:  ANDA #$1F
KAE17:  STD  8,Y
KAE19:  LDD  BJ_PNT+$32
KAE1B:  SUBD BJ_PNT+$2D
KAE1D:  ORA  #$E0
KAE1F:  STD  $A,Y
KAE21:  LDD  BJ_PNT+$39             ;draw point 10 to 11
KAE23:  SUBD BJ_PNT+$34
KAE25:  ANDA #$1F
KAE27:  STD  $C,Y
KAE29:  LDD  BJ_PNT+$37
KAE2B:  SUBD BJ_PNT+$32
KAE2D:  ORA  #$E0
KAE2F:  STD  $E,Y
KAE31:  LDD  BJ_PNT+$3E             ;draw point 11 to 12
KAE33:  SUBD BJ_PNT+$39
KAE35:  ANDA #$1F
KAE37:  LEAY $20,Y
KAE3A:  STD  -16,Y
KAE3C:  LDD  BJ_PNT+$3C
KAE3E:  SUBD BJ_PNT+$37
KAE40:  ORA  #$E0
KAE42:  STD  -14,Y
KAE44:  LDD  BJ_PNT+$25             ;draw point 12 to 7
KAE46:  SUBD BJ_PNT+$3E
KAE48:  ANDA #$1F
KAE4A:  STD  -12,Y
KAE4C:  LDD  BJ_PNT+$23
KAE4E:  SUBD BJ_PNT+$3C
KAE50:  ORA  #$E0
KAE52:  STD  -10,Y
KAE54:  LDD  BJ_PNT+$7F             ;draw point 7 to 25
KAE56:  SUBD BJ_PNT+$25
KAE58:  ANDA #$1F
KAE5A:  STD  -8,Y
KAE5C:  LDD  BJ_PNT+$7D
KAE5E:  SUBD BJ_PNT+$23
KAE60:  ORA  #$E0
KAE62:  STD  -6,Y
KAE64:  LDD  BJ_PNT+$84             ;draw point 25 to 26
KAE66:  SUBD BJ_PNT+$7F
KAE68:  ANDA #$1F
KAE6A:  STD  -4,Y
KAE6C:  LDD  BJ_PNT+$82
KAE6E:  SUBD BJ_PNT+$7D
KAE70:  ORA  #$E0
KAE72:  STD  -2,Y
KAE74:  LDD  BJ_PNT+$89             ;draw point 26 to 27
KAE76:  SUBD BJ_PNT+$84
KAE78:  ANDA #$1F
KAE7A:  STD  ,Y
KAE7C:  LDD  BJ_PNT+$87
KAE7E:  SUBD BJ_PNT+$82
KAE80:  ORA  #$E0
KAE82:  STD  2,Y
KAE84:  LDD  BJ_PNT+$8E             ;DRAWTO 0,2,3,1,5,4,0  draw point 27 to 28
KAE86:  SUBD BJ_PNT+$89
KAE88:  ANDA #$1F
KAE8A:  STD  4,Y
KAE8C:  LDD  BJ_PNT+$8C
KAE8E:  SUBD BJ_PNT+$87
KAE90:  ORA  #$E0
KAE92:  STD  6,Y
KAE94:  LDD  BJ_PNT+$93             ;draw point 28 to 29
KAE96:  SUBD BJ_PNT+$8E
KAE98:  ANDA #$1F
KAE9A:  STD  8,Y
KAE9C:  LDD  BJ_PNT+$91
KAE9E:  SUBD BJ_PNT+$8C
KAEA0:  ORA  #$E0
KAEA2:  STD  $A,Y
KAEA4:  LDD  BJ_PNT+$7F             ;draw point 29 to 25
KAEA6:  SUBD BJ_PNT+$93
KAEA8:  ANDA #$1F
KAEAA:  STD  $C,Y
KAEAC:  LDD  BJ_PNT+$7D
KAEAE:  SUBD BJ_PNT+$91
KAEB0:  ORA  #$E0
KAEB2:  STD  $E,Y
KAEB4:  LDD  BJ_PNT+$BB             ;draw point 25 to 37
KAEB6:  SUBD BJ_PNT+$7F
KAEB8:  ANDA #$1F
KAEBA:  LEAY $20,Y
KAEBD:  STD  -16,Y
KAEBF:  LDD  BJ_PNT+$B9
KAEC1:  SUBD BJ_PNT+$7D
KAEC3:  ORA  #$E0
KAEC5:  STD  -14,Y
KAEC7:  LDD  BJ_PNT+$C0             ;draw point 37 to 38
KAEC9:  SUBD BJ_PNT+$BB
KAECB:  ANDA #$1F
KAECD:  STD  -12,Y
KAECF:  LDD  BJ_PNT+$BE
KAED1:  SUBD BJ_PNT+$B9
KAED3:  ORA  #$E0
KAED5:  STD  -10,Y
KAED7:  LDD  BJ_PNT+$C5             ;draw point 38 to 39
KAED9:  SUBD BJ_PNT+$C0
KAEDB:  ANDA #$1F
KAEDD:  STD  -8,Y
KAEDF:  LDD  BJ_PNT+$C3
KAEE1:  SUBD BJ_PNT+$BE
KAEE3:  ORA  #$E0
KAEE5:  STD  -6,Y
KAEE7:  LDD  BJ_PNT+$ED             ;draw point 39 to 47
KAEE9:  SUBD BJ_PNT+$C5
KAEEB:  ANDA #$1F
KAEED:  STD  -4,Y
KAEEF:  LDD  BJ_PNT+$EB
KAEF1:  SUBD BJ_PNT+$C3
KAEF3:  ORA  #$E0
KAEF5:  STD  -2,Y
KAEF7:  LDD  BJ_PNT+$C5             ;move point 47 to 39
KAEF9:  SUBD BJ_PNT+$ED
KAEFB:  ANDA #$1F
KAEFD:  STD  ,Y
KAEFF:  LDD  BJ_PNT+$C3
KAF01:  SUBD BJ_PNT+$EB
KAF03:  ANDA #$1F
KAF05:  STD  2,Y
KAF07:  LDD  BJ_PNT+$CA             ;DRAWTO 0,2,3,1,5,4,0  draw point 39 to 40
KAF09:  SUBD BJ_PNT+$C5
KAF0B:  ANDA #$1F
KAF0D:  STD  4,Y
KAF0F:  LDD  BJ_PNT+$C8
KAF11:  SUBD BJ_PNT+$C3
KAF13:  ORA  #$E0
KAF15:  STD  6,Y
KAF17:  LDD  BJ_PNT+$CF             ;draw point 40 to 41
KAF19:  SUBD BJ_PNT+$CA
KAF1B:  ANDA #$1F
KAF1D:  STD  8,Y
KAF1F:  LDD  BJ_PNT+$CD
KAF21:  SUBD BJ_PNT+$C8
KAF23:  ORA  #$E0
KAF25:  STD  $A,Y
KAF27:  LDD  BJ_PNT+$F7             ;draw point 41 to 49
KAF29:  SUBD BJ_PNT+$CF
KAF2B:  ANDA #$1F
KAF2D:  STD  $C,Y
KAF2F:  LDD  BJ_PNT+$F5
KAF31:  SUBD BJ_PNT+$CD
KAF33:  ORA  #$E0
KAF35:  STD  $E,Y
KAF37:  LDD  BJ_PNT+$CF             ;move point 49 to 41
KAF39:  SUBD BJ_PNT+$F7
KAF3B:  ANDA #$1F
KAF3D:  LEAY $20,Y
KAF40:  STD  -16,Y
KAF42:  LDD  BJ_PNT+$CD
KAF44:  SUBD BJ_PNT+$F5
KAF46:  ANDA #$1F
KAF48:  STD  -14,Y
KAF4A:  LDD  BJ_PNT+$D4             ;draw point 41 to 42
KAF4C:  SUBD BJ_PNT+$CF
KAF4E:  ANDA #$1F
KAF50:  STD  -12,Y
KAF52:  LDD  BJ_PNT+$D2
KAF54:  SUBD BJ_PNT+$CD
KAF56:  ORA  #$E0
KAF58:  STD  -10,Y
KAF5A:  LDD  BJ_PNT+$D9             ;draw point 42 to 43
KAF5C:  SUBD BJ_PNT+$D4
KAF5E:  ANDA #$1F
KAF60:  STD  -8,Y
KAF62:  LDD  BJ_PNT+$D7
KAF64:  SUBD BJ_PNT+$D2
KAF66:  ORA  #$E0
KAF68:  STD  -6,Y
KAF6A:  LDD  BJ_PNT+$DE             ;draw point 43 to 44
KAF6C:  SUBD BJ_PNT+$D9
KAF6E:  ANDA #$1F
KAF70:  STD  -4,Y
KAF72:  LDD  BJ_PNT+$DC
KAF74:  SUBD BJ_PNT+$D7
KAF76:  ORA  #$E0
KAF78:  STD  -2,Y
KAF7A:  LDD  BJ_PNT+$BB             ;draw point 44 to 37
KAF7C:  SUBD BJ_PNT+$DE
KAF7E:  ANDA #$1F
KAF80:  STD  ,Y
KAF82:  LDD  BJ_PNT+$B9
KAF84:  SUBD BJ_PNT+$DC
KAF86:  ORA  #$E0
KAF88:  STD  2,Y
KAF8A:  LDD  BJ_PNT+$E3             ;DRAWTO 0,2,3,1,5,4,0  draw point 37 to 45
KAF8C:  SUBD BJ_PNT+$BB
KAF8E:  ANDA #$1F
KAF90:  STD  4,Y
KAF92:  LDD  BJ_PNT+$E1
KAF94:  SUBD BJ_PNT+$B9
KAF96:  ORA  #$E0
KAF98:  STD  6,Y
KAF9A:  LDD  BJ_PNT+$E8             ;draw point 45 to 46
KAF9C:  SUBD BJ_PNT+$E3
KAF9E:  ANDA #$1F
KAFA0:  STD  8,Y
KAFA2:  LDD  BJ_PNT+$E6
KAFA4:  SUBD BJ_PNT+$E1
KAFA6:  ORA  #$E0
KAFA8:  STD  $A,Y
KAFAA:  LDD  BJ_PNT+$ED             ;draw point 46 to 47
KAFAC:  SUBD BJ_PNT+$E8
KAFAE:  ANDA #$1F
KAFB0:  STD  $C,Y
KAFB2:  LDD  BJ_PNT+$EB
KAFB4:  SUBD BJ_PNT+$E6
KAFB6:  ORA  #$E0
KAFB8:  STD  $E,Y
KAFBA:  LDD  BJ_PNT+$F2             ;draw point 47 to 48
KAFBC:  SUBD BJ_PNT+$ED
KAFBE:  ANDA #$1F
KAFC0:  LEAY $20,Y
KAFC3:  STD  -16,Y
KAFC5:  LDD  BJ_PNT+$F0
KAFC7:  SUBD BJ_PNT+$EB
KAFC9:  ORA  #$E0
KAFCB:  STD  -14,Y
KAFCD:  LDD  BJ_PNT+$F7             ;draw point 48 to 49
KAFCF:  SUBD BJ_PNT+$F2
KAFD1:  ANDA #$1F
KAFD3:  STD  -12,Y
KAFD5:  LDD  BJ_PNT+$F5
KAFD7:  SUBD BJ_PNT+$F0
KAFD9:  ORA  #$E0
KAFDB:  STD  -10,Y
KAFDD:  LDD  BJ_PNT+$FC             ;draw point 49 to 50
KAFDF:  SUBD BJ_PNT+$F7
KAFE1:  ANDA #$1F
KAFE3:  STD  -8,Y
KAFE5:  LDD  BJ_PNT+$FA
KAFE7:  SUBD BJ_PNT+$F5
KAFE9:  ORA  #$E0
KAFEB:  STD  -6,Y
KAFED:  LDD  BJ_PNT+$101
KAFF0:  SUBD BJ_PNT+$FC
KAFF2:  ANDA #$1F
KAFF4:  STD  -4,Y
KAFF6:  LDD  BJ_PNT+$FF
KAFF8:  SUBD BJ_PNT+$FA
KAFFA:  ORA  #$E0
KAFFC:  STD  -2,Y
KAFFE:  LDD  BJ_PNT+$106
KB001:  SUBD BJ_PNT+$101
KB004:  ANDA #$1F
KB006:  STD  ,Y
KB008:  LDD  BJ_PNT+$104
KB00B:  SUBD BJ_PNT+$FF
KB00D:  ORA  #$E0
KB00F:  STD  2,Y
KB011:  LDD  BJ_PNT+$E3
KB013:  SUBD BJ_PNT+$106
KB016:  ANDA #$1F
KB018:  STD  4,Y
KB01A:  LDD  BJ_PNT+$E1
KB01C:  SUBD BJ_PNT+$104
KB01F:  ORA  #$E0
KB021:  STD  6,Y
KB023:  LDD  BJ_PNT+$9D             ;draw point 45 to 31
KB025:  SUBD BJ_PNT+$E3
KB027:  ANDA #$1F
KB029:  STD  8,Y
KB02B:  LDD  BJ_PNT+$9B
KB02D:  SUBD BJ_PNT+$E1
KB02F:  ORA  #$E0
KB031:  STD  $A,Y
KB033:  LDD  BJ_PNT+$A2             ;draw point 31 to 32
KB035:  SUBD BJ_PNT+$9D
KB037:  ANDA #$1F
KB039:  STD  $C,Y
KB03B:  LDD  BJ_PNT+$A0
KB03D:  SUBD BJ_PNT+$9B
KB03F:  ORA  #$E0
KB041:  STD  $E,Y
KB043:  LDD  BJ_PNT+$A7             ;draw point 32 to 33
KB045:  SUBD BJ_PNT+$A2
KB047:  ANDA #$1F
KB049:  LEAY $20,Y
KB04C:  STD  -16,Y
KB04E:  LDD  BJ_PNT+$A5
KB050:  SUBD BJ_PNT+$A0
KB052:  ORA  #$E0
KB054:  STD  -14,Y
KB056:  LDD  BJ_PNT+$AC             ;draw point 33 to 34
KB058:  SUBD BJ_PNT+$A7
KB05A:  ANDA #$1F
KB05C:  STD  -12,Y
KB05E:  LDD  BJ_PNT+$AA
KB060:  SUBD BJ_PNT+$A5
KB062:  ORA  #$E0
KB064:  STD  -10,Y
KB066:  LDD  BJ_PNT+$B1             ;draw point 34 to 35
KB068:  SUBD BJ_PNT+$AC
KB06A:  ANDA #$1F
KB06C:  STD  -8,Y
KB06E:  LDD  BJ_PNT+$AF
KB070:  SUBD BJ_PNT+$AA
KB072:  ORA  #$E0
KB074:  STD  -6,Y
KB076:  LDD  BJ_PNT+$B6             ;draw point 35 to 36
KB078:  SUBD BJ_PNT+$B1
KB07A:  ANDA #$1F
KB07C:  STD  -4,Y
KB07E:  LDD  BJ_PNT+$B4
KB080:  SUBD BJ_PNT+$AF
KB082:  ORA  #$E0
KB084:  STD  -2,Y
KB086:  LDD  BJ_PNT+$9D             ;draw point 36 to 31
KB088:  SUBD BJ_PNT+$B6
KB08A:  ANDA #$1F
KB08C:  STD  ,Y
KB08E:  LDD  BJ_PNT+$9B
KB090:  SUBD BJ_PNT+$B4
KB092:  ORA  #$E0
KB094:  STD  2,Y
KB096:  LDD  BJ_PNT+$61             ;DRAWTO 0,2,3,1,5,4,0  draw point 31 to 19
KB098:  SUBD BJ_PNT+$9D
KB09A:  ANDA #$1F
KB09C:  STD  4,Y
KB09E:  LDD  BJ_PNT+$5F
KB0A0:  SUBD BJ_PNT+$9B
KB0A2:  ORA  #$E0
KB0A4:  STD  6,Y
KB0A6:  LDD  BJ_PNT+$66             ;draw point 19 to 20
KB0A8:  SUBD BJ_PNT+$61
KB0AA:  ANDA #$1F
KB0AC:  STD  8,Y
KB0AE:  LDD  BJ_PNT+$64
KB0B0:  SUBD BJ_PNT+$5F
KB0B2:  ORA  #$E0
KB0B4:  STD  $A,Y
KB0B6:  LDD  BJ_PNT+$6B             ;draw point 20 to 21
KB0B8:  SUBD BJ_PNT+$66
KB0BA:  ANDA #$1F
KB0BC:  STD  $C,Y
KB0BE:  LDD  BJ_PNT+$69
KB0C0:  SUBD BJ_PNT+$64
KB0C2:  ORA  #$E0
KB0C4:  STD  $E,Y
KB0C6:  LDD  BJ_PNT+$70             ;draw point 21 to 22
KB0C8:  SUBD BJ_PNT+$6B
KB0CA:  ANDA #$1F
KB0CC:  LEAY $20,Y
KB0CF:  STD  -16,Y
KB0D1:  LDD  BJ_PNT+$6E
KB0D3:  SUBD BJ_PNT+$69
KB0D5:  ORA  #$E0
KB0D7:  STD  -14,Y
KB0D9:  LDD  BJ_PNT+$75             ;draw point 22 to 23
KB0DB:  SUBD BJ_PNT+$70
KB0DD:  ANDA #$1F
KB0DF:  STD  -12,Y
KB0E1:  LDD  BJ_PNT+$73
KB0E3:  SUBD BJ_PNT+$6E
KB0E5:  ORA  #$E0
KB0E7:  STD  -10,Y
KB0E9:  LDD  BJ_PNT+$7A             ;draw point 23 to 24
KB0EB:  SUBD BJ_PNT+$75
KB0ED:  ANDA #$1F
KB0EF:  STD  -8,Y
KB0F1:  LDD  BJ_PNT+$78
KB0F3:  SUBD BJ_PNT+$73
KB0F5:  ORA  #$E0
KB0F7:  STD  -6,Y
KB0F9:  LDD  BJ_PNT+$61             ;draw point 24 to 19
KB0FB:  SUBD BJ_PNT+$7A
KB0FD:  ANDA #$1F
KB0FF:  STD  -4,Y
KB101:  LDD  BJ_PNT+$5F
KB103:  SUBD BJ_PNT+$78
KB105:  ORA  #$E0
KB107:  STD  -2,Y
KB109:  LDD  BJ_PNT+$43             ;draw point 19 to 13
KB10B:  SUBD BJ_PNT+$61
KB10D:  ANDA #$1F
KB10F:  STD  ,Y
KB111:  LDD  BJ_PNT+$41
KB113:  SUBD BJ_PNT+$5F
KB115:  ORA  #$E0
KB117:  STD  2,Y
KB119:  LDD  BJ_PNT+$48             ;DRAWTO 0,2,3,1,5,4,0  draw point 13 to 14
KB11B:  SUBD BJ_PNT+$43
KB11D:  ANDA #$1F
KB11F:  STD  4,Y
KB121:  LDD  BJ_PNT+$46
KB123:  SUBD BJ_PNT+$41
KB125:  ORA  #$E0
KB127:  STD  6,Y
KB129:  LDD  BJ_PNT+$4D             ;draw point 14 to 15
KB12B:  SUBD BJ_PNT+$48
KB12D:  ANDA #$1F
KB12F:  STD  8,Y
KB131:  LDD  BJ_PNT+$4B
KB133:  SUBD BJ_PNT+$46
KB135:  ORA  #$E0
KB137:  STD  $A,Y
KB139:  LDD  BJ_PNT+$52             ;draw point 15 to 16
KB13B:  SUBD BJ_PNT+$4D
KB13D:  ANDA #$1F
KB13F:  STD  $C,Y
KB141:  LDD  BJ_PNT+$50
KB143:  SUBD BJ_PNT+$4B
KB145:  ORA  #$E0
KB147:  STD  $E,Y
KB149:  LDD  BJ_PNT+$57             ;draw point 16 to 17
KB14B:  SUBD BJ_PNT+$52
KB14D:  ANDA #$1F
KB14F:  LEAY $20,Y
KB152:  STD  -16,Y
KB154:  LDD  BJ_PNT+$55
KB156:  SUBD BJ_PNT+$50
KB158:  ORA  #$E0
KB15A:  STD  -14,Y
KB15C:  LDD  BJ_PNT+$5C             ;draw point 17 to 18
KB15E:  SUBD BJ_PNT+$57
KB160:  ANDA #$1F
KB162:  STD  -12,Y
KB164:  LDD  BJ_PNT+$5A
KB166:  SUBD BJ_PNT+$55
KB168:  ORA  #$E0
KB16A:  STD  -10,Y
KB16C:  LDD  BJ_PNT+$43             ;draw point 18 to 13
KB16E:  SUBD BJ_PNT+$5C
KB170:  ANDA #$1F
KB172:  STD  -8,Y
KB174:  LDD  BJ_PNT+$41
KB176:  SUBD BJ_PNT+$5A
KB178:  ORA  #$E0
KB17A:  STD  -6,Y
KB17C:  LDD  BJ_PNT+$48             ;move point 13 to 14
KB17E:  SUBD BJ_PNT+$43
KB180:  ANDA #$1F
KB182:  STD  -4,Y
KB184:  LDD  BJ_PNT+$46
KB186:  SUBD BJ_PNT+$41
KB188:  ANDA #$1F
KB18A:  STD  -2,Y
KB18C:  LDD  BJ_PNT+$66             ;draw point 14 to 20
KB18E:  SUBD BJ_PNT+$48
KB190:  ANDA #$1F
KB192:  STD  ,Y
KB194:  LDD  BJ_PNT+$64
KB196:  SUBD BJ_PNT+$46
KB198:  ORA  #$E0
KB19A:  STD  2,Y
KB19C:  LDD  BJ_PNT+$A2             ;DRAWTO 0,2,3,1,5,4,0  draw point 20 to 32
KB19E:  SUBD BJ_PNT+$66
KB1A0:  ANDA #$1F
KB1A2:  STD  4,Y
KB1A4:  LDD  BJ_PNT+$A0
KB1A6:  SUBD BJ_PNT+$64
KB1A8:  ORA  #$E0
KB1AA:  STD  6,Y
KB1AC:  LDD  BJ_PNT+$E8             ;draw point 32 to 46
KB1AE:  SUBD BJ_PNT+$A2
KB1B0:  ANDA #$1F
KB1B2:  STD  8,Y
KB1B4:  LDD  BJ_PNT+$E6
KB1B6:  SUBD BJ_PNT+$A0
KB1B8:  ORA  #$E0
KB1BA:  STD  $A,Y
KB1BC:  LDD  BJ_PNT+$C0             ;draw point 46 to 38
KB1BE:  SUBD BJ_PNT+$E8
KB1C0:  ANDA #$1F
KB1C2:  STD  $C,Y
KB1C4:  LDD  BJ_PNT+$BE
KB1C6:  SUBD BJ_PNT+$E6
KB1C8:  ORA  #$E0
KB1CA:  STD  $E,Y
KB1CC:  LDD  BJ_PNT+$84             ;draw point 38 to 26
KB1CE:  SUBD BJ_PNT+$C0
KB1D0:  ANDA #$1F
KB1D2:  LEAY $20,Y
KB1D5:  STD  -16,Y
KB1D7:  LDD  BJ_PNT+$82
KB1D9:  SUBD BJ_PNT+$BE
KB1DB:  ORA  #$E0
KB1DD:  STD  -14,Y
KB1DF:  LDD  BJ_PNT+$2A             ;draw point 26 to 8
KB1E1:  SUBD BJ_PNT+$84
KB1E3:  ANDA #$1F
KB1E5:  STD  -12,Y
KB1E7:  LDD  BJ_PNT+$28
KB1E9:  SUBD BJ_PNT+$82
KB1EB:  ORA  #$E0
KB1ED:  STD  -10,Y
KB1EF:  LDD  BJ_PNT+$0C             ;draw point 8 to 2
KB1F1:  SUBD BJ_PNT+$2A
KB1F3:  ANDA #$1F
KB1F5:  STD  -8,Y
KB1F7:  LDD  BJ_PNT+$0A
KB1F9:  SUBD BJ_PNT+$28
KB1FB:  ORA  #$E0
KB1FD:  STD  -6,Y
KB1FF:  LDD  BJ_PNT+$11             ;move point 2 to 3
KB201:  SUBD BJ_PNT+$0C
KB203:  ANDA #$1F
KB205:  STD  -4,Y
KB207:  LDD  BJ_PNT+$0F
KB209:  SUBD BJ_PNT+$0A
KB20B:  ANDA #$1F
KB20D:  STD  -2,Y
KB20F:  LDD  BJ_PNT+$2F             ;draw point 3 to 9
KB211:  SUBD BJ_PNT+$11
KB213:  ANDA #$1F
KB215:  STD  ,Y
KB217:  LDD  BJ_PNT+$2D
KB219:  SUBD BJ_PNT+$0F
KB21B:  ORA  #$E0
KB21D:  STD  2,Y
KB21F:  LDD  BJ_PNT+$89             ;DRAWTO 0,2,3,1,5,4,0  draw point 9 to 27
KB221:  SUBD BJ_PNT+$2F
KB223:  ANDA #$1F
KB225:  STD  4,Y
KB227:  LDD  BJ_PNT+$87
KB229:  SUBD BJ_PNT+$2D
KB22B:  ORA  #$E0
KB22D:  STD  6,Y
KB22F:  LDD  BJ_PNT+$CA             ;draw point 27 to 40
KB231:  SUBD BJ_PNT+$89
KB233:  ANDA #$1F
KB235:  STD  8,Y
KB237:  LDD  BJ_PNT+$C8
KB239:  SUBD BJ_PNT+$87
KB23B:  ORA  #$E0
KB23D:  STD  $A,Y
KB23F:  LDD  BJ_PNT+$F2             ;move point 40 to 48
KB241:  SUBD BJ_PNT+$CA
KB243:  ANDA #$1F
KB245:  STD  $C,Y
KB247:  LDD  BJ_PNT+$F0
KB249:  SUBD BJ_PNT+$C8
KB24B:  ANDA #$1F
KB24D:  STD  $E,Y
KB24F:  LDD  BJ_PNT+$A7             ;draw point 48 to 33
KB251:  SUBD BJ_PNT+$F2
KB253:  ANDA #$1F
KB255:  LEAY $20,Y
KB258:  STD  -16,Y
KB25A:  LDD  BJ_PNT+$A5
KB25C:  SUBD BJ_PNT+$F0
KB25E:  ORA  #$E0
KB260:  STD  -14,Y
KB262:  LDD  BJ_PNT+$6B             ;draw point 33 to 21
KB264:  SUBD BJ_PNT+$A7
KB266:  ANDA #$1F
KB268:  STD  -12,Y
KB26A:  LDD  BJ_PNT+$69
KB26C:  SUBD BJ_PNT+$A5
KB26E:  ORA  #$E0
KB270:  STD  -10,Y
KB272:  LDD  BJ_PNT+$4D             ;draw point 21 to 15
KB274:  SUBD BJ_PNT+$6B
KB276:  ANDA #$1F
KB278:  STD  -8,Y
KB27A:  LDD  BJ_PNT+$4B
KB27C:  SUBD BJ_PNT+$69
KB27E:  ORA  #$E0
KB280:  STD  -6,Y
KB282:  LDD  BJ_PNT+$52             ;move point 15 to 16
KB284:  SUBD BJ_PNT+$4D
KB286:  ANDA #$1F
KB288:  STD  -4,Y
KB28A:  LDD  BJ_PNT+$50
KB28C:  SUBD BJ_PNT+$4B
KB28E:  ANDA #$1F
KB290:  STD  -2,Y
KB292:  LDD  BJ_PNT+$70             ;draw point 16 to 22
KB294:  SUBD BJ_PNT+$52
KB296:  ANDA #$1F
KB298:  STD  ,Y
KB29A:  LDD  BJ_PNT+$6E
KB29C:  SUBD BJ_PNT+$50
KB29E:  ORA  #$E0
KB2A0:  STD  2,Y
KB2A2:  LDD  BJ_PNT+$AC             ;DRAWTO 0,2,3,1,5,4,0  draw point 22 to 34
KB2A4:  SUBD BJ_PNT+$70
KB2A6:  ANDA #$1F
KB2A8:  STD  4,Y
KB2AA:  LDD  BJ_PNT+$AA
KB2AC:  SUBD BJ_PNT+$6E
KB2AE:  ORA  #$E0
KB2B0:  STD  6,Y
KB2B2:  LDD  BJ_PNT+$FC             ;draw point 34 to 50
KB2B4:  SUBD BJ_PNT+$AC
KB2B6:  ANDA #$1F
KB2B8:  STD  8,Y
KB2BA:  LDD  BJ_PNT+$FA
KB2BC:  SUBD BJ_PNT+$AA
KB2BE:  ORA  #$E0
KB2C0:  STD  $A,Y
KB2C2:  LDD  BJ_PNT+$D4             ;draw point 50 to 42
KB2C4:  SUBD BJ_PNT+$FC
KB2C6:  ANDA #$1F
KB2C8:  STD  $C,Y
KB2CA:  LDD  BJ_PNT+$D2
KB2CC:  SUBD BJ_PNT+$FA
KB2CE:  ORA  #$E0
KB2D0:  STD  $E,Y
KB2D2:  LDD  BJ_PNT+$8E             ;draw point 42 to 28
KB2D4:  SUBD BJ_PNT+$D4
KB2D6:  ANDA #$1F
KB2D8:  LEAY $20,Y
KB2DB:  STD  -16,Y
KB2DD:  LDD  BJ_PNT+$8C
KB2DF:  SUBD BJ_PNT+$D2
KB2E1:  ORA  #$E0
KB2E3:  STD  -14,Y
KB2E5:  LDD  BJ_PNT+$34             ;draw point 28 to 10
KB2E7:  SUBD BJ_PNT+$8E
KB2E9:  ANDA #$1F
KB2EB:  STD  -12,Y
KB2ED:  LDD  BJ_PNT+$32
KB2EF:  SUBD BJ_PNT+$8C
KB2F1:  ORA  #$E0
KB2F3:  STD  -10,Y
KB2F5:  LDD  BJ_PNT+$16             ;draw point 10 to 4
KB2F7:  SUBD BJ_PNT+$34
KB2F9:  ANDA #$1F
KB2FB:  STD  -8,Y
KB2FD:  LDD  BJ_PNT+$14
KB2FF:  SUBD BJ_PNT+$32
KB301:  ORA  #$E0
KB303:  STD  -6,Y
KB305:  LDD  BJ_PNT+$1B             ;move point 4 to 5
KB307:  SUBD BJ_PNT+$16
KB309:  ANDA #$1F
KB30B:  STD  -4,Y
KB30D:  LDD  BJ_PNT+$19
KB30F:  SUBD BJ_PNT+$14
KB311:  ANDA #$1F
KB313:  STD  -2,Y
KB315:  LDD  BJ_PNT+$39             ;draw point 5 to 11
KB317:  SUBD BJ_PNT+$1B
KB319:  ANDA #$1F
KB31B:  STD  ,Y
KB31D:  LDD  BJ_PNT+$37
KB31F:  SUBD BJ_PNT+$19
KB321:  ORA  #$E0
KB323:  STD  2,Y
KB325:  LDD  BJ_PNT+$93             ;DRAWTO 0,2,3,1,5,4,0  draw point 11 to 29
KB327:  SUBD BJ_PNT+$39
KB329:  ANDA #$1F
KB32B:  STD  4,Y
KB32D:  LDD  BJ_PNT+$91
KB32F:  SUBD BJ_PNT+$37
KB331:  ORA  #$E0
KB333:  STD  6,Y
KB335:  LDD  BJ_PNT+$D9             ;draw point 29 to 43
KB337:  SUBD BJ_PNT+$93
KB339:  ANDA #$1F
KB33B:  STD  8,Y
KB33D:  LDD  BJ_PNT+$D7
KB33F:  SUBD BJ_PNT+$91
KB341:  ORA  #$E0
KB343:  STD  $A,Y
KB345:  LDD  BJ_PNT+$101
KB348:  SUBD BJ_PNT+$D9
KB34A:  ANDA #$1F
KB34C:  STD  $C,Y
KB34E:  LDD  BJ_PNT+$FF
KB350:  SUBD BJ_PNT+$D7
KB352:  ORA  #$E0
KB354:  STD  $E,Y
KB356:  LDD  BJ_PNT+$B1             ;draw point 51 to 35
KB358:  SUBD BJ_PNT+$101
KB35B:  ANDA #$1F
KB35D:  LEAY $20,Y
KB360:  STD  -16,Y
KB362:  LDD  BJ_PNT+$AF
KB364:  SUBD BJ_PNT+$FF
KB366:  ORA  #$E0
KB368:  STD  -14,Y
KB36A:  LDD  BJ_PNT+$75             ;draw point 35 to 23
KB36C:  SUBD BJ_PNT+$B1
KB36E:  ANDA #$1F
KB370:  STD  -12,Y
KB372:  LDD  BJ_PNT+$73
KB374:  SUBD BJ_PNT+$AF
KB376:  ORA  #$E0
KB378:  STD  -10,Y
KB37A:  LDD  BJ_PNT+$57             ;draw point 23 to 17
KB37C:  SUBD BJ_PNT+$75
KB37E:  ANDA #$1F
KB380:  STD  -8,Y
KB382:  LDD  BJ_PNT+$55
KB384:  SUBD BJ_PNT+$73
KB386:  ORA  #$E0
KB388:  STD  -6,Y
KB38A:  LDD  BJ_PNT+$5C             ;move point 17 to 18
KB38C:  SUBD BJ_PNT+$57
KB38E:  ANDA #$1F
KB390:  STD  -4,Y
KB392:  LDD  BJ_PNT+$5A
KB394:  SUBD BJ_PNT+$55
KB396:  ANDA #$1F
KB398:  STD  -2,Y
KB39A:  LDD  BJ_PNT+$7A             ;draw point 18 to 24
KB39C:  SUBD BJ_PNT+$5C
KB39E:  ANDA #$1F
KB3A0:  STD  ,Y
KB3A2:  LDD  BJ_PNT+$78
KB3A4:  SUBD BJ_PNT+$5A
KB3A6:  ORA  #$E0
KB3A8:  STD  2,Y
KB3AA:  LDD  BJ_PNT+$B6             ;DRAWTO 0,2,3,1,5,4,0  draw point 24 to 36
KB3AC:  SUBD BJ_PNT+$7A
KB3AE:  ANDA #$1F
KB3B0:  STD  4,Y
KB3B2:  LDD  BJ_PNT+$B4
KB3B4:  SUBD BJ_PNT+$78
KB3B6:  ORA  #$E0
KB3B8:  STD  6,Y
KB3BA:  LDD  BJ_PNT+$106
KB3BD:  SUBD BJ_PNT+$B6
KB3BF:  ANDA #$1F
KB3C1:  STD  8,Y
KB3C3:  LDD  BJ_PNT+$104
KB3C6:  SUBD BJ_PNT+$B4
KB3C8:  ORA  #$E0
KB3CA:  STD  $A,Y
KB3CC:  LDD  BJ_PNT+$DE
KB3CE:  SUBD BJ_PNT+$106
KB3D1:  ANDA #$1F
KB3D3:  STD  $C,Y
KB3D5:  LDD  BJ_PNT+$DC
KB3D7:  SUBD BJ_PNT+$104
KB3DA:  ORA  #$E0
KB3DC:  STD  $E,Y
KB3DE:  LDD  BJ_PNT+$98             ;draw point 44 to 30
KB3E0:  SUBD BJ_PNT+$DE
KB3E2:  ANDA #$1F
KB3E4:  LEAY $20,Y
KB3E7:  STD  -16,Y
KB3E9:  LDD  BJ_PNT+$96
KB3EB:  SUBD BJ_PNT+$DC
KB3ED:  ORA  #$E0
KB3EF:  STD  -14,Y
KB3F1:  LDD  BJ_PNT+$3E             ;draw point 30 to 12
KB3F3:  SUBD BJ_PNT+$98
KB3F5:  ANDA #$1F
KB3F7:  STD  -12,Y
KB3F9:  LDD  BJ_PNT+$3C
KB3FB:  SUBD BJ_PNT+$96
KB3FD:  ORA  #$E0
KB3FF:  STD  -10,Y
KB401:  LDD  BJ_PNT+$20             ;draw point 12 to 6
KB403:  SUBD BJ_PNT+$3E
KB405:  ANDA #$1F
KB407:  STD  -8,Y
KB409:  LDD  BJ_PNT+$1E
KB40B:  SUBD BJ_PNT+$3C
KB40D:  ORA  #$E0
KB40F:  STD  -6,Y
KB411:  LEAY -4,Y
KB413:  LDA  #$48
KB415:  TFR  A,DP
.dpage $48
KB417:  LDD  BJ_PNT+$1E
KB41A:  STD  BJ_CX
KB41C:  LDD  BJ_PNT+$20
KB41F:  STD  BJ_CY
KB421:  PULS A,B,X,U,PC

;------------------------------------------------------------------------------
; draw_tie_wing - draw routine of objects 1 and 2, the left and the right wing with strut of an exploded TIE
;   fighter (Star Wars' TDS_TI1 and TDS_TI2, explosion piece types 9 and 10): 30 lines at full brightness between
;   points 1 to 18. the two objects differ only in their point tables
;------------------------------------------------------------------------------
draw_tie_wing:
KB423:  LDA  #$4E
KB425:  TFR  A,DP
.dpage $4E
KB427:  LDD  BJ_PNT+$25             ;beam to point 7
KB429:  SUBD BJ_CY
KB42C:  ANDA #$1F
KB42E:  STD  ,Y
KB430:  LDD  BJ_PNT+$23
KB432:  SUBD BJ_CX
KB435:  ANDA #$1F
KB437:  STD  2,Y
KB439:  LDD  BJ_PNT+$2A             ;DRAWTO 0,2,3,1,5,4,0  draw point 7 to 8
KB43B:  SUBD BJ_PNT+$25
KB43D:  ANDA #$1F
KB43F:  STD  4,Y
KB441:  LDD  BJ_PNT+$28
KB443:  SUBD BJ_PNT+$23
KB445:  ORA  #$E0
KB447:  STD  6,Y
KB449:  LDD  BJ_PNT+$2F             ;draw point 8 to 9
KB44B:  SUBD BJ_PNT+$2A
KB44D:  ANDA #$1F
KB44F:  STD  8,Y
KB451:  LDD  BJ_PNT+$2D
KB453:  SUBD BJ_PNT+$28
KB455:  ORA  #$E0
KB457:  STD  $A,Y
KB459:  LDD  BJ_PNT+$34             ;draw point 9 to 10
KB45B:  SUBD BJ_PNT+$2F
KB45D:  ANDA #$1F
KB45F:  STD  $C,Y
KB461:  LDD  BJ_PNT+$32
KB463:  SUBD BJ_PNT+$2D
KB465:  ORA  #$E0
KB467:  STD  $E,Y
KB469:  LDD  BJ_PNT+$39             ;draw point 10 to 11
KB46B:  SUBD BJ_PNT+$34
KB46D:  ANDA #$1F
KB46F:  LEAY $20,Y
KB472:  STD  -16,Y
KB474:  LDD  BJ_PNT+$37
KB476:  SUBD BJ_PNT+$32
KB478:  ORA  #$E0
KB47A:  STD  -14,Y
KB47C:  LDD  BJ_PNT+$3E             ;draw point 11 to 12
KB47E:  SUBD BJ_PNT+$39
KB480:  ANDA #$1F
KB482:  STD  -12,Y
KB484:  LDD  BJ_PNT+$3C
KB486:  SUBD BJ_PNT+$37
KB488:  ORA  #$E0
KB48A:  STD  -10,Y
KB48C:  LDD  BJ_PNT+$25             ;draw point 12 to 7
KB48E:  SUBD BJ_PNT+$3E
KB490:  ANDA #$1F
KB492:  STD  -8,Y
KB494:  LDD  BJ_PNT+$23
KB496:  SUBD BJ_PNT+$3C
KB498:  ORA  #$E0
KB49A:  STD  -6,Y
KB49C:  LDD  BJ_PNT+$43             ;draw point 7 to 13
KB49E:  SUBD BJ_PNT+$25
KB4A0:  ANDA #$1F
KB4A2:  STD  -4,Y
KB4A4:  LDD  BJ_PNT+$41
KB4A6:  SUBD BJ_PNT+$23
KB4A8:  ORA  #$E0
KB4AA:  STD  -2,Y
KB4AC:  LDD  BJ_PNT+$48             ;draw point 13 to 14
KB4AE:  SUBD BJ_PNT+$43
KB4B0:  ANDA #$1F
KB4B2:  STD  ,Y
KB4B4:  LDD  BJ_PNT+$46
KB4B6:  SUBD BJ_PNT+$41
KB4B8:  ORA  #$E0
KB4BA:  STD  2,Y
KB4BC:  LDD  BJ_PNT+$4D             ;DRAWTO 0,2,3,1,5,4,0  draw point 14 to 15
KB4BE:  SUBD BJ_PNT+$48
KB4C0:  ANDA #$1F
KB4C2:  STD  4,Y
KB4C4:  LDD  BJ_PNT+$4B
KB4C6:  SUBD BJ_PNT+$46
KB4C8:  ORA  #$E0
KB4CA:  STD  6,Y
KB4CC:  LDD  BJ_PNT+$52             ;draw point 15 to 16
KB4CE:  SUBD BJ_PNT+$4D
KB4D0:  ANDA #$1F
KB4D2:  STD  8,Y
KB4D4:  LDD  BJ_PNT+$50
KB4D6:  SUBD BJ_PNT+$4B
KB4D8:  ORA  #$E0
KB4DA:  STD  $A,Y
KB4DC:  LDD  BJ_PNT+$57             ;draw point 16 to 17
KB4DE:  SUBD BJ_PNT+$52
KB4E0:  ANDA #$1F
KB4E2:  STD  $C,Y
KB4E4:  LDD  BJ_PNT+$55
KB4E6:  SUBD BJ_PNT+$50
KB4E8:  ORA  #$E0
KB4EA:  STD  $E,Y
KB4EC:  LDD  BJ_PNT+$5C             ;draw point 17 to 18
KB4EE:  SUBD BJ_PNT+$57
KB4F0:  ANDA #$1F
KB4F2:  LEAY $20,Y
KB4F5:  STD  -16,Y
KB4F7:  LDD  BJ_PNT+$5A
KB4F9:  SUBD BJ_PNT+$55
KB4FB:  ORA  #$E0
KB4FD:  STD  -14,Y
KB4FF:  LDD  BJ_PNT+$43             ;draw point 18 to 13
KB501:  SUBD BJ_PNT+$5C
KB503:  ANDA #$1F
KB505:  STD  -12,Y
KB507:  LDD  BJ_PNT+$41
KB509:  SUBD BJ_PNT+$5A
KB50B:  ORA  #$E0
KB50D:  STD  -10,Y
KB50F:  LDD  BJ_PNT+$25             ;move point 13 to 7
KB511:  SUBD BJ_PNT+$43
KB513:  ANDA #$1F
KB515:  STD  -8,Y
KB517:  LDD  BJ_PNT+$23
KB519:  SUBD BJ_PNT+$41
KB51B:  ANDA #$1F
KB51D:  STD  -6,Y
KB51F:  LDD  BJ_PNT+$07             ;draw point 7 to 1
KB521:  SUBD BJ_PNT+$25
KB523:  ANDA #$1F
KB525:  STD  -4,Y
KB527:  LDD  BJ_PNT+$05
KB529:  SUBD BJ_PNT+$23
KB52B:  ORA  #$E0
KB52D:  STD  -2,Y
KB52F:  LDD  BJ_PNT+$0C             ;draw point 1 to 2
KB531:  SUBD BJ_PNT+$07
KB533:  ANDA #$1F
KB535:  STD  ,Y
KB537:  LDD  BJ_PNT+$0A
KB539:  SUBD BJ_PNT+$05
KB53B:  ORA  #$E0
KB53D:  STD  2,Y
KB53F:  LDD  BJ_PNT+$11             ;DRAWTO 0,2,3,1,5,4,0  draw point 2 to 3
KB541:  SUBD BJ_PNT+$0C
KB543:  ANDA #$1F
KB545:  STD  4,Y
KB547:  LDD  BJ_PNT+$0F
KB549:  SUBD BJ_PNT+$0A
KB54B:  ORA  #$E0
KB54D:  STD  6,Y
KB54F:  LDD  BJ_PNT+$16             ;draw point 3 to 4
KB551:  SUBD BJ_PNT+$11
KB553:  ANDA #$1F
KB555:  STD  8,Y
KB557:  LDD  BJ_PNT+$14
KB559:  SUBD BJ_PNT+$0F
KB55B:  ORA  #$E0
KB55D:  STD  $A,Y
KB55F:  LDD  BJ_PNT+$1B             ;draw point 4 to 5
KB561:  SUBD BJ_PNT+$16
KB563:  ANDA #$1F
KB565:  STD  $C,Y
KB567:  LDD  BJ_PNT+$19
KB569:  SUBD BJ_PNT+$14
KB56B:  ORA  #$E0
KB56D:  STD  $E,Y
KB56F:  LDD  BJ_PNT+$20             ;draw point 5 to 6
KB571:  SUBD BJ_PNT+$1B
KB573:  ANDA #$1F
KB575:  LEAY $20,Y
KB578:  STD  -16,Y
KB57A:  LDD  BJ_PNT+$1E
KB57C:  SUBD BJ_PNT+$19
KB57E:  ORA  #$E0
KB580:  STD  -14,Y
KB582:  LDD  BJ_PNT+$07             ;draw point 6 to 1
KB584:  SUBD BJ_PNT+$20
KB586:  ANDA #$1F
KB588:  STD  -12,Y
KB58A:  LDD  BJ_PNT+$05
KB58C:  SUBD BJ_PNT+$1E
KB58E:  ORA  #$E0
KB590:  STD  -10,Y
KB592:  LDD  BJ_PNT+$0C             ;move point 1 to 2
KB594:  SUBD BJ_PNT+$07
KB596:  ANDA #$1F
KB598:  STD  -8,Y
KB59A:  LDD  BJ_PNT+$0A
KB59C:  SUBD BJ_PNT+$05
KB59E:  ANDA #$1F
KB5A0:  STD  -6,Y
KB5A2:  LDD  BJ_PNT+$2A             ;draw point 2 to 8
KB5A4:  SUBD BJ_PNT+$0C
KB5A6:  ANDA #$1F
KB5A8:  STD  -4,Y
KB5AA:  LDD  BJ_PNT+$28
KB5AC:  SUBD BJ_PNT+$0A
KB5AE:  ORA  #$E0
KB5B0:  STD  -2,Y
KB5B2:  LDD  BJ_PNT+$48             ;draw point 8 to 14
KB5B4:  SUBD BJ_PNT+$2A
KB5B6:  ANDA #$1F
KB5B8:  STD  ,Y
KB5BA:  LDD  BJ_PNT+$46
KB5BC:  SUBD BJ_PNT+$28
KB5BE:  ORA  #$E0
KB5C0:  STD  2,Y
KB5C2:  LDD  BJ_PNT+$4D             ;DRAWTO 0,2,3,1,5,4,0  move point 14 to 15
KB5C4:  SUBD BJ_PNT+$48
KB5C6:  ANDA #$1F
KB5C8:  STD  4,Y
KB5CA:  LDD  BJ_PNT+$4B
KB5CC:  SUBD BJ_PNT+$46
KB5CE:  ANDA #$1F
KB5D0:  STD  6,Y
KB5D2:  LDD  BJ_PNT+$2F             ;draw point 15 to 9
KB5D4:  SUBD BJ_PNT+$4D
KB5D6:  ANDA #$1F
KB5D8:  STD  8,Y
KB5DA:  LDD  BJ_PNT+$2D
KB5DC:  SUBD BJ_PNT+$4B
KB5DE:  ORA  #$E0
KB5E0:  STD  $A,Y
KB5E2:  LDD  BJ_PNT+$11             ;draw point 9 to 3
KB5E4:  SUBD BJ_PNT+$2F
KB5E6:  ANDA #$1F
KB5E8:  STD  $C,Y
KB5EA:  LDD  BJ_PNT+$0F
KB5EC:  SUBD BJ_PNT+$2D
KB5EE:  ORA  #$E0
KB5F0:  STD  $E,Y
KB5F2:  LDD  BJ_PNT+$16             ;move point 3 to 4
KB5F4:  SUBD BJ_PNT+$11
KB5F6:  ANDA #$1F
KB5F8:  LEAY $20,Y
KB5FB:  STD  -16,Y
KB5FD:  LDD  BJ_PNT+$14
KB5FF:  SUBD BJ_PNT+$0F
KB601:  ANDA #$1F
KB603:  STD  -14,Y
KB605:  LDD  BJ_PNT+$34             ;draw point 4 to 10
KB607:  SUBD BJ_PNT+$16
KB609:  ANDA #$1F
KB60B:  STD  -12,Y
KB60D:  LDD  BJ_PNT+$32
KB60F:  SUBD BJ_PNT+$14
KB611:  ORA  #$E0
KB613:  STD  -10,Y
KB615:  LDD  BJ_PNT+$52             ;draw point 10 to 16
KB617:  SUBD BJ_PNT+$34
KB619:  ANDA #$1F
KB61B:  STD  -8,Y
KB61D:  LDD  BJ_PNT+$50
KB61F:  SUBD BJ_PNT+$32
KB621:  ORA  #$E0
KB623:  STD  -6,Y
KB625:  LDD  BJ_PNT+$57             ;move point 16 to 17
KB627:  SUBD BJ_PNT+$52
KB629:  ANDA #$1F
KB62B:  STD  -4,Y
KB62D:  LDD  BJ_PNT+$55
KB62F:  SUBD BJ_PNT+$50
KB631:  ANDA #$1F
KB633:  STD  -2,Y
KB635:  LDD  BJ_PNT+$39             ;draw point 17 to 11
KB637:  SUBD BJ_PNT+$57
KB639:  ANDA #$1F
KB63B:  STD  ,Y
KB63D:  LDD  BJ_PNT+$37
KB63F:  SUBD BJ_PNT+$55
KB641:  ORA  #$E0
KB643:  STD  2,Y
KB645:  LDD  BJ_PNT+$1B             ;DRAWTO 0,2,3,1,5,4,0  draw point 11 to 5
KB647:  SUBD BJ_PNT+$39
KB649:  ANDA #$1F
KB64B:  STD  4,Y
KB64D:  LDD  BJ_PNT+$19
KB64F:  SUBD BJ_PNT+$37
KB651:  ORA  #$E0
KB653:  STD  6,Y
KB655:  LDD  BJ_PNT+$20             ;BDRAWTO 1,3,15,12,9  UP RIGHT SIDE  move point 5 to 6
KB657:  SUBD BJ_PNT+$1B
KB659:  ANDA #$1F
KB65B:  STD  8,Y
KB65D:  LDD  BJ_PNT+$1E
KB65F:  SUBD BJ_PNT+$19
KB661:  ANDA #$1F
KB663:  STD  $A,Y
KB665:  LDD  BJ_PNT+$3E             ;draw point 6 to 12
KB667:  SUBD BJ_PNT+$20
KB669:  ANDA #$1F
KB66B:  STD  $C,Y
KB66D:  LDD  BJ_PNT+$3C
KB66F:  SUBD BJ_PNT+$1E
KB671:  ORA  #$E0
KB673:  STD  $E,Y
KB675:  LDD  BJ_PNT+$5C             ;draw point 12 to 18
KB677:  SUBD BJ_PNT+$3E
KB679:  ANDA #$1F
KB67B:  LEAY $20,Y
KB67E:  STD  -16,Y
KB680:  LDD  BJ_PNT+$5A
KB682:  SUBD BJ_PNT+$3C
KB684:  ORA  #$E0
KB686:  STD  -14,Y
KB688:  LEAY -12,Y
KB68A:  LDA  #$48
KB68C:  TFR  A,DP
.dpage $48
KB68E:  LDD  BJ_PNT+$5A
KB691:  STD  BJ_CX
KB693:  LDD  BJ_PNT+$5C
KB696:  STD  BJ_CY
KB698:  PULS A,B,X,U,PC

;------------------------------------------------------------------------------
; draw_tie_cabin - draw routine of object 3, the centre cabin of an exploded TIE fighter (Star Wars' TDS_TI3,
;   explosion piece type 11): 46 lines at full brightness between points 1 to 28
;------------------------------------------------------------------------------
draw_tie_cabin:
KB69A:  LDA  #$4E
KB69C:  TFR  A,DP
.dpage $4E
KB69E:  LDD  BJ_PNT+$07             ;beam to point 1
KB6A0:  SUBD BJ_CY
KB6A3:  ANDA #$1F
KB6A5:  STD  ,Y
KB6A7:  LDD  BJ_PNT+$05
KB6A9:  SUBD BJ_CX
KB6AC:  ANDA #$1F
KB6AE:  STD  2,Y
KB6B0:  LDD  BJ_PNT+$0C             ;DRAWTO 0,2,3,1,5,4,0  draw point 1 to 2
KB6B2:  SUBD BJ_PNT+$07
KB6B4:  ANDA #$1F
KB6B6:  STD  4,Y
KB6B8:  LDD  BJ_PNT+$0A
KB6BA:  SUBD BJ_PNT+$05
KB6BC:  ORA  #$E0
KB6BE:  STD  6,Y
KB6C0:  LDD  BJ_PNT+$11             ;draw point 2 to 3
KB6C2:  SUBD BJ_PNT+$0C
KB6C4:  ANDA #$1F
KB6C6:  STD  8,Y
KB6C8:  LDD  BJ_PNT+$0F
KB6CA:  SUBD BJ_PNT+$0A
KB6CC:  ORA  #$E0
KB6CE:  STD  $A,Y
KB6D0:  LDD  BJ_PNT+$16             ;draw point 3 to 4
KB6D2:  SUBD BJ_PNT+$11
KB6D4:  ANDA #$1F
KB6D6:  STD  $C,Y
KB6D8:  LDD  BJ_PNT+$14
KB6DA:  SUBD BJ_PNT+$0F
KB6DC:  ORA  #$E0
KB6DE:  STD  $E,Y
KB6E0:  LDD  BJ_PNT+$1B             ;draw point 4 to 5
KB6E2:  SUBD BJ_PNT+$16
KB6E4:  ANDA #$1F
KB6E6:  LEAY $20,Y
KB6E9:  STD  -16,Y
KB6EB:  LDD  BJ_PNT+$19
KB6ED:  SUBD BJ_PNT+$14
KB6EF:  ORA  #$E0
KB6F1:  STD  -14,Y
KB6F3:  LDD  BJ_PNT+$07             ;draw point 5 to 1
KB6F5:  SUBD BJ_PNT+$1B
KB6F7:  ANDA #$1F
KB6F9:  STD  -12,Y
KB6FB:  LDD  BJ_PNT+$05
KB6FD:  SUBD BJ_PNT+$19
KB6FF:  ORA  #$E0
KB701:  STD  -10,Y
KB703:  LDD  BJ_PNT+$43             ;draw point 1 to 13
KB705:  SUBD BJ_PNT+$07
KB707:  ANDA #$1F
KB709:  STD  -8,Y
KB70B:  LDD  BJ_PNT+$41
KB70D:  SUBD BJ_PNT+$05
KB70F:  ORA  #$E0
KB711:  STD  -6,Y
KB713:  LDD  BJ_PNT+$48             ;draw point 13 to 14
KB715:  SUBD BJ_PNT+$43
KB717:  ANDA #$1F
KB719:  STD  -4,Y
KB71B:  LDD  BJ_PNT+$46
KB71D:  SUBD BJ_PNT+$41
KB71F:  ORA  #$E0
KB721:  STD  -2,Y
KB723:  LDD  BJ_PNT+$4D             ;draw point 14 to 15
KB725:  SUBD BJ_PNT+$48
KB727:  ANDA #$1F
KB729:  STD  ,Y
KB72B:  LDD  BJ_PNT+$4B
KB72D:  SUBD BJ_PNT+$46
KB72F:  ORA  #$E0
KB731:  STD  2,Y
KB733:  LDD  BJ_PNT+$75             ;DRAWTO 0,2,3,1,5,4,0  draw point 15 to 23
KB735:  SUBD BJ_PNT+$4D
KB737:  ANDA #$1F
KB739:  STD  4,Y
KB73B:  LDD  BJ_PNT+$73
KB73D:  SUBD BJ_PNT+$4B
KB73F:  ORA  #$E0
KB741:  STD  6,Y
KB743:  LDD  BJ_PNT+$4D             ;BDRAWTO 1,3,15,12,9  UP RIGHT SIDE  move point 23 to 15
KB745:  SUBD BJ_PNT+$75
KB747:  ANDA #$1F
KB749:  STD  8,Y
KB74B:  LDD  BJ_PNT+$4B
KB74D:  SUBD BJ_PNT+$73
KB74F:  ANDA #$1F
KB751:  STD  $A,Y
KB753:  LDD  BJ_PNT+$52             ;draw point 15 to 16
KB755:  SUBD BJ_PNT+$4D
KB757:  ANDA #$1F
KB759:  STD  $C,Y
KB75B:  LDD  BJ_PNT+$50
KB75D:  SUBD BJ_PNT+$4B
KB75F:  ORA  #$E0
KB761:  STD  $E,Y
KB763:  LDD  BJ_PNT+$57             ;draw point 16 to 17
KB765:  SUBD BJ_PNT+$52
KB767:  ANDA #$1F
KB769:  LEAY $20,Y
KB76C:  STD  -16,Y
KB76E:  LDD  BJ_PNT+$55
KB770:  SUBD BJ_PNT+$50
KB772:  ORA  #$E0
KB774:  STD  -14,Y
KB776:  LDD  BJ_PNT+$7F             ;draw point 17 to 25
KB778:  SUBD BJ_PNT+$57
KB77A:  ANDA #$1F
KB77C:  STD  -12,Y
KB77E:  LDD  BJ_PNT+$7D
KB780:  SUBD BJ_PNT+$55
KB782:  ORA  #$E0
KB784:  STD  -10,Y
KB786:  LDD  BJ_PNT+$57             ;move point 25 to 17
KB788:  SUBD BJ_PNT+$7F
KB78A:  ANDA #$1F
KB78C:  STD  -8,Y
KB78E:  LDD  BJ_PNT+$55
KB790:  SUBD BJ_PNT+$7D
KB792:  ANDA #$1F
KB794:  STD  -6,Y
KB796:  LDD  BJ_PNT+$5C             ;draw point 17 to 18
KB798:  SUBD BJ_PNT+$57
KB79A:  ANDA #$1F
KB79C:  STD  -4,Y
KB79E:  LDD  BJ_PNT+$5A
KB7A0:  SUBD BJ_PNT+$55
KB7A2:  ORA  #$E0
KB7A4:  STD  -2,Y
KB7A6:  LDD  BJ_PNT+$61             ;draw point 18 to 19
KB7A8:  SUBD BJ_PNT+$5C
KB7AA:  ANDA #$1F
KB7AC:  STD  ,Y
KB7AE:  LDD  BJ_PNT+$5F
KB7B0:  SUBD BJ_PNT+$5A
KB7B2:  ORA  #$E0
KB7B4:  STD  2,Y
KB7B6:  LDD  BJ_PNT+$66             ;DRAWTO 0,2,3,1,5,4,0  draw point 19 to 20
KB7B8:  SUBD BJ_PNT+$61
KB7BA:  ANDA #$1F
KB7BC:  STD  4,Y
KB7BE:  LDD  BJ_PNT+$64
KB7C0:  SUBD BJ_PNT+$5F
KB7C2:  ORA  #$E0
KB7C4:  STD  6,Y
KB7C6:  LDD  BJ_PNT+$43             ;draw point 20 to 13
KB7C8:  SUBD BJ_PNT+$66
KB7CA:  ANDA #$1F
KB7CC:  STD  8,Y
KB7CE:  LDD  BJ_PNT+$41
KB7D0:  SUBD BJ_PNT+$64
KB7D2:  ORA  #$E0
KB7D4:  STD  $A,Y
KB7D6:  LDD  BJ_PNT+$6B             ;draw point 13 to 21
KB7D8:  SUBD BJ_PNT+$43
KB7DA:  ANDA #$1F
KB7DC:  STD  $C,Y
KB7DE:  LDD  BJ_PNT+$69
KB7E0:  SUBD BJ_PNT+$41
KB7E2:  ORA  #$E0
KB7E4:  STD  $E,Y
KB7E6:  LDD  BJ_PNT+$70             ;draw point 21 to 22
KB7E8:  SUBD BJ_PNT+$6B
KB7EA:  ANDA #$1F
KB7EC:  LEAY $20,Y
KB7EF:  STD  -16,Y
KB7F1:  LDD  BJ_PNT+$6E
KB7F3:  SUBD BJ_PNT+$69
KB7F5:  ORA  #$E0
KB7F7:  STD  -14,Y
KB7F9:  LDD  BJ_PNT+$75             ;draw point 22 to 23
KB7FB:  SUBD BJ_PNT+$70
KB7FD:  ANDA #$1F
KB7FF:  STD  -12,Y
KB801:  LDD  BJ_PNT+$73
KB803:  SUBD BJ_PNT+$6E
KB805:  ORA  #$E0
KB807:  STD  -10,Y
KB809:  LDD  BJ_PNT+$7A             ;draw point 23 to 24
KB80B:  SUBD BJ_PNT+$75
KB80D:  ANDA #$1F
KB80F:  STD  -8,Y
KB811:  LDD  BJ_PNT+$78
KB813:  SUBD BJ_PNT+$73
KB815:  ORA  #$E0
KB817:  STD  -6,Y
KB819:  LDD  BJ_PNT+$7F             ;draw point 24 to 25
KB81B:  SUBD BJ_PNT+$7A
KB81D:  ANDA #$1F
KB81F:  STD  -4,Y
KB821:  LDD  BJ_PNT+$7D
KB823:  SUBD BJ_PNT+$78
KB825:  ORA  #$E0
KB827:  STD  -2,Y
KB829:  LDD  BJ_PNT+$84             ;draw point 25 to 26
KB82B:  SUBD BJ_PNT+$7F
KB82D:  ANDA #$1F
KB82F:  STD  ,Y
KB831:  LDD  BJ_PNT+$82
KB833:  SUBD BJ_PNT+$7D
KB835:  ORA  #$E0
KB837:  STD  2,Y
KB839:  LDD  BJ_PNT+$89             ;DRAWTO 0,2,3,1,5,4,0  draw point 26 to 27
KB83B:  SUBD BJ_PNT+$84
KB83D:  ANDA #$1F
KB83F:  STD  4,Y
KB841:  LDD  BJ_PNT+$87
KB843:  SUBD BJ_PNT+$82
KB845:  ORA  #$E0
KB847:  STD  6,Y
KB849:  LDD  BJ_PNT+$8E             ;draw point 27 to 28
KB84B:  SUBD BJ_PNT+$89
KB84D:  ANDA #$1F
KB84F:  STD  8,Y
KB851:  LDD  BJ_PNT+$8C
KB853:  SUBD BJ_PNT+$87
KB855:  ORA  #$E0
KB857:  STD  $A,Y
KB859:  LDD  BJ_PNT+$6B             ;draw point 28 to 21
KB85B:  SUBD BJ_PNT+$8E
KB85D:  ANDA #$1F
KB85F:  STD  $C,Y
KB861:  LDD  BJ_PNT+$69
KB863:  SUBD BJ_PNT+$8C
KB865:  ORA  #$E0
KB867:  STD  $E,Y
KB869:  LDD  BJ_PNT+$25             ;draw point 21 to 7
KB86B:  SUBD BJ_PNT+$6B
KB86D:  ANDA #$1F
KB86F:  LEAY $20,Y
KB872:  STD  -16,Y
KB874:  LDD  BJ_PNT+$23
KB876:  SUBD BJ_PNT+$69
KB878:  ORA  #$E0
KB87A:  STD  -14,Y
KB87C:  LDD  BJ_PNT+$2A             ;draw point 7 to 8
KB87E:  SUBD BJ_PNT+$25
KB880:  ANDA #$1F
KB882:  STD  -12,Y
KB884:  LDD  BJ_PNT+$28
KB886:  SUBD BJ_PNT+$23
KB888:  ORA  #$E0
KB88A:  STD  -10,Y
KB88C:  LDD  BJ_PNT+$2F             ;draw point 8 to 9
KB88E:  SUBD BJ_PNT+$2A
KB890:  ANDA #$1F
KB892:  STD  -8,Y
KB894:  LDD  BJ_PNT+$2D
KB896:  SUBD BJ_PNT+$28
KB898:  ORA  #$E0
KB89A:  STD  -6,Y
KB89C:  LDD  BJ_PNT+$34             ;draw point 9 to 10
KB89E:  SUBD BJ_PNT+$2F
KB8A0:  ANDA #$1F
KB8A2:  STD  -4,Y
KB8A4:  LDD  BJ_PNT+$32
KB8A6:  SUBD BJ_PNT+$2D
KB8A8:  ORA  #$E0
KB8AA:  STD  -2,Y
KB8AC:  LDD  BJ_PNT+$39             ;draw point 10 to 11
KB8AE:  SUBD BJ_PNT+$34
KB8B0:  ANDA #$1F
KB8B2:  STD  ,Y
KB8B4:  LDD  BJ_PNT+$37
KB8B6:  SUBD BJ_PNT+$32
KB8B8:  ORA  #$E0
KB8BA:  STD  2,Y
KB8BC:  LDD  BJ_PNT+$3E             ;DRAWTO 0,2,3,1,5,4,0  draw point 11 to 12
KB8BE:  SUBD BJ_PNT+$39
KB8C0:  ANDA #$1F
KB8C2:  STD  4,Y
KB8C4:  LDD  BJ_PNT+$3C
KB8C6:  SUBD BJ_PNT+$37
KB8C8:  ORA  #$E0
KB8CA:  STD  6,Y
KB8CC:  LDD  BJ_PNT+$25             ;draw point 12 to 7
KB8CE:  SUBD BJ_PNT+$3E
KB8D0:  ANDA #$1F
KB8D2:  STD  8,Y
KB8D4:  LDD  BJ_PNT+$23
KB8D6:  SUBD BJ_PNT+$3C
KB8D8:  ORA  #$E0
KB8DA:  STD  $A,Y
KB8DC:  LDD  BJ_PNT+$2A             ;move point 7 to 8
KB8DE:  SUBD BJ_PNT+$25
KB8E0:  ANDA #$1F
KB8E2:  STD  $C,Y
KB8E4:  LDD  BJ_PNT+$28
KB8E6:  SUBD BJ_PNT+$23
KB8E8:  ANDA #$1F
KB8EA:  STD  $E,Y
KB8EC:  LDD  BJ_PNT+$70             ;draw point 8 to 22
KB8EE:  SUBD BJ_PNT+$2A
KB8F0:  ANDA #$1F
KB8F2:  LEAY $20,Y
KB8F5:  STD  -16,Y
KB8F7:  LDD  BJ_PNT+$6E
KB8F9:  SUBD BJ_PNT+$28
KB8FB:  ORA  #$E0
KB8FD:  STD  -14,Y
KB8FF:  LDD  BJ_PNT+$48             ;draw point 22 to 14
KB901:  SUBD BJ_PNT+$70
KB903:  ANDA #$1F
KB905:  STD  -12,Y
KB907:  LDD  BJ_PNT+$46
KB909:  SUBD BJ_PNT+$6E
KB90B:  ORA  #$E0
KB90D:  STD  -10,Y
KB90F:  LDD  BJ_PNT+$0C             ;draw point 14 to 2
KB911:  SUBD BJ_PNT+$48
KB913:  ANDA #$1F
KB915:  STD  -8,Y
KB917:  LDD  BJ_PNT+$0A
KB919:  SUBD BJ_PNT+$46
KB91B:  ORA  #$E0
KB91D:  STD  -6,Y
KB91F:  LDD  BJ_PNT+$11             ;move point 2 to 3
KB921:  SUBD BJ_PNT+$0C
KB923:  ANDA #$1F
KB925:  STD  -4,Y
KB927:  LDD  BJ_PNT+$0F
KB929:  SUBD BJ_PNT+$0A
KB92B:  ANDA #$1F
KB92D:  STD  -2,Y
KB92F:  LDD  BJ_PNT+$52             ;draw point 3 to 16
KB931:  SUBD BJ_PNT+$11
KB933:  ANDA #$1F
KB935:  STD  ,Y
KB937:  LDD  BJ_PNT+$50
KB939:  SUBD BJ_PNT+$0F
KB93B:  ORA  #$E0
KB93D:  STD  2,Y
KB93F:  LDD  BJ_PNT+$7A             ;DRAWTO 0,2,3,1,5,4,0  move point 16 to 24
KB941:  SUBD BJ_PNT+$52
KB943:  ANDA #$1F
KB945:  STD  4,Y
KB947:  LDD  BJ_PNT+$78
KB949:  SUBD BJ_PNT+$50
KB94B:  ANDA #$1F
KB94D:  STD  6,Y
KB94F:  LDD  BJ_PNT+$2F             ;draw point 24 to 9
KB951:  SUBD BJ_PNT+$7A
KB953:  ANDA #$1F
KB955:  STD  8,Y
KB957:  LDD  BJ_PNT+$2D
KB959:  SUBD BJ_PNT+$78
KB95B:  ORA  #$E0
KB95D:  STD  $A,Y
KB95F:  LDD  BJ_PNT+$34             ;move point 9 to 10
KB961:  SUBD BJ_PNT+$2F
KB963:  ANDA #$1F
KB965:  STD  $C,Y
KB967:  LDD  BJ_PNT+$32
KB969:  SUBD BJ_PNT+$2D
KB96B:  ANDA #$1F
KB96D:  STD  $E,Y
KB96F:  LDD  BJ_PNT+$84             ;draw point 10 to 26
KB971:  SUBD BJ_PNT+$34
KB973:  ANDA #$1F
KB975:  LEAY $20,Y
KB978:  STD  -16,Y
KB97A:  LDD  BJ_PNT+$82
KB97C:  SUBD BJ_PNT+$32
KB97E:  ORA  #$E0
KB980:  STD  -14,Y
KB982:  LDD  BJ_PNT+$5C             ;draw point 26 to 18
KB984:  SUBD BJ_PNT+$84
KB986:  ANDA #$1F
KB988:  STD  -12,Y
KB98A:  LDD  BJ_PNT+$5A
KB98C:  SUBD BJ_PNT+$82
KB98E:  ORA  #$E0
KB990:  STD  -10,Y
KB992:  LDD  BJ_PNT+$16             ;draw point 18 to 4
KB994:  SUBD BJ_PNT+$5C
KB996:  ANDA #$1F
KB998:  STD  -8,Y
KB99A:  LDD  BJ_PNT+$14
KB99C:  SUBD BJ_PNT+$5A
KB99E:  ORA  #$E0
KB9A0:  STD  -6,Y
KB9A2:  LDD  BJ_PNT+$1B             ;move point 4 to 5
KB9A4:  SUBD BJ_PNT+$16
KB9A6:  ANDA #$1F
KB9A8:  STD  -4,Y
KB9AA:  LDD  BJ_PNT+$19
KB9AC:  SUBD BJ_PNT+$14
KB9AE:  ANDA #$1F
KB9B0:  STD  -2,Y
KB9B2:  LDD  BJ_PNT+$61             ;draw point 5 to 19
KB9B4:  SUBD BJ_PNT+$1B
KB9B6:  ANDA #$1F
KB9B8:  STD  ,Y
KB9BA:  LDD  BJ_PNT+$5F
KB9BC:  SUBD BJ_PNT+$19
KB9BE:  ORA  #$E0
KB9C0:  STD  2,Y
KB9C2:  LDD  BJ_PNT+$89             ;DRAWTO 0,2,3,1,5,4,0  draw point 19 to 27
KB9C4:  SUBD BJ_PNT+$61
KB9C6:  ANDA #$1F
KB9C8:  STD  4,Y
KB9CA:  LDD  BJ_PNT+$87
KB9CC:  SUBD BJ_PNT+$5F
KB9CE:  ORA  #$E0
KB9D0:  STD  6,Y
KB9D2:  LDD  BJ_PNT+$39             ;draw point 27 to 11
KB9D4:  SUBD BJ_PNT+$89
KB9D6:  ANDA #$1F
KB9D8:  STD  8,Y
KB9DA:  LDD  BJ_PNT+$37
KB9DC:  SUBD BJ_PNT+$87
KB9DE:  ORA  #$E0
KB9E0:  STD  $A,Y
KB9E2:  LDD  BJ_PNT+$3E             ;move point 11 to 12
KB9E4:  SUBD BJ_PNT+$39
KB9E6:  ANDA #$1F
KB9E8:  STD  $C,Y
KB9EA:  LDD  BJ_PNT+$3C
KB9EC:  SUBD BJ_PNT+$37
KB9EE:  ANDA #$1F
KB9F0:  STD  $E,Y
KB9F2:  LDD  BJ_PNT+$8E             ;draw point 12 to 28
KB9F4:  SUBD BJ_PNT+$3E
KB9F6:  ANDA #$1F
KB9F8:  LEAY $20,Y
KB9FB:  STD  -16,Y
KB9FD:  LDD  BJ_PNT+$8C
KB9FF:  SUBD BJ_PNT+$3C
KBA01:  ORA  #$E0
KBA03:  STD  -14,Y
KBA05:  LDD  BJ_PNT+$66             ;draw point 28 to 20
KBA07:  SUBD BJ_PNT+$8E
KBA09:  ANDA #$1F
KBA0B:  STD  -12,Y
KBA0D:  LDD  BJ_PNT+$64
KBA0F:  SUBD BJ_PNT+$8C
KBA11:  ORA  #$E0
KBA13:  STD  -10,Y
KBA15:  LDD  BJ_PNT+$20             ;draw point 20 to 6
KBA17:  SUBD BJ_PNT+$66
KBA19:  ANDA #$1F
KBA1B:  STD  -8,Y
KBA1D:  LDD  BJ_PNT+$1E
KBA1F:  SUBD BJ_PNT+$64
KBA21:  ORA  #$E0
KBA23:  STD  -6,Y
KBA25:  LEAY -4,Y
KBA27:  LDA  #$48
KBA29:  TFR  A,DP
.dpage $48
KBA2B:  LDD  BJ_PNT+$1E
KBA2E:  STD  BJ_CX
KBA30:  LDD  BJ_PNT+$20
KBA33:  STD  BJ_CY
KBA35:  PULS A,B,X,U,PC

;------------------------------------------------------------------------------
; draw_probot_body - draw routine of objects 4 and 5, which make one picture, the body of a probot: object 4 (19
;   points, a three-ring hexagonal body below the head) is perspected into buffer points 1 to 19 and object 5 (a
;   hexagon of 6 points) into points 20 to 25, and this routine draws 36 lines, the last six from the body's top
;   ring to the points of object 5. brightness of each line comes from the depth cue flags of its two points. page
;   2 processes object 4, then object 5 raised by the probot's bob offset, and draws once
;------------------------------------------------------------------------------
draw_probot_body:
KBA37:  LDA  #$4E
KBA39:  TFR  A,DP
.dpage $4E
KBA3B:  LDD  BJ_PNT+$07             ;beam to point 1
KBA3D:  SUBD BJ_CY
KBA40:  ANDA #$1F
KBA42:  STD  ,Y
KBA44:  LDD  BJ_PNT+$05
KBA46:  SUBD BJ_CX
KBA49:  ANDA #$1F
KBA4B:  STD  2,Y
KBA4D:  LDD  BJ_PNT+$0C             ;DRAWTO 0,2,3,1,5,4,0  draw point 1 to 2, intensity from the two points' flag bytes
KBA4F:  SUBD BJ_PNT+$07
KBA51:  ANDA #$1F
KBA53:  STD  4,Y
KBA55:  LDD  BJ_PNT+$0A
KBA57:  SUBD BJ_PNT+$05
KBA59:  ANDA #$1F
KBA5B:  ORA  BJ_PNT+$0E
KBA5D:  ADDA BJ_PNT+$09
KBA5F:  STD  6,Y
KBA61:  LDD  BJ_PNT+$11             ;BDRAWTO 1,3,15,12,9  UP RIGHT SIDE  draw point 2 to 3, intensity from the two points' flag bytes
KBA63:  SUBD BJ_PNT+$0C
KBA65:  ANDA #$1F
KBA67:  STD  8,Y
KBA69:  LDD  BJ_PNT+$0F
KBA6B:  SUBD BJ_PNT+$0A
KBA6D:  ANDA #$1F
KBA6F:  ORA  BJ_PNT+$13
KBA71:  ADDA BJ_PNT+$0E
KBA73:  STD  $A,Y
KBA75:  LDD  BJ_PNT+$16             ;draw point 3 to 4, intensity from the two points' flag bytes
KBA77:  SUBD BJ_PNT+$11
KBA79:  ANDA #$1F
KBA7B:  STD  $C,Y
KBA7D:  LDD  BJ_PNT+$14
KBA7F:  SUBD BJ_PNT+$0F
KBA81:  ANDA #$1F
KBA83:  ORA  BJ_PNT+$18
KBA85:  ADDA BJ_PNT+$13
KBA87:  STD  $E,Y
KBA89:  LDD  BJ_PNT+$1B             ;draw point 4 to 5, intensity from the two points' flag bytes
KBA8B:  SUBD BJ_PNT+$16
KBA8D:  ANDA #$1F
KBA8F:  LEAY $20,Y
KBA92:  STD  -16,Y
KBA94:  LDD  BJ_PNT+$19
KBA96:  SUBD BJ_PNT+$14
KBA98:  ANDA #$1F
KBA9A:  ORA  BJ_PNT+$1D
KBA9C:  ADDA BJ_PNT+$18
KBA9E:  STD  -14,Y
KBAA0:  LDD  BJ_PNT+$20             ;draw point 5 to 6, intensity from the two points' flag bytes
KBAA2:  SUBD BJ_PNT+$1B
KBAA4:  ANDA #$1F
KBAA6:  STD  -12,Y
KBAA8:  LDD  BJ_PNT+$1E
KBAAA:  SUBD BJ_PNT+$19
KBAAC:  ANDA #$1F
KBAAE:  ORA  BJ_PNT+$22
KBAB0:  ADDA BJ_PNT+$1D
KBAB2:  STD  -10,Y
KBAB4:  LDD  BJ_PNT+$07             ;draw point 6 to 1, intensity from the two points' flag bytes
KBAB6:  SUBD BJ_PNT+$20
KBAB8:  ANDA #$1F
KBABA:  STD  -8,Y
KBABC:  LDD  BJ_PNT+$05
KBABE:  SUBD BJ_PNT+$1E
KBAC0:  ANDA #$1F
KBAC2:  ORA  BJ_PNT+$09
KBAC4:  ADDA BJ_PNT+$22
KBAC6:  STD  -6,Y
KBAC8:  LDD  BJ_PNT+$25             ;draw point 1 to 7, intensity from the two points' flag bytes
KBACA:  SUBD BJ_PNT+$07
KBACC:  ANDA #$1F
KBACE:  STD  -4,Y
KBAD0:  LDD  BJ_PNT+$23
KBAD2:  SUBD BJ_PNT+$05
KBAD4:  ANDA #$1F
KBAD6:  ORA  BJ_PNT+$27
KBAD8:  ADDA BJ_PNT+$09
KBADA:  STD  -2,Y
KBADC:  LDD  BJ_PNT+$2A             ;draw point 7 to 8, intensity from the two points' flag bytes
KBADE:  SUBD BJ_PNT+$25
KBAE0:  ANDA #$1F
KBAE2:  STD  ,Y
KBAE4:  LDD  BJ_PNT+$28
KBAE6:  SUBD BJ_PNT+$23
KBAE8:  ANDA #$1F
KBAEA:  ORA  BJ_PNT+$2C
KBAEC:  ADDA BJ_PNT+$27
KBAEE:  STD  2,Y
KBAF0:  LDD  BJ_PNT+$2F             ;draw point 8 to 9, intensity from the two points' flag bytes
KBAF2:  SUBD BJ_PNT+$2A
KBAF4:  ANDA #$1F
KBAF6:  STD  4,Y
KBAF8:  LDD  BJ_PNT+$2D
KBAFA:  SUBD BJ_PNT+$28
KBAFC:  ANDA #$1F
KBAFE:  ORA  BJ_PNT+$31
KBB00:  ADDA BJ_PNT+$2C
KBB02:  STD  6,Y
KBB04:  LDD  BJ_PNT+$34             ;BDRAWTO 1,3,15,12,9  UP RIGHT SIDE  draw point 9 to 10, intensity from the two points' flag bytes
KBB06:  SUBD BJ_PNT+$2F
KBB08:  ANDA #$1F
KBB0A:  STD  8,Y
KBB0C:  LDD  BJ_PNT+$32
KBB0E:  SUBD BJ_PNT+$2D
KBB10:  ANDA #$1F
KBB12:  ORA  BJ_PNT+$36
KBB14:  ADDA BJ_PNT+$31
KBB16:  STD  $A,Y
KBB18:  LDD  BJ_PNT+$39             ;draw point 10 to 11, intensity from the two points' flag bytes
KBB1A:  SUBD BJ_PNT+$34
KBB1C:  ANDA #$1F
KBB1E:  STD  $C,Y
KBB20:  LDD  BJ_PNT+$37
KBB22:  SUBD BJ_PNT+$32
KBB24:  ANDA #$1F
KBB26:  ORA  BJ_PNT+$3B
KBB28:  ADDA BJ_PNT+$36
KBB2A:  STD  $E,Y
KBB2C:  LDD  BJ_PNT+$3E             ;draw point 11 to 12, intensity from the two points' flag bytes
KBB2E:  SUBD BJ_PNT+$39
KBB30:  ANDA #$1F
KBB32:  LEAY $20,Y
KBB35:  STD  -16,Y
KBB37:  LDD  BJ_PNT+$3C
KBB39:  SUBD BJ_PNT+$37
KBB3B:  ANDA #$1F
KBB3D:  ORA  BJ_PNT+$40
KBB3F:  ADDA BJ_PNT+$3B
KBB41:  STD  -14,Y
KBB43:  LDD  BJ_PNT+$25             ;draw point 12 to 7, intensity from the two points' flag bytes
KBB45:  SUBD BJ_PNT+$3E
KBB47:  ANDA #$1F
KBB49:  STD  -12,Y
KBB4B:  LDD  BJ_PNT+$23
KBB4D:  SUBD BJ_PNT+$3C
KBB4F:  ANDA #$1F
KBB51:  ORA  BJ_PNT+$27
KBB53:  ADDA BJ_PNT+$40
KBB55:  STD  -10,Y
KBB57:  LDD  BJ_PNT+$43             ;draw point 7 to 13, intensity from the two points' flag bytes
KBB59:  SUBD BJ_PNT+$25
KBB5B:  ANDA #$1F
KBB5D:  STD  -8,Y
KBB5F:  LDD  BJ_PNT+$41
KBB61:  SUBD BJ_PNT+$23
KBB63:  ANDA #$1F
KBB65:  ORA  BJ_PNT+$45
KBB67:  ADDA BJ_PNT+$27
KBB69:  STD  -6,Y
KBB6B:  LDD  BJ_PNT+$48             ;draw point 13 to 14, intensity from the two points' flag bytes
KBB6D:  SUBD BJ_PNT+$43
KBB6F:  ANDA #$1F
KBB71:  STD  -4,Y
KBB73:  LDD  BJ_PNT+$46
KBB75:  SUBD BJ_PNT+$41
KBB77:  ANDA #$1F
KBB79:  ORA  BJ_PNT+$4A
KBB7B:  ADDA BJ_PNT+$45
KBB7D:  STD  -2,Y
KBB7F:  LDD  BJ_PNT+$4D             ;draw point 14 to 15, intensity from the two points' flag bytes
KBB81:  SUBD BJ_PNT+$48
KBB83:  ANDA #$1F
KBB85:  STD  ,Y
KBB87:  LDD  BJ_PNT+$4B
KBB89:  SUBD BJ_PNT+$46
KBB8B:  ANDA #$1F
KBB8D:  ORA  BJ_PNT+$4F
KBB8F:  ADDA BJ_PNT+$4A
KBB91:  STD  2,Y
KBB93:  LDD  BJ_PNT+$52             ;draw point 15 to 16, intensity from the two points' flag bytes
KBB95:  SUBD BJ_PNT+$4D
KBB97:  ANDA #$1F
KBB99:  STD  4,Y
KBB9B:  LDD  BJ_PNT+$50
KBB9D:  SUBD BJ_PNT+$4B
KBB9F:  ANDA #$1F
KBBA1:  ORA  BJ_PNT+$54
KBBA3:  ADDA BJ_PNT+$4F
KBBA5:  STD  6,Y
KBBA7:  LDD  BJ_PNT+$57             ;BDRAWTO 1,3,15,12,9  UP RIGHT SIDE  draw point 16 to 17, intensity from the two points' flag bytes
KBBA9:  SUBD BJ_PNT+$52
KBBAB:  ANDA #$1F
KBBAD:  STD  8,Y
KBBAF:  LDD  BJ_PNT+$55
KBBB1:  SUBD BJ_PNT+$50
KBBB3:  ANDA #$1F
KBBB5:  ORA  BJ_PNT+$59
KBBB7:  ADDA BJ_PNT+$54
KBBB9:  STD  $A,Y
KBBBB:  LDD  BJ_PNT+$5C             ;draw point 17 to 18, intensity from the two points' flag bytes
KBBBD:  SUBD BJ_PNT+$57
KBBBF:  ANDA #$1F
KBBC1:  STD  $C,Y
KBBC3:  LDD  BJ_PNT+$5A
KBBC5:  SUBD BJ_PNT+$55
KBBC7:  ANDA #$1F
KBBC9:  ORA  BJ_PNT+$5E
KBBCB:  ADDA BJ_PNT+$59
KBBCD:  STD  $E,Y
KBBCF:  LDD  BJ_PNT+$43             ;draw point 18 to 13, intensity from the two points' flag bytes
KBBD1:  SUBD BJ_PNT+$5C
KBBD3:  ANDA #$1F
KBBD5:  LEAY $20,Y
KBBD8:  STD  -16,Y
KBBDA:  LDD  BJ_PNT+$41
KBBDC:  SUBD BJ_PNT+$5A
KBBDE:  ANDA #$1F
KBBE0:  ORA  BJ_PNT+$45
KBBE2:  ADDA BJ_PNT+$5E
KBBE4:  STD  -14,Y
KBBE6:  LDD  BJ_PNT+$48             ;move point 13 to 14
KBBE8:  SUBD BJ_PNT+$43
KBBEA:  ANDA #$1F
KBBEC:  STD  -12,Y
KBBEE:  LDD  BJ_PNT+$46
KBBF0:  SUBD BJ_PNT+$41
KBBF2:  ANDA #$1F
KBBF4:  STD  -10,Y
KBBF6:  LDD  BJ_PNT+$2A             ;draw point 14 to 8, intensity from the two points' flag bytes
KBBF8:  SUBD BJ_PNT+$48
KBBFA:  ANDA #$1F
KBBFC:  STD  -8,Y
KBBFE:  LDD  BJ_PNT+$28
KBC00:  SUBD BJ_PNT+$46
KBC02:  ANDA #$1F
KBC04:  ORA  BJ_PNT+$2C
KBC06:  ADDA BJ_PNT+$4A
KBC08:  STD  -6,Y
KBC0A:  LDD  BJ_PNT+$0C             ;draw point 8 to 2, intensity from the two points' flag bytes
KBC0C:  SUBD BJ_PNT+$2A
KBC0E:  ANDA #$1F
KBC10:  STD  -4,Y
KBC12:  LDD  BJ_PNT+$0A
KBC14:  SUBD BJ_PNT+$28
KBC16:  ANDA #$1F
KBC18:  ORA  BJ_PNT+$0E
KBC1A:  ADDA BJ_PNT+$2C
KBC1C:  STD  -2,Y
KBC1E:  LDD  BJ_PNT+$11             ;move point 2 to 3
KBC20:  SUBD BJ_PNT+$0C
KBC22:  ANDA #$1F
KBC24:  STD  ,Y
KBC26:  LDD  BJ_PNT+$0F
KBC28:  SUBD BJ_PNT+$0A
KBC2A:  ANDA #$1F
KBC2C:  STD  2,Y
KBC2E:  LDD  BJ_PNT+$2F             ;DRAWTO 0,2,3,1,5,4,0  draw point 3 to 9, intensity from the two points' flag bytes
KBC30:  SUBD BJ_PNT+$11
KBC32:  ANDA #$1F
KBC34:  STD  4,Y
KBC36:  LDD  BJ_PNT+$2D
KBC38:  SUBD BJ_PNT+$0F
KBC3A:  ANDA #$1F
KBC3C:  ORA  BJ_PNT+$31
KBC3E:  ADDA BJ_PNT+$13
KBC40:  STD  6,Y
KBC42:  LDD  BJ_PNT+$4D             ;BDRAWTO 1,3,15,12,9  UP RIGHT SIDE  draw point 9 to 15, intensity from the two points' flag bytes
KBC44:  SUBD BJ_PNT+$2F
KBC46:  ANDA #$1F
KBC48:  STD  8,Y
KBC4A:  LDD  BJ_PNT+$4B
KBC4C:  SUBD BJ_PNT+$2D
KBC4E:  ANDA #$1F
KBC50:  ORA  BJ_PNT+$4F
KBC52:  ADDA BJ_PNT+$31
KBC54:  STD  $A,Y
KBC56:  LDD  BJ_PNT+$52             ;move point 15 to 16
KBC58:  SUBD BJ_PNT+$4D
KBC5A:  ANDA #$1F
KBC5C:  STD  $C,Y
KBC5E:  LDD  BJ_PNT+$50
KBC60:  SUBD BJ_PNT+$4B
KBC62:  ANDA #$1F
KBC64:  STD  $E,Y
KBC66:  LDD  BJ_PNT+$34             ;draw point 16 to 10, intensity from the two points' flag bytes
KBC68:  SUBD BJ_PNT+$52
KBC6A:  ANDA #$1F
KBC6C:  LEAY $20,Y
KBC6F:  STD  -16,Y
KBC71:  LDD  BJ_PNT+$32
KBC73:  SUBD BJ_PNT+$50
KBC75:  ANDA #$1F
KBC77:  ORA  BJ_PNT+$36
KBC79:  ADDA BJ_PNT+$54
KBC7B:  STD  -14,Y
KBC7D:  LDD  BJ_PNT+$16             ;draw point 10 to 4, intensity from the two points' flag bytes
KBC7F:  SUBD BJ_PNT+$34
KBC81:  ANDA #$1F
KBC83:  STD  -12,Y
KBC85:  LDD  BJ_PNT+$14
KBC87:  SUBD BJ_PNT+$32
KBC89:  ANDA #$1F
KBC8B:  ORA  BJ_PNT+$18
KBC8D:  ADDA BJ_PNT+$36
KBC8F:  STD  -10,Y
KBC91:  LDD  BJ_PNT+$1B             ;move point 4 to 5
KBC93:  SUBD BJ_PNT+$16
KBC95:  ANDA #$1F
KBC97:  STD  -8,Y
KBC99:  LDD  BJ_PNT+$19
KBC9B:  SUBD BJ_PNT+$14
KBC9D:  ANDA #$1F
KBC9F:  STD  -6,Y
KBCA1:  LDD  BJ_PNT+$39             ;draw point 5 to 11, intensity from the two points' flag bytes
KBCA3:  SUBD BJ_PNT+$1B
KBCA5:  ANDA #$1F
KBCA7:  STD  -4,Y
KBCA9:  LDD  BJ_PNT+$37
KBCAB:  SUBD BJ_PNT+$19
KBCAD:  ANDA #$1F
KBCAF:  ORA  BJ_PNT+$3B
KBCB1:  ADDA BJ_PNT+$1D
KBCB3:  STD  -2,Y
KBCB5:  LDD  BJ_PNT+$57             ;draw point 11 to 17, intensity from the two points' flag bytes
KBCB7:  SUBD BJ_PNT+$39
KBCB9:  ANDA #$1F
KBCBB:  STD  ,Y
KBCBD:  LDD  BJ_PNT+$55
KBCBF:  SUBD BJ_PNT+$37
KBCC1:  ANDA #$1F
KBCC3:  ORA  BJ_PNT+$59
KBCC5:  ADDA BJ_PNT+$3B
KBCC7:  STD  2,Y
KBCC9:  LDD  BJ_PNT+$5C             ;move point 17 to 18
KBCCB:  SUBD BJ_PNT+$57
KBCCD:  ANDA #$1F
KBCCF:  STD  4,Y
KBCD1:  LDD  BJ_PNT+$5A
KBCD3:  SUBD BJ_PNT+$55
KBCD5:  ANDA #$1F
KBCD7:  STD  6,Y
KBCD9:  LDD  BJ_PNT+$3E             ;BDRAWTO 1,3,15,12,9  UP RIGHT SIDE  draw point 18 to 12, intensity from the two points' flag bytes
KBCDB:  SUBD BJ_PNT+$5C
KBCDD:  ANDA #$1F
KBCDF:  STD  8,Y
KBCE1:  LDD  BJ_PNT+$3C
KBCE3:  SUBD BJ_PNT+$5A
KBCE5:  ANDA #$1F
KBCE7:  ORA  BJ_PNT+$40
KBCE9:  ADDA BJ_PNT+$5E
KBCEB:  STD  $A,Y
KBCED:  LDD  BJ_PNT+$20             ;draw point 12 to 6, intensity from the two points' flag bytes
KBCEF:  SUBD BJ_PNT+$3E
KBCF1:  ANDA #$1F
KBCF3:  STD  $C,Y
KBCF5:  LDD  BJ_PNT+$1E
KBCF7:  SUBD BJ_PNT+$3C
KBCF9:  ANDA #$1F
KBCFB:  ORA  BJ_PNT+$22
KBCFD:  ADDA BJ_PNT+$40
KBCFF:  STD  $E,Y
KBD01:  LDD  BJ_PNT+$07             ;move point 6 to 1
KBD03:  SUBD BJ_PNT+$20
KBD05:  ANDA #$1F
KBD07:  LEAY $20,Y
KBD0A:  STD  -16,Y
KBD0C:  LDD  BJ_PNT+$05
KBD0E:  SUBD BJ_PNT+$1E
KBD10:  ANDA #$1F
KBD12:  STD  -14,Y
KBD14:  LDD  BJ_PNT+$66             ;draw point 1 to 20, intensity from the two points' flag bytes
KBD16:  SUBD BJ_PNT+$07
KBD18:  ANDA #$1F
KBD1A:  STD  -12,Y
KBD1C:  LDD  BJ_PNT+$64
KBD1E:  SUBD BJ_PNT+$05
KBD20:  ANDA #$1F
KBD22:  ORA  BJ_PNT+$68
KBD24:  ADDA BJ_PNT+$09
KBD26:  STD  -10,Y
KBD28:  LDD  BJ_PNT+$0C             ;move point 20 to 2
KBD2A:  SUBD BJ_PNT+$66
KBD2C:  ANDA #$1F
KBD2E:  STD  -8,Y
KBD30:  LDD  BJ_PNT+$0A
KBD32:  SUBD BJ_PNT+$64
KBD34:  ANDA #$1F
KBD36:  STD  -6,Y
KBD38:  LDD  BJ_PNT+$6B             ;draw point 2 to 21, intensity from the two points' flag bytes
KBD3A:  SUBD BJ_PNT+$0C
KBD3C:  ANDA #$1F
KBD3E:  STD  -4,Y
KBD40:  LDD  BJ_PNT+$69
KBD42:  SUBD BJ_PNT+$0A
KBD44:  ANDA #$1F
KBD46:  ORA  BJ_PNT+$6D
KBD48:  ADDA BJ_PNT+$0E
KBD4A:  STD  -2,Y
KBD4C:  LDD  BJ_PNT+$11             ;move point 21 to 3
KBD4E:  SUBD BJ_PNT+$6B
KBD50:  ANDA #$1F
KBD52:  STD  ,Y
KBD54:  LDD  BJ_PNT+$0F
KBD56:  SUBD BJ_PNT+$69
KBD58:  ANDA #$1F
KBD5A:  STD  2,Y
KBD5C:  LDD  BJ_PNT+$70             ;DRAWTO 0,2,3,1,5,4,0  draw point 3 to 22, intensity from the two points' flag bytes
KBD5E:  SUBD BJ_PNT+$11
KBD60:  ANDA #$1F
KBD62:  STD  4,Y
KBD64:  LDD  BJ_PNT+$6E
KBD66:  SUBD BJ_PNT+$0F
KBD68:  ANDA #$1F
KBD6A:  ORA  BJ_PNT+$72
KBD6C:  ADDA BJ_PNT+$13
KBD6E:  STD  6,Y
KBD70:  LDD  BJ_PNT+$16             ;BDRAWTO 1,3,15,12,9  UP RIGHT SIDE  move point 22 to 4
KBD72:  SUBD BJ_PNT+$70
KBD74:  ANDA #$1F
KBD76:  STD  8,Y
KBD78:  LDD  BJ_PNT+$14
KBD7A:  SUBD BJ_PNT+$6E
KBD7C:  ANDA #$1F
KBD7E:  STD  $A,Y
KBD80:  LDD  BJ_PNT+$75             ;draw point 4 to 23, intensity from the two points' flag bytes
KBD82:  SUBD BJ_PNT+$16
KBD84:  ANDA #$1F
KBD86:  STD  $C,Y
KBD88:  LDD  BJ_PNT+$73
KBD8A:  SUBD BJ_PNT+$14
KBD8C:  ANDA #$1F
KBD8E:  ORA  BJ_PNT+$77
KBD90:  ADDA BJ_PNT+$18
KBD92:  STD  $E,Y
KBD94:  LDD  BJ_PNT+$1B             ;move point 23 to 5
KBD96:  SUBD BJ_PNT+$75
KBD98:  ANDA #$1F
KBD9A:  LEAY $20,Y
KBD9D:  STD  -16,Y
KBD9F:  LDD  BJ_PNT+$19
KBDA1:  SUBD BJ_PNT+$73
KBDA3:  ANDA #$1F
KBDA5:  STD  -14,Y
KBDA7:  LDD  BJ_PNT+$7A             ;draw point 5 to 24, intensity from the two points' flag bytes
KBDA9:  SUBD BJ_PNT+$1B
KBDAB:  ANDA #$1F
KBDAD:  STD  -12,Y
KBDAF:  LDD  BJ_PNT+$78
KBDB1:  SUBD BJ_PNT+$19
KBDB3:  ANDA #$1F
KBDB5:  ORA  BJ_PNT+$7C
KBDB7:  ADDA BJ_PNT+$1D
KBDB9:  STD  -10,Y
KBDBB:  LDD  BJ_PNT+$20             ;move point 24 to 6
KBDBD:  SUBD BJ_PNT+$7A
KBDBF:  ANDA #$1F
KBDC1:  STD  -8,Y
KBDC3:  LDD  BJ_PNT+$1E
KBDC5:  SUBD BJ_PNT+$78
KBDC7:  ANDA #$1F
KBDC9:  STD  -6,Y
KBDCB:  LDD  BJ_PNT+$7F             ;draw point 6 to 25, intensity from the two points' flag bytes
KBDCD:  SUBD BJ_PNT+$20
KBDCF:  ANDA #$1F
KBDD1:  STD  -4,Y
KBDD3:  LDD  BJ_PNT+$7D
KBDD5:  SUBD BJ_PNT+$1E
KBDD7:  ANDA #$1F
KBDD9:  ORA  BJ_PNT+$81
KBDDB:  ADDA BJ_PNT+$22
KBDDD:  STD  -2,Y
KBDDF:  LEAY ,Y
KBDE1:  LDA  #$48
KBDE3:  TFR  A,DP
.dpage $48
KBDE5:  LDD  BJ_PNT+$7D
KBDE8:  STD  BJ_CX
KBDEA:  LDD  BJ_PNT+$7F
KBDED:  STD  BJ_CY
KBDEF:  PULS A,B,X,U,PC

;------------------------------------------------------------------------------
; draw_probot_head - draw routine of object 6, the head of a probot (20 points, a flat dome of three hexagonal
;   rings, 27 lines with depth cue brightness). the explosion code also draws object 6 for the pieces of a
;   destroyed probot (piece types 0 to 2)
;------------------------------------------------------------------------------
draw_probot_head:
KBDF1:  LDA  #$4E
KBDF3:  TFR  A,DP
.dpage $4E
KBDF5:  LDD  BJ_PNT+$07             ;beam to point 1
KBDF7:  SUBD BJ_CY
KBDFA:  ANDA #$1F
KBDFC:  STD  ,Y
KBDFE:  LDD  BJ_PNT+$05
KBE00:  SUBD BJ_CX
KBE03:  ANDA #$1F
KBE05:  STD  2,Y
KBE07:  LDD  BJ_PNT+$0C             ;DRAWTO 0,2,3,1,5,4,0  draw point 1 to 2, intensity from the two points' flag bytes
KBE09:  SUBD BJ_PNT+$07
KBE0B:  ANDA #$1F
KBE0D:  STD  4,Y
KBE0F:  LDD  BJ_PNT+$0A
KBE11:  SUBD BJ_PNT+$05
KBE13:  ANDA #$1F
KBE15:  ORA  BJ_PNT+$0E
KBE17:  ADDA BJ_PNT+$09
KBE19:  STD  6,Y
KBE1B:  LDD  BJ_PNT+$11             ;BDRAWTO 1,3,15,12,9  UP RIGHT SIDE  draw point 2 to 3, intensity from the two points' flag bytes
KBE1D:  SUBD BJ_PNT+$0C
KBE1F:  ANDA #$1F
KBE21:  STD  8,Y
KBE23:  LDD  BJ_PNT+$0F
KBE25:  SUBD BJ_PNT+$0A
KBE27:  ANDA #$1F
KBE29:  ORA  BJ_PNT+$13
KBE2B:  ADDA BJ_PNT+$0E
KBE2D:  STD  $A,Y
KBE2F:  LDD  BJ_PNT+$16             ;draw point 3 to 4, intensity from the two points' flag bytes
KBE31:  SUBD BJ_PNT+$11
KBE33:  ANDA #$1F
KBE35:  STD  $C,Y
KBE37:  LDD  BJ_PNT+$14
KBE39:  SUBD BJ_PNT+$0F
KBE3B:  ANDA #$1F
KBE3D:  ORA  BJ_PNT+$18
KBE3F:  ADDA BJ_PNT+$13
KBE41:  STD  $E,Y
KBE43:  LDD  BJ_PNT+$1B             ;draw point 4 to 5, intensity from the two points' flag bytes
KBE45:  SUBD BJ_PNT+$16
KBE47:  ANDA #$1F
KBE49:  LEAY $20,Y
KBE4C:  STD  -16,Y
KBE4E:  LDD  BJ_PNT+$19
KBE50:  SUBD BJ_PNT+$14
KBE52:  ANDA #$1F
KBE54:  ORA  BJ_PNT+$1D
KBE56:  ADDA BJ_PNT+$18
KBE58:  STD  -14,Y
KBE5A:  LDD  BJ_PNT+$02             ;draw point 5 to 0, intensity from the two points' flag bytes
KBE5C:  SUBD BJ_PNT+$1B
KBE5E:  ANDA #$1F
KBE60:  STD  -12,Y
KBE62:  LDD  ST_QUZ
KBE64:  SUBD BJ_PNT+$19
KBE66:  ANDA #$1F
KBE68:  ORA  BJ_PNT+$04
KBE6A:  ADDA BJ_PNT+$1D
KBE6C:  STD  -10,Y
KBE6E:  LDD  BJ_PNT+$07             ;draw point 0 to 1, intensity from the two points' flag bytes
KBE70:  SUBD BJ_PNT+$02
KBE72:  ANDA #$1F
KBE74:  STD  -8,Y
KBE76:  LDD  BJ_PNT+$05
KBE78:  SUBD ST_QUZ
KBE7A:  ANDA #$1F
KBE7C:  ORA  BJ_PNT+$09
KBE7E:  ADDA BJ_PNT+$04
KBE80:  STD  -6,Y
KBE82:  LDD  BJ_PNT+$25             ;draw point 1 to 7, intensity from the two points' flag bytes
KBE84:  SUBD BJ_PNT+$07
KBE86:  ANDA #$1F
KBE88:  STD  -4,Y
KBE8A:  LDD  BJ_PNT+$23
KBE8C:  SUBD BJ_PNT+$05
KBE8E:  ANDA #$1F
KBE90:  ORA  BJ_PNT+$27
KBE92:  ADDA BJ_PNT+$09
KBE94:  STD  -2,Y
KBE96:  LDD  BJ_PNT+$2A             ;draw point 7 to 8, intensity from the two points' flag bytes
KBE98:  SUBD BJ_PNT+$25
KBE9A:  ANDA #$1F
KBE9C:  STD  ,Y
KBE9E:  LDD  BJ_PNT+$28
KBEA0:  SUBD BJ_PNT+$23
KBEA2:  ANDA #$1F
KBEA4:  ORA  BJ_PNT+$2C
KBEA6:  ADDA BJ_PNT+$27
KBEA8:  STD  2,Y
KBEAA:  LDD  BJ_PNT+$2F             ;draw point 8 to 9, intensity from the two points' flag bytes
KBEAC:  SUBD BJ_PNT+$2A
KBEAE:  ANDA #$1F
KBEB0:  STD  4,Y
KBEB2:  LDD  BJ_PNT+$2D
KBEB4:  SUBD BJ_PNT+$28
KBEB6:  ANDA #$1F
KBEB8:  ORA  BJ_PNT+$31
KBEBA:  ADDA BJ_PNT+$2C
KBEBC:  STD  6,Y
KBEBE:  LDD  BJ_PNT+$34             ;BDRAWTO 1,3,15,12,9  UP RIGHT SIDE  draw point 9 to 10, intensity from the two points' flag bytes
KBEC0:  SUBD BJ_PNT+$2F
KBEC2:  ANDA #$1F
KBEC4:  STD  8,Y
KBEC6:  LDD  BJ_PNT+$32
KBEC8:  SUBD BJ_PNT+$2D
KBECA:  ANDA #$1F
KBECC:  ORA  BJ_PNT+$36
KBECE:  ADDA BJ_PNT+$31
KBED0:  STD  $A,Y
KBED2:  LDD  BJ_PNT+$39             ;draw point 10 to 11, intensity from the two points' flag bytes
KBED4:  SUBD BJ_PNT+$34
KBED6:  ANDA #$1F
KBED8:  STD  $C,Y
KBEDA:  LDD  BJ_PNT+$37
KBEDC:  SUBD BJ_PNT+$32
KBEDE:  ANDA #$1F
KBEE0:  ORA  BJ_PNT+$3B
KBEE2:  ADDA BJ_PNT+$36
KBEE4:  STD  $E,Y
KBEE6:  LDD  BJ_PNT+$20             ;draw point 11 to 6, intensity from the two points' flag bytes
KBEE8:  SUBD BJ_PNT+$39
KBEEA:  ANDA #$1F
KBEEC:  LEAY $20,Y
KBEEF:  STD  -16,Y
KBEF1:  LDD  BJ_PNT+$1E
KBEF3:  SUBD BJ_PNT+$37
KBEF5:  ANDA #$1F
KBEF7:  ORA  BJ_PNT+$22
KBEF9:  ADDA BJ_PNT+$3B
KBEFB:  STD  -14,Y
KBEFD:  LDD  BJ_PNT+$25             ;draw point 6 to 7, intensity from the two points' flag bytes
KBEFF:  SUBD BJ_PNT+$20
KBF01:  ANDA #$1F
KBF03:  STD  -12,Y
KBF05:  LDD  BJ_PNT+$23
KBF07:  SUBD BJ_PNT+$1E
KBF09:  ANDA #$1F
KBF0B:  ORA  BJ_PNT+$27
KBF0D:  ADDA BJ_PNT+$22
KBF0F:  STD  -10,Y
KBF11:  LDD  BJ_PNT+$43             ;draw point 7 to 13, intensity from the two points' flag bytes
KBF13:  SUBD BJ_PNT+$25
KBF15:  ANDA #$1F
KBF17:  STD  -8,Y
KBF19:  LDD  BJ_PNT+$41
KBF1B:  SUBD BJ_PNT+$23
KBF1D:  ANDA #$1F
KBF1F:  ORA  BJ_PNT+$45
KBF21:  ADDA BJ_PNT+$27
KBF23:  STD  -6,Y
KBF25:  LDD  BJ_PNT+$48             ;draw point 13 to 14, intensity from the two points' flag bytes
KBF27:  SUBD BJ_PNT+$43
KBF29:  ANDA #$1F
KBF2B:  STD  -4,Y
KBF2D:  LDD  BJ_PNT+$46
KBF2F:  SUBD BJ_PNT+$41
KBF31:  ANDA #$1F
KBF33:  ORA  BJ_PNT+$4A
KBF35:  ADDA BJ_PNT+$45
KBF37:  STD  -2,Y
KBF39:  LDD  BJ_PNT+$4D             ;draw point 14 to 15, intensity from the two points' flag bytes
KBF3B:  SUBD BJ_PNT+$48
KBF3D:  ANDA #$1F
KBF3F:  STD  ,Y
KBF41:  LDD  BJ_PNT+$4B
KBF43:  SUBD BJ_PNT+$46
KBF45:  ANDA #$1F
KBF47:  ORA  BJ_PNT+$4F
KBF49:  ADDA BJ_PNT+$4A
KBF4B:  STD  2,Y
KBF4D:  LDD  BJ_PNT+$52             ;draw point 15 to 16, intensity from the two points' flag bytes
KBF4F:  SUBD BJ_PNT+$4D
KBF51:  ANDA #$1F
KBF53:  STD  4,Y
KBF55:  LDD  BJ_PNT+$50
KBF57:  SUBD BJ_PNT+$4B
KBF59:  ANDA #$1F
KBF5B:  ORA  BJ_PNT+$54
KBF5D:  ADDA BJ_PNT+$4F
KBF5F:  STD  6,Y
KBF61:  LDD  BJ_PNT+$57             ;BDRAWTO 1,3,15,12,9  UP RIGHT SIDE  draw point 16 to 17, intensity from the two points' flag bytes
KBF63:  SUBD BJ_PNT+$52
KBF65:  ANDA #$1F
KBF67:  STD  8,Y
KBF69:  LDD  BJ_PNT+$55
KBF6B:  SUBD BJ_PNT+$50
KBF6D:  ANDA #$1F
KBF6F:  ORA  BJ_PNT+$59
KBF71:  ADDA BJ_PNT+$54
KBF73:  STD  $A,Y
KBF75:  LDD  BJ_PNT+$39             ;draw point 17 to 11, intensity from the two points' flag bytes
KBF77:  SUBD BJ_PNT+$57
KBF79:  ANDA #$1F
KBF7B:  STD  $C,Y
KBF7D:  LDD  BJ_PNT+$37
KBF7F:  SUBD BJ_PNT+$55
KBF81:  ANDA #$1F
KBF83:  ORA  BJ_PNT+$3B
KBF85:  ADDA BJ_PNT+$59
KBF87:  STD  $E,Y
KBF89:  LDD  BJ_PNT+$1B             ;draw point 11 to 5, intensity from the two points' flag bytes
KBF8B:  SUBD BJ_PNT+$39
KBF8D:  ANDA #$1F
KBF8F:  LEAY $20,Y
KBF92:  STD  -16,Y
KBF94:  LDD  BJ_PNT+$19
KBF96:  SUBD BJ_PNT+$37
KBF98:  ANDA #$1F
KBF9A:  ORA  BJ_PNT+$1D
KBF9C:  ADDA BJ_PNT+$3B
KBF9E:  STD  -14,Y
KBFA0:  LDD  BJ_PNT+$16             ;move point 5 to 4
KBFA2:  SUBD BJ_PNT+$1B
KBFA4:  ANDA #$1F
KBFA6:  STD  -12,Y
KBFA8:  LDD  BJ_PNT+$14
KBFAA:  SUBD BJ_PNT+$19
KBFAC:  ANDA #$1F
KBFAE:  STD  -10,Y
KBFB0:  LDD  BJ_PNT+$34             ;draw point 4 to 10, intensity from the two points' flag bytes
KBFB2:  SUBD BJ_PNT+$16
KBFB4:  ANDA #$1F
KBFB6:  STD  -8,Y
KBFB8:  LDD  BJ_PNT+$32
KBFBA:  SUBD BJ_PNT+$14
KBFBC:  ANDA #$1F
KBFBE:  ORA  BJ_PNT+$36
KBFC0:  ADDA BJ_PNT+$18
KBFC2:  STD  -6,Y
KBFC4:  LDD  BJ_PNT+$52             ;draw point 10 to 16, intensity from the two points' flag bytes
KBFC6:  SUBD BJ_PNT+$34
KBFC8:  ANDA #$1F
KBFCA:  STD  -4,Y
KBFCC:  LDD  BJ_PNT+$50
KBFCE:  SUBD BJ_PNT+$32
KBFD0:  ANDA #$1F
KBFD2:  ORA  BJ_PNT+$54
KBFD4:  ADDA BJ_PNT+$36
KBFD6:  STD  -2,Y
KBFD8:  LDD  BJ_PNT+$4D             ;move point 16 to 15
KBFDA:  SUBD BJ_PNT+$52
KBFDC:  ANDA #$1F
KBFDE:  STD  ,Y
KBFE0:  LDD  BJ_PNT+$4B
KBFE2:  SUBD BJ_PNT+$50
KBFE4:  ANDA #$1F
KBFE6:  STD  2,Y
KBFE8:  LDD  BJ_PNT+$2F             ;DRAWTO 0,2,3,1,5,4,0  draw point 15 to 9, intensity from the two points' flag bytes
KBFEA:  SUBD BJ_PNT+$4D
KBFEC:  ANDA #$1F
KBFEE:  STD  4,Y
KBFF0:  LDD  BJ_PNT+$2D
KBFF2:  SUBD BJ_PNT+$4B
KBFF4:  ANDA #$1F
KBFF6:  ORA  BJ_PNT+$31
KBFF8:  ADDA BJ_PNT+$4F
KBFFA:  STD  6,Y
KBFFC:  LDD  BJ_PNT+$11             ;BDRAWTO 1,3,15,12,9  UP RIGHT SIDE  draw point 9 to 3, intensity from the two points' flag bytes
KBFFE:  SUBD BJ_PNT+$2F
KC000:  ANDA #$1F
KC002:  STD  8,Y
KC004:  LDD  BJ_PNT+$0F
KC006:  SUBD BJ_PNT+$2D
KC008:  ANDA #$1F
KC00A:  ORA  BJ_PNT+$13
KC00C:  ADDA BJ_PNT+$31
KC00E:  STD  $A,Y
KC010:  LDD  BJ_PNT+$0C             ;move point 3 to 2
KC012:  SUBD BJ_PNT+$11
KC014:  ANDA #$1F
KC016:  STD  $C,Y
KC018:  LDD  BJ_PNT+$0A
KC01A:  SUBD BJ_PNT+$0F
KC01C:  ANDA #$1F
KC01E:  STD  $E,Y
KC020:  LDD  BJ_PNT+$2A             ;draw point 2 to 8, intensity from the two points' flag bytes
KC022:  SUBD BJ_PNT+$0C
KC024:  ANDA #$1F
KC026:  LEAY $20,Y
KC029:  STD  -16,Y
KC02B:  LDD  BJ_PNT+$28
KC02D:  SUBD BJ_PNT+$0A
KC02F:  ANDA #$1F
KC031:  ORA  BJ_PNT+$2C
KC033:  ADDA BJ_PNT+$0E
KC035:  STD  -14,Y
KC037:  LDD  BJ_PNT+$48             ;draw point 8 to 14, intensity from the two points' flag bytes
KC039:  SUBD BJ_PNT+$2A
KC03B:  ANDA #$1F
KC03D:  STD  -12,Y
KC03F:  LDD  BJ_PNT+$46
KC041:  SUBD BJ_PNT+$28
KC043:  ANDA #$1F
KC045:  ORA  BJ_PNT+$4A
KC047:  ADDA BJ_PNT+$2C
KC049:  STD  -10,Y
KC04B:  LDD  BJ_PNT+$02             ;move point 14 to 0
KC04D:  SUBD BJ_PNT+$48
KC04F:  ANDA #$1F
KC051:  STD  -8,Y
KC053:  LDD  ST_QUZ
KC055:  SUBD BJ_PNT+$46
KC057:  ANDA #$1F
KC059:  STD  -6,Y
KC05B:  LDD  BJ_PNT+$20             ;draw point 0 to 6, intensity from the two points' flag bytes
KC05D:  SUBD BJ_PNT+$02
KC05F:  ANDA #$1F
KC061:  STD  -4,Y
KC063:  LDD  BJ_PNT+$1E
KC065:  SUBD ST_QUZ
KC067:  ANDA #$1F
KC069:  ORA  BJ_PNT+$22
KC06B:  ADDA BJ_PNT+$04
KC06D:  STD  -2,Y
KC06F:  LEAY ,Y
KC071:  LDA  #$48
KC073:  TFR  A,DP
.dpage $48
KC075:  LDD  BJ_PNT+$1E
KC078:  STD  BJ_CX
KC07A:  LDD  BJ_PNT+$20
KC07D:  STD  BJ_CY
KC07F:  PULS A,B,X,U,PC

;------------------------------------------------------------------------------
; draw_probot_eye - draw routine of object 7, which has the same point table as object 6: four lines round
;   points 6, 13, 12 and 17 of the head, a four-sided figure on its front. page 2 draws it from the points
;   perspected for object 6 after the head, in the colour its launch test chose
;------------------------------------------------------------------------------
draw_probot_eye:
KC081:  LDA  #$4E
KC083:  TFR  A,DP
.dpage $4E
KC085:  LDD  BJ_PNT+$20             ;beam to point 6
KC087:  SUBD BJ_CY
KC08A:  ANDA #$1F
KC08C:  STD  ,Y
KC08E:  LDD  BJ_PNT+$1E
KC090:  SUBD BJ_CX
KC093:  ANDA #$1F
KC095:  STD  2,Y
KC097:  LDD  BJ_PNT+$43             ;DRAWTO 0,2,3,1,5,4,0  draw point 6 to 13, intensity from the two points' flag bytes
KC099:  SUBD BJ_PNT+$20
KC09B:  ANDA #$1F
KC09D:  STD  4,Y
KC09F:  LDD  BJ_PNT+$41
KC0A1:  SUBD BJ_PNT+$1E
KC0A3:  ANDA #$1F
KC0A5:  ORA  BJ_PNT+$45
KC0A7:  ADDA BJ_PNT+$22
KC0A9:  STD  6,Y
KC0AB:  LDD  BJ_PNT+$3E             ;BDRAWTO 1,3,15,12,9  UP RIGHT SIDE  draw point 13 to 12, intensity from the two points' flag bytes
KC0AD:  SUBD BJ_PNT+$43
KC0AF:  ANDA #$1F
KC0B1:  STD  8,Y
KC0B3:  LDD  BJ_PNT+$3C
KC0B5:  SUBD BJ_PNT+$41
KC0B7:  ANDA #$1F
KC0B9:  ORA  BJ_PNT+$40
KC0BB:  ADDA BJ_PNT+$45
KC0BD:  STD  $A,Y
KC0BF:  LDD  BJ_PNT+$57             ;draw point 12 to 17, intensity from the two points' flag bytes
KC0C1:  SUBD BJ_PNT+$3E
KC0C3:  ANDA #$1F
KC0C5:  STD  $C,Y
KC0C7:  LDD  BJ_PNT+$55
KC0C9:  SUBD BJ_PNT+$3C
KC0CB:  ANDA #$1F
KC0CD:  ORA  BJ_PNT+$59
KC0CF:  ADDA BJ_PNT+$40
KC0D1:  STD  $E,Y
KC0D3:  LDD  BJ_PNT+$20             ;draw point 17 to 6, intensity from the two points' flag bytes
KC0D5:  SUBD BJ_PNT+$57
KC0D7:  ANDA #$1F
KC0D9:  LEAY $20,Y
KC0DC:  STD  -16,Y
KC0DE:  LDD  BJ_PNT+$1E
KC0E0:  SUBD BJ_PNT+$55
KC0E2:  ANDA #$1F
KC0E4:  ORA  BJ_PNT+$22
KC0E6:  ADDA BJ_PNT+$59
KC0E8:  STD  -14,Y
KC0EA:  LEAY -12,Y
KC0EC:  LDA  #$48
KC0EE:  TFR  A,DP
.dpage $48
KC0F0:  LDD  BJ_PNT+$1E
KC0F3:  STD  BJ_CX
KC0F5:  LDD  BJ_PNT+$20
KC0F8:  STD  BJ_CY
KC0FA:  PULS A,B,X,U,PC

;------------------------------------------------------------------------------
; draw_limb_down - draw routine of objects 9 and 11 to 16 in the table, used by page 2 for all eight probot
;   limbs (objects 9 to 16, four points each, hanging below the body): writes colour instruction $6260, moves to
;   point 0 and draws points 0-1-2-3 at full brightness
;------------------------------------------------------------------------------
draw_limb_down:
KC0FC:  LDA  #$4E
KC0FE:  TFR  A,DP
.dpage $4E
KC100:  LDD  #$6260
KC103:  STD  ,Y
KC105:  LDD  BJ_PNT+$02             ;beam to point 0
KC107:  SUBD BJ_CY
KC10A:  ANDA #$1F
KC10C:  STD  2,Y
KC10E:  LDD  ST_QUZ
KC110:  SUBD BJ_CX
KC113:  ANDA #$1F
KC115:  STD  4,Y
KC117:  LDD  BJ_PNT+$07             ;DRAWTO 9,8,4  draw point 0 to 1
KC119:  SUBD BJ_PNT+$02
KC11B:  ANDA #$1F
KC11D:  STD  6,Y
KC11F:  LDD  BJ_PNT+$05
KC121:  SUBD ST_QUZ
KC123:  ORA  #$E0
KC125:  STD  8,Y
KC127:  LDD  BJ_PNT+$0C             ;draw point 1 to 2
KC129:  SUBD BJ_PNT+$07
KC12B:  ANDA #$1F
KC12D:  STD  $A,Y
KC12F:  LDD  BJ_PNT+$0A
KC131:  SUBD BJ_PNT+$05
KC133:  ORA  #$E0
KC135:  STD  $C,Y
KC137:  LDD  BJ_PNT+$11             ;draw point 2 to 3
KC139:  SUBD BJ_PNT+$0C
KC13B:  ANDA #$1F
KC13D:  STD  $E,Y
KC13F:  LDD  BJ_PNT+$0F
KC141:  SUBD BJ_PNT+$0A
KC143:  ORA  #$E0
KC145:  LEAY $20,Y
KC148:  STD  -16,Y
KC14A:  LEAY -14,Y
KC14C:  LDA  #$48
KC14E:  TFR  A,DP
.dpage $48
KC150:  LDD  BJ_PNT+$0F
KC153:  STD  BJ_CX
KC155:  LDD  BJ_PNT+$11
KC158:  STD  BJ_CY
KC15A:  PULS A,B,X,U,PC

;------------------------------------------------------------------------------
; draw_limb_up - draw routine of object 10: draws from the beam position to point 2, then to 1 and to 0, three
;   lines at full brightness with no move first. page 2 calls it as object 10 after draw_limb_down for every limb
;   with BJ_CX shifted, so the limb is drawn down one side and back up the other
;------------------------------------------------------------------------------
draw_limb_up:
KC15C:  LDA  #$4E
KC15E:  TFR  A,DP
.dpage $4E
KC160:  LDD  BJ_PNT+$0C             ;draw from the beam to point 2
KC162:  SUBD BJ_CY
KC165:  ANDA #$1F
KC167:  STD  ,Y
KC169:  LDD  BJ_PNT+$0A
KC16B:  SUBD BJ_CX
KC16E:  ORA  #$E0
KC170:  STD  2,Y
KC172:  LDD  BJ_PNT+$07             ;DRAWTO 0,2,3,1,5,4,0  draw point 2 to 1
KC174:  SUBD BJ_PNT+$0C
KC176:  ANDA #$1F
KC178:  STD  4,Y
KC17A:  LDD  BJ_PNT+$05
KC17C:  SUBD BJ_PNT+$0A
KC17E:  ORA  #$E0
KC180:  STD  6,Y
KC182:  LDD  BJ_PNT+$02             ;draw point 1 to 0
KC184:  SUBD BJ_PNT+$07
KC186:  ANDA #$1F
KC188:  STD  8,Y
KC18A:  LDD  ST_QUZ
KC18C:  SUBD BJ_PNT+$05
KC18E:  ORA  #$E0
KC190:  STD  $A,Y
KC192:  LEAY 12,Y
KC194:  LDA  #$48
KC196:  TFR  A,DP
.dpage $48
KC198:  LDD  ST_QUZ
KC19B:  STD  BJ_CX
KC19D:  LDD  BJ_PNT+$02
KC1A0:  STD  BJ_CY
KC1A2:  PULS A,B,X,U,PC

;------------------------------------------------------------------------------
; draw_hexagon - draw routine of object 8, a flat hexagon of six points (radius 60), six lines with depth cue
;   brightness. page 3 draws it for the probot transmissions
;------------------------------------------------------------------------------
draw_hexagon:
KC1A4:  LDA  #$4E
KC1A6:  TFR  A,DP
.dpage $4E
KC1A8:  LDD  BJ_PNT+$02             ;beam to point 0
KC1AA:  SUBD BJ_CY
KC1AD:  ANDA #$1F
KC1AF:  STD  ,Y
KC1B1:  LDD  ST_QUZ
KC1B3:  SUBD BJ_CX
KC1B6:  ANDA #$1F
KC1B8:  STD  2,Y
KC1BA:  LDD  BJ_PNT+$07             ;DRAWTO 0,2,3,1,5,4,0  draw point 0 to 1, intensity from the two points' flag bytes
KC1BC:  SUBD BJ_PNT+$02
KC1BE:  ANDA #$1F
KC1C0:  STD  4,Y
KC1C2:  LDD  BJ_PNT+$05
KC1C4:  SUBD ST_QUZ
KC1C6:  ANDA #$1F
KC1C8:  ORA  BJ_PNT+$09
KC1CA:  ADDA BJ_PNT+$04
KC1CC:  STD  6,Y
KC1CE:  LDD  BJ_PNT+$0C             ;BDRAWTO 1,3,15,12,9  UP RIGHT SIDE  draw point 1 to 2, intensity from the two points' flag bytes
KC1D0:  SUBD BJ_PNT+$07
KC1D2:  ANDA #$1F
KC1D4:  STD  8,Y
KC1D6:  LDD  BJ_PNT+$0A
KC1D8:  SUBD BJ_PNT+$05
KC1DA:  ANDA #$1F
KC1DC:  ORA  BJ_PNT+$0E
KC1DE:  ADDA BJ_PNT+$09
KC1E0:  STD  $A,Y
KC1E2:  LDD  BJ_PNT+$11             ;draw point 2 to 3, intensity from the two points' flag bytes
KC1E4:  SUBD BJ_PNT+$0C
KC1E6:  ANDA #$1F
KC1E8:  STD  $C,Y
KC1EA:  LDD  BJ_PNT+$0F
KC1EC:  SUBD BJ_PNT+$0A
KC1EE:  ANDA #$1F
KC1F0:  ORA  BJ_PNT+$13
KC1F2:  ADDA BJ_PNT+$0E
KC1F4:  STD  $E,Y
KC1F6:  LDD  BJ_PNT+$16             ;draw point 3 to 4, intensity from the two points' flag bytes
KC1F8:  SUBD BJ_PNT+$11
KC1FA:  ANDA #$1F
KC1FC:  LEAY $20,Y
KC1FF:  STD  -16,Y
KC201:  LDD  BJ_PNT+$14
KC203:  SUBD BJ_PNT+$0F
KC205:  ANDA #$1F
KC207:  ORA  BJ_PNT+$18
KC209:  ADDA BJ_PNT+$13
KC20B:  STD  -14,Y
KC20D:  LDD  BJ_PNT+$1B             ;draw point 4 to 5, intensity from the two points' flag bytes
KC20F:  SUBD BJ_PNT+$16
KC211:  ANDA #$1F
KC213:  STD  -12,Y
KC215:  LDD  BJ_PNT+$19
KC217:  SUBD BJ_PNT+$14
KC219:  ANDA #$1F
KC21B:  ORA  BJ_PNT+$1D
KC21D:  ADDA BJ_PNT+$18
KC21F:  STD  -10,Y
KC221:  LDD  BJ_PNT+$02             ;draw point 5 to 0, intensity from the two points' flag bytes
KC223:  SUBD BJ_PNT+$1B
KC225:  ANDA #$1F
KC227:  STD  -8,Y
KC229:  LDD  ST_QUZ
KC22B:  SUBD BJ_PNT+$19
KC22D:  ANDA #$1F
KC22F:  ORA  BJ_PNT+$04
KC231:  ADDA BJ_PNT+$1D
KC233:  STD  -6,Y
KC235:  LEAY -4,Y
KC237:  LDA  #$48
KC239:  TFR  A,DP
.dpage $48
KC23B:  LDD  ST_QUZ
KC23E:  STD  BJ_CX
KC240:  LDD  BJ_PNT+$02
KC243:  STD  BJ_CY
KC245:  PULS A,B,X,U,PC

;------------------------------------------------------------------------------
; draw_atst_head - draw routine of object 17, the head (cab) of an AT-ST walker: 18 lines with depth cue
;   brightness between points 0 to 13 of its 18 points
;------------------------------------------------------------------------------
draw_atst_head:
KC247:  LDA  #$4E
KC249:  TFR  A,DP
.dpage $4E
KC24B:  LDD  BJ_PNT+$3E             ;beam to point 12
KC24D:  SUBD BJ_CY
KC250:  ANDA #$1F
KC252:  STD  ,Y
KC254:  LDD  BJ_PNT+$3C
KC256:  SUBD BJ_CX
KC259:  ANDA #$1F
KC25B:  STD  2,Y
KC25D:  LDD  BJ_PNT+$34             ;DRAWTO 0,2,3,1,5,4,0  draw point 12 to 10, intensity from the two points' flag bytes
KC25F:  SUBD BJ_PNT+$3E
KC261:  ANDA #$1F
KC263:  STD  4,Y
KC265:  LDD  BJ_PNT+$32
KC267:  SUBD BJ_PNT+$3C
KC269:  ANDA #$1F
KC26B:  ORA  BJ_PNT+$36
KC26D:  ADDA BJ_PNT+$40
KC26F:  STD  6,Y
KC271:  LDD  BJ_PNT+$02             ;BDRAWTO 1,3,15,12,9  UP RIGHT SIDE  draw point 10 to 0, intensity from the two points' flag bytes
KC273:  SUBD BJ_PNT+$34
KC275:  ANDA #$1F
KC277:  STD  8,Y
KC279:  LDD  ST_QUZ
KC27B:  SUBD BJ_PNT+$32
KC27D:  ANDA #$1F
KC27F:  ORA  BJ_PNT+$04
KC281:  ADDA BJ_PNT+$36
KC283:  STD  $A,Y
KC285:  LDD  BJ_PNT+$0C             ;draw point 0 to 2, intensity from the two points' flag bytes
KC287:  SUBD BJ_PNT+$02
KC289:  ANDA #$1F
KC28B:  STD  $C,Y
KC28D:  LDD  BJ_PNT+$0A
KC28F:  SUBD ST_QUZ
KC291:  ANDA #$1F
KC293:  ORA  BJ_PNT+$0E
KC295:  ADDA BJ_PNT+$04
KC297:  STD  $E,Y
KC299:  LDD  BJ_PNT+$16             ;draw point 2 to 4, intensity from the two points' flag bytes
KC29B:  SUBD BJ_PNT+$0C
KC29D:  ANDA #$1F
KC29F:  LEAY $20,Y
KC2A2:  STD  -16,Y
KC2A4:  LDD  BJ_PNT+$14
KC2A6:  SUBD BJ_PNT+$0A
KC2A8:  ANDA #$1F
KC2AA:  ORA  BJ_PNT+$18
KC2AC:  ADDA BJ_PNT+$0E
KC2AE:  STD  -14,Y
KC2B0:  LDD  BJ_PNT+$20             ;draw point 4 to 6, intensity from the two points' flag bytes
KC2B2:  SUBD BJ_PNT+$16
KC2B4:  ANDA #$1F
KC2B6:  STD  -12,Y
KC2B8:  LDD  BJ_PNT+$1E
KC2BA:  SUBD BJ_PNT+$14
KC2BC:  ANDA #$1F
KC2BE:  ORA  BJ_PNT+$22
KC2C0:  ADDA BJ_PNT+$18
KC2C2:  STD  -10,Y
KC2C4:  LDD  BJ_PNT+$2A             ;draw point 6 to 8, intensity from the two points' flag bytes
KC2C6:  SUBD BJ_PNT+$20
KC2C8:  ANDA #$1F
KC2CA:  STD  -8,Y
KC2CC:  LDD  BJ_PNT+$28
KC2CE:  SUBD BJ_PNT+$1E
KC2D0:  ANDA #$1F
KC2D2:  ORA  BJ_PNT+$2C
KC2D4:  ADDA BJ_PNT+$22
KC2D6:  STD  -6,Y
KC2D8:  LDD  BJ_PNT+$34             ;draw point 8 to 10, intensity from the two points' flag bytes
KC2DA:  SUBD BJ_PNT+$2A
KC2DC:  ANDA #$1F
KC2DE:  STD  -4,Y
KC2E0:  LDD  BJ_PNT+$32
KC2E2:  SUBD BJ_PNT+$28
KC2E4:  ANDA #$1F
KC2E6:  ORA  BJ_PNT+$36
KC2E8:  ADDA BJ_PNT+$2C
KC2EA:  STD  -2,Y
KC2EC:  LDD  BJ_PNT+$43             ;move point 10 to 13
KC2EE:  SUBD BJ_PNT+$34
KC2F0:  ANDA #$1F
KC2F2:  STD  ,Y
KC2F4:  LDD  BJ_PNT+$41
KC2F6:  SUBD BJ_PNT+$32
KC2F8:  ANDA #$1F
KC2FA:  STD  2,Y
KC2FC:  LDD  BJ_PNT+$39             ;DRAWTO 0,2,3,1,5,4,0  draw point 13 to 11, intensity from the two points' flag bytes
KC2FE:  SUBD BJ_PNT+$43
KC300:  ANDA #$1F
KC302:  STD  4,Y
KC304:  LDD  BJ_PNT+$37
KC306:  SUBD BJ_PNT+$41
KC308:  ANDA #$1F
KC30A:  ORA  BJ_PNT+$3B
KC30C:  ADDA BJ_PNT+$45
KC30E:  STD  6,Y
KC310:  LDD  BJ_PNT+$07             ;BDRAWTO 1,3,15,12,9  UP RIGHT SIDE  draw point 11 to 1, intensity from the two points' flag bytes
KC312:  SUBD BJ_PNT+$39
KC314:  ANDA #$1F
KC316:  STD  8,Y
KC318:  LDD  BJ_PNT+$05
KC31A:  SUBD BJ_PNT+$37
KC31C:  ANDA #$1F
KC31E:  ORA  BJ_PNT+$09
KC320:  ADDA BJ_PNT+$3B
KC322:  STD  $A,Y
KC324:  LDD  BJ_PNT+$11             ;draw point 1 to 3, intensity from the two points' flag bytes
KC326:  SUBD BJ_PNT+$07
KC328:  ANDA #$1F
KC32A:  STD  $C,Y
KC32C:  LDD  BJ_PNT+$0F
KC32E:  SUBD BJ_PNT+$05
KC330:  ANDA #$1F
KC332:  ORA  BJ_PNT+$13
KC334:  ADDA BJ_PNT+$09
KC336:  STD  $E,Y
KC338:  LDD  BJ_PNT+$1B             ;draw point 3 to 5, intensity from the two points' flag bytes
KC33A:  SUBD BJ_PNT+$11
KC33C:  ANDA #$1F
KC33E:  LEAY $20,Y
KC341:  STD  -16,Y
KC343:  LDD  BJ_PNT+$19
KC345:  SUBD BJ_PNT+$0F
KC347:  ANDA #$1F
KC349:  ORA  BJ_PNT+$1D
KC34B:  ADDA BJ_PNT+$13
KC34D:  STD  -14,Y
KC34F:  LDD  BJ_PNT+$25             ;draw point 5 to 7, intensity from the two points' flag bytes
KC351:  SUBD BJ_PNT+$1B
KC353:  ANDA #$1F
KC355:  STD  -12,Y
KC357:  LDD  BJ_PNT+$23
KC359:  SUBD BJ_PNT+$19
KC35B:  ANDA #$1F
KC35D:  ORA  BJ_PNT+$27
KC35F:  ADDA BJ_PNT+$1D
KC361:  STD  -10,Y
KC363:  LDD  BJ_PNT+$2F             ;draw point 7 to 9, intensity from the two points' flag bytes
KC365:  SUBD BJ_PNT+$25
KC367:  ANDA #$1F
KC369:  STD  -8,Y
KC36B:  LDD  BJ_PNT+$2D
KC36D:  SUBD BJ_PNT+$23
KC36F:  ANDA #$1F
KC371:  ORA  BJ_PNT+$31
KC373:  ADDA BJ_PNT+$27
KC375:  STD  -6,Y
KC377:  LDD  BJ_PNT+$39             ;draw point 9 to 11, intensity from the two points' flag bytes
KC379:  SUBD BJ_PNT+$2F
KC37B:  ANDA #$1F
KC37D:  STD  -4,Y
KC37F:  LDD  BJ_PNT+$37
KC381:  SUBD BJ_PNT+$2D
KC383:  ANDA #$1F
KC385:  ORA  BJ_PNT+$3B
KC387:  ADDA BJ_PNT+$31
KC389:  STD  -2,Y
KC38B:  LDD  BJ_PNT+$2A             ;move point 11 to 8
KC38D:  SUBD BJ_PNT+$39
KC38F:  ANDA #$1F
KC391:  STD  ,Y
KC393:  LDD  BJ_PNT+$28
KC395:  SUBD BJ_PNT+$37
KC397:  ANDA #$1F
KC399:  STD  2,Y
KC39B:  LDD  BJ_PNT+$2F             ;DRAWTO 0,2,3,1,5,4,0  draw point 8 to 9, intensity from the two points' flag bytes
KC39D:  SUBD BJ_PNT+$2A
KC39F:  ANDA #$1F
KC3A1:  STD  4,Y
KC3A3:  LDD  BJ_PNT+$2D
KC3A5:  SUBD BJ_PNT+$28
KC3A7:  ANDA #$1F
KC3A9:  ORA  BJ_PNT+$31
KC3AB:  ADDA BJ_PNT+$2C
KC3AD:  STD  6,Y
KC3AF:  LDD  BJ_PNT+$20             ;BDRAWTO 1,3,15,12,9  UP RIGHT SIDE  move point 9 to 6
KC3B1:  SUBD BJ_PNT+$2F
KC3B3:  ANDA #$1F
KC3B5:  STD  8,Y
KC3B7:  LDD  BJ_PNT+$1E
KC3B9:  SUBD BJ_PNT+$2D
KC3BB:  ANDA #$1F
KC3BD:  STD  $A,Y
KC3BF:  LDD  BJ_PNT+$25             ;draw point 6 to 7, intensity from the two points' flag bytes
KC3C1:  SUBD BJ_PNT+$20
KC3C3:  ANDA #$1F
KC3C5:  STD  $C,Y
KC3C7:  LDD  BJ_PNT+$23
KC3C9:  SUBD BJ_PNT+$1E
KC3CB:  ANDA #$1F
KC3CD:  ORA  BJ_PNT+$27
KC3CF:  ADDA BJ_PNT+$22
KC3D1:  STD  $E,Y
KC3D3:  LDD  BJ_PNT+$0C             ;move point 7 to 2
KC3D5:  SUBD BJ_PNT+$25
KC3D7:  ANDA #$1F
KC3D9:  LEAY $20,Y
KC3DC:  STD  -16,Y
KC3DE:  LDD  BJ_PNT+$0A
KC3E0:  SUBD BJ_PNT+$23
KC3E2:  ANDA #$1F
KC3E4:  STD  -14,Y
KC3E6:  LDD  BJ_PNT+$11             ;draw point 2 to 3, intensity from the two points' flag bytes
KC3E8:  SUBD BJ_PNT+$0C
KC3EA:  ANDA #$1F
KC3EC:  STD  -12,Y
KC3EE:  LDD  BJ_PNT+$0F
KC3F0:  SUBD BJ_PNT+$0A
KC3F2:  ANDA #$1F
KC3F4:  ORA  BJ_PNT+$13
KC3F6:  ADDA BJ_PNT+$0E
KC3F8:  STD  -10,Y
KC3FA:  LDD  BJ_PNT+$02             ;move point 3 to 0
KC3FC:  SUBD BJ_PNT+$11
KC3FE:  ANDA #$1F
KC400:  STD  -8,Y
KC402:  LDD  ST_QUZ
KC404:  SUBD BJ_PNT+$0F
KC406:  ANDA #$1F
KC408:  STD  -6,Y
KC40A:  LDD  BJ_PNT+$07             ;draw point 0 to 1, intensity from the two points' flag bytes
KC40C:  SUBD BJ_PNT+$02
KC40E:  ANDA #$1F
KC410:  STD  -4,Y
KC412:  LDD  BJ_PNT+$05
KC414:  SUBD ST_QUZ
KC416:  ANDA #$1F
KC418:  ORA  BJ_PNT+$09
KC41A:  ADDA BJ_PNT+$04
KC41C:  STD  -2,Y
KC41E:  LEAY ,Y
KC420:  LDA  #$48
KC422:  TFR  A,DP
.dpage $48
KC424:  LDD  BJ_PNT+$05
KC427:  STD  BJ_CX
KC429:  LDD  BJ_PNT+$07
KC42C:  STD  BJ_CY
KC42E:  PULS A,B,X,U,PC

;------------------------------------------------------------------------------
; draw_atst_port - draw routine of object 18, which has the same point table as object 17: four lines round
;   points 12, 13, 15 and 14, the panel on the front of the AT-ST head. page 1 draws it from the points perspected
;   for object 17, in the colour its aim test left
;------------------------------------------------------------------------------
draw_atst_port:
KC430:  LDA  #$4E
KC432:  TFR  A,DP
.dpage $4E
KC434:  LDD  BJ_PNT+$3E             ;beam to point 12
KC436:  SUBD BJ_CY
KC439:  ANDA #$1F
KC43B:  STD  ,Y
KC43D:  LDD  BJ_PNT+$3C
KC43F:  SUBD BJ_CX
KC442:  ANDA #$1F
KC444:  STD  2,Y
KC446:  LDD  BJ_PNT+$43             ;DRAWTO 0,2,3,1,5,4,0  draw point 12 to 13, intensity from the two points' flag bytes
KC448:  SUBD BJ_PNT+$3E
KC44A:  ANDA #$1F
KC44C:  STD  4,Y
KC44E:  LDD  BJ_PNT+$41
KC450:  SUBD BJ_PNT+$3C
KC452:  ANDA #$1F
KC454:  ORA  BJ_PNT+$45
KC456:  ADDA BJ_PNT+$40
KC458:  STD  6,Y
KC45A:  LDD  BJ_PNT+$4D             ;BDRAWTO 1,3,15,12,9  UP RIGHT SIDE  draw point 13 to 15, intensity from the two points' flag bytes
KC45C:  SUBD BJ_PNT+$43
KC45E:  ANDA #$1F
KC460:  STD  8,Y
KC462:  LDD  BJ_PNT+$4B
KC464:  SUBD BJ_PNT+$41
KC466:  ANDA #$1F
KC468:  ORA  BJ_PNT+$4F
KC46A:  ADDA BJ_PNT+$45
KC46C:  STD  $A,Y
KC46E:  LDD  BJ_PNT+$48             ;draw point 15 to 14, intensity from the two points' flag bytes
KC470:  SUBD BJ_PNT+$4D
KC472:  ANDA #$1F
KC474:  STD  $C,Y
KC476:  LDD  BJ_PNT+$46
KC478:  SUBD BJ_PNT+$4B
KC47A:  ANDA #$1F
KC47C:  ORA  BJ_PNT+$4A
KC47E:  ADDA BJ_PNT+$4F
KC480:  STD  $E,Y
KC482:  LDD  BJ_PNT+$3E             ;draw point 14 to 12, intensity from the two points' flag bytes
KC484:  SUBD BJ_PNT+$48
KC486:  ANDA #$1F
KC488:  LEAY $20,Y
KC48B:  STD  -16,Y
KC48D:  LDD  BJ_PNT+$3C
KC48F:  SUBD BJ_PNT+$46
KC491:  ANDA #$1F
KC493:  ORA  BJ_PNT+$40
KC495:  ADDA BJ_PNT+$4A
KC497:  STD  -14,Y
KC499:  LEAY -12,Y
KC49B:  LDA  #$48
KC49D:  TFR  A,DP
.dpage $48
KC49F:  LDD  BJ_PNT+$3C
KC4A2:  STD  BJ_CX
KC4A4:  LDD  BJ_PNT+$3E
KC4A7:  STD  BJ_CY
KC4A9:  PULS A,B,X,U,PC

;------------------------------------------------------------------------------
; draw_atst_leg - draw routine of object 19, one AT-ST leg: 33 lines at full brightness between 18 buffer
;   points. the object's own table holds a single point, the 18 points are put into the buffer one at a time by
;   page 1 through pnt_add_scratch
;------------------------------------------------------------------------------
draw_atst_leg:
KC4AB:  LDA  #$4E
KC4AD:  TFR  A,DP
.dpage $4E
KC4AF:  LDD  BJ_PNT+$57             ;beam to point 17
KC4B1:  SUBD BJ_CY
KC4B4:  ANDA #$1F
KC4B6:  STD  ,Y
KC4B8:  LDD  BJ_PNT+$55
KC4BA:  SUBD BJ_CX
KC4BD:  ANDA #$1F
KC4BF:  STD  2,Y
KC4C1:  LDD  BJ_PNT+$48             ;DRAWTO 0,2,3,1,5,4,0  draw point 17 to 14
KC4C3:  SUBD BJ_PNT+$57
KC4C5:  ANDA #$1F
KC4C7:  STD  4,Y
KC4C9:  LDD  BJ_PNT+$46
KC4CB:  SUBD BJ_PNT+$55
KC4CD:  ORA  #$E0
KC4CF:  STD  6,Y
KC4D1:  LDD  BJ_PNT+$43             ;draw point 14 to 13
KC4D3:  SUBD BJ_PNT+$48
KC4D5:  ANDA #$1F
KC4D7:  STD  8,Y
KC4D9:  LDD  BJ_PNT+$41
KC4DB:  SUBD BJ_PNT+$46
KC4DD:  ORA  #$E0
KC4DF:  STD  $A,Y
KC4E1:  LDD  BJ_PNT+$52             ;draw point 13 to 16
KC4E3:  SUBD BJ_PNT+$43
KC4E5:  ANDA #$1F
KC4E7:  STD  $C,Y
KC4E9:  LDD  BJ_PNT+$50
KC4EB:  SUBD BJ_PNT+$41
KC4ED:  ORA  #$E0
KC4EF:  STD  $E,Y
KC4F1:  LDD  BJ_PNT+$57             ;draw point 16 to 17
KC4F3:  SUBD BJ_PNT+$52
KC4F5:  ANDA #$1F
KC4F7:  LEAY $20,Y
KC4FA:  STD  -16,Y
KC4FC:  LDD  BJ_PNT+$55
KC4FE:  SUBD BJ_PNT+$50
KC500:  ORA  #$E0
KC502:  STD  -14,Y
KC504:  LDD  BJ_PNT+$4D             ;draw point 17 to 15
KC506:  SUBD BJ_PNT+$57
KC508:  ANDA #$1F
KC50A:  STD  -12,Y
KC50C:  LDD  BJ_PNT+$4B
KC50E:  SUBD BJ_PNT+$55
KC510:  ORA  #$E0
KC512:  STD  -10,Y
KC514:  LDD  BJ_PNT+$3E             ;draw point 15 to 12
KC516:  SUBD BJ_PNT+$4D
KC518:  ANDA #$1F
KC51A:  STD  -8,Y
KC51C:  LDD  BJ_PNT+$3C
KC51E:  SUBD BJ_PNT+$4B
KC520:  ORA  #$E0
KC522:  STD  -6,Y
KC524:  LDD  BJ_PNT+$52             ;draw point 12 to 16
KC526:  SUBD BJ_PNT+$3E
KC528:  ANDA #$1F
KC52A:  STD  -4,Y
KC52C:  LDD  BJ_PNT+$50
KC52E:  SUBD BJ_PNT+$3C
KC530:  ORA  #$E0
KC532:  STD  -2,Y
KC534:  LDD  BJ_PNT+$4D             ;move point 16 to 15
KC536:  SUBD BJ_PNT+$52
KC538:  ANDA #$1F
KC53A:  STD  ,Y
KC53C:  LDD  BJ_PNT+$4B
KC53E:  SUBD BJ_PNT+$50
KC540:  ANDA #$1F
KC542:  STD  2,Y
KC544:  LDD  BJ_PNT+$39             ;DRAWTO 0,2,3,1,5,4,0  draw point 15 to 11
KC546:  SUBD BJ_PNT+$4D
KC548:  ANDA #$1F
KC54A:  STD  4,Y
KC54C:  LDD  BJ_PNT+$37
KC54E:  SUBD BJ_PNT+$4B
KC550:  ORA  #$E0
KC552:  STD  6,Y
KC554:  LDD  BJ_PNT+$34             ;draw point 11 to 10
KC556:  SUBD BJ_PNT+$39
KC558:  ANDA #$1F
KC55A:  STD  8,Y
KC55C:  LDD  BJ_PNT+$32
KC55E:  SUBD BJ_PNT+$37
KC560:  ORA  #$E0
KC562:  STD  $A,Y
KC564:  LDD  BJ_PNT+$48             ;draw point 10 to 14
KC566:  SUBD BJ_PNT+$34
KC568:  ANDA #$1F
KC56A:  STD  $C,Y
KC56C:  LDD  BJ_PNT+$46
KC56E:  SUBD BJ_PNT+$32
KC570:  ORA  #$E0
KC572:  STD  $E,Y
KC574:  LDD  BJ_PNT+$4D             ;draw point 14 to 15
KC576:  SUBD BJ_PNT+$48
KC578:  ANDA #$1F
KC57A:  LEAY $20,Y
KC57D:  STD  -16,Y
KC57F:  LDD  BJ_PNT+$4B
KC581:  SUBD BJ_PNT+$46
KC583:  ORA  #$E0
KC585:  STD  -14,Y
KC587:  LDD  BJ_PNT+$3E             ;move point 15 to 12
KC589:  SUBD BJ_PNT+$4D
KC58B:  ANDA #$1F
KC58D:  STD  -12,Y
KC58F:  LDD  BJ_PNT+$3C
KC591:  SUBD BJ_PNT+$4B
KC593:  ANDA #$1F
KC595:  STD  -10,Y
KC597:  LDD  BJ_PNT+$2A             ;draw point 12 to 8
KC599:  SUBD BJ_PNT+$3E
KC59B:  ANDA #$1F
KC59D:  STD  -8,Y
KC59F:  LDD  BJ_PNT+$28
KC5A1:  SUBD BJ_PNT+$3C
KC5A3:  ORA  #$E0
KC5A5:  STD  -6,Y
KC5A7:  LDD  BJ_PNT+$2F             ;draw point 8 to 9
KC5A9:  SUBD BJ_PNT+$2A
KC5AB:  ANDA #$1F
KC5AD:  STD  -4,Y
KC5AF:  LDD  BJ_PNT+$2D
KC5B1:  SUBD BJ_PNT+$28
KC5B3:  ORA  #$E0
KC5B5:  STD  -2,Y
KC5B7:  LDD  BJ_PNT+$43             ;draw point 9 to 13
KC5B9:  SUBD BJ_PNT+$2F
KC5BB:  ANDA #$1F
KC5BD:  STD  ,Y
KC5BF:  LDD  BJ_PNT+$41
KC5C1:  SUBD BJ_PNT+$2D
KC5C3:  ORA  #$E0
KC5C5:  STD  2,Y
KC5C7:  LDD  BJ_PNT+$3E             ;DRAWTO 0,2,3,1,5,4,0  draw point 13 to 12
KC5C9:  SUBD BJ_PNT+$43
KC5CB:  ANDA #$1F
KC5CD:  STD  4,Y
KC5CF:  LDD  BJ_PNT+$3C
KC5D1:  SUBD BJ_PNT+$41
KC5D3:  ORA  #$E0
KC5D5:  STD  6,Y
KC5D7:  LDD  BJ_PNT+$39             ;BDRAWTO 1,3,15,12,9  UP RIGHT SIDE  move point 12 to 11
KC5D9:  SUBD BJ_PNT+$3E
KC5DB:  ANDA #$1F
KC5DD:  STD  8,Y
KC5DF:  LDD  BJ_PNT+$37
KC5E1:  SUBD BJ_PNT+$3C
KC5E3:  ANDA #$1F
KC5E5:  STD  $A,Y
KC5E7:  LDD  BJ_PNT+$25             ;draw point 11 to 7
KC5E9:  SUBD BJ_PNT+$39
KC5EB:  ANDA #$1F
KC5ED:  STD  $C,Y
KC5EF:  LDD  BJ_PNT+$23
KC5F1:  SUBD BJ_PNT+$37
KC5F3:  ORA  #$E0
KC5F5:  STD  $E,Y
KC5F7:  LDD  BJ_PNT+$16             ;draw point 7 to 4
KC5F9:  SUBD BJ_PNT+$25
KC5FB:  ANDA #$1F
KC5FD:  LEAY $20,Y
KC600:  STD  -16,Y
KC602:  LDD  BJ_PNT+$14
KC604:  SUBD BJ_PNT+$23
KC606:  ORA  #$E0
KC608:  STD  -14,Y
KC60A:  LDD  BJ_PNT+$2A             ;draw point 4 to 8
KC60C:  SUBD BJ_PNT+$16
KC60E:  ANDA #$1F
KC610:  STD  -12,Y
KC612:  LDD  BJ_PNT+$28
KC614:  SUBD BJ_PNT+$14
KC616:  ORA  #$E0
KC618:  STD  -10,Y
KC61A:  LDD  BJ_PNT+$39             ;draw point 8 to 11
KC61C:  SUBD BJ_PNT+$2A
KC61E:  ANDA #$1F
KC620:  STD  -8,Y
KC622:  LDD  BJ_PNT+$37
KC624:  SUBD BJ_PNT+$28
KC626:  ORA  #$E0
KC628:  STD  -6,Y
KC62A:  LDD  BJ_PNT+$34             ;move point 11 to 10
KC62C:  SUBD BJ_PNT+$39
KC62E:  ANDA #$1F
KC630:  STD  -4,Y
KC632:  LDD  BJ_PNT+$32
KC634:  SUBD BJ_PNT+$37
KC636:  ANDA #$1F
KC638:  STD  -2,Y
KC63A:  LDD  BJ_PNT+$20             ;draw point 10 to 6
KC63C:  SUBD BJ_PNT+$34
KC63E:  ANDA #$1F
KC640:  STD  ,Y
KC642:  LDD  BJ_PNT+$1E
KC644:  SUBD BJ_PNT+$32
KC646:  ORA  #$E0
KC648:  STD  2,Y
KC64A:  LDD  BJ_PNT+$1B             ;DRAWTO 0,2,3,1,5,4,0  draw point 6 to 5
KC64C:  SUBD BJ_PNT+$20
KC64E:  ANDA #$1F
KC650:  STD  4,Y
KC652:  LDD  BJ_PNT+$19
KC654:  SUBD BJ_PNT+$1E
KC656:  ORA  #$E0
KC658:  STD  6,Y
KC65A:  LDD  BJ_PNT+$2F             ;draw point 5 to 9
KC65C:  SUBD BJ_PNT+$1B
KC65E:  ANDA #$1F
KC660:  STD  8,Y
KC662:  LDD  BJ_PNT+$2D
KC664:  SUBD BJ_PNT+$19
KC666:  ORA  #$E0
KC668:  STD  $A,Y
KC66A:  LDD  BJ_PNT+$34             ;draw point 9 to 10
KC66C:  SUBD BJ_PNT+$2F
KC66E:  ANDA #$1F
KC670:  STD  $C,Y
KC672:  LDD  BJ_PNT+$32
KC674:  SUBD BJ_PNT+$2D
KC676:  ORA  #$E0
KC678:  STD  $E,Y
KC67A:  LDD  BJ_PNT+$02             ;move point 10 to 0
KC67C:  SUBD BJ_PNT+$34
KC67E:  ANDA #$1F
KC680:  LEAY $20,Y
KC683:  STD  -16,Y
KC685:  LDD  ST_QUZ
KC687:  SUBD BJ_PNT+$32
KC689:  ANDA #$1F
KC68B:  STD  -14,Y
KC68D:  LDD  BJ_PNT+$11             ;draw point 0 to 3
KC68F:  SUBD BJ_PNT+$02
KC691:  ANDA #$1F
KC693:  STD  -12,Y
KC695:  LDD  BJ_PNT+$0F
KC697:  SUBD ST_QUZ
KC699:  ORA  #$E0
KC69B:  STD  -10,Y
KC69D:  LDD  BJ_PNT+$25             ;draw point 3 to 7
KC69F:  SUBD BJ_PNT+$11
KC6A1:  ANDA #$1F
KC6A3:  STD  -8,Y
KC6A5:  LDD  BJ_PNT+$23
KC6A7:  SUBD BJ_PNT+$0F
KC6A9:  ORA  #$E0
KC6AB:  STD  -6,Y
KC6AD:  LDD  BJ_PNT+$20             ;draw point 7 to 6
KC6AF:  SUBD BJ_PNT+$25
KC6B1:  ANDA #$1F
KC6B3:  STD  -4,Y
KC6B5:  LDD  BJ_PNT+$1E
KC6B7:  SUBD BJ_PNT+$23
KC6B9:  ORA  #$E0
KC6BB:  STD  -2,Y
KC6BD:  LDD  BJ_PNT+$0C             ;draw point 6 to 2
KC6BF:  SUBD BJ_PNT+$20
KC6C1:  ANDA #$1F
KC6C3:  STD  ,Y
KC6C5:  LDD  BJ_PNT+$0A
KC6C7:  SUBD BJ_PNT+$1E
KC6C9:  ORA  #$E0
KC6CB:  STD  2,Y
KC6CD:  LDD  BJ_PNT+$11             ;DRAWTO 0,2,3,1,5,4,0  draw point 2 to 3
KC6CF:  SUBD BJ_PNT+$0C
KC6D1:  ANDA #$1F
KC6D3:  STD  4,Y
KC6D5:  LDD  BJ_PNT+$0F
KC6D7:  SUBD BJ_PNT+$0A
KC6D9:  ORA  #$E0
KC6DB:  STD  6,Y
KC6DD:  LDD  BJ_PNT+$0C             ;BDRAWTO 1,3,15,12,9  UP RIGHT SIDE  move point 3 to 2
KC6DF:  SUBD BJ_PNT+$11
KC6E1:  ANDA #$1F
KC6E3:  STD  8,Y
KC6E5:  LDD  BJ_PNT+$0A
KC6E7:  SUBD BJ_PNT+$0F
KC6E9:  ANDA #$1F
KC6EB:  STD  $A,Y
KC6ED:  LDD  BJ_PNT+$07             ;draw point 2 to 1
KC6EF:  SUBD BJ_PNT+$0C
KC6F1:  ANDA #$1F
KC6F3:  STD  $C,Y
KC6F5:  LDD  BJ_PNT+$05
KC6F7:  SUBD BJ_PNT+$0A
KC6F9:  ORA  #$E0
KC6FB:  STD  $E,Y
KC6FD:  LDD  BJ_PNT+$02             ;draw point 1 to 0
KC6FF:  SUBD BJ_PNT+$07
KC701:  ANDA #$1F
KC703:  LEAY $20,Y
KC706:  STD  -16,Y
KC708:  LDD  ST_QUZ
KC70A:  SUBD BJ_PNT+$05
KC70C:  ORA  #$E0
KC70E:  STD  -14,Y
KC710:  LDD  BJ_PNT+$16             ;draw point 0 to 4
KC712:  SUBD BJ_PNT+$02
KC714:  ANDA #$1F
KC716:  STD  -12,Y
KC718:  LDD  BJ_PNT+$14
KC71A:  SUBD ST_QUZ
KC71C:  ORA  #$E0
KC71E:  STD  -10,Y
KC720:  LDD  BJ_PNT+$1B             ;draw point 4 to 5
KC722:  SUBD BJ_PNT+$16
KC724:  ANDA #$1F
KC726:  STD  -8,Y
KC728:  LDD  BJ_PNT+$19
KC72A:  SUBD BJ_PNT+$14
KC72C:  ORA  #$E0
KC72E:  STD  -6,Y
KC730:  LDD  BJ_PNT+$07             ;draw point 5 to 1
KC732:  SUBD BJ_PNT+$1B
KC734:  ANDA #$1F
KC736:  STD  -4,Y
KC738:  LDD  BJ_PNT+$05
KC73A:  SUBD BJ_PNT+$19
KC73C:  ORA  #$E0
KC73E:  STD  -2,Y
KC740:  LEAY ,Y
KC742:  LDA  #$48
KC744:  TFR  A,DP
.dpage $48
KC746:  LDD  BJ_PNT+$05
KC749:  STD  BJ_CX
KC74B:  LDD  BJ_PNT+$07
KC74E:  STD  BJ_CY
KC750:  PULS A,B,X,U,PC

;------------------------------------------------------------------------------
; draw_atst_side - draw routine of objects 20 and 22, the left and the right half of the AT-ST head as separate
;   8 point pieces, 11 lines at full brightness. they are the pictures of explosion piece types 3 and 5
;------------------------------------------------------------------------------
draw_atst_side:
KC752:  LDA  #$4E
KC754:  TFR  A,DP
.dpage $4E
KC756:  LDD  BJ_PNT+$25             ;beam to point 7
KC758:  SUBD BJ_CY
KC75B:  ANDA #$1F
KC75D:  STD  ,Y
KC75F:  LDD  BJ_PNT+$23
KC761:  SUBD BJ_CX
KC764:  ANDA #$1F
KC766:  STD  2,Y
KC768:  LDD  BJ_PNT+$02             ;DRAWTO 0,2,3,1,5,4,0  draw point 7 to 0
KC76A:  SUBD BJ_PNT+$25
KC76C:  ANDA #$1F
KC76E:  STD  4,Y
KC770:  LDD  ST_QUZ
KC772:  SUBD BJ_PNT+$23
KC774:  ORA  #$E0
KC776:  STD  6,Y
KC778:  LDD  BJ_PNT+$20             ;draw point 0 to 6
KC77A:  SUBD BJ_PNT+$02
KC77C:  ANDA #$1F
KC77E:  STD  8,Y
KC780:  LDD  BJ_PNT+$1E
KC782:  SUBD ST_QUZ
KC784:  ORA  #$E0
KC786:  STD  $A,Y
KC788:  LDD  BJ_PNT+$25             ;draw point 6 to 7
KC78A:  SUBD BJ_PNT+$20
KC78C:  ANDA #$1F
KC78E:  STD  $C,Y
KC790:  LDD  BJ_PNT+$23
KC792:  SUBD BJ_PNT+$1E
KC794:  ORA  #$E0
KC796:  STD  $E,Y
KC798:  LDD  BJ_PNT+$1B             ;draw point 7 to 5
KC79A:  SUBD BJ_PNT+$25
KC79C:  ANDA #$1F
KC79E:  LEAY $20,Y
KC7A1:  STD  -16,Y
KC7A3:  LDD  BJ_PNT+$19
KC7A5:  SUBD BJ_PNT+$23
KC7A7:  ORA  #$E0
KC7A9:  STD  -14,Y
KC7AB:  LDD  BJ_PNT+$16             ;draw point 5 to 4
KC7AD:  SUBD BJ_PNT+$1B
KC7AF:  ANDA #$1F
KC7B1:  STD  -12,Y
KC7B3:  LDD  BJ_PNT+$14
KC7B5:  SUBD BJ_PNT+$19
KC7B7:  ORA  #$E0
KC7B9:  STD  -10,Y
KC7BB:  LDD  BJ_PNT+$20             ;draw point 4 to 6
KC7BD:  SUBD BJ_PNT+$16
KC7BF:  ANDA #$1F
KC7C1:  STD  -8,Y
KC7C3:  LDD  BJ_PNT+$1E
KC7C5:  SUBD BJ_PNT+$14
KC7C7:  ORA  #$E0
KC7C9:  STD  -6,Y
KC7CB:  LDD  BJ_PNT+$25             ;draw point 6 to 7
KC7CD:  SUBD BJ_PNT+$20
KC7CF:  ANDA #$1F
KC7D1:  STD  -4,Y
KC7D3:  LDD  BJ_PNT+$23
KC7D5:  SUBD BJ_PNT+$1E
KC7D7:  ORA  #$E0
KC7D9:  STD  -2,Y
KC7DB:  LDD  BJ_PNT+$16             ;move point 7 to 4
KC7DD:  SUBD BJ_PNT+$25
KC7DF:  ANDA #$1F
KC7E1:  STD  ,Y
KC7E3:  LDD  BJ_PNT+$14
KC7E5:  SUBD BJ_PNT+$23
KC7E7:  ANDA #$1F
KC7E9:  STD  2,Y
KC7EB:  LDD  BJ_PNT+$11             ;DRAWTO 0,2,3,1,5,4,0  draw point 4 to 3
KC7ED:  SUBD BJ_PNT+$16
KC7EF:  ANDA #$1F
KC7F1:  STD  4,Y
KC7F3:  LDD  BJ_PNT+$0F
KC7F5:  SUBD BJ_PNT+$14
KC7F7:  ORA  #$E0
KC7F9:  STD  6,Y
KC7FB:  LDD  BJ_PNT+$0C             ;draw point 3 to 2
KC7FD:  SUBD BJ_PNT+$11
KC7FF:  ANDA #$1F
KC801:  STD  8,Y
KC803:  LDD  BJ_PNT+$0A
KC805:  SUBD BJ_PNT+$0F
KC807:  ORA  #$E0
KC809:  STD  $A,Y
KC80B:  LDD  BJ_PNT+$07             ;draw point 2 to 1
KC80D:  SUBD BJ_PNT+$0C
KC80F:  ANDA #$1F
KC811:  STD  $C,Y
KC813:  LDD  BJ_PNT+$05
KC815:  SUBD BJ_PNT+$0A
KC817:  ORA  #$E0
KC819:  STD  $E,Y
KC81B:  LDD  BJ_PNT+$02             ;draw point 1 to 0
KC81D:  SUBD BJ_PNT+$07
KC81F:  ANDA #$1F
KC821:  LEAY $20,Y
KC824:  STD  -16,Y
KC826:  LDD  ST_QUZ
KC828:  SUBD BJ_PNT+$05
KC82A:  ORA  #$E0
KC82C:  STD  -14,Y
KC82E:  LEAY -12,Y
KC830:  LDA  #$48
KC832:  TFR  A,DP
.dpage $48
KC834:  LDD  ST_QUZ
KC837:  STD  BJ_CX
KC839:  LDD  BJ_PNT+$02
KC83C:  STD  BJ_CY
KC83E:  PULS A,B,X,U,PC

;------------------------------------------------------------------------------
; draw_atst_top - draw routine of object 21, a 6 point wedge made of the top and front points of the AT-ST head,
;   9 lines at full brightness. it is the picture of explosion piece type 4
;------------------------------------------------------------------------------
draw_atst_top:
KC840:  LDA  #$4E
KC842:  TFR  A,DP
.dpage $4E
KC844:  LDD  BJ_PNT+$02             ;beam to point 0
KC846:  SUBD BJ_CY
KC849:  ANDA #$1F
KC84B:  STD  ,Y
KC84D:  LDD  ST_QUZ
KC84F:  SUBD BJ_CX
KC852:  ANDA #$1F
KC854:  STD  2,Y
KC856:  LDD  BJ_PNT+$0C             ;DRAWTO 0,2,3,1,5,4,0  draw point 0 to 2
KC858:  SUBD BJ_PNT+$02
KC85A:  ANDA #$1F
KC85C:  STD  4,Y
KC85E:  LDD  BJ_PNT+$0A
KC860:  SUBD ST_QUZ
KC862:  ORA  #$E0
KC864:  STD  6,Y
KC866:  LDD  BJ_PNT+$16             ;draw point 2 to 4
KC868:  SUBD BJ_PNT+$0C
KC86A:  ANDA #$1F
KC86C:  STD  8,Y
KC86E:  LDD  BJ_PNT+$14
KC870:  SUBD BJ_PNT+$0A
KC872:  ORA  #$E0
KC874:  STD  $A,Y
KC876:  LDD  BJ_PNT+$02             ;draw point 4 to 0
KC878:  SUBD BJ_PNT+$16
KC87A:  ANDA #$1F
KC87C:  STD  $C,Y
KC87E:  LDD  ST_QUZ
KC880:  SUBD BJ_PNT+$14
KC882:  ORA  #$E0
KC884:  STD  $E,Y
KC886:  LDD  BJ_PNT+$07             ;draw point 0 to 1
KC888:  SUBD BJ_PNT+$02
KC88A:  ANDA #$1F
KC88C:  LEAY $20,Y
KC88F:  STD  -16,Y
KC891:  LDD  BJ_PNT+$05
KC893:  SUBD ST_QUZ
KC895:  ORA  #$E0
KC897:  STD  -14,Y
KC899:  LDD  BJ_PNT+$11             ;draw point 1 to 3
KC89B:  SUBD BJ_PNT+$07
KC89D:  ANDA #$1F
KC89F:  STD  -12,Y
KC8A1:  LDD  BJ_PNT+$0F
KC8A3:  SUBD BJ_PNT+$05
KC8A5:  ORA  #$E0
KC8A7:  STD  -10,Y
KC8A9:  LDD  BJ_PNT+$1B             ;draw point 3 to 5
KC8AB:  SUBD BJ_PNT+$11
KC8AD:  ANDA #$1F
KC8AF:  STD  -8,Y
KC8B1:  LDD  BJ_PNT+$19
KC8B3:  SUBD BJ_PNT+$0F
KC8B5:  ORA  #$E0
KC8B7:  STD  -6,Y
KC8B9:  LDD  BJ_PNT+$07             ;draw point 5 to 1
KC8BB:  SUBD BJ_PNT+$1B
KC8BD:  ANDA #$1F
KC8BF:  STD  -4,Y
KC8C1:  LDD  BJ_PNT+$05
KC8C3:  SUBD BJ_PNT+$19
KC8C5:  ORA  #$E0
KC8C7:  STD  -2,Y
KC8C9:  LDD  BJ_PNT+$16             ;move point 1 to 4
KC8CB:  SUBD BJ_PNT+$07
KC8CD:  ANDA #$1F
KC8CF:  STD  ,Y
KC8D1:  LDD  BJ_PNT+$14
KC8D3:  SUBD BJ_PNT+$05
KC8D5:  ANDA #$1F
KC8D7:  STD  2,Y
KC8D9:  LDD  BJ_PNT+$1B             ;DRAWTO 0,2,3,1,5,4,0  draw point 4 to 5
KC8DB:  SUBD BJ_PNT+$16
KC8DD:  ANDA #$1F
KC8DF:  STD  4,Y
KC8E1:  LDD  BJ_PNT+$19
KC8E3:  SUBD BJ_PNT+$14
KC8E5:  ORA  #$E0
KC8E7:  STD  6,Y
KC8E9:  LDD  BJ_PNT+$0C             ;BDRAWTO 1,3,15,12,9  UP RIGHT SIDE  move point 5 to 2
KC8EB:  SUBD BJ_PNT+$1B
KC8ED:  ANDA #$1F
KC8EF:  STD  8,Y
KC8F1:  LDD  BJ_PNT+$0A
KC8F3:  SUBD BJ_PNT+$19
KC8F5:  ANDA #$1F
KC8F7:  STD  $A,Y
KC8F9:  LDD  BJ_PNT+$11             ;draw point 2 to 3
KC8FB:  SUBD BJ_PNT+$0C
KC8FD:  ANDA #$1F
KC8FF:  STD  $C,Y
KC901:  LDD  BJ_PNT+$0F
KC903:  SUBD BJ_PNT+$0A
KC905:  ORA  #$E0
KC907:  STD  $E,Y
KC909:  LEAY $10,Y
KC90C:  LDA  #$48
KC90E:  TFR  A,DP
.dpage $48
KC910:  LDD  BJ_PNT+$0F
KC913:  STD  BJ_CX
KC915:  LDD  BJ_PNT+$11
KC918:  STD  BJ_CY
KC91A:  PULS A,B,X,U,PC

;------------------------------------------------------------------------------
; draw_atat_body - draw routine of object 23, the body of an AT-AT walker (24 points perspected into buffer
;   points 1 to 24): 26 lines at full brightness between points 1 to 16
;------------------------------------------------------------------------------
draw_atat_body:
KC91C:  LDA  #$4E
KC91E:  TFR  A,DP
.dpage $4E
KC920:  LDD  BJ_PNT+$07             ;beam to point 1
KC922:  SUBD BJ_CY
KC925:  ANDA #$1F
KC927:  STD  ,Y
KC929:  LDD  BJ_PNT+$05
KC92B:  SUBD BJ_CX
KC92E:  ANDA #$1F
KC930:  STD  2,Y
KC932:  LDD  BJ_PNT+$11             ;DRAWTO 0,2,3,1,5,4,0  draw point 1 to 3
KC934:  SUBD BJ_PNT+$07
KC936:  ANDA #$1F
KC938:  STD  4,Y
KC93A:  LDD  BJ_PNT+$0F
KC93C:  SUBD BJ_PNT+$05
KC93E:  ORA  #$E0
KC940:  STD  6,Y
KC942:  LDD  BJ_PNT+$1B             ;draw point 3 to 5
KC944:  SUBD BJ_PNT+$11
KC946:  ANDA #$1F
KC948:  STD  8,Y
KC94A:  LDD  BJ_PNT+$19
KC94C:  SUBD BJ_PNT+$0F
KC94E:  ORA  #$E0
KC950:  STD  $A,Y
KC952:  LDD  BJ_PNT+$25             ;draw point 5 to 7
KC954:  SUBD BJ_PNT+$1B
KC956:  ANDA #$1F
KC958:  STD  $C,Y
KC95A:  LDD  BJ_PNT+$23
KC95C:  SUBD BJ_PNT+$19
KC95E:  ORA  #$E0
KC960:  STD  $E,Y
KC962:  LDD  BJ_PNT+$2F             ;draw point 7 to 9
KC964:  SUBD BJ_PNT+$25
KC966:  ANDA #$1F
KC968:  LEAY $20,Y
KC96B:  STD  -16,Y
KC96D:  LDD  BJ_PNT+$2D
KC96F:  SUBD BJ_PNT+$23
KC971:  ORA  #$E0
KC973:  STD  -14,Y
KC975:  LDD  BJ_PNT+$39             ;draw point 9 to 11
KC977:  SUBD BJ_PNT+$2F
KC979:  ANDA #$1F
KC97B:  STD  -12,Y
KC97D:  LDD  BJ_PNT+$37
KC97F:  SUBD BJ_PNT+$2D
KC981:  ORA  #$E0
KC983:  STD  -10,Y
KC985:  LDD  BJ_PNT+$43             ;draw point 11 to 13
KC987:  SUBD BJ_PNT+$39
KC989:  ANDA #$1F
KC98B:  STD  -8,Y
KC98D:  LDD  BJ_PNT+$41
KC98F:  SUBD BJ_PNT+$37
KC991:  ORA  #$E0
KC993:  STD  -6,Y
KC995:  LDD  BJ_PNT+$4D             ;draw point 13 to 15
KC997:  SUBD BJ_PNT+$43
KC999:  ANDA #$1F
KC99B:  STD  -4,Y
KC99D:  LDD  BJ_PNT+$4B
KC99F:  SUBD BJ_PNT+$41
KC9A1:  ORA  #$E0
KC9A3:  STD  -2,Y
KC9A5:  LDD  BJ_PNT+$07             ;draw point 15 to 1
KC9A7:  SUBD BJ_PNT+$4D
KC9A9:  ANDA #$1F
KC9AB:  STD  ,Y
KC9AD:  LDD  BJ_PNT+$05
KC9AF:  SUBD BJ_PNT+$4B
KC9B1:  ORA  #$E0
KC9B3:  STD  2,Y
KC9B5:  LDD  BJ_PNT+$0C             ;DRAWTO 0,2,3,1,5,4,0  draw point 1 to 2
KC9B7:  SUBD BJ_PNT+$07
KC9B9:  ANDA #$1F
KC9BB:  STD  4,Y
KC9BD:  LDD  BJ_PNT+$0A
KC9BF:  SUBD BJ_PNT+$05
KC9C1:  ORA  #$E0
KC9C3:  STD  6,Y
KC9C5:  LDD  BJ_PNT+$16             ;draw point 2 to 4
KC9C7:  SUBD BJ_PNT+$0C
KC9C9:  ANDA #$1F
KC9CB:  STD  8,Y
KC9CD:  LDD  BJ_PNT+$14
KC9CF:  SUBD BJ_PNT+$0A
KC9D1:  ORA  #$E0
KC9D3:  STD  $A,Y
KC9D5:  LDD  BJ_PNT+$20             ;draw point 4 to 6
KC9D7:  SUBD BJ_PNT+$16
KC9D9:  ANDA #$1F
KC9DB:  STD  $C,Y
KC9DD:  LDD  BJ_PNT+$1E
KC9DF:  SUBD BJ_PNT+$14
KC9E1:  ORA  #$E0
KC9E3:  STD  $E,Y
KC9E5:  LDD  BJ_PNT+$2A             ;draw point 6 to 8
KC9E7:  SUBD BJ_PNT+$20
KC9E9:  ANDA #$1F
KC9EB:  LEAY $20,Y
KC9EE:  STD  -16,Y
KC9F0:  LDD  BJ_PNT+$28
KC9F2:  SUBD BJ_PNT+$1E
KC9F4:  ORA  #$E0
KC9F6:  STD  -14,Y
KC9F8:  LDD  BJ_PNT+$34             ;draw point 8 to 10
KC9FA:  SUBD BJ_PNT+$2A
KC9FC:  ANDA #$1F
KC9FE:  STD  -12,Y
KCA00:  LDD  BJ_PNT+$32
KCA02:  SUBD BJ_PNT+$28
KCA04:  ORA  #$E0
KCA06:  STD  -10,Y
KCA08:  LDD  BJ_PNT+$3E             ;draw point 10 to 12
KCA0A:  SUBD BJ_PNT+$34
KCA0C:  ANDA #$1F
KCA0E:  STD  -8,Y
KCA10:  LDD  BJ_PNT+$3C
KCA12:  SUBD BJ_PNT+$32
KCA14:  ORA  #$E0
KCA16:  STD  -6,Y
KCA18:  LDD  BJ_PNT+$48             ;draw point 12 to 14
KCA1A:  SUBD BJ_PNT+$3E
KCA1C:  ANDA #$1F
KCA1E:  STD  -4,Y
KCA20:  LDD  BJ_PNT+$46
KCA22:  SUBD BJ_PNT+$3C
KCA24:  ORA  #$E0
KCA26:  STD  -2,Y
KCA28:  LDD  BJ_PNT+$52             ;draw point 14 to 16
KCA2A:  SUBD BJ_PNT+$48
KCA2C:  ANDA #$1F
KCA2E:  STD  ,Y
KCA30:  LDD  BJ_PNT+$50
KCA32:  SUBD BJ_PNT+$46
KCA34:  ORA  #$E0
KCA36:  STD  2,Y
KCA38:  LDD  BJ_PNT+$0C             ;DRAWTO 0,2,3,1,5,4,0  draw point 16 to 2
KCA3A:  SUBD BJ_PNT+$52
KCA3C:  ANDA #$1F
KCA3E:  STD  4,Y
KCA40:  LDD  BJ_PNT+$0A
KCA42:  SUBD BJ_PNT+$50
KCA44:  ORA  #$E0
KCA46:  STD  6,Y
KCA48:  LDD  BJ_PNT+$4D             ;BDRAWTO 1,3,15,12,9  UP RIGHT SIDE  move point 2 to 15
KCA4A:  SUBD BJ_PNT+$0C
KCA4C:  ANDA #$1F
KCA4E:  STD  8,Y
KCA50:  LDD  BJ_PNT+$4B
KCA52:  SUBD BJ_PNT+$0A
KCA54:  ANDA #$1F
KCA56:  STD  $A,Y
KCA58:  LDD  BJ_PNT+$52             ;draw point 15 to 16
KCA5A:  SUBD BJ_PNT+$4D
KCA5C:  ANDA #$1F
KCA5E:  STD  $C,Y
KCA60:  LDD  BJ_PNT+$50
KCA62:  SUBD BJ_PNT+$4B
KCA64:  ORA  #$E0
KCA66:  STD  $E,Y
KCA68:  LDD  BJ_PNT+$11             ;move point 16 to 3
KCA6A:  SUBD BJ_PNT+$52
KCA6C:  ANDA #$1F
KCA6E:  LEAY $20,Y
KCA71:  STD  -16,Y
KCA73:  LDD  BJ_PNT+$0F
KCA75:  SUBD BJ_PNT+$50
KCA77:  ANDA #$1F
KCA79:  STD  -14,Y
KCA7B:  LDD  BJ_PNT+$43             ;draw point 3 to 13
KCA7D:  SUBD BJ_PNT+$11
KCA7F:  ANDA #$1F
KCA81:  STD  -12,Y
KCA83:  LDD  BJ_PNT+$41
KCA85:  SUBD BJ_PNT+$0F
KCA87:  ORA  #$E0
KCA89:  STD  -10,Y
KCA8B:  LDD  BJ_PNT+$48             ;draw point 13 to 14
KCA8D:  SUBD BJ_PNT+$43
KCA8F:  ANDA #$1F
KCA91:  STD  -8,Y
KCA93:  LDD  BJ_PNT+$46
KCA95:  SUBD BJ_PNT+$41
KCA97:  ORA  #$E0
KCA99:  STD  -6,Y
KCA9B:  LDD  BJ_PNT+$16             ;draw point 14 to 4
KCA9D:  SUBD BJ_PNT+$48
KCA9F:  ANDA #$1F
KCAA1:  STD  -4,Y
KCAA3:  LDD  BJ_PNT+$14
KCAA5:  SUBD BJ_PNT+$46
KCAA7:  ORA  #$E0
KCAA9:  STD  -2,Y
KCAAB:  LDD  BJ_PNT+$1B             ;move point 4 to 5
KCAAD:  SUBD BJ_PNT+$16
KCAAF:  ANDA #$1F
KCAB1:  STD  ,Y
KCAB3:  LDD  BJ_PNT+$19
KCAB5:  SUBD BJ_PNT+$14
KCAB7:  ANDA #$1F
KCAB9:  STD  2,Y
KCABB:  LDD  BJ_PNT+$39             ;DRAWTO 0,2,3,1,5,4,0  draw point 5 to 11
KCABD:  SUBD BJ_PNT+$1B
KCABF:  ANDA #$1F
KCAC1:  STD  4,Y
KCAC3:  LDD  BJ_PNT+$37
KCAC5:  SUBD BJ_PNT+$19
KCAC7:  ORA  #$E0
KCAC9:  STD  6,Y
KCACB:  LDD  BJ_PNT+$3E             ;draw point 11 to 12
KCACD:  SUBD BJ_PNT+$39
KCACF:  ANDA #$1F
KCAD1:  STD  8,Y
KCAD3:  LDD  BJ_PNT+$3C
KCAD5:  SUBD BJ_PNT+$37
KCAD7:  ORA  #$E0
KCAD9:  STD  $A,Y
KCADB:  LDD  BJ_PNT+$20             ;draw point 12 to 6
KCADD:  SUBD BJ_PNT+$3E
KCADF:  ANDA #$1F
KCAE1:  STD  $C,Y
KCAE3:  LDD  BJ_PNT+$1E
KCAE5:  SUBD BJ_PNT+$3C
KCAE7:  ORA  #$E0
KCAE9:  STD  $E,Y
KCAEB:  LDD  BJ_PNT+$2F             ;move point 6 to 9
KCAED:  SUBD BJ_PNT+$20
KCAEF:  ANDA #$1F
KCAF1:  LEAY $20,Y
KCAF4:  STD  -16,Y
KCAF6:  LDD  BJ_PNT+$2D
KCAF8:  SUBD BJ_PNT+$1E
KCAFA:  ANDA #$1F
KCAFC:  STD  -14,Y
KCAFE:  LDD  BJ_PNT+$34             ;draw point 9 to 10
KCB00:  SUBD BJ_PNT+$2F
KCB02:  ANDA #$1F
KCB04:  STD  -12,Y
KCB06:  LDD  BJ_PNT+$32
KCB08:  SUBD BJ_PNT+$2D
KCB0A:  ORA  #$E0
KCB0C:  STD  -10,Y
KCB0E:  LDD  BJ_PNT+$25             ;move point 10 to 7
KCB10:  SUBD BJ_PNT+$34
KCB12:  ANDA #$1F
KCB14:  STD  -8,Y
KCB16:  LDD  BJ_PNT+$23
KCB18:  SUBD BJ_PNT+$32
KCB1A:  ANDA #$1F
KCB1C:  STD  -6,Y
KCB1E:  LDD  BJ_PNT+$2A             ;draw point 7 to 8
KCB20:  SUBD BJ_PNT+$25
KCB22:  ANDA #$1F
KCB24:  STD  -4,Y
KCB26:  LDD  BJ_PNT+$28
KCB28:  SUBD BJ_PNT+$23
KCB2A:  ORA  #$E0
KCB2C:  STD  -2,Y
KCB2E:  LEAY ,Y
KCB30:  LDA  #$48
KCB32:  TFR  A,DP
.dpage $48
KCB34:  LDD  BJ_PNT+$28
KCB37:  STD  BJ_CX
KCB39:  LDD  BJ_PNT+$2A
KCB3C:  STD  BJ_CY
KCB3E:  PULS A,B,X,U,PC

;------------------------------------------------------------------------------
; draw_atat_neck - draw routine of object 26, which has the point table of the AT-AT head: four lines at full
;   brightness from buffer points 17 to 20, which belong to the body (object 23), to points 22 to 25, the back of
;   the head - the neck. page 0 draws it only when the body is in view
;------------------------------------------------------------------------------
draw_atat_neck:
KCB40:  LDA  #$4E
KCB42:  TFR  A,DP
.dpage $4E
KCB44:  LDD  BJ_PNT+$57             ;beam to point 17
KCB46:  SUBD BJ_CY
KCB49:  ANDA #$1F
KCB4B:  STD  ,Y
KCB4D:  LDD  BJ_PNT+$55
KCB4F:  SUBD BJ_CX
KCB52:  ANDA #$1F
KCB54:  STD  2,Y
KCB56:  LDD  BJ_PNT+$7A             ;DRAWTO 0,2,3,1,5,4,0  draw point 17 to 24
KCB58:  SUBD BJ_PNT+$57
KCB5A:  ANDA #$1F
KCB5C:  STD  4,Y
KCB5E:  LDD  BJ_PNT+$78
KCB60:  SUBD BJ_PNT+$55
KCB62:  ANDA #$1F
KCB64:  ORA  #$A0
KCB66:  STD  6,Y
KCB68:  LDD  BJ_PNT+$5C             ;BDRAWTO 1,3,15,12,9  UP RIGHT SIDE  move point 24 to 18
KCB6A:  SUBD BJ_PNT+$7A
KCB6C:  ANDA #$1F
KCB6E:  STD  8,Y
KCB70:  LDD  BJ_PNT+$5A
KCB72:  SUBD BJ_PNT+$78
KCB74:  ANDA #$1F
KCB76:  STD  $A,Y
KCB78:  LDD  BJ_PNT+$7F             ;draw point 18 to 25
KCB7A:  SUBD BJ_PNT+$5C
KCB7C:  ANDA #$1F
KCB7E:  STD  $C,Y
KCB80:  LDD  BJ_PNT+$7D
KCB82:  SUBD BJ_PNT+$5A
KCB84:  ANDA #$1F
KCB86:  ORA  #$A0
KCB88:  STD  $E,Y
KCB8A:  LDD  BJ_PNT+$61             ;move point 25 to 19
KCB8C:  SUBD BJ_PNT+$7F
KCB8E:  ANDA #$1F
KCB90:  LEAY $20,Y
KCB93:  STD  -16,Y
KCB95:  LDD  BJ_PNT+$5F
KCB97:  SUBD BJ_PNT+$7D
KCB99:  ANDA #$1F
KCB9B:  STD  -14,Y
KCB9D:  LDD  BJ_PNT+$70             ;draw point 19 to 22
KCB9F:  SUBD BJ_PNT+$61
KCBA1:  ANDA #$1F
KCBA3:  STD  -12,Y
KCBA5:  LDD  BJ_PNT+$6E
KCBA7:  SUBD BJ_PNT+$5F
KCBA9:  ANDA #$1F
KCBAB:  ORA  #$A0
KCBAD:  STD  -10,Y
KCBAF:  LDD  BJ_PNT+$66             ;move point 22 to 20
KCBB1:  SUBD BJ_PNT+$70
KCBB3:  ANDA #$1F
KCBB5:  STD  -8,Y
KCBB7:  LDD  BJ_PNT+$64
KCBB9:  SUBD BJ_PNT+$6E
KCBBB:  ANDA #$1F
KCBBD:  STD  -6,Y
KCBBF:  LDD  BJ_PNT+$75             ;draw point 20 to 23
KCBC1:  SUBD BJ_PNT+$66
KCBC3:  ANDA #$1F
KCBC5:  STD  -4,Y
KCBC7:  LDD  BJ_PNT+$73
KCBC9:  SUBD BJ_PNT+$64
KCBCB:  ANDA #$1F
KCBCD:  ORA  #$A0
KCBCF:  STD  -2,Y
KCBD1:  LEAY ,Y
KCBD3:  LDA  #$48
KCBD5:  TFR  A,DP
.dpage $48
KCBD7:  LDD  BJ_PNT+$73
KCBDA:  STD  BJ_CX
KCBDC:  LDD  BJ_PNT+$75
KCBDF:  STD  BJ_CY
KCBE1:  PULS A,B,X,U,PC

;------------------------------------------------------------------------------
; draw_atat_head - draw routine of object 24, the head of an AT-AT (21 points perspected into buffer points 22
;   to 42, after the body's): 21 lines with depth cue brightness
;------------------------------------------------------------------------------
draw_atat_head:
KCBE3:  LDA  #$4E
KCBE5:  TFR  A,DP
.dpage $4E
KCBE7:  LDD  BJ_PNT+$7A             ;beam to point 24
KCBE9:  SUBD BJ_CY
KCBEC:  ANDA #$1F
KCBEE:  STD  ,Y
KCBF0:  LDD  BJ_PNT+$78
KCBF2:  SUBD BJ_CX
KCBF5:  ANDA #$1F
KCBF7:  STD  2,Y
KCBF9:  LDD  BJ_PNT+$84             ;DRAWTO 0,2,3,1,5,4,0  draw point 24 to 26, intensity from the two points' flag bytes
KCBFB:  SUBD BJ_PNT+$7A
KCBFD:  ANDA #$1F
KCBFF:  STD  4,Y
KCC01:  LDD  BJ_PNT+$82
KCC03:  SUBD BJ_PNT+$78
KCC05:  ANDA #$1F
KCC07:  ORA  BJ_PNT+$86
KCC09:  ADDA BJ_PNT+$7C
KCC0B:  STD  6,Y
KCC0D:  LDD  BJ_PNT+$8E             ;BDRAWTO 1,3,15,12,9  UP RIGHT SIDE  draw point 26 to 28, intensity from the two points' flag bytes
KCC0F:  SUBD BJ_PNT+$84
KCC11:  ANDA #$1F
KCC13:  STD  8,Y
KCC15:  LDD  BJ_PNT+$8C
KCC17:  SUBD BJ_PNT+$82
KCC19:  ANDA #$1F
KCC1B:  ORA  BJ_PNT+$90
KCC1D:  ADDA BJ_PNT+$86
KCC1F:  STD  $A,Y
KCC21:  LDD  BJ_PNT+$98             ;draw point 28 to 30, intensity from the two points' flag bytes
KCC23:  SUBD BJ_PNT+$8E
KCC25:  ANDA #$1F
KCC27:  STD  $C,Y
KCC29:  LDD  BJ_PNT+$96
KCC2B:  SUBD BJ_PNT+$8C
KCC2D:  ANDA #$1F
KCC2F:  ORA  BJ_PNT+$9A
KCC31:  ADDA BJ_PNT+$90
KCC33:  STD  $E,Y
KCC35:  LDD  BJ_PNT+$A2             ;draw point 30 to 32, intensity from the two points' flag bytes
KCC37:  SUBD BJ_PNT+$98
KCC39:  ANDA #$1F
KCC3B:  LEAY $20,Y
KCC3E:  STD  -16,Y
KCC40:  LDD  BJ_PNT+$A0
KCC42:  SUBD BJ_PNT+$96
KCC44:  ANDA #$1F
KCC46:  ORA  BJ_PNT+$A4
KCC48:  ADDA BJ_PNT+$9A
KCC4A:  STD  -14,Y
KCC4C:  LDD  BJ_PNT+$AC             ;draw point 32 to 34, intensity from the two points' flag bytes
KCC4E:  SUBD BJ_PNT+$A2
KCC50:  ANDA #$1F
KCC52:  STD  -12,Y
KCC54:  LDD  BJ_PNT+$AA
KCC56:  SUBD BJ_PNT+$A0
KCC58:  ANDA #$1F
KCC5A:  ORA  BJ_PNT+$AE
KCC5C:  ADDA BJ_PNT+$A4
KCC5E:  STD  -10,Y
KCC60:  LDD  BJ_PNT+$B6             ;draw point 34 to 36, intensity from the two points' flag bytes
KCC62:  SUBD BJ_PNT+$AC
KCC64:  ANDA #$1F
KCC66:  STD  -8,Y
KCC68:  LDD  BJ_PNT+$B4
KCC6A:  SUBD BJ_PNT+$AA
KCC6C:  ANDA #$1F
KCC6E:  ORA  BJ_PNT+$B8
KCC70:  ADDA BJ_PNT+$AE
KCC72:  STD  -6,Y
KCC74:  LDD  BJ_PNT+$7A             ;draw point 36 to 24, intensity from the two points' flag bytes
KCC76:  SUBD BJ_PNT+$B6
KCC78:  ANDA #$1F
KCC7A:  STD  -4,Y
KCC7C:  LDD  BJ_PNT+$78
KCC7E:  SUBD BJ_PNT+$B4
KCC80:  ANDA #$1F
KCC82:  ORA  BJ_PNT+$7C
KCC84:  ADDA BJ_PNT+$B8
KCC86:  STD  -2,Y
KCC88:  LDD  BJ_PNT+$7F             ;draw point 24 to 25, intensity from the two points' flag bytes
KCC8A:  SUBD BJ_PNT+$7A
KCC8C:  ANDA #$1F
KCC8E:  STD  ,Y
KCC90:  LDD  BJ_PNT+$7D
KCC92:  SUBD BJ_PNT+$78
KCC94:  ANDA #$1F
KCC96:  ORA  BJ_PNT+$81
KCC98:  ADDA BJ_PNT+$7C
KCC9A:  STD  2,Y
KCC9C:  LDD  BJ_PNT+$89             ;draw point 25 to 27, intensity from the two points' flag bytes
KCC9E:  SUBD BJ_PNT+$7F
KCCA0:  ANDA #$1F
KCCA2:  STD  4,Y
KCCA4:  LDD  BJ_PNT+$87
KCCA6:  SUBD BJ_PNT+$7D
KCCA8:  ANDA #$1F
KCCAA:  ORA  BJ_PNT+$8B
KCCAC:  ADDA BJ_PNT+$81
KCCAE:  STD  6,Y
KCCB0:  LDD  BJ_PNT+$93             ;BDRAWTO 1,3,15,12,9  UP RIGHT SIDE  draw point 27 to 29, intensity from the two points' flag bytes
KCCB2:  SUBD BJ_PNT+$89
KCCB4:  ANDA #$1F
KCCB6:  STD  8,Y
KCCB8:  LDD  BJ_PNT+$91
KCCBA:  SUBD BJ_PNT+$87
KCCBC:  ANDA #$1F
KCCBE:  ORA  BJ_PNT+$95
KCCC0:  ADDA BJ_PNT+$8B
KCCC2:  STD  $A,Y
KCCC4:  LDD  BJ_PNT+$9D             ;draw point 29 to 31, intensity from the two points' flag bytes
KCCC6:  SUBD BJ_PNT+$93
KCCC8:  ANDA #$1F
KCCCA:  STD  $C,Y
KCCCC:  LDD  BJ_PNT+$9B
KCCCE:  SUBD BJ_PNT+$91
KCCD0:  ANDA #$1F
KCCD2:  ORA  BJ_PNT+$9F
KCCD4:  ADDA BJ_PNT+$95
KCCD6:  STD  $E,Y
KCCD8:  LDD  BJ_PNT+$A7             ;draw point 31 to 33, intensity from the two points' flag bytes
KCCDA:  SUBD BJ_PNT+$9D
KCCDC:  ANDA #$1F
KCCDE:  LEAY $20,Y
KCCE1:  STD  -16,Y
KCCE3:  LDD  BJ_PNT+$A5
KCCE5:  SUBD BJ_PNT+$9B
KCCE7:  ANDA #$1F
KCCE9:  ORA  BJ_PNT+$A9
KCCEB:  ADDA BJ_PNT+$9F
KCCED:  STD  -14,Y
KCCEF:  LDD  BJ_PNT+$B1             ;draw point 33 to 35, intensity from the two points' flag bytes
KCCF1:  SUBD BJ_PNT+$A7
KCCF3:  ANDA #$1F
KCCF5:  STD  -12,Y
KCCF7:  LDD  BJ_PNT+$AF
KCCF9:  SUBD BJ_PNT+$A5
KCCFB:  ANDA #$1F
KCCFD:  ORA  BJ_PNT+$B3
KCCFF:  ADDA BJ_PNT+$A9
KCD01:  STD  -10,Y
KCD03:  LDD  BJ_PNT+$BB             ;draw point 35 to 37, intensity from the two points' flag bytes
KCD05:  SUBD BJ_PNT+$B1
KCD07:  ANDA #$1F
KCD09:  STD  -8,Y
KCD0B:  LDD  BJ_PNT+$B9
KCD0D:  SUBD BJ_PNT+$AF
KCD0F:  ANDA #$1F
KCD11:  ORA  BJ_PNT+$BD
KCD13:  ADDA BJ_PNT+$B3
KCD15:  STD  -6,Y
KCD17:  LDD  BJ_PNT+$7F             ;draw point 37 to 25, intensity from the two points' flag bytes
KCD19:  SUBD BJ_PNT+$BB
KCD1B:  ANDA #$1F
KCD1D:  STD  -4,Y
KCD1F:  LDD  BJ_PNT+$7D
KCD21:  SUBD BJ_PNT+$B9
KCD23:  ANDA #$1F
KCD25:  ORA  BJ_PNT+$81
KCD27:  ADDA BJ_PNT+$BD
KCD29:  STD  -2,Y
KCD2B:  LDD  BJ_PNT+$8E             ;move point 25 to 28
KCD2D:  SUBD BJ_PNT+$7F
KCD2F:  ANDA #$1F
KCD31:  STD  ,Y
KCD33:  LDD  BJ_PNT+$8C
KCD35:  SUBD BJ_PNT+$7D
KCD37:  ANDA #$1F
KCD39:  STD  2,Y
KCD3B:  LDD  BJ_PNT+$93             ;DRAWTO 0,2,3,1,5,4,0  draw point 28 to 29, intensity from the two points' flag bytes
KCD3D:  SUBD BJ_PNT+$8E
KCD3F:  ANDA #$1F
KCD41:  STD  4,Y
KCD43:  LDD  BJ_PNT+$91
KCD45:  SUBD BJ_PNT+$8C
KCD47:  ANDA #$1F
KCD49:  ORA  BJ_PNT+$95
KCD4B:  ADDA BJ_PNT+$90
KCD4D:  STD  6,Y
KCD4F:  LDD  BJ_PNT+$98             ;BDRAWTO 1,3,15,12,9  UP RIGHT SIDE  move point 29 to 30
KCD51:  SUBD BJ_PNT+$93
KCD53:  ANDA #$1F
KCD55:  STD  8,Y
KCD57:  LDD  BJ_PNT+$96
KCD59:  SUBD BJ_PNT+$91
KCD5B:  ANDA #$1F
KCD5D:  STD  $A,Y
KCD5F:  LDD  BJ_PNT+$9D             ;draw point 30 to 31, intensity from the two points' flag bytes
KCD61:  SUBD BJ_PNT+$98
KCD63:  ANDA #$1F
KCD65:  STD  $C,Y
KCD67:  LDD  BJ_PNT+$9B
KCD69:  SUBD BJ_PNT+$96
KCD6B:  ANDA #$1F
KCD6D:  ORA  BJ_PNT+$9F
KCD6F:  ADDA BJ_PNT+$9A
KCD71:  STD  $E,Y
KCD73:  LDD  BJ_PNT+$A2             ;move point 31 to 32
KCD75:  SUBD BJ_PNT+$9D
KCD77:  ANDA #$1F
KCD79:  LEAY $20,Y
KCD7C:  STD  -16,Y
KCD7E:  LDD  BJ_PNT+$A0
KCD80:  SUBD BJ_PNT+$9B
KCD82:  ANDA #$1F
KCD84:  STD  -14,Y
KCD86:  LDD  BJ_PNT+$CA             ;draw point 32 to 40, intensity from the two points' flag bytes
KCD88:  SUBD BJ_PNT+$A2
KCD8A:  ANDA #$1F
KCD8C:  STD  -12,Y
KCD8E:  LDD  BJ_PNT+$C8
KCD90:  SUBD BJ_PNT+$A0
KCD92:  ANDA #$1F
KCD94:  ORA  BJ_PNT+$CC
KCD96:  ADDA BJ_PNT+$A4
KCD98:  STD  -10,Y
KCD9A:  LDD  BJ_PNT+$A7             ;move point 40 to 33
KCD9C:  SUBD BJ_PNT+$CA
KCD9E:  ANDA #$1F
KCDA0:  STD  -8,Y
KCDA2:  LDD  BJ_PNT+$A5
KCDA4:  SUBD BJ_PNT+$C8
KCDA6:  ANDA #$1F
KCDA8:  STD  -6,Y
KCDAA:  LDD  BJ_PNT+$CF             ;draw point 33 to 41, intensity from the two points' flag bytes
KCDAC:  SUBD BJ_PNT+$A7
KCDAE:  ANDA #$1F
KCDB0:  STD  -4,Y
KCDB2:  LDD  BJ_PNT+$CD
KCDB4:  SUBD BJ_PNT+$A5
KCDB6:  ANDA #$1F
KCDB8:  ORA  BJ_PNT+$D1
KCDBA:  ADDA BJ_PNT+$A9
KCDBC:  STD  -2,Y
KCDBE:  LDD  BJ_PNT+$AC             ;move point 41 to 34
KCDC0:  SUBD BJ_PNT+$CF
KCDC2:  ANDA #$1F
KCDC4:  STD  ,Y
KCDC6:  LDD  BJ_PNT+$AA
KCDC8:  SUBD BJ_PNT+$CD
KCDCA:  ANDA #$1F
KCDCC:  STD  2,Y
KCDCE:  LDD  BJ_PNT+$B1             ;DRAWTO 0,2,3,1,5,4,0  draw point 34 to 35, intensity from the two points' flag bytes
KCDD0:  SUBD BJ_PNT+$AC
KCDD2:  ANDA #$1F
KCDD4:  STD  4,Y
KCDD6:  LDD  BJ_PNT+$AF
KCDD8:  SUBD BJ_PNT+$AA
KCDDA:  ANDA #$1F
KCDDC:  ORA  BJ_PNT+$B3
KCDDE:  ADDA BJ_PNT+$AE
KCDE0:  STD  6,Y
KCDE2:  LDD  BJ_PNT+$B6             ;BDRAWTO 1,3,15,12,9  UP RIGHT SIDE  move point 35 to 36
KCDE4:  SUBD BJ_PNT+$B1
KCDE6:  ANDA #$1F
KCDE8:  STD  8,Y
KCDEA:  LDD  BJ_PNT+$B4
KCDEC:  SUBD BJ_PNT+$AF
KCDEE:  ANDA #$1F
KCDF0:  STD  $A,Y
KCDF2:  LDD  BJ_PNT+$BB             ;draw point 36 to 37, intensity from the two points' flag bytes
KCDF4:  SUBD BJ_PNT+$B6
KCDF6:  ANDA #$1F
KCDF8:  STD  $C,Y
KCDFA:  LDD  BJ_PNT+$B9
KCDFC:  SUBD BJ_PNT+$B4
KCDFE:  ANDA #$1F
KCE00:  ORA  BJ_PNT+$BD
KCE02:  ADDA BJ_PNT+$B8
KCE04:  STD  14,Y
KCE06:  LEAY $10,Y
KCE09:  LDA  #$48
KCE0B:  TFR  A,DP
.dpage $48
KCE0D:  LDD  BJ_PNT+$B9
KCE10:  STD  BJ_CX
KCE12:  LDD  BJ_PNT+$BB
KCE15:  STD  BJ_CY
KCE17:  PULS A,B,X,U,PC

;------------------------------------------------------------------------------
; draw_atat_eye - draw routine of object 25, which has the point table of the AT-AT head: four lines round
;   buffer points 38 to 41, the rectangle on the front of the head that page 0 turns red and tests the lazar
;   against (the eye the player is told to shoot)
;------------------------------------------------------------------------------
draw_atat_eye:
KCE19:  LDA  #$4E
KCE1B:  TFR  A,DP
.dpage $4E
KCE1D:  LDD  BJ_PNT+$CF             ;beam to point 41
KCE1F:  SUBD BJ_CY
KCE22:  ANDA #$1F
KCE24:  STD  ,Y
KCE26:  LDD  BJ_PNT+$CD
KCE28:  SUBD BJ_CX
KCE2B:  ANDA #$1F
KCE2D:  STD  2,Y
KCE2F:  LDD  BJ_PNT+$C5             ;DRAWTO 0,2,3,1,5,4,0  draw point 41 to 39, intensity from the two points' flag bytes
KCE31:  SUBD BJ_PNT+$CF
KCE33:  ANDA #$1F
KCE35:  STD  4,Y
KCE37:  LDD  BJ_PNT+$C3
KCE39:  SUBD BJ_PNT+$CD
KCE3B:  ANDA #$1F
KCE3D:  ORA  BJ_PNT+$C7
KCE3F:  ADDA BJ_PNT+$D1
KCE41:  STD  6,Y
KCE43:  LDD  BJ_PNT+$C0             ;BDRAWTO 1,3,15,12,9  UP RIGHT SIDE  draw point 39 to 38, intensity from the two points' flag bytes
KCE45:  SUBD BJ_PNT+$C5
KCE47:  ANDA #$1F
KCE49:  STD  8,Y
KCE4B:  LDD  BJ_PNT+$BE
KCE4D:  SUBD BJ_PNT+$C3
KCE4F:  ANDA #$1F
KCE51:  ORA  BJ_PNT+$C2
KCE53:  ADDA BJ_PNT+$C7
KCE55:  STD  $A,Y
KCE57:  LDD  BJ_PNT+$CA             ;draw point 38 to 40, intensity from the two points' flag bytes
KCE59:  SUBD BJ_PNT+$C0
KCE5B:  ANDA #$1F
KCE5D:  STD  $C,Y
KCE5F:  LDD  BJ_PNT+$C8
KCE61:  SUBD BJ_PNT+$BE
KCE63:  ANDA #$1F
KCE65:  ORA  BJ_PNT+$CC
KCE67:  ADDA BJ_PNT+$C2
KCE69:  STD  $E,Y
KCE6B:  LDD  BJ_PNT+$CF             ;draw point 40 to 41, intensity from the two points' flag bytes
KCE6D:  SUBD BJ_PNT+$CA
KCE6F:  ANDA #$1F
KCE71:  LEAY $20,Y
KCE74:  STD  -16,Y
KCE76:  LDD  BJ_PNT+$CD
KCE78:  SUBD BJ_PNT+$C8
KCE7A:  ANDA #$1F
KCE7C:  ORA  BJ_PNT+$D1
KCE7E:  ADDA BJ_PNT+$CC
KCE80:  STD  -14,Y
KCE82:  LEAY -12,Y
KCE84:  LDA  #$48
KCE86:  TFR  A,DP
.dpage $48
KCE88:  LDD  BJ_PNT+$CD
KCE8B:  STD  BJ_CX
KCE8D:  LDD  BJ_PNT+$CF
KCE90:  STD  BJ_CY
KCE92:  PULS A,B,X,U,PC

;------------------------------------------------------------------------------
; draw_atat_leg - draw routine of object 27, one AT-AT leg: 18 lines at full brightness between 12 buffer
;   points, three points at each of four levels joined into a three-sided tube. the object's own table holds a
;   single point, the 12 points are put into the buffer one at a time by page 0 through pnt_add_scratch
;------------------------------------------------------------------------------
draw_atat_leg:
KCE94:  LDA  #$4E
KCE96:  TFR  A,DP
.dpage $4E
KCE98:  LDD  BJ_PNT+$02             ;beam to point 0
KCE9A:  SUBD BJ_CY
KCE9D:  ANDA #$1F
KCE9F:  STD  ,Y
KCEA1:  LDD  ST_QUZ
KCEA3:  SUBD BJ_CX
KCEA6:  ANDA #$1F
KCEA8:  STD  2,Y
KCEAA:  LDD  BJ_PNT+$11             ;DRAWTO 0,2,3,1,5,4,0  draw point 0 to 3
KCEAC:  SUBD BJ_PNT+$02
KCEAE:  ANDA #$1F
KCEB0:  STD  4,Y
KCEB2:  LDD  BJ_PNT+$0F
KCEB4:  SUBD ST_QUZ
KCEB6:  ORA  #$E0
KCEB8:  STD  6,Y
KCEBA:  LDD  BJ_PNT+$16             ;draw point 3 to 4
KCEBC:  SUBD BJ_PNT+$11
KCEBE:  ANDA #$1F
KCEC0:  STD  8,Y
KCEC2:  LDD  BJ_PNT+$14
KCEC4:  SUBD BJ_PNT+$0F
KCEC6:  ORA  #$E0
KCEC8:  STD  $A,Y
KCECA:  LDD  BJ_PNT+$1B             ;draw point 4 to 5
KCECC:  SUBD BJ_PNT+$16
KCECE:  ANDA #$1F
KCED0:  STD  $C,Y
KCED2:  LDD  BJ_PNT+$19
KCED4:  SUBD BJ_PNT+$14
KCED6:  ORA  #$E0
KCED8:  STD  $E,Y
KCEDA:  LDD  BJ_PNT+$11             ;draw point 5 to 3
KCEDC:  SUBD BJ_PNT+$1B
KCEDE:  ANDA #$1F
KCEE0:  LEAY $20,Y
KCEE3:  STD  -16,Y
KCEE5:  LDD  BJ_PNT+$0F
KCEE7:  SUBD BJ_PNT+$19
KCEE9:  ORA  #$E0
KCEEB:  STD  -14,Y
KCEED:  LDD  BJ_PNT+$20             ;draw point 3 to 6
KCEEF:  SUBD BJ_PNT+$11
KCEF1:  ANDA #$1F
KCEF3:  STD  -12,Y
KCEF5:  LDD  BJ_PNT+$1E
KCEF7:  SUBD BJ_PNT+$0F
KCEF9:  ORA  #$E0
KCEFB:  STD  -10,Y
KCEFD:  LDD  BJ_PNT+$25             ;draw point 6 to 7
KCEFF:  SUBD BJ_PNT+$20
KCF01:  ANDA #$1F
KCF03:  STD  -8,Y
KCF05:  LDD  BJ_PNT+$23
KCF07:  SUBD BJ_PNT+$1E
KCF09:  ORA  #$E0
KCF0B:  STD  -6,Y
KCF0D:  LDD  BJ_PNT+$2A             ;draw point 7 to 8
KCF0F:  SUBD BJ_PNT+$25
KCF11:  ANDA #$1F
KCF13:  STD  -4,Y
KCF15:  LDD  BJ_PNT+$28
KCF17:  SUBD BJ_PNT+$23
KCF19:  ORA  #$E0
KCF1B:  STD  -2,Y
KCF1D:  LDD  BJ_PNT+$20             ;draw point 8 to 6
KCF1F:  SUBD BJ_PNT+$2A
KCF21:  ANDA #$1F
KCF23:  STD  ,Y
KCF25:  LDD  BJ_PNT+$1E
KCF27:  SUBD BJ_PNT+$28
KCF29:  ORA  #$E0
KCF2B:  STD  2,Y
KCF2D:  LDD  BJ_PNT+$2F             ;DRAWTO 0,2,3,1,5,4,0  draw point 6 to 9
KCF2F:  SUBD BJ_PNT+$20
KCF31:  ANDA #$1F
KCF33:  STD  4,Y
KCF35:  LDD  BJ_PNT+$2D
KCF37:  SUBD BJ_PNT+$1E
KCF39:  ORA  #$E0
KCF3B:  STD  6,Y
KCF3D:  LDD  BJ_PNT+$34             ;draw point 9 to 10
KCF3F:  SUBD BJ_PNT+$2F
KCF41:  ANDA #$1F
KCF43:  STD  8,Y
KCF45:  LDD  BJ_PNT+$32
KCF47:  SUBD BJ_PNT+$2D
KCF49:  ORA  #$E0
KCF4B:  STD  $A,Y
KCF4D:  LDD  BJ_PNT+$39             ;draw point 10 to 11
KCF4F:  SUBD BJ_PNT+$34
KCF51:  ANDA #$1F
KCF53:  STD  $C,Y
KCF55:  LDD  BJ_PNT+$37
KCF57:  SUBD BJ_PNT+$32
KCF59:  ORA  #$E0
KCF5B:  STD  $E,Y
KCF5D:  LDD  BJ_PNT+$2F             ;draw point 11 to 9
KCF5F:  SUBD BJ_PNT+$39
KCF61:  ANDA #$1F
KCF63:  LEAY $20,Y
KCF66:  STD  -16,Y
KCF68:  LDD  BJ_PNT+$2D
KCF6A:  SUBD BJ_PNT+$37
KCF6C:  ORA  #$E0
KCF6E:  STD  -14,Y
KCF70:  LDD  BJ_PNT+$34             ;move point 9 to 10
KCF72:  SUBD BJ_PNT+$2F
KCF74:  ANDA #$1F
KCF76:  STD  -12,Y
KCF78:  LDD  BJ_PNT+$32
KCF7A:  SUBD BJ_PNT+$2D
KCF7C:  ANDA #$1F
KCF7E:  STD  -10,Y
KCF80:  LDD  BJ_PNT+$25             ;draw point 10 to 7
KCF82:  SUBD BJ_PNT+$34
KCF84:  ANDA #$1F
KCF86:  STD  -8,Y
KCF88:  LDD  BJ_PNT+$23
KCF8A:  SUBD BJ_PNT+$32
KCF8C:  ORA  #$E0
KCF8E:  STD  -6,Y
KCF90:  LDD  BJ_PNT+$16             ;draw point 7 to 4
KCF92:  SUBD BJ_PNT+$25
KCF94:  ANDA #$1F
KCF96:  STD  -4,Y
KCF98:  LDD  BJ_PNT+$14
KCF9A:  SUBD BJ_PNT+$23
KCF9C:  ORA  #$E0
KCF9E:  STD  -2,Y
KCFA0:  LDD  BJ_PNT+$07             ;draw point 4 to 1
KCFA2:  SUBD BJ_PNT+$16
KCFA4:  ANDA #$1F
KCFA6:  STD  ,Y
KCFA8:  LDD  BJ_PNT+$05
KCFAA:  SUBD BJ_PNT+$14
KCFAC:  ORA  #$E0
KCFAE:  STD  2,Y
KCFB0:  LDD  BJ_PNT+$0C             ;DRAWTO 0,2,3,1,5,4,0  move point 1 to 2
KCFB2:  SUBD BJ_PNT+$07
KCFB4:  ANDA #$1F
KCFB6:  STD  4,Y
KCFB8:  LDD  BJ_PNT+$0A
KCFBA:  SUBD BJ_PNT+$05
KCFBC:  ANDA #$1F
KCFBE:  STD  6,Y
KCFC0:  LDD  BJ_PNT+$1B             ;draw point 2 to 5
KCFC2:  SUBD BJ_PNT+$0C
KCFC4:  ANDA #$1F
KCFC6:  STD  8,Y
KCFC8:  LDD  BJ_PNT+$19
KCFCA:  SUBD BJ_PNT+$0A
KCFCC:  ORA  #$E0
KCFCE:  STD  $A,Y
KCFD0:  LDD  BJ_PNT+$2A             ;draw point 5 to 8
KCFD2:  SUBD BJ_PNT+$1B
KCFD4:  ANDA #$1F
KCFD6:  STD  $C,Y
KCFD8:  LDD  BJ_PNT+$28
KCFDA:  SUBD BJ_PNT+$19
KCFDC:  ORA  #$E0
KCFDE:  STD  $E,Y
KCFE0:  LDD  BJ_PNT+$39             ;draw point 8 to 11
KCFE2:  SUBD BJ_PNT+$2A
KCFE4:  ANDA #$1F
KCFE6:  LEAY $20,Y
KCFE9:  STD  -16,Y
KCFEB:  LDD  BJ_PNT+$37
KCFED:  SUBD BJ_PNT+$28
KCFEF:  ORA  #$E0
KCFF1:  STD  -14,Y
KCFF3:  LEAY -12,Y
KCFF5:  LDA  #$48
KCFF7:  TFR  A,DP
.dpage $48
KCFF9:  LDD  BJ_PNT+$37
KCFFC:  STD  BJ_CX
KCFFE:  LDD  BJ_PNT+$39
KD001:  STD  BJ_CY
KD003:  PULS A,B,X,U,PC

;------------------------------------------------------------------------------
; draw_atat_piece - draw routine of objects 28, 29 and 30, the front, middle and rear third of the AT-AT body as
;   separate 8 point boxes, 12 lines at full brightness. they are the pictures of explosion piece types 6 to 8
;------------------------------------------------------------------------------
draw_atat_piece:
KD005:  LDA  #$4E
KD007:  TFR  A,DP
.dpage $4E
KD009:  LDD  BJ_PNT+$02             ;beam to point 0
KD00B:  SUBD BJ_CY
KD00E:  ANDA #$1F
KD010:  STD  ,Y
KD012:  LDD  ST_QUZ
KD014:  SUBD BJ_CX
KD017:  ANDA #$1F
KD019:  STD  2,Y
KD01B:  LDD  BJ_PNT+$07             ;DRAWTO 0,2,3,1,5,4,0  draw point 0 to 1
KD01D:  SUBD BJ_PNT+$02
KD01F:  ANDA #$1F
KD021:  STD  4,Y
KD023:  LDD  BJ_PNT+$05
KD025:  SUBD ST_QUZ
KD027:  ORA  #$E0
KD029:  STD  6,Y
KD02B:  LDD  BJ_PNT+$11             ;draw point 1 to 3
KD02D:  SUBD BJ_PNT+$07
KD02F:  ANDA #$1F
KD031:  STD  8,Y
KD033:  LDD  BJ_PNT+$0F
KD035:  SUBD BJ_PNT+$05
KD037:  ORA  #$E0
KD039:  STD  $A,Y
KD03B:  LDD  BJ_PNT+$0C             ;draw point 3 to 2
KD03D:  SUBD BJ_PNT+$11
KD03F:  ANDA #$1F
KD041:  STD  $C,Y
KD043:  LDD  BJ_PNT+$0A
KD045:  SUBD BJ_PNT+$0F
KD047:  ORA  #$E0
KD049:  STD  $E,Y
KD04B:  LDD  BJ_PNT+$02             ;draw point 2 to 0
KD04D:  SUBD BJ_PNT+$0C
KD04F:  ANDA #$1F
KD051:  LEAY $20,Y
KD054:  STD  -16,Y
KD056:  LDD  ST_QUZ
KD058:  SUBD BJ_PNT+$0A
KD05A:  ORA  #$E0
KD05C:  STD  -14,Y
KD05E:  LDD  BJ_PNT+$20             ;draw point 0 to 6
KD060:  SUBD BJ_PNT+$02
KD062:  ANDA #$1F
KD064:  STD  -12,Y
KD066:  LDD  BJ_PNT+$1E
KD068:  SUBD ST_QUZ
KD06A:  ORA  #$E0
KD06C:  STD  -10,Y
KD06E:  LDD  BJ_PNT+$25             ;draw point 6 to 7
KD070:  SUBD BJ_PNT+$20
KD072:  ANDA #$1F
KD074:  STD  -8,Y
KD076:  LDD  BJ_PNT+$23
KD078:  SUBD BJ_PNT+$1E
KD07A:  ORA  #$E0
KD07C:  STD  -6,Y
KD07E:  LDD  BJ_PNT+$1B             ;draw point 7 to 5
KD080:  SUBD BJ_PNT+$25
KD082:  ANDA #$1F
KD084:  STD  -4,Y
KD086:  LDD  BJ_PNT+$19
KD088:  SUBD BJ_PNT+$23
KD08A:  ORA  #$E0
KD08C:  STD  -2,Y
KD08E:  LDD  BJ_PNT+$16             ;draw point 5 to 4
KD090:  SUBD BJ_PNT+$1B
KD092:  ANDA #$1F
KD094:  STD  ,Y
KD096:  LDD  BJ_PNT+$14
KD098:  SUBD BJ_PNT+$19
KD09A:  ORA  #$E0
KD09C:  STD  2,Y
KD09E:  LDD  BJ_PNT+$20             ;DRAWTO 0,2,3,1,5,4,0  draw point 4 to 6
KD0A0:  SUBD BJ_PNT+$16
KD0A2:  ANDA #$1F
KD0A4:  STD  4,Y
KD0A6:  LDD  BJ_PNT+$1E
KD0A8:  SUBD BJ_PNT+$14
KD0AA:  ORA  #$E0
KD0AC:  STD  6,Y
KD0AE:  LDD  BJ_PNT+$0C             ;BDRAWTO 1,3,15,12,9  UP RIGHT SIDE  move point 6 to 2
KD0B0:  SUBD BJ_PNT+$20
KD0B2:  ANDA #$1F
KD0B4:  STD  8,Y
KD0B6:  LDD  BJ_PNT+$0A
KD0B8:  SUBD BJ_PNT+$1E
KD0BA:  ANDA #$1F
KD0BC:  STD  $A,Y
KD0BE:  LDD  BJ_PNT+$16             ;draw point 2 to 4
KD0C0:  SUBD BJ_PNT+$0C
KD0C2:  ANDA #$1F
KD0C4:  STD  $C,Y
KD0C6:  LDD  BJ_PNT+$14
KD0C8:  SUBD BJ_PNT+$0A
KD0CA:  ORA  #$E0
KD0CC:  STD  $E,Y
KD0CE:  LDD  BJ_PNT+$11             ;move point 4 to 3
KD0D0:  SUBD BJ_PNT+$16
KD0D2:  ANDA #$1F
KD0D4:  LEAY $20,Y
KD0D7:  STD  -16,Y
KD0D9:  LDD  BJ_PNT+$0F
KD0DB:  SUBD BJ_PNT+$14
KD0DD:  ANDA #$1F
KD0DF:  STD  -14,Y
KD0E1:  LDD  BJ_PNT+$1B             ;draw point 3 to 5
KD0E3:  SUBD BJ_PNT+$11
KD0E5:  ANDA #$1F
KD0E7:  STD  -12,Y
KD0E9:  LDD  BJ_PNT+$19
KD0EB:  SUBD BJ_PNT+$0F
KD0ED:  ORA  #$E0
KD0EF:  STD  -10,Y
KD0F1:  LDD  BJ_PNT+$07             ;move point 5 to 1
KD0F3:  SUBD BJ_PNT+$1B
KD0F5:  ANDA #$1F
KD0F7:  STD  -8,Y
KD0F9:  LDD  BJ_PNT+$05
KD0FB:  SUBD BJ_PNT+$19
KD0FD:  ANDA #$1F
KD0FF:  STD  -6,Y
KD101:  LDD  BJ_PNT+$25             ;draw point 1 to 7
KD103:  SUBD BJ_PNT+$07
KD105:  ANDA #$1F
KD107:  STD  -4,Y
KD109:  LDD  BJ_PNT+$23
KD10B:  SUBD BJ_PNT+$05
KD10D:  ORA  #$E0
KD10F:  STD  -2,Y
KD111:  LEAY ,Y
KD113:  LDA  #$48
KD115:  TFR  A,DP
.dpage $48
KD117:  LDD  BJ_PNT+$23
KD11A:  STD  BJ_CX
KD11C:  LDD  BJ_PNT+$25
KD11F:  STD  BJ_CY
KD121:  PULS A,B,X,U,PC

;------------------------------------------------------------------------------
; draw_dart - draw routine of object 31 (9 points perspected into buffer points 1 to 9): a long square shaft
;   that widens to the rear, with a pointed nose. 18 lines at full brightness in three colours, written by the
;   routine itself: $6180 for the nose, $6680 for the shaft and a JSRL $A013 before the rear end. it is the body
;   at each end of the tow cable: page 0 loads it in cable_init and draws it once for each end (cable_view_end1,
;   cable_view_end2)
;------------------------------------------------------------------------------
draw_dart:
KD123:  LDA  #$4E
KD125:  TFR  A,DP
.dpage $4E
KD127:  LDD  #$6180
KD12A:  STD  ,Y
KD12C:  LDD  BJ_PNT+$0C             ;beam to point 2
KD12E:  SUBD BJ_CY
KD131:  ANDA #$1F
KD133:  STD  2,Y
KD135:  LDD  BJ_PNT+$0A
KD137:  SUBD BJ_CX
KD13A:  ANDA #$1F
KD13C:  STD  4,Y
KD13E:  LDD  BJ_PNT+$07             ;DRAWTO 9,8,4  draw point 2 to 1
KD140:  SUBD BJ_PNT+$0C
KD142:  ANDA #$1F
KD144:  STD  6,Y
KD146:  LDD  BJ_PNT+$05
KD148:  SUBD BJ_PNT+$0A
KD14A:  ORA  #$E0
KD14C:  STD  8,Y
KD14E:  LDD  BJ_PNT+$11             ;draw point 1 to 3
KD150:  SUBD BJ_PNT+$07
KD152:  ANDA #$1F
KD154:  STD  $A,Y
KD156:  LDD  BJ_PNT+$0F
KD158:  SUBD BJ_PNT+$05
KD15A:  ORA  #$E0
KD15C:  STD  $C,Y
KD15E:  LDD  BJ_PNT+$0C             ;draw point 3 to 2
KD160:  SUBD BJ_PNT+$11
KD162:  ANDA #$1F
KD164:  STD  $E,Y
KD166:  LDD  BJ_PNT+$0A
KD168:  SUBD BJ_PNT+$0F
KD16A:  ORA  #$E0
KD16C:  LEAY $20,Y
KD16F:  STD  -16,Y
KD171:  LDD  BJ_PNT+$16             ;draw point 2 to 4
KD173:  SUBD BJ_PNT+$0C
KD175:  ANDA #$1F
KD177:  STD  -14,Y
KD179:  LDD  BJ_PNT+$14
KD17B:  SUBD BJ_PNT+$0A
KD17D:  ORA  #$E0
KD17F:  STD  -12,Y
KD181:  LDD  BJ_PNT+$07             ;draw point 4 to 1
KD183:  SUBD BJ_PNT+$16
KD185:  ANDA #$1F
KD187:  STD  -10,Y
KD189:  LDD  BJ_PNT+$05
KD18B:  SUBD BJ_PNT+$14
KD18D:  ORA  #$E0
KD18F:  STD  -8,Y
KD191:  LDD  BJ_PNT+$1B             ;draw point 1 to 5
KD193:  SUBD BJ_PNT+$07
KD195:  ANDA #$1F
KD197:  STD  -6,Y
KD199:  LDD  BJ_PNT+$19
KD19B:  SUBD BJ_PNT+$05
KD19D:  ORA  #$E0
KD19F:  STD  -4,Y
KD1A1:  LDD  BJ_PNT+$16             ;draw point 5 to 4
KD1A3:  SUBD BJ_PNT+$1B
KD1A5:  ANDA #$1F
KD1A7:  STD  -2,Y
KD1A9:  LDD  BJ_PNT+$14
KD1AB:  SUBD BJ_PNT+$19
KD1AD:  ORA  #$E0
KD1AF:  STD  ,Y
KD1B1:  LDD  BJ_PNT+$1B             ;move point 4 to 5
KD1B3:  SUBD BJ_PNT+$16
KD1B5:  ANDA #$1F
KD1B7:  STD  2,Y
KD1B9:  LDD  BJ_PNT+$19             ;DRAWTO 0,2,3,1,5,4,0
KD1BB:  SUBD BJ_PNT+$14
KD1BD:  ANDA #$1F
KD1BF:  STD  4,Y
KD1C1:  LDD  BJ_PNT+$11             ;DRAWTO 9,8,4  draw point 5 to 3
KD1C3:  SUBD BJ_PNT+$1B
KD1C5:  ANDA #$1F
KD1C7:  STD  6,Y
KD1C9:  LDD  BJ_PNT+$0F
KD1CB:  SUBD BJ_PNT+$19
KD1CD:  ORA  #$E0
KD1CF:  STD  8,Y
KD1D1:  LDD  #$6680
KD1D4:  STD  $A,Y
KD1D6:  LDD  BJ_PNT+$25             ;draw point 3 to 7
KD1D8:  SUBD BJ_PNT+$11
KD1DA:  ANDA #$1F
KD1DC:  STD  $C,Y
KD1DE:  LDD  BJ_PNT+$23
KD1E0:  SUBD BJ_PNT+$0F
KD1E2:  ORA  #$E0
KD1E4:  STD  $E,Y
KD1E6:  LDD  BJ_PNT+$20             ;draw point 7 to 6
KD1E8:  SUBD BJ_PNT+$25
KD1EA:  ANDA #$1F
KD1EC:  LEAY $20,Y
KD1EF:  STD  -16,Y
KD1F1:  LDD  BJ_PNT+$1E
KD1F3:  SUBD BJ_PNT+$23
KD1F5:  ORA  #$E0
KD1F7:  STD  -14,Y
KD1F9:  LDD  BJ_PNT+$0C             ;draw point 6 to 2
KD1FB:  SUBD BJ_PNT+$20
KD1FD:  ANDA #$1F
KD1FF:  STD  -12,Y
KD201:  LDD  BJ_PNT+$0A
KD203:  SUBD BJ_PNT+$1E
KD205:  ORA  #$E0
KD207:  STD  -10,Y
KD209:  LDD  BJ_PNT+$16             ;move point 2 to 4
KD20B:  SUBD BJ_PNT+$0C
KD20D:  ANDA #$1F
KD20F:  STD  -8,Y
KD211:  LDD  BJ_PNT+$14
KD213:  SUBD BJ_PNT+$0A
KD215:  ANDA #$1F
KD217:  STD  -6,Y
KD219:  LDD  BJ_PNT+$2A             ;draw point 4 to 8
KD21B:  SUBD BJ_PNT+$16
KD21D:  ANDA #$1F
KD21F:  STD  -4,Y
KD221:  LDD  BJ_PNT+$28
KD223:  SUBD BJ_PNT+$14
KD225:  ORA  #$E0
KD227:  STD  -2,Y
KD229:  LDD  BJ_PNT+$2F             ;draw point 8 to 9
KD22B:  SUBD BJ_PNT+$2A
KD22D:  ANDA #$1F
KD22F:  STD  ,Y
KD231:  LDD  BJ_PNT+$2D
KD233:  SUBD BJ_PNT+$28
KD235:  ORA  #$E0
KD237:  STD  2,Y
KD239:  LDD  BJ_PNT+$1B             ;DRAWTO 0,2,3,1,5,4,0  draw point 9 to 5
KD23B:  SUBD BJ_PNT+$2F
KD23D:  ANDA #$1F
KD23F:  STD  4,Y
KD241:  LDD  BJ_PNT+$19
KD243:  SUBD BJ_PNT+$2D
KD245:  ORA  #$E0
KD247:  STD  6,Y
KD249:  LDD  BJ_PNT+$2A             ;BDRAWTO 1,3,15,12,9  UP RIGHT SIDE  move point 5 to 8
KD24B:  SUBD BJ_PNT+$1B
KD24D:  ANDA #$1F
KD24F:  STD  8,Y
KD251:  LDD  BJ_PNT+$28
KD253:  SUBD BJ_PNT+$19
KD255:  ANDA #$1F
KD257:  STD  $A,Y
KD259:  LDD  BJ_PNT+$20             ;draw point 8 to 6
KD25B:  SUBD BJ_PNT+$2A
KD25D:  ANDA #$1F
KD25F:  STD  $C,Y
KD261:  LDD  BJ_PNT+$1E
KD263:  SUBD BJ_PNT+$28
KD265:  ORA  #$E0
KD267:  STD  $E,Y
KD269:  LDD  BJ_PNT+$25             ;move point 6 to 7
KD26B:  SUBD BJ_PNT+$20
KD26D:  ANDA #$1F
KD26F:  LEAY $20,Y
KD272:  STD  -16,Y
KD274:  LDD  BJ_PNT+$23
KD276:  SUBD BJ_PNT+$1E
KD278:  ANDA #$1F
KD27A:  STD  -14,Y
KD27C:  LDD  BJ_PNT+$2F             ;draw point 7 to 9
KD27E:  SUBD BJ_PNT+$25
KD280:  ANDA #$1F
KD282:  STD  -12,Y
KD284:  LDD  BJ_PNT+$2D
KD286:  SUBD BJ_PNT+$23
KD288:  ORA  #$E0
KD28A:  STD  -10,Y
KD28C:  LDD  #$A013
KD28F:  STD  -8,Y
KD291:  LDD  BJ_PNT+$20             ;draw point 9 to 6
KD293:  SUBD BJ_PNT+$2F
KD295:  ANDA #$1F
KD297:  STD  -6,Y
KD299:  LDD  BJ_PNT+$1E
KD29B:  SUBD BJ_PNT+$2D
KD29D:  ORA  #$E0
KD29F:  STD  -4,Y
KD2A1:  LDD  BJ_PNT+$25             ;move point 6 to 7
KD2A3:  SUBD BJ_PNT+$20
KD2A5:  ANDA #$1F
KD2A7:  STD  -2,Y
KD2A9:  LDD  BJ_PNT+$23
KD2AB:  SUBD BJ_PNT+$1E
KD2AD:  ANDA #$1F
KD2AF:  STD  ,Y
KD2B1:  LDD  BJ_PNT+$2A             ;draw point 7 to 8
KD2B3:  SUBD BJ_PNT+$25
KD2B5:  ANDA #$1F
KD2B7:  STD  2,Y
KD2B9:  LDD  BJ_PNT+$28
KD2BB:  SUBD BJ_PNT+$23
KD2BD:  ORA  #$E0
KD2BF:  STD  4,Y
KD2C1:  LEAY 6,Y
KD2C3:  LDA  #$48
KD2C5:  TFR  A,DP
.dpage $48
KD2C7:  LDD  BJ_PNT+$28
KD2CA:  STD  BJ_CX
KD2CC:  LDD  BJ_PNT+$2A
KD2CF:  STD  BJ_CY
KD2D1:  PULS A,B,X,U,PC

;------------------------------------------------------------------------------
; draw_asteroid - draw routine of objects 32, 33 and 34, one 24 point solid - a cube with every corner and edge
;   cut off - in three sizes (1000, 500 and 250 units): 48 lines with depth cue brightness. page 2 loads all three
;   for the asteroid field and draws object 33
;------------------------------------------------------------------------------
draw_asteroid:
KD2D3:  LDA  #$4E
KD2D5:  TFR  A,DP
.dpage $4E
KD2D7:  LDD  BJ_PNT+$34             ;beam to point 10
KD2D9:  SUBD BJ_CY
KD2DC:  ANDA #$1F
KD2DE:  STD  ,Y
KD2E0:  LDD  BJ_PNT+$32
KD2E2:  SUBD BJ_CX
KD2E5:  ANDA #$1F
KD2E7:  STD  2,Y
KD2E9:  LDD  BJ_PNT+$0C             ;DRAWTO 0,2,3,1,5,4,0  draw point 10 to 2, intensity from the two points' flag bytes
KD2EB:  SUBD BJ_PNT+$34
KD2ED:  ANDA #$1F
KD2EF:  STD  4,Y
KD2F1:  LDD  BJ_PNT+$0A
KD2F3:  SUBD BJ_PNT+$32
KD2F5:  ANDA #$1F
KD2F7:  ORA  BJ_PNT+$0E
KD2F9:  ADDA BJ_PNT+$36
KD2FB:  STD  6,Y
KD2FD:  LDD  BJ_PNT+$02             ;BDRAWTO 1,3,15,12,9  UP RIGHT SIDE  draw point 2 to 0, intensity from the two points' flag bytes
KD2FF:  SUBD BJ_PNT+$0C
KD301:  ANDA #$1F
KD303:  STD  8,Y
KD305:  LDD  ST_QUZ
KD307:  SUBD BJ_PNT+$0A
KD309:  ANDA #$1F
KD30B:  ORA  BJ_PNT+$04
KD30D:  ADDA BJ_PNT+$0E
KD30F:  STD  $A,Y
KD311:  LDD  BJ_PNT+$20             ;draw point 0 to 6, intensity from the two points' flag bytes
KD313:  SUBD BJ_PNT+$02
KD315:  ANDA #$1F
KD317:  STD  $C,Y
KD319:  LDD  BJ_PNT+$1E
KD31B:  SUBD ST_QUZ
KD31D:  ANDA #$1F
KD31F:  ORA  BJ_PNT+$22
KD321:  ADDA BJ_PNT+$04
KD323:  STD  $E,Y
KD325:  LDD  BJ_PNT+$16             ;draw point 6 to 4, intensity from the two points' flag bytes
KD327:  SUBD BJ_PNT+$20
KD329:  ANDA #$1F
KD32B:  LEAY $20,Y
KD32E:  STD  -16,Y
KD330:  LDD  BJ_PNT+$14
KD332:  SUBD BJ_PNT+$1E
KD334:  ANDA #$1F
KD336:  ORA  BJ_PNT+$18
KD338:  ADDA BJ_PNT+$22
KD33A:  STD  -14,Y
KD33C:  LDD  BJ_PNT+$3E             ;draw point 4 to 12, intensity from the two points' flag bytes
KD33E:  SUBD BJ_PNT+$16
KD340:  ANDA #$1F
KD342:  STD  -12,Y
KD344:  LDD  BJ_PNT+$3C
KD346:  SUBD BJ_PNT+$14
KD348:  ANDA #$1F
KD34A:  ORA  BJ_PNT+$40
KD34C:  ADDA BJ_PNT+$18
KD34E:  STD  -10,Y
KD350:  LDD  BJ_PNT+$48             ;draw point 12 to 14, intensity from the two points' flag bytes
KD352:  SUBD BJ_PNT+$3E
KD354:  ANDA #$1F
KD356:  STD  -8,Y
KD358:  LDD  BJ_PNT+$46
KD35A:  SUBD BJ_PNT+$3C
KD35C:  ANDA #$1F
KD35E:  ORA  BJ_PNT+$4A
KD360:  ADDA BJ_PNT+$40
KD362:  STD  -6,Y
KD364:  LDD  BJ_PNT+$66             ;draw point 14 to 20, intensity from the two points' flag bytes
KD366:  SUBD BJ_PNT+$48
KD368:  ANDA #$1F
KD36A:  STD  -4,Y
KD36C:  LDD  BJ_PNT+$64
KD36E:  SUBD BJ_PNT+$46
KD370:  ANDA #$1F
KD372:  ORA  BJ_PNT+$68
KD374:  ADDA BJ_PNT+$4A
KD376:  STD  -2,Y
KD378:  LDD  BJ_PNT+$3E             ;draw point 20 to 12, intensity from the two points' flag bytes
KD37A:  SUBD BJ_PNT+$66
KD37C:  ANDA #$1F
KD37E:  STD  ,Y
KD380:  LDD  BJ_PNT+$3C
KD382:  SUBD BJ_PNT+$64
KD384:  ANDA #$1F
KD386:  ORA  BJ_PNT+$40
KD388:  ADDA BJ_PNT+$68
KD38A:  STD  2,Y
KD38C:  LDD  BJ_PNT+$43             ;draw point 12 to 13, intensity from the two points' flag bytes
KD38E:  SUBD BJ_PNT+$3E
KD390:  ANDA #$1F
KD392:  STD  4,Y
KD394:  LDD  BJ_PNT+$41
KD396:  SUBD BJ_PNT+$3C
KD398:  ANDA #$1F
KD39A:  ORA  BJ_PNT+$45
KD39C:  ADDA BJ_PNT+$40
KD39E:  STD  6,Y
KD3A0:  LDD  BJ_PNT+$6B             ;BDRAWTO 1,3,15,12,9  UP RIGHT SIDE  draw point 13 to 21, intensity from the two points' flag bytes
KD3A2:  SUBD BJ_PNT+$43
KD3A4:  ANDA #$1F
KD3A6:  STD  8,Y
KD3A8:  LDD  BJ_PNT+$69
KD3AA:  SUBD BJ_PNT+$41
KD3AC:  ANDA #$1F
KD3AE:  ORA  BJ_PNT+$6D
KD3B0:  ADDA BJ_PNT+$45
KD3B2:  STD  $A,Y
KD3B4:  LDD  BJ_PNT+$4D             ;draw point 21 to 15, intensity from the two points' flag bytes
KD3B6:  SUBD BJ_PNT+$6B
KD3B8:  ANDA #$1F
KD3BA:  STD  $C,Y
KD3BC:  LDD  BJ_PNT+$4B
KD3BE:  SUBD BJ_PNT+$69
KD3C0:  ANDA #$1F
KD3C2:  ORA  BJ_PNT+$4F
KD3C4:  ADDA BJ_PNT+$6D
KD3C6:  STD  $E,Y
KD3C8:  LDD  BJ_PNT+$43             ;draw point 15 to 13, intensity from the two points' flag bytes
KD3CA:  SUBD BJ_PNT+$4D
KD3CC:  ANDA #$1F
KD3CE:  LEAY $20,Y
KD3D1:  STD  -16,Y
KD3D3:  LDD  BJ_PNT+$41
KD3D5:  SUBD BJ_PNT+$4B
KD3D7:  ANDA #$1F
KD3D9:  ORA  BJ_PNT+$45
KD3DB:  ADDA BJ_PNT+$4F
KD3DD:  STD  -14,Y
KD3DF:  LDD  BJ_PNT+$1B             ;draw point 13 to 5, intensity from the two points' flag bytes
KD3E1:  SUBD BJ_PNT+$43
KD3E3:  ANDA #$1F
KD3E5:  STD  -12,Y
KD3E7:  LDD  BJ_PNT+$19
KD3E9:  SUBD BJ_PNT+$41
KD3EB:  ANDA #$1F
KD3ED:  ORA  BJ_PNT+$1D
KD3EF:  ADDA BJ_PNT+$45
KD3F1:  STD  -10,Y
KD3F3:  LDD  BJ_PNT+$25             ;draw point 5 to 7, intensity from the two points' flag bytes
KD3F5:  SUBD BJ_PNT+$1B
KD3F7:  ANDA #$1F
KD3F9:  STD  -8,Y
KD3FB:  LDD  BJ_PNT+$23
KD3FD:  SUBD BJ_PNT+$19
KD3FF:  ANDA #$1F
KD401:  ORA  BJ_PNT+$27
KD403:  ADDA BJ_PNT+$1D
KD405:  STD  -6,Y
KD407:  LDD  BJ_PNT+$07             ;draw point 7 to 1, intensity from the two points' flag bytes
KD409:  SUBD BJ_PNT+$25
KD40B:  ANDA #$1F
KD40D:  STD  -4,Y
KD40F:  LDD  BJ_PNT+$05
KD411:  SUBD BJ_PNT+$23
KD413:  ANDA #$1F
KD415:  ORA  BJ_PNT+$09
KD417:  ADDA BJ_PNT+$27
KD419:  STD  -2,Y
KD41B:  LDD  BJ_PNT+$1B             ;draw point 1 to 5, intensity from the two points' flag bytes
KD41D:  SUBD BJ_PNT+$07
KD41F:  ANDA #$1F
KD421:  STD  ,Y
KD423:  LDD  BJ_PNT+$19
KD425:  SUBD BJ_PNT+$05
KD427:  ANDA #$1F
KD429:  ORA  BJ_PNT+$1D
KD42B:  ADDA BJ_PNT+$09
KD42D:  STD  2,Y
KD42F:  LDD  BJ_PNT+$16             ;draw point 5 to 4, intensity from the two points' flag bytes
KD431:  SUBD BJ_PNT+$1B
KD433:  ANDA #$1F
KD435:  STD  4,Y
KD437:  LDD  BJ_PNT+$14
KD439:  SUBD BJ_PNT+$19
KD43B:  ANDA #$1F
KD43D:  ORA  BJ_PNT+$18
KD43F:  ADDA BJ_PNT+$1D
KD441:  STD  6,Y
KD443:  LDD  BJ_PNT+$02             ;BDRAWTO 1,3,15,12,9  UP RIGHT SIDE  draw point 4 to 0, intensity from the two points' flag bytes
KD445:  SUBD BJ_PNT+$16
KD447:  ANDA #$1F
KD449:  STD  8,Y
KD44B:  LDD  ST_QUZ
KD44D:  SUBD BJ_PNT+$14
KD44F:  ANDA #$1F
KD451:  ORA  BJ_PNT+$04
KD453:  ADDA BJ_PNT+$18
KD455:  STD  $A,Y
KD457:  LDD  BJ_PNT+$07             ;draw point 0 to 1, intensity from the two points' flag bytes
KD459:  SUBD BJ_PNT+$02
KD45B:  ANDA #$1F
KD45D:  STD  $C,Y
KD45F:  LDD  BJ_PNT+$05
KD461:  SUBD ST_QUZ
KD463:  ANDA #$1F
KD465:  ORA  BJ_PNT+$09
KD467:  ADDA BJ_PNT+$04
KD469:  STD  $E,Y
KD46B:  LDD  BJ_PNT+$11             ;draw point 1 to 3, intensity from the two points' flag bytes
KD46D:  SUBD BJ_PNT+$07
KD46F:  ANDA #$1F
KD471:  LEAY $20,Y
KD474:  STD  -16,Y
KD476:  LDD  BJ_PNT+$0F
KD478:  SUBD BJ_PNT+$05
KD47A:  ANDA #$1F
KD47C:  ORA  BJ_PNT+$13
KD47E:  ADDA BJ_PNT+$09
KD480:  STD  -14,Y
KD482:  LDD  BJ_PNT+$2F             ;draw point 3 to 9, intensity from the two points' flag bytes
KD484:  SUBD BJ_PNT+$11
KD486:  ANDA #$1F
KD488:  STD  -12,Y
KD48A:  LDD  BJ_PNT+$2D
KD48C:  SUBD BJ_PNT+$0F
KD48E:  ANDA #$1F
KD490:  ORA  BJ_PNT+$31
KD492:  ADDA BJ_PNT+$13
KD494:  STD  -10,Y
KD496:  LDD  BJ_PNT+$25             ;draw point 9 to 7, intensity from the two points' flag bytes
KD498:  SUBD BJ_PNT+$2F
KD49A:  ANDA #$1F
KD49C:  STD  -8,Y
KD49E:  LDD  BJ_PNT+$23
KD4A0:  SUBD BJ_PNT+$2D
KD4A2:  ANDA #$1F
KD4A4:  ORA  BJ_PNT+$27
KD4A6:  ADDA BJ_PNT+$31
KD4A8:  STD  -6,Y
KD4AA:  LDD  BJ_PNT+$4D             ;draw point 7 to 15, intensity from the two points' flag bytes
KD4AC:  SUBD BJ_PNT+$25
KD4AE:  ANDA #$1F
KD4B0:  STD  -4,Y
KD4B2:  LDD  BJ_PNT+$4B
KD4B4:  SUBD BJ_PNT+$23
KD4B6:  ANDA #$1F
KD4B8:  ORA  BJ_PNT+$4F
KD4BA:  ADDA BJ_PNT+$27
KD4BC:  STD  -2,Y
KD4BE:  LDD  BJ_PNT+$57             ;draw point 15 to 17, intensity from the two points' flag bytes
KD4C0:  SUBD BJ_PNT+$4D
KD4C2:  ANDA #$1F
KD4C4:  STD  ,Y
KD4C6:  LDD  BJ_PNT+$55
KD4C8:  SUBD BJ_PNT+$4B
KD4CA:  ANDA #$1F
KD4CC:  ORA  BJ_PNT+$59
KD4CE:  ADDA BJ_PNT+$4F
KD4D0:  STD  2,Y
KD4D2:  LDD  BJ_PNT+$75             ;draw point 17 to 23, intensity from the two points' flag bytes
KD4D4:  SUBD BJ_PNT+$57
KD4D6:  ANDA #$1F
KD4D8:  STD  4,Y
KD4DA:  LDD  BJ_PNT+$73
KD4DC:  SUBD BJ_PNT+$55
KD4DE:  ANDA #$1F
KD4E0:  ORA  BJ_PNT+$77
KD4E2:  ADDA BJ_PNT+$59
KD4E4:  STD  6,Y
KD4E6:  LDD  BJ_PNT+$6B             ;BDRAWTO 1,3,15,12,9  UP RIGHT SIDE  draw point 23 to 21, intensity from the two points' flag bytes
KD4E8:  SUBD BJ_PNT+$75
KD4EA:  ANDA #$1F
KD4EC:  STD  8,Y
KD4EE:  LDD  BJ_PNT+$69
KD4F0:  SUBD BJ_PNT+$73
KD4F2:  ANDA #$1F
KD4F4:  ORA  BJ_PNT+$6D
KD4F6:  ADDA BJ_PNT+$77
KD4F8:  STD  $A,Y
KD4FA:  LDD  BJ_PNT+$66             ;draw point 21 to 20, intensity from the two points' flag bytes
KD4FC:  SUBD BJ_PNT+$6B
KD4FE:  ANDA #$1F
KD500:  STD  $C,Y
KD502:  LDD  BJ_PNT+$64
KD504:  SUBD BJ_PNT+$69
KD506:  ANDA #$1F
KD508:  ORA  BJ_PNT+$68
KD50A:  ADDA BJ_PNT+$6D
KD50C:  STD  $E,Y
KD50E:  LDD  BJ_PNT+$70             ;draw point 20 to 22, intensity from the two points' flag bytes
KD510:  SUBD BJ_PNT+$66
KD512:  ANDA #$1F
KD514:  LEAY $20,Y
KD517:  STD  -16,Y
KD519:  LDD  BJ_PNT+$6E
KD51B:  SUBD BJ_PNT+$64
KD51D:  ANDA #$1F
KD51F:  ORA  BJ_PNT+$72
KD521:  ADDA BJ_PNT+$68
KD523:  STD  -14,Y
KD525:  LDD  BJ_PNT+$52             ;draw point 22 to 16, intensity from the two points' flag bytes
KD527:  SUBD BJ_PNT+$70
KD529:  ANDA #$1F
KD52B:  STD  -12,Y
KD52D:  LDD  BJ_PNT+$50
KD52F:  SUBD BJ_PNT+$6E
KD531:  ANDA #$1F
KD533:  ORA  BJ_PNT+$54
KD535:  ADDA BJ_PNT+$72
KD537:  STD  -10,Y
KD539:  LDD  BJ_PNT+$48             ;draw point 16 to 14, intensity from the two points' flag bytes
KD53B:  SUBD BJ_PNT+$52
KD53D:  ANDA #$1F
KD53F:  STD  -8,Y
KD541:  LDD  BJ_PNT+$46
KD543:  SUBD BJ_PNT+$50
KD545:  ANDA #$1F
KD547:  ORA  BJ_PNT+$4A
KD549:  ADDA BJ_PNT+$54
KD54B:  STD  -6,Y
KD54D:  LDD  BJ_PNT+$20             ;draw point 14 to 6, intensity from the two points' flag bytes
KD54F:  SUBD BJ_PNT+$48
KD551:  ANDA #$1F
KD553:  STD  -4,Y
KD555:  LDD  BJ_PNT+$1E
KD557:  SUBD BJ_PNT+$46
KD559:  ANDA #$1F
KD55B:  ORA  BJ_PNT+$22
KD55D:  ADDA BJ_PNT+$4A
KD55F:  STD  -2,Y
KD561:  LDD  BJ_PNT+$2A             ;draw point 6 to 8, intensity from the two points' flag bytes
KD563:  SUBD BJ_PNT+$20
KD565:  ANDA #$1F
KD567:  STD  ,Y
KD569:  LDD  BJ_PNT+$28
KD56B:  SUBD BJ_PNT+$1E
KD56D:  ANDA #$1F
KD56F:  ORA  BJ_PNT+$2C
KD571:  ADDA BJ_PNT+$22
KD573:  STD  2,Y
KD575:  LDD  BJ_PNT+$0C             ;draw point 8 to 2, intensity from the two points' flag bytes
KD577:  SUBD BJ_PNT+$2A
KD579:  ANDA #$1F
KD57B:  STD  4,Y
KD57D:  LDD  BJ_PNT+$0A
KD57F:  SUBD BJ_PNT+$28
KD581:  ANDA #$1F
KD583:  ORA  BJ_PNT+$0E
KD585:  ADDA BJ_PNT+$2C
KD587:  STD  6,Y
KD589:  LDD  BJ_PNT+$11             ;BDRAWTO 1,3,15,12,9  UP RIGHT SIDE  draw point 2 to 3, intensity from the two points' flag bytes
KD58B:  SUBD BJ_PNT+$0C
KD58D:  ANDA #$1F
KD58F:  STD  8,Y
KD591:  LDD  BJ_PNT+$0F
KD593:  SUBD BJ_PNT+$0A
KD595:  ANDA #$1F
KD597:  ORA  BJ_PNT+$13
KD599:  ADDA BJ_PNT+$0E
KD59B:  STD  $A,Y
KD59D:  LDD  BJ_PNT+$39             ;draw point 3 to 11, intensity from the two points' flag bytes
KD59F:  SUBD BJ_PNT+$11
KD5A1:  ANDA #$1F
KD5A3:  STD  $C,Y
KD5A5:  LDD  BJ_PNT+$37
KD5A7:  SUBD BJ_PNT+$0F
KD5A9:  ANDA #$1F
KD5AB:  ORA  BJ_PNT+$3B
KD5AD:  ADDA BJ_PNT+$13
KD5AF:  STD  $E,Y
KD5B1:  LDD  BJ_PNT+$2F             ;draw point 11 to 9, intensity from the two points' flag bytes
KD5B3:  SUBD BJ_PNT+$39
KD5B5:  ANDA #$1F
KD5B7:  LEAY $20,Y
KD5BA:  STD  -16,Y
KD5BC:  LDD  BJ_PNT+$2D
KD5BE:  SUBD BJ_PNT+$37
KD5C0:  ANDA #$1F
KD5C2:  ORA  BJ_PNT+$31
KD5C4:  ADDA BJ_PNT+$3B
KD5C6:  STD  -14,Y
KD5C8:  LDD  BJ_PNT+$57             ;draw point 9 to 17, intensity from the two points' flag bytes
KD5CA:  SUBD BJ_PNT+$2F
KD5CC:  ANDA #$1F
KD5CE:  STD  -12,Y
KD5D0:  LDD  BJ_PNT+$55
KD5D2:  SUBD BJ_PNT+$2D
KD5D4:  ANDA #$1F
KD5D6:  ORA  BJ_PNT+$59
KD5D8:  ADDA BJ_PNT+$31
KD5DA:  STD  -10,Y
KD5DC:  LDD  BJ_PNT+$61             ;draw point 17 to 19, intensity from the two points' flag bytes
KD5DE:  SUBD BJ_PNT+$57
KD5E0:  ANDA #$1F
KD5E2:  STD  -8,Y
KD5E4:  LDD  BJ_PNT+$5F
KD5E6:  SUBD BJ_PNT+$55
KD5E8:  ANDA #$1F
KD5EA:  ORA  BJ_PNT+$63
KD5EC:  ADDA BJ_PNT+$59
KD5EE:  STD  -6,Y
KD5F0:  LDD  BJ_PNT+$75             ;draw point 19 to 23, intensity from the two points' flag bytes
KD5F2:  SUBD BJ_PNT+$61
KD5F4:  ANDA #$1F
KD5F6:  STD  -4,Y
KD5F8:  LDD  BJ_PNT+$73
KD5FA:  SUBD BJ_PNT+$5F
KD5FC:  ANDA #$1F
KD5FE:  ORA  BJ_PNT+$77
KD600:  ADDA BJ_PNT+$63
KD602:  STD  -2,Y
KD604:  LDD  BJ_PNT+$70             ;draw point 23 to 22, intensity from the two points' flag bytes
KD606:  SUBD BJ_PNT+$75
KD608:  ANDA #$1F
KD60A:  STD  ,Y
KD60C:  LDD  BJ_PNT+$6E
KD60E:  SUBD BJ_PNT+$73
KD610:  ANDA #$1F
KD612:  ORA  BJ_PNT+$72
KD614:  ADDA BJ_PNT+$77
KD616:  STD  2,Y
KD618:  LDD  BJ_PNT+$5C             ;draw point 22 to 18, intensity from the two points' flag bytes
KD61A:  SUBD BJ_PNT+$70
KD61C:  ANDA #$1F
KD61E:  STD  4,Y
KD620:  LDD  BJ_PNT+$5A
KD622:  SUBD BJ_PNT+$6E
KD624:  ANDA #$1F
KD626:  ORA  BJ_PNT+$5E
KD628:  ADDA BJ_PNT+$72
KD62A:  STD  6,Y
KD62C:  LDD  BJ_PNT+$52             ;BDRAWTO 1,3,15,12,9  UP RIGHT SIDE  draw point 18 to 16, intensity from the two points' flag bytes
KD62E:  SUBD BJ_PNT+$5C
KD630:  ANDA #$1F
KD632:  STD  8,Y
KD634:  LDD  BJ_PNT+$50
KD636:  SUBD BJ_PNT+$5A
KD638:  ANDA #$1F
KD63A:  ORA  BJ_PNT+$54
KD63C:  ADDA BJ_PNT+$5E
KD63E:  STD  $A,Y
KD640:  LDD  BJ_PNT+$2A             ;draw point 16 to 8, intensity from the two points' flag bytes
KD642:  SUBD BJ_PNT+$52
KD644:  ANDA #$1F
KD646:  STD  $C,Y
KD648:  LDD  BJ_PNT+$28
KD64A:  SUBD BJ_PNT+$50
KD64C:  ANDA #$1F
KD64E:  ORA  BJ_PNT+$2C
KD650:  ADDA BJ_PNT+$54
KD652:  STD  $E,Y
KD654:  LDD  BJ_PNT+$34             ;draw point 8 to 10, intensity from the two points' flag bytes
KD656:  SUBD BJ_PNT+$2A
KD658:  ANDA #$1F
KD65A:  LEAY $20,Y
KD65D:  STD  -16,Y
KD65F:  LDD  BJ_PNT+$32
KD661:  SUBD BJ_PNT+$28
KD663:  ANDA #$1F
KD665:  ORA  BJ_PNT+$36
KD667:  ADDA BJ_PNT+$2C
KD669:  STD  -14,Y
KD66B:  LDD  BJ_PNT+$39             ;draw point 10 to 11, intensity from the two points' flag bytes
KD66D:  SUBD BJ_PNT+$34
KD66F:  ANDA #$1F
KD671:  STD  -12,Y
KD673:  LDD  BJ_PNT+$37
KD675:  SUBD BJ_PNT+$32
KD677:  ANDA #$1F
KD679:  ORA  BJ_PNT+$3B
KD67B:  ADDA BJ_PNT+$36
KD67D:  STD  -10,Y
KD67F:  LDD  BJ_PNT+$61             ;draw point 11 to 19, intensity from the two points' flag bytes
KD681:  SUBD BJ_PNT+$39
KD683:  ANDA #$1F
KD685:  STD  -8,Y
KD687:  LDD  BJ_PNT+$5F
KD689:  SUBD BJ_PNT+$37
KD68B:  ANDA #$1F
KD68D:  ORA  BJ_PNT+$63
KD68F:  ADDA BJ_PNT+$3B
KD691:  STD  -6,Y
KD693:  LDD  BJ_PNT+$5C             ;draw point 19 to 18, intensity from the two points' flag bytes
KD695:  SUBD BJ_PNT+$61
KD697:  ANDA #$1F
KD699:  STD  -4,Y
KD69B:  LDD  BJ_PNT+$5A
KD69D:  SUBD BJ_PNT+$5F
KD69F:  ANDA #$1F
KD6A1:  ORA  BJ_PNT+$5E
KD6A3:  ADDA BJ_PNT+$63
KD6A5:  STD  -2,Y
KD6A7:  LDD  BJ_PNT+$34             ;draw point 18 to 10, intensity from the two points' flag bytes
KD6A9:  SUBD BJ_PNT+$5C
KD6AB:  ANDA #$1F
KD6AD:  STD  ,Y
KD6AF:  LDD  BJ_PNT+$32
KD6B1:  SUBD BJ_PNT+$5A
KD6B3:  ANDA #$1F
KD6B5:  ORA  BJ_PNT+$36
KD6B7:  ADDA BJ_PNT+$5E
KD6B9:  STD  2,Y
KD6BB:  LEAY 4,Y
KD6BD:  LDA  #$48
KD6BF:  TFR  A,DP
.dpage $48
KD6C1:  LDD  BJ_PNT+$32
KD6C4:  STD  BJ_CX
KD6C6:  LDD  BJ_PNT+$34
KD6C9:  STD  BJ_CY
KD6CB:  PULS A,B,X,U,PC

obj_draw_tab:
KD6CD:  .word draw_tie              ;object 0: TIE fighter. this table: the draw routine of each of the 35 objects, indexed by BJ_ID
KD6CF:  .word draw_tie_wing         ;object 1: exploded TIE, left wing
KD6D1:  .word draw_tie_wing         ;object 2: exploded TIE, right wing
KD6D3:  .word draw_tie_cabin        ;object 3: exploded TIE, centre cabin
KD6D5:  .word draw_probot_body      ;object 4: probot body
KD6D7:  .word draw_probot_body      ;object 5: hexagon on top of the probot body, drawn with object 4
KD6D9:  .word draw_probot_head      ;object 6: probot head
KD6DB:  .word draw_probot_eye       ;object 7: figure on the front of the probot head
KD6DD:  .word draw_hexagon          ;object 8: hexagon of the probot transmissions
KD6DF:  .word draw_limb_down        ;object 9: probot limb, the stroke down
KD6E1:  .word draw_limb_up          ;object 10: probot limb, the stroke back up
KD6E3:  .word draw_limb_down        ;objects 11 to 16: six more probot limbs, drawn by the game as objects 9 and 10
KD6E5:  .word draw_limb_down
KD6E7:  .word draw_limb_down
KD6E9:  .word draw_limb_down
KD6EB:  .word draw_limb_down
KD6ED:  .word draw_limb_down
KD6EF:  .word draw_atst_head        ;object 17: AT-ST head
KD6F1:  .word draw_atst_port        ;object 18: panel on the front of the AT-ST head
KD6F3:  .word draw_atst_leg         ;object 19: AT-ST leg, 18 points made by the game
KD6F5:  .word draw_atst_side        ;object 20: AT-ST head, one half (explosion piece)
KD6F7:  .word draw_atst_top         ;object 21: AT-ST head, top wedge (explosion piece)
KD6F9:  .word draw_atst_side        ;object 22: AT-ST head, other half (explosion piece)
KD6FB:  .word draw_atat_body        ;object 23: AT-AT body
KD6FD:  .word draw_atat_head        ;object 24: AT-AT head
KD6FF:  .word draw_atat_eye         ;object 25: the eye on the AT-AT head
KD701:  .word draw_atat_neck        ;object 26: AT-AT neck, between body and head points
KD703:  .word draw_atat_leg         ;object 27: AT-AT leg, 12 points made by the game
KD705:  .word draw_atat_piece       ;objects 28 to 30: thirds of the AT-AT body (explosion pieces)
KD707:  .word draw_atat_piece
KD709:  .word draw_atat_piece
KD70B:  .word draw_dart             ;object 31: the dart of the tow cable code
KD70D:  .word draw_asteroid         ;objects 32 to 34: asteroid, three sizes
KD70F:  .word draw_asteroid
KD711:  .word draw_asteroid

TDRWNM:
KD713:  .byte $35, $13, $13, $1D, $13, $06, $14, $14 ;points per object, objects 0-7
KD71B:  .byte $06, $04, $04, $04, $04, $04, $04, $04 ;points per object, objects 8-15
KD723:  .byte $04, $12, $12, $01, $08, $06, $08, $18 ;points per object, objects 16-23
KD72B:  .byte $15, $15, $15, $01, $08, $08, $08, $09 ;points per object, objects 24-31
KD733:  .byte $18, $18, $18         ;points per object, objects 32-34

obj_points_tab:
KD736:  .word TD0PC                 ;object 0: 53 points - TIE fighter
KD738:  .word TD1PC                 ;object 1: 19 points - exploded TIE wing
KD73A:  .word TD2PC                 ;object 2: 19 points - exploded TIE wing
KD73C:  .word TD3PC                 ;object 3: 29 points - exploded TIE cabin
KD73E:  .word KA6F6                 ;object 4: 19 points - probot body, upper part
KD740:  .word KA768                 ;object 5: 6 points - probot body, lower part
KD742:  .word KA78C                 ;object 6: 20 points - probot head
KD744:  .word KA78C                 ;object 7: 20 points - four-sided figure on the front of the probot head
KD746:  .word KA804                 ;object 8: 6 points - hexagon of a probot transmission
KD748:  .word KA828                 ;object 9: 4 points - probot limb, stroke down
KD74A:  .word KA840                 ;object 10: 4 points - probot limb, stroke back up
KD74C:  .word KA858                 ;object 11: 4 points - probot limb
KD74E:  .word KA870                 ;object 12: 4 points - probot limb
KD750:  .word KA888                 ;object 13: 4 points - probot limb
KD752:  .word KA8A0                 ;object 14: 4 points - probot limb
KD754:  .word KA8B8                 ;object 15: 4 points - probot limb
KD756:  .word KA8D0                 ;object 16: 4 points - probot limb
KD758:  .word KA8E8                 ;object 17: 18 points - AT-ST head
KD75A:  .word KA8E8                 ;object 18: 18 points - front panel of the AT-ST head
KD75C:  .word KA954                 ;object 19: 1 points - AT-ST leg (its 18 points are made by the game)
KD75E:  .word KA95A                 ;object 20: 8 points - AT-ST head half (explosion piece)
KD760:  .word KA98A                 ;object 21: 6 points - AT-ST head top wedge (explosion piece)
KD762:  .word KA9AE                 ;object 22: 8 points - AT-ST head half (explosion piece)
KD764:  .word KA9DE                 ;object 23: 24 points - AT-AT body
KD766:  .word KAA6E                 ;object 24: 21 points - AT-AT head
KD768:  .word KAA6E                 ;object 25: 21 points - the eye on the AT-AT head
KD76A:  .word KAA6E                 ;object 26: 21 points - AT-AT neck
KD76C:  .word KAAEC                 ;object 27: 1 points - AT-AT leg (its 12 points are made by the game)
KD76E:  .word KAAF2                 ;object 28: 8 points - third of the AT-AT body (explosion piece)
KD770:  .word KAB22                 ;object 29: 8 points - third of the AT-AT body (explosion piece)
KD772:  .word KAB52                 ;object 30: 8 points - third of the AT-AT body (explosion piece)
KD774:  .word KAB82                 ;object 31: 9 points - dart at the end of the tow cable
KD776:  .word KABB8                 ;object 32: 24 points - asteroid
KD778:  .word KAC48                 ;object 33: 24 points - asteroid
KD77A:  .word KACD8                 ;object 34: 24 points - asteroid

obj_buf_tab:
KD77C:  .word $4E00                 ;this table: where in BJ_PNT obj_points puts each object's first perspected point. $4E05 is point 1, $4E64 point 20, $4E6E point 22, so that two objects can share one draw routine
KD77E:  .word $4E00                 ;object 1
KD780:  .word $4E00                 ;object 2
KD782:  .word $4E00                 ;object 3
KD784:  .word $4E05                 ;object 4
KD786:  .word $4E64                 ;object 5
KD788:  .word $4E00                 ;object 6
KD78A:  .word $4E00                 ;object 7
KD78C:  .word $4E00                 ;object 8
KD78E:  .word $4E00                 ;object 9
KD790:  .word $4E00                 ;object 10
KD792:  .word $4E00                 ;object 11
KD794:  .word $4E00                 ;object 12
KD796:  .word $4E00                 ;object 13
KD798:  .word $4E00                 ;object 14
KD79A:  .word $4E00                 ;object 15
KD79C:  .word $4E00                 ;object 16
KD79E:  .word $4E00                 ;object 17
KD7A0:  .word $4E00                 ;object 18
KD7A2:  .word $4E00                 ;object 19
KD7A4:  .word $4E00                 ;object 20
KD7A6:  .word $4E00                 ;object 21
KD7A8:  .word $4E00                 ;object 22
KD7AA:  .word $4E05                 ;object 23
KD7AC:  .word $4E6E                 ;object 24
KD7AE:  .word $4E6E                 ;object 25
KD7B0:  .word $4E6E                 ;object 26
KD7B2:  .word $4E00                 ;object 27
KD7B4:  .word $4E00                 ;object 28
KD7B6:  .word $4E00                 ;object 29
KD7B8:  .word $4E00                 ;object 30
KD7BA:  .word $4E05                 ;object 31
KD7BC:  .word $4E00                 ;object 32
KD7BE:  .word $4E00                 ;object 33
KD7C0:  .word $4E00                 ;object 34

obj_cue_scale:
KD7C2:  .word $0E00                 ;this table: depth cue scale of each object, to M_YPS. scale times range is about 64 in the math box's $4000 = 1 units, so the cue runs from 0 to 127 across the object
KD7C4:  .word $0FC0                 ;object 1
KD7C6:  .word $0CC0                 ;object 2
KD7C8:  .word $1E40                 ;object 3
KD7CA:  .word $30C0                 ;object 4
KD7CC:  .word $7FC0                 ;object 5
KD7CE:  .word $30C0                 ;object 6
KD7D0:  .word $30C0                 ;object 7
KD7D2:  .word $30C0                 ;object 8
KD7D4:  .word $4900                 ;object 9
KD7D6:  .word $4900                 ;object 10
KD7D8:  .word $6180                 ;object 11
KD7DA:  .word $6180                 ;object 12
KD7DC:  .word $7FC0                 ;object 13
KD7DE:  .word $5540                 ;object 14
KD7E0:  .word $7FC0                 ;object 15
KD7E2:  .word $4EC0                 ;object 16
KD7E4:  .word $0F80                 ;object 17
KD7E6:  .word $0F80                 ;object 18
KD7E8:  .word $7FC0                 ;object 19
KD7EA:  .word $0F80                 ;object 20
KD7EC:  .word $1180                 ;object 21
KD7EE:  .word $0F80                 ;object 22
KD7F0:  .word $0240                 ;object 23
KD7F2:  .word $0240                 ;object 24
KD7F4:  .word $0240                 ;object 25
KD7F6:  .word $0240                 ;object 26
KD7F8:  .word $7FC0                 ;object 27
KD7FA:  .word $0240                 ;object 28
KD7FC:  .word $0440                 ;object 29
KD7FE:  .word $0240                 ;object 30
KD800:  .word $07C0                 ;object 31
KD802:  .word $02C0                 ;object 32
KD804:  .word $05C0                 ;object 33
KD806:  .word $0B80                 ;object 34

obj_cue_depth:
KD808:  .word $0123                 ;this table: depth cue range of each object, about its radius. added to the distance of the object's centre it is the depth at which the cue is 0
KD80A:  .word $0104                 ;object 1
KD80C:  .word $013D                 ;object 2
KD80E:  .word $0087                 ;object 3
KD810:  .word $0054                 ;object 4
KD812:  .word $0020                 ;object 5
KD814:  .word $0054                 ;object 6
KD816:  .word $0054                 ;object 7
KD818:  .word $0054                 ;object 8
KD81A:  .word $0038                 ;object 9
KD81C:  .word $0038                 ;object 10
KD81E:  .word $002A                 ;object 11
KD820:  .word $002A                 ;object 12
KD822:  .word $0020                 ;object 13
KD824:  .word $0030                 ;object 14
KD826:  .word $0020                 ;object 15
KD828:  .word $0034                 ;object 16
KD82A:  .word $0108                 ;object 17
KD82C:  .word $0108                 ;object 18
KD82E:  .word $0020                 ;object 19
KD830:  .word $0108                 ;object 20
KD832:  .word $00EA                 ;object 21
KD834:  .word $0108                 ;object 22
KD836:  .word $0708                 ;object 23
KD838:  .word $06D6                 ;object 24
KD83A:  .word $06D6                 ;object 25
KD83C:  .word $06D6                 ;object 26
KD83E:  .word $0020                 ;object 27
KD840:  .word $0708                 ;object 28
KD842:  .word $03B6                 ;object 29
KD844:  .word $0708                 ;object 30
KD846:  .word $0208                 ;object 31
KD848:  .word $0578                 ;object 32
KD84A:  .word $02BC                 ;object 33
KD84C:  .word $015E                 ;object 34

;------------------------------------------------------------------------------
; obj_list_init - entry of JINOBJ through the cross-bank table (bank 0 L60A2, called by init_general): saves X,
;   runs JINOBJ below, which in ESB ends by pulling X and returning
;------------------------------------------------------------------------------
obj_list_init:
KD84E:  PSHS X

;------------------------------------------------------------------------------
; INOBJ_670D - [note] Initialize objects: clear the BIC list BJBIC..BJBICZ, BJ_BIC = MS_BJBC/2 (starting BIC value, pairs of
;   points), BJ_RAM = M_OBJ (starting RAM address)
;   (also: TPNTZ, INOBJ_670D)
;------------------------------------------------------------------------------
INOBJ_670D:
JINOBJ:
TPNTZ:
KD850:  LDX  #BJBIC
KD853:  LDA  #$00

JINOBJ_10:
KD855:  STA  ,X+                    ;CLEAR OUT BIC LIST
KD857:  CMPX #BJBICZ
KD85A:  BLO  JINOBJ_10
KD85C:  LDA  #MS_BJBC
KD85E:  LSRA                        ;PAIRS OF POINTS
KD85F:  STA  BJ_BIC                 ;STARTING BIC VALUE
KD861:  LDD  #M_OBJ
KD864:  STD  BJ_RAM                 ;STARTING RAM ADDRESS
KD866:  PULS X,PC                   ;ESB: X was saved by the entry at $D84E

;------------------------------------------------------------------------------
; obj_load_b - loads object B into the math RAM: stores B in BJ_ID and runs obj_load. called through bank 0
;   L60A8 by the setup routines of the game parts, once for every object the part draws
;------------------------------------------------------------------------------
obj_load_b:
KD868:  STB  BJ_ID

;------------------------------------------------------------------------------
; obj_load - Star Wars' JADOBJ, changed: copies the points of object BJ_ID from its ROM table (6 bytes each,
;   address from obj_points_tab) into the math RAM at BJ_RAM (8 bytes each) and notes the block index in BJBIC,
;   unless the object is already there. ESB rounds the point count up to an even number, keeps the counter on the
;   stack, saves A, X and U, and returns without loading when the block index would overflow, where Star Wars had
;   a SWI
;------------------------------------------------------------------------------
obj_load:
KD86A:  PSHS A,X,U

ADOBJ_6726:
JADOBJ:
KD86C:  LDB  BJ_ID
KD86E:  LDX  #BJBIC
KD871:  LDA  B,X                    ;?MISSING FROM MBOX?
KD873:  BNE  KD8AA                  ;B IF ALREADY PRESENT IN MBOX
KD875:  LDA  BJ_BIC                 ;THEN START THE TRANSFER
KD877:  STA  B,X                    ;SAVE BIC ADDRESS
KD879:  LDX  #TDRWNM
KD87C:  LDA  B,X                    ;# OF POINTS TO XFER
KD87E:  INCA                        ;ESB: the count is rounded up to an even number, points are loaded in pairs
KD87F:  ANDA #$FE
KD881:  STA  ,S                     ;loop counter on the stack, in the place of the saved A
KD883:  LSRA                        ;PAIRS OF POINTS
KD884:  ADDA BJ_BIC                 ;UPDATE BIC
KD886:  BCC  JADOBJ_25              ;?TOO MANY POINTS?
KD888:  BRA  KD8AA                  ;ESB: too many points, return without loading (a SWI in Star Wars)

;FOR PROD, REPOINT FOR PSUEDO-GOOD POINTS BJBIC TO M$BJBC
JADOBJ_25:
KD88A:  STA  BJ_BIC
KD88C:  LDX  #obj_points_tab        ;POINTER TO 6 BYTE ROM POINTS
KD88F:  LSLB                        ;ACCESSED BY WORDS
KD890:  LDX  B,X                    ;X-->6 BYTE ROM
KD892:  LDU  BJ_RAM                 ;U-->8 BYTE MRAM

JADOBJ_30:
KD894:  LDD  ,X                     ;X
KD896:  STD  ,U
KD898:  LDD  2,X                    ;Y
KD89A:  STD  2,U
KD89C:  LDD  4,X                    ;Z
KD89E:  STD  4,U
KD8A0:  LEAX 6,X                    ;6 BYTE ROM
KD8A2:  LEAU 8,U                    ;8 BYTE MRAM
KD8A4:  DEC  ,S
KD8A6:  BGT  JADOBJ_30              ;LOOP THRU THEM ALL
KD8A8:  STU  BJ_RAM                 ;RECORD LATEST MRAM USAGE
KD8AA:  PULS A,X,U,PC

;------------------------------------------------------------------------------
; obj_beam_home - ends an object: sets the beam position the draw routines work from to the screen centre (BJ_CX
;   = 0, BJ_CY = $68, which is minus VGOFFY) and adds a JSRL to vector ROM $32AC, the default scale and a centre
;   instruction. called after every object draw and by bank 0 when a display list is started
;------------------------------------------------------------------------------
obj_beam_home:
KD8AC:  LDD  #$0000
KD8AF:  STD  BJ_CX
KD8B1:  LDD  #$0068
KD8B4:  STD  BJ_CY
KD8B6:  LDD  #$B956                 ;JSRL to vector ROM $32AC: default scale, centre
KD8B9:  STD  ,Y++

JADOBJ_90:
KD8BB:  RTS

;------------------------------------------------------------------------------
; BJCNTR_6761 - OBJECT DRAW -- BJCNTR,OBJCEN,OBJPNT,OBJDRW,BJLNV/B
;   EXPECTS VG AT CENTER, INFO AT QUO, YP, XP
;   (also: JOBJCEN, BJCNTR_6761, OBJCEN_6761)
;------------------------------------------------------------------------------
BJCNTR_6761:
JBJCNTR:
JOBJCEN:
OBJCEN_6761:
KD8BC:  LDD  M_QUO                  ;AT LEAST 7.5 CYCLES AFTER M.DVD
KD8BF:  STD  M_XP
KD8C2:  LDA  #MS_PERS
KD8C4:  JSR  MGOWT_B1
KD8C7:  LDD  M_ZP
KD8CA:  STD  BJ_CY                  ;NEW CUNENT Y
KD8CC:  ADDD #VGOFFY                ;VIDEO CENTER OFFSET
KD8CF:  ANDA #$1F
KD8D1:  STD  ,Y++                   ;Y LONG VECTOR
KD8D3:  LDD  M_YP
KD8D6:  STD  BJ_CX
KD8D8:  ANDA #$1F
KD8DA:  STD  ,Y++                   ;X LONG VECTOR
KD8DC:  RTS

;------------------------------------------------------------------------------
; BJLNV_6782 - [note] Draw visible line: M_QUO to M_XP and MS_PERS, then output a vector (Z bits $E0) from current
;   BJ_CX,BJ_CY to the new point M_YP (left/right), M_ZP (up/down) and make it current. Y-->VG list
;   (also: BJLNV_6782)
;------------------------------------------------------------------------------
BJLNV_6782:
JBJLNV:
KD8DD:  LDD  M_QUO                  ;AT LEAST 7.5 CYCLES AFTER M.DVD
KD8E0:  STD  M_XP
KD8E3:  LDA  #MS_PERS
KD8E5:  JSR  MGOWT_B1
KD8E8:  LDD  M_ZP
KD8EB:  SUBD BJ_CY                  ;CURRENT UP/DOWN POSITION
KD8ED:  ANDA #$1F
KD8EF:  STD  ,Y++
KD8F1:  LDD  M_ZP
KD8F4:  STD  BJ_CY
KD8F6:  LDD  M_YP                   ;LEFT/RIGHT
KD8F9:  SUBD BJ_CX
KD8FB:  ORA  #$E0
KD8FD:  STD  ,Y++
KD8FF:  LDD  M_YP
KD902:  STD  BJ_CX
KD904:  RTS

;------------------------------------------------------------------------------
; BJLNB_67AA - [note] Draw blank line: as JBJLNV but the vector is output blank (Z bits off); updates BJ_CX,BJ_CY
;   (also: BJLNB_67AA)
;------------------------------------------------------------------------------
BJLNB_67AA:
JBJLNB:
KD905:  LDD  M_QUO                  ;AT LEAST 7.5 CYCLES AFTER M.DVD
KD908:  STD  M_XP
KD90B:  LDA  #MS_PERS
KD90D:  JSR  MGOWT_B1
KD910:  LDD  M_ZP
KD913:  SUBD BJ_CY                  ;CURRENT UP/DOWN POSITION
KD915:  ANDA #$1F
KD917:  STD  ,Y++
KD919:  LDD  M_ZP
KD91C:  STD  BJ_CY
KD91E:  LDD  M_YP                   ;LEFT/RIGHT
KD921:  SUBD BJ_CX
KD923:  ANDA #$1F                   ;BLANK
KD925:  STD  ,Y++
KD927:  LDD  M_YP
KD92A:  STD  BJ_CX
KD92C:  RTS

;------------------------------------------------------------------------------
; JOBJBPNT - [note] Process object points, B = object #: BJ_ID = B, then JOBJPNT - for each point of the object (count
;   from TDRWNM, BIC from BJBIC) do MS_PAD, 1/X and MS_PERS, saving M_YP,M_ZP in BJ_PNT (4 bytes each)
;   (also: OBJBPNT_67D2)
;   in ESB: only the entry is the same. obj_points below does not use MS_PAD and MS_PERS point by point:
;   programs $32 and $36 of ESB's own microcode do each point, the points are 5 bytes with a depth cue flag,
;   and they go to the buffer address of obj_buf_tab
;------------------------------------------------------------------------------
JOBJBPNT:
OBJBPNT_67D2:
KD92D:  STB  BJ_ID

;------------------------------------------------------------------------------
; obj_points - perspects the points of object BJ_ID into the point buffer, ESB's version of JOBJPNT. the buffer
;   address comes from obj_buf_tab, the depth cue range (plus the centre's distance M_XT) and scale from
;   obj_cue_depth and obj_cue_scale go to M_XPS and M_YPS, and the math box programs $32 and $36, which Star Wars'
;   microcode does not have, do the transform, the perspective and the depth cue of each point while the divider
;   supplies 1/depth. each point is stored as screen x (limited to -534..534), screen y (limited to -532..728) and
;   a flag byte with the top three bits of the cue, the intensity bits of a vector. pnt_next is left pointing past
;   the last point. returns at once if the object is not loaded
;------------------------------------------------------------------------------
obj_points:
KD92F:  PSHS A,X,Y,U

JOBJPNT:
OBJPNT_67D4:
KD931:  LDB  BJ_ID                  ;SAVE OBJECT IDENTIFICATION
KD933:  LDX  #TDRWNM
KD936:  LDA  B,X                    ;# OF POINTS
KD938:  STA  ,S
KD93A:  LDX  #BJBIC
KD93D:  LDA  B,X
KD93F:  BNE  JOBJPN_5
KD941:  JMP  KD9ED                  ;ESB: object not loaded, return (a SWI in Star Wars)

;SET TO M$BJBC IF FAIL
JOBJPN_5:
KD944:  LSLA                        ;ALWAYS IN PAIRS, SHIFT UP TO 9 BITS
KD945:  STA  M_BICL
KD948:  ROLA
KD949:  STA  M_BICH
KD94C:  LDX  #obj_buf_tab           ;address in BJ_PNT of this object's first point
KD94F:  LDB  BJ_ID
KD951:  ABX
KD952:  ABX
KD953:  LDY  ,X
KD956:  STY  >pnt_next              ;pnt_next is the next free point of the buffer here
KD95A:  LDX  #obj_cue_scale         ;depth cue scale of the object
KD95D:  ABX
KD95E:  ABX
KD95F:  LDX  ,X
KD961:  STX  M_YPS
KD964:  LDX  #obj_cue_depth         ;depth cue range of the object
KD967:  ABX
KD968:  ABX
KD969:  LDD  ,X
KD96B:  ADDD M_XT                   ;plus the distance of the object's centre: the depth where the cue is 0
KD96E:  STD  M_XPS
KD971:  LDA  #$32                   ;program $32: M_XP = depth of the first point, M_ZPS = (M_XPS - depth) * M_YPS
KD973:  JSR  MGOWT_B1
KD976:  LDX  M_XP
KD979:  STX  M_DVD                  ;start the divide for 1/depth
KD97C:  LDB  m_zps_lo               ;low byte of M_ZPS: the depth cue of the first point
KD97F:  LDX  M_PCGO                 ;the quotient, read at the address of M_PCGO
KD982:  STX  M_XP
KD985:  LDA  #$36                   ;program $36: x and y of this point with perspective, then depth and cue of the next point
KD987:  JSR  MGOWT_B1
KD98A:  ANDB #$E0                   ;the top three bits are the intensity bits of a vector
KD98C:  STB  4,Y                    ;flag byte of the first point
KD98E:  TST  DIAGSW                 ;wait while the math box runs (bit 7 of this port)
KD991:  BMI  KD98E
KD993:  LDU  M_XP                   ;depth of the next point
KD996:  STU  M_DVD                  ;start its divide
KD999:  LDX  M_YP                   ;screen x of this point
KD99C:  LDU  M_PCGO                 ;1/depth of the next point
KD99F:  STU  M_XP
KD9A2:  LDU  M_ZP                   ;screen y of this point
KD9A5:  LDB  m_zps_lo               ;depth cue of the next point
KD9A8:  STA  M_PCGO                 ;A is still $36: start the program for the next point
KD9AB:  ANDB #$E0
KD9AD:  STB  9,Y                    ;flag byte of the next point
KD9AF:  STX  ,Y
KD9B1:  BPL  KD9BD
KD9B3:  CMPX #$FDEA                 ;the operand is the number $FDEA, not an address: x is held to -534..534
KD9B6:  BGE  KD9C7
KD9B8:  LDX  #$FDEA
KD9BB:  BRA  KD9C5
KD9BD:  CMPX #$0216                 ;534
KD9C0:  BLE  KD9C7
KD9C2:  LDX  #$0216
KD9C5:  STX  ,Y
KD9C7:  STU  2,Y
KD9C9:  BPL  KD9D6
KD9CB:  CMPU #$FDEC                 ;the operand is the number $FDEC, not an address: y is held to -532..728
KD9CF:  BGE  KD9E1
KD9D1:  LDU  #$FDEC
KD9D4:  BRA  KD9DF
KD9D6:  CMPU #$02D8                 ;728
KD9DA:  BLE  KD9E1
KD9DC:  LDU  #$02D8
KD9DF:  STU  2,Y
KD9E1:  LDA  #$36                   ;program number for the next pass
KD9E3:  LEAY 5,Y
KD9E5:  DEC  ,S
KD9E7:  BGT  KD98E
KD9E9:  STY  >pnt_next              ;next free point of the buffer
KD9ED:  PULS A,X,Y,U,PC

;------------------------------------------------------------------------------
; pnt_buf_reset - starts a new point list: pnt_next, the next free point of the buffer, is set to BJ_PNT
;   ($4E00). called by pages 0 and 1 before they build the points of a walker leg
;------------------------------------------------------------------------------
pnt_buf_reset:
KD9EF:  LDD  #BJ_PNT
KD9F2:  STD  >pnt_next
KD9F5:  RTS

;------------------------------------------------------------------------------
; pnt_add_scratch - perspects the single point in the scratch block M_X0 (block index $0F) with MS_PAD, the
;   divider and MS_PERS, as Star Wars' JOBJPNT did for every point, stores its screen x and y at the buffer
;   position pnt_next and moves pnt_next on by 5. the flag byte is not written. pages 0 and 1 call it for every
;   joint point of a walker leg, which is then drawn as object 27 or 19
;------------------------------------------------------------------------------
pnt_add_scratch:
KD9F6:  PSHS X
KD9F8:  LDD  #$000F                 ;block index of the scratch point M_X0 (MS_X0BC)
KD9FB:  STD  M_BIC
KD9FE:  LDX  >pnt_next              ;next free point of the buffer

JOBJPN_10:
KDA01:  LDA  #MS_PAD
KDA03:  JSR  MGOWT_B1
KDA06:  LDD  M_XP                   ;X
KDA09:  STD  M_DVD
KDA0C:  ORCC #$00                   ;TOTAL OF 7.5 CYCLE DELAY BEFORE READ
KDA0E:  LDD  M_QUO                  ;GET 1/X, RECIPROCAL
KDA11:  STD  M_XP
KDA14:  LDA  #MS_PERS               ;1/X (*Y,*Z)
KDA16:  JSR  MGOWT_B1
KDA19:  LDD  M_YP
KDA1C:  STD  ,X
KDA1E:  LDD  M_ZP
KDA21:  STD  2,X
KDA23:  LEAX 5,X
KDA25:  STX  >pnt_next
KDA28:  PULS X,PC

;------------------------------------------------------------------------------
; obj_draw_b - draws object B from the points now in the buffer: stores B in BJ_ID and runs obj_draw. used to
;   draw with another object's lines than the one whose points were perspected
;------------------------------------------------------------------------------
obj_draw_b:
KDA2A:  STB  BJ_ID

;------------------------------------------------------------------------------
; obj_draw - draws object BJ_ID: stacks A, B, X and U and jumps to the object's draw routine from obj_draw_tab,
;   which unstacks them and returns to the caller. it replaces Star Wars' JOBJDRW, which interpreted a line list
;------------------------------------------------------------------------------
obj_draw:
KDA2C:  PSHS A,B,X,U
KDA2E:  LDX  #obj_draw_tab
KDA31:  LDB  BJ_ID
KDA33:  ASLB
KDA34:  LDX  B,X
KDA36:  JMP  ,X                     ;the draw routine returns for us with PULS A,B,X,U,PC

;------------------------------------------------------------------------------
; thr_start - unused code that the listing shows as data ($DA38-$DAB2): a threaded interpreter that draws the
;   same vectors as the generated draw routines from a list. entered with X at a 3-byte instruction (a JMP here,
;   where obj_draw's JMP ,X would have arrived) that is followed by 4-byte cells, each the address of a primitive
;   and an operand. it points U at BJ_CX as the last point, steps X over the 3 bytes and jumps through the first
;   cell. every primitive ends by stepping X to the next cell and jumping through it. no word in either bank, the
;   slapstic pages or the vector ROM holds the address of any of the six entries, so nothing runs it
;------------------------------------------------------------------------------
thr_start:
KDA38:  LDU  #BJ_CX
KDA3B:  LEAX 3,X
KDA3D:  JMP  [,X]

;------------------------------------------------------------------------------
; thr_move - threaded primitive (unused): the operand is the address of a buffer point. writes a blank vector
;   from the last point at U to it (y difference, then x difference, both masked to 13 bits), makes it the last
;   point and goes to the next cell. it keeps the list pointer in the two stack bytes that hold obj_draw's saved A
;   and B
;------------------------------------------------------------------------------
thr_move:
KDA3F:  STX  ,S
KDA41:  LDX  2,X
KDA43:  LDD  2,X
KDA45:  SUBD 2,U
KDA47:  ANDA #$1F
KDA49:  STD  ,Y
KDA4B:  LDD  ,X
KDA4D:  SUBD ,U
KDA4F:  ANDA #$1F
KDA51:  STD  2,Y
KDA53:  LEAY 4,Y
KDA55:  LEAU ,X
KDA57:  LDX  ,S
KDA59:  LEAX 4,X
KDA5B:  JMP  [,X]

;------------------------------------------------------------------------------
; thr_draw - threaded primitive (unused): as thr_move, but the vector is drawn at full brightness (ORA #$E0)
;------------------------------------------------------------------------------
thr_draw:
KDA5D:  STX  ,S
KDA5F:  LDX  2,X
KDA61:  LDD  2,X
KDA63:  SUBD 2,U
KDA65:  ANDA #$1F
KDA67:  STD  ,Y
KDA69:  LDD  ,X
KDA6B:  SUBD ,U
KDA6D:  ORA  #$E0
KDA6F:  STD  2,Y
KDA71:  LEAY 4,Y
KDA73:  LEAU ,X
KDA75:  LDX  ,S
KDA77:  LEAX 4,X
KDA79:  JMP  [,X]

;------------------------------------------------------------------------------
; thr_draw_cued - threaded primitive (unused): as thr_move, but the vector's intensity bits are the sum of the
;   flag bytes of the new point and of the last point, the depth cue that obj_points leaves
;------------------------------------------------------------------------------
thr_draw_cued:
KDA7B:  STX  ,S
KDA7D:  LDX  2,X
KDA7F:  LDD  2,X
KDA81:  SUBD 2,U
KDA83:  ANDA #$1F
KDA85:  STD  ,Y
KDA87:  LDD  ,X
KDA89:  SUBD ,U
KDA8B:  ANDA #$1F
KDA8D:  ORA  4,X
KDA8F:  ADDA 4,U
KDA91:  STD  2,Y
KDA93:  LEAY 4,Y
KDA95:  LEAU ,X
KDA97:  LDX  ,S
KDA99:  LEAX 4,X
KDA9B:  JMP  [,X]

;------------------------------------------------------------------------------
; thr_word - threaded primitive (unused): writes the operand word to the display list as it is, a colour
;   instruction for example, and goes to the next cell
;------------------------------------------------------------------------------
thr_word:
KDA9D:  LDD  2,X
KDA9F:  STD  ,Y++
KDAA1:  LEAX 4,X
KDAA3:  JMP  [,X]

;------------------------------------------------------------------------------
; thr_end - threaded primitive (unused), the end of a list: copies the last point at U to BJ_CX and BJ_CY and
;   its flag byte to $48BE, then unstacks A, B, X, U and returns as the generated draw routines do
;------------------------------------------------------------------------------
thr_end:
KDAA5:  LDD  ,U
KDAA7:  STD  BJ_CX
KDAA9:  LDD  2,U
KDAAB:  STD  BJ_CY
KDAAD:  LDA  4,U
KDAAF:  STA  $48BE
KDAB1:  PULS A,B,X,U,PC
KDAB3:  .byte $10, $6E, $39, $3C, $00

fuller_credit:
KDAB8:  .byte $46, $55, $4C, $4C, $45, $52, $20, $44 ;text FULLER DID THE EFFECTS, not referenced by any code. the five bytes before it ($DAB3: 10 6E 39 3C 00) follow the unused threaded primitives and are not referenced either
KDAC0:  .byte $49, $44, $20, $54, $48, $45, $20, $45
KDAC8:  .byte $46, $46, $45, $43, $54, $53
KDACE:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;ROM fill, 909 bytes of $FF
KDADE:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDAEE:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDAFE:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDB0E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDB1E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDB2E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDB3E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDB4E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDB5E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDB6E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDB7E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDB8E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDB9E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDBAE:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDBBE:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDBCE:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDBDE:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDBEE:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDBFE:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDC0E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDC1E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDC2E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDC3E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDC4E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDC5E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDC6E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDC7E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDC8E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDC9E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDCAE:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDCBE:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDCCE:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDCDE:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDCEE:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDCFE:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDD0E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDD1E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDD2E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDD3E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDD4E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDD5E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDD6E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDD7E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDD8E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDD9E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDDAE:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDDBE:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDDCE:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDDDE:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDDEE:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDDFE:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDE0E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDE1E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDE2E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDE3E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDE4E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF

FILL0_B1_3:
KDE5B:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;.REPT 73  FILL WITH FF'S
KDE63:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDE6B:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDE73:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDE7B:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDE83:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDE8B:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDE93:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDE9B:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDEA3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDEAB:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDEB3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDEBB:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDEC3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KDECB:  .byte $FF, $FF, $FF

CPYRT0_B1_3:
KDECE:  .byte $43, $4F, $50, $59, $52, $49, $47, $48 ;the text here is COPYRIGHT 1984 ATARI
KDED6:  .byte $54, $20, $31, $39, $38, $34, $20, $41
KDEDE:  .byte $54, $41, $52, $49

;------------------------------------------------------------------------------
; hs_view - Star Wars' VWHSCR, changed: draws the high score table. with UPDFLG plus (initials being entered) it
;   shows message $32 in the middle of the screen, rows from the half-screen table hs_ypos_half and, after the
;   rows, the alphabet with RUB and END and the cursor. otherwise message $33 at the top, a larger scale and the
;   full-screen rows THSY2. both messages have the legend JEDI KNIGHT, next to which the mark at vector ROM $326A
;   is drawn. ten of the 25 entries are shown, from entry hs_scroll (held to 0-15): each row is the three initials
;   (the one being entered flashes), the mark again if bit 7 of the first initial is set, the rank number and the
;   8 digit score. when no initials are being entered the yoke scrolls the table: cursor y beyond +-$140 steps
;   hs_scroll by one every third frame
;------------------------------------------------------------------------------
hs_view:
KDEE2:  PSHS A,B,X,U
KDEE4:  TST  UPDFLG
KDEE7:  BMI  KDF11
KDEE9:  LDB  #$32                   ;message $32: REBEL FORCE ROSTER in the middle of the screen and the legend JEDI KNIGHT
KDEEB:  JSR  K6030
KDEEE:  LDD  #$1E00                 ;blank vector to y -512, x -168, left of the legend
KDEF1:  STD  ,Y++
KDEF3:  LDD  #$1F58
KDEF6:  STD  ,Y++
KDEF8:  LDD  #$6180
KDEFB:  STD  ,Y++
KDEFD:  LDD  #$B935                 ;JSRL to vector ROM $326A, the Jedi mark
KDF00:  STD  ,Y++
KDF02:  LDD  #VGCNTR
KDF05:  STD  ,Y++
KDF07:  LDD  #VGSCAL
KDF0A:  STD  ,Y++
KDF0C:  LDD  #hs_ypos_half          ;the operand is the address of hs_ypos_half ($E1E1), the row positions for the half screen (Star Wars' THSY1)
KDF0F:  BRA  KDF37
KDF11:  LDB  #$33                   ;message $33: the same two lines for the full-screen table
KDF13:  JSR  K6030
KDF16:  LDD  #$1E80                 ;blank vector to y -384, x -168, left of the legend
KDF19:  STD  ,Y++
KDF1B:  LDD  #$1F58
KDF1E:  STD  ,Y++
KDF20:  LDD  #$6180
KDF23:  STD  ,Y++
KDF25:  LDD  #$B935                 ;the Jedi mark
KDF28:  STD  ,Y++
KDF2A:  LDD  #$8040
KDF2D:  STD  ,Y++
KDF2F:  LDD  #VGSCAL-$100+$40       ;MAKE LIST LARGER,BUT NOT TOO LARGE
KDF32:  STD  ,Y++
KDF34:  LDD  #THSY2                 ;TABLE OF HI SCORE Y POSITIONS FOR WHOLE SCREEN
KDF37:  STD  HSYPOS
KDF3A:  LDA  hs_scroll              ;first entry to show, held to 0-15
KDF3D:  BPL  KDF40
KDF3F:  CLRA
KDF40:  CMPA #$0F
KDF42:  BCS  KDF46
KDF44:  LDA  #$0F
KDF46:  STA  hs_scroll
KDF49:  STA  HSCNT
KDF4C:  ADDA #$0A                   ;ten rows
KDF4E:  STA  hs_row_end
KDF51:  LDU  HSYPOS                 ;DO THE INITIALS FIRST
KDF54:  LDD  ,U                     ;GET Y POS
KDF56:  STD  ,Y++
KDF58:  LDD  #$1F80                 ;X POS
KDF5B:  STD  ,Y++
KDF5D:  LDB  HSCNT
KDF60:  LDA  #$07                   ;7 bytes per entry: 3 initials, 4 score bytes
KDF62:  MUL
KDF63:  LDX  #INITLS
KDF66:  ABX                         ;POINT TO THIS SET OF INITIALS
KDF67:  CMPX UPDFLG                 ;PLAYER'S INITIALS? ( ONLY FOR ENTERING INITIALS )
KDF6A:  BNE  KDF71                  ;IFEQ  YES
KDF6C:  LDD  #VGCOLR+(VGCWHT*$100)  ;MAKE THEM STAND OUT
KDF6F:  BRA  KDF74                  ;ELSE
KDF71:  LDD  PH_COL                 ;COLOR DEPENDING ON THE PHASE
KDF74:  STD  ,Y++
KDF76:  STD  TMPCOL                 ;USED FOR FLASHING INITIAL IN ENTERING STATE
KDF78:  LDU  #VGMSGA+$14            ;POINTS TO LETTER "A"
;1ST INITIAL
KDF7B:  TST  UPDFLG                 ;ENTERING INITIALS?
KDF7E:  BMI  KDF9B                  ;IFPL  YES, HAVE TO FLASH CURRENT INITIAL
KDF80:  LDA  UPDINT
KDF83:  CMPA #$00                   ;THIS INITIAL??
KDF85:  BNE  KDF97                  ;IFEQ  YES, THEN MAKE IT FLASH
KDF87:  LDA  >FRAME+1               ;LSD OF FRAME
KDF8A:  ANDA #$01                   ;ON OR OFF
KDF8C:  BNE  KDF93                  ;IFEQ  OFF THIS FRAME
KDF8E:  LDD  PH_COL                 ;USE NORMAL COLOR FOR OFF
KDF91:  BRA  KDF95                  ;ELSE  ON AS PER THIS LINES COLOR
KDF93:  LDD  TMPCOL                 ;WILL BE WHITE IF CURRENT INITIAL BEING ENTERED
KDF95:  BRA  KDF99                  ;ELSE  NOT THIS INITIAL, MAKE SURE IT IS THIS LINES COLOR
KDF97:  LDD  TMPCOL
KDF99:  STD  ,Y++
KDF9B:  LDA  ,X+
KDF9D:  ANDA #$7F                   ;bit 7 of the first initial is the Jedi mark
KDF9F:  BNE  KDFB0                  ;IFEQ  BLANK
KDFA1:  TST  UPDFLG
KDFA4:  BMI  KDFAB                  ;IFPL  ENTERING INITIALS, SHOW UNDERLINE INSTEAD OF BLANK
KDFA6:  LDD  L306C
KDFA9:  BRA  KDFAE                  ;ELSE  NOT ENTERING INITIALS, SHOW A BLANK
KDFAB:  LDD  VGMSGA
KDFAE:  BRA  KDFB3                  ;ELSE  THEN A-Z
KDFB0:  ASLA                        ;WORD TABLE
KDFB1:  LDD  A,U                    ;JSRL TO LETTER
KDFB3:  STD  ,Y++
;2ND INITIAL
KDFB5:  TST  UPDFLG                 ;ENTERING INITIALS?
KDFB8:  BMI  KDFD5                  ;IFPL  YES, HAVE TO FLASH CURRENT INITIAL
KDFBA:  LDA  UPDINT
KDFBD:  CMPA #$01                   ;THIS INITIAL??
KDFBF:  BNE  KDFD1                  ;IFEQ  YES, THEN MAKE IT FLASH
KDFC1:  LDA  >FRAME+1               ;LSD OF FRAME
KDFC4:  ANDA #$01                   ;ON OR OFF
KDFC6:  BNE  KDFCD                  ;IFEQ  OFF THIS FRAME
KDFC8:  LDD  PH_COL                 ;USE NORMAL COLOR FOR OFF
KDFCB:  BRA  KDFCF                  ;ELSE  ON AS PER THIS LINES COLOR
KDFCD:  LDD  TMPCOL                 ;WILL BE WHITE IF CURRENT INITIAL BEING ENTERED
KDFCF:  BRA  KDFD3                  ;ELSE  NOT THIS INITIAL, MAKE SURE IT IS THIS LINES COLOR
KDFD1:  LDD  TMPCOL
KDFD3:  STD  ,Y++
KDFD5:  LDA  ,X+
KDFD7:  BNE  KDFE8                  ;IFEQ  BLANK
KDFD9:  TST  UPDFLG
KDFDC:  BMI  KDFE3                  ;IFPL  ENTERING INITIALS, SHOW UNDERLINE INSTEAD OF BLANK
KDFDE:  LDD  L306C
KDFE1:  BRA  KDFE6                  ;ELSE  NOT ENTERING INITIALS, SHOW A BLANK
KDFE3:  LDD  VGMSGA
KDFE6:  BRA  KDFEB                  ;ELSE  THEN A-Z
KDFE8:  ASLA                        ;WORD TABLE
KDFE9:  LDD  A,U                    ;JSRL TO LETTER
KDFEB:  STD  ,Y++
;3RD INITIAL
KDFED:  TST  UPDFLG                 ;ENTERING INITIALS?
KDFF0:  BMI  KE00D                  ;IFPL  YES, HAVE TO FLASH CURRENT INITIAL
KDFF2:  LDA  UPDINT
KDFF5:  CMPA #$02                   ;THIS INITIAL??
KDFF7:  BNE  KE009                  ;IFEQ  YES, THEN MAKE IT FLASH
KDFF9:  LDA  >FRAME+1               ;LSD OF FRAME
KDFFC:  ANDA #$01                   ;ON OR OFF
KDFFE:  BNE  KE005                  ;IFEQ  OFF THIS FRAME
KE000:  LDD  PH_COL                 ;USE NORMAL COLOR FOR OFF
KE003:  BRA  KE007                  ;ELSE  ON AS PER THIS LINES COLOR
KE005:  LDD  TMPCOL                 ;WILL BE WHITE IF CURRENT INITIAL BEING ENTERED
KE007:  BRA  KE00B                  ;ELSE  NOT THIS INITIAL, MAKE SURE IT IS THIS LINES COLOR
KE009:  LDD  TMPCOL
KE00B:  STD  ,Y++
KE00D:  LDA  ,X+
KE00F:  BNE  KE020                  ;IFEQ  BLANK
KE011:  TST  UPDFLG
KE014:  BMI  KE01B                  ;IFPL  ENTERING INITIALS, SHOW UNDERLINE INSTEAD OF BLANK
KE016:  LDD  L306C
KE019:  BRA  KE01E                  ;ELSE  NOT ENTERING INITIALS, SHOW A BLANK
KE01B:  LDD  VGMSGA
KE01E:  BRA  KE023                  ;ELSE  THEN A-Z
KE020:  ASLA                        ;WORD TABLE
KE021:  LDD  A,U                    ;JSRL TO LETTER
KE023:  STD  ,Y++
KE025:  LDD  TMPCOL                 ;RESTORE COLOR TO THIS LINE'S COLOR
KE027:  STD  ,Y++
KE029:  LDD  #VGCNTR
KE02C:  STD  ,Y++
KE02E:  LDA  -3,X                   ;first initial of this entry: bit 7 set = made by a Jedi knight
KE030:  BPL  KE04C
KE032:  LDU  HSYPOS
KE035:  LDD  ,U
KE037:  STD  ,Y++
KE039:  LDD  #$1F1A                 ;x -230, left of the initials
KE03C:  STD  ,Y++
KE03E:  LDD  #$B935                 ;the Jedi mark
KE041:  STD  ,Y++
KE043:  LDD  #$8040
KE046:  STD  ,Y++
KE048:  LDD  scratch_1              ;TMPCOL: back to the row's colour
KE04A:  STD  ,Y++
;NOW THE NUMBER
KE04C:  LDU  HSYPOS
KE04F:  LDD  ,U                     ;Y POS
KE051:  STD  ,Y++
KE053:  LDD  #$1F38                 ;X POS
KE056:  STD  ,Y++
KE058:  LDA  HSCNT                  ;rank number = entry index + 1
KE05B:  INCA
KE05C:  LDX  #$0008
KE05F:  JSR  BINBCD
KE062:  LDA  bcd_lo
KE065:  LDB  #$01                   ;SUPPRESS THIS MANY ZEROS
KE067:  STB  BT_SUP
KE069:  JSR  K607E                  ;THE NUMBER
KE06C:  LDD  #$B8E5                 ;PERIOD
KE06F:  STD  ,Y++
KE071:  LDD  #VGCNTR
KE074:  STD  ,Y++
KE076:  LDU  HSYPOS
KE079:  LDD  ,U++                   ;Y POS
KE07B:  STD  ,Y++
KE07D:  LDD  #$1FF0                 ;X POS
KE080:  STD  ,Y++
KE082:  STU  HSYPOS
KE085:  LDB  #$06                   ;SUPPRESS THIS MANY LEADING ZEROS
KE087:  STB  BT_SUP
KE089:  LDB  HSCNT
KE08C:  LDA  #$07
KE08E:  MUL
KE08F:  ADDD #hs_top                ;hs_top, the score field of the first entry
KE092:  TFR  D,U
KE094:  JSR  K606C
KE097:  LDD  #VGCNTR
KE09A:  STD  ,Y++
KE09C:  INC  HSCNT
KE09F:  LDA  HSCNT
KE0A2:  CMPA hs_row_end             ;until ten rows are done
KE0A5:  LBLO KDF51                  ;HSEND
KE0A9:  LDD  #VGSCAL                ;RESTORE SCALE TO NORMAL
KE0AC:  STD  ,Y++
KE0AE:  LDD  UPDFLG                 ;ENTERING INITIALS?
KE0B1:  BPL  KE0E7                  ;IFMI  NOPE, THEN LEAVE
KE0B3:  LDA  hs_scr_delay           ;not entering initials: delay between scroll steps
KE0B6:  BMI  KE0C4
KE0B8:  DECA
KE0B9:  CMPA #$05
KE0BB:  BLE  KE0BF
KE0BD:  LDA  #$05
KE0BF:  STA  hs_scr_delay
KE0C2:  BRA  KE0E5
KE0C4:  LDD  >SI_CY                 ;yoke pushed past $140: scroll towards the top of the table
KE0C7:  CMPD #$0140
KE0CB:  BLE  KE0D7
KE0CD:  DEC  hs_scroll
KE0D0:  LDA  #$01
KE0D2:  STA  hs_scr_delay
KE0D5:  BRA  KE0E5
KE0D7:  CMPD #$FEC0                 ;pulled past -$140: scroll towards the end
KE0DB:  BGE  KE0E5
KE0DD:  INC  hs_scroll
KE0E0:  LDA  #$01
KE0E2:  STA  hs_scr_delay
KE0E5:  PULS A,B,X,U,PC
KE0E7:  LDD  #VGCOLR+(VGCRED*$100)
KE0EA:  STD  ,Y++
KE0EC:  LDX  #TINTXY+4              ;TABLE OF XY POSITIONS FOR ALPHABET
KE0EF:  LDU  #VGMSGA+22             ;START WITH "A"
KE0F2:  LDD  2,X                    ;Y POS
KE0F4:  ANDA #$1F
KE0F6:  STD  ,Y++
KE0F8:  LDD  ,X                     ;X POS
KE0FA:  ANDA #$1F
KE0FC:  STD  ,Y++
KE0FE:  LDD  ,U++                   ;JSRL TO LETTER
KE100:  STD  ,Y++
KE102:  LDD  #VGCNTR
KE105:  STD  ,Y++
KE107:  LEAX 4,X
KE109:  CMPX #TINTXY+(27*4)         ;STOP AFTER "Z"
KE10C:  BLO  KE0F2                  ;HSEND
;THE UNDERLINE
KE10E:  LDD  TINTXY+2               ;Y POS
KE111:  ANDA #$1F
KE113:  STD  ,Y++
KE115:  LDD  TINTXY+0               ;X POS
KE118:  ANDA #$1F
KE11A:  STD  ,Y++
KE11C:  LDD  L306C                  ;"_" OR UNDERLINE
KE11F:  STD  ,Y++
KE121:  LDD  #VGCNTR
KE124:  STD  ,Y++
;NEXT COMES "RUB"
KE126:  LDB  INITL
KE129:  CMPB #$1B                   ;"RUB"???
KE12B:  BNE  KE132                  ;IFEQ  YES, THEN HIGHLIGHT IT
KE12D:  LDD  #VGCOLR+(VGCWHT*$100)-$30
KE130:  BRA  KE135                  ;ELSE  NORMAL COLOR
KE132:  LDD  #VGCOLR+(VGCRED*$100)-$30
KE135:  STD  ,Y++
KE137:  LDD  2,X
KE139:  ANDA #$1F
KE13B:  STD  ,Y++
KE13D:  LDD  ,X
KE13F:  SUBD #$0008
KE142:  ANDA #$1F
KE144:  STD  ,Y++
KE146:  LDD  #VGSCAL-$40            ;MAKE LETTERS SMALLER
KE149:  STD  ,Y++
KE14B:  LDD  VGMSGA+56              ;"R"
KE14E:  STD  ,Y++
KE150:  LDD  VGMSGA+62              ;"U"
KE153:  STD  ,Y++
KE155:  LDD  VGMSGA+24              ;"B"
KE158:  STD  ,Y++
KE15A:  LDD  #VGSCAL                ;RESTORE NORMAL SCALE
KE15D:  STD  ,Y++
KE15F:  LDD  #VGCNTR
KE162:  STD  ,Y++
;NOW THE WORD "END"
KE164:  LDB  INITL
KE167:  CMPB #$1C                   ;"END"???
KE169:  BNE  KE170                  ;IFEQ  YES, THEN HIGHLIGHT IT
KE16B:  LDD  #VGCOLR+(VGCWHT*$100)-$30
KE16E:  BRA  KE173                  ;ELSE  NORMAL COLOR
KE170:  LDD  #VGCOLR+(VGCRED*$100)-$30
KE173:  STD  ,Y++
KE175:  LDD  6,X
KE177:  ANDA #$1F
KE179:  STD  ,Y++
KE17B:  LDD  4,X
KE17D:  SUBD #$0008
KE180:  ANDA #$1F
KE182:  STD  ,Y++
KE184:  LDD  #VGSCAL-$40            ;MAKE LETTERS SMALLER
KE187:  STD  ,Y++
KE189:  LDD  VGMSGA+30              ;"E"
KE18C:  STD  ,Y++
KE18E:  LDD  VGMSGA+48              ;"N"
KE191:  STD  ,Y++
KE193:  LDD  VGMSGA+28              ;"D"
KE196:  STD  ,Y++
KE198:  LDD  #VGSCAL                ;RESTORE NORMAL SCALE
KE19B:  STD  ,Y++
KE19D:  LDD  #VGCNTR
KE1A0:  STD  ,Y++
;HILITE SELECTED LETTER
KE1A2:  LDD  #VGCOLR+(VGCWHT*$100)
KE1A5:  STD  ,Y++
KE1A7:  LDB  INITL                  ;CURRENT LETTER
KE1AA:  CMPB #$1B                   ;NORMAL ALPHAS
KE1AC:  BHS  KE1D7                  ;IFLO  YES, THEN HIGHLIGHT ( END, RUB DONE ELSEWHERE )
KE1AE:  ASLB
KE1AF:  ASLB
KE1B0:  LDX  #TINTXY
KE1B3:  ABX                         ;POINTS TO POSITION
KE1B4:  LDD  2,X                    ;Y POS
KE1B6:  ANDA #$1F
KE1B8:  STD  ,Y++
KE1BA:  LDD  ,X                     ;X POS
KE1BC:  ANDA #$1F
KE1BE:  STD  ,Y++
KE1C0:  LDB  INITL
KE1C3:  BNE  KE1CA                  ;IFEQ  BLANK?? USE UNDERLINE INSTEAD
KE1C5:  LDD  L306C
KE1C8:  BRA  KE1D0                  ;ELSE
KE1CA:  ASLB
KE1CB:  LDX  #VGMSGA+20             ;"A"
KE1CE:  LDD  B,X
KE1D0:  STD  ,Y++
KE1D2:  LDD  #VGCNTR
KE1D5:  STD  ,Y++
KE1D7:  LDD  #VGCOLR+(VGCYLW*$100)  ;YELLOW FOR THE SITE
KE1DA:  STD  ,Y++
KE1DC:  JSR  K609C                  ;DISPLAY THE CURSOR
KE1DF:  PULS A,B,X,U,PC

hs_ypos_half:
KE1E1:  .word $1FB2, $1F8E, $1F6A, $1F46
KE1E9:  .word $1F22, $1EFE, $1EDA
KE1EF:  .word $1EB6
KE1F1:  .word $1E92                 ;.POS -366.,-402.
KE1F3:  .word $1E6E

THSY2:          ;WHOLE SCREEN
KE1F5:  .word $008C                 ;.POS 140.,100.,60.,20.
KE1F7:  .word $0064
KE1F9:  .word $003C
KE1FB:  .word $0014
KE1FD:  .word $1FEC                 ;.POS -20.,-60.,-100.,-140.
KE1FF:  .word $1FC4
KE201:  .word $1F9C
KE203:  .word $1F74
KE205:  .word $1F4C                 ;.POS -180.,-220.
KE207:  .word $1F24

;------------------------------------------------------------------------------
; hs_rank_step - called once a frame from bank 0 (L6303) through L60FC: when the player's score has reached the
;   score of table entry rank_index (higher top word, or equal top word and the low word not below), rank_index is
;   stepped down to the next better entry. does nothing once rank_index is minus
;------------------------------------------------------------------------------
hs_rank_step:
KE209:  PSHS A,B,X
KE20B:  LDA  rank_index
KE20E:  BMI  KE22B                  ;minus: the score is already the best
KE210:  LDX  #INITLS
KE213:  LDB  #$07
KE215:  MUL
KE216:  LEAX D,X
KE218:  LDD  S_SC87
KE21A:  CMPD 3,X
KE21D:  BHI  KE228
KE21F:  BNE  KE22B
KE221:  LDD  S_SC43
KE223:  CMPD 5,X
KE226:  BCS  KE22B
KE228:  DEC  rank_index
KE22B:  PULS A,B,X,PC

;------------------------------------------------------------------------------
; hs_insert - Star Wars' UPDATE and PUTHI in one, for the 25 entry table of 7 byte records (3 initials, 4 BCD
;   score bytes) at INITLS: finds the first entry the score S_SC87, S_SC43 is not below, moves the entries from
;   there down by one (the last drops out), and writes the new one with the score and the initials in last_inits.
;   UPDFLG = the entry's address, UPDINT = 0 and INITL = its first initial, or UPDFLG = $FFFF if the score is
;   below all 25. hs_scroll is left at the entry's index less 5 so that the display shows it
;------------------------------------------------------------------------------
hs_insert:
KE22D:  LDA  #$FA                   ;-6: counts up to the entry's index less 5 in the search below
KE22F:  STA  hs_scroll
KE232:  LDX  #INITLS
KE235:  INC  hs_scroll
KE238:  LDD  S_SC87
KE23A:  SUBD 3,X
KE23C:  BHI  KE255
KE23E:  BNE  KE246
KE240:  LDD  S_SC43
KE242:  SUBD 5,X
KE244:  BCC  KE255
KE246:  LEAX <7,X
KE249:  CMPX #INITLS+175            ;the operand is the end of the 25 entry table, $4BEE
KE24C:  BCS  KE235
KE24E:  LDD  #$FFFF
KE251:  STD  UPDFLG
KE254:  RTS
KE255:  STX  UPDFLG
KE258:  LDX  #INITLS+(24*7)         ;the last entry, INITLS + 24*7
KE25B:  CMPX UPDFLG
KE25E:  BEQ  KE27B
KE260:  LDD  <-7,X
KE263:  STD  ,X
KE265:  LDD  <-5,X
KE268:  STD  2,X
KE26A:  LDD  <-3,X
KE26D:  STD  4,X
KE26F:  LDA  <-1,X
KE272:  STA  6,X
KE274:  LEAX -7,X
KE276:  CMPX UPDFLG
KE279:  BHI  KE260
KE27B:  LDA  last_inits             ;the initials of the last entry made are the first offer
KE27E:  STA  ,X
KE280:  STA  INITL
KE283:  LDA  last_inits+1
KE286:  STA  1,X
KE288:  LDA  last_inits+2
KE28B:  STA  2,X
KE28D:  LDD  S_SC87
KE28F:  STD  3,X
KE291:  LDD  S_SC43
KE293:  STD  5,X
KE295:  LDA  #$00
KE297:  STA  UPDINT
KE29A:  RTS

;------------------------------------------------------------------------------
; GETINT - GETINT
;   in ESB: the fire or thumb switch edge picks a letter. RUB and a letter send sound commands $3B and $3F.
;   END copies the entry's initials to last_inits, saves the top ten to the NVRAM image (hs_save), sends sound
;   $38 and sets UPDFLG to $FFFF. after a letter the next initial offered is the one already in the entry. the
;   routine ends in jedi_mark_set, which sets bit 7 of the first initial when jedi_done is set
;------------------------------------------------------------------------------
GETINT:
KE29B:  LDX  UPDFLG                 ;INDEX INTO TABLE
KE29E:  LDB  UPDINT                 ;WHICH INITIAL ARE WE GETTING
KE2A1:  ABX
KE2A2:  LEAU ,X
KE2A4:  LDA  UPDINT
KE2A7:  CMPA #$03                   ;DONE WITH APLHA'S ??
KE2A9:  BLO  KE2B0                  ;IFHS  YES, THEN ONLY CHECK FOR RUB OR END
KE2AB:  LDX  #TINTXY+(4*27)
KE2AE:  BRA  KE2B3                  ;ELSE  CHECK FOR ALL CHARACTERS
KE2B0:  LDX  #TINTXY                ;TABLE OF POSITIONS FOR INITIALS ( CENTER OF LETTER )
KE2B3:  LDD  >SI_CX                 ;CHECK X POS OF CURSOR
KE2B6:  SUBD #$0008
KE2B9:  SUBD ,X
KE2BB:  TSTA                        ;ABSD
KE2BC:  BPL  KE2C2
KE2BE:  COMA
KE2BF:  NEGB
KE2C0:  SBCA #$FF
KE2C2:  STD  TMPABS
KE2C4:  CMPD #$0018
KE2C8:  BHS  KE2F1                  ;IFLO  WITHIN X LIMIT
KE2CA:  LDD  >SI_CY                 ;CHECK Y POS
KE2CD:  ADDD #VGOFFY-12             ;ADD IN SCREEN OFFSET
KE2D0:  SUBD 2,X
KE2D2:  TSTA                        ;ABSD
KE2D3:  BPL  KE2D9
KE2D5:  COMA
KE2D6:  NEGB
KE2D7:  SBCA #$FF
KE2D9:  CMPD #$0018
KE2DD:  BHS  KE2F1                  ;IFLO  ALSO WITHIN Y LIMIT
KE2DF:  ADDD TMPABS                 ;OCTAGON CHECK
KE2E1:  CMPD #$0020
KE2E5:  BHS  KE2F1                  ;IFLO  HIT
KE2E7:  TFR  X,D                    ;MAKE INDEXED NUMBER USEFUL
KE2E9:  SUBD #TINTXY
KE2EC:  LSRB                        ;/4
KE2ED:  LSRB
KE2EE:  STB  INITL                  ;CURRENT VALUE OF INITIAL
KE2F1:  LEAX 4,X                    ;NEXT TABLE ENTRY
KE2F3:  CMPX #TINTXY+116            ;DONE?
KE2F6:  BLO  KE2B3                  ;HSEND
KE2F8:  LDA  INITL                  ;PUT IT IN TABLE
KE2FB:  CMPA #$1B                   ;NORMAL ALPHA?
KE2FD:  BHS  KE301                  ;IFLO  YES, THEN INSERT IT INTO TABLE
KE2FF:  STA  ,U
KE301:  LDA  GN_SWE                 ;FALLING EDGE OF FIRE BUTTON ( SEE IFRAME IN MAIN )
KE303:  ANDA #FIREBT|THMBT
KE305:  BEQ  jedi_mark_set          ;IFNE  TRANSITION FROM OFF TO ON
KE307:  LDA  INITL
KE30A:  CMPA #$1B                   ;"RUB"?
KE30C:  BNE  KE32A                  ;IFEQ  BACK UP ONE INITIAL
KE30E:  LDA  UPDINT
KE311:  CMPA #$02                   ;ON AN INITIAL?
KE313:  BHI  KE319                  ;IFLS  YES, RUB IT OUT
KE315:  LDA  #$00                   ;MAKE IT A BLANK ( UNDERLINE IN THIS MODE )
KE317:  STA  ,U
KE319:  LDA  UPDINT                 ;MOVE POINTER BACK ONE
KE31C:  BEQ  KE325                  ;IFNE  DON'T WRAP
KE31E:  DEC  UPDINT
KE321:  LDA  #$00                   ;BLANK FOR THE INITIAL WE JUST MOVED BACK TO
KE323:  STA  ,-U
KE325:  JSR  aud_cmd_3b_b1
KE328:  BRA  jedi_mark_set
KE32A:  CMPA #$1C
KE32C:  BNE  KE34B
KE32E:  LDX  UPDFLG                 ;END: keep the initials for the next entry
KE331:  LDA  ,X
KE333:  ANDA #$7F                   ;without the Jedi mark
KE335:  STA  last_inits
KE338:  LDD  1,X
KE33A:  STD  last_inits+1
KE33D:  JSR  hs_save                ;top ten to the NVRAM image
KE340:  JSR  aud_cmd_38_b1
KE343:  LDD  #$FFFF                 ;no entry in progress any more
KE346:  STD  UPDFLG
KE349:  BRA  jedi_mark_set
KE34B:  BSR  jedi_mark_set
KE34D:  INC  UPDINT                 ;NEXT INITIAL
KE350:  LDA  UPDINT
KE353:  CMPA #$03                   ;ALL INITIALS SELECTED?
KE355:  BLO  KE35B                  ;IFHS  YES
KE357:  LDA  #$1C                   ;INITL TO "END"
KE359:  BRA  KE35D
KE35B:  LDA  1,U                    ;the initial already in the next place is the first offer
KE35D:  STA  INITL
KE360:  JSR  aud_cmd_3f_b1

;------------------------------------------------------------------------------
; jedi_mark_set - tail of GETINT, also called before it moves to the next initial: if jedi_done is set and the
;   first initial is the current one (UPDINT = 0), sets bit 7 of the initial at U. the display shows the Jedi mark
;   beside entries whose first initial has that bit
;------------------------------------------------------------------------------
jedi_mark_set:
KE363:  LDB  jedi_done
KE366:  BEQ  KE373
KE368:  LDB  UPDINT
KE36B:  BNE  KE373
KE36D:  LDA  ,U
KE36F:  ORA  #$80
KE371:  STA  ,U
KE373:  RTS

TINTXY:          ;TABLE OF XY POSITIONS FOR INITIALS
KE374:  .word $011C, $FF44          ;UNDERLINE
KE378:  .word $FEDC, $FFA4          ;A
KE37C:  .word $FEDC, $FF74          ;B
KE380:  .word $FEDC, $FF44          ;C
KE384:  .word $FEDC, $FF14          ;D
KE388:  .word $FEDC, $FEE4          ;E
KE38C:  .word $FEDC, $FEB4          ;F
KE390:  .word $FEDC, $FE84          ;G
KE394:  .word $FEDC, $FE54          ;H
KE398:  .word $FEDC, $FE24          ;I
KE39C:  .word $FF0C, $FE24          ;J
KE3A0:  .word $FF3C, $FE24          ;K
KE3A4:  .word $FF6C, $FE24          ;L
KE3A8:  .word $FF9C, $FE24          ;M
KE3AC:  .word $FFCC, $FE24          ;N
KE3B0:  .word $FFFC, $FE24          ;O
KE3B4:  .word $002C, $FE24          ;P
KE3B8:  .word $005C, $FE24          ;Q
KE3BC:  .word $008C, $FE24          ;R
KE3C0:  .word $00BC, $FE24          ;S
KE3C4:  .word $00EC, $FE24          ;T
KE3C8:  .word $011C, $FE24          ;U
KE3CC:  .word $011C, $FE54          ;V
KE3D0:  .word $011C, $FE84          ;W
KE3D4:  .word $011C, $FEB4          ;X
KE3D8:  .word $011C, $FEE4          ;Y
KE3DC:  .word $011C, $FF14          ;Z
KE3E0:  .word $011C, $FF74          ;RUB
KE3E4:  .word $011C, $FFA4          ;END

;------------------------------------------------------------------------------
; hs_load - start-up: fills the 25 entries with the defaults (hs_set_defaults), has NVRAM area 1 read and
;   checked (K768E), copies the top ten entries (70 bytes) from the NVRAM image at nv_hiscores to INITLS and falls
;   into hs_validate. Star Wars' SETINT
;------------------------------------------------------------------------------
hs_load:
KE3E8:  JSR  hs_set_defaults
KE3EB:  LDA  #$01                   ;NVRAM area 1
KE3ED:  JSR  ee_area_check
KE3F0:  LDX  #nv_hiscores
KE3F3:  LDU  #INITLS
KE3F6:  LDA  ,X+
KE3F8:  STA  ,U+
KE3FA:  CMPU #INITLS+70             ;INITLS + 70: the top ten
KE3FE:  BCS  KE3F6

;------------------------------------------------------------------------------
; hs_validate - Star Wars' CHKHIS for the 7 byte entries: checks every entry up to the end of the table ($4BEE)
;   - three initials below $1B (bit 7 of the first ignored) and four score bytes that are BCD. on any bad byte it
;   goes to DOINTS, which puts in the defaults and writes the top ten back to the NVRAM image. also called from
;   bank 0 through L6114
;------------------------------------------------------------------------------
hs_validate:
KE400:  PSHS A,B,X,U
KE402:  LDX  #INITLS
KE405:  LDA  ,X+
KE407:  ANDA #$7F
KE409:  CMPA #$1B
KE40B:  BCC  DOINTS
KE40D:  LDA  ,X+
KE40F:  CMPA #$1B
KE411:  BCC  DOINTS
KE413:  LDA  ,X+
KE415:  CMPA #$1B
KE417:  BCC  DOINTS
KE419:  LDA  ,X+
KE41B:  CMPA #$A0                   ;HIGH NIBBLE <= 9 ?
KE41D:  BHS  DOINTS                 ;NO, ERROR -- PUT IN DEFAULTS
KE41F:  ANDA #$0F
KE421:  CMPA #$0A                   ;LO NIBBLE <= 9 ?
KE423:  BHS  DOINTS                 ;NOPE, ERROR -- USE DEFAULTS
KE425:  LDA  ,X+
KE427:  CMPA #$A0                   ;HIGH NIBBLE <= 9 ?
KE429:  BHS  DOINTS                 ;NO, ERROR -- PUT IN DEFAULTS
KE42B:  ANDA #$0F
KE42D:  CMPA #$0A                   ;LO NIBBLE <= 9 ?
KE42F:  BHS  DOINTS                 ;NOPE, ERROR -- USE DEFAULTS
KE431:  LDA  ,X+
KE433:  CMPA #$A0                   ;HIGH NIBBLE <= 9 ?
KE435:  BHS  DOINTS                 ;NO, ERROR -- PUT IN DEFAULTS
KE437:  ANDA #$0F
KE439:  CMPA #$0A                   ;LO NIBBLE <= 9 ?
KE43B:  BHS  DOINTS                 ;NOPE, ERROR -- USE DEFAULTS
KE43D:  LDA  ,X+
KE43F:  CMPA #$A0                   ;HIGH NIBBLE <= 9 ?
KE441:  BHS  DOINTS                 ;NO, ERROR -- PUT IN DEFAULTS
KE443:  ANDA #$0F
KE445:  CMPA #$0A                   ;LO NIBBLE <= 9 ?
KE447:  BHS  DOINTS                 ;NOPE, ERROR -- USE DEFAULTS
KE449:  CMPX #INITLS+175            ;the operand is the end of the 25 entry table, $4BEE
KE44C:  BLO  KE405                  ;HSEND
KE44E:  PULS A,B,X,U,PC

DOINTS:
KE450:  JSR  hs_set_defaults
KE453:  JSR  hs_save
KE456:  PULS A,B,X,U,PC

;------------------------------------------------------------------------------
; hs_save - copies the top ten entries (70 bytes from INITLS) to the NVRAM image at nv_hiscores and calls EECKSM
;   for area 1. called when a player ends the entry of initials and by DOINTS
;------------------------------------------------------------------------------
hs_save:
KE458:  LDX  #INITLS
KE45B:  LDU  #nv_hiscores
KE45E:  LDA  ,X+
KE460:  STA  ,U+
KE462:  CMPX #INITLS+70             ;INITLS + 70: the top ten
KE465:  BCS  KE45E
KE467:  LDA  #$01
KE469:  JSR  EECKSM
KE46C:  RTS

;------------------------------------------------------------------------------
; hs_set_defaults - copies the 175 bytes of the default table hs_defaults, 25 entries, to INITLS
;------------------------------------------------------------------------------
hs_set_defaults:
KE46D:  LDU  #INITLS
KE470:  LDX  #hs_defaults
KE473:  LDA  ,X+
KE475:  STA  ,U+
KE477:  CMPX #hs_defaults+175
KE47A:  BCS  KE473
KE47C:  RTS

;------------------------------------------------------------------------------
; hs_nv_defaults - copies the first 70 bytes of hs_defaults, the top ten entries, to the NVRAM image at
;   nv_hiscores. called by the NVRAM code at K751E and offered to bank 0 as L611A, which nothing calls
;------------------------------------------------------------------------------
hs_nv_defaults:
KE47D:  LDX  #nv_hiscores
KE480:  LDU  #hs_defaults
KE483:  LDB  ,U+
KE485:  STB  ,X+
KE487:  CMPU #hs_defaults+70        ;the first 70 bytes: the top ten
KE48B:  BCS  KE483
KE48D:  RTS

hs_defaults:
KE48E:  .byte $0F, $02, $09, $00, $28, $53, $53, $17 ;default high scores, 25 entries of 3 initials (1 = A) and 4 BCD score bytes: OBI 00285353 first
KE496:  .byte $01, $0E, $00, $17, $09, $36, $08, $01
KE49E:  .byte $0E, $00, $15, $46, $50, $0D, $0C, $08
KE4A6:  .byte $00, $14, $02, $12, $07, $0A, $12, $00
KE4AE:  .byte $12, $76, $45, $0E, $0C, $01, $00, $11
KE4B6:  .byte $37, $10, $12, $0F, $02, $00, $10, $01
KE4BE:  .byte $75, $04, $01, $12, $00, $08, $86, $14
KE4C6:  .byte $0A, $05, $04, $00, $07, $58, $00, $04
KE4CE:  .byte $05, $13, $00, $06, $24, $36
KE4D4:  .byte $00, $00, $00, $00, $05, $06, $12, $08 ;defaults from the 11th entry on, which are not kept in NVRAM
KE4DC:  .byte $12, $12, $00, $04, $98, $70, $01, $09
KE4E4:  .byte $0F, $00, $04, $52, $25, $0C, $16, $17
KE4EC:  .byte $00, $04, $07, $15, $0C, $05, $05, $00
KE4F4:  .byte $03, $93, $12, $19, $12, $00, $00, $03
KE4FC:  .byte $50, $25, $00, $01, $0D, $00, $03, $21
KE504:  .byte $90, $01, $00, $01, $00, $02, $75, $15
KE50C:  .byte $16, $12, $12, $00, $02, $22, $82, $05
KE514:  .byte $01, $07, $00, $01, $98, $52, $0C, $0C
KE51C:  .byte $0F, $00, $01, $50, $56, $0C, $13, $0C
KE524:  .byte $00, $01, $23, $75, $01, $14, $09, $00
KE52C:  .byte $00, $90, $82, $12, $0F, $0E, $00, $00
KE534:  .byte $87, $80, $00, $0E, $00, $00, $00, $54
KE53C:  .byte $90

;------------------------------------------------------------------------------
; expl_clear - clears the timer byte XPS_TMR of every entry of the explosion queue XPQUE, so that no explosion
;   piece is live. called through bank 0 L6186 by the setup of each part of a wave
;------------------------------------------------------------------------------
expl_clear:
KE53D:  LDX  #XPQUE
KE540:  LDA  #$00
KE542:  STA  13,X
KE544:  LEAX 14,X
KE546:  CMPX #ALIEN
KE549:  BCS  KE540
KE54B:  RTS

;.SBTTL MUNGE, FANCY EXPLOSION OF OTHERS
TMV:
KE54C:  .word MVBK1                 ;.IRP .A,<BK1,BK2,BK3,TW1,TW2,TW3,TI1,TI2,TI3>
KE54E:  .word expl_piece_kill       ;type 1: ended at once
KE550:  .word MVBK1                 ;type 2. types 0 and 2 are the two probot pieces
;.SBTTL MUNGE, FANCY EXPLOSION OF OTHERS
KE552:  .word MVBK1                 ;.IRP .A,<BK1,BK2,BK3,TW1,TW2,TW3,TI1,TI2,TI3>
KE554:  .word MVBK2                 ;types 3 to 5 (from $E552): AT-ST pieces
KE556:  .word MVBK3
KE558:  .word MVTW1                 ;types 6 to 8: AT-AT pieces
KE55A:  .word MVTW2
KE55C:  .word MVTW3
KE55E:  .word MVTI1                 ;types 9 to 11: TIE fighter pieces
KE560:  .word MVTI2
KE562:  .word MVTI3

expl_view_tab:
KE564:  .word vwx_probot_0          ;view routines of the 12 explosion piece types (Star Wars' TVW): types 0 to 2 draw object 6
KE566:  .word vwx_probot_1
KE568:  .word vwx_probot_2
KE56A:  .word vwx_atst_0            ;types 3 to 5: objects 20, 21, 22
KE56C:  .word vwx_atst_1
KE56E:  .word vwx_atst_2
KE570:  .word vwx_atat_0            ;types 6 to 8: objects 28, 29, 30
KE572:  .word vwx_atat_1
KE574:  .word vwx_atat_2
KE576:  .word VWTI1                 ;types 9 to 11: objects 1, 2, 3
KE578:  .word VWTI2
KE57A:  .word VWTI3

;------------------------------------------------------------------------------
; tie_expl_begin - cross-bank entry (L618C, called by page 3) that starts the explosion of the TIE fighter whose
;   record is at X: clears byte 3 of the record and calls BGAXP with X and U saved. Star Wars' BGAXPLD without the
;   CPUGON call
;------------------------------------------------------------------------------
tie_expl_begin:
KE57C:  PSHS X,U
KE57E:  LDA  #$00
KE580:  STA  3,X                    ;byte 3 of the TIE fighter's record
KE582:  JSR  BGAXP
KE585:  PULS X,U,PC

;------------------------------------------------------------------------------
; atat_expl_begin - cross-bank entry (L6192, called by page 0) that starts the explosion of an AT-AT: BGTWXP
;   with X and U saved. the centre is in M_XT, M_YT, M_ZT
;------------------------------------------------------------------------------
atat_expl_begin:
KE587:  PSHS X,U
KE589:  JSR  BGTWXP
KE58C:  PULS X,U,PC

;------------------------------------------------------------------------------
; probot_expl_begin - cross-bank entry (L6198, called by page 2) that starts the explosion of a probot: BGBKXP
;   with X and U saved. the centre is in M_XT, M_YT, M_ZT
;------------------------------------------------------------------------------
probot_expl_begin:
KE58E:  PSHS X,U
KE590:  JSR  BGBKXP
KE593:  PULS X,U,PC

;------------------------------------------------------------------------------
; atst_expl_begin - cross-bank entry (L61A4, called by page 1) that starts the explosion of an AT-ST:
;   atst_expl_setup with X and U saved. the centre is in M_XT, M_YT, M_ZT
;------------------------------------------------------------------------------
atst_expl_begin:
KE595:  PSHS X,U
KE597:  JSR  atst_expl_setup
KE59A:  PULS X,U,PC

;------------------------------------------------------------------------------
; expl_stub_rts - a lone RTS that the cross-bank table offers to bank 0 as L619E. nothing calls it
;------------------------------------------------------------------------------
expl_stub_rts:
KE59C:  RTS

;------------------------------------------------------------------------------
; BGAXP - BEGIN ALIEN EXPLOSION
;   X-->ALIEN PARMS
;   (also: ZVW)
;   in ESB: the three TIE pieces are types 9, 10 and 11 here, with timers $18, $18 and $10
;------------------------------------------------------------------------------
BGAXP:
ZVW:
KE59D:  LDU  ,X                     ;U-->ALIEN VECTORS
KE59F:  JSR  NXTFRE
;X-->EXPLOSION PARMS
KE5A2:  LDA  #$09                   ;TYPE 1, TIE FIGHTER
KE5A4:  STA  XPS_TYP,X
KE5A6:  LDA  #$18
KE5A8:  STA  XPS_TMR,X
KE5AA:  LDD  #$0000
KE5AD:  SUBD MS_AY,U                ;OFFSET TO CENTER OF LEFT WING
KE5AF:  JSR  ASRD6_B1
KE5B2:  STD  XPS_MX,X               ;INIT MUNGE VALUE
KE5B4:  ADDD MS_TX,U
KE5B6:  STD  ,X
KE5B8:  LDD  #$0000
KE5BB:  SUBD MS_BY,U                ;OFFSET TO CENTER OF LEFT WING
KE5BD:  JSR  ASRD6_B1
KE5C0:  STD  XPS_MY,X               ;INIT MUNGE VELOCITY
KE5C2:  ADDD MS_TY,U
KE5C4:  STD  XPS_CY,X
KE5C6:  LDD  #$0000
KE5C9:  SUBD MS_CY,U                ;OFFSET TO CENTER OF LEFT WING
KE5CB:  JSR  ASRD6_B1
KE5CE:  STD  XPS_MZ,X               ;INIT Z MUNGE
KE5D0:  ADDD MS_TZ,U
KE5D2:  STD  XPS_CZ,X
KE5D4:  JSR  BGAM
KE5D7:  JSR  NXTFRE
;X-->EXPLOSION PARMS
KE5DA:  LDA  #$0A                   ;TYPE 2, TIE FIGHTER RIGHT WING
KE5DC:  STA  XPS_TYP,X
KE5DE:  LDA  #$18
KE5E0:  STA  XPS_TMR,X
KE5E2:  LDD  MS_AY,U                ;OFFSET TO CENTER OF RIGHT WING
KE5E4:  JSR  ASRD6_B1
KE5E7:  STD  XPS_MX,X               ;INIT MUNGE X
KE5E9:  ADDD MS_TX,U
KE5EB:  STD  ,X
KE5ED:  LDD  MS_BY,U                ;OFFSET TO CENTER OF RIGHT WING
KE5EF:  JSR  ASRD6_B1
KE5F2:  STD  XPS_MY,X               ;INIT Y MUNGE
KE5F4:  ADDD MS_TY,U
KE5F6:  STD  XPS_CY,X
KE5F8:  LDD  MS_CY,U                ;OFFSET TO CENTER OF RIGHT WING
KE5FA:  JSR  ASRD6_B1
KE5FD:  STD  XPS_MZ,X               ;INIT Z MUNGE
KE5FF:  ADDD MS_TZ,U
KE601:  STD  XPS_CZ,X
KE603:  JSR  BGAM
KE606:  JSR  NXTFRE
;X-->EXPLOSION PARMS
KE609:  LDA  #$0B                   ;TYPE 3, TIE FIGHTER CENTER GLOBE
KE60B:  STA  XPS_TYP,X
KE60D:  LDA  #$10
KE60F:  STA  XPS_TMR,X
KE611:  LDD  MS_TX,U
KE613:  STD  ,X
KE615:  STD  XPS_MX,X
KE617:  LDD  MS_TY,U
KE619:  STD  XPS_CY,X
KE61B:  STD  XPS_MY,X
KE61D:  LDD  MS_TZ,U
KE61F:  STD  XPS_CZ,X
KE621:  STD  XPS_MZ,X
KE623:  LDA  XPS_MX,X               ;D:=X POSITION
KE625:  LDB  #$80                   ;LIMIT THE VECTORIZING
KE627:  LSLB
KE628:  ROLA
KE629:  BVC  KE62F                  ;IFVS  ?OVER-NORMALIZED?
KE62B:  RORA
KE62C:  RORB
KE62D:  BRA  BGAXP_40
KE62F:  LSL  XPS_MY+1,X
KE631:  ROL  XPS_MY,X
KE633:  BVC  KE63D                  ;IFVS  ?Y IS OVER?
KE635:  ROR  XPS_MY,X
KE637:  ROR  XPS_MY+1,X             ;Y IS CORRECTED
KE639:  ASRA
KE63A:  RORB                        ;UNDO X
KE63B:  BRA  BGAXP_40
KE63D:  LSL  XPS_MZ+1,X
KE63F:  ROL  XPS_MZ,X
KE641:  BVC  KE627                  ;VSEND  ALSO END WHEN Z TOO LARGE
KE643:  ROR  XPS_MZ,X
KE645:  ROR  XPS_MZ+1,X             ;Z IS CORRECTED
KE647:  ASR  XPS_MY,X
KE649:  ASR  XPS_MY+1,X             ;UNDO ONE Y
KE64B:  ASRA
KE64C:  RORB                        ;UNDO X ALSO

BGAXP_40:
KE64D:  SUBD ,X                     ;GET DISTANCE FROM CURRENT TO FRONTIER
KE64F:  JSR  ASRD4                  ;GO ALL THE WAY TO EDGE IN 16.
KE652:  LDB  P_RND1
KE655:  STD  XPS_MX,X
KE657:  LDD  XPS_MY,X
KE659:  SUBD XPS_CY,X
KE65B:  JSR  ASRD4
KE65E:  LDB  P_RND1
KE661:  STD  XPS_MY,X
KE663:  LDD  XPS_MZ,X
KE665:  SUBD XPS_CZ,X
KE667:  JSR  ASRD4
KE66A:  LDB  P_RND1
KE66D:  STD  XPS_MZ,X
KE66F:  RTS

;------------------------------------------------------------------------------
; BGAM - HANDLE XP$M*
;------------------------------------------------------------------------------
BGAM:
KE670:  LDD  MS_VX,U
KE672:  ADDD XPS_MX,X
KE674:  STD  XPS_MX,X
KE676:  LDD  MS_VY,U
KE678:  ADDD XPS_MY,X
KE67A:  STD  XPS_MY,X
KE67C:  LDD  MS_VZ,U
KE67E:  ADDD XPS_MZ,X
KE680:  STD  XPS_MZ,X
KE682:  RTS

;------------------------------------------------------------------------------
; BGBKXP - BEGIN WALL GUN EXPLOSION
;   BEGIN BUNKER EXPLOSION
;   (also: BGBKXP)
;   in ESB: in ESB this begins the explosion of a probot. BGBKN makes two pieces, not three: type 0 from a
;   point $100 above the centre going left and type 2 (TMPTP3) from the centre going right, both with a random
;   upward speed whose high byte TMPVZ is 0. both are drawn as object 6, the probot head
;------------------------------------------------------------------------------
BGBKXP:
BGWGXP:
KE683:  LDD  #(TPS_BK1*$100)+TPS_BK2 ;TYPE 1 BUNKER, TYPE 2 BUNKER
KE686:  STD  TMPTP1
KE688:  LDD  #$0200                 ;TMPTP3 = 2, the type of the second probot piece, and TMPVZ = 0
KE68B:  STD  TMPTP3

;M.XT,YT,ZT HAVE CENTER
BGBKN:
KE68D:  JSR  NXTFRE                 ;X-->EXPLOSION QUEUE ENTRY
KE690:  LDA  TMPTP1                 ;BUNKER PIECE 1
KE692:  STA  XPS_TYP,X
KE694:  LDA  #$20
KE696:  STA  XPS_TMR,X              ;LIFE TIMER
KE698:  LDD  M_XT                   ;CENTER OF EXPLOSION
KE69B:  STD  ,X
KE69D:  LDD  M_YT
KE6A0:  STD  XPS_CY,X
KE6A2:  LDD  M_ZT
KE6A5:  ADDA #$01
KE6A7:  STD  XPS_CZ,X
KE6A9:  LDD  MS_TX+M_S1
KE6AC:  ADDA #$7F
KE6AE:  SUBD M_XT
KE6B1:  JSR  ASRD5
KE6B4:  LDB  P_RND1
KE6B7:  STD  XPS_MX,X               ;SPEED TO DESTINATION
KE6B9:  LDD  MS_TY+M_S1
KE6BC:  ADDA #$C1                   ;GO LEFT
KE6BE:  SUBD M_YT
KE6C1:  JSR  ASRD5
KE6C4:  LDB  P_RND1
KE6C7:  STD  XPS_MY,X               ;LEFT/RIGHT SPEED TO DESTINATION
KE6C9:  LDA  TMPVZ                  ;728. TO 1024., VARY AROUND 54.*120.*2/16=810.
KE6CB:  LDB  P_RND1
KE6CE:  JSR  LSLD2                  ;*4
KE6D1:  STD  XPS_MZ,X               ;VERTICAL VELOCITY
;CENTER PIECE
KE6D3:  JSR  NXTFRE                 ;X-->EXPLOSION QUEUE ENTRY
KE6D6:  LDA  scratch_3              ;TMPTP3: the second and last piece is of type 2
KE6D8:  STA  XPS_TYP,X
KE6DA:  LDA  #$20
KE6DC:  STA  XPS_TMR,X              ;LIFE TIMER
KE6DE:  LDD  M_XT                   ;CENTER OF EXPLOSION
KE6E1:  STD  ,X
KE6E3:  LDD  M_YT
KE6E6:  STD  XPS_CY,X
KE6E8:  LDD  M_ZT
KE6EB:  STD  XPS_CZ,X
KE6ED:  LDD  MS_TX+M_S1
KE6F0:  ADDA #$7F
KE6F2:  SUBD M_XT
KE6F5:  JSR  ASRD5
KE6F8:  LDB  P_RND1
KE6FB:  STD  XPS_MX,X               ;SPEED TO DESTINATION
KE6FD:  LDD  MS_TY+M_S1
KE700:  ADDA #$3F                   ;GO RIGHT
KE702:  SUBD M_YT
KE705:  JSR  ASRD5
KE708:  LDB  P_RND1
KE70B:  STD  XPS_MY,X               ;LEFT/RIGHT SPEED TO DESTINATION
KE70D:  LDA  TMPVZ                  ;728. TO 1024., VARY AROUND 54.*120.*2/16=810.
KE70F:  LDB  P_RND1
KE712:  JSR  LSLD2                  ;*4
KE715:  STD  XPS_MZ,X               ;VERTICAL VELOCITY
KE717:  RTS

;------------------------------------------------------------------------------
; atst_expl_setup - begins the explosion of an AT-ST: piece types 3, 4 and 5 and an upward speed byte of 3 into
;   TMPTP1, TMPTP2, TMPTP3 and TMPVZ, then the three-piece code it shares with BGTWXP at $E72E
;------------------------------------------------------------------------------
atst_expl_setup:
KE718:  LDD  #$0304                 ;TMPTP1 = 3, TMPTP2 = 4: explosion piece types of the AT-ST
KE71B:  STD  TMPTP1
KE71D:  LDD  #$0503                 ;TMPTP3 = 5, and TMPVZ = 3, the high byte of the pieces' upward speed
KE720:  STD  TMPTP3
KE722:  BRA  KE72E

;------------------------------------------------------------------------------
; BGTWXP - [note] Begin tower top explosion: TMPTP1..3 = tower piece types TPS_TW1..3 and TMPVZ = 2, then falls into
;   BGBKN, which queues the three pieces around center M_XT,YT,ZT
;   in ESB: in ESB this begins the explosion of an AT-AT with piece types 6, 7 and 8, and it does not fall
;   into BGBKN: its own three-piece code at $E72E, shared with atst_expl_setup, starts type TMPTP2 $200 ahead
;   of the centre, TMPTP1 $200 to one side and TMPTP3 $200 to the other
;------------------------------------------------------------------------------
BGTWXP:
KE724:  LDD  #$0607                 ;TYPE 1 TOWER,TYPE 2 TOWER
KE727:  STD  TMPTP1
KE729:  LDD  #$0802                 ;TYPE 3 TOWER, Z VELOCITY OF 800(4*200)
KE72C:  STD  TMPTP3
;CENTER PIECE
KE72E:  JSR  NXTFRE                 ;X-->EXPLOSION QUEUE ENTRY
KE731:  LDA  TMPTP2                 ;BUNKER PIECE 2
KE733:  STA  XPS_TYP,X
KE735:  LDA  #$20
KE737:  STA  XPS_TMR,X              ;LIFE TIMER
KE739:  LDD  M_XT                   ;CENTER OF EXPLOSION
KE73C:  ADDA #$02
KE73E:  STD  ,X
KE740:  LDD  M_YT
KE743:  STD  XPS_CY,X
KE745:  LDD  M_ZT
KE748:  STD  XPS_CZ,X
KE74A:  LDD  MS_TX+M_S1
KE74D:  ADDA #$7F
KE74F:  SUBD M_XT
KE752:  JSR  ASRD5
KE755:  LDB  P_RND1
KE758:  STD  XPS_MX,X               ;SPEED TO DESTINATION
KE75A:  LDD  MS_TY+M_S1
KE75D:  SUBD M_YT
KE760:  JSR  ASRD5
KE763:  LDB  P_RND1
KE766:  STD  XPS_MY,X               ;LEFT/RIGHT SPEED TO DESTINATION
KE768:  LDA  TMPVZ                  ;728. TO 1024., VARY AROUND 54.*120.*2/16=810.
KE76A:  LDB  P_RND1
KE76D:  JSR  LSLD2                  ;*4
KE770:  STD  XPS_MZ,X               ;VERTICAL VELOCITY
;RIGHT PIECE
KE772:  JSR  NXTFRE                 ;X-->EXPLOSION QUEUE ENTRY
KE775:  LDA  scratch_1              ;TMPTP1
KE777:  STA  XPS_TYP,X
KE779:  LDA  #$20
KE77B:  STA  XPS_TMR,X              ;LIFE TIMER
KE77D:  LDD  M_XT                   ;CENTER OF EXPLOSION
KE780:  STD  ,X
KE782:  LDD  M_YT
KE785:  ADDA #$FE
KE787:  STD  XPS_CY,X
KE789:  LDD  M_ZT
KE78C:  STD  XPS_CZ,X
KE78E:  LDD  MS_TX+M_S1
KE791:  ADDA #$7F
KE793:  SUBD M_XT
KE796:  JSR  ASRD5
KE799:  LDB  P_RND1
KE79C:  STD  XPS_MX,X               ;SPEED TO DESTINATION
KE79E:  LDD  MS_TY+M_S1
KE7A1:  ADDA #$C1                   ;GO RIGHT
KE7A3:  SUBD M_YT
KE7A6:  JSR  ASRD5
KE7A9:  LDB  P_RND1
KE7AC:  STD  XPS_MY,X               ;LEFT/RIGHT SPEED TO DESTINATION
KE7AE:  LDA  TMPVZ                  ;728. TO 1024., VARY AROUND 54.*120.*2/16=810.
KE7B0:  LDB  P_RND1
KE7B3:  JSR  LSLD2                  ;*4
KE7B6:  STD  XPS_MZ,X               ;VERTICAL VELOCITY
;RIGHT PIECE
KE7B8:  JSR  NXTFRE                 ;X-->EXPLOSION QUEUE ENTRY
KE7BB:  LDA  TMPTP3                 ;BUNKER PIECE 3
KE7BD:  STA  XPS_TYP,X
KE7BF:  LDA  #$20
KE7C1:  STA  XPS_TMR,X              ;LIFE TIMER
KE7C3:  LDD  M_XT                   ;CENTER OF EXPLOSION
KE7C6:  STD  ,X
KE7C8:  LDD  M_YT
KE7CB:  ADDA #$02
KE7CD:  STD  XPS_CY,X
KE7CF:  LDD  M_ZT
KE7D2:  STD  XPS_CZ,X
KE7D4:  LDD  MS_TX+M_S1
KE7D7:  ADDA #$7F
KE7D9:  SUBD M_XT
KE7DC:  JSR  ASRD5
KE7DF:  LDB  P_RND1
KE7E2:  STD  XPS_MX,X               ;SPEED TO DESTINATION
KE7E4:  LDD  MS_TY+M_S1
KE7E7:  ADDA #$3F                   ;GO RIGHT
KE7E9:  SUBD M_YT
KE7EC:  JSR  ASRD5
KE7EF:  LDB  P_RND1
KE7F2:  STD  XPS_MY,X               ;LEFT/RIGHT SPEED TO DESTINATION
KE7F4:  LDA  TMPVZ                  ;728. TO 1024., VARY AROUND 54.*120.*2/16=810.
KE7F6:  LDB  P_RND1
KE7F9:  JSR  LSLD2                  ;*4
KE7FC:  STD  XPS_MZ,X               ;VERTICAL VELOCITY
KE7FE:  RTS

;------------------------------------------------------------------------------
; NXTFRE - GET NEXT FREE EXPLOSION SLOT
;------------------------------------------------------------------------------
NXTFRE:
KE7FF:  LDB  XP_HDQ
KE801:  INCB                        ;BUMP TO NEXT SLOT
KE802:  STB  XP_HDQ
KE804:  LDA  #XPS_IZE
KE806:  MUL
KE807:  LDX  #XPQUE
KE80A:  LEAX D,X                    ;X-->QUEUE ENTRY
KE80C:  CMPX #ALIEN
KE80F:  BCS  KE816
KE811:  CLR  XP_HDQ
KE813:  LDX  #XPQUE
KE816:  RTS

;------------------------------------------------------------------------------
; MUNGE - CONTORT THE EXPLOSION MATRIX FOR VIEWING
;------------------------------------------------------------------------------
MUNGE:
KE817:  LDD  #$14BD                 ;19.04 DEGREES ROLL
KE81A:  STD  M_SIN
KE81D:  LDD  #$3C8C
KE820:  STD  M_COS
KE823:  LDD  #MS_MUNBC
KE826:  STD  M_BIC
KE829:  LDA  #MS_ROLL
KE82B:  JSR  MGOWT_B1
KE82E:  LDD  #$0590                 ;4.99 DEGREES PITCH
KE831:  STD  M_SIN
KE834:  LDD  #$3FC2
KE837:  STD  M_COS
KE83A:  LDD  #MS_MUNBC
KE83D:  STD  M_BIC
KE840:  LDA  #MS_PTCH
KE842:  JSR  MGOWT_B1
KE845:  RTS

;------------------------------------------------------------------------------
; DOXPLD - PROCESS EXPLOSIONS IN PROGRESS
;   in ESB: 12 piece types in ESB: 0-2 probot, 3-5 AT-ST, 6-8 AT-AT, 9-11 TIE fighter
;------------------------------------------------------------------------------
DOXPLD:
KE846:  LDX  #XPQUE
KE849:  LDA  XPS_TMR,X
KE84B:  BEQ  KE85D                  ;IFNE
KE84D:  DEC  XPS_TMR,X              ;COUNT DOWN TO ZERO
KE84F:  LDB  XPS_TYP,X
KE851:  CMPB #$0C                   ;12 piece types in ESB
KE853:  BLO  KE857                  ;IFHS
KE855:  LDB  #$00
KE857:  LDU  #TMV
KE85A:  LSLB                        ;WORD POINTER
KE85B:  JSR  [B,U]
KE85D:  LEAX XPS_IZE,X
KE85F:  CMPX #XPQUEZ
KE862:  BLO  KE849                  ;HSEND
KE864:  LDX  #XPQUE
KE867:  LDA  XPS_TMR,X
KE869:  BEQ  KE86E                  ;IFNE
KE86B:  JMP  MUNGE                  ;J A LIVE EXPLOSION KEEPS THE MATRIX ROLLING
KE86E:  LEAX XPS_IZE,X
KE870:  CMPX #XPQUEZ
KE873:  BLO  KE867                  ;HSEND
;?NONE ARE ACTIVE?
KE875:  LDU  #M_MUN                 ;THEN RESTART THE UNIT VECTORS
KE878:  JSR  UNITV_B1
KE87B:  RTS

;------------------------------------------------------------------------------
; expl_piece_kill - move routine of explosion piece type 1 in TMV: clears the piece's timer, which ends it. no
;   code here makes a piece of type 1
;------------------------------------------------------------------------------
expl_piece_kill:
KE87C:  LDA  #$00
KE87E:  STA  13,X
KE880:  RTS

;------------------------------------------------------------------------------
; MVBK1 - [note] Move a bunker or tower explosion piece, X-->explosion queue entry: add XPS_MX,MY to center with
;   friction losses (velocity less 1/32), add XPS_MZ to Z (stops at ground level 0), gravity $C8 off XPS_MZ
;   (also: MVBK2, MVBK3, MVTW1, MVTW2, MVTW3)
;   in ESB: in ESB a piece that goes below ground level bounces: its height becomes half the depth it went
;   below, and if it was falling its upward speed becomes half the falling speed. type 1's entry of TMV is
;   expl_piece_kill instead
;------------------------------------------------------------------------------
MVBK1:
MVBK2:
MVBK3:
MVTW1:
MVTW2:
MVTW3:
KE881:  LDD  XPS_MX,X
KE883:  ADDD ,X                     ;MOVE CENTER OF EXPLOSION PIECE
KE885:  STD  ,X
KE887:  LDD  #$0000
KE88A:  SUBD XPS_MX,X
KE88C:  JSR  ASRD5
KE88F:  ADDD XPS_MX,X
KE891:  STD  XPS_MX,X               ;FRICTION LOSSES
KE893:  LDD  XPS_MY,X
KE895:  ADDD XPS_CY,X               ;MOVE CENTER OF EXPLOSION
KE897:  STD  XPS_CY,X
KE899:  LDD  #$0000
KE89C:  SUBD XPS_MY,X
KE89E:  JSR  ASRD5
KE8A1:  ADDD XPS_MY,X
KE8A3:  STD  XPS_MY,X               ;FRICTION LOSSES
KE8A5:  LDD  XPS_CZ,X
KE8A7:  ADDD XPS_MZ,X
KE8A9:  BVS  KE8C3                  ;IFVC  ?VALID RESULTS?
KE8AB:  STD  XPS_CZ,X               ;UPDATE VERTICAL POSITION
KE8AD:  BGE  KE8C3
KE8AF:  COMA                        ;ESB: below the ground - bounce
KE8B0:  NEGB
KE8B1:  SBCA #$FF
KE8B3:  LSRA
KE8B4:  RORB
KE8B5:  STD  4,X                    ;height = half of the depth below ground
KE8B7:  LDD  #$0000
KE8BA:  SUBD 10,X
KE8BC:  BLE  KE8C3                  ;only when it was falling: upward speed = half of the falling speed
KE8BE:  JSR  ASRD1_B1
KE8C1:  STD  10,X
KE8C3:  LDD  XPS_MZ,X
KE8C5:  SUBD #$00C8                 ;FORCE OF GRAVITY <54.*120.*2>/16.SQUARED FRAME
KE8C8:  STD  XPS_MZ,X
KE8CA:  RTS

;------------------------------------------------------------------------------
; MVTI1 - LEFT WING KEEP ORIGINAL VELOCITY
;   RIGHT WING KEEP ORIGINAL VELOCITY
;   CENTER GLOBE MOVE AWAY FROM LAZAR BLAST
;   (also: MVTI2, MVTI3)
;------------------------------------------------------------------------------
MVTI1:
MVTI2:
MVTI3:
KE8CB:  LDD  XPS_MX,X
KE8CD:  ADDD ,X
KE8CF:  BVS  KE8D3                  ;IFVC
KE8D1:  STD  ,X
KE8D3:  LDD  XPS_MY,X
KE8D5:  ADDD XPS_CY,X
KE8D7:  BVS  KE8DB                  ;IFVC
KE8D9:  STD  XPS_CY,X
KE8DB:  LDD  XPS_MZ,X
KE8DD:  ADDD XPS_CZ,X
KE8DF:  BVS  KE8E3                  ;IFVC
KE8E1:  STD  XPS_CZ,X
KE8E3:  RTS

;------------------------------------------------------------------------------
; VWXPLD - VIEW OTHERS EXPLODING
;------------------------------------------------------------------------------
VWXPLD:
KE8E4:  LDA  #MS_MUNBC
KE8E6:  JSR  IS2UV_B1               ;DOWNLOAD DESTINATION MATRIX
KE8E9:  LDA  #MS_CNCT
KE8EB:  JSR  MGOWT_B1               ;CONCATENATE WITH VIEWERS MATRIX
KE8EE:  LDX  #XPQUE
KE8F1:  STX  S2_PRM
KE8F3:  LDA  XPS_TMR,X
KE8F5:  BEQ  KE8FA                  ;IFNE  ?GOT A LIVE EXPLOSION?
KE8F7:  JSR  VWXPL2
KE8FA:  LDX  S2_PRM
KE8FC:  LEAX XPS_IZE,X
KE8FE:  CMPX #XPQUEZ
KE901:  BLO  KE8F1                  ;HSEND
KE903:  RTS

;------------------------------------------------------------------------------
; VWXPL2 - [note] View one explosion piece, X-->explosion queue entry: PSB2 its center; if in view call its TVW
;   routine (XPS_TYP), then ADOBJ, OBJPNT, OBJDRW; if not visible clear XPS_TMR to turn it off
;   in ESB: in ESB the type's view routine only picks the object and the colour (VWTIN), then obj_load,
;   obj_points, obj_draw and obj_beam_home draw it: obj_points gives screen positions without a move to the
;   object's centre first
;------------------------------------------------------------------------------
VWXPL2:
KE904:  LDD  ,X
KE906:  STD  M_X0                   ;CENTER OF THIS PIECE
KE909:  LDD  XPS_CY,X
KE90B:  STD  M_Y0
KE90E:  LDD  XPS_CZ,X
KE910:  STD  M_Z0
KE913:  LDD  #MS_X0BC
KE916:  STD  M_BIC
KE919:  LDA  #MS_PSB2
KE91B:  JSR  MGOWT_B1
KE91E:  LDD  M_XP
KE921:  BMI  VWXPL2_92              ;B SPECIAL IF NOT VISIBLE
KE923:  STD  M_XT
KE926:  STD  M_DVD
KE929:  LDD  M_YP
KE92C:  STD  M_YT
KE92F:  BPL  KE935                  ;IFMI
KE931:  COMA                        ;NEGD
KE932:  NEGB
KE933:  SBCA #$FF
KE935:  SUBD M_XT
KE938:  BGE  VWXPL2_92              ;B SPECIAL IF NOT VISIBLE
KE93A:  LDD  M_ZP
KE93D:  STD  M_ZT
KE940:  BPL  KE946                  ;IFMI
KE942:  COMA                        ;NEGD
KE943:  NEGB
KE944:  SBCA #$FF
KE946:  LSRA                        ;LSRD  ALLOW Z TO BE TWICE AS HI FOR LAZAR TOWERS
KE947:  RORB
KE948:  SUBD M_XT
KE94B:  BGE  VWXPL2_92              ;B SPECIAL IF NOT VISIBLE
KE94D:  LDB  XPS_TYP,X
KE94F:  CMPB #$0C
KE951:  BLO  KE955                  ;IFHS  ?OUT OF RANGE TYP?
KE953:  LDB  #$00
KE955:  LDU  #expl_view_tab
KE958:  LSLB                        ;WORD POINTER
KE959:  JSR  [B,U]
KE95B:  JSR  obj_load               ;load the object if it is not in the math RAM
KE95E:  JSR  obj_points             ;perspect its points
KE961:  JSR  obj_draw               ;draw it
KE964:  JSR  obj_beam_home          ;beam back to the centre
KE967:  BRA  VWXPL2_98

VWXPL2_92:
KE969:  CLR  XPS_TMR,X              ;IF PIECE NOT VISIBLE, THEN TURN IT OFF

VWXPL2_98:
KE96B:  RTS

;------------------------------------------------------------------------------
; vwx_probot_0 - view routine of explosion piece type 0 (table expl_view_tab): object 6, the probot head,
;   through VWTIN
;------------------------------------------------------------------------------
vwx_probot_0:
KE96C:  LDB  #$06
KE96E:  BRA  VWTIN                  ;ELSE

;------------------------------------------------------------------------------
; vwx_probot_1 - view routine of explosion piece type 1: object 6 through VWTIN
;------------------------------------------------------------------------------
vwx_probot_1:
KE970:  LDB  #$06
KE972:  BRA  VWTIN

;------------------------------------------------------------------------------
; vwx_probot_2 - view routine of explosion piece type 2: object 6 through VWTIN
;------------------------------------------------------------------------------
vwx_probot_2:
KE974:  LDB  #$06
KE976:  BRA  VWTIN

;------------------------------------------------------------------------------
; vwx_atst_0 - view routine of explosion piece type 3: object $14 (20), one half of the AT-ST head, through
;   VWTIN
;------------------------------------------------------------------------------
vwx_atst_0:
KE978:  LDB  #$14
KE97A:  BRA  VWTIN

;------------------------------------------------------------------------------
; vwx_atst_1 - view routine of explosion piece type 4: object $15 (21), the top wedge of the AT-ST head, through
;   VWTIN
;------------------------------------------------------------------------------
vwx_atst_1:
KE97C:  LDB  #$15
KE97E:  BRA  VWTIN

;------------------------------------------------------------------------------
; vwx_atst_2 - view routine of explosion piece type 5: object $16 (22), the other half of the AT-ST head,
;   through VWTIN
;------------------------------------------------------------------------------
vwx_atst_2:
KE980:  LDB  #$16
KE982:  BRA  VWTIN

;------------------------------------------------------------------------------
; vwx_atat_0 - view routine of explosion piece type 6: object $1C (28), the front third of the AT-AT body,
;   through VWTIN
;------------------------------------------------------------------------------
vwx_atat_0:
KE984:  LDB  #$1C
KE986:  BRA  VWTIN

;------------------------------------------------------------------------------
; vwx_atat_1 - view routine of explosion piece type 7: object $1D (29), the middle third of the AT-AT body,
;   through VWTIN
;------------------------------------------------------------------------------
vwx_atat_1:
KE988:  LDB  #$1D
KE98A:  BRA  VWTIN

;------------------------------------------------------------------------------
; vwx_atat_2 - view routine of explosion piece type 8: object $1E (30), the rear third of the AT-AT body,
;   through VWTIN
;------------------------------------------------------------------------------
vwx_atat_2:
KE98C:  LDB  #$1E
KE98E:  BRA  VWTIN

;------------------------------------------------------------------------------
; VWTI3 - VIEW TIE CENTER
;------------------------------------------------------------------------------
VWTI3:
KE990:  LDB  #TDS_TI3
KE992:  BRA  VWTIN

;------------------------------------------------------------------------------
; VWTI1 - LEFT TIE WING
;------------------------------------------------------------------------------
VWTI1:
KE994:  LDB  #TDS_TI1
KE996:  BRA  VWTIN

;------------------------------------------------------------------------------
; VWTI2 - RIGHT TIE WING
;------------------------------------------------------------------------------
VWTI2:
KE998:  LDB  #TDS_TI2
KE99A:  BRA  VWTIN

;------------------------------------------------------------------------------
; VWTIN - [note] Common part for TIE pieces: BJ_ID = B, color from TVWCLE indexed by XPS_TMR (VJFLS flash when beyond
;   the table), then OBJCEN. X-->explosion queue entry
;   in ESB: in ESB all 12 piece types come here. it does not call OBJCEN, the colour table has $18 entries and
;   a timer of $18 or more gives a JSRL $A013
;------------------------------------------------------------------------------
VWTIN:
KE99C:  STB  BJ_ID
KE99E:  LDB  XPS_TMR,X              ;SELECT A COLOR
KE9A0:  CMPB #$18                   ;the table has $18 entries
KE9A2:  BCS  KE9A9
KE9A4:  LDD  #$A013                 ;THEN REALLY FLASH
KE9A7:  BRA  KE9AF                  ;ELSE
KE9A9:  LDU  #tie_expl_colors       ;ELSE SHOW US BEATING IT
KE9AC:  LSLB
KE9AD:  LDD  B,U
KE9AF:  STD  ,Y++
KE9B1:  RTS

tie_expl_colors:
KE9B2:  .word $6710, $6230, $6720, $6240 ;colour instruction for each value of the piece's timer below $18, Star Wars' TVWCLE with other values
KE9BA:  .word $6730, $6250, $6740, $6260
KE9C2:  .word $6750, $6270, $6760, $6280
KE9CA:  .word $6770, $6290, $6780
KE9D0:  .word (VGCOLR&$F000)+(($A2&$F)*$100)+($A2&$F0)
KE9D2:  .word (VGCOLR&$F000)+(($87&$F)*$100)+($87&$F0) ;TVWBYT 87,0A2,97,0A2,0A7,0A2,0C7,0A2
KE9D4:  .word (VGCOLR&$F000)+(($A2&$F)*$100)+($A2&$F0)
KE9D6:  .word (VGCOLR&$F000)+(($97&$F)*$100)+($97&$F0)
KE9D8:  .word (VGCOLR&$F000)+(($A2&$F)*$100)+($A2&$F0)
KE9DA:  .word (VGCOLR&$F000)+(($A7&$F)*$100)+($A7&$F0)
KE9DC:  .word (VGCOLR&$F000)+(($A2&$F)*$100)+($A2&$F0)
KE9DE:  .word (VGCOLR&$F000)+(($C7&$F)*$100)+($C7&$F0)
KE9E0:  .word (VGCOLR&$F000)+(($A2&$F)*$100)+($A2&$F0)
KE9E2:  .byte $1C, $6D, $B8, $CA, $60, $4A, $75, $90 ;33 bytes that no code refers to, up to the ROM fill at $EA03
KE9EA:  .byte $C0, $3C, $0F, $44, $00, $00, $08, $9C
KE9F2:  .byte $B0, $A5, $90, $00, $C0, $8F, $68, $90
KE9FA:  .byte $C0, $56, $AA, $45, $C0, $A0, $D4, $7F
KEA02:  .byte $EA
KEA03:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;ROM fill, 5095 bytes of $FF
KEA13:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEA23:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEA33:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEA43:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEA53:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEA63:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEA73:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEA83:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEA93:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEAA3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEAB3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEAC3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEAD3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEAE3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEAF3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEB03:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEB13:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEB23:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEB33:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEB43:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEB53:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEB63:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEB73:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEB83:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEB93:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEBA3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEBB3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEBC3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEBD3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEBE3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEBF3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEC03:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEC13:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEC23:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEC33:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEC43:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEC53:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEC63:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEC73:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEC83:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEC93:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KECA3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KECB3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KECC3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KECD3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KECE3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KECF3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KED03:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KED13:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KED23:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KED33:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KED43:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KED53:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KED63:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KED73:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KED83:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KED93:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEDA3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEDB3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEDC3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEDD3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEDE3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEDF3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEE03:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEE13:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEE23:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEE33:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEE43:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEE53:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEE63:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEE73:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEE83:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEE93:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEEA3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEEB3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEEC3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEED3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEEE3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEEF3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEF03:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEF13:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEF23:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEF33:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEF43:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEF53:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEF63:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEF73:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEF83:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEF93:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEFA3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEFB3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEFC3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEFD3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEFE3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KEFF3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF003:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF013:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF023:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF033:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF043:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF053:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF063:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF073:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF083:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF093:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF0A3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF0B3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF0C3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF0D3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF0E3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF0F3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF103:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF113:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF123:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF133:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF143:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF153:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF163:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF173:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF183:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF193:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF1A3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF1B3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF1C3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF1D3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF1E3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF1F3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF203:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF213:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF223:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF233:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF243:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF253:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF263:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF273:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF283:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF293:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF2A3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF2B3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF2C3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF2D3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF2E3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF2F3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF303:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF313:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF323:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF333:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF343:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF353:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF363:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF373:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF383:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF393:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF3A3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF3B3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF3C3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF3D3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF3E3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF3F3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF403:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF413:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF423:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF433:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF443:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF453:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF463:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF473:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF483:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF493:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF4A3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF4B3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF4C3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF4D3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF4E3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF4F3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF503:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF513:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF523:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF533:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF543:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF553:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF563:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF573:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF583:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF593:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF5A3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF5B3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF5C3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF5D3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF5E3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF5F3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF603:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF613:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF623:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF633:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF643:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF653:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF663:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF673:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF683:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF693:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF6A3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF6B3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF6C3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF6D3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF6E3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF6F3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF703:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF713:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF723:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF733:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF743:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF753:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF763:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF773:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF783:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF793:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF7A3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF7B3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF7C3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF7D3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF7E3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF7F3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF803:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF813:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF823:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF833:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF843:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF853:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF863:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF873:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF883:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF893:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF8A3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF8B3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF8C3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF8D3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF8E3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF8F3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF903:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF913:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF923:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF933:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF943:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF953:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF963:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF973:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF983:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF993:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF9A3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF9B3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF9C3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF9D3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF9E3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KF9F3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFA03:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFA13:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFA23:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFA33:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFA43:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFA53:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFA63:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFA73:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFA83:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFA93:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFAA3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFAB3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFAC3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFAD3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFAE3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFAF3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFB03:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFB13:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFB23:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFB33:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFB43:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFB53:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFB63:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFB73:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFB83:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFB93:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFBA3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFBB3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFBC3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFBD3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFBE3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFBF3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFC03:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFC13:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFC23:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFC33:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFC43:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFC53:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFC63:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFC73:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFC83:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFC93:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFCA3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFCB3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFCC3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFCD3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFCE3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFCF3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFD03:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFD13:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFD23:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFD33:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFD43:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFD53:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFD63:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFD73:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFD83:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFD93:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFDA3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFDB3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFDC3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFDD3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFDE3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFDEA:  .byte $FF
KFDEB:  .byte $FF
KFDEC:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;ROM fill, 322 bytes of $FF
KFDFC:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFE0C:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFE1C:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFE2C:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFE3C:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFE4C:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFE5C:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFE6C:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFE7C:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFE8C:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFE9C:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFEAC:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFEBC:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFECC:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFEDC:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFEEC:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFEFC:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFF0C:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFF1C:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFF2C:  .byte $FF, $FF

FILL0_B1_4:
KFF2E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;.REPT 73  FILL WITH FF'S
KFF36:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFF3E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFF46:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFF4E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFF56:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFF5E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFF66:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFF6E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFF76:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFF7E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFF86:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFF8E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFF96:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
KFF9E:  .byte $FF, $FF, $FF

CPYRT0_B1_4:
KFFA1:  .byte $43, $4F, $50, $59, $52, $49, $47, $48 ;.ASCII /COPYRIGHT 1983 ATARI/
KFFA9:  .byte $54, $20, $31, $39, $38, $34, $20, $41
KFFB1:  .byte $54, $41, $52, $49, $AE, $C4, $10, $8E
KFFB9:  .byte $20, $00, $86, $FF, $B7, $46, $84

;------------------------------------------------------------------------------
; rom_sum_b1 - the bank 1 half of the self test's ROM sum. bank 0's rom_sum_2banks sets W_BANK and the 6809
;   fetches its next instruction here: add the 8K at X, in bank 1, into the sum with end-around carry, then clear
;   W_BANK, which continues in bank 0 at $FFD8. found by running the program (emu_src/tests/coverage.py)
;------------------------------------------------------------------------------
rom_sum_b1:
KFFC0:  TFR  X,D
KFFC2:  ANDCC #$FE
KFFC4:  ADDD ,X++
KFFC6:  ADCB #$00
KFFC8:  ADCA #$00
KFFCA:  STA  WTCHDG                 ;SHUT THE DOG UP
KFFCD:  LEAY -$2,Y
KFFCF:  BNE  KFFC4                  ;EQEND  END OF FIRST HALF
KFFD1:  TFR  D,X                    ;SAVE CURRENT CHECKSUM
KFFD3:  LDA  #$00
KFFD5:  STA  W_BANK                 ;SWITCH BANKS  back to bank 0: the next instruction is fetched from bank 0 at $FFD8
KFFD8:  .byte $1F, $10, $AE, $C1, $10, $8E, $20, $00
KFFE0:  .byte $E3, $81, $C9, $00, $89, $00, $B7, $46
KFFE8:  .byte $40, $31, $3E, $26, $F3, $7E, $00, $00
KFFF0:  .byte $00, $00
KFFF2:  .word K6024                 ;6809 vectors: SWI3, SWI2, FIRQ, IRQ, SWI, NMI, RESET - all through the cross-bank table
KFFF4:  .word K6024
KFFF6:  .word K6024
KFFF8:  .word irq_entry_b1
KFFFA:  .word K6024
KFFFC:  .word K6024
KFFFE:  .word K601E
