;The Empire Strikes Back (Atari, 1985) - annotated disassembly of the main
;program ROM, bank 0: $6000-$7FFF and $A000-$FFFF with W_BANK D7 = 0
;(MAME 'esb': the first halves of 136031-101.1f, -102.1jk, -203.1kl, -104.1m).
;Bank 1 is in esb_bank1_rom.asm; $8000-$9FFF is the slapstic window, in
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
; prog_start - start of the program ROM: a jump to RESET, kept from Star Wars where it let the development
;   system start the program, then the address of the IRQ entry
;------------------------------------------------------------------------------
prog_start:
L6000:  JMP  RESET
L6003:  .word irq_entry             ;address of the IRQ entry

;------------------------------------------------------------------------------
; irq_entry - the IRQ vector of both banks. U = the interrupted frame, then the IRQ handler proper, which is in
;   bank 0, then RTI. Bank 1's copy of this code reaches the handler through its cross-bank table entry
;------------------------------------------------------------------------------
irq_entry:
L6005:  LEAU ,S
L6007:  JSR  irq_handler
L600A:  RTI

;------------------------------------------------------------------------------
; xbank_call - cross-bank call, at the same address in both banks. Reached by JSR from an entry of the table
;   that follows, it flips W_BANK D7 by rotating the carry into it, so the next instruction is fetched from the
;   other bank's copy of this routine, which calls the address on the stack - the instruction after the table
;   entry's JSR, in the other bank a JMP to the routine - then flips the bank back and returns to the original
;   caller. Bank 0's copy sets D7 on the way out and bank 1's copy sets it on the way back, bank 1's copy clears
;   it on the way out and bank 0's on the way back
;------------------------------------------------------------------------------
xbank_call:
L600B:  ORCC #$01                   ;carry = 1: bank 1
L600D:  ROR  W_BANK                 ;into W_BANK D7, the next instruction comes from bank 1
L6010:  JSR  [,S++]                 ;(arriving from bank 1) call the JMP after the caller's table entry
L6012:  ORCC #$01                   ;carry = 1: back to bank 1
L6014:  ROR  W_BANK
L6017:  RTS                         ;(in bank 1 again) return to the original caller
L6018:  .byte $3F, $3F, $3F
L601B:  JMP  irq_handler
L601E:  .byte $3F, $3F, $3F
L6021:  JMP  RESET
L6024:  .byte $3F, $3F, $3F
L6027:  JMP  HANG
L602A:  .byte $3F, $3F, $3F
L602D:  JMP  WAITFRAME
L6030:  .byte $3F, $3F, $3F
L6033:  JMP  MESSON
L6036:  .byte $3F, $3F, $3F
L6039:  JMP  MESSOFF
L603C:  .byte $3F, $3F, $3F
L603F:  JMP  ALLOFF
L6042:  .byte $3F, $3F, $3F
L6045:  JMP  VWMESS
L6048:  .byte $3F, $3F, $3F
L604B:  JMP  VWMES2
L604E:  .byte $3F, $3F, $3F
L6051:  JMP  SPMON
L6054:  .byte $3F, $3F, $3F
L6057:  JMP  SPMOFF
L605A:  .byte $3F, $3F, $3F
L605D:  JMP  VWSPMS
L6060:  .byte $3F, $3F, $3F
L6063:  JMP  BGBNNR
L6066:  .byte $3F, $3F, $3F
L6069:  JMP  spmess_entry
L606C:  .byte $3F, $3F, $3F
L606F:  JMP  view_8dig
L6072:  .byte $3F, $3F, $3F
L6075:  JMP  view_6dig
L6078:  .byte $3F, $3F, $3F
L607B:  JMP  view_4dig
L607E:  .byte $3F, $3F
L6080:  .byte $3F
L6081:  JMP  VWBYTE
L6084:  .byte $3F, $3F, $3F
L6087:  JMP  VWBYT1
L608A:  .byte $3F, $3F, $3F
L608D:  JMP  VWBYT1
L6090:  .byte $3F, $3F, $3F
L6093:  JMP  do_message
L6096:  .byte $3F, $3F, $3F
L6099:  JMP  do_message_nc
L609C:  .byte $3F, $3F, $3F
L609F:  JMP  VWCURC
L60A2:  JSR  xbank_call             ;bank 1: obj_list_init
L60A5:  .byte $3F, $3F, $3F
L60A8:  JSR  xbank_call             ;bank 1: obj_load_b
L60AB:  .byte $3F, $3F, $3F
L60AE:  JSR  xbank_call             ;bank 1: obj_load
L60B1:  .byte $3F, $3F, $3F
L60B4:  JSR  xbank_call             ;bank 1: BJCNTR_6761
L60B7:  .byte $3F, $3F, $3F
L60BA:  JSR  xbank_call             ;bank 1: obj_beam_home
L60BD:  .byte $3F, $3F, $3F
L60C0:  JSR  xbank_call             ;bank 1: BJLNV_6782
L60C3:  .byte $3F, $3F, $3F
L60C6:  JSR  xbank_call             ;bank 1: BJLNB_67AA
L60C9:  .byte $3F, $3F, $3F
L60CC:  JSR  xbank_call             ;bank 1: pnt_buf_reset
L60CF:  .byte $3F, $3F, $3F
L60D2:  JSR  xbank_call             ;bank 1: JOBJBPNT
L60D5:  .byte $3F, $3F, $3F
L60D8:  JSR  xbank_call             ;bank 1: obj_points
L60DB:  .byte $3F, $3F, $3F
L60DE:  JSR  xbank_call             ;bank 1: pnt_add_scratch
L60E1:  .byte $3F, $3F, $3F
L60E4:  JSR  xbank_call             ;bank 1: obj_draw
L60E7:  .byte $3F, $3F, $3F
L60EA:  JSR  xbank_call             ;bank 1: obj_draw_b
L60ED:  .byte $3F, $3F, $3F
L60F0:  JSR  xbank_call             ;bank 1: view_title_logo
L60F3:  .byte $3F, $3F, $3F
L60F6:  JSR  xbank_call             ;bank 1: hs_view
L60F9:  .byte $3F, $3F, $3F
L60FC:  JSR  xbank_call             ;bank 1: hs_rank_step
L60FF:  .byte $3F, $3F, $3F
L6102:  JSR  xbank_call             ;bank 1: hs_insert
L6105:  .byte $3F, $3F, $3F
L6108:  JSR  xbank_call             ;bank 1: GETINT
L610B:  .byte $3F, $3F, $3F
L610E:  JSR  xbank_call             ;bank 1: hs_load
L6111:  .byte $3F, $3F, $3F
L6114:  JSR  xbank_call             ;bank 1: hs_validate
L6117:  .byte $3F, $3F, $3F
L611A:  JSR  xbank_call             ;bank 1: hs_nv_defaults
L611D:  .byte $3F, $3F, $3F
L6120:  JSR  xbank_call             ;bank 1: acct_page_view
L6123:  .byte $3F, $3F, $3F
L6126:  JSR  xbank_call             ;bank 1: coin_acct_upd
L6129:  .byte $3F, $3F, $3F
L612C:  JSR  xbank_call             ;bank 1: EEACCT
L612F:  .byte $3F, $3F, $3F
L6132:  JSR  xbank_call             ;bank 1: time_on_upd
L6135:  .byte $3F, $3F, $3F
L6138:  JSR  xbank_call             ;bank 1: EECKSM
L613B:  .byte $3F, $3F, $3F
L613E:  JSR  xbank_call             ;bank 1: ee_area_sum
L6141:  .byte $3F, $3F, $3F
L6144:  JSR  xbank_call             ;bank 1: ee_init
L6147:  .byte $3F, $3F, $3F
L614A:  JSR  xbank_call             ;bank 1: ee_area_check
L614D:  .byte $3F, $3F, $3F
L6150:  JSR  xbank_call             ;bank 1: ee_opts_check
L6153:  .byte $3F, $3F, $3F
L6156:  JSR  xbank_call             ;bank 1: opt_page_view
L6159:  .byte $3F, $3F, $3F
L615C:  JSR  xbank_call             ;bank 1: opt_page_change
L615F:  .byte $3F, $3F, $3F
L6162:  JSR  xbank_call             ;bank 1: EEOPT3
L6165:  .byte $3F, $3F, $3F
L6168:  JSR  xbank_call             ;bank 1: EETMP2
L616B:  .byte $3F, $3F, $3F
L616E:  JSR  xbank_call             ;bank 1: ISTAR
L6171:  .byte $3F, $3F, $3F
L6174:  JSR  xbank_call             ;bank 1: ISTARG
L6177:  .byte $3F, $3F, $3F
L617A:  JSR  xbank_call             ;bank 1: JVWSTAR
L617D:  .byte $3F, $3F, $3F
L6180:  JSR  xbank_call             ;bank 1: JVWSTRG
L6183:  .byte $3F, $3F, $3F
L6186:  JSR  xbank_call             ;bank 1: expl_clear
L6189:  .byte $3F, $3F, $3F
L618C:  JSR  xbank_call             ;bank 1: tie_expl_begin
L618F:  .byte $3F, $3F, $3F
L6192:  JSR  xbank_call             ;bank 1: atat_expl_begin
L6195:  .byte $3F, $3F, $3F
L6198:  JSR  xbank_call             ;bank 1: probot_expl_begin
L619B:  .byte $3F, $3F, $3F
L619E:  JSR  xbank_call             ;bank 1: expl_stub_rts
L61A1:  .byte $3F, $3F, $3F
L61A4:  JSR  xbank_call             ;bank 1: atst_expl_begin
L61A7:  .byte $3F, $3F, $3F
L61AA:  JSR  xbank_call             ;bank 1: DOXPLD
L61AD:  .byte $3F, $3F, $3F
L61B0:  JSR  xbank_call             ;bank 1: VWXPLD
L61B3:  .byte $3F, $3F, $3F

;------------------------------------------------------------------------------
; WAITFRAME - the main loop, Star Wars's WAITFRAME and MAIN which the matcher missed. waits for the IRQ to set
;   GMSYNC, once per game frame. if the stack is not at its top a phase routine has called this loop to wait a
;   frame and it returns into that routine. otherwise it reads the gun switches and their edges (this part was in
;   IFRAME in Star Wars), handles the freeze option, where holding left fire steps frames at a growing rate, calls
;   IFRAME and then the routine of the current phase through TPHASE
;------------------------------------------------------------------------------
WAITFRAME:
L61B6:  LDX  #$0000                 ;kept from Star Wars, where X and D talked to the development system
L61B9:  ORCC #$50                   ;no IRQ or FIRQ while the direct page register is loaded
L61BB:  LDD  #$F800
L61BE:  LDA  #$48                   ;direct page $48
L61C0:  TFR  A,DP
L61C2:  ANDCC #$AF
L61C4:  LSR  GMSYNC                 ;bit 0 of GMSYNC is set by the IRQ when a game frame is due
L61C6:  BCC  WAITFRAME
L61C8:  CMPS #$4FFF                 ;stack not at its top: a phase routine called this loop to wait for a frame
L61CC:  BEQ  L61CF
L61CE:  RTS                         ;so return into it
;GET EDGE OF SWITCHES-- LFIRE,RFIRE,AUX,TEST,COINS
L61CF:  LDA  GN_SWN                 ;PREVIOUS NEW VALUE
L61D1:  STA  GN_SWO                 ;IS CURRENT OLD VALUE
L61D3:  LDA  R_THMB
L61D5:  ANDA #THMBT                 ;ISOLATE THUMB BITS
L61D7:  PSHS A                      ;TEMP
L61D9:  LDA  R_FIRE                 ;GET THIS NEWEST VALUE
L61DB:  ANDA #-1-THMBT              ;OPEN UP SPACE FOR THUMBS
L61DD:  ORA  ,S+                    ;ORA WITH POP
L61DF:  ANDA #FIREBT|THMBT|AUXBIT   ;ONLY CONCERNED WITH GUN CONTROLS
L61E1:  STA  GN_SWN                 ;AND SAY SO
L61E3:  EORA GN_SWO                 ;CATCH ANY CHANGES
L61E5:  ANDA GN_SWO                 ;FROM AN OLD '1'
L61E7:  STA  GN_SWE                 ;1==>FALLING EDGE (WENT ON)
L61E9:  LDA  PT_DLY                 ;pot filter still settling after power on: no freeze
L61EB:  BNE  L6226
L61ED:  LDA  >R_OPT2                ;freeze option: bit 7 set = run normally
L61F0:  ANDA #$80
L61F2:  BNE  L6226
L61F4:  LDA  GN_SWO                 ;frozen. left fire (bit 7, active low) up on the frame before?
L61F6:  BITA #$80
L61F8:  BEQ  L6204
L61FA:  LDA  #$02                   ;then rearm: the next press steps at once
L61FC:  STA  step_delay
L61FF:  LDA  #$0A                   ;and its first repeat comes after 10 frame times
L6201:  STA  step_rate
L6204:  DEC  step_delay             ;count the delay down
L6207:  LBNE WAITFRAME              ;not run out, or fire not held: no game frame
L620B:  LDA  step_rate              ;step one frame: reload the delay
L620E:  STA  step_delay
L6211:  SUBA #$02                   ;and shorten the next delay by 2, not below 2
L6213:  BHI  L6217
L6215:  LDA  #$02
L6217:  STA  step_rate
L621A:  LDA  VG_LON                 ;the stepped frame sees no left fire: clear its lasers-on bit
L621C:  ANDA #$7F
L621E:  STA  VG_LON
L6220:  LDA  GN_SWE                 ;and its edge
L6222:  ANDA #$7F
L6224:  STA  GN_SWE
L6226:  JSR  IFRAME                 ;frame counter, coin sound, high score place, cursor
L6229:  LDB  PHASE                  ;Star Wars's MAIN: run the routine of the current phase
L622B:  CMPB #$4D                   ;77 phases
L622D:  BCC  L622D                  ;die on a bad phase
L622F:  LDX  #TPHASE
L6232:  ABX
L6233:  ABX
L6234:  JSR  [,X]
L6236:  JMP  WAITFRAME              ;next frame

TPHASE:
L6239:  .word PHERES                ;phase $00: reset - pot limits, attract mode variables, high scores from NVRAM
L623B:  .word PHIBNR                ;phase $01 (PHS_BNR): banner (title), init
L623D:  .word PHEBNR                ;phase $02: banner, execute - until the banner counter reaches $200
L623F:  .word PHISCR                ;phase $03: scoring page, init
L6241:  .word PHESCR                ;phase $04: scoring page, execute
L6243:  .word PHIINS                ;phase $05: flight instructions, init
L6245:  .word PHEINS                ;phase $06: flight instructions, execute
L6247:  .word team_page_init        ;phase $07: design team page (message $01), init
L6249:  .word team_page_exec        ;phase $08: design team page, execute
L624B:  .word PHIHIS                ;phase $09 (PHS_HIS): high score table, init
L624D:  .word PHEHIS                ;phase $0A: high score table, execute - then back to phase $01
L624F:  .word PHISG1                ;phase $0B: start game part 1, init - entered from STRTCK when the start switch is accepted
L6251:  .word PHESG1                ;phase $0C: start game part 1, execute - reset the per-game variables, then phase $0D
L6253:  .word sel_wave_init         ;phase $0D: select the starting wave, init - message $2B, three wave planets and two instructions planets
L6255:  .word sel_wave_exec         ;phase $0E: select the starting wave, execute - cursor on a planet and fire, or the countdown ends, then phase $0F
L6257:  .word launch_init           ;phase $0F: opening text, init - display list set 0, stars, sounds, falls into phase $10
L6259:  .word launch_exec           ;phase $10: opening text, execute - message $2C (Darth Vader's Executor is searching) for 100 frames, then phase $13
L625B:  .word cont_offer_init       ;phase $11: continue offer, shown when a continue wave of 4 or more is on record, init - message $2D, you may start your next game on wave n
L625D:  .word cont_offer_exec       ;phase $12: continue offer, execute - fire on the planet with a credit starts at that wave (phase $13), after $200 frames back to phase $01
L625F:  .word PHISG2                ;phase $13: start game part 2, init - parameters, stars, score, bonus counts, falls into phase $14
L6261:  .word PHESG2                ;phase $14: start game part 2, execute - on to phase $15
L6263:  .word begin_act_init        ;phase $15 (PHS_BGN): begin a wave, init - wave number for the display, the level of each of the four parts from GM_WAV, falls into phase $16
L6265:  .word begin_act_exec        ;phase $16: begin a wave, execute - on to phase $17
L6267:  .word wave1_init            ;phase $17: probot part, entry - display list set 1, wave_type = 0, then the training manual (phase $43) if it was selected, else falls into the setup of phase $45
L6269:  .word wave1_leadin          ;phase $18: probot part, fly in - 40 frames without shooting, then phase $19
L626B:  .word wave1_level_init      ;phase $19: probot part, init - enemy skill level from wave and difficulty adder, falls into phase $1A
L626D:  .word wave1_exec            ;phase $1A: probot part, execute - until $4CA1 reaches 4, then phase $1B
L626F:  .word wave1_end_init        ;phase $1B: probot part, second stage, init - a speech line chosen by the wave, falls into phase $1C
L6271:  .word wave1_end_exec        ;phase $1C: probot part, second stage, execute - until $4C69 is 0, then phase $1D
L6273:  .word wave1_exit_init       ;phase $1D: probot part, exit, init
L6275:  .word wave1_exit_exec       ;phase $1E: probot part, exit, execute - 40 to 80 frames, then phase $1F
L6277:  .word wave2_init            ;phase $1F: walker part, entry - display list set 1, wave_type = 1, then the training manual (phase $43) if selected, else into the setup of phase $46 past its parameter init
L6279:  .word wave2_exec            ;phase $20: walker part, execute - until $4CA3 reaches $190, then phase $21
L627B:  .word wave2_end_init        ;phase $21 (PHS_SP2): walker part, second stage, init - falls into phase $22
L627D:  .word wave2_end_exec        ;phase $22: walker part, second stage, execute - until $4C6A and $4C6B are 0, then phase $23
L627F:  .word wave2_exit_init       ;phase $23: walker part, exit, init - music, falls into phase $24
L6281:  .word wave2_exit_exec       ;phase $24: walker part, exit, execute - 40 frames, then phase $25
L6283:  .word wave3_init            ;phase $25: TIE fighter part, entry - display list set 2, wave_type = 2, then the training manual (phase $43) if selected, else falls into the setup of phase $47
L6285:  .word wave3_exec            ;phase $26: TIE fighter part, execute - 440 frames, a new fighter whenever fewer than 3 are alive, then phase $27
L6287:  .word phi_tie_flee          ;phase $27: TIE fighters leave, init - nothing to set up, falls into phase $28
L6289:  .word phe_tie_flee          ;phase $28: TIE fighters leave, execute - until none is left and the player has turned, then phase $29
L628B:  .word phi_tie_exit          ;phase $29: TIE fighter part, exit, init
L628D:  .word phe_tie_exit          ;phase $2A: TIE fighter part, exit, execute - until $4CCC is down to -$208, then phase $2B
L628F:  .word phi_asteroids         ;phase $2B: asteroid part, entry - display list set 2, wave_type = 3, then the training manual (phase $43) if selected, else into the setup of phase $48 past its parameter init
L6291:  .word phe_asteroids         ;phase $2C: asteroid part, execute - 300 frames (400 from wave 3 on), then phase $2D
L6293:  .word phi_jedi_award        ;phase $2D: asteroid field passed, init - awards a Jedi letter, falls into phase $2E
L6295:  .word phe_jedi_award        ;phase $2E: asteroid field passed, execute - message $4D (5,000 points and Jedi letter awarded) for 70 frames, then phase $2F
L6297:  .word ph_to_set_done        ;phase $2F: sets phase $31 and falls into its routine
L6299:  .word ph_to_set_done        ;phase $30: the same routine as phase $2F, no code found that enters it
L629B:  .word phi_set_done          ;phase $31: wave completed, init - messages off, wave completed score, falls into phase $32
L629D:  .word phe_set_done          ;phase $32: wave completed, execute - $80 frames, in the first wave of a game the starting wave bonus at frame $40, then phase $33
L629F:  .word phi_next_set          ;phase $33: next wave, init - parameters restored, the four shoot-for-bonus counts raised, wave and score saved for the continue offer, falls into phase $34
L62A1:  .word phe_next_set          ;phase $34: next wave, execute - GM_WAV + 1, difficulty adder raised in the first three waves, back to phase $15
L62A3:  .word phi_probot_die        ;phase $35 (PHS_S0D): shields gone in the probot part, init - falls into phase $36
L62A5:  .word phe_probot_die        ;phase $36: shields gone in the probot part, execute - 40 frames with the growing game over message, then phase $3F
L62A7:  .word phi_walker_die        ;phase $37 (PHS_G0D): shields gone in the walker part, init - falls into phase $38
L62A9:  .word phe_walker_die        ;phase $38: shields gone in the walker part, execute - 40 frames, then phase $3F
L62AB:  .word phi_tie_die           ;phase $39 (PHS_B0D): shields gone in the TIE fighter part, init - falls into phase $3A
L62AD:  .word phe_tie_die           ;phase $3A: shields gone in the TIE fighter part, execute - the ship rolls for 40 frames, then phase $3F
L62AF:  .word phi_astrd_die         ;phase $3B: shields gone in the asteroid part, init - falls into phase $3C
L62B1:  .word phe_astrd_die         ;phase $3C: shields gone in the asteroid part, execute - the ship rolls for 40 frames, then phase $3F
L62B3:  .word phi_die_plain         ;phase $3D: game over over a plain screen, init - no code found that enters it
L62B5:  .word phe_die_plain         ;phase $3E: game over over a plain screen, execute - 40 frames, then phase $3F
L62B7:  .word PHIEGM                ;phase $3F (PHS_EGM): end of game, init - falls into phase $40
L62B9:  .word PHEEGM                ;phase $40: end of game, execute - bookkeeping, then phase $41 on a new high score, else phase $11 if a continue wave of 4 or more is on record, else phase $01
L62BB:  .word PHIENT                ;phase $41: enter initials, init
L62BD:  .word PHEENT                ;phase $42: enter initials, execute - then phase $11 if a continue wave of 4 or more is on record, else phase $09
L62BF:  .word phi_manual            ;phase $43: rebel training manual for the coming part, init
L62C1:  .word phe_manual            ;phase $44: rebel training manual, execute - $190 frames or until $4CB8 is set, then phase $45 + wave_type
L62C3:  .word wave1_setup           ;phase $45: probot part setup after the training manual - also the tail of phase $17, ends in phase $18
L62C5:  .word wave2_setup           ;phase $46: walker part setup after the training manual - phase $1F enters it part way, ends in phase $20
L62C7:  .word wave3_setup           ;phase $47: TIE fighter part setup after the training manual - also the tail of phase $25, ends in phase $26
L62C9:  .word asteroid_setup        ;phase $48: asteroid part setup after the training manual - phase $2B enters it part way, ends in phase $2C
L62CB:  .word PHISTS                ;phase $49: statistics, init - entered from TSTCK when the self test switch is on
L62CD:  .word PHESTS                ;phase $4A: statistics, execute - aux switch goes to phase $4B, test switch off to phase $01
L62CF:  .word PHIOPT                ;phase $4B: option settings, init
L62D1:  .word PHEOPT                ;phase $4C: option settings, execute - aux switch resets the game, test switch off goes to phase $01

;------------------------------------------------------------------------------
; IFRAME - Star Wars's IFRAME, init game frame, without the switch reading that moved into the main loop: steps
;   the 16-bit frame counter, sends the coin sound command once when the first credit appears, has bank 1 move the
;   player's place in the high score table (KE209) and pulls the cursor position from the IRQ's pot values
;------------------------------------------------------------------------------
IFRAME:
L62D3:  INC  FRAMEL
L62D5:  BNE  L62DF
L62D7:  INC  FRAME
L62D9:  BNE  L62DF
L62DB:  LDA  #$80                   ;the frame word overflowed: its high byte restarts at $80
L62DD:  STA  FRAME
L62DF:  LDA  S_S_CRDT               ;credits
L62E1:  BNE  L62E8
L62E3:  STA  coin_spoken            ;none: the coin sound may be made again
L62E6:  BRA  L6303
L62E8:  LDA  coin_spoken            ;sound already made for these credits?
L62EB:  BNE  L62F7
L62ED:  JSR  spk_cmd_0a             ;first credit: send the sound command of spk_cmd_0a
L62F0:  LDA  S_S_CRDT               ;remember the credits it was made for
L62F2:  STA  coin_spoken
L62F5:  BRA  L6303
L62F7:  LDA  coin_spoken            ;more credits than then?
L62FA:  CMPA S_S_CRDT
L62FC:  BCC  L6303
L62FE:  LDA  #$FF                   ;then $FF: nothing more until the credits are gone
L6300:  STA  coin_spoken
L6303:  JSR  L60FC                  ;bank 1 KE209: step the player's high score place up when the score has reached the next entry
L6306:  JSR  VGTOSITE               ;cursor position from the IRQ's pot values
L6309:  RTS

;------------------------------------------------------------------------------
; IPARM - Star Wars' IPARM, which the matcher missed: init the general parameters (init_general) and the
;   player's ship (NW1SHP)
;------------------------------------------------------------------------------
IPARM:
L630A:  JSR  init_general
L630D:  JSR  NW1SHP
L6310:  RTS

;------------------------------------------------------------------------------
; init_general - the three parts of Star Wars's IPGEN, now in three places: random generator check and math box
;   constants (IPGEN), bank 1's clear of the object list (JINOBJ) and page 1's init of the gun shot blocks
;   (P1_8EFC)
;------------------------------------------------------------------------------
init_general:
L6311:  JSR  IPGEN                  ;random generator check and math box constants
L6314:  JSR  L60A2                  ;bank 1 JINOBJ: clear the object list
L6317:  JSR  MZ_812D                ;calls page 1 gun_init
L631A:  RTS

;------------------------------------------------------------------------------
; STRTCK - CHECK FOR START SWITCH AND SELF TEST ( STATS )
;   THIS ROUTINE SHOULD ONLY BE CALLED DURING ATTRACT PHASES
;   in ESB: the sight at the extreme left goes to the scoring page (phases $03 and $04), at the extreme right
;   to the high score table. free play gives 2 credits
;------------------------------------------------------------------------------
STRTCK:
L631B:  LDB  SI_RSX                 ;SITE POSITION X
L631D:  CMPB #$A0                   ;EXTREME LEFT?
L631F:  BGT  L632C                  ;at the extreme left the attract mode goes to the scoring page
L6321:  LDA  #$04                   ;phase $04 here is the scoring page
L6323:  CMPA PHASE                  ;ALREADY THERE?
L6325:  BEQ  L632A                  ;IFNE  NO, THEN GO THERE
L6327:  DECA                        ;INITIALIZER FRO THE PHASE
L6328:  STA  PHASE
L632A:  BRA  L6339                  ;ELSE
L632C:  CMPB #$60                   ;EXTREME RIGHT?
L632E:  BLT  L6339                  ;IFGE  YES, THEN MAYBE WE'LL GO TO HIGH SCORE TABLE
L6330:  LDA  #PHS_HIS+1
L6332:  CMPA PHASE                  ;ALREADY THERE?
L6334:  BEQ  L6339                  ;IFNE  NOPE, OK DOIT
L6336:  DECA                        ;INITIALIZER
L6337:  STA  PHASE
L6339:  LDA  OPTS0                  ;LOW NIBBLE OF COIN OPTIONS
L633C:  ANDA #$03                   ;COIN MODE
L633E:  BNE  L6344                  ;IFEQ  FREE PLAY
L6340:  LDA  #$02                   ;GIVE FREE CREDIT ( NO 2 COIN MINIMUM )
L6342:  STA  S_S_CRDT
L6344:  LDA  S_S_CRDT
L6346:  BEQ  TSTCK                  ;IFNE  MAYBE WE'LL START A GAME
L6348:  LDA  GN_SWE                 ;SWITCH EDGES
L634A:  ANDA #STRTBT                ;START SWITCH(ES)?
L634C:  BEQ  TSTCK                  ;IFNE  YES, OH BOY!!
L634E:  LDA  #$0B                   ;START THE GAME
L6350:  STA  PHASE
L6352:  DEC  S_S_CRDT

TSTCK:
L6354:  LDA  >IN_SW0                ;CHECK FOR SELF-TEST SWITCH
L6357:  ANDA #TESTBT
L6359:  BNE  L635F                  ;IFEQ  GO TO STATS PHASE
L635B:  LDA  #$49                   ;statistics phase
L635D:  STA  PHASE
L635F:  RTS

;------------------------------------------------------------------------------
; PHERES - RESET
;------------------------------------------------------------------------------
PHERES:
L6360:  ORCC #$10                   ;SEI
L6362:  LDX  #POTSAV                ;the four pot limits saved in NVRAM
L6365:  LEAS -16,S                  ;16 bytes of stack to read them into
L6367:  LEAU ,S
L6369:  JSR  L6168                  ;bank 1 EETMP2: the 4 bytes at X, a plain copy from the byte-wide NVRAM image, to U
L636C:  LEAX ,S
L636E:  JSR  PHERES_100
L6371:  STA  >RHEOP+RHS_LO
L6374:  LEAX 1,S
L6376:  JSR  PHERES_100
L6379:  STA  >RHEOP+RHS_SP
L637C:  LEAX 2,S
L637E:  JSR  PHERES_100
L6381:  STA  >RHEOY+RHS_LO
L6384:  LEAX 3,S
L6386:  JSR  PHERES_100
L6389:  STA  >RHEOY+RHS_SP
L638C:  LEAS $10,S
L638F:  ANDCC #$EF                  ;CLI
L6391:  LDA  #PHS_HIS               ;attract mode starts at the high score table
L6393:  STA  PHASE
L6395:  LDA  #$FF                   ;DON'T PLAY MUSIC ON POWER UP
L6397:  STA  MUSTIM
L639A:  JSR  IPGEN
L639D:  JSR  IPARM
L63A0:  LDB  #$00                   ;display list set 0
L63A2:  JSR  load_vg_set            ;copy that set from ROM to vector RAM
L63A5:  JSR  L616E
L63A8:  JSR  MZ_842D                ;calls page 1 jedi_clear
L63AB:  JSR  ALLOFF                 ;TURN ALL MESSAGES OFF
L63AE:  LDA  #$00
L63B0:  STA  S_SC87
L63B2:  STA  S_SC65
L63B4:  STA  S_SC43
L63B6:  STA  S_SC21
L63B8:  STA  GS_GLW
L63BA:  STA  GS_HIT
L63BC:  STA  GM_WAV                 ;wave 1
L63BF:  LDA  #$01                   ;wave number 1 for the display
L63C1:  STA  wave_bcd
L63C4:  JSR  L610E                  ;bank 1 KE3E8: high scores and initials from NVRAM, checked
L63C7:  LDD  #$FFFF                 ;no initials being entered
L63CA:  STD  UPDFLG
L63CD:  STA  >MOOTIM
L63D0:  LDA  #$18                   ;place 25: the player's score is below the whole high score table
L63D2:  STA  rank_index
L63D5:  RTS

;------------------------------------------------------------------------------
; PHERES_100 - adjust one saved pot limit for PHERES: X points at the saved byte, A returns the value to use. a
;   saved value of $40 or more gives $40, a lower one is moved up by an eighth of its distance to $40 plus 1
;------------------------------------------------------------------------------
PHERES_100:          ;ADJUST THE POTS
L63D6:  LDA  #$40                   ;ADJUST VALUES
L63D8:  CMPA ,X
L63DA:  BLS  L63E4                  ;IFHI
L63DC:  SUBA ,X
L63DE:  LSRA
L63DF:  LSRA
L63E0:  LSRA
L63E1:  INCA
L63E2:  ADDA ,X
L63E4:  RTS

;------------------------------------------------------------------------------
; PHIBNR - phase $01, Star Wars's PHIBNR which the matcher missed: init of the banner (title) phase. loads
;   display list set 0, turns the messages off, starts the banner, restores the math box and the ship, and about
;   every 6.7 minutes, if the attract music option is on, starts one of the five tunes of TMUSIC at random
;------------------------------------------------------------------------------
PHIBNR:
L63E5:  INC  PHASE
L63E7:  LDB  #$00                   ;display list set 0
L63E9:  JSR  load_vg_set
L63EC:  JSR  ALLOFF                 ;TURN OFF ALL MESSAGES
L63EF:  LDD  #$0000                 ;SET Y OFFSETS FOR MESSAGES TO 0
L63F2:  STD  PH_YOF
L63F5:  STD  >MSYOFF
L63F8:  STD  PH_TIM
L63FB:  JSR  BGBNNR
L63FE:  JSR  IPGEN
L6401:  JSR  IPARM
L6404:  LDU  #M_U1                  ;STARS ASSUME UV1 MATRIX
L6407:  JSR  UNITV                  ;SETUP FACING FORWARD
L640A:  LDA  MUSTIM
L640D:  CMPA #$FF                   ;SPECIAL FLAG FOR SKIPPING MUSIC THIS TIME
L640F:  BNE  L6419                  ;IFEQ  SKIP IT
L6411:  LDA  TIMER+2                ;PREPARE FOR NEXT CYCLE
L6414:  STA  MUSTIM
L6417:  BRA  L643A                  ;ELSE
L6419:  LDA  TIMER+2
L641C:  CMPA MUSTIM
L641F:  BEQ  L643A                  ;IFNE  APROX 6.66666 MINS.
L6421:  STA  MUSTIM                 ;FOR NEXT TIME
L6424:  JSR  L6132
L6427:  LDA  OPTS1
L642A:  ANDA #$40
L642C:  BEQ  L643A
L642E:  LDX  #TMUSIC
L6431:  LDA  P_RND1
L6434:  LDB  #$05                   ;# OF ENTRIES
L6436:  MUL
L6437:  LSLA                        ;WORD POINTER
L6438:  JSR  [A,X]
L643A:  RTS

TMUSIC:
L643B:  .word tune_cmd_2a, tune_cmd_31, tune_cmd_2e, tune_cmd_29
L6443:  .word tune_cmd_2b

;------------------------------------------------------------------------------
; PHEBNR - phase $02, Star Wars's PHEBNR which the matcher missed: one frame of the banner phase. draws the
;   stars, the banner (bank 1 K66D0), the special messages, the coin lines, the score line and the Jedi letters,
;   moves the stars, flashes the Jedi letters and checks the start and test switches. new in this game: when the
;   banner counter reaches $200 it goes on to the scoring page
;------------------------------------------------------------------------------
PHEBNR:
L6445:  JSR  ivgen1_wait            ;wait for the display buffer, Y = display list pointer
L6448:  JSR  L617A                  ;bank 1 JVWSTAR: view the stars
L644B:  JSR  L60F0
L644E:  JSR  VWSPMS                 ;special messages that go with the banner
L6451:  JSR  VWCOIN
L6454:  JSR  vw_score_all           ;score line
L6457:  JSR  MZ_816C                ;calls page 1 jedi_draw
L645A:  JSR  VGDONE
L645D:  JSR  SMVBNR                 ;move the stars for the banner
L6460:  JSR  MZ_8403                ;calls page 1 jedi_time_run
L6463:  LDA  jedi_blink             ;every 32 frames
L6466:  ANDA #$1F
L6468:  BNE  L6472
L646A:  LDA  jedi_show              ;flash the Jedi letters: display state 2 (shown) or 0 (off)
L646D:  EORA #$02
L646F:  STA  jedi_show
L6472:  JSR  STRTCK
L6475:  LDD  BN_CNT                 ;frames of banner so far
L6478:  CMPD #$0200
L647C:  BCS  L6480
L647E:  INC  PHASE                  ;$200: on to the scoring page
L6480:  RTS

;------------------------------------------------------------------------------
; PHIINS - INSTRUCTION PAGE
;------------------------------------------------------------------------------
PHIINS:
L6481:  LDD  #$0000                 ;WAS 380 FOR SCROLLING
L6484:  STD  PH_YOF                 ;PHASE Y OFFSET
L6487:  LDD  #$0000                 ;phase timer counts up from 0
L648A:  STD  PH_TIM
L648D:  LDA  #$15                   ;"FLIGHT INSTRUCTIONS..."
L648F:  STA  NXTMES
L6492:  LDA  #$20                   ;one past the last line of the page
L6494:  STA  LSTMES
L6497:  LDD  #VGCOLR+(VGCRED*$100)  ;RED
L649A:  STD  PH_COL
L649D:  JSR  ALLOFF                 ;TURN OFF ALL MESSAGES
L64A0:  INC  PHASE
L64A2:  RTS

;------------------------------------------------------------------------------
; PHEINS - phase $06, Star Wars' PHEINS changed: one frame of the flight instructions page. score, coin lines,
;   the page (view_ins_page), stars and Jedi letters, the stars move sideways. when view_ins_page has set the
;   timer to $200 it goes on to the design team page. flashes the Jedi letters and checks the start and test
;   switches
;------------------------------------------------------------------------------
PHEINS:
L64A3:  JSR  ivgen1_wait
L64A6:  JSR  vw_score_all
L64A9:  JSR  VWCOIN
L64AC:  JSR  view_ins_page
L64AF:  JSR  L617A
L64B2:  JSR  MZ_816C                ;calls page 1 jedi_draw
L64B5:  JSR  VGDONE
L64B8:  JSR  SMVINS
L64BB:  LDD  PH_TIM                 ;view_ins_page sets the timer to $200 when the page has faded
L64BE:  CMPD #$0200
L64C2:  BCS  L64C6
L64C4:  INC  PHASE                  ;then on to the design team page
L64C6:  JSR  MZ_8403                ;calls page 1 jedi_time_run
L64C9:  LDA  jedi_blink             ;every 32 frames flash the Jedi letters
L64CC:  ANDA #$1F
L64CE:  BNE  L64D8
L64D0:  LDA  jedi_show
L64D3:  EORA #$02
L64D5:  STA  jedi_show
L64D8:  JSR  STRTCK
L64DB:  RTS

;------------------------------------------------------------------------------
; view_ins_page - view the flight instructions page for PHEINS, a copy of VWPAGE without the scroll: counts the
;   phase timer up, turns on the next line every 8 frames, puts the shield count digit of the option switches into
;   the line that names it, fades the messages out from frame $140 and sets the timer to $200 when they are dark,
;   which ends the phase
;------------------------------------------------------------------------------
view_ins_page:
L64DC:  LDD  PH_TIM                 ;phase timer counts up
L64DF:  ADDD #$0001
L64E2:  STD  PH_TIM
L64E5:  ANDB #$07                   ;every 8 frames turn on the next line
L64E7:  BNE  L6511
L64E9:  LDB  NXTMES
L64EC:  BMI  L64F1
L64EE:  JSR  MESSON
L64F1:  LDA  NXTMES
L64F4:  CMPA #$17
L64F6:  BNE  L6502
L64F8:  LDB  OPTS1                  ;shield option 0-3
L64FB:  ANDB #$03
L64FD:  ADDB #$20                   ;messages $20-$23 are the digits 2-5 that go into that line
L64FF:  JSR  MESSON
L6502:  LDA  NXTMES
L6505:  ADDA #$01
L6507:  CMPA LSTMES
L650A:  BCS  L650E
L650C:  LDA  #$80                   ;$80: no more lines
L650E:  STA  NXTMES
L6511:  LDD  PH_TIM
L6514:  CMPD #$0140                 ;from frame $140 fade the page out
L6518:  BCS  L652E
L651A:  LDB  ph_col_brt             ;brightness the message drawing uses
L651D:  SUBB #$01
L651F:  CMPB #$08                   ;below 8 is dark enough
L6521:  BCC  L652B
L6523:  LDD  #$0200                 ;the timer value that ends the phase
L6526:  STD  PH_TIM
L6529:  LDB  #$00
L652B:  STB  ph_col_brt
L652E:  LDD  PH_YOF
L6531:  STD  >MSYOFF
L6534:  JSR  VWMES2
L6537:  RTS

;------------------------------------------------------------------------------
; PHISCR - phase $03, Star Wars's PHISCR which the matcher missed: init of the scoring page. the page starts
;   $3C0 down and scrolls up, lines are messages $24 to $2A
;------------------------------------------------------------------------------
PHISCR:
L6538:  LDD  #$03C0                 ;the page starts $3C0 down and scrolls up
L653B:  STD  PH_YOF
L653E:  LDD  #$0000
L6541:  STD  PH_TIM
L6544:  LDA  #$80                   ;"SCORING"
L6546:  STA  ph_col_brt             ;messages at full brightness
L6549:  LDA  #$24                   ;first line of the page, "rebel scoring"
L654B:  STA  NXTMES
L654E:  LDA  #$2B                   ;one past its last line
L6550:  STA  LSTMES
L6553:  JSR  ALLOFF
L6556:  INC  PHASE
L6558:  RTS

;------------------------------------------------------------------------------
; PHESCR - phase $04, Star Wars' PHESCR changed: one frame of the scoring page. score, coin lines, the page
;   (VWPAGE), stars and Jedi letters, the stars move up. when VWPAGE has set the timer to $200 it goes on to the
;   flight instructions. flashes the Jedi letters and checks the start and test switches
;------------------------------------------------------------------------------
PHESCR:
L6559:  JSR  ivgen1_wait
L655C:  JSR  vw_score_all
L655F:  JSR  VWCOIN
L6562:  JSR  VWPAGE
L6565:  JSR  L617A
L6568:  JSR  MZ_816C                ;calls page 1 jedi_draw
L656B:  JSR  VGDONE
L656E:  JSR  SMVSCR
L6571:  LDD  PH_TIM                 ;VWPAGE sets the timer to $200 when the page has faded
L6574:  CMPD #$0200
L6578:  BCS  L657C
L657A:  INC  PHASE                  ;then on to the flight instructions
L657C:  JSR  MZ_8403                ;calls page 1 jedi_time_run
L657F:  LDA  jedi_blink             ;every 32 frames flash the Jedi letters
L6582:  ANDA #$1F
L6584:  BNE  L658E
L6586:  LDA  jedi_show
L6589:  EORA #$02
L658B:  STA  jedi_show
L658E:  JSR  STRTCK
L6591:  RTS

;------------------------------------------------------------------------------
; VWPAGE - Star Wars's VWPAGE which the matcher missed, here used by the scoring page only: counts the phase
;   timer up (it counted down in Star Wars), turns on the next line every 8 frames, scrolls the page up 8 units a
;   frame until its offset is 0, fades the messages out from frame $140 and sets the timer to $200 when they are
;   dark, which ends the phase
;------------------------------------------------------------------------------
VWPAGE:
L6592:  LDD  PH_TIM                 ;phase timer counts up
L6595:  ADDD #$0001
L6598:  STD  PH_TIM
L659B:  ANDB #$07                   ;every 8 frames turn on the next line
L659D:  BNE  L65B6
L659F:  LDB  NXTMES
L65A2:  BMI  L65A7
L65A4:  JSR  MESSON
L65A7:  LDA  NXTMES                 ;INC NEXT MESSAGE
L65AA:  ADDA #$01
L65AC:  CMPA LSTMES                 ;NO MORE FOR THIS PHASE?
L65AF:  BLO  L65B3                  ;IFHS  THAT'S ALL FOLKS
L65B1:  LDA  #$80                   ;FLAG IT AS NO MORE
L65B3:  STA  NXTMES
L65B6:  LDD  PH_YOF                 ;UPDATE MESSAGE Y OFFSET ( SCROLL )
L65B9:  SUBD #$0008
L65BC:  BPL  L65C1                  ;IFMI  TOO FAR
L65BE:  LDD  #$0000
L65C1:  STD  PH_YOF
L65C4:  LDD  PH_TIM                 ;from frame $140 fade the page out
L65C7:  CMPD #$0140
L65CB:  BCS  L65E1
L65CD:  LDB  PH_COL+1               ;DECREMENT Z
L65D0:  SUBB #$01
L65D2:  CMPB #$08                   ;DIM ENOUGH AT 10 DON'T WASTE TIME GOING TO 0
L65D4:  BHS  L65DE                  ;IFLO
L65D6:  LDD  #$0200                 ;the timer value that ends the phase
L65D9:  STD  PH_TIM                 ;PHASE OVER
L65DC:  LDB  #$00
L65DE:  STB  PH_COL+1
L65E1:  LDD  PH_YOF
L65E4:  STD  >MSYOFF
L65E7:  JSR  VWMES2                 ;VIEW MESAGES (NO COLOR COMMAND )
L65EA:  RTS

;------------------------------------------------------------------------------
; VWCOIN - Star Wars's VWCOIN which the matcher missed: the two coin lines of the attract screens. first line:
;   with no credit "game over" and "insert coins" alternate, with credit "pull trigger to start". second line:
;   "free play" in free play mode (new in this game), else the cost of a game or the number of credits with a half
;   sign for a partial credit. Y = display list pointer
;------------------------------------------------------------------------------
VWCOIN:
L65EB:  LDA  S_S_CRDT
L65ED:  BNE  L6600                  ;IFEQ  NO CREDIT--FLASH "GAME OVER"+"INSERT COINS"
L65EF:  LDA  FRAME+1
L65F1:  ANDA #$10                   ;PICK A RATE FOR FLASH
L65F3:  BNE  L65F9                  ;IFEQ
L65F5:  LDB  #$04                   ;"INSERT COINS" ON
L65F7:  BRA  L65FB                  ;ELSE
L65F9:  LDB  #$03                   ;"GAME OVER" ON
L65FB:  JSR  do_message             ;draw message B now
L65FE:  BRA  L6605                  ;ELSE  ELSE WE HAVE ENUF CREDIT
;WE GOT THEIR MONEY SO TELL THEM TO...
L6600:  LDB  #$09                   ;"PRESS FIRE TO START"
L6602:  JSR  do_message
L6605:  LDB  OPTS0                  ;second line. coin mode
L6608:  ANDB #$03
L660A:  BNE  L6613
L660C:  LDB  #$05                   ;free play: say so, and no credit count
L660E:  JSR  do_message
L6611:  BRA  L6670
L6613:  LDA  S_S_CRDT
L6615:  BNE  L6631
L6617:  LDA  S_CNCT
L6619:  BEQ  VWCOIN_30              ;IFNE  ?ANY PARTIAL CREDITS?
L661B:  LDA  FRAMEL
L661D:  ANDA #$10
L661F:  BEQ  VWCOIN_30              ;B INSERT COINS GOES WITH COIN COST
L6621:  BRA  L6631                  ;B GAME OVER GOES WITH # OF CREDITS
L6623:  BRA  L662F                  ;ELSE  ELSE NO PARTIAL CREDITS  an unreachable BRA L662F, the ELSE of the source macros

;NOW TELL THEM HOW MUCH ITS GONNA COST
VWCOIN_30:
L6625:  LDB  OPTS0                  ;LOW NIBBLE OF COIN OPTIONS
L6628:  ANDB #$03                   ;0=FREE,1=2 PLAYS/COIN,2=1PLAY/COIN,3=2COINS/PLAY
L662A:  ADDB #$05                   ;GET CORRECT MESSAGE NUMBER
L662C:  JSR  do_message
L662F:  BRA  L6670
L6631:  LDA  S_S_CRDT
L6633:  ADDA S_CNCT
L6635:  CMPA #$01
L6637:  BNE  L663D                  ;IFEQ  ?GOT HALF OR ONE CREDITS?
L6639:  LDB  #MS_CRD+1              ;THEN SAY SINGULAR CREDIT
L663B:  BRA  L663F                  ;ELSE  ELSE USE PLURAL
L663D:  LDB  #MS_CRD
L663F:  JSR  do_message
L6642:  LDD  #$01B0                 ;position of the credit count: y 432
L6645:  STD  ,Y++
L6647:  LDD  #$1F80                 ;x -128
L664A:  TST  S_CNCT
L664C:  BEQ  L6651                  ;IFNE  ?HAVE A PARTIAL CREDIT?
L664E:  LDD  #$1F68                 ;x -152 to leave room for the half sign
L6651:  STD  ,Y++
L6653:  LDA  S_S_CRDT
L6655:  CMPA #$0A
L6657:  BLO  L665B                  ;IFHS  CONVERT 0A-12 TO 10-18
L6659:  ADDA #$06
L665B:  LDB  #$02                   ;SUPPRESS BOTH DIGITS
L665D:  STB  BT_SUP
L665F:  JSR  VWBYTE                 ;SHOW THEM
L6662:  LDA  S_CNCT
L6664:  BEQ  L666B                  ;IFNE  ?STILL HAVE A PARTIAL CREDIT?
L6666:  LDD  #$B8FC                 ;THEN SAY SO
L6669:  STD  ,Y++
L666B:  LDD  #VGCNTR                ;ALWAYS DO A CENTER AFTER YOU'RE DONE
L666E:  STD  ,Y++
L6670:  RTS

;------------------------------------------------------------------------------
; team_page_init - phase $07, init of the design team page: message offset and timer 0, messages off, full
;   brightness, message $01 (Atari's game design team) on
;------------------------------------------------------------------------------
team_page_init:
L6671:  LDD  #$0000                 ;in this game this entry starts the design team page
L6674:  STD  PH_YOF
L6677:  LDD  #$0000
L667A:  STD  PH_TIM
L667D:  JSR  ALLOFF
L6680:  LDA  #$80                   ;messages at full brightness
L6682:  STA  ph_col_brt
L6685:  LDB  #$01                   ;message $01: Atari's game design team
L6687:  JSR  MESSON
L668A:  INC  PHASE
L668C:  RTS

;------------------------------------------------------------------------------
; team_page_exec - phase $08, one frame of the design team page: score, coin lines, stars, Jedi letters and the
;   message, the stars move up. from frame $A0 the message fades two steps a frame, and when it is dark the timer
;   is set to $100, which ends the phase: on to the high score table. flashes the Jedi letters and checks the
;   start and test switches
;------------------------------------------------------------------------------
team_page_exec:
L668D:  JSR  ivgen1_wait
L6690:  JSR  vw_score_all
L6693:  JSR  VWCOIN
L6696:  JSR  L617A
L6699:  JSR  MZ_816C                ;calls page 1 jedi_draw
L669C:  JSR  VWMES2
L669F:  JSR  VGDONE
L66A2:  JSR  SMVSCR
L66A5:  LDD  PH_TIM
L66A8:  ADDD #$0001
L66AB:  STD  PH_TIM
L66AE:  CMPD #$00A0                 ;from frame $A0 fade the page out
L66B2:  BCS  L66C8
L66B4:  LDB  ph_col_brt             ;brightness the message drawing uses
L66B7:  SUBB #$02                   ;two steps a frame
L66B9:  CMPB #$08
L66BB:  BCC  L66C5
L66BD:  LDD  #$0100                 ;dark: the timer value that ends the phase
L66C0:  STD  PH_TIM
L66C3:  LDB  #$00
L66C5:  STB  ph_col_brt
L66C8:  LDD  PH_TIM
L66CB:  CMPD #$0100
L66CF:  BCS  L66D3
L66D1:  INC  PHASE                  ;on to the high score table
L66D3:  JSR  MZ_8403                ;calls page 1 jedi_time_run
L66D6:  LDA  jedi_blink             ;every 32 frames flash the Jedi letters
L66D9:  ANDA #$1F
L66DB:  BNE  L66E5
L66DD:  LDA  jedi_show
L66E0:  EORA #$02
L66E2:  STA  jedi_show
L66E5:  JSR  STRTCK
L66E8:  RTS

;------------------------------------------------------------------------------
; PHIHIS - phase $09 (PHS_HIS), Star Wars' PHIHIS with the timer started at 0: init of the high score table
;   display. blue for the table, messages off, math box and ship restored, stars facing forward, high scores
;   checked for reasonableness by bank 1
;------------------------------------------------------------------------------
PHIHIS:
L66E9:  LDD  #$0000
L66EC:  STD  PH_YOF
L66EF:  STD  >MSYOFF
L66F2:  LDD  #$0000
L66F5:  STD  PH_TIM
L66F8:  LDD  #VGCOLR+(VGCBLU*$100)
L66FB:  STD  PH_COL
L66FE:  JSR  ALLOFF
L6701:  JSR  IPGEN
L6704:  JSR  IPARM
L6707:  LDU  #M_U1                  ;STARS ASSUME UV1 MATRIX
L670A:  JSR  UNITV                  ;SETUP FACING FORWARD
L670D:  JSR  L6114
L6710:  INC  PHASE
L6712:  RTS

;------------------------------------------------------------------------------
; PHEHIS - phase $0A, Star Wars' PHEHIS with the timer counting up: one frame of the high score table display.
;   draws the copyright message, stars, score, coin lines, the table in the phase colour (faded from frame $B0)
;   and the Jedi letters, moves the stars forward, and after $100 frames goes back to the banner. flashes the Jedi
;   letters and checks the start and test switches
;------------------------------------------------------------------------------
PHEHIS:
L6713:  JSR  ivgen1_wait
L6716:  JSR  CPYRGHT
L6719:  JSR  L617A
L671C:  JSR  vw_score_all
L671F:  JSR  VWCOIN
L6722:  LDD  PH_TIM                 ;FADER?
L6725:  CMPD #$00B0                 ;from frame $B0 fade the table out
L6729:  BCS  L6739
L672B:  LDB  PH_COL+1
L672E:  SUBB #$01
L6730:  CMPB #$F0
L6732:  BLO  L6736                  ;IFHS  PROBABLY WRAPPED
L6734:  LDB  #$00
L6736:  STB  PH_COL+1
L6739:  LDD  PH_COL                 ;PUT THE COLOR OUT
L673C:  STD  ,Y++
L673E:  JSR  L60F6
L6741:  JSR  VWMESS
L6744:  JSR  MZ_816C                ;calls page 1 jedi_draw
L6747:  JSR  VGDONE
L674A:  JSR  SMVHIS                 ;move the stars forward
L674D:  LDD  PH_TIM
L6750:  ADDD #$0001
L6753:  STD  PH_TIM
L6756:  CMPD #$0100                 ;$100 frames of table
L675A:  BCS  L6760
L675C:  LDA  #$01                   ;then back to the banner
L675E:  STA  PHASE
L6760:  JSR  MZ_8403                ;calls page 1 jedi_time_run
L6763:  LDA  jedi_blink             ;every 32 frames flash the Jedi letters
L6766:  ANDA #$1F
L6768:  BNE  L6772
L676A:  LDA  jedi_show
L676D:  EORA #$02
L676F:  STA  jedi_show
L6772:  JSR  STRTCK
L6775:  RTS

;------------------------------------------------------------------------------
; CPYRGHT - Star Wars's CPYRGHT cut down to one message: draws message $00, the title and the three copyright
;   lines. Y = display list pointer
;------------------------------------------------------------------------------
CPYRGHT:
L6776:  LDB  #$00                   ;message $00: title and copyright lines
L6778:  JMP  do_message

;------------------------------------------------------------------------------
; PHISG1 - phase $0B, Star Wars's PHISG1 cut down: entered when the start switch is accepted. loads display list
;   set 0 and sends a sound command, then goes on to PHESG1
;------------------------------------------------------------------------------
PHISG1:
L677B:  LDB  #$00                   ;display list set 0
L677D:  JSR  load_vg_set
L6780:  JSR  spk_cmd_0d             ;sound command of spk_cmd_0d
L6783:  INC  PHASE
L6785:  RTS

;------------------------------------------------------------------------------
; PHESG1 - phase $0C, the first instructions of Star Wars' PHESG1: clears kill_count, sets phase $0D (select the
;   starting wave) and falls into game_vars_init, the rest of PHESG1
;------------------------------------------------------------------------------
PHESG1:
L6786:  LDA  #$00
L6788:  STA  kill_count             ;kill counter of the walker part
L678B:  LDA  #$0D                   ;next: select the starting wave
L678D:  STA  PHASE

;------------------------------------------------------------------------------
; game_vars_init - reset the per-game variables, the second half of Star Wars's PHESG1: no attract music after
;   the game, messages off, Jedi letters cleared, frame counter 0, shields from the option switches (2 to 5), Jedi
;   time, difficulty adder and gas gauge flags cleared, cursor centred and the pot limits perturbed. PHESG1 falls
;   into it and the continue offer (L69B0) calls it
;------------------------------------------------------------------------------
game_vars_init:
L678F:  LDA  #$FF                   ;no attract music right after a game
L6791:  STA  MUSTIM
L6794:  JSR  ALLOFF
L6797:  JSR  MZ_842D                ;calls page 1 jedi_clear
L679A:  LDD  #$0000                 ;frame counter from 0
L679D:  STD  FRAME
L679F:  STA  WV_LVL
L67A1:  STA  cont_used              ;not a continued game
L67A4:  LDA  OPTS1
L67A7:  ANDA #$03
L67A9:  ADDA #$02
L67AB:  STA  S_GAS
L67AD:  LDD  #$0000
L67B0:  STD  jedi_time              ;no Jedi time running
L67B3:  STA  jedi_count             ;the Jedi letters have not been completed yet
L67B6:  STA  jedi_on
L67B9:  STA  diff_adder             ;difficulty adder and its step from 0
L67BC:  STA  diff_step
L67BF:  STA  GS_GLW
L67C1:  STA  GS_HIT
L67C3:  STD  >VG_RSX                ;cursor to the centre
L67C6:  STD  >VG_RSY
L67C9:  ORCC #$10
L67CB:  INC  >RHEOY
L67CE:  INC  >RHEOP
L67D1:  INC  >rheoy_sp
L67D4:  INC  >rheop_sp
L67D7:  ANDCC #$EF
L67D9:  RTS

;------------------------------------------------------------------------------
; PHISG2 - phase $13, Star Wars' PHISG2 with more to reset: finish starting up the game. math box, parameters
;   and stars, the four bonus quotas from the starting wave (set_bonus_quota), ship facing backwards, bonus coin
;   count, score, foa_said and jedi_done cleared, rank_index at the last entry, start_bonus set and diff_adder
;   taken from the difficulty option. falls into PHESG2
;------------------------------------------------------------------------------
PHISG2:
L67DA:  JSR  IPGEN
L67DD:  JSR  IPARM
L67E0:  JSR  L616E
L67E3:  JSR  set_bonus_quota        ;shoot-for-bonus counts of the parts, from the starting wave
L67E6:  LDA  #$C0
L67E8:  STA  s1_ax
L67EB:  STA  s1_by
L67EE:  LDD  #$0000
L67F1:  STA  $4813                  ;a coin routine byte, see the questions
L67F3:  STA  S_BCCNT
L67F5:  STA  foa_said               ;the spk_cmd_05 sound has not been sent this game
L67F8:  STD  S_SC87                 ;score 0
L67FA:  STD  S_SC43
L67FC:  STA  jedi_done              ;Jedi letters not completed in this game
L67FF:  LDA  #$18                   ;place 25: below the whole high score table
L6801:  STA  rank_index             ;rank starts at the last of the 25 high score entries
L6804:  LDA  #$01
L6806:  STA  start_bonus            ;the starting bonus has not been paid yet
L6809:  LDA  OPTS1
L680C:  ANDA #$0C                   ;difficulty option, bits 2 and 3, is the first difficulty adder
L680E:  LSRA
L680F:  LSRA
L6810:  STA  diff_adder
L6813:  INC  PHASE

;------------------------------------------------------------------------------
; PHESG2 - phase $14, Star Wars' PHESG2: goes to phase $15 (PHS_BGN), begin a wave
;------------------------------------------------------------------------------
PHESG2:
L6815:  LDA  #$15
L6817:  STA  PHASE
L6819:  RTS

;------------------------------------------------------------------------------
; sel_wave_init - phase $0D, init of the starting difficulty select screen. Star Wars' PHISDS (select a death
;   star) changed: loads picture set 0 into the pseudo vector ROM, clears the phase timer and the message offsets,
;   sets the message colour and turns on message $2B (select starting difficulty, the three waves with their
;   bonuses and the two instructions targets), then steps to the execute phase
;------------------------------------------------------------------------------
sel_wave_init:
L681A:  LDB  #$00                   ;picture set 0 into the pseudo vector ROM
L681C:  JSR  load_vg_set
L681F:  LDD  #$0000
L6822:  STD  PH_TIM
L6825:  STA  snd_mute
L6828:  LDD  #$0000
L682B:  STD  PH_YOF
L682E:  STD  >MSYOFF
L6831:  LDD  #$6480
L6834:  STD  PH_COL
L6837:  JSR  ALLOFF
L683A:  LDB  #$2B                   ;message $2B: the whole select screen
L683C:  JSR  MESSON
L683F:  INC  PHASE
L6841:  RTS

TDTH:          ;X,Y POS
L6842:  .word $0064, $FE70
;;; .WORD -100.,-200.
L6846:  .word $FED4, $0000
;;; .WORD -100.,200.
L684A:  .word $0064, $0190

tdth_instr:
L684E:  .word $FED4, $FEBB, $FED4, $0145 ;the two instructions targets: y -300 x -325 and y -300 x 325

;------------------------------------------------------------------------------
; sel_wave_exec - phase $0E, the starting difficulty select screen. Star Wars' PHESDS changed: the table TDTH
;   now has five targets, three planets (easy, medium, hard = GM_WAV 0, 1, 2) and two instructions targets that
;   pick easy and set manual_on. Each frame it hit tests the cursor against the targets with the octagon check,
;   draws the planets, the two instructions pictures, the cursor (yellow when on a target), the messages and a
;   countdown, and goes to phase $0F when a fire or thumb switch is pressed on a target or, on easy, when 256
;   frames have passed
;------------------------------------------------------------------------------
sel_wave_exec:
L6856:  LDD  PH_TIM
L6859:  ADDD #$0001
L685C:  STD  PH_TIM
L685F:  CMPD #$0100                 ;256 frames without a choice
L6863:  BCS  L686B
L6865:  CLR  GM_WAV                 ;then start on easy
L6868:  JMP  L6972
L686B:  CLR  manual_on              ;no instructions unless the cursor is on one of their targets
L686E:  LDA  #$FF
L6870:  STA  WV_LVL                 ;FLAG
L6872:  LDX  #TDTH
L6875:  LDD  SI_CY                  ;Y POS OF CURSOR
L6877:  ADDD #VGOFFY                ;ADD BACK THE SCREEN OFFSET
L687A:  SUBD ,X                     ;MINUS SCREEN CO-ORD FOR DEATH STAR
L687C:  BPL  L6882
L687E:  COMA
L687F:  NEGB
L6880:  SBCA #$FF
L6882:  STD  TMPABS
L6884:  CMPD #$0048
L6888:  BHS  L68B7                  ;IFLO  WITHIN X LIMIT
L688A:  LDD  SI_CX
L688C:  SUBD 2,X
L688E:  BPL  L6894
L6890:  COMA
L6891:  NEGB
L6892:  SBCA #$FF
L6894:  CMPD #$0034
L6898:  BHS  L68B7                  ;IFLO  ALSO WITHIN Y LIMIT
L689A:  ADDD TMPABS                 ;OCTAGON CHECK
L689C:  CMPD #$0050
L68A0:  BHS  L68B7                  ;IFLO  HIT
L68A2:  TFR  X,D                    ;MAKE INDEXED NUMBER USEFUL
L68A4:  SUBD #$6842
L68A7:  LSRB                        ;/4
L68A8:  LSRB
L68A9:  CMPB #$03                   ;entries 0-2 are the planets: easy, medium, hard
L68AB:  BCS  L68B2
L68AD:  INC  manual_on              ;entries 3 and 4: instructions wanted, on easy
L68B0:  LDB  #$00
L68B2:  STB  WV_LVL
L68B4:  STB  GM_WAV                 ;the starting wave: 0, 1 or 2
L68B7:  LEAX 4,X                    ;NEXT TABLE ENTRY
L68B9:  CMPX #sel_wave_exec         ;DONE?
L68BC:  BLO  L6875                  ;HSEND
L68BE:  JSR  ivgen1_wait
L68C1:  LDX  #TDTH                  ;TABLE FOR DEATH STAR SETUP
L68C4:  LDD  ,X++                   ;Y POS
L68C6:  ANDA #$1F
L68C8:  STD  ,Y++
L68CA:  LDD  ,X++                   ;X POS
L68CC:  ANDA #$1F
L68CE:  STD  ,Y++
L68D0:  LDD  #VGSCAL+0              ;SIZE THE DEATH STAR
L68D3:  STD  ,Y++
L68D5:  LDD  #$B4A2                 ;MINIATURE BASE
L68D8:  STD  ,Y++
L68DA:  CMPX #tdth_instr            ;END OF TABLE?
L68DD:  BLO  L68C4                  ;HSEND
L68DF:  LDD  ,X                     ;the two instructions targets, each drawn twice
L68E1:  ANDA #$1F
L68E3:  STD  ,Y++
L68E5:  LDD  2,X
L68E7:  ANDA #$1F
L68E9:  STD  ,Y++
L68EB:  LDD  #VGSCAL+0              ;SIZE THE DEATH STAR
L68EE:  STD  ,Y++
L68F0:  LDD  #$6180                 ;colour 1 at brightness $80
L68F3:  STD  ,Y++
L68F5:  LDD  #$B535                 ;JSRL to the picture at $2A6A
L68F8:  STD  ,Y++
L68FA:  LDD  ,X
L68FC:  ANDA #$1F
L68FE:  STD  ,Y++
L6900:  LDD  2,X
L6902:  ANDA #$1F
L6904:  STD  ,Y++
L6906:  LDD  #$7200
L6909:  STD  ,Y++
L690B:  LDB  ph_tim_lo              ;brightness from the low byte of the timer: falls over 16 frames, then jumps back
L690E:  ANDB #$0F
L6910:  ASLB
L6911:  ASLB
L6912:  ASLB
L6913:  NEGB
L6914:  ADDB #$80
L6916:  LDA  #$62
L6918:  STD  ,Y++
L691A:  LDB  ph_tim_lo              ;two pictures alternate every 16 frames
L691D:  ANDB #$10
L691F:  BNE  L6926
L6921:  LDD  #$B55F                 ;JSRL to the first of the two pictures, at $2ABE
L6924:  BRA  L6929
L6926:  LDD  #$B58E                 ;JSRL to the second, at $2B1C
L6929:  STD  ,Y++
L692B:  LEAX 4,X
L692D:  CMPX #sel_wave_exec         ;END OF TABLE?
L6930:  BLO  L68DF                  ;HSEND
L6932:  LDA  WV_LVL                 ;WHAT COLOR FOR THE CURSOR
L6934:  BPL  L693B                  ;IFMI  NOT ON ANY PLANETOID
L6936:  LDD  #VGCOLR+(VGCTRQ*$100)  ;SO MAKE IT THE STANDARD CURSOR COLOR
L6939:  BRA  L693E                  ;ELSE  ZEROED IN ON A FAVORITE
L693B:  LDD  #VGCOLR+(VGCYLW*$100)  ;LET THEM SEE THE LIGHT
L693E:  STD  ,Y++
L6940:  JSR  VWCURC
L6943:  JSR  VWMESS                 ;LOOK AT THE MESSAGES
L6946:  LDD  #$00C8                 ;POSITION FOR COUNTDOWN
L6949:  STD  ,Y++
L694B:  LDD  #$1FF0
L694E:  STD  ,Y++
L6950:  LDD  #$0100                 ;(256 - timer) * 8 / 256: counts 7 down to 0
L6953:  SUBD PH_TIM
L6956:  ASLB                        ;ASLD
L6957:  ROLA
L6958:  ASLB                        ;ASLD
L6959:  ROLA
L695A:  ASLB                        ;ASLD  RESULTS ARE 00-10 HEX
L695B:  ROLA
L695C:  CMPA #$0A
L695E:  BLO  L6962                  ;IFHS  CONVERT 0A-10 (HEX) TO 10-16 (DEC)
L6960:  ADDA #$06
L6962:  JSR  VWBYTE
L6965:  JSR  VGDONE
L6968:  LDA  WV_LVL
L696A:  BMI  L697F
L696C:  LDA  GN_SWE                 ;on a target: any fire or thumb switch going on starts the game
L696E:  ANDA #$F0
L6970:  BEQ  L697F
L6972:  CLR  >gtime_2               ;clear the three bytes of the game time
L6975:  CLR  >gtime_1
L6978:  CLR  >GTIME
L697B:  LDA  #$0F                   ;phase $0F: the launch sequence
L697D:  STA  PHASE
L697F:  RTS

;------------------------------------------------------------------------------
; launch_init - phase $0F, init of the sequence shown between the select screen and the game: picture set 0,
;   stars (ISTAR), phase timer 0, all messages off, a tune (tune_cmd_2f) and an effect (aud_cmd_47), then falls
;   into the execute phase
;------------------------------------------------------------------------------
launch_init:
L6980:  LDB  #$00                   ;picture set 0
L6982:  JSR  load_vg_set
L6985:  JSR  L616E
L6988:  LDD  #$0000
L698B:  STD  PH_TIM
L698E:  JSR  ALLOFF
L6991:  JSR  tune_cmd_2f
L6994:  JSR  aud_cmd_47
L6997:  INC  PHASE

;------------------------------------------------------------------------------
; launch_exec - phase $10: draws the sequence through LA91A (message $2C, darth vader's executor is searching
;   for the rebel hideout, fading after frame 60 while a picture crosses the screen over the stars) for 100
;   frames, then goes to phase $13 (PHISG2) to start the game
;------------------------------------------------------------------------------
launch_exec:
L6999:  JSR  vew_exec_intro
L699C:  LDD  PH_TIM
L699F:  ADDD #$0001
L69A2:  STD  PH_TIM
L69A5:  CMPD #$0064                 ;100 frames
L69A9:  BCS  L69AF
L69AB:  LDA  #$13                   ;phase $13: PHISG2
L69AD:  STA  PHASE
L69AF:  RTS

;------------------------------------------------------------------------------
; cont_offer_init - phase $11, init of the screen that offers a start at a higher wave after a game (PHEEGM and
;   PHEENT come here when cont_wave is 3 or more). Runs the new game reset L678F, loads picture set 0, starts the
;   countdown at $100, clears cont_used and the no-credit flag and turns on message $2D (you may start your next
;   game on wave / bonus) plus one of $30 (the starting bonus of the last game was never paid), $2E (Jedi bonus
;   earned) or $2F (Jedi bonus not earned)
;------------------------------------------------------------------------------
cont_offer_init:
L69B0:  JSR  game_vars_init         ;the reset every new game gets
L69B3:  LDB  #$00
L69B5:  JSR  load_vg_set
L69B8:  LDD  #$0100                 ;the countdown runs from $100 to $200
L69BB:  STD  PH_TIM
L69BE:  LDD  #$0000
L69C1:  STD  PH_YOF
L69C4:  STD  >MSYOFF
L69C7:  STA  cont_nocrd
L69CA:  STA  snd_mute
L69CD:  STA  cont_used
L69D0:  LDD  #$6480
L69D3:  STD  PH_COL
L69D6:  LDB  #$2D                   ;message $2D: you may start your next game on wave / bonus
L69D8:  JSR  MESSON
L69DB:  LDA  start_bonus
L69DE:  BEQ  L69E4
L69E0:  LDB  #$30                   ;starting bonus never paid: you must complete advanced wave and earn Jedi bonus
L69E2:  BRA  L69EF
L69E4:  LDA  jedi_done
L69E7:  BNE  L69ED
L69E9:  LDB  #$2F                   ;you must earn Jedi bonus to start at higher waves
L69EB:  BRA  L69EF
L69ED:  LDB  #$2E                   ;congratulations, advanced wave finished and Jedi bonus earned
L69EF:  JSR  MESSON
L69F2:  INC  PHASE
L69F4:  RTS

cont_planet:
L69F5:  .word $FF4C                 ;the planet of the continue screen: y -180
L69F7:  .word $0000                 ;x 0

;------------------------------------------------------------------------------
; cont_offer_exec - phase $12, the continue offer screen, a second changed copy of Star Wars' PHESDS with one
;   planet at cont_planet. Draws the score, the coin messages, the planet, the cursor, the messages, a countdown,
;   the offered wave number (cont_wave + 1) and its bonus (cont_bonus, 6 or 8 digits). A fire or thumb switch
;   pressed with the cursor on the planet takes a credit, sets GM_WAV to cont_wave and goes straight to phase $13
;   (PHISG2) - with no credit it puts 256 frames back on the countdown, once. When the timer reaches $200 the
;   offer and the pending offer are cleared and the phase goes back to the banner
;------------------------------------------------------------------------------
cont_offer_exec:
L69F9:  LDD  PH_TIM
L69FC:  ADDD #$0001
L69FF:  STD  PH_TIM
L6A02:  CMPD #$0200                 ;time is up
L6A06:  BCS  L6A22
L6A08:  LDA  #$01                   ;back to the banner
L6A0A:  STA  PHASE
L6A0C:  LDD  #$0000                 ;and the offer and the pending offer are gone
L6A0F:  STA  cont_wave
L6A12:  STA  pend_wave
L6A15:  STD  cont_bonus
L6A18:  STD  cont_bonus_2
L6A1B:  STD  pend_bonus
L6A1E:  STD  pend_bonus_2
L6A21:  RTS
L6A22:  LDA  #$FF
L6A24:  STA  WV_LVL                 ;FLAG
L6A26:  LDX  #cont_planet
L6A29:  LDD  SI_CY                  ;Y POS OF CURSOR
L6A2B:  ADDD #VGOFFY                ;ADD BACK THE SCREEN OFFSET
L6A2E:  SUBD ,X                     ;MINUS SCREEN CO-ORD FOR DEATH STAR
L6A30:  BPL  L6A36
L6A32:  COMA
L6A33:  NEGB
L6A34:  SBCA #$FF
L6A36:  STD  TMPABS
L6A38:  CMPD #$0048
L6A3C:  BHS  L6A5E                  ;IFLO  WITHIN X LIMIT
L6A3E:  LDD  SI_CX
L6A40:  SUBD 2,X
L6A42:  BPL  L6A48
L6A44:  COMA
L6A45:  NEGB
L6A46:  SBCA #$FF
L6A48:  CMPD #$0034
L6A4C:  BHS  L6A5E                  ;IFLO  ALSO WITHIN Y LIMIT
L6A4E:  ADDD TMPABS                 ;OCTAGON CHECK
L6A50:  CMPD #$0050
L6A54:  BHS  L6A5E                  ;IFLO  HIT
L6A56:  LDB  cont_wave              ;on the planet: the offered wave becomes the starting wave
L6A59:  STB  GM_WAV
L6A5C:  STB  WV_LVL
L6A5E:  JSR  ivgen1_wait
L6A61:  JSR  vw_score_all
L6A64:  JSR  VWCOIN
L6A67:  LDD  cont_planet
L6A6A:  ANDA #$1F
L6A6C:  STD  ,Y++
L6A6E:  LDD  L69F7
L6A71:  ANDA #$1F
L6A73:  STD  ,Y++
L6A75:  LDD  #$7200                 ;normal scale
L6A78:  STD  ,Y++
L6A7A:  LDD  #$B4A2
L6A7D:  STD  ,Y++
L6A7F:  LDA  WV_LVL                 ;WHAT COLOR FOR THE CURSOR
L6A81:  BPL  L6A88                  ;IFMI  NOT ON ANY PLANETOID
L6A83:  LDD  #VGCOLR+(VGCTRQ*$100)  ;SO MAKE IT THE STANDARD CURSOR COLOR
L6A86:  BRA  L6A8B                  ;ELSE  ZEROED IN ON A FAVORITE
L6A88:  LDD  #VGCOLR+(VGCYLW*$100)  ;LET THEM SEE THE LIGHT
L6A8B:  STD  ,Y++
L6A8D:  JSR  VWCURC
L6A90:  JSR  VWMESS                 ;LOOK AT THE MESSAGES
L6A93:  LDD  #$00C8                 ;POSITION FOR COUNTDOWN
L6A96:  STD  ,Y++
L6A98:  LDD  #$1FF0
L6A9B:  STD  ,Y++
L6A9D:  LDD  #$0200                 ;($200 - timer) * 16 / 256: counts 16 down to 0, shown in decimal
L6AA0:  SUBD PH_TIM
L6AA3:  ASLB                        ;ASLD
L6AA4:  ROLA
L6AA5:  ASLB                        ;ASLD
L6AA6:  ROLA
L6AA7:  ASLB                        ;ASLD  RESULTS ARE 00-10 HEX
L6AA8:  ROLA
L6AA9:  ASLB
L6AAA:  ROLA
L6AAB:  LDX  #$0008
L6AAE:  JSR  BINBCD_B0
L6AB1:  LDA  bcd_lo
L6AB4:  JSR  VWBYTE
L6AB7:  LDD  #$8040
L6ABA:  STD  ,Y++
L6ABC:  LDD  #$6480
L6ABF:  STD  ,Y++
L6AC1:  LDD  #$1FC0                 ;y -64, x 54: after the word wave
L6AC4:  STD  ,Y++
L6AC6:  LDD  #$0036
L6AC9:  STD  ,Y++
L6ACB:  LDB  #$01
L6ACD:  STB  BT_SUP
L6ACF:  LDA  cont_wave              ;offered wave number, counted from 1
L6AD2:  INCA
L6AD3:  LDX  #$0008
L6AD6:  JSR  BINBCD_B0
L6AD9:  LDA  bcd_lo
L6ADC:  JSR  VWBYTE
L6ADF:  LDD  #$8040
L6AE2:  STD  ,Y++
L6AE4:  LDD  #$6480
L6AE7:  STD  ,Y++
L6AE9:  LDD  #$1EAC                 ;y -340: under the word bonus
L6AEC:  STD  ,Y++
L6AEE:  LDB  #$04
L6AF0:  STB  BT_SUP
L6AF2:  LDA  cont_bonus             ;top two digits zero?
L6AF5:  BNE  L6B04
L6AF7:  LDD  #$1FB2
L6AFA:  STD  ,Y++
L6AFC:  LDU  #cont_bonus_1          ;then 6 digits
L6AFF:  JSR  view_6dig
L6B02:  BRA  L6B0F
L6B04:  LDD  #$1F94
L6B07:  STD  ,Y++
L6B09:  LDU  #cont_bonus            ;else 8 digits
L6B0C:  JSR  view_8dig
L6B0F:  LDD  #$8040
L6B12:  STD  ,Y++
L6B14:  JSR  VGDONE
L6B17:  LDA  OPTS0                  ;free play keeps two credits
L6B1A:  ANDA #$03
L6B1C:  BNE  L6B22
L6B1E:  LDA  #$02
L6B20:  STA  S_S_CRDT
L6B22:  LDA  WV_LVL
L6B24:  BMI  L6B54
L6B26:  LDA  GN_SWE                 ;a fire or thumb switch went on with the cursor on the planet
L6B28:  ANDA #$F0
L6B2A:  BEQ  L6B54
L6B2C:  LDA  S_S_CRDT
L6B2E:  BEQ  L6B47
L6B30:  LDA  #$13                   ;phase $13: PHISG2, the game starts at the offered wave
L6B32:  STA  PHASE
L6B34:  DEC  S_S_CRDT
L6B36:  CLR  manual_on
L6B39:  CLR  >gtime_2
L6B3C:  CLR  >gtime_1
L6B3F:  CLR  >GTIME
L6B42:  INC  cont_used              ;count a continued game for the accounting
L6B45:  BRA  L6B54
L6B47:  LDA  cont_nocrd             ;no credit: the first time only
L6B4A:  BNE  L6B54
L6B4C:  LDA  #$00                   ;put 256 frames back on the countdown
L6B4E:  STA  PH_TIM
L6B51:  INC  cont_nocrd
L6B54:  RTS

;------------------------------------------------------------------------------
; begin_act_init - phase $15 (PHS_BGN), begin a set of four waves. Star Wars' PHIBGN changed: resets the ship's
;   flight state (OLD1SHP), makes the BCD wave number for the display from GM_WAV + 1 (at most 99), copies GM_WAV
;   to the level of each of the four wave types, clears wave_type, snd_mute and man_running, then falls into the
;   execute phase
;------------------------------------------------------------------------------
begin_act_init:
L6B55:  JSR  OLD1SHP
L6B58:  LDX  #$0008
L6B5B:  LDA  GM_WAV                 ;wave number shown is GM_WAV + 1, at most 99
L6B5E:  INCA
L6B5F:  CMPA #$63
L6B61:  BLS  L6B65
L6B63:  LDA  #$63
L6B65:  JSR  BINBCD_B0
L6B68:  LDA  bcd_lo
L6B6B:  STA  wave_bcd
L6B6E:  LDA  GM_WAV                 ;all four wave types start the set at this level
L6B71:  STA  w1_level
L6B74:  STA  w2_level
L6B77:  STA  SP_WAV
L6B7A:  STA  w4_level
L6B7D:  LDA  #$00                   ;wave type 0
L6B7F:  STA  wave_type
L6B82:  STA  snd_mute
L6B85:  STA  man_running
L6B88:  INC  PHASE

;------------------------------------------------------------------------------
; begin_act_exec - phase $16, Star Wars' PHEBGN reduced to its first two instructions: goes to phase $17, the
;   init of wave 1
;------------------------------------------------------------------------------
begin_act_exec:
L6B8A:  LDA  #$17                   ;phase $17: init of wave 1
L6B8C:  STA  PHASE
L6B8E:  RTS

;------------------------------------------------------------------------------
; wave1_init - phase $17, init of wave 1: picture set 1, wave_type 0, bonus_left from the wave 1 quota, the Jedi
;   letter display turned off unless a letter is being awarded, prog_count cleared. If instructions were asked for
;   it goes to phase $43 (which comes back at wave1_setup), otherwise it falls into wave1_setup
;------------------------------------------------------------------------------
wave1_init:
L6B8F:  LDB  #$01                   ;picture set 1
L6B91:  JSR  load_vg_set
L6B94:  LDA  #$00
L6B96:  STA  wave_type
L6B99:  LDA  quota_probot           ;Jedi quota of wave 1
L6B9C:  STA  bonus_left
L6B9F:  LDA  jedi_show              ;keep the letter display only while a letter is being awarded
L6BA2:  CMPA #$01
L6BA4:  BEQ  L6BA9
L6BA6:  CLR  jedi_show
L6BA9:  LDA  #$00
L6BAB:  STA  prog_count
L6BAE:  LDA  manual_on              ;instructions wanted: phase $43 shows them first
L6BB1:  BEQ  wave1_setup
L6BB3:  LDB  #$43
L6BB5:  STB  PHASE
L6BB7:  RTS

;------------------------------------------------------------------------------
; wave1_setup - phase $45, the rest of the wave 1 init, entered by falling in from wave1_init or from the
;   training manual phase (manual_next_ph): general parameters and a new ship (IPARM) turned to face backwards,
;   ground stars (ISTARG), the wave 1 objects and the progress indicator set up on the slapstic pages, player
;   speed, position and height, timer and the hit speech flags cleared, the part's tune (tune_cmd_2e) and one of
;   two speeches by the low bit of GM_WAV, craft type 0, then phase $18
;------------------------------------------------------------------------------
wave1_setup:
L6BB8:  JSR  IPARM
L6BBB:  LDA  #$C0                   ;unit vector A x = -1
L6BBD:  STA  s1_ax
L6BC0:  STA  s1_by                  ;and B y = -1: face backwards
L6BC3:  JSR  L6174
L6BC6:  JSR  MZ_859E                ;calls page 2 probot_setup
L6BC9:  JSR  L6186
L6BCC:  JSR  MZ_8286                ;calls page 1 probot_ind_init
L6BCF:  JSR  MZ_83CA                ;calls page 3 xmit_init
L6BD2:  LDD  #$0100                 ;INITIAL PLAYER SPEED
L6BD5:  STD  (MS_VX+M_S1)&$FFFF
L6BD8:  ASRA                        ;ASRD
L6BD9:  RORB
L6BDA:  STD  MS_TX+M_S1             ;OFFSET POSITION INTO MIDDLE FOR COLLISION DETECT
L6BDD:  LDD  #$2000                 ;INITIAL HITE
L6BE0:  STD  MS_TZ+M_S1
L6BE3:  LDD  #$0000
L6BE6:  STD  PH_TIM
L6BE9:  CLRA
L6BEA:  STA  glow_said
L6BED:  STA  hit_said
L6BF0:  JSR  tune_cmd_2e
L6BF3:  LDA  GM_WAV                 ;odd GM_WAV: one speech, even: another
L6BF6:  ANDA #$01
L6BF8:  BEQ  L6BFF
L6BFA:  JSR  spk_cmd_0f
L6BFD:  BRA  L6C02
L6BFF:  JSR  spk_cmd_0e
L6C02:  LDA  #$00                   ;one pair of laser beams
L6C04:  STA  craft_type
L6C07:  LDA  #$18
L6C09:  STA  PHASE

;------------------------------------------------------------------------------
; wave1_leadin - phase $18, the first 40 frames of wave 1 before anything attacks: views the scene (vew_probot),
;   ends the game through phi_probot_die when the shields are gone, runs the shield gauge and the Jedi flags,
;   turns and moves the player, then goes to phase $19
;------------------------------------------------------------------------------
wave1_leadin:
L6C0B:  JSR  vew_probot
L6C0E:  LDA  S_GAS
L6C10:  LBMI phi_probot_die
L6C14:  JSR  DO1GAS
L6C17:  JSR  MZ_8157                ;calls page 1 jedi_on_update
L6C1A:  JSR  VGTOSITE
L6C1D:  JSR  twirl_ground
L6C20:  LDA  #$10
L6C22:  JSR  IS1UV
L6C25:  JSR  smv_probot
L6C28:  LDD  PH_TIM
L6C2B:  ADDD #$0001
L6C2E:  STD  PH_TIM
L6C31:  CMPD #$0028                 ;2 SECONDS  40 frames
L6C35:  BLO  L6C3B                  ;IFHS
L6C37:  LDA  #$19
L6C39:  STA  PHASE
L6C3B:  RTS

;------------------------------------------------------------------------------
; wave1_level_init - phase $19: works out the level wave 1 is played at, 2 * w1_level + diff_adder, folded into
;   $10-$1F once it passes $1F, stores it in fire_level and its two wave 1 copies, clears the phase timer and
;   GD_ROL and falls into the wave 1 play phase (wave1_exec, phase $1A)
;------------------------------------------------------------------------------
wave1_level_init:
L6C3C:  LDA  w1_level               ;level = 2 * wave 1 level + difficulty adder
L6C3F:  ASLA
L6C40:  ADDA diff_adder
L6C43:  CMPA #$20                   ;past $1F it is folded into $10-$1F
L6C45:  BCS  L6C4B
L6C47:  ANDA #$1F
L6C49:  ORA  #$10
L6C4B:  STA  fire_level
L6C4E:  STA  w1_pace
L6C51:  STA  $4C5C
L6C54:  LDD  #$0000
L6C57:  STD  PH_TIM
L6C5A:  STD  >GD_ROL
L6C5D:  INC  PHASE

;------------------------------------------------------------------------------
; wave1_exec - phase $1A, wave 1 play: views with vew_probot, ends the game through phi_probot_die when the
;   shields are gone, moves shots, transmissions, glow, the shield gauge, explosions and the wave 1 objects (page
;   2 P2_877C), runs the Jedi time, turns and moves the player. at frame 20 it shows the Jedi letters. once the
;   quota is met or 100 frames have passed the level climbs (wave1_level_up), and when prog_count reaches 4 it
;   goes to phase $1B
;------------------------------------------------------------------------------
wave1_exec:
L6C5F:  JSR  vew_probot
L6C62:  LDA  S_GAS
L6C64:  LBMI phi_probot_die
L6C68:  JSR  MZ_84CC                ;calls page 1 MVGUN
L6C6B:  JSR  MZ_843F                ;calls page 3 xmit_move_all
L6C6E:  JSR  DO1GLW
L6C71:  JSR  DO1GAS
L6C74:  JSR  L61AA
L6C77:  JSR  MZ_837F                ;calls page 2 probots_move
L6C7A:  JSR  MZ_8403                ;calls page 1 jedi_time_run
L6C7D:  JSR  VGTOSITE
L6C80:  JSR  twirl_ground
L6C83:  LDA  #$10
L6C85:  JSR  IS1UV
L6C88:  JSR  smv_probot
L6C8B:  LDD  PH_TIM
L6C8E:  ADDD #$0001
L6C91:  STD  PH_TIM
L6C94:  CMPD #$0014                 ;frame 20: show the Jedi letters, unless they are already on
L6C98:  BNE  L6CA4
L6C9A:  LDA  jedi_show
L6C9D:  BNE  L6CA4
L6C9F:  LDA  #$02
L6CA1:  STA  jedi_show
L6CA4:  LDA  bonus_left             ;quota met, or 100 frames gone: the level climbs
L6CA7:  BEQ  L6CB2
L6CA9:  LDD  PH_TIM
L6CAC:  CMPD #$0064
L6CB0:  BCS  L6CB5
L6CB2:  JSR  wave1_level_up
L6CB5:  LDA  prog_count
L6CB8:  CMPA #$04                   ;four marks on the indicator end the wave
L6CBA:  BCS  L6CC0
L6CBC:  LDA  #$1B
L6CBE:  STA  PHASE
L6CC0:  RTS

;------------------------------------------------------------------------------
; wave1_level_up - called each frame by the wave 1 play phase once the Jedi quota is met or 100 frames have
;   passed: steps fire_level up by one every 32 frames and w1_pace every 16 frames, both folded into $10-$1F past
;   $1F
;------------------------------------------------------------------------------
wave1_level_up:
L6CC1:  LDB  ph_tim_lo              ;low byte of the phase timer
L6CC4:  BITB #$1F
L6CC6:  BNE  L6CD7                  ;every 32 frames
L6CC8:  LDA  fire_level
L6CCB:  INCA
L6CCC:  CMPA #$20
L6CCE:  BCS  L6CD4
L6CD0:  ANDA #$1F
L6CD2:  ORA  #$10
L6CD4:  STA  fire_level
L6CD7:  BITB #$0F
L6CD9:  BNE  L6CEA                  ;every 16 frames
L6CDB:  LDA  w1_pace
L6CDE:  INCA
L6CDF:  CMPA #$20
L6CE1:  BCS  L6CE7
L6CE3:  ANDA #$1F
L6CE5:  ORA  #$10
L6CE7:  STA  w1_pace
L6CEA:  RTS

w1_end_spk:
L6CEB:  .word spk_cmd_16            ;the four speeches one of which ends wave 1 from GM_WAV 3 up
L6CED:  .word spk_cmd_08
L6CEF:  .word spk_cmd_10
L6CF1:  .word spk_cmd_11

;------------------------------------------------------------------------------
; wave1_end_init - phase $1B, wave 1 is over (prog_count reached 4): timer 0, a speech picked by GM_WAV (0, 1,
;   2, from 3 up one of the four in w1_end_spk at random), and w1_spawn = $FF so that page 2 frees the wave 1
;   objects. Falls into phase $1C (wave1_end_exec), which plays on until none is left
;------------------------------------------------------------------------------
wave1_end_init:
L6CF3:  JSR  spk_cmd_13
L6CF6:  LDD  #$0000
L6CF9:  STD  PH_TIM
L6CFC:  LDA  GM_WAV                 ;speech by GM_WAV: 0, 1, 2, else at random
L6CFF:  BNE  L6D06
L6D01:  JSR  spk_cmd_16
L6D04:  BRA  L6D24
L6D06:  CMPA #$01
L6D08:  BNE  L6D0F
L6D0A:  JSR  spk_cmd_08
L6D0D:  BRA  L6D24
L6D0F:  CMPA #$02
L6D11:  BNE  L6D18
L6D13:  JSR  spk_cmd_10
L6D16:  BRA  L6D24
L6D18:  LDX  #w1_end_spk
L6D1B:  LDA  P_RND1                 ;random 0-3
L6D1E:  LDB  #$04
L6D20:  MUL
L6D21:  ASLA
L6D22:  JSR  [A,X]
L6D24:  LDA  #$FF                   ;minus: page 2 frees the wave 1 objects
L6D26:  STA  w1_spawn
L6D29:  INC  PHASE

;------------------------------------------------------------------------------
; wave1_end_exec - phase $1C: plays wave 1 on, as wave1_exec does without the level and indicator tests, until
;   page 2 counts no live object record (w1_active 0), then goes to phase $1D
;------------------------------------------------------------------------------
wave1_end_exec:
L6D2B:  JSR  vew_probot
L6D2E:  LDA  S_GAS
L6D30:  LBMI phi_probot_die
L6D34:  JSR  MZ_84CC                ;calls page 1 MVGUN
L6D37:  JSR  MZ_843F                ;calls page 3 xmit_move_all
L6D3A:  JSR  DO1GLW
L6D3D:  JSR  DO1GAS
L6D40:  JSR  L61AA
L6D43:  JSR  MZ_837F                ;calls page 2 probots_move
L6D46:  JSR  MZ_8403                ;calls page 1 jedi_time_run
L6D49:  JSR  VGTOSITE
L6D4C:  JSR  twirl_ground
L6D4F:  LDA  #$10
L6D51:  JSR  IS1UV
L6D54:  JSR  smv_probot
L6D57:  LDD  PH_TIM
L6D5A:  ADDD #$0001
L6D5D:  STD  PH_TIM
L6D60:  LDA  w1_active              ;play on until no wave 1 object is left
L6D63:  BNE  L6D69
L6D65:  LDA  #$1D
L6D67:  STA  PHASE
L6D69:  RTS

;------------------------------------------------------------------------------
; wave1_exit_init - phase $1D: clears the phase timer and steps to the wave 1 exit phase
;------------------------------------------------------------------------------
wave1_exit_init:
L6D6A:  LDD  #$0000
L6D6D:  STD  PH_TIM
L6D70:  INC  PHASE
L6D72:  RTS

;------------------------------------------------------------------------------
; wave1_exit_exec - phase $1E, the flight out of wave 1: views with vew_probot_end, still moves shots,
;   explosions, glow and the shield gauge, turns the player with L778C and moves him. After 40 frames it waits for
;   the ship to face backwards (unit vector A x at or below $C100) and at 80 frames at the latest goes to phase
;   $1F, the init of wave 2
;------------------------------------------------------------------------------
wave1_exit_exec:
L6D73:  JSR  vew_probot_end
L6D76:  LDA  S_GAS
L6D78:  LBMI phi_probot_die
L6D7C:  JSR  MZ_84CC                ;calls page 1 MVGUN
L6D7F:  JSR  MZ_843F                ;calls page 3 xmit_move_all
L6D82:  JSR  DO1GLW
L6D85:  JSR  DO1GAS
L6D88:  JSR  L61AA
L6D8B:  JSR  MZ_8157                ;calls page 1 jedi_on_update
L6D8E:  JSR  VGTOSITE
L6D91:  JSR  twirl_turn_back
L6D94:  LDA  #$10
L6D96:  JSR  IS1UV
L6D99:  JSR  smv_probot
L6D9C:  LDD  PH_TIM
L6D9F:  ADDD #$0001
L6DA2:  STD  PH_TIM
L6DA5:  CMPD #$0050                 ;80 frames at the most
L6DA9:  BCC  L6DBA
L6DAB:  CMPD #$0028                 ;40 at the least
L6DAF:  BCS  L6DBE
L6DB1:  LDD  s1_ax                  ;then until unit vector A x says the ship faces backwards
L6DB4:  CMPD #$C100
L6DB8:  BGT  L6DBE
L6DBA:  LDA  #$1F
L6DBC:  STA  PHASE
L6DBE:  RTS

;------------------------------------------------------------------------------
; wave2_init - phase $1F, init of wave 2: picture set 1, wave_type 1, bonus_left from the wave 2 quota, the Jedi
;   letter display turned off unless a letter is being awarded. With instructions asked for it goes to phase $43
;   (which comes back at wave2_setup), otherwise it joins wave2_setup at L6DF3, past the new ship and stars, so
;   the flight carries on from wave 1
;------------------------------------------------------------------------------
wave2_init:
L6DBF:  LDB  #$01                   ;picture set 1
L6DC1:  JSR  load_vg_set
L6DC4:  LDA  #$01                   ;wave type 1
L6DC6:  STA  wave_type
L6DC9:  LDA  quota_walker           ;Jedi quota of wave 2
L6DCC:  STA  bonus_left
L6DCF:  LDA  jedi_show
L6DD2:  CMPA #$01
L6DD4:  BEQ  L6DD9
L6DD6:  CLR  jedi_show
L6DD9:  LDA  manual_on              ;instructions wanted: phase $43 shows them first
L6DDC:  BEQ  L6DE3
L6DDE:  LDB  #$43
L6DE0:  STB  PHASE
L6DE2:  RTS
L6DE3:  BRA  L6DF3                  ;skip the new ship and the stars: the flight carries on from wave 1

;------------------------------------------------------------------------------
; wave2_setup - phase $46, the rest of the wave 2 init, entered from the training manual phase (manual_next_ph)
;   with a new ship facing backwards and ground stars, and at L6DF3 from wave2_init: sets up the two kinds of wave
;   2 objects and the progress indicator on the slapstic pages, works out fire_level from w2_level and diff_adder,
;   clears the timer, the legs bonus and the speech flags, sends the part's tune (tune_cmd_2b) while jedi_time is
;   under $80 and a speech (spk_cmd_18) and goes to phase $20
;------------------------------------------------------------------------------
wave2_setup:
L6DE5:  JSR  IPARM
L6DE8:  LDA  #$C0                   ;face backwards, as in wave1_setup
L6DEA:  STA  s1_ax
L6DED:  STA  s1_by
L6DF0:  JSR  L6174
L6DF3:  JSR  MZ_85DA                ;calls page 1 atst_init
L6DF6:  JSR  MZ_8103                ;calls page 0 atat_init
L6DF9:  JSR  MZ_83B8                ;calls page 1 walker_ind_init
L6DFC:  JSR  L6186
L6DFF:  JSR  MZ_8247                ;calls page 0 cable_init
L6E02:  LDA  w2_level               ;level = 2 * wave 2 level + difficulty adder, folded into $10-$1F past $1F
L6E05:  ASLA
L6E06:  ADDA diff_adder
L6E09:  CMPA #$20
L6E0B:  BCS  L6E11
L6E0D:  ANDA #$1F
L6E0F:  ORA  #$10
L6E11:  STA  fire_level
L6E14:  STA  $4C5E
L6E17:  STA  w2_level_b
L6E1A:  LDD  #$0000
L6E1D:  STD  PH_TIM
L6E20:  STD  legs_bonus             ;passing bonus back to zero (3 BCD bytes)
L6E23:  STA  legs_bonus_2
L6E26:  STA  hit_said
L6E29:  STA  w2_spk_cnt
L6E2C:  STA  legs_bon_tmr
L6E2F:  STA  S_ROL
L6E31:  LDD  jedi_time              ;Jedi time under $80
L6E34:  CMPD #$0080
L6E38:  BCC  L6E3D
L6E3A:  JSR  tune_cmd_2b
L6E3D:  JSR  spk_cmd_18
L6E40:  LDA  #$20
L6E42:  STA  PHASE

;------------------------------------------------------------------------------
; wave2_exec - phase $20, wave 2 play: views with LA448, ends the game through phi_walker_die when the shields
;   are gone, moves shots, explosions and the two kinds of wave 2 objects, runs the Jedi time, turns and moves the
;   player. After 1200 frames, or once the quota is met with Jedi time running, it clears adv_hold so nothing
;   holds the advance up. At frame 60 it shows the Jedi letters, and when walk_adv reaches 400 it goes to phase
;   $21
;------------------------------------------------------------------------------
wave2_exec:
L6E44:  JSR  vew_walker
L6E47:  LDA  S_GAS
L6E49:  LBMI phi_walker_die
L6E4D:  JSR  MZ_84CC                ;calls page 1 MVGUN
L6E50:  JSR  DO1GLW
L6E53:  JSR  MZ_83DF                ;calls page 0 cable_move
L6E56:  JSR  DO1GAS
L6E59:  JSR  L61AA
L6E5C:  JSR  MZ_8514                ;calls page 1 atst_move_all
L6E5F:  JSR  MZ_847E                ;calls page 0 atat_move_all
L6E62:  JSR  MZ_8403                ;calls page 1 jedi_time_run
L6E65:  JSR  VGTOSITE
L6E68:  JSR  twirl_ground
L6E6B:  LDA  #$10
L6E6D:  JSR  IS1UV
L6E70:  JSR  SMVG0B
L6E73:  LDD  PH_TIM
L6E76:  ADDD #$0001
L6E79:  STD  PH_TIM
L6E7C:  CMPD #$04B0                 ;1200 frames
L6E80:  BCC  L6E8C
L6E82:  LDA  bonus_left             ;or the quota is met and Jedi time is running
L6E85:  BNE  L6E8F
L6E87:  LDD  jedi_time
L6E8A:  BEQ  L6E8F
L6E8C:  CLR  adv_hold               ;then nothing holds the advance up any more
L6E8F:  LDD  PH_TIM
L6E92:  CMPD #$003C
L6E96:  BNE  L6EA2
L6E98:  LDA  jedi_show
L6E9B:  BNE  L6EA2
L6E9D:  LDA  #$02
L6E9F:  STA  jedi_show
L6EA2:  LDD  walk_adv               ;advance at 400: the wave is over
L6EA5:  CMPD #$0190
L6EA9:  BLT  L6EAF
L6EAB:  LDA  #$21
L6EAD:  STA  PHASE
L6EAF:  RTS

;------------------------------------------------------------------------------
; wave2_end_init - phase $21, wave 2 is over: timer 0 and both spawn counts = $FF so that the slapstic pages
;   free the wave 2 objects, the hit speech flag bumped, then phase $22
;------------------------------------------------------------------------------
wave2_end_init:
L6EB0:  LDD  #$0000
L6EB3:  STD  PH_TIM
L6EB6:  LDA  #$FF                   ;minus: the pages free the wave 2 objects of both kinds
L6EB8:  STA  w2_spawn_b
L6EBB:  STA  w2_spawn_a
L6EBE:  INC  hit_spk_done
L6EC1:  INC  PHASE

;------------------------------------------------------------------------------
; wave2_end_exec - phase $22: plays wave 2 on, as wave2_exec does without the timing tests, until neither kind
;   of wave 2 object has a live record, then goes to phase $23
;------------------------------------------------------------------------------
wave2_end_exec:
L6EC3:  JSR  vew_walker
L6EC6:  LDA  S_GAS
L6EC8:  LBMI phi_walker_die
L6ECC:  JSR  MZ_84CC                ;calls page 1 MVGUN
L6ECF:  JSR  DO1GLW
L6ED2:  JSR  MZ_83DF                ;calls page 0 cable_move
L6ED5:  JSR  DO1GAS
L6ED8:  JSR  L61AA
L6EDB:  JSR  MZ_8514                ;calls page 1 atst_move_all
L6EDE:  JSR  MZ_847E                ;calls page 0 atat_move_all
L6EE1:  JSR  MZ_8403                ;calls page 1 jedi_time_run
L6EE4:  JSR  VGTOSITE
L6EE7:  JSR  twirl_ground
L6EEA:  LDA  #$10
L6EEC:  JSR  IS1UV
L6EEF:  JSR  SMVG0B
L6EF2:  LDD  PH_TIM
L6EF5:  ADDD #$0001
L6EF8:  STD  PH_TIM
L6EFB:  LDA  w2_active_b            ;play on until neither kind has a live record
L6EFE:  ORA  w2_active_a
L6F01:  BNE  L6F07
L6F03:  LDB  #$23                   ;phase $23: the exit from wave 2
L6F05:  STB  PHASE
L6F07:  RTS

;------------------------------------------------------------------------------
; wave2_exit_init - phase $23: clears the phase timer, sends a speech (spk_cmd_23) and an effect (aud_cmd_45)
;   and falls into the wave 2 exit phase
;------------------------------------------------------------------------------
wave2_exit_init:
L6F08:  LDD  #$0000
L6F0B:  STD  PH_TIM
L6F0E:  JSR  spk_cmd_23
L6F11:  JSR  aud_cmd_45
L6F14:  INC  PHASE

;------------------------------------------------------------------------------
; wave2_exit_exec - phase $24, the flight out of wave 2: views with LA48A, still moves shots, explosions, glow
;   and the shield gauge, turns the player with L7796 and moves him with L7AFB for 40 frames, then goes to phase
;   $25, the init of wave 3
;------------------------------------------------------------------------------
wave2_exit_exec:
L6F16:  JSR  vew_walker_end
L6F19:  LDA  S_GAS
L6F1B:  LBMI phi_walker_die
L6F1F:  JSR  MZ_84CC                ;calls page 1 MVGUN
L6F22:  JSR  DO1GLW
L6F25:  JSR  MZ_83DF                ;calls page 0 cable_move
L6F28:  JSR  DO1GAS
L6F2B:  JSR  L61AA
L6F2E:  JSR  MZ_8157                ;calls page 1 jedi_on_update
L6F31:  JSR  VGTOSITE
L6F34:  JSR  twirl_unroll
L6F37:  LDA  #$10
L6F39:  JSR  IS1UV
L6F3C:  JSR  smv_descend
L6F3F:  LDD  PH_TIM
L6F42:  ADDD #$0001
L6F45:  STD  PH_TIM
L6F48:  LDD  PH_TIM
L6F4B:  CMPD #$0028
L6F4F:  BCS  L6F55
L6F51:  LDA  #$25
L6F53:  STA  PHASE
L6F55:  RTS

;------------------------------------------------------------------------------
; wave3_init - phase $25, init of wave 3: picture set 2, wave_type 2, bonus_left from the wave 3 quota, the Jedi
;   letter display turned off unless a letter is being awarded. With instructions asked for it goes to phase $43
;   (which comes back at wave3_setup), otherwise it falls into wave3_setup
;------------------------------------------------------------------------------
wave3_init:
L6F56:  LDB  #$02                   ;picture set 2
L6F58:  JSR  load_vg_set
L6F5B:  LDA  #$02                   ;wave type 2
L6F5D:  STA  wave_type
L6F60:  LDA  quota_tie              ;Jedi quota of wave 3
L6F63:  STA  bonus_left
L6F66:  LDA  jedi_show
L6F69:  CMPA #$01
L6F6B:  BEQ  L6F70
L6F6D:  CLR  jedi_show
L6F70:  LDA  manual_on              ;instructions wanted: phase $43 shows them first
L6F73:  BEQ  wave3_setup
L6F75:  LDB  #$43
L6F77:  STB  PHASE
L6F79:  RTS

;------------------------------------------------------------------------------
; wave3_setup - phase $47, the rest of the wave 3 init, entered by falling in from wave3_init or from the
;   training manual phase (manual_next_ph): general parameters and a new ship facing backwards, stars (ISTAR), the
;   wave 3 setup on page 3, fire_level from SP_WAV and diff_adder, timer and hit speech flags cleared, craft type
;   1 with its second pair of lasers, a speech (spk_cmd_24) and, while jedi_time is under $80, the part's tune
;   (tune_cmd_2c), then phase $26
;------------------------------------------------------------------------------
wave3_setup:
L6F7A:  JSR  IPARM
L6F7D:  LDA  #$C0                   ;face backwards, as in wave1_setup
L6F7F:  STA  s1_ax
L6F82:  STA  s1_by
L6F85:  JSR  L616E
L6F88:  JSR  MZ_82A7                ;calls page 3 tie_wave_init
L6F8B:  JSR  L6186
L6F8E:  LDA  SP_WAV                 ;level = 2 * wave 3 level + difficulty adder, folded into $10-$1F past $1F
L6F91:  ASLA
L6F92:  ADDA diff_adder
L6F95:  CMPA #$20
L6F97:  BCS  L6F9D
L6F99:  ANDA #$1F
L6F9B:  ORA  #$10
L6F9D:  STA  fire_level
L6FA0:  LDD  #$0000
L6FA3:  STD  PH_TIM
L6FA6:  STA  glow_said
L6FA9:  STA  hit_said
L6FAC:  LDA  #$01                   ;two pairs of laser beams
L6FAE:  STA  craft_type
L6FB1:  JSR  spk_cmd_24
L6FB4:  LDD  jedi_time              ;Jedi time under $80
L6FB7:  CMPD #$0080
L6FBB:  BCC  L6FC0
L6FBD:  JSR  tune_cmd_2c
L6FC0:  LDA  #$26
L6FC2:  STA  PHASE

;------------------------------------------------------------------------------
; wave3_exec - phase $26, wave 3 play, built on Star Wars' PHESP1: views with LA515, ends the game through
;   phi_tie_die when the shields are gone, moves shots, glows, explosions and the computer ships, runs the Jedi
;   time, turns and moves the player and moves the stars. At frame 60 it shows the Jedi letters, after 440 frames
;   it goes to phase $27, and while fewer than three ships are alive it adds another (ADASHP on page 3)
;------------------------------------------------------------------------------
wave3_exec:
L6FC4:  JSR  vew_tie
L6FC7:  LDA  S_GAS
L6FC9:  LBMI phi_tie_die
L6FCD:  JSR  MZ_84CC                ;calls page 1 MVGUN
L6FD0:  JSR  DONGLW
L6FD3:  JSR  L61AA
L6FD6:  JSR  DO1GLW
L6FD9:  JSR  DO1GAS
L6FDC:  JSR  MZ_8403                ;calls page 1 jedi_time_run
L6FDF:  JSR  MZ_836A                ;calls page 3 CPU
L6FE2:  JSR  VGTOSITE
L6FE5:  JSR  twirl_tie_wave
L6FE8:  LDA  #$10
L6FEA:  JSR  IS1UV
L6FED:  JSR  RESIDU
L6FF0:  JSR  S1MV
L6FF3:  LDD  PH_TIM
L6FF6:  ADDD #$0001
L6FF9:  STD  PH_TIM
L6FFC:  CMPD #$01B8                 ;440 frames
L7000:  BCS  L7006
L7002:  LDA  #$27                   ;440 frames: the TIE fighter wave is over, phase $27
L7004:  STA  PHASE
L7006:  LDD  PH_TIM
L7009:  CMPD #$003C                 ;60 frames into the wave
L700D:  BNE  L7019
L700F:  LDA  jedi_show
L7012:  BNE  L7019
L7014:  LDA  #$02                   ;show the Jedi letters if they are hidden
L7016:  STA  jedi_show
L7019:  LDA  WV_LIV
L701B:  CMPA #$03
L701D:  BCC  L7022
L701F:  JSR  MZ_8319                ;calls page 3 ADASHP
L7022:  RTS

;------------------------------------------------------------------------------
; phi_tie_flee - phase $27, init half of the end of the TIE fighter wave: nothing to set up, it steps PHASE to
;   $28 and falls into the execute half
;------------------------------------------------------------------------------
phi_tie_flee:
L7023:  INC  PHASE

;------------------------------------------------------------------------------
; phe_tie_flee - phase $28, the TIE fighter wave after its time is up: the same frame as the wave itself (view
;   LA515, shots, glow, explosions, shields, Jedi timer) but the fighters run away (CPURET) and the player is
;   turned towards the far object (L76A3). when no alien record is in use and unit vector A's X of the player is
;   $3800 or more it goes to phase $29. shields gone goes to phi_tie_die. Star Wars' PHESP2 with the aim test of
;   its PHES0G added
;------------------------------------------------------------------------------
phe_tie_flee:
L7025:  JSR  vew_tie
L7028:  LDA  S_GAS
L702A:  LBMI phi_tie_die
L702E:  JSR  MZ_84CC                ;calls page 1 MVGUN
L7031:  JSR  DONGLW
L7034:  JSR  L61AA
L7037:  JSR  DO1GLW
L703A:  JSR  DO1GAS
L703D:  JSR  MZ_8403                ;calls page 1 jedi_time_run
L7040:  JSR  MZ_82E3                ;calls page 3 CPURET
L7043:  JSR  VGTOSITE
L7046:  JSR  twirl_to_far
L7049:  LDA  #$10
L704B:  JSR  IS1UV
L704E:  JSR  RESIDU
L7051:  JSR  S1MV
L7054:  LDX  #ALIEN
L7057:  LDA  3,X
L7059:  BNE  L7070
L705B:  LEAX $19,X
L705E:  CMPX #ALIENZ
L7061:  BCS  L7057
L7063:  LDD  s1_ax
L7066:  CMPD #$3800
L706A:  BLT  L7070
L706C:  LDA  #$29
L706E:  STA  PHASE
L7070:  RTS

;------------------------------------------------------------------------------
; phi_tie_exit - phase $29: clears the phase timer and steps to phase $2A
;------------------------------------------------------------------------------
phi_tie_exit:
L7071:  LDD  #$0000
L7074:  STD  PH_TIM
L7077:  INC  PHASE
L7079:  RTS

;------------------------------------------------------------------------------
; phe_tie_exit - phase $2A, the way out of the TIE fighter wave: view LA599, which slides the far object 16
;   units to the left every frame, shots, glow, explosions and shields still run, the player keeps turning towards
;   the far object (L76CB) with no fighters left. when the object's screen x exec_x is -520 or less it goes to
;   phase $2B, the asteroid field. shields gone goes to phi_tie_die
;------------------------------------------------------------------------------
phe_tie_exit:
L707A:  JSR  vew_tie_end
L707D:  LDA  S_GAS
L707F:  LBMI phi_tie_die
L7083:  JSR  MZ_84CC                ;calls page 1 MVGUN
L7086:  JSR  DONGLW
L7089:  JSR  L61AA
L708C:  JSR  DO1GLW
L708F:  JSR  DO1GAS
L7092:  JSR  MZ_8157                ;calls page 1 jedi_on_update
L7095:  JSR  VGTOSITE
L7098:  JSR  turn_to_far
L709B:  LDA  #$10
L709D:  JSR  IS1UV
L70A0:  JSR  RESIDU
L70A3:  JSR  S1MV
L70A6:  LDD  PH_TIM
L70A9:  ADDD #$0001
L70AC:  STD  PH_TIM
L70AF:  LDD  exec_x
L70B2:  CMPD #$FDF8                 ;far object off the left edge (x -520)?
L70B6:  BGT  L70BC
L70B8:  LDA  #$2B
L70BA:  STA  PHASE
L70BC:  RTS

;------------------------------------------------------------------------------
; phi_asteroids - phase $2B, init of the asteroid field wave: pseudo vector ROM set 2, wave_type = 3, bonus
;   count from quota_astrd, Jedi letters hidden unless one is being awarded. if instructions were chosen
;   (manual_on) it goes to phase $43 for the training manual page, which comes back through asteroid_setup, else
;   it branches into asteroid_setup past the object and star set-up
;------------------------------------------------------------------------------
phi_asteroids:
L70BD:  LDB  #$02                   ;pseudo vector ROM set 2
L70BF:  JSR  load_vg_set
L70C2:  LDA  #$03                   ;wave type 3: asteroid field
L70C4:  STA  wave_type
L70C7:  LDA  quota_astrd
L70CA:  STA  bonus_left             ;quota_astrd is this wave's bonus quota
L70CD:  LDA  jedi_show
L70D0:  CMPA #$01                   ;1 = a letter is being awarded, leave it, else hide the letters
L70D2:  BEQ  L70D7
L70D4:  CLR  jedi_show
L70D7:  LDA  manual_on              ;instructions chosen?
L70DA:  BEQ  L70E1
L70DC:  LDB  #$43                   ;then the training manual page first
L70DE:  STB  PHASE
L70E0:  RTS
L70E1:  BRA  L70E9                  ;skip the reset, the stars are already set up

;------------------------------------------------------------------------------
; asteroid_setup - phase $48, the rest of the asteroid part's init, entered from the training manual phase
;   (manual_next_ph) with new parameters and stars, and at L70E9 from phi_asteroids: sets the asteroids up on page
;   2 (P2_9561), forward speed $0100, fire_level from w4_level and diff_adder, timer and hit_said cleared, craft
;   type 1, the part's tune while jedi_time is under $80 and a speech picked by GM_WAV (0, even, odd), then phase
;   $2C
;------------------------------------------------------------------------------
asteroid_setup:
L70E3:  JSR  IPARM
L70E6:  JSR  L616E
L70E9:  JSR  MZ_84DE                ;calls page 2 astrd_init
L70EC:  JSR  L6186
L70EF:  LDD  #$0100                 ;player's forward speed
L70F2:  STD  s1_vx
L70F5:  LDA  w4_level               ;level = 2 * wave number + difficulty adder
L70F8:  ASLA
L70F9:  ADDA diff_adder
L70FC:  CMPA #$20
L70FE:  BCS  L7104
L7100:  ANDA #$1F                   ;$20 and up folds into $10-$1F
L7102:  ORA  #$10
L7104:  STA  fire_level
L7107:  LDD  #$0000
L710A:  STD  PH_TIM
L710D:  STA  hit_said
L7110:  LDA  #$01                   ;craft type 1
L7112:  STA  craft_type
L7115:  LDD  jedi_time
L7118:  CMPD #$0080                 ;sound request only when less than $80 is left of the Jedi time
L711C:  BCC  L7121
L711E:  JSR  tune_cmd_29
L7121:  LDA  GM_WAV                 ;music request by wave number: wave 0
L7124:  BNE  L712B
L7126:  JSR  spk_cmd_1c
L7129:  BRA  L713A
L712B:  ANDA #$01
L712D:  BNE  L7137
L712F:  JSR  spk_cmd_22             ;even waves from 2 on
L7132:  JSR  spk_cmd_1f
L7135:  BRA  L713A
L7137:  JSR  spk_cmd_26             ;odd waves
L713A:  LDA  #$2C                   ;phase $2C: the asteroid field
L713C:  STA  PHASE

;------------------------------------------------------------------------------
; phe_asteroids - phase $2C, the asteroid field wave: view LA5F9, shots, explosions, glow, shields, Jedi timer,
;   asteroids moved and launched (P2_96E0), player twirled by twirl_asteroid and moved by S1MVBS. it lasts 300
;   frames in waves 0 and 1 and 400 in later waves, then phase $2D. 40 frames before the end it requests
;   spk_cmd_20 and stops the asteroids (astrd_max = $FF). 60 frames in it shows the Jedi letters. shields gone
;   goes to L73AA
;------------------------------------------------------------------------------
phe_asteroids:
L713E:  JSR  vew_asteroid
L7141:  LDA  S_GAS
L7143:  LBMI phi_astrd_die
L7147:  JSR  MZ_84CC                ;calls page 1 MVGUN
L714A:  JSR  L61AA
L714D:  JSR  DO1GLW
L7150:  JSR  DO1GAS
L7153:  JSR  MZ_8403                ;calls page 1 jedi_time_run
L7156:  JSR  MZ_84A8                ;calls page 2 astrd_move_all
L7159:  JSR  VGTOSITE
L715C:  JSR  twirl_asteroid
L715F:  LDA  #$10
L7161:  JSR  IS1UV
L7164:  JSR  RESIDU
L7167:  JSR  S1MVBS
L716A:  LDD  PH_TIM
L716D:  ADDD #$0001
L7170:  STD  PH_TIM
L7173:  LDA  GM_WAV                 ;length of the wave: 300 frames in waves 0 and 1, 400 later
L7176:  BNE  L717D
L7178:  LDD  #$012C
L717B:  BRA  L7189
L717D:  CMPA #$01
L717F:  BNE  L7186
L7181:  LDD  #$012C
L7184:  BRA  L7189
L7186:  LDD  #$0190
L7189:  CMPD PH_TIM
L718D:  BCC  L7193
L718F:  LDA  #$2D                   ;over: phase $2D, the Jedi letter
L7191:  STA  PHASE
L7193:  LDA  GM_WAV                 ;40 frames before the end: 260 or 360
L7196:  BNE  L719D
L7198:  LDD  #$0104
L719B:  BRA  L71A9
L719D:  CMPA #$01
L719F:  BNE  L71A6
L71A1:  LDD  #$0104
L71A4:  BRA  L71A9
L71A6:  LDD  #$0168
L71A9:  CMPD PH_TIM
L71AD:  BNE  L71B7
L71AF:  JSR  spk_cmd_20
L71B2:  LDA  #$FF                   ;no more asteroids
L71B4:  STA  astrd_max
L71B7:  LDD  PH_TIM                 ;60 frames in: show the Jedi letters if they are hidden
L71BA:  CMPD #$003C
L71BE:  BNE  L71CA
L71C0:  LDA  jedi_show
L71C3:  BNE  L71CA
L71C5:  LDA  #$02
L71C7:  STA  jedi_show
L71CA:  RTS

;------------------------------------------------------------------------------
; phi_jedi_award - phase $2D, init of the award after the asteroid field: clears the phase timer, awards the
;   Jedi letter (P1_9573), requests sound $4A (LC64D) and falls into phase $2E
;------------------------------------------------------------------------------
phi_jedi_award:
L71CB:  LDD  #$0000
L71CE:  STD  PH_TIM
L71D1:  JSR  MZ_81E4                ;calls page 1 jedi_award
L71D4:  JSR  aud_cmd_4a
L71D7:  INC  PHASE

;------------------------------------------------------------------------------
; phe_jedi_award - phase $2E, the award after the asteroid field: view LA63E with message $4D (5,000 points and
;   Jedi letter awarded), explosions, glow and shields still run. requests spk_cmd_0a at frame 50, shows the Jedi
;   letters at frame 60 if they are hidden, and goes to phase $2F after 70 frames. shields gone goes to L73AA
;------------------------------------------------------------------------------
phe_jedi_award:
L71D9:  JSR  vew_asteroid_end
L71DC:  LDA  S_GAS
L71DE:  LBMI phi_astrd_die
L71E2:  JSR  L61AA
L71E5:  JSR  DO1GLW
L71E8:  JSR  DO1GAS
L71EB:  JSR  MZ_8157                ;calls page 1 jedi_on_update
L71EE:  JSR  VGTOSITE
L71F1:  LDA  #$10
L71F3:  JSR  IS1UV
L71F6:  LDD  PH_TIM
L71F9:  ADDD #$0001
L71FC:  STD  PH_TIM
L71FF:  CMPD #$0046                 ;70 frames
L7203:  BCS  L7209
L7205:  LDA  #$2F
L7207:  STA  PHASE
L7209:  LDD  PH_TIM
L720C:  CMPD #$0032                 ;frame 50
L7210:  BNE  L7215
L7212:  JSR  spk_cmd_0a
L7215:  LDD  PH_TIM
L7218:  CMPD #$003C                 ;frame 60: show the Jedi letters if they are hidden
L721C:  BNE  L7228
L721E:  LDA  jedi_show
L7221:  BNE  L7228
L7223:  LDA  #$02
L7225:  STA  jedi_show
L7228:  RTS

;------------------------------------------------------------------------------
; ph_to_set_done - phases $2F and $30 (both table entries point here): sets PHASE to $31 and falls into its
;   init, so the frame is not lost. phase $2F is set by L71D9, no instruction was found that sets $30
;------------------------------------------------------------------------------
ph_to_set_done:
L7229:  LDA  #$31                   ;phase $31, entered at once
L722B:  STA  PHASE

;------------------------------------------------------------------------------
; phi_set_done - phase $31, init of the wave completed screen: pseudo vector ROM set 2, phase timer cleared, all
;   messages off, speech request spk_cmd_0c, 2,500 points added (LB65D), then it falls into phase $32
;------------------------------------------------------------------------------
phi_set_done:
L722D:  LDB  #$02
L722F:  JSR  load_vg_set
L7232:  LDD  #$0000
L7235:  STD  PH_TIM
L7238:  JSR  ALLOFF
L723B:  JSR  spk_cmd_0c
L723E:  JSR  scr_wave_done          ;2,500 points for the completed wave
L7241:  INC  PHASE

;------------------------------------------------------------------------------
; phe_set_done - phase $32, the wave completed screen, 128 frames: view LA6B2 shows message $4E (wave completed:
;   2,500 points) for the first 64 frames and, in the first set of the game (start_bonus), the starting wave bonus
;   message for the next 64. at frame 64 that bonus is added to the score (LB5D4). at frame 128 it clears
;   start_bonus and goes to phase $33
;------------------------------------------------------------------------------
phe_set_done:
L7243:  JSR  vew_wave_bonus
L7246:  JSR  DO1GAS
L7249:  JSR  MZ_8157                ;calls page 1 jedi_on_update
L724C:  LDD  PH_TIM
L724F:  ADDD #$0001
L7252:  STD  PH_TIM
L7255:  CMPD #$0040                 ;frame 64
L7259:  BNE  L7263
L725B:  LDA  start_bonus            ;first set of this game?
L725E:  BEQ  L7263
L7260:  JSR  scr_level_bonus        ;then add the bonus for the wave the game started on
L7263:  LDD  PH_TIM
L7266:  CMPD #$0080                 ;128 frames
L726A:  BCS  L7273
L726C:  CLR  start_bonus
L726F:  LDA  #$33
L7271:  STA  PHASE
L7273:  RTS

;------------------------------------------------------------------------------
; phi_next_set - phase $33, first half of going on to the next set of four waves: objects and the player's ship
;   reset, manual_on cleared, the four bonus quotas (probots, walkers, TIE fighters, quota_astrd) each one higher
;   with 90 as the top, and the wave to continue from (GM_WAV + 1) with the score so far saved in pend_wave and
;   pend_bonus. falls into phase $34
;------------------------------------------------------------------------------
phi_next_set:
L7274:  JSR  IPGEN
L7277:  JSR  IPARM
L727A:  CLR  manual_on
L727D:  LDA  quota_probot           ;probot quota one higher, 90 at most
L7280:  INCA
L7281:  CMPA #$5A
L7283:  BLS  L7287
L7285:  LDA  #$5A
L7287:  STA  quota_probot
L728A:  LDA  quota_walker           ;walker quota
L728D:  INCA
L728E:  CMPA #$5A
L7290:  BLS  L7294
L7292:  LDA  #$5A
L7294:  STA  quota_walker
L7297:  LDA  quota_tie              ;TIE fighter quota
L729A:  INCA
L729B:  CMPA #$5A
L729D:  BLS  L72A1
L729F:  LDA  #$5A
L72A1:  STA  quota_tie
L72A4:  LDA  quota_astrd
L72A7:  INCA
L72A8:  CMPA #$5A
L72AA:  BLS  L72AE
L72AC:  LDA  #$5A
L72AE:  STA  quota_astrd
L72B1:  LDA  GM_WAV                 ;the wave a next game may continue from: the next one
L72B4:  INCA
L72B5:  STA  pend_wave
L72B8:  LDD  S_SC87                 ;with the score so far
L72BA:  STD  pend_bonus
L72BD:  LDD  S_SC43
L72BF:  STD  pend_bonus_2
L72C2:  INC  PHASE

;------------------------------------------------------------------------------
; phe_next_set - phase $34, second half: in waves 0 to 2 diff_step goes up by one and is added to diff_adder,
;   then the wave number GM_WAV goes up by one (it stays at $FF) and PHASE = PHS_BGN starts the next set
;------------------------------------------------------------------------------
phe_next_set:
L72C4:  LDA  GM_WAV                 ;waves 0 to 2: the difficulty adder grows by 1, then 2, then 3
L72C7:  CMPA #$02
L72C9:  BHI  L72D7
L72CB:  INC  diff_step
L72CE:  LDA  diff_adder
L72D1:  ADDA diff_step
L72D4:  STA  diff_adder
L72D7:  INC  GM_WAV                 ;next wave number, it stays at $FF
L72DA:  BNE  L72DF
L72DC:  DEC  GM_WAV
L72DF:  LDA  #$15
L72E1:  STA  PHASE
L72E3:  RTS

;------------------------------------------------------------------------------
; phi_probot_die - phase $35, init of the player's death in the probot part (the probot phases branch here when
;   S_GAS goes minus), Star Wars' PHIS0D with a mute added: drops the waiting speech (spk_cmd_13), PHASE = $36,
;   phase timer cleared, snd_mute = 1. falls into the execute half
;------------------------------------------------------------------------------
phi_probot_die:
L72E4:  JSR  spk_cmd_13
L72E7:  LDA  #$36
L72E9:  STA  PHASE                  ;EXECUTE THIS PHASE
L72EB:  LDD  #$0000
L72EE:  STD  PH_TIM                 ;NEW PHASE TIMER JUST STARTED
L72F1:  LDA  #$01                   ;mutes the sound effects sent through LC4DA
L72F3:  STA  snd_mute

;------------------------------------------------------------------------------
; phe_probot_die - phase $36, execute half of phi_probot_die, the death of the player in the probot wave (the
;   probot phases branch to phi_probot_die when S_GAS goes minus): view vew_probot_die with the growing GAME OVER,
;   shots still move, the glow is kept flashing, speech request spk_cmd_1a at frame 8, and after 40 frames PHASE =
;   PHS_EGM
;------------------------------------------------------------------------------
phe_probot_die:
L72F6:  JSR  vew_probot_die
L72F9:  JSR  MZ_84CC                ;calls page 1 MVGUN
L72FC:  JSR  KPGLOW
L72FF:  LDD  PH_TIM
L7302:  CMPD #$0008                 ;frame 8
L7306:  BNE  L730B
L7308:  JSR  spk_cmd_1a
L730B:  LDD  PH_TIM
L730E:  ADDD #$0001
L7311:  STD  PH_TIM
L7314:  CMPD #$0028                 ;2 SECONDS
L7318:  BLO  L731E                  ;IFHS
L731A:  LDA  #PHS_EGM
L731C:  STA  PHASE
L731E:  RTS

;------------------------------------------------------------------------------
; phi_walker_die - phase $37 (PHS_G0D), init of the player's death in the walker part (the walker phases branch
;   here when S_GAS goes minus), Star Wars' PHIG0D with a mute added: drops the waiting speech (spk_cmd_13), PHASE
;   = $38, phase timer cleared, snd_mute = 1. falls into the execute half
;------------------------------------------------------------------------------
phi_walker_die:
L731F:  JSR  spk_cmd_13
L7322:  LDA  #PHS_G0D+1
L7324:  STA  PHASE                  ;EXECUTE THIS PHASE
L7326:  LDD  #$0000
L7329:  STD  PH_TIM                 ;NEW PHASE TIMER JUST STARTED
L732C:  LDA  #$01                   ;mutes the sound effects sent through LC4DA
L732E:  STA  snd_mute

;------------------------------------------------------------------------------
; phe_walker_die - phase $38, the death of the player in the walker part, Star Wars' PHEG0D: view vew_walker_die
;   with the growing GAME OVER, shots still move, the glow is kept flashing, speech request spk_cmd_1a at frame 8,
;   and after 40 frames PHASE = PHS_EGM
;------------------------------------------------------------------------------
phe_walker_die:
L7331:  JSR  vew_walker_die
L7334:  JSR  MZ_84CC                ;calls page 1 MVGUN
L7337:  JSR  KPGLOW
L733A:  LDD  PH_TIM
L733D:  CMPD #$0008                 ;frame 8
L7341:  BNE  L7346
L7343:  JSR  spk_cmd_1a
L7346:  LDD  PH_TIM
L7349:  ADDD #$0001
L734C:  STD  PH_TIM
L734F:  CMPD #$0028                 ;2 SECONDS
L7353:  BLO  L7359                  ;IFHS
L7355:  LDA  #PHS_EGM
L7357:  STA  PHASE
L7359:  RTS

;------------------------------------------------------------------------------
; phi_tie_die - phase $39, init of the player's death in the TIE fighter part (the TIE fighter phases branch
;   here when S_GAS goes minus): drops the waiting speech (spk_cmd_13), PHASE = $3A, phase timer cleared, snd_mute
;   = 1. falls into the execute half
;------------------------------------------------------------------------------
phi_tie_die:
L735A:  JSR  spk_cmd_13
L735D:  LDA  #$3A
L735F:  STA  PHASE                  ;EXECUTE THIS PHASE
L7361:  LDD  #$0000
L7364:  STD  PH_TIM                 ;NEW PHASE TIMER JUST STARTED
L7367:  LDA  #$01                   ;mutes the sound effects sent through LC4DA
L7369:  STA  snd_mute

;------------------------------------------------------------------------------
; phe_tie_die - phase $3A, the death of the player in the TIE fighter part, Star Wars' PHES0D: view vew_tie_die
;   with the growing GAME OVER, shots still move, the glow is kept flashing, the aliens' glow and the explosions
;   run, and the craft rolls 4.48 degrees a frame. speech request spk_cmd_1b at frame 8, after 40 frames PHASE =
;   PHS_EGM
;------------------------------------------------------------------------------
phe_tie_die:
L736C:  JSR  vew_tie_die
L736F:  JSR  MZ_84CC                ;calls page 1 MVGUN
L7372:  JSR  KPGLOW
L7375:  JSR  DONGLW
L7378:  JSR  L61AA
L737B:  LDD  #$FB01                 ;FLIP DIRECTION OF ROLL CUZ WE ARE DIEING
L737E:  STD  M_SIN
L7381:  LDD  #$3FCE
L7384:  STD  M_COS
L7387:  JSR  S1RL
L738A:  LDD  PH_TIM
L738D:  CMPD #$0008                 ;frame 8
L7391:  BNE  L7396
L7393:  JSR  spk_cmd_1b
L7396:  LDD  PH_TIM
L7399:  ADDD #$0001
L739C:  STD  PH_TIM
L739F:  CMPD #$0028                 ;2 SECONDS
L73A3:  BLO  L73A9                  ;IFHS
L73A5:  LDA  #PHS_EGM
L73A7:  STA  PHASE
L73A9:  RTS

;------------------------------------------------------------------------------
; phi_astrd_die - phase $3B, init of the death of the player in the asteroid field (reached by branch from
;   phases $2C and $2E): speech request spk_cmd_13, PHASE = $3C, asteroids stopped (astrd_max = $FF), phase timer
;   cleared, snd_mute = 1 which mutes the sound effects sent through LC4DA. falls into the execute half
;------------------------------------------------------------------------------
phi_astrd_die:
L73AA:  JSR  spk_cmd_13
L73AD:  LDA  #$3C
L73AF:  STA  PHASE
L73B1:  LDA  #$FF                   ;stop the asteroid field
L73B3:  STA  astrd_max
L73B6:  LDD  #$0000
L73B9:  STD  PH_TIM
L73BC:  LDA  #$01                   ;mutes the sound effects sent through LC4DA
L73BE:  STA  snd_mute

;------------------------------------------------------------------------------
; phe_astrd_die - phase $3C, the death in the asteroid field: view LA66A with the growing GAME OVER, glow kept
;   flashing, explosions, the asteroids still move, and the craft rolls 4.48 degrees a frame as in phe_tie_die.
;   speech request spk_cmd_1b at frame 8, after 40 frames PHASE = PHS_EGM
;------------------------------------------------------------------------------
phe_astrd_die:
L73C1:  JSR  vew_asteroid_die
L73C4:  JSR  KPGLOW
L73C7:  JSR  L61AA
L73CA:  JSR  MZ_84A8                ;calls page 2 astrd_move_all
L73CD:  LDD  #$FB01                 ;FLIP DIRECTION OF ROLL CUZ WE ARE DIEING
L73D0:  STD  M_SIN
L73D3:  LDD  #$3FCE
L73D6:  STD  M_COS
L73D9:  JSR  S1RL
L73DC:  LDD  PH_TIM
L73DF:  CMPD #$0008                 ;frame 8
L73E3:  BNE  L73E8
L73E5:  JSR  spk_cmd_1b
L73E8:  LDD  PH_TIM
L73EB:  ADDD #$0001
L73EE:  STD  PH_TIM
L73F1:  CMPD #$0028                 ;2 SECONDS
L73F5:  BLO  L73FB                  ;IFHS
L73F7:  LDA  #PHS_EGM
L73F9:  STA  PHASE
L73FB:  RTS

;------------------------------------------------------------------------------
; phi_die_plain - phase $3D, init of a fifth dying phase: speech request spk_cmd_13, PHASE = $3E, phase timer
;   cleared, snd_mute = 1, falls into the execute half. reached only through the phase table and no instruction
;   was found that sets phase $3D
;------------------------------------------------------------------------------
phi_die_plain:
L73FC:  JSR  spk_cmd_13
L73FF:  LDA  #$3E
L7401:  STA  PHASE                  ;EXECUTE THIS PHASE
L7403:  LDD  #$0000
L7406:  STD  PH_TIM                 ;NEW PHASE TIMER JUST STARTED
L7409:  LDA  #$01                   ;mutes the sound effects sent through LC4DA
L740B:  STA  snd_mute

;------------------------------------------------------------------------------
; phe_die_plain - phase $3E: view vew_die_plain (score, Jedi letters, shields and the growing GAME OVER, no
;   scene), glow kept flashing, speech request spk_cmd_1a at frame 8, after 40 frames PHASE = PHS_EGM
;------------------------------------------------------------------------------
phe_die_plain:
L740E:  JSR  vew_die_plain
L7411:  JSR  KPGLOW
L7414:  LDD  PH_TIM
L7417:  CMPD #$0008                 ;frame 8
L741B:  BNE  L7420
L741D:  JSR  spk_cmd_1a
L7420:  LDD  PH_TIM
L7423:  ADDD #$0001
L7426:  STD  PH_TIM
L7429:  CMPD #$0028                 ;2 SECONDS
L742D:  BLO  L7433                  ;IFHS
L742F:  LDA  #PHS_EGM
L7431:  STA  PHASE
L7433:  RTS

;------------------------------------------------------------------------------
; PHIEGM - phase $3F (PHS_EGM), Star Wars' PHIEGM without its farewell speech: drops the waiting speech
;   (spk_cmd_13) and falls into PHEEGM
;------------------------------------------------------------------------------
PHIEGM:
L7434:  JSR  spk_cmd_13
L7437:  INC  PHASE

;------------------------------------------------------------------------------
; PHEEGM - phase $40, Star Wars' PHEEGM with the continue offer added: math box, parameters and stars restored,
;   Jedi letters shown, jedi_blink and snd_mute cleared, then bank 1 does the accounting (EEACCT) and looks for a
;   new high score. with one it goes to phase $41, the initials. else, if the Jedi bonus was earned, the pending
;   offer becomes the continue offer, and an offer of wave 4 or higher goes to phase $11. else a speech (only when
;   the game ended in the probot or walker part) and a tune are sent and the phase is the banner
;------------------------------------------------------------------------------
PHEEGM:
L7439:  JSR  IPGEN
L743C:  JSR  IPARM
L743F:  JSR  L616E
L7442:  LDU  #M_CX1
L7445:  JSR  UNITV
L7448:  LDA  #$02                   ;Jedi letters shown
L744A:  STA  jedi_show
L744D:  CLRA                        ;blink counter restarted, sound effects on again
L744E:  STA  jedi_blink
L7451:  STA  snd_mute
L7454:  JSR  L612C
L7457:  JSR  L6114
L745A:  JSR  L6102
L745D:  LDA  UPDFLG
L7460:  BMI  L7468
L7462:  LDA  #$41
L7464:  STA  PHASE
L7466:  BRA  L749B
L7468:  LDB  jedi_done              ;Jedi bonus earned in this game?
L746B:  BEQ  L747F
L746D:  LDB  pend_wave              ;then the last finished set becomes the continue offer: wave
L7470:  STB  cont_wave
L7473:  LDD  pend_bonus             ;and score
L7476:  STD  cont_bonus
L7479:  LDD  pend_bonus_2
L747C:  STD  cont_bonus_2
L747F:  LDB  cont_wave              ;an offer of wave 4 or higher?
L7482:  CMPB #$03
L7484:  BCS  L748A
L7486:  LDA  #$11                   ;phase $11: the continue screen
L7488:  BRA  L7499
L748A:  LDA  wave_type              ;wave type 0 or 1 (probots, walkers)?
L748D:  CMPA #$02
L748F:  BCC  L7494
L7491:  JSR  spk_cmd_1e
L7494:  JSR  tune_cmd_30
L7497:  LDA  #$01                   ;phase 1: the banner
L7499:  STA  PHASE
L749B:  RTS

;------------------------------------------------------------------------------
; PHIENT - ENTER INITIALS
;   in ESB: the page is message $31 (message from rebel command post, shoot your initials) and the tune of
;   command $31 is started
;------------------------------------------------------------------------------
PHIENT:
L749C:  LDD  #$0000
L749F:  STD  PH_TIM
L74A2:  STD  PH_YOF
L74A5:  STD  >MSYOFF
L74A8:  LDD  #VGCOLR+(VGCBLU*$100)
L74AB:  STD  PH_COL
L74AE:  JSR  ALLOFF
L74B1:  LDB  #$31                   ;message $31: message from rebel command post, shoot your initials
L74B3:  JSR  MESSON
L74B6:  JSR  tune_cmd_31
L74B9:  INC  PHASE
L74BB:  RTS

;------------------------------------------------------------------------------
; PHEENT - phase $42, Star Wars' PHEENT with the continue offer added: the initials entry. score, coin lines,
;   the high score table and the messages, bank 1's GETINT takes the initials. the test switch or $280 frames end
;   it. when it is done the pending offer becomes the continue offer if the Jedi bonus was earned, and the phase
;   is $11 for an offer of wave 4 or higher, else $09, the high score table
;------------------------------------------------------------------------------
PHEENT:
L74BC:  JSR  ivgen1_wait
L74BF:  JSR  vw_score_all
L74C2:  JSR  VWCOIN
L74C5:  JSR  L60F6
L74C8:  JSR  VWMESS
L74CB:  JSR  VGDONE
L74CE:  JSR  L6108                  ;GET THE PLAYER'S INITIALS
L74D1:  LDA  >IN_SW0                ;CHECK FOR TEST SWITCH
L74D4:  ANDA #TESTBT
L74D6:  BNE  L74DE                  ;IFEQ  YES
L74D8:  LDD  #$0280                 ;THEN ATTEMPT TO LEAVE THIS MODE GRACEFULLY
L74DB:  STD  PH_TIM                 ;SAYS TIME'S UP, NO MORE INITIALS
L74DE:  LDD  PH_TIM
L74E1:  ADDD #$0001
L74E4:  STD  PH_TIM
L74E7:  CMPD #$0280                 ;GIVE 'EM ABOUT 30 SECONDS
L74EB:  BLO  L74F3                  ;IFHS
L74ED:  LDD  #$FFFF
L74F0:  STD  UPDFLG
L74F3:  LDA  UPDFLG
L74F6:  BPL  L751E
L74F8:  LDB  jedi_done              ;Jedi bonus earned: the last finished set becomes the continue offer
L74FB:  BEQ  L750F
L74FD:  LDB  pend_wave
L7500:  STB  cont_wave
L7503:  LDD  pend_bonus
L7506:  STD  cont_bonus
L7509:  LDD  pend_bonus_2
L750C:  STD  cont_bonus_2
L750F:  LDB  cont_wave              ;an offer of wave 4 or higher?
L7512:  CMPB #$03
L7514:  BCS  L751A
L7516:  LDA  #$11                   ;phase $11: the continue screen
L7518:  BRA  L751C
L751A:  LDA  #$09                   ;else phase 9: the high score table
L751C:  STA  PHASE
L751E:  RTS

;------------------------------------------------------------------------------
; phi_manual - phase $43, init of a training manual page, entered from the init of a part when manual_on is set:
;   new parameters and ground stars, the ship facing forward ($40 in s1_ax and s1_by), the page of section
;   wave_type set up (manual_page_init), timer and man_done cleared, man_running bumped
;------------------------------------------------------------------------------
phi_manual:
L751F:  JSR  IPARM
L7522:  JSR  L6174
L7525:  LDA  #$40
L7527:  STA  s1_ax
L752A:  STA  s1_by
L752D:  JSR  manual_page_init       ;set up the training manual page of part wave_type
L7530:  JSR  L6186
L7533:  LDD  #$0000
L7536:  STD  PH_TIM
L7539:  CLR  man_done               ;page not finished
L753C:  INC  man_running            ;manual running: the demonstration does not count
L753F:  INC  PHASE
L7541:  RTS

;------------------------------------------------------------------------------
; phe_manual - phase $44, execute half of phi_manual, one page of the rebel training manual shown before a wave
;   when instructions were chosen: view LA697, then LB189 runs the page's script and the demonstration of part
;   wave_type. when the script ends (man_done) or after 400 frames PHASE is taken from manual_next_ph for the wave
;   type ($45 probots, $46 walkers, $47 TIE fighters, $48 asteroids, each the wave's own set-up) and the glow, the
;   hit and man_running are cleared
;------------------------------------------------------------------------------
phe_manual:
L7542:  JSR  vew_manual
L7545:  JSR  manual_run
L7548:  LDD  PH_TIM
L754B:  ADDD #$0001
L754E:  STD  PH_TIM
L7551:  TST  man_done               ;page script ended?
L7554:  BNE  L755F
L7556:  LDD  PH_TIM
L7559:  CMPD #$0190                 ;or 400 frames
L755D:  BCS  L757A
L755F:  LDB  wave_type              ;wave type
L7562:  CMPB #$04
L7564:  BCS  L7568
L7566:  LDB  #$00                   ;(out of range: probots)
L7568:  LDX  #manual_next_ph
L756B:  LDB  B,X                    ;the phase that sets the wave up
L756D:  STB  PHASE
L756F:  LDA  #$00
L7571:  STA  GS_HIT
L7573:  STA  GS_GLW
L7575:  STA  S_GLW
L7577:  STA  man_running
L757A:  RTS

manual_next_ph:
L757B:  .byte $45, $46, $47, $48    ;by wave type: probots, walkers, TIE fighters, asteroids

;------------------------------------------------------------------------------
; NW1SHP - RESET UNITVECTORS ALSO
;------------------------------------------------------------------------------
NW1SHP:
L757F:  LDU  #M_S1
L7582:  JSR  UNITV
L7585:  LDD  #$0000
L7588:  STD  MS_TX+M_S1
L758B:  STD  MS_TY+M_S1
L758E:  STD  MS_TZ+M_S1

;------------------------------------------------------------------------------
; OLD1SHP - USE OLD UNIT VECTORS
;------------------------------------------------------------------------------
OLD1SHP:
L7591:  LDD  #$0000
L7594:  STA  S_GLW
L7596:  STA  S_ROL
L7598:  STA  VG_LON
L759A:  STA  LZ_ON                  ;TURN OFF LAZARS
L759C:  STA  LZ_EDG
L759E:  STA  LZ_HIT
L75A0:  STD  GD_ACT
L75A2:  STA  >RHS_RSD+RHEOR         ;SPECIAL ROLL
L75A5:  STA  >RHS_RSD+RHEOP         ;CLEAR OUT MAGIC RESIDUE
L75A8:  STA  >RHS_RSD+RHEOY
L75AB:  RTS

;------------------------------------------------------------------------------
; set_bonus_quota - sets the four bonus quotas (quota_probot, quota_walker, quota_tie, quota_astrd) from the
;   starting wave number GM_WAV: 6, 8, 10 from quota_tab for waves 0 to 2, GM_WAV + 9 for later waves. called by
;   PHISG2 when a game starts
;------------------------------------------------------------------------------
set_bonus_quota:
L75AC:  LDB  GM_WAV
L75AF:  CMPB #$02                   ;waves 0 to 2: quota from the table
L75B1:  BHI  L75BA
L75B3:  LDX  #quota_tab
L75B6:  LDB  B,X
L75B8:  BRA  L75C2
L75BA:  ADDB #$09                   ;later waves: wave number + 9
L75BC:  CMPB #$5A                   ;over 90?
L75BE:  BLS  L75C2
L75C0:  LDB  #$90                   ;$90 is loaded here, not $5A (L7274 brings it to $5A at the end of the set)
L75C2:  STB  quota_probot           ;the same quota for all four wave types
L75C5:  STB  quota_walker
L75C8:  STB  quota_tie
L75CB:  STB  quota_astrd
L75CE:  RTS

quota_tab:
L75CF:  .byte $06, $08, $0A         ;bonus quota of waves 0, 1, 2

;------------------------------------------------------------------------------
; PHISTS - STATISTICS DISPLAY
;------------------------------------------------------------------------------
PHISTS:
L75D2:  JSR  ALLOFF
L75D5:  LDD  #$0000                 ;NO Y OFFSET FOR MESSAGES
L75D8:  STD  PH_YOF
L75DB:  STD  >MSYOFF
L75DE:  INC  PHASE
L75E0:  RTS

;------------------------------------------------------------------------------
; PHESTS - phase $4A, Star Wars' PHESTS: the statistics page, drawn by bank 1 (K712B). the aux switch goes on to
;   the option page (phase $4B), the test switch off goes back to the banner
;------------------------------------------------------------------------------
PHESTS:
L75E1:  JSR  ivgen1_wait
L75E4:  JSR  L6120
L75E7:  JSR  VWMESS
L75EA:  JSR  VGDONE
L75ED:  LDA  GN_SWE                 ;CHECK FOR AUX SWITCH
L75EF:  ANDA #AUXBIT
L75F1:  BEQ  L75F7                  ;IFNE  GOTO NEXT PHASE
L75F3:  LDA  #$4B                   ;OPTIONS PAGE
L75F5:  STA  PHASE
L75F7:  LDA  >IN_SW0                ;CHECK FOR SELF TEST SWITCH
L75FA:  ANDA #TESTBT
L75FC:  BEQ  L7602                  ;IFNE  SWITCH OFF, GO BACK TO ATTRACT MODE
L75FE:  LDA  #PHS_BNR               ;BANNER PHASE
L7600:  STA  PHASE
L7602:  RTS

;------------------------------------------------------------------------------
; PHIOPT - OPTION SWITCH  (comment at its table entry)
;------------------------------------------------------------------------------
PHIOPT:
L7603:  JSR  ALLOFF                 ;TURN OFF ALL MESSAGES
L7606:  LDA  #$0A                   ;HIGH LITE INDEX STARTS WITH MESSAGE
L7608:  STA  EEINDX
L760B:  LDA  #$00
L760D:  STA  RESETS                 ;START WITH A CLEAN SHEET
L7610:  STA  NVTSTR                 ;NOVRAM TEST RESULTS ( 0 MEANS NO TEST DONE )
L7613:  JSR  L6150
L7616:  INC  PHASE
L7618:  RTS

;------------------------------------------------------------------------------
; PHEOPT - phase $4C, Star Wars' PHEOPT: the option page, drawn and changed by bank 1 (K76AD, K773E). the aux
;   switch jumps to HANG, so the watchdog resets the machine, the test switch off goes back to the banner
;------------------------------------------------------------------------------
PHEOPT:
L7619:  JSR  ivgen1_wait
L761C:  JSR  L6156
L761F:  LDD  #$6780
L7622:  STD  ,Y++
L7624:  JSR  L615C
L7627:  JSR  VWMESS
L762A:  JSR  VGDONE
L762D:  LDA  GN_SWE                 ;CHECK FOR AUX SWITCH
L762F:  ANDA #AUXBIT
L7631:  BEQ  L7636                  ;IFNE  GOTO NEXT PHASE
L7633:  JMP  HANG
L7636:  LDA  >IN_SW0                ;CHECK FOR SELF TEST SWITCH
L7639:  ANDA #TESTBT
L763B:  BEQ  L7644                  ;IFNE  SWITCH OFF, GO BACK TO ATTRACT MODE
L763D:  JSR  ALLOFF                 ;TURN OFF ALL MESSAGES
L7640:  LDA  #PHS_BNR               ;BANNER PHASE
L7642:  STA  PHASE
L7644:  RTS

;------------------------------------------------------------------------------
; SMVBNR - star movement of the banner phase, called by L6445: ST_UX and ST_UZ each $80 further. the same
;   instructions as Star Wars' SMVBNR, which the matcher missed
;------------------------------------------------------------------------------
SMVBNR:
L7645:  LDD  >ST_UX
L7648:  ADDD #$0080
L764B:  STD  >ST_UX
L764E:  LDD  ST_UZ
L7651:  ADDD #$0080                 ;45 DEGREES UP Z
L7654:  STD  ST_UZ
L7657:  RTS

;------------------------------------------------------------------------------
; SMVINS - STAR MOVEMENT DURING FLIGHT INSTRUCTION PHASE
;------------------------------------------------------------------------------
SMVINS:
L7658:  LDD  ST_UY
L765B:  ADDD #$FF80                 ;SIDEWAYS
L765E:  STD  ST_UY
L7661:  RTS

;------------------------------------------------------------------------------
; SMVSCR - STAR MOVEMENT DURING SCORING SCREEN PHASE
;------------------------------------------------------------------------------
SMVSCR:
L7662:  LDD  ST_UZ
L7665:  ADDD #$0080                 ;UP
L7668:  STD  ST_UZ
L766B:  RTS

;------------------------------------------------------------------------------
; SMVHIS - star movement of the high score table phase, called by PHEHIS: ST_UX $80 further, forward. the same
;   instructions as Star Wars' SMVHIS, which the matcher missed
;------------------------------------------------------------------------------
SMVHIS:
L766C:  LDD  >ST_UX
L766F:  ADDD #$0080                 ;FORWARD
L7672:  STD  >ST_UX
L7675:  RTS

;------------------------------------------------------------------------------
; twirl_tie_wave - MOVE THE PLAYER
;   ROLL IF HIT
;   (also: S1TW)
;   in ESB: the twirl of the TIE fighter part (phase $26): Star Wars' STWSP1 with 8 tics of roll added every
;   frame through s1_roll_add
;------------------------------------------------------------------------------
twirl_tie_wave:
S1TW:
STWSP1:
L7676:  LDA  S_ROL
L7678:  BEQ  L7694                  ;IFNE  ?ANY ROLLING TO DO?
L767A:  BLE  L7683                  ;IFGT  ?POSITIVE?
L767C:  DEC  S_ROL
L767E:  LDD  #$04FF
L7681:  BRA  L7688                  ;ELSE  ELSE NEGATIVE
L7683:  INC  S_ROL
L7685:  LDD  #$FB01
L7688:  STD  M_SIN
L768B:  LDD  #$3FCE                 ;4.48 DEGREES
L768E:  STD  M_COS
L7691:  JSR  S1RL
L7694:  JSR  AIM                    ;AIM AT ALIEN OR DETH STAR
L7697:  JSR  S1RHPT
L769A:  JSR  S1RHYW
L769D:  LDA  #$08                   ;and 8 tics of roll every frame
L769F:  JSR  s1_roll_add
L76A2:  RTS

;------------------------------------------------------------------------------
; twirl_to_far - FOR THE LAST OF A GROUP OF THREE ALIENS
;   ROLL IF HIT
;   in ESB: the twirl of phase $28, while the TIE fighters run away: AIMDTH aims at the far object, the
;   Executor
;------------------------------------------------------------------------------
twirl_to_far:
STWSP2:
L76A3:  LDA  S_ROL
L76A5:  BEQ  L76C1                  ;IFNE  ?ANY ROLLING TO DO?
L76A7:  BLE  L76B0                  ;IFGT  ?POSITIVE?
L76A9:  DEC  S_ROL
L76AB:  LDD  #$04FF
L76AE:  BRA  L76B5                  ;ELSE  ELSE NEGATIVE
L76B0:  INC  S_ROL
L76B2:  LDD  #$FB01
L76B5:  STD  M_SIN
L76B8:  LDD  #$3FCE                 ;4.48 DEGREES
L76BB:  STD  M_COS
L76BE:  JSR  S1RL
L76C1:  JSR  AIMDTH
L76C4:  JSR  S1RHPT
L76C7:  JSR  S1RHYW
L76CA:  RTS

;------------------------------------------------------------------------------
; turn_to_far - twirl of phase $2A: AIMDTH aims at the far object, then pitch and yaw from the yoke. L76A3
;   without the roll after a hit
;------------------------------------------------------------------------------
turn_to_far:
L76CB:  JSR  AIMDTH
L76CE:  JSR  S1RHPT
L76D1:  JSR  S1RHYW
L76D4:  RTS

;------------------------------------------------------------------------------
; S1TWGD - TWIRL THE GROUND FLYER
;   in ESB: the routine ends once the limited step is in GD_ACT. the roll is not put into the ship's own
;   vectors any more: bank_roll_u1 rolls the view by GD_ACT, and gd_unroll enters at L7728 to take the roll
;   back
;------------------------------------------------------------------------------
S1TWGD:
L76D5:  LDA  S_ROL
L76D7:  BEQ  L76E1                  ;IFNE  ?TIME TO ROLL PLAYER?
L76D9:  BLE  L76DE                  ;IFGT
L76DB:  DECA                        ;GO TOWARDS ZERO
L76DC:  BRA  L76DF                  ;ELSE
L76DE:  INCA                        ;GO TOWARDS ZERO
L76DF:  STA  S_ROL
L76E1:  LDA  S_ROL
L76E3:  BPL  L76E6                  ;IFMI
L76E5:  NEGA                        ;ABS FOR MULTIPLIER
L76E6:  LDB  #$20                   ;15 PER DEGREE PER COUNT
L76E8:  MUL
L76E9:  TST  S_ROL
L76EB:  BPL  L76F1                  ;IFMI
L76ED:  COMA                        ;NEGD  RESTORE SIGN
L76EE:  NEGB
L76EF:  SBCA #$FF
L76F1:  STD  >GD_ROL
L76F4:  LDA  >SI_RSX
L76F7:  BPL  L76FA                  ;IFMI
L76F9:  COMA
L76FA:  LDB  #$05                   ;MAX COUNT OF 5*128=45 DEGREES(78 PER 5 DEGREES)
;USE 4 MAX SO DOUBLE SHIFT GET 8 BITS
L76FC:  MUL
L76FD:  TST  >SI_RSX
L7700:  BPL  L7706                  ;IFMI
L7702:  COMA                        ;NEGD  RESTORE SIGN
L7703:  NEGB
L7704:  SBCA #$FF
L7706:  ADDD >GD_ROL
L7709:  TST  S_ROL
L770B:  BNE  L7728                  ;IFEQ  ?NO FANCY COLLISION ROLL?THEN GO SLOW
L770D:  SUBD >GD_ACT
L7710:  BLE  L771D                  ;IFGT  ?ROLL PLUS?
L7712:  CMPD #$0010                 ;LIMIT PLUS ROLL
L7716:  BLE  L771B                  ;IFGT
L7718:  LDD  #$0010                 ;127.(BYTE MAX)-77.(RESIDU MOST)=50.(MAX INCREASE ALLOWED)
L771B:  BRA  L7726                  ;ELSE
L771D:  CMPD #$FFF0                 ;LIMIT MINUS ROLL
L7721:  BGE  L7726                  ;IFLT
L7723:  LDD  #$FFF0
L7726:  BRA  L7741                  ;ELSE  ELSE IS FANCY ROLL
L7728:  SUBD >GD_ACT
L772B:  BLE  L7738                  ;IFGT  ?ROLL PLUS?
L772D:  CMPD #$0032                 ;LIMIT PLUS ROLL
L7731:  BLE  L7736                  ;IFGT
L7733:  LDD  #$0032                 ;127.(BYTE MAX)-77.(RESIDU MOST)=50.(MAX INCREASE ALLOWED)
L7736:  BRA  L7741                  ;ELSE
L7738:  CMPD #$FFCE                 ;LIMIT MINUS ROLL
L773C:  BGE  L7741                  ;IFLT
L773E:  LDD  #$FFCE
L7741:  STD  >GD_ROL                ;the step taken (Star Wars adds it to the roll residue here, L7750 holds that code)
L7744:  ADDD >GD_ACT
L7747:  STD  >GD_ACT
L774A:  RTS

;------------------------------------------------------------------------------
; gd_unroll - takes the ground flyer's roll back towards level: enters S1TWGD at L7728 with a wanted roll of 0,
;   so GD_ACT moves towards 0 by at most $32 a frame. called by L778C and L7796
;------------------------------------------------------------------------------
gd_unroll:
L774B:  LDD  #$0000                 ;wanted roll 0, fast limit
L774E:  BRA  L7728

;------------------------------------------------------------------------------
; gd_roll_apply - no caller found, dead code: adds the low byte of GD_ROL to the roll residue, runs the residue
;   routine L7BB1 on the roll block and rolls the ship (S1RL) when it asks. this is the end of Star Wars' S1TWGD,
;   which ESB's S1TWGD no longer runs into
;------------------------------------------------------------------------------
gd_roll_apply:
L7750:  LDD  >GD_ROL
L7753:  ADDB rheor_rsd              ;roll residue
L7755:  STB  rheor_rsd
L7757:  LDX  #RHEOR                 ;the roll block (Star Wars' RHEOR)
L775A:  JSR  RHRSDU
L775D:  BEQ  L7762
L775F:  JSR  S1RL
L7762:  RTS

;------------------------------------------------------------------------------
; twirl_ground - twirls the player in the probot and walker waves: S1TWGD for the roll, then yaw from the yoke:
;   the X deflection SI_RSX doubled, squared, its high byte times $46, with the sign turned, is added to the yaw
;   residue and S1YW turns the ship when L7BB1 asks
;------------------------------------------------------------------------------
twirl_ground:
L7763:  JSR  S1TWGD
L7766:  LDA  >SI_RSX
L7769:  BPL  L776C
L776B:  COMA
L776C:  ASLA                        ;2 * |x|
L776D:  TFR  A,B                    ;squared
L776F:  MUL
L7770:  LDB  #$46                   ;high byte times $46
L7772:  MUL
L7773:  TST  >SI_RSX
L7776:  BMI  L777C                  ;x plus: turn the other way
L7778:  COMA
L7779:  NEGB
L777A:  SBCA #$FF
L777C:  ADDA rheoy_rsd              ;into the yaw residue
L777E:  STA  rheoy_rsd
L7780:  LDX  #RHEOY
L7783:  JSR  RHRSDU
L7786:  BEQ  L778B
L7788:  JSR  S1YW
L778B:  RTS

;------------------------------------------------------------------------------
; twirl_turn_back - twirl of phase $1E, after the probot wave: unrolls (L774B), sets the yaw rate from the
;   player's unit vector A (L784D) and yaws by it (S1RHYW), which brings the craft round to the heading the phase
;   waits for
;------------------------------------------------------------------------------
twirl_turn_back:
L778C:  JSR  gd_unroll
L778F:  JSR  aim_home_yaw
L7792:  JSR  S1RHYW
L7795:  RTS

;------------------------------------------------------------------------------
; twirl_unroll - twirl of phase $24, after the walker wave: only takes the roll back to level (L774B)
;------------------------------------------------------------------------------
twirl_unroll:
L7796:  JSR  gd_unroll
L7799:  RTS

;------------------------------------------------------------------------------
; twirl_asteroid - twirls the player in the asteroid part (phase $2C): Star Wars' STWSP1 once more - the roll
;   after a hit while S_ROL counts back to zero, AIM, pitch and yaw from the yoke - with 12 tics of roll the other
;   way added every frame through s1_roll_add
;------------------------------------------------------------------------------
twirl_asteroid:
L779A:  LDA  S_ROL
L779C:  BEQ  L77B8                  ;IFNE  ?ANY ROLLING TO DO?
L779E:  BLE  L77A7                  ;IFGT  ?POSITIVE?
L77A0:  DEC  S_ROL
L77A2:  LDD  #$04FF
L77A5:  BRA  L77AC                  ;ELSE  ELSE NEGATIVE
L77A7:  INC  S_ROL
L77A9:  LDD  #$FB01
L77AC:  STD  M_SIN
L77AF:  LDD  #$3FCE                 ;4.48 DEGREES
L77B2:  STD  M_COS
L77B5:  JSR  S1RL
L77B8:  JSR  AIM                    ;AIM AT ALIEN OR DETH STAR
L77BB:  JSR  S1RHPT
L77BE:  JSR  S1RHYW
L77C1:  LDA  #$F4                   ;and 12 tics of roll the other way every frame
L77C3:  JSR  s1_roll_add
L77C6:  RTS

;------------------------------------------------------------------------------
; gd_act_by_stick - no caller found, dead code: the yoke's X deflection doubled, times 16, the high byte
;   squared, with the sign of the deflection, is added to GD_ACT, and GD_ACT is brought back by $1555 when it
;   passes $0E38 either way. ends in the RTS of S1TWBS
;------------------------------------------------------------------------------
gd_act_by_stick:
L77C7:  LDA  >SI_RSX
L77CA:  BPL  L77CD
L77CC:  COMA
L77CD:  ASLA
L77CE:  LDB  #$10
L77D0:  MUL
L77D1:  TFR  A,B
L77D3:  MUL
L77D4:  NOP
L77D5:  NOP
L77D6:  NOP
L77D7:  TST  >SI_RSX
L77DA:  BPL  L77E0                  ;IFMI
L77DC:  COMA                        ;NEGD  RESTORE SIGN
L77DD:  NEGB
L77DE:  SBCA #$FF
L77E0:  ADDD >GD_ACT
L77E3:  STD  >GD_ACT
L77E6:  LDD  >GD_ACT
L77E9:  CMPD #$0E38
L77ED:  BLE  L77F7
L77EF:  SUBD #$1555                 ;past $0E38: back by $1555
L77F2:  STD  >GD_ACT
L77F5:  BRA  S1TWBS
L77F7:  CMPD #$F1C8
L77FB:  BGE  S1TWBS
L77FD:  ADDD #$1555
L7800:  STD  >GD_ACT

;------------------------------------------------------------------------------
; S1TWBS - TWIRL IN BASE TRENCH
;------------------------------------------------------------------------------
S1TWBS:
L7803:  RTS

;------------------------------------------------------------------------------
; AIM - AIM AT ALIEN OR DEATH STAR
;------------------------------------------------------------------------------
AIM:
L7804:  LDX  AM_PTR
L7807:  BNE  L780C                  ;IFEQ  CYCLE THRU STARTING AT CURRENT POSITION
L7809:  LDX  #ALIEN
L780C:  LDA  AS_TYP,X
L780E:  CMPA #$01
L7810:  BNE  L781B                  ;IFEQ  ?FOUND OUR FIRST LIVE ALIEN?
L7812:  LDA  7,X
L7814:  BNE  L781B
L7816:  STX  S2_PRM
L7818:  JMP  AIMA
L781B:  LEAX AS_IZE,X               ;GET NEW ALIEN TO AIM AT
L781E:  CMPX #ALIENZ
L7821:  BLO  L780C                  ;HSEND  LOOP TILL DONE

;------------------------------------------------------------------------------
; AIMDTH - ---WHEN NO ALIENS TO LOOK AT, USE DETH STAR
;   in ESB: the far object is the Executor, which VWDTHB draws straight ahead along +x
;------------------------------------------------------------------------------
AIMDTH:
L7823:  LDD  #$0000
L7826:  STD  AM_PTR                 ;NO CURRENT POINTER TO ALIEN BEING TRACKED
L7829:  LDA  (MS_AX+M_S1)&$FFFF
L782C:  BMI  L7833                  ;IFPL  ?DETH STAR IN FRONT?
L782E:  LDB  (MS_AZ+M_S1)&$FFFF     ;THEN SLEW NORMALLY(USE HITE OF DETHSTAR)
L7831:  BRA  L7838                  ;ELSE  ELSE DETH STAR IN BACK
L7833:  LDB  #$7F                   ;STRAIGHT IN BACK GIVES LARGE VALUE
L7835:  SUBB (MS_AZ+M_S1)&$FFFF
L7838:  STB  rheop_rate             ;pitch rate of turn, RHS_RAT of RHEOP
L783A:  LDA  (MS_AX+M_S1)&$FFFF
L783D:  BMI  L7844                  ;IFPL  ?DETH STAR IN FRONT?
L783F:  LDB  (MS_AY+M_S1)&$FFFF     ;THEN SLEW NORMALLY(USE WIDTH OF DETHSTAR)
L7842:  BRA  L7849                  ;ELSE  ELSE DETH STAR IN BACK
L7844:  LDB  #$7F                   ;STRAIGHT IN BACK GIVES LARGE VALUE
L7846:  SUBB (MS_AY+M_S1)&$FFFF
L7849:  COMB
L784A:  STB  rheoy_rate             ;yaw rate of turn, RHS_RAT of RHEOY
L784C:  RTS

;------------------------------------------------------------------------------
; aim_home_yaw - sets the yaw rate of turn (RHS_RAT of RHEOY) so that the ship turns back to head along -x, the
;   heading every wave starts with. It is the yaw half of AIMDTH with the front/back test on minus the ship's A,X
;   and without the COMB (a NOP is in its place). Called by L778C while the probot wave ends, followed by S1RHYW
;------------------------------------------------------------------------------
aim_home_yaw:
L784D:  LDA  s1_ax                  ;ship's unit vector A,X: minus when the ship heads towards -x
L7850:  NEGA
L7851:  BMI  L7858                  ;IFPL  ?DETH STAR IN FRONT?
L7853:  LDB  (MS_AY+M_S1)&$FFFF     ;THEN SLEW NORMALLY(USE WIDTH OF DETHSTAR)
L7856:  BRA  L785D                  ;ELSE  ELSE DETH STAR IN BACK
L7858:  LDB  #$7F                   ;STRAIGHT IN BACK GIVES LARGE VALUE
L785A:  SUBB (MS_AY+M_S1)&$FFFF
L785D:  NOP                         ;AIMDTH has COMB here: the yaw goes the other way
L785E:  STB  rheoy_rate             ;yaw rate of turn
L7860:  RTS

;------------------------------------------------------------------------------
; AIMA - AIM AT ALIEN
;------------------------------------------------------------------------------
AIMA:
L7861:  LDA  #MS_S1BC
L7863:  JSR  IS1UV                  ;DOWNLOAD LATEST UNIT VECTOR
L7866:  JSR  RESIDU
L7869:  LDX  S2_PRM                 ;GET THE ALIEN TO AIM AT
L786B:  STX  AM_PTR                 ;SAVE OUR CURRENT ALIEN
L786E:  CLRA
L786F:  LDB  AS_BIC,X
L7871:  ADDB #$03
L7873:  STD  M_BIC
L7876:  LDA  #MS_PSB2
L7878:  JSR  MGOWT                  ;GET ALIENS LATEST LOC VIA PLAYER
L787B:  LDA  M_XP
L787E:  BLE  L78A3                  ;IFGT  ?ALIEN IN FRONT?
L7880:  LDD  M_YP                   ;THEN SCALE USING X
L7883:  LSL  M_XP+1
L7886:  ROL  M_XP
L7889:  BVS  AIMA_26                ;B WHEN X OVERFLOWS
L788B:  LSLB                        ;LSLD  NOW DO Y
L788C:  ROLA
L788D:  BVC  L7893                  ;IFVS  ?Y AT MAX SCALE?
L788F:  RORA                        ;RORD  THEN RESTORE SIGN
L7890:  RORB
L7891:  BRA  AIMA_26                ;J AND SKIP OUT
L7893:  LSL  M_ZP+1
L7896:  ROL  M_ZP
L7899:  BVC  L7883                  ;VSEND
L789B:  ROR  M_ZP                   ;RESTORE CORRECT SIGN
L789E:  ROR  M_ZP+1
L78A1:  BRA  AIMA_26                ;ELSE  ELSE ALIEN IS BEHIND -- USE LARGEST SCALE
L78A3:  LDD  M_YP                   ;PREPARE DREG FOR SPEED
L78A6:  ORB  #$01                   ;FORCE END TO LOOP
L78A8:  LSLB                        ;LSLD  NOW DO Y
L78A9:  ROLA
L78AA:  BVC  L78B0                  ;IFVS  ?Y AT MAX SCALE?
L78AC:  RORA                        ;RORD  THEN RESTORE SIGN
L78AD:  RORB
L78AE:  BRA  AIMA_26                ;J AND SKIP OUT
L78B0:  LSL  M_ZP+1
L78B3:  ROL  M_ZP
L78B6:  BVC  L78A8                  ;VSEND
L78B8:  ROR  M_ZP                   ;RESTORE CORRECT SIGN
L78BB:  ROR  M_ZP+1

AIMA_26:
L78BE:  COMA                        ;DREG := SHIFTED Y
L78BF:  STA  rheoy_rate             ;yaw rate of turn
L78C1:  LDB  M_ZP
L78C4:  STB  rheop_rate             ;pitch rate of turn
L78C6:  RTS

;------------------------------------------------------------------------------
; S1MV - the Star Wars routine SMVSP1/S1MV, instruction for instruction (the matcher missed it): star field
;   viewer x = frame counter shifted left 7, so the stars stream past. It is the whole player movement of the TIE
;   fighter wave, called after RESIDU
;------------------------------------------------------------------------------
S1MV:
L78C7:  LDD  FRAME
L78C9:  JSR  LSLD7
L78CC:  STD  >ST_UX                 ;stars relative movement
L78CF:  RTS

;------------------------------------------------------------------------------
; S1MVBS - WORMHOLE PLAYER MOVEMENT
;   in ESB: the player movement of the asteroid part: forward at MS_VX, sideways and up or down by the sight's
;   x and y, and the star field viewer position moves with the ship
;------------------------------------------------------------------------------
S1MVBS:
L78D0:  LDD  (MS_VX+M_S1)&$FFFF     ;PLAYERS FORWARD MOVEMENT
L78D3:  ADDD MS_TX+M_S1
L78D6:  STD  MS_TX+M_S1
L78D9:  STD  MS_TX+M_U1
L78DC:  LDD  >SI_RSY                ;FASTEST IS AT 45 DEGREES
L78DF:  JSR  ASRD7
L78E2:  STD  M_XP
L78E5:  LDD  M_BZ1                  ;download block B,Z: the ship's up axis, y part
L78E8:  STD  M_YP
L78EB:  LDD  M_CZ1
L78EE:  STD  M_ZP                   ;GET X FOR PROPER SCREEN CONVERSION
L78F1:  LDA  #MS_PERS
L78F3:  JSR  MGOWT
L78F6:  LDD  M_YP
L78F9:  STD  s1_vy                  ;FOR SAVETY
L78FC:  LDD  M_ZP
L78FF:  STD  s1_vz                  ;Y,Z CONVERTED TO SCREEN COORDS
L7902:  NOP
L7903:  LDD  >SI_RSX
L7906:  JSR  ASRD7
L7909:  STD  M_XP
L790C:  LDD  M_BY1                  ;download block B,Y: the ship's side axis, y part
L790F:  STD  M_YP
L7912:  LDD  M_CY1                  ;download block C,Y: the ship's side axis, z part
L7915:  STD  M_ZP
L7918:  LDA  #MS_PERS
L791A:  JSR  MGOWT                  ;DO THE MULTIPLYS
L791D:  LDD  M_YP                   ;NOW TEST UNROTATED VIDEO LOC
L7920:  ADDD s1_vy                  ;MISNAMED, IS RADIUS OF COLLISION
L7923:  STD  s1_vy
L7926:  LDD  M_ZP
L7929:  ADDD s1_vz
L792C:  STD  s1_vz
L792F:  LDD  s1_vy
L7932:  ADDD s1_ty                  ;y speed into the universe y position
L7935:  STD  s1_ty
L7938:  STD  M_YT1
L793B:  LDD  s1_vz                  ;z speed into the universe z position
L793E:  ADDD s1_tz
L7941:  STD  s1_tz
L7944:  STD  M_ZT1
L7947:  LDD  s1_vx                  ;the star field viewer position moves by the same three speeds
L794A:  ADDD >ST_UX
L794D:  STD  >ST_UX
L7950:  LDD  s1_vy
L7953:  ADDD ST_UY
L7956:  STD  ST_UY
L7959:  LDD  s1_vz
L795C:  ADDD ST_UZ
L795F:  STD  ST_UZ
L7962:  RTS

;------------------------------------------------------------------------------
; smv_probot - player movement of the probot wave (wave 1). Sets the x and y speed from the ship's forward axis
;   (unit vector A,X and B,X, each / 32), adds a side slip along the ship's side axis (A,Y and B,Y) in proportion
;   to the sight's x deflection, then falls into L79C9 to move the ship. SMVG0B is the same code for the walker
;   wave
;------------------------------------------------------------------------------
smv_probot:
L7963:  LDD  s1_ax                  ;forward axis x (unit vector A,X)
L7966:  JSR  ASRD5_B0
L7969:  STD  s1_vx                  ;x speed = forward x / 32
L796C:  LDD  s1_bx                  ;forward axis y (unit vector B,X)
L796F:  JSR  ASRD5_B0
L7972:  STD  s1_vy                  ;y speed = forward y / 32
L7975:  LDA  s1_ay                  ;side axis x (unit vector A,Y), high byte
L7978:  BPL  L797B
L797A:  NEGA
L797B:  ASLA
L797C:  LDB  >SI_RSX
L797F:  BPL  L7982
L7981:  COMB
L7982:  ASLB
L7983:  MUL                         ;times the sight's x deflection
L7984:  TST  >SI_RSX
L7987:  BGE  L798D
L7989:  COMA
L798A:  NEGB
L798B:  SBCA #$FF
L798D:  TST  s1_ay
L7990:  BGE  L7996
L7992:  COMA
L7993:  NEGB
L7994:  SBCA #$FF
L7996:  JSR  ASRD6
L7999:  ADDD s1_vx                  ;side slip into the x speed
L799C:  STD  s1_vx
L799F:  LDA  s1_by                  ;side axis y (unit vector B,Y), high byte
L79A2:  BPL  L79A5
L79A4:  NEGA
L79A5:  ASLA
L79A6:  LDB  >SI_RSX
L79A9:  BPL  L79AC
L79AB:  COMB
L79AC:  ASLB
L79AD:  MUL
L79AE:  TST  >SI_RSX
L79B1:  BGE  L79B7
L79B3:  COMA
L79B4:  NEGB
L79B5:  SBCA #$FF
L79B7:  TST  s1_by
L79BA:  BGE  L79C0
L79BC:  COMA
L79BD:  NEGB
L79BE:  SBCA #$FF
L79C0:  JSR  ASRD6
L79C3:  ADDD s1_vy                  ;side slip into the y speed
L79C6:  STD  s1_vy

;------------------------------------------------------------------------------
; smv_probot_adv - moves the ship by its x and y speed (both the ship block and the download block), then sets
;   the z speed from the sight's y deflection times the horizontal speed (|x speed| + |y speed|) and moves the
;   height, kept between $0200 and $0C00. Changed from Star Wars S1MVGD. Entered by falling through from L7963
;------------------------------------------------------------------------------
smv_probot_adv:
L79C9:  LDD  (MS_VX+M_S1)&$FFFF     ;PLAYERS FORWARD MOVEMENT
L79CC:  ADDD MS_TX+M_S1
L79CF:  STD  MS_TX+M_S1
L79D2:  STD  MS_TX+M_U1
L79D5:  LDD  s1_vy                  ;y speed into the universe y position
L79D8:  ADDD s1_ty
L79DB:  STD  s1_ty
L79DE:  STD  M_YT1
L79E1:  LDD  s1_vx                  ;horizontal speed: |x speed| + |y speed|
L79E4:  BPL  L79EA                  ;IFMI
L79E6:  COMA                        ;NEGD
L79E7:  NEGB
L79E8:  SBCA #$FF
L79EA:  TST  s1_vy
L79ED:  BPL  L79F4
L79EF:  SUBD s1_vy
L79F2:  BRA  L79F7
L79F4:  ADDD s1_vy
L79F7:  JSR  LSLD4
L79FA:  LDB  >SI_RSY
L79FD:  BPL  L7A00                  ;IFMI
L79FF:  COMB                        ;HANDLE 80 CORRECTLY,ABSB
L7A00:  NOP                         ;SLOWER RANGE
L7A01:  MUL                         ;times the sight's y deflection
L7A02:  TST  >SI_RSY
L7A05:  BPL  L7A0B                  ;IFMI
L7A07:  COMA                        ;NEGD
L7A08:  NEGB
L7A09:  SBCA #$FF
L7A0B:  JSR  ASRD4_B0
L7A0E:  STD  MS_VZ+M_S1             ;z speed
L7A11:  ADDD MS_TZ+M_S1
L7A14:  CMPD #$0C00                 ;USE BELOW IN GD$MDT
L7A18:  BLE  L7A1F                  ;IFGT
L7A1A:  LDD  #$0C00
L7A1D:  BRA  L7A28                  ;ELSE
L7A1F:  CMPD #$0200                 ;USE BELOW IN GD$MDT
L7A23:  BGE  L7A28                  ;IFLT
L7A25:  LDD  #$0200
L7A28:  STD  MS_TZ+M_S1
L7A2B:  STD  MS_TZ+M_U1
L7A2E:  RTS

;------------------------------------------------------------------------------
; SMVG0B - GROUND TO BASE TRENCH TRANSITION
;   in ESB: the player movement of the walker part, the same code as smv_probot: x and y speed from the ship's
;   forward axis / 32 plus a side slip by the sight's x, then smv_walker_adv
;------------------------------------------------------------------------------
SMVG0B:
L7A2F:  LDD  s1_ax
L7A32:  JSR  ASRD5_B0
L7A35:  STD  s1_vx                  ;x speed = forward x / 32

;------------------------------------------------------------------------------
; SMVG9B - REST OF G*B TRANSITION
;   in ESB: the y speed and side slip of the walker part's movement, the second half of SMVG0B
;------------------------------------------------------------------------------
SMVG9B:
L7A38:  LDD  s1_bx
L7A3B:  JSR  ASRD5_B0
L7A3E:  STD  s1_vy
L7A41:  LDA  s1_ay
L7A44:  BPL  L7A47
L7A46:  NEGA
L7A47:  ASLA
L7A48:  LDB  >SI_RSX
L7A4B:  BPL  L7A4E
L7A4D:  COMB
L7A4E:  ASLB
L7A4F:  MUL
L7A50:  TST  >SI_RSX
L7A53:  BGE  L7A59
L7A55:  COMA
L7A56:  NEGB
L7A57:  SBCA #$FF
L7A59:  TST  s1_ay
L7A5C:  BGE  L7A62
L7A5E:  COMA
L7A5F:  NEGB
L7A60:  SBCA #$FF
L7A62:  JSR  ASRD6
L7A65:  ADDD (MS_VX+M_S1)&$FFFF
L7A68:  STD  (MS_VX+M_S1)&$FFFF
L7A6B:  LDA  s1_by                  ;side axis y (unit vector B,Y), high byte
L7A6E:  BPL  L7A71
L7A70:  NEGA
L7A71:  ASLA
L7A72:  LDB  >SI_RSX
L7A75:  BPL  L7A78
L7A77:  COMB
L7A78:  ASLB
L7A79:  MUL
L7A7A:  TST  >SI_RSX
L7A7D:  BGE  L7A83
L7A7F:  COMA
L7A80:  NEGB
L7A81:  SBCA #$FF
L7A83:  TST  s1_by
L7A86:  BGE  L7A8C
L7A88:  COMA
L7A89:  NEGB
L7A8A:  SBCA #$FF
L7A8C:  JSR  ASRD6
L7A8F:  ADDD s1_vy
L7A92:  STD  s1_vy

;------------------------------------------------------------------------------
; smv_walker_adv - the same as L79C9 for the walker wave, entered by falling through from SMVG9B: moves the ship
;   in x and y, sets the z speed from the sight's y deflection and the horizontal speed, and keeps the height
;   between $0200 and $1C00
;------------------------------------------------------------------------------
smv_walker_adv:
L7A95:  LDD  (MS_VX+M_S1)&$FFFF     ;PLAYERS FORWARD MOVEMENT
L7A98:  ADDD MS_TX+M_S1
L7A9B:  STD  MS_TX+M_S1
L7A9E:  STD  MS_TX+M_U1
L7AA1:  LDD  s1_vy                  ;y speed into the universe y position
L7AA4:  ADDD s1_ty
L7AA7:  STD  s1_ty
L7AAA:  STD  M_YT1
L7AAD:  LDD  s1_vx                  ;horizontal speed: |x speed| + |y speed|
L7AB0:  BPL  L7AB6                  ;IFMI
L7AB2:  COMA                        ;NEGD
L7AB3:  NEGB
L7AB4:  SBCA #$FF
L7AB6:  TST  s1_vy
L7AB9:  BPL  L7AC0
L7ABB:  SUBD s1_vy
L7ABE:  BRA  L7AC3
L7AC0:  ADDD s1_vy
L7AC3:  JSR  LSLD4
L7AC6:  LDB  >SI_RSY
L7AC9:  BPL  L7ACC                  ;IFMI
L7ACB:  COMB                        ;HANDLE 80 CORRECTLY,ABSB
L7ACC:  NOP                         ;SLOWER RANGE
L7ACD:  MUL
L7ACE:  TST  >SI_RSY
L7AD1:  BPL  L7AD7                  ;IFMI
L7AD3:  COMA                        ;NEGD
L7AD4:  NEGB
L7AD5:  SBCA #$FF
L7AD7:  JSR  ASRD4_B0
L7ADA:  STD  MS_VZ+M_S1             ;z speed
L7ADD:  ADDD MS_TZ+M_S1
L7AE0:  CMPD #$1C00                 ;USE BELOW IN GD$MDT
L7AE4:  BLE  L7AEB                  ;IFGT
L7AE6:  LDD  #$1C00
L7AE9:  BRA  L7AF4                  ;ELSE
L7AEB:  CMPD #$0200                 ;USE BELOW IN GD$MDT
L7AEF:  BGE  L7AF4                  ;IFLT
L7AF1:  LDD  #$0200
L7AF4:  STD  MS_TZ+M_S1
L7AF7:  STD  MS_TZ+M_U1
L7AFA:  RTS

;------------------------------------------------------------------------------
; smv_descend - player movement while the walker wave ends (phase $24): x and y speed straight from the ship's
;   forward axis / 32 with no steering from the sight, then L7B0D moves the ship and brings it down
;------------------------------------------------------------------------------
smv_descend:
L7AFB:  LDD  s1_ax
L7AFE:  JSR  ASRD5_B0
L7B01:  STD  s1_vx                  ;x speed = forward x / 32

;------------------------------------------------------------------------------
; smv_descend_vy - part of L7AFB, reached by falling through: y speed = forward axis y (unit vector B,X) / 32
;------------------------------------------------------------------------------
smv_descend_vy:
L7B04:  LDD  s1_bx
L7B07:  JSR  ASRD5_B0
L7B0A:  STD  s1_vy

;------------------------------------------------------------------------------
; smv_descend_adv - part of L7AFB, reached by falling through: moves the ship by its x and y speed (ship block
;   and download block), sets the z speed to -$0400 and lowers the height by it each frame down to the floor of
;   $0200
;------------------------------------------------------------------------------
smv_descend_adv:
L7B0D:  LDD  (MS_VX+M_S1)&$FFFF     ;PLAYERS FORWARD MOVEMENT
L7B10:  ADDD MS_TX+M_S1
L7B13:  STD  MS_TX+M_S1
L7B16:  STD  MS_TX+M_U1
L7B19:  LDD  s1_vy                  ;y speed into the universe y position
L7B1C:  ADDD s1_ty
L7B1F:  STD  s1_ty
L7B22:  STD  M_YT1
L7B25:  LDD  #$FC00                 ;z speed: down $0400 a frame
L7B28:  STD  s1_vz
L7B2B:  ADDD s1_tz
L7B2E:  CMPD #$0200                 ;USE BELOW IN GD$MDT  floor of the descent
L7B32:  BGE  L7B37                  ;IFLT
L7B34:  LDD  #$0200
L7B37:  STD  MS_TZ+M_S1
L7B3A:  STD  MS_TZ+M_U1
L7B3D:  RTS

;------------------------------------------------------------------------------
; S1RHPT - Star Wars' S1RHPT, ship 1 rheostat pitch: RHTRIG and RHRSDU on the pitch block RHEOP, and S1PT
;   pitches the ship when a magic step is due
;------------------------------------------------------------------------------
S1RHPT:
L7B3E:  LDX  #RHEOP
L7B41:  JSR  RHTRIG
L7B44:  JSR  RHRSDU
L7B47:  BEQ  L7B4C
L7B49:  JSR  S1PT
L7B4C:  RTS

;------------------------------------------------------------------------------
; S1RHYW - Star Wars' S1RHYW, ship 1 rheostat yaw: RHTRIG and RHRSDU on the yaw block RHEOY, and S1YW yaws the
;   ship when a magic step is due
;------------------------------------------------------------------------------
S1RHYW:
L7B4D:  LDX  #RHEOY
L7B50:  JSR  RHTRIG
L7B53:  JSR  RHRSDU
L7B56:  BEQ  L7B5B
L7B58:  JSR  S1YW
L7B5B:  RTS

;------------------------------------------------------------------------------
; s1_roll_add - adds A (signed tics) to the roll residue and lets RHRSDU take whole magic steps out of it,
;   rolling the ship (S1RL) when it gives one. Called every frame with A = 8 in the TIE fighter wave and A = -12
;   in the asteroid wave, which keeps the ship rolling slowly
;------------------------------------------------------------------------------
s1_roll_add:
L7B5C:  LDX  #RHEOR                 ;roll block: only its residue byte, $4877, is used
L7B5F:  ADDA <8,X                   ;A more tics to roll
L7B62:  STA  <8,X
L7B65:  JSR  RHRSDU
L7B68:  BEQ  L7B6D
L7B6A:  JSR  S1RL
L7B6D:  RTS

;------------------------------------------------------------------------------
; VGTOSITE - Star Wars' VGTOSITE, which the matcher missed: with interrupts off it copies the IRQ's rheostat
;   values VG_RSY, VG_RSX, VG_CY and VG_CX into the sight values SI_RSY, SI_RSX, SI_CY and SI_CX that the mainline
;   uses
;------------------------------------------------------------------------------
VGTOSITE:
L7B6E:  ORCC #$10
L7B70:  LDD  >VG_RSY
L7B73:  STD  >SI_RSY
L7B76:  LDD  >VG_RSX
L7B79:  STD  >SI_RSX
L7B7C:  LDD  >VG_CY
L7B7F:  STD  >SI_CY
L7B82:  LDD  >VG_CX
L7B85:  STD  >SI_CX
L7B88:  ANDCC #$EF
L7B8A:  RTS

;------------------------------------------------------------------------------
; RHTRIG - the Star Wars routine RHTRIG (the matcher missed it because ESB assembles the block offsets as
;   8-bit): X points to a rheostat block. Half the size of its rate of turn RHS_RAT is added, with the rate's
;   sign, to its tic residue RHS_RSD, held at $7F or $81 on overflow
;------------------------------------------------------------------------------
RHTRIG:
L7B8B:  LDA  <7,X
L7B8E:  BPL  RHTRIG_20
L7B90:  COMA                        ;WIDER BALANCED ZERO, ALLOW -80

RHTRIG_20:
L7B91:  LDB  #$80                   ;FROM +-128. TO ?
L7B93:  MUL
L7B94:  NOP
L7B95:  NOP
L7B96:  NOP
L7B97:  LDB  <7,X
L7B9A:  BMI  L7BA5
L7B9C:  ADDA <8,X
L7B9F:  BVC  L7BA3                  ;IFVS
L7BA1:  LDA  #$7F
L7BA3:  BRA  L7BAD                  ;ELSE  GO IN NEGATIVE DIRECTION
L7BA5:  NEGA
L7BA6:  ADDA <8,X
L7BA9:  BVC  L7BAD
L7BAB:  LDA  #$81
L7BAD:  STA  <8,X
L7BB0:  RTS

;------------------------------------------------------------------------------
; RHRSDU - the Star Wars routine RHRSDU (missed for the same 8-bit offsets): X points to a rheostat block. If
;   the size of its residue is at least 78 tics it takes 78 off and sets M_SIN/M_COS for the 4.99 degree magic
;   angle, else if at least 14 it takes 14 off and sets them for the .895 degree angle, with the sine signed like
;   the residue. Returns Z clear when the caller has to rotate, Z set when there is nothing to do
;------------------------------------------------------------------------------
RHRSDU:
L7BB1:  LDA  <8,X
L7BB4:  BPL  RHRSDU_48
L7BB6:  NEGA                        ;ABSOLUTE VALUE

RHRSDU_48:
L7BB7:  CMPA #$4E                   ;?PASSED THE LARGE MAGIC ANGLE?
L7BB9:  BLO  RHRSDU_60
L7BBB:  LDD  #$3FC2                 ;HS. 78., ROTATE 4.99 LARGE MAGIC ANGLE DEGREES
L7BBE:  STD  M_COS
L7BC1:  LDA  <8,X
L7BC4:  BPL  RHRSDU_54
L7BC6:  ADDA #$4E                   ;NEGATIVE ROTATE
L7BC8:  STA  <8,X
L7BCB:  LDD  #$FA70
L7BCE:  STD  M_SIN
L7BD1:  RTS

RHRSDU_54:
L7BD2:  SUBA #$4E                   ;POSITIVE ROTATE
L7BD4:  STA  <8,X
L7BD7:  LDD  #$0590
L7BDA:  STD  M_SIN
L7BDD:  RTS

RHRSDU_60:          ;---CHECK FOR SMALLER MAGIC ANGLE
L7BDE:  CMPA #$0E                   ;.895 MARK
L7BE0:  BLO  RHRSDU_70              ;?BEYOND .895 MAGIC ANGLE?
L7BE2:  LDD  #$3FFE
L7BE5:  STD  M_COS
L7BE8:  LDA  <8,X
L7BEB:  BPL  RHRSDU_64              ;?NEGATIVE ROTATE?
L7BED:  ADDA #$0E
L7BEF:  STA  <8,X
L7BF2:  LDD  #$FF00
L7BF5:  STD  M_SIN
L7BF8:  RTS

RHRSDU_64:          ;---POSITIVE,ROTATE
L7BF9:  SUBA #$0E                   ;CORRECT THE RESIDUE
L7BFB:  STA  <8,X
L7BFE:  LDD  #$0100
L7C01:  STD  M_SIN
L7C04:  RTS

RHRSDU_70:
L7C05:  CLRB                        ;NO ROTATE
L7C06:  RTS

;------------------------------------------------------------------------------
; RESIDU - the Star Wars routine RESIDU (missed because the residue addresses are direct page here): turns the
;   downloaded unit vectors (BIC MS_U1BC) by what is left in the pitch, yaw and roll residues, each through RESCNV
;   and the matrix processor's pitch, yaw or roll program. The ship's own vectors only turn in magic steps and
;   this makes the view turn smoothly
;------------------------------------------------------------------------------
RESIDU:
L7C07:  LDA  rheop_rsd
L7C09:  BEQ  L7C26                  ;RESIDUE LEFT?
L7C0B:  JSR  RESCNV                 ;CONVERT RESIDUE TO SIN/COS
L7C0E:  LDA  rheop_rsd
L7C10:  BPL  RESIDU_35              ;?TURNING BACKWARDS?
L7C12:  LDD  #$0000                 ;THEN INVERT SINE
L7C15:  SUBD M_SIN
L7C18:  STD  M_SIN

RESIDU_35:
L7C1B:  CLRA
L7C1C:  LDB  #MS_U1BC               ;PITCH DOWNLOADED UNIT VECTORS
L7C1E:  STD  M_BIC
L7C21:  LDA  #MS_PTCH
L7C23:  JSR  MGOWT
L7C26:  LDA  rheoy_rsd
L7C28:  BEQ  L7C45
L7C2A:  JSR  RESCNV                 ;CONVERT RESIDUE
L7C2D:  LDA  rheoy_rsd
L7C2F:  BPL  RESIDU_45              ;?TURNING BACKWARDS?
L7C31:  LDD  #$0000                 ;THEN INVERT SINE
L7C34:  SUBD M_SIN
L7C37:  STD  M_SIN

RESIDU_45:
L7C3A:  CLRA
L7C3B:  LDB  #MS_U1BC               ;YAW DOWNLOADED UNIT VECTORS
L7C3D:  STD  M_BIC
L7C40:  LDA  #MS_YAW
L7C42:  JSR  MGOWT
L7C45:  LDA  rheor_rsd
L7C47:  BEQ  RESIDU_70              ;RESIDUE LEFT?
L7C49:  JSR  RESCNV                 ;CONVERT RESIDUE TO SIN/COS
L7C4C:  LDA  rheor_rsd
L7C4E:  BPL  RESIDU_65              ;?TURNING BACKWARDS?
L7C50:  LDD  #$0000                 ;THEN INVERT SINE
L7C53:  SUBD M_SIN
L7C56:  STD  M_SIN

RESIDU_65:
L7C59:  CLRA
L7C5A:  LDB  #MS_U1BC               ;ROLL DOWNLOADED UNIT VECTORS
L7C5C:  STD  M_BIC
L7C5F:  LDA  #MS_ROLL
L7C61:  JSR  MGOWT

RESIDU_70:
L7C64:  RTS

;------------------------------------------------------------------------------
; RESCNV - CONVERT A=RESIDUE TO SIN,COS
;------------------------------------------------------------------------------
RESCNV:
L7C65:  BPL  RESCNV_22
L7C67:  NEGA                        ;ABSOLUTE VALUE

RESCNV_22:
L7C68:  LDB  #$03
L7C6A:  MUL
L7C6B:  LDX  #L7CE2+1               ;TABLE OF TIC SIN AND COS
L7C6E:  ABX                         ;X-->ENTRY
L7C6F:  LDD  ,X                     ;SIN AS WORD ENTRY
L7C71:  STD  M_SIN
L7C74:  LDB  2,X                    ;ONE BYTE COS OFFSET FROM 1
L7C76:  SEX
L7C77:  ADDD #$4000                 ;GET WORD COSISNE
L7C7A:  STD  M_COS
L7C7D:  RTS

;------------------------------------------------------------------------------
; bank_roll_u1 - rolls the downloaded unit vectors (BIC 5) by GD_ACT, the amount S1TWGD has banked the ground
;   flyer, which in ESB is not rolled into the ship's own vectors. Bits 6-11 of |GD_ACT| times 3 make an angle in
;   256ths of a turn for the table roll at LB4B2, the low 6 bits are tics looked up in the tic table for a second
;   roll with MS_ROLL, both signed like GD_ACT. Called by the view routines of the probot and walker waves after
;   RESIDU
;------------------------------------------------------------------------------
bank_roll_u1:
L7C7E:  LDD  #$0005                 ;BIC of the ship 1 download block
L7C81:  STD  M_BIC
L7C84:  LDD  >GD_ACT
L7C87:  BPL  L7C8D
L7C89:  COMA
L7C8A:  NEGB
L7C8B:  SBCA #$FF
L7C8D:  ANDA #$0F                   ;bits 6-11 of |GD_ACT|: whole steps of 64 tics
L7C8F:  ANDB #$C0
L7C91:  LSRA
L7C92:  RORB
L7C93:  LSRA
L7C94:  RORB
L7C95:  LSRA
L7C96:  RORB
L7C97:  LSRA
L7C98:  RORB
L7C99:  LSRA
L7C9A:  RORB
L7C9B:  STD  M_COS                  ;M_COS used as a temp
L7C9E:  LSRA
L7C9F:  RORB
L7CA0:  ADDD M_COS                  ;steps * 3 = angle in 256ths of a turn (64 tics are 4.09 degrees)
L7CA3:  TST  >GD_ACT
L7CA6:  BPL  L7CAC
L7CA8:  COMA
L7CA9:  NEGB
L7CAA:  SBCA #$FF
L7CAC:  JSR  roll_by_angle          ;roll the download block by angle B (sine table)
L7CAF:  LDD  >GD_ACT
L7CB2:  BPL  L7CB5
L7CB4:  NEGB
L7CB5:  ANDB #$3F                   ;the 0-63 tics left over
L7CB7:  BEQ  L7CE5
L7CB9:  LDA  #$03                   ;3 bytes per tic table entry
L7CBB:  MUL
L7CBC:  LDX  #L7CE2+1
L7CBF:  ABX
L7CC0:  LDA  >GD_ACT                ;sine signed like GD_ACT
L7CC3:  BMI  L7CC9
L7CC5:  LDD  ,X
L7CC7:  BRA  L7CCE
L7CC9:  LDD  #$0000
L7CCC:  SUBD ,X
L7CCE:  STD  M_SIN
L7CD1:  LDB  2,X
L7CD3:  SEX
L7CD4:  ADDD #$4000
L7CD7:  STD  M_COS
L7CDA:  LDD  #$0005
L7CDD:  STD  M_BIC
L7CE0:  LDA  #MS_ROLL
L7CE2:  JSR  MGOWT
L7CE5:  RTS

;SINE COSINE FOR MAGIC TICS, 4000(16384.) IS UNITY
;# DEGREES SINE COSINE
tic_sin_cos:
L7CE6:  .word $0012                 ;TIC 18 16384  # 1 .064 18 16384
L7CE8:  .byte $00
L7CE9:  .word $0025                 ;TIC 37 16384  # 2 .128 37 16384
L7CEB:  .byte $00
L7CEC:  .word $0037                 ;TIC 55 16384  # 3 .192 55 16384
L7CEE:  .byte $00
L7CEF:  .word $0049                 ;TIC 73 16384  # 4 .256 73 16384
L7CF1:  .byte $00
L7CF2:  .word $005B                 ;TIC 91 16384  # 5 .32 91 16384
L7CF4:  .byte $00
L7CF5:  .word $006E                 ;TIC 110 16384  # 6 .384 110 16384
L7CF7:  .byte $00
L7CF8:  .word $0080                 ;TIC 128 16384  # 7 .447 128 16384
L7CFA:  .byte $00
L7CFB:  .word $0092                 ;TIC 146 16383  # 8 .511 146 16383
L7CFD:  .byte $FF
L7CFE:  .word $00A5                 ;TIC 165 16383  # 9 .575 165 16383
L7D00:  .byte $FF
L7D01:  .word $00B7                 ;TIC 183 16383  # 10 .639 183 16383
L7D03:  .byte $FF
L7D04:  .word $00C9                 ;TIC 201 16383  # 11 .703 201 16383
L7D06:  .byte $FF
L7D07:  .word $00DB                 ;TIC 219 16383  # 12 .767 219 16383
L7D09:  .byte $FF
L7D0A:  .word $00EE                 ;TIC 238 16382  # 13 .831 238 16382
L7D0C:  .byte $FE
L7D0D:  .word $0100                 ;TIC 256 16382  # 14 .895 256 16382
L7D0F:  .byte $FE
L7D10:  .word $0112                 ;TIC 274 16382  # 15 .959 274 16382
L7D12:  .byte $FE
L7D13:  .word $0124                 ;TIC 292 16381  # 16 1.023 292 16381
L7D15:  .byte $FD
L7D16:  .word $0137                 ;TIC 311 16381  # 17 1.087 311 16381
L7D18:  .byte $FD
L7D19:  .word $0149                 ;TIC 329 16381  # 18 1.151 329 16381
L7D1B:  .byte $FD
L7D1C:  .word $015B                 ;TIC 347 16380  # 19 1.215 347 16380
L7D1E:  .byte $FC
L7D1F:  .word $016E                 ;TIC 366 16380  # 20 1.278 366 16380
L7D21:  .byte $FC
L7D22:  .word $0180                 ;TIC 384 16380  # 21 1.342 384 16380
L7D24:  .byte $FC
L7D25:  .word $0192                 ;TIC 402 16379  # 22 1.406 402 16379
L7D27:  .byte $FB
L7D28:  .word $01A4                 ;TIC 420 16379  # 23 1.47 420 16379
L7D2A:  .byte $FB
L7D2B:  .word $01B7                 ;TIC 439 16378  # 24 1.534 439 16378
L7D2D:  .byte $FA
L7D2E:  .word $01C9                 ;TIC 457 16378  # 25 1.598 457 16378
L7D30:  .byte $FA
L7D31:  .word $01DB                 ;TIC 475 16377  # 26 1.662 475 16377
L7D33:  .byte $F9
L7D34:  .word $01ED                 ;TIC 493 16377  # 27 1.726 493 16377
L7D36:  .byte $F9
L7D37:  .word $0200                 ;TIC 512 16376  # 28 1.79 512 16376
L7D39:  .byte $F8
L7D3A:  .word $0212                 ;TIC 530 16375  # 29 1.854 530 16375
L7D3C:  .byte $F7
L7D3D:  .word $0224                 ;TIC 548 16375  # 30 1.918 548 16375
L7D3F:  .byte $F7
L7D40:  .word $0237                 ;TIC 567 16374  # 31 1.982 567 16374
L7D42:  .byte $F6
L7D43:  .word $0249                 ;TIC 585 16374  # 32 2.046 585 16374
L7D45:  .byte $F6
L7D46:  .word $025B                 ;TIC 603 16373  # 33 2.109 603 16373
L7D48:  .byte $F5
L7D49:  .word $026D                 ;TIC 621 16372  # 34 2.173 621 16372
L7D4B:  .byte $F4
L7D4C:  .word $0280                 ;TIC 640 16372  # 35 2.237 640 16372
L7D4E:  .byte $F4
L7D4F:  .word $0292                 ;TIC 658 16371  # 36 2.301 658 16371
L7D51:  .byte $F3
L7D52:  .word $02A4                 ;TIC 676 16370  # 37 2.365 676 16370
L7D54:  .byte $F2
L7D55:  .word $02B6                 ;TIC 694 16369  # 38 2.429 694 16369
L7D57:  .byte $F1
L7D58:  .word $02C9                 ;TIC 713 16368  # 39 2.493 713 16368
L7D5A:  .byte $F0
L7D5B:  .word $02DB                 ;TIC 731 16368  # 40 2.557 731 16368
L7D5D:  .byte $F0
L7D5E:  .word $02ED                 ;TIC 749 16367  # 41 2.621 749 16367
L7D60:  .byte $EF
L7D61:  .word $02FF                 ;TIC 767 16366  # 42 2.685 767 16366
L7D63:  .byte $EE
L7D64:  .word $0312                 ;TIC 786 16365  # 43 2.749 786 16365
L7D66:  .byte $ED
L7D67:  .word $0324                 ;TIC 804 16364  # 44 2.813 804 16364
L7D69:  .byte $EC
L7D6A:  .word $0336                 ;TIC 822 16363  # 45 2.877 822 16363
L7D6C:  .byte $EB
L7D6D:  .word $0348                 ;TIC 840 16362  # 46 2.94 840 16362
L7D6F:  .byte $EA
L7D70:  .word $035B                 ;TIC 859 16361  # 47 3.004 859 16361
L7D72:  .byte $E9
L7D73:  .word $036D                 ;TIC 877 16361  # 48 3.068 877 16361
L7D75:  .byte $E9
L7D76:  .word $037F                 ;TIC 895 16360  # 49 3.132 895 16360
L7D78:  .byte $E8
L7D79:  .word $0391                 ;TIC 913 16359  # 50 3.196 913 16359
L7D7B:  .byte $E7
L7D7C:  .word $03A4                 ;TIC 932 16357  # 51 3.26 932 16357
L7D7E:  .byte $E5
L7D7F:  .word $03B6                 ;TIC 950 16356  # 52 3.324 950 16356
L7D81:  .byte $E4
L7D82:  .word $03C8                 ;TIC 968 16355  # 53 3.388 968 16355
L7D84:  .byte $E3
L7D85:  .word $03DA                 ;TIC 986 16354  # 54 3.452 986 16354
L7D87:  .byte $E2
L7D88:  .word $03ED                 ;TIC 1005 16353  # 55 3.516 1005 16353
L7D8A:  .byte $E1
L7D8B:  .word $03FF                 ;TIC 1023 16352  # 56 3.58 1023 16352
L7D8D:  .byte $E0
L7D8E:  .word $0411                 ;TIC 1041 16351  # 57 3.644 1041 16351
L7D90:  .byte $DF
L7D91:  .word $0423                 ;TIC 1059 16350  # 58 3.708 1059 16350
L7D93:  .byte $DE
L7D94:  .word $0436                 ;TIC 1078 16349  # 59 3.771 1078 16349
L7D96:  .byte $DD
L7D97:  .word $0448                 ;TIC 1096 16347  # 60 3.835 1096 16347
L7D99:  .byte $DB
L7D9A:  .word $045A                 ;TIC 1114 16346  # 61 3.899 1114 16346
L7D9C:  .byte $DA
L7D9D:  .word $046C                 ;TIC 1132 16345  # 62 3.963 1132 16345
L7D9F:  .byte $D9
L7DA0:  .word $047F                 ;TIC 1151 16344  # 63 4.027 1151 16344
L7DA2:  .byte $D8
L7DA3:  .word $0491                 ;TIC 1169 16342  # 64 4.091 1169 16342
L7DA5:  .byte $D6
L7DA6:  .word $04A3                 ;TIC 1187 16341  # 65 4.155 1187 16341
L7DA8:  .byte $D5
L7DA9:  .word $04B5                 ;TIC 1205 16340  # 66 4.219 1205 16340
L7DAB:  .byte $D4
L7DAC:  .word $04C8                 ;TIC 1224 16338  # 67 4.283 1224 16338
L7DAE:  .byte $D2
L7DAF:  .word $04DA                 ;TIC 1242 16337  # 68 4.347 1242 16337
L7DB1:  .byte $D1
L7DB2:  .word $04EC                 ;TIC 1260 16335  # 69 4.411 1260 16335
L7DB4:  .byte $CF
L7DB5:  .word $04FE                 ;TIC 1278 16334  # 70 4.475 1278 16334
L7DB7:  .byte $CE
L7DB8:  .word $0510                 ;TIC 1296 16333  # 71 4.539 1296 16333
L7DBA:  .byte $CD
L7DBB:  .word $0523                 ;TIC 1315 16331  # 72 4.602 1315 16331
L7DBD:  .byte $CB
L7DBE:  .word $0535                 ;TIC 1333 16330  # 73 4.666 1333 16330
L7DC0:  .byte $CA
L7DC1:  .word $0547                 ;TIC 1351 16328  # 74 4.73 1351 16328
L7DC3:  .byte $C8
L7DC4:  .word $0559                 ;TIC 1369 16327  # 75 4.794 1369 16327
L7DC6:  .byte $C7
L7DC7:  .word $056C                 ;TIC 1388 16325  # 76 4.858 1388 16325
L7DC9:  .byte $C5
L7DCA:  .word $057E                 ;TIC 1406 16324  # 77 4.922 1406 16324
L7DCC:  .byte $C4
L7DCD:  .word $0590                 ;TIC 1424 16322  # 78 4.986 1424 16322
L7DCF:  .byte $C2
L7DD0:  .byte $E7                   ;the self test, when it finds no errors, xors this byte with $9941, $A000, $C7F1, $FFB3 and $3000 and shows the result
L7DD1:  .byte $15, $02, $BB, $5A, $30, $5F, $EE, $05 ;the first byte is xored the same way with $9942, $A001, $C7F2, $FFB4 and $3001 for the second number shown. No code reads the other seven bytes or L7DD9
L7DD9:  .byte $A8
L7DDA:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;ROM fill, 390 bytes of $FF
L7DEA:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7DFA:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7E0A:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7E1A:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7E2A:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7E3A:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7E4A:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7E5A:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7E6A:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7E7A:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7E8A:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7E9A:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7EAA:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7EBA:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7ECA:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7EDA:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7EEA:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7EFA:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7F0A:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7F1A:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7F2A:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7F3A:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7F4A:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7F5A:  .byte $FF, $FF, $FF, $FF, $FF, $FF

FILL0:
L7F60:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;.REPT 73  FILL WITH FF'S
L7F68:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7F70:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7F78:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7F80:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7F88:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7F90:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7F98:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7FA0:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7FA8:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7FB0:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7FB8:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7FC0:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7FC8:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7FD0:  .byte $FF, $FF, $FF

CPYRT0:
L7FD3:  .byte $43, $4F, $50, $59, $52, $49, $47, $48 ;.ASCII /COPYRIGHT 1983 ATARI/
L7FDB:  .byte $54, $20, $31, $39, $38, $34, $20, $41
L7FE3:  .byte $54, $41, $52, $49
L7FE7:  .byte $B8, $AD, $BA, $B8, $DF, $AD, $B6, $A9 ;.IRPC .A,<GREG RIVERA DID IT>
L7FEF:  .byte $BA, $AD, $BE, $DF, $BB, $B6, $BB, $DF
L7FF7:  .byte $B6, $AB
L7FF9:  .byte $DF, $BE, $B8, $BE, $B6, $B1, $96 ;one's complement of ' AGAIN' (the line reads GREG RIVERA DID IT AGAIN), then a last byte $96

.org $A000
LA000:  .byte $34                   ;this byte and the next go into the two numbers the self test shows when there are no errors (see L7DD0)
LA001:  .byte $77
LA002:  .byte $FF
LA003:  .byte $FF
LA004:  .byte $FF
LA005:  .byte $FF
LA006:  .byte $FF
LA007:  .byte $FF
LA008:  .byte $FF
LA009:  .byte $FF
LA00A:  .byte $FF
LA00B:  .byte $FF
LA00C:  .byte $FF
LA00D:  .byte $FF
LA00E:  .byte $FF
LA00F:  .byte $FF
LA010:  .byte $FF
LA011:  .byte $FF
LA012:  .byte $FF
LA013:  .byte $FF
LA014:  .byte $FF
LA015:  .byte $FF
LA016:  .byte $FF
LA017:  .byte $FF
LA018:  .byte $FF
LA019:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;ROM fill, 630 bytes of $FF
LA029:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA039:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA049:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA059:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA069:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA079:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA089:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA099:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA0A9:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA0B9:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA0C9:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA0D9:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA0E9:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA0F9:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA109:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA119:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA129:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA139:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA149:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA159:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA169:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA179:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA189:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA199:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA1A9:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA1B9:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA1C9:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA1D9:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA1E9:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA1F9:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA209:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA219:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA229:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA239:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA249:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA259:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA269:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA279:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA289:  .byte $FF, $FF, $FF, $FF, $FF, $FF
LA28F:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;.REPT 73  FILL WITH FF'S
LA297:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA29F:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA2A7:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA2AF:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA2B7:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA2BF:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA2C7:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA2CF:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA2D7:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA2DF:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA2E7:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA2EF:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA2F7:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA2FF:  .byte $FF, $FF, $FF
LA302:  .byte $43, $4F, $50, $59, $52, $49, $47, $48 ;.ASCII /COPYRIGHT 1983 ATARI/
LA30A:  .byte $54, $20, $31, $39, $38, $34, $20, $41
LA312:  .byte $54, $41, $52, $49
LA316:  .byte $04, $BC, $96, $FA, $5B, $28, $41, $4C ;.IRPC .A,<MIKE HALLY WAS THE WHIPCRACKER>
LA31E:  .byte $4C, $59, $20, $4D, $41, $4E, $41, $47
LA326:  .byte $45, $44, $20, $54, $48, $45, $20, $54
LA32E:  .byte $45, $41, $4D

;------------------------------------------------------------------------------
; ivgen1_wait - Star Wars IVGEN1/IVGEN, changed: starts a display list. Waits until the IRQ has handed over a
;   buffer (VGSYNC plus), points Y to its first instruction at offset $3A and stores the JSRL to VGINIT, then
;   calls bank 1 KD8AC through L60BA, which resets the object draw position and adds a JSRL $32AC. Every view
;   routine begins with it
;------------------------------------------------------------------------------
ivgen1_wait:
LA331:  LDA  VGSYNC
LA333:  BMI  ivgen1_wait            ;wait until the IRQ has handed over a buffer: VGSYNC plus is its high address byte
LA335:  LDB  #$3A                   ;offset of a buffer's first instruction
LA337:  TFR  D,Y                    ;Y-->VG BUFFER

IVGEN:
LA339:  LDD  #$B943                 ;INIT VECTOR GENERATOR
LA33C:  STD  ,Y++
LA33E:  JSR  L60BA                  ;bank 1 KD8AC: object draw position to 0,$68 and a JSRL $32AC
LA341:  RTS

;------------------------------------------------------------------------------
; load_vg_set - Star Wars DOWNVG, changed to choose between four sets: copies display list set B (0-3, pointers
;   at LB974) from program ROM to the pseudo vector ROM at $2800-$2FFF. When B is not the set already loaded
;   ($48CD) it first sends an empty display list and waits for the next buffer, so that nothing in the pseudo ROM
;   is being drawn while it changes. The phase init routines call it with 0 for the attract and select screens, 1
;   for the probot and walker waves and 2 for the TIE fighter and asteroid waves, VGDONE calls it to reload the
;   current set after a buffer overrun
;------------------------------------------------------------------------------
load_vg_set:
LA342:  CMPB >vg_set                ;B = set wanted: already loaded?
LA345:  BEQ  LA353
LA347:  STB  >vg_set
LA34A:  JSR  ivgen1_wait            ;no: start a display list
LA34D:  JSR  VGDONE                 ;and end it empty
LA350:  JSR  ivgen1_wait            ;wait for the next buffer, so the empty list is the one being drawn during the copy
LA353:  LDB  >vg_set
LA356:  ANDB #$03                   ;four sets
LA358:  STB  >vg_set
LA35B:  ASLB
LA35C:  LDX  #vg_set_tab            ;ROM address of each set
LA35F:  LDX  B,X
LA361:  LDU  #VGPSROM               ;ADDRESS OF WHERE THEY BELONG
LA364:  LDD  ,X++
LA366:  STD  ,U++
LA368:  CMPU #VGRROM                ;STOP AT VG REAL ROM
LA36C:  BLO  LA364                  ;HSEND
LA36E:  RTS

;------------------------------------------------------------------------------
; VGDONE - DONE WITH THE VG IN THIS PHASE  (comment at the calls)
;   ALL DONE WITH THE VG THIS PHASE  (another call)
;   in ESB: on a buffer overrun it also loads the pseudo vector ROM set again (load_vg_set)
;------------------------------------------------------------------------------
VGDONE:
LA36F:  LDD  #VGCNTR                ;CENTER
LA372:  STD  ,Y++
LA374:  LDD  #$2020
LA377:  STD  ,Y++                   ;ASK FOR HALT
LA379:  STD  ,Y+                    ;FORCE HALT, POINT TO LAST ADDRESS USED
LA37B:  TFR  Y,D                    ;CHECK FOR OVERFLOW
LA37D:  SUBA VGSYNC                 ;END-BEGIN
LA37F:  SUBA #VGBFSZ/$100           ;CMP WITH MAX SIZE
LA381:  BLO  LA398                  ;IFHS  ?OVERFLOW?
LA383:  LDB  >vg_set                ;the set that is loaded
LA386:  JSR  load_vg_set
LA389:  LDD  #$2020
LA38C:  STD  VGBFSZ+VGRAM-2
LA38F:  STD  VGBFSZ+VGRAM-4
LA392:  STD  (2*VGBFSZ)+VGRAM-2
LA395:  STD  (2*VGBFSZ)+VGRAM-4
LA398:  LDA  #$FF                   ;FINISHED WITH BUFFER
LA39A:  STA  VGSYNC                 ;MINUS INDICATES DONE WITH BUFFER
LA39C:  RTS

;------------------------------------------------------------------------------
; vew_probot - view of the probot part (phases $18, $1A and $1C): downloads the ship's vectors and turns them by
;   the residues and the bank (bank_roll_u1), then score, Jedi letters, shields, page 1 P1_9A0E, sight and cockpit
;   (VWSITE), ground stars, the lazar test (TSTLAZ) and its ground splash, gun shots, the transmissions (page 3
;   P3_9B6D), the probots (page 2 P2_8FB7), their lazar collision test (page 3 P3_9838), the lazars (page 3
;   P3_95D3), explosions and glow
;------------------------------------------------------------------------------
vew_probot:
LA39D:  JSR  ivgen1_wait
LA3A0:  LDA  #$10
LA3A2:  JSR  IS1UV
LA3A5:  JSR  RESIDU
LA3A8:  JSR  bank_roll_u1
LA3AB:  JSR  vw_score_all
LA3AE:  JSR  MZ_816C                ;calls page 1 jedi_draw
LA3B1:  JSR  vw_gas_jedi
LA3B4:  JSR  MZ_82CB                ;calls page 1 vw_wave_ind
LA3B7:  JSR  VWSITE
LA3BA:  JSR  L6180
LA3BD:  JSR  MZ_8307                ;calls page 3 TSTLAZ
LA3C0:  JSR  lz_ground_hit
LA3C3:  JSR  MZ_81D2                ;calls page 1 VWGUN
LA3C6:  JSR  MZ_8466                ;calls page 3 xmit_view_all
LA3C9:  JSR  MZ_8196                ;calls page 2 probots_view
LA3CC:  JSR  MZ_83F1                ;calls page 3 lz_hit_probot
LA3CF:  JSR  MZ_8565                ;calls page 3 view_lazars
LA3D2:  JSR  L61B0
LA3D5:  JSR  VWGLW
LA3D8:  JSR  VGDONE
LA3DB:  RTS

;------------------------------------------------------------------------------
; vew_probot_end - view of the flight out of the probot part (phase $1E): call for call the same as vew_probot
;------------------------------------------------------------------------------
vew_probot_end:
LA3DC:  JSR  ivgen1_wait
LA3DF:  LDA  #$10
LA3E1:  JSR  IS1UV
LA3E4:  JSR  RESIDU
LA3E7:  JSR  bank_roll_u1
LA3EA:  JSR  vw_score_all
LA3ED:  JSR  MZ_816C                ;calls page 1 jedi_draw
LA3F0:  JSR  vw_gas_jedi
LA3F3:  JSR  MZ_82CB                ;calls page 1 vw_wave_ind
LA3F6:  JSR  VWSITE
LA3F9:  JSR  L6180
LA3FC:  JSR  MZ_8307                ;calls page 3 TSTLAZ
LA3FF:  JSR  lz_ground_hit
LA402:  JSR  MZ_81D2                ;calls page 1 VWGUN
LA405:  JSR  MZ_8466                ;calls page 3 xmit_view_all
LA408:  JSR  MZ_8196                ;calls page 2 probots_view
LA40B:  JSR  MZ_83F1                ;calls page 3 lz_hit_probot
LA40E:  JSR  MZ_8565                ;calls page 3 view_lazars
LA411:  JSR  L61B0
LA414:  JSR  VWGLW
LA417:  JSR  VGDONE
LA41A:  RTS

;------------------------------------------------------------------------------
; vew_probot_die - view of the player dying in the probot part (phase $36): score, Jedi letters, shields, ground
;   stars, gun shots, the transmissions (page 3 P3_9B6D), the probots (page 2 P2_8FB7), the growing GAME OVER
;   message (VWMOVR) and glow, no sight and no lazars
;------------------------------------------------------------------------------
vew_probot_die:
LA41B:  JSR  ivgen1_wait
LA41E:  LDA  #$10
LA420:  JSR  IS1UV
LA423:  JSR  RESIDU
LA426:  JSR  bank_roll_u1
LA429:  JSR  vw_score_all
LA42C:  JSR  MZ_816C                ;calls page 1 jedi_draw
LA42F:  JSR  vw_gas_jedi
LA432:  JSR  L6180
LA435:  JSR  MZ_81D2                ;calls page 1 VWGUN
LA438:  JSR  MZ_8466                ;calls page 3 xmit_view_all
LA43B:  JSR  MZ_8196                ;calls page 2 probots_view
LA43E:  JSR  VWMOVR
LA441:  JSR  VWGLW
LA444:  JSR  VGDONE
LA447:  RTS

;------------------------------------------------------------------------------
; vew_walker - view of the walker wave (phases $20 and $22). As vew_probot, which views the probot wave, with
;   the walker views (page 1 P1_88FD, page 0 P0_891A, page 0 P0_969D) and their lazar collision test (page 3
;   P3_97CB) in place of the probot ones
;------------------------------------------------------------------------------
vew_walker:
LA448:  JSR  ivgen1_wait
LA44B:  LDA  #$10
LA44D:  JSR  IS1UV
LA450:  JSR  RESIDU
LA453:  JSR  bank_roll_u1
LA456:  JSR  vw_score_all
LA459:  JSR  MZ_816C                ;calls page 1 jedi_draw
LA45C:  JSR  vw_gas_jedi
LA45F:  JSR  MZ_82CB                ;calls page 1 vw_wave_ind
LA462:  JSR  VWSITE
LA465:  JSR  L6180
LA468:  JSR  MZ_8307                ;calls page 3 TSTLAZ
LA46B:  JSR  lz_ground_hit
LA46E:  JSR  MZ_84FF                ;calls page 0 cable_view
LA471:  JSR  MZ_81D2                ;calls page 1 VWGUN
LA474:  JSR  MZ_8550                ;calls page 1 atst_view_all
LA477:  JSR  MZ_832E                ;calls page 0 atat_view_all
LA47A:  JSR  MZ_8184                ;calls page 3 lz_hit_walker
LA47D:  JSR  MZ_8565                ;calls page 3 view_lazars
LA480:  JSR  L61B0
LA483:  JSR  VWGLW
LA486:  JSR  VGDONE
LA489:  RTS

;------------------------------------------------------------------------------
; vew_walker_end - view of the end of the walker wave (phase $24, 40 frames): score, shields, sight, ground
;   stars, lazars and explosions without the walkers, then the picture at the start of the pseudo ROM set growing
;   from small to full size 120 below the centre, with the message 'REBEL HIDEOUT'
;------------------------------------------------------------------------------
vew_walker_end:
LA48A:  JSR  ivgen1_wait
LA48D:  LDA  #$10
LA48F:  JSR  IS1UV
LA492:  JSR  RESIDU
LA495:  JSR  bank_roll_u1
LA498:  JSR  vw_score_all
LA49B:  JSR  MZ_816C                ;calls page 1 jedi_draw
LA49E:  JSR  vw_gas_jedi
LA4A1:  JSR  VWSITE
LA4A4:  JSR  L6180
LA4A7:  JSR  MZ_8307                ;calls page 3 TSTLAZ
LA4AA:  JSR  lz_ground_hit
LA4AD:  JSR  MZ_84FF                ;calls page 0 cable_view
LA4B0:  JSR  MZ_81D2                ;calls page 1 VWGUN
LA4B3:  JSR  MZ_8184                ;calls page 3 lz_hit_walker
LA4B6:  JSR  MZ_8565                ;calls page 3 view_lazars
LA4B9:  JSR  L61B0
LA4BC:  JSR  VWGLW
LA4BF:  LDD  #$1F88                 ;y -120
LA4C2:  STD  ,Y++
LA4C4:  LDD  #$0000
LA4C7:  STD  ,Y++
LA4C9:  LDB  #$28                   ;40 frames: the scale goes from $F0 (small) to $00 (full size)
LA4CB:  SUBB ph_tim_lo
LA4CE:  LDA  #$06
LA4D0:  MUL
LA4D1:  LDA  #$72
LA4D3:  STD  ,Y++
LA4D5:  LDD  #$B400                 ;JSRL $2800: the picture at the start of the pseudo ROM set
LA4D8:  STD  ,Y++
LA4DA:  LDB  #$45                   ;'REBEL HIDEOUT'
LA4DC:  JSR  do_message
LA4DF:  LDD  #$7200                 ;back to normal scale
LA4E2:  STD  ,Y++
LA4E4:  JSR  VGDONE
LA4E7:  RTS

;------------------------------------------------------------------------------
; vew_walker_die - view of the player dying in the walker part (phase $38): score, Jedi letters, shields, ground
;   stars, gun shots, the walkers (page 1 P1_88FD, page 0 P0_891A), the growing GAME OVER message and glow
;------------------------------------------------------------------------------
vew_walker_die:
LA4E8:  JSR  ivgen1_wait
LA4EB:  LDA  #$10
LA4ED:  JSR  IS1UV
LA4F0:  JSR  RESIDU
LA4F3:  JSR  bank_roll_u1
LA4F6:  JSR  vw_score_all
LA4F9:  JSR  MZ_816C                ;calls page 1 jedi_draw
LA4FC:  JSR  vw_gas_jedi
LA4FF:  JSR  L6180
LA502:  JSR  MZ_81D2                ;calls page 1 VWGUN
LA505:  JSR  MZ_8550                ;calls page 1 atst_view_all
LA508:  JSR  MZ_832E                ;calls page 0 atat_view_all
LA50B:  JSR  VWMOVR
LA50E:  JSR  VWGLW
LA511:  JSR  VGDONE
LA514:  RTS

;------------------------------------------------------------------------------
; vew_tie - view of the TIE fighter wave (phases $26 and $28): residue, score, shields, VWDTHB, sight, stars,
;   explosions, lazars, the alien ships (SNVW), guns, collisions and glow. It ends with a line that alternates
;   every 128 frames between 'SHOOT nn TIE FIGHTERS FOR BONUS', with the count $4C53 drawn into the gap ('5,000
;   POINTS AND JEDI LETTER AWARDED' once the count is 0), and 'SHOOT ENEMY SHOTS TO SAVE YOUR SHIELDS'
;------------------------------------------------------------------------------
vew_tie:
LA515:  JSR  ivgen1_wait
LA518:  LDA  #$10
LA51A:  JSR  IS1UV
LA51D:  JSR  RESIDU
LA520:  JSR  vw_score_all
LA523:  JSR  MZ_816C                ;calls page 1 jedi_draw
LA526:  JSR  vw_gas_jedi
LA529:  JSR  VWDTHB
LA52C:  JSR  VWSITE
LA52F:  JSR  L617A
LA532:  JSR  L61B0
LA535:  JSR  MZ_8307                ;calls page 3 TSTLAZ
LA538:  JSR  MZ_8496                ;calls page 3 SNVW
LA53B:  JSR  MZ_81D2                ;calls page 1 VWGUN
LA53E:  JSR  MZ_84BA                ;calls page 3 lz_hit_space
LA541:  JSR  MZ_8565                ;calls page 3 view_lazars
LA544:  LDA  FRAMEL                 ;the line changes every 128 frames
LA546:  ANDA #$80
LA548:  BNE  LA58D
LA54A:  LDA  bonus_left             ;TIE fighters still to shoot for the bonus
LA54D:  BEQ  LA589
LA54F:  LDD  #$6780                 ;colour 7
LA552:  STD  ,Y++
LA554:  LDD  #$0150                 ;y 336, the line of the message
LA557:  STD  ,Y++
LA559:  LDA  #$01
LA55B:  STA  >BT_SUP
LA55E:  LDA  bonus_left             ;the count in decimal
LA561:  LDX  #$0008
LA564:  JSR  BINBCD_B0
LA567:  LDA  bcd_lo                 ;two digits?
LA56A:  CMPA #$10
LA56C:  BCS  LA578
LA56E:  LDX  #$1F21                 ;x of a two digit count
LA571:  STX  ,Y++
LA573:  JSR  VWBYTE
LA576:  BRA  LA580
LA578:  LDX  #$1F2D                 ;x of a one digit count
LA57B:  STX  ,Y++
LA57D:  JSR  VWBYT1
LA580:  LDD  #$8040
LA583:  STD  ,Y++
LA585:  LDB  #$46                   ;'SHOOT TIE FIGHTERS FOR BONUS': the count stands in the gap
LA587:  BRA  LA58B
LA589:  LDB  #$4C                   ;'5,000 POINTS AND JEDI LETTER AWARDED'
LA58B:  BRA  LA58F
LA58D:  LDB  #$47                   ;'SHOOT ENEMY SHOTS TO SAVE YOUR SHIELDS'
LA58F:  JSR  do_message
LA592:  JSR  VWGLW
LA595:  JSR  VGDONE
LA598:  RTS

;------------------------------------------------------------------------------
; vew_tie_end - view of the end of the TIE fighter wave (phase $2A): as LA515 without the message line and with
;   LA8F8 in place of VWDTHB, which draws the same far object at its saved screen position and moves it 16 to the
;   left each frame
;------------------------------------------------------------------------------
vew_tie_end:
LA599:  JSR  ivgen1_wait
LA59C:  LDA  #$10
LA59E:  JSR  IS1UV
LA5A1:  JSR  RESIDU
LA5A4:  JSR  vw_score_all
LA5A7:  JSR  MZ_816C                ;calls page 1 jedi_draw
LA5AA:  JSR  vw_gas_jedi
LA5AD:  JSR  exec_drift_left
LA5B0:  JSR  VWSITE
LA5B3:  JSR  L617A
LA5B6:  JSR  L61B0
LA5B9:  JSR  MZ_8307                ;calls page 3 TSTLAZ
LA5BC:  JSR  MZ_8496                ;calls page 3 SNVW
LA5BF:  JSR  MZ_81D2                ;calls page 1 VWGUN
LA5C2:  JSR  MZ_84BA                ;calls page 3 lz_hit_space
LA5C5:  JSR  MZ_8565                ;calls page 3 view_lazars
LA5C8:  JSR  VWGLW
LA5CB:  JSR  VGDONE
LA5CE:  RTS

;------------------------------------------------------------------------------
; vew_tie_die - view for phe_tie_die, the player dying in the TIE fighter wave: residue, score, shields, stars,
;   explosions, alien ships, guns, the growing GAME OVER message and glow, no sight and no lazars. The ESB form of
;   Star Wars VEWS0D
;------------------------------------------------------------------------------
vew_tie_die:
LA5CF:  JSR  ivgen1_wait
LA5D2:  LDA  #$10
LA5D4:  JSR  IS1UV
LA5D7:  JSR  RESIDU
LA5DA:  JSR  vw_score_all
LA5DD:  JSR  MZ_816C                ;calls page 1 jedi_draw
LA5E0:  JSR  vw_gas_jedi
LA5E3:  JSR  L617A
LA5E6:  JSR  L61B0
LA5E9:  JSR  MZ_8496                ;calls page 3 SNVW
LA5EC:  JSR  MZ_81D2                ;calls page 1 VWGUN
LA5EF:  JSR  VWMOVR
LA5F2:  JSR  VWGLW
LA5F5:  JSR  VGDONE
LA5F8:  RTS

;------------------------------------------------------------------------------
; vew_asteroid - view of the asteroid wave (phase $2C): residue, score, shields, sight, stars, explosions,
;   lazars, the asteroids (page 2 P2_9983), guns, collisions, LA843 (an object that appears near the end of the
;   wave) and a line that alternates every 128 frames between 'SURVIVE TO EARN NEXT JEDI LETTER' and 'AVOID
;   COLLISIONS WITH ASTEROIDS'
;------------------------------------------------------------------------------
vew_asteroid:
LA5F9:  JSR  ivgen1_wait
LA5FC:  LDA  #$10
LA5FE:  JSR  IS1UV
LA601:  JSR  RESIDU
LA604:  JSR  vw_score_all
LA607:  JSR  MZ_816C                ;calls page 1 jedi_draw
LA60A:  JSR  vw_gas_jedi
LA60D:  JSR  VWSITE
LA610:  JSR  L617A
LA613:  JSR  L61B0
LA616:  JSR  MZ_8307                ;calls page 3 TSTLAZ
LA619:  JSR  MZ_8526                ;calls page 2 astrd_view_all
LA61C:  JSR  MZ_81D2                ;calls page 1 VWGUN
LA61F:  JSR  MZ_84BA                ;calls page 3 lz_hit_space
LA622:  JSR  MZ_8565                ;calls page 3 view_lazars
LA625:  JSR  exec_slide_in
LA628:  LDA  FRAMEL                 ;the line changes every 128 frames
LA62A:  ANDA #$80
LA62C:  BNE  LA632
LA62E:  LDB  #$48                   ;'SURVIVE TO EARN NEXT JEDI LETTER'
LA630:  BRA  LA634
LA632:  LDB  #$49                   ;'AVOID COLLISIONS WITH ASTEROIDS'
LA634:  JSR  do_message
LA637:  JSR  VWGLW
LA63A:  JSR  VGDONE
LA63D:  RTS

;------------------------------------------------------------------------------
; vew_asteroid_end - view of the end of the asteroid wave (phase $2E, 70 frames): residue, score, shields,
;   stars, explosions, the message '5,000 POINTS AND JEDI LETTER AWARDED', the object of LA881 and the shrinking
;   picture of LA763
;------------------------------------------------------------------------------
vew_asteroid_end:
LA63E:  JSR  ivgen1_wait
LA641:  LDA  #$10
LA643:  JSR  IS1UV
LA646:  JSR  RESIDU
LA649:  JSR  vw_score_all
LA64C:  JSR  MZ_816C                ;calls page 1 jedi_draw
LA64F:  JSR  vw_gas_jedi
LA652:  JSR  L617A
LA655:  JSR  L61B0
LA658:  LDB  #$4D                   ;'5,000 POINTS AND JEDI LETTER AWARDED'
LA65A:  JSR  do_message
LA65D:  JSR  exec_slide_on
LA660:  JSR  vw_shrink_pic
LA663:  JSR  VWGLW
LA666:  JSR  VGDONE
LA669:  RTS

;------------------------------------------------------------------------------
; vew_asteroid_die - view for phase $3C (entered through L73AA), the player dying in the asteroid wave: residue,
;   score, shields, stars, explosions, the asteroids, guns, the growing GAME OVER message and glow
;------------------------------------------------------------------------------
vew_asteroid_die:
LA66A:  JSR  ivgen1_wait
LA66D:  LDA  #$10
LA66F:  JSR  IS1UV
LA672:  JSR  RESIDU
LA675:  JSR  vw_score_all
LA678:  JSR  MZ_816C                ;calls page 1 jedi_draw
LA67B:  JSR  vw_gas_jedi
LA67E:  JSR  L617A
LA681:  JSR  L61B0
LA684:  JSR  MZ_8496                ;calls page 3 SNVW
LA687:  JSR  MZ_8526                ;calls page 2 astrd_view_all
LA68A:  JSR  MZ_81D2                ;calls page 1 VWGUN
LA68D:  JSR  VWMOVR
LA690:  JSR  VWGLW
LA693:  JSR  VGDONE
LA696:  RTS

;------------------------------------------------------------------------------
; vew_manual - view of the rebel training manual pages of the attract mode (phase after phi_manual): residue,
;   score, shields, guns and LB20A, which shows 'REBEL TRAINING MANUAL SECTION' with its numbers and the objects
;   of the wave being explained
;------------------------------------------------------------------------------
vew_manual:
LA697:  JSR  ivgen1_wait
LA69A:  LDA  #$10
LA69C:  JSR  IS1UV
LA69F:  JSR  RESIDU
LA6A2:  JSR  vw_score_all
LA6A5:  JSR  vw_gas_jedi
LA6A8:  JSR  MZ_81D2                ;calls page 1 VWGUN
LA6AB:  JSR  manual_view
LA6AE:  JSR  VGDONE
LA6B1:  RTS

;------------------------------------------------------------------------------
; vew_wave_bonus - view of the bonus screen after the asteroid wave (phase $32): score, shields and the picture
;   at the start of the pseudo ROM set. For the first 64 frames it shows 'WAVE COMPLETED: 2,500 POINTS'. For the
;   next 64, if the start bonus is still due ($4C62), it shows the bonus for the starting difficulty: none for
;   easy, 100,000 for moderate, 250,000 for hard, or from difficulty 3 up 'BONUS AWARDED FOR CONTINUED PLAY' with
;   the 8-digit amount at $4BEF
;------------------------------------------------------------------------------
vew_wave_bonus:
LA6B2:  JSR  ivgen1_wait
LA6B5:  JSR  vw_score_all
LA6B8:  JSR  MZ_816C                ;calls page 1 jedi_draw
LA6BB:  JSR  vw_gas_jedi
LA6BE:  LDD  #$B400                 ;JSRL $2800: the picture at the start of the pseudo ROM set
LA6C1:  STD  ,Y++
LA6C3:  LDD  PH_TIM
LA6C6:  CMPD #$0040
LA6CA:  BGE  LA6D1
LA6CC:  LDB  #$4E                   ;first 64 frames: 'WAVE COMPLETED: 2,500 POINTS'
LA6CE:  JSR  do_message
LA6D1:  LDD  PH_TIM
LA6D4:  CMPD #$0080
LA6D8:  BGE  LA70D
LA6DA:  CMPD #$0040
LA6DE:  BCS  LA70D
LA6E0:  LDA  start_bonus            ;next 64 frames, only while the start bonus is due
LA6E3:  BEQ  LA70D
LA6E5:  LDB  GM_WAV                 ;difficulty level of the set of waves just flown: 0 easy, 1 moderate, 2 hard, 3 up continued play
LA6E8:  CMPB #$03
LA6EA:  BCC  LA6F3
LA6EC:  ADDB #$4F                   ;messages $4F-$51: no bonus for easy, 100,000 for moderate, 250,000 for hard wave
LA6EE:  JSR  do_message
LA6F1:  BRA  LA70D
LA6F3:  LDB  #$52                   ;'BONUS AWARDED FOR CONTINUED PLAY'
LA6F5:  JSR  do_message
LA6F8:  LDD  #$1E34                 ;Y POS  y -460
LA6FB:  STD  ,Y++
LA6FD:  LDD  #$1E24                 ;X POS  x -476
LA700:  STD  ,Y++
LA702:  LDA  #$04                   ;SUPRESS 4 ZEROES  suppress 4 leading zeroes
LA704:  STA  >BT_SUP
LA707:  LDU  #cont_bonus            ;the bonus: 8 BCD digits with commas
LA70A:  JSR  view_8dig
LA70D:  JSR  VGDONE
LA710:  RTS

;------------------------------------------------------------------------------
; vew_die_plain - view of phase $3E: score, Jedi letters, shields, the picture at the start of the pseudo ROM
;   set and the growing GAME OVER message, no scene
;------------------------------------------------------------------------------
vew_die_plain:
LA711:  JSR  ivgen1_wait
LA714:  JSR  vw_score_all
LA717:  JSR  MZ_816C                ;calls page 1 jedi_draw
LA71A:  JSR  vw_gas_jedi
LA71D:  LDD  #$B400                 ;JSRL $2800: the picture at the start of the pseudo ROM set
LA720:  STD  ,Y++
LA722:  JSR  VWMOVR
LA725:  JSR  VGDONE
LA728:  RTS

;------------------------------------------------------------------------------
; vew_stars_only - no caller found: a view with score, Jedi letters, shields, sight and cockpit, stars and glow
;   only, the shape of Star Wars' VEWHPB without its Death Star
;------------------------------------------------------------------------------
vew_stars_only:
LA729:  JSR  ivgen1_wait
LA72C:  LDA  #$10
LA72E:  JSR  IS1UV
LA731:  JSR  RESIDU
LA734:  JSR  vw_score_all
LA737:  JSR  MZ_816C                ;calls page 1 jedi_draw
LA73A:  JSR  vw_gas_jedi
LA73D:  JSR  VWSITE
LA740:  JSR  L617A
LA743:  JSR  VWGLW
LA746:  JSR  VGDONE
LA749:  RTS

;------------------------------------------------------------------------------
; VWMOVR - VIEW GROWING GAME OVER MESSAGE
;------------------------------------------------------------------------------
VWMOVR:
LA74A:  LDA  PH_TIM+1
LA74D:  CMPA #$20                   ;STOP GROWING
LA74F:  BLS  LA753                  ;IFHI
LA751:  LDA  #$20
LA753:  LDB  #$06                   ;EXPAND AT 6 PER FRAME
LA755:  MUL
LA756:  NEGB
LA757:  ADDB #$C0                   ;SMALL IS 0C0, LARGE IS 000
LA759:  LDA  #(VGSCAL&$F000)/$100   ;FRONT PART OF SCALE INSTRUCTION
LA75B:  STD  ,Y++
LA75D:  LDB  #$02                   ;"GAME OVER" IN CENTER OF SCREEN
LA75F:  JSR  do_message
LA762:  RTS

;------------------------------------------------------------------------------
; vw_shrink_pic - draws a picture made of seven vector ROM pieces ($34A2 to $3646), each with its own move,
;   scale and JSRL. The scale comes from the low byte of the phase timer, 4 steps a frame up to $F8, so the
;   picture starts full size 600 below the centre and shrinks towards the point 600 right and 200 above it. Called
;   by LA63E at the end of the asteroid wave. Preserves X and U
;------------------------------------------------------------------------------
vw_shrink_pic:
LA763:  PSHS X,U
LA765:  LDB  ph_tim_lo              ;phase timer, low byte
LA768:  LDA  #$04                   ;the scale shrinks 4 steps a frame
LA76A:  MUL
LA76B:  CMPD #$00F8
LA76F:  BLS  LA773
LA771:  LDB  #$F8                   ;smallest size
LA773:  LDA  #$72                   ;scale instruction, binary scale 2
LA775:  STD  scratch_1
LA777:  LDU  #$1CE0                 ;second move, drawn at the picture's scale: y -800
LA77A:  LDX  #$1DA8                 ;x -600
LA77D:  LDD  #$00C8                 ;first move at full scale: y 200
LA780:  STD  ,Y++
LA782:  LDD  #$0258                 ;x 600
LA785:  STD  ,Y++
LA787:  LDD  scratch_1
LA789:  STD  ,Y++
LA78B:  STU  ,Y++
LA78D:  STX  ,Y++
LA78F:  LDD  #$BA51                 ;JSRL $34A2: the first of the seven pieces
LA792:  STD  ,Y++
LA794:  LDD  #$7200                 ;back to normal scale
LA797:  STD  ,Y++
LA799:  LDD  #$00C8
LA79C:  STD  ,Y++
LA79E:  LDD  #$0258
LA7A1:  STD  ,Y++
LA7A3:  LDD  scratch_1
LA7A5:  STD  ,Y++
LA7A7:  STU  ,Y++
LA7A9:  STX  ,Y++
LA7AB:  LDD  #$BA7C
LA7AE:  STD  ,Y++
LA7B0:  LDD  #$7200
LA7B3:  STD  ,Y++
LA7B5:  LDD  #$00C8
LA7B8:  STD  ,Y++
LA7BA:  LDD  #$0258
LA7BD:  STD  ,Y++
LA7BF:  LDD  scratch_1
LA7C1:  STD  ,Y++
LA7C3:  STU  ,Y++
LA7C5:  STX  ,Y++
LA7C7:  LDD  #$BAA7
LA7CA:  STD  ,Y++
LA7CC:  LDD  #$7200
LA7CF:  STD  ,Y++
LA7D1:  LDD  #$00C8
LA7D4:  STD  ,Y++
LA7D6:  LDD  #$0258
LA7D9:  STD  ,Y++
LA7DB:  LDD  scratch_1
LA7DD:  STD  ,Y++
LA7DF:  STU  ,Y++
LA7E1:  STX  ,Y++
LA7E3:  LDD  #$BAC9
LA7E6:  STD  ,Y++
LA7E8:  LDD  #$7200
LA7EB:  STD  ,Y++
LA7ED:  LDD  #$00C8
LA7F0:  STD  ,Y++
LA7F2:  LDD  #$0258
LA7F5:  STD  ,Y++
LA7F7:  LDD  scratch_1
LA7F9:  STD  ,Y++
LA7FB:  STU  ,Y++
LA7FD:  STX  ,Y++
LA7FF:  LDD  #$BAEB
LA802:  STD  ,Y++
LA804:  LDD  #$7200
LA807:  STD  ,Y++
LA809:  LDD  #$00C8
LA80C:  STD  ,Y++
LA80E:  LDD  #$0258
LA811:  STD  ,Y++
LA813:  LDD  scratch_1
LA815:  STD  ,Y++
LA817:  STU  ,Y++
LA819:  STX  ,Y++
LA81B:  LDD  #$BB01
LA81E:  STD  ,Y++
LA820:  LDD  #$7200
LA823:  STD  ,Y++
LA825:  LDD  #$00C8
LA828:  STD  ,Y++
LA82A:  LDD  #$0258
LA82D:  STD  ,Y++
LA82F:  LDD  scratch_1
LA831:  STD  ,Y++
LA833:  STU  ,Y++
LA835:  STX  ,Y++
LA837:  LDD  #$BB23
LA83A:  STD  ,Y++
LA83C:  LDD  #$7200
LA83F:  STD  ,Y++
LA841:  PULS X,U,PC

;------------------------------------------------------------------------------
; exec_slide_in - draws the Executor (the star destroyer picture at $298E in the pseudo ROM) coming in from the
;   right near the end of the asteroid wave. nothing is drawn until PH_TIM reaches 260 (360 when GM_WAV is 2 or
;   more), then the picture goes at y 200, x 530 - 7 * frames since then, at scale $7400. called by the view
;   LA5F9. Y-->VG list
;------------------------------------------------------------------------------
exec_slide_in:
LA843:  LDA  GM_WAV
LA846:  BNE  LA84D
LA848:  LDD  #$FEFC
LA84B:  BRA  LA859
LA84D:  CMPA #$01                   ;GM_WAV 0 and 1 start at frame 260, the others at 360
LA84F:  BNE  LA856
LA851:  LDD  #$FEFC
LA854:  BRA  LA859
LA856:  LDD  #$FE98
LA859:  ADDD PH_TIM
LA85C:  BLT  LA880
LA85E:  LDA  #$07                   ;7 * frames since the start (low byte only)
LA860:  MUL
LA861:  COMA
LA862:  NEGB
LA863:  SBCA #$FF
LA865:  ADDD #$0212                 ;x = 530 - 7n, 13 bits
LA868:  ANDA #$1F
LA86A:  STD  2,Y
LA86C:  LDD  #$00C8                 ;y = 200
LA86F:  STD  ,Y
LA871:  LEAY 4,Y
LA873:  LDD  #$7400
LA876:  STD  ,Y++
LA878:  LDD  #$B4C7
LA87B:  STD  ,Y++
LA87D:  JSR  L60BA
LA880:  RTS

;------------------------------------------------------------------------------
; exec_slide_on - draws the Executor at y 200, x 250 - 7 * the low byte of PH_TIM, at scale $7400: the
;   continuation of exec_slide_in in the phase that follows (view LA63E), starting where that one stopped. Y-->VG
;   list
;------------------------------------------------------------------------------
exec_slide_on:
LA881:  LDD  #$00C8
LA884:  STD  ,Y++
LA886:  LDB  ph_tim_lo              ;low byte of PH_TIM
LA889:  LDA  #$07
LA88B:  MUL
LA88C:  COMA
LA88D:  NEGB
LA88E:  SBCA #$FF
LA890:  ADDD #$00FA                 ;x = 250 - 7 * PH_TIM
LA893:  ANDA #$1F
LA895:  STD  ,Y++
LA897:  LDD  #$7400                 ;scale of the Executor here
LA89A:  STD  ,Y++
LA89C:  LDD  #$B4C7                 ;JSRL to the Executor picture at $298E in the pseudo ROM
LA89F:  STD  ,Y++
LA8A1:  JSR  L60BA
LA8A4:  RTS

;------------------------------------------------------------------------------
; VWDTHB - VIEW DEATH STAR, VERSION B (WITH SCALING)
;   in ESB: views the Executor in the TIE fighter part: the far point straight ahead along +x is projected,
;   its screen position kept in exec_y and exec_x, and the picture at $298E of the pseudo ROM drawn there at
;   scale $7600
;------------------------------------------------------------------------------
VWDTHB:
LA8A5:  LDD  (MS_AX+M_U1)&$FFFF     ;X POSITION AT FAR(4000,0,0) DISTANCE
LA8A8:  BLE  LA8F7                  ;IFGT  ?IN FRONT OF PLAYER?
LA8AA:  STD  M_DVD                  ;PREPARE DIVIDER,PERSPECTIVE
LA8AD:  LDD  (MS_AY+M_U1)&$FFFF
LA8B0:  STD  M_YP
LA8B3:  TSTA                        ;ABSD
LA8B4:  BPL  LA8BA
LA8B6:  COMA
LA8B7:  NEGB
LA8B8:  SBCA #$FF
LA8BA:  SUBD (MS_AX+M_U1)&$FFFF
LA8BD:  BGE  LA8F7                  ;IFLT  ?Y WITHIN X FIELD OF VIEW?
LA8BF:  LDD  (MS_AZ+M_U1)&$FFFF
LA8C2:  STD  M_ZP                   ;ASSUME OK, THEN TEST
LA8C5:  TSTA                        ;ABSD
LA8C6:  BPL  LA8CC
LA8C8:  COMA
LA8C9:  NEGB
LA8CA:  SBCA #$FF
LA8CC:  SUBD (MS_AX+M_U1)&$FFFF
LA8CF:  BGE  LA8F7                  ;IFLT  ?Z WITHIN X FIELD OF VIEW?
LA8D1:  JSR  L60B4                  ;bank 1 BJCNTR_6761: blank vector to the object's centre (Star Wars called DTHVW here)
LA8D4:  LDD  -4,Y                   ;read the centre back out of the list: y, sign extended from 13 bits
LA8D6:  BITA #$10
LA8D8:  BEQ  LA8DC
LA8DA:  ORA  #$F0
LA8DC:  STD  exec_y                 ;screen y of the Executor, kept for exec_drift_left
LA8DF:  LDD  -2,Y                   ;and x
LA8E1:  BITA #$10
LA8E3:  BEQ  LA8E7
LA8E5:  ORA  #$F0
LA8E7:  STD  exec_x
LA8EA:  LDD  #$7600                 ;scale for the distant ship
LA8ED:  STD  ,Y++
LA8EF:  LDD  #$B4C7                 ;JSRL to the Executor picture at $298E in the pseudo ROM
LA8F2:  STD  ,Y++
LA8F4:  JSR  L60BA                  ;bank 1 KD8AC: back to the screen centre
LA8F7:  RTS

;------------------------------------------------------------------------------
; exec_drift_left - draws the Executor at the screen position VWDTHB saved in $4CCE (y) and $4CCC (x), after
;   moving x 16 to the left. called every frame by the view LA599, whose phase (L707A) ends when x has reached
;   -520. Y-->VG list
;------------------------------------------------------------------------------
exec_drift_left:
LA8F8:  LDD  exec_y
LA8FB:  ANDA #$1F
LA8FD:  STD  ,Y++
LA8FF:  LDD  exec_x                 ;x moves 16 left each frame
LA902:  SUBD #$0010
LA905:  STD  exec_x
LA908:  ANDA #$1F
LA90A:  STD  ,Y++
LA90C:  LDD  #$7600                 ;same scale and picture as VWDTHB
LA90F:  STD  ,Y++
LA911:  LDD  #$B4C7
LA914:  STD  ,Y++
LA916:  JSR  L60BA
LA919:  RTS

;------------------------------------------------------------------------------
; vew_exec_intro - the whole view of the phase L6999, 100 frames before a game: message $2C (DARTH VADER'S
;   EXECUTOR IS SEARCHING FOR THE REBEL HIDEOUT) in red, the Executor picture ($2B70 in the pseudo ROM) crossing
;   the screen from x 700 leftwards 10 a frame, and the stars. after frame 60 the brightness of the text, the ship
;   and the stars (ST_BRT) falls by 3 a frame
;------------------------------------------------------------------------------
vew_exec_intro:
LA91A:  JSR  ivgen1_wait
LA91D:  LDB  ph_tim_lo              ;low byte of PH_TIM, the frame number of this phase
LA920:  SUBB #$3C                   ;from frame 60 on the brightness falls
LA922:  BLE  LA92C
LA924:  LDA  #$03                   ;$80 - 3 * (frame - 60)
LA926:  MUL
LA927:  NEGB
LA928:  ADDB #$80
LA92A:  BRA  LA92E
LA92C:  LDB  #$80
LA92E:  LDA  #$64                   ;red at that brightness
LA930:  STD  ,Y++
LA932:  STB  scratch_1              ;kept for the ship's colour
LA934:  STB  >ST_BRT                ;the stars fade with it
LA937:  LDB  #$2C                   ;DARTH VADER'S EXECUTOR IS SEARCHING FOR THE REBEL HIDEOUT, in the colour just set
LA939:  JSR  do_message_nc
LA93C:  LDD  #$0000
LA93F:  STD  ,Y++
LA941:  LDB  ph_tim_lo
LA944:  LDA  #$0A
LA946:  MUL
LA947:  COMA
LA948:  NEGB
LA949:  SBCA #$FF
LA94B:  ADDD #$02BC                 ;x = 700 - 10 * frame
LA94E:  ANDA #$1F
LA950:  STD  ,Y++
LA952:  LDD  #$7300
LA955:  STD  ,Y++
LA957:  LDA  #$67
LA959:  LDB  scratch_1
LA95B:  STD  ,Y++
LA95D:  LDD  #$B5B8                 ;JSRL to the Executor picture at $2B70 in the pseudo ROM
LA960:  STD  ,Y++
LA962:  JSR  L60BA                  ;bank 1 KD8AC: back to the screen centre
LA965:  JSR  L617A                  ;bank 1 JVWSTAR: the stars
LA968:  JSR  VGDONE
LA96B:  RTS

;------------------------------------------------------------------------------
; vw_score_all - the score and status display that nearly every view calls first: vw_score_ladder then
;   vw_wave_left. takes the place of Star Wars' VWMES. saves X and U. Y-->VG list
;------------------------------------------------------------------------------
vw_score_all:
LA96C:  PSHS X,U
LA96E:  JSR  vw_score_ladder
LA971:  JSR  vw_wave_left
LA974:  PULS X,U,PC

;------------------------------------------------------------------------------
; vw_score_ladder - shows the scores at the top left, much changed from the first half of Star Wars' VWMES: in
;   red the high score entry the player has yet to beat with its rank ($4C72) and the top score with rank 1, in
;   green the player's own rank and score with a flashing box round it, and in yellow the amount last added while
;   SC_ADT runs (that part is Star Wars'). all lines use 8 digits and sit further left when the top score or the
;   player's score has reached 1,000,000. Y-->VG list
;------------------------------------------------------------------------------
vw_score_ladder:
LA976:  LDA  hs_top                 ;top two digits of the top high score
LA979:  ORA  >S_SC87                ;or of the player's score
LA97C:  STA  >sc_wide               ;non-zero: 8 digit lines, further left
LA97F:  BNE  LA986
LA981:  LDX  #ladder_pos_6dig
LA984:  BRA  LA989
LA986:  LDX  #ladder_pos_8dig
LA989:  LDA  rank_index             ;index of the high score entry still to beat
LA98C:  BLE  LA9EF                  ;0 or less: no separate line for it
LA98E:  LDD  #$6480                 ;red
LA991:  STD  ,Y++
LA993:  LDD  ,X++                   ;y and x of the line from the position table
LA995:  STD  ,Y++
LA997:  LDD  ,X++
LA999:  STD  ,Y++
LA99B:  LDD  #$7240
LA99E:  STD  ,Y++
LA9A0:  LDA  rank_index             ;its rank, index + 1, to BCD
LA9A3:  INCA
LA9A4:  LEAU ,X
LA9A6:  LDX  #$0008
LA9A9:  JSR  BINBCD_B0
LA9AC:  LEAX ,U
LA9AE:  LDA  bcd_lo                 ;BCD+2
LA9B1:  LDB  #$01
LA9B3:  STB  >BT_SUP
LA9B6:  JSR  VWBYTE
LA9B9:  LDD  #$B8E5                 ;JSRL to the period, then a blank
LA9BC:  STD  ,Y++
LA9BE:  LDD  VGMSGA
LA9C1:  STD  ,Y++
LA9C3:  LDB  rank_index             ;7 bytes an entry, the 4 BCD score bytes follow the 3 initials
LA9C6:  LDA  #$07
LA9C8:  MUL
LA9C9:  ADDD #$0003
LA9CC:  LDU  #INITLS
LA9CF:  LEAU D,U
LA9D1:  LDA  #$06
LA9D3:  STA  >BT_SUP
LA9D6:  LDA  >sc_wide
LA9D9:  BNE  LA9E2
LA9DB:  LEAU 1,U                    ;6 digits: skip the top byte
LA9DD:  JSR  view_6dig
LA9E0:  BRA  LA9E5
LA9E2:  JSR  view_8dig
LA9E5:  LDD  #$8040
LA9E8:  STD  ,Y++
LA9EA:  LDD  #$7200
LA9ED:  STD  ,Y++
LA9EF:  LDA  rank_index             ;minus: the player leads, no top score line
LA9F2:  BMI  LAA3A
LA9F4:  LDD  #$6480
LA9F7:  STD  ,Y++
LA9F9:  LDD  ,X++
LA9FB:  STD  ,Y++
LA9FD:  LDD  ,X++
LA9FF:  STD  ,Y++
LAA01:  LDD  #$7240
LAA04:  STD  ,Y++
LAA06:  LDA  #$01                   ;rank 1 (A is still 1 for VWBYTE)
LAA08:  STA  >BT_SUP
LAA0B:  JSR  VWBYTE
LAA0E:  LDD  #$B8E5
LAA11:  STD  ,Y++
LAA13:  LDD  VGMSGA
LAA16:  STD  ,Y++
LAA18:  LDA  #$06
LAA1A:  STA  >BT_SUP
LAA1D:  LDA  >sc_wide
LAA20:  BNE  LAA2A
LAA22:  LDU  #$4B43                 ;the top score, low 6 digits
LAA25:  JSR  view_6dig
LAA28:  BRA  LAA30
LAA2A:  LDU  #hs_top                ;the top score, 8 digits
LAA2D:  JSR  view_8dig
LAA30:  LDD  #$8040
LAA33:  STD  ,Y++
LAA35:  LDD  #$7200
LAA38:  STD  ,Y++
LAA3A:  LDD  #$6280                 ;green: the player's own line
LAA3D:  STD  ,Y++
LAA3F:  LDD  #$01B0                 ;y 432
LAA42:  STD  ,Y++
LAA44:  LDA  >sc_wide
LAA47:  BNE  LAA4E
LAA49:  LDD  #$1E68
LAA4C:  BRA  LAA51
LAA4E:  LDD  #$1E38
LAA51:  STD  ,Y++
LAA53:  LDD  #$7240
LAA56:  STD  ,Y++
LAA58:  LDA  rank_index
LAA5B:  BPL  LAA61
LAA5D:  LDA  #$01                   ;the player leads: rank 1
LAA5F:  BRA  LAA6C
LAA61:  ADDA #$02                   ;else rank = index of the entry still to beat + 2
LAA63:  LDX  #$0008
LAA66:  JSR  BINBCD_B0
LAA69:  LDA  bcd_lo
LAA6C:  CMPA #$26                   ;rank 26 (BCD): not in the table of 25 yet
LAA6E:  BCC  LAA7D
LAA70:  LDB  #$01
LAA72:  STB  >BT_SUP
LAA75:  JSR  VWBYTE
LAA78:  LDD  #$B8E5
LAA7B:  BRA  LAA84
LAA7D:  LDD  VGMSGA                 ;three blanks in place of the rank and its period
LAA80:  STD  ,Y++
LAA82:  STD  ,Y++
LAA84:  STD  ,Y++
LAA86:  LDD  VGMSGA
LAA89:  STD  ,Y++
LAA8B:  LDA  >sc_wide
LAA8E:  BNE  LAA9F
LAA90:  LEAU 1,U                    ;has no effect, U is loaded next
LAA92:  LDA  #$04
LAA94:  STA  >BT_SUP
LAA97:  LDU  #S_SC65
LAA9A:  JSR  view_6dig
LAA9D:  BRA  LAAAA
LAA9F:  LDA  #$06
LAAA1:  STA  >BT_SUP
LAAA4:  LDU  #S_SC87
LAAA7:  JSR  view_8dig
LAAAA:  LDD  #$8040                 ;centre
LAAAD:  STD  ,Y++
LAAAF:  LDD  #$7200                 ;normal scale
LAAB2:  STD  ,Y++
LAAB4:  LDD  $002A                  ;copy the medium flash colour instruction from vector RAM (VRMFL)
LAAB7:  STD  ,Y++
LAAB9:  LDD  #$01A8                 ;y 424: under the player's line
LAABC:  STD  ,Y++
LAABE:  LDA  >sc_wide
LAAC1:  BNE  LAACD
LAAC3:  LDD  #$1EA8
LAAC6:  STD  ,Y++
LAAC8:  LDD  #$BDEB                 ;JSRL to a box 120 wide, for 6 digits
LAACB:  BRA  LAAD5
LAACD:  LDD  #$1E76                 ;x -394 in the 8 digit layout
LAAD0:  STD  ,Y++
LAAD2:  LDD  #$BDF4                 ;JSRL to the wider box, for 8 digits
LAAD5:  STD  ,Y++
LAAD7:  LDD  #VGCNTR
LAADA:  STD  ,Y++
;SHOW LAST SCORE ADDED IN
LAADC:  LDB  SC_ADT                 ;TIMER
LAADF:  BEQ  LAB15                  ;IFNE  STILL VISIBLE, SHOW IT
LAAE1:  SUBB #$08
LAAE3:  CMPB #$20
LAAE5:  BHS  LAAE9                  ;IFLO
LAAE7:  LDB  #$00
LAAE9:  STB  SC_ADT                 ;USE TIMER FOR BRIGHTNESS
LAAEC:  LSRB
LAAED:  LDA  #(VGCOPC/$100)+VGCYLW
LAAEF:  STD  ,Y++
LAAF1:  LDD  #$0180                 ;Y POS
LAAF4:  STD  ,Y++
LAAF6:  LDD  #$1E80                 ;X POS
LAAF9:  STD  ,Y++
LAAFB:  LDD  #$7240                 ;scale of the score lines
LAAFE:  STD  ,Y++
LAB00:  LDA  #$07                   ;8 digits, 7 leading zeroes suppressed
LAB02:  STA  >BT_SUP
LAB05:  LDU  #sc_add_top            ;SC_ADD-1, as in Star Wars
LAB08:  JSR  view_8dig
LAB0B:  LDD  #$8040
LAB0E:  STD  ,Y++
LAB10:  LDD  #$7200
LAB13:  STD  ,Y++
LAB15:  RTS

ladder_pos_6dig:
LAB16:  .word $01E0, $1E68, $0210, $1E68 ;y and x of the two red lines, 6 digit layout: y 480, x -408 and y 528, x -408

ladder_pos_8dig:
LAB1E:  .word $01E0, $1E38, $0210, $1E38 ;the same for the 8 digit layout: x -456

;------------------------------------------------------------------------------
; vw_wave_left - shows the right hand status: WAVE (message $0E) and the BCD wave number, left out while Jedi
;   letters are held and their display is on, then a count of interrupts since the last call drawn beyond the
;   right screen limit, and for the probot, walker and TIE fighter waves the number of enemies still to shoot
;   ($4C53) followed by its name from enemy_name_msg. the number flashes red and white for 16 frames whenever it
;   changes. Y-->VG list
;------------------------------------------------------------------------------
vw_wave_left:
LAB26:  LDA  jedi_let               ;Jedi letters earned
LAB29:  ANDA #$0F
LAB2B:  BEQ  LAB32
LAB2D:  LDA  jedi_show              ;and their display on: no room for WAVE
LAB30:  BNE  LAB60
LAB32:  LDB  #$0E
LAB34:  JSR  do_message
LAB37:  LDD  #$6280                 ;green
LAB3A:  STD  ,Y++
LAB3C:  LDD  #$01EC                 ;y 492
LAB3F:  STD  ,Y++
LAB41:  LDD  #$0108                 ;x 264
LAB44:  STD  ,Y++
LAB46:  LDD  #$7100                 ;scale of the wave number
LAB49:  STD  ,Y++
LAB4B:  LDA  #$01                   ;ZERO SUPPRES TOP 1 DIGIT
LAB4D:  STA  >BT_SUP
LAB50:  LDA  wave_bcd               ;BCD wave number
LAB53:  JSR  VWBYTE
LAB56:  LDD  #VGSCAL                ;RESTORE NORMAL SCALE
LAB59:  STD  ,Y++
LAB5B:  LDD  #VGCNTR
LAB5E:  STD  ,Y++
LAB60:  LDD  #$01EC                 ;y 492
LAB63:  STD  ,Y++
LAB65:  LDD  #$0230                 ;x 560: beyond the right limit VGLIMR (480)
LAB68:  STD  ,Y++
LAB6A:  LDD  #$6480
LAB6D:  STD  ,Y++
LAB6F:  LDA  SWNEW                  ;interrupts since the last call - the IRQ increments SWNEW - shown as a number and cleared
LAB71:  CLR  SWNEW
LAB73:  LDX  #$0008
LAB76:  JSR  BINBCD_B0
LAB79:  LDA  bcd_lo
LAB7C:  JSR  VWBYTE
LAB7F:  LDD  #$8040
LAB82:  STD  ,Y++
LAB84:  LDA  wave_type              ;0 probots, 1 walkers, 2 TIE fighters, 3 asteroids
LAB87:  CMPA #$03
LAB89:  BGE  LABEF                  ;asteroids: no count
LAB8B:  LDB  bonus_left             ;enemies still to shoot
LAB8E:  CMPB left_shown             ;changed since the last frame?
LAB91:  BEQ  LAB9B
LAB93:  STB  left_shown
LAB96:  LDB  #$7F                   ;then flash the number: timer from $7F down by 8 a frame
LAB98:  STB  left_flash
LAB9B:  LDB  left_flash
LAB9E:  SUBB #$08
LABA0:  BGE  LABA3
LABA2:  CLRB
LABA3:  STB  left_flash
LABA6:  BEQ  LABB6
LABA8:  ADDB #$80                   ;the timer + $80 is the brightness
LABAA:  BITB #$08                   ;and its bit 3 picks red or white
LABAC:  BNE  LABB2
LABAE:  LDA  #$64
LABB0:  BRA  LABB4
LABB2:  LDA  #$67
LABB4:  BRA  LABB9
LABB6:  LDD  #$6480                 ;steady red
LABB9:  STD  ,Y++
LABBB:  LDD  #$0180                 ;y 384
LABBE:  STD  ,Y++
LABC0:  LDD  #$0120                 ;x 288
LABC3:  STD  ,Y++
LABC5:  LDA  #$01
LABC7:  STA  >BT_SUP
LABCA:  LDA  bonus_left             ;the count in decimal, leading zero suppressed
LABCD:  LDX  #$0008
LABD0:  JSR  BINBCD_B0
LABD3:  LDA  bcd_lo
LABD6:  JSR  VWBYTE
LABD9:  LDD  #$8040
LABDC:  STD  ,Y++
LABDE:  LDB  wave_type
LABE1:  CMPB #$05
LABE3:  BCS  LABE7
LABE5:  LDB  #$04
LABE7:  LDX  #enemy_name_msg        ;PROBOTS, WALKERS or TIES in the same colour
LABEA:  LDB  B,X
LABEC:  JSR  do_message_nc
LABEF:  RTS

enemy_name_msg:
LABF0:  .byte $0F, $10, $11, $12, $14 ;message numbers by wave_type: PROBOTS, WALKERS, TIES, blank, blank

;------------------------------------------------------------------------------
; lz_ground_hit - tests whether the lazar is sweeping the ground and sets up the splash. a point $4000 ahead at
;   half the lazar's screen position goes through math box program MS_S1UN on the scratch block, which turns it
;   from the player's view into universe coordinates, and if its z is below zero or below half the player's height
;   s1_tz while LZ_ON, LZ_HIT is set with splash type 3, a colour (white, or purple while the Jedi force is on)
;   and SP_LOC from the high byte of z. made from the first half of Star Wars' GRLZIN, which transposed the ship's
;   matrix and used MS_PSUB
;------------------------------------------------------------------------------
lz_ground_hit:
LABF5:  LDD  #$4000                 ;a point $4000 ahead
LABF8:  STD  M_X0
LABFB:  LDD  >LZ_RSX                ;at half the lazar's screen x
LABFE:  ASRA
LABFF:  RORB
LAC00:  STD  M_Y0
LAC03:  LDD  >LZ_RSY                ;and half its screen y
LAC06:  ASRA
LAC07:  RORB
LAC08:  STD  4+M_X0                 ;UP/DOWN VID Y IS MATH Z
LAC0B:  LDD  #MS_X0BC
LAC0E:  STD  M_BIC
LAC11:  LDA  #MS_S1UN
LAC13:  JSR  MGOWT
LAC16:  LDD  M_ZP                   ;z of the point in universe coordinates
LAC19:  BMI  LAC29                  ;below zero: on the ground
LAC1B:  CMPD s1_tz                  ;$509C: the player's height
LAC1F:  BGT  LAC79
LAC21:  ADDD M_ZP                   ;ground too when z is less than half the height
LAC24:  SUBD s1_tz
LAC27:  BPL  LAC79
LAC29:  LDA  >LZ_ON
LAC2C:  BEQ  LAC79
LAC2E:  LDA  #$FF
LAC30:  STA  >LZ_HIT
LAC33:  LDA  #$03                   ;splash type 3
LAC35:  STA  SP_TYP
LAC38:  LDA  jedi_on                ;Jedi force flag
LAC3B:  BNE  LAC41
LAC3D:  LDA  #$67                   ;off: white splash
LAC3F:  BRA  LAC54
LAC41:  LDD  jedi_time              ;force timer: under $60 the purple blinks to white on bit 3
LAC44:  CMPD #$0060
LAC48:  BCC  LAC4E
LAC4A:  ANDB #$08
LAC4C:  BNE  LAC52
LAC4E:  LDA  #$65                   ;purple
LAC50:  BRA  LAC54
LAC52:  LDA  #$67
LAC54:  LDB  #$80
LAC56:  STD  SP_COL
LAC59:  LDA  M_ZP                   ;high byte of z, taken as -1 when z is positive
LAC5C:  BLT  LAC60
LAC5E:  LDA  #$FF
LAC60:  CMPA #$C2                   ;no lower than -62
LAC62:  BGE  LAC66
LAC64:  LDA  #$C2
LAC66:  NEGA                        ;SP_LOC = 255 - 4 * the depth, kept within 1..$D0
LAC67:  ASLA
LAC68:  ASLA
LAC69:  COMA
LAC6A:  CMPA #$01
LAC6C:  BCC  LAC70
LAC6E:  LDA  #$01
LAC70:  CMPA #$D0
LAC72:  BLS  LAC76
LAC74:  LDA  #$D0
LAC76:  STA  SP_LOC
LAC79:  RTS

;------------------------------------------------------------------------------
; DO1GAS - WE MIGHT INC GAS  (comment at the call)
;   in ESB: takes one shield off S_GAS when a glow has been counted in GS_GLW and the last loss has finished,
;   starts the loss animation (GS_HIT, gs_fade), sends the shield effect (aud_cmd_3a) and, at the last shield
;   and at none, a speech that depends on wave_type
;------------------------------------------------------------------------------
DO1GAS:
LAC7A:  LDA  GS_GLW                 ;WHAT CAN WE LOSE?
LAC7C:  BLE  LACC3                  ;IFGT  ?SHIELDS HIT?
LAC7E:  LDA  GS_HIT
LAC80:  BGT  LACC3                  ;IFLE  ?AND DONE WITH PREVIOUS GAS CHANGE?
LAC82:  LDA  #$01                   ;the gauge animates the loss of a shield
LAC84:  STA  GS_HIT
LAC86:  DEC  S_GAS                  ;THEN DECREASE OUR FUEL
LAC88:  BGE  LAC90                  ;IFLT  ?OUT OF FUEL?
LAC8A:  LDA  #$FF
LAC8C:  STA  S_GAS                  ;SET TO DEAD
LAC8E:  CLR  GS_HIT                 ;NO ANIMATION CUZ FINAL MESSAGE ALREADY ON
LAC90:  JSR  aud_cmd_3a
LAC93:  LDA  S_GAS
LAC95:  CMPA #$00
LAC97:  BNE  LACA8
LAC99:  LDA  wave_type              ;speech only in the TIE fighter and asteroid waves
LAC9C:  CMPA #$02
LAC9E:  BCS  LACA6
LACA0:  JSR  spk_cmd_13
LACA3:  JSR  spk_cmd_21
LACA6:  BRA  LACBF
LACA8:  CMPA #$01
LACAA:  BNE  LACBB
LACAC:  LDA  wave_type              ;speech only in the probot and walker waves
LACAF:  CMPA #$02
LACB1:  BCC  LACB9
LACB3:  JSR  spk_cmd_13
LACB6:  JSR  spk_cmd_04
LACB9:  BRA  LACBF
LACBB:  CMPA #$02
LACBD:  BNE  LACBF
LACBF:  LDB  #$F0                   ;brightness the lost segment starts to fade from
LACC1:  STB  gs_fade
LACC3:  RTS

;------------------------------------------------------------------------------
; vw_gas_jedi - the views' entry to the shield gauge. while a hit is being animated (GS_HIT) it draws the gauge
;   part of VWGAS, with the Jedi force timer $4C50 at zero it is VWGAS, and while the force is on it draws
;   nothing, except that in the last $60 counts VWGAS blinks back in whenever bit 3 of the timer is set. Y-->VG
;   list
;------------------------------------------------------------------------------
vw_gas_jedi:
LACC4:  LDA  GS_HIT
LACC6:  BNE  LACFA
LACC8:  LDD  jedi_time              ;Jedi force timer
LACCB:  BEQ  VWGAS                  ;force off: the normal gauge
LACCD:  CMPD #$0060                 ;force on: no gauge until the last $60 counts
LACD1:  BCC  LACD7
LACD3:  ANDB #$08                   ;then it blinks on bit 3 of the timer
LACD5:  BNE  VWGAS
LACD7:  RTS

;------------------------------------------------------------------------------
; VWGAS - [note] View the gas gauge: VWGONE if S_GAS is gone and no hit is being handled; else color from TGCLR, title
;   VJFUEL, the gauge (GSVNEW while GS_HIT animates, else GSVALL) and the S_GAS numeral. Y-->VG list
;   in ESB: the shield display: SHIELDS GONE flashing when S_GAS is gone and no loss is being shown, else one
;   segment picture for each shield on either side of the top edge (shield_segs_left, shield_segs_right) in a
;   colour from shield_colors, the segment just lost fading, then the word SHIELDS and the number
;------------------------------------------------------------------------------
VWGAS:
LACD8:  LDA  GS_HIT
LACDA:  BNE  LACFA                  ;IFEQ  ?FINISHED HANDLING HIT?
LACDC:  LDA  S_GAS
LACDE:  BGT  LACFA                  ;IFLE  ?AND NO GAS LEFT?
LACE0:  LDD  #$7100                 ;large scale
LACE3:  STD  ,Y++
LACE5:  LDB  FRAMEL                 ;red, flashing brighter every 4 frames
LACE7:  ANDB #$04
LACE9:  BNE  LACF0
LACEB:  LDD  #$64E0
LACEE:  BRA  LACF3
LACF0:  LDD  #$6480
LACF3:  STD  ,Y++
LACF5:  LDB  #$0D                   ;SHIELDS GONE
LACF7:  JMP  do_message_nc
LACFA:  LDD  #$0210                 ;y 528: the top edge, where the gauge hangs
LACFD:  STD  ,Y++
LACFF:  LDD  #$0000
LAD02:  STD  ,Y++
LAD04:  LDX  #shield_segs_left      ;JSRLs to the left hand segments, outermost first
LAD07:  LDB  S_GAS
LAD09:  BLE  LAD1D
LAD0B:  STB  scratch_1
LAD0D:  LDU  #shield_colors         ;colour for this many shields: 1 red, 2 yellow, 3 and up green
LAD10:  ASLB
LAD11:  LDD  B,U
LAD13:  STD  ,Y++
LAD15:  LDD  ,X++                   ;one segment for each shield left
LAD17:  STD  ,Y++
LAD19:  DEC  scratch_1
LAD1B:  BNE  LAD15
LAD1D:  LDA  GS_HIT                 ;a shield just lost
LAD1F:  BEQ  LAD2A
LAD21:  LDD  shield_colors          ;entry 0: JSRL to the fading colour at $002E in vector RAM
LAD24:  STD  ,Y++
LAD26:  LDD  ,X                     ;then the segment that was lost
LAD28:  STD  ,Y++
LAD2A:  LDD  #$8040
LAD2D:  STD  ,Y++
LAD2F:  LDD  #$0210
LAD32:  STD  ,Y++
LAD34:  LDD  #$0000
LAD37:  STD  ,Y++
LAD39:  LDX  #shield_segs_right     ;the same for the right hand segments
LAD3C:  LDB  S_GAS
LAD3E:  BLE  LAD52
LAD40:  STB  scratch_1
LAD42:  LDU  #shield_colors
LAD45:  ASLB
LAD46:  LDD  B,U
LAD48:  STD  ,Y++
LAD4A:  LDD  ,X++
LAD4C:  STD  ,Y++
LAD4E:  DEC  scratch_1
LAD50:  BNE  LAD4A
LAD52:  LDA  GS_HIT
LAD54:  BEQ  LAD5F
LAD56:  LDD  shield_colors
LAD59:  STD  ,Y++
LAD5B:  LDD  ,X
LAD5D:  STD  ,Y++
LAD5F:  LDD  #$8040
LAD62:  STD  ,Y++
LAD64:  LDA  GS_HIT
LAD66:  BEQ  LAD6D
LAD68:  LDD  #$A015                 ;during the loss the title flashes (JSRL to VRMFL)
LAD6B:  STD  ,Y++
LAD6D:  LDB  #$0C                   ;SHIELDS, in the current colour
LAD6F:  JSR  do_message_nc
LAD72:  LDD  #$01C8                 ;y 456, x -8
LAD75:  STD  ,Y++
LAD77:  LDD  #$1FF8
LAD7A:  STD  ,Y++
LAD7C:  LDA  S_GAS                  ;the number of shields left
LAD7E:  JSR  VWBYT1
LAD81:  LDD  #$8040
LAD84:  STD  ,Y++
LAD86:  LDB  gs_fade                ;brightness of the lost segment, which the IRQ puts in the colour at $002E
LAD88:  BEQ  LAD9C
LAD8A:  LDA  FRAMEL
LAD8C:  ANDA #$00                   ;always zero: every frame
LAD8E:  BNE  LAD9C
LAD90:  LDA  gs_fade
LAD92:  SUBA #$08                   ;fade by 8 a frame
LAD94:  STA  gs_fade
LAD96:  BNE  LAD9C
LAD98:  STA  GS_HIT                 ;faded out: the loss is over, ready for the next hit
LAD9A:  STA  GS_GLW
LAD9C:  RTS

shield_colors:
LAD9D:  .word $A017                 ;JSRL $002E  colour word by shields left: 0 JSRL to the fading colour ($002E), 1 red, 2 yellow, 3-5 green
LAD9F:  .word $6480                 ;STAT colour 4, brightness $80
LADA1:  .word $6680                 ;STAT colour 6, brightness $80
LADA3:  .word $6280                 ;STAT colour 2, brightness $80
LADA5:  .word $6280                 ;STAT colour 2, brightness $80
LADA7:  .word $6280                 ;STAT colour 2, brightness $80

shield_segs_left:
LADA9:  .word (((vg_shld_l0-VGBASE)/2)&$1FFF)+$A000 ;JSRL vg_shld_l0  JSRLs to the five shield segment pictures left of centre (L3BFA up)
LADAB:  .word (((vg_shld_l1-VGBASE)/2)&$1FFF)+$A000 ;JSRL vg_shld_l1
LADAD:  .word (((vg_shld_l2-VGBASE)/2)&$1FFF)+$A000 ;JSRL vg_shld_l2
LADAF:  .word (((vg_shld_l3-VGBASE)/2)&$1FFF)+$A000 ;JSRL vg_shld_l3
LADB1:  .word (((vg_shld_l4-VGBASE)/2)&$1FFF)+$A000 ;JSRL vg_shld_l4

shield_segs_right:
LADB3:  .word (((vg_shld_r0-VGBASE)/2)&$1FFF)+$A000 ;JSRL vg_shld_r0  JSRLs to the five shield segment pictures right of centre (L3C54 up)
LADB5:  .word (((vg_shld_r1-VGBASE)/2)&$1FFF)+$A000 ;JSRL vg_shld_r1
LADB7:  .word (((vg_shld_r2-VGBASE)/2)&$1FFF)+$A000 ;JSRL vg_shld_r2
LADB9:  .word (((vg_shld_r3-VGBASE)/2)&$1FFF)+$A000 ;JSRL vg_shld_r3
LADBB:  .word (((vg_shld_r4-VGBASE)/2)&$1FFF)+$A000 ;JSRL vg_shld_r4

;------------------------------------------------------------------------------
; BG1GLW - GLOW--DO1GLW,VWGLW
;   BEGIN GLOWING
;------------------------------------------------------------------------------
BG1GLW:
LADBD:  LDA  GS_GLW
LADBF:  BNE  LADC7                  ;IFEQ  ?READY FOR ANOTHER HIT?
LADC1:  LDA  #$10                   ;FOR THIS LONG
LADC3:  STA  S_GLW
LADC5:  INC  GS_GLW                 ;TELL GAS THAT WE HAVE GLOWED ONCE MORE
LADC7:  RTS

;------------------------------------------------------------------------------
; KPGLOW - KEEP ON GLOWING, DONT TIME OUT OR STICK
;------------------------------------------------------------------------------
KPGLOW:
LADC8:  LDA  FRAMEL
LADCA:  ANDA #$03
LADCC:  STA  S_GLW
LADCE:  RTS

;------------------------------------------------------------------------------
; DO1QGLW - CUT GLOW DOWN TO SIZE
;------------------------------------------------------------------------------
DO1QGLW:
LADCF:  LDB  S_GLW
LADD1:  CMPB #$08                   ;NEED QUICK GLOW FOR TRENCH SEQUENCES
LADD3:  BLS  DO1GLW                 ;IFHI
LADD5:  LDB  #$08                   ;INSTEAD OF 10 FROM BG1GLW
LADD7:  STB  S_GLW

;------------------------------------------------------------------------------
; DO1GLW - [note] Count S_GLW (glowing from hit) down by one until it reaches zero; DO1QGLW falls into this
;------------------------------------------------------------------------------
DO1GLW:
LADD9:  LDB  S_GLW
LADDB:  BEQ  LADE0                  ;IFNE  NOT FINISHED YET
LADDD:  DECB
LADDE:  STB  S_GLW
LADE0:  RTS

;------------------------------------------------------------------------------
; DONGLW - GLOW THE ALIENS
;------------------------------------------------------------------------------
DONGLW:
LADE1:  LDA  FRAMEL
LADE3:  ANDA #$00
LADE5:  BNE  DONGLW_90
LADE7:  LDX  #ALIEN
LADEA:  DEC  7,X
LADEC:  BPL  DONGLW_30
LADEE:  CLR  7,X

DONGLW_30:
LADF0:  LEAX AS_IZE,X
LADF3:  CMPX #ALIENZ
LADF6:  BLO  LADEA

DONGLW_90:
LADF8:  RTS

;------------------------------------------------------------------------------
; VWGLW - VIEW GLOW IF WE ARE HIT
;------------------------------------------------------------------------------
VWGLW:
LADF9:  LDB  S_GLW
LADFB:  ANDB #$03                   ;MAKE IT FLASH
LADFD:  BEQ  LAE13                  ;IFNE
LADFF:  LDD  #VGSCAL-$100           ;SUPER LARGE TO BACKLIGHT SCREEN
LAE02:  STD  ,Y++
LAE04:  LDD  #(VGCOLR+(VGCWHT*$100))|$FF ;MAX WHITE
LAE07:  STD  ,Y++
LAE09:  LDD  #$B959                 ;BOX
LAE0C:  STD  ,Y++
LAE0E:  LDD  #VGSCAL                ;RESET SCALE
LAE11:  STD  ,Y++
LAE13:  RTS

man_op_tab:
LAE14:  .word man_op_end            ;script opcode routines, indexed by byte 2 of a record: 0 end, 1 message on, 2 message off, 3 store byte, 4 store word, 5 call, 6 nothing
LAE16:  .word man_op_messon
LAE18:  .word man_op_messoff
LAE1A:  .word man_op_poke_b
LAE1C:  .word man_op_poke_w
LAE1E:  .word man_op_call
LAE20:  .word man_op_nop

;------------------------------------------------------------------------------
; man_op_nop - training manual script opcode 6 and above: does nothing. reached through man_op_tab from the
;   interpreter LB189
;------------------------------------------------------------------------------
man_op_nop:
LAE22:  RTS

;------------------------------------------------------------------------------
; man_op_end - training manual script opcode 0, the last record of every script: sets $4CB8 to $FF, which makes
;   L7542 leave the page, and turns all messages off. reached through man_op_tab
;------------------------------------------------------------------------------
man_op_end:
LAE23:  LDA  #$FF
LAE25:  STA  man_done
LAE28:  JSR  ALLOFF
LAE2B:  RTS

;------------------------------------------------------------------------------
; man_op_messon - training manual script opcode 1: turns on the message whose number is byte 4 of the record
;   (MESSON). U-->record. reached through man_op_tab
;------------------------------------------------------------------------------
man_op_messon:
LAE2C:  LDB  >$0004,U
LAE30:  JMP  MESSON

;------------------------------------------------------------------------------
; man_op_messoff - training manual script opcode 2: turns off the message whose number is byte 4 of the record
;   (LCB21, the MESSOFF entry). U-->record. reached through man_op_tab
;------------------------------------------------------------------------------
man_op_messoff:
LAE33:  LDB  >$0004,U
LAE37:  JMP  MESSOFF

;------------------------------------------------------------------------------
; man_op_poke_b - training manual script opcode 3: stores byte 4 of the record at the RAM address in bytes 5-6.
;   the scripts use it to set the first byte of an object record. U-->record. reached through man_op_tab
;------------------------------------------------------------------------------
man_op_poke_b:
LAE3A:  LDD  >$0003,U
LAE3E:  STB  [>$0005,U]
LAE42:  RTS

;------------------------------------------------------------------------------
; man_op_poke_w - training manual script opcode 4: stores the word in bytes 3-4 of the record at the RAM address
;   in bytes 5-6. no script uses it. U-->record. reached through man_op_tab
;------------------------------------------------------------------------------
man_op_poke_w:
LAE43:  LDD  >$0003,U
LAE47:  STD  [>$0005,U]
LAE4B:  RTS

;------------------------------------------------------------------------------
; man_op_call - training manual script opcode 5: calls the routine whose address is in bytes 3-4 of the record
;   (LB14E, LB1CF, LB1D6, LB1E7, LB1EE, LB1FC, which is why the tracer found no caller for those) and keeps U.
;   reached through man_op_tab
;------------------------------------------------------------------------------
man_op_call:
LAE4C:  PSHS U
LAE4E:  JSR  [>$0003,U]
LAE52:  PULS U,PC

man_probot_1:
LAE54:  .byte $00, $00, $01, $00, $54, $00, $00, $00 ;training manual scripts, 8 byte records in time order. bytes 0-1 the frame (PH_TIM) at which the record is due, byte 2 the opcode 0-6 (7 and up count as 6), then for 1 and 2 the message number in byte 4, for 3 the value in byte 4 and a RAM address in bytes 5-6, for 4 a word in bytes 3-4 and a RAM address in bytes 5-6, for 5 a routine address in bytes 3-4, byte 7 unused. LB189 runs at most one record a frame from the pointer $4CB6, so records with the same time run on successive frames. LB169 holds the script addresses: four sections (wave_type) of three pages ($4CB5). this one is probots page 1: the probot's parts
LAE5C:  .byte $00, $30, $01, $00, $55, $00, $00, $00
LAE64:  .byte $00, $60, $02, $00, $55, $00, $00, $00
LAE6C:  .byte $00, $60, $01, $00, $56, $00, $00, $00
LAE74:  .byte $00, $90, $02, $00, $56, $00, $00, $00
LAE7C:  .byte $00, $95, $00, $00, $00, $00, $00, $00 ;frame $95: end of the page

man_probot_2:
LAE84:  .byte $00, $00, $01, $00, $57, $00, $00, $00 ;probots page 2: PROBOT WEAPONRY
LAE8C:  .byte $00, $30, $01, $00, $58, $00, $00, $00
LAE94:  .byte $00, $40, $05, $B1, $CF, $00, $00, $00 ;frame $40: call LB1CF
LAE9C:  .byte $00, $60, $02, $00, $58, $00, $00, $00
LAEA4:  .byte $00, $60, $01, $00, $59, $00, $00, $00
LAEAC:  .byte $00, $65, $03, $00, $04, $49, $D2, $00 ;store 4 in the first byte of the first alien record (ALIEN)
LAEB4:  .byte $00, $65, $03, $00, $00, $49, $E6, $00 ;store 0 at $49E6
LAEBC:  .byte $00, $90, $01, $00, $5B, $00, $00, $00
LAEC4:  .byte $00, $B5, $05, $B1, $D6, $00, $00, $00 ;frame $B5: call LB1D6
LAECC:  .byte $00, $F0, $02, $00, $5B, $00, $00, $00
LAED4:  .byte $00, $F8, $00, $00, $00, $00, $00, $00 ;end of the page

man_probot_3:
LAEDC:  .byte $00, $00, $01, $00, $5C, $00, $00, $00 ;probots page 3: PROBOT HIT ZONES
LAEE4:  .byte $00, $30, $01, $00, $5D, $00, $00, $00
LAEEC:  .byte $00, $60, $02, $00, $5D, $00, $00, $00
LAEF4:  .byte $00, $60, $01, $00, $5E, $00, $00, $00
LAEFC:  .byte $00, $90, $02, $00, $5E, $00, $00, $00
LAF04:  .byte $00, $95, $00, $00, $00, $00, $00, $00 ;end of the page

man_walker_1:
LAF0C:  .byte $00, $00, $01, $00, $5F, $00, $00, $00 ;walkers page 1: the AT-ST, then from frame $65 the AT-AT
LAF14:  .byte $00, $30, $01, $00, $60, $00, $00, $00
LAF1C:  .byte $00, $60, $02, $00, $60, $00, $00, $00
LAF24:  .byte $00, $65, $02, $00, $5F, $00, $00, $00
LAF2C:  .byte $00, $65, $03, $00, $00, $4A, $54, $00 ;store 0 in the first byte of the record at $4A54
LAF34:  .byte $00, $65, $05, $B1, $4E, $00, $00, $00 ;call LB14E
LAF3C:  .byte $00, $65, $01, $00, $65, $00, $00, $00
LAF44:  .byte $00, $95, $01, $00, $66, $00, $00, $00
LAF4C:  .byte $00, $C5, $02, $00, $66, $00, $00, $00
LAF54:  .byte $00, $D0, $00, $00, $00, $00, $00, $00 ;end of the page

man_walker_2:
LAF5C:  .byte $00, $00, $01, $00, $61, $00, $00, $00 ;walkers page 2: AT-ST WALKER WEAPONRY, then AT-AT WALKER WEAPONRY
LAF64:  .byte $00, $10, $01, $00, $62, $00, $00, $00
LAF6C:  .byte $00, $30, $05, $B1, $E7, $00, $00, $00 ;frame $30: call LB1E7
LAF74:  .byte $00, $60, $02, $00, $62, $00, $00, $00
LAF7C:  .byte $00, $65, $02, $00, $61, $00, $00, $00
LAF84:  .byte $00, $65, $03, $00, $00, $4A, $54, $00 ;store 0 in the first byte of the record at $4A54
LAF8C:  .byte $00, $65, $05, $B1, $4E, $00, $00, $00 ;call LB14E
LAF94:  .byte $00, $65, $01, $00, $67, $00, $00, $00
LAF9C:  .byte $00, $75, $01, $00, $68, $00, $00, $00
LAFA4:  .byte $00, $90, $05, $B1, $EE, $00, $00, $00 ;frame $90: call LB1EE
LAFAC:  .byte $00, $C5, $02, $00, $68, $00, $00, $00
LAFB4:  .byte $00, $D0, $00, $00, $00, $00, $00, $00 ;end of the page

man_walker_3:
LAFBC:  .byte $00, $00, $01, $00, $63, $00, $00, $00 ;walkers page 3: AT-ST WALKER HIT ZONES, then AT-AT WALKER HIT ZONES (ends at LB014)
LAFC4:  .byte $00, $30, $01, $00, $64, $00, $00, $00
LAFCC:  .byte $00, $60, $02, $00, $64, $00, $00, $00
LAFD4:  .byte $00, $65, $02, $00, $63, $00, $00, $00
LAFDC:  .byte $00, $65, $03, $00, $00, $4A, $54, $00 ;store 0 in the first byte of the record at $4A54
LAFE4:  .byte $00, $65, $05, $B1, $4E, $00, $00, $00 ;call LB14E
LAFEC:  .byte $00, $65, $01, $00, $69, $00, $00, $00
LAFF4:  .byte $00, $95, $01, $00, $6A, $00, $00, $00
LAFFC:  .byte $00, $C8, $02, $00, $6A, $00, $00, $00
LB004:  .byte $00, $D0, $01, $00, $6B, $00, $00, $00
LB00C:  .byte $01, $00, $02, $00, $6B, $00, $00, $00
LB014:  .byte $01, $05, $00, $00, $00, $00, $00, $00
LB01C:  .byte $00, $00, $01, $00, $6C, $00, $00, $00
LB024:  .byte $00, $30, $01, $00, $6D, $00, $00, $00
LB02C:  .byte $00, $90, $02, $00, $6D, $00, $00, $00
LB034:  .byte $00, $95, $00, $00, $00, $00, $00, $00
LB03C:  .byte $00, $00, $01, $00, $6E, $00, $00, $00
LB044:  .byte $00, $30, $01, $00, $6F, $00, $00, $00
LB04C:  .byte $00, $55, $05, $B1, $FC, $00, $00, $00
LB054:  .byte $00, $90, $02, $00, $6F, $00, $00, $00
LB05C:  .byte $00, $95, $00, $00, $00, $00, $00, $00
LB064:  .byte $00, $00, $01, $00, $70, $00, $00, $00
LB06C:  .byte $00, $30, $01, $00, $71, $00, $00, $00
LB074:  .byte $00, $90, $02, $00, $71, $00, $00, $00
LB07C:  .byte $00, $95, $00, $00, $00, $00, $00, $00
LB084:  .byte $00, $00, $01, $00, $72, $00, $00, $00
LB08C:  .byte $00, $30, $01, $00, $73, $00, $00, $00
LB094:  .byte $00, $90, $02, $00, $73, $00, $00, $00
LB09C:  .byte $00, $95, $00, $00, $00, $00, $00, $00
LB0A4:  .byte $00, $00, $01, $00, $74, $00, $00, $00
LB0AC:  .byte $00, $30, $01, $00, $75, $00, $00, $00
LB0B4:  .byte $00, $90, $02, $00, $75, $00, $00, $00
LB0BC:  .byte $00, $95, $00, $00, $00, $00, $00, $00
LB0C4:  .byte $00, $00, $01, $00, $76, $00, $00, $00
LB0CC:  .byte $00, $30, $01, $00, $77, $00, $00, $00
LB0D4:  .byte $00, $90, $02, $00, $77, $00, $00, $00
LB0DC:  .byte $00, $95, $00, $00, $00, $00, $00, $00

;------------------------------------------------------------------------------
; manual_page_init - starts one page of the rebel training manual, called by phi_manual. turns all messages off,
;   calls the set-up routine of section wave_type (0 probot, 1 walkers, 2 TIE fighter, 3 asteroids) from
;   manual_init_tab, then points the script pointer $4CB6 at the script of that section's page $4CB5, taken from
;   manual_script_tab
;------------------------------------------------------------------------------
manual_page_init:
LB0E4:  JSR  ALLOFF
LB0E7:  LDB  wave_type              ;section of the manual, 0-3: probot, walkers, TIE fighter, asteroids
LB0EA:  ASLB
LB0EB:  CMPB #$08                   ;a section past 3 is set up as section 0
LB0ED:  BCS  LB0F1
LB0EF:  LDB  #$00
LB0F1:  LDX  #manual_init_tab
LB0F4:  JSR  [B,X]                  ;the section's set-up routine
LB0F6:  LDB  wave_type
LB0F9:  ASLB
LB0FA:  LDX  #manual_script_tab
LB0FD:  LDX  B,X                    ;the section's list of three page scripts
LB0FF:  LDB  man_page               ;page within the section, 0-2
LB102:  ASLB
LB103:  LDX  B,X
LB105:  STX  man_script             ;the script starts here
LB108:  RTS

manual_init_tab:
LB109:  .word man_init_probot
LB10B:  .word man_init_walker
LB10D:  .word man_init_tie
LB10F:  .word man_init_asteroid

;------------------------------------------------------------------------------
; man_init_probot - manual set-up for section 0, the probot pages. sets the player's height to $0200, steps the
;   page number $4CB5 on (0, 1, 2, then 0 again - this is the only place the page changes, so each pass through
;   the four sections shows the next page of all of them), sets the demo probot up for that page (page 2 P2_86C7)
;   and clears the transmission records (page 3 P3_98D3)
;------------------------------------------------------------------------------
man_init_probot:
LB111:  LDD  #$0200                 ;player height for the probot pages
LB114:  STD  s1_tz                  ;this is MS_TZ+M_S1, the player's z
LB117:  LDB  man_page
LB11A:  INCB
LB11B:  CMPB #$03                   ;next page, and 0 after page 2
LB11D:  BCS  LB121
LB11F:  LDB  #$00
LB121:  STB  man_page
LB124:  JSR  MZ_825C                ;calls page 2 man_probot_setup
LB127:  LDB  man_page               ;B is not used by the routine called: it clears the three transmission records at $4A54
LB12A:  JSR  MZ_81AB                ;calls page 3 xmit_init
LB12D:  RTS

;------------------------------------------------------------------------------
; man_init_walker - manual set-up for section 1, the walker pages. turns the player half round (-1.0 in the A.X
;   and B.Y terms of the player's matrix), sets the height to $0800, sets the demo AT-ST up for page $4CB5 (page 1
;   P1_866F) and the demo AT-AT (page 0 P0_8674), then clears the AT-AT record's type byte so that only the AT-ST
;   shows until the script calls man_show_atat
;------------------------------------------------------------------------------
man_init_walker:
LB12E:  LDA  #$C0                   ;$C0 is -1.0 in the high byte: turn the player half round
LB130:  STA  s1_ax                  ;MS_AX+M_S1
LB133:  STA  s1_by                  ;the B.Y term of the player's matrix - phi_manual stores $40 in the same two bytes just before calling here
LB136:  LDD  #$0800                 ;player height for the AT-ST part of the walker pages
LB139:  STD  s1_tz
LB13C:  LDB  man_page               ;B = page: the demo AT-ST goes in the first record at $4A54
LB13F:  JSR  MZ_822F                ;calls page 1 man_atst_init
LB142:  LDB  man_page               ;B = page: the demo AT-AT goes in the first record at $4A87
LB145:  JSR  MZ_8391                ;calls page 0 atat_demo_init
LB148:  LDB  #$00                   ;but its type byte is cleared: no AT-AT until the script calls man_show_atat
LB14A:  STB  atat_rec
LB14D:  RTS

;------------------------------------------------------------------------------
; man_show_atat - called from the walker scripts (command 5 records at time $65 on all three walker pages, after
;   the AT-ST record has been cleared): raises the player to height $1800 and sets the demo AT-AT up again for
;   page $4CB5 (page 0 P0_8674). reached only through the script, hence no caller found
;------------------------------------------------------------------------------
man_show_atat:
LB14E:  LDD  #$1800                 ;player height for the AT-AT part of the walker pages
LB151:  STD  s1_tz
LB154:  LDB  man_page
LB157:  JSR  MZ_8391                ;calls page 0 atat_demo_init
LB15A:  RTS

;------------------------------------------------------------------------------
; man_init_tie - manual set-up for section 2, the TIE fighter pages: B = page $4CB5, page 3 P3_8613 sets the
;   alien records up
;------------------------------------------------------------------------------
man_init_tie:
LB15B:  LDB  man_page
LB15E:  JSR  MZ_8145                ;calls page 3 man_tie_setup
LB161:  RTS

;------------------------------------------------------------------------------
; man_init_asteroid - manual set-up for section 3, the asteroid pages: B = page $4CB5, page 2 P2_965E sets the
;   demo asteroid up in the records at ALIENZ
;------------------------------------------------------------------------------
man_init_asteroid:
LB162:  LDB  man_page
LB165:  JSR  MZ_841B                ;calls page 2 astrd_man_init
LB168:  RTS

manual_script_tab:
LB169:  .word man_scripts_probot
LB16B:  .word man_scripts_walker
LB16D:  .word man_scripts_tie
LB16F:  .word man_scripts_asteroid

man_scripts_probot:
LB171:  .word man_probot_1
LB173:  .word man_probot_2
LB175:  .word man_probot_3

man_scripts_walker:
LB177:  .word man_walker_1
LB179:  .word man_walker_2
LB17B:  .word man_walker_3

man_scripts_tie:
LB17D:  .word LB01C
LB17F:  .word LB03C
LB181:  .word LB064

man_scripts_asteroid:
LB183:  .word LB084
LB185:  .word LB0A4
LB187:  .word LB0C4

;------------------------------------------------------------------------------
; manual_run - the per-frame work of a manual page, called by the phase routine at L7542. if the time word of
;   the script record at $4CB6 has been reached by PH_TIM it runs the record's command (byte 2, 0-6, through the
;   table at LAE14, with U at the record: end of page, message on, message off, store byte, store word, call
;   routine, nothing) and steps the pointer on 8 bytes - one record a frame at most. then it calls the move
;   routine of section wave_type from manual_move_tab. the task text gives this as LB18A
;------------------------------------------------------------------------------
manual_run:
LB189:  PSHS X,U
LB18B:  CLR  >GS_GLW
LB18E:  LDU  man_script             ;next record of the page's script
LB191:  LDD  ,U                     ;the time it is due
LB193:  CMPD PH_TIM
LB197:  BHI  LB1AC                  ;not yet
LB199:  LDB  2,U                    ;command, 0-6
LB19B:  ASLB
LB19C:  CMPB #$0E
LB19E:  BCS  LB1A2                  ;anything above 6 does nothing
LB1A0:  LDB  #$0C
LB1A2:  LDX  #man_op_tab
LB1A5:  JSR  [B,X]                  ;run the command with U at the record
LB1A7:  LEAU 8,U                    ;8 bytes to a record
LB1A9:  STU  man_script
LB1AC:  LDB  wave_type
LB1AF:  ASLB
LB1B0:  CMPB #$08
LB1B2:  BCS  LB1B6
LB1B4:  LDB  #$00
LB1B6:  LDX  #manual_move_tab
LB1B9:  JSR  [B,X]                  ;the section's move routine
LB1BB:  PULS X,U,PC

manual_move_tab:
LB1BD:  .word man_move_probot
LB1BF:  .word man_move_walker
LB1C1:  .word man_move_tie
LB1C3:  .word man_move_asteroid

;------------------------------------------------------------------------------
; man_move_probot - per-frame movement for the probot pages of the manual: the probots (page 2 P2_877C), the gun
;   shots (page 1 P1_9185) and the transmissions (page 3 P3_9989)
;------------------------------------------------------------------------------
man_move_probot:
LB1C5:  JSR  MZ_837F                ;calls page 2 probots_move
LB1C8:  JSR  MZ_84CC                ;calls page 1 MVGUN
LB1CB:  JSR  MZ_843F                ;calls page 3 xmit_move_all
LB1CE:  RTS

;------------------------------------------------------------------------------
; man_probot_fire - called from the script of the probot weaponry page (command 5 record at $AE94, time $40):
;   makes the demo probot, the first alien record, fire a shot (page 1 P1_9063, which with the manual flag $4CB9
;   set fires at once from the first gun record). reached only through the script, hence no caller found
;------------------------------------------------------------------------------
man_probot_fire:
LB1CF:  LDU  #ALIEN
LB1D2:  JSR  MZ_8295                ;calls page 1 probot_fire; leaves page 2
LB1D5:  RTS

;------------------------------------------------------------------------------
; man_probot_xmit - called from the script of the probot weaponry page (command 5 record at $AEC4, time $B5):
;   makes the demo probot launch a transmission (page 3 P3_98E8, which takes a free transmission record). reached
;   only through the script, hence no caller found
;------------------------------------------------------------------------------
man_probot_xmit:
LB1D6:  LDU  #ALIEN
LB1D9:  JSR  MZ_83A3                ;calls page 3 xmit_launch
LB1DC:  RTS

;------------------------------------------------------------------------------
; man_move_walker - per-frame movement for the walker pages of the manual: the AT-STs (page 1 P1_86E1), the AT-
;   ATs (page 0 P0_8705) and the gun shots (page 1 P1_9185)
;------------------------------------------------------------------------------
man_move_walker:
LB1DD:  JSR  MZ_8514                ;calls page 1 atst_move_all
LB1E0:  JSR  MZ_847E                ;calls page 0 atat_move_all
LB1E3:  JSR  MZ_84CC                ;calls page 1 MVGUN
LB1E6:  RTS

;------------------------------------------------------------------------------
; man_atst_fire - called from the script of the AT-ST weaponry page (command 5 record at $AF6C, time $30): makes
;   the demo AT-ST, the first record at $4A54, fire a shot (page 1 P1_8FF7). reached only through the script,
;   hence no caller found
;------------------------------------------------------------------------------
man_atst_fire:
LB1E7:  LDU  #xmit_atst
LB1EA:  JSR  MZ_81C0                ;calls page 1 atst_fire; leaves page 1
LB1ED:  RTS

;------------------------------------------------------------------------------
; man_atat_fire - called from the script of the AT-AT weaponry part of the same page (command 5 record at $AFA4,
;   time $90): makes the demo AT-AT, the first record at $4A87, fire a shot (page 1 P1_8F8B). reached only through
;   the script, hence no caller found
;------------------------------------------------------------------------------
man_atat_fire:
LB1EE:  LDU  #atat_rec
LB1F1:  JSR  MZ_84F0                ;calls page 1 atat_fire; leaves page 0
LB1F4:  RTS

;------------------------------------------------------------------------------
; man_move_tie - per-frame movement for the TIE fighter pages of the manual: the computer drones (page 3 CPU)
;   and the gun shots (page 1 P1_9185)
;------------------------------------------------------------------------------
man_move_tie:
LB1F5:  JSR  MZ_8115                ;calls page 3 CPU
LB1F8:  JSR  MZ_84CC                ;calls page 1 MVGUN
LB1FB:  RTS

;------------------------------------------------------------------------------
; man_tie_fire - called from the script of the TIE fighter weaponry page (command 5 record at $B04C, time $55):
;   makes the demo TIE fighter, the first alien record, fire a shot from the first gun record (page 1 P1_8F16, X =
;   alien, U = gun). reached only through the script, hence no caller found
;------------------------------------------------------------------------------
man_tie_fire:
LB1FC:  LDX  #ALIEN
LB1FF:  LDU  #GUN
LB202:  JSR  MZ_857A                ;calls page 1 tie_fire; leaves page 3
LB205:  RTS

;------------------------------------------------------------------------------
; man_move_asteroid - per-frame movement for the asteroid pages of the manual: page 2 P2_96E0 moves and launches
;   the asteroids
;------------------------------------------------------------------------------
man_move_asteroid:
LB206:  JSR  MZ_84A8                ;calls page 2 astrd_move_all
LB209:  RTS

;------------------------------------------------------------------------------
; manual_view - draws a manual page, called by the view routine at LA697 with Y at the display list. turns on
;   message $53 (REBEL TRAINING MANUAL SECTION), views the messages, writes the section and page numbers after the
;   heading as n.n, then calls the view routine of section wave_type from manual_view_tab
;------------------------------------------------------------------------------
manual_view:
LB20A:  PSHS X
LB20C:  LDB  #$53                   ;message $53: REBEL TRAINING MANUAL SECTION
LB20E:  JSR  MESSON
LB211:  JSR  VWMESS

manual_view_num:
LB214:  LDD  #$6480                 ;red
LB217:  STD  ,Y++
LB219:  LDD  #$0150                 ;a blank move of y 336, x 348, to just after the heading
LB21C:  STD  ,Y++
LB21E:  LDD  #$015C
LB221:  STD  ,Y++
LB223:  LDA  wave_type              ;section number, shown as 1-4
LB226:  INCA
LB227:  JSR  VWBYT1
LB22A:  LDD  #$B8E5                 ;JSRL to the period, CH_PER in the vector ROM
LB22D:  STD  ,Y++
LB22F:  LDA  man_page               ;page number, shown as 1-3
LB232:  INCA
LB233:  JSR  VWBYT1
LB236:  LDD  #$8040                 ;centre
LB239:  STD  ,Y++
LB23B:  LDB  wave_type
LB23E:  ASLB
LB23F:  CMPB #$08
LB241:  BCS  LB245
LB243:  LDB  #$00
LB245:  LDX  #manual_view_tab
LB248:  JSR  [B,X]                  ;the section's view routine
LB24A:  PULS X,PC

manual_view_tab:
LB24C:  .word man_view_probot
LB24E:  .word man_view_walker
LB250:  .word man_view_tie
LB252:  .word man_view_asteroid

;------------------------------------------------------------------------------
; man_view_probot - view routine of the probot pages: the transmissions (page 3 P3_9B6D) and the probots (page 2
;   P2_8FB7)
;------------------------------------------------------------------------------
man_view_probot:
LB254:  JSR  MZ_8466                ;calls page 3 xmit_view_all
LB257:  JSR  MZ_8196                ;calls page 2 probots_view
LB25A:  RTS

;------------------------------------------------------------------------------
; man_view_walker - view routine of the walker pages: the AT-STs (page 1 P1_88FD) and the AT-ATs (page 0
;   P0_891A)
;------------------------------------------------------------------------------
man_view_walker:
LB25B:  JSR  MZ_8550                ;calls page 1 atst_view_all
LB25E:  JSR  MZ_832E                ;calls page 0 atat_view_all
LB261:  RTS

;------------------------------------------------------------------------------
; man_view_tie - view routine of the TIE fighter pages: views the alien ships (page 3 SNVW_P3)
;------------------------------------------------------------------------------
man_view_tie:
LB262:  JSR  MZ_81F9                ;calls page 3 SNVW
LB265:  RTS

;------------------------------------------------------------------------------
; man_view_asteroid - view routine of the asteroid pages: page 2 P2_9983 views the asteroid records
;------------------------------------------------------------------------------
man_view_asteroid:
LB266:  JSR  MZ_8526                ;calls page 2 astrd_view_all
LB269:  RTS

;------------------------------------------------------------------------------
; IPGEN - INIT GENERAL PARMS
;------------------------------------------------------------------------------
IPGEN:
LB26A:  LDA  P_RND1
LB26D:  SUBA P_RND1                 ;rev 2 patch: Atari's 22-JUN-83 source and rev 1 have CMPA here ($B1)
LB270:  BNE  IMATH                  ;IFEQ  ?# GENERATOR STUCK?
LB272:  STA  P_IRND                 ;INIT POLY COUNTER
LB275:  LDA  #$80                   ;START IT RUNNING
LB277:  STA  P_IRND

;------------------------------------------------------------------------------
; IMATH - RESTORE MATH BOX  (comment at the calls)
;------------------------------------------------------------------------------
IMATH:
LB27A:  LDD  #$0000
LB27D:  STD  M_ZRO
LB280:  LDD  #$4000
LB283:  STD  M_ONE                  ;CONSTANT '1'
LB286:  LDD  #$E000                 ;CONSTANT DIVIDE BY 2
LB289:  STD  M_HLF
LB28C:  LDD  #$0080                 ;ROUNDING CONSTANTS
LB28F:  STD  M_C80                  ;0080
LB292:  LDD  #$0040
LB295:  STD  M_C40                  ;0040
LB298:  LDD  #$021F                 ;SIN,COS ANGLES
LB29B:  STD  M_SINH                 ;FOR .895 DEGREES
LB29E:  LDD  #$3FF7
LB2A1:  STD  M_COS
LB2A4:  LDD  #$4000                 ;SCALE
LB2A7:  STD  M_SCL
LB2AA:  LDD  #$0200
LB2AD:  STD  M_DVN                  ;RECIPROCAL PERSPECTIVE
LB2B0:  RTS

;------------------------------------------------------------------------------
; asrd12 - arithmetic shift right of D by 12 bits, done as a byte move, sign extension and 4 shifts of B. first
;   of five such entries (12 to 8 bits) that ESB puts in front of Atari's ASRD7-ASRD1 chain. no call to any of the
;   five was found in either bank or the slapstic pages, they look like unused library code
;------------------------------------------------------------------------------
asrd12:
LB2B1:  TFR  A,B
LB2B3:  SEX
LB2B4:  ASRB
LB2B5:  ASRB
LB2B6:  ASRB
LB2B7:  ASRB
LB2B8:  RTS

;------------------------------------------------------------------------------
; asrd11 - arithmetic shift right of D by 11 bits: A to B, sign extend, 3 shifts of B. no caller found, unused
;   as far as can be seen
;------------------------------------------------------------------------------
asrd11:
LB2B9:  TFR  A,B
LB2BB:  SEX
LB2BC:  ASRB
LB2BD:  ASRB
LB2BE:  ASRB
LB2BF:  RTS

;------------------------------------------------------------------------------
; asrd10 - arithmetic shift right of D by 10 bits: A to B, sign extend, 2 shifts of B. no caller found, unused
;   as far as can be seen
;------------------------------------------------------------------------------
asrd10:
LB2C0:  TFR  A,B
LB2C2:  SEX
LB2C3:  ASRB
LB2C4:  ASRB
LB2C5:  RTS

;------------------------------------------------------------------------------
; asrd9 - arithmetic shift right of D by 9 bits: A to B, sign extend, 1 shift of B. no caller found, unused as
;   far as can be seen
;------------------------------------------------------------------------------
asrd9:
LB2C6:  TFR  A,B
LB2C8:  SEX
LB2C9:  ASRB
LB2CA:  RTS

;------------------------------------------------------------------------------
; asrd8 - arithmetic shift right of D by 8 bits: A to B and sign extend. replaces the Star Wars ASRD8, which
;   shifted eight times and fell into ASRD7. no caller found, unused as far as can be seen
;------------------------------------------------------------------------------
asrd8:
LB2CB:  TFR  A,B
LB2CD:  SEX
LB2CE:  RTS

;------------------------------------------------------------------------------
; ASRD7 - entry point: arithmetic shift D right 7 bits (falls through ASRD6..ASRD1 to the RTS at ASRD0)
;------------------------------------------------------------------------------
ASRD7:
LB2CF:  ASRA
LB2D0:  RORB

;------------------------------------------------------------------------------
; ASRD6 - [note] Entry point: arithmetic shift D right 6 bits (falls through ASRD5..ASRD1 to the RTS at ASRD0)
;------------------------------------------------------------------------------
ASRD6:
LB2D1:  ASRA
LB2D2:  RORB

;------------------------------------------------------------------------------
; ASRD5_B0 - [note] Entry point: arithmetic shift D right 5 bits (falls through ASRD4..ASRD1 to the RTS at ASRD0)
;------------------------------------------------------------------------------
ASRD5_B0:
LB2D3:  ASRA
LB2D4:  RORB

;------------------------------------------------------------------------------
; ASRD4_B0 - [note] Entry point: arithmetic shift D right 4 bits (falls through ASRD3..ASRD1 to the RTS at ASRD0)
;------------------------------------------------------------------------------
ASRD4_B0:
LB2D5:  ASRA
LB2D6:  RORB

;------------------------------------------------------------------------------
; ASRD3 - [note] Entry point: arithmetic shift D right 3 bits (falls through ASRD2, ASRD1 to the RTS at ASRD0)
;------------------------------------------------------------------------------
ASRD3:
LB2D7:  ASRA
LB2D8:  RORB

;------------------------------------------------------------------------------
; ASRD2 - entry point: arithmetic shift D right 2 bits (falls through ASRD1 to the RTS at ASRD0)
;------------------------------------------------------------------------------
ASRD2:
LB2D9:  ASRA
LB2DA:  RORB

;------------------------------------------------------------------------------
; ASRD1 - entry point: arithmetic shift D right 1 bit, then the RTS at ASRD0
;------------------------------------------------------------------------------
ASRD1:
LB2DB:  ASRA
LB2DC:  RORB

ASRD0:
LB2DD:  RTS

;------------------------------------------------------------------------------
; lsrd12 - logical shift right of D by 12 bits: A to B, clear A, 4 shifts of B. first of a logical shift right
;   library that Star Wars does not have: 12 to 8 bits as separate short routines, then a fall-through chain for 7
;   to 1 bits that starts in the bytes at LB2FC. only the 4 bit entry lsrd4 is called. no caller found for this
;   one
;------------------------------------------------------------------------------
lsrd12:
LB2DE:  TFR  A,B
LB2E0:  CLRA
LB2E1:  LSRB
LB2E2:  LSRB
LB2E3:  LSRB
LB2E4:  LSRB
LB2E5:  RTS

;------------------------------------------------------------------------------
; lsrd11 - logical shift right of D by 11 bits: A to B, clear A, 3 shifts of B. no caller found, unused as far
;   as can be seen
;------------------------------------------------------------------------------
lsrd11:
LB2E6:  TFR  A,B
LB2E8:  CLRA
LB2E9:  LSRB
LB2EA:  LSRB
LB2EB:  LSRB
LB2EC:  RTS

;------------------------------------------------------------------------------
; lsrd10 - logical shift right of D by 10 bits: A to B, clear A, 2 shifts of B. no caller found, unused as far
;   as can be seen
;------------------------------------------------------------------------------
lsrd10:
LB2ED:  TFR  A,B
LB2EF:  CLRA
LB2F0:  LSRB
LB2F1:  LSRB
LB2F2:  RTS

;------------------------------------------------------------------------------
; lsrd9 - logical shift right of D by 9 bits: A to B, clear A, 1 shift of B. no caller found, unused as far as
;   can be seen
;------------------------------------------------------------------------------
lsrd9:
LB2F3:  TFR  A,B
LB2F5:  CLRA
LB2F6:  LSRB
LB2F7:  RTS

;------------------------------------------------------------------------------
; lsrd8 - logical shift right of D by 8 bits: A to B, clear A. no caller found, unused as far as can be seen
;------------------------------------------------------------------------------
lsrd8:
LB2F8:  TFR  A,B
LB2FA:  CLRA
LB2FB:  RTS

;------------------------------------------------------------------------------
; lsrd7 - the 7-, 6- and 5-bit entries of the logical shift right family: three LSRA / RORB pairs that fall into
;   lsrd4. nothing calls them
;------------------------------------------------------------------------------
lsrd7:
LB2FC:  LSRA                        ;really code: LSRA RORB three times, the 7, 6 and 5 bit entries of the logical shift right chain that ends in lsrd4. nothing calls them
LB2FD:  RORB
LB2FE:  LSRA
LB2FF:  RORB
LB300:  LSRA
LB301:  RORB

;------------------------------------------------------------------------------
; lsrd4 - logical shift right of D by 4 bits, the one used entry of the logical shift chain (the 7, 6 and 5 bit
;   entries are the six bytes in front of it, shown as data). called by the AT-AT view code in slapstic page 0 to
;   turn a clamped distance into a brightness byte
;------------------------------------------------------------------------------
lsrd4:
LB302:  LSRA
LB303:  RORB
LB304:  LSRA
LB305:  RORB
LB306:  LSRA
LB307:  RORB
LB308:  LSRA
LB309:  RORB
LB30A:  RTS

;------------------------------------------------------------------------------
; lsld12 - shift D left 12 bits: B to A, clear B, 4 shifts of A. first of five such entries (12 to 8 bits) that
;   ESB puts in front of Atari's LSLD7-LSLD1 chain. no caller found, unused as far as can be seen
;------------------------------------------------------------------------------
lsld12:
LB30B:  TFR  B,A
LB30D:  CLRB
LB30E:  ASLA
LB30F:  ASLA
LB310:  ASLA
LB311:  ASLA
LB312:  RTS

;------------------------------------------------------------------------------
; lsld11 - shift D left 11 bits: B to A, clear B, 3 shifts of A. no caller found, unused as far as can be seen
;------------------------------------------------------------------------------
lsld11:
LB313:  TFR  B,A
LB315:  CLRB
LB316:  ASLA
LB317:  ASLA
LB318:  ASLA
LB319:  RTS

;------------------------------------------------------------------------------
; lsld10 - shift D left 10 bits: B to A, clear B, 2 shifts of A. no caller found, unused as far as can be seen
;------------------------------------------------------------------------------
lsld10:
LB31A:  TFR  B,A
LB31C:  CLRB
LB31D:  ASLA
LB31E:  ASLA
LB31F:  RTS

;------------------------------------------------------------------------------
; lsld9 - shift D left 9 bits: B to A, clear B, 1 shift of A. no caller found, unused as far as can be seen
;------------------------------------------------------------------------------
lsld9:
LB320:  TFR  B,A
LB322:  CLRB
LB323:  ASLA
LB324:  RTS

;------------------------------------------------------------------------------
; lsld8 - shift D left 8 bits: B to A and clear B. replaces the Star Wars LSLD8, which shifted eight times and
;   fell into LSLD7. no caller found, unused as far as can be seen
;------------------------------------------------------------------------------
lsld8:
LB325:  TFR  B,A
LB327:  CLRB
LB328:  RTS

;------------------------------------------------------------------------------
; LSLD7 - [note] Entry point: shift D left 7 bits (falls through LSLD6..LSLD1 to the RTS at LSLD0)
;------------------------------------------------------------------------------
LSLD7:
LB329:  LSLB
LB32A:  ROLA

LSLD6:
LB32B:  LSLB
LB32C:  ROLA

LSLD5:
LB32D:  LSLB
LB32E:  ROLA

;------------------------------------------------------------------------------
; LSLD4 - [note] Entry point: shift D left 4 bits (falls through LSLD3..LSLD1 to the RTS at LSLD0)
;------------------------------------------------------------------------------
LSLD4:
LB32F:  LSLB
LB330:  ROLA

;------------------------------------------------------------------------------
; LSLD3 - entry point: shift D left 3 bits (falls through LSLD2, LSLD1 to the RTS at LSLD0)
;------------------------------------------------------------------------------
LSLD3:
LB331:  LSLB
LB332:  ROLA

;------------------------------------------------------------------------------
; LSLD2_B0 - [note] Entry point: shift D left 2 bits (falls through LSLD1 to the RTS at LSLD0)
;------------------------------------------------------------------------------
LSLD2_B0:
LB333:  LSLB
LB334:  ROLA

LSLD1:
LB335:  LSLB
LB336:  ROLA

LSLD0:
LB337:  RTS

;------------------------------------------------------------------------------
; MGOWT - MATH SUBROUTINES
;   START THE MATH BOX, AND WAIT
;------------------------------------------------------------------------------
MGOWT:
LB338:  STA  M_PCGO

MWAIT:
MWAIT_10:
LB33B:  TST  M_BUSY                 ;SLOW BUT SAFE
LB33E:  BMI  MWAIT
LB340:  RTS

;------------------------------------------------------------------------------
; UNITV - SETUP UNIT VECTORS
;------------------------------------------------------------------------------
UNITV:
LB341:  LDD  #$0000
LB344:  STD  MS_VX,U                ;VELOCITY VECTORS
LB346:  STD  MS_VY,U
LB348:  STD  MS_VZ,U
LB34A:  STD  MS_TX,U                ;TRANSLATION COORDS
LB34C:  STD  MS_TY,U
LB34E:  STD  MS_TZ,U
;STD M$AX(U) ;IDENTITY MATRIX
LB350:  STD  MS_AY,U
LB352:  STD  MS_AZ,U
LB354:  STD  MS_BX,U
;STD M$BY(U)
LB356:  STD  MS_BZ,U
LB358:  STD  ,U                     ;MS_CX,U
LB35A:  STD  MS_CY,U
;STD M$CZ(U)
LB35C:  LDA  #$40                   ;IDENTITY VALUE FOR 1.
LB35E:  STD  MS_AX,U
LB360:  STD  MS_BY,U
LB362:  STD  MS_CZ,U
LB364:  RTS

;------------------------------------------------------------------------------
; tranu1_entry - the real entry of ESB's TRANU1: it saves U, which the transpose uses as its second scratch
;   register, and the code ends with PULS U,PC where Star Wars has RTS. the TRANU1 label two bytes further on
;   marks the part that matches Star Wars and must not be called by itself. no call to either address was found in
;   bank 0, so the routine looks unused here
;------------------------------------------------------------------------------
tranu1_entry:
LB365:  PSHS U

;------------------------------------------------------------------------------
; TRANU1 - TRANSPOSE U1 UNIT VECTORS
;------------------------------------------------------------------------------
TRANU1:
LB367:  LDD  (MS_AY+M_U1)&$FFFF
LB36A:  LDU  (MS_BX+M_U1)&$FFFF
LB36D:  STD  (MS_BX+M_U1)&$FFFF
LB370:  STU  (MS_AY+M_U1)&$FFFF
LB373:  LDD  (MS_AZ+M_U1)&$FFFF
LB376:  LDU  MS_CX+M_U1
LB379:  STD  MS_CX+M_U1
LB37C:  STU  (MS_AZ+M_U1)&$FFFF
LB37F:  LDD  (MS_BZ+M_U1)&$FFFF
LB382:  LDU  MS_CY+M_U1
LB385:  STD  MS_CY+M_U1
LB388:  STU  (MS_BZ+M_U1)&$FFFF
LB38B:  PULS U,PC

;------------------------------------------------------------------------------
; store_u1_block - copies the ship 1 download block of the math box ($5028-$5045: the nine matrix terms, the
;   three spare words and the position) into the unit vector block whose middle U points at - the reverse of the
;   download IS1UV starts. called by slapstic page 0 P0_95C3 with U = M_AL
;------------------------------------------------------------------------------
store_u1_block:
LB38D:  LDD  M_AX1
LB390:  STD  -16,U
LB392:  LDD  M_AY1
LB395:  STD  -14,U
LB397:  LDD  M_AZ1
LB39A:  STD  -12,U
LB39C:  LDD  M_BX1
LB39F:  STD  -8,U
LB3A1:  LDD  M_BY1
LB3A4:  STD  -6,U
LB3A6:  LDD  M_BZ1
LB3A9:  STD  -4,U
LB3AB:  LDD  M_CX1
LB3AE:  STD  ,U
LB3B0:  LDD  M_CY1
LB3B3:  STD  2,U
LB3B5:  LDD  M_CZ1
LB3B8:  STD  4,U
LB3BA:  LDD  M_XT1
LB3BD:  STD  8,U
LB3BF:  LDD  M_YT1
LB3C2:  STD  10,U
LB3C4:  LDD  M_ZT1
LB3C7:  STD  12,U
LB3C9:  LDD  m_vx1
LB3CC:  STD  -10,U
LB3CE:  LDD  m_vy1
LB3D1:  STD  -2,U
LB3D3:  LDD  m_vz1
LB3D6:  STD  6,U
LB3D8:  RTS

;------------------------------------------------------------------------------
; IS1UV - MATH BOX, PRIMARY INIT  (comment at the calls)
;   DOWNLOAD LATEST UNIT VECTOR  (another call)
;   DOWNLOAD VECTORS  (another call)
;------------------------------------------------------------------------------
IS1UV:
LB3D9:  STA  M_BICL
LB3DC:  CLR  M_BICH
LB3DF:  LDA  #MS_DLD1
LB3E1:  JSR  MGOWT
LB3E4:  RTS

;------------------------------------------------------------------------------
; IS2UV - DOWNLOAD SHIP 2 UNIT VECTORS  (comment at the call)
;   DOWNLOAD DESTINATION MATRIX  (another call)
;------------------------------------------------------------------------------
IS2UV:
LB3E5:  STA  M_BICL
LB3E8:  CLR  M_BICH
LB3EB:  LDA  #MS_DLD2
LB3ED:  JSR  MGOWT
LB3F0:  RTS

;------------------------------------------------------------------------------
; presub_via_u2 - runs the math box pre-subtract MS_PSB2 with ship 2's download block in the place of ship 1's:
;   swaps the two blocks, starts program $67 for the block index the caller left in M_BIC and waits, then swaps
;   the blocks back. called by the walker code in slapstic pages 0 and 1
;------------------------------------------------------------------------------
presub_via_u2:
LB3F1:  JSR  swap_u1_u2
LB3F4:  LDA  #$67                   ;MS_PSB2, the 15-bit pre-subtract, for the block index in M_BIC
LB3F6:  JSR  MGOWT
LB3F9:  JSR  swap_u1_u2
LB3FC:  RTS

;------------------------------------------------------------------------------
; swap_u1_u2 - exchanges the ship 1 download block ($5028-$5045) with the ship 2 block ($5048-$5065) word by
;   word: the nine matrix terms and the position, not the three spare words. U is saved and used as the second
;   scratch register. the three headers that follow are parts of this one routine
;------------------------------------------------------------------------------
swap_u1_u2:
LB3FD:  PSHS U
LB3FF:  LDD  M_AX1
LB402:  LDU  M_AX2
LB405:  STD  M_AX2
LB408:  STU  M_AX1

swap_u1_u2_b:
LB40B:  LDD  (MS_AY+M_U1)&$FFFF
LB40E:  LDU  M_AY2
LB411:  STD  M_AY2
LB414:  STU  (MS_AY+M_U1)&$FFFF
LB417:  LDD  (MS_AZ+M_U1)&$FFFF
LB41A:  LDU  M_AZ2
LB41D:  STD  M_AZ2
LB420:  STU  (MS_AZ+M_U1)&$FFFF
LB423:  LDD  M_BX1
LB426:  LDU  M_BX2
LB429:  STD  M_BX2
LB42C:  STU  M_BX1
LB42F:  LDD  M_BY1
LB432:  LDU  M_BY2
LB435:  STD  M_BY2
LB438:  STU  M_BY1
LB43B:  LDD  (MS_BZ+M_U1)&$FFFF
LB43E:  LDU  M_BZ2
LB441:  STD  M_BZ2
LB444:  STU  (MS_BZ+M_U1)&$FFFF
LB447:  LDD  M_CX1
LB44A:  LDU  M_CX2
LB44D:  STD  M_CX2
LB450:  STU  M_CX1

swap_u1_u2_c:
LB453:  LDD  M_CY1
LB456:  LDU  M_CY2
LB459:  STD  M_CY2
LB45C:  STU  M_CY1
LB45F:  LDD  M_CZ1
LB462:  LDU  M_CZ2
LB465:  STD  M_CZ2
LB468:  STU  M_CZ1

swap_u1_u2_d:
LB46B:  LDD  M_XT1
LB46E:  LDU  M_XT2
LB471:  STD  M_XT2
LB474:  STU  M_XT1
LB477:  LDD  M_YT1
LB47A:  LDU  M_YT2
LB47D:  STD  M_YT2
LB480:  STU  M_YT1
LB483:  LDD  M_ZT1
LB486:  LDU  M_ZT2
LB489:  STD  M_ZT2
LB48C:  STU  M_ZT1
LB48F:  PULS U,PC

;------------------------------------------------------------------------------
; S1RL - ROLL PLAYER SHIP
;------------------------------------------------------------------------------
S1RL:
LB491:  LDD  #MS_S1BC
LB494:  STD  M_BIC
LB497:  LDA  #MS_ROLL
LB499:  JMP  MGOWT                  ;RTS

;------------------------------------------------------------------------------
; S1PT - PITCH PLAYER SHIP
;------------------------------------------------------------------------------
S1PT:
LB49C:  LDD  #MS_S1BC
LB49F:  STD  M_BIC
LB4A2:  LDA  #MS_PTCH
LB4A4:  JMP  MGOWT                  ;RTS

;------------------------------------------------------------------------------
; S1YW - YAW PLAYER SHIP
;------------------------------------------------------------------------------
S1YW:
LB4A7:  LDD  #MS_S1BC
LB4AA:  STD  M_BIC
LB4AD:  LDA  #MS_YAW
LB4AF:  JMP  MGOWT                  ;RTS

;------------------------------------------------------------------------------
; roll_by_angle - rolls a unit vector block by an angle: B = angle (256 to the full turn), block index already
;   in M_BIC. sets M_SIN and M_COS from the sine table and runs math box program MS_ROLL, waiting for it
;------------------------------------------------------------------------------
roll_by_angle:
LB4B2:  JSR  set_sin_cos
LB4B5:  LDA  #$00                   ;MS_ROLL
LB4B7:  JMP  MGOWT

;------------------------------------------------------------------------------
; pitch_by_angle - pitches a unit vector block by an angle: B = angle (256 to the full turn), block index
;   already in M_BIC. sets M_SIN and M_COS from the sine table and runs math box program MS_PTCH, waiting for it
;------------------------------------------------------------------------------
pitch_by_angle:
LB4BA:  JSR  set_sin_cos
LB4BD:  LDA  #$0E                   ;MS_PTCH
LB4BF:  JMP  MGOWT

;------------------------------------------------------------------------------
; yaw_by_angle - yaws a unit vector block by an angle: B = angle (256 to the full turn), block index already in
;   M_BIC. sets M_SIN and M_COS from the sine table and runs math box program MS_YAW, waiting for it. the most
;   used of the three, called from all the enemy view code in the slapstic pages
;------------------------------------------------------------------------------
yaw_by_angle:
LB4C2:  JSR  set_sin_cos
LB4C5:  LDA  #$1C                   ;MS_YAW
LB4C7:  JMP  MGOWT

;------------------------------------------------------------------------------
; set_sin_cos - B = angle (256 to the full turn): writes its sine to M_SIN and its cosine to M_COS for the math
;   box rotate programs. the cosine is the sine of the angle plus $40. X is saved, D returns the cosine
;------------------------------------------------------------------------------
set_sin_cos:
LB4CA:  PSHS X
LB4CC:  STB  M_COS                  ;the angle is parked in the high byte of M_COS
LB4CF:  JSR  sine
LB4D2:  STD  M_SIN
LB4D5:  LDB  M_COS
LB4D8:  ADDB #$40                   ;a quarter turn on: the cosine
LB4DA:  JSR  sine
LB4DD:  STD  M_COS
LB4E0:  PULS X,PC

;------------------------------------------------------------------------------
; sine - B = angle (256 to the full turn), returns D = sine as a signed fraction with $4000 = 1.0. looks the
;   first quadrant up in the 65-word table sine_tab, reads the table backwards for the second quadrant and negates
;   the value for angles $80-$FF. uses X
;------------------------------------------------------------------------------
sine:
LB4E2:  LDX  #sine_tab
LB4E5:  BITB #$40                   ;second or fourth quadrant?
LB4E7:  BEQ  LB4EE
LB4E9:  EORB #$3F                   ;then count back from 90 degrees
LB4EB:  LDX  #sine_tab+2
LB4EE:  ASLB                        ;word index, and bit 7 of the angle goes to carry
LB4EF:  ANDB #$7F
LB4F1:  ABX
LB4F2:  BCC  LB4FB                  ;carry set, angle $80-$FF: the sine is negative
LB4F4:  LDD  #$0000
LB4F7:  SUBD ,X
LB4F9:  BRA  LB4FD
LB4FB:  LDD  ,X
LB4FD:  RTS

sine_tab:
LB4FE:  .word $0000                 ;sine table: 65 words, 0 to 90 degrees in steps of 1/256 turn, $4000 = 1.0
LB500:  .word $0192, $0324, $04B5, $0646
LB508:  .word $07D6, $0964, $0AF1, $0C7C
LB510:  .word $0E06, $0F8D, $1112, $1294
LB518:  .word $1413, $1590, $1709, $187E
LB520:  .word $19EF, $1B5D, $1CC6, $1E2B
LB528:  .word $1F8C, $20E7, $223D, $238E
LB530:  .word $24DA, $2620, $2760, $289A
LB538:  .word $29CE, $2AFB, $2C21, $2D41
LB540:  .word $2E5A, $2F6C, $3076, $3179
LB548:  .word $3274, $3368, $3453, $3537
LB550:  .word $3612, $36E5, $37AF, $3871
LB558:  .word $392B, $39DB, $3A82, $3B21
LB560:  .word $3BB6, $3C42, $3CC5, $3D3F
LB568:  .word $3DAF, $3E15, $3E72, $3EC5
LB570:  .word $3F0F, $3F4F, $3F85, $3FB1
LB578:  .word $3FD4, $3FEC, $3FFB, $4000

;------------------------------------------------------------------------------
; BINBCD_B0 - BIN TO BCD, BCD TO BIN, AND VIEW BYTES
;   CONVERT POSITIVE BINARY TO BCD
;   INPUT BINARY IN D, NUMBER OF SHIFTS IN X
;   OUTPUT IS BCD IN BCD,BCD+1,BCD+2
;------------------------------------------------------------------------------
BINBCD_B0:
LB580:  STD  BIN
LB583:  LDD  #$0000
LB586:  STD  BCD
LB589:  STA  BCD+2
LB58C:  ASL  BIN+1
LB58F:  ROL  BIN
LB592:  LDA  BCD+2
LB595:  ADCA BCD+2
LB598:  DAA
LB599:  STA  BCD+2
LB59C:  LDA  BCD+1
LB59F:  ADCA BCD+1
LB5A2:  DAA
LB5A3:  STA  BCD+1
LB5A6:  ROL  BCD
LB5A9:  LEAX -$1,X
LB5AB:  BNE  LB58C                  ;EQEND
LB5AD:  RTS

;------------------------------------------------------------------------------
; BCDBIN - CONVERT 2 POSITIVE BCD DIGITS TO BINARY
;   INPUT A, OUTPUT BIN
;------------------------------------------------------------------------------
BCDBIN:
LB5AE:  STA  BIN
LB5B1:  ANDA #$F0                   ;USE FIRST NYBBLE
LB5B3:  LDB  #$A0
LB5B5:  MUL                         ;ACC A CONTAINS FIRST DIGIT*10.
LB5B6:  LDB  BIN
LB5B9:  ANDB #$0F
LB5BB:  STB  BIN
LB5BE:  ADDA BIN
LB5C1:  STA  BIN
LB5C4:  RTS

;------------------------------------------------------------------------------
; rnd_set - ESB's form of the Star Wars RND8 (random number set): moves RND_S1 and RND_S2 down to RND_S3 and the
;   byte after it, then reads two new bytes from the pokey random register P_RND1 into RND_S2 and RND_S1. called
;   all over the slapstic pages before a routine that wants random bytes
;------------------------------------------------------------------------------
rnd_set:
LB5C5:  LDD  RND_S1                 ;the last two bytes move down to RND_S3 and $4855
LB5C7:  STD  RND_S3
LB5C9:  LDA  P_RND1                 ;two new random bytes
LB5CC:  STA  RND_S2
LB5CE:  LDA  P_RND1
LB5D1:  STA  RND_S1
LB5D3:  RTS

;------------------------------------------------------------------------------
; scr_level_bonus - adds the bonus for the level the game was started at, called once at frame $40 of the wave
;   completed phase when $4C62 is set. GM_WAV 0 (easy) adds nothing, 1 adds 100000, 2 adds 250000 (the table at
;   $B724, messages $4F-$51), 3 and up (continued play, message $52) adds the 8-digit bcd bonus carried over at
;   $4BEF and shows it as the amount being added
;------------------------------------------------------------------------------
scr_level_bonus:
LB5D4:  LDB  GM_WAV                 ;level the game was started at
LB5D7:  BEQ  LB619                  ;0, the easy start: no bonus
LB5D9:  CMPB #$03                   ;3 and up is continued play
LB5DB:  BCC  LB5E8
LB5DD:  LDA  #$03
LB5DF:  MUL
LB5E0:  ADDD #$B724                 ;3-byte entries at $B724: nothing, 100000 for level 1, 250000 for level 2
LB5E3:  JSR  ADUSCR
LB5E6:  BRA  LB619
LB5E8:  LDA  cont_bonus_3           ;continued play: add the four bcd bytes carried over at $4BEF, as ADUSCR does for three
LB5EB:  STA  SC_ADD+2               ;DISPLAY OUR NEW ADDITION
LB5EE:  ADDA S_SC21
LB5F0:  DAA
LB5F1:  STA  S_SC21
LB5F3:  LDA  cont_bonus_2
LB5F6:  STA  SC_ADD+1
LB5F9:  ADCA S_SC43
LB5FB:  DAA
LB5FC:  STA  S_SC43
LB5FE:  LDA  cont_bonus_1
LB601:  STA  SC_ADD+0
LB604:  ADCA S_SC65
LB606:  DAA
LB607:  STA  S_SC65
LB609:  LDA  cont_bonus             ;the top two digits
LB60C:  STA  sc_add_top
LB60F:  ADCA S_SC87
LB611:  DAA
LB612:  STA  S_SC87
LB614:  LDA  #$FF
LB616:  STA  SC_ADT                 ;NEW TIMER FOR NEW ADDITION
LB619:  RTS

;------------------------------------------------------------------------------
; scr_legs_bonus - the progressive bonus for flying through an AT-AT's legs, called by slapstic page 0 P0_87DD
;   when the player passes under a walker. adds 5000 to the 3-byte bcd bonus at $4CBF unless it has reached
;   900000, adds the bonus to the score, starts the 20-frame display timer $4CDF and a sound (LC657)
;------------------------------------------------------------------------------
scr_legs_bonus:
LB61A:  PSHS X,U
LB61C:  LDX  #legs_bonus
LB61F:  LDU  #LB71E                 ;the 5000 step
LB622:  LDD  ,X
LB624:  CMPD #$9000                 ;at 900000 the bonus stops growing
LB628:  BCC  LB63F
LB62A:  LDA  2,X
LB62C:  ADDA 2,U
LB62E:  DAA
LB62F:  STA  2,X
LB631:  LDA  1,X
LB633:  ADCA 1,U
LB635:  DAA
LB636:  STA  1,X
LB638:  LDA  ,X
LB63A:  ADCA ,U
LB63C:  DAA
LB63D:  STA  ,X
LB63F:  LDD  #$4CBF                 ;add the bonus to the score
LB642:  BSR  ADUSCR
LB644:  LDA  #$14                   ;show it for 20 frames
LB646:  STA  legs_bon_tmr
LB649:  JSR  aud_cmd_4c
LB64C:  PULS X,U,PC

;------------------------------------------------------------------------------
; scr_shot_3 - score 3 points: an enemy shot destroyed by the player's laser, for a shot whose type byte has bit
;   6 clear (slapstic page 1 P1_92E8 and PTHTBG)
;------------------------------------------------------------------------------
scr_shot_3:
LB64E:  LDD  #$B6E5
LB651:  BRA  ADUSCR

;------------------------------------------------------------------------------
; scr_shot_7 - score 7 points: an enemy shot destroyed by the player's laser, for a shot whose type byte has bit
;   6 set, as the AT-AT's shots have (slapstic page 1 P1_92E3 and PTHTBG)
;------------------------------------------------------------------------------
scr_shot_7:
LB653:  LDD  #$B6E8
LB656:  BRA  ADUSCR

;------------------------------------------------------------------------------
; scr_xmit_5 - score 5 points: called by slapstic page 3 P3_9CF2 when the laser hits a probot transmission
;   record
;------------------------------------------------------------------------------
scr_xmit_5:
LB658:  LDD  #$B6EB
LB65B:  BRA  ADUSCR

;------------------------------------------------------------------------------
; scr_wave_done - score 2500 points for completing a wave (message $4E, WAVE COMPLETED: 2,500 POINTS), called
;   when the wave completed phase starts at L723E
;------------------------------------------------------------------------------
scr_wave_done:
LB65D:  LDD  #$B71B
LB660:  BRA  ADUSCR

;------------------------------------------------------------------------------
; scr_jedi - score 20000 points: called by slapstic page 1 P1_95E8 when the letter bits at $4C80 reach $0F, all
;   four letters of JEDI
;------------------------------------------------------------------------------
scr_jedi:
LB662:  LDD  #$B721
LB665:  BRA  ADUSCR

;------------------------------------------------------------------------------
; scr_probot_25 - score 25 points for a probot shot down while the kill counter $4C53 is not yet zero (slapstic
;   page 2 P2_92EE)
;------------------------------------------------------------------------------
scr_probot_25:
LB667:  LDD  #$B6EE
LB66A:  BRA  ADUSCR

;------------------------------------------------------------------------------
; scr_probot_250 - score 250 points for a probot shot down once the kill counter $4C53 has run out (slapstic
;   page 2 P2_92EE)
;------------------------------------------------------------------------------
scr_probot_250:
LB66C:  LDD  #$B6F1
LB66F:  BRA  ADUSCR

;------------------------------------------------------------------------------
; scr_probot_quota - score 5000 points when a probot kill brings the counter $4C53 down to zero (slapstic page 2
;   P2_9341, which then calls the letter award on page 1)
;------------------------------------------------------------------------------
scr_probot_quota:
LB671:  LDD  #$B6F4
LB674:  BRA  ADUSCR

;------------------------------------------------------------------------------
; scr_atst_50 - score 50 points for an AT-ST destroyed while the kill counter $4C53 is not yet zero (slapstic
;   page 1 P1_8E33)
;------------------------------------------------------------------------------
scr_atst_50:
LB676:  LDD  #$B6F7
LB679:  BRA  ADUSCR

;------------------------------------------------------------------------------
; scr_atst_500 - score 500 points for an AT-ST destroyed once the kill counter $4C53 has run out (slapstic page
;   1 P1_8E33)
;------------------------------------------------------------------------------
scr_atst_500:
LB67B:  LDD  #$B6FA
LB67E:  BRA  ADUSCR

;------------------------------------------------------------------------------
; scr_atat_75 - score 75 points for an AT-AT destroyed, by laser or by tow cable, while the kill counter $4C53
;   is not yet zero (slapstic page 0 P0_9034 and P0_90C1)
;------------------------------------------------------------------------------
scr_atat_75:
LB680:  LDD  #$B6FD
LB683:  BRA  ADUSCR

;------------------------------------------------------------------------------
; scr_atat_750 - score 750 points for an AT-AT destroyed once the kill counter $4C53 has run out (slapstic page
;   0 P0_9047 and P0_90D4)
;------------------------------------------------------------------------------
scr_atat_750:
LB685:  LDD  #$B700
LB688:  BRA  ADUSCR

;------------------------------------------------------------------------------
; scr_walker_quota - score 5000 points when a walker kill, AT-ST or AT-AT, brings the counter $4C53 down to zero
;   (slapstic pages 0 and 1, which then call the letter award on page 1)
;------------------------------------------------------------------------------
scr_walker_quota:
LB68A:  LDD  #$B703
LB68D:  BRA  ADUSCR

;------------------------------------------------------------------------------
; scr_tie_100 - score 100 points for a TIE fighter destroyed while the kill counter $4C53 is not yet zero (XPSA
;   in slapstic page 3)
;------------------------------------------------------------------------------
scr_tie_100:
LB68F:  LDD  #$B706
LB692:  BRA  ADUSCR

;------------------------------------------------------------------------------
; scr_tie_1000 - score 1000 points for a TIE fighter destroyed once the kill counter $4C53 has run out (XPSA in
;   slapstic page 3)
;------------------------------------------------------------------------------
scr_tie_1000:
LB694:  LDD  #$B709
LB697:  BRA  ADUSCR

;------------------------------------------------------------------------------
; scr_tie_quota - score 5000 points when a TIE fighter kill brings the counter $4C53 down to zero (XPSA in
;   slapstic page 3). four more routines of the same shape follow in the bytes at LB69E, shown as data and not
;   called
;------------------------------------------------------------------------------
scr_tie_quota:
LB699:  LDD  #$B70C
LB69C:  BRA  ADUSCR

;------------------------------------------------------------------------------
; scr_10 - add 10 points: D = address of the 3-byte BCD value, then the common tail that goes to ADUSCR. no
;   caller found in any listing
;------------------------------------------------------------------------------
scr_10:
LB69E:  LDD  #$B70F                 ;really code, never called as far as can be seen: four more score routines, LDD #$B70F, #$B712, #$B715, #$B718 each followed by BRA ADUSCR - 10, 100, 1000 and 5000 points
LB6A1:  BRA  ADUSCR

;------------------------------------------------------------------------------
; scr_100 - add 100 points, as scr_10. no caller found
;------------------------------------------------------------------------------
scr_100:
LB6A3:  LDD  #$B712
LB6A6:  BRA  ADUSCR

;------------------------------------------------------------------------------
; scr_1000 - add 1,000 points, as scr_10. no caller found
;------------------------------------------------------------------------------
scr_1000:
LB6A8:  LDD  #$B715
LB6AB:  BRA  ADUSCR

;------------------------------------------------------------------------------
; scr_5000 - add 5,000 points, as scr_10. no caller found
;------------------------------------------------------------------------------
scr_5000:
LB6AD:  LDD  #$B718
LB6B0:  BRA  ADUSCR

;------------------------------------------------------------------------------
; ADUSCR - ADD FROM U PTR TO SCORE, USES A REGISTER
;------------------------------------------------------------------------------
ADUSCR:
LB6B2:  PSHS U
LB6B4:  TFR  D,U                    ;ESB passes the address of the three bcd bytes in D, where Star Wars passed it in U
LB6B6:  LDA  2,U
LB6B8:  STA  SC_ADD+2               ;DISPLAY OUR NEW ADDITION
LB6BB:  ADDA S_SC21
LB6BD:  DAA
LB6BE:  STA  S_SC21
LB6C0:  LDA  1,U
LB6C2:  STA  SC_ADD+1
LB6C5:  ADCA S_SC43
LB6C7:  DAA
LB6C8:  STA  S_SC43
LB6CA:  LDA  ,U
LB6CC:  STA  SC_ADD+0
LB6CF:  ADCA S_SC65
LB6D1:  DAA
LB6D2:  STA  S_SC65
LB6D4:  LDA  #$00                   ;a 6-digit amount: clear the top two digits of the amount shown
LB6D6:  STA  sc_add_top
LB6D9:  ADCA S_SC87
LB6DB:  DAA
LB6DC:  STA  S_SC87
LB6DE:  LDA  #$FF
LB6E0:  STA  SC_ADT                 ;NEW TIMER FOR NEW ADDITION
LB6E3:  PULS U,PC

score_values:
LB6E5:  .byte $00, $00, $03         ;3: scr_shot_3
LB6E8:  .byte $00, $00, $07         ;7: scr_shot_7
LB6EB:  .byte $00, $00, $05         ;5: scr_xmit_5
LB6EE:  .byte $00, $00, $25         ;25: scr_probot_25
LB6F1:  .byte $00, $02, $50         ;250: scr_probot_250
LB6F4:  .byte $00, $50, $00         ;5000: scr_probot_quota
LB6F7:  .byte $00, $00, $50         ;50: scr_atst_50
LB6FA:  .byte $00, $05, $00         ;500: scr_atst_500
LB6FD:  .byte $00, $00, $75         ;75: scr_atat_75
LB700:  .byte $00, $07, $50         ;750: scr_atat_750
LB703:  .byte $00, $50, $00         ;5000: scr_walker_quota
LB706:  .byte $00, $01, $00         ;100: scr_tie_100
LB709:  .byte $00, $10, $00         ;1000: scr_tie_1000
LB70C:  .byte $00, $50, $00         ;5000: scr_tie_quota. then 10, 100 and the first byte of 1000 for the uncalled routines at LB69E
LB70F:  .byte $00, $00, $10
LB712:  .byte $00, $01, $00
LB715:  .byte $00, $10, $00
LB718:  .byte $00, $50, $00
LB71B:  .byte $00, $25, $00         ;2500: scr_wave_done
LB71E:  .byte $00, $50, $00         ;5000: the step of the legs bonus
LB721:  .byte $02, $00, $00, $00, $00, $00, $10, $00 ;20000: scr_jedi. then from $B724 the level bonus of scr_level_bonus: 0, 100000, 250000
LB729:  .byte $00, $25, $00, $00

;------------------------------------------------------------------------------
; VWSITE - Star Wars' VWSITE with view_cockpit in the place of VWPLAN: the cursor in its normal colour (VWCURS),
;   then the cockpit. Y = display list
;------------------------------------------------------------------------------
VWSITE:
LB72D:  JSR  VWCURS
LB730:  JSR  view_cockpit
LB733:  RTS

;------------------------------------------------------------------------------
; VWSITC - Star Wars' VWSITC likewise: the cursor without a colour instruction (VWCURC), then the cockpit. no
;   caller found
;------------------------------------------------------------------------------
VWSITC:
LB734:  JSR  VWCURC
LB737:  JSR  view_cockpit
LB73A:  RTS

;------------------------------------------------------------------------------
; VWCURS - ---VIEW CURSOR WITH ITS NORMAL COLOR
;------------------------------------------------------------------------------
VWCURS:
LB73B:  LDD  #$63C0                 ;SITE COLOR
LB73E:  STD  ,Y++                   ;COLOR BRITE

;------------------------------------------------------------------------------
; VWCURC - VIEW CURSOR WITH YOUR OWN COLOR
;------------------------------------------------------------------------------
VWCURC:
LB740:  LDD  #$A00A                 ;JOY MOVES CURSOR
LB743:  STD  ,Y++
LB745:  LDD  #$B97B
LB748:  STD  ,Y++
LB74A:  RTS

;------------------------------------------------------------------------------
; view_cockpit - draws the parts of the player's craft that show on the screen, ESB's replacement for the body
;   of Star Wars VWPLAN, called by VWSITE and VWSITC with Y at the display list. takes the list for craft type
;   $4C60 (0 or 1) from cockpit_lists and calls the four routines it names in turn: x shift, y shift, write the
;   two positions, write colour and pictures. each list ends with the two picture words, which the fourth routine
;   reads through X
;------------------------------------------------------------------------------
view_cockpit:
LB74B:  PSHS X,U
LB74D:  LDX  #cockpit_lists         ;the two cockpit lists
LB750:  LDB  craft_type             ;craft type, 0 or 1
LB753:  ASLB
LB754:  CMPB #$04
LB756:  BCS  LB75A
LB758:  LDB  #$00
LB75A:  ABX
LB75B:  LDX  ,X                     ;the list: four routine addresses and two picture words
LB75D:  JSR  [,X++]
LB75F:  JSR  [,X++]
LB761:  JSR  [,X++]
LB763:  JSR  [,X++]                 ;this one reads the two picture words through X
LB765:  PULS X,U,PC

;------------------------------------------------------------------------------
; VWPLAN - VIEW PARTS OF X-WING VISIBLE TO PLAYER
;   in ESB: only the first part of Star Wars' VWPLAN is left: the sideways shift of the cockpit from the
;   sight's x, stored in LZ_GX and returned in U as the x word of a position vector. it is the first step of
;   the cockpit list for craft type 0
;------------------------------------------------------------------------------
VWPLAN:
LB767:  LDA  SI_RSX                 ;SHIFT PLAYERS HOOD VIA CONTROLS
LB769:  BPL  LB76C                  ;IFMI
LB76B:  NEGA                        ;ABSOLUTE VALUE
LB76C:  LDB  #$6E                   ;ALLOW +-5.5 GRIDS MOVEMENT, *2 COMPENSATES FOR MUL
LB76E:  MUL
LB76F:  LDB  SI_RSX
LB771:  BPL  LB774                  ;IFMI
LB773:  NEGA                        ;RESTORE SIGN
LB774:  TFR  A,B
LB776:  SEX
LB777:  STD  LZ_GX                  ;X DISTANCE OF SITE
LB77A:  ANDA #$1F                   ;NO BRITE
LB77C:  TFR  D,U
LB77E:  RTS

;------------------------------------------------------------------------------
; cockpit_no_x - first step of the cockpit list for craft type 1: no sideways shift, U = 0 and LZ_GX = 0.
;   reached through cockpit_list_1, hence no caller found
;------------------------------------------------------------------------------
cockpit_no_x:
LB77F:  LDU  #$0000
LB782:  STU  LZ_GX
LB785:  RTS

;------------------------------------------------------------------------------
; cockpit_shift_y - second step of both cockpit lists: the up and down shift of the cockpit from the site's
;   screen y, as in Star Wars VWPLAN (whose comments it carries). stores it in LZ_GY and returns it in D as the y
;   word of a position vector. reached through the lists, hence no caller found
;------------------------------------------------------------------------------
cockpit_shift_y:
LB786:  LDA  SI_RSY                 ;NOW HANDLE UP/DOWN SHIFTING
LB788:  BPL  LB78B                  ;IFMI
LB78A:  NEGA                        ;ABSOLUTE VALUE
LB78B:  LDB  #$50                   ;ALLOW +-4 GRIDS MOVEMENT, *2 COMPENSATES FOR MUL
LB78D:  MUL
LB78E:  LDB  SI_RSY
LB790:  BPL  LB793                  ;IFMI
LB792:  NEGA                        ;RESTORE SIGN
LB793:  TFR  A,B
LB795:  SEX
LB796:  STD  LZ_GY                  ;Y DISTANCE OF SITE
LB799:  ANDA #$1F                   ;VECTOR OPCODE
LB79B:  RTS

;------------------------------------------------------------------------------
; cockpit_put_pos - third step of both cockpit lists: writes the position vector, D = y word and U = x word, at
;   0,Y and again at 8,Y - one for each of the two pictures. reached through the lists, hence no caller found
;------------------------------------------------------------------------------
cockpit_put_pos:
LB79C:  STD  8,Y                    ;position for the second picture
LB79E:  STU  10,Y
LB7A0:  STD  ,Y                     ;position for the first picture
LB7A2:  STU  2,Y
LB7A4:  RTS

;------------------------------------------------------------------------------
; cockpit_colour - returns in D the display list word that colours the cockpit: JSRL $002A, the colour word kept
;   in vector RAM, while the Jedi timer $4C50 runs or the flag $4C84 is set, else colour 1 at brightness $80.
;   called by the two routines that follow
;------------------------------------------------------------------------------
cockpit_colour:
LB7A5:  LDD  jedi_time
LB7A8:  BNE  LB7AF
LB7AA:  LDA  jedi_on
LB7AD:  BEQ  LB7B4
LB7AF:  LDD  #$A015                 ;JSRL $002A: the colour word kept in vector RAM
LB7B2:  BRA  LB7B7
LB7B4:  LDD  #$6180                 ;colour 1 at brightness $80
LB7B7:  RTS

;------------------------------------------------------------------------------
; cockpit_put_2 - writes colour and picture for both parts of the cockpit: the colour word at 12,Y and the
;   list's first picture word at 14,Y, then falls into cockpit_put_1 for the colour at 4,Y and the second picture
;   word at 6,Y. X points at the picture words and is stepped past them
;------------------------------------------------------------------------------
cockpit_put_2:
LB7B8:  BSR  cockpit_colour
LB7BA:  STD  12,Y
LB7BC:  LDD  ,X++                   ;first picture word of the list
LB7BE:  STD  14,Y

;------------------------------------------------------------------------------
; cockpit_put_1 - writes the colour word at 4,Y and the next picture word from X at 6,Y. the tail of
;   cockpit_put_2 and the body of cockpit_one_part
;------------------------------------------------------------------------------
cockpit_put_1:
LB7C0:  BSR  cockpit_colour
LB7C2:  STD  4,Y
LB7C4:  LDD  ,X++                   ;second picture word of the list
LB7C6:  STD  6,Y
LB7C8:  RTS

;------------------------------------------------------------------------------
; cockpit_two_parts - fourth step of both cockpit lists: writes colours and pictures for the two parts and moves
;   Y past the 16 bytes built. reached through the lists, hence no caller found
;------------------------------------------------------------------------------
cockpit_two_parts:
LB7C9:  BSR  cockpit_put_2
LB7CB:  LEAY $10,Y
LB7CE:  RTS

;------------------------------------------------------------------------------
; cockpit_one_part - a fourth step for a cockpit with one part: one colour and picture, Y moved on 8 bytes.
;   neither list names it and no call was found, so it is unused
;------------------------------------------------------------------------------
cockpit_one_part:
LB7CF:  BSR  cockpit_put_1
LB7D1:  LEAY 8,Y
LB7D3:  RTS

cockpit_lists:
LB7D4:  .word cockpit_list_0        ;cockpit_lists: the list for craft type 0, then for type 1. each list is four routine addresses and two JSRL words to vector ROM pictures
LB7D6:  .word cockpit_list_1

cockpit_list_0:
LB7D8:  .word VWPLAN
LB7DA:  .word cockpit_shift_y
LB7DC:  .word cockpit_put_pos
LB7DE:  .word cockpit_two_parts
LB7E0:  .word (((vg_cockpit0l-VGBASE)/2)&$1FFF)+$A000 ;JSRL vg_cockpit0l
LB7E2:  .word (((vg_cockpit0r-VGBASE)/2)&$1FFF)+$A000 ;JSRL vg_cockpit0r

cockpit_list_1:
LB7E4:  .word cockpit_no_x
LB7E6:  .word cockpit_shift_y
LB7E8:  .word cockpit_put_pos
LB7EA:  .word cockpit_two_parts
LB7EC:  .word (((vg_cockpit1l-VGBASE)/2)&$1FFF)+$A000 ;JSRL vg_cockpit1l
LB7EE:  .word (((vg_cockpit1r-VGBASE)/2)&$1FFF)+$A000 ;JSRL vg_cockpit1r

;------------------------------------------------------------------------------
; SPLASH - SPLASH
;   (also: VTGNTZ)
;------------------------------------------------------------------------------
SPLASH:
VTGNTZ:
LB7F0:  JSR  URQUAD
LB7F3:  JSR  URQ2
LB7F6:  LDD  #VGRTSL
LB7F9:  STD  ,U++
LB7FB:  JSR  ULQUAD
LB7FE:  JSR  ULQ2
LB801:  LDD  #VGRTSL
LB804:  STD  ,U++
LB806:  JSR  DLQUAD
LB809:  JSR  DLQ2
LB80C:  LDD  #VGRTSL
LB80F:  STD  ,U++
LB811:  JSR  DRQUAD
LB814:  JSR  DRQ2
LB817:  LDD  #VGRTSL
LB81A:  STD  ,U++
LB81C:  RTS

;------------------------------------------------------------------------------
; URQUAD - UP-RIGHT QUADRANT ( +Y AND +X )
;------------------------------------------------------------------------------
URQUAD:
LB81D:  LDU  #$1402

;------------------------------------------------------------------------------
; URQ2 - [note] Up-right quadrant, entry with U already set: copy 3 vector words from the RNDVEC list to (U)+ as is
;------------------------------------------------------------------------------
URQ2:
LB820:  JSR  RNDVEC                 ;RETURNS WITH X POINTING TO A LIST OF VECTORS
LB823:  LDD  ,X++
LB825:  STD  ,U++
LB827:  LDD  ,X++
LB829:  STD  ,U++
LB82B:  LDD  ,X
LB82D:  STD  ,U++
LB82F:  RTS

;------------------------------------------------------------------------------
; ULQUAD - UP-LEFT QUADRANT ( +Y AND -X )
;------------------------------------------------------------------------------
ULQUAD:
LB830:  LDU  #$1410

;------------------------------------------------------------------------------
; ULQ2 - [note] Up-left quadrant, entry with U already set: copy 3 vector words from the RNDVEC list to (U)+ with X
;   negated; Z off on the first and third, Z = 7 on the second
;------------------------------------------------------------------------------
ULQ2:
LB833:  JSR  RNDVEC                 ;RETURNS WITH X POINTING TO A LIST OF VECTORS
LB836:  LDD  ,X++
LB838:  NEGB                        ;NEGATIVE X
LB839:  ANDB #$1F                   ;Z OFF
LB83B:  STD  ,U++
LB83D:  LDD  ,X++
LB83F:  NEGB                        ;NEGATIVE X ( THERE ARE NO 0 X'S )
LB840:  ORB  #$E0                   ;AND SET Z TO 7
LB842:  STD  ,U++
LB844:  LDD  ,X
LB846:  NEGB                        ;NEGATIVE X
LB847:  ANDB #$1F                   ;Z OFF
LB849:  STD  ,U++
LB84B:  RTS

;------------------------------------------------------------------------------
; DLQUAD - DOWN-LEFT QUADRANT ( -Y AND -X )
;------------------------------------------------------------------------------
DLQUAD:
LB84C:  LDU  #$141E

;------------------------------------------------------------------------------
; DLQ2 - [note] Down-left quadrant, entry with U already set: copy 3 vector words from the RNDVEC list to (U)+ with Y
;   and X negated (remade as SVCTR instructions); Z off on the first and third, Z = 7 on the second
;------------------------------------------------------------------------------
DLQ2:
LB84F:  JSR  RNDVEC                 ;RETURNS WITH X POINTING TO A LIST OF VECTORS
LB852:  LDD  ,X++
LB854:  NEGA                        ;NEGATIVE Y
LB855:  ANDA #$1F                   ;LIMIT IT
LB857:  ORA  #$40                   ;MAKE IT A SVCTR INSTRUCTION AGAIN
LB859:  NEGB                        ;NEGATIVE X
LB85A:  ANDB #$1F                   ;Z OFF
LB85C:  STD  ,U++
LB85E:  LDD  ,X++
LB860:  NEGA
LB861:  ANDA #$1F
LB863:  ORA  #$40
LB865:  NEGB                        ;NEGATIVE X
LB866:  ORB  #$E0                   ;Z=7
LB868:  STD  ,U++
LB86A:  LDD  ,X
LB86C:  NEGA
LB86D:  ANDA #$1F
LB86F:  ORA  #$40
LB871:  NEGB
LB872:  ANDB #$1F
LB874:  STD  ,U++
LB876:  RTS

;------------------------------------------------------------------------------
; DRQUAD - DOWN-RIGHT QUAD ( -Y AND +X )
;------------------------------------------------------------------------------
DRQUAD:
LB877:  LDU  #$142C

;------------------------------------------------------------------------------
; DRQ2 - [note] Down-right quadrant, entry with U already set: copy 3 vector words from the RNDVEC list to (U)+ with Y
;   negated (remade as SVCTR instructions)
;------------------------------------------------------------------------------
DRQ2:
LB87A:  JSR  RNDVEC                 ;RETURNS WITH X POINTING TO A LIST OF VECTORS
LB87D:  LDD  ,X++
LB87F:  NEGA
LB880:  ANDA #$1F
LB882:  ORA  #$40
LB884:  STD  ,U++
LB886:  LDD  ,X++
LB888:  NEGA
LB889:  ANDA #$1F
LB88B:  ORA  #$40
LB88D:  STD  ,U++
LB88F:  LDD  ,X
LB891:  NEGA
LB892:  ANDA #$1F
LB894:  ORA  #$40
LB896:  STD  ,U++
LB898:  RTS

;------------------------------------------------------------------------------
; RNDVEC - RETURNS WITH X POINTING TO A LIST OF VECTORS  (comment at the calls)
;------------------------------------------------------------------------------
RNDVEC:
LB899:  LDA  P_RND                  ;RANDOM NUMBER
LB89C:  ANDA #$0F                   ;0 TO 15.
LB89E:  LDB  #$06                   ;6 BYTE ENTRIES IN TABLE
LB8A0:  MUL
LB8A1:  LDX  #TSPLSH                ;TABLE OF SPLASH VECTORS
LB8A4:  ABX
LB8A5:  RTS

;.SBTTL SPLASH VECTORS
TSPLSH:          ;TABLE OF SPLASH VECTORS
LB8A6:  .byte $42, $00, $4D, $E1, $51, $1F ;.SPLSH 00.,04.,02.,30.
LB8AC:  .byte $46, $01, $46, $E1, $54, $1E ;.SPLSH 02.,12.,04.,24.
LB8B2:  .byte $49, $02, $43, $E1, $54, $1D ;.SPLSH 04.,18.,06.,24.
LB8B8:  .byte $43, $01, $4C, $E3, $51, $1C ;.SPLSH 02.,06.,08.,30.
LB8BE:  .byte $42, $01, $48, $E4, $56, $1B ;.SPLSH 02.,04.,10.,20.
LB8C4:  .byte $43, $02, $48, $E6, $55, $18 ;.SPLSH 04.,06.,16.,22.
LB8CA:  .byte $45, $04, $43, $E2, $58, $1A ;.SPLSH 08.,10.,12.,16.
LB8D0:  .byte $46, $05, $45, $E4, $55, $17 ;.SPLSH 10.,12.,18.,22.
LB8D6:  .byte $42, $02, $46, $E6, $58, $18 ;.SPLSH 04.,04.,16.,16.
LB8DC:  .byte $44, $05, $44, $E5, $58, $16 ;.SPLSH 10.,08.,20.,16.
LB8E2:  .byte $42, $03, $48, $EC, $56, $11 ;.SPLSH 06.,04.,30.,20.
LB8E8:  .byte $41, $02, $45, $EA, $5A, $14 ;.SPLSH 04.,02.,24.,12.
LB8EE:  .byte $41, $03, $42, $E6, $5D, $17 ;.SPLSH 06.,02.,18.,06.
LB8F4:  .byte $42, $08, $41, $E4, $5D, $14 ;.SPLSH 16.,04.,24.,06.
LB8FA:  .byte $41, $06, $41, $E6, $5E, $14 ;.SPLSH 12.,02.,24.,04.
LB900:  .byte $40, $02, $41, $ED, $5F, $11 ;.SPLSH 04.,00.,30.,02.

;.SBTTL VG TABLES
;USES MAX BRIGHTNESS
VTFLS:          ;FLASH COLOR TABLE
ZFAKEVG:
LB906:  .word $61FF                 ;COLOR 1,0FF
LB908:  .word $62FF                 ;COLOR 2,0FF
LB90A:  .word $63FF                 ;COLOR 3,0FF
LB90C:  .word $64FF                 ;COLOR 4,0FF
LB90E:  .word $65FF                 ;COLOR 5,0FF
LB910:  .word $66FF                 ;COLOR 6,0FF
LB912:  .word $67FF                 ;COLOR 7,0FF

;USES DEFAULT BRIGHTNESS
VTFLSZ:
VTMFL:          ;MEDIUM ( MESSAGE ) FLASH COLOR TABLE
LB914:  .word $6180                 ;COLOR 1
LB916:  .word $6280                 ;COLOR 2
LB918:  .word $6380                 ;COLOR 3
LB91A:  .word $6480                 ;COLOR 4
LB91C:  .word $6580                 ;COLOR 5
LB91E:  .word $6680                 ;COLOR 6
LB920:  .word $6780                 ;COLOR 7

VTLZF:          ;TABLE OF LAZAR FIRE JMPL'S
VTMFLZ:
LB922:  .word ((LZF0-VGBASE)/2)+$E000 ;.IRP .A,<0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F>
LB924:  .word ((LZF1-VGBASE)/2)+$E000
LB926:  .word ((LZF2-VGBASE)/2)+$E000
LB928:  .word ((LZF3-VGBASE)/2)+$E000
LB92A:  .word ((LZF4-VGBASE)/2)+$E000
LB92C:  .word (((LZF5-VGBASE)/2)&$1FFF)+$E000 ;JMPL LZF5
LB92E:  .word (((LZF5-VGBASE)/2)&$1FFF)+$E000 ;JMPL LZF5
LB930:  .word (((LZF5-VGBASE)/2)&$1FFF)+$E000

VTLZFZ:
VTLZS:          ;TABLE FOR LAZAR SPLASHES
LB932:  .word ((LZS0-VGBASE)/2)+$E000 ;.IRP .A,<0,1,2,3>
LB934:  .word ((LZS1-VGBASE)/2)+$E000
LB936:  .word ((LZS2-VGBASE)/2)+$E000
LB938:  .word (((LZS3-VGBASE)/2)&$1FFF)+$E000 ;JMPL LZS3

VTGNB:
LB93A:  .word (((vg_gnb0-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_gnb0  Star Wars VTGNB: JMPLs to the four enemy shot pictures vg_gnb0-3, now in the real vector ROM. the IRQ steps through them every fourth frame for the slot at vector RAM $001A
LB93C:  .word (((vg_gnb1-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_gnb1
LB93E:  .word (((vg_gnb2-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_gnb2
LB940:  .word (((vg_gnb3-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_gnb3

VTGNX:
LB942:  .word (((vg_gnx0-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_gnx0  Star Wars VTGNX: JMPLs to the four shot explosion pictures vg_gnx0-3, for the slot at $001E, stepped together with VTGNB
LB944:  .word (((vg_gnx1-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_gnx1
LB946:  .word (((vg_gnx2-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_gnx2
LB948:  .word (((vg_gnx3-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_gnx3

VTGNT:
LB94A:  .word (((GNT0-VGBASE)/2)&$1FFF)+$E000 ;JMPL GNT0  Star Wars VTGNT: JMPLs to the four tip fuse pictures GNT0-3, for the slot at $001C, stepped every frame
LB94C:  .word (((GNT1-VGBASE)/2)&$1FFF)+$E000 ;JMPL GNT1
LB94E:  .word (((GNT2-VGBASE)/2)&$1FFF)+$E000 ;JMPL GNT2
LB950:  .word (((GNT3-VGBASE)/2)&$1FFF)+$E000 ;JMPL GNT3

spark_tab:
LB952:  .word (((vg_spark0-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_spark0  JMPLs to the four sparkle pictures vg_spark0-3, for the slot at $0020 (VRLZS), stepped every second frame
LB954:  .word (((vg_spark1-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_spark1
LB956:  .word (((vg_spark2-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_spark2
LB958:  .word (((vg_spark3-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_spark3

sparks_tab:
LB95A:  .word (((vg_sparks0-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_sparks0  JMPLs to the four sparkle rings vg_sparks0-3, for the slot at $0022 (VRGNX), stepped every frame
LB95C:  .word (((vg_sparks1-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_sparks1
LB95E:  .word (((vg_sparks2-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_sparks2
LB960:  .word (((vg_sparks3-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_sparks3

aflash_tab:
LB962:  .word $B560                 ;JSRL $2AC0  JSRLs to the five asteroid hit flash pictures of set 2, s2_flash0-4 at $2AC0, $2AF2, $2B24, $2B56 and $2B88. page 2 astrd_flash_draw picks one by byte $16 of the flash record
LB964:  .word $B579                 ;JSRL $2AF2
LB966:  .word $B592                 ;JSRL $2B24
LB968:  .word $B5AB                 ;JSRL $2B56
LB96A:  .word $B5C4                 ;JSRL $2B88

tri_tab:
LB96C:  .word $F5FE                 ;JMPL $2BFC  JMPLs to the four triangles of set 2 at $2BFC, $2BE6, $2BD0 and $2BBA, for the slot at $0024 (VRGNT), stepped every frame. only the flash pictures of set 2 call that slot
LB96E:  .word $F5F3                 ;JMPL $2BE6
LB970:  .word $F5E8                 ;JMPL $2BD0
LB972:  .word $F5DD                 ;JMPL $2BBA

vg_set_tab:
LB974:  .word s0_big_half           ;ROM address of each display list set, indexed by vg_set times 2. load_vg_set copies $0800 bytes from there to vector RAM $2800, so what follows a set in the ROM is copied with it
LB976:  .word s1_hideout
LB978:  .word s2_vader
LB97A:  .word DOXMT                 ;not a set: the address after the end of set 2. load_vg_set masks the set number to 0-3 but only 0, 1 and 2 are ever asked for

s0_big_half:
LB97C:  .word $6780                 ;STAT colour 7, brightness $80  display list set 0, $2800-$2C9F in vector RAM: loaded by PHERES, the title (PHIBNR), the game start (PHISG1), the difficulty select screen, the launch sequence with the Executor and the continue offer. first list: white, a move 1600 to the right and a JMPL to s0_big_top, the upper half of the big striped disc. it takes the place of Star Wars BSHEM. no caller found
LB97E:  .word $0000, $0640          ;VCTR 1600,0,0
LB982:  .word (((s0_big_top-s0_big_half+$2800-VGBASE)/2)&$1FFF)+$E000 ;JMPL s0_big_top (at $28B0 in vector RAM)

s0_big_disc:
LB984:  .word $6780                 ;STAT colour 7, brightness $80  big striped disc, 3200 wide and 4800 high at the list's scale: white, a move 1600 to the left, the lower half of the outline in 14 vectors, 13 horizontal stripes at brightness $C0, then it runs on into s0_big_top. the outline is Star Wars' big Death Star circle (BSCIR) with stripes added. no caller found
LB986:  .word $0000, $19C0          ;VCTR -1600,0,0
LB98A:  .word $1E20, $A020          ;VCTR 32,-480,5
LB98E:  .word $1E20, $A060          ;AON -46,-20,5
LB992:  .word $1E20, $A0C0          ;AON -40,-30,5
LB996:  .word $1E20, $A140          ;AON -30,-40,5
LB99A:  .word $1EE0, $A140          ;AON -20,-46,5
LB99E:  .word $1F70, $A140          ;AON -10,-49,5
LB9A2:  .word $1FD0, $A140          ;AON 0,-50,5
LB9A6:  .word $0030, $A140          ;AON 10,-49,5
LB9AA:  .word $0090, $A140          ;AON 20,-46,5
LB9AE:  .word $0120, $A140          ;AON 30,-40,5
LB9B2:  .word $01E0, $A140          ;AON 40,-30,5
LB9B6:  .word $01E0, $C0C0          ;AON 46,-20,6
LB9BA:  .word $01E0, $C060          ;AON 49,-10,6

BSHEM2:
LB9BE:  .word $01E0, $E020          ;AON 50,0,7
LB9C2:  .word $67C0                 ;STAT colour 7, brightness $C0
LB9C4:  .word $16D0, $1880          ;VCTR -1920,-2352,0
LB9C8:  .word $0000, $E280          ;VCTR 640,0,7
LB9CC:  .word $0048, $00A0          ;VCTR 160,72,0
LB9D0:  .word $0000, $FC40          ;VCTR -960,0,7
LB9D4:  .word $0048, $1F60          ;VCTR -160,72,0
LB9D8:  .word $0000, $E500          ;VCTR 1280,0,7
LB9DC:  .word $0090, $00A0          ;VCTR 160,144,0
LB9E0:  .word $0000, $F9C0          ;VCTR -1600,0,7
LB9E4:  .word $0090, $1F60          ;VCTR -160,144,0
LB9E8:  .word $0000, $E780          ;VCTR 1920,0,7
LB9EC:  .word $00F0, $00A0          ;VCTR 160,240,0
LB9F0:  .word $0000, $F740          ;VCTR -2240,0,7
LB9F4:  .word $00F0, $1F60          ;VCTR -160,240,0
LB9F8:  .word $0000, $EA00          ;VCTR 2560,0,7
LB9FC:  .word $00F0, $0060          ;VCTR 96,240,0
LBA00:  .word $0000, $F540          ;VCTR -2752,0,7
LBA04:  .word $00F0, $1FA0          ;VCTR -96,240,0
LBA08:  .word $0000, $EB80          ;VCTR 2944,0,7
LBA0C:  .word $00F0, $0030          ;VCTR 48,240,0
LBA10:  .word $0000, $F420          ;VCTR -3040,0,7
LBA14:  .word $00F0, $1FD0          ;VCTR -48,240,0
LBA18:  .word $0000, $EC40          ;VCTR 3136,0,7
LBA1C:  .word $00F0, $0010          ;VCTR 16,240,0
LBA20:  .word $0000, $F3A0          ;VCTR -3168,0,7
LBA24:  .word $00F0, $1FF0          ;VCTR -16,240,0
LBA28:  .word $0000, $EC80          ;VCTR 3200,0,7

s0_big_top:
LBA2C:  .word $01E0, $FFE0          ;AON 49,10,7  upper half of the big disc: 14 outline vectors that fade from intensity 7 to 5, 11 horizontal stripes at brightness $C0, then JMPL vg_scal_cntr. reached from s0_big_half and by running on from s0_big_disc
LBA30:  .word $01E0, $FFA0          ;AON 46,20,7
LBA34:  .word $01E0, $FF40          ;AON 40,30,7
LBA38:  .word $01E0, $FEC0          ;AON 30,40,7
LBA3C:  .word $0120, $FEC0          ;AON 20,46,7
LBA40:  .word $0090, $DEC0          ;AON 10,49,6
LBA44:  .word $0030, $DEC0          ;AON 0,50,6
LBA48:  .word $1FD0, $BEC0          ;AON -10,49,5
LBA4C:  .word $1F70, $BEC0          ;AON -20,46,5
LBA50:  .word $1EE0, $BEC0          ;AON -30,40,5
LBA54:  .word $1E20, $BEC0          ;AON -40,30,5
LBA58:  .word $1E20, $BF40          ;AON -46,20,5
LBA5C:  .word $1E20, $BFA0          ;AON -49,10,5
LBA60:  .word $1E20, $BFE0          ;AON -50,0,5
LBA64:  .word $67C0                 ;STAT colour 7, brightness $C0
LBA66:  .word $01E0, $0020          ;VCTR 32,480,0
LBA6A:  .word $0000, $EC40          ;VCTR 3136,0,7
LBA6E:  .word $00F0, $1FD0          ;VCTR -48,240,0
LBA72:  .word $0000, $F420          ;VCTR -3040,0,7
LBA76:  .word $00F0, $0030          ;VCTR 48,240,0
LBA7A:  .word $0000, $EB80          ;VCTR 2944,0,7
LBA7E:  .word $00F0, $1FA0          ;VCTR -96,240,0
LBA82:  .word $0000, $F540          ;VCTR -2752,0,7
LBA86:  .word $00F0, $0060          ;VCTR 96,240,0
LBA8A:  .word $0000, $EA00          ;VCTR 2560,0,7
LBA8E:  .word $00F0, $1F60          ;VCTR -160,240,0
LBA92:  .word $0000, $F740          ;VCTR -2240,0,7
LBA96:  .word $00F0, $00A0          ;VCTR 160,240,0
LBA9A:  .word $0000, $E780          ;VCTR 1920,0,7
LBA9E:  .word $0090, $1F60          ;VCTR -160,144,0
LBAA2:  .word $0000, $F9C0          ;VCTR -1600,0,7
LBAA6:  .word $0090, $00A0          ;VCTR 160,144,0
LBAAA:  .word $0000, $E500          ;VCTR 1280,0,7
LBAAE:  .word $0048, $1F60          ;VCTR -160,72,0
LBAB2:  .word $0000, $FC40          ;VCTR -960,0,7
LBAB6:  .word $0048, $00A0          ;VCTR 160,72,0
LBABA:  .word $0000, $E280          ;VCTR 640,0,7
LBABE:  .word (((vg_scal_cntr-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_scal_cntr

s0_planet:
LBAC0:  .word $6780                 ;STAT colour 7, brightness $80  the planet of the select screens: a disc 100 wide and 150 high, white, an outline of 28 vectors and 25 horizontal stripes. sel_wave_exec draws one for each of the three starting waves and cont_offer_exec one for the continue offer (JSRL $2944)
LBAC2:  .word $0000, $1FCE          ;VCTR -50,0,0
LBAC6:  .word $1FF1, $E001          ;VCTR 1,-15,7
LBACA:  .word $1FF1, $E003          ;VCTR 3,-15,7
LBACE:  .word $1FF1, $E006          ;VCTR 6,-15,7
LBAD2:  .word $1FF1, $E00A          ;VCTR 10,-15,7
LBAD6:  .word $1FF7, $E00A          ;VCTR 10,-9,7
LBADA:  .word $5EE5                 ;SVEC 10,-4,7
LBADC:  .word $5FE5                 ;SVEC 10,-2,7
LBADE:  .word $41E5                 ;SVEC 10,2,7
LBAE0:  .word $42E5                 ;SVEC 10,4,7
LBAE2:  .word $0009, $E00A          ;VCTR 10,9,7
LBAE6:  .word $000F, $E00A          ;VCTR 10,15,7
LBAEA:  .word $000F, $E006          ;VCTR 6,15,7
LBAEE:  .word $000F, $E003          ;VCTR 3,15,7
LBAF2:  .word $000F, $E001          ;VCTR 1,15,7
LBAF6:  .word $000F, $FFFF          ;VCTR -1,15,7
LBAFA:  .word $000F, $FFFD          ;VCTR -3,15,7
LBAFE:  .word $000F, $FFFA          ;VCTR -6,15,7
LBB02:  .word $000F, $FFF6          ;VCTR -10,15,7
LBB06:  .word $0009, $FFF6          ;VCTR -10,9,7
LBB0A:  .word $42FB                 ;SVEC -10,4,7
LBB0C:  .word $41FB                 ;SVEC -10,2,7
LBB0E:  .word $5FFB                 ;SVEC -10,-2,7
LBB10:  .word $5EFB                 ;SVEC -10,-4,7
LBB12:  .word $1FF7, $FFF6          ;VCTR -10,-9,7
LBB16:  .word $1FF1, $FFF6          ;VCTR -10,-15,7
LBB1A:  .word $1FF1, $FFFA          ;VCTR -6,-15,7
LBB1E:  .word $1FF1, $FFFD          ;VCTR -3,-15,7
LBB22:  .word $1FF1, $FFFF          ;VCTR -1,-15,7
LBB26:  .word $67C0                 ;STAT colour 7, brightness $C0
LBB28:  .word $1FB7, $0028          ;VCTR 40,-73,0
LBB2C:  .word $40EA                 ;SVEC 20,0,7
LBB2E:  .word $0001, $0005          ;VCTR 5,1,0
LBB32:  .word $41F1                 ;SVEC -30,2,7
LBB34:  .word $0001, $1FFB          ;VCTR -5,1,0
LBB38:  .word $0000, $E028          ;VCTR 40,0,7
LBB3C:  .word $0005, $0005          ;VCTR 5,5,0
LBB40:  .word $0000, $FFCE          ;VCTR -50,0,7
LBB44:  .word $0004, $1FFB          ;VCTR -5,4,0
LBB48:  .word $0000, $E03C          ;VCTR 60,0,7
LBB4C:  .word $0008, $0005          ;VCTR 5,8,0
LBB50:  .word $0000, $FFBA          ;VCTR -70,0,7
LBB54:  .word $0007, $1FFB          ;VCTR -5,7,0
LBB58:  .word $0000, $E050          ;VCTR 80,0,7
LBB5C:  .word $0008, $0003          ;VCTR 3,8,0
LBB60:  .word $0000, $FFAA          ;VCTR -86,0,7
LBB64:  .word $0007, $1FFD          ;VCTR -3,7,0
LBB68:  .word $0000, $E05C          ;VCTR 92,0,7
LBB6C:  .word $0008, $0001          ;VCTR 1,8,0
LBB70:  .word $0000, $FFA1          ;VCTR -95,0,7
LBB74:  .word $0007, $1FFF          ;VCTR -1,7,0
LBB78:  .word $0000, $E062          ;VCTR 98,0,7
LBB7C:  .word $4400                 ;SVEC 0,8,0
LBB7E:  .word $0000, $FF9D          ;VCTR -99,0,7
LBB82:  .word $0007, $0000          ;VCTR 0,7,0
LBB86:  .word $0000, $E064          ;VCTR 100,0,7
LBB8A:  .word $0007, $1FFF          ;VCTR -1,7,0
LBB8E:  .word $0000, $FF9E          ;VCTR -98,0,7
LBB92:  .word $4400                 ;SVEC 0,8,0
LBB94:  .word $0000, $E062          ;VCTR 98,0,7
LBB98:  .word $0007, $1FFF          ;VCTR -1,7,0
LBB9C:  .word $0000, $FFA1          ;VCTR -95,0,7
LBBA0:  .word $0008, $0001          ;VCTR 1,8,0
LBBA4:  .word $0000, $E05C          ;VCTR 92,0,7
LBBA8:  .word $0007, $1FFD          ;VCTR -3,7,0
LBBAC:  .word $0000, $FFAA          ;VCTR -86,0,7
LBBB0:  .word $0008, $0003          ;VCTR 3,8,0
LBBB4:  .word $0000, $E050          ;VCTR 80,0,7
LBBB8:  .word $0007, $1FFB          ;VCTR -5,7,0
LBBBC:  .word $0000, $FFBA          ;VCTR -70,0,7
LBBC0:  .word $0008, $0005          ;VCTR 5,8,0
LBBC4:  .word $0000, $E03C          ;VCTR 60,0,7
LBBC8:  .word $0004, $1FFB          ;VCTR -5,4,0
LBBCC:  .word $0000, $FFCE          ;VCTR -50,0,7
LBBD0:  .word $0005, $0005          ;VCTR 5,5,0
LBBD4:  .word $0000, $E028          ;VCTR 40,0,7
LBBD8:  .word $0001, $1FFB          ;VCTR -5,1,0
LBBDC:  .word $41F1                 ;SVEC -30,2,7
LBBDE:  .word $0001, $0005          ;VCTR 5,1,0
LBBE2:  .word $40EA                 ;SVEC 20,0,7
LBBE4:  .word (((vg_scal_cntr-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_scal_cntr

s0_manual:
LBBE6:  .word $004B, $1FCE          ;VCTR -50,75,0  the instructions target of the select screen, a book: a page 80 wide and 150 high at intensity 7 and the top and right edges of three more pages behind it, each 5 further right and 7 further up, at intensities 6, 5 and 4, 16 vectors in the caller's colour. sel_wave_exec draws it in colour 1 (JSRL $2A6A)
LBBEA:  .word $0000, $E050          ;VCTR 80,0,7
LBBEE:  .word $1F6A, $E000          ;VCTR 0,-150,7
LBBF2:  .word $0000, $FFB0          ;VCTR -80,0,7
LBBF6:  .word $0096, $E000          ;VCTR 0,150,7
LBBFA:  .word $0000, $0005          ;VCTR 5,0,0
LBBFE:  .word $0007, $C000          ;VCTR 0,7,6
LBC02:  .word $0000, $C050          ;VCTR 80,0,6
LBC06:  .word $1F6B, $C000          ;VCTR 0,-149,6
LBC0A:  .word $0000, $DFFB          ;VCTR -5,0,6
LBC0E:  .word $0007, $0005          ;VCTR 5,7,0
LBC12:  .word $0000, $A005          ;VCTR 5,0,5
LBC16:  .word $0096, $A000          ;VCTR 0,150,5
LBC1A:  .word $0000, $BFB0          ;VCTR -80,0,5
LBC1E:  .word $5CA0                 ;SVEC 0,-8,5
LBC20:  .word $0008, $0005          ;VCTR 5,8,0
LBC24:  .word $0007, $8000          ;VCTR 0,7,4
LBC28:  .word $0000, $8050          ;VCTR 80,0,4
LBC2C:  .word $1F6B, $8000          ;VCTR 0,-149,4
LBC30:  .word $0000, $9FFB          ;VCTR -5,0,4
LBC34:  .word $0034, $1FD8          ;VCTR -40,52,0
LBC38:  .word (((vg_scal_cntr-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_scal_cntr

s0_wd_rebel:
LBC3A:  .word $0021, $1FD6          ;VCTR -42,33,0  the word REBEL in small letters stepping down to the right, 23 vectors. sel_wave_exec draws it on the book for 16 frames, then s0_wd_manual for 16 (JSRL $2ABE)
LBC3E:  .word $0017, $E000          ;VCTR 0,23,7
LBC42:  .word $40E5                 ;SVEC 10,0,7
LBC44:  .word $1FF5, $E000          ;VCTR 0,-11,7
LBC48:  .word $40FB                 ;SVEC -10,0,7
LBC4A:  .word $0000, $0005          ;VCTR 5,0,0
LBC4E:  .word $1FF4, $E005          ;VCTR 5,-12,7
LBC52:  .word $0000, $000F          ;VCTR 15,0,0
LBC56:  .word $40FB                 ;SVEC -10,0,7
LBC58:  .word $55E0                 ;SVEC 0,-22,7
LBC5A:  .word $40E5                 ;SVEC 10,0,7
LBC5C:  .word $000B, $1FF6          ;VCTR -10,11,0
LBC60:  .word $0000, $E007          ;VCTR 7,0,7
LBC64:  .word $1FEA, $000D          ;VCTR 13,-22,0
LBC68:  .word $40E1                 ;SVEC 2,0,7
LBC6A:  .word $0003, $E003          ;VCTR 3,3,7
LBC6E:  .word $44E0                 ;SVEC 0,8,7
LBC70:  .word $40FB                 ;SVEC -10,0,7
LBC72:  .word $55E0                 ;SVEC 0,-22,7
LBC74:  .word $40E5                 ;SVEC 10,0,7
LBC76:  .word $44E0                 ;SVEC 0,8,7
LBC78:  .word $0003, $FFFD          ;VCTR -3,3,7
LBC7C:  .word $1FF5, $0011          ;VCTR 17,-11,0
LBC80:  .word $40FB                 ;SVEC -10,0,7
LBC82:  .word $55E0                 ;SVEC 0,-22,7
LBC84:  .word $40E5                 ;SVEC 10,0,7
LBC86:  .word $000B, $1FF6          ;VCTR -10,11,0
LBC8A:  .word $40E4                 ;SVEC 8,0,7
LBC8C:  .word $1FF5, $0007          ;VCTR 7,-11,0
LBC90:  .word $1FE9, $E000          ;VCTR 0,-23,7
LBC94:  .word $40E5                 ;SVEC 10,0,7
LBC96:  .word (((vg_scal_cntr-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_scal_cntr

s0_wd_manual:
LBC98:  .word $002D, $1FD3          ;VCTR -45,45,0  the word MANUAL in small letters stepping down to the right, 18 vectors (JSRL $2B1C)
LBC9C:  .word $4BE0                 ;SVEC 0,22,7
LBC9E:  .word $1FF5, $E005          ;VCTR 5,-11,7
LBCA2:  .word $000B, $E005          ;VCTR 5,11,7
LBCA6:  .word $55E0                 ;SVEC 0,-22,7
LBCA8:  .word $1FE9, $0000          ;VCTR 0,-23,0
LBCAC:  .word $0017, $E005          ;VCTR 5,23,7
LBCB0:  .word $1FE9, $E005          ;VCTR 5,-23,7
LBCB4:  .word $000B, $1FF9          ;VCTR -7,11,0
LBCB8:  .word $0000, $E005          ;VCTR 5,0,7
LBCBC:  .word $1FDF, $0007          ;VCTR 7,-33,0
LBCC0:  .word $4BE0                 ;SVEC 0,22,7
LBCC2:  .word $55E5                 ;SVEC 10,-22,7
LBCC4:  .word $4BE0                 ;SVEC 0,22,7
LBCC6:  .word $1FEA, $0005          ;VCTR 5,-22,0
LBCCA:  .word $55E0                 ;SVEC 0,-22,7
LBCCC:  .word $40E5                 ;SVEC 10,0,7
LBCCE:  .word $4BE0                 ;SVEC 0,22,7
LBCD0:  .word $1FD3, $0000          ;VCTR 0,-45,0
LBCD4:  .word $0017, $E005          ;VCTR 5,23,7
LBCD8:  .word $1FE9, $E005          ;VCTR 5,-23,7
LBCDC:  .word $461C                 ;SVEC -8,12,0
LBCDE:  .word $0000, $E005          ;VCTR 5,0,7
LBCE2:  .word $5A04                 ;SVEC 8,-12,0
LBCE4:  .word $55E0                 ;SVEC 0,-22,7
LBCE6:  .word $0000, $E007          ;VCTR 7,0,7
LBCEA:  .word (((vg_scal_cntr-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_scal_cntr

s0_executor:
LBCEC:  .word $0000, $1CE0          ;VCTR -800,0,0  the Executor, Darth Vader's star destroyer, seen from the side: a hull bar 1300 wide and 15 high with the superstructure above and the keel below, 60 vectors in the caller's colour, 1650 wide and 404 high, ends in RTSL. vew_exec_intro draws it crossing the screen with message $2C (JSRL $2B70). the same vectors as s2_executor
LBCF0:  .word $0000, $C514          ;VCTR 1300,0,6
LBCF4:  .word $1FF1, $C000          ;VCTR 0,-15,6
LBCF8:  .word $0000, $DAEC          ;VCTR -1300,0,6
LBCFC:  .word $000F, $C000          ;VCTR 0,15,6
LBD00:  .word $0000, $003C          ;VCTR 60,0,0
LBD04:  .word $002D, $A280          ;VCTR 640,45,5
LBD08:  .word $001E, $A096          ;VCTR 150,30,5
LBD0C:  .word $1FD3, $1E3E          ;VCTR -450,-45,0
LBD10:  .word $000F, $6000          ;VCTR 0,15,3
LBD14:  .word $0000, $612C          ;VCTR 300,0,3
LBD18:  .word $000F, $6000          ;VCTR 0,15,3
LBD1C:  .word $0000, $7F9C          ;VCTR -100,0,3
LBD20:  .word $1FF1, $6000          ;VCTR 0,-15,3
LBD24:  .word $001E, $00FA          ;VCTR 250,30,0
LBD28:  .word $4FA0                 ;SVEC 0,30,5
LBD2A:  .word $0000, $A064          ;VCTR 100,0,5
LBD2E:  .word $002D, $A000          ;VCTR 0,45,5
LBD32:  .word $0000, $0190          ;VCTR 400,0,0
LBD36:  .word $0000, $BE1B          ;VCTR -485,0,5
LBD3A:  .word $0016, $BF8D          ;VCTR -115,22,5
LBD3E:  .word $0000, $BFCE          ;VCTR -50,0,5
LBD42:  .word $0017, $A000          ;VCTR 0,23,5
LBD46:  .word $0000, $A032          ;VCTR 50,0,5
LBD4A:  .word $001E, $A064          ;VCTR 100,30,5
LBD4E:  .word $0000, $A0FA          ;VCTR 250,0,5
LBD52:  .word $1FDA, $A064          ;VCTR 100,-38,5
LBD56:  .word $0000, $A096          ;VCTR 150,0,5
LBD5A:  .word $0026, $A032          ;VCTR 50,38,5
LBD5E:  .word $0000, $A032          ;VCTR 50,0,5
LBD62:  .word $4BA0                 ;SVEC 0,22,5
LBD64:  .word $0000, $A0B9          ;VCTR 185,0,5
LBD68:  .word $1FEA, $A00F          ;VCTR 15,-22,5
LBD6C:  .word $0016, $1FF1          ;VCTR -15,22,0
LBD70:  .word $1FEA, $A005          ;VCTR 5,-22,5
LBD74:  .word $40A5                 ;SVEC 10,0,5
LBD76:  .word $1FDA, $A000          ;VCTR 0,-38,5
LBD7A:  .word $40BB                 ;SVEC -10,0,5
LBD7C:  .word $0026, $A000          ;VCTR 0,38,5
LBD80:  .word $1FDA, $0000          ;VCTR 0,-38,0
LBD84:  .word $1F90, $BEC5          ;VCTR -315,-112,5
LBD88:  .word $1FB5, $BFE7          ;VCTR -25,-75,5
LBD8C:  .word $1FF1, $A000          ;VCTR 0,-15,5
LBD90:  .word $1F79, $A064          ;VCTR 100,-135,5
LBD94:  .word $0087, $A04B          ;VCTR 75,135,5
LBD98:  .word $005A, $A000          ;VCTR 0,90,5
LBD9C:  .word $0070, $A0AF          ;VCTR 175,112,5
LBDA0:  .word $1EAF, $1F06          ;VCTR -250,-337,0
LBDA4:  .word $0008, $BFC9          ;VCTR -55,8,5
LBDA8:  .word $1FF1, $8000          ;VCTR 0,-15,4
LBDAC:  .word $0000, $9F6F          ;VCTR -145,0,4
LBDB0:  .word $000F, $8000          ;VCTR 0,15,4
LBDB4:  .word $000F, $9FE7          ;VCTR -25,15,4
LBDB8:  .word $1FF1, $00AA          ;VCTR 170,-15,0
LBDBC:  .word $000F, $BF56          ;VCTR -170,15,5
LBDC0:  .word $0000, $BEED          ;VCTR -275,0,5
LBDC4:  .word $0069, $BC7C          ;VCTR -900,105,5
LBDC8:  .word $4BA0                 ;SVEC 0,22,5
LBDCA:  .word $1FB5, $0352          ;VCTR 850,-75,0
LBDCE:  .word $0000, $815E          ;VCTR 350,0,4
LBDD2:  .word $1FF1, $00B4          ;VCTR 180,-15,0
LBDD6:  .word $0000, $8028          ;VCTR 40,0,4
LBDDA:  .word $0035, $001E          ;VCTR 30,53,0
LBDDE:  .word $0000, $9F9C          ;VCTR -100,0,4
LBDE2:  .word $0025, $1FE7          ;VCTR -25,37,0
LBDE6:  .word $0000, $8091          ;VCTR 145,0,4
LBDEA:  .word $0025, $1FF6          ;VCTR -10,37,0
LBDEE:  .word $0000, $9F83          ;VCTR -125,0,4
LBDF2:  .word $0026, $000F          ;VCTR 15,38,0
LBDF6:  .word $0000, $8064          ;VCTR 100,0,4
LBDFA:  .word $0000, $1F38          ;VCTR -200,0,0
LBDFE:  .word $0000, $DEA2          ;VCTR -350,0,6
LBE02:  .word $007F, $00C8          ;VCTR 200,127,0
LBE06:  .word $0000, $DF06          ;VCTR -250,0,6
LBE0A:  .word $0017, $0023          ;VCTR 35,23,0
LBE0E:  .word $0016, $C00F          ;VCTR 15,22,6
LBE12:  .word $0000, $C064          ;VCTR 100,0,6
LBE16:  .word $1FEA, $C00F          ;VCTR 15,-22,6
LBE1A:  .word $C000                 ;RTSL

s1_hideout:
LBE1C:  .word $0000, $1E20          ;VCTR -480,0,0  display list set 1, $2800-$2A57 in vector RAM: loaded by wave1_init (probots) and wave2_init (walkers). first list: the rebel hideout, a ridge line 1312 wide and 250 high of 31 vectors in white at brightness $60 with a doorway of 10 vectors in colour 1 at brightness $40. vew_walker_end grows it from small to full size under the message REBEL HIDEOUT (JSRL $2800)
LBE20:  .word $6760                 ;STAT colour 7, brightness $60
LBE22:  .word $0000, $1F45          ;VCTR -187,0,0
LBE26:  .word $007D, $E03E          ;VCTR 62,125,7
LBE2A:  .word $004B, $E07D          ;VCTR 125,75,7
LBE2E:  .word $1F9C, $E0AF          ;VCTR 175,-100,7
LBE32:  .word $1F9C, $E032          ;VCTR 50,-100,7
LBE36:  .word $00C8, $E07D          ;VCTR 125,200,7
LBE3A:  .word $1FE7, $E032          ;VCTR 50,-25,7
LBE3E:  .word $1F51, $E0AF          ;VCTR 175,-175,7
LBE42:  .word $0000, $0096          ;VCTR 150,0,0
LBE46:  .word $0064, $E032          ;VCTR 50,100,7
LBE4A:  .word $007D, $E096          ;VCTR 150,125,7
LBE4E:  .word $0019, $E04B          ;VCTR 75,25,7
LBE52:  .word $1F06, $E07D          ;VCTR 125,-250,7
LBE56:  .word $00AF, $1BCD          ;VCTR -1075,175,0
LBE5A:  .word $0019, $A04B          ;VCTR 75,25,5
LBE5E:  .word $1FCE, $BFDA          ;VCTR -38,-50,5
LBE62:  .word $0032, $0026          ;VCTR 38,50,0
LBE66:  .word $1FCE, $A032          ;VCTR 50,-50,5
LBE6A:  .word $0000, $A019          ;VCTR 25,0,5
LBE6E:  .word $0032, $A032          ;VCTR 50,50,5
LBE72:  .word $1FDA, $A04B          ;VCTR 75,-38,5
LBE76:  .word $0026, $1FB5          ;VCTR -75,38,0
LBE7A:  .word $1FCE, $A019          ;VCTR 25,-50,5
LBE7E:  .word $1F9C, $BFB5          ;VCTR -75,-100,5
LBE82:  .word $0089, $00AF          ;VCTR 175,137,0
LBE86:  .word $0026, $8032          ;VCTR 50,38,4
LBE8A:  .word $0019, $8032          ;VCTR 50,25,4
LBE8E:  .word $1F9C, $804B          ;VCTR 75,-100,4
LBE92:  .word $0064, $1FB5          ;VCTR -75,100,0
LBE96:  .word $1F9C, $9FCE          ;VCTR -50,-100,4
LBE9A:  .word $1FC1, $003E          ;VCTR 62,-63,0
LBE9E:  .word $0058, $A058          ;VCTR 88,88,5
LBEA2:  .word $1FE7, $A04B          ;VCTR 75,-25,5
LBEA6:  .word $1FCE, $A019          ;VCTR 25,-50,5
LBEAA:  .word $1F9C, $BFC1          ;VCTR -63,-100,5
LBEAE:  .word $0096, $0026          ;VCTR 38,150,0
LBEB2:  .word $0032, $8019          ;VCTR 25,50,4
LBEB6:  .word $0032, $8064          ;VCTR 100,50,4
LBEBA:  .word $1FB5, $8057          ;VCTR 87,-75,4
LBEBE:  .word $004B, $1FA9          ;VCTR -87,75,0
LBEC2:  .word $1F83, $8019          ;VCTR 25,-125,4
LBEC6:  .word $6140                 ;STAT colour 1, brightness $40
LBEC8:  .word $1FCE, $1E3E          ;VCTR -450,-50,0
LBECC:  .word $1FE7, $C00C          ;VCTR 12,-25,6
LBED0:  .word $1FCE, $BFF4          ;VCTR -12,-50,5
LBED4:  .word $0000, $DFE7          ;VCTR -25,0,6
LBED8:  .word $004B, $E019          ;VCTR 25,75,7
LBEDC:  .word $0000, $E04B          ;VCTR 75,0,7
LBEE0:  .word $1FB5, $E019          ;VCTR 25,-75,7
LBEE4:  .word $0000, $DFE7          ;VCTR -25,0,6
LBEE8:  .word $0032, $BFF3          ;VCTR -13,50,5
LBEEC:  .word $0000, $BFCE          ;VCTR -50,0,5
LBEF0:  .word $0000, $0032          ;VCTR 50,0,0
LBEF4:  .word $0019, $C00D          ;VCTR 13,25,6
LBEF8:  .word (((vg_cntr-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_cntr

s1_xmit_frm:
LBEFA:  .word $1FB5, $1F06          ;VCTR -250,-75,0  frame of the probot part's indicator of transmissions sent: a box 800 wide and 150 high, 4 vectors. page 1 vw_probot_ind (JSRL $28DE)
LBEFE:  .word $0096, $E000          ;VCTR 0,150,7
LBF02:  .word $0000, $E320          ;VCTR 800,0,7
LBF06:  .word $1F6A, $E000          ;VCTR 0,-150,7
LBF0A:  .word $0000, $FCE0          ;VCTR -800,0,7
LBF0E:  .word (((vg_cntr-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_cntr

s1_xmit_slot:
LBF10:  .word $1FF1, $1FE2          ;VCTR -30,-15,0  the four slots of the probot indicator: a box 400 wide and 30 high at intensity 4 whose top and bottom are broken by four gaps of 60. vw_probot_ind (JSRL $28F4)
LBF14:  .word $4096                 ;SVEC -20,0,4
LBF16:  .word $4F80                 ;SVEC 0,30,4
LBF18:  .word $408A                 ;SVEC 20,0,4
LBF1A:  .word $0000, $003C          ;VCTR 60,0,0
LBF1E:  .word $0000, $8028          ;VCTR 40,0,4
LBF22:  .word $0000, $003C          ;VCTR 60,0,0
LBF26:  .word $0000, $8028          ;VCTR 40,0,4
LBF2A:  .word $0000, $003C          ;VCTR 60,0,0
LBF2E:  .word $0000, $8028          ;VCTR 40,0,4
LBF32:  .word $0000, $003C          ;VCTR 60,0,0
LBF36:  .word $408A                 ;SVEC 20,0,4
LBF38:  .word $5180                 ;SVEC 0,-30,4
LBF3A:  .word $4096                 ;SVEC -20,0,4
LBF3C:  .word $0000, $1FC4          ;VCTR -60,0,0
LBF40:  .word $0000, $9FD8          ;VCTR -40,0,4
LBF44:  .word $0000, $1FC4          ;VCTR -60,0,0
LBF48:  .word $0000, $9FD8          ;VCTR -40,0,4
LBF4C:  .word $0000, $1FC4          ;VCTR -60,0,0
LBF50:  .word $0000, $9FD8          ;VCTR -40,0,4
LBF54:  .word (((vg_cntr-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_cntr

s1_xmit_mark:
LBF56:  .word $003C, $1FEC          ;VCTR -20,60,0  mark for one transmission sent: an upright capsule 50 wide and 134 high with two uprights and bowed sides inside, 16 vectors at intensities 5 to 7. page 1 vw_xmit_marks and vw_xmit_mark_new (JSRL $293A)
LBF5A:  .word $0007, $C00A          ;VCTR 10,7,6
LBF5E:  .word $40CA                 ;SVEC 20,0,6
LBF60:  .word $1FF9, $C00A          ;VCTR 10,-7,6
LBF64:  .word $1F88, $C000          ;VCTR 0,-120,6
LBF68:  .word $1FF9, $DFF6          ;VCTR -10,-7,6
LBF6C:  .word $40D6                 ;SVEC -20,0,6
LBF6E:  .word $0007, $DFF6          ;VCTR -10,7,6
LBF72:  .word $0078, $C000          ;VCTR 0,120,6
LBF76:  .word $1FF1, $0000          ;VCTR 0,-15,0
LBF7A:  .word $1FF1, $BFFB          ;VCTR -5,-15,5
LBF7E:  .word $1FC4, $A000          ;VCTR 0,-60,5
LBF82:  .word $1FF1, $A005          ;VCTR 5,-15,5
LBF86:  .word $5505                 ;SVEC 10,-22,0
LBF88:  .word $0086, $E000          ;VCTR 0,134,7
LBF8C:  .word $400A                 ;SVEC 20,0,0
LBF8E:  .word $1F7A, $E000          ;VCTR 0,-134,7
LBF92:  .word $4B05                 ;SVEC 10,22,0
LBF94:  .word $000F, $A005          ;VCTR 5,15,5
LBF98:  .word $003C, $A000          ;VCTR 0,60,5
LBF9C:  .word $000F, $BFFB          ;VCTR -5,15,5
LBFA0:  .word (((vg_cntr-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_cntr

s1_adv_frame:
LBFA2:  .word $0000, $1F06          ;VCTR -250,0,0  frame of the walker part's advance indicator: a box 800 wide and 75 high, 4 vectors. page 1 vw_walker_ind (JSRL $2986)
LBFA6:  .word $004B, $E000          ;VCTR 0,75,7
LBFAA:  .word $0000, $E320          ;VCTR 800,0,7
LBFAE:  .word $1FB5, $E000          ;VCTR 0,-75,7
LBFB2:  .word $0000, $FCE0          ;VCTR -800,0,7
LBFB6:  .word (((vg_cntr-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_cntr

s1_adv_slots:
LBFB8:  .word $4F16                 ;SVEC -20,30,0  the four slots of the walker indicator: a box 400 wide and 15 high at intensity 4 whose top and bottom are broken by four gaps of 40. vw_walker_ind (JSRL $299C)
LBFBA:  .word $4091                 ;SVEC -30,0,4
LBFBC:  .word $000F, $8000          ;VCTR 0,15,4
LBFC0:  .word $408F                 ;SVEC 30,0,4
LBFC2:  .word $0000, $0028          ;VCTR 40,0,0
LBFC6:  .word $0000, $803C          ;VCTR 60,0,4
LBFCA:  .word $0000, $0028          ;VCTR 40,0,0
LBFCE:  .word $0000, $803C          ;VCTR 60,0,4
LBFD2:  .word $0000, $0028          ;VCTR 40,0,0
LBFD6:  .word $0000, $803C          ;VCTR 60,0,4
LBFDA:  .word $0000, $0028          ;VCTR 40,0,0
LBFDE:  .word $408F                 ;SVEC 30,0,4
LBFE0:  .word $1FF1, $8000          ;VCTR 0,-15,4
LBFE4:  .word $4091                 ;SVEC -30,0,4
LBFE6:  .word $0000, $1FD8          ;VCTR -40,0,0
LBFEA:  .word $0000, $9FC4          ;VCTR -60,0,4
LBFEE:  .word $0000, $1FD8          ;VCTR -40,0,0
LBFF2:  .word $0000, $9FC4          ;VCTR -60,0,4
LBFF6:  .word $0000, $1FD8          ;VCTR -40,0,0
LBFFA:  .word $0000, $9FC4          ;VCTR -60,0,4
LBFFE:  .word (((vg_cntr-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_cntr

s1_gen_mark:
LC000:  .word $471B                 ;SVEC -10,14,0  mark for one part of the power generator still standing: a six-sided upright 30 wide and 60 high with two uprights inside, 10 vectors. page 1 vw_gen_marks (JSRL $29E4)
LC002:  .word $40CA                 ;SVEC 20,0,6
LC004:  .word $000F, $A005          ;VCTR 5,15,5
LC008:  .word $4FA0                 ;SVEC 0,30,5
LC00A:  .word $000F, $BFFB          ;VCTR -5,15,5
LC00E:  .word $40D6                 ;SVEC -20,0,6
LC010:  .word $1FF1, $BFFB          ;VCTR -5,-15,5
LC014:  .word $51A0                 ;SVEC 0,-30,5
LC016:  .word $1FF1, $A005          ;VCTR 5,-15,5
LC01A:  .word $003C, $C000          ;VCTR 0,60,6
LC01E:  .word $400A                 ;SVEC 20,0,0
LC020:  .word $1FC4, $C000          ;VCTR 0,-60,6
LC024:  .word (((vg_cntr-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_cntr

s1_gen_burst:
LC026:  .word $0007, $0000          ;VCTR 0,7,0  burst for a generator mark just lost: 13 short strokes in the space of the mark. page 1 vw_gen_mark_lost draws it growing and fading (JSRL $2A0A)
LC02A:  .word $000F, $E00A          ;VCTR 10,15,7
LC02E:  .word $1FF9, $E005          ;VCTR 5,-7,7
LC032:  .word $1FF8, $FFFB          ;VCTR -5,-8,7
LC036:  .word $0008, $FFFB          ;VCTR -5,8,7
LC03A:  .word $0000, $1FFB          ;VCTR -5,0,0
LC03E:  .word $0007, $FFFB          ;VCTR -5,7,7
LC042:  .word $000F, $E00A          ;VCTR 10,15,7
LC046:  .word $4400                 ;SVEC 0,8,0
LC048:  .word $0007, $FFFB          ;VCTR -5,7,7
LC04C:  .word $1FF1, $FFF6          ;VCTR -10,-15,7
LC050:  .word $1FF9, $E005          ;VCTR 5,-7,7
LC054:  .word $0007, $0005          ;VCTR 5,7,0
LC058:  .word $0008, $FFFB          ;VCTR -5,8,7
LC05C:  .word $0000, $1FFB          ;VCTR -5,0,0
LC060:  .word $000F, $E00A          ;VCTR 10,15,7
LC064:  .word $0007, $1FFB          ;VCTR -5,7,0
LC068:  .word $1FF1, $FFF6          ;VCTR -10,-15,7
LC06C:  .word $4005                 ;SVEC 10,0,0
LC06E:  .word $0008, $FFFB          ;VCTR -5,8,7
LC072:  .word (((vg_cntr-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_cntr

s2_vader:
LC074:  .word $1F88, $0000          ;VCTR 0,-120,0  display list set 2, $2800-$2C55 in vector RAM: loaded by wave3_init (TIE fighters), phi_asteroids and phi_set_done (the wave completed screen). first list: Darth Vader's helmet from the front, 1140 wide and 1005 high, 79 vectors, 72 in colour 1 and the 7 of the mouth grille in colour 5. vew_wave_bonus draws it on the wave completed screen (JSRL $2800), and so would vew_die_plain, the view of a phase that nothing enters. identified by its shape only
LC078:  .word $6180                 ;STAT colour 1, brightness $80
LC07A:  .word $400A                 ;SVEC 20,0,0
LC07C:  .word $0000, $FFD8          ;VCTR -40,0,7
LC080:  .word $002D, $E00A          ;VCTR 10,45,7
LC084:  .word $004B, $FFF6          ;VCTR -10,75,7
LC088:  .word $002D, $FFD8          ;VCTR -40,45,7
LC08C:  .word $1FF1, $FFC4          ;VCTR -60,-15,7
LC090:  .word $1FC4, $FFD8          ;VCTR -40,-60,7
LC094:  .word $1F88, $E00A          ;VCTR 10,-120,7
LC098:  .word $1F88, $E028          ;VCTR 40,-120,7
LC09C:  .word $0096, $E05A          ;VCTR 90,150,7
LC0A0:  .word $000F, $1FF6          ;VCTR -10,15,0
LC0A4:  .word $1F88, $9FB0          ;VCTR -80,-120,4
LC0A8:  .word $0069, $9FEC          ;VCTR -20,105,4
LC0AC:  .word $003C, $806E          ;VCTR 110,60,4
LC0B0:  .word $1FE2, $9FB0          ;VCTR -80,-30,4
LC0B4:  .word $001E, $9FD8          ;VCTR -40,30,4
LC0B8:  .word $1FF1, $0082          ;VCTR 130,-15,0
LC0BC:  .word $40EA                 ;SVEC 20,0,7
LC0BE:  .word $004B, $E00A          ;VCTR 10,75,7
LC0C2:  .word $002D, $E028          ;VCTR 40,45,7
LC0C6:  .word $1FF1, $E03C          ;VCTR 60,-15,7
LC0CA:  .word $1FC4, $E028          ;VCTR 40,-60,7
LC0CE:  .word $1F88, $FFF6          ;VCTR -10,-120,7
LC0D2:  .word $1F88, $FFD8          ;VCTR -40,-120,7
LC0D6:  .word $0096, $FFA6          ;VCTR -90,150,7
LC0DA:  .word $002D, $FFF6          ;VCTR -10,45,7
LC0DE:  .word $510A                 ;SVEC 20,-30,0
LC0E0:  .word $1F88, $8050          ;VCTR 80,-120,4
LC0E4:  .word $0069, $8014          ;VCTR 20,105,4
LC0E8:  .word $003C, $9F92          ;VCTR -110,60,4
LC0EC:  .word $1FE2, $8050          ;VCTR 80,-30,4
LC0F0:  .word $001E, $8028          ;VCTR 40,30,4
LC0F4:  .word $1E89, $1EC0          ;VCTR -320,-375,0
LC0F8:  .word $004B, $FF9C          ;VCTR -100,75,7
LC0FC:  .word $004B, $E000          ;VCTR 0,75,7
LC100:  .word $010E, $E046          ;VCTR 70,270,7
LC104:  .word $00D2, $E014          ;VCTR 20,210,7
LC108:  .word $0069, $E032          ;VCTR 50,105,7
LC10C:  .word $004B, $E050          ;VCTR 80,75,7
LC110:  .word $0000, $E078          ;VCTR 120,0,7
LC114:  .word $1FB5, $E050          ;VCTR 80,-75,7
LC118:  .word $1F97, $E032          ;VCTR 50,-105,7
LC11C:  .word $1F2E, $E014          ;VCTR 20,-210,7
LC120:  .word $1EF2, $E046          ;VCTR 70,-270,7
LC124:  .word $1FB5, $E000          ;VCTR 0,-75,7
LC128:  .word $1FB5, $FF9C          ;VCTR -100,-75,7
LC12C:  .word $01A4, $001E          ;VCTR 30,420,0
LC130:  .word $004B, $FFBA          ;VCTR -70,75,7
LC134:  .word $000F, $FFB0          ;VCTR -80,15,7
LC138:  .word $1FD3, $FFC4          ;VCTR -60,-45,7
LC13C:  .word $002D, $FFC4          ;VCTR -60,45,7
LC140:  .word $1FF1, $FFB0          ;VCTR -80,-15,7
LC144:  .word $1FB5, $FFBA          ;VCTR -70,-75,7
LC148:  .word $0069, $0046          ;VCTR 70,105,0
LC14C:  .word $000F, $E050          ;VCTR 80,15,7
LC150:  .word $1FE2, $E028          ;VCTR 40,-30,7
LC154:  .word $011D, $E000          ;VCTR 0,285,7
LC158:  .word $0000, $0028          ;VCTR 40,0,0
LC15C:  .word $1EE3, $E000          ;VCTR 0,-285,7
LC160:  .word $001E, $E028          ;VCTR 40,30,7
LC164:  .word $1FF1, $E050          ;VCTR 80,-15,7
LC168:  .word $1D30, $1D3A          ;VCTR -710,-720,0
LC16C:  .word $00D2, $A1A4          ;VCTR 420,210,5
LC170:  .word $0087, $A01E          ;VCTR 30,135,5
LC174:  .word $000F, $A00A          ;VCTR 10,15,5
LC178:  .word $0000, $A0DC          ;VCTR 220,0,5
LC17C:  .word $1FF1, $A00A          ;VCTR 10,-15,5
LC180:  .word $0000, $BF10          ;VCTR -240,0,5
LC184:  .word $1FB5, $A064          ;VCTR 100,-75,5
LC188:  .word $0000, $A028          ;VCTR 40,0,5
LC18C:  .word $004B, $A064          ;VCTR 100,75,5
LC190:  .word $1F79, $A01E          ;VCTR 30,-135,5
LC194:  .word $1F2E, $A1A4          ;VCTR 420,-210,5
LC198:  .word $01E0, $1E84          ;VCTR -380,480,0
LC19C:  .word $1F88, $7FB0          ;VCTR -80,-120,3
LC1A0:  .word $000F, $000A          ;VCTR 10,15,0
LC1A4:  .word $1FF1, $600A          ;VCTR 10,-15,3
LC1A8:  .word $1FF1, $7FF6          ;VCTR -10,-15,3
LC1AC:  .word $000F, $000A          ;VCTR 10,15,0
LC1B0:  .word $002D, $6046          ;VCTR 70,45,3
LC1B4:  .word $004B, $1E7A          ;VCTR -390,75,0
LC1B8:  .word $1F88, $6050          ;VCTR 80,-120,3
LC1BC:  .word $000F, $1FF6          ;VCTR -10,15,0
LC1C0:  .word $1FF1, $7FF6          ;VCTR -10,-15,3
LC1C4:  .word $1FF1, $600A          ;VCTR 10,-15,3
LC1C8:  .word $000F, $1FF6          ;VCTR -10,15,0
LC1CC:  .word $002D, $7FBA          ;VCTR -70,45,3
LC1D0:  .word $6580                 ;STAT colour 5, brightness $80
LC1D2:  .word $000F, $008C          ;VCTR 140,15,0
LC1D6:  .word $1FD3, $C000          ;VCTR 0,-45,6
LC1DA:  .word $400A                 ;SVEC 20,0,0
LC1DC:  .word $004B, $C000          ;VCTR 0,75,6
LC1E0:  .word $4F0A                 ;SVEC 20,30,0
LC1E2:  .word $1F97, $C000          ;VCTR 0,-105,6
LC1E6:  .word $400A                 ;SVEC 20,0,0
LC1E8:  .word $0078, $C000          ;VCTR 0,120,6
LC1EC:  .word $1FF1, $0014          ;VCTR 20,-15,0
LC1F0:  .word $1F97, $C000          ;VCTR 0,-105,6
LC1F4:  .word $400A                 ;SVEC 20,0,0
LC1F6:  .word $004B, $C000          ;VCTR 0,75,6
LC1FA:  .word $510A                 ;SVEC 20,-30,0
LC1FC:  .word $1FD3, $C000          ;VCTR 0,-45,6
LC200:  .word (((vg_scal_cntr-VGBASE)/2)&$1FFF)+$E000 ;JMPL vg_scal_cntr

s2_executor:
LC202:  .word $6780                 ;STAT colour 7, brightness $80  the Executor: colour 7 at brightness $80, then the same 60 vectors as s0_executor. VWDTHB, exec_slide_in, exec_slide_on and exec_drift_left draw it in the TIE fighter and asteroid parts (JSRL $298E)
LC204:  .word $0000, $1CE0          ;VCTR -800,0,0
LC208:  .word $0000, $C514          ;VCTR 1300,0,6
LC20C:  .word $1FF1, $C000          ;VCTR 0,-15,6
LC210:  .word $0000, $DAEC          ;VCTR -1300,0,6
LC214:  .word $000F, $C000          ;VCTR 0,15,6
LC218:  .word $0000, $003C          ;VCTR 60,0,0
LC21C:  .word $002D, $A280          ;VCTR 640,45,5
LC220:  .word $001E, $A096          ;VCTR 150,30,5
LC224:  .word $1FD3, $1E3E          ;VCTR -450,-45,0
LC228:  .word $000F, $6000          ;VCTR 0,15,3
LC22C:  .word $0000, $612C          ;VCTR 300,0,3
LC230:  .word $000F, $6000          ;VCTR 0,15,3
LC234:  .word $0000, $7F9C          ;VCTR -100,0,3
LC238:  .word $1FF1, $6000          ;VCTR 0,-15,3
LC23C:  .word $001E, $00FA          ;VCTR 250,30,0
LC240:  .word $4FA0                 ;SVEC 0,30,5
LC242:  .word $0000, $A064          ;VCTR 100,0,5
LC246:  .word $002D, $A000          ;VCTR 0,45,5
LC24A:  .word $0000, $0190          ;VCTR 400,0,0
LC24E:  .word $0000, $BE1B          ;VCTR -485,0,5
LC252:  .word $0016, $BF8D          ;VCTR -115,22,5
LC256:  .word $0000, $BFCE          ;VCTR -50,0,5
LC25A:  .word $0017, $A000          ;VCTR 0,23,5
LC25E:  .word $0000, $A032          ;VCTR 50,0,5
LC262:  .word $001E, $A064          ;VCTR 100,30,5
LC266:  .word $0000, $A0FA          ;VCTR 250,0,5
LC26A:  .word $1FDA, $A064          ;VCTR 100,-38,5
LC26E:  .word $0000, $A096          ;VCTR 150,0,5
LC272:  .word $0026, $A032          ;VCTR 50,38,5
LC276:  .word $0000, $A032          ;VCTR 50,0,5
LC27A:  .word $4BA0                 ;SVEC 0,22,5
LC27C:  .word $0000, $A0B9          ;VCTR 185,0,5
LC280:  .word $1FEA, $A00F          ;VCTR 15,-22,5
LC284:  .word $0016, $1FF1          ;VCTR -15,22,0
LC288:  .word $1FEA, $A005          ;VCTR 5,-22,5
LC28C:  .word $40A5                 ;SVEC 10,0,5
LC28E:  .word $1FDA, $A000          ;VCTR 0,-38,5
LC292:  .word $40BB                 ;SVEC -10,0,5
LC294:  .word $0026, $A000          ;VCTR 0,38,5
LC298:  .word $1FDA, $0000          ;VCTR 0,-38,0
LC29C:  .word $1F90, $BEC5          ;VCTR -315,-112,5
LC2A0:  .word $1FB5, $BFE7          ;VCTR -25,-75,5
LC2A4:  .word $1FF1, $A000          ;VCTR 0,-15,5
LC2A8:  .word $1F79, $A064          ;VCTR 100,-135,5
LC2AC:  .word $0087, $A04B          ;VCTR 75,135,5
LC2B0:  .word $005A, $A000          ;VCTR 0,90,5
LC2B4:  .word $0070, $A0AF          ;VCTR 175,112,5
LC2B8:  .word $1EAF, $1F06          ;VCTR -250,-337,0
LC2BC:  .word $0008, $BFC9          ;VCTR -55,8,5
LC2C0:  .word $1FF1, $8000          ;VCTR 0,-15,4
LC2C4:  .word $0000, $9F6F          ;VCTR -145,0,4
LC2C8:  .word $000F, $8000          ;VCTR 0,15,4
LC2CC:  .word $000F, $9FE7          ;VCTR -25,15,4
LC2D0:  .word $1FF1, $00AA          ;VCTR 170,-15,0
LC2D4:  .word $000F, $BF56          ;VCTR -170,15,5
LC2D8:  .word $0000, $BEED          ;VCTR -275,0,5
LC2DC:  .word $0069, $BC7C          ;VCTR -900,105,5
LC2E0:  .word $4BA0                 ;SVEC 0,22,5
LC2E2:  .word $1FB5, $0352          ;VCTR 850,-75,0
LC2E6:  .word $0000, $815E          ;VCTR 350,0,4
LC2EA:  .word $1FF1, $00B4          ;VCTR 180,-15,0
LC2EE:  .word $0000, $8028          ;VCTR 40,0,4
LC2F2:  .word $0035, $001E          ;VCTR 30,53,0
LC2F6:  .word $0000, $9F9C          ;VCTR -100,0,4
LC2FA:  .word $0025, $1FE7          ;VCTR -25,37,0
LC2FE:  .word $0000, $8091          ;VCTR 145,0,4
LC302:  .word $0025, $1FF6          ;VCTR -10,37,0
LC306:  .word $0000, $9F83          ;VCTR -125,0,4
LC30A:  .word $0026, $000F          ;VCTR 15,38,0
LC30E:  .word $0000, $8064          ;VCTR 100,0,4
LC312:  .word $0000, $1F38          ;VCTR -200,0,0
LC316:  .word $0000, $DEA2          ;VCTR -350,0,6
LC31A:  .word $007F, $00C8          ;VCTR 200,127,0
LC31E:  .word $0000, $DF06          ;VCTR -250,0,6
LC322:  .word $0017, $0023          ;VCTR 35,23,0
LC326:  .word $0016, $C00F          ;VCTR 15,22,6
LC32A:  .word $0000, $C064          ;VCTR 100,0,6
LC32E:  .word $1FEA, $C00F          ;VCTR 15,-22,6
LC332:  .word $C000                 ;RTSL

s2_flash0:
LC334:  .word $02D0, $1F10          ;VCTR -240,720,0  asteroid hit flash picture 0 of 5: draws nothing itself, the triangle kept in vector RAM $0024 at eight places scattered up to 960 from the start point. called through aflash_tab by page 2 astrd_flash_draw
LC338:  .word $A012                 ;JSRL $0024
LC33A:  .word $1E98, $1F10          ;VCTR -240,-360,0
LC33E:  .word $A012                 ;JSRL $0024
LC340:  .word $0000, $0168          ;VCTR 360,0,0
LC344:  .word $A012                 ;JSRL $0024
LC346:  .word $1D30, $1F10          ;VCTR -240,-720,0
LC34A:  .word $A012                 ;JSRL $0024
LC34C:  .word $1E98, $1F10          ;VCTR -240,-360,0
LC350:  .word $A012                 ;JSRL $0024
LC352:  .word $02D0, $0078          ;VCTR 120,720,0
LC356:  .word $A012                 ;JSRL $0024
LC358:  .word $0168, $05A0          ;VCTR 1440,360,0
LC35C:  .word $A012                 ;JSRL $0024
LC35E:  .word $1D30, $0000          ;VCTR 0,-720,0
LC362:  .word $A012                 ;JSRL $0024
LC364:  .word $C000                 ;RTSL

s2_flash1:
LC366:  .word $02D0, $1E98          ;VCTR -360,720,0  asteroid hit flash picture 1 of 5: draws nothing itself, the triangle kept in vector RAM $0024 at eight places scattered up to 900 from the start point
LC36A:  .word $A012                 ;JSRL $0024
LC36C:  .word $00B4, $00F0          ;VCTR 240,180,0
LC370:  .word $A012                 ;JSRL $0024
LC372:  .word $0000, $00F0          ;VCTR 240,0,0
LC376:  .word $A012                 ;JSRL $0024
LC378:  .word $1F4C, $00F0          ;VCTR 240,-180,0
LC37C:  .word $A012                 ;JSRL $0024
LC37E:  .word $1DE4, $1DA8          ;VCTR -600,-540,0
LC382:  .word $A012                 ;JSRL $0024
LC384:  .word $0000, $01E0          ;VCTR 480,0,0
LC388:  .word $A012                 ;JSRL $0024
LC38A:  .word $1D30, $1D30          ;VCTR -720,-720,0
LC38E:  .word $A012                 ;JSRL $0024
LC390:  .word $0000, $03C0          ;VCTR 960,0,0
LC394:  .word $A012                 ;JSRL $0024
LC396:  .word $C000                 ;RTSL

s2_flash2:
LC398:  .word $021C, $02D0          ;VCTR 720,540,0  asteroid hit flash picture 2 of 5: draws nothing itself, the triangle kept in vector RAM $0024 at eight places scattered up to 1080 from the start point
LC39C:  .word $A012                 ;JSRL $0024
LC39E:  .word $1F4C, $1E20          ;VCTR -480,-180,0
LC3A2:  .word $A012                 ;JSRL $0024
LC3A4:  .word $1E98, $00F0          ;VCTR 240,-360,0
LC3A8:  .word $A012                 ;JSRL $0024
LC3AA:  .word $1DE4, $1F88          ;VCTR -120,-540,0
LC3AE:  .word $A012                 ;JSRL $0024
LC3B0:  .word $1F4C, $0168          ;VCTR 360,-180,0
LC3B4:  .word $A012                 ;JSRL $0024
LC3B6:  .word $1E98, $1DA8          ;VCTR -600,-360,0
LC3BA:  .word $A012                 ;JSRL $0024
LC3BC:  .word $0438, $1CB8          ;VCTR -840,1080,0
LC3C0:  .word $A012                 ;JSRL $0024
LC3C2:  .word $1E98, $1F10          ;VCTR -240,-360,0
LC3C6:  .word $A012                 ;JSRL $0024
LC3C8:  .word $C000                 ;RTSL

s2_flash3:
LC3CA:  .word $021C, $1E98          ;VCTR -360,540,0  asteroid hit flash picture 3 of 5: draws nothing itself, the triangle kept in vector RAM $0024 at eight places scattered up to 900 from the start point
LC3CE:  .word $A012                 ;JSRL $0024
LC3D0:  .word $1D30, $1F10          ;VCTR -240,-720,0
LC3D4:  .word $A012                 ;JSRL $0024
LC3D6:  .word $1F4C, $0168          ;VCTR 360,-180,0
LC3DA:  .word $A012                 ;JSRL $0024
LC3DC:  .word $1DE4, $0078          ;VCTR 120,-540,0
LC3E0:  .word $A012                 ;JSRL $0024
LC3E2:  .word $0000, $00F0          ;VCTR 240,0,0
LC3E6:  .word $A012                 ;JSRL $0024
LC3E8:  .word $021C, $0078          ;VCTR 120,540,0
LC3EC:  .word $A012                 ;JSRL $0024
LC3EE:  .word $00B4, $0168          ;VCTR 360,180,0
LC3F2:  .word $A012                 ;JSRL $0024
LC3F4:  .word $02D0, $1F10          ;VCTR -240,720,0
LC3F8:  .word $A012                 ;JSRL $0024
LC3FA:  .word $C000                 ;RTSL

s2_flash4:
LC3FC:  .word $0168, $0000          ;VCTR 0,360,0  asteroid hit flash picture 4 of 5: draws nothing itself, the triangle kept in vector RAM $0024 at eight places on a diamond 480 wide and 720 high round the start point
LC400:  .word $A012                 ;JSRL $0024
LC402:  .word $1F4C, $0078          ;VCTR 120,-180,0
LC406:  .word $A012                 ;JSRL $0024
LC408:  .word $1F4C, $0078          ;VCTR 120,-180,0
LC40C:  .word $A012                 ;JSRL $0024
LC40E:  .word $1F4C, $1F88          ;VCTR -120,-180,0
LC412:  .word $A012                 ;JSRL $0024
LC414:  .word $1F4C, $1F88          ;VCTR -120,-180,0
LC418:  .word $A012                 ;JSRL $0024
LC41A:  .word $00B4, $1F88          ;VCTR -120,180,0
LC41E:  .word $A012                 ;JSRL $0024
LC420:  .word $00B4, $1F88          ;VCTR -120,180,0
LC424:  .word $A012                 ;JSRL $0024
LC426:  .word $00B4, $0078          ;VCTR 120,180,0
LC42A:  .word $A012                 ;JSRL $0024
LC42C:  .word $C000                 ;RTSL

s2_tri_up:
LC42E:  .word $0057, $0000          ;VCTR 0,87,0  triangle of 3 vectors round the start point, point up, 100 wide and 130 high. the IRQ puts a JMPL to one of the four in vector RAM $0024 every frame (tri_tab, in the order left, down, right, up), so the triangles of a flash picture turn
LC432:  .word $1F7E, $FFCE          ;VCTR -50,-130,7
LC436:  .word $0000, $E064          ;VCTR 100,0,7
LC43A:  .word $0082, $FFCE          ;VCTR -50,130,7
LC43E:  .word $1FA9, $0000          ;VCTR 0,-87,0
LC442:  .word $C000                 ;RTSL

s2_tri_right:
LC444:  .word $004B, $1FE3          ;VCTR -29,75,0  triangle of 3 vectors round the start point, point to the right, 87 wide and 150 high
LC448:  .word $1F6A, $E000          ;VCTR 0,-150,7
LC44C:  .word $004B, $E057          ;VCTR 87,75,7
LC450:  .word $004B, $FFA9          ;VCTR -87,75,7
LC454:  .word $1FB5, $001D          ;VCTR 29,-75,0
LC458:  .word $C000                 ;RTSL

s2_tri_down:
LC45A:  .word $002B, $1FCE          ;VCTR -50,43,0  triangle of 3 vectors round the start point, point down, 100 wide and 130 high
LC45E:  .word $1F7E, $E032          ;VCTR 50,-130,7
LC462:  .word $0082, $E032          ;VCTR 50,130,7
LC466:  .word $0000, $FF9C          ;VCTR -100,0,7
LC46A:  .word $1FD5, $0032          ;VCTR 50,-43,0
LC46E:  .word $C000                 ;RTSL

s2_tri_left:
LC470:  .word $0000, $1FC6          ;VCTR -58,0,0  triangle of 3 vectors round the start point, point to the left, 86 wide and 150 high
LC474:  .word $1FB5, $E056          ;VCTR 86,-75,7
LC478:  .word $0096, $E000          ;VCTR 0,150,7
LC47C:  .word $1FB5, $FFAA          ;VCTR -86,-75,7
LC480:  .word $0000, $003A          ;VCTR 58,0,0
LC484:  .word $C000                 ;RTSL

s2_x_burst:
LC486:  .word $A015                 ;JSRL $002A  the flash colour (JSRL $002A), then two crossed zigzag strokes, 580 wide and 780 high, 14 vectors. no caller found
LC488:  .word $401B                 ;SVEC -10,0,0
LC48A:  .word $0186, $FEE8          ;VCTR -280,390,7
LC48E:  .word $1DE4, $E168          ;VCTR 360,-540,7
LC492:  .word $0096, $FFC4          ;VCTR -60,150,7
LC496:  .word $1E7A, $E118          ;VCTR 280,-390,7
LC49A:  .word $021C, $FE98          ;VCTR -360,540,7
LC49E:  .word $1F6A, $E03C          ;VCTR 60,-150,7
LC4A2:  .word $4016                 ;SVEC -20,0,0
LC4A4:  .word $1E7A, $FEFC          ;VCTR -260,-390,7
LC4A8:  .word $0177, $E10E          ;VCTR 270,375,7
LC4AC:  .word $1F79, $FFCE          ;VCTR -50,-135,7
LC4B0:  .word $0069, $E046          ;VCTR 70,105,7
LC4B4:  .word $002D, $001E          ;VCTR 30,45,0
LC4B8:  .word $0186, $E104          ;VCTR 260,390,7
LC4BC:  .word $1E89, $FEF2          ;VCTR -270,-375,7
LC4C0:  .word $0087, $E032          ;VCTR 50,135,7
LC4C4:  .word $1F97, $FFBA          ;VCTR -70,-105,7
LC4C8:  .word $C000                 ;RTSL

;------------------------------------------------------------------------------
; DOXMT - DOXMT - XMT TO SOUND BOARD
;   A := ID OF REQUESTED SOUND
;   ALL INDEX REGS MUST BE SAVED
;   ABOUT 50 CYCLE LATENCY FOR SOUND BOARD
;   USE SAFETY FACTOR OF 4 FOR 200 CYCLES
;   15 CYCLES PER FOLLOWING LOOP*14. IS 210.
;------------------------------------------------------------------------------
DOXMT:
LC4CA:  LDB  #$0E                   ;TIME OUT THE SOUND BOARD
LC4CC:  TST  R_STAS                 ;D7 HI SAYS PREVIOUS XMT STILL THERE
LC4CF:  BPL  DOXMT_30               ;SKIP OUT WHEN ROOM FOR MORE DATA
LC4D1:  DECB
LC4D2:  BNE  LC4CC                  ;EQEND
LC4D4:  LDA  #$00                   ;TOOK TOO LONG TO PROCESS,

;SO SOFTWARE RESET SOUND BOARD
DOXMT_30:
LC4D6:  STA  W_XMTS                 ;SHIP IT OUT
LC4D9:  RTS

;------------------------------------------------------------------------------
; doxmt_gated - send sound command A to the sound board through DOXMT, but only while snd_mute is zero - when it
;   is set the command is dropped. the effect stubs from $32 up jump here, except $34, $36, $40, $44 and $52, so
;   the dying phases, which set snd_mute to 1, silence the effects. bank 1 has its own copy at K6530
;------------------------------------------------------------------------------
doxmt_gated:
LC4DA:  LDB  snd_mute               ;effects are dropped while this is nonzero
LC4DD:  BEQ  DOXMT
LC4DF:  RTS

;------------------------------------------------------------------------------
; AUDTST - SNDPBX - XMT,RCV ROUTINE TAGS
;   USE POKEY AND SPEECH RIGHT AWAY FOR IMPATIENT TECHS
;------------------------------------------------------------------------------
AUDTST:
LC4E0:  LDA  #IDATST                ;AUD TST  SOUND EFFECT POKEY TEST TONES  nothing calls this stub or the next one: the sound test sends $01 and $02 from its table
LC4E2:  JMP  DOXMT

;------------------------------------------------------------------------------
; PMTST - [note] Request music channel POKEY test tones: A = IDPTST, jump to DOXMT
;------------------------------------------------------------------------------
PMTST:
LC4E5:  LDA  #IDPTST                ;PM TST  MUSIC CHANNEL POKEY TEST TONES
LC4E7:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_03 - sound stub: sends command $03 through DOXMT, which on ESB's sound board is speech, phrase 10 of
;   its table. sent by page 0 (P0_8F5B) in the walker part when w2_spk_cnt reaches 20. the Star Wars name SPKALW
;   was carried here by the command number, which meant another sound there
;------------------------------------------------------------------------------
spk_cmd_03:
LC4EA:  LDA  #$03
LC4EC:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_04 - sound stub: sends command $04 through DOXMT, which on ESB's sound board is speech, phrase 15 of
;   its table. sent by DO1GAS when one shield is left in the probot and walker parts. the Star Wars name SPKELE
;   was carried here by the command number, which meant another sound there
;------------------------------------------------------------------------------
spk_cmd_04:
LC4EF:  LDA  #$04
LC4F1:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_05 - sound stub: sends command $05 through DOXMT, which on ESB's sound board is speech, phrase 9 of
;   its table. sent by page 2 (P2_92F3) at the first probot shot down in a game (foa_said). the Star Wars name
;   SPKFOA was carried here by the command number, which meant another sound there
;------------------------------------------------------------------------------
spk_cmd_05:
LC4F4:  LDA  #$05
LC4F6:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_06 - sound stub: sends command $06 through DOXMT, which on ESB's sound board is speech, phrase 1 of
;   its table. sent by S2VW (pages 2 and 3) when a ship starts a pass-by. the sound board says it only when no
;   speech is under way. the Star Wars name SPKFOR was carried here by the command number, which meant another
;   sound there
;------------------------------------------------------------------------------
spk_cmd_06:
LC4F9:  LDA  #$06
LC4FB:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_07 - sound stub: sends command $07 through DOXMT, which on ESB's sound board is speech, phrase 3 of
;   its table. sent by page 1 (P1_95C3) when a Jedi letter is awarded, except the third. the Star Wars name SPKGRE
;   was carried here by the command number, which meant another sound there
;------------------------------------------------------------------------------
spk_cmd_07:
LC4FE:  LDA  #$07
LC500:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_08 - sound stub: sends command $08 through DOXMT, which on ESB's sound board is speech, phrase 23 of
;   its table. sent when the probot part ends in wave 2 (GM_WAV 1), and one of the four picked at random from wave
;   4 on (w1_end_spk). the Star Wars name SPKHAV was carried here by the command number, which meant another sound
;   there
;------------------------------------------------------------------------------
spk_cmd_08:
LC503:  LDA  #$08
LC505:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_09 - sound stub: sends command $09 through DOXMT, which on ESB's sound board is speech, phrase 12 of
;   its table. sent by page 0 (P0_9641) once in a walker part (hit_spk_done). the Star Wars name SPKHIT was
;   carried here by the command number, which meant another sound there
;------------------------------------------------------------------------------
spk_cmd_09:
LC508:  LDA  #$09
LC50A:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_0a - sound stub: sends command $0A through DOXMT, which on ESB's sound board is speech, phrase 17 of
;   its table. sent by IFRAME when the first credit comes in and by phe_jedi_award at frame 50. the Star Wars name
;   SPKI was carried here by the command number, which meant another sound there
;------------------------------------------------------------------------------
spk_cmd_0a:
LC50D:  LDA  #$0A
LC50F:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_0b - sound stub: sends command $0B through DOXMT, which on ESB's sound board is the warm start of the
;   speech chip, queued like a sentence (its SPKI). nothing calls this stub. the Star Wars name SPKIMO was carried
;   here by the command number, which meant another sound there
;------------------------------------------------------------------------------
spk_cmd_0b:
LC512:  LDA  #$0B                   ;nothing calls this stub
LC514:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_0c - sound stub: sends command $0C through DOXMT, which on ESB's sound board is speech, phrases 4, 2
;   and 5 of its table. sent by phi_set_done when a wave is completed. the Star Wars name SPKLET was carried here
;   by the command number, which meant another sound there
;------------------------------------------------------------------------------
spk_cmd_0c:
LC517:  LDA  #$0C
LC519:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_0d - sound stub: sends command $0D through DOXMT, which on ESB's sound board is speech, phrase 6 of
;   its table. sent by PHISG1 when the start switch is accepted. the Star Wars name SPKLOS was carried here by the
;   command number, which meant another sound there
;------------------------------------------------------------------------------
spk_cmd_0d:
LC51C:  LDA  #$0D
LC51E:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_0e - sound stub: sends command $0E through DOXMT, which on ESB's sound board is speech, phrase 19 of
;   its table. sent by the probot part's setup in the waves with an even GM_WAV. the Star Wars name SPKR2N was
;   carried here by the command number, which meant another sound there
;------------------------------------------------------------------------------
spk_cmd_0e:
LC521:  LDA  #$0E
LC523:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_0f - sound stub: sends command $0F through DOXMT, which on ESB's sound board is speech, phrase 13 of
;   its table. sent by the probot part's setup in the waves with an odd GM_WAV. the Star Wars name SPKR2T was
;   carried here by the command number, which meant another sound there
;------------------------------------------------------------------------------
spk_cmd_0f:
LC526:  LDA  #$0F
LC528:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_10 - sound stub: sends command $10 through DOXMT, which on ESB's sound board is speech, phrase 20 of
;   its table. sent when the probot part ends in wave 3 (GM_WAV 2), and one of the four picked at random from wave
;   4 on (w1_end_spk). the Star Wars name SPKRED was carried here by the command number, which meant another sound
;   there
;------------------------------------------------------------------------------
spk_cmd_10:
LC52B:  LDA  #$10
LC52D:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_11 - sound stub: sends command $11 through DOXMT, which on ESB's sound board is speech, phrase 22 of
;   its table. one of the four speeches picked at random when the probot part ends from wave 4 on (w1_end_spk).
;   the Star Wars name SPKREM was carried here by the command number, which meant another sound there
;------------------------------------------------------------------------------
spk_cmd_11:
LC530:  LDA  #$11
LC532:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_12 - sound stub: sends command $12 through DOXMT, which on ESB's sound board is speech, phrase 7 of
;   its table. sent by page 1 (P1_9C4B) when the walkers' advance reaches its last mark (prog_count 0) in a wave
;   with an even GM_WAV. the Star Wars name SPKSHK was carried here by the command number, which meant another
;   sound there
;------------------------------------------------------------------------------
spk_cmd_12:
LC535:  LDA  #$12
LC537:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_13 - sound stub: sends command $13 through DOXMT, which on ESB's sound board is the command that drops
;   the speech still waiting in its queue (its SPKSKP). sent before a speech that must not wait: by the five dying
;   phases, PHIEGM, the end of the probot part, DO1GAS and page 1 when a shot hits the ship. the Star Wars name
;   SPKSIZ was carried here by the command number, which meant another sound there
;------------------------------------------------------------------------------
spk_cmd_13:
LC53A:  LDA  #$13
LC53C:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_14 - sound stub: sends command $14 through DOXMT, which on ESB's sound board is speech, phrase 18 of
;   its table. sent by page 1 (P1_95BE) when the third Jedi letter is awarded. the Star Wars name SPKSKP was
;   carried here by the command number, which meant another sound there
;------------------------------------------------------------------------------
spk_cmd_14:
LC53F:  LDA  #$14
LC541:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_15 - sound stub: sends command $15 through DOXMT, which on ESB's sound board is speech, phrase 14 of
;   its table. sent by page 1 (P1_9C50) when the walkers' advance reaches its last mark in a wave with an odd
;   GM_WAV. the Star Wars name SPKSTA was carried here by the command number, which meant another sound there
;------------------------------------------------------------------------------
spk_cmd_15:
LC544:  LDA  #$15
LC546:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_16 - sound stub: sends command $16 through DOXMT, which on ESB's sound board is speech, phrase 21 of
;   its table. sent when the probot part ends in wave 1 (GM_WAV 0), and one of the four picked at random from wave
;   4 on (w1_end_spk). the Star Wars name SPKSTR was carried here by the command number, which meant another sound
;   there
;------------------------------------------------------------------------------
spk_cmd_16:
LC549:  LDA  #$16
LC54B:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_17 - sound stub: sends command $17 through DOXMT, which on ESB's sound board is speech, phrase 11 of
;   its table. sent by page 1 (P1_9C3C) when the walkers' advance passes its first mark (prog_count 3) while $4CD6
;   is 0. the Star Wars name SPKTHI was carried here by the command number, which meant another sound there
;------------------------------------------------------------------------------
spk_cmd_17:
LC54E:  LDA  #$17
LC550:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_18 - sound stub: sends command $18 through DOXMT, which on ESB's sound board is speech, phrase 8 of
;   its table. sent by the walker part's setup. the Star Wars name SPKTRU was carried here by the command number,
;   which meant another sound there
;------------------------------------------------------------------------------
spk_cmd_18:
LC553:  LDA  #$18
LC555:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_19 - sound stub: sends command $19 through DOXMT, which on ESB's sound board is speech, phrase 24 of
;   its table. sent by page 1 (P1_94E4), once a part, when a shot hits the ship while its shield still glows, in
;   the probot and walker parts. the Star Wars name SPKUSE was carried here by the command number, which meant
;   another sound there
;------------------------------------------------------------------------------
spk_cmd_19:
LC558:  LDA  #$19
LC55A:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_1a - sound stub: sends command $1A through DOXMT, which on ESB's sound board is speech, phrase 16 of
;   its table. sent at frame 8 of dying in the probot part, in the walker part and in the plain dying phase. the
;   Star Wars name SPKYAU was carried here by the command number, which meant another sound there
;------------------------------------------------------------------------------
spk_cmd_1a:
LC55D:  LDA  #$1A
LC55F:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_1b - sound stub: sends command $1B through DOXMT, which on ESB's sound board is speech, phrase 32 of
;   its table. sent at frame 8 of dying in the TIE fighter and asteroid parts. the Star Wars name PMBEN was
;   carried here by the command number, which meant another sound there
;------------------------------------------------------------------------------
spk_cmd_1b:
LC562:  LDA  #$1B
LC564:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_1c - sound stub: sends command $1C through DOXMT, which on ESB's sound board is speech, phrase 26 of
;   its table. sent by the asteroid part's setup in wave 1 (GM_WAV 0). the Star Wars name PMCNT was carried here
;   by the command number, which meant another sound there
;------------------------------------------------------------------------------
spk_cmd_1c:
LC567:  LDA  #$1C
LC569:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_1d - sound stub: sends command $1D through DOXMT, which on ESB's sound board is speech, phrase 29 of
;   its table. sent by page 1 (P1_94BD) at the first enemy shot that hits the ship in the TIE fighter part. the
;   Star Wars name PMDAR was carried here by the command number, which meant another sound there
;------------------------------------------------------------------------------
spk_cmd_1d:
LC56C:  LDA  #$1D
LC56E:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_1e - sound stub: sends command $1E through DOXMT, which on ESB's sound board is speech, phrases 35 and
;   36 of its table. sent by PHEEGM when a game without high score or continue offer ended in the probot or walker
;   part. the Star Wars name PMDES was carried here by the command number, which meant another sound there
;------------------------------------------------------------------------------
spk_cmd_1e:
LC571:  LDA  #$1E
LC573:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_1f - sound stub: sends command $1F through DOXMT, which on ESB's sound board is speech, phrase 34 of
;   its table. sent by the asteroid part's setup, after command $22, in the waves with an even GM_WAV from 2 on.
;   the Star Wars name PMEND was carried here by the command number, which meant another sound there
;------------------------------------------------------------------------------
spk_cmd_1f:
LC576:  LDA  #$1F
LC578:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_20 - sound stub: sends command $20 through DOXMT, which on ESB's sound board is speech, phrase 27 of
;   its table. sent by phe_asteroids 40 frames before the asteroid part ends. the Star Wars name PM4TH was carried
;   here by the command number, which meant another sound there
;------------------------------------------------------------------------------
spk_cmd_20:
LC57B:  LDA  #$20
LC57D:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_21 - sound stub: sends command $21 through DOXMT, which on ESB's sound board is speech, phrase 30 of
;   its table. sent by DO1GAS when the last shield is lost in the TIE fighter and asteroid parts. the Star Wars
;   name PMREB was carried here by the command number, which meant another sound there
;------------------------------------------------------------------------------
spk_cmd_21:
LC580:  LDA  #$21
LC582:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_22 - sound stub: sends command $22 through DOXMT, which on ESB's sound board is speech, phrase 37 of
;   its table. sent by the asteroid part's setup in the waves with an even GM_WAV from 2 on. the Star Wars name
;   PMRRP was carried here by the command number, which meant another sound there
;------------------------------------------------------------------------------
spk_cmd_22:
LC585:  LDA  #$22
LC587:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_23 - sound stub: sends command $23 through DOXMT, which on ESB's sound board is speech, phrase 31 of
;   its table. sent by wave2_exit_init when the walker part is over. the Star Wars name PMSF2 was carried here by
;   the command number, which meant another sound there
;------------------------------------------------------------------------------
spk_cmd_23:
LC58A:  LDA  #$23
LC58C:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_24 - sound stub: sends command $24 through DOXMT, which on ESB's sound board is speech, phrase 25 of
;   its table. sent by the TIE fighter part's setup. the Star Wars name PMTH5 was carried here by the command
;   number, which meant another sound there
;------------------------------------------------------------------------------
spk_cmd_24:
LC58F:  LDA  #$24
LC591:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_25 - sound stub: sends command $25 through DOXMT, which on ESB's sound board is speech, phrase 38 of
;   its table. sent by page 1 (P1_94C9) at the first enemy shot that hits the ship in the asteroid part. the Star
;   Wars name PMTHB was carried here by the command number, which meant another sound there
;------------------------------------------------------------------------------
spk_cmd_25:
LC594:  LDA  #$25
LC596:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_26 - sound stub: sends command $26 through DOXMT, which on ESB's sound board is speech, phrase 39 of
;   its table. sent by the asteroid part's setup in the waves with an odd GM_WAV. the Star Wars name AUDCR was
;   carried here by the command number, which meant another sound there
;------------------------------------------------------------------------------
spk_cmd_26:
LC599:  LDA  #$26
LC59B:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_27 - sound stub: sends command $27 through DOXMT, which on ESB's sound board is speech, phrase 33 of
;   its table. sent by page 1 (P1_94E9), once a part, when a shot hits the ship while its shield still glows, in
;   the TIE fighter and asteroid parts. the Star Wars name AUDDF was carried here by the command number, which
;   meant another sound there
;------------------------------------------------------------------------------
spk_cmd_27:
LC59E:  LDA  #$27
LC5A0:  JMP  DOXMT

;------------------------------------------------------------------------------
; spk_cmd_28 - sound stub: sends command $28 through DOXMT, which on ESB's sound board is speech, phrase 40 of
;   its table. nothing calls this stub. the sound board says it only when no speech is under way. the Star Wars
;   name AUDDR was carried here by the command number, which meant another sound there
;------------------------------------------------------------------------------
spk_cmd_28:
LC5A3:  LDA  #$28                   ;nothing calls this stub
LC5A5:  JMP  DOXMT

;------------------------------------------------------------------------------
; tune_cmd_29 - sound stub: sends command $29 through DOXMT, which on ESB's sound board is a tune (the sound
;   board's tunes 35-38, melody not identified). sent by the asteroid part's setup while jedi_time is under $80,
;   and one of the five attract tunes of TMUSIC. the Star Wars name AUDNAY was carried here by the command number,
;   which meant another sound there
;------------------------------------------------------------------------------
tune_cmd_29:
LC5A8:  LDA  #$29
LC5AA:  JMP  DOXMT

;------------------------------------------------------------------------------
; tune_cmd_2a - sound stub: sends command $2A through DOXMT, which on ESB's sound board is a tune, Ben's theme
;   (tunes 7-10). sent by page 1 (P1_95E5) when the fourth Jedi letter is earned, and one of the five attract
;   tunes of TMUSIC. the Star Wars name AUDPB was carried here by the command number, which meant another sound
;   there
;------------------------------------------------------------------------------
tune_cmd_2a:
LC5AD:  LDA  #$2A
LC5AF:  JMP  DOXMT

;------------------------------------------------------------------------------
; tune_cmd_2b - sound stub: sends command $2B through DOXMT, which on ESB's sound board is a tune, the Imperial
;   March (tunes 15-18). sent by the walker part's setup while jedi_time is under $80, and one of the five attract
;   tunes of TMUSIC. the Star Wars name AUDPBZ was carried here by the command number, which meant another sound
;   there
;------------------------------------------------------------------------------
tune_cmd_2b:
LC5B2:  LDA  #$2B
LC5B4:  JMP  DOXMT

;------------------------------------------------------------------------------
; tune_cmd_2c - sound stub: sends command $2C through DOXMT, which on ESB's sound board is a tune (tunes 23-26,
;   melody not identified). sent by the TIE fighter part's setup while jedi_time is under $80. the Star Wars name
;   AUDPF was carried here by the command number, which meant another sound there
;------------------------------------------------------------------------------
tune_cmd_2c:
LC5B7:  LDA  #$2C
LC5B9:  JMP  DOXMT

;------------------------------------------------------------------------------
; tune_cmd_2d - sound stub: sends command $2D through DOXMT, which on ESB's sound board is a tune, descending
;   semitone scales (tunes 1-4). nothing calls this stub. the Star Wars name AUDPH was carried here by the command
;   number, which meant another sound there
;------------------------------------------------------------------------------
tune_cmd_2d:
LC5BC:  LDA  #$2D                   ;nothing calls this stub
LC5BE:  JMP  DOXMT

;------------------------------------------------------------------------------
; tune_cmd_2e - sound stub: sends command $2E through DOXMT, which on ESB's sound board is a tune, the Star Wars
;   main theme (tunes 27-30). sent by the probot part's setup, and one of the five attract tunes of TMUSIC. the
;   Star Wars name AUDPS was carried here by the command number, which meant another sound there
;------------------------------------------------------------------------------
tune_cmd_2e:
LC5C1:  LDA  #$2E
LC5C3:  JMP  DOXMT

;------------------------------------------------------------------------------
; tune_cmd_2f - sound stub: sends command $2F through DOXMT, which on ESB's sound board is a tune, the rhythm
;   figure of the Imperial March looped (tunes 43-46). sent by launch_init for the opening text. the Star Wars
;   name AUDRC was carried here by the command number, which meant another sound there
;------------------------------------------------------------------------------
tune_cmd_2f:
LC5C6:  LDA  #$2F
LC5C8:  JMP  DOXMT

;------------------------------------------------------------------------------
; tune_cmd_30 - sound stub: sends command $30 through DOXMT, which on ESB's sound board is a tune (tunes 39-42,
;   by its notes perhaps Yoda's theme). sent by PHEEGM when a game ends without high score or continue offer. the
;   Star Wars name AUDRD was carried here by the command number, which meant another sound there
;------------------------------------------------------------------------------
tune_cmd_30:
LC5CB:  LDA  #$30
LC5CD:  JMP  DOXMT

;------------------------------------------------------------------------------
; tune_cmd_31 - sound stub: sends command $31 through DOXMT, which on ESB's sound board is a tune (tunes 31-34,
;   melody not identified). sent by PHIENT when the initials entry starts, and one of the five attract tunes of
;   TMUSIC. the Star Wars name AUDRS was carried here by the command number, which meant another sound there
;------------------------------------------------------------------------------
tune_cmd_31:
LC5D0:  LDA  #$31
LC5D2:  JMP  DOXMT

;------------------------------------------------------------------------------
; aud_cmd_32 - sound stub: sends command $32 through doxmt_gated, which on ESB's sound board is the effect of
;   Atari's table CR0, crash, which Star Wars' AUDCR requested. sent by pages 0 and 1 (P0_914F, P1_89AA) when the
;   ship runs into a walker. the Star Wars name AUDRY was carried here by the command number, which meant another
;   sound there
;------------------------------------------------------------------------------
aud_cmd_32:
LC5D5:  LDA  #$32
LC5D7:  JMP  doxmt_gated

;------------------------------------------------------------------------------
; aud_cmd_33 - sound stub: sends command $33 through doxmt_gated, which on ESB's sound board is the effect of
;   Atari's table DF0, the final explosion, which Star Wars' AUDDF requested. sent by page 1 (P1_9C28) when the
;   walkers' advance reaches its last mark (prog_count 0)
;------------------------------------------------------------------------------
aud_cmd_33:
LC5DA:  LDA  #$33
LC5DC:  JMP  doxmt_gated

;------------------------------------------------------------------------------
; aud_cmd_34 - sound stub: sends command $34 through DOXMT, which on ESB's sound board is the effect of Atari's
;   table NAY0, nay - test failed, which Star Wars' AUDNAY requested. nothing calls this stub: the self test sends
;   $34 itself as its error sound
;------------------------------------------------------------------------------
aud_cmd_34:
LC5DF:  LDA  #$34                   ;nothing calls this stub
LC5E1:  JMP  DOXMT

;------------------------------------------------------------------------------
; aud_cmd_35 - sound stub: sends command $35 through doxmt_gated, which on ESB's sound board is the effect of
;   Atari's table PB0, pass-by, which Star Wars' AUDPB requested. sent by S2VW (pages 2 and 3) when a ship starts
;   a pass-by
;------------------------------------------------------------------------------
aud_cmd_35:
LC5E4:  LDA  #$35
LC5E6:  JMP  doxmt_gated

;------------------------------------------------------------------------------
; aud_cmd_36 - sound stub: sends command $36 through DOXMT, which on ESB's sound board is the table PBZ0, which
;   ends the pass-by sound, as Star Wars' AUDPBZ did. sent by XPSA (P3_8A3D) when the ship that explodes is the
;   one passing by. not gated by snd_mute. the self test's sound test leaves it out
;------------------------------------------------------------------------------
aud_cmd_36:
LC5E9:  LDA  #$36                   ;not gated by snd_mute
LC5EB:  JMP  DOXMT

;------------------------------------------------------------------------------
; aud_cmd_37 - sound stub: sends command $37 through doxmt_gated, which on ESB's sound board is the effect of
;   Atari's table PF0, tower pfffts, which Star Wars' AUDPF requested. nothing calls this stub
;------------------------------------------------------------------------------
aud_cmd_37:
LC5EE:  LDA  #$37                   ;nothing calls this stub or the next one
LC5F0:  JMP  doxmt_gated

;------------------------------------------------------------------------------
; aud_cmd_38 - sound stub: sends command $38 through doxmt_gated, which on ESB's sound board is the effect of
;   Atari's table PH0, port hole shot, which Star Wars' AUDPH requested. nothing in bank 0 or the pages calls this
;   stub. bank 1's copy is called from the initials entry
;------------------------------------------------------------------------------
aud_cmd_38:
LC5F3:  LDA  #$38
LC5F5:  JMP  doxmt_gated

;------------------------------------------------------------------------------
; aud_cmd_39 - sound stub: sends command $39 through doxmt_gated, which on ESB's sound board is the effect of
;   Atari's table PS0, short pass-by, which Star Wars' AUDPS requested. sent by S2VW (pages 2 and 3) when the ship
;   passing by starts to move away
;------------------------------------------------------------------------------
aud_cmd_39:
LC5F8:  LDA  #$39
LC5FA:  JMP  doxmt_gated

;------------------------------------------------------------------------------
; aud_cmd_3a - sound stub: sends command $3A through doxmt_gated, which on ESB's sound board is the effect of
;   Atari's table SH0, shield, which Star Wars' AUDSH requested. sent by DO1GAS when a shield is lost, by page 1
;   (P1_94FE) when a shot hits the ship and by page 2 (P2_9AF3) when an asteroid does
;------------------------------------------------------------------------------
aud_cmd_3a:
LC5FD:  LDA  #$3A
LC5FF:  JMP  doxmt_gated

;------------------------------------------------------------------------------
; aud_cmd_3b - sound stub: sends command $3B through doxmt_gated, which on ESB's sound board is the effect of
;   Atari's table SS0, shoot shots, which Star Wars' AUDSS requested. sent by page 1 (P1_9527) when the lazar
;   destroys an enemy shot and by page 3 (P3_9D23) when it hits a probot transmission
;------------------------------------------------------------------------------
aud_cmd_3b:
LC602:  LDA  #$3B
LC604:  JMP  doxmt_gated

;------------------------------------------------------------------------------
; aud_cmd_3c - sound stub: sends command $3C through doxmt_gated, which on ESB's sound board is the effect of
;   Atari's table SX0, small explosion, which Star Wars' AUDSX requested. sent by page 1 (P1_8E75) when an AT-ST
;   is destroyed and by page 3 (CPHTSA, XPSA) when a TIE fighter is hit
;------------------------------------------------------------------------------
aud_cmd_3c:
LC607:  LDA  #$3C
LC609:  JMP  doxmt_gated

;------------------------------------------------------------------------------
; aud_cmd_3d - sound stub: sends command $3D through doxmt_gated, which on ESB's sound board is the effect of
;   Atari's table XL0, which Star Wars' AUDTC requested for the TIE fighter cannon. sent by page 1 when a TIE
;   fighter (P1_8F82) or a probot (P1_90C6) fires a shot
;------------------------------------------------------------------------------
aud_cmd_3d:
LC60C:  LDA  #$3D
LC60E:  JMP  doxmt_gated

;------------------------------------------------------------------------------
; aud_cmd_3e - sound stub: sends command $3E through doxmt_gated, which on ESB's sound board is the table XLZ0,
;   which ends the sound of command $3D, as Star Wars' AUDTCZ did. sent by page 1 (P1_9524) when the lazar
;   destroys an enemy shot. the self test's sound test leaves it out
;------------------------------------------------------------------------------
aud_cmd_3e:
LC611:  LDA  #$3E
LC613:  JMP  doxmt_gated

;------------------------------------------------------------------------------
; aud_cmd_3f - sound stub: sends command $3F through doxmt_gated, which on ESB's sound board is the effect of
;   Atari's table BL0, the player's laser blast, which Star Wars' AUDXL requested. sent by TSTLAZ (P3_95BA) when
;   the lazars fire in the TIE fighter and asteroid parts
;------------------------------------------------------------------------------
aud_cmd_3f:
LC616:  LDA  #$3F
LC618:  JMP  doxmt_gated

;------------------------------------------------------------------------------
; aud_cmd_40 - sound stub: sends command $40 through DOXMT, which on ESB's sound board is the effect of Atari's
;   table YEA0, yea - test successful, which Star Wars' AUDYEA requested. nothing calls this stub: the self test
;   sends $40 itself as its no-error sound
;------------------------------------------------------------------------------
aud_cmd_40:
LC61B:  LDA  #$40                   ;nothing calls this stub
LC61D:  JMP  DOXMT

;------------------------------------------------------------------------------
; aud_cmd_41 - sound stub: sends command $41 through doxmt_gated, which on ESB's sound board is an effect ESB
;   added (2 channels, noise, about 0.4 s). sent by page 1 when an AT-AT (P1_8FEE) or an AT-ST (P1_905A) fires a
;   shot
;------------------------------------------------------------------------------
aud_cmd_41:
LC620:  LDA  #$41
LC622:  JMP  doxmt_gated

;------------------------------------------------------------------------------
; aud_cmd_42 - sound stub: sends command $42 through doxmt_gated, which on ESB's sound board is an effect ESB
;   added (1 channel, about 0.4 s). nothing calls this stub
;------------------------------------------------------------------------------
aud_cmd_42:
LC625:  LDA  #$42                   ;nothing calls this stub
LC627:  JMP  doxmt_gated

;------------------------------------------------------------------------------
; aud_cmd_43 - sound stub: sends command $43 through doxmt_gated, which on ESB's sound board is an effect ESB
;   added (2 channels, pure tone, about 2.5 s). sent by page 3 (P3_995A) when a probot launches a transmission
;------------------------------------------------------------------------------
aud_cmd_43:
LC62A:  LDA  #$43
LC62C:  JMP  doxmt_gated

;------------------------------------------------------------------------------
; aud_cmd_44 - sound stub: sends command $44 through DOXMT, which on ESB's sound board is a table of end marks
;   that silences the two channels of commands $43 and $45. sent by page 3 (P3_9D20) when the lazar hits a
;   transmission and no other transmission is live. not gated by snd_mute. the self test's sound test leaves it
;   out
;------------------------------------------------------------------------------
aud_cmd_44:
LC62F:  LDA  #$44
LC631:  JMP  DOXMT

;------------------------------------------------------------------------------
; aud_cmd_45 - sound stub: sends command $45 through doxmt_gated, which on ESB's sound board is an effect ESB
;   added (2 channels, noise, about 6.1 s). sent by wave2_exit_init when the walker part is over
;------------------------------------------------------------------------------
aud_cmd_45:
LC634:  LDA  #$45
LC636:  JMP  doxmt_gated

;------------------------------------------------------------------------------
; aud_cmd_46 - sound stub: sends command $46 through doxmt_gated, which on ESB's sound board is an effect ESB
;   added (2 channels, pure tone, about 0.8 s). sent by page 1 (P1_9A02) just before flash_fade is set to $7F, not
;   while a training manual page is shown
;------------------------------------------------------------------------------
aud_cmd_46:
LC639:  LDA  #$46
LC63B:  JMP  doxmt_gated

;------------------------------------------------------------------------------
; aud_cmd_47 - sound stub: sends command $47 through doxmt_gated, which on ESB's sound board is an effect ESB
;   added (3 channels, noise, about 4.8 s). sent by launch_init for the opening text
;------------------------------------------------------------------------------
aud_cmd_47:
LC63E:  LDA  #$47
LC640:  JMP  doxmt_gated

;------------------------------------------------------------------------------
; aud_cmd_48 - sound stub: sends command $48 through doxmt_gated, which on ESB's sound board is an effect ESB
;   added (1 channel, about 1.1 s). sent by page 1 (P1_9C2D) when the walkers' advance passes a mark that is not
;   the last
;------------------------------------------------------------------------------
aud_cmd_48:
LC643:  LDA  #$48
LC645:  JMP  doxmt_gated

;------------------------------------------------------------------------------
; aud_cmd_49 - sound stub: sends command $49 through doxmt_gated, which on ESB's sound board is an effect ESB
;   added (2 channels, noise, about 0.9 s). sent by page 2 (P2_9AF6) when an asteroid hits the ship
;------------------------------------------------------------------------------
aud_cmd_49:
LC648:  LDA  #$49
LC64A:  JMP  doxmt_gated

;------------------------------------------------------------------------------
; aud_cmd_4a - sound stub: sends command $4A through doxmt_gated, which on ESB's sound board is an effect ESB
;   added (2 channels, noise, about 4.5 s). sent by phi_jedi_award when the asteroid field is passed
;------------------------------------------------------------------------------
aud_cmd_4a:
LC64D:  LDA  #$4A
LC64F:  JMP  doxmt_gated

;------------------------------------------------------------------------------
; aud_cmd_4b - sound stub: sends command $4B through doxmt_gated, which on ESB's sound board is an effect ESB
;   added (1 channel, noise, about 2.8 s). sent by page 0 (P0_95BA) where $4BFE is counted down
;------------------------------------------------------------------------------
aud_cmd_4b:
LC652:  LDA  #$4B
LC654:  JMP  doxmt_gated

;------------------------------------------------------------------------------
; aud_cmd_4c - sound stub: sends command $4C through doxmt_gated, which on ESB's sound board is an effect ESB
;   added (2 channels, pure tone, about 0.7 s). sent by scr_legs_bonus when the player flies through an AT-AT's
;   legs
;------------------------------------------------------------------------------
aud_cmd_4c:
LC657:  LDA  #$4C
LC659:  JMP  doxmt_gated

;------------------------------------------------------------------------------
; aud_cmd_4d - sound stub: sends command $4D through doxmt_gated, which on ESB's sound board is an effect ESB
;   added (1 channel, about 0.2 s). sent by TSTLAZ (P3_95B5) when the lazars fire in the probot and walker parts
;------------------------------------------------------------------------------
aud_cmd_4d:
LC65C:  LDA  #$4D
LC65E:  JMP  doxmt_gated

;------------------------------------------------------------------------------
; aud_cmd_4e - sound stub: sends command $4E through doxmt_gated, which on ESB's sound board is an effect ESB
;   added (2 channels, about 0.9 s). sent by page 2 (P2_9327) when a probot is shot down
;------------------------------------------------------------------------------
aud_cmd_4e:
LC661:  LDA  #$4E
LC663:  JMP  doxmt_gated

;------------------------------------------------------------------------------
; aud_cmd_4f - sound stub: sends command $4F through doxmt_gated, which on ESB's sound board is an effect ESB
;   added (1 channel, about 0.9 s). sent by page 0 (P0_9927)
;------------------------------------------------------------------------------
aud_cmd_4f:
LC666:  LDA  #$4F
LC668:  JMP  doxmt_gated

;------------------------------------------------------------------------------
; aud_cmd_50 - sound stub: sends command $50 through doxmt_gated, which on ESB's sound board is an effect ESB
;   added (1 channel, about 6.1 s). sent by page 1 (P1_963F), once, when jedi_time falls under $60
;------------------------------------------------------------------------------
aud_cmd_50:
LC66B:  LDA  #$50
LC66D:  JMP  doxmt_gated

;------------------------------------------------------------------------------
; aud_cmd_51 - sound stub: sends command $51 through doxmt_gated, which on ESB's sound board is an effect ESB
;   added (2 channels, noise, about 1.1 s). sent by page 0 (P0_904A) when an AT-AT is destroyed. the last command
;   the self test's sound test plays
;------------------------------------------------------------------------------
aud_cmd_51:
LC670:  LDA  #$51
LC672:  JMP  doxmt_gated

;------------------------------------------------------------------------------
; aud_cmd_52 - sound stub: sends command $52 through DOXMT, which on ESB's sound board is a command it has no
;   routine for: its command table ends at $51 and the word it takes for $52 is the ROM's checksum word. sent by
;   page 1 (P1_962A) when jedi_time runs out. not gated by snd_mute. the self test's sound test leaves it out
;------------------------------------------------------------------------------
aud_cmd_52:
LC675:  LDA  #$52
LC677:  JMP  DOXMT

;------------------------------------------------------------------------------
; COINS - ACTIVITY CHECK
;   ONLY CALL MOOLAH IF IT IS NEEDED.
;   CHECK COIN RELATED SWITCHES OR E.M. COUNTERS FOR ACTIVITY,
;   WHEN ACTIVE SET A COUNTER TO CALL MOOLAH.
;   TIMER SHOULD BE SET TO A VALUE LARGE ENOUGH TO
;   ALLOW ELECTRO-MECHANICAL COUNTERS TO CYCLE.
;------------------------------------------------------------------------------
COINS:
LC67A:  LDA  S_COINA                ;CHECK SWITCHES
LC67D:  ANDA #$0F                   ;RIGHT,LEFT,AUX COIN AND SLAM SWITCHES
LC67F:  CMPA #$0F
LC681:  BEQ  LC687                  ;IFNE  SWITCH ACTIVITY
LC683:  LDA  #$FF                   ;GIVE 'EM A COUPLE OF SECONDS
LC685:  STA  MOOTIM                 ;DECREMENTED EVERY 16 MS IN IRQ
LC687:  LDA  MOOTIM                 ;SHALL I CALL MOOLAH
LC689:  BNE  LC68C                  ;IFEQ  TIMER RAN OUT, DON'T DO MOOLAH
LC68B:  RTS                         ;RETURN FROM WHENCE YOU CAME
;ELSE
LC68C:  DEC  MOOTIM                 ;DEC TIMER
LC68E:  LDA  #MAXCRD                ;VERIFY PROPER CREDIT RANGE
LC690:  CMPA S_S_CRDT
LC692:  BHS  LC696                  ;IFLO  TOO MANY CREDITS
LC694:  STA  S_S_CRDT
LC696:  LDA  S_CCTIM+2              ;CHECK ELECTRO-MECHANICAL COUNTER TIMERS
LC698:  STA  EMCNT0                 ;ACTIVATE EM-COUNTERS ( RIGHT )
LC69B:  LDB  S_CCTIM+1
LC69D:  STB  EMCNT1                 ;( LEFT )
LC6A0:  ORA  S_CCTIM+1
LC6A2:  ORA  S_CCTIM                ;AUX DOESN'T HIT EM-COUNTER
LC6A4:  BEQ  LC6AA                  ;IFNE  MECH ACTIVITY
LC6A6:  LDA  #$FF
LC6A8:  STA  MOOTIM
LC6AA:  LDA  TESTSW                 ;SELF TEST SWITCH?
LC6AD:  ANDA #TESTBT
LC6AF:  BNE  LC6B4                  ;IFEQ  YES, IT IS ON
LC6B1:  JMP  S_EXT                  ;NO COINS, BUT CONTINUE EM COUNTER TIMING
LC6B4:  LDA  OPTS0                  ;SETUP $CMODE FROM EEROM OPTIONS
LC6B7:  STA  S_CMODE
LC6B9:  LDA  S_INTCT
LC6BB:  ANDA #$03
LC6BD:  BNE  MOOLAH                 ;IFEQ  16 MS
LC6BF:  JSR  L6126

;.SBTTL DETECT COIN
MOOLAH:
LC6C2:  LDX  #$480E                 ;(src: LDX #$BASE+OFFSET+OFFSET)  X IS USED TO INDEX FROM RIGHT TO LEFT COIN MECH

S_DETCT:
LC6C5:  LDA  S_COINA                ;GET COIN SWITCHES
LC6C8:  CMPX #$480D                 ;(src: CMPX #$BASE+OFFSET)  WHICH MECH ARE WE DOING
LC6CB:  BEQ  S_DETCT_11             ;MIDDLE ($BASE+OFFSET) SHIFT TWICE
LC6CD:  BHS  S_DETCT_12             ;RIGHT ($BASE+2*OFFSET) SHIFT ONCE
LC6CF:  LSRA                        ;ELSE RIGHT, SHIFT THRICE

S_DETCT_11:
LC6D0:  LSRA

S_DETCT_12:
LC6D1:  LSRA
LC6D2:  LDA  ,X                     ;(src: LDA $CNSTT-$BASE(X))
LC6D4:  ANDA #$1F                   ;SHARED INST. SEE BELOW IN BRACKETS []
LC6D6:  BCS  S_DETCT_50             ;BRANCH IF INPUT HIGH (COIN ABSENT)
;[ANDA #31.] ;ISOLATE COIN-ON DOWN-COUNTER, RESET COIN-OFF UP-CTR.
LC6D8:  BEQ  S_DETCT_1              ;STICK AT 0 (TERMINAL COUNT)
LC6DA:  CMPA #$1B                   ;IN FIRST FIVE SAMPLES?
LC6DC:  BHS  S_DETCT_10             ;YES, RUN FAST
LC6DE:  LDB  S_INTCT                ;CHECK INTERUPT CTR
LC6E0:  ANDB #$01                   ;COUNTDOWN SLOWLY
LC6E2:  BNE  S_DETCT_1              ;SKIP IF NOT 0 (MOD 2) INTERRUPT

S_DETCT_10:
LC6E4:  SUBA #$01                   ;COUNTDOWN EVERY 8 MILS

S_DETCT_1:
LC6E6:  STA  ,X                     ;(src: STA $CNSTT-$BASE(X))  SAVE UPDATED STATUS
LC6E8:  LDA  S_LAM                  ;CHECK SLAM SWITCH
LC6EB:  ANDA #S_LMBIT
LC6ED:  BNE  S_DETCT_20             ;BRANCH IF BIT HI (SWITCH OFF)
LC6EF:  LDA  #PRST*8                ;ELSE SET PRE-COIN SLAM TIMER
LC6F1:  STA  S_LMTIM                ;DECR. 8 TIMES/FRAME=PRST FRAMES

S_DETCT_20:
LC6F3:  LDA  S_LMTIM                ;CHECK PRE-COIN SLAM TIMER
LC6F5:  BEQ  S_DETCT_30             ;O.K.
LC6F7:  DEC  S_LMTIM                ;ELSE RUN TIMER
LC6F9:  LDA  #$00
LC6FB:  STA  ,X                     ;(src: STA $CNSTT-$BASE(X))  CLEAR COIN STATUS
LC6FD:  STA  3,X                    ;(src: STA $PSTSL-$BASE(X))  CLEAR POST-COIN SLAM-TIMER

S_DETCT_30:
LC6FF:  LDA  3,X                    ;(src: LDA $PSTSL-$BASE(X))  CHECK POST-COIN SLAM-TIMER
LC701:  BEQ  S_DETNXT               ;EMPTY, PROCEED WITH NEXT MECH
LC703:  DEC  3,X                    ;(src: DEC $PSTSL-$BASE(X))  RUN TIMER
LC705:  BEQ  S_MULT                 ;WHEN IT BECOMES ZERO INDICATE A COIN
LC707:  BRA  S_DETNXT               ;ELSE NOT DONE, PROCEED WITH NEXT MECH

;COIN SW IS OFF
;[ANDA #31.] ;GET COIN-ON DOWN-CTR (ACTUALLY DONE BEFORE)
S_DETCT_50:
LC709:  CMPA #$1B                   ;IS COIN VALID YET (ON FOR >4 SAMPLES)
LC70B:  BHS  S_DETCT_60             ;NO, RESET IT
LC70D:  LDA  ,X                     ;(src: LDA $CNSTT-$BASE(X))  GET STATUS AGAIN
LC70F:  ADDA #$20                   ;BUMP COIN-OFF UP-CTR.
LC711:  BCC  S_DETCT_1              ;IF IT DIDN'T WRAP, JUST STORE STATUS
LC713:  BNE  S_DETCT_70             ;IT WRAPPED BUT COIN WAS ON TOO LONG, JUST RESET

;COIN TOO LONG OR TOO SHORT
S_DETCT_60:
LC715:  LDA  #$1F                   ;RESET DOWN-COUNTER
LC717:  BRA  S_DETCT_1              ;AND PROCESS TIMERS

;COIN SW OK, WAIT FOR POST SLAM
S_DETCT_70:
LC719:  LDA  #$1F                   ;SETUP DOWN-COUNTER FOR NEXT COIN
LC71B:  STA  ,X                     ;(src: STA $CNSTT-$BASE(X))  SAVE RESET STATUS
LC71D:  LDB  3,X                    ;(src: LDB $PSTSL-$BASE(X))  CHECK IF PREVIOUS COIN STILL WAITING
LC71F:  LDA  #POST*4                ;/(4 COUNTS/FRAME)="POST" FRAMES
LC721:  STA  3,X                    ;(src: STA $PSTSL-$BASE(X))  DELAY ACCEPTANCE FOR POST/60 SEC.
LC723:  TSTB                        ;?ONLY ONE COIN WAITING?
LC724:  BEQ  S_DETNXT               ;THEN WAIT FOR POST SLAM

;.SBTTL MECH-MULTIPLIERS
S_MULT:
LC726:  CLRA                        ;START WITH 0 (TO ADD 1)
LC727:  CMPX #$480D                 ;(src: CMPX #$BASE+OFFSET)  CHECK WHICH MECH
LC72A:  BLO  S_MUL85                ;IF LEFT, ALWAYS ADD 1
LC72C:  BEQ  S_MUL83                ;IF CENTER, CHECK HALF-MUL
LC72E:  LDA  S_CMODE                ;GDM  ELSE GET DOLLAR MUL
LC730:  ANDA #$0C
LC732:  LSRA
LC733:  LSRA
LC734:  BEQ  S_MUL85                ;00-ADD 1
LC736:  ADDA #$02                   ;ELSE MAP 1,2,3 TO 3,4,5
LC738:  BRA  S_MUL85                ;(ALWAYS)

;NOTE: BRANCH AROUND THIS TABLE
S_MODLO:          ;TWICE THE UNIT-COINS REQUIRED TO RECEIVE BONUS
LC73A:  .byte $FF, $04, $08, $08, $0A, $FF, $FF, $FF ;-,2,4,4,5,-,-,-UNIT COINS

;------------------------------------------------------------------------------
; S_MUL83 - [note] Center mech: check half-mul - A = 1 if S_CMODE bit $10 is set, else 0; falls into S_MUL85, which
;   adds A+1 unit coins to S_BCCNT and S_CNCT
;------------------------------------------------------------------------------
S_MUL83:
LC742:  LDA  S_CMODE                ;GHM
LC744:  ANDA #$10
LC746:  BEQ  S_MUL85
LC748:  LDA  #$01

S_MUL85:
LC74A:  INCA                        ;ADD MIN OF ONE COIN
LC74B:  TFR  A,B                    ;SAVE NEW COINS INCREMENT
LC74D:  ADDB S_BCCNT                ;UPDATE BONUS-ADDER COUNTER
LC74F:  STB  S_BCCNT
LC751:  ADDA S_CNCT
LC753:  STA  S_CNCT
LC755:  INC  10,X

S_DETNXT:
LC757:  LEAX -OFFSET,X
LC759:  CMPX #$480C                 ;(src: CMPX #$BASE)
LC75C:  LBGE S_DETCT

;.SBTTL BONUS-ADDER
S_BONUS:
LC760:  LDA  S_CMODE                ;GBAM  GET BONUS ADDER MODE
LC762:  LSRA
LC763:  LSRA
LC764:  LSRA
LC765:  LSRA
LC766:  LSRA
LC767:  LDB  S_BCCNT
LC769:  LSLB                        ;B:= ORIGINAL UNIT COINS*2
LC76A:  LDX  #S_MODLO
LC76D:  SUBB A,X                    ;SEE IF ENOUGH UNIT-COINS HAVE ACCUMULATED
LC76F:  BLO  S_CNVRT                ;BRANCH IF NOT
LC771:  LSL  S_BCCNT                ;PULL IN HALF-CREDIT MARKER
LC773:  RORB
LC774:  CMPA #$03                   ;MODE 3 YIELDS 2 BONUS COINS FOR 4 INSERTED
LC776:  BEQ  S_BONUS_20             ;NOTE: MODE 3 ==> NO ODD BONUS COINS
LC778:  ADDB #$80                   ;OTHER MODES: ADD ODD BONUS
LC77A:  BCC  S_BONUS_40             ;? 2 ODDS MAKE A PAIR OF BONUS COINS?

S_BONUS_20:
LC77C:  INC  S_CNCT                 ;ADD TWO BONUS COINS
LC77E:  INC  S_CNCT

S_BONUS_40:
LC780:  STB  S_BCCNT                ;UPDATE BOTH ODD BONUS COIN

;.SBTTL COINS TO CREDITS
S_CNVRT:
S_EXTB:
LC782:  LDA  S_CMODE                ;GCM  GET COIN MODE IN ACC 0,1
LC784:  ANDA #$03
LC786:  BEQ  S_CNVRT_50             ;IF FREE PLAY, KEEP COIN COUNT CLEAR, LEAVE CREDIT
LC788:  TFR  A,B                    ;SAVE $CMODE
LC78A:  NEGA                        ;CONVERT MODE 0,1,2,3 TO -,-1,-1,-2 UNIT COIN PRICING
LC78B:  ASRA
LC78C:  ADDA S_CNCT                 ;A:=$CNCT-PRICE
LC78E:  BPL  S_CNVRT_40             ;?NOT ENOUGH UNIT COINS?
LC790:  TST  S_BCCNT                ;TEST FOR EXTRA ODD BONUS COIN
LC792:  BPL  S_EXT                  ;?EXTRA ODD BONUS COIN PRESENT?
LC794:  INCA                        ;INCLUDE IT IN
LC795:  BMI  S_EXT                  ;?ENOUGH COINS NOW?
LC797:  LSL  S_BCCNT                ;GREAT--CLEAR ODD COIN FLAG
LC799:  LSR  S_BCCNT

S_CNVRT_40:
LC79B:  CMPB #$01                   ;ENUF COINS ==> INCREASE CREDITS
LC79D:  BNE  S_CNVRT_45             ;?MODE 1?
LC79F:  INC  S_S_CRDT               ;THEN ADD SECOND CREDIT

S_CNVRT_45:
LC7A1:  INC  S_S_CRDT               ;ALWAYS ADD FIRST CREDIT

S_CNVRT_50:
LC7A3:  STA  S_CNCT                 ;SAVE NEW REDUCED COIN COUNT

;.SBTTL ELECTRO-MECH. CTRS
;SINCE COUNTERS MAY BE WIRE-ORED TOGETHER, ONE FULL
;ON/OFF CYCLE MUST OCCURR FOR EACH POTENTIAL COUNT.
;NO OVERLAPPING ALLOWED!
;ALSO NOTE: WITH MAX OF 1 COUNTER ON,POWER NEEDS ARE LESS
S_EXT:
LC7A5:  LDB  S_INTCT                ;SPEC 171005 DRAFT 3, 2/23/82
LC7A7:  ANDB #$0F                   ;MIN ON TIME = 50 MSECS, MIN OFF = 50 MSECS
LC7A9:  BNE  S_EXT_99               ;SO USE 16 INTS ==> 64 MSEC ON, 64 MSECS OFF
LC7AB:  LDX  #S_BASE+OFFSET+OFFSET

S_EXT_10:
LC7AE:  LDA  ,X                     ;CHECK TIMER(X)
LC7B0:  BPL  S_EXT_30               ;B NOT CURRENTLY ACTIVE ON
LC7B2:  ANDA #$7F                   ;WAS ACTIVE ON, SO CYCLE TO ACTIVE OFF
LC7B4:  INCB                        ;FLAGIT: FOUND AN ACTIVE COUNTER

S_EXT_20:
LC7B5:  STA  ,X                     ;SAVE DECREMENTED TIMER

S_EXT_30:
LC7B7:  LEAX -OFFSET,X
LC7B9:  CMPX #S_BASE
LC7BC:  BGE  S_EXT_10
LC7BE:  TSTB                        ;CHECK "IN USE" FLAG
LC7BF:  BNE  S_EXT_99               ;SKIP IF ANY IN USE
;IF NONE OF THE COUNTERS ARE CURRENTLY IN USE, WE CHECK TO SEE IF ANY CAN BE
;STARTED.
LC7C1:  LDX  #S_BASE+OFFSET+OFFSET

S_EXT_40:
LC7C4:  LDA  ,X                     ;NEED WE START THIS ONE
LC7C6:  BEQ  S_EXT_50               ;NO, NO COUNTS PENDING
LC7C8:  ADDA #$7F                   ;SET 1 MSB, DEC 7 LSB
LC7CA:  STA  ,X                     ;START TIMER, ACTIVE ON
LC7CC:  BRA  S_EXT_99               ;EXIT, SO WE DON'T START MORE

S_EXT_50:
LC7CE:  LEAX -OFFSET,X
LC7D0:  CMPX #S_BASE
LC7D3:  BGE  S_EXT_40

S_EXT_99:
LC7D5:  RTS

vickers_text:
LC7D6:  .byte $13, $C7, $58, $38, $30, $56, $49, $43 ;not referenced by any code found: the bytes $13 $C7 $58 $38 $30, then the text VICKERS DID THE VOICES
LC7DE:  .byte $4B, $45, $52, $53, $20, $44, $49, $44
LC7E6:  .byte $20, $54, $48, $45, $20, $56, $4F, $49
LC7EE:  .byte $43, $45, $53
LC7F1:  .byte $B0                   ;last word before this ROM's fill, one of the six words the self test combines into the signature it shows
LC7F2:  .byte $A8
LC7F3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;ROM fill, 653 bytes of $FF
LC803:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LC813:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LC823:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LC833:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LC843:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LC853:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LC863:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LC873:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LC883:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LC893:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LC8A3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LC8B3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LC8C3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LC8D3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LC8E3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LC8F3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LC903:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LC913:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LC923:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LC933:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LC943:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LC953:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LC963:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LC973:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LC983:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LC993:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LC9A3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LC9B3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LC9C3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LC9D3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LC9E3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LC9F3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LCA03:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LCA13:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LCA23:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LCA33:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LCA43:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LCA53:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LCA63:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LCA73:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LCA80:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;.REPT 73  FILL WITH FF'S
LCA88:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LCA90:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LCA98:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LCAA0:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LCAA8:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LCAB0:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LCAB8:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LCAC0:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LCAC8:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LCAD0:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LCAD8:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LCAE0:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LCAE8:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LCAF0:  .byte $FF, $FF, $FF
LCAF3:  .byte $43, $4F, $50, $59, $52, $49, $47, $48 ;.ASCII /COPYRIGHT 1983 ATARI/
LCAFB:  .byte $54, $20, $31, $39, $38, $34, $20, $41
LCB03:  .byte $54, $41, $52, $49

;------------------------------------------------------------------------------
; MESSON - MESSON,MESSOFF
;------------------------------------------------------------------------------
MESSON:
LCB07:  PSHS X
LCB09:  LDX  #MESBLK
LCB0C:  CMPX MESLST
LCB0F:  BHS  LCB1A                  ;IFLO  LIST NOT EMPTY, SEARCH IT
LCB11:  CMPB ,X+
LCB13:  BEQ  LCB1F
LCB15:  CMPX MESLST                 ;END OF LIST?
LCB18:  BLO  LCB11                  ;HSEND
LCB1A:  STB  ,X+
LCB1C:  STX  MESLST
LCB1F:  PULS X,PC

;------------------------------------------------------------------------------
; MESSOFF - Star Wars' MESSOFF, which the matcher left without its label: turn message B off. Searches the list
;   MESBLK..MESLST for message number B and deletes it by moving the last entry into its slot and backing MESLST
;   up one. ESB takes the number in B instead of A and saves B, X and U. Reached through the cross-bank table
;   entry L6039
;------------------------------------------------------------------------------
MESSOFF:
LCB21:  PSHS B,X,U
LCB23:  LDX  #MESBLK
LCB26:  CMPB ,X
LCB28:  BNE  LCB3E                  ;IFEQ  FOUND IT, DELETE IT
LCB2A:  LDU  MESLST                 ;AVAILABLE POINTER
LCB2D:  CMPU #MESBLK                ;COMPARE WITH FIRST ENTRY SLOT
LCB31:  BLS  LCB3E                  ;IFHI  LIST WASN'T EMPTY, OK TO DELETE IT
LCB33:  LEAU -$1,U                  ;DECU  POINTS TO LAST ENTRY NOW
LCB35:  LDB  ,U
LCB37:  STB  ,X
LCB39:  STU  MESLST
LCB3C:  BRA  LCB45
LCB3E:  LEAX 1,X                    ;NEXT ENTRY
LCB40:  CMPX MESLST
LCB43:  BLO  LCB26                  ;HSEND
LCB45:  PULS B,X,U,PC

;------------------------------------------------------------------------------
; ALLOFF - TURN OFF ALL MESSAGES  (comment at the calls)
;   TURN ALL MESSAGES OFF  (another call)
;------------------------------------------------------------------------------
ALLOFF:
LCB47:  PSHS X
LCB49:  LDX  #MESBLK                ;SET POINTER TO START OF LIST
LCB4C:  CLR  ,X
LCB4E:  STX  MESLST
LCB51:  PULS X,PC

;------------------------------------------------------------------------------
; VWMESS - VWMESS
;------------------------------------------------------------------------------
VWMESS:
LCB53:  PSHS X,U
LCB55:  LDU  #MESBLK                ;START AT THE BEGINNING
LCB58:  CMPU MESLST                 ;ARE WE DONE BEFORE WE START?
LCB5C:  BHS  LCB7F                  ;IFLO  NO, GO ON
LCB5E:  LDB  ,U+
LCB60:  CMPB #MESSZ                 ;IS IT A VALID MESSAGE NUMBER?
LCB62:  BHS  LCB79                  ;IFLO  YES, DO IT
LCB64:  STB  >MESNUM                ;SAVE IT FOR LATER--->MESOUT
LCB67:  LDX  #message_tab           ;message_tab: 3 bytes per message - number of lines, address of the first line
LCB6A:  ABX
LCB6B:  ABX
LCB6C:  ABX
LCB6D:  LDB  ,X                     ;number of lines
LCB6F:  BLE  LCB79                  ;none: a banner message, not drawn here
LCB71:  STB  >mes_linect
LCB74:  LDX  1,X                    ;X = the first line
LCB76:  JSR  mes_lines_scroll
LCB79:  CMPU MESLST                 ;DONE? (U UPDATED AT BEGINNING OF LOOP)
LCB7D:  BLO  LCB5E                  ;HSEND
LCB7F:  PULS X,U,PC

;------------------------------------------------------------------------------
; VWMES2 - VWMES2 NEVER DOES A COLOR COMMAND
;------------------------------------------------------------------------------
VWMES2:
LCB81:  PSHS X,U
LCB83:  LDU  #MESBLK                ;START AT THE BEGINNING
LCB86:  CMPU MESLST                 ;ARE WE DONE BEFORE WE START?
LCB8A:  BHS  LCBAD                  ;IFLO  NO, GO ON
LCB8C:  LDB  ,U+
LCB8E:  CMPB #MESSZ                 ;IS IT A VALID MESSAGE NUMBER?
LCB90:  BHS  LCBA7                  ;IFLO  YES, DO IT
LCB92:  STB  >MESNUM                ;SAVE IT FOR LATER--->MESOUT
LCB95:  LDX  #message_tab           ;message_tab: 3 bytes per message - number of lines, address of the first line
LCB98:  ABX
LCB99:  ABX
LCB9A:  ABX
LCB9B:  LDB  ,X
LCB9D:  BLE  LCBA7
LCB9F:  STB  >mes_linect
LCBA2:  LDX  1,X
LCBA4:  JSR  mes_lines_fade
LCBA7:  CMPU MESLST                 ;DONE? (U UPDATED AT BEGINNING OF LOOP)
LCBAB:  BLO  LCB8C                  ;HSEND
LCBAD:  PULS X,U,PC

;------------------------------------------------------------------------------
; SPMON - SPMON,SPMOFF --SPECIAL MESSAGE ON,OFF
;------------------------------------------------------------------------------
SPMON:
LCBAF:  PSHS U
LCBB1:  LDU  SPMLST                 ;POINTS TO NEXT AVAILABLE SLOT IN SPECIAL MESSAGE LIST
LCBB4:  STA  ,U+                    ;PUT IT IN LIST
LCBB6:  LDD  #$0000                 ;SIZE ALWAYS STARTS AT LINEAR SCALE OF 0
LCBB9:  STD  ,U++
LCBBB:  LDD  #$0100                 ;START MOVING SLOW
LCBBE:  STD  ,U++
LCBC0:  STU  SPMLST                 ;SAVE UPDATED POINTER
LCBC3:  PULS U,PC

;------------------------------------------------------------------------------
; SPMOFF - GET RID OF IT  (comment at the call)
;------------------------------------------------------------------------------
SPMOFF:
LCBC5:  PSHS U
LCBC7:  LDU  #SPMBLK                ;START AT THE BEGINNING
LCBCA:  CMPA ,U                     ;IS THIS IT
LCBCC:  BNE  LCBD2                  ;IFEQ  YES, FOUND IT
LCBCE:  LDA  #$00
LCBD0:  STD  ,U
LCBD2:  LEAU 5,U                    ;NEXT ENTRY
LCBD4:  CMPU SPMLST                 ;DONE?
LCBD8:  BLO  LCBCA                  ;HSEND
LCBDA:  PULS U,PC

;------------------------------------------------------------------------------
; VWSPMS - VWSPMS --- VIEW SPECIAL MESSAGES
;------------------------------------------------------------------------------
VWSPMS:
LCBDC:  PSHS X,U
LCBDE:  LDU  #SPMBLK                ;SPECIAL MESSAGE RAM BLOCK
LCBE1:  CMPU SPMLST                 ;DONE BEFORE WE START?
LCBE5:  BHS  LCC3B                  ;IFLO  LIST NOT EMPTY, GO ON
LCBE7:  LDD  #VGSCAL                ;SET UP SCALE
LCBEA:  STD  ,Y++
LCBEC:  LDA  ,U+                    ;GET MESSAGE #
LCBEE:  BEQ  LCC33                  ;IFNE  VALID MESSAGE
LCBF0:  STA  >MESNUM                ;SAVE IT FOR LATER
LCBF3:  LDD  #VGLIMT&$1FFF          ;VECTOR FROM CENTER TO VANISHING POINT
LCBF6:  STD  ,Y++
LCBF8:  LDD  #$0000
LCBFB:  STD  ,Y++
LCBFD:  LDB  ,U                     ;SIZE FROM LIST
LCBFF:  LDA  #((VGSCAL/$100)&$F0)+1 ;MAKES THIS A SCAL INSTRUCTION
LCC01:  STD  ,Y++
LCC03:  COMB                        ;BRIGHTNESS RELATIVE TO INVERSE OF SCALE
LCC04:  ADDB #$10                   ;PLUS AN OFFSET
LCC06:  LDA  #(VGCOLR/$100)+VGCGRN  ;COLOR
LCC08:  STD  ,Y++
LCC0A:  LDX  #message_tab           ;message_tab, 3 bytes per message
LCC0D:  LDB  >MESNUM
LCC10:  ABX
LCC11:  ABX
LCC12:  ABX
LCC13:  LDX  1,X                    ;address of the banner message: one byte x / 4, then the text
LCC15:  LDD  #$1DD0                 ;DELTA Y (FROM VANISHING POINT)
LCC18:  STD  ,Y++
LCC1A:  LDB  ,X+                    ;x / 4, signed
LCC1C:  SEX
LCC1D:  ASLB
LCC1E:  ASLB
LCC1F:  ROLA
LCC20:  ANDA #$1F
LCC22:  ORA  #$00
LCC24:  STD  ,Y++
LCC26:  JSR  mes_text
LCC29:  LDD  #VGSCAL                ;RESET THE SCALE TO NORMAL
LCC2C:  STD  ,Y++
LCC2E:  LDD  #VGCNTR                ;CENTER AFTER MESSAGE
LCC31:  STD  ,Y++
LCC33:  LEAU 4,U
LCC35:  CMPU SPMLST                 ;DONE?
LCC39:  BLO  LCBEC                  ;HSEND
LCC3B:  PULS X,U,PC

;------------------------------------------------------------------------------
; BGBNNR - BEGIN BANNER
;------------------------------------------------------------------------------
BGBNNR:
LCC3D:  LDD  #$0000
LCC40:  STD  BN_CNT
LCC43:  STA  bn_brite               ;title brightness starts at 0
LCC46:  LDD  #SPMBLK                ;SETUP POINTER
LCC49:  STD  SPMLST
LCC4C:  LDD  TSPMAL                 ;SETUP ALARM FOR 1ST MESSAGE
LCC4F:  STD  SPMALM
LCC52:  LDA  #$D8                   ;$D8: the first of the seven moving story messages
LCC54:  STA  SPMNXT
LCC57:  RTS

;------------------------------------------------------------------------------
; spmess_entry - entry to SPMESS that saves X and U first, SPMESS ends by pulling them with the return address.
;   Reached through the cross-bank table entry L6069 - in ESB the title banner (Star Wars' VWBNNR, which fell into
;   SPMESS) is drawn in bank 1 and calls this to move the story messages
;------------------------------------------------------------------------------
spmess_entry:
LCC58:  PSHS X,U

;.SBTTL SPMESS
SPMESS:
VWBNNR_80:
LCC5A:  LDX  #SPMBLK                ;UPDATE MOVING MESSAGE SIZES
LCC5D:  CMPX SPMLST
LCC60:  BHS  LCCBB                  ;IFLO  THERE IS A MESSAGE TO PROCESS
LCC62:  LDD  BN_CNT
LCC65:  CMPD #$00E0
LCC69:  BHS  LCC79                  ;IFLO
LCC6B:  CMPD #$0040
LCC6F:  BLO  LCC77                  ;IFHS
LCC71:  LDD  1,X
LCC73:  ADDD 3,X
LCC75:  STD  1,X
LCC77:  BRA  LCCB4                  ;ELSE
LCC79:  CMPD #$0160
LCC7D:  BHS  LCC87                  ;IFLO
LCC7F:  LDD  #$0400                 ;SPEED IT UP
LCC82:  STD  SPMBLK+3
LCC85:  BRA  LCCB4                  ;ELSE
LCC87:  LDD  1,X                    ;UPDATE SCALE
LCC89:  ADDD 3,X
LCC8B:  STD  1,X
LCC8D:  CMPD #$F000                 ;MAKE NEXT ONE FAST
LCC91:  BLO  LCCB4                  ;IFHS
LCC93:  LDA  ,X                     ;MESSAGE #
LCC95:  INCA                        ;NEXT MESSAGE
LCC96:  LDU  #SPMBLK
LCC99:  CMPA ,U
LCC9B:  BNE  LCCA5                  ;IFEQ  FOUND NEXT HIGHER MESSAGE
LCC9D:  LDD  #$0400                 ;SPEED IT UP
LCCA0:  STD  3,U
LCCA2:  LDU  SPMLST                 ;LEAVE LOOP
LCCA5:  LEAU 5,U                    ;NEXT IN LIST
LCCA7:  CMPU SPMLST                 ;DONE?
LCCAB:  BLO  LCC99                  ;HSEND
LCCAD:  LDA  ,X
LCCAF:  JSR  SPMOFF                 ;GET RID OF IT
LCCB2:  LEAX -$5,X                  ;MAKE SURE WE DO THE ONE THAT REPLACED IT
LCCB4:  LEAX 5,X
LCCB6:  CMPX SPMLST                 ;DONE?
LCCB9:  BLO  LCC62                  ;HSEND
LCCBB:  LDD  BN_CNT                 ;INC TIMER
LCCBE:  CMPD SPMALM                 ;ALARM? ( NEXT LINE ?)
LCCC2:  BLO  LCCE9                  ;IFHS  YES, START IT AND RESET FOR NEXT LINE
LCCC4:  LDA  SPMNXT
LCCC7:  JSR  SPMON
LCCCA:  LDA  SPMNXT
LCCCD:  INCA
LCCCE:  CMPA #$DF                   ;one past the last story message ($DE)
LCCD0:  BLO  LCCDA                  ;IFHS  NO MORE MESSAGES
LCCD2:  LDD  #$FFFF                 ;DISABLE ALARM
LCCD5:  STD  SPMALM                 ;TIMER WILL NEVER GET THIS FAR
LCCD8:  BRA  LCCE9                  ;ELSE
LCCDA:  STA  SPMNXT                 ;NEXT MESSAGE TO GO OUT
LCCDD:  LDX  #TSPMAL-(2*$D8)        ;GET ALARM TIME
LCCE0:  TFR  A,B
LCCE2:  ABX                         ;WORD TABLE
LCCE3:  ABX
LCCE4:  LDD  ,X
LCCE6:  STD  SPMALM                 ;NEW ALARM
LCCE9:  PULS X,U,PC

TSPMAL:          ;ALARM TIMES FOR SPECIAL MESSAGES
LCCEB:  .word $0041
LCCED:  .word $0050
LCCEF:  .word $0060
LCCF1:  .word $0070
LCCF3:  .word $0080
LCCF5:  .word $0090
LCCF7:  .word $00A0
LCCF9:  .word $00B8

mes_colour_tab:
LCCFB:  .word $6180, $6280, $6380, $6480 ;colour instruction of a message line, indexed by the line's first byte (index times 2): 0-3 colours 1-4 at brightness $80, 4 colour 4 at $F0, 5-7 colours 5-7 at $80, 8-10 white at $00, $10, $20 for the intensity test, 11 a JSRL to the medium flash slot VRMFL
LCD03:  .word $64F0, $6580, $6680, $6780
LCD0B:  .word $6700, $6710, $6720, $A015
LCD13:  .byte $02, $97, $BC         ;message $00 line 1: colour 1, y -420, x -272
LCD16:  .byte $54, $48, $45, $20, $45, $4D, $50, $49 ;"THE EMPIRE STRIKES BACK"
LCD1E:  .byte $52, $45, $20, $53, $54, $52, $49, $4B
LCD26:  .byte $45, $53, $20, $42, $41, $43, $CB
LCD2D:  .byte $02, $90, $80         ;message $00 line 2: colour 1, y -448, x -512
LCD30:  .byte $20, $20, $23, $20, $31, $39, $38, $35 ;"  # 1985 LUCASFILM LTD.AND ATARI GAMES,INC."
LCD38:  .byte $20, $4C, $55, $43, $41, $53, $46, $49
LCD40:  .byte $4C, $4D, $20, $4C, $54, $44, $2E, $41
LCD48:  .byte $4E, $44, $20, $41, $54, $41, $52, $49
LCD50:  .byte $20, $47, $41, $4D, $45, $53, $2C, $49
LCD58:  .byte $4E, $43, $AE
LCD5B:  .byte $02, $87, $C5         ;message $00 line 3: colour 1, y -484, x -236

MES2:
LCD5E:  .byte $41, $4C, $4C, $20, $52, $49, $47, $48 ;"ALL RIGHTS RESERVED."
LCD66:  .byte $54, $53, $20, $52, $45, $53, $45, $52
LCD6E:  .byte $56, $45, $44, $AE
LCD72:  .byte $02, $80, $80         ;message $00 line 4: colour 1, y -512, x -512
LCD75:  .byte $20, $20, $20, $4C, $55, $43, $41, $53 ;"   LUCASFILM TRADEMARKS USED UNDER LICENSE."
LCD7D:  .byte $46, $49, $4C, $4D, $20, $54, $52, $41
LCD85:  .byte $44, $45, $4D, $41, $52, $4B, $53, $20
LCD8D:  .byte $55, $53, $45, $44, $20, $55, $4E, $44
LCD95:  .byte $45, $52, $20, $4C, $49, $43, $45, $4E
LCD9D:  .byte $53, $45, $AE
LCDA0:  .byte $02, $32, $B9         ;message $01 line 1: colour 1, y 200, x -284
LCDA3:  .byte $41, $54, $41, $52, $49, $27, $53, $20 ;"ATARI'S GAME DESIGN TEAM"
LCDAB:  .byte $47, $41, $4D, $45, $20, $44, $45, $53
LCDB3:  .byte $49, $47, $4E, $20, $54, $45, $41, $CD
LCDBB:  .byte $02, $25, $F8         ;message $01 line 2: colour 1, y 148, x -32
LCDBE:  .byte $46, $4F, $D2         ;"FOR"
LCDC1:  .byte $02, $19, $B6         ;message $01 line 3: colour 1, y 100, x -296
LCDC4:  .byte $27, $54, $48, $45, $20, $45, $4D, $50 ;"'THE EMPIRE STRIKES BACK'"
LCDCC:  .byte $49, $52, $45, $20, $53, $54, $52, $49
LCDD4:  .byte $4B, $45, $53, $20, $42, $41, $43, $4B
LCDDC:  .byte $A7
LCDDD:  .byte $0E, $F6, $B7         ;message $01 line 4: colour 7, y -40, x -292
LCDE0:  .byte $4D, $49, $4B, $45, $20, $48, $41, $4C ;"MIKE HALLY"
LCDE8:  .byte $4C, $D9
LCDEA:  .byte $00, $F6, $05         ;message $01 line 5: colour 0, y -40, x 20
LCDED:  .byte $50, $52, $4F, $44, $55, $43, $54, $20 ;"PRODUCT MANAGER"
LCDF5:  .byte $4D, $41, $4E, $41, $47, $45, $D2
LCDFC:  .byte $0E, $E7, $B1         ;message $01 line 6: colour 7, y -100, x -316
LCDFF:  .byte $47, $52, $45, $47, $20, $52, $49, $56 ;"GREG RIVERA"
LCE07:  .byte $45, $52, $C1
LCE0A:  .byte $00, $E7, $05         ;message $01 line 7: colour 0, y -100, x 20
LCE0D:  .byte $50, $52, $4F, $47, $52, $41, $4D, $4D ;"PROGRAMMER"
LCE15:  .byte $45, $D2
LCE17:  .byte $0E, $D8, $AB         ;message $01 line 8: colour 7, y -160, x -340
LCE1A:  .byte $4E, $4F, $52, $4D, $20, $41, $56, $45 ;"NORM AVELLAR"
LCE22:  .byte $4C, $4C, $41, $D2
LCE26:  .byte $00, $D8, $05         ;message $01 line 9: colour 0, y -160, x 20
LCE29:  .byte $50, $52, $4F, $47, $52, $41, $4D, $4D ;"PROGRAMMER"
LCE31:  .byte $45, $D2
LCE33:  .byte $0E, $C9, $C3         ;message $01 line 10: colour 7, y -220, x -244
LCE36:  .byte $52, $4F, $42, $20, $52, $4F, $57, $C5 ;"ROB ROWE"
LCE3E:  .byte $00, $C9, $05         ;message $01 line 11: colour 0, y -220, x 20
LCE41:  .byte $54, $45, $43, $48, $4E, $49, $43, $49 ;"TECHNICIAN"
LCE49:  .byte $41, $CE
LCE4B:  .byte $02, $B5, $CB         ;message $01 line 12: colour 1, y -300, x -212
LCE4E:  .byte $53, $50, $45, $43, $49, $41, $4C, $20 ;"SPECIAL THANKS TO:"
LCE56:  .byte $54, $48, $41, $4E, $4B, $53, $20, $54
LCE5E:  .byte $4F, $BA
LCE60:  .byte $0E, $AB, $8C         ;message $01 line 13: colour 7, y -340, x -464
LCE63:  .byte $42, $52, $41, $44, $20, $46, $55, $4C ;"BRAD FULLER, JED MARGOLIN, DAVE RALSTON"
LCE6B:  .byte $4C, $45, $52, $2C, $20, $4A, $45, $44
LCE73:  .byte $20, $4D, $41, $52, $47, $4F, $4C, $49
LCE7B:  .byte $4E, $2C, $20, $44, $41, $56, $45, $20
LCE83:  .byte $52, $41, $4C, $53, $54, $4F, $CE
LCE8A:  .byte $0E, $A1, $AA         ;message $01 line 14: colour 7, y -380, x -344
LCE8D:  .byte $44, $4F, $55, $47, $20, $53, $4E, $59 ;"DOUG SNYDER, AND EARL VICKERS"
LCE95:  .byte $44, $45, $52, $2C, $20, $41, $4E, $44
LCE9D:  .byte $20, $45, $41, $52, $4C, $20, $56, $49
LCEA5:  .byte $43, $4B, $45, $52, $D3
LCEAA:  .byte $08, $00, $E6         ;message $02 line 1: colour 4, y 0, x -104
LCEAD:  .byte $47, $41, $4D, $45, $20, $4F, $56, $45 ;"GAME OVER"
LCEB5:  .byte $D2
LCEB6:  .byte $04, $78, $E6         ;message $03 line 1: colour 2, y 480, x -104
LCEB9:  .byte $47, $41, $4D, $45, $20, $4F, $56, $45 ;"GAME OVER"
LCEC1:  .byte $D2
LCEC2:  .byte $00, $78, $DD         ;message $04 line 1: colour 0, y 480, x -140

MES6:
LCEC5:  .byte $49, $4E, $53, $45, $52, $54, $20, $43 ;"INSERT COINS"
LCECD:  .byte $4F, $49, $4E, $D3
LCED1:  .byte $0C, $72, $E6         ;message $05 line 1: colour 6, y 456, x -104
LCED4:  .byte $46, $52, $45, $45, $20, $50, $4C, $41 ;"FREE PLAY"
LCEDC:  .byte $D9
LCEDD:  .byte $0C, $6C, $D7         ;message $06 line 1: colour 6, y 432, x -164

MES8:
LCEE0:  .byte $32, $20, $50, $4C, $41, $59, $53, $20 ;"2 PLAYS 1 COIN"
LCEE8:  .byte $31, $20, $43, $4F, $49, $CE
LCEEE:  .byte $0C, $6C, $DA         ;message $07 line 1: colour 6, y 432, x -152

MES9:
LCEF1:  .byte $31, $20, $43, $4F, $49, $4E, $20, $31 ;"1 COIN 1 PLAY"
LCEF9:  .byte $20, $50, $4C, $41, $D9
LCEFE:  .byte $0C, $6C, $D7         ;message $08 line 1: colour 6, y 432, x -164

MES10:
LCF01:  .byte $32, $20, $43, $4F, $49, $4E, $53, $20 ;"2 COINS 1 PLAY"
LCF09:  .byte $31, $20, $50, $4C, $41, $D9
LCF0F:  .byte $16, $60, $C2         ;message $09 line 1: colour 11, y 384, x -248

MES11:
LCF12:  .byte $50, $55, $4C, $4C, $20, $54, $52, $49 ;"PULL TRIGGER TO START"
LCF1A:  .byte $47, $47, $45, $52, $20, $54, $4F, $20
LCF22:  .byte $53, $54, $41, $52, $D4
LCF27:  .byte $0E, $6C, $F1         ;message $0A line 1: colour 7, y 432, x -60
LCF2A:  .byte $43, $52, $45, $44, $49, $54, $D3 ;"CREDITS"
LCF31:  .byte $0E, $6C, $F1         ;message $0B line 1: colour 7, y 432, x -60
LCF34:  .byte $43, $52, $45, $44, $49, $D4 ;"CREDIT"
LCF3A:  .byte $02, $66, $EC         ;message $0C line 1: colour 1, y 408, x -80
LCF3D:  .byte $53, $48, $49, $45, $4C, $44, $D3 ;"SHIELDS"
LCF44:  .byte $06, $3C, $EC         ;message $0D line 1: colour 3, y 240, x -80
LCF47:  .byte $53, $48, $49, $45, $4C, $44, $D3 ;"SHIELDS"
LCF4E:  .byte $06, $33, $F5         ;message $0D line 2: colour 3, y 204, x -44
LCF51:  .byte $47, $4F, $4E, $C5    ;"GONE"
LCF55:  .byte $06, $7E, $5B         ;message $0E line 1: colour 3, y 504, x 364
LCF58:  .byte $57, $41, $56, $C5    ;"WAVE"
LCF5C:  .byte $06, $6C, $3E         ;message $0F line 1: colour 3, y 432, x 248
LCF5F:  .byte $50, $52, $4F, $42, $4F, $54, $D3 ;"PROBOTS"
LCF66:  .byte $06, $6C, $3E         ;message $10 line 1: colour 3, y 432, x 248
LCF69:  .byte $57, $41, $4C, $4B, $45, $52, $D3 ;"WALKERS"
LCF70:  .byte $06, $6C, $41         ;message $11 line 1: colour 3, y 432, x 260
LCF73:  .byte $54, $49, $45, $D3    ;"TIES"
LCF77:  .byte $06, $6C, $3E         ;message $12 line 1: colour 3, y 432, x 248
LCF7A:  .byte $A0                   ;" "
LCF7B:  .byte $06, $6C, $41         ;message $13 line 1: colour 3, y 432, x 260
LCF7E:  .byte $54, $49, $4D, $45, $D2 ;"TIMER"
LCF83:  .byte $06, $6C, $41         ;message $14 line 1: colour 3, y 432, x 260
LCF86:  .byte $A0                   ;" "
LCF87:  .byte $06, $36, $C8         ;message $15 line 1: colour 3, y 216, x -224

MES15:
LCF8A:  .byte $46, $4C, $49, $47, $48, $54, $20, $49 ;"FLIGHT INSTRUCTIONS"
LCF92:  .byte $4E, $53, $54, $52, $55, $43, $54, $49
LCF9A:  .byte $4F, $4E, $D3
LCF9D:  .byte $02, $1B, $A3         ;message $16 line 1: colour 1, y 108, x -372
LCFA0:  .byte $31, $2E, $20, $20, $59, $4F, $55, $20 ;"1.  YOU BEGIN WITH ENOUGH 'FORCE'"
LCFA8:  .byte $42, $45, $47, $49, $4E, $20, $57, $49
LCFB0:  .byte $54, $48, $20, $45, $4E, $4F, $55, $47
LCFB8:  .byte $48, $20, $27, $46, $4F, $52, $43, $45
LCFC0:  .byte $A7
LCFC1:  .byte $02, $12, $A9         ;message $17 line 1: colour 1, y 72, x -348
LCFC4:  .byte $54, $4F, $20, $50, $52, $4F, $54, $45 ;"TO PROTECT YOU FOR   COLLISIONS."
LCFCC:  .byte $43, $54, $20, $59, $4F, $55, $20, $46
LCFD4:  .byte $4F, $52, $20, $20, $20, $43, $4F, $4C
LCFDC:  .byte $4C, $49, $53, $49, $4F, $4E, $53, $AE
LCFE4:  .byte $02, $F7, $A3         ;message $18 line 1: colour 1, y -36, x -372
LCFE7:  .byte $32, $2E, $20, $20, $27, $46, $4F, $52 ;"2.  'FORCE' STRENGTH IS LOST WHEN"
LCFEF:  .byte $43, $45, $27, $20, $53, $54, $52, $45
LCFF7:  .byte $4E, $47, $54, $48, $20, $49, $53, $20
LCFFF:  .byte $4C, $4F, $53, $54, $20, $57, $48, $45
LD007:  .byte $CE
LD008:  .byte $02, $EE, $A9         ;message $19 line 1: colour 1, y -72, x -348
LD00B:  .byte $59, $4F, $55, $20, $43, $4F, $4C, $4C ;"YOU COLLIDE WITH ENEMY SHOTS,"
LD013:  .byte $49, $44, $45, $20, $57, $49, $54, $48
LD01B:  .byte $20, $45, $4E, $45, $4D, $59, $20, $53
LD023:  .byte $48, $4F, $54, $53, $AC
LD028:  .byte $02, $E5, $A9         ;message $1A line 1: colour 1, y -108, x -348
LD02B:  .byte $57, $41, $4C, $4B, $45, $52, $53, $20 ;"WALKERS AND ASTEROIDS."
LD033:  .byte $41, $4E, $44, $20, $41, $53, $54, $45
LD03B:  .byte $52, $4F, $49, $44, $53, $AE
LD041:  .byte $02, $CA, $A3         ;message $1B line 1: colour 1, y -216, x -372

MES23:
LD044:  .byte $33, $2E, $20, $20, $41, $49, $4D, $20 ;"3.  AIM YOUR LASERS WITH CURSOR TO"
LD04C:  .byte $59, $4F, $55, $52, $20, $4C, $41, $53
LD054:  .byte $45, $52, $53, $20, $57, $49, $54, $48
LD05C:  .byte $20, $43, $55, $52, $53, $4F, $52, $20
LD064:  .byte $54, $CF
LD066:  .byte $02, $C1, $A9         ;message $1C line 1: colour 1, y -252, x -348
LD069:  .byte $45, $58, $50, $4C, $4F, $44, $45, $20 ;"EXPLODE PROBOTS, TRANSMISSIONS,"
LD071:  .byte $50, $52, $4F, $42, $4F, $54, $53, $2C
LD079:  .byte $20, $54, $52, $41, $4E, $53, $4D, $49
LD081:  .byte $53, $53, $49, $4F, $4E, $53, $AC
LD088:  .byte $02, $B8, $A9         ;message $1D line 1: colour 1, y -288, x -348
LD08B:  .byte $57, $41, $4C, $4B, $45, $52, $53, $2C ;"WALKERS, TIE FIGHTERS AND SHOTS."
LD093:  .byte $20, $54, $49, $45, $20, $46, $49, $47
LD09B:  .byte $48, $54, $45, $52, $53, $20, $41, $4E
LD0A3:  .byte $44, $20, $53, $48, $4F, $54, $53, $AE
LD0AB:  .byte $02, $9D, $A3         ;message $1E line 1: colour 1, y -396, x -372
LD0AE:  .byte $34, $2E, $20, $20, $41, $56, $4F, $49 ;"4.  AVOID COLLISION WITH ASTEROIDS"
LD0B6:  .byte $44, $20, $43, $4F, $4C, $4C, $49, $53
LD0BE:  .byte $49, $4F, $4E, $20, $57, $49, $54, $48
LD0C6:  .byte $20, $41, $53, $54, $45, $52, $4F, $49
LD0CE:  .byte $44, $D3
LD0D0:  .byte $02, $94, $A9         ;message $1F line 1: colour 1, y -432, x -348
LD0D3:  .byte $42, $59, $20, $46, $4C, $59, $49, $4E ;"BY FLYING AROUND THEM."
LD0DB:  .byte $47, $20, $41, $52, $4F, $55, $4E, $44
LD0E3:  .byte $20, $54, $48, $45, $4D, $AE
LD0E9:  .byte $02, $12, $18         ;message $20 line 1: colour 1, y 72, x 96
LD0EC:  .byte $B2                   ;"2"
LD0ED:  .byte $02, $12, $18         ;message $21 line 1: colour 1, y 72, x 96
LD0F0:  .byte $B3                   ;"3"
LD0F1:  .byte $02, $12, $18         ;message $22 line 1: colour 1, y 72, x 96
LD0F4:  .byte $B4                   ;"4"
LD0F5:  .byte $02, $12, $18         ;message $23 line 1: colour 1, y 72, x 96
LD0F8:  .byte $B5                   ;"5"
LD0F9:  .byte $06, $46, $DA         ;message $24 line 1: colour 3, y 280, x -152
LD0FC:  .byte $52, $45, $42, $45, $4C, $20, $53, $43 ;"REBEL SCORING"
LD104:  .byte $4F, $52, $49, $4E, $C7
LD109:  .byte $06, $2D, $92         ;message $25 line 1: colour 3, y 180, x -440
LD10C:  .byte $2A, $50, $52, $4F, $42, $4F, $D4 ;"*PROBOT"
LD113:  .byte $0C, $2D, $5E         ;message $25 line 2: colour 6, y 180, x 376
LD116:  .byte $32, $B5              ;"25"
LD118:  .byte $06, $20, $98         ;message $25 line 3: colour 3, y 128, x -416
LD11B:  .byte $46, $49, $52, $45, $42, $41, $4C, $CC ;"FIREBALL"
LD123:  .byte $0C, $20, $64         ;message $25 line 4: colour 6, y 128, x 400
LD126:  .byte $B3                   ;"3"
LD127:  .byte $06, $14, $98         ;message $26 line 1: colour 3, y 80, x -416
LD12A:  .byte $54, $52, $41, $4E, $53, $4D, $49, $53 ;"TRANSMISSION"
LD132:  .byte $53, $49, $4F, $CE
LD136:  .byte $0C, $14, $64         ;message $26 line 2: colour 6, y 80, x 400
LD139:  .byte $B5                   ;"5"
LD13A:  .byte $06, $07, $92         ;message $26 line 3: colour 3, y 28, x -440
LD13D:  .byte $2A, $41, $54, $2D, $53, $D4 ;"*AT-ST"
LD143:  .byte $0C, $07, $5E         ;message $26 line 4: colour 6, y 28, x 376
LD146:  .byte $35, $B0              ;"50"
LD148:  .byte $06, $FB, $92         ;message $27 line 1: colour 3, y -20, x -440
LD14B:  .byte $2A, $41, $54, $2D, $41, $D4 ;"*AT-AT"
LD151:  .byte $0C, $FB, $5E         ;message $27 line 2: colour 6, y -20, x 376
LD154:  .byte $37, $B5              ;"75"
LD156:  .byte $06, $EF, $98         ;message $27 line 3: colour 3, y -68, x -416
LD159:  .byte $46, $4C, $59, $49, $4E, $47, $20, $42 ;"FLYING BONUS"
LD161:  .byte $4F, $4E, $55, $D3
LD165:  .byte $0C, $EF, $07         ;message $27 line 4: colour 6, y -68, x 28
LD168:  .byte $50, $52, $4F, $47, $52, $45, $53, $53 ;"PROGRESSIVE 5,000"
LD170:  .byte $49, $56, $45, $20, $35, $2C, $30, $30
LD178:  .byte $B0
LD179:  .byte $06, $E2, $98         ;message $28 line 1: colour 3, y -120, x -416
LD17C:  .byte $53, $54, $41, $52, $20, $53, $48, $4F ;"STAR SHOT"
LD184:  .byte $D4
LD185:  .byte $0C, $E2, $64         ;message $28 line 2: colour 6, y -120, x 400
LD188:  .byte $B7                   ;"7"
LD189:  .byte $06, $D6, $92         ;message $28 line 3: colour 3, y -168, x -440
LD18C:  .byte $2A, $54, $49, $45, $20, $46, $49, $47 ;"*TIE FIGHTER"
LD194:  .byte $48, $54, $45, $D2
LD198:  .byte $0C, $D6, $58         ;message $28 line 4: colour 6, y -168, x 352
LD19B:  .byte $31, $30, $B0         ;"100"
LD19E:  .byte $06, $C9, $98         ;message $28 line 5: colour 3, y -220, x -416
LD1A1:  .byte $57, $41, $56, $45, $20, $43, $4F, $4D ;"WAVE COMPLETED"
LD1A9:  .byte $50, $4C, $45, $54, $45, $C4
LD1AF:  .byte $0C, $C9, $4C         ;message $28 line 6: colour 6, y -220, x 304
LD1B2:  .byte $32, $2C, $35, $30, $B0 ;"2,500"
LD1B7:  .byte $06, $BD, $98         ;message $29 line 1: colour 3, y -268, x -416
LD1BA:  .byte $4A, $45, $44, $49, $20, $4C, $45, $54 ;"JEDI LETTER"
LD1C2:  .byte $54, $45, $D2
LD1C5:  .byte $0C, $BD, $4C         ;message $29 line 2: colour 6, y -268, x 304
LD1C8:  .byte $35, $2C, $30, $30, $B0 ;"5,000"
LD1CD:  .byte $06, $B0, $98         ;message $29 line 3: colour 3, y -320, x -416
LD1D0:  .byte $4A, $45, $44, $49, $20, $42, $4F, $4E ;"JEDI BONUS"
LD1D8:  .byte $55, $D3
LD1DA:  .byte $0C, $B0, $46         ;message $29 line 4: colour 6, y -320, x 280
LD1DD:  .byte $32, $30, $2C, $30, $30, $B0 ;"20,000"
LD1E3:  .byte $06, $A4, $89         ;message $2A line 1: colour 3, y -368, x -476
LD1E6:  .byte $2A, $20, $31, $30, $20, $58, $20, $53 ;"* 10 X SCORING AFTER EARNING JEDI LETTER"
LD1EE:  .byte $43, $4F, $52, $49, $4E, $47, $20, $41
LD1F6:  .byte $46, $54, $45, $52, $20, $45, $41, $52
LD1FE:  .byte $4E, $49, $4E, $47, $20, $4A, $45, $44
LD206:  .byte $49, $20, $4C, $45, $54, $54, $45, $D2
LD20E:  .byte $0A, $55, $B3         ;message $2B line 1: colour 5, y 340, x -308
LD211:  .byte $53, $45, $4C, $45, $43, $54, $20, $53 ;"SELECT STARTING DIFFICULTY"
LD219:  .byte $54, $41, $52, $54, $49, $4E, $47, $20
LD221:  .byte $44, $49, $46, $46, $49, $43, $55, $4C
LD229:  .byte $54, $D9
LD22B:  .byte $0A, $4B, $8F         ;message $2B line 2: colour 5, y 300, x -452
LD22E:  .byte $4D, $4F, $56, $45, $20, $43, $55, $52 ;"MOVE CURSOR TO A PLANET AND FIRE LASER"
LD236:  .byte $53, $4F, $52, $20, $54, $4F, $20, $41
LD23E:  .byte $20, $50, $4C, $41, $4E, $45, $54, $20
LD246:  .byte $41, $4E, $44, $20, $46, $49, $52, $45
LD24E:  .byte $20, $4C, $41, $53, $45, $D2
LD254:  .byte $16, $41, $E6         ;message $2B line 3: colour 11, y 260, x -104
LD257:  .byte $43, $4F, $55, $4E, $54, $44, $4F, $57 ;"COUNTDOWN"
LD25F:  .byte $CE
LD260:  .byte $02, $08, $B5         ;message $2B line 4: colour 1, y 32, x -300
LD263:  .byte $45, $41, $53, $D9    ;"EASY"
LD267:  .byte $06, $32, $8B         ;message $2B line 5: colour 3, y 200, x -468
LD26A:  .byte $57, $41, $56, $45, $20, $B1 ;"WAVE 1"
LD270:  .byte $00, $FD, $85         ;message $2B line 6: colour 0, y -12, x -492
LD273:  .byte $4E, $4F, $20, $42, $4F, $4E, $55, $D3 ;"NO BONUS"
LD27B:  .byte $02, $CE, $EF         ;message $2B line 7: colour 1, y -200, x -68
LD27E:  .byte $4D, $45, $44, $49, $55, $CD ;"MEDIUM"
LD284:  .byte $06, $D8, $EF         ;message $2B line 8: colour 3, y -160, x -68
LD287:  .byte $57, $41, $56, $45, $20, $B2 ;"WAVE 2"
LD28D:  .byte $00, $97, $F2         ;message $2B line 9: colour 0, y -420, x -56
LD290:  .byte $42, $4F, $4E, $55, $D3 ;"BONUS"
LD295:  .byte $06, $8D, $EC         ;message $2B line 10: colour 3, y -460, x -80
LD298:  .byte $31, $30, $30, $2C, $30, $30, $B0 ;"100,000"
LD29F:  .byte $02, $08, $38         ;message $2B line 11: colour 1, y 32, x 224
LD2A2:  .byte $48, $41, $52, $C4    ;"HARD"
LD2A6:  .byte $06, $32, $53         ;message $2B line 12: colour 3, y 200, x 332
LD2A9:  .byte $57, $41, $56, $45, $20, $B3 ;"WAVE 3"
LD2AF:  .byte $00, $FD, $56         ;message $2B line 13: colour 0, y -12, x 344
LD2B2:  .byte $42, $4F, $4E, $55, $D3 ;"BONUS"
LD2B7:  .byte $06, $F3, $50         ;message $2B line 14: colour 3, y -52, x 320
LD2BA:  .byte $32, $35, $30, $2C, $30, $30, $B0 ;"250,000"
LD2C1:  .byte $06, $D8, $8B         ;message $2B line 15: colour 3, y -160, x -468
LD2C4:  .byte $49, $4E, $53, $54, $52, $55, $43, $54 ;"INSTRUCTIONS"
LD2CC:  .byte $49, $4F, $4E, $D3
LD2D0:  .byte $06, $D8, $32         ;message $2B line 16: colour 3, y -160, x 200
LD2D3:  .byte $49, $4E, $53, $54, $52, $55, $43, $54 ;"INSTRUCTIONS"
LD2DB:  .byte $49, $4F, $4E, $D3
LD2DF:  .byte $02, $78, $B6         ;message $2C line 1: colour 1, y 480, x -296

MES37:
LD2E2:  .byte $44, $41, $52, $54, $48, $20, $56, $41 ;"DARTH VADER'S EXECUTOR IS"
LD2EA:  .byte $44, $45, $52, $27, $53, $20, $45, $58
LD2F2:  .byte $45, $43, $55, $54, $4F, $52, $20, $49
LD2FA:  .byte $D3
LD2FB:  .byte $02, $69, $A4         ;message $2C line 2: colour 1, y 420, x -368
LD2FE:  .byte $53, $45, $41, $52, $43, $48, $49, $4E ;"SEARCHING FOR THE REBEL HIDEOUT"
LD306:  .byte $47, $20, $46, $4F, $52, $20, $54, $48
LD30E:  .byte $45, $20, $52, $45, $42, $45, $4C, $20
LD316:  .byte $48, $49, $44, $45, $4F, $55, $D4
LD31D:  .byte $02, $41, $E6         ;message $2D line 1: colour 1, y 260, x -104
LD320:  .byte $43, $4F, $55, $4E, $54, $44, $4F, $57 ;"COUNTDOWN"
LD328:  .byte $CE
LD329:  .byte $06, $00, $A4         ;message $2D line 2: colour 3, y 0, x -368
LD32C:  .byte $59, $4F, $55, $20, $4D, $41, $59, $20 ;"YOU MAY START YOUR NEXT GAME ON"
LD334:  .byte $53, $54, $41, $52, $54, $20, $59, $4F
LD33C:  .byte $55, $52, $20, $4E, $45, $58, $54, $20
LD344:  .byte $47, $41, $4D, $45, $20, $4F, $CE
LD34B:  .byte $06, $F0, $EB         ;message $2D line 3: colour 3, y -64, x -84
LD34E:  .byte $57, $41, $56, $C5    ;"WAVE"
LD352:  .byte $00, $B5, $F2         ;message $2D line 4: colour 0, y -300, x -56
LD355:  .byte $42, $4F, $4E, $55, $D3 ;"BONUS"
LD35A:  .byte $16, $28, $D4         ;message $2E line 1: colour 11, y 160, x -176
LD35D:  .byte $43, $4F, $4E, $47, $52, $41, $54, $55 ;"CONGRATULATIONS"
LD365:  .byte $4C, $41, $54, $49, $4F, $4E, $D3
LD36C:  .byte $0E, $1E, $BF         ;message $2E line 2: colour 7, y 120, x -260
LD36F:  .byte $41, $44, $56, $41, $4E, $43, $45, $44 ;"ADVANCED WAVE FINISHED"
LD377:  .byte $20, $57, $41, $56, $45, $20, $46, $49
LD37F:  .byte $4E, $49, $53, $48, $45, $C4
LD385:  .byte $0E, $14, $C2         ;message $2E line 3: colour 7, y 80, x -248
LD388:  .byte $41, $4E, $44, $20, $4A, $45, $44, $49 ;"AND JEDI BONUS EARNED"
LD390:  .byte $20, $42, $4F, $4E, $55, $53, $20, $45
LD398:  .byte $41, $52, $4E, $45, $C4
LD39D:  .byte $0E, $23, $B9         ;message $2F line 1: colour 7, y 140, x -284
LD3A0:  .byte $59, $4F, $55, $20, $4D, $55, $53, $54 ;"YOU MUST EARN JEDI BONUS"
LD3A8:  .byte $20, $45, $41, $52, $4E, $20, $4A, $45
LD3B0:  .byte $44, $49, $20, $42, $4F, $4E, $55, $D3
LD3B8:  .byte $0E, $19, $B9         ;message $2F line 2: colour 7, y 100, x -284
LD3BB:  .byte $54, $4F, $20, $53, $54, $41, $52, $54 ;"TO START AT HIGHER WAVES"
LD3C3:  .byte $20, $41, $54, $20, $48, $49, $47, $48
LD3CB:  .byte $45, $52, $20, $57, $41, $56, $45, $D3
LD3D3:  .byte $0E, $28, $A4         ;message $30 line 1: colour 7, y 160, x -368
LD3D6:  .byte $59, $4F, $55, $20, $4D, $55, $53, $54 ;"YOU MUST COMPLETE ADVANCED WAVE"
LD3DE:  .byte $20, $43, $4F, $4D, $50, $4C, $45, $54
LD3E6:  .byte $45, $20, $41, $44, $56, $41, $4E, $43
LD3EE:  .byte $45, $44, $20, $57, $41, $56, $C5
LD3F5:  .byte $0E, $1E, $C8         ;message $30 line 2: colour 7, y 120, x -224
LD3F8:  .byte $41, $4E, $44, $20, $45, $41, $52, $4E ;"AND EARN JEDI BONUS"
LD400:  .byte $20, $4A, $45, $44, $49, $20, $42, $4F
LD408:  .byte $4E, $55, $D3
LD40B:  .byte $0E, $14, $B9         ;message $30 line 3: colour 7, y 80, x -284
LD40E:  .byte $54, $4F, $20, $53, $54, $41, $52, $54 ;"TO START AT HIGHER WAVES"
LD416:  .byte $20, $41, $54, $20, $48, $49, $47, $48
LD41E:  .byte $45, $52, $20, $57, $41, $56, $45, $D3
LD426:  .byte $0C, $50, $A4         ;message $31 line 1: colour 6, y 320, x -368

MES58:
LD429:  .byte $4D, $45, $53, $53, $41, $47, $45, $20 ;"MESSAGE FROM REBEL COMMAND POST"
LD431:  .byte $46, $52, $4F, $4D, $20, $52, $45, $42
LD439:  .byte $45, $4C, $20, $43, $4F, $4D, $4D, $41
LD441:  .byte $4E, $44, $20, $50, $4F, $53, $D4
LD448:  .byte $16, $46, $9B         ;message $31 line 2: colour 11, y 280, x -404
LD44B:  .byte $59, $4F, $55, $52, $20, $53, $54, $52 ;"YOUR STRENGTH FLOWS FROM THE FORCE"
LD453:  .byte $45, $4E, $47, $54, $48, $20, $46, $4C
LD45B:  .byte $4F, $57, $53, $20, $46, $52, $4F, $4D
LD463:  .byte $20, $54, $48, $45, $20, $46, $4F, $52
LD46B:  .byte $43, $C5
LD46D:  .byte $00, $3C, $B0         ;message $31 line 3: colour 0, y 240, x -320
LD470:  .byte $42, $55, $54, $20, $42, $45, $57, $41 ;"BUT BEWARE OF THE DARK SIDE"
LD478:  .byte $52, $45, $20, $4F, $46, $20, $54, $48
LD480:  .byte $45, $20, $44, $41, $52, $4B, $20, $53
LD488:  .byte $49, $44, $C5
LD48B:  .byte $02, $1E, $C8         ;message $31 line 4: colour 1, y 120, x -224

MES61:
LD48E:  .byte $53, $48, $4F, $4F, $54, $20, $59, $4F ;"SHOOT YOUR INITIALS"
LD496:  .byte $55, $52, $20, $49, $4E, $49, $54, $49
LD49E:  .byte $41, $4C, $D3
LD4A1:  .byte $16, $00, $CB         ;message $32 line 1: colour 11, y 0, x -212
LD4A4:  .byte $52, $45, $42, $45, $4C, $20, $46, $4F ;"REBEL FORCE ROSTER"
LD4AC:  .byte $52, $43, $45, $20, $52, $4F, $53, $54
LD4B4:  .byte $45, $D2
LD4B6:  .byte $00, $80, $E2         ;message $32 line 2: colour 0, y -512, x -120
LD4B9:  .byte $4A, $45, $44, $49, $20, $4B, $4E, $49 ;"JEDI KNIGHT"
LD4C1:  .byte $47, $48, $D4
LD4C4:  .byte $06, $4F, $CB         ;message $33 line 1: colour 3, y 316, x -212
LD4C7:  .byte $52, $45, $42, $45, $4C, $20, $46, $4F ;"REBEL FORCE ROSTER"
LD4CF:  .byte $52, $43, $45, $20, $52, $4F, $53, $54
LD4D7:  .byte $45, $D2
LD4D9:  .byte $00, $A0, $E2         ;message $33 line 2: colour 0, y -384, x -120
LD4DC:  .byte $4A, $45, $44, $49, $20, $4B, $4E, $49 ;"JEDI KNIGHT"
LD4E4:  .byte $47, $48, $D4
LD4E7:  .byte $06, $54, $92         ;message $34 line 1: colour 3, y 336, x -440
LD4EA:  .byte $49, $4D, $50, $45, $52, $49, $41, $4C ;"IMPERIAL PROBOTS SEARCHING FOR REBELS"
LD4F2:  .byte $20, $50, $52, $4F, $42, $4F, $54, $53
LD4FA:  .byte $20, $53, $45, $41, $52, $43, $48, $49
LD502:  .byte $4E, $47, $20, $46, $4F, $52, $20, $52
LD50A:  .byte $45, $42, $45, $4C, $D3
LD50F:  .byte $0E, $54, $92         ;message $35 line 1: colour 7, y 336, x -440
LD512:  .byte $53, $48, $4F, $4F, $54, $20, $50, $52 ;"SHOOT PROBOTS AND THEIR TRANSMISSIONS"
LD51A:  .byte $4F, $42, $4F, $54, $53, $20, $41, $4E
LD522:  .byte $44, $20, $54, $48, $45, $49, $52, $20
LD52A:  .byte $54, $52, $41, $4E, $53, $4D, $49, $53
LD532:  .byte $53, $49, $4F, $4E, $D3
LD537:  .byte $06, $54, $98         ;message $36 line 1: colour 3, y 336, x -416
LD53A:  .byte $50, $41, $52, $54, $49, $41, $4C, $20 ;"PARTIAL TRANSMISSION SENT TO EMPIRE"
LD542:  .byte $54, $52, $41, $4E, $53, $4D, $49, $53
LD54A:  .byte $53, $49, $4F, $4E, $20, $53, $45, $4E
LD552:  .byte $54, $20, $54, $4F, $20, $45, $4D, $50
LD55A:  .byte $49, $52, $C5
LD55D:  .byte $0E, $54, $B3         ;message $37 line 1: colour 7, y 336, x -308
LD560:  .byte $53, $48, $4F, $4F, $54, $20, $20, $20 ;"SHOOT    PROBOTS FOR BONUS"
LD568:  .byte $20, $50, $52, $4F, $42, $4F, $54, $53
LD570:  .byte $20, $46, $4F, $52, $20, $42, $4F, $4E
LD578:  .byte $55, $D3
LD57A:  .byte $06, $54, $92         ;message $38 line 1: colour 3, y 336, x -440
LD57D:  .byte $44, $41, $52, $54, $48, $20, $56, $41 ;"DARTH VADER ALERTED TO REBEL LOCATION"
LD585:  .byte $44, $45, $52, $20, $41, $4C, $45, $52
LD58D:  .byte $54, $45, $44, $20, $54, $4F, $20, $52
LD595:  .byte $45, $42, $45, $4C, $20, $4C, $4F, $43
LD59D:  .byte $41, $54, $49, $4F, $CE
LD5A2:  .byte $06, $54, $A4         ;message $39 line 1: colour 3, y 336, x -368
LD5A5:  .byte $45, $4D, $50, $49, $52, $45, $20, $4C ;"EMPIRE LAUNCHING TROOPS TO HOTH"
LD5AD:  .byte $41, $55, $4E, $43, $48, $49, $4E, $47
LD5B5:  .byte $20, $54, $52, $4F, $4F, $50, $53, $20
LD5BD:  .byte $54, $4F, $20, $48, $4F, $54, $C8
LD5C4:  .byte $06, $54, $83         ;message $3A line 1: colour 3, y 336, x -500
LD5C7:  .byte $49, $4D, $50, $45, $52, $49, $41, $4C ;"IMPERIAL WALKERS ATTACKING POWER GENERATOR"
LD5CF:  .byte $20, $57, $41, $4C, $4B, $45, $52, $53
LD5D7:  .byte $20, $41, $54, $54, $41, $43, $4B, $49
LD5DF:  .byte $4E, $47, $20, $50, $4F, $57, $45, $52
LD5E7:  .byte $20, $47, $45, $4E, $45, $52, $41, $54
LD5EF:  .byte $4F, $D2
LD5F1:  .byte $0E, $54, $8F         ;message $3B line 1: colour 7, y 336, x -452
LD5F4:  .byte $53, $48, $4F, $4F, $54, $20, $52, $45 ;"SHOOT RED EYE OR USE TOW CABLE ON LEGS"
LD5FC:  .byte $44, $20, $45, $59, $45, $20, $4F, $52
LD604:  .byte $20, $55, $53, $45, $20, $54, $4F, $57
LD60C:  .byte $20, $43, $41, $42, $4C, $45, $20, $4F
LD614:  .byte $4E, $20, $4C, $45, $47, $D3
LD61A:  .byte $0E, $54, $B6         ;message $3C line 1: colour 7, y 336, x -296
LD61D:  .byte $53, $48, $4F, $4F, $54, $20, $52, $45 ;"SHOOT RED EYE WITH LASERS"
LD625:  .byte $44, $20, $45, $59, $45, $20, $57, $49
LD62D:  .byte $54, $48, $20, $4C, $41, $53, $45, $52
LD635:  .byte $D3
LD636:  .byte $06, $54, $B9         ;message $3D line 1: colour 3, y 336, x -284
LD639:  .byte $50, $41, $52, $54, $49, $41, $4C, $20 ;"PARTIAL GENERATOR DAMAGE"
LD641:  .byte $47, $45, $4E, $45, $52, $41, $54, $4F
LD649:  .byte $52, $20, $44, $41, $4D, $41, $47, $C5
LD651:  .byte $0E, $54, $B3         ;message $3E line 1: colour 7, y 336, x -308
LD654:  .byte $53, $48, $4F, $4F, $54, $20, $20, $20 ;"SHOOT    WALKERS FOR BONUS"
LD65C:  .byte $20, $57, $41, $4C, $4B, $45, $52, $53
LD664:  .byte $20, $46, $4F, $52, $20, $42, $4F, $4E
LD66C:  .byte $55, $D3
LD66E:  .byte $06, $54, $B6         ;message $3F line 1: colour 3, y 336, x -296
LD671:  .byte $52, $45, $42, $45, $4C, $53, $20, $45 ;"REBELS EVACUATING HIDEOUT"
LD679:  .byte $56, $41, $43, $55, $41, $54, $49, $4E
LD681:  .byte $47, $20, $48, $49, $44, $45, $4F, $55
LD689:  .byte $D4
LD68A:  .byte $0E, $54, $B6         ;message $40 line 1: colour 7, y 336, x -296
LD68D:  .byte $50, $4F, $57, $45, $52, $20, $47, $45 ;"POWER GENERATOR DESTROYED"
LD695:  .byte $4E, $45, $52, $41, $54, $4F, $52, $20
LD69D:  .byte $44, $45, $53, $54, $52, $4F, $59, $45
LD6A5:  .byte $C4
LD6A6:  .byte $0E, $32, $DD         ;message $41 line 1: colour 7, y 200, x -140
LD6A9:  .byte $20, $20, $54, $4F, $57, $20, $43, $41 ;"  TOW CABLES"
LD6B1:  .byte $42, $4C, $45, $D3
LD6B5:  .byte $0E, $32, $E0         ;message $42 line 1: colour 7, y 200, x -128
LD6B8:  .byte $31, $20, $54, $4F, $57, $20, $43, $41 ;"1 TOW CABLE"
LD6C0:  .byte $42, $4C, $C5
LD6C3:  .byte $0E, $32, $C8         ;message $43 line 1: colour 7, y 200, x -224
LD6C6:  .byte $41, $4C, $4C, $20, $54, $4F, $57, $20 ;"ALL TOW CABLES GONE"
LD6CE:  .byte $43, $41, $42, $4C, $45, $53, $20, $47
LD6D6:  .byte $4F, $4E, $C5
LD6D9:  .byte $0C, $32, $BF         ;message $44 line 1: colour 6, y 200, x -260
LD6DC:  .byte $42, $4F, $4E, $55, $53, $20, $50, $4F ;"BONUS POINTS FOR TRICK FLYING"
LD6E4:  .byte $49, $4E, $54, $53, $20, $46, $4F, $52
LD6EC:  .byte $20, $54, $52, $49, $43, $4B, $20, $46
LD6F4:  .byte $4C, $59, $49, $4E, $C7
LD6F9:  .byte $06, $19, $DA         ;message $45 line 1: colour 3, y 100, x -152
LD6FC:  .byte $52, $45, $42, $45, $4C, $20, $48, $49 ;"REBEL HIDEOUT"
LD704:  .byte $44, $45, $4F, $55, $D4
LD709:  .byte $0E, $54, $A4         ;message $46 line 1: colour 7, y 336, x -368
LD70C:  .byte $53, $48, $4F, $4F, $54, $20, $20, $20 ;"SHOOT    TIE FIGHTERS FOR BONUS"
LD714:  .byte $20, $54, $49, $45, $20, $46, $49, $47
LD71C:  .byte $48, $54, $45, $52, $53, $20, $46, $4F
LD724:  .byte $52, $20, $42, $4F, $4E, $55, $D3
LD72B:  .byte $06, $54, $8F         ;message $47 line 1: colour 3, y 336, x -452
LD72E:  .byte $53, $48, $4F, $4F, $54, $20, $45, $4E ;"SHOOT ENEMY SHOTS TO SAVE YOUR SHIELDS"
LD736:  .byte $45, $4D, $59, $20, $53, $48, $4F, $54
LD73E:  .byte $53, $20, $54, $4F, $20, $53, $41, $56
LD746:  .byte $45, $20, $59, $4F, $55, $52, $20, $53
LD74E:  .byte $48, $49, $45, $4C, $44, $D3
LD754:  .byte $0E, $54, $A1         ;message $48 line 1: colour 7, y 336, x -380
LD757:  .byte $53, $55, $52, $56, $49, $56, $45, $20 ;"SURVIVE TO EARN NEXT JEDI LETTER"
LD75F:  .byte $54, $4F, $20, $45, $41, $52, $4E, $20
LD767:  .byte $4E, $45, $58, $54, $20, $4A, $45, $44
LD76F:  .byte $49, $20, $4C, $45, $54, $54, $45, $D2
LD777:  .byte $06, $54, $A4         ;message $49 line 1: colour 3, y 336, x -368
LD77A:  .byte $41, $56, $4F, $49, $44, $20, $43, $4F ;"AVOID COLLISIONS WITH ASTEROIDS"
LD782:  .byte $4C, $4C, $49, $53, $49, $4F, $4E, $53
LD78A:  .byte $20, $57, $49, $54, $48, $20, $41, $53
LD792:  .byte $54, $45, $52, $4F, $49, $44, $D3
LD799:  .byte $16, $54, $95         ;message $4A line 1: colour 11, y 336, x -428
LD79C:  .byte $35, $2C, $30, $30, $30, $20, $50, $4F ;"5,000 POINTS AND JEDI LETTER AWARDED"
LD7A4:  .byte $49, $4E, $54, $53, $20, $41, $4E, $44
LD7AC:  .byte $20, $4A, $45, $44, $49, $20, $4C, $45
LD7B4:  .byte $54, $54, $45, $52, $20, $41, $57, $41
LD7BC:  .byte $52, $44, $45, $C4
LD7C0:  .byte $16, $54, $95         ;message $4B line 1: colour 11, y 336, x -428
LD7C3:  .byte $35, $2C, $30, $30, $30, $20, $50, $4F ;"5,000 POINTS AND JEDI LETTER AWARDED"
LD7CB:  .byte $49, $4E, $54, $53, $20, $41, $4E, $44
LD7D3:  .byte $20, $4A, $45, $44, $49, $20, $4C, $45
LD7DB:  .byte $54, $54, $45, $52, $20, $41, $57, $41
LD7E3:  .byte $52, $44, $45, $C4
LD7E7:  .byte $16, $54, $95         ;message $4C line 1: colour 11, y 336, x -428
LD7EA:  .byte $35, $2C, $30, $30, $30, $20, $50, $4F ;"5,000 POINTS AND JEDI LETTER AWARDED"
LD7F2:  .byte $49, $4E, $54, $53, $20, $41, $4E, $44
LD7FA:  .byte $20, $4A, $45, $44, $49, $20, $4C, $45
LD802:  .byte $54, $54, $45, $52, $20, $41, $57, $41
LD80A:  .byte $52, $44, $45, $C4
LD80E:  .byte $16, $54, $95         ;message $4D line 1: colour 11, y 336, x -428
LD811:  .byte $35, $2C, $30, $30, $30, $20, $50, $4F ;"5,000 POINTS AND JEDI LETTER AWARDED"
LD819:  .byte $49, $4E, $54, $53, $20, $41, $4E, $44
LD821:  .byte $20, $4A, $45, $44, $49, $20, $4C, $45
LD829:  .byte $54, $54, $45, $52, $20, $41, $57, $41
LD831:  .byte $52, $44, $45, $C4
LD835:  .byte $16, $99, $AD         ;message $4E line 1: colour 11, y -412, x -332
LD838:  .byte $57, $41, $56, $45, $20, $43, $4F, $4D ;"WAVE COMPLETED: 2,500 POINTS"
LD840:  .byte $50, $4C, $45, $54, $45, $44, $3A, $20
LD848:  .byte $32, $2C, $35, $30, $30, $20, $50, $4F
LD850:  .byte $49, $4E, $54, $D3
LD854:  .byte $16, $90, $A7         ;message $4F line 1: colour 11, y -448, x -356
LD857:  .byte $4E, $4F, $20, $42, $4F, $4E, $55, $53 ;"NO BONUS AWARDED FOR EASY WAVE"
LD85F:  .byte $20, $41, $57, $41, $52, $44, $45, $44
LD867:  .byte $20, $46, $4F, $52, $20, $45, $41, $53
LD86F:  .byte $59, $20, $57, $41, $56, $C5
LD875:  .byte $16, $90, $8C         ;message $50 line 1: colour 11, y -448, x -464
LD878:  .byte $31, $30, $30, $2C, $30, $30, $30, $20 ;"100,000 BONUS AWARDED FOR MODERATE WAVE"
LD880:  .byte $42, $4F, $4E, $55, $53, $20, $41, $57
LD888:  .byte $41, $52, $44, $45, $44, $20, $46, $4F
LD890:  .byte $52, $20, $4D, $4F, $44, $45, $52, $41
LD898:  .byte $54, $45, $20, $57, $41, $56, $C5
LD89F:  .byte $16, $90, $98         ;message $51 line 1: colour 11, y -448, x -416
LD8A2:  .byte $32, $35, $30, $2C, $30, $30, $30, $20 ;"250,000 BONUS AWARDED FOR HARD WAVE"
LD8AA:  .byte $42, $4F, $4E, $55, $53, $20, $41, $57
LD8B2:  .byte $41, $52, $44, $45, $44, $20, $46, $4F
LD8BA:  .byte $52, $20, $48, $41, $52, $44, $20, $57
LD8C2:  .byte $41, $56, $C5
LD8C5:  .byte $16, $8D, $BF         ;message $52 line 1: colour 11, y -460, x -260
LD8C8:  .byte $42, $4F, $4E, $55, $53, $20, $41, $57 ;"BONUS AWARDED FOR CONTINUED PLAY"
LD8D0:  .byte $41, $52, $44, $45, $44, $20, $46, $4F
LD8D8:  .byte $52, $20, $43, $4F, $4E, $54, $49, $4E
LD8E0:  .byte $55, $45, $44, $20, $50, $4C, $41, $D9
LD8E8:  .byte $06, $54, $97         ;message $53 line 1: colour 3, y 336, x -420
LD8EB:  .byte $52, $45, $42, $45, $4C, $20, $54, $52 ;"REBEL TRAINING MANUAL   SECTION "
LD8F3:  .byte $41, $49, $4E, $49, $4E, $47, $20, $4D
LD8FB:  .byte $41, $4E, $55, $41, $4C, $20, $20, $20
LD903:  .byte $53, $45, $43, $54, $49, $4F, $4E, $A0
LD90B:  .byte $0E, $3E, $C5         ;message $54 line 1: colour 7, y 248, x -236
LD90E:  .byte $49, $4D, $50, $45, $52, $49, $41, $4C ;"IMPERIAL PROBE DROID"
LD916:  .byte $20, $50, $52, $4F, $42, $45, $20, $44
LD91E:  .byte $52, $4F, $49, $C4
LD922:  .byte $0E, $32, $EF         ;message $54 line 2: colour 7, y 200, x -68
LD925:  .byte $50, $52, $4F, $42, $4F, $D4 ;"PROBOT"
LD92B:  .byte $02, $0C, $BC         ;message $55 line 1: colour 1, y 48, x -272
LD92E:  .byte $49, $4E, $46, $4F, $52, $4D, $41, $54 ;"INFORMATION TRANSMITTER"
LD936:  .byte $49, $4F, $4E, $20, $54, $52, $41, $4E
LD93E:  .byte $53, $4D, $49, $54, $54, $45, $D2
LD945:  .byte $06, $E7, $32         ;message $56 line 1: colour 3, y -100, x 200
LD948:  .byte $52, $45, $C4         ;"RED"
LD94B:  .byte $06, $DE, $19         ;message $56 line 2: colour 3, y -136, x 100
LD94E:  .byte $53, $45, $4E, $53, $4F, $52, $59, $20 ;"SENSORY EYE"
LD956:  .byte $45, $59, $C5
LD959:  .byte $0E, $3E, $D4         ;message $57 line 1: colour 7, y 248, x -176
LD95C:  .byte $50, $52, $4F, $42, $4F, $54, $20, $57 ;"PROBOT WEAPONRY"
LD964:  .byte $45, $41, $50, $4F, $4E, $52, $D9
LD96B:  .byte $06, $E7, $25         ;message $58 line 1: colour 3, y -100, x 148
LD96E:  .byte $45, $4E, $45, $4D, $59, $20, $4D, $41 ;"ENEMY MAY"
LD976:  .byte $D9
LD977:  .byte $06, $DE, $25         ;message $58 line 2: colour 3, y -136, x 148
LD97A:  .byte $53, $48, $4F, $4F, $54, $20, $41, $D4 ;"SHOOT AT"
LD982:  .byte $06, $D5, $25         ;message $58 line 3: colour 3, y -172, x 148
LD985:  .byte $50, $4C, $41, $59, $45, $52, $20, $41 ;"PLAYER AT"
LD98D:  .byte $D4
LD98E:  .byte $06, $CC, $25         ;message $58 line 4: colour 3, y -208, x 148
LD991:  .byte $41, $4E, $59, $20, $54, $49, $4D, $C5 ;"ANY TIME"
LD999:  .byte $06, $25, $CB         ;message $59 line 1: colour 3, y 148, x -212
LD99C:  .byte $50, $52, $4F, $42, $4F, $54, $20, $54 ;"PROBOT TRANSMITTER"
LD9A4:  .byte $52, $41, $4E, $53, $4D, $49, $54, $54
LD9AC:  .byte $45, $D2
LD9AE:  .byte $0A, $19, $9C         ;message $5A line 1: colour 5, y 100, x -400
LD9B1:  .byte $54, $52, $41, $4E, $53, $4D, $49, $53 ;"TRANSMISSION"
LD9B9:  .byte $53, $49, $4F, $CE
LD9BD:  .byte $06, $E7, $25         ;message $5B line 1: colour 3, y -100, x 148
LD9C0:  .byte $54, $52, $41, $4E, $53, $4D, $49, $53 ;"TRANSMISSION"
LD9C8:  .byte $53, $49, $4F, $CE
LD9CC:  .byte $06, $DE, $25         ;message $5B line 2: colour 3, y -136, x 148
LD9CF:  .byte $52, $45, $41, $44, $59, $20, $54, $CF ;"READY TO"
LD9D7:  .byte $06, $D5, $25         ;message $5B line 3: colour 3, y -172, x 148
LD9DA:  .byte $4C, $41, $55, $4E, $43, $48, $20, $57 ;"LAUNCH WHEN"
LD9E2:  .byte $48, $45, $CE
LD9E5:  .byte $06, $CC, $25         ;message $5B line 4: colour 3, y -208, x 148
LD9E8:  .byte $50, $52, $4F, $42, $4F, $54, $20, $48 ;"PROBOT HEAD"
LD9F0:  .byte $45, $41, $C4
LD9F3:  .byte $0E, $C3, $25         ;message $5B line 5: colour 7, y -244, x 148
LD9F6:  .byte $49, $53, $20, $57, $48, $49, $54, $C5 ;"IS WHITE"
LD9FE:  .byte $0E, $3E, $D1         ;message $5C line 1: colour 7, y 248, x -188
LDA01:  .byte $50, $52, $4F, $42, $4F, $54, $20, $48 ;"PROBOT HIT ZONES"
LDA09:  .byte $49, $54, $20, $5A, $4F, $4E, $45, $D3
LDA11:  .byte $06, $E7, $25         ;message $5D line 1: colour 3, y -100, x 148
LDA14:  .byte $44, $45, $53, $54, $52, $4F, $D9 ;"DESTROY"
LDA1B:  .byte $06, $DE, $25         ;message $5D line 2: colour 3, y -136, x 148
LDA1E:  .byte $50, $52, $4F, $42, $4F, $D4 ;"PROBOT"
LDA24:  .byte $06, $D5, $25         ;message $5D line 3: colour 3, y -172, x 148
LDA27:  .byte $42, $59, $20, $53, $48, $4F, $4F, $54 ;"BY SHOOTING"
LDA2F:  .byte $49, $4E, $C7
LDA32:  .byte $06, $CC, $25         ;message $5D line 4: colour 3, y -208, x 148
LDA35:  .byte $48, $45, $41, $44, $20, $4F, $52, $20 ;"HEAD OR BODY"
LDA3D:  .byte $42, $4F, $44, $D9
LDA41:  .byte $06, $22, $9C         ;message $5E line 1: colour 3, y 136, x -400
LDA44:  .byte $44, $45, $53, $54, $52, $4F, $D9 ;"DESTROY"
LDA4B:  .byte $06, $19, $9C         ;message $5E line 2: colour 3, y 100, x -400
LDA4E:  .byte $54, $52, $41, $4E, $53, $4D, $49, $53 ;"TRANSMISSION"
LDA56:  .byte $53, $49, $4F, $CE
LDA5A:  .byte $06, $10, $9C         ;message $5E line 3: colour 3, y 64, x -400
LDA5D:  .byte $42, $59, $20, $53, $48, $4F, $4F, $54 ;"BY SHOOTING"
LDA65:  .byte $49, $4E, $C7
LDA68:  .byte $16, $07, $9C         ;message $5E line 4: colour 11, y 28, x -400
LDA6B:  .byte $46, $4C, $41, $53, $48, $49, $4E, $C7 ;"FLASHING"
LDA73:  .byte $06, $FE, $9C         ;message $5E line 5: colour 3, y -8, x -400
LDA76:  .byte $52, $49, $4E, $C7    ;"RING"
LDA7A:  .byte $0E, $3E, $B0         ;message $5F line 1: colour 7, y 248, x -320
LDA7D:  .byte $41, $4C, $4C, $20, $54, $45, $52, $52 ;"ALL TERRAIN SCOUT TRANSPORT"
LDA85:  .byte $41, $49, $4E, $20, $53, $43, $4F, $55
LDA8D:  .byte $54, $20, $54, $52, $41, $4E, $53, $50
LDA95:  .byte $4F, $52, $D4
LDA98:  .byte $0E, $35, $DD         ;message $5F line 2: colour 7, y 212, x -140
LDA9B:  .byte $41, $54, $2D, $53, $54, $20, $57, $41 ;"AT-ST WALKER"
LDAA3:  .byte $4C, $4B, $45, $D2
LDAA7:  .byte $06, $E7, $25         ;message $60 line 1: colour 3, y -100, x 148
LDAAA:  .byte $47, $55, $4E, $20, $50, $4F, $52, $D4 ;"GUN PORT"
LDAB2:  .byte $0E, $3E, $C2         ;message $61 line 1: colour 7, y 248, x -248
LDAB5:  .byte $41, $54, $2D, $53, $54, $20, $57, $41 ;"AT-ST WALKER WEAPONRY"
LDABD:  .byte $4C, $4B, $45, $52, $20, $57, $45, $41
LDAC5:  .byte $50, $4F, $4E, $52, $D9
LDACA:  .byte $06, $E7, $25         ;message $62 line 1: colour 3, y -100, x 148
LDACD:  .byte $45, $4E, $45, $4D, $59, $20, $4D, $41 ;"ENEMY MAY"
LDAD5:  .byte $D9
LDAD6:  .byte $06, $DE, $25         ;message $62 line 2: colour 3, y -136, x 148
LDAD9:  .byte $53, $48, $4F, $4F, $54, $20, $41, $D4 ;"SHOOT AT"
LDAE1:  .byte $06, $D5, $25         ;message $62 line 3: colour 3, y -172, x 148
LDAE4:  .byte $50, $4C, $41, $59, $45, $52, $20, $57 ;"PLAYER WHEN"
LDAEC:  .byte $48, $45, $CE
LDAEF:  .byte $06, $CC, $25         ;message $62 line 4: colour 3, y -208, x 148
LDAF2:  .byte $47, $55, $4E, $20, $50, $4F, $52, $54 ;"GUN PORT IS"
LDAFA:  .byte $20, $49, $D3
LDAFD:  .byte $16, $C3, $25         ;message $62 line 5: colour 11, y -244, x 148
LDB00:  .byte $46, $4C, $41, $53, $48, $49, $4E, $C7 ;"FLASHING"
LDB08:  .byte $0E, $3E, $BF         ;message $63 line 1: colour 7, y 248, x -260
LDB0B:  .byte $41, $54, $2D, $53, $54, $20, $57, $41 ;"AT-ST WALKER HIT ZONES"
LDB13:  .byte $4C, $4B, $45, $52, $20, $48, $49, $54
LDB1B:  .byte $20, $5A, $4F, $4E, $45, $D3
LDB21:  .byte $0E, $9C, $8F         ;message $63 line 2: colour 7, y -400, x -452
LDB24:  .byte $45, $56, $45, $52, $59, $20, $35, $20 ;"EVERY 5 AT-ST WALKERS DESTROYED AWARDS"
LDB2C:  .byte $41, $54, $2D, $53, $54, $20, $57, $41
LDB34:  .byte $4C, $4B, $45, $52, $53, $20, $44, $45
LDB3C:  .byte $53, $54, $52, $4F, $59, $45, $44, $20
LDB44:  .byte $41, $57, $41, $52, $44, $D3
LDB4A:  .byte $0E, $90, $A1         ;message $63 line 3: colour 7, y -448, x -380
LDB4D:  .byte $41, $4E, $20, $45, $58, $54, $52, $41 ;"AN EXTRA TOW CABLE FOR NEXT WAVE"
LDB55:  .byte $20, $54, $4F, $57, $20, $43, $41, $42
LDB5D:  .byte $4C, $45, $20, $46, $4F, $52, $20, $4E
LDB65:  .byte $45, $58, $54, $20, $57, $41, $56, $C5
LDB6D:  .byte $06, $E7, $25         ;message $64 line 1: colour 3, y -100, x 148
LDB70:  .byte $44, $45, $53, $54, $52, $4F, $D9 ;"DESTROY"
LDB77:  .byte $06, $DE, $25         ;message $64 line 2: colour 3, y -136, x 148
LDB7A:  .byte $41, $54, $2D, $53, $54, $20, $57, $41 ;"AT-ST WALKER"
LDB82:  .byte $4C, $4B, $45, $D2
LDB86:  .byte $06, $D5, $25         ;message $64 line 3: colour 3, y -172, x 148
LDB89:  .byte $42, $59, $20, $53, $48, $4F, $4F, $54 ;"BY SHOOTING"
LDB91:  .byte $49, $4E, $C7
LDB94:  .byte $06, $CC, $25         ;message $64 line 4: colour 3, y -208, x 148
LDB97:  .byte $4C, $41, $53, $45, $52, $20, $41, $D4 ;"LASER AT"
LDB9F:  .byte $06, $C3, $25         ;message $64 line 5: colour 3, y -244, x 148
LDBA2:  .byte $47, $55, $4E, $20, $50, $4F, $52, $54 ;"GUN PORT."
LDBAA:  .byte $AE
LDBAB:  .byte $0E, $3E, $AA         ;message $65 line 1: colour 7, y 248, x -344
LDBAE:  .byte $41, $4C, $4C, $20, $54, $45, $52, $52 ;"ALL TERRAIN ARMORED TRANSPORT"
LDBB6:  .byte $41, $49, $4E, $20, $41, $52, $4D, $4F
LDBBE:  .byte $52, $45, $44, $20, $54, $52, $41, $4E
LDBC6:  .byte $53, $50, $4F, $52, $D4
LDBCB:  .byte $0E, $35, $DD         ;message $65 line 2: colour 7, y 212, x -140
LDBCE:  .byte $41, $54, $2D, $41, $54, $20, $57, $41 ;"AT-AT WALKER"
LDBD6:  .byte $4C, $4B, $45, $D2
LDBDA:  .byte $06, $E7, $25         ;message $66 line 1: colour 3, y -100, x 148
LDBDD:  .byte $47, $55, $4E, $20, $50, $4F, $52, $D4 ;"GUN PORT"
LDBE5:  .byte $0E, $9C, $8F         ;message $66 line 2: colour 7, y -400, x -452
LDBE8:  .byte $46, $4C, $59, $20, $54, $48, $52, $4F ;"FLY THROUGH LEGS FOR PROGRESSIVE BONUS"
LDBF0:  .byte $55, $47, $48, $20, $4C, $45, $47, $53
LDBF8:  .byte $20, $46, $4F, $52, $20, $50, $52, $4F
LDC00:  .byte $47, $52, $45, $53, $53, $49, $56, $45
LDC08:  .byte $20, $42, $4F, $4E, $55, $D3
LDC0E:  .byte $0E, $3E, $C2         ;message $67 line 1: colour 7, y 248, x -248
LDC11:  .byte $41, $54, $2D, $41, $54, $20, $57, $41 ;"AT-AT WALKER WEAPONRY"
LDC19:  .byte $4C, $4B, $45, $52, $20, $57, $45, $41
LDC21:  .byte $50, $4F, $4E, $52, $D9
LDC26:  .byte $06, $E7, $25         ;message $68 line 1: colour 3, y -100, x 148
LDC29:  .byte $45, $4E, $45, $4D, $59, $20, $4D, $41 ;"ENEMY MAY"
LDC31:  .byte $D9
LDC32:  .byte $06, $DE, $25         ;message $68 line 2: colour 3, y -136, x 148
LDC35:  .byte $53, $48, $4F, $4F, $54, $20, $41, $D4 ;"SHOOT AT"
LDC3D:  .byte $06, $D5, $25         ;message $68 line 3: colour 3, y -172, x 148
LDC40:  .byte $50, $4C, $41, $59, $45, $52, $20, $57 ;"PLAYER WHEN"
LDC48:  .byte $48, $45, $CE
LDC4B:  .byte $06, $CC, $25         ;message $68 line 4: colour 3, y -208, x 148
LDC4E:  .byte $47, $55, $4E, $20, $50, $4F, $52, $54 ;"GUN PORT IS"
LDC56:  .byte $20, $49, $D3
LDC59:  .byte $16, $C3, $25         ;message $68 line 5: colour 11, y -244, x 148
LDC5C:  .byte $46, $4C, $41, $53, $48, $49, $4E, $C7 ;"FLASHING"
LDC64:  .byte $0E, $3E, $BF         ;message $69 line 1: colour 7, y 248, x -260
LDC67:  .byte $41, $54, $2D, $41, $54, $20, $57, $41 ;"AT-AT WALKER HIT ZONES"
LDC6F:  .byte $4C, $4B, $45, $52, $20, $48, $49, $54
LDC77:  .byte $20, $5A, $4F, $4E, $45, $D3
LDC7D:  .byte $06, $E7, $25         ;message $6A line 1: colour 3, y -100, x 148
LDC80:  .byte $44, $45, $53, $54, $52, $4F, $D9 ;"DESTROY"
LDC87:  .byte $06, $DE, $25         ;message $6A line 2: colour 3, y -136, x 148
LDC8A:  .byte $41, $54, $2D, $41, $54, $20, $57, $41 ;"AT-AT WALKER"
LDC92:  .byte $4C, $4B, $45, $D2
LDC96:  .byte $06, $D5, $25         ;message $6A line 3: colour 3, y -172, x 148
LDC99:  .byte $42, $59, $20, $53, $48, $4F, $4F, $54 ;"BY SHOOTING"
LDCA1:  .byte $49, $4E, $C7
LDCA4:  .byte $06, $CC, $25         ;message $6A line 4: colour 3, y -208, x 148
LDCA7:  .byte $4C, $41, $53, $45, $52, $20, $41, $D4 ;"LASER AT"
LDCAF:  .byte $06, $C3, $25         ;message $6A line 5: colour 3, y -244, x 148
LDCB2:  .byte $47, $55, $4E, $20, $50, $4F, $52, $D4 ;"GUN PORT"
LDCBA:  .byte $06, $E7, $25         ;message $6B line 1: colour 3, y -100, x 148
LDCBD:  .byte $44, $45, $53, $54, $52, $4F, $D9 ;"DESTROY"
LDCC4:  .byte $06, $DE, $25         ;message $6B line 2: colour 3, y -136, x 148
LDCC7:  .byte $41, $54, $2D, $41, $54, $20, $57, $41 ;"AT-AT WALKER"
LDCCF:  .byte $4C, $4B, $45, $D2
LDCD3:  .byte $06, $D5, $25         ;message $6B line 3: colour 3, y -172, x 148
LDCD6:  .byte $42, $59, $20, $53, $48, $4F, $4F, $54 ;"BY SHOOTING"
LDCDE:  .byte $49, $4E, $C7
LDCE1:  .byte $06, $CC, $25         ;message $6B line 4: colour 3, y -208, x 148
LDCE4:  .byte $54, $4F, $57, $20, $43, $41, $42, $4C ;"TOW CABLE"
LDCEC:  .byte $C5
LDCED:  .byte $06, $C3, $25         ;message $6B line 5: colour 3, y -244, x 148
LDCF0:  .byte $42, $45, $54, $57, $45, $45, $4E, $20 ;"BETWEEN LEGS."
LDCF8:  .byte $4C, $45, $47, $53, $AE
LDCFD:  .byte $0E, $3E, $BC         ;message $6C line 1: colour 7, y 248, x -272
LDD00:  .byte $54, $57, $49, $4E, $20, $49, $4F, $4E ;"TWIN ION ENGINE FIGHTER"
LDD08:  .byte $20, $45, $4E, $47, $49, $4E, $45, $20
LDD10:  .byte $46, $49, $47, $48, $54, $45, $D2
LDD17:  .byte $0E, $35, $E0         ;message $6C line 2: colour 7, y 212, x -128
LDD1A:  .byte $54, $49, $45, $20, $46, $49, $47, $48 ;"TIE FIGHTER"
LDD22:  .byte $54, $45, $D2
LDD25:  .byte $06, $CE, $E9         ;message $6D line 1: colour 3, y -200, x -92
LDD28:  .byte $47, $55, $4E, $20, $50, $4F, $52, $D4 ;"GUN PORT"
LDD30:  .byte $0E, $3E, $C5         ;message $6E line 1: colour 7, y 248, x -236
LDD33:  .byte $54, $49, $45, $20, $46, $49, $47, $48 ;"TIE FIGHTER WEAPONRY"
LDD3B:  .byte $54, $45, $52, $20, $57, $45, $41, $50
LDD43:  .byte $4F, $4E, $52, $D9
LDD47:  .byte $06, $E7, $25         ;message $6F line 1: colour 3, y -100, x 148
LDD4A:  .byte $45, $4E, $45, $4D, $59, $20, $4D, $41 ;"ENEMY MAY"
LDD52:  .byte $D9
LDD53:  .byte $06, $DE, $25         ;message $6F line 2: colour 3, y -136, x 148
LDD56:  .byte $53, $48, $4F, $4F, $54, $20, $41, $D4 ;"SHOOT AT"
LDD5E:  .byte $06, $D5, $25         ;message $6F line 3: colour 3, y -172, x 148
LDD61:  .byte $50, $4C, $41, $59, $45, $52, $20, $41 ;"PLAYER AT"
LDD69:  .byte $D4
LDD6A:  .byte $06, $CC, $25         ;message $6F line 4: colour 3, y -208, x 148
LDD6D:  .byte $41, $4E, $59, $20, $54, $49, $4D, $C5 ;"ANY TIME"
LDD75:  .byte $0E, $3E, $C2         ;message $70 line 1: colour 7, y 248, x -248
LDD78:  .byte $54, $49, $45, $20, $46, $49, $47, $48 ;"TIE FIGHTER HIT ZONES"
LDD80:  .byte $54, $45, $52, $20, $48, $49, $54, $20
LDD88:  .byte $5A, $4F, $4E, $45, $D3
LDD8D:  .byte $06, $E7, $25         ;message $71 line 1: colour 3, y -100, x 148
LDD90:  .byte $44, $45, $53, $54, $52, $4F, $D9 ;"DESTROY"
LDD97:  .byte $06, $DE, $25         ;message $71 line 2: colour 3, y -136, x 148
LDD9A:  .byte $54, $49, $45, $20, $46, $49, $47, $48 ;"TIE FIGHTER"
LDDA2:  .byte $54, $45, $D2
LDDA5:  .byte $06, $D5, $25         ;message $71 line 3: colour 3, y -172, x 148
LDDA8:  .byte $57, $49, $54, $48, $20, $4C, $41, $53 ;"WITH LASER"
LDDB0:  .byte $45, $D2
LDDB2:  .byte $0E, $3E, $E9         ;message $72 line 1: colour 7, y 248, x -92
LDDB5:  .byte $41, $53, $54, $45, $52, $4F, $49, $C4 ;"ASTEROID"
LDDBD:  .byte $06, $00, $B5         ;message $73 line 1: colour 3, y 0, x -300
LDDC0:  .byte $A0                   ;" "
LDDC1:  .byte $0E, $3E, $CE         ;message $74 line 1: colour 7, y 248, x -200
LDDC4:  .byte $41, $53, $54, $45, $52, $4F, $49, $44 ;"ASTEROID WEAPONRY"
LDDCC:  .byte $20, $57, $45, $41, $50, $4F, $4E, $52
LDDD4:  .byte $D9
LDDD5:  .byte $06, $B5, $B6         ;message $75 line 1: colour 3, y -300, x -296
LDDD8:  .byte $41, $53, $54, $45, $52, $4F, $49, $44 ;"ASTEROIDS HAVE NO WEAPONS"
LDDE0:  .byte $53, $20, $48, $41, $56, $45, $20, $4E
LDDE8:  .byte $4F, $20, $57, $45, $41, $50, $4F, $4E
LDDF0:  .byte $D3
LDDF1:  .byte $06, $9C, $A7         ;message $75 line 2: colour 3, y -400, x -356
LDDF4:  .byte $41, $56, $4F, $49, $44, $20, $43, $4F ;"AVOID COLLISION WITH ASTEROIDS"
LDDFC:  .byte $4C, $4C, $49, $53, $49, $4F, $4E, $20
LDE04:  .byte $57, $49, $54, $48, $20, $41, $53, $54
LDE0C:  .byte $45, $52, $4F, $49, $44, $D3
LDE12:  .byte $0E, $3E, $CB         ;message $76 line 1: colour 7, y 248, x -212
LDE15:  .byte $41, $53, $54, $45, $52, $4F, $49, $44 ;"ASTEROID HIT ZONES"
LDE1D:  .byte $20, $48, $49, $54, $20, $5A, $4F, $4E
LDE25:  .byte $45, $D3
LDE27:  .byte $06, $9C, $A7         ;message $77 line 1: colour 3, y -400, x -356
LDE2A:  .byte $41, $56, $4F, $49, $44, $20, $43, $4F ;"AVOID COLLISION WITH ASTEROIDS"
LDE32:  .byte $4C, $4C, $49, $53, $49, $4F, $4E, $20
LDE3A:  .byte $57, $49, $54, $48, $20, $41, $53, $54
LDE42:  .byte $45, $52, $4F, $49, $44, $D3
LDE48:  .byte $0E, $78, $BF         ;message $78 line 1: colour 7, y 480, x -260

MES89:
LDE4B:  .byte $41, $43, $43, $4F, $55, $4E, $54, $49 ;"ACCOUNTING INFORMATION"
LDE53:  .byte $4E, $47, $20, $49, $4E, $46, $4F, $52
LDE5B:  .byte $4D, $41, $54, $49, $4F, $CE
LDE61:  .byte $02, $6E, $CA         ;message $78 line 2: colour 1, y 440, x -216
LDE64:  .byte $41, $55, $58, $20, $43, $4F, $49, $4E ;"AUX COINS"
LDE6C:  .byte $D3
LDE6D:  .byte $02, $64, $A6         ;message $78 line 3: colour 1, y 400, x -360

MES91:
LDE70:  .byte $4C, $45, $46, $54, $20, $4D, $45, $43 ;"LEFT MECH COINS"
LDE78:  .byte $48, $20, $43, $4F, $49, $4E, $D3
LDE7F:  .byte $02, $5A, $A0         ;message $78 line 4: colour 1, y 360, x -384

MES92:
LDE82:  .byte $52, $49, $47, $48, $54, $20, $4D, $45 ;"RIGHT MECH COINS"
LDE8A:  .byte $43, $48, $20, $43, $4F, $49, $4E, $D3
LDE92:  .byte $02, $50, $A0         ;message $78 line 5: colour 1, y 320, x -384

MES93:
LDE95:  .byte $54, $4F, $54, $41, $4C, $20, $43, $4F ;"TOTAL COINS PAID"
LDE9D:  .byte $49, $4E, $53, $20, $50, $41, $49, $C4
LDEA5:  .byte $02, $46, $B8         ;message $78 line 6: colour 1, y 280, x -288

MES94:
LDEA8:  .byte $47, $41, $4D, $45, $53, $20, $50, $4C ;"GAMES PLAYED"
LDEB0:  .byte $41, $59, $45, $C4
LDEB4:  .byte $02, $3C, $A0         ;message $78 line 7: colour 1, y 240, x -384
LDEB7:  .byte $41, $44, $44, $2D, $41, $2D, $43, $4F ;"ADD-A-COIN GAMES              PERCENT"
LDEBF:  .byte $49, $4E, $20, $47, $41, $4D, $45, $53
LDEC7:  .byte $20, $20, $20, $20, $20, $20, $20, $20
LDECF:  .byte $20, $20, $20, $20, $20, $20, $50, $45
LDED7:  .byte $52, $43, $45, $4E, $D4
LDEDC:  .byte $02, $6E, $3E         ;message $78 line 8: colour 1, y 440, x 248
LDEDF:  .byte $48, $49, $47, $48, $20, $57, $41, $56 ;"HIGH WAVE"
LDEE7:  .byte $C5
LDEE8:  .byte $02, $2D, $A6         ;message $78 line 9: colour 1, y 180, x -360

MES96:
LDEEB:  .byte $54, $4F, $54, $41, $4C, $20, $47, $41 ;"TOTAL GAME TIME           SECONDS"
LDEF3:  .byte $4D, $45, $20, $54, $49, $4D, $45, $20
LDEFB:  .byte $20, $20, $20, $20, $20, $20, $20, $20
LDF03:  .byte $20, $20, $53, $45, $43, $4F, $4E, $44
LDF0B:  .byte $D3
LDF0C:  .byte $02, $23, $9A         ;message $78 line 10: colour 1, y 140, x -408

MES97:
LDF0F:  .byte $41, $56, $45, $52, $41, $47, $45, $20 ;"AVERAGE GAME TIME"
LDF17:  .byte $47, $41, $4D, $45, $20, $54, $49, $4D
LDF1F:  .byte $C5
LDF20:  .byte $02, $14, $B2         ;message $78 line 11: colour 1, y 80, x -312

MES98:
LDF23:  .byte $54, $4F, $54, $41, $4C, $20, $54, $49 ;"TOTAL TIME ON           SECONDS"
LDF2B:  .byte $4D, $45, $20, $4F, $4E, $20, $20, $20
LDF33:  .byte $20, $20, $20, $20, $20, $20, $20, $20
LDF3B:  .byte $53, $45, $43, $4F, $4E, $44, $D3
LDF42:  .byte $02, $0A, $94         ;message $78 line 12: colour 1, y 40, x -432

MES99:
LDF45:  .byte $50, $45, $52, $43, $45, $4E, $54, $41 ;"PERCENTAGE OF PLAY     PERCENT"
LDF4D:  .byte $47, $45, $20, $4F, $46, $20, $50, $4C
LDF55:  .byte $41, $59, $20, $20, $20, $20, $20, $50
LDF5D:  .byte $45, $52, $43, $45, $4E, $D4
LDF63:  .byte $0E, $F6, $C2         ;message $78 line 13: colour 7, y -40, x -248

MES100:
LDF66:  .byte $48, $49, $53, $54, $4F, $52, $59, $20 ;"HISTORY OF GAME TIMES"
LDF6E:  .byte $4F, $46, $20, $47, $41, $4D, $45, $20
LDF76:  .byte $54, $49, $4D, $45, $D3
LDF7B:  .byte $0E, $7D, $DD         ;message $79 line 1: colour 7, y 500, x -140

MES101:
LDF7E:  .byte $47, $41, $4D, $45, $20, $4F, $50, $54 ;"GAME OPTIONS"
LDF86:  .byte $49, $4F, $4E, $D3
LDF8A:  .byte $02, $70, $A6         ;message $79 line 2: colour 1, y 448, x -360

MES102:
LDF8D:  .byte $56, $41, $4C, $55, $45, $20, $4F, $46 ;"VALUE OF A COIN"
LDF95:  .byte $20, $41, $20, $43, $4F, $49, $CE
LDF9C:  .byte $02, $64, $A6         ;message $79 line 3: colour 1, y 400, x -360

MES103:
LDF9F:  .byte $4C, $45, $46, $54, $20, $4D, $45, $43 ;"LEFT MECH VALUE"
LDFA7:  .byte $48, $20, $56, $41, $4C, $55, $C5
LDFAE:  .byte $02, $57, $A0         ;message $79 line 4: colour 1, y 348, x -384

MES104:
LDFB1:  .byte $52, $49, $47, $48, $54, $20, $4D, $45 ;"RIGHT MECH VALUE"
LDFB9:  .byte $43, $48, $20, $56, $41, $4C, $55, $C5
LDFC1:  .byte $02, $4B, $BE         ;message $79 line 5: colour 1, y 300, x -264
LDFC4:  .byte $42, $4F, $4E, $55, $53, $20, $41, $44 ;"BONUS ADDER"
LDFCC:  .byte $44, $45, $D2
LDFCF:  .byte $02, $3E, $A0         ;message $79 line 6: colour 1, y 248, x -384

MES106:
LDFD2:  .byte $53, $54, $41, $52, $54, $49, $4E, $47 ;"STARTING SHIELDS"
LDFDA:  .byte $20, $53, $48, $49, $45, $4C, $44, $D3
LDFE2:  .byte $02, $32, $A6         ;message $79 line 7: colour 1, y 200, x -360

MES107:
LDFE5:  .byte $50, $4C, $41, $59, $20, $44, $49, $46 ;"PLAY DIFFICULTY"
LDFED:  .byte $46, $49, $43, $55, $4C, $54, $D9
LDFF4:  .byte $02, $25, $A0         ;message $79 line 8: colour 1, y 148, x -384
LDFF7:  .byte $4A, $45, $44, $49, $2D, $4C, $45, $54 ;"JEDI-LETTER MODE"
LDFFF:  .byte $54, $45, $52, $20, $4D, $4F, $44, $C5
LE007:  .byte $02, $19, $A0         ;message $79 line 9: colour 1, y 100, x -384

MES109:
LE00A:  .byte $4D, $55, $53, $49, $43, $20, $49, $4E ;"MUSIC IN ATTRACT"
LE012:  .byte $20, $41, $54, $54, $52, $41, $43, $D4
LE01A:  .byte $02, $E7, $9A         ;message $79 line 10: colour 1, y -100, x -408

MES110:
LE01D:  .byte $52, $45, $53, $45, $54, $20, $48, $49 ;"RESET HIGH SCORES"
LE025:  .byte $47, $48, $20, $53, $43, $4F, $52, $45
LE02D:  .byte $D3
LE02E:  .byte $02, $DB, $9A         ;message $79 line 11: colour 1, y -148, x -408

MES111:
LE031:  .byte $52, $45, $53, $45, $54, $20, $54, $49 ;"RESET TIMING INFO"
LE039:  .byte $4D, $49, $4E, $47, $20, $49, $4E, $46
LE041:  .byte $CF
LE042:  .byte $02, $CE, $B2         ;message $79 line 12: colour 1, y -200, x -312

MES112:
LE045:  .byte $52, $45, $53, $45, $54, $20, $4F, $50 ;"RESET OPTIONS"
LE04D:  .byte $54, $49, $4F, $4E, $D3
LE052:  .byte $02, $C2, $BE         ;message $79 line 13: colour 1, y -248, x -264
LE055:  .byte $54, $45, $53, $54, $20, $4E, $4F, $56 ;"TEST NOVRAM"
LE05D:  .byte $52, $41, $CD
LE060:  .byte $06, $9C, $BF         ;message $79 line 14: colour 3, y -400, x -260

MES114:
LE063:  .byte $55, $50, $2C, $44, $4F, $57, $4E, $20 ;"UP,DOWN TO SELECT ITEM"
LE06B:  .byte $54, $4F, $20, $53, $45, $4C, $45, $43
LE073:  .byte $54, $20, $49, $54, $45, $CD
LE079:  .byte $06, $90, $A1         ;message $79 line 15: colour 3, y -448, x -380

MES115:
LE07C:  .byte $50, $55, $4C, $4C, $20, $4C, $45, $46 ;"PULL LEFT FIRE TO CHANGE SETTING"
LE084:  .byte $54, $20, $46, $49, $52, $45, $20, $54
LE08C:  .byte $4F, $20, $43, $48, $41, $4E, $47, $45
LE094:  .byte $20, $53, $45, $54, $54, $49, $4E, $C7
LE09C:  .byte $02, $70, $12         ;message $7A line 1: colour 1, y 448, x 72
LE09F:  .byte $46, $52, $45, $45, $20, $50, $4C, $41 ;"FREE PLAY"
LE0A7:  .byte $D9
LE0A8:  .byte $02, $70, $12         ;message $7B line 1: colour 1, y 448, x 72
LE0AB:  .byte $32, $20, $43, $52, $45, $44, $49, $54 ;"2 CREDITS"
LE0B3:  .byte $D3
LE0B4:  .byte $02, $70, $12         ;message $7C line 1: colour 1, y 448, x 72
LE0B7:  .byte $31, $20, $43, $52, $45, $44, $49, $D4 ;"1 CREDIT"
LE0BF:  .byte $02, $70, $12         ;message $7D line 1: colour 1, y 448, x 72
LE0C2:  .byte $25, $20, $43, $52, $45, $44, $49, $D4 ;"% CREDIT"
LE0CA:  .byte $02, $64, $12         ;message $7E line 1: colour 1, y 400, x 72
LE0CD:  .byte $B1                   ;"1"
LE0CE:  .byte $02, $64, $12         ;message $7F line 1: colour 1, y 400, x 72
LE0D1:  .byte $B2                   ;"2"
LE0D2:  .byte $02, $57, $12         ;message $80 line 1: colour 1, y 348, x 72
LE0D5:  .byte $B1                   ;"1"
LE0D6:  .byte $02, $57, $12         ;message $81 line 1: colour 1, y 348, x 72
LE0D9:  .byte $B4                   ;"4"
LE0DA:  .byte $02, $57, $12         ;message $82 line 1: colour 1, y 348, x 72
LE0DD:  .byte $B5                   ;"5"
LE0DE:  .byte $02, $57, $12         ;message $83 line 1: colour 1, y 348, x 72
LE0E1:  .byte $B6                   ;"6"
LE0E2:  .byte $02, $4B, $12         ;message $84 line 1: colour 1, y 300, x 72
LE0E5:  .byte $4E, $4F, $4E, $C5    ;"NONE"
LE0E9:  .byte $02, $4B, $12         ;message $85 line 1: colour 1, y 300, x 72
LE0EC:  .byte $32, $20, $47, $49, $56, $45, $53, $20 ;"2 GIVES 1"
LE0F4:  .byte $B1
LE0F5:  .byte $02, $4B, $12         ;message $86 line 1: colour 1, y 300, x 72
LE0F8:  .byte $34, $20, $47, $49, $56, $45, $53, $20 ;"4 GIVES 1"
LE100:  .byte $B1
LE101:  .byte $02, $4B, $12         ;message $87 line 1: colour 1, y 300, x 72
LE104:  .byte $34, $20, $47, $49, $56, $45, $53, $20 ;"4 GIVES 2"
LE10C:  .byte $B2
LE10D:  .byte $02, $4B, $12         ;message $88 line 1: colour 1, y 300, x 72
LE110:  .byte $35, $20, $47, $49, $56, $45, $53, $20 ;"5 GIVES 1"
LE118:  .byte $B1
LE119:  .byte $02, $4B, $12         ;message $89 line 1: colour 1, y 300, x 72
LE11C:  .byte $33, $20, $47, $49, $56, $45, $53, $20 ;"3 GIVES 1"
LE124:  .byte $B1
LE125:  .byte $02, $4B, $12         ;message $8A line 1: colour 1, y 300, x 72
LE128:  .byte $4E, $4F, $4E, $C5    ;"NONE"
LE12C:  .byte $02, $4B, $12         ;message $8B line 1: colour 1, y 300, x 72
LE12F:  .byte $4E, $4F, $4E, $C5    ;"NONE"
LE133:  .byte $02, $3E, $12         ;message $8C line 1: colour 1, y 248, x 72
LE136:  .byte $B2                   ;"2"
LE137:  .byte $02, $3E, $12         ;message $8D line 1: colour 1, y 248, x 72
LE13A:  .byte $B3                   ;"3"
LE13B:  .byte $02, $3E, $12         ;message $8E line 1: colour 1, y 248, x 72
LE13E:  .byte $B4                   ;"4"
LE13F:  .byte $02, $3E, $12         ;message $8F line 1: colour 1, y 248, x 72
LE142:  .byte $B5                   ;"5"
LE143:  .byte $02, $32, $12         ;message $90 line 1: colour 1, y 200, x 72
LE146:  .byte $45, $41, $53, $D9    ;"EASY"
LE14A:  .byte $02, $32, $12         ;message $91 line 1: colour 1, y 200, x 72
LE14D:  .byte $4D, $4F, $44, $45, $52, $41, $54, $C5 ;"MODERATE"
LE155:  .byte $02, $32, $12         ;message $92 line 1: colour 1, y 200, x 72
LE158:  .byte $48, $41, $52, $C4    ;"HARD"
LE15C:  .byte $02, $32, $12         ;message $93 line 1: colour 1, y 200, x 72
LE15F:  .byte $48, $41, $52, $44, $45, $53, $D4 ;"HARDEST"
LE166:  .byte $02, $25, $12         ;message $94 line 1: colour 1, y 148, x 72
LE169:  .byte $4C, $45, $56, $45, $CC ;"LEVEL"
LE16E:  .byte $02, $25, $12         ;message $95 line 1: colour 1, y 148, x 72
LE171:  .byte $4C, $45, $56, $45, $4C, $20, $4F, $4E ;"LEVEL ONLY"
LE179:  .byte $4C, $D9
LE17B:  .byte $02, $25, $12         ;message $96 line 1: colour 1, y 148, x 72
LE17E:  .byte $49, $4E, $43, $52, $45, $4D, $45, $4E ;"INCREMENT"
LE186:  .byte $D4
LE187:  .byte $02, $25, $12         ;message $97 line 1: colour 1, y 148, x 72
LE18A:  .byte $49, $4E, $43, $52, $45, $4D, $45, $4E ;"INCREMENT ONLY"
LE192:  .byte $54, $20, $4F, $4E, $4C, $D9
LE198:  .byte $02, $19, $12         ;message $98 line 1: colour 1, y 100, x 72
LE19B:  .byte $4E, $CF              ;"NO"
LE19D:  .byte $02, $19, $12         ;message $99 line 1: colour 1, y 100, x 72
LE1A0:  .byte $59, $45, $D3         ;"YES"
LE1A3:  .byte $02, $E7, $12         ;message $9A line 1: colour 1, y -100, x 72
LE1A6:  .byte $4E, $CF              ;"NO"
LE1A8:  .byte $02, $E7, $12         ;message $9B line 1: colour 1, y -100, x 72
LE1AB:  .byte $59, $45, $D3         ;"YES"
LE1AE:  .byte $02, $DB, $12         ;message $9C line 1: colour 1, y -148, x 72
LE1B1:  .byte $4E, $CF              ;"NO"
LE1B3:  .byte $02, $DB, $12         ;message $9D line 1: colour 1, y -148, x 72
LE1B6:  .byte $59, $45, $D3         ;"YES"
LE1B9:  .byte $02, $CE, $12         ;message $9E line 1: colour 1, y -200, x 72
LE1BC:  .byte $4E, $CF              ;"NO"
LE1BE:  .byte $02, $CE, $12         ;message $9F line 1: colour 1, y -200, x 72
LE1C1:  .byte $59, $45, $D3         ;"YES"
LE1C4:  .byte $02, $C2, $12         ;message $A0 line 1: colour 1, y -248, x 72
LE1C7:  .byte $4E, $CF              ;"NO"
LE1C9:  .byte $02, $C2, $12         ;message $A1 line 1: colour 1, y -248, x 72
LE1CC:  .byte $59, $45, $D3         ;"YES"
LE1CF:  .byte $06, $C2, $2C         ;message $A2 line 1: colour 3, y -248, x 176
LE1D2:  .byte $4E, $4F, $20, $45, $52, $52, $4F, $52 ;"NO ERRORS"
LE1DA:  .byte $D3
LE1DB:  .byte $06, $C2, $2C         ;message $A3 line 1: colour 3, y -248, x 176
LE1DE:  .byte $45, $52, $52, $4F, $52, $20, $41, $D4 ;"ERROR AT"
LE1E6:  .byte $0E, $70, $D4         ;message $A4 line 1: colour 7, y 448, x -176

MES176:
LE1E9:  .byte $48, $41, $52, $44, $57, $41, $52, $45 ;"HARDWARE ERRORS"
LE1F1:  .byte $20, $45, $52, $52, $4F, $52, $D3
LE1F8:  .byte $0E, $00, $CB         ;message $A5 line 1: colour 7, y 0, x -212

MES177:
LE1FB:  .byte $4E, $4F, $20, $45, $52, $52, $4F, $52 ;"NO ERRORS DETECTED"
LE203:  .byte $53, $20, $44, $45, $54, $45, $43, $54
LE20B:  .byte $45, $C4
LE20D:  .byte $06, $E7, $DD         ;message $A5 line 2: colour 3, y -100, x -140
LE210:  .byte $56, $45, $52, $49, $53, $55, $CD ;"VERISUM"
LE217:  .byte $02, $64, $CB         ;message $A6 line 1: colour 1, y 400, x -212

MES178:
LE21A:  .byte $50, $52, $4F, $47, $52, $41, $4D, $20 ;"PROGRAM RAM AT 2FH"
LE222:  .byte $52, $41, $4D, $20, $41, $54, $20, $32
LE22A:  .byte $46, $C8
LE22C:  .byte $02, $57, $D7         ;message $A7 line 1: colour 1, y 348, x -164

MES179:
LE22F:  .byte $4D, $41, $54, $48, $20, $52, $41, $4D ;"MATH RAM AT 5F"
LE237:  .byte $20, $41, $54, $20, $35, $C6
LE23D:  .byte $02, $4B, $D7         ;message $A8 line 1: colour 1, y 300, x -164
LE240:  .byte $4D, $41, $54, $48, $20, $52, $41, $4D ;"MATH RAM AT 5H"
LE248:  .byte $20, $41, $54, $20, $35, $C8
LE24E:  .byte $02, $3E, $DA         ;message $A9 line 1: colour 1, y 248, x -152

MES181:
LE251:  .byte $56, $47, $20, $52, $41, $4D, $30, $20 ;"VG RAM0 AT 3L"
LE259:  .byte $41, $54, $20, $33, $CC
LE25E:  .byte $02, $32, $DA         ;message $AA line 1: colour 1, y 200, x -152

MES182:
LE261:  .byte $56, $47, $20, $52, $41, $4D, $31, $20 ;"VG RAM1 AT 3M"
LE269:  .byte $41, $54, $20, $33, $CD
LE26E:  .byte $02, $25, $DA         ;message $AB line 1: colour 1, y 148, x -152

MES183:
LE271:  .byte $56, $47, $20, $52, $41, $4D, $32, $20 ;"VG RAM2 AT 3P"
LE279:  .byte $41, $54, $20, $33, $D0
LE27E:  .byte $02, $19, $DA         ;message $AC line 1: colour 1, y 100, x -152

MES184:
LE281:  .byte $56, $47, $20, $52, $41, $4D, $33, $20 ;"VG RAM3 AT 4L"
LE289:  .byte $41, $54, $20, $34, $CC
LE28E:  .byte $02, $0C, $DA         ;message $AD line 1: colour 1, y 48, x -152

MES185:
LE291:  .byte $56, $47, $20, $52, $41, $4D, $34, $20 ;"VG RAM4 AT 4M"
LE299:  .byte $41, $54, $20, $34, $CD
LE29E:  .byte $02, $00, $DA         ;message $AE line 1: colour 1, y 0, x -152

MES186:
LE2A1:  .byte $56, $47, $20, $52, $41, $4D, $35, $20 ;"VG RAM5 AT 4P"
LE2A9:  .byte $41, $54, $20, $34, $D0
LE2AE:  .byte $02, $F4, $BF         ;message $AF line 1: colour 1, y -48, x -260

MES187:
LE2B1:  .byte $4E, $4F, $4E, $20, $56, $4F, $4C, $41 ;"NON VOLATILE RAM AT 1E"
LE2B9:  .byte $54, $49, $4C, $45, $20, $52, $41, $4D
LE2C1:  .byte $20, $41, $54, $20, $31, $C5
LE2C7:  .byte $02, $CE, $CE         ;message $B0 line 1: colour 1, y -200, x -200

MES188:
LE2CA:  .byte $50, $52, $4F, $47, $52, $41, $4D, $20 ;"PROGRAM ROM0 AT 1F"
LE2D2:  .byte $52, $4F, $4D, $30, $20, $41, $54, $20
LE2DA:  .byte $31, $C6
LE2DC:  .byte $02, $C2, $CE         ;message $B1 line 1: colour 1, y -248, x -200

MES190:
LE2DF:  .byte $50, $52, $4F, $47, $52, $41, $4D, $20 ;"PROGRAM ROM2 AT 1JK"
LE2E7:  .byte $52, $4F, $4D, $32, $20, $41, $54, $20
LE2EF:  .byte $31, $4A, $CB
LE2F2:  .byte $02, $B5, $CE         ;message $B2 line 1: colour 1, y -300, x -200

MES191:
LE2F5:  .byte $50, $52, $4F, $47, $52, $41, $4D, $20 ;"PROGRAM ROM3 AT 1KL"
LE2FD:  .byte $52, $4F, $4D, $33, $20, $41, $54, $20
LE305:  .byte $31, $4B, $CC
LE308:  .byte $02, $A9, $CE         ;message $B3 line 1: colour 1, y -348, x -200

MES192:
LE30B:  .byte $50, $52, $4F, $47, $52, $41, $4D, $20 ;"PROGRAM ROM4 AT 1M"
LE313:  .byte $52, $4F, $4D, $34, $20, $41, $54, $20
LE31B:  .byte $31, $CD
LE31D:  .byte $02, $9C, $CE         ;message $B4 line 1: colour 1, y -400, x -200
LE320:  .byte $45, $58, $50, $41, $4E, $53, $49, $4F ;"EXPANSION BOARD 1HJ"
LE328:  .byte $4E, $20, $42, $4F, $41, $52, $44, $20
LE330:  .byte $31, $48, $CA
LE333:  .byte $02, $DB, $DD         ;message $B5 line 1: colour 1, y -148, x -140

MES193:
LE336:  .byte $56, $47, $20, $52, $4F, $4D, $20, $41 ;"VG ROM AT 1L"
LE33E:  .byte $54, $20, $31, $CC
LE342:  .byte $0E, $64, $E0         ;message $B6 line 1: colour 7, y 400, x -128
LE345:  .byte $53, $57, $49, $54, $43, $48, $20, $54 ;"SWITCH TEST"
LE34D:  .byte $45, $53, $D4
LE350:  .byte $02, $4B, $B5         ;message $B7 line 1: colour 1, y 300, x -300
LE353:  .byte $4C, $45, $46, $54, $20, $46, $49, $52 ;"LEFT FIRE"
LE35B:  .byte $C5
LE35C:  .byte $02, $4B, $19         ;message $B8 line 1: colour 1, y 300, x 100
LE35F:  .byte $52, $49, $47, $48, $54, $20, $46, $49 ;"RIGHT FIRE"
LE367:  .byte $52, $C5
LE369:  .byte $02, $DB, $EC         ;message $B9 line 1: colour 1, y -148, x -80
LE36C:  .byte $53, $50, $41, $52, $45, $20, $B1 ;"SPARE 1"
LE373:  .byte $02, $32, $E6         ;message $BA line 1: colour 1, y 200, x -104
LE376:  .byte $53, $45, $4C, $46, $20, $54, $45, $53 ;"SELF TEST"
LE37E:  .byte $D4
LE37F:  .byte $02, $25, $F5         ;message $BB line 1: colour 1, y 148, x -44
LE382:  .byte $53, $4C, $41, $CD    ;"SLAM"
LE386:  .byte $02, $19, $E9         ;message $BC line 1: colour 1, y 100, x -92
LE389:  .byte $41, $55, $58, $20, $43, $4F, $49, $CE ;"AUX COIN"
LE391:  .byte $02, $0C, $E6         ;message $BD line 1: colour 1, y 48, x -104
LE394:  .byte $4C, $45, $46, $54, $20, $43, $4F, $49 ;"LEFT COIN"
LE39C:  .byte $CE
LE39D:  .byte $02, $00, $E3         ;message $BE line 1: colour 1, y 0, x -116
LE3A0:  .byte $52, $49, $47, $48, $54, $20, $43, $4F ;"RIGHT COIN"
LE3A8:  .byte $49, $CE
LE3AA:  .byte $02, $F4, $DA         ;message $BF line 1: colour 1, y -48, x -152
LE3AD:  .byte $A0                   ;" "
LE3AE:  .byte $02, $E7, $E6         ;message $C0 line 1: colour 1, y -100, x -104
LE3B1:  .byte $A0                   ;" "
LE3B2:  .byte $02, $3E, $AF         ;message $C1 line 1: colour 1, y 248, x -324
LE3B5:  .byte $4C, $45, $46, $54, $20, $54, $48, $55 ;"LEFT THUMB"
LE3BD:  .byte $4D, $C2
LE3BF:  .byte $02, $3E, $19         ;message $C2 line 1: colour 1, y 248, x 100
LE3C2:  .byte $52, $49, $47, $48, $54, $20, $54, $48 ;"RIGHT THUMB"
LE3CA:  .byte $55, $4D, $C2
LE3CD:  .byte $02, $CE, $EC         ;message $C3 line 1: colour 1, y -200, x -80
LE3D0:  .byte $53, $50, $41, $52, $45, $20, $B2 ;"SPARE 2"
LE3D7:  .byte $02, $C2, $E3         ;message $C4 line 1: colour 1, y -248, x -116
LE3DA:  .byte $A0                   ;" "
LE3DB:  .byte $02, $B5, $EC         ;message $C5 line 1: colour 1, y -300, x -80
LE3DE:  .byte $A0                   ;" "
LE3DF:  .byte $02, $B5, $EF         ;message $C6 line 1: colour 1, y -300, x -68
LE3E2:  .byte $A0                   ;" "
LE3E3:  .byte $0E, $34, $39         ;message $C7 line 1: colour 7, y 208, x 228
LE3E6:  .byte $50, $4F, $54, $20, $54, $45, $53, $D4 ;"POT TEST"
LE3EE:  .byte $0E, $64, $E3         ;message $C8 line 1: colour 7, y 400, x -116
LE3F1:  .byte $53, $4F, $55, $4E, $44, $20, $54, $45 ;"SOUND TEST"
LE3F9:  .byte $53, $D4
LE3FB:  .byte $06, $00, $F2         ;message $C8 line 2: colour 3, y 0, x -56
LE3FE:  .byte $53, $4F, $55, $4E, $C4 ;"SOUND"
LE403:  .byte $0E, $64, $DA         ;message $C9 line 1: colour 7, y 400, x -152

MES194:
LE406:  .byte $4D, $41, $54, $48, $42, $4F, $58, $20 ;"MATHBOX TESTS"
LE40E:  .byte $54, $45, $53, $54, $D3
LE413:  .byte $0E, $32, $BF         ;message $CA line 1: colour 7, y 200, x -260

MES195:
LE416:  .byte $42, $41, $44, $20, $4D, $41, $54, $48 ;"BAD MATHBOX READY LINE"
LE41E:  .byte $42, $4F, $58, $20, $52, $45, $41, $44
LE426:  .byte $59, $20, $4C, $49, $4E, $C5
LE42C:  .byte $0E, $57, $D7         ;message $CB line 1: colour 7, y 348, x -164

MES196:
LE42F:  .byte $44, $49, $56, $49, $44, $45, $52, $20 ;"DIVIDER ERRORS"
LE437:  .byte $45, $52, $52, $4F, $52, $D3
LE43D:  .byte $0E, $32, $CE         ;message $CC line 1: colour 7, y 200, x -200

MES197:
LE440:  .byte $4E, $4F, $20, $44, $49, $56, $49, $44 ;"NO DIVIDER ERRORS"
LE448:  .byte $45, $52, $20, $45, $52, $52, $4F, $52
LE450:  .byte $D3
LE451:  .byte $0E, $44, $A7         ;message $CD line 1: colour 7, y 272, x -356

MES198:
LE454:  .byte $4F, $50, $54, $20, $53, $57, $20, $20 ;"OPT SW    NUM DIV DEN IS ERROR"
LE45C:  .byte $20, $20, $4E, $55, $4D, $20, $44, $49
LE464:  .byte $56, $20, $44, $45, $4E, $20, $49, $53
LE46C:  .byte $20, $45, $52, $52, $4F, $D2
LE472:  .byte $0E, $E7, $DA         ;message $CE line 1: colour 7, y -100, x -152

MES199:
LE475:  .byte $4D, $41, $54, $52, $49, $58, $20, $45 ;"MATRIX ERRORS"
LE47D:  .byte $52, $52, $4F, $52, $D3
LE482:  .byte $0E, $B5, $D1         ;message $CF line 1: colour 7, y -300, x -188

MES200:
LE485:  .byte $4E, $4F, $20, $4D, $41, $54, $52, $49 ;"NO MATRIX ERRORS"
LE48D:  .byte $58, $20, $45, $52, $52, $4F, $52, $D3
LE495:  .byte $0E, $19, $E9         ;message $D0 line 1: colour 7, y 100, x -92
LE498:  .byte $42, $49, $50, $20, $54, $45, $53, $D4 ;"BIP TEST"
LE4A0:  .byte $0E, $E7, $D4         ;message $D0 line 2: colour 7, y -100, x -176

MES202:
LE4A3:  .byte $41, $4C, $49, $47, $4E, $20, $54, $48 ;"ALIGN THE BOXES"
LE4AB:  .byte $45, $20, $42, $4F, $58, $45, $D3
LE4B2:  .byte $0E, $3E, $E3         ;message $D1 line 1: colour 7, y 248, x -116
LE4B5:  .byte $53, $43, $41, $4C, $45, $20, $54, $45 ;"SCALE TEST"
LE4BD:  .byte $53, $D4
LE4BF:  .byte $0E, $2F, $EF         ;message $D2 line 1: colour 7, y 188, x -68
LE4C2:  .byte $4C, $49, $4E, $45, $41, $D2 ;"LINEAR"
LE4C8:  .byte $0E, $2F, $CE         ;message $D3 line 1: colour 7, y 188, x -200

MES205:
LE4CB:  .byte $4C, $49, $4E, $45, $41, $52, $20, $41 ;"LINEAR AND BINARY"
LE4D3:  .byte $4E, $44, $20, $42, $49, $4E, $41, $52
LE4DB:  .byte $D9
LE4DC:  .byte $0E, $4B, $D7         ;message $D4 line 1: colour 7, y 300, x -164

MES210:
LE4DF:  .byte $49, $4E, $54, $45, $4E, $53, $49, $54 ;"INTENSITY TEST"
LE4E7:  .byte $59, $20, $54, $45, $53, $D4
LE4ED:  .byte $10, $CE, $E7         ;message $D4 line 2: colour 8, y -200, x -100
LE4F0:  .byte $30, $2E, $20, $4F, $46, $C6 ;"0. OFF"
LE4F6:  .byte $12, $C2, $E7         ;message $D4 line 3: colour 9, y -248, x -100
LE4F9:  .byte $31, $2E, $20, $44, $49, $CD ;"1. DIM"
LE4FF:  .byte $14, $B5, $E7         ;message $D4 line 4: colour 10, y -300, x -100
LE502:  .byte $32, $2E, $20, $4C, $4F, $D7 ;"2. LOW"
LE508:  .byte $0E, $A9, $E7         ;message $D4 line 5: colour 7, y -348, x -100
LE50B:  .byte $33, $2E, $20, $48, $49, $47, $C8 ;"3. HIGH"
LE512:  .byte $0E, $83, $B3         ;message $D5 line 1: colour 7, y -500, x -308

MES211:
LE515:  .byte $50, $52, $45, $53, $53, $20, $41, $55 ;"PRESS AUX COIN TO CONTINUE"
LE51D:  .byte $58, $20, $43, $4F, $49, $4E, $20, $54
LE525:  .byte $4F, $20, $43, $4F, $4E, $54, $49, $4E
LE52D:  .byte $55, $C5
LE52F:  .byte $0E, $83, $AD         ;message $D6 line 1: colour 7, y -500, x -332
LE532:  .byte $50, $52, $45, $53, $53, $20, $41, $55 ;"PRESS AUX COIN FOR SELF TEST"
LE53A:  .byte $58, $20, $43, $4F, $49, $4E, $20, $46
LE542:  .byte $4F, $52, $20, $53, $45, $4C, $46, $20
LE54A:  .byte $54, $45, $53, $D4
LE54E:  .byte $16, $B5, $9E         ;message $D7 line 1: colour 11, y -300, x -392

HERE:
MES213:
LE551:  .byte $50, $55, $4C, $4C, $20, $52, $49, $47 ;"PULL RIGHT FIRE TO PERFORM RESETS"
LE559:  .byte $48, $54, $20, $46, $49, $52, $45, $20
LE561:  .byte $54, $4F, $20, $50, $45, $52, $46, $4F
LE569:  .byte $52, $4D, $20, $52, $45, $53, $45, $54
LE571:  .byte $D3
LE572:  .byte $C2, $49, $54, $20, $49, $53, $20, $41
LE57A:  .byte $20, $44, $41, $52, $4B, $20, $54, $49
LE582:  .byte $4D, $45, $20, $46, $4F, $D2
LE588:  .byte $B3, $54, $48, $45, $20, $52, $45, $42
LE590:  .byte $45, $4C, $53, $2E, $20, $54, $48, $45
LE598:  .byte $20, $45, $4D, $50, $49, $52, $45, $20
LE5A0:  .byte $48, $41, $D3
LE5A3:  .byte $AA, $4C, $41, $55, $4E, $43, $48, $45
LE5AB:  .byte $44, $20, $54, $48, $4F, $55, $53, $41
LE5B3:  .byte $4E, $44, $53, $20, $4F, $46, $20, $50
LE5BB:  .byte $52, $4F, $42, $4F, $54, $D3
LE5C1:  .byte $A1, $20, $49, $4E, $20, $53, $45, $41
LE5C9:  .byte $52, $43, $48, $20, $4F, $46, $20, $54
LE5D1:  .byte $48, $45, $20, $52, $45, $42, $45, $4C
LE5D9:  .byte $20, $48, $49, $44, $45, $4F, $55, $54
LE5E1:  .byte $AE
LE5E2:  .byte $A1, $54, $48, $45, $20, $45, $4D, $50
LE5EA:  .byte $49, $52, $45, $20, $46, $45, $41, $52
LE5F2:  .byte $53, $20, $54, $48, $45, $20, $53, $54
LE5FA:  .byte $52, $45, $4E, $47, $54, $48, $20, $4F
LE602:  .byte $C6
LE603:  .byte $AD, $20

MES87:
LE605:  .byte $54, $48, $45, $20, $46, $4F, $52, $43 ;.SPMESS <THE FORCE WILL BE WITH YOU.>
LE60D:  .byte $45, $20, $57, $49, $54, $48, $49, $4E
LE615:  .byte $20, $4F, $4E, $45, $20, $52, $45, $42
LE61D:  .byte $45, $4C, $AE
LE620:  .byte $C2, $2E, $2E, $2E, $4C, $55, $4B, $45
LE628:  .byte $20, $53, $4B, $59, $57, $41, $4C, $4B
LE630:  .byte $45, $52, $20, $2E, $2E, $AE

;------------------------------------------------------------------------------
; view_8dig - ESB's version of Star Wars' VW8DIG: output the four BCD bytes at U as 87,654,321 through Y, with
;   leading zeros blanked according to BT_SUP and a comma only once a digit has been shown. U is preserved. Falls
;   into the shared tail with view_6dig and view_4dig
;------------------------------------------------------------------------------
view_8dig:
LE636:  PSHS U
LE638:  BRA  LE642

;------------------------------------------------------------------------------
; view_6dig - ESB's version of Star Wars' VW6DIG: output the three BCD bytes at U as 654,321 through Y, zero
;   suppression by BT_SUP, U preserved
;------------------------------------------------------------------------------
view_6dig:
LE63A:  PSHS U
LE63C:  BRA  LE64F

;------------------------------------------------------------------------------
; view_4dig - output the two BCD bytes at U as 4,321 through Y: the high nibble of the first byte, a comma if a
;   digit has been shown, then the other three digits. U preserved. Called only through the cross-bank table entry
;   L607B
;------------------------------------------------------------------------------
view_4dig:
LE63E:  PSHS U
LE640:  BRA  LE653
LE642:  LDA  ,U+                    ;digits 8 and 7
LE644:  BSR  VWBYTE
LE646:  LDA  BT_SUP                 ;comma only once a digit has been shown (BT_SUP gone negative)
LE648:  BGE  LE64F
LE64A:  LDD  #$B931                 ;JSRL to the comma
LE64D:  STD  ,Y++
LE64F:  LDA  ,U+                    ;digits 6 and 5
LE651:  BSR  VWBYTE
LE653:  LDA  ,U                     ;digit 4 is the high nibble
LE655:  LSRA
LE656:  LSRA
LE657:  LSRA
LE658:  LSRA
LE659:  BSR  VWBYT1
LE65B:  LDA  BT_SUP
LE65D:  BGE  LE664
LE65F:  LDD  #$B931                 ;JSRL to the comma
LE662:  STD  ,Y++
LE664:  LDA  ,U+                    ;digit 3
LE666:  BSR  VWBYT1
LE668:  LDA  ,U                     ;digits 2 and 1
LE66A:  BSR  VWBYTE
LE66C:  PULS U,PC

;------------------------------------------------------------------------------
; VWBYTE - VIEW BOTH NUMERALS IN BYTE
;   FALL THRU TO VWBYTE
;------------------------------------------------------------------------------
VWBYTE:
LE66E:  PSHS U
LE670:  TFR  A,B
LE672:  LSRB                        ;DO HI BYTE
LE673:  LSRB
LE674:  LSRB
LE675:  ANDB #$1E
LE677:  BNE  LE682                  ;IFEQ  ?IS IT A ZERO?
LE679:  TST  BT_SUP
LE67B:  BLE  LE682                  ;IFGT  ?AND SUPPRESSION STILL ON?
LE67D:  LDU  VGMSGA                 ;THEN GET A BLANK
LE680:  BRA  VWBYTE_20
LE682:  CLR  BT_SUP                 ;ELSE IS SIGNIFICANT DIGIT--STOP ZERO SUPPRESSION
LE684:  LDU  #VGMSGA+2
LE687:  LDU  B,U

VWBYTE_20:          ;---OUTPUT SELECTED NUMERAL
LE689:  DEC  BT_SUP                 ;DECREASE NUMBER OF SUPPRESSED DIGITS
LE68B:  STU  ,Y++
LE68D:  BRA  LE691

;------------------------------------------------------------------------------
; VWBYT1 - TOMCAT NAME
;   VIEW ONLY LO NUMERAL
;   (also: VWBYT1)
;------------------------------------------------------------------------------
VWBYT1:
VWNIBL:
LE68F:  PSHS U
LE691:  LSLA
LE692:  ANDA #$1E
LE694:  BNE  LE69F                  ;IFEQ  ?IS IT A ZERO?
LE696:  TST  BT_SUP
LE698:  BLE  LE69F                  ;IFGT  ?AND SUPPRESSION STILL ON?
LE69A:  LDU  VGMSGA                 ;THEN GET A BLANK
LE69D:  BRA  VWBYT1_40
LE69F:  CLR  BT_SUP                 ;ELSE IS SIGNIFICANT DIGIT--STOP ZERO SUPPRESSION
LE6A1:  LDU  #VGMSGA+2
LE6A4:  LDU  A,U

VWBYT1_40:          ;---DISPLAY OUR NUMBER
LE6A6:  DEC  BT_SUP                 ;DECREASE NUMBER OF SIGNIFICANT DIGITS
LE6A8:  STU  ,Y++
LE6AA:  PULS U,PC

;------------------------------------------------------------------------------
; do_message - ESB's version of Star Wars' DOMESS: draw message B through Y at its fixed place. Ignores numbers
;   of $DF and up and messages whose line count in message_tab is zero (the banner messages), saves the number in
;   MESNUM, then mes_lines draws every line with its own colour. X preserved
;------------------------------------------------------------------------------
do_message:
LE6AC:  PSHS X
LE6AE:  CMPB #$DF                   ;MESSZ: a legal message number?
LE6B0:  BCC  LE6C6
LE6B2:  STB  >MESNUM
LE6B5:  LDX  #message_tab           ;MESSAGE POSITION TABLE
LE6B8:  ABX                         ;*4 FOR 2-WORD ENTRIES
LE6B9:  ABX
LE6BA:  ABX
LE6BB:  LDB  ,X                     ;number of lines
LE6BD:  BLE  LE6C6                  ;none: a banner message, not drawn here
LE6BF:  STB  >mes_linect
LE6C2:  LDX  1,X                    ;X = the first line
LE6C4:  BSR  mes_lines
LE6C6:  PULS X,PC

;------------------------------------------------------------------------------
; do_message_nc - ESB's version of Star Wars' DOMES2: as do_message but without a colour instruction, the caller
;   has set the colour. Draws the lines with mes_lines_nc
;------------------------------------------------------------------------------
do_message_nc:
LE6C8:  PSHS X
LE6CA:  CMPB #$DF                   ;MESSZ: a legal message number?
LE6CC:  BCC  LE6E2
LE6CE:  STB  >MESNUM
LE6D1:  LDX  #message_tab           ;MESSAGE POSITION TABLE
LE6D4:  ABX                         ;*4 FOR 2-WORD ENTRIES
LE6D5:  ABX
LE6D6:  ABX
LE6D7:  LDB  ,X
LE6D9:  BLE  LE6E2
LE6DB:  STB  >mes_linect
LE6DE:  LDX  1,X
LE6E0:  BSR  mes_lines_nc
LE6E2:  PULS X,PC

;------------------------------------------------------------------------------
; mes_lines - draw the lines of a message: X = the first line, mes_linect = number of lines, Y = display list.
;   Each line is a colour index (times 2) into mes_colour_tab, y / 4, x / 4 (signed bytes) and the text. Per line
;   it writes the colour word, the position vector, the characters (mes_text) and a centre instruction, and after
;   the last line the normal scale $7200
;------------------------------------------------------------------------------
mes_lines:
LE6E4:  PSHS U
LE6E6:  LDB  ,X+                    ;colour index times 2
LE6E8:  LDU  #mes_colour_tab
LE6EB:  LDD  B,U
LE6ED:  STD  ,Y++
LE6EF:  LDB  ,X+                    ;y / 4, signed: times 4 into a 13-bit vector word
LE6F1:  SEX
LE6F2:  ASLB
LE6F3:  ASLB
LE6F4:  ROLA
LE6F5:  ANDA #$1F
LE6F7:  STD  ,Y++
LE6F9:  LDB  ,X+                    ;x / 4, signed, brightness 0
LE6FB:  SEX
LE6FC:  ASLB
LE6FD:  ASLB
LE6FE:  ROLA
LE6FF:  ANDA #$1F
LE701:  STD  ,Y++
LE703:  JSR  mes_text               ;the characters
LE706:  LDD  #$8040                 ;centre
LE709:  STD  ,Y++
LE70B:  DEC  >mes_linect            ;next line
LE70E:  BNE  LE6E6
LE710:  LDD  #$7200                 ;normal scale
LE713:  STD  ,Y++
LE715:  PULS U,PC

;------------------------------------------------------------------------------
; mes_lines_nc - as mes_lines but the colour byte of each line is skipped and no colour word is written
;------------------------------------------------------------------------------
mes_lines_nc:
LE717:  PSHS U
LE719:  LEAX 1,X                    ;skip the line's colour byte
LE71B:  LDB  ,X+
LE71D:  SEX
LE71E:  ASLB
LE71F:  ASLB
LE720:  ROLA
LE721:  ANDA #$1F
LE723:  STD  ,Y++
LE725:  LDB  ,X+
LE727:  SEX
LE728:  ASLB
LE729:  ASLB
LE72A:  ROLA
LE72B:  ANDA #$1F
LE72D:  STD  ,Y++
LE72F:  JSR  mes_text
LE732:  LDD  #$8040
LE735:  STD  ,Y++
LE737:  DEC  >mes_linect
LE73A:  BNE  LE719
LE73C:  LDD  #$7200
LE73F:  STD  ,Y++
LE741:  PULS U,PC

;------------------------------------------------------------------------------
; mes_lines_scroll - as mes_lines but MSYOFF is subtracted from each line's y, so the text scrolls. Used by
;   VWMESS for the messages in the MESBLK list (Star Wars' MOUT2)
;------------------------------------------------------------------------------
mes_lines_scroll:
LE743:  PSHS U
LE745:  LDB  ,X+
LE747:  LDU  #mes_colour_tab
LE74A:  LDD  B,U
LE74C:  STD  ,Y++
LE74E:  LDB  ,X+
LE750:  SEX
LE751:  ASLB
LE752:  ASLB
LE753:  ROLA
LE754:  SUBD >MSYOFF                ;less the scroll offset
LE757:  ANDA #$1F
LE759:  STD  ,Y++
LE75B:  LDB  ,X+
LE75D:  SEX
LE75E:  ASLB
LE75F:  ASLB
LE760:  ROLA
LE761:  ANDA #$1F
LE763:  STD  ,Y++
LE765:  JSR  mes_text
LE768:  LDD  #$8040
LE76B:  STD  ,Y++
LE76D:  DEC  >mes_linect
LE770:  BNE  LE745
LE772:  LDD  #$7200
LE775:  STD  ,Y++
LE777:  PULS U,PC

;------------------------------------------------------------------------------
; mes_lines_fade - as mes_lines_scroll but each line's colour word takes only its high byte from mes_colour_tab
;   and its brightness from ph_col_brt, so the whole text can be faded. Used by VWMES2
;------------------------------------------------------------------------------
mes_lines_fade:
LE779:  PSHS U
LE77B:  LDB  ,X+
LE77D:  LDU  #mes_colour_tab
LE780:  LDA  B,U                    ;high byte of the line's colour word
LE782:  LDB  ph_col_brt             ;brightness common to all lines
LE785:  STD  ,Y++
LE787:  LDB  ,X+
LE789:  SEX
LE78A:  ASLB
LE78B:  ASLB
LE78C:  ROLA
LE78D:  SUBD >MSYOFF                ;less the scroll offset
LE790:  ANDA #$1F
LE792:  STD  ,Y++
LE794:  LDB  ,X+
LE796:  SEX
LE797:  ASLB
LE798:  ASLB
LE799:  ROLA
LE79A:  ANDA #$1F
LE79C:  STD  ,Y++
LE79E:  JSR  mes_text
LE7A1:  LDD  #$8040
LE7A4:  STD  ,Y++
LE7A6:  DEC  >mes_linect
LE7A9:  BNE  LE77B
LE7AB:  LDD  #$7200
LE7AE:  STD  ,Y++
LE7B0:  PULS U,PC

;------------------------------------------------------------------------------
; mes_text - ESB's version of Star Wars' MESOUT: output the characters at X through Y until one with bit 7 set
;   has been done, each as the JSRL word found in the vector ROM's character tables - letters $41 up, the colon,
;   digits $30-$39, and space and punctuation $20-$2F each have their own table base. X is left after the text, U
;   preserved
;------------------------------------------------------------------------------
mes_text:
LE7B2:  PSHS U
LE7B4:  LDB  ,X+
LE7B6:  ANDB #$7F                   ;without the end mark
LE7B8:  CMPB #$41                   ;a letter?
LE7BA:  BCS  LE7C3
LE7BC:  ANDB #$3F
LE7BE:  LDU  #L3016                 ;letters: table at $3018, indexed by (character - $40) times 2
LE7C1:  BRA  LE7D8
LE7C3:  CMPB #$3A                   ;colon?
LE7C5:  BNE  LE7CC
LE7C7:  LDU  #$2FD8                 ;its word is at $304C
LE7CA:  BRA  LE7D8
LE7CC:  CMPB #$30                   ;a digit?
LE7CE:  BCS  LE7D5
LE7D0:  LDU  #$2FA4                 ;digits: table at $3004
LE7D3:  BRA  LE7D8
LE7D5:  LDU  #L300E                 ;$20-$2F, space and punctuation: table at $304E
LE7D8:  ASLB
LE7D9:  LDD  B,U
LE7DB:  STD  ,Y++
LE7DD:  TST  -1,X                   ;bit 7 marks the last character
LE7DF:  BPL  LE7B4
LE7E1:  PULS U,PC

message_tab:
LE7E3:  .byte $04                   ;message $00: 4 lines
LE7E4:  .word LCD13
LE7E6:  .byte $0E                   ;message $01: 14 lines
LE7E7:  .word LCDA0
LE7E9:  .byte $01                   ;message $02: 1 line
LE7EA:  .word LCEAA
LE7EC:  .byte $01                   ;message $03: 1 line
LE7ED:  .word LCEB6
LE7EF:  .byte $01                   ;message $04: 1 line
LE7F0:  .word LCEC2
LE7F2:  .byte $01                   ;message $05: 1 line
LE7F3:  .word LCED1
LE7F5:  .byte $01                   ;message $06: 1 line
LE7F6:  .word LCEDD
LE7F8:  .byte $01                   ;message $07: 1 line
LE7F9:  .word LCEEE
LE7FB:  .byte $01                   ;message $08: 1 line
LE7FC:  .word LCEFE
LE7FE:  .byte $01                   ;message $09: 1 line
LE7FF:  .word LCF0F
LE801:  .byte $01                   ;message $0A: 1 line
LE802:  .word LCF27
LE804:  .byte $01                   ;message $0B: 1 line
LE805:  .word LCF31
LE807:  .byte $01                   ;message $0C: 1 line
LE808:  .word LCF3A
LE80A:  .byte $02                   ;message $0D: 2 lines
LE80B:  .word LCF44
LE80D:  .byte $01                   ;message $0E: 1 line
LE80E:  .word LCF55
LE810:  .byte $01                   ;message $0F: 1 line
LE811:  .word LCF5C
LE813:  .byte $01                   ;message $10: 1 line
LE814:  .word LCF66
LE816:  .byte $01                   ;message $11: 1 line
LE817:  .word LCF70
LE819:  .byte $01                   ;message $12: 1 line
LE81A:  .word LCF77
LE81C:  .byte $01                   ;message $13: 1 line
LE81D:  .word LCF7B
LE81F:  .byte $01                   ;message $14: 1 line
LE820:  .word LCF83
LE822:  .byte $01                   ;message $15: 1 line
LE823:  .word LCF87
LE825:  .byte $01                   ;message $16: 1 line
LE826:  .word LCF9D
LE828:  .byte $01                   ;message $17: 1 line
LE829:  .word LCFC1
LE82B:  .byte $01                   ;message $18: 1 line
LE82C:  .word LCFE4
LE82E:  .byte $01                   ;message $19: 1 line
LE82F:  .word LD008
LE831:  .byte $01                   ;message $1A: 1 line
LE832:  .word LD028
LE834:  .byte $01                   ;message $1B: 1 line
LE835:  .word LD041
LE837:  .byte $01                   ;message $1C: 1 line
LE838:  .word LD066
LE83A:  .byte $01                   ;message $1D: 1 line
LE83B:  .word LD088
LE83D:  .byte $01                   ;message $1E: 1 line
LE83E:  .word LD0AB
LE840:  .byte $01                   ;message $1F: 1 line
LE841:  .word LD0D0
LE843:  .byte $01                   ;message $20: 1 line
LE844:  .word LD0E9
LE846:  .byte $01                   ;message $21: 1 line
LE847:  .word LD0ED
LE849:  .byte $01                   ;message $22: 1 line
LE84A:  .word LD0F1
LE84C:  .byte $01                   ;message $23: 1 line
LE84D:  .word LD0F5
LE84F:  .byte $01                   ;message $24: 1 line
LE850:  .word LD0F9
LE852:  .byte $04                   ;message $25: 4 lines
LE853:  .word LD109
LE855:  .byte $04                   ;message $26: 4 lines
LE856:  .word LD127
LE858:  .byte $04                   ;message $27: 4 lines
LE859:  .word LD148
LE85B:  .byte $06                   ;message $28: 6 lines
LE85C:  .word LD179
LE85E:  .byte $04                   ;message $29: 4 lines
LE85F:  .word LD1B7
LE861:  .byte $01                   ;message $2A: 1 line
LE862:  .word LD1E3
LE864:  .byte $10                   ;message $2B: 16 lines
LE865:  .word LD20E
LE867:  .byte $02                   ;message $2C: 2 lines
LE868:  .word LD2DF
LE86A:  .byte $04                   ;message $2D: 4 lines
LE86B:  .word LD31D
LE86D:  .byte $03                   ;message $2E: 3 lines
LE86E:  .word LD35A
LE870:  .byte $02                   ;message $2F: 2 lines
LE871:  .word LD39D
LE873:  .byte $03                   ;message $30: 3 lines
LE874:  .word LD3D3
LE876:  .byte $04                   ;message $31: 4 lines
LE877:  .word LD426
LE879:  .byte $02                   ;message $32: 2 lines
LE87A:  .word LD4A1
LE87C:  .byte $02                   ;message $33: 2 lines
LE87D:  .word LD4C4
LE87F:  .byte $01                   ;message $34: 1 line
LE880:  .word LD4E7
LE882:  .byte $01                   ;message $35: 1 line
LE883:  .word LD50F
LE885:  .byte $01                   ;message $36: 1 line
LE886:  .word LD537
LE888:  .byte $01                   ;message $37: 1 line
LE889:  .word LD55D
LE88B:  .byte $01                   ;message $38: 1 line
LE88C:  .word LD57A
LE88E:  .byte $01                   ;message $39: 1 line
LE88F:  .word LD5A2
LE891:  .byte $01                   ;message $3A: 1 line
LE892:  .word LD5C4
LE894:  .byte $01                   ;message $3B: 1 line
LE895:  .word LD5F1
LE897:  .byte $01                   ;message $3C: 1 line
LE898:  .word LD61A
LE89A:  .byte $01                   ;message $3D: 1 line
LE89B:  .word LD636
LE89D:  .byte $01                   ;message $3E: 1 line
LE89E:  .word LD651
LE8A0:  .byte $01                   ;message $3F: 1 line
LE8A1:  .word LD66E
LE8A3:  .byte $01                   ;message $40: 1 line
LE8A4:  .word LD68A
LE8A6:  .byte $01                   ;message $41: 1 line
LE8A7:  .word LD6A6
LE8A9:  .byte $01                   ;message $42: 1 line
LE8AA:  .word LD6B5
LE8AC:  .byte $01                   ;message $43: 1 line
LE8AD:  .word LD6C3
LE8AF:  .byte $01                   ;message $44: 1 line
LE8B0:  .word LD6D9
LE8B2:  .byte $01                   ;message $45: 1 line
LE8B3:  .word LD6F9
LE8B5:  .byte $01                   ;message $46: 1 line
LE8B6:  .word LD709
LE8B8:  .byte $01                   ;message $47: 1 line
LE8B9:  .word LD72B
LE8BB:  .byte $01                   ;message $48: 1 line
LE8BC:  .word LD754
LE8BE:  .byte $01                   ;message $49: 1 line
LE8BF:  .word LD777
LE8C1:  .byte $01                   ;message $4A: 1 line
LE8C2:  .word LD799
LE8C4:  .byte $01                   ;message $4B: 1 line
LE8C5:  .word LD7C0
LE8C7:  .byte $01                   ;message $4C: 1 line
LE8C8:  .word LD7E7
LE8CA:  .byte $01                   ;message $4D: 1 line
LE8CB:  .word LD80E
LE8CD:  .byte $01                   ;message $4E: 1 line
LE8CE:  .word LD835
LE8D0:  .byte $01                   ;message $4F: 1 line
LE8D1:  .word LD854
LE8D3:  .byte $01                   ;message $50: 1 line
LE8D4:  .word LD875
LE8D6:  .byte $01                   ;message $51: 1 line
LE8D7:  .word LD89F
LE8D9:  .byte $01                   ;message $52: 1 line
LE8DA:  .word LD8C5
LE8DC:  .byte $01                   ;message $53: 1 line
LE8DD:  .word LD8E8
LE8DF:  .byte $02                   ;message $54: 2 lines
LE8E0:  .word LD90B
LE8E2:  .byte $01                   ;message $55: 1 line
LE8E3:  .word LD92B
LE8E5:  .byte $02                   ;message $56: 2 lines
LE8E6:  .word LD945
LE8E8:  .byte $01                   ;message $57: 1 line
LE8E9:  .word LD959
LE8EB:  .byte $04                   ;message $58: 4 lines
LE8EC:  .word LD96B
LE8EE:  .byte $01                   ;message $59: 1 line
LE8EF:  .word LD999
LE8F1:  .byte $01                   ;message $5A: 1 line
LE8F2:  .word LD9AE
LE8F4:  .byte $05                   ;message $5B: 5 lines
LE8F5:  .word LD9BD
LE8F7:  .byte $01                   ;message $5C: 1 line
LE8F8:  .word LD9FE
LE8FA:  .byte $04                   ;message $5D: 4 lines
LE8FB:  .word LDA11
LE8FD:  .byte $05                   ;message $5E: 5 lines
LE8FE:  .word LDA41
LE900:  .byte $02                   ;message $5F: 2 lines
LE901:  .word LDA7A
LE903:  .byte $01                   ;message $60: 1 line
LE904:  .word LDAA7
LE906:  .byte $01                   ;message $61: 1 line
LE907:  .word LDAB2
LE909:  .byte $05                   ;message $62: 5 lines
LE90A:  .word LDACA
LE90C:  .byte $03                   ;message $63: 3 lines
LE90D:  .word LDB08
LE90F:  .byte $05                   ;message $64: 5 lines
LE910:  .word LDB6D
LE912:  .byte $02                   ;message $65: 2 lines
LE913:  .word LDBAB
LE915:  .byte $02                   ;message $66: 2 lines
LE916:  .word LDBDA
LE918:  .byte $01                   ;message $67: 1 line
LE919:  .word LDC0E
LE91B:  .byte $05                   ;message $68: 5 lines
LE91C:  .word LDC26
LE91E:  .byte $01                   ;message $69: 1 line
LE91F:  .word LDC64
LE921:  .byte $05                   ;message $6A: 5 lines
LE922:  .word LDC7D
LE924:  .byte $05                   ;message $6B: 5 lines
LE925:  .word LDCBA
LE927:  .byte $02                   ;message $6C: 2 lines
LE928:  .word LDCFD
LE92A:  .byte $01                   ;message $6D: 1 line
LE92B:  .word LDD25
LE92D:  .byte $01                   ;message $6E: 1 line
LE92E:  .word LDD30
LE930:  .byte $04                   ;message $6F: 4 lines
LE931:  .word LDD47
LE933:  .byte $01                   ;message $70: 1 line
LE934:  .word LDD75
LE936:  .byte $03                   ;message $71: 3 lines
LE937:  .word LDD8D
LE939:  .byte $01                   ;message $72: 1 line
LE93A:  .word LDDB2
LE93C:  .byte $01                   ;message $73: 1 line
LE93D:  .word LDDBD
LE93F:  .byte $01                   ;message $74: 1 line
LE940:  .word LDDC1
LE942:  .byte $02                   ;message $75: 2 lines
LE943:  .word LDDD5
LE945:  .byte $01                   ;message $76: 1 line
LE946:  .word LDE12
LE948:  .byte $01                   ;message $77: 1 line
LE949:  .word LDE27
LE94B:  .byte $0D                   ;message $78: 13 lines
LE94C:  .word LDE48
LE94E:  .byte $0F                   ;message $79: 15 lines
LE94F:  .word LDF7B
LE951:  .byte $01                   ;message $7A: 1 line
LE952:  .word LE09C
LE954:  .byte $01                   ;message $7B: 1 line
LE955:  .word LE0A8
LE957:  .byte $01                   ;message $7C: 1 line
LE958:  .word LE0B4
LE95A:  .byte $01                   ;message $7D: 1 line
LE95B:  .word LE0BF
LE95D:  .byte $01                   ;message $7E: 1 line
LE95E:  .word LE0CA
LE960:  .byte $01                   ;message $7F: 1 line
LE961:  .word LE0CE
LE963:  .byte $01                   ;message $80: 1 line
LE964:  .word LE0D2
LE966:  .byte $01                   ;message $81: 1 line
LE967:  .word LE0D6
LE969:  .byte $01                   ;message $82: 1 line
LE96A:  .word LE0DA
LE96C:  .byte $01                   ;message $83: 1 line
LE96D:  .word LE0DE
LE96F:  .byte $01                   ;message $84: 1 line
LE970:  .word LE0E2
LE972:  .byte $01                   ;message $85: 1 line
LE973:  .word LE0E9
LE975:  .byte $01                   ;message $86: 1 line
LE976:  .word LE0F5
LE978:  .byte $01                   ;message $87: 1 line
LE979:  .word LE101
LE97B:  .byte $01                   ;message $88: 1 line
LE97C:  .word LE10D
LE97E:  .byte $01                   ;message $89: 1 line
LE97F:  .word LE119
LE981:  .byte $01                   ;message $8A: 1 line
LE982:  .word LE125
LE984:  .byte $01                   ;message $8B: 1 line
LE985:  .word LE12C
LE987:  .byte $01                   ;message $8C: 1 line
LE988:  .word LE133
LE98A:  .byte $01                   ;message $8D: 1 line
LE98B:  .word LE137
LE98D:  .byte $01                   ;message $8E: 1 line
LE98E:  .word LE13B
LE990:  .byte $01                   ;message $8F: 1 line
LE991:  .word LE13F
LE993:  .byte $01                   ;message $90: 1 line
LE994:  .word LE143
LE996:  .byte $01                   ;message $91: 1 line
LE997:  .word LE14A
LE999:  .byte $01                   ;message $92: 1 line
LE99A:  .word LE155
LE99C:  .byte $01                   ;message $93: 1 line
LE99D:  .word LE15C
LE99F:  .byte $01                   ;message $94: 1 line
LE9A0:  .word LE166
LE9A2:  .byte $01                   ;message $95: 1 line
LE9A3:  .word LE16E
LE9A5:  .byte $01                   ;message $96: 1 line
LE9A6:  .word LE17B
LE9A8:  .byte $01                   ;message $97: 1 line
LE9A9:  .word LE187
LE9AB:  .byte $01                   ;message $98: 1 line
LE9AC:  .word LE198
LE9AE:  .byte $01                   ;message $99: 1 line
LE9AF:  .word LE19D
LE9B1:  .byte $01                   ;message $9A: 1 line
LE9B2:  .word LE1A3
LE9B4:  .byte $01                   ;message $9B: 1 line
LE9B5:  .word LE1A8
LE9B7:  .byte $01                   ;message $9C: 1 line
LE9B8:  .word LE1AE
LE9BA:  .byte $01                   ;message $9D: 1 line
LE9BB:  .word LE1B3
LE9BD:  .byte $01                   ;message $9E: 1 line
LE9BE:  .word LE1B9
LE9C0:  .byte $01                   ;message $9F: 1 line
LE9C1:  .word LE1BE
LE9C3:  .byte $01                   ;message $A0: 1 line
LE9C4:  .word LE1C4
LE9C6:  .byte $01                   ;message $A1: 1 line
LE9C7:  .word LE1C9
LE9C9:  .byte $01                   ;message $A2: 1 line
LE9CA:  .word LE1CF
LE9CC:  .byte $01                   ;message $A3: 1 line
LE9CD:  .word LE1DB
LE9CF:  .byte $01                   ;message $A4: 1 line
LE9D0:  .word LE1E6
LE9D2:  .byte $02                   ;message $A5: 2 lines
LE9D3:  .word LE1F8
LE9D5:  .byte $01                   ;message $A6: 1 line
LE9D6:  .word LE217
LE9D8:  .byte $01                   ;message $A7: 1 line
LE9D9:  .word LE22C
LE9DB:  .byte $01                   ;message $A8: 1 line
LE9DC:  .word LE23D
LE9DE:  .byte $01                   ;message $A9: 1 line
LE9DF:  .word LE24E
LE9E1:  .byte $01                   ;message $AA: 1 line
LE9E2:  .word LE25E
LE9E4:  .byte $01                   ;message $AB: 1 line
LE9E5:  .word LE26E
LE9E7:  .byte $01                   ;message $AC: 1 line
LE9E8:  .word LE27E
LE9EA:  .byte $01                   ;message $AD: 1 line
LE9EB:  .word LE28E
LE9ED:  .byte $01                   ;message $AE: 1 line
LE9EE:  .word LE29E
LE9F0:  .byte $01                   ;message $AF: 1 line
LE9F1:  .word LE2AE
LE9F3:  .byte $01                   ;message $B0: 1 line
LE9F4:  .word LE2C7
LE9F6:  .byte $01                   ;message $B1: 1 line
LE9F7:  .word LE2DC
LE9F9:  .byte $01                   ;message $B2: 1 line
LE9FA:  .word LE2F2
LE9FC:  .byte $01                   ;message $B3: 1 line
LE9FD:  .word LE308
LE9FF:  .byte $01                   ;message $B4: 1 line
LEA00:  .word LE31D
LEA02:  .byte $01                   ;message $B5: 1 line
LEA03:  .word LE333
LEA05:  .byte $01                   ;message $B6: 1 line
LEA06:  .word LE342
LEA08:  .byte $01                   ;message $B7: 1 line
LEA09:  .word LE350
LEA0B:  .byte $01                   ;message $B8: 1 line
LEA0C:  .word LE35C
LEA0E:  .byte $01                   ;message $B9: 1 line
LEA0F:  .word LE369
LEA11:  .byte $01                   ;message $BA: 1 line
LEA12:  .word LE373
LEA14:  .byte $01                   ;message $BB: 1 line
LEA15:  .word LE37F
LEA17:  .byte $01                   ;message $BC: 1 line
LEA18:  .word LE386
LEA1A:  .byte $01                   ;message $BD: 1 line
LEA1B:  .word LE391
LEA1D:  .byte $01                   ;message $BE: 1 line
LEA1E:  .word LE39D
LEA20:  .byte $01                   ;message $BF: 1 line
LEA21:  .word LE3AA
LEA23:  .byte $01                   ;message $C0: 1 line
LEA24:  .word LE3AE
LEA26:  .byte $01                   ;message $C1: 1 line
LEA27:  .word LE3B2
LEA29:  .byte $01                   ;message $C2: 1 line
LEA2A:  .word LE3BF
LEA2C:  .byte $01                   ;message $C3: 1 line
LEA2D:  .word LE3CD
LEA2F:  .byte $01                   ;message $C4: 1 line
LEA30:  .word LE3D7
LEA32:  .byte $01                   ;message $C5: 1 line
LEA33:  .word LE3DB
LEA35:  .byte $01                   ;message $C6: 1 line
LEA36:  .word LE3DF
LEA38:  .byte $01                   ;message $C7: 1 line
LEA39:  .word LE3E3
LEA3B:  .byte $02                   ;message $C8: 2 lines
LEA3C:  .word LE3EE
LEA3E:  .byte $01                   ;message $C9: 1 line
LEA3F:  .word LE403
LEA41:  .byte $01                   ;message $CA: 1 line
LEA42:  .word LE413
LEA44:  .byte $01                   ;message $CB: 1 line
LEA45:  .word LE42C
LEA47:  .byte $01                   ;message $CC: 1 line
LEA48:  .word LE43D
LEA4A:  .byte $01                   ;message $CD: 1 line
LEA4B:  .word LE451
LEA4D:  .byte $01                   ;message $CE: 1 line
LEA4E:  .word LE472
LEA50:  .byte $01                   ;message $CF: 1 line
LEA51:  .word LE482
LEA53:  .byte $02                   ;message $D0: 2 lines
LEA54:  .word LE495
LEA56:  .byte $01                   ;message $D1: 1 line
LEA57:  .word LE4B2
LEA59:  .byte $01                   ;message $D2: 1 line
LEA5A:  .word LE4BF
LEA5C:  .byte $01                   ;message $D3: 1 line
LEA5D:  .word LE4C8
LEA5F:  .byte $05                   ;message $D4: 5 lines
LEA60:  .word LE4DC
LEA62:  .byte $01                   ;message $D5: 1 line
LEA63:  .word LE512
LEA65:  .byte $01                   ;message $D6: 1 line
LEA66:  .word LE52F
LEA68:  .byte $01                   ;message $D7: 1 line
LEA69:  .word LE54E
LEA6B:  .byte $00                   ;message $D8: 0 lines
LEA6C:  .word LE572
LEA6E:  .byte $00                   ;message $D9: 0 lines
LEA6F:  .word LE588
LEA71:  .byte $00                   ;message $DA: 0 lines
LEA72:  .word LE5A3
LEA74:  .byte $00                   ;message $DB: 0 lines
LEA75:  .word LE5C1
LEA77:  .byte $00                   ;message $DC: 0 lines
LEA78:  .word LE5E2
LEA7A:  .byte $00                   ;message $DD: 0 lines
LEA7B:  .word LE603
LEA7D:  .byte $00                   ;message $DE: 0 lines
LEA7E:  .word LE620

;------------------------------------------------------------------------------
; irq_handler - Star Wars' IRQ routine as changed for ESB, called from irq_entry with U = the interrupted frame
;   and ended by RTS. Every 4 ms: checks the interrupted PC and the RAM trap byte (SWI on a fault), counts the
;   game frame timer, runs COINS, debounces the switch bytes, catches fire and thumb button edges, reads a pot,
;   and once every 256 interrupts checks the sound board's watchdog byte and resets it if wrong. Every fourth
;   interrupt it steps the game time and the BCD time-on counter. Then DOVG: when the vector generator has halted
;   it swaps display buffers if the mainline finished one, updates the gun sight and the animated picture slots at
;   the bottom of vector RAM and starts the generator again
;------------------------------------------------------------------------------
irq_handler:
LEA80:  LDX  10,U                   ;U = the interrupted frame: its PC
LEA82:  CMPX #prog_start            ;below the program ROM?
LEA85:  BCC  LEA88
LEA87:  SWI                         ;BREAK FOR OUT OF RANGE IRQ
LEA88:  LDA  #DPRAM/$100            ;SETUP NORMAL DIRECT PAGE
LEA8A:  TFR  A,DP
LEA8C:  STA  WTCHDG                 ;KEEP WATCHDOG QUIET HERE SINCE IT IS TOO FAST
;FOR MAINLINE
LEA8F:  LDA  S_GARBG                ;VALIDATE RAM TRAP
LEA91:  CMPA #$3F
LEA93:  BEQ  LEA96                  ;IFNE
LEA95:  SWI
LEA96:  DEC  GMTIMR                 ;?TIME FOR NEXT GAME FRAME UPDATE?
LEA98:  BPL  LEAA3                  ;IFMI  YES
LEA9A:  LDA  #$0B                   ;12.*4.2MS==>50. MS, 20 PER SECOND
LEA9C:  STA  GMTIMR
LEA9E:  INC  GMSYNC
LEAA0:  BVC  LEAA3                  ;IFVS  ?MAINLINE CAUGHT UP IN ITSELF?
LEAA2:  SWI
LEAA3:  INC  S_INTCT                ;INCREMENT THE INTERRUPT COUNTER
LEAA5:  INC  SWNEW                  ;INCREMENT THE INTERRUPT COUNTER
LEAA7:  JSR  COINS
LEAAA:  LDA  S_S_CRDT
LEAAC:  CMPA #BADCRD
LEAAE:  BLO  LEAB1                  ;IFHS  ?TOO MUCH OF A GOOD THING?
LEAB0:  SWI                         ;GAMING IS ILLEGAL, BREAK IT UP
;SWITCHES
LEAB1:  LDX  #IN_NW0
LEAB4:  LDA  R_BYT0
LEAB7:  JSR  DEBNCE
LEABA:  LDA  R_BYT1
LEABD:  JSR  DEBNCE
LEAC0:  LDA  R_BYT2
LEAC3:  JSR  DEBNCE
LEAC6:  LDA  R_BYT3
LEAC9:  JSR  DEBNCE
LEACC:  LDA  VG_LSN                 ;PREVIOUS NEW VALUE
LEACE:  STA  VG_LSO                 ;IS CURRENT OLD VALUE
LEAD0:  LDA  >R_THMB                ;THUMB VALUES
LEAD3:  ANDA #THMBT                 ;ISOLATE THUMB VALUES
LEAD5:  STA  -$1,S                  ;ITEMP THUMB VALUE
LEAD7:  LDA  >R_FIRE                ;GET THIS NEWEST VALUE
LEADA:  ANDA #-1-THMBT              ;CLEAR ROOM FOR CHANGING THUMB VALUE
LEADC:  ORA  -$1,S                  ;MIX IN THUMB VALUE
LEADE:  STA  VG_LSN                 ;AND SAY SO
LEAE0:  EORA VG_LSO                 ;CATCH ANY CHANGES
LEAE2:  ANDA VG_LSO                 ;FROM AN OLD '1'
LEAE4:  STA  VG_LSE                 ;1==>FALLING EDGE (WENT ON)
LEAE6:  LDA  VG_LSE                 ;SEE IF PLAYER HAS PRESSED FIRE
LEAE8:  ANDA #FIREBT|THMBT
LEAEA:  BEQ  LEAF0                  ;IFNE  ?SWITCH EDGE?
LEAEC:  ORA  VG_LON
LEAEE:  STA  VG_LON                 ;THEN TURN ON LAZARS
LEAF0:  JSR  DOPOTS
LEAF3:  LDA  S_INTCT
LEAF5:  BNE  LEB0C                  ;IFEQ  ONCE A SECOND
;BRIEF ASIDE: CHECK ON SOUND BOARD EVERY SO OFTEN
LEAF7:  LDA  R_STAS
LEAFA:  LSLA
LEAFB:  BPL  IRQ_112                ;B RESET SOUND PCB IF IT HASN'T HIT WATCHDOG
LEAFD:  LDA  R_RCVS                 ;ELSE SOUND PCB HIT WATCHDOG, VERIFY VALUE
LEB00:  CMPA #$D3                   ;CHECK VALUE FINDS 'CATCH FIRE AND BURN' MODE
LEB02:  BEQ  LEB0C                  ;IFNE  ?OOPS, WRONG VALUE, SOUND PCB IN TROUBLE

IRQ_112:
LEB04:  STA  W_RSTS                 ;FORCE A RESET TO SOUND BOARD
LEB07:  LDA  #$00                   ;RESET VIA SOFTWARE ALSO
LEB09:  STA  W_XMTS                 ;ATTEMPT TO RESET SOUND BOARD
LEB0C:  LDA  S_INTCT
LEB0E:  ANDA #$03                   ;EVERY 16 MILS
LEB10:  BNE  DOVG                   ;IFEQ
;INC TIMERS
LEB12:  LDA  >GTIME+2               ;CURRENT GAME TIMER - SET TO 0 AT START OF GAME
LEB15:  ADDA #$01
LEB17:  CMPA #$FA                   ;4 SECONDS? ( 250. * 16 ms = 4 SECONDS )
LEB19:  BLO  LEB1D                  ;IFHS  YES
LEB1B:  LDA  #$00                   ;START BACK AT 00
LEB1D:  STA  >GTIME+2
LEB20:  BNE  DOVG                   ;IFEQ  4 SECONDS, DO OTHER TIMERS
LEB22:  LDA  >GTIME+1
LEB25:  ADDA #$01
LEB27:  DAA
LEB28:  STA  >GTIME+1
LEB2B:  LDA  >GTIME
LEB2E:  ADCA #$00
LEB30:  DAA                         ;9999 * 16 ms = 666.6 MINS = 11.11 HOURS
LEB31:  BCS  LEB36                  ;IFCC  DON'T OVERFLOW TIME, MORE THAN 11 HOURS !!WOW!!
LEB33:  STA  >GTIME
;INC TOTAL TIME ON COUNT
LEB36:  LDA  TIMER+3
LEB39:  ADDA #$01
LEB3B:  DAA
LEB3C:  STA  TIMER+3
LEB3F:  LDA  TIMER+2
LEB42:  ADCA #$00
LEB44:  DAA
LEB45:  STA  TIMER+2
LEB48:  LDA  TIMER+1
LEB4B:  ADCA #$00
LEB4D:  DAA
LEB4E:  STA  TIMER+1
LEB51:  LDA  TIMER
LEB54:  ADCA #$00
LEB56:  DAA
LEB57:  STA  TIMER

DOVG:          ;HANDLE VG STUFF
LEB5A:  DEC  VGTIMR
LEB5C:  BVC  LEB6A                  ;IFVS  ?VGEN TIMED OUT?
LEB5E:  STA  VGSTOP                 ;THEN KILL IT
LEB61:  LDB  >vg_set                ;the display-list set last loaded
LEB64:  JSR  load_vg_set
LEB67:  JMP  DOVG_90
LEB6A:  LBPL DOVG_90                ;?START NEXT VGEN FIELD?
LEB6E:  LDA  VGHALT
LEB71:  LSLA
LEB72:  LBPL DOVG_90                ;?VGEN HALTED (READY TO START)?
LEB76:  LDA  VGSYNC                 ;?SWITCH FRAME BUFFERS?
LEB78:  BPL  LEB93                  ;IFMI  NON-NEGATIVE VALUE INDICATES BUFFER READY
LEB7A:  LDA  VGRAM
LEB7D:  ANDA #VGBFSZ/$200           ;HIGH BYTE IN VG WORDS
LEB7F:  BEQ  LEB83                  ;IFNE  BEWARE BAD VGRAM AND GLITCHES
LEB81:  LDA  #VGBFSZ/$100           ;HIGH BYTE ADDRESS IN BYTES
LEB83:  ORA  #(VGRAM/$100)&$FF
LEB85:  STA  VGSYNC
LEB87:  LDB  #$1D                   ;low byte of the JMPL: the buffer's list starts at word $1D (byte $3A), past the IRQ's picture slots
LEB89:  LSRA                        ;ALSO SWITCH FIELD BUFFERS
LEB8A:  ANDA #VGBFSZ/$200           ;PROG USED BYTES, VG USES WORDS
LEB8C:  EORA #VGBFSZ/$200           ;HI BYTE IN VG WORDS
LEB8E:  ORA  #$E0                   ;INCLUDE THE JMP
LEB90:  STD  VGRAM
LEB93:  DEC  PT_DLY                 ;ON STARTUP, DONT USE UNSEASONED POT FILTER
LEB95:  BPL  LEB9C                  ;IFMI
LEB97:  CLR  PT_DLY
LEB99:  JSR  RHCTRL                 ;DO CONTROLS AT IRQ VG TIME
LEB9C:  JSR  GNSITE                 ;AND DISPLAY ITS COORDS
;---LAZAR FIRE
LEB9F:  LDB  VG_LZF
LEBA1:  ADDB #$02
LEBA3:  CMPB #$10
LEBA5:  BLO  LEBA8                  ;IFHS  WRAPPED THE TABLE
LEBA7:  CLRB
LEBA8:  STB  VG_LZF
LEBAA:  LDX  #VRLZF+2               ;ALLOW FOR PREDEC
LEBAD:  ABX                         ;NEXT START OF RAM
LEBAE:  LDU  #VTLZF                 ;SOURCE ROM
LEBB1:  LDD  ,U++
LEBB3:  STD  ,--X
LEBB5:  CMPX #VRLZF
LEBB8:  BGT  LEBB1                  ;LEEND
LEBBA:  LDX  #$0012                 ;END OF RAM
LEBBD:  CMPU #VTLZFZ
LEBC1:  BHS  DOVG_48                ;DONE LEAVE
LEBC3:  LDD  ,U++                   ;ROM HAS HEAD FIRST, TO TAIL
LEBC5:  STD  ,--X                   ;VIEW RAM HAS HEAD FAR AWAY, TAIL NEAR
LEBC7:  BRA  LEBBD                  ;LOOP

;===LAZAR SPLASH
DOVG_48:
LEBC9:  LDB  pic12_index            ;picture for the slot at vector RAM $0012: next of the four in VTLZS, every field
LEBCB:  ADDB #$02
LEBCD:  CMPB #$08
LEBCF:  BLO  LEBD2                  ;IFHS
LEBD1:  CLRB
LEBD2:  STB  pic12_index
LEBD4:  LDU  #VTLZS
LEBD7:  LDD  B,U
LEBD9:  STD  $0012                  ;ONE PICTURE ONLY
;ALIEN GUN SHOT, BASE SPARKLE
LEBDC:  DEC  gnb_timer
LEBDE:  BGT  LEC01                  ;IFLE
LEBE0:  LDB  #$04                   ;EVERY FOURTH SCREEN, CHANGE PICTURE TYPE
LEBE2:  STB  gnb_timer
LEBE4:  LDB  VG_GNB
LEBE6:  ADDB #$02
LEBE8:  CMPB #$08
LEBEA:  BLO  LEBED                  ;IFHS
LEBEC:  CLRB
LEBED:  STB  VG_GNB
LEBEF:  LDU  #VTGNB
LEBF2:  LDD  B,U
LEBF4:  STD  $001A                  ;ONE PICTURE ONLY
LEBF7:  LDB  VG_GNB                 ;ALSO HANDLE GUN EXPLODE SAME TIME
LEBF9:  LDU  #VTGNX
LEBFC:  LDD  B,U
LEBFE:  STD  $001E
;ALIEN GUN SHOT, TIP FUSE
LEC01:  DEC  pic1c_timer
LEC03:  BGT  LEC1C                  ;IFLE
LEC05:  LDB  #$01                   ;EVERY SCREEN, CHANGE PICTURE TYPE
LEC07:  STB  pic1c_timer
LEC09:  LDB  pic1c_index            ;picture for the slot at $001C: next of the four at LB94A
LEC0B:  ADDB #$02
LEC0D:  CMPB #$08
LEC0F:  BLO  LEC12                  ;IFHS
LEC11:  CLRB
LEC12:  STB  pic1c_index
LEC14:  LDU  #VTGNT
LEC17:  LDD  B,U
LEC19:  STD  $001C                  ;ONE PICTURE ONLY
LEC1C:  DEC  lzs_timer              ;every second field
LEC1E:  BGT  LEC37
LEC20:  LDB  #$02
LEC22:  STB  lzs_timer
;===LAZAR SPLASH
LEC24:  LDB  VG_LZS
LEC26:  ADDB #$02
LEC28:  CMPB #$08
LEC2A:  BLO  LEC2D                  ;IFHS
LEC2C:  CLRB
LEC2D:  STB  VG_LZS
LEC2F:  LDU  #spark_tab
LEC32:  LDD  B,U
LEC34:  STD  VRLZS                  ;ONE PICTURE ONLY
;ALIEN GUN SHOT, BASE SPARKLE
LEC37:  DEC  VF_GNB
LEC39:  BGT  LEC52                  ;IFLE
LEC3B:  LDB  #$01                   ;EVERY FOURTH SCREEN, CHANGE PICTURE TYPE
LEC3D:  STB  VF_GNB
;===LAZAR SPLASH
LEC3F:  LDB  gnx_index              ;picture for the slot VRGNX: next of the four at LB95A
LEC41:  ADDB #$02
LEC43:  CMPB #$08
LEC45:  BLO  LEC48                  ;IFHS
LEC47:  CLRB
LEC48:  STB  gnx_index
LEC4A:  LDU  #sparks_tab
LEC4D:  LDD  B,U
LEC4F:  STD  VRGNX
;ALIEN GUN SHOT, TIP FUSE
LEC52:  DEC  VF_GNT
LEC54:  BGT  LEC6D                  ;IFLE
LEC56:  LDB  #$01                   ;EVERY SCREEN, CHANGE PICTURE TYPE
LEC58:  STB  VF_GNT
LEC5A:  LDB  VG_GNT
LEC5C:  ADDB #$02
LEC5E:  CMPB #$08
LEC60:  BLO  LEC63                  ;IFHS
LEC62:  CLRB
LEC63:  STB  VG_GNT
LEC65:  LDU  #tri_tab
LEC68:  LDD  B,U
LEC6A:  STD  VRGNT                  ;ONE PICTURE ONLY
LEC6D:  LDB  VG_FLS                 ;BRITE FLASH
LEC6F:  ADDB #$02
LEC71:  CMPB #VTFLSZ-VTFLS
LEC73:  BLO  LEC76                  ;IFHS  ?OVERFLOWED?
LEC75:  CLRB
LEC76:  STB  VG_FLS
LEC78:  LDU  #VTFLS
LEC7B:  LDD  B,U
LEC7D:  STD  VRFLS                  ;ONE PICTURE ONLY
LEC80:  LDB  gs_fade                ;the same colour with brightness gs_fade
LEC82:  STD  $002E                  ;into the slot at $002E
LEC85:  LDB  #$80                   ;and with brightness $80 - flash_fade
LEC87:  SUBB flash_fade
LEC8A:  STD  $0032                  ;into the slot at $0032
LEC8D:  LDD  #VGRTSL                ;an RTSL after each of the three colour words
LEC90:  STD  $0028
LEC93:  STD  $0030
LEC96:  STD  $0034                  ;AND RETURN VG
LEC99:  LDB  VG_MFL                 ;MEDIUM FLASH
LEC9B:  ADDB #$02
LEC9D:  CMPB #VTMFLZ-VTMFL
LEC9F:  BLO  LECA2                  ;IFHS  ?OVERFLOWED TABLE?
LECA1:  CLRB                        ;THEN START AT BEGINNING
LECA2:  STB  VG_MFL
LECA4:  LDU  #VTMFL
LECA7:  LDD  B,U
LECA9:  STD  VRMFL                  ;ONE PICTURE ONLY
LECAC:  LDD  #VGRTSL
LECAF:  STD  VRMFL+2                ;AND RETURN VG
LECB2:  JSR  SPLASH                 ;OSCILLATE LAZAR SPLASH PICS
LECB5:  STA  VGGO                   ;START VGEN AGAIN
LECB8:  LDA  #$05
LECBA:  STA  VGTIMR

DOVG_90:
LECBC:  STA  IRCLR                  ;ALLOW NEXT IRQ
LECBF:  RTS

;------------------------------------------------------------------------------
; DEBNCE - A=NEW VAL
;   X-->RAM AREA
;------------------------------------------------------------------------------
DEBNCE:
LECC0:  LDB  ,X                     ;NW: PREVIOUS NEW
LECC2:  STB  1,X                    ;OL: -->OLD
LECC4:  STA  ,X                     ;NW: SAVE NEWEST
LECC6:  ANDA 1,X                    ;OL: SAME BITS ON
LECC8:  ORA  2,X                    ;SW:
LECCA:  STA  2,X                    ;SW: SAVE DEBOUNCED ON BITS
LECCC:  ORB  ,X++                   ;NW: SAME BITS OFF
LECCE:  ANDB ,X                     ;SW:
LECD0:  STB  ,X+                    ;SW: SAVE DEBOUNCED OFF BITS,
;(X)+: PREPARE FOR NEXT SWITCH SET
LECD2:  RTS

;------------------------------------------------------------------------------
; DOPOTS - HANDLE READING POT VALUES
;------------------------------------------------------------------------------
DOPOTS:
LECD3:  LDA  S_INTCT
LECD5:  LSRA                        ;?WHICH POT?
LECD6:  LDY  #PT_VL                 ;ASSUME POT 1
LECDA:  BCS  LECE0                  ;IFCC  NOPE, IT'S THE OTHER ONE
LECDC:  LDY  #PT_VL+PTS_IZ          ;POT 2
;POKEY FILTER
;REQUIRE 2 SAMPLES ALL HIGHER (OR LOWER)
;THAN CURRENT SAVED VALUE.
;THEN UPDATE TO CLOSEST HI (LO) VALUE
LECE0:  LDB  1,Y                    ;B:=VNEW PREVIOUS NEW BECOMES CURRENT OLD
LECE2:  LDA  R_CHN
LECE5:  STA  1,Y                    ;A:=VNEW UPDATE CURRENT NEW
LECE7:  CMPA ,Y                     ;VL
LECE9:  BLO  LECF9                  ;IFHS  ?NEW VALUE HIGHER THAN STANDARD VALUE?
LECEB:  CMPB ,Y                     ;VL
LECED:  BLS  LECF7                  ;IFHI  ?AND OLD VALUE HIGHER ALSO?
LECEF:  CMPB 1,Y                    ;VNEW
LECF1:  BLS  LECF5                  ;IFHI  ?VNEW IS CLOSER?
LECF3:  LDB  1,Y                    ;VNEW
LECF5:  STB  ,Y                     ;VL SAVE CLOSEST OF HIGHER VALUES
LECF7:  BRA  LED05                  ;ELSE  ELSE NEW VALUE IS LOWER THAN STANDARD VALUE
LECF9:  CMPB ,Y                     ;VL
LECFB:  BHS  LED05                  ;IFLO  ?OLD VALUE ALSO LOWER?
LECFD:  CMPB 1,Y                    ;VNEW
LECFF:  BHS  LED03                  ;IFLO  ?VNEW IS CLOSER?
LED01:  LDB  1,Y                    ;VNEW
LED03:  STB  ,Y                     ;VL SAVE CLOSEST OF LOWER VALUES
LED05:  CMPY #PT_VL                 ;START NEXT A-D CONVERSION
LED09:  BNE  LED13                  ;IFEQ
LED0B:  STA  W_CHN0                 ;SELECT CHANNEL 0
LED0E:  STA  W_CHN0                 ;START GOOD CONVERSION
LED11:  BRA  LED19                  ;ELSE
LED13:  STA  W_CHN1                 ;SELECT CHANNEL 1
LED16:  STA  W_CHN1                 ;AND START IT CLEANLY
LED19:  RTS

;------------------------------------------------------------------------------
; RHCTRL - IRQ VG HANDLES CONTROLS
;------------------------------------------------------------------------------
RHCTRL:
LED1A:  LDX  #RHEOP                 ;DO PITCH POT
LED1D:  LDA  PT_VL2                 ;UP/DOWN VG Y
LED1F:  NOP
LED20:  JSR  RHLIM                  ;LIMIT AND SCALE RHESTAT
LED23:  LDA  RHS_NML,X              ;NOW LIMIT THE POT BY THE VG SCREEN
LED25:  CMPA #VGCURT                ;HI LIMIT - CURSOR SIZE, SCALED TO +-128
LED27:  BLE  LED2B                  ;IFGT
LED29:  LDA  #VGCURT
LED2B:  CMPA #VGCURB&$FF            ;TOP CURSOR POSITION, SCALED DOWN +-512 TO +-128
LED2D:  BGE  LED31                  ;IFLT
LED2F:  LDA  #VGCURB&$FF
LED31:  STA  RHS_NML,X
LED33:  JSR  RHPOS
LED36:  LDX  #RHEOY                 ;DO YAW POT
LED39:  LDA  PT_VL1                 ;LEFT/RIGHT VG X
LED3B:  NOP
LED3C:  JSR  RHLIM                  ;LIMIT AND SCALE RHESTAT
LED3F:  LDA  RHS_NML,X              ;NOW LIMIT TO CURSOR SCREEN SIZE
LED41:  CMPA #VGCURR
LED43:  BLE  LED47                  ;IFGT
LED45:  LDA  #VGCURR
LED47:  CMPA #VGCURL&$FF
LED49:  BGE  LED4D                  ;IFLT
LED4B:  LDA  #VGCURL&$FF
LED4D:  STA  RHS_NML,X
LED4F:  JSR  RHPOS
LED52:  RTS

;------------------------------------------------------------------------------
; RHLIM - ---LIMIT AND SCALE
;------------------------------------------------------------------------------
RHLIM:
LED53:  CMPA ,X                     ;A=RHEOSTAT VALUE
;X==>RAM BLOCK
;Y==>DATA TABLE
LED55:  BHS  LED5D                  ;IFLO  ?LESS THAN LO?
LED57:  CMPA RHS_LT,X
LED59:  BLO  LED5D                  ;IFHS  ?HIGHER THAN TRIAL LO?
LED5B:  DEC  ,X                     ;APPROACH NEW DEGLITCHED LO
LED5D:  STA  RHS_LT,X               ;SAVE OUR NEW TRIAL LO
LED5F:  CMPA ,X                     ;?LESS THAN LOWER LIMIT?
LED61:  BHS  LED65                  ;IFLO
LED63:  LDA  ,X                     ;THEN REPLACE WITH LOWER LIMIT
LED65:  SUBA ,X                     ;BASE AT ZERO
LED67:  STA  RH_DIR                 ;TEMP STORAGE OF POT BASED VALUE
LED69:  LDB  RHS_SP,X               ;SPREAD THE VALUES-SCAL
LED6B:  MUL
LED6C:  ADDA RH_DIR                 ;MULTS BY 1XX SO VALUE GOES ABOVE 7F
LED6E:  BNE  LED72                  ;IFEQ  ?UNDERFLOW?
LED70:  LDA  #$01                   ;RANGE IS -7F TO 7F (ALLOWS PROPER NEGATE)
LED72:  BCS  LED78                  ;IFCC  ?OVERFLOW?
LED74:  CLR  RHS_ST,X               ;PREPARE TIMER FOR NEXT TOO-HIGH POT VALUE
LED76:  BRA  LED84                  ;ELSE
LED78:  LDA  #$FF                   ;THEN LIMIT VALUE
LED7A:  INC  RHS_ST,X               ;TIME THESE EXCESSES
LED7C:  LDB  RHS_ST,X
LED7E:  CMPB #$02
LED80:  BLO  LED84                  ;IFHS  ?TOO LARGE FOR TOO LONG?
LED82:  DEC  RHS_SP,X               ;THEN DECREASE SPREAD
LED84:  CLRB
LED85:  SUBA #$80                   ;CHANGE TO SIGNED VALUE
LED87:  STA  RHS_NML,X
LED89:  RTS

;------------------------------------------------------------------------------
; RHPOS - CONVERT NML VALUE TO SCREEN POSITION
;   SLEWED POSITIONAL
;------------------------------------------------------------------------------
RHPOS:
LED8A:  CLR  RH_DIR                 ;START WITH POSITIVE DIRECTION TO TRAVEL
LED8C:  LDA  RHS_NML,X              ;CURRENT -7F TO 7F POT
LED8E:  LDB  #$80                   ;HALF WAY INTO POTS STAMP
LED90:  SUBD RHS_POS,X              ;CURRENT SCREEN POSITION
LED92:  BGE  LED97                  ;IFLT  ?WANT TO GO IN NEGATIVE DIRECTION?
LED94:  NEGA                        ;THEN CHANGE DELTA TO POSITIVE 8-BIT
LED95:  DEC  RH_DIR                 ;AND SAVE NEGATIVE INDICATOR
LED97:  BLE  LED9C                  ;IFGT  ?SLIGHTLY POSITIVE?
LED99:  ADDD #$00FF                 ;TRUNCATE UPWARD -- ALWAYS SLEW SOME
LED9C:  CMPA #$F8
LED9E:  BLS  LEDA2                  ;IFHI
LEDA0:  LDA  #$F8                   ;PREVENT OVERFLOWS DURING LATER TRUNCATIONS
LEDA2:  LDB  #$60                   ;HOW QUICKLY TO SKEW TO DESIRED LOCATION
LEDA4:  CMPA #$40                   ;ONE-QUARTER SCREEN
LEDA6:  BHS  LEDAA                  ;IFLO  ?CLOSE ENUF?
LEDA8:  LDB  #$30                   ;SLOWER WHEN CLOSER
LEDAA:  MUL
LEDAB:  TST  RH_DIR                 ;RESTORE ORIGINAL DIRECTION
LEDAD:  BPL  LEDB3                  ;IFMI
LEDAF:  COMA                        ;NEGD
LEDB0:  NEGB
LEDB1:  SBCA #$FF
LEDB3:  ADDD RHS_POS,X              ;NOW UPDATE OUR CURSOR POSITION
LEDB5:  STD  RHS_POS,X              ;RH$POS IS EQUATED TO VG.RSX,VG.RSY
LEDB7:  RTS

;------------------------------------------------------------------------------
; GNSITE - IRQ,VG GENERATE SITE COORDS ON SCREEN
;------------------------------------------------------------------------------
GNSITE:
LEDB8:  LDB  VG_RSY
LEDBA:  LDA  VG_RSY+1               ;REVERSE LDD
LEDBC:  ANDA #$C0                   ;ONLY NEED TOP TWO BITS
LEDBE:  LSLA                        ;SHIFT UP LO VALUES
LEDBF:  ROLB                        ;FROM +-128 TO +-256
LEDC0:  BCC  LEDC4                  ;IFCS  ?NEGATIVE?
LEDC2:  ORA  #$3F                   ;AFTER TWO SHIFTS IS SEX'D
LEDC4:  ROLA
LEDC5:  ROLB                        ;UP TO +-512
LEDC6:  ROLA                        ;NOW OF FORM 1FFF, VECTOR OPCODE
LEDC7:  STD  VG_CY                  ;CURRENT SITE Y POS
LEDC9:  ADDD #VGOFFY                ;OFFSET TO CENTER
LEDCC:  ANDA #$1F                   ;VECTOR OPCODE
LEDCE:  STD  VRSITE+0
;---YAW CURSOR IN X POSITION
LEDD1:  LDB  VG_RSX
LEDD3:  LDA  VG_RSX+1               ;REVERSE LDD
LEDD5:  ANDA #$C0                   ;ONLY SHIFT IN TOP TWO BITS
LEDD7:  LSLA                        ;SHIFT UP LO VALUES
LEDD8:  ROLB                        ;FROM +-128 TO +-256
LEDD9:  BCC  LEDDD                  ;IFCS  ?NEGATIVE?
LEDDB:  ORA  #$3F                   ;BECOMES SEX'D AFTER TWO SHIFTS
LEDDD:  ROLA
LEDDE:  ROLB                        ;UP TO +-512
LEDDF:  ROLA
LEDE0:  STD  VG_CX                  ;CURRENT SITE LEFT/RIGHT
LEDE2:  ANDA #$1F                   ;KEEP BRITENESS ZERO
LEDE4:  STD  VRSITE+2
LEDE7:  LDD  #$C000                 ;RTSL
LEDEA:  STD  VRSITE+4
LEDED:  RTS

;------------------------------------------------------------------------------
; RESET - RESET
;------------------------------------------------------------------------------
RESET:
LEDEE:  ORCC #$10                   ;SEI  DISABLE INTERRUPTS UNTIL MAINLINE INIT
LEDF0:  CLR  W_BANK                 ;SELECT NORMAL ROOT ROM
LEDF3:  LDA  #$00                   ;TURN ON DIAG LEDS FOR TESTING
LEDF5:  STA  W_LED1
LEDF8:  STA  W_LED2
LEDFB:  STA  W_LED3
LEDFE:  LDA  #$00
LEE00:  STA  P_IRND                 ;INIT RANDOM # SEQUENCE
LEE03:  LDA  #$80                   ;GET IT GOING BEFORE TEST/DIAGNOSTICS
LEE05:  STA  P_IRND                 ;THEN START UP THE RANDOM # GENERATOR
LEE08:  STA  VGSTOP                 ;GATE ARRAY ONLY LISTENS TO STOP, NOT RESET LINE
LEE0B:  LDU  #$0000                 ;JUST SIT HERE AND SPIN FOR AWHILE TO LET THE NOVRAM COME TO LIFE
LEE0E:  STA  WTCHDG                 ;GOT TO KEEP IT HAPPY
LEE11:  LEAU -$1,U
LEE13:  CMPU #$0000                 ;NOT NEEDED BUT IT MAKES THE LOOP A LITTLE LONGER
LEE17:  BNE  LEE0E                  ;EQEND
LEE19:  LDS  #STACK                 ;SYSTEM STACK
LEE1D:  LDA  #DPRAM/$100            ;INIT DPAGE POINTER
LEE1F:  TFR  A,DP
LEE21:  STA  W_RSTS                 ;HARDWARE RESET SOUND BOARD
LEE24:  LDA  #$00
LEE26:  STA  W_XMTS                 ;ALSO TRY SOFTWARE RESET
LEE29:  LDX  #RAM                   ;CLEAR RAM
LEE2C:  LDD  #$0000
LEE2F:  STD  ,X++
LEE31:  CMPX #RAMZ
LEE34:  BLO  LEE2F                  ;HSEND
;---AFTER 2K FAST LOOP
LEE36:  STA  WTCHDG
LEE39:  LDX  #M_BASE                ;CLEAR MATH RAM
LEE3C:  LDD  #$0000
LEE3F:  STD  ,X++
LEE41:  STA  WTCHDG                 ;KEEP THE DOG HAPPY
LEE44:  CMPX #M_FIN
LEE47:  BLO  LEE3F                  ;HSEND
LEE49:  LDX  #VGRAM                 ;CLEAR VECTOR RAM
LEE4C:  LDD  #$0000
LEE4F:  STD  ,X++
;---MORE THAN 2K, SO DO ALL THE TIME
LEE51:  STA  WTCHDG                 ;KEEP THE DOG HAPPY
;;; .IF NE,DEVSYS
;;; CMPX #VGROM ;DON'T DESTROY DOWNLOADED VG PSUEDO ROM STUFF
;;; .IFF
LEE54:  CMPX #VGRROM                ;CLEAR ALL THE WAY TO REAL ROM
;;; .ENDC
LEE57:  BLO  LEE4F                  ;HSEND
;WITH ALL OF MEMORY EMPTY, PREPARED FOR TEST
LEE59:  LDA  TESTSW
LEE5C:  ANDA #TESTBT                ;SELF-TEST?
LEE5E:  BNE  LEE63                  ;IFEQ  YES
LEE60:  JMP  TEST
;NOT SELF TEST ******************************************************************
;SETUP FOR THE FIRST DEBOUNCE OF THE OPTION SWITCHES
LEE63:  LDA  R_BYT2                 ;GET FIRST SET OF DATA
LEE66:  LDB  R_BYT3
LEE69:  STA  R_OPT2                 ;SAVE THE DATA
LEE6B:  STB  R_OPT1
LEE6D:  LDX  #$0800                 ;WAIT A WHILE
LEE70:  LEAX -$1,X
LEE72:  BNE  LEE70                  ;EQEND
LEE74:  LDA  R_BYT2                 ;SECOND READING FOR DEBOUNCING THE OPTION SWITCHES
LEE77:  LDB  R_BYT3
LEE7A:  CMPA R_OPT2
LEE7C:  BNE  LEE69                  ;EQEND  NOT THE SAME, GO BACK AND TRY AGAIN
LEE7E:  CMPB R_OPT1
LEE80:  BNE  LEE69                  ;EQEND  NOT THE SAME, TRY AGAIN
;SETUP VG WITH ALL HALT INSTRUCTIONS ( JUST IN CASE ... )
LEE82:  LDD  #$2020                 ;HALT VG
LEE85:  LDX  #VGRAM
LEE88:  STD  ,X++
;---MORE THAN 2K FAST LOOP, SO DO ALL THE TIME
LEE8A:  STA  WTCHDG                 ;KEEP THE DOG HAPPY
LEE8D:  CMPX #VGROM
LEE90:  BLO  LEE88                  ;HSEND
LEE92:  LDD  #$E01D                 ;JUMP TO DOUBLE BUFFER
LEE95:  STD  VGRAM
LEE98:  LDA  #$FF                   ;SWITCH BUFFERS IMMEDIATELY
LEE9A:  STA  VGSYNC
LEE9C:  LDA  #$3F                   ;TRAP OUT FIRST BYTE RAM
LEE9E:  STA  S_GARBG
LEEA0:  LDA  #$40                   ;POSITIVE VALUE FOR DELAY
LEEA2:  STA  PT_DLY                 ;DELAY RHEOSTATS UNTIL FILTER IS STABLE
LEEA4:  JSR  L6144
LEEA7:  STA  WTCHDG                 ;FINAL SHADDUP
LEEAA:  JSR  SLAP_ARM               ;arms the slapstic
LEEAD:  LDA  #$FF                   ;TURN OFF DIAG LEDS FOR MAINLINE
LEEAF:  STA  W_LED1
LEEB2:  STA  W_LED2
LEEB5:  STA  W_LED3
LEEB8:  STA  IRCLR                  ;ENABLE HARDWARE INTS (BUT STILL DISABLED BY SOFTWARE)
LEEBB:  JMP  L6229

;.SBTTL TEST ROUTINES
TRAMP:          ;TABLE OF POINTERS FOR RAM TEST (ERROR BIT PATTERN)
LEEBE:  .word RAM                   ;PROCESSOR RAM 0001

MRAM0:
LEEC0:  .word MBRAM+0               ;MATH BOX RAM (EVEN ADDRESSES) 0002

MRAM1:
LEEC2:  .word MBRAM+1               ;MATH BOX RAM ( ODD ADDRESSES) 0004
LEEC4:  .word VGRAM+0               ;VECTOR GENERATOR RAM 0008
LEEC6:  .word VGRAM+$800            ;" " " 0010
LEEC8:  .word VGRAM+$1000           ;" " " 0020
LEECA:  .word VGRAM+$1800           ;" " " 0040
LEECC:  .word VGRAM+$2000           ;" " " 0080
LEECE:  .word VGRAM+$2800           ;" " " 0100

TRAMPZ:
LEED0:  .word NVRAM+0               ;NON-VOLATILE RAM 0200

TROMP:          ;TABLE OF POINTERS FOR ROM TEST
LEED2:  .word PROG+0                ;PROGRAM ROMS 0400
LEED4:  .word PROG+$4000            ;" " 1000
LEED6:  .word PROG+$6000            ;" " 2000
LEED8:  .word PROG+$8000            ;" " 4000

trom_slapstic:
LEEDA:  .word SLAP_ARM              ;TROMP continued: the slapstic ROM at $8000, summed over its four pages (error bit $4000)

trom_vector:
LEEDC:  .word L3000                 ;the vector ROM at $3000 (error bit $8000)

BITS:
LEEDE:  .word $0001, $0002, $0004, $0008 ;BIT PATTERNS
LEEE6:  .word $0010, $0020, $0040, $0080
LEEEE:  .word $0100, $0200, $0400, $0800
LEEF6:  .word $1000, $2000, $4000, $8000

slap_select_tab:
LEEFE:  .word SLAP_PAGE0            ;the four slapstic page-select addresses, read through by the ROM test to select each page
LEF00:  .word SLAP_PAGE1
LEF02:  .word SLAP_PAGE2
LEF04:  .word SLAP_PAGE3

;------------------------------------------------------------------------------
; TEST - TEST
;------------------------------------------------------------------------------
TEST:
LEF06:  LDA  DIAGSW
LEF09:  ANDA #DIAGBT                ;DIAGNOSTIC SWITCH?
LEF0B:  BNE  RAMTST                 ;IFEQ  YES, ITS ON
LEF0D:  LDA  R_BYT2                 ;CHECK FOR DIAGNOSTIC 1 OR 2
LEF10:  COMA
LEF11:  ANDA #$7F                   ;DIAG 1 = 00; DIAG 2 = 80
LEF13:  BEQ  RAMTST                 ;IFNE  NOT DIAG 1 OR 2, THEN SKIP RAM/ROM TEST
LEF15:  JMP  DIAGLP                 ;GO EXECUTE DIAGNOSTICS, NOW WITHOUT DELAY

;------------------------------------------------------------------------------
; RAMTST - ELSE PERFORM RAM/ROM TEST FOR SELF-TEST AND/OR DIAGNOSTICS 1&2
;   PERFORM A RUNNING 1 AND 0 TEST ON ALL RAMS. THE MAJORITY OF RAMS ARE OF TYPE 4016 ( 2K*8 )
;   EXCEPT FOR THE NON-VOLATILE RAM WHICH IS 100*4.
;   THIS TEST ASSUMES THAT ALL RAM HAS BEEN CLEARED BEFORE GETTING HERE.
;------------------------------------------------------------------------------
RAMTST:
LEF18:  LDS  #$0000                 ;USE S TO FLAG ERRORS
LEF1C:  LDU  #TRAMP                 ;TABLE OF RAM POINTERS
LEF1F:  LDX  ,U++                   ;BLOCK POINTER
LEF21:  LDY  #$0800                 ;BLOCK SIZE ( 2K*8 )
LEF25:  LDA  ,X                     ;START WITH NEXT BYTE
LEF27:  BEQ  LEF35                  ;IFNE  ERROR---SHOULD BE ZERO
LEF29:  TFR  S,D                    ;ERR
LEF2B:  ORA  BITS-TRAMP-2,U
LEF2E:  ORB  BITS-TRAMP-1,U
LEF31:  TFR  D,S
LEF33:  BRA  RAMTST_100
LEF35:  LDA  #$80                   ;FLOATING ONE TEST
LEF37:  LSLA                        ;SETUP CARRY TOO(1,000)

RAMTST_30:
LEF38:  ROLA                        ;FORM NEXT TEST
LEF39:  STA  ,X
LEF3B:  TFR  A,B
LEF3D:  EORB ,X
LEF3F:  BEQ  LEF4D                  ;IFNE  ERROR---SHOULD HAVE MATCHED
LEF41:  TFR  S,D                    ;ERR
LEF43:  ORA  BITS-TRAMP-2,U
LEF46:  ORB  BITS-TRAMP-1,U
LEF49:  TFR  D,S
LEF4B:  BRA  RAMTST_100
LEF4D:  BCC  RAMTST_50              ;?END OF FLOATING ONE?(=1,000)
LEF4F:  TSTA
LEF50:  BNE  RAMTST_30              ;B NOPE, WAS FLOATING ZERO
LEF52:  ADDA #$FF                   ;YEP, PREPARE FOR FLOATING ZERO
LEF54:  BRA  RAMTST_30              ;J (1,000),ADDA#0FF,(0,0FF),ROLA,(1,0FE)

RAMTST_50:
LEF56:  TFR  A,B
LEF58:  INCB                        ;?END OF FLOATING ZERO?(=0,0FF)
LEF59:  BNE  RAMTST_30              ;B NOT YET
LEF5B:  STA  WTCHDG                 ;KEEP THE DOG QUIET
;INCREMENT X TO NEXT BYTE
LEF5E:  CMPU #MRAM0+2               ;MATH RAM?? ( SPECIAL CASE FOR MATH RAM )
LEF62:  BEQ  RAMTST_80
LEF64:  CMPU #MRAM1+2
LEF68:  BNE  LEF6E                  ;IFEQ  YES, MATH RAM

RAMTST_80:
LEF6A:  LEAX 2,X                    ;THEN DO EVERY OTHER BYTE
LEF6C:  BRA  LEF70                  ;ELSE
LEF6E:  LEAX 1,X                    ;DO EVERY BYTE
LEF70:  LEAY -$1,Y                  ;DECREMENT BLOCK LENGTH COUNT, DONE?
LEF72:  BNE  LEF25                  ;EQEND

RAMTST_100:
LEF74:  CMPU #TRAMPZ                ;END OF TABLE?
LEF78:  BLO  LEF1F                  ;HSEND

;PREVIOUS TESTING LEFT ALL DATA AT 0FF
FINCLR:          ;PERFORM A FINAL CLEAR OF ALL RAMS
LEF7A:  LDU  #TRAMP
LEF7D:  LDX  ,U++
LEF7F:  LDY  #$0800                 ;BLOCK SIZE COUNTER
LEF83:  INC  ,X                     ;SHOULD INC FROM 0FF TO 00
LEF85:  BEQ  LEF93                  ;IFNE  WASN'T 0FF --- ERROR
LEF87:  TFR  S,D                    ;ERR
LEF89:  ORA  BITS-TRAMP-2,U
LEF8C:  ORB  BITS-TRAMP-1,U
LEF8F:  TFR  D,S
LEF91:  BRA  FINCLR_100
LEF93:  LDA  ,X                     ;INC SHOULD HAVE LEFT A 00
LEF95:  BEQ  LEFA3                  ;IFNE  WASN'T 00 --- ERROR
LEF97:  TFR  S,D                    ;ERR
LEF99:  ORA  BITS-TRAMP-2,U
LEF9C:  ORB  BITS-TRAMP-1,U
LEF9F:  TFR  D,S
LEFA1:  BRA  FINCLR_100
LEFA3:  STA  WTCHDG                 ;MUZZLE THE DOG
;INCREMENT X TO NEXT BYTE
LEFA6:  CMPU #MRAM0+2               ;MATH RAM?? ( SPECIAL CASE FOR MATH RAM )
LEFAA:  BEQ  FINCLR_80
LEFAC:  CMPU #MRAM1+2
LEFB0:  BNE  LEFB6                  ;IFEQ  YES, MATH RAM

FINCLR_80:
LEFB2:  LEAX 2,X                    ;THEN DO EVERY OTHER BYTE
LEFB4:  BRA  LEFB8                  ;ELSE
LEFB6:  LEAX 1,X                    ;DO EVERY BYTE
LEFB8:  LEAY -$1,Y                  ;DECREMENT BLOCK LENGTH COUNT, DONE?
LEFBA:  BNE  LEF83                  ;EQEND

FINCLR_100:
LEFBC:  CMPU #TRAMPZ                ;END OF TABLE?
LEFC0:  BLO  LEF7D                  ;HSEND
;NON-VOLATILE RAM TEST
LEFC2:  TFR  S,D                    ;IS PROGRAM RAM OK?
LEFC4:  ANDB #$01
LEFC6:  BNE  LEFD7                  ;IFEQ  YES, USE IT FOR EEBUFF
LEFC8:  LDX  #NVRAM
LEFCB:  LDU  #EEROM
LEFCE:  LDD  ,X++
LEFD0:  STD  ,U++
LEFD2:  CMPX #NVRAMZ
LEFD5:  BLO  LEFCE                  ;HSEND
LEFD7:  LDU  #TRAMPZ+2              ;POINTER FOR ERROR BITS

NVRTST:
LEFDA:  LDX  #NVRAM                 ;CLEAR IT FIRST
LEFDD:  LDD  #$0000
LEFE0:  STD  ,X++
LEFE2:  CMPX #NVRAMZ
LEFE5:  BLO  LEFE0                  ;HSEND
LEFE7:  LDX  #NVRAM
LEFEA:  LDA  ,X
LEFEC:  ANDA #$0F                   ;LOW NIBBLE ONLY
LEFEE:  BEQ  LEFFC                  ;IFNE
LEFF0:  TFR  S,D                    ;ERR
LEFF2:  ORA  BITS-TRAMP-2,U
LEFF5:  ORB  BITS-TRAMP-1,U
LEFF8:  TFR  D,S
LEFFA:  BRA  NVRTST_100
LEFFC:  LDA  #$80
LEFFE:  LSLA                        ;SET PATTERN (1,00)
LEFFF:  LDY  #$0004                 ;SET COUNT

NVRTST_30:
LF003:  ROLA
LF004:  STA  ,X
LF006:  TFR  A,B
LF008:  EORB ,X
LF00A:  ANDB #$0F
LF00C:  BEQ  LF01A                  ;IFNE  SHOULD HAVE MATCHED
LF00E:  TFR  S,D                    ;ERR
LF010:  ORA  BITS-TRAMP-2,U
LF013:  ORB  BITS-TRAMP-1,U
LF016:  TFR  D,S
LF018:  BRA  NVRTST_100
LF01A:  LEAY -$1,Y                  ;DONE WITH THIS PASS?
LF01C:  BNE  NVRTST_30              ;NO, CONTINUE
LF01E:  TSTA                        ;YES, WHAT PHASE
LF01F:  BMI  LF029                  ;IFPL  WAS RUNNING 1, MAKE IT RUNNING 0
LF021:  LDA  #$FF                   ;C SHOULD BE CLEAR STILL
LF023:  LDY  #$0005                 ;COUNT OF 5 WILL LEAVE NIBBLE AS F
LF027:  BRA  NVRTST_30
LF029:  STA  WTCHDG
LF02C:  LEAX 1,X                    ;NEXT BYTE
LF02E:  CMPX #NVRAMZ                ;DONE?
LF031:  BLO  LEFEA                  ;HSEND
;OK CHECK USING A FINAL CLEAR
LF033:  LDX  #NVRAM
LF036:  INC  ,X                     ;WAS LEFT AS xF, NOW SHOULD BE x0
LF038:  LDA  ,X+
LF03A:  ANDA #$0F                   ;LOW NIBBLE ONLY
LF03C:  BEQ  LF04A                  ;IFNE  WRONG
LF03E:  TFR  S,D                    ;ERR
LF040:  ORA  BITS-TRAMP-2,U
LF043:  ORB  BITS-TRAMP-1,U
LF046:  TFR  D,S
LF048:  BRA  NVRTST_100
LF04A:  CMPX #NVRAMZ                ;DONE?
LF04D:  BLO  LF036                  ;HSEND

NVRTST_100:
LF04F:  TFR  S,D
LF051:  ANDB #$01
LF053:  BNE  LF067                  ;IFEQ  PROGRAM RAM ( EEBUF ) OK
LF055:  LDX  #EEROM                 ;COPY DATA BACK TO NVRAM
LF058:  LDU  #NVRAM
LF05B:  LDD  ,X++
LF05D:  STD  ,U++
LF05F:  CMPU #VGGO
LF063:  BLO  LF05B                  ;HSEND
LF065:  BRA  LF085                  ;ELSE  NO EEBUF
LF067:  LDA  #$FF                   ;PERFORM A RECALL OF THE NON-VOLATILE MEMORY
LF069:  STA  NVRRCL
LF06C:  LDX  #$0100                 ;WAIT FOR THE CAP TO DISCHARGE
LF06F:  STA  WTCHDG
LF072:  LEAX -$1,X
LF074:  BNE  LF06F                  ;EQEND
LF076:  LDA  #$00                   ;TURN OFF RECALL LINE
LF078:  STA  NVRRCL
LF07B:  LDX  #$A000                 ;NOW WAIT FOR THE CAP TO CHARGE BACK UP
LF07E:  STA  WTCHDG
LF081:  LEAX -$1,X
LF083:  BNE  LF07E                  ;EQEND
LF085:  STA  WTCHDG                 ;KEEP THE DOG HAPPY
LF088:  LDU  #TROMP
LF08B:  JMP  rom_sum_2banks         ;sum both halves of this 16K ROM, comes back to the next line
LF08E:  ADDD #$0001                 ;a good ROM sums to $FFFF: stored value 0
LF091:  STD  CHKSUM-TROMP-2,U
LF095:  BEQ  LF09E                  ;IFNE  ERROR
LF097:  TFR  S,D
LF099:  ORA  BITS-TRAMP-2,U
LF09C:  TFR  D,S
LF09E:  CMPU #trom_slapstic         ;four program ROMs: $6000, $A000, $C000, $E000
LF0A2:  BLO  LF08B                  ;HSEND
LF0A4:  LDU  #slap_select_tab       ;slapstic ROM: one pass per page select address
LF0A7:  LDD  #$8000                 ;seed, kept across the four pages
LF0AA:  TST  SLAP_ARM               ;arm the slapstic
LF0AD:  ANDCC #$FE
LF0AF:  TST  [,U]                   ;touch the page select: this page is now at $8000-$9FFF
LF0B1:  LDX  #SLAP_ARM
LF0B4:  ADDD ,X++                   ;first word of the page - reading $8000 arms the slapstic again
LF0B6:  ADCB #$00
LF0B8:  ADCA #$00
LF0BA:  TST  [,U++]                 ;so touch the same page select once more
LF0BC:  ADDD ,X++
LF0BE:  ADCB #$00
LF0C0:  ADCA #$00
LF0C2:  STA  WTCHDG
LF0C5:  CMPX #LA000                 ;to the end of the page
LF0C8:  BCS  LF0BC
LF0CA:  CMPU #TEST                  ;end of slap_select_tab
LF0CE:  BCS  LF0AA
LF0D0:  LDU  #trom_vector
LF0D3:  ADDD #$0001
LF0D6:  STD  $5A08,U                ;CHKSUM+8: the slapstic's word
LF0DA:  BEQ  LF0E3
LF0DC:  TFR  S,D
LF0DE:  ORA  $1E,U                  ;error bit $4000
LF0E1:  TFR  D,S
LF0E3:  LDA  SLAP_ARM               ;arm the slapstic and select page 0 again
LF0E6:  LDA  SLAP_PAGE0             ;slapstic: EN -> DIS
LF0E9:  LDX  ,U++                   ;the vector ROM
LF0EB:  LDY  #$1000                 ;4K
LF0EF:  TFR  X,D                    ;address as seed
LF0F1:  ANDCC #$FE
LF0F3:  ADDD ,X++
LF0F5:  ADCB #$00
LF0F7:  ADCA #$00
LF0F9:  STA  WTCHDG
LF0FC:  LEAY -2,Y
LF0FE:  BNE  LF0F3
LF100:  ADDD #$0001
LF103:  STD  CHKSUM-TROMP-2,U
LF107:  BEQ  LF110                  ;IFNE  ERROR
LF109:  TFR  S,D
LF10B:  ORA  BITS-TRAMP-2,U
LF10E:  TFR  D,S
LF110:  LDA  #$FF                   ;TURN OFF THE LEDS
LF112:  STA  W_LED1
LF115:  STA  W_LED2
LF118:  STA  W_LED3
LF11B:  CLR  SIGFLG
LF11D:  LDA  DIAGSW                 ;CHECK FOR DIAGNOSTIC SWITCH
LF120:  ANDA #DIAGBT
LF122:  BNE  LF127                  ;IFEQ  ITS ON, DO DIAGNOSTICS
LF124:  JMP  DIAGLP
LF127:  STA  WTCHDG                 ;HIT THE DOG
LF12A:  LDX  #CHKSUM                ;negate the six stored checksum words for the display
LF12D:  LDD  ,X
LF12F:  COMA
LF130:  NEGB
LF131:  SBCA #$FF
LF133:  STD  ,X++
LF135:  CMPX #$48E8                 ;end of CHKSUM
LF138:  BCS  LF12D

;.SBTTL DISPLAY THE RESULTS
TSTOUT:
LF13A:  STS  ERRORS                 ;SAVE ERRORS FOR LATER
LF13D:  TFR  S,D
LF13F:  ANDB #$01                   ;PROGRAM RAM OK? ( VARIABLES AND STACK )
LF141:  LBNE LF1EA
;YES, THEN ATTEMP TO USE VG FOR ERROR DISPLAY
;SETUP FOR DISPLAY
LF145:  LDY  #VGRAM                 ;VG POINTER
LF149:  LDD  #VGCOLR&$FF00          ;COLOR OFF
LF14C:  STD  ,Y++
LF14E:  LDD  #VJBONDRY              ;DRAW A BOX TO FOOL THE BEAM KILLER
LF151:  STD  ,Y++
LF153:  LDD  #VGCNTR
LF156:  STD  ,Y++
LF158:  LDA  #$48                   ;SET DPAGE REGISTER
LF15A:  TFR  A,DP
LF15C:  STS  TTEMP                  ;SAVE ERRORS IN RAM
LF15F:  LDS  #STACK                 ;SET STACK
LF163:  LDB  #$D5                   ;"PRESS AUX SWITCH TO CONTINUE"
LF165:  JSR  do_message
LF168:  LDB  #$A4
LF16A:  JSR  do_message
LF16D:  LDB  #MS_RAM+2              ;START WITH ERROR MESSAGES
LF16F:  STB  TTEMP2
LF171:  LDD  TTEMP                  ;ERRORS?
LF173:  BNE  LF1B0                  ;IFEQ  NO ERRORS
LF175:  LDB  #MS_RAM+1              ;"NO ERRORS DETECTED"
LF177:  JSR  do_message
LF17A:  LDD  #$1F9C
LF17D:  STD  ,Y++
LF17F:  LDD  #$0030
LF182:  STD  ,Y++
LF184:  LDA  L7DD0                  ;signature: one word from each of the six ROMs ($7DD0, slapstic $9941, $A000, $C7F1, $FFB3, vector ROM $3000) exclusive-ored together and shown as four hex digits after NO ERRORS DETECTED
LF187:  EORA $9941
LF18A:  EORA LA000
LF18D:  EORA LC7F1
LF190:  EORA LFFB3
LF193:  EORA L3000
LF196:  JSR  VWBYTE
LF199:  LDA  L7DD1
LF19C:  EORA $9942
LF19F:  EORA LA001
LF1A2:  EORA LC7F2
LF1A5:  EORA LFFB4
LF1A8:  EORA L3000+1
LF1AB:  JSR  VWBYTE
LF1AE:  BRA  LF1E8                  ;ELSE  YES, THERE ARE ERRORS
LF1B0:  LSRA                        ;LSRD  SHIFT IT
LF1B1:  RORB
LF1B2:  STD  TTEMP                  ;STORE IT BACK
LF1B4:  BCC  LF1E2                  ;IFCS  HAD AN ERROR THERE
LF1B6:  LDB  TTEMP2                 ;MESSAGE NUMBER FOR THIS ERROR
LF1B8:  JSR  do_message
LF1BB:  LDB  TTEMP2
LF1BD:  SUBB #MS_RAM+12             ;ROM ERROR MESSAGES?
LF1BF:  BLO  LF1E2                  ;IFHS  YES, THEN OUTPUT THE CHECKSUM
LF1C1:  ASLB
LF1C2:  LDX  #TSUMY                 ;POSITION TO THE RIGHT OF THE MESSAGE
LF1C5:  ABX
LF1C6:  LDU  ,X
LF1C8:  STU  ,Y++
LF1CA:  LDU  #$0120
LF1CD:  STU  ,Y++
LF1CF:  LDX  #CHKSUM                ;GET THE DATA
LF1D2:  ABX
LF1D3:  LDA  ,X
LF1D5:  JSR  VWBYTE
LF1D8:  LDA  1,X
LF1DA:  JSR  VWBYTE
LF1DD:  LDD  #VGCNTR
LF1E0:  STD  ,Y++
LF1E2:  INC  TTEMP2                 ;NEXT MESSAGE NUMBER
LF1E4:  LDD  TTEMP                  ;DONE WHEN NO ERRORS LEFT TO DISPLAY
LF1E6:  BNE  LF1B0                  ;EQEND
LF1E8:  BRA  TSTOUT_100             ;LEAVE
;NOTHING WORKS, TRY TO MAKE ERROR TONES
LF1EA:  LDX  #$0008
LF1ED:  TFR  S,D
LF1EF:  LSRB
LF1F0:  BCC  LF1F6                  ;IFCS  ERROR ON
LF1F2:  LDA  #IDANAY                ;ERROR SOUND
LF1F4:  BRA  LF1F8                  ;ELSE
LF1F6:  LDA  #IDAYEA                ;NON-ERROR SOUND
LF1F8:  STA  W_XMTS
LF1FB:  LDU  #$0000                 ;1/2 SECOND DELAY
LF1FE:  STB  WTCHDG
LF201:  LEAU 1,U
LF203:  CMPU #$A000
LF207:  BLO  LF1FE                  ;HSEND
LF209:  LEAX -$1,X
LF20B:  BNE  LF1EF                  ;EQEND
;NOW THE OTHER HALF OF THE ERRORS
LF20D:  LDX  #$0008
LF210:  TFR  S,D
LF212:  LSRA
LF213:  BCC  LF219                  ;IFCS  ERROR ON
LF215:  LDB  #IDANAY                ;ERROR SOUND
LF217:  BRA  LF21B                  ;ELSE
LF219:  LDB  #IDAYEA                ;NON-ERROR SOUND
LF21B:  STB  W_XMTS
LF21E:  LDU  #$0000                 ;1/2 SECOND DELAY
LF221:  STA  WTCHDG
LF224:  LEAU 1,U
LF226:  CMPU #$A000
LF22A:  BLO  LF221                  ;HSEND
LF22C:  LEAX -$1,X
LF22E:  BNE  LF212                  ;EQEND
;DELAY, THEN REPEAT
LF230:  LDU  #$0000
LF233:  STA  WTCHDG
LF236:  LEAU 1,U
LF238:  CMPU #$FF00
LF23C:  BLO  LF233                  ;HSEND
LF23E:  BRA  LF1EA                  ;LOOP

TSTOUT_100:
LF240:  LDD  #$2020                 ;HALT
LF243:  STD  ,Y++
;.SBTTL TEST MAINLINE
LF245:  LDU  #TSTATE                ;SET UP FIRST TEST STATE
LF248:  CLR  COLOR                  ;START WITH THE FIRST COLOR IN TABLE
LF24A:  LDA  #$03                   ;INIT SWITCH DEBOUNCERS
LF24C:  STA  DBNC
LF24E:  STA  DBNC2
LF250:  STA  DBNC3
LF252:  STA  ERRCNT                 ;START NOISES QUICKLY
LF254:  STA  snd_test_tmr           ;START NOISES QUICKLY
LF256:  LDX  #BITS                  ;SET UP FOR HARDWARE ERROR DISPLAY ( FIRST STATE )
LF259:  STX  ERRPNT

TSTLP:
LF25B:  LDD  #$0001
LF25E:  LDX  #$0000
LF261:  STA  WTCHDG                 ;5 CYCLES ---- SHUT THE DOG UP
LF264:  LEAX D,X                    ;8 CYCLES
LF266:  CMPX #$0708                 ;4 CYCLES
LF269:  BLO  LF261                  ;HSEND  3 CYCLES = 20 CYCLES * 1800. /1.5MHz = 24ms
LF26B:  STA  VGSTOP                 ;STOP THE VECTOR GENERATOR, SHOULD HAVE PREVIOUSLY HALTED
LF26E:  STA  W_CHN0                 ;START X POT
LF271:  STA  W_CHN0                 ;MAKE SURE IT STARTS CORRECTLY
LF274:  LDX  #$0014
LF277:  LEAX -$1,X
LF279:  BNE  LF277                  ;EQEND
LF27B:  LDB  R_CHN
LF27E:  STB  WV_LP
LF280:  STA  W_CHN1                 ;START X POT
LF283:  STA  W_CHN1                 ;MAKE SURE IT STARTS CORRECTLY
LF286:  LDX  #$0014
LF289:  LEAX -$1,X
LF28B:  BNE  LF289                  ;EQEND
LF28D:  LDB  R_CHN                  ;pot channel 1 reading
LF290:  STB  pot1_test
LF292:  LDA  DIAGSW                 ;CHECK FOR DIAGNOSTIC SWITCH
LF295:  ANDA #DIAGBT
LF297:  BNE  LF29C                  ;IFEQ  IT IS ON
LF299:  JMP  HANG                   ;GO DO THEM BUT RESET FIRST
;DEBOUNCE SWITCHES AND SET PARAMS
LF29C:  LDA  AUXSW                  ;CHECK AUX SWITCH
LF29F:  ANDA #AUXBIT
LF2A1:  BNE  LF2C4                  ;IFEQ  SWITCH WAS THERE
LF2A3:  LDA  DBNC
LF2A5:  BEQ  LF2C2                  ;IFNE
LF2A7:  DECA
LF2A8:  BNE  LF2C2                  ;IFEQ
LF2AA:  LEAU 2,U                    ;INC STATE
LF2AC:  CMPU #TSTATZ                ;END OF STATE TABLE?
LF2B0:  BLO  LF2B5                  ;IFHS
LF2B2:  LDU  #TSTATE+2
LF2B5:  LDD  #$0000
LF2B8:  STD  SCALE                  ;ALWAYS START THE SCALE TEST WITH LARGEST SCALE
LF2BA:  STA  SCLTYP                 ;ALWAYS START THE SCALE TEST WITH LINEAR TEST
LF2BC:  STA  COLOR                  ;ALWAYS START THE SCALE TEST WITH LINEAR TEST
LF2BE:  STA  snd_test_no            ;ALWAYS START AT FIRST COLOR IN TABLE ( RED )
LF2C0:  LDA  #$80                   ;AUTO REPEAT TIMER
LF2C2:  BRA  LF2C6                  ;ELSE  NO SWITCHES ON
LF2C4:  LDA  #$03                   ;WANT TO SEE IT THIS MANY TIMES FOR A DEBOUNCE
LF2C6:  STA  DBNC
LF2C8:  LDA  IN0                    ;DEBOUNCE FIRE SWITCH FOR COLOR CHANGES
LF2CB:  COMA                        ;CHECK FOR EITHER FIRE SWITCH
LF2CC:  ANDA #FIREBT
LF2CE:  BEQ  LF2F0                  ;IFNE
LF2D0:  LDA  DBNC2
LF2D2:  BEQ  LF2EE                  ;IFNE
LF2D4:  DECA
LF2D5:  BNE  LF2EE                  ;IFEQ  INC COLOR FROM TABLE
LF2D7:  LDB  COLOR
LF2D9:  ADDB #$02
LF2DB:  CMPB #TCOLRZ-TCOLR
LF2DD:  BLO  LF2E0                  ;IFHS  END OF TABLE, START OVER
LF2DF:  CLRB
LF2E0:  STB  COLOR
LF2E2:  CMPB #(TCOLRW-TCOLR)/2      ;WHITE?
LF2E4:  BNE  LF2E8                  ;IFEQ  YES, ALWAYS MAKE A NEW WHITE BRIGHT
LF2E6:  CLR  BRITE
LF2E8:  LDA  #$01                   ;AUTO REPEAT TIMER
LF2EA:  STA  snd_test_tmr           ;ALWAYS START AT FIRST COLOR IN TABLE ( RED )
LF2EC:  LDA  #$80                   ;AUTO REPEAT TIMER
LF2EE:  BRA  LF2F2                  ;ELSE  NO SWITCHES ON
LF2F0:  LDA  #$03                   ;WANT TO SEE IT THIS MANY TIMES FOR A DEBOUNCE
LF2F2:  STA  DBNC2
LF2F4:  LDA  IN1                    ;USE THUMB BUTTONS FOR CHANGE
LF2F7:  COMA
LF2F8:  ANDA #THMBT
LF2FA:  BEQ  LF311                  ;IFNE  SWITCH IS ON
LF2FC:  LDA  DBNC3
LF2FE:  BEQ  LF30F                  ;IFNE
LF300:  DECA
LF301:  BNE  LF30F                  ;IFEQ  TIME TO CHANGE
LF303:  LDB  BRITE
LF305:  EORB #$01
LF307:  STB  BRITE
LF309:  LDA  #$01                   ;AUTO REPEAT TIMER
LF30B:  STA  snd_test_tmr           ;ALWAYS START AT FIRST COLOR IN TABLE ( RED )
LF30D:  LDA  #$80                   ;AUTO REPEAT TIMER
LF30F:  BRA  LF313                  ;ELSE  NO SWITCHES ON
LF311:  LDA  #$03                   ;WANT TO SEE IT THIS MANY TIMES FOR A DEBOUNCE
LF313:  STA  WV_BGP
LF315:  LDA  WV_LP                  ;sound test select: the pot channel 0 reading
LF317:  CMPA #$C0                   ;pushed past $C0: step to the next sound
LF319:  BCS  LF33B
LF31B:  LDA  #$03                   ;WANT TO SEE IT THIS MANY TIMES TO DEBOUNCE
LF31D:  STA  snd_dn_rpt
LF31F:  LDA  WV_LIV                 ;debounce, then auto repeat
LF321:  BEQ  LF339                  ;IFNE
LF323:  DEC  WV_LIV
LF325:  BNE  LF339
LF327:  LDA  snd_test_no
LF329:  INCA
LF32A:  CMPA #$4D                   ;$4D sounds in sound_test_tab
LF32C:  BCS  LF32F
LF32E:  CLRA
LF32F:  STA  snd_test_no
LF331:  LDA  #$28                   ;send it $28 frames from now
LF333:  STA  snd_test_tmr
LF335:  LDA  #$0F                   ;NORMAL DEBOUNCE COUNT
LF337:  STA  WV_LIV
LF339:  BRA  LF364                  ;ELSE  NOPE, NOT THE RASTER TEST
LF33B:  CMPA #$40                   ;pulled below $40: step to the previous sound
LF33D:  BHI  LF35E
LF33F:  LDA  #$03
LF341:  STA  WV_LIV
LF343:  LDA  snd_dn_rpt
LF345:  BEQ  LF35C
LF347:  DEC  snd_dn_rpt
LF349:  BNE  LF35C
LF34B:  LDA  snd_test_no
LF34D:  BNE  LF351
LF34F:  LDA  #$4D                   ;wrap from the first to the last
LF351:  DECA
LF352:  STA  snd_test_no
LF354:  LDA  #$28
LF356:  STA  snd_test_tmr
LF358:  LDA  #$0F
LF35A:  STA  snd_dn_rpt
LF35C:  BRA  LF364
LF35E:  LDA  #$03                   ;in the middle: re-arm both directions
LF360:  STA  snd_dn_rpt
LF362:  STA  WV_LIV
LF364:  LDY  #VGRAM                 ;SETUP POINTER
LF368:  LDB  COLOR                  ;OUTPUT COLOR COMMAND
LF36A:  LDX  #TCOLR
LF36D:  LDD  B,X
LF36F:  CMPD #VGCOLR+(VGCWHT*$100)  ;WHITE?
LF373:  BNE  LF37B                  ;IFEQ
LF375:  TST  BRITE
LF377:  BEQ  LF37B                  ;IFNE  WANTS THE DIMMER WHITE FOR COLOR TRACKING
LF379:  LDB  #$20                   ;INSTEAD OF THE NORMAL 80
LF37B:  STD  ,Y++
LF37D:  JMP  [,U]                   ;EXECUTE THAT STATE

;------------------------------------------------------------------------------
; GETBAK - GO BACK TO MAIN TEST LOOP  (comment at the call)
;   GO BACK TO THE MAINLINE  (another call)
;------------------------------------------------------------------------------
GETBAK:
LF37F:  LDD  #$2020                 ;PUT A COUPLE OF HALTS AT END
LF382:  STD  ,Y++
LF384:  STD  ,Y++

GETBK2:
LF386:  STA  VGGO                   ;START THE VECTOR GENERATOR
LF389:  LDA  TESTSW                 ;CHECK FOR TEST SWITCH
LF38C:  ANDA #TESTBT
LF38E:  LBEQ TSTLP                  ;NEEND  FALL THROUGH IF NO TEST SWITCH

;------------------------------------------------------------------------------
; HANG - endless jump to itself: waits for the watchdog to reset the machine. Left through when the self test
;   switch is turned off and when the diagnostic switches change. Bank 0's SWI, SWI2, SWI3, FIRQ and NMI vectors
;   also point here
;------------------------------------------------------------------------------
HANG:
LF392:  JMP  HANG                   ;WAIT FOR WATCHDOG

TSTATE:
LF395:  .word SDISP                 ;DISPLAY RAM-ROM ERRORS
LF397:  .word SSWTCH                ;LF3F3 (SSWTCH): switch and pot test
LF399:  .word snd_test              ;state 2: the sound test, where Star Wars has its checker board state

TSTAT1:
LF39B:  .word SDIV                  ;MATHBOX TESTS -- DIVIDER AND MATRIX PROC.
LF39D:  .word SHATCH                ;CROSSHATCH PATTERN
LF39F:  .word SCHKR                 ;CHECKER BOARD PATTERN  state 5: SCHKR
LF3A1:  .word SINTEN                ;COLOR INTENSITY PATTERN
LF3A3:  .word SBIP                  ;BIP PATTERN
LF3A5:  .word SSCAL                 ;SCALE PATTERN
LF3A7:  .word SRASTR                ;RASTER PATTERN

TCOLR:
TSTATZ:
LF3A9:  .word VGCOLR+(VGCRED*$100)  ;COLORS FOR PATTERN TESTS
LF3AB:  .word VGCOLR+(VGCGRN*$100)
LF3AD:  .word VGCOLR+(VGCBLU*$100)
LF3AF:  .word VGCOLR+(VGCPRP*$100)

TCOLRW:
LF3B1:  .word VGCOLR+(VGCWHT*$100)
LF3B3:  .word VGCOLR+(VGCYLW*$100)
LF3B5:  .word VGCOLR+(VGCTRQ*$100)

TCOLRZ:
TSUMY:
LF3B7:  .word $1F38
LF3B9:  .word $1F06
LF3BB:  .word $1ED4
LF3BD:  .word $1EA2
LF3BF:  .word $1E70
LF3C1:  .word $1F6A

;------------------------------------------------------------------------------
; SDISP - SWITCH AND POT TEST
;   (also: SDISP)
;------------------------------------------------------------------------------
SDISP:
TSUMYZ:
LF3C3:  DEC  ERRCNT                 ;TIME?
LF3C5:  BPL  LF3F0                  ;IFMI  YES, TIME TO SOUND OFF
LF3C7:  LDA  #$10                   ;RESET TIMER FOR THE NEXT BIT
LF3C9:  STA  ERRCNT
LF3CB:  LDX  ERRPNT                 ;INDEXES INTO BIT TABLE
LF3CD:  LDD  ERRORS                 ;CHECK IT OUT
LF3CF:  ANDA ,X
LF3D1:  BNE  SDISP_30               ;ERROR DETECTED, GO SAY NAY
LF3D3:  ANDB 1,X                    ;A WAS CLEAN, HOW ABOUT B?
LF3D5:  BNE  SDISP_30               ;IFEQ  B CLEAN TOO, SAY YEA
LF3D7:  LDA  #IDAYEA
LF3D9:  BRA  LF3DD                  ;ELSE  MAKE ERROR SOUND ( NAY )

SDISP_30:
LF3DB:  LDA  #IDANAY
LF3DD:  STA  W_XMTS                 ;SHOVE IT OUT TO THE SOUND BOARD
LF3E0:  LEAX 2,X
LF3E2:  CMPX #BITS+$20              ;END OF BIT TABLE?
LF3E5:  BLO  LF3EE                  ;IFHS  YES
LF3E7:  LDA  #$20                   ;DELAY LONGER BEFORE STARTING OVER
LF3E9:  STA  ERRCNT
LF3EB:  LDX  #BITS
LF3EE:  STX  ERRPNT
LF3F0:  JMP  GETBK2                 ;DO NOTHING

;------------------------------------------------------------------------------
; SSWTCH - Star Wars' SSWTCH, the switch test state of the self test, missed by the matcher because ESB dropped
;   its first two instructions and reaches it only through the state table (second entry of TSTATE). Draws the
;   border, SWITCH TEST and the name of every switch that is on, beeps on a switch edge, shows the two option
;   switch banks as N and F, then the pot test: a line from the screen centre to the position read from the two
;   pots. Stays in this state until the aux coin switch steps on
;------------------------------------------------------------------------------
SSWTCH:
LF3F3:  LDD  #VJBONDRY              ;DRAW THE BORDER
LF3F6:  STD  ,Y++
LF3F8:  LDD  #VGCNTR
LF3FB:  STD  ,Y++
LF3FD:  LDS  #STACK                 ;SET STACK
LF401:  LDB  #MS_SWT                ;"SWITCH TEST"
LF403:  JSR  do_message
LF406:  LDB  #$D5
LF408:  JSR  do_message
LF40B:  LDB  #MS_SWT+1              ;MESSAGES FOR SWITCHES
LF40D:  STB  TTEMP2
LF40F:  LDA  R_BYT0                 ;GET SWITCH DATA
LF412:  LDB  R_BYT1
LF415:  ORB  #$C7                   ;DISALLOW NON-SWITCHES (IE MATHBOX READY,VG HALTED,ETC.)
LF417:  STD  TTEMP
LF419:  ASLB                        ;ASLD  SHIFT BIT TO CARRY
LF41A:  ROLA
LF41B:  STD  TTEMP                  ;SAVE FOR NEXT SWITCH
LF41D:  BCS  LF424                  ;IFCC  SWITCH WAS ON
LF41F:  LDB  TTEMP2                 ;DISLAY MESSAGE
LF421:  JSR  do_message
LF424:  INC  TTEMP2                 ;NEXT POSSIBLE MESSAGE
LF426:  LDD  TTEMP                  ;SWITCH DATA
LF428:  BNE  LF419                  ;EQEND
;FIND SWITCH EDGES AND MAKE SOUND
LF42A:  LDD  SWNEW                  ;PUT LAST TIMES NEW INTO THIS TIMES OLD
LF42C:  STD  SWOLD
LF42E:  LDA  R_BYT0                 ;READ IN SWITCHES IN QUESTION
LF431:  ANDA #$CF
LF433:  LDB  R_BYT1
LF436:  ANDB #$3A
LF438:  STD  SWNEW                  ;SAVE AS NEW
LF43A:  EORA SWOLD                  ;CATCH OFF TO ON EDGES
LF43C:  ANDA SWOLD
LF43E:  EORB SWOLD+1
LF440:  ANDB SWOLD+1
LF442:  CMPD #$0000
LF446:  BEQ  LF44D                  ;IFNE  CAUGHT AN EDGE, MAKE A SOUND
LF448:  LDA  #IDAYEA
LF44A:  STA  W_XMTS
;OPTION SWITCHES
LF44D:  LDD  #$1EA2                 ;POSITION FOR OPTION SWITCH DISPLAY
LF450:  STD  ,Y++
LF452:  LDD  #$1F74
LF455:  STD  ,Y++
LF457:  LDA  #$10                   ;SHOW OPTION SWITCH BANK LOCATION ( 10D )
LF459:  JSR  VWBYTE
LF45C:  LDD  VGMSGA+28
LF45F:  STD  ,Y++
LF461:  LDD  VGMSGA
LF464:  STD  ,Y++
LF466:  LDA  R_BYT2                 ;1ST BANK OF OPTION SWITCHES
LF469:  JSR  SWDISP                 ;SHOW 'EM
LF46C:  LDD  #$1E70
LF46F:  STD  ,Y++
LF471:  LDD  #$1F5C
LF474:  STD  ,Y++
LF476:  LDA  #$10                   ;SHOW OPTION SWITCH BANK LOCATION ( 10EF )
LF478:  JSR  VWBYTE
LF47B:  LDD  VGMSGA+30
LF47E:  STD  ,Y++
LF480:  LDD  VGMSGA+32
LF483:  STD  ,Y++
LF485:  LDD  VGMSGA
LF488:  STD  ,Y++
LF48A:  LDA  R_BYT3                 ;2ND BANK OF OPTION SWITCHES
LF48D:  JSR  SWDISP                 ;SHOW 'EM
;POT TEST
LF490:  LDB  #$C7                   ;"POT TEST"
LF492:  JSR  do_message
LF495:  LDD  #$BF93                 ;SHOW PATTERN AROUND POT TEST LINE
LF498:  STD  ,Y++
LF49A:  LDD  #$0000                 ;POSITION TO THE RIGHT
LF49D:  STD  ,Y++
LF49F:  LDD  #$0140
LF4A2:  STD  ,Y++
LF4A4:  LDB  WV_LP
LF4A6:  SUBB #$80                   ;MAKE READING RELATIVE TO CENTER
LF4A8:  SEX
LF4A9:  TFR  D,U                    ;COMPENSATE FOR 1.5/1 ASPECT RATIO
LF4AB:  ASRA                        ;ASRD  1/2
LF4AC:  RORB
LF4AD:  LEAU D,U                    ;GENERATED 1.5 FOR THE Y POT
LF4AF:  TFR  U,D                    ;GET IT BACK
LF4B1:  ANDA #$1F
LF4B3:  STD  ,Y++
LF4B5:  LDB  pot1_test
LF4B7:  SUBB #$80
LF4B9:  SEX
LF4BA:  ANDA #$1F
LF4BC:  ORA  #$E0                   ;TURN THIS LINE ON
LF4BE:  STD  ,Y++
LF4C0:  LDD  #VGCNTR
LF4C3:  STD  ,Y++
LF4C5:  LDU  #LF397                 ;DESTROYED U, SET BACK TO SWITCH TEST STATE
LF4C8:  JMP  GETBAK                 ;GO BACK TO MAIN TEST LOOP

;------------------------------------------------------------------------------
; SWDISP - DISPLAY 8 SWITCHES IN "0" OR "1" FORM
;------------------------------------------------------------------------------
SWDISP:
LF4CB:  LDB  #$07                   ;COUNT
LF4CD:  LSRA                        ;SHIFT SWITCH INTO CARRY
LF4CE:  BCC  LF4D5                  ;IFCS  NOT ON
LF4D0:  LDX  VGMSGA+32              ;"F" FOR OFF
LF4D3:  BRA  LF4D8                  ;ELSE  WAS ON
LF4D5:  LDX  VGMSGA+48              ;"N" FOR ON
LF4D8:  STX  ,Y++
LF4DA:  DECB
LF4DB:  BPL  LF4CD                  ;MIEND
LF4DD:  LDD  #VGCNTR
LF4E0:  STD  ,Y++
LF4E2:  RTS

;------------------------------------------------------------------------------
; snd_test - self test state 2, the sound test, which ESB put where Star Wars has its checker board state: draws
;   the screen boundary, the messages SOUND TEST and SOUND and the index of the chosen sound, and sends the
;   command from sound_test_tab when snd_test_tmr runs out
;------------------------------------------------------------------------------
snd_test:
LF4E3:  LDD  #$BF6D                 ;JSRL to the screen boundary picture
LF4E6:  STD  ,Y++
LF4E8:  LDD  #$8040                 ;centre, normal scale
LF4EB:  STD  ,Y++
LF4ED:  LDD  #$7200
LF4F0:  STD  ,Y++
LF4F2:  LDB  #$C8                   ;SOUND TEST and SOUND
LF4F4:  JSR  do_message
LF4F7:  LDD  #$1F9C                 ;position of the number
LF4FA:  STD  ,Y++
LF4FC:  LDD  #$1FE8
LF4FF:  STD  ,Y++
LF501:  LDA  #$01                   ;blank one leading zero
LF503:  STA  BT_SUP
LF505:  LDA  snd_test_no            ;the selected sound's index, in hex
LF507:  JSR  VWBYTE
LF50A:  DEC  snd_test_tmr           ;time to send it?
LF50C:  BNE  LF51C
LF50E:  LDA  #$FF                   ;then again every 255 frames
LF510:  STA  snd_test_tmr
LF512:  LDB  snd_test_no
LF514:  LDX  #sound_test_tab        ;index to sound board command
LF517:  LDB  B,X
LF519:  STB  W_XMTS                 ;straight to the sound board, no wait for it to be ready
LF51C:  LDU  #LF399                 ;stay in the sound test state
LF51F:  JMP  GETBAK

sound_test_tab:
LF522:  .byte $01, $02, $0B, $03, $04, $05, $06, $07 ;the $4D commands the sound test plays, in its order: $01, $02, $0B (the speech chip's warm start), then $03-$51 without $13, $36, $3E and $44
LF52A:  .byte $08, $09, $0A, $0C, $0D, $0E, $0F, $10
LF532:  .byte $11, $12, $14, $15, $16, $17, $18, $19
LF53A:  .byte $1A, $1B, $1C, $1D, $1E, $1F, $20, $21
LF542:  .byte $22, $23, $24, $25, $26, $27, $28, $29
LF54A:  .byte $2A, $2B, $2C, $2D, $2E, $2F, $30, $31
LF552:  .byte $32, $33, $34, $35, $37, $38, $39, $3A
LF55A:  .byte $3B, $3C, $3D, $3F, $40, $41, $42, $43
LF562:  .byte $45, $46, $47, $48, $49, $4A, $4B, $4C
LF56A:  .byte $4D, $4E, $4F, $50, $51

;------------------------------------------------------------------------------
; SCHKR - Star Wars' SCHKR, the checker board state of the self test, reached through the state table: the JSRL
;   to the checker pattern, then GETBAK
;------------------------------------------------------------------------------
SCHKR:
LF56F:  LDD  #$BEDF
LF572:  STD  ,Y++
LF574:  JMP  GETBAK

;------------------------------------------------------------------------------
; SHATCH - CROSSHATCH PATTERN  (comment at its table entry)
;------------------------------------------------------------------------------
SHATCH:
LF577:  LDD  #$BEBC                 ;CROSS HATCH PATTERN
LF57A:  STD  ,Y++
LF57C:  JMP  GETBAK

;------------------------------------------------------------------------------
; SINTEN - COLOR INTENSITY PATTERN  (comment at its table entry)
;------------------------------------------------------------------------------
SINTEN:
LF57F:  LDD  #$BE6E                 ;COLOR BAR PATTERN
LF582:  STD  ,Y++
LF584:  LDB  #$D4                   ;OUTPUT THE INTENSITY TEST MESSAGES
LF586:  JSR  do_message
LF589:  JMP  GETBAK

;------------------------------------------------------------------------------
; SBIP - BIP PATTERN  (comment at its table entry)
;------------------------------------------------------------------------------
SBIP:
LF58C:  LDD  #$BF6D                 ;BIP PATTERN
LF58F:  STD  ,Y++
LF591:  LDD  #$BF72                 ;BOX WITHOUT CENTERS
LF594:  STD  ,Y++
LF596:  STD  ,Y++
LF598:  STD  ,Y++
LF59A:  STD  ,Y++
LF59C:  LDD  #VGCNTR
LF59F:  STD  ,Y++
LF5A1:  LDB  #$D0                   ;"BIP TEST"
LF5A3:  JSR  do_message
LF5A6:  JMP  GETBAK

;------------------------------------------------------------------------------
; SSCAL - SCALE PATTERN  (comment at its table entry)
;------------------------------------------------------------------------------
SSCAL:
LF5A9:  LDA  DBNC2                  ;CHECK FOR TRIGGER SWITCH
LF5AB:  CMPA #$01
LF5AD:  BHI  LF5B6                  ;IFLS
LF5AF:  LDD  #$0000                 ;RESET TO LARGEST LINEAR SCALE TEST
LF5B2:  STD  SCALE
LF5B4:  STA  SCLTYP
LF5B6:  LDD  #VGCOLR&$F000          ;NO COLOR FOR THE BOX
LF5B9:  STD  ,Y++
LF5BB:  LDD  #$BF6E                 ;DRAW A BOX
LF5BE:  STD  ,Y++
LF5C0:  LDD  #VGCNTR
LF5C3:  STD  ,Y++
LF5C5:  LDD  SCALE                  ;UPDATE SCALE
LF5C7:  ADDD #$0001
LF5CA:  TST  SCLTYP                 ;WHICH TEST ARE WE DOING?
LF5CC:  BNE  LF5DD                  ;IFEQ  LINEAR SCALE TEST
LF5CE:  CMPB #$FC                   ;DONE YET?
LF5D0:  BLO  LF5D9                  ;IFHS  YEP, ALL DONE
LF5D2:  LDA  #$01
LF5D4:  STA  SCLTYP                 ;NON-ZERO MEANS GO TO COMBINED SCALE TEST
LF5D6:  LDD  #$0000                 ;START FROM 0000
LF5D9:  STD  SCALE
LF5DB:  BRA  LF5F4                  ;ELSE  COMBINATION SCALE TEST
LF5DD:  CMPB #$B0                   ;CAUSE A DELAY
LF5DF:  BLO  LF5E3                  ;IFHS  DELAY WHILE LINEAR IS 80 TO 0B0
LF5E1:  CLRB
LF5E2:  INCA
LF5E3:  CMPA #$08                   ;BINARY SCALE WRAP?
LF5E5:  BLO  LF5EC                  ;IFHS  YES
LF5E7:  CLR  SCLTYP                 ;THEN START LINEAR SCALE TEST AGAIN
LF5E9:  LDD  #$0000
LF5EC:  STD  SCALE
LF5EE:  CMPB #$7F                   ;IF LINEAR SCALE IS GREATER THAN 7F MAKE IT 7F
LF5F0:  BLO  LF5F4                  ;IFHS  THIS HOLDS THE SIZE OF THE SQUARE WHILE DELAYING
LF5F2:  LDB  #$7F
LF5F4:  ORA  #(VGSCAL&$F000)/$100   ;MAKE THIS A SCALE INSTRUCTION
LF5F6:  STD  ,Y++
LF5F8:  LDD  #VGCOLR+(VGCGRN*$100)  ;GIVE IT SOME COLOR
LF5FB:  STD  ,Y++
LF5FD:  LDD  #$BF7B                 ;USE SQAURE FOR SCALE TEST
LF600:  STD  ,Y++
LF602:  LDD  #VGSCAL
LF605:  STD  ,Y++
LF607:  LDB  SCLTYP
LF609:  BNE  LF60F                  ;IFEQ  LINEAR SCALE TEST
LF60B:  LDB  #MS_SCL+1              ;"LINEAR"
LF60D:  BRA  LF611                  ;ELSE
LF60F:  LDB  #MS_SCL+2              ;"LINEAR AND BINARY"
LF611:  JSR  do_message
LF614:  LDB  #$D1
LF616:  JSR  do_message
LF619:  JMP  GETBAK

;------------------------------------------------------------------------------
; SRASTR - RASTER PATTERN  (comment at its table entry)
;------------------------------------------------------------------------------
SRASTR:
LF61C:  LDD  #$BF86                 ;START OF PATTERN
LF61F:  STD  ,Y++
LF621:  LDX  #$0038                 ;# OF LINES
LF624:  LDD  #$BF8A                 ;EACH LINE
LF627:  STD  ,Y++
LF629:  LEAX -$1,X
LF62B:  BNE  LF627                  ;EQEND
LF62D:  LDD  #VGCNTR                ;CENTER
LF630:  STD  ,Y++
LF632:  JMP  GETBAK

;------------------------------------------------------------------------------
; SDIV - MATHBOX TEST --- DIVIDER
;------------------------------------------------------------------------------
SDIV:
LF635:  LDD  #VJBONDRY              ;PUT THE BOX OUT THERE
LF638:  STD  ,Y++
LF63A:  LDD  #VGCNTR
LF63D:  STD  ,Y++
LF63F:  LDD  #VGSCAL
LF642:  STD  ,Y++
LF644:  LDS  #STACK                 ;SETUP THE STACK
LF648:  LDB  #$C9                   ;"MATHBOX TESTS"
LF64A:  JSR  do_message
LF64D:  LDA  #$5D                   ;DO A QUICKIE TEST FOR THE MATHBOX READY LINE
LF64F:  STA  M_PCGO
LF652:  TST  M_BUSY                 ;IF READY ALREADY, ITS AN ERROR
LF655:  BPL  LF65C                  ;ERROR
LF657:  TST  M_BUSY                 ;IF READY NOW, GOOD. ELSE ERROR
LF65A:  BPL  SDIV_20
LF65C:  LDB  #$CA
LF65E:  JSR  do_message
LF661:  LDU  #TSTAT1                ;STAY IN THIS TEST
LF664:  JMP  GETBAK                 ;GO BACK TO THE MAINLINE

;CONTINUE WITH MATHBOX TESTS
SDIV_20:
LF667:  LDD  #VGCOLR+(VGCGRN*$100)  ;SHOW ERRORS IN GREEN
LF66A:  STD  ,Y++
LF66C:  CLR  TTEMP                  ;CLEAR ERROR FLAG
LF66E:  LDX  #TDIV                  ;BEGINNING OF TABLE
LF671:  LDS  #SDIVRT                ;SET RETURN ADDRESS
LF675:  JMP  DIVTST                 ;GO DO CURRENT DIVIDER TEST INDICATED BY X

;------------------------------------------------------------------------------
; SDIVRT - RETURN FROM DIVIDER TEST
;   COMPARE TO CORRECT ANSWER WAS LAST THING DONE
;------------------------------------------------------------------------------
SDIVRT:
LF678:  BEQ  LF6F6                  ;IFNE  ERROR--THEN DISPLAY ERROR
LF67A:  STD  ERRORS                 ;ANSWER FROM DIVIDER
LF67C:  INC  TTEMP                  ;FLAG AN ERROR ( WON'T WRAP )
;SHOW OPTION SWITCH SETTING FOR DIAGNOSTIC
LF67E:  LDS  #STACK                 ;SET STACK
LF682:  LDD  6,X                    ;Y POSITION ON SCREEN
LF684:  STD  ,Y++
LF686:  LDD  #$1E98                 ;X POS
LF689:  STD  ,Y++
LF68B:  LDD  VGMSGA+48              ;"NNNN" FOR ON INDICATES DIVIDER TEST
LF68E:  STD  ,Y++
LF690:  STD  ,Y++
LF692:  STD  ,Y++
LF694:  STD  ,Y++
LF696:  LDD  VGMSGA                 ;" "
LF699:  STD  ,Y++
LF69B:  TFR  X,D                    ;WHICH TEST OF 16.
LF69D:  SUBD #TDIV
LF6A0:  ASLB                        ;DISPLAY D6-D3
LF6A1:  LDA  #$03
LF6A3:  ASLB
LF6A4:  BCS  LF6AB                  ;IFCC
LF6A6:  LDU  VGMSGA+32              ;"F" FOR OFF
LF6A9:  BRA  LF6AE                  ;ELSE
LF6AB:  LDU  VGMSGA+48              ;"N" FOR ON
LF6AE:  STU  ,Y++
LF6B0:  DECA
LF6B1:  BPL  LF6A3                  ;MIEND
LF6B3:  LDD  VGMSGA                 ;COUPLE OF SPACES
LF6B6:  STD  ,Y++
LF6B8:  STD  ,Y++
LF6BA:  LDA  ,X                     ;NUMERATOR
LF6BC:  JSR  VWBYTE
LF6BF:  LDA  1,X
LF6C1:  JSR  VWBYTE
LF6C4:  LDD  VGMSGA
LF6C7:  STD  ,Y++
LF6C9:  LDA  2,X                    ;DENOMINATOR
LF6CB:  JSR  VWBYTE
LF6CE:  LDA  3,X
LF6D0:  JSR  VWBYTE
LF6D3:  LDD  VGMSGA
LF6D6:  STD  ,Y++
LF6D8:  LDA  4,X                    ;CORRECT ANSWER
LF6DA:  JSR  VWBYTE
LF6DD:  LDA  5,X
LF6DF:  JSR  VWBYTE
LF6E2:  LDD  VGMSGA
LF6E5:  STD  ,Y++
LF6E7:  LDA  ERRORS                 ;INCORRECT ANSWER
LF6E9:  JSR  VWBYTE
LF6EC:  LDA  ERRORS+1
LF6EE:  JSR  VWBYTE
LF6F1:  LDD  #VGCNTR
LF6F4:  STD  ,Y++
LF6F6:  LEAX 8,X
LF6F8:  CMPX #TDIVZ
LF6FB:  LBLO LF671                  ;HSEND
LF6FF:  LDS  #STACK                 ;SET STACK FOR MESSAGES
LF703:  TST  TTEMP                  ;ERRORS?
LF705:  BNE  LF70B                  ;IFEQ  NO
LF707:  LDB  #MS_DIV+1              ;"NO DIVIDER ERRORS"
LF709:  BRA  LF712                  ;ELSE
LF70B:  LDB  #MS_DIV                ;"DIVIDER ERRORS"
LF70D:  JSR  do_message
LF710:  LDB  #$CD
LF712:  JSR  do_message

;.SBTTL MATHBOX TEST --- MATRIX
SMUL:
LF715:  LDX  #TMULT
LF718:  CLR  TTEMP                  ;CLEAR ERROR FLAG
LF71A:  LDD  #VGCOLR+(VGCRED*$100)  ;SHOW MATRIX ERRORS IN RED
LF71D:  STD  ,Y++
LF71F:  TFR  X,D                    ;GET TEST #
LF721:  SUBD #TMULT1                ;MINUS TABLE OFFSET
LF724:  LSRB                        ;/2 ==> 0,2,4,6 FOR MTST12
LF725:  LDS  #SMULRT
LF729:  JMP  [,X]

;------------------------------------------------------------------------------
; SMULRT - COMPARE TO CORRECT ANSWER WAS LAST THING DONE
;------------------------------------------------------------------------------
SMULRT:
LF72B:  BEQ  LF79E                  ;IFNE  ERROR--THEN DISPLAY ERROR
LF72D:  STD  ERRORS                 ;ANSWER FROM DIVIDER
LF72F:  INC  TTEMP                  ;FLAG AN ERROR
LF731:  CMPX #TMULT2                ;SOME TESTS DON'T HAVE DIAGNOSTICS
LF734:  BHS  LF76F                  ;IFLO  THESE DO
;SHOW OPTION SWITCH SETTING FOR DIAGNOSTIC
LF736:  LDD  2,X                    ;Y POSITION ON SCREEN
LF738:  STD  ,Y++
LF73A:  LDD  #$1EA2                 ;X POS
LF73D:  STD  ,Y++
LF73F:  LDD  VGMSGA+48              ;"NNNF" FOR ON INDICATES MULTIPLIER RATHER THAN DIVIDER TEST
LF742:  STD  ,Y++
LF744:  STD  ,Y++
LF746:  STD  ,Y++
LF748:  LDD  VGMSGA+32              ;"F"
LF74B:  STD  ,Y++
LF74D:  LDD  VGMSGA                 ;" "
LF750:  STD  ,Y++
LF752:  TFR  X,D                    ;WHICH TEST OF 6
LF754:  SUBD #TMULT
LF757:  ASLB                        ;DISPLAY D5-D2
LF758:  ASLB
LF759:  ADDB #$50                   ;THESE TESTS START WITH DIAG 5
LF75B:  LDA  #$03
LF75D:  ASLB
LF75E:  BCS  LF765                  ;IFCC
LF760:  LDU  VGMSGA+32              ;"F" FOR OFF
LF763:  BRA  LF768                  ;ELSE
LF765:  LDU  VGMSGA+48              ;"N" FOR ON
LF768:  STU  ,Y++
LF76A:  DECA
LF76B:  BPL  LF75D                  ;MIEND
LF76D:  BRA  LF786                  ;ELSE  NON DIAGNOSTIC TESTS GIVE CODE LETTERS
LF76F:  LDD  2,X
LF771:  STD  ,Y++
LF773:  LDD  #$0096
LF776:  STD  ,Y++
LF778:  TFR  X,D
LF77A:  SUBD #TMULT2
LF77D:  LSRB
LF77E:  LDS  #VGMSGA+22
LF782:  LDD  B,S
LF784:  STD  ,Y++
LF786:  LDD  VGMSGA
LF789:  STD  ,Y++
LF78B:  LDS  #STACK                 ;SET STACK
LF78F:  LDA  ERRORS                 ;DIPLAY ERRONEOUS DATA
LF791:  JSR  VWBYTE
LF794:  LDA  ERRORS+1
LF796:  JSR  VWBYTE
LF799:  LDD  #VGCNTR
LF79C:  STD  ,Y++
LF79E:  LEAX 4,X
LF7A0:  CMPX #TMULTZ
LF7A3:  LBLO LF71F                  ;HSEND
LF7A7:  LDS  #STACK                 ;SET THE STACK FOR THE MESSAGE ROUTINE
LF7AB:  TST  TTEMP                  ;ERRORS?
LF7AD:  BNE  LF7B3                  ;IFEQ  NO
LF7AF:  LDB  #MS_MTX+1              ;"NO MATRIX ERRORS"
LF7B1:  BRA  LF7B5                  ;ELSE
LF7B3:  LDB  #MS_MTX                ;"MATRIX ERRORS"
LF7B5:  JSR  do_message
LF7B8:  LDU  #TSTAT1
LF7BB:  JMP  GETBAK

TMULT:
LF7BE:  .word MTST6, $1F6A
LF7C2:  .word MTST7, $1F38

TMULT1:
LF7C6:  .word MTST12, $1F06
LF7CA:  .word MTST12, $1ED4
LF7CE:  .word MTST12, $1EA2
LF7D2:  .word MTST12, $1E70

TMULT2:
LF7D6:  .word MULT9, $1F6A
LF7DA:  .word MTST10, $1F38
LF7DE:  .word MTST11, $1F06
LF7E2:  .word MTST8, $1ED4
LF7E6:  .word $F9D2, $1EA2          ;fifth entry of TMULT2: the test at mtst_zt_bits ($F9D2) and its screen y

;------------------------------------------------------------------------------
; MULT9 - [note] End of the TMULT table. MULT9 (its TMULT2 entry): matrix test 9 - set S as return pointer to MT9RT1
;   and jump to MTST9
;   (also: MULT9)
;------------------------------------------------------------------------------
MULT9:
TMULTZ:
LF7EA:  LDS  #MT9RT1
LF7EE:  JMP  MTST9                  ;CLEARS ACCUMULATOR AND STARTS ACCUMULATING

;------------------------------------------------------------------------------
; MT9RT1 - [note] Return from MTST9: D (M_XP) must be $0001, else to SMULRT with the error; then U = 2, return pointer
;   S = MT9RT2, and jump to MTST92 to add the accumulator to itself
;------------------------------------------------------------------------------
MT9RT1:
LF7F1:  CMPD #$0001
LF7F5:  BEQ  LF7FA                  ;IFNE
LF7F7:  JMP  SMULRT
LF7FA:  LDU  #$0002
LF7FD:  LDS  #MT9RT2
LF801:  JMP  MTST92                 ;ADD ACCUMULATOR TO ITSELF

;------------------------------------------------------------------------------
; MT9RT2 - [note] Return from MTST92: D must equal the BITS entry at U, else to SMULRT with the error; U + 2 and repeat
;   MTST92 until U = $20, then to SMULRT with the last compare equal
;------------------------------------------------------------------------------
MT9RT2:
LF804:  CMPD BITS,U
LF809:  BEQ  LF80E                  ;IFNE
LF80B:  JMP  SMULRT
LF80E:  LEAU 2,U
LF810:  CMPU #$0020
LF814:  BLO  LF7FD                  ;HSEND
LF816:  JMP  SMULRT

;------------------------------------------------------------------------------
; DIVTST - DIVIDER TESTS
;   PROGRAMMER: JED MARGOLIN MODIFIED BY NORM AVELLAR
;   DATE 12/10/82 5/18/83
;   2/21/83
;   3/14/83
;   4/4/83
;   HARDWARE: STAR WARS,REV A
;   The STAR WARS Divider is an unsigned 15 bit fractional divider which assumes
;   that the dividend (the numerator) is less than twice the Divisor (the
;   denominator).
;   The hardware consists of a Dividend Latch, a Dividend Shift Register, an
;   inverting Divisor Latch, an Adder, a Difference Latch, a Quotient Shift
;   Register with tri-state Buffer, and a Control Unit which includes the
;   Divide Cycle Counter.
;   The Dividend Latch is written into by the 6809 and has two parts: Dividend
;   Latch High Byte (DVDDH) and Dividend Latch Low Byte (DVDDL) The Dividend
;   Latch is not altered by the operation of the divider so it may be left at
;   its previous value if desired.
;   The Divisor Latch is also written into by the 6809 and has two parts:
;   Divisor High Byte (DVSRH) and Divisor Low Byte (DVSRL). DVSRH loads
;   the Divisor High Byte, clears the Quotient Shift Register, and loads the
;   Dividend Shift Register from the Dividend Latch. DVSRL loads the Divisor Low
;   Byte and starts the Divider.
;   Divider Operation: Subtract the Divisor from the Dividend in the Dividend
;   Shift Register and put the result in the Difference Latch.
;   If the result of this subtraction is positive, the Carry (C16*) will
;   be a '1'. Shift a '1' into the Quotient Shift Register and store the
;   value from the Difference Latch into the Dividend Shift Register.
;   (In a conventional divider algorithm the dividend shift register would
;   then be shifted left, but here the output of the Adder is wired
;   to the Difference Latch already shifted over by one)
;   If the result of the subtraction is negative, the Carry (C16*) will
;   be a '0'. Shift a '0' into the Quotient Shift Register and shift the
;   Dividend Shift Register left once. The value in the Difference Latch
;   is otherwise ignored.
;   Do it 15 times. With a 3 Mhz clock it will take 5.0 uS.
;   The Quotient Shift Register is read by the 6809 as QUOH and QUOL.
;------------------------------------------------------------------------------
DIVTST:
LF819:  LDD  ,X                     ;GET NUMERATOR
LF81B:  STD  M_DVN
LF81E:  LDD  2,X                    ;GET DENOMINATOR
LF820:  STD  M_DVD                  ;STORE DENOMINATOR AND START DIVIDER
LF823:  MUL                         ;CONVENIENT WAY TO WAIT
LF824:  LDD  M_QUO                  ;GET ANSWER
LF827:  CMPD 4,X                    ;IS IT RIGHT?
LF82A:  JMP  ,S                     ;RETURN VIA PREVIOUSLY SET POINTER

;NUMERATOR,DENOMINATOR,QUOTIENT,Y POS ON SCREEN
TDIV:          ;TABLE OF VALUES FOR DIVIDER TESTS
LF82C:  .word $4000, $4000, $4000, $00C8
LF834:  .word $5555, $4000, $5555, $0096
LF83C:  .word $2AAA, $4000, $2AAA, $0064
LF844:  .word $2AAA, $2AAA, $4000, $0032
LF84C:  .word $5555, $5555, $4000, $0000

;------------------------------------------------------------------------------
; MULRET - MULTIPLIER TEST
;   (also: MULRET)
;------------------------------------------------------------------------------
MULRET:
TDIVZ:
LF854:  JMP  ,S                     ;RETURN VIA PREVIOUSLY SET POINTER

;------------------------------------------------------------------------------
; MTST1 - TEST 1 LOOP - LDA ZERO,HALT
;------------------------------------------------------------------------------
MTST1:
LF856:  LDD  #$5555
LF859:  STD  M_ZRO
LF85C:  LDA  #$57
LF85E:  STA  M_PCGO
LF861:  BRA  MULRET

;------------------------------------------------------------------------------
; MTST2 - TEST 2 LOOP - LDB ZERO,HALT
;------------------------------------------------------------------------------
MTST2:
LF863:  LDD  #$AAAA
LF866:  STD  M_ZRO
LF869:  LDA  #$58
LF86B:  STA  M_PCGO
LF86E:  BRA  MULRET

;------------------------------------------------------------------------------
; MTST3 - TEST 3 LOOP - LDC ZERO,MAC,HALT
;------------------------------------------------------------------------------
MTST3:
LF870:  LDD  #$5555
LF873:  STD  M_ZRO
LF876:  LDA  #$59
LF878:  STA  M_PCGO
LF87B:  BRA  MULRET

;------------------------------------------------------------------------------
; MTST4 - TEST 4 LOOP - CLA,HALT
;------------------------------------------------------------------------------
MTST4:
LF87D:  LDA  #$5A
LF87F:  STA  M_PCGO
LF882:  BRA  MULRET

;------------------------------------------------------------------------------
; MTST5 - TEST 5 LOOP - IBC,HALT
;------------------------------------------------------------------------------
MTST5:
LF884:  LDA  #$5B
LF886:  STA  M_PCGO
LF889:  BRA  MULRET

;------------------------------------------------------------------------------
; MTST6 - TEST 6 LOOP - LAC XP
;   SAC YP,HALT
;------------------------------------------------------------------------------
MTST6:
LF88B:  LDD  #$5555
LF88E:  STD  M_XP
LF891:  LDA  #$5C
LF893:  STA  M_PCGO
LF896:  NOP
LF897:  LDD  M_YP                   ;FOR ANALYZER TRIGGERING
LF89A:  CMPD #$5555
LF89E:  BRA  MULRET

;------------------------------------------------------------------------------
; MTST7 - TEST 7 LOOP - LAC XP
;   SAC YP,HALT
;------------------------------------------------------------------------------
MTST7:
LF8A0:  LDD  #$AAAA
LF8A3:  STD  M_XP
LF8A6:  LDA  #$5C
LF8A8:  STA  M_PCGO
LF8AB:  NOP
LF8AC:  LDD  M_YP                   ;FOR ANALYZER TRIGGERING
LF8AF:  CMPD #$AAAA
LF8B3:  BRA  MULRET

;------------------------------------------------------------------------------
; MTST8 - TEST 8 LOOP TESTS SUBTRACT
;   LDA XT,CLA
;   LDB YT
;   LDC ZT,MAC
;   SAC XP,HALT
;------------------------------------------------------------------------------
MTST8:
LF8B5:  LDD  #$2696
LF8B8:  STD  M_XT
LF8BB:  LDD  #$1B2C
LF8BE:  STD  M_YT
LF8C1:  LDD  #$4000
LF8C4:  STD  M_ZT
LF8C7:  LDA  #$5D
LF8C9:  STA  M_PCGO
LF8CC:  MUL
LF8CD:  LDD  M_XP
LF8D0:  CMPD #$0B6A
LF8D4:  JMP  MULRET

;------------------------------------------------------------------------------
; MTST9 - TEST 9 TESTS ACCUMULATOR
;   LDA XT
;   LDB YT
;   LDC ZT,MAC
;   SAC XP,HALT
;------------------------------------------------------------------------------
MTST9:
LF8D7:  LDA  #$5A                   ;FIRST CLEAR ACCUMULATOR
LF8D9:  STA  M_PCGO
LF8DC:  LDD  #$0000
LF8DF:  STD  M_YT
LF8E2:  LDD  #$4000
LF8E5:  STD  M_ZT
LF8E8:  LDD  #$0001                 ;EVERY TIME THIS PART IS RUN
LF8EB:  STD  M_XT                   ;THE PRODUCT SHOULD ACCUMULATE

MTST92:
LF8EE:  STD  M_XT                   ;ADD RESULT BACK TO ACCUMULATOR
LF8F1:  LDA  #$5E
LF8F3:  STA  M_PCGO
LF8F6:  MUL
LF8F7:  LDD  M_XP                   ;PUT RESULT IN D
LF8FA:  JMP  MULRET

;------------------------------------------------------------------------------
; MTST10 - TEST 10 - TEST BLOCK INDEX COUNTER
;   LDA X,IND,CLA
;   LDB ZERO
;   LDC ONE,MAC
;   SAC XP,HALT
;------------------------------------------------------------------------------
MTST10:
LF8FD:  LDU  #MBRAM+$28             ;SETUP THE MATH RAM
LF900:  LDD  #$0005                 ;START AT BIC #4
LF903:  STD  ,U
LF905:  ADDD #$0001
LF908:  LEAU 8,U
LF90A:  CMPU #MBRAMZ
LF90E:  BLO  LF903                  ;HSEND
LF910:  LDD  #$0000
LF913:  STD  M_ZRO
LF916:  LDD  #$4000
LF919:  STD  M_ONE
LF91C:  LDD  #$0004
LF91F:  STD  M_BIC
LF922:  LDU  #$0008                 ;START AT 8TH BIC
LF925:  STA  WTCHDG
LF928:  TFR  U,D                    ;INCREMENT THE BIC
LF92A:  LSRA                        ;LSRD  ADD HALF THE CURRENT VALUE OF U
LF92B:  RORB
LF92C:  LDA  #$5B                   ;INC BIC
LF92E:  STA  M_PCGO
LF931:  DECB
LF932:  BNE  LF92C                  ;EQEND
LF934:  LDA  #$5F                   ;GO GET THE DATA
LF936:  STA  M_PCGO
LF939:  MUL
LF93A:  CMPU M_XP                   ;SHOULD BE THE SAME
LF93E:  BEQ  LF943                  ;IFNE  ERROR
LF940:  JMP  MULRET
LF943:  TFR  U,D                    ;ADD U TO ITSELF
LF945:  LEAU D,U
LF947:  CMPU #$0200
LF94B:  BLO  LF925                  ;HSEND
LF94D:  LDD  #$0000                 ;NO ERRORS
LF950:  JMP  MULRET

;------------------------------------------------------------------------------
; MTST11 - TEST 11 QUICK ACCUMULATOR TEST
;------------------------------------------------------------------------------
MTST11:
LF953:  LDD  #$1B2C
LF956:  STD  M_XT
LF959:  LDD  #$0000
LF95C:  STD  M_YT
LF95F:  LDD  #$4000
LF962:  STD  M_ZT
LF965:  LDA  #$5D                   ;CLEARS ACCUM. AND PUTS 1B2C IN ACCUM
LF967:  STA  M_PCGO
LF96A:  MUL
LF96B:  LDD  #$196A
LF96E:  STD  M_XT
LF971:  LDD  #$0000
LF974:  STD  M_YT
LF977:  LDD  #$4000
LF97A:  STD  M_ZT
LF97D:  LDA  #$5E                   ;ADDS 196A TO ACCUM.
LF97F:  STA  M_PCGO
LF982:  MUL
LF983:  LDD  M_XP
LF986:  CMPD #$3496
LF98A:  JMP  MULRET

;------------------------------------------------------------------------------
; MTST12 - TEST 12 LOOP -- TESTS SUBTRACT
;   LDA XT,CLA
;   LDB YT
;   LDC ZT,MAC
;   SAC XP,HALT
;   B MUST BE SET TO 0,2,4 OR 6 BEFORE GETTING HERE
;------------------------------------------------------------------------------
MTST12:
LF98D:  ASLB
LF98E:  ASLB
LF98F:  LDU  #TMTRX                 ;TABLE OF VALUES FOR TEST 12
LF992:  LEAU B,U
LF994:  LDD  ,U
LF996:  STD  M_XT
LF999:  LDD  2,U
LF99B:  STD  M_YT
LF99E:  LDD  4,U
LF9A0:  STD  M_ZT
LF9A3:  LDA  #$5D
LF9A5:  STA  M_PCGO
LF9A8:  MUL                         ;DELAY
LF9A9:  LDD  M_XP
LF9AC:  CMPD 6,U
LF9AF:  JMP  MULRET

TMTRX:
LF9B2:  .word $5555, $0000, $4000, $5555
LF9BA:  .word $0000, $5555, $C000, $5555
LF9C2:  .word $2AAA, $0000, $4000, $2AAA
LF9CA:  .word $0000, $2AAA, $C000, $2AAA

;------------------------------------------------------------------------------
; mtst_zt_bits - self test: start of the walking-bit matrix processor test, reached through the table word at
;   $F7E6
;------------------------------------------------------------------------------
mtst_zt_bits:
LF9D2:  LDD  #$4000                 ;code, not data: LDD #$4000 / STD M_XT / LDD #$0000 / STD M_YT / LDD #$0001 - a matrix test with a walking bit in ZT
LF9D5:  STD  M_XT
LF9D8:  LDD  #$0000
LF9DB:  STD  M_YT
LF9DE:  LDD  #$0001
LF9E1:  STD  TTEMP2                 ;the bit under test, also the expected product
LF9E3:  STD  M_ZT
LF9E6:  LDA  #$5D                   ;program $5D: XP = the product
LF9E8:  STA  M_PCGO
LF9EB:  MUL                         ;DELAY
LF9EC:  LDD  M_XP
LF9EF:  CMPD TTEMP2
LF9F2:  BEQ  mtst_zt_next           ;right: on to the next bit
LF9F4:  JMP  MULRET

;------------------------------------------------------------------------------
; mtst_zt_next - not a routine of its own: the loop end of the matrix test that starts at $F9D2 (mtst_zt_bits,
;   shown as .byte rows), reached by the BEQ at $F9F2 when the product matched. Shifts the test bit in D left and
;   loops to $F9E1 until it falls out, then returns through MULRET with the equal flag set
;------------------------------------------------------------------------------
mtst_zt_next:
LF9F7:  ASLB
LF9F8:  ROLA
LF9F9:  BCC  LF9E1
LF9FB:  JMP  MULRET

TMUL:          ;TABLE OF MULTIPLIER TEST ROUTINES
LF9FE:  .word MTST1
LFA00:  .word MTST2
LFA02:  .word MTST3
LFA04:  .word MTST4
LFA06:  .word MTST5
LFA08:  .word MTST6
LFA0A:  .word MTST7

TMUL1:
LFA0C:  .word MTST12
LFA0E:  .word MTST12
LFA10:  .word MTST12
LFA12:  .word MTST12

;------------------------------------------------------------------------------
; DIAGLP - DIAGNOSTICS
;   (also: DLOOP, DIAGLP)
;------------------------------------------------------------------------------
DIAGLP:
DLOOP:
TMULZ:
LFA14:  LDA  TESTSW                 ;BOTH TEST AND DIAG SWITCHES ON?
LFA17:  ANDA #TESTBT
LFA19:  LDB  DIAGSW
LFA1C:  ANDB #DIAGBT
LFA1E:  CMPD #$0000                 ;SHOULD BE 0000 IF BOTH ON
LFA22:  BEQ  LFA27                  ;IFNE
LFA24:  JMP  HANG                   ;WAIT FOR WATCH DOG
LFA27:  STA  WTCHDG                 ;KEEP THE DOG QUIET
LFA2A:  LDA  #$FF                   ;TURN OFF ALL LEDS
LFA2C:  STA  W_LED1
LFA2F:  STA  W_LED2
LFA32:  STA  W_LED3
LFA35:  LDB  R_BYT2
LFA38:  COMB
LFA39:  LDU  #TDNUM                 ;TABLE OF DIAG NUM TO BCD CONVERSIONS
LFA3C:  CMPB ,U+                    ;IS THIS THE SWITCH CONFIGURATION?
LFA3E:  BNE  LFA67                  ;IFEQ  YES, THEN SHOW THE TEST NUMBER
LFA40:  STA  VGSTOP                 ;MAKE SURE VG HAS STOPPED
LFA43:  LDY  #VGRAM                 ;SET UP POINTER
LFA47:  LDD  #VJBONDRY              ;DRAW A BOX
LFA4A:  STD  ,Y++
LFA4C:  LDD  #VGCNTR
LFA4F:  STD  ,Y++
LFA51:  LDA  ,U                     ;GET BCD FOR DIAG NUMBER
LFA53:  LDS  #STACK
LFA57:  JSR  VWBYTE
LFA5A:  LDD  #$2020                 ;PUT A HALT IN AT END OF LIST
LFA5D:  STD  ,Y++
LFA5F:  STD  ,Y++
LFA61:  STA  VGGO                   ;START THE VG
LFA64:  LDU  #TDNUMZ                ;LEAVE THE LOOP
LFA67:  LEAU 1,U                    ;NEXT ENTRY
LFA69:  CMPU #TDNUMZ
LFA6D:  BLO  LFA3C                  ;HSEND
LFA6F:  LDB  R_BYT2                 ;READ OPTION SWITCH TO FIND DIAGNOSTIC TEST #
LFA72:  COMB                        ;OFF-->0, ON-->1
LFA73:  TFR  B,A
LFA75:  ANDB #$0F                   ;TO BE USED BY CERTAIN TESTS INTERNALLY
LFA77:  ANDA #$F8                   ;TOP 5 BITS INDICATE TEST TYPE
LFA79:  CMPA #$C0                   ;AVG INSTRUCTIONS?
LFA7B:  BEQ  LFA7F                  ;IFNE  NO
LFA7D:  CLR  SIGFLG                 ;MAKE SURE SIGNATURE ANALYSIS GETS INITIATED CORRECTLY
LFA7F:  LDX  #TDIAG
LFA82:  CMPA ,X+
LFA84:  BNE  LFA88                  ;IFEQ
LFA86:  JMP  [,X]
LFA88:  LEAX 2,X
LFA8A:  CMPX #TDIAGZ                ;PAST END OF TABLE?
LFA8D:  BLO  LFA82                  ;HSEND  IF NOT KEEP LOOKING
LFA8F:  JMP  DIAGERR                ;ELSE FLASH ALL 3 LEDS TO INDICATE ERROR

TDIAG:
LFA92:  .byte $00                   ;LOOKUP 000,D.KERN  KERNAL TEST
LFA93:  .word D_KERN
LFA95:  .byte $80                   ;LOOKUP 080,D.AVGR  AVG RAM AND ROM TEST
LFA96:  .word D_AVGR
LFA98:  .byte $C0                   ;LOOKUP 0C0,D.AVGI  AVG INSTRUCTIONS
LFA99:  .word D_AVGI
LFA9B:  .byte $E0                   ;LOOKUP 0E0,D.MTRX  MATRIX PROCESSOR INSTRUCTIONS
LFA9C:  .word D_MTRX
LFA9E:  .byte $E8                   ;LOOKUP 0E8,D.MTRX  "
LFA9F:  .word D_MTRX
LFAA1:  .byte $F0                   ;LOOKUP 0F0,D.DVDR  DIVIDER TESTS
LFAA2:  .word D_DVDR
LFAA4:  .byte $F8                   ;LOOKUP 0F8,D.SND  SOUND BOARD COMMUNICATIONS
LFAA5:  .word D_SND

TDIAGZ:
TDNUM:          ;SWITCH TO TEST NUMBER CONVERSION TABLE
LFAA7:  .byte $E0, $10
LFAA9:  .byte $E1, $11
LFAAB:  .byte $E2, $12
LFAAD:  .byte $E3, $13
LFAAF:  .byte $E4, $14
LFAB1:  .byte $E5, $15
LFAB3:  .byte $E6, $16
LFAB5:  .byte $E7, $17
LFAB7:  .byte $E8, $18
LFAB9:  .byte $E9, $19
LFABB:  .byte $EA, $20
LFABD:  .byte $F0, $21
LFABF:  .byte $F1, $22
LFAC1:  .byte $F2, $23
LFAC3:  .byte $F3, $24
LFAC5:  .byte $F4, $25
LFAC7:  .byte $F8, $26

;------------------------------------------------------------------------------
; D_KERN - KERNAL TEST
;   (also: D_KERN)
;------------------------------------------------------------------------------
D_KERN:
TDNUMZ:
LFAC9:  TSTB                        ;SHOULD BE 00
LFACA:  BEQ  LFACF                  ;IFNE  ERROR
LFACC:  JMP  DIAGERR
LFACF:  TFR  S,D                    ;GET TEST RESULTS
LFAD1:  ANDA #$40                   ;ROM 4 OK?
LFAD3:  ANDB #$01                   ;RAM OK?
LFAD5:  CMPD #$0000
LFAD9:  BNE  LFAE1                  ;IFEQ  YES, ROM AND RAM OK
LFADB:  LDU  #W_LED1                ;THEN FLASH LED 1
LFADE:  JMP  LEDFLSH                ;AND RETURN TO DIAGLP
LFAE1:  JMP  DIAGLP

;------------------------------------------------------------------------------
; D_AVGR - AVG ROM/RAM TEST
;------------------------------------------------------------------------------
D_AVGR:
LFAE4:  TSTB                        ;SHOULD BE 00
LFAE5:  BEQ  LFAEA                  ;IFNE  ERROR
LFAE7:  JMP  DIAGERR
LFAEA:  TFR  S,D
LFAEC:  ANDA #$81
LFAEE:  ANDB #$F8
LFAF0:  CMPD #$0000
LFAF4:  BNE  LFAFC                  ;IFEQ  AVG RAM AND ROM ARE OK
LFAF6:  LDU  #W_LED2                ;THEN FLASH LED 2
LFAF9:  JMP  LEDFLSH                ;AND RETURN TO DIAGLP
LFAFC:  JMP  DIAGLP

;------------------------------------------------------------------------------
; D_AVGI - AVG INSTRUCTION DIAGNOSTICS
;------------------------------------------------------------------------------
D_AVGI:
LFAFF:  CMPB #$06                   ;SIGNATURE ANALYSIS?
LFB01:  BNE  LFB1B                  ;IFEQ  YEP
LFB03:  TST  SIGFLG                 ;BEEN THROUGH HERE ALREADY?
LFB05:  BNE  LFB19                  ;IFEQ  NOPE, THEN SET UP RAM, AND SET FLAG
LFB07:  LDX  #VGRAM+$800            ;VGRAM1
LFB0A:  LDA  #$00
LFB0C:  STA  ,X+
LFB0E:  ADDA #$05
LFB10:  CMPX #VGRAM+$1000           ;FILLED VGRAM1 WITH APPROPRIATE DATA?
LFB13:  BLO  LFB0C                  ;HSEND
LFB15:  LDA  #$FF
LFB17:  STA  SIGFLG                 ;FLAG SO WON'T DO IT AGAIN
LFB19:  BRA  LFB41                  ;ELSE  NORMAL AVG INSTRUCTIONS
LFB1B:  CLR  SIGFLG
LFB1D:  STA  VGSTOP
LFB20:  LDX  #TAVGI
LFB23:  ASLB                        ;2-WORD ENTRIES
LFB24:  ASLB
LFB25:  ABX
LFB26:  CMPX #TAVGIZ
LFB29:  BLO  LFB2E                  ;IFHS
LFB2B:  JMP  DIAGERR                ;FLASH LEDS
LFB2E:  LDD  ,X                     ;SET UP INSTRUCTIONS FROM THE TABLE
LFB30:  STD  VGRAM+0
LFB33:  LDD  2,X
LFB35:  STD  VGRAM+2
LFB38:  LDD  #$2020                 ;MAKE SURE IT STOPS
LFB3B:  STD  VGRAM+4
LFB3E:  STA  VGGO                   ;START THE VG
LFB41:  JMP  DIAGLP                 ;GO BACK TO THE DIAGNOSTIC MAIN LOOP

TAVGI:
LFB44:  .word $2020, $2020          ;HALT;HALT
LFB48:  .word $0100, $0100          ;VCTR 100,100
LFB4C:  .word $5010, $2020          ;SVCTR 20,20;HALT
LFB50:  .word $8040, $2020          ;CNTR;HALT
LFB54:  .word $7240, $2020          ;SCAL 2,40;HALT
LFB58:  .word $6780, $2020          ;COLOR WHT,80;HALT

;------------------------------------------------------------------------------
; D_MTRX - MATHBOX DIAGS
;   MATRIX PROCESSOR DIAGS
;   (also: D_MTRX)
;------------------------------------------------------------------------------
D_MTRX:
TAVGIZ:
LFB5C:  LDX  #TMUL                  ;MATRIX MULTIPLIER TEST TABLE
LFB5F:  ASLB
LFB60:  ABX
LFB61:  LDY  #$0000                 ;SETUP REPEAT COUNT

D_MTRX_30:          ;REPEATER RETURN POINT ( FOR FASTER TESTS )
LFB65:  CMPX #TMULZ                 ;PAST END OF TABLE?
LFB68:  BLO  LFB6D                  ;IFHS  YES
LFB6A:  JMP  DIAGERR                ;THEN INDICATE AN ERROR
LFB6D:  STA  WTCHDG                 ;DOING MULTIPLE TESTS, SO KEEP THE DOG QUIET
LFB70:  LEAY 1,Y                    ;INC REPEAT COUNT
LFB72:  CMPY #$0200
LFB76:  BLO  LFB7E                  ;IFHS  CHECK FOR NEW TEST, RESTART VG, ETC.
LFB78:  LDS  #DLOOP                 ;RETURN TO THE DIAGNOSTIC MAIN LOOP DELAY
LFB7C:  BRA  LFB82                  ;ELSE  JUST KEEP DOING OLD TEST
LFB7E:  LDS  #D_MTRX_30             ;RETURN TO ABOVE
LFB82:  TFR  X,D                    ;SETUP FOR MTST12
LFB84:  SUBD #TMUL1                 ;GIVES 0,2,4 OR 6
LFB87:  JMP  [,X]                   ;DO IT AND RETURN VIA S

;------------------------------------------------------------------------------
; D_DVDR - DIVIDER DIAGS
;------------------------------------------------------------------------------
D_DVDR:
LFB89:  LDX  #TDIV                  ;DIVIDER TEST TABLE
LFB8C:  ASLB                        ;8 BYTES PER ENTRY
LFB8D:  ASLB
LFB8E:  ASLB
LFB8F:  ABX
LFB90:  LDY  #$0000                 ;SETUP REPEAT COUNT

D_DVDR_30:          ;REPEATER RETURN POINT ( FOR FASTER TESTS )
LFB94:  CMPX #TDIVZ                 ;PAST END OF TABLE?
LFB97:  BLO  LFB9C                  ;IFHS  YES
LFB99:  JMP  DIAGERR                ;THEN INDICATE AN ERROR
LFB9C:  STA  WTCHDG                 ;DOING MULTIPLE TESTS, SO KEEP THE DOG QUIET
LFB9F:  LEAY 1,Y                    ;INC REPEAT COUNT
LFBA1:  CMPY #$0200
LFBA5:  BLO  LFBAD                  ;IFHS  CHECK FOR NEW TEST, RESTART VG, ETC.
LFBA7:  LDS  #DLOOP                 ;RETURN TO THE DIAGNOSTIC MAIN LOOP DELAY
LFBAB:  BRA  LFBB1                  ;ELSE  JUST KEEP DOING OLD TEST
LFBAD:  LDS  #D_DVDR_30             ;RETURN TO ABOVE
LFBB1:  JMP  DIVTST                 ;GO DO IT AND RETURN VIA S

;------------------------------------------------------------------------------
; D_SND - SOUND BOARD COMMUNICATIONS
;------------------------------------------------------------------------------
D_SND:
LFBB4:  ANDB #$07
LFBB6:  BEQ  LFBBB                  ;IFNE
LFBB8:  JMP  DIAGERR
LFBBB:  LDA  #$01                   ;STARTING PATTERN
LFBBD:  STB  W_RSTS                 ;RESET THE SOUND BOARD (INITIATE PORT TEST)
LFBC0:  TFR  X,U                    ;SHORT PAUSE
LFBC2:  LDB  R_RCVS                 ;READ PORT FROM SOUND BOARD, SHOULD CLEAR RECIEVED FLAG
LFBC5:  LDB  R_STAS                 ;CHECK RECEIVE STATUS, SHOULD BE LOW SINCE I JUST READ IT
LFBC8:  ANDB #$40
LFBCA:  BNE  WAIT1                  ;WASN'T CORRECT POLARITY
;CHECK TO SEE IF XMIT READY
LFBCC:  LDB  #$80                   ;ALLOW A DELAY
LFBCE:  DECB
LFBCF:  BMI  WAIT1                  ;DELAYED TOO LONG, WAIT A WHILE AND TRY AGAIN
LFBD1:  STA  WTCHDG                 ;KEEP THE POOCH QUIET
LFBD4:  TST  R_STAS                 ;CHECK XMIT STATUS
LFBD7:  BMI  LFBCE                  ;PLEND  XMIT IS NOW READY
LFBD9:  STA  W_XMTS                 ;GIVE THE SOUND BOARD THE DATA PATTERN
LFBDC:  LDB  R_STAS                 ;CHECK XMIT STATUS, SHOULD BE HI SINCE I JUST SENT DATA
LFBDF:  BPL  WAIT1                  ;WRONG, DELAY AND TRY AGAIN LATER
;WAIT FOR SOUND BOARD TO TALK TO US
LFBE1:  LDX  #$0100                 ;ALLOW A DELAY
LFBE4:  LEAX -$1,X
LFBE6:  BEQ  WAIT1                  ;DELAYED TOO LONG, TRY AGAIN LATER
LFBE8:  STA  WTCHDG
LFBEB:  LDB  R_STAS                 ;GET STATUS
LFBEE:  ANDB #$40                   ;HI IF SOUND BOARD TALKED TO US
LFBF0:  BEQ  LFBE4                  ;NEEND  IT SPOKE!
;THE XMIT LINE SHOULD BE READY AGAIN SINCE IT READ BEFORE IT SPOKE
LFBF2:  TST  R_STAS
LFBF5:  BMI  WAIT1                  ;WRONG! DELAY AND TRY AGAIN
LFBF7:  CMPA R_RCVS                 ;COMPARE DATA RCVD FROM SOUND BOARD TO DATA XMITD
LFBFA:  BNE  WAIT1                  ;ERROR, GO AWAY AGAIN
;CHECK RECEIVE STATUS AGAIN
LFBFC:  LDB  R_STAS
LFBFF:  ANDB #$40
LFC01:  BMI  WAIT1                  ;WRONGO
LFC03:  ASLA                        ;NEW PATTERN
LFC04:  BCC  LFBBD                  ;CSEND  WHEN BIT SHIFTS TO CARRY, ALL DONE
LFC06:  LDU  #W_LED3                ;ELSE ALL OK, FLASH LED #3
LFC09:  JMP  LEDFLSH

;------------------------------------------------------------------------------
; LEDFLSH - DIAGNOSTIC LED FLASHERS
;   FLASH LED POINTED AT BY U
;------------------------------------------------------------------------------
LEDFLSH:
LFC0C:  LDA  #$00                   ;TURN LED ON
LFC0E:  STA  ,U

WAIT1:          ;THIS ENTRY POINT WAITS 1 SECOND
LFC10:  LDX  #$0000                 ;WAIT ABOUT HALF A SECOND
LFC13:  STA  WTCHDG
LFC16:  LEAX 1,X
LFC18:  CMPX #$AC55
LFC1B:  BLO  LFC13                  ;HSEND
LFC1D:  LDA  #$FF                   ;TURN LED OFF
LFC1F:  STA  ,U
LFC21:  LDX  #$0000                 ;WAIT ANOTHER HALF A SECOND
LFC24:  STA  WTCHDG
LFC27:  LEAX 1,X
LFC29:  CMPX #$AC55
LFC2C:  BLO  LFC24                  ;HSEND
LFC2E:  JMP  DIAGLP                 ;GO BACK TO BEGINNING OF DIAGNOSTICS

;------------------------------------------------------------------------------
; DIAGERR - DIAGNOSTIC ERROR INDICATOR--FLASH ALL LEDS
;------------------------------------------------------------------------------
DIAGERR:
LFC31:  LDA  #$00                   ;TURN ALL LEDS ON
LFC33:  STA  W_LED1
LFC36:  STA  W_LED2
LFC39:  STA  W_LED3
LFC3C:  LDX  #$0000                 ;WAIT ABOUT 1/4 SECOND
LFC3F:  STA  WTCHDG
LFC42:  LEAX 1,X
LFC44:  CMPX #$5600
LFC47:  BLO  LFC3F                  ;HSEND
LFC49:  LDA  #$FF                   ;TURN ALL LEDS OFF
LFC4B:  STA  W_LED1
LFC4E:  STA  W_LED2
LFC51:  STA  W_LED3
LFC54:  LDX  #$0000                 ;WAITR ANOTHER 1/4 SECOND
LFC57:  STA  WTCHDG
LFC5A:  LEAX 1,X
LFC5C:  CMPX #$5600
LFC5F:  BLO  LFC57                  ;HSEND
LFC61:  JMP  DIAGLP                 ;GO BACK TO DIAGNOSTIC LOOP
;.SBTTL STAR WARS FILLER FOR ROM 4
LFC64:  .byte $A6, $BF, $C8, $40, $96, $1F, $64, $10 ;.IRPC .A,<JED MARGOLIN -- ENGINEER EMERITUS>
LFC6C:  .byte $59, $A0, $74, $A6, $20, $B1, $00, $D6
LFC74:  .byte $A9, $00, $B0, $BF, $C0, $0A, $55, $A8
LFC7C:  .byte $16, $E0, $C2, $77, $FE
LFC81:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;ROM fill, 42 bytes of $FF
LFC91:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFCA1:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFCAB:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;ROM fill, 85 bytes of $FF
LFCBB:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFCCB:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFCDB:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFCEB:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFCFB:  .byte $FF, $FF, $FF, $FF, $FF
LFD00:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;ROM fill, 52 bytes of $FF
LFD10:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFD20:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFD30:  .byte $FF, $FF, $FF, $FF
LFD34:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;ROM fill, 34 bytes of $FF
LFD44:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFD54:  .byte $FF, $FF
LFD56:  .byte $FF
LFD57:  .byte $FF
LFD58:  .byte $FF
LFD59:  .byte $FF
LFD5A:  .byte $FF
LFD5B:  .byte $FF
LFD5C:  .byte $FF
LFD5D:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;ROM fill, 163 bytes of $FF
LFD6D:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFD7D:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFD8D:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFD9D:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFDAD:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFDBD:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFDCD:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFDDD:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFDED:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFDFD:  .byte $FF, $FF, $FF
LFE00:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;ROM fill, 62 bytes of $FF
LFE10:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFE20:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFE30:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFE3E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;ROM fill, 50 bytes of $FF
LFE4E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFE5E:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFE6E:  .byte $FF, $FF
LFE70:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;ROM fill, 40 bytes of $FF
LFE80:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFE90:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFE98:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;ROM fill, 100 bytes of $FF
LFEA8:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFEB8:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFEC8:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFED8:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFEE8:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFEF8:  .byte $FF, $FF, $FF, $FF
LFEFC:  .byte $FF
LFEFD:  .byte $FF
LFEFE:  .byte $FF
LFEFF:  .byte $FF
LFF00:  .byte $FF
LFF01:  .byte $FF
LFF02:  .byte $FF
LFF03:  .byte $FF
LFF04:  .byte $FF
LFF05:  .byte $FF
LFF06:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;ROM fill, 38 bytes of $FF
LFF16:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFF26:  .byte $FF, $FF, $FF, $FF, $FF, $FF
LFF2C:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;.REPT 73  FILL WITH FF'S
LFF34:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFF3C:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFF44:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFF4C:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFF54:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFF5C:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFF64:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFF6C:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFF74:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFF7C:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFF84:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFF8C:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFF94:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFF9C:  .byte $FF, $FF, $FF
LFF9F:  .byte $43, $4F, $50, $59, $52, $49, $47, $48 ;.ASCII /COPYRIGHT 1983 ATARI/
LFFA7:  .byte $54, $20, $31, $39, $38, $34, $20, $41
LFFAF:  .byte $54, $41, $52, $49
LFFB3:  .byte $9C                   ;one of the six words the self test combines into the signature it shows
LFFB4:  .byte $8C

;------------------------------------------------------------------------------
; rom_sum_2banks - self test checksum of one 16K program ROM, placed at the same address in both banks because
;   it switches W_BANK while it runs. U points at the ROM's entry in TROMP. Starting with the ROM's address as
;   seed it adds the $1000 words of the bank 1 half, then of the bank 0 half, with end-around carry, steps U to
;   the next entry and jumps back to LF08E with the sum in D. Bank 1's copy is what executes between the two
;   writes to W_BANK
;------------------------------------------------------------------------------
rom_sum_2banks:
LFFB5:  LDX  ,U                     ;the ROM's address
LFFB7:  LDY  #$2000                 ;$2000 bytes per half
LFFBB:  LDA  #$FF                   ;bank 1: from here bank 1's copy of this routine runs
LFFBD:  STA  W_BANK
LFFC0:  TFR  X,D                    ;address as seed
LFFC2:  ANDCC #$FE
LFFC4:  ADDD ,X++                   ;add the word, end-around carry
LFFC6:  ADCB #$00
LFFC8:  ADCA #$00
LFFCA:  STA  WTCHDG                 ;SHUT THE DOG UP
LFFCD:  LEAY -$2,Y
LFFCF:  BNE  LFFC4                  ;EQEND  END OF FIRST HALF
LFFD1:  TFR  D,X                    ;SAVE CURRENT CHECKSUM
LFFD3:  LDA  #$00
LFFD5:  STA  W_BANK                 ;SWITCH BANKS
LFFD8:  TFR  X,D                    ;back in bank 0's copy
LFFDA:  LDX  ,U++                   ;the same address again, U to the next table entry
LFFDC:  LDY  #$2000
LFFE0:  ADDD ,X++
LFFE2:  ADCB #$00
LFFE4:  ADCA #$00
LFFE6:  STA  WTCHDG
LFFE9:  LEAY -2,Y
LFFEB:  BNE  LFFE0
LFFED:  JMP  LF08E                  ;back to the self test with the sum in D
LFFF0:  .byte $00, $00              ;a zero word, then the 6809 vectors: SWI3, SWI2 and FIRQ to HANG
LFFF2:  .word HANG                  ;6809 vectors: SWI3, SWI2, FIRQ, IRQ, SWI, NMI, RESET
LFFF4:  .word HANG
LFFF6:  .word HANG
LFFF8:  .word irq_entry             ;IRQ to irq_entry ($6005), SWI and NMI to HANG, RESET to RESET ($EDEE)
LFFFA:  .word HANG
LFFFC:  .word HANG
LFFFE:  .word RESET
