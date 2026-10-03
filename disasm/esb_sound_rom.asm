;The Empire Strikes Back (Atari, 1985) - annotated disassembly of the sound
;program ROM on the sound board's 6809: $4000-$7FFF and $C000-$FFFF (the first
;and second halves of 136031-113.1jk and 136031-112.1h).
;Names and upper-case comments are Atari's, carried over from the Star Wars
;source wherever this code is the same instruction for instruction (swmatch.py);
;everything in lower case was written for this disassembly.
;Every line below was re-encoded and byte-compared with the ROM (verify.py).
;Syntax: Motorola 6809 mnemonics and operands; .alias, .byte, .word (big-endian);
;( ) groups expressions; ~ is one's complement, | is OR, ^ is exclusive OR.
;.dpage gives the direct page the assembler assumed; < and > before an operand
;force the short and the long form.

.org $4000

.include "esb_sound_defines.asm"

.dpage $10
L4000:  .word $27C0                 ;checksum word of the first ROM, Star Wars's CKSUM0: with it TEST's sum of $4000-$5FFF and $C000-$DFFF comes out right
L4002:  .word L40A6, L41B6          ;phrase 0: 273 bytes  no command says phrase 0, it has the same start and end as phrase 1
L4006:  .word L40A6, L41B6          ;phrase 1: 273 bytes  said by sound command $06, only when no speech is under way (SPITE)
L400A:  .word L41B7, L43AF+3        ;phrase 2: 508 bytes  said by sound command $0C (word 2 of 3)
L400E:  .word L43B3, L449B+7        ;phrase 3: 240 bytes  said by sound command $07
L4012:  .word L44A3, L456B          ;phrase 4: 201 bytes  said by sound command $0C (word 1 of 3)
L4016:  .word L456C, L4634          ;phrase 5: 201 bytes  said by sound command $0C (word 3 of 3)
L401A:  .word L4635, L46FD+6        ;phrase 6: 207 bytes  said by sound command $0D
L401E:  .word L4704, L4864+3        ;phrase 7: 356 bytes  said by sound command $12
L4022:  .word L4868, L4980+6        ;phrase 8: 287 bytes  said by sound command $18
L4026:  .word L4987, L4A67+3        ;phrase 9: 228 bytes  said by sound command $05
L402A:  .word L4A6B, L4BD3+2        ;phrase 10: 363 bytes  said by sound command $03
L402E:  .word L4BD6, L4D16+4        ;phrase 11: 325 bytes  said by sound command $17
L4032:  .word L4D1B, L4EF3+2        ;phrase 12: 475 bytes  said by sound command $09
L4036:  .word L4EF6, L502E+3        ;phrase 13: 316 bytes  said by sound command $0F
L403A:  .word L5032, L5112+7        ;phrase 14: 232 bytes  said by sound command $15
L403E:  .word L511A, L5382+6        ;phrase 15: 623 bytes  said by sound command $04
L4042:  .word L5389, L5439+3        ;phrase 16: 180 bytes  said by sound command $1A
L4046:  .word L543D, L5575+6        ;phrase 17: 319 bytes  said by sound command $0A
L404A:  .word L557C, L58E4+3        ;phrase 18: 876 bytes  said by sound command $14
L404E:  .word L58E8, L5A88+6        ;phrase 19: 423 bytes  said by sound command $0E
L4052:  .word L5A8F, L5C47+5        ;phrase 20: 446 bytes  said by sound command $10
L4056:  .word L5C4D, L5F35+4        ;phrase 21: 749 bytes  said by sound command $16
L405A:  .word L5F3A, L60EA+3        ;phrase 22: 436 bytes  said by sound command $11
L405E:  .word L60EE, L62FE+2        ;phrase 23: 531 bytes  said by sound command $08
L4062:  .word L6301, L6451+5        ;phrase 24: 342 bytes  said by sound command $19
L4066:  .word L6457, L665F          ;phrase 25: 521 bytes  said by sound command $24
L406A:  .word L6660, L68B0+5        ;phrase 26: 598 bytes  said by sound command $1C
L406E:  .word L68B6, L6AD6+7        ;phrase 27: 552 bytes  said by sound command $20
L4072:  .word L6ADE, L6ADE          ;phrase 28: 1 bytes  no command's word list holds phrase 28
L4076:  .word L6ADF, L6C87+1        ;phrase 29: 426 bytes  said by sound command $1D
L407A:  .word L6C89, L6DE1+2        ;phrase 30: 347 bytes  said by sound command $21
L407E:  .word L6DE4, L6F04+7        ;phrase 31: 296 bytes  said by sound command $23
L4082:  .word L6F0C, L707C+6        ;phrase 32: 375 bytes  said by sound command $1B
L4086:  .word L7083, L7163+3        ;phrase 33: 228 bytes  said by sound command $27
L408A:  .word L7167, L727F+1        ;phrase 34: 282 bytes  said by sound command $1F
L408E:  .word L7281, L7491+5        ;phrase 35: 534 bytes  said by sound command $1E (word 1 of 2)
L4092:  .word L7497, L764F+6        ;phrase 36: 447 bytes  said by sound command $1E (word 2 of 2)
L4096:  .word L7656, L7B16+5        ;phrase 37: 1222 bytes  said by sound command $22
L409A:  .word L7B1C, L7BF4+5        ;phrase 38: 222 bytes  said by sound command $25
L409E:  .word L7BFA, L7CB2+5        ;phrase 39: 190 bytes  said by sound command $26
L40A2:  .word L7CB8, L7CF0+6        ;phrase 40: 63 bytes  said by sound command $28, only when no speech is under way (SPITE)
L40A6:  .byte $0C, $30, $7D, $CA, $00, $B6, $54, $05 ;phrase 0, TMS5220 speech data
L40AE:  .byte $C0, $B5, $AC, $86, $47, $63, $1D, $C9
L40B6:  .byte $72, $0A, $11, $6C, $64, $9A, $28, $6D
L40BE:  .byte $78, $32, $92, $A5, $EA, $BA, $E1, $D9
L40C6:  .byte $A8, $8C, $B9, $9D, $81, $07, $E3, $55
L40CE:  .byte $6C, $4E, $17, $1E, $94, $67, $85, $5B
L40D6:  .byte $5D, $78, $D2, $5A, $A9, $6E, $B7, $01
L40DE:  .byte $3A, $FA, $2C, $3C, $E8, $88, $2A, $93
L40E6:  .byte $DB, $00, $53, $23, $1B, $60, $72, $D4
L40EE:  .byte $22, $A2, $D6, $4A, $77, $29, $05, $10
L40F6:  .byte $25, $AA, $00, $AE, $7B, $2F, $32, $19
L40FE:  .byte $F7, $4A, $13, $DB, $00, $3B, $32, $0A
L4106:  .byte $E0, $A2, $67, $01, $6C, $F0, $1C, $64
L410E:  .byte $36, $AA, $15, $61, $79, $91, $C9, $6A
L4116:  .byte $74, $98, $D4, $02, $B8, $E8, $DD, $00
L411E:  .byte $93, $A3, $16, $99, $94, $47, $84, $DB
L4126:  .byte $29, $80, $29, $11, $83, $8C, $3A, $BC
L412E:  .byte $DC, $E4, $0C, $32, $19, $8F, $0A, $95
L4136:  .byte $B2, $C8, $64, $C3, $A7, $54, $EE, $20
L413E:  .byte $A3, $4A, $8F, $54, $3B, $05, $30, $35
L4146:  .byte $AA, $00, $2E, $45, $16, $C0, $C6, $F2
L414E:  .byte $41, $27, $13, $99, $13, $F4, $12, $E0
L4156:  .byte $63, $E4, $A0, $B2, $F6, $88, $32, $39
L415E:  .byte $05, $30, $25, $B2, $00, $A6, $44, $25
L4166:  .byte $C0, $96, $CA, $02, $B8, $52, $95, $00
L416E:  .byte $9F, $AB, $06, $15, $7C, $D6, $4C, $DA
L4176:  .byte $49, $80, $99, $D1, $09, $30, $BB, $2A
L417E:  .byte $01, $FA, $46, $07, $40, $5E, $4F, $07
L4186:  .byte $E8, $17, $69, $00, $B5, $23, $0C, $20
L418E:  .byte $67, $B8, $01, $E4, $F0, $30, $80, $AE
L4196:  .byte $1E, $06, $D0, $35, $5D, $01, $A6, $95
L419E:  .byte $2B, $C0, $D4, $74, $01, $98, $98, $CE
L41A6:  .byte $00, $16, $CB, $19, $20, $53, $3A, $01
L41AE:  .byte $4C, $C8, $40, $00, $4B, $E5, $F0, $00
L41B6:  .byte $FF
L41B7:  .byte $02, $88, $8C, $4B, $01, $9E, $6B, $AF ;phrase 2, TMS5220 speech data
L41BF:  .byte $61, $16, $11, $F0, $5A, $BC, $C6, $11
L41C7:  .byte $48, $A8, $7A, $D6, $9A, $66, $60, $86
L41CF:  .byte $9E, $56, $6D, $AE, $1A, $D9, $A7, $13
L41D7:  .byte $95, $25, $4A, $49, $33, $69, $93, $D6
L41DF:  .byte $E0, $34, $99, $B2, $71, $59, $7C, $B0
L41E7:  .byte $20, $F1, $2D, $63, $89, $C6, $92, $55
L41EF:  .byte $B6, $AC, $25, $19, $4D, $31, $5B, $B3
L41F7:  .byte $D6, $68, $23, $85, $6A, $C9, $5A, $43
L41FF:  .byte $A8, $20, $89, $25, $63, $09, $BE, $82
L4207:  .byte $39, $36, $B7, $39, $98, $4C, $65, $DB
L420F:  .byte $DC, $D6, $CC, $CA, $94, $A5, $6D, $DA
L4217:  .byte $13, $37, $73, $91, $AE, $08, $00, $3D
L421F:  .byte $AD, $2C, $CB, $98, $6B, $B8, $E4, $00
L4227:  .byte $AC, $EA, $9A, $80, $59, $4C, $D6, $DC
L422F:  .byte $1C, $8B, $47, $A4, $5B, $6B, $D6, $96
L4237:  .byte $EA, $D2, $75, $AD, $45, $FB, $98, $62
L423F:  .byte $D6, $35, $27, $5F, $A3, $8A, $A9, $D7
L4247:  .byte $54, $9C, $B5, $29, $D6, $59, $53, $0B
L424F:  .byte $12, $6A, $9C, $74, $4D, $2D, $B1, $71
L4257:  .byte $48, $9D, $35, $35, $CF, $AA, $61, $B5
L425F:  .byte $C7, $52, $0C, $44, $78, $C6, $1D, $4B
L4267:  .byte $31, $50, $9E, $99, $74, $4D, $C5, $B0
L426F:  .byte $9B, $69, $9D, $35, $17, $AD, $EE, $C6
L4277:  .byte $B3, $D7, $54, $0C, $45, $9A, $D5, $5D
L427F:  .byte $63, $B5, $66, $29, $5C, $7B, $4D, $95
L4287:  .byte $9A, $5B, $58, $2A, $05, $FC, $1C, $69
L428F:  .byte $80, $13, $CC, $1C, $70, $AC, $86, $01
L4297:  .byte $4E, $70, $77, $C0, $4D, $6A, $06, $78
L429F:  .byte $81, $5D, $01, $C7, $72, $08, $E0, $06
L42A7:  .byte $77, $06, $34, $A2, $41, $80, $E4, $5B
L42AF:  .byte $11, $E0, $7C, $18, $02, $AC, $0E, $47
L42B7:  .byte $80, $D7, $E1, $08, $E0, $2A, $02, $01
L42BF:  .byte $CC, $A6, $B7, $29, $0B, $5B, $77, $72
L42C7:  .byte $37, $96, $60, $72, $59, $B9, $EB, $58
L42CF:  .byte $83, $A9, $25, $D5, $35, $6B, $0D, $B1
L42D7:  .byte $86, $45, $BB, $AE, $35, $A4, $1C, $34
L42DF:  .byte $5B, $B3, $D6, $58, $AD, $C8, $F2, $76
L42E7:  .byte $3A, $42, $0A, $53, $8B, $46, $61, $8D
L42EF:  .byte $26, $C2, $D4, $13, $99, $35, $4A, $77
L42F7:  .byte $57, $8B, $AD, $D6, $A0, $DD, $22, $C2
L42FF:  .byte $A4, $59, $82, $52, $F1, $C8, $58, $04
L4307:  .byte $00, $39, $02, $01, $40, $47, $20, $00
L430F:  .byte $08, $8F, $D1, $0D, $5D, $E6, $61, $91
L4317:  .byte $D6, $58, $9C, $86, $7B, $D5, $5E, $4B
L431F:  .byte $0E, $19, $EE, $DD, $78, $AD, $29, $77
L4327:  .byte $7A, $F4, $E2, $B5, $E5, $14, $63, $9E
L432F:  .byte $4B, $D6, $91, $72, $8E, $5B, $4E, $5E
L4337:  .byte $5B, $CE, $15, $E9, $BE, $68, $ED, $39
L433F:  .byte $64, $96, $79, $A3, $75, $64, $EF, $33
L4347:  .byte $AE, $B3, $D7, $51, $92, $77, $6A, $3D
L434F:  .byte $19, $47, $2D, $91, $AE, $59, $B9, $1D
L4357:  .byte $2D, $4B, $A4, $65, $95, $B1, $B5, $AC
L435F:  .byte $6E, $56, $75, $DA, $DE, $A2, $8A, $5B
L4367:  .byte $56, $6E, $47, $D5, $AC, $59, $59, $B5
L436F:  .byte $1D, $A3, $A8, $8A, $67, $94, $72, $8E
L4377:  .byte $80, $E2, $DD, $75, $CA, $39, $46, $28
L437F:  .byte $4A, $54, $29, $D7, $88, $C2, $92, $55
L4387:  .byte $35, $9D, $A3, $39, $83, $57, $95, $70
L438F:  .byte $8D, $A8, $88, $1D, $65, $D2, $55, $0D
L4397:  .byte $72, $5F, $85, $0E, $F7, $88, $C8, $96
L439F:  .byte $1D, $36, $DC, $A3, $28, $51, $67, $69
L43A7:  .byte $77, $8F, $E3, $4A, $96, $41, $10, $D0
L43AF:  .byte $3D, $09, $3C, $FF
L43B3:  .byte $02, $A8, $56, $62, $74, $5D, $73, $AB ;phrase 3, TMS5220 speech data
L43BB:  .byte $53, $FA, $D1, $36, $CD, $9D, $C1, $D9
L43C3:  .byte $4A, $57, $15, $75, $85, $AB, $15, $80
L43CB:  .byte $D3, $36, $0A, $C8, $C6, $53, $00, $D9
L43D3:  .byte $7A, $08, $A0, $9A, $30, $05, $54, $69
L43DB:  .byte $2A, $80, $6C, $DD, $19, $C0, $42, $56
L43E3:  .byte $AA, $B3, $C4, $EB, $42, $79, $AD, $2E
L43EB:  .byte $0A, $77, $0A, $A4, $8D, $2A, $4B, $DA
L43F3:  .byte $29, $B4, $33, $AA, $24, $79, $A7, $C9
L43FB:  .byte $CE, $A8, $B3, $A4, $9D, $A6, $28, $AB
L4403:  .byte $29, $92, $AA, $D3, $6B, $AF, $B6, $4A
L440B:  .byte $EA, $4A, $AB, $B5, $FA, $A6, $A8, $BB
L4413:  .byte $C8, $5E, $5B, $0A, $B7, $31, $E1, $36
L441B:  .byte $06, $58, $44, $4A, $01, $97, $AB, $19
L4423:  .byte $E0, $19, $73, $07, $04, $96, $B2, $BA
L442B:  .byte $AE, $DC, $24, $28, $6F, $1B, $32, $4B
L4433:  .byte $15, $8F, $3D, $65, $7C, $C5, $2C, $95
L443B:  .byte $E9, $18, $60, $0F, $66, $03, $B4, $48
L4443:  .byte $4E, $00, $49, $B5, $CC, $10, $A5, $44
L444B:  .byte $A4, $2A, $29, $6D, $12, $DA, $52, $98
L4453:  .byte $6D, $B5, $4D, $4A, $52, $73, $BA, $D5
L445B:  .byte $17, $25, $66, $25, $5D, $C3, $54, $8D
L4463:  .byte $98, $38, $75, $75, $53, $B5, $AC, $AE
L446B:  .byte $9A, $39, $4D, $C3, $9A, $B0, $73, $ED
L4473:  .byte $36, $AE, $2C, $82, $AE, $6B, $C7, $B8
L447B:  .byte $86, $28, $18, $AF, $1D, $E3, $48, $E6
L4483:  .byte $E0, $D2, $6C, $8C, $DD, $8A, $53, $73
L448B:  .byte $BA, $31, $35, $A5, $2D, $81, $EA, $DA
L4493:  .byte $5C, $85, $B6, $06, $79, $2F, $4B, $15
L449B:  .byte $92, $9C, $DC, $36, $2E, $78, $7D, $FF
L44A3:  .byte $04, $F0, $4F, $1C, $01, $3C, $7B, $10 ;phrase 4, TMS5220 speech data
L44AB:  .byte $40, $17, $0F, $06, $D8, $E5, $21, $00
L44B3:  .byte $B7, $DC, $05, $60, $7A, $A4, $02, $FC
L44BB:  .byte $CE, $0A, $40, $70, $39, $01, $08, $3E
L44C3:  .byte $36, $01, $A1, $55, $25, $C0, $F7, $8C
L44CB:  .byte $00, $04, $17, $15, $00, $3F, $A2, $13
L44D3:  .byte $E0, $43, $56, $00, $74, $CD, $0C, $40
L44DB:  .byte $F0, $B9, $09, $F0, $25, $2B, $01, $21
L44E3:  .byte $64, $27, $C0, $E7, $AC, $04, $84, $90
L44EB:  .byte $9D, $00, $5F, $B2, $12, $10, $62, $4D
L44F3:  .byte $00, $82, $8F, $0D, $80, $F7, $31, $01
L44FB:  .byte $08, $2E, $36, $00, $21, $D6, $04, $20
L4503:  .byte $A4, $4E, $07, $84, $5C, $E3, $80, $E0
L450B:  .byte $B3, $1D, $10, $5D, $8C, $03, $A2, $F5
L4513:  .byte $75, $80, $2F, $35, $06, $08, $21, $C7
L451B:  .byte $01, $21, $D6, $18, $20, $FA, $58, $03
L4523:  .byte $84, $98, $63, $00, $DF, $AB, $0D, $E0
L452B:  .byte $43, $8E, $01, $A2, $8F, $35, $40, $74
L4533:  .byte $B1, $06, $08, $3E, $C6, $00, $3E, $67
L453B:  .byte $2B, $C0, $E7, $2A, $05, $F8, $59, $A5
L4543:  .byte $80, $50, $6A, $04, $10, $62, $B5, $00
L454B:  .byte $42, $CA, $11, $80, $5F, $1E, $02, $F0
L4553:  .byte $B3, $8A, $00, $B6, $66, $12, $C0, $D7
L455B:  .byte $4C, $04, $98, $9C, $86, $00, $5F, $AA
L4563:  .byte $11, $10, $5C, $0C, $02, $BA, $0C, $7B
L456B:  .byte $FF
L456C:  .byte $08, $40, $33, $0D, $01, $7E, $40, $12 ;phrase 5, TMS5220 speech data
L4574:  .byte $C0, $6D, $2A, $06, $F8, $4A, $C9, $80
L457C:  .byte $B0, $39, $18, $10, $06, $94, $00, $42
L4584:  .byte $C7, $92, $80, $00, $4C, $C1, $12, $40
L458C:  .byte $68, $18, $02, $F0, $0D, $42, $00, $BE
L4594:  .byte $41, $32, $20, $4C, $2C, $01, $F8, $4E
L459C:  .byte $29, $00, $DF, $A0, $18, $10, $3A, $24
L45A4:  .byte $07, $18, $E0, $3B, $14, $03, $C2, $84
L45AC:  .byte $64, $40, $58, $98, $0C, $08, $13, $92
L45B4:  .byte $01, $BE, $43, $31, $C0, $4F, $4C, $06
L45BC:  .byte $F8, $06, $C5, $00, $3F, $A1, $19, $E0
L45C4:  .byte $27, $36, $03, $5C, $87, $22, $40, $18
L45CC:  .byte $90, $0C, $F0, $0D, $9A, $01, $76, $62
L45D4:  .byte $13, $C0, $0F, $48, $06, $84, $01, $49
L45DC:  .byte $80, $70, $31, $08, $E0, $27, $14, $01
L45E4:  .byte $C2, $86, $22, $80, $9B, $90, $04, $08
L45EC:  .byte $0B, $8A, $00, $71, $43, $11, $C0, $0D
L45F4:  .byte $4C, $04, $C4, $03, $8E, $80, $B0, $20
L45FC:  .byte $11, $E0, $06, $24, $02, $C2, $86, $44
L4604:  .byte $40, $D8, $10, $08, $88, $0F, $0C, $01
L460C:  .byte $7E, $41, $22, $C0, $0C, $30, $04, $F8
L4614:  .byte $8D, $8A, $00, $BF, $48, $11, $60, $26
L461C:  .byte $2B, $02, $C2, $21, $42, $80, $1E, $2A
L4624:  .byte $08, $08, $57, $08, $01, $B6, $BB, $20
L462C:  .byte $20, $3C, $41, $04, $E0, $E6, $F4, $00
L4634:  .byte $FF
L4635:  .byte $A2, $52, $36, $3D, $C2, $63, $A6, $2A ;phrase 6, TMS5220 speech data
L463D:  .byte $5A, $B5, $A0, $A8, $33, $AA, $1C, $29
L4645:  .byte $5C, $CB, $E9, $A8, $5B, $57, $31, $AB
L464D:  .byte $2A, $A3, $6E, $C5, $44, $65, $C6, $8E
L4655:  .byte $BA, $05, $63, $D3, $3A, $B3, $AA, $6A
L465D:  .byte $8C, $DD, $EA, $F2, $AA, $8A, $13, $77
L4665:  .byte $8B, $29, $0A, $68, $26, $55, $01, $53
L466D:  .byte $97, $29, $A0, $72, $17, $05, $34, $55
L4675:  .byte $AE, $80, $AA, $CB, $4B, $E6, $D3, $9A
L467D:  .byte $9A, $D4, $6E, $B9, $EF, $61, $C9, $DA
L4685:  .byte $6E, $E5, $21, $47, $84, $58, $B2, $95
L468D:  .byte $C7, $18, $EA, $96, $C9, $5B, $91, $0A
L4695:  .byte $79, $59, $A4, $71, $C0, $4E, $6B, $06
L469D:  .byte $98, $D8, $D4, $00, $4B, $84, $30, $A0
L46A5:  .byte $12, $61, $04, $04, $68, $96, $32, $6F
L46AD:  .byte $29, $3A, $DD, $CC, $CA, $AA, $27, $89
L46B5:  .byte $EC, $D9, $2B, $AB, $8E, $38, $AB, $66
L46BD:  .byte $A7, $DC, $85, $26, $93, $BC, $5D, $8B
L46C5:  .byte $55, $26, $EB, $1A, $92, $B7, $57, $5D
L46CD:  .byte $A3, $A1, $A7, $4F, $49, $7D, $71, $2C
L46D5:  .byte $19, $59, $5A, $00, $89, $89, $0B, $A0
L46DD:  .byte $0B, $65, $01, $64, $41, $5E, $FA, $CC
L46E5:  .byte $C5, $BB, $2A, $4C, $E9, $B2, $64, $EF
L46ED:  .byte $C9, $D2, $A5, $2B, $4E, $34, $32, $26
L46F5:  .byte $87, $21, $66, $75, $D5, $AC, $62, $86
L46FD:  .byte $E8, $3D, $54, $24, $F2, $03, $FF
L4704:  .byte $0C, $E8, $8E, $48, $01, $B3, $85, $1A ;phrase 7, TMS5220 speech data
L470C:  .byte $60, $EE, $72, $03, $8C, $BD, $E1, $80
L4714:  .byte $79, $37, $0C, $30, $F7, $46, $4B, $7A
L471C:  .byte $15, $25, $8D, $D6, $2B, $EC, $89, $84
L4724:  .byte $33, $16, $37, $AF, $06, $70, $9D, $9A
L472C:  .byte $33, $FC, $12, $28, $25, $73, $C9, $08
L4734:  .byte $73, $D4, $22, $F5, $35, $2B, $CC, $4A
L473C:  .byte $DB, $59, $97, $AD, $A8, $28, $99, $24
L4744:  .byte $5E, $3A, $92, $66, $70, $C5, $A8, $4B
L474C:  .byte $2A, $AA, $C1, $4C, $E6, $64, $A4, $A9
L4754:  .byte $8A, $CA, $8C, $93, $AE, $B2, $5A, $2D
L475C:  .byte $15, $6A, $B7, $8A, $E2, $AC, $55, $A4
L4764:  .byte $DD, $CA, $A3, $89, $4A, $D1, $65, $2B
L476C:  .byte $0B, $76, $C2, $4D, $E6, $AE, $3C, $9A
L4774:  .byte $CA, $74, $5A, $BB, $8A, $64, $DB, $35
L477C:  .byte $68, $EB, $AA, $73, $2A, $57, $E3, $2D
L4784:  .byte $AB, $2D, $26, $52, $D0, $D6, $8E, $AE
L478C:  .byte $E8, $0E, $41, $5D, $33, $C6, $AB, $CD
L4794:  .byte $23, $48, $ED, $18, $5F, $30, $F7, $64
L479C:  .byte $BA, $61, $6E, $54, $3D, $44, $DD, $98
L47A4:  .byte $29, $E3, $08, $13, $4B, $63, $C6, $A2
L47AC:  .byte $30, $D6, $28, $99, $EB, $B3, $C4, $6E
L47B4:  .byte $11, $FB, $A9, $48, $82, $3A, $59, $94
L47BC:  .byte $AD, $30, $98, $29, $E3, $A8, $BB, $82
L47C4:  .byte $A4, $A7, $8C, $73, $8E, $03, $A2, $1B
L47CC:  .byte $73, $80, $8F, $29, $06, $D8, $44, $CD
L47D4:  .byte $01, $DF, $99, $2B, $E0, $69, $73, $06
L47DC:  .byte $0C, $C8, $02, $02, $08, $CE, $0D, $42
L47E4:  .byte $EB, $AD, $AB, $7A, $24, $1A, $79, $F3
L47EC:  .byte $EC, $EC, $D6, $64, $95, $DD, $A1, $49
L47F4:  .byte $D6, $9C, $95, $F7, $20, $4C, $95, $8B
L47FC:  .byte $5D, $1E, $24, $7B, $77, $48, $04, $05
L4804:  .byte $64, $D3, $9A, $B2, $4A, $2D, $5A, $34
L480C:  .byte $69, $CB, $83, $F4, $51, $F6, $D6, $2B
L4814:  .byte $CB, $32, $DB, $D8, $EE, $AD, $34, $DA
L481C:  .byte $68, $D6, $5E, $B2, $92, $6C, $A3, $15
L4824:  .byte $6B, $CD, $CA, $93, $CA, $0A, $8A, $75
L482C:  .byte $6B, $CC, $3A, $2A, $49, $DE, $AD, $A9
L4834:  .byte $48, $AB, $62, $5E, $37, $E6, $AC, $BC
L483C:  .byte $9C, $74, $59, $5A, $93, $2B, $67, $F6
L4844:  .byte $3B, $02, $B0, $55, $58, $00, $81, $65
L484C:  .byte $31, $20, $22, $1F, $01, $34, $C8, $29
L4854:  .byte $80, $2D, $59, $18, $70, $30, $18, $02
L485C:  .byte $6C, $15, $16, $C0, $82, $A2, $08, $E8
L4864:  .byte $D8, $F5, $01, $FF
L4868:  .byte $26, $F7, $55, $8D, $C3, $3B, $96, $24 ;phrase 8, TMS5220 speech data
L4870:  .byte $3B, $72, $6F, $7B, $32, $A2, $A6, $4C
L4878:  .byte $A9, $7D, $CE, $88, $9A, $F5, $20, $97
L4880:  .byte $3B, $2E, $0A, $B4, $5D, $33, $2C, $1A
L4888:  .byte $60, $32, $75, $03, $4C, $ED, $86, $81
L4890:  .byte $61, $A6, $58, $23, $6A, $49, $87, $99
L4898:  .byte $43, $6D, $A8, $27, $5E, $7A, $F6, $3D
L48A0:  .byte $9A, $DE, $78, $69, $25, $4E, $A9, $65
L48A8:  .byte $D2, $65, $74, $AF, $E5, $E2, $8D, $99
L48B0:  .byte $D1, $BD, $35, $93, $B5, $59, $56, $77
L48B8:  .byte $12, $2A, $D6, $76, $D9, $2D, $5A, $A1
L48C0:  .byte $59, $1A, $E5, $76, $CF, $C9, $2A, $CB
L48C8:  .byte $96, $DB, $9C, $24, $6A, $CE, $19, $5E
L48D0:  .byte $73, $EA, $AC, $76, $A7, $F8, $45, $73
L48D8:  .byte $99, $4B, $55, $97, $24, $21, $E1, $2E
L48E0:  .byte $75, $C0, $00, $55, $B1, $34, $BD, $18
L48E8:  .byte $71, $8F, $A8, $B4, $B4, $94, $55, $23
L48F0:  .byte $33, $F6, $52, $4B, $36, $4F, $33, $D7
L48F8:  .byte $4B, $CD, $29, $42, $42, $D2, $2C, $A3
L4900:  .byte $64, $55, $73, $6D, $B3, $EC, $6A, $5D
L4908:  .byte $24, $AD, $F7, $72, $AA, $73, $A5, $B6
L4910:  .byte $4E, $CB, $A9, $31, $5D, $93, $7A, $2F
L4918:  .byte $37, $C5, $1A, $73, $6E, $3C, $DC, $64
L4920:  .byte $72, $D9, $2C, $73, $73, $83, $AB, $21
L4928:  .byte $D1, $C6, $CD, $09, $A1, $46, $D9, $AC
L4930:  .byte $0E, $37, $DA, $9C, $C0, $8C, $37, $DC
L4938:  .byte $14, $EA, $DA, $42, $ED, $F0, $92, $CF
L4940:  .byte $4D, $0E, $27, $C3, $4B, $31, $C7, $35
L4948:  .byte $5C, $0F, $2F, $D5, $2A, $09, $6F, $0C
L4950:  .byte $06, $88, $41, $3C, $B8, $2D, $87, $6A
L4958:  .byte $A9, $E2, $E4, $E7, $AE, $C6, $C5, $9D
L4960:  .byte $4B, $98, $BC, $B8, $AE, $B6, $4D, $49
L4968:  .byte $0A, $E4, $5E, $D9, $2E, $E4, $C5, $9B
L4970:  .byte $92, $65, $5B, $05, $14, $A4, $21, $80
L4978:  .byte $41, $55, $18, $D0, $44, $28, $01, $1A
L4980:  .byte $71, $41, $40, $90, $42, $0F, $FF
L4987:  .byte $21, $2B, $99, $0D, $09, $49, $A6, $34 ;phrase 9, TMS5220 speech data
L498F:  .byte $55, $35, $09, $49, $5B, $92, $58, $CD
L4997:  .byte $25, $A9, $D9, $88, $63, $8A, $E0, $34
L499F:  .byte $AF, $2B, $C8, $21, $53, $82, $DD, $0D
L49A7:  .byte $37, $B9, $4A, $0E, $EB, $B6, $9C, $E4
L49AF:  .byte $D2, $A5, $BC, $CD, $72, $B3, $4D, $93
L49B7:  .byte $8E, $2C, $2B, $69, $2E, $92, $52, $DA
L49BF:  .byte $AE, $A8, $39, $73, $2E, $5E, $BD, $E2
L49C7:  .byte $62, $4D, $35, $7D, $75, $8B, $8B, $74
L49CF:  .byte $B5, $88, $C6, $AD, $78, $D6, $CC, $CC
L49D7:  .byte $92, $3A, $60, $59, $76, $03, $2C, $63
L49DF:  .byte $DE, $C2, $41, $23, $4D, $AD, $F5, $08
L49E7:  .byte $4B, $E8, $12, $B1, $36, $2B, $A8, $26
L49EF:  .byte $C7, $54, $D3, $2C, $AF, $DA, $6A, $71
L49F7:  .byte $49, $3B, $BC, $A2, $AD, $74, $D8, $6E
L49FF:  .byte $09, $B2, $A1, $F4, $E2, $BA, $2E, $48
L4A07:  .byte $CA, $D3, $52, $D3, $80, $01, $8A, $73
L4A0F:  .byte $35, $40, $72, $46, $2D, $CF, $29, $24
L4A17:  .byte $C3, $1A, $8F, $BC, $E4, $CC, $62, $ED
L4A1F:  .byte $B2, $F2, $92, $AB, $DD, $34, $F5, $CA
L4A27:  .byte $6B, $9C, $32, $97, $CC, $2B, $EB, $AE
L4A2F:  .byte $CB, $5C, $5D, $AF, $AC, $C5, $4E, $76
L4A37:  .byte $ED, $BC, $D2, $EE, $C2, $29, $A2, $71
L4A3F:  .byte $4B, $8B, $62, $B7, $D2, $28, $29, $CD
L4A47:  .byte $8A, $23, $D2, $62, $99, $CC, $A9, $E8
L4A4F:  .byte $08, $B7, $8D, $00, $92, $33, $55, $E6
L4A57:  .byte $B4, $BA, $B5, $DA, $12, $99, $8F, $C4
L4A5F:  .byte $E6, $22, $0A, $01, $21, $2A, $23, $A0
L4A67:  .byte $CB, $B0, $07, $FF
L4A6B:  .byte $43, $AF, $B6, $38, $64, $A2, $0E, $2D ;phrase 10, TMS5220 speech data
L4A73:  .byte $A5, $F2, $9A, $88, $33, $94, $EC, $37
L4A7B:  .byte $73, $B2, $D4, $90, $72, $1C, $CF, $F5
L4A83:  .byte $28, $43, $AC, $C1, $4B, $6C, $A2, $0C
L4A8B:  .byte $AE, $A4, $48, $B7, $76, $32, $B8, $EC
L4A93:  .byte $BA, $BC, $AA, $E6, $E0, $B2, $9B, $75
L4A9B:  .byte $93, $25, $8D, $CB, $71, $D7, $4D, $A2
L4AA3:  .byte $0E, $2E, $95, $6D, $73, $B7, $3A, $F8
L4AAB:  .byte $92, $C6, $BD, $D4, $F5, $E0, $73, $2E
L4AB3:  .byte $F7, $E4, $24, $85, $4F, $B9, $CD, $8B
L4ABB:  .byte $A5, $26, $21, $D5, $56, $4F, $91, $5A
L4AC3:  .byte $F8, $74, $58, $2B, $DC, $69, $11, $CA
L4ACB:  .byte $63, $AD, $A0, $26, $4D, $6E, $39, $55
L4AD3:  .byte $D4, $23, $1B, $A0, $53, $17, $01, $34
L4ADB:  .byte $AC, $86, $80, $00, $5D, $C0, $00, $43
L4AE3:  .byte $85, $1B, $A0, $7A, $8F, $C1, $94, $64
L4AEB:  .byte $62, $E2, $51, $06, $DD, $45, $8B, $29
L4AF3:  .byte $55, $1D, $4C, $97, $29, $C5, $54, $7B
L4AFB:  .byte $70, $43, $85, $84, $52, $95, $24, $6F
L4B03:  .byte $19, $22, $66, $B6, $09, $10, $51, $39
L4B0B:  .byte $08, $60, $04, $F6, $42, $37, $13, $A9
L4B13:  .byte $6A, $96, $07, $93, $4B, $A7, $94, $B8
L4B1B:  .byte $19, $4C, $2E, $D5, $12, $91, $78, $30
L4B23:  .byte $29, $75, $4B, $65, $ED, $C1, $A6, $3C
L4B2B:  .byte $65, $9E, $49, $06, $9B, $E3, $8F, $87
L4B33:  .byte $C6, $1D, $5C, $09, $9B, $61, $5E, $A3
L4B3B:  .byte $89, $D5, $AC, $16, $69, $ED, $64, $54
L4B43:  .byte $D9, $9A, $64, $0D, $19, $10, $54, $09
L4B4B:  .byte $01, $9C, $50, $0D, $7A, $DC, $6A, $E5
L4B53:  .byte $1C, $A7, $E9, $69, $99, $A5, $8B, $B2
L4B5B:  .byte $60, $86, $65, $12, $26, $71, $11, $C0
L4B63:  .byte $27, $19, $02, $48, $37, $2D, $66, $C8
L4B6B:  .byte $D9, $86, $51, $B9, $19, $C9, $D6, $14
L4B73:  .byte $5A, $92, $61, $24, $77, $59, $14, $53
L4B7B:  .byte $87, $99, $FD, $86, $5B, $35, $19, $4E
L4B83:  .byte $76, $DD, $ED, $35, $7B, $B8, $C5, $57
L4B8B:  .byte $66, $F4, $92, $E1, $D5, $E8, $1D, $D1
L4B93:  .byte $75, $86, $DF, $92, $55, $EA, $34, $69
L4B9B:  .byte $61, $4B, $D2, $11, $99, $48, $00, $59
L4BA3:  .byte $BA, $32, $A0, $61, $53, $60, $40, $97
L4BAB:  .byte $1C, $C5, $AB, $C1, $85, $D2, $EB, $94
L4BB3:  .byte $A8, $44, $27, $2F, $6B, $93, $92, $9C
L4BBB:  .byte $98, $3A, $6C, $B1, $2B, $4A, $16, $4A
L4BC3:  .byte $B7, $D5, $0C, $30, $4E, $93, $01, $99
L4BCB:  .byte $B9, $32, $A0, $51, $57, $04, $34, $66
L4BD3:  .byte $FA, $00, $FF
L4BD6:  .byte $C1, $3B, $41, $84, $7C, $42, $37, $6D ;phrase 11, TMS5220 speech data
L4BDE:  .byte $45, $15, $B4, $8A, $BC, $84, $DE, $8C
L4BE6:  .byte $D8, $3D, $F2, $60, $8B, $53, $33, $B6
L4BEE:  .byte $3A, $83, $2D, $3A, $D8, $C5, $AA, $0E
L4BF6:  .byte $61, $5A, $43, $0D, $8F, $DD, $94, $15
L4BFE:  .byte $5C, $55, $55, $4E, $93, $B7, $6F, $13
L4C06:  .byte $D6, $C8, $83, $EF, $A3, $D8, $4C, $1C
L4C0E:  .byte $35, $A1, $CC, $62, $77, $69, $D4, $A4
L4C16:  .byte $DC, $9C, $A2, $B4, $D5, $50, $72, $2A
L4C1E:  .byte $F1, $32, $27, $45, $CF, $C1, $A3, $5C
L4C26:  .byte $1C, $15, $31, $E6, $C8, $54, $AB, $B4
L4C2E:  .byte $84, $14, $BB, $C3, $DD, $EB, $12, $53
L4C36:  .byte $CC, $F0, $8A, $6C, $43, $4E, $39, $2C
L4C3E:  .byte $DB, $92, $3A, $2B, $16, $E3, $34, $8B
L4C46:  .byte $8C, $80, $D0, $58, $41, $01, $C5, $86
L4C4E:  .byte $27, $2A, $A9, $F2, $20, $2B, $5B, $E8
L4C56:  .byte $68, $AB, $8C, $7C, $6A, $A1, $62, $AC
L4C5E:  .byte $61, $CA, $C6, $85, $4E, $2E, $4B, $B9
L4C66:  .byte $2C, $17, $A6, $4A, $A9, $92, $94, $5D
L4C6E:  .byte $D8, $A6, $28, $4A, $CA, $96, $01, $9A
L4C76:  .byte $30, $6B, $62, $37, $A9, $21, $65, $69
L4C7E:  .byte $89, $C3, $BA, $26, $57, $95, $24, $57
L4C86:  .byte $29, $91, $94, $52, $82, $DA, $24, $79
L4C8E:  .byte $53, $8A, $55, $4E, $E5, $66, $2D, $49
L4C96:  .byte $19, $0C, $D0, $8C, $67, $E3, $8B, $2E
L4C9E:  .byte $B5, $88, $C8, $83, $8D, $A9, $CB, $3C
L4CA6:  .byte $12, $35, $36, $A5, $49, $B5, $68, $3C
L4CAE:  .byte $B8, $14, $3B, $5D, $DD, $E9, $E0, $B3
L4CB6:  .byte $AF, $4C, $31, $E5, $45, $CA, $66, $2A
L4CBE:  .byte $D0, $C7, $1A, $25, $BA, $61, $F6, $AA
L4CC6:  .byte $A8, $80, $5E, $CA, $0D, $30, $43, $58
L4CCE:  .byte $93, $AA, $65, $CF, $36, $DB, $43, $ED
L4CD6:  .byte $4D, $34, $AA, $22, $0F, $73, $24, $96
L4CDE:  .byte $A8, $B2, $33, $9C, $91, $85, $3C, $CA
L4CE6:  .byte $EE, $70, $47, $11, $74, $EF, $29, $21
L4CEE:  .byte $E9, $46, $B5, $5C, $A4, $BA, $C4, $DB
L4CF6:  .byte $70, $65, $9D, $12, $92, $64, $A6, $8C
L4CFE:  .byte $69, $89, $CB, $7C, $ED, $40, $CD, $39
L4D06:  .byte $A6, $0C, $71, $83, $C4, $E7, $20, $C0
L4D0E:  .byte $6C, $47, $01, $34, $9C, $2E, $01, $04
L4D16:  .byte $14, $E8, $FA, $00, $FF
L4D1B:  .byte $0A, $28, $D3, $65, $F0, $59, $97, $85 ;phrase 12, TMS5220 speech data
L4D23:  .byte $C4, $BC, $C1, $E6, $58, $65, $EA, $71
L4D2B:  .byte $07, $9D, $AC, $E7, $64, $C6, $6B, $54
L4D33:  .byte $CA, $DD, $29, $61, $57, $01, $59, $55
L4D3B:  .byte $2A, $A0, $89, $F0, $C1, $E6, $14, $91
L4D43:  .byte $29, $B5, $06, $53, $6A, $B8, $5A, $AC
L4D4B:  .byte $29, $6C, $D1, $65, $AE, $15, $A5, $71
L4D53:  .byte $D5, $94, $07, $DB, $95, $C1, $65, $3B
L4D5B:  .byte $11, $AA, $CD, $06, $9F, $D2, $A4, $8B
L4D63:  .byte $25, $6D, $7C, $B4, $1D, $2E, $55, $AD
L4D6B:  .byte $F1, $21, $56, $A8, $77, $BC, $C1, $65
L4D73:  .byte $DF, $11, $56, $71, $06, $97, $5D, $66
L4D7B:  .byte $D4, $46, $1E, $42, $F3, $AE, $DE, $AB
L4D83:  .byte $68, $C8, $23, $85, $6A, $97, $93, $E1
L4D8B:  .byte $CC, $3E, $22, $12, $51, $92, $37, $83
L4D93:  .byte $91, $45, $44, $0A, $61, $0B, $6D, $A6
L4D9B:  .byte $2E, $85, $01, $55, $08, $33, $20, $33
L4DA3:  .byte $F1, $A6, $37, $E3, $E2, $D2, $55, $83
L4DAB:  .byte $1E, $75, $68, $DA, $54, $15, $40, $32
L4DB3:  .byte $61, $4E, $49, $25, $5D, $31, $6D, $37
L4DBB:  .byte $29, $E6, $49, $F1, $89, $3C, $84, $94
L4DC3:  .byte $AE, $A4, $D3, $F2, $E0, $4A, $EC, $B0
L4DCB:  .byte $EC, $68, $83, $6F, $C1, $CC, $73, $CC
L4DD3:  .byte $05, $BD, $19, $57, $D7, $94, $82, $00
L4DDB:  .byte $6F, $CC, $8A, $30, $7A, $8A, $B2, $87
L4DE3:  .byte $6E, $C2, $68, $2D, $A2, $3E, $65, $88
L4DEB:  .byte $AD, $88, $64, $66, $D5, $21, $E7, $6C
L4DF3:  .byte $9E, $11, $5D, $86, $92, $4B, $69, $B4
L4DFB:  .byte $B5, $1D, $4A, $CA, $A9, $D1, $96, $6C
L4E03:  .byte $C8, $A9, $96, $47, $6A, $DC, $26, $A6
L4E0B:  .byte $56, $95, $26, $F2, $06, $9F, $52, $86
L4E13:  .byte $99, $B6, $1D, $5C, $11, $D9, $AE, $E1
L4E1B:  .byte $BA, $B0, $9D, $64, $07, $A5, $93, $C2
L4E23:  .byte $35, $96, $69, $68, $4E, $07, $37, $6D
L4E2B:  .byte $B8, $48, $DB, $19, $C2, $4A, $CE, $62
L4E33:  .byte $69, $C5, $18, $8D, $B0, $56, $A5, $18
L4E3B:  .byte $02, $74, $CC, $6A, $80, $29, $4C, $1D
L4E43:  .byte $30, $95, $69, $E1, $87, $37, $16, $2D
L4E4B:  .byte $2B, $83, $1F, $BD, $48, $BD, $9A, $0C
L4E53:  .byte $A1, $F7, $64, $F5, $AE, $3A, $84, $DE
L4E5B:  .byte $53, $25, $3A, $CE, $10, $5B, $CE, $24
L4E63:  .byte $6F, $DB, $45, $E9, $36, $2C, $C4, $1D
L4E6B:  .byte $33, $20, $0A, $0D, $06, $44, $6E, $51
L4E73:  .byte $8C, $EA, $CB, $0C, $BD, $6E, $B2, $AA
L4E7B:  .byte $09, $35, $CA, $29, $04, $F0, $C4, $43
L4E83:  .byte $00, $5D, $84, $31, $A0, $73, $53, $04
L4E8B:  .byte $74, $19, $06, $85, $EF, $3E, $CD, $38
L4E93:  .byte $AA, $0E, $3E, $E5, $B0, $6C, $8F, $3C
L4E9B:  .byte $C4, $5C, $26, $BC, $A2, $49, $93, $72
L4EA3:  .byte $D8, $8E, $AA, $4A, $43, $CE, $61, $C3
L4EAB:  .byte $BB, $66, $0F, $25, $BB, $49, $EF, $6E
L4EB3:  .byte $12, $D4, $E2, $AA, $52, $7B, $0A, $03
L4EBB:  .byte $A2, $0D, $2B, $6E, $4F, $21, $AA, $36
L4EC3:  .byte $B9, $F8, $A3, $34, $9A, $F8, $E8, $10
L4ECB:  .byte $74, $CB, $74, $E4, $D6, $42, $D4, $8D
L4ED3:  .byte $D0, $A2, $DB, $0B, $69, $37, $AC, $85
L4EDB:  .byte $5E, $B7, $E4, $CD, $84, $A9, $4E, $59
L4EE3:  .byte $97, $7B, $9F, $EA, $51, $64, $10, $40
L4EEB:  .byte $52, $16, $02, $68, $C8, $40, $40, $97
L4EF3:  .byte $61, $0F, $FF
L4EF6:  .byte $AE, $09, $AE, $42, $CC, $16, $A5, $BA ;phrase 13, TMS5220 speech data
L4EFE:  .byte $46, $55, $76, $6F, $52, $AA, $96, $5D
L4F06:  .byte $A0, $7D, $8E, $29, $AA, $31, $C3, $B4
L4F0E:  .byte $C6, $08, $00, $4E, $13, $14, $D0, $52
L4F16:  .byte $FB, $CA, $8A, $55, $75, $EF, $DA, $2B
L4F1E:  .byte $EB, $31, $15, $CD, $57, $8D, $BC, $79
L4F26:  .byte $62, $AF, $5C, $E4, $B2, $62, $58, $3D
L4F2E:  .byte $AB, $02, $01, $9C, $D2, $52, $C0, $32
L4F36:  .byte $6C, $2B, $A9, $C2, $42, $BD, $66, $AD
L4F3E:  .byte $2C, $AB, $52, $8D, $4D, $BC, $B2, $12
L4F46:  .byte $5A, $45, $BA, $31, $C9, $A3, $4F, $57
L4F4E:  .byte $AF, $D6, $02, $88, $AA, $55, $00, $99
L4F56:  .byte $59, $1B, $60, $CD, $50, $03, $9C, $66
L4F5E:  .byte $32, $CA, $A9, $29, $93, $BD, $F1, $AA
L4F66:  .byte $8A, $8E, $26, $AD, $DA, $A3, $4D, $A5
L4F6E:  .byte $54, $AC, $27, $A7, $3E, $D4, $10, $F3
L4F76:  .byte $AE, $E3, $86, $20, $DA, $D4, $B2, $A6
L4F7E:  .byte $1A, $82, $4C, $F3, $B0, $D8, $0A, $C8
L4F86:  .byte $D2, $7D, $0C, $4D, $49, $AA, $D7, $EC
L4F8E:  .byte $D6, $57, $67, $68, $5B, $55, $C3, $50
L4F96:  .byte $B5, $50, $76, $C7, $1E, $4D, $73, $4E
L4F9E:  .byte $7A, $59, $7B, $35, $4D, $65, $70, $E5
L4FA6:  .byte $EC, $D5, $E6, $90, $C1, $55, $53, $56
L4FAE:  .byte $9D, $43, $A5, $44, $4D, $5E, $75, $B1
L4FB6:  .byte $9D, $22, $35, $2B, $E4, $45, $56, $30
L4FBE:  .byte $E5, $4C, $05, $0C, $8A, $69, $80, $9D
L4FC6:  .byte $49, $56, $55, $A5, $17, $6B, $D7, $5A
L4FCE:  .byte $75, $31, $19, $6C, $5B, $6B, $35, $D9
L4FD6:  .byte $87, $4B, $4E, $95, $D1, $64, $17, $62
L4FDE:  .byte $B6, $75, $5D, $1B, $45, $5A, $C9, $98
L4FE6:  .byte $72, $63, $11, $66, $21, $15, $B9, $F4
L4FEE:  .byte $59, $5A, $98, $D5, $6C, $35, $39, $99
L4FF6:  .byte $E6, $5A, $B1, $D1, $A0, $6D, $8A, $78
L4FFE:  .byte $35, $6E, $6D, $36, $66, $E2, $99, $78
L5006:  .byte $55, $39, $A8, $6A, $F6, $EC, $55, $17
L500E:  .byte $6F, $E2, $3D, $51, $56, $DB, $B4, $A9
L5016:  .byte $C6, $54, $5E, $7D, $53, $2A, $1A, $5B
L501E:  .byte $45, $01, $C3, $8A, $2A, $60, $25, $33
L5026:  .byte $05, $EC, $22, $A4, $80, $9D, $98, $38
L502E:  .byte $80, $01, $78, $FF
L5032:  .byte $0C, $D8, $C5, $54, $00, $BB, $AD, $81 ;phrase 14, TMS5220 speech data
L503A:  .byte $00, $A6, $E7, $18, $65, $B6, $99, $64
L5042:  .byte $39, $67, $D5, $31, $A4, $69, $77, $A2
L504A:  .byte $51, $A7, $54, $C6, $11, $B3, $57, $9B
L5052:  .byte $62, $A9, $55, $D5, $1E, $7D, $51, $DA
L505A:  .byte $AA, $35, $2B, $0C, $53, $BA, $99, $79
L5062:  .byte $6C, $02, $B0, $94, $D6, $BA, $E1, $4C
L506A:  .byte $34, $A2, $F2, $E8, $9B, $57, $E6, $AA
L5072:  .byte $31, $6D, $AC, $86, $D4, $33, $27, $B7
L507A:  .byte $A1, $59, $D2, $C8, $98, $9A, $86, $E4
L5082:  .byte $4C, $D5, $7D, $4A, $18, $53, $48, $13
L508A:  .byte $A1, $5A, $69, $48, $35, $4C, $54, $6A
L5092:  .byte $8F, $3E, $06, $0B, $F3, $9C, $BC, $FA
L509A:  .byte $62, $D2, $25, $FC, $CE, $EA, $73, $08
L50A2:  .byte $B5, $CC, $2A, $6B, $28, $59, $5C, $AA
L50AA:  .byte $A3, $B4, $BE, $25, $85, $4A, $6F, $02
L50B2:  .byte $0A, $E8, $41, $B8, $0C, $D9, $B2, $7A
L50BA:  .byte $E5, $D4, $36, $46, $6F, $66, $6E, $8B
L50C2:  .byte $D3, $E0, $AB, $98, $57, $4D, $69, $63
L50CA:  .byte $48, $6A, $5E, $35, $65, $4C, $D1, $AB
L50D2:  .byte $7B, $D7, $D4, $36, $47, $A5, $55, $9D
L50DA:  .byte $A3, $DB, $52, $14, $BB, $4F, $57, $19
L50E2:  .byte $EB, $30, $64, $96, $51, $A7, $AD, $B3
L50EA:  .byte $9B, $B2, $69, $12, $03, $8C, $66, $6E
L50F2:  .byte $80, $51, $33, $18, $30, $B6, $A9, $59
L50FA:  .byte $03, $A3, $8E, $F4, $54, $66, $93, $C2
L5102:  .byte $72, $C4, $6D, $AA, $9D, $D8, $8A, $D4
L510A:  .byte $90, $A8, $76, $C7, $C2, $CD, $5A, $96
L5112:  .byte $38, $02, $54, $0E, $55, $2B, $0F, $FF
L511A:  .byte $29, $6E, $3E, $45, $DC, $93, $AE, $A4 ;phrase 15, TMS5220 speech data
L5122:  .byte $5B, $25, $CB, $9A, $A2, $C2, $1E, $8C
L512A:  .byte $34, $7C, $B6, $01, $06, $17, $77, $40
L5132:  .byte $CB, $4D, $0C, $C8, $43, $D9, $69, $29
L513A:  .byte $90, $4B, $94, $ED, $61, $B6, $88, $E1
L5142:  .byte $19, $72, $8B, $51, $24, $97, $9B, $30
L514A:  .byte $4B, $76, $83, $E6, $15, $E2, $A4, $F8
L5152:  .byte $39, $99, $DB, $B8, $AC, $92, $E5, $5C
L515A:  .byte $A6, $59, $92, $57, $95, $4A, $BA, $67
L5162:  .byte $CB, $5E, $4D, $CA, $69, $99, $6D, $35
L516A:  .byte $F5, $4D, $B4, $5B, $A6, $68, $03, $74
L5172:  .byte $E9, $E6, $80, $AE, $CC, $0C, $30, $85
L517A:  .byte $59, $B2, $4A, $14, $F3, $4C, $59, $CB
L5182:  .byte $CB, $99, $23, $AB, $AC, $AC, $28, $27
L518A:  .byte $77, $AF, $AE, $BA, $92, $1C, $23, $D4
L5192:  .byte $77, $EC, $CA, $52, $8C, $D0, $98, $32
L519A:  .byte $AB, $48, $D1, $43, $A2, $A2, $98, $21
L51A2:  .byte $79, $77, $D1, $0A, $65, $80, $41, $DC
L51AA:  .byte $15, $D0, $18, $1B, $01, $7C, $5E, $45
L51B2:  .byte $00, $B1, $EE, $18, $18, $59, $2A, $15
L51BA:  .byte $1A, $6D, $79, $C5, $39, $4E, $6A, $76
L51C2:  .byte $95, $95, $E5, $58, $EE, $9B, $76, $96
L51CA:  .byte $9B, $A3, $44, $75, $28, $19, $56, $D1
L51D2:  .byte $5A, $1E, $26, $AB, $38, $4D, $B2, $95
L51DA:  .byte $B9, $1C, $06, $58, $A3, $61, $80, $AA
L51E2:  .byte $45, $87, $9F, $95, $74, $AA, $AA, $0B
L51EA:  .byte $99, $B7, $3A, $A4, $99, $C6, $75, $49
L51F2:  .byte $A9, $BB, $7A, $64, $37, $A6, $60, $62
L51FA:  .byte $E1, $B1, $54, $93, $4C, $98, $93, $5B
L5202:  .byte $1E, $69, $4C, $63, $6A, $5E, $75, $A5
L520A:  .byte $29, $4D, $A9, $D4, $EC, $15, $A4, $3C
L5212:  .byte $21, $5E, $63, $9A, $17, $5B, $86, $65
L521A:  .byte $4A, $4D, $61, $17, $19, $AE, $61, $9A
L5222:  .byte $00, $46, $87, $82, $02, $26, $54, $5F
L522A:  .byte $6D, $F1, $21, $62, $39, $25, $35, $59
L5232:  .byte $AB, $93, $C7, $E4, $D4, $76, $CD, $2E
L523A:  .byte $6A, $8B, $5D, $DB, $14, $B9, $BB, $2D
L5242:  .byte $6A, $79, $B1, $EC, $62, $39, $67, $64
L524A:  .byte $49, $87, $AA, $FB, $9D, $94, $B9, $54
L5252:  .byte $22, $16, $73, $44, $1E, $A4, $7B, $98
L525A:  .byte $56, $02, $05, $D4, $A6, $1A, $8A, $65
L5262:  .byte $9C, $5C, $33, $EE, $2A, $9A, $67, $36
L526A:  .byte $DF, $3A, $A5, $9F, $CA, $54, $2C, $63
L5272:  .byte $1B, $60, $28, $13, $03, $24, $E4, $36
L527A:  .byte $F2, $EA, $99, $33, $43, $6C, $AA, $92
L5282:  .byte $A6, $11, $0B, $37, $AD, $A9, $C2, $2C
L528A:  .byte $CC, $6C, $AB, $BE, $1A, $F7, $54, $B5
L5292:  .byte $A2, $80, $62, $8C, $47, $5D, $6D, $B2
L529A:  .byte $5B, $CB, $0E, $55, $90, $3C, $66, $EE
L52A2:  .byte $DA, $34, $5E, $EB, $18, $87, $1B, $04
L52AA:  .byte $50, $11, $A6, $80, $2E, $55, $0D, $B0
L52B2:  .byte $6C, $88, $01, $8E, $66, $36, $C0, $F1
L52BA:  .byte $26, $01, $38, $CA, $7D, $F1, $CD, $8B
L52C2:  .byte $8A, $97, $EC, $25, $B5, $A4, $C6, $19
L52CA:  .byte $51, $8B, $DC, $3C, $07, $76, $D5, $2E
L52D2:  .byte $72, $6B, $19, $AA, $9A, $B4, $98, $B5
L52DA:  .byte $66, $98, $12, $ED, $52, $C7, $A6, $66
L52E2:  .byte $AA, $69, $DC, $E0, $8B, $B9, $89, $76
L52EA:  .byte $56, $4B, $10, $1E, $61, $6E, $07, $01
L52F2:  .byte $29, $B8, $B6, $34, $E4, $2C, $E4, $AA
L52FA:  .byte $53, $C2, $10, $62, $C0, $AA, $71, $70
L5302:  .byte $43, $F0, $86, $E8, $C4, $CE, $F5, $D6
L530A:  .byte $1B, $AD, $D3, $38, $2F, $46, $72, $8D
L5312:  .byte $4A, $8C, $00, $E0, $6B, $10, $C0, $49
L531A:  .byte $28, $02, $BA, $0C, $83, $A6, $0F, $67
L5322:  .byte $AA, $59, $4E, $96, $D1, $BC, $B0, $D7
L532A:  .byte $D8, $5D, $56, $31, $9C, $59, $EE, $64
L5332:  .byte $18, $45, $52, $56, $BB, $9D, $66, $34
L533A:  .byte $45, $99, $CA, $6E, $8B, $55, $B9, $B4
L5342:  .byte $29, $B5, $76, $BE, $77, $96, $62, $56
L534A:  .byte $DB, $25, $C6, $59, $AA, $46, $63, $53
L5352:  .byte $6A, $EB, $19, $6A, $8D, $5D, $1D, $53
L535A:  .byte $9A, $99, $C5, $16, $40, $2F, $E3, $A9
L5362:  .byte $E9, $B1, $58, $24, $9D, $B6, $A6, $14
L536A:  .byte $36, $8B, $68, $D4, $DA, $9C, $D5, $2D
L5372:  .byte $AB, $4A, $EB, $52, $75, $4D, $EF, $B0
L537A:  .byte $A9, $49, $25, $A5, $CA, $AC, $B8, $BA
L5382:  .byte $98, $76, $2E, $33, $F2, $00, $FF
L5389:  .byte $A9, $1B, $D1, $99, $50, $D2, $94, $BE ;phrase 16, TMS5220 speech data
L5391:  .byte $D9, $36, $16, $B1, $92, $DA, $20, $C3
L5399:  .byte $4B, $35, $4D, $EB, $B2, $96, $4E, $87
L53A1:  .byte $AE, $A3, $2B, $5C, $37, $12, $F2, $AC
L53A9:  .byte $AE, $19, $99, $34, $CA, $B3, $FA, $A2
L53B1:  .byte $65, $52, $B8, $6D, $1B, $B3, $D2, $0E
L53B9:  .byte $E1, $D4, $7E, $44, $00, $08, $91, $08
L53C1:  .byte $00, $2E, $0B, $03, $30, $BA, $AE, $DC
L53C9:  .byte $4C, $C3, $F1, $E8, $46, $53, $A6, $F0
L53D1:  .byte $DA, $23, $5E, $25, $0D, $24, $EC, $8C
L53D9:  .byte $7C, $C5, $64, $D4, $70, $E2, $DA, $65
L53E1:  .byte $48, $C4, $5B, $31, $02, $06, $54, $C1
L53E9:  .byte $00, $28, $60, $EA, $8E, $D2, $65, $2E
L53F1:  .byte $16, $99, $B5, $D3, $1A, $05, $67, $79
L53F9:  .byte $C6, $49, $6B, $96, $94, $1E, $96, $28
L5401:  .byte $6D, $23, $92, $72, $4A, $A3, $B4, $55
L5409:  .byte $85, $9E, $69, $99, $C2, $5A, $35, $78
L5411:  .byte $94, $AD, $0A, $5B, $95, $64, $61, $9E
L5419:  .byte $3A, $6C, $55, $89, $8B, $59, $EB, $74
L5421:  .byte $56, $C5, $EA, $16, $9E, $C3, $D1, $15
L5429:  .byte $9A, $A6, $BB, $11, $40, $94, $12, $0C
L5431:  .byte $C8, $8A, $8D, $00, $51, $70, $21, $A0
L5439:  .byte $5A, $0E, $78, $FF
L543D:  .byte $0C, $88, $0A, $3B, $C5, $3D, $31, $49 ;phrase 17, TMS5220 speech data
L5445:  .byte $67, $9D, $51, $8D, $AC, $84, $99, $73
L544D:  .byte $47, $3D, $AA, $12, $56, $2E, $1D, $F5
L5455:  .byte $E8, $4C, $D4, $39, $37, $35, $BD, $23
L545D:  .byte $6B, $D4, $1C, $33, $F5, $84, $64, $51
L5465:  .byte $4D, $10, $60, $05, $25, $08, $A0, $D4
L546D:  .byte $11, $05, $C4, $1A, $22, $00, $9F, $95
L5475:  .byte $53, $E1, $52, $B8, $8A, $DF, $19, $79
L547D:  .byte $E2, $D9, $1A, $D4, $76, $E4, $C9, $54
L5485:  .byte $42, $DA, $92, $56, $97, $C0, $C5, $AA
L548D:  .byte $6D, $5C, $1B, $95, $94, $AB, $27, $52
L5495:  .byte $43, $90, $16, $E1, $11, $53, $8C, $4E
L549D:  .byte $86, $45, $66, $44, $36, $59, $11, $1E
L54A5:  .byte $59, $A6, $A0, $8C, $DD, $86, $9B, $89
L54AD:  .byte $EC, $51, $B6, $E2, $4A, $A2, $6B, $56
L54B5:  .byte $D9, $AA, $31, $7A, $DC, $1D, $65, $2D
L54BD:  .byte $22, $18, $5D, $B7, $B5, $4D, $98, $A8
L54C5:  .byte $D7, $22, $07, $5C, $29, $E2, $80, $EB
L54CD:  .byte $CC, $0D, $F0, $82, $B1, $01, $AE, $77
L54D5:  .byte $57, $C0, $F7, $EA, $0A, $B8, $C6, $95
L54DD:  .byte $00, $57, $A8, $82, $03, $DA, $30, $77
L54E5:  .byte $40, $6B, $E3, $06, $A8, $6B, $BC, $65
L54ED:  .byte $B9, $98, $71, $8A, $BB, $95, $17, $67
L54F5:  .byte $A9, $85, $C9, $56, $5E, $94, $B5, $06
L54FD:  .byte $35, $5B, $79, $E6, $BE, $EA, $DC, $6C
L5505:  .byte $15, $95, $FB, $B2, $69, $D3, $55, $55
L550D:  .byte $E1, $C3, $A9, $6B, $57, $5B, $8D, $07
L5515:  .byte $A7, $3E, $59, $7D, $73, $6E, $54, $7A
L551D:  .byte $67, $F5, $25, $89, $68, $C7, $95, $35
L5525:  .byte $D6, $A8, $AA, $E9, $57, $D7, $54, $4C
L552D:  .byte $98, $B4, $3E, $59, $4B, $B1, $E9, $92
L5535:  .byte $FA, $64, $6C, $29, $B8, $59, $E4, $E5
L553D:  .byte $34, $45, $9B, $1A, $15, $53, $19, $90
L5545:  .byte $69, $B9, $00, $8E, $12, $15, $C0, $37
L554D:  .byte $A2, $02, $B8, $4A, $4D, $00, $4F, $88
L5555:  .byte $09, $E0, $29, $33, $01, $3C, $E5, $2A
L555D:  .byte $80, $67, $44, $19, $70, $84, $9B, $00
L5565:  .byte $9E, $B6, $64, $C0, $15, $16, $0C, $78
L556D:  .byte $9A, $9D, $01, $D7, $78, $10, $60, $63
L5575:  .byte $36, $04, $0C, $28, $FE, $00, $FF
L557C:  .byte $6A, $95, $A6, $22, $DC, $13, $A7, $A5 ;phrase 18, TMS5220 speech data
L5584:  .byte $28, $57, $4B, $8B, $DB, $A6, $2A, $D3
L558C:  .byte $C9, $E5, $E9, $1A, $07, $CB, $44, $D7
L5594:  .byte $B5, $6D, $9C, $24, $42, $D4, $3B, $1B
L559C:  .byte $E0, $1A, $31, $03, $7C, $63, $EA, $80
L55A4:  .byte $1F, $DC, $02, $F0, $BD, $87, $03, $AE
L55AC:  .byte $37, $5B, $59, $A5, $63, $EA, $59, $67
L55B4:  .byte $15, $D9, $57, $B2, $E5, $9C, $95, $37
L55BC:  .byte $55, $C3, $A6, $73, $56, $DE, $A5, $8D
L55C4:  .byte $9A, $4C, $5D, $79, $95, $5C, $EC, $E1
L55CC:  .byte $64, $15, $55, $72, $4A, $84, $9D, $51
L55D4:  .byte $56, $49, $A3, $AE, $D1, $56, $39, $94
L55DC:  .byte $8E, $2A, $2F, $5D, $55, $97, $36, $A2
L55E4:  .byte $BC, $76, $55, $4D, $D8, $88, $F2, $D2
L55EC:  .byte $D6, $76, $A1, $2D, $4A, $6D, $05, $D0
L55F4:  .byte $A8, $86, $01, $B6, $D2, $32, $C0, $33
L55FC:  .byte $6E, $0E, $78, $4A, $CD, $01, $4F, $B9
L5604:  .byte $05, $E0, $EB, $F4, $00, $7C, $99, $EA
L560C:  .byte $80, $23, $D3, $19, $30, $E8, $3A, $18
L5614:  .byte $A0, $76, $96, $55, $B5, $9C, $E4, $66
L561C:  .byte $8B, $57, $DD, $82, $59, $98, $DD, $5D
L5624:  .byte $75, $53, $95, $9A, $B4, $66, $D5, $D5
L562C:  .byte $54, $5A, $D0, $DA, $55, $97, $D0, $A9
L5634:  .byte $AE, $6F, $56, $5D, $42, $86, $9A, $BD
L563C:  .byte $5E, $75, $B5, $11, $5A, $F2, $64, $D5
L5644:  .byte $2D, $B8, $6A, $EA, $93, $55, $77, $EF
L564C:  .byte $C2, $C5, $4F, $56, $93, $A5, $99, $27
L5654:  .byte $3D, $49, $AD, $D3, $93, $96, $34, $C7
L565C:  .byte $75, $41, $44, $64, $F1, $24, $D3, $E9
L5664:  .byte $10, $1E, $E1, $91, $43, $6B, $DC, $B8
L566C:  .byte $A6, $D5, $4E, $8D, $67, $3B, $94, $1A
L5674:  .byte $B7, $D4, $91, $CC, $91, $4A, $9C, $56
L567C:  .byte $27, $9C, $27, $CA, $4D, $5B, $9D, $71
L5684:  .byte $9E, $18, $B7, $1D, $75, $41, $7E, $66
L568C:  .byte $D4, $74, $D4, $05, $FB, $99, $61, $B3
L5694:  .byte $D1, $64, $1C, $67, $8E, $75, $53, $65
L569C:  .byte $F3, $25, $84, $CF, $76, $65, $26, $33
L56A4:  .byte $E2, $96, $18, $01, $DC, $B5, $83, $00
L56AC:  .byte $D2, $59, $69, $79, $0C, $6E, $A6, $BE
L56B4:  .byte $64, $D5, $45, $45, $58, $F0, $9A, $55
L56BC:  .byte $17, $11, $A5, $29, $6F, $56, $9D, $65
L56C4:  .byte $15, $85, $AD, $5D, $75, $96, $55, $94
L56CC:  .byte $76, $77, $D5, $85, $67, $53, $D8, $D3
L56D4:  .byte $D1, $24, $DD, $49, $E9, $77, $53, $57
L56DC:  .byte $54, $26, $05, $45, $4D, $5D, $D2, $1A
L56E4:  .byte $62, $16, $3D, $F5, $49, $4B, $B1, $96
L56EC:  .byte $DA, $D0, $27, $CD, $C5, $96, $CA, $53
L56F4:  .byte $9F, $B4, $94, $B8, $C7, $4B, $5D, $32
L56FC:  .byte $16, $EA, $1C, $6D, $B5, $29, $57, $50
L5704:  .byte $C6, $DC, $D5, $A6, $5A, $C6, $D9, $53
L570C:  .byte $DB, $90, $4A, $06, $7B, $D9, $51, $40
L5714:  .byte $62, $ED, $06, $B8, $42, $5D, $01, $3F
L571C:  .byte $A8, $0B, $60, $33, $51, $06, $1C, $A1
L5724:  .byte $C2, $80, $C1, $8D, $11, $60, $A0, $A9
L572C:  .byte $EB, $BC, $B1, $F0, $C8, $38, $A9, $F7
L5734:  .byte $CE, $22, $3D, $9D, $A4, $CE, $3B, $B3
L573C:  .byte $F0, $74, $92, $DA, $A4, $B8, $A9, $D2
L5744:  .byte $E9, $AA, $9B, $F6, $61, $95, $B9, $AB
L574C:  .byte $EE, $DC, $D6, $8C, $E7, $AE, $B6, $F2
L5754:  .byte $38, $35, $9E, $5B, $EA, $2A, $7C, $52
L575C:  .byte $35, $09, $03, $32, $CA, $44, $80, $E7
L5764:  .byte $95, $60, $80, $29, $38, $18, $10, $31
L576C:  .byte $3B, $02, $90, $9E, $46, $00, $F0, $93
L5774:  .byte $08, $00, $A5, $73, $4C, $2D, $85, $B1
L577C:  .byte $D1, $92, $D5, $D4, $C8, $E2, $3E, $AB
L5784:  .byte $56, $DB, $1A, $B3, $79, $AF, $2E, $63
L578C:  .byte $6B, $42, $61, $D1, $98, $00, $41, $53
L5794:  .byte $22, $20, $28, $14, $30, $40, $3B, $22
L579C:  .byte $0A, $68, $DD, $B9, $0D, $75, $0E, $46
L57A4:  .byte $78, $D2, $D1, $97, $AC, $61, $9A, $95
L57AC:  .byte $57, $DB, $4C, $95, $24, $2D, $59, $6D
L57B4:  .byte $53, $35, $92, $BC, $64, $B5, $C5, $F4
L57BC:  .byte $70, $C8, $DC, $D5, $55, $99, $23, $C1
L57C4:  .byte $73, $C7, $50, $64, $8C, $24, $55, $2D
L57CC:  .byte $63, $56, $96, $92, $18, $35, $4D, $49
L57D4:  .byte $6B, $6A, $70, $D4, $34, $47, $63, $A9
L57DC:  .byte $C1, $51, $D3, $12, $9C, $87, $AA, $C4
L57E4:  .byte $0D, $4B, $B0, $69, $EA, $E2, $34, $2C
L57EC:  .byte $DE, $85, $AB, $6B, $9A, $B0, $78, $EB
L57F4:  .byte $E1, $6A, $71, $C3, $E2, $8D, $87, $9B
L57FC:  .byte $C5, $71, $AB, $33, $E9, $E6, $96, $C4
L5804:  .byte $6C, $41, $44, $B8, $4B, $5A, $B3, $79
L580C:  .byte $9E, $59, $C1, $49, $C2, $14, $BD, $B9
L5814:  .byte $BA, $C5, $2E, $73, $72, $15, $94, $7A
L581C:  .byte $A7, $2C, $31, $A6, $4B, $C7, $94, $36
L5824:  .byte $65, $5B, $C9, $69, $73, $C6, $98, $5D
L582C:  .byte $05, $97, $DF, $19, $63, $4A, $EE, $92
L5834:  .byte $79, $B5, $4D, $D1, $87, $CA, $47, $1D
L583C:  .byte $B7, $24, $6B, $CA, $51, $95, $C5, $EA
L5844:  .byte $B5, $89, $4D, $86, $54, $9B, $13, $E1
L584C:  .byte $56, $69, $99, $ED, $9E, $B9, $67, $84
L5854:  .byte $25, $B5, $AF, $99, $E9, $48, $4E, $D3
L585C:  .byte $BA, $46, $57, $18, $89, $75, $C0, $28
L5864:  .byte $15, $6D, $E8, $4D, $05, $C3, $97, $AC
L586C:  .byte $BE, $77, $57, $36, $7B, $B2, $FA, $56
L5874:  .byte $CD, $C4, $E2, $C9, $1A, $6A, $52, $D3
L587C:  .byte $AC, $27, $6D, $2C, $45, $94, $A3, $E6
L5884:  .byte $B8, $35, $6B, $51, $CB, $A8, $24, $F6
L588C:  .byte $CE, $4D, $D8, $3C, $C9, $9A, $73, $14
L5894:  .byte $F3, $98, $38, $6B, $49, $49, $2D, $AA
L589C:  .byte $EB, $AC, $35, $25, $B7, $E8, $9A, $DC
L58A4:  .byte $F6, $58, $CD, $FC, $2B, $CE, $D8, $53
L58AC:  .byte $4A, $93, $CD, $38, $E5, $48, $25, $C5
L58B4:  .byte $26, $2A, $B7, $23, $C5, $36, $DD, $AC
L58BC:  .byte $5D, $8E, $E2, $26, $C4, $3D, $52, $3A
L58C4:  .byte $72, $2E, $93, $AC, $46, $EE, $28, $7E
L58CC:  .byte $82, $2A, $6A, $33, $20, $24, $75, $06
L58D4:  .byte $04, $4B, $C6, $80, $E4, $A9, $08, $90
L58DC:  .byte $1C, $26, $02, $AC, $E3, $45, $40, $71
L58E4:  .byte $68, $F0, $00, $FF
L58E8:  .byte $23, $68, $DC, $C5, $43, $67, $2F, $2F ;phrase 19, TMS5220 speech data
L58F0:  .byte $07, $93, $88, $AE, $BA, $9C, $92, $54
L58F8:  .byte $AC, $22, $F1, $72, $AB, $37, $55, $F5
L5900:  .byte $C6, $CD, $EB, $3C, $4D, $4D, $62, $B7
L5908:  .byte $60, $88, $34, $57, $B5, $BC, $DC, $21
L5910:  .byte $42, $5C, $6D, $F1, $72, $AB, $34, $75
L5918:  .byte $B5, $45, $C3, $C9, $52, $AD, $34, $1B
L5920:  .byte $37, $2B, $6B, $B1, $94, $68, $DD, $8C
L5928:  .byte $AC, $D5, $5D, $2D, $CE, $52, $BB, $15
L5930:  .byte $89, $C8, $B0, $4B, $9E, $41, $C9, $2B
L5938:  .byte $A2, $2C, $69, $45, $23, $CF, $B4, $B2
L5940:  .byte $C4, $99, $83, $C5, $3B, $0C, $92, $67
L5948:  .byte $70, $52, $B7, $AA, $4B, $9C, $A5, $44
L5950:  .byte $C4, $A3, $2C, $79, $E4, $66, $55, $4F
L5958:  .byte $B5, $94, $92, $94, $D3, $BD, $ED, $30
L5960:  .byte $52, $53, $B1, $F0, $A4, $C3, $4E, $DB
L5968:  .byte $55, $C3, $EC, $2C, $27, $4F, $33, $4B
L5970:  .byte $8B, $B3, $DC, $54, $C2, $34, $A3, $C9
L5978:  .byte $F2, $73, $2C, $D3, $AC, $A6, $2B, $28
L5980:  .byte $B9, $D4, $B3, $DA, $AC, $B0, $65, $B3
L5988:  .byte $B0, $9C, $EB, $80, $96, $45, $4B, $54
L5990:  .byte $A3, $68, $E8, $54, $69, $C1, $88, $C5
L5998:  .byte $4E, $B2, $74, $05, $23, $17, $19, $57
L59A0:  .byte $D5, $E1, $B5, $4C, $EA, $D1, $4A, $96
L59A8:  .byte $DB, $83, $91, $D9, $C4, $0D, $5E, $B7
L59B0:  .byte $CC, $61, $15, $97, $01, $4E, $59, $33
L59B8:  .byte $20, $52, $D5, $E1, $34, $A9, $54, $3E
L59C0:  .byte $75, $9D, $DB, $98, $72, $5B, $57, $61
L59C8:  .byte $6E, $15, $CC, $11, $6D, $27, $B9, $D9
L59D0:  .byte $B4, $B2, $9A, $E3, $62, $85, $A2, $5A
L59D8:  .byte $EC, $8D, $87, $99, $BA, $AB, $B9, $26
L59E0:  .byte $5B, $7A, $AD, $65, $E6, $E9, $76, $E9
L59E8:  .byte $F5, $44, $98, $97, $9D, $A5, $D5, $1E
L59F0:  .byte $E1, $52, $71, $97, $56, $47, $A5, $5A
L59F8:  .byte $C6, $5D, $5A, $ED, $5D, $26, $65, $67
L5A00:  .byte $69, $A5, $AF, $B9, $67, $DC, $A5, $95
L5A08:  .byte $3E, $EE, $9E, $71, $97, $5E, $E3, $88
L5A10:  .byte $5B, $3A, $59, $46, $F5, $29, $4E, $E5
L5A18:  .byte $78, $98, $DD, $A9, $24, $B7, $DD, $E6
L5A20:  .byte $74, $C7, $D2, $DC, $D6, $96, $B3, $54
L5A28:  .byte $A0, $7B, $55, $59, $FE, $2C, $C5, $A2
L5A30:  .byte $1D, $7A, $05, $A3, $24, $9A, $56, $A3
L5A38:  .byte $15, $F6, $EA, $64, $91, $8D, $56, $D8
L5A40:  .byte $BA, $72, $68, $B4, $5A, $51, $ED, $85
L5A48:  .byte $A9, $9E, $79, $24, $A5, $0B, $95, $47
L5A50:  .byte $E7, $91, $B6, $41, $1A, $5A, $B3, $5B
L5A58:  .byte $DA, $2A, $AA, $C5, $C4, $2D, $49, $73
L5A60:  .byte $C4, $39, $5E, $B9, $25, $CD, $A1, $55
L5A68:  .byte $57, $95, $91, $F4, $4C, $9C, $D9, $75
L5A70:  .byte $46, $D2, $AA, $62, $54, $2E, $6E, $69
L5A78:  .byte $29, $C2, $E5, $B5, $B8, $A4, $39, $39
L5A80:  .byte $47, $56, $3B, $97, $E5, $94, $E2, $15
L5A88:  .byte $49, $11, $90, $53, $CA, $03, $FF
L5A8F:  .byte $EE, $C8, $86, $C2, $5D, $B3, $B8, $3D ;phrase 20, TMS5220 speech data
L5A97:  .byte $5B, $76, $35, $EE, $1B, $B6, $E2, $D4
L5A9F:  .byte $D9, $30, $5B, $5A, $8B, $D3, $10, $C3
L5AA7:  .byte $74, $63, $AC, $DE, $52, $0C, $9B, $AD
L5AAF:  .byte $A1, $46, $2B, $77, $C9, $BA, $FA, $1A
L5AB7:  .byte $3D, $D3, $AC, $DB, $6A, $4B, $F0, $4A
L5ABF:  .byte $CB, $6E, $AB, $2A, $CE, $32, $BD, $DA
L5AC7:  .byte $AE, $AA, $46, $4D, $D7, $6C, $03, $06
L5ACF:  .byte $88, $81, $83, $01, $35, $79, $0A, $20
L5AD7:  .byte $31, $33, $05, $4C, $A8, $EC, $80, $CD
L5ADF:  .byte $42, $0D, $F0, $A4, $D9, $AA, $7A, $0A
L5AE7:  .byte $43, $D5, $AC, $AB, $EA, $49, $15, $C3
L5AEF:  .byte $DA, $AC, $BA, $67, $53, $32, $6F, $BC
L5AF7:  .byte $DA, $DE, $DC, $C9, $B4, $F5, $EA, $7A
L5AFF:  .byte $75, $57, $91, $B5, $6B, $18, $C9, $D4
L5B07:  .byte $4C, $DB, $A5, $61, $EA, $50, $71, $A9
L5B0F:  .byte $85, $00, $2F, $C4, $10, $D0, $65, $18
L5B17:  .byte $06, $20, $00, $8B, $BB, $39, $60, $CB
L5B1F:  .byte $76, $06, $74, $1E, $86, $80, $4C, $5C
L5B27:  .byte $11, $D0, $65, $18, $06, $30, $80, $01
L5B2F:  .byte $0C, $60, $00, $03, $18, $58, $43, $53
L5B37:  .byte $59, $6A, $9C, $6E, $8C, $29, $7B, $A8
L5B3F:  .byte $68, $DB, $36, $A6, $A1, $CE, $21, $CE
L5B47:  .byte $C2, $18, $27, $AB, $26, $3B, $0B, $63
L5B4F:  .byte $9C, $EC, $16, $AC, $AE, $F5, $A9, $99
L5B57:  .byte $51, $AA, $BD, $D5, $D6, $E4, $29, $26
L5B5F:  .byte $F1, $56, $D5, $B3, $B9, $87, $25, $5B
L5B67:  .byte $45, $2F, $E6, $EE, $E2, $AC, $54, $B5
L5B6F:  .byte $58, $B2, $49, $53, $D5, $B7, $20, $C9
L5B77:  .byte $2A, $51, $57, $D1, $82, $76, $05, $CB
L5B7F:  .byte $5D, $65, $73, $5C, $1D, $24, $6F, $95
L5B87:  .byte $DD, $B3, $9D, $8B, $DD, $95, $F7, $40
L5B8F:  .byte $B9, $29, $72, $57, $D6, $3C, $E6, $B8
L5B97:  .byte $CA, $1E, $69, $F3, $50, $5D, $24, $B7
L5B9F:  .byte $65, $CD, $62, $F4, $80, $B5, $91, $37
L5BA7:  .byte $2A, $1D, $8D, $CA, $57, $3D, $B8, $8C
L5BAF:  .byte $2B, $2A, $1F, $FD, $4D, $14, $E5, $2C
L5BB7:  .byte $46, $00, $EF, $B5, $AF, $7E, $1B, $A9
L5BBF:  .byte $0C, $A6, $BB, $DA, $AA, $BD, $43, $B0
L5BC7:  .byte $EB, $EA, $8A, $89, $2A, $E5, $2E, $AB
L5BCF:  .byte $2F, $CE, $27, $C9, $D6, $AE, $A1, $98
L5BD7:  .byte $68, $55, $5E, $D3, $C6, $A2, $A3, $5C
L5BDF:  .byte $A0, $75, $98, $8B, $C9, $52, $A6, $D6
L5BE7:  .byte $61, $6E, $3A, $32, $0C, $D5, $8E, $BE
L5BEF:  .byte $59, $4F, $57, $48, $BB, $BA, $6A, $3D
L5BF7:  .byte $D4, $B4, $EB, $EA, $8B, $77, $D7, $B4
L5BFF:  .byte $B6, $6B, $A8, $51, $CD, $53, $BB, $AC
L5C07:  .byte $A1, $65, $73, $4D, $E9, $BA, $A6, $96
L5C0F:  .byte $35, $CC, $3D, $DD, $5A, $5A, $D6, $30
L5C17:  .byte $8F, $74, $6B, $6D, $59, $53, $D2, $D3
L5C1F:  .byte $8D, $B5, $65, $4D, $2E, $4D, $37, $B6
L5C27:  .byte $56, $A4, $B8, $25, $79, $DB, $4B, $D1
L5C2F:  .byte $E6, $96, $B6, $E9, $28, $59, $4B, $3C
L5C37:  .byte $D2, $94, $A3, $66, $2D, $4D, $8E, $5B
L5C3F:  .byte $CE, $9C, $2C, $C3, $4C, $B1, $39, $8B
L5C47:  .byte $0B, $17, $0E, $37, $0F, $FF
L5C4D:  .byte $6E, $CB, $9A, $53, $5C, $BA, $84, $35 ;phrase 21, TMS5220 speech data
L5C55:  .byte $6B, $4E, $76, $E9, $92, $D6, $66, $24
L5C5D:  .byte $D8, $60, $5D, $5A, $9B, $E5, $10, $87
L5C65:  .byte $75, $65, $EE, $5E, $42, $1C, $DA, $AF
L5C6D:  .byte $B1, $1B, $4B, $0E, $EA, $BE, $9A, $E6
L5C75:  .byte $AC, $CC, $AC, $EF, $AA, $AA, $8D, $F2
L5C7D:  .byte $88, $CE, $AB, $A8, $CE, $CB, $23, $3A
L5C85:  .byte $AD, $B2, $45, $4F, $8D, $5C, $BC, $AA
L5C8D:  .byte $1A, $5D, $3D, $CB, $B2, $00, $B2, $E7
L5C95:  .byte $66, $80, $73, $EC, $A0, $80, $1D, $CB
L5C9D:  .byte $56, $D5, $1D, $A9, $64, $CC, $59, $D5
L5CA5:  .byte $B0, $22, $5C, $BA, $65, $D5, $DD, $9B
L5CAD:  .byte $92, $73, $D7, $D1, $77, $ED, $CA, $26
L5CB5:  .byte $B9, $C7, $72, $42, $87, $8B, $49, $51
L5CBD:  .byte $C0, $16, $A2, $0A, $98, $22, $84, $01
L5CC5:  .byte $19, $4B, $10, $40, $F2, $B2, $D0, $56
L5CCD:  .byte $27, $AE, $C2, $AB, $5B, $DF, $1C, $85
L5CD5:  .byte $8A, $BD, $2E, $6B, $A3, $A6, $A1, $D6
L5CDD:  .byte $C5, $00, $4B, $BA, $38, $60, $E9, $32
L5CE5:  .byte $07, $6C, $97, $69, $80, $63, $C2, $14
L5CED:  .byte $30, $A5, $6B, $E9, $AB, $0C, $31, $89
L5CF5:  .byte $C6, $6D, $1A, $2A, $9C, $D8, $5A, $1B
L5CFD:  .byte $60, $31, $13, $03, $1C, $15, $6E, $80
L5D05:  .byte $E3, $DC, $09, $30, $A9, $0A, $02, $BA
L5D0D:  .byte $0C, $03, $01, $74, $2C, $DE, $D6, $1E
L5D15:  .byte $24, $D4, $30, $7D, $9A, $46, $46, $95
L5D1D:  .byte $91, $F8, $69, $5C, $99, $8D, $9B, $CC
L5D25:  .byte $B9, $A9, $2A, $F1, $30, $72, $E6, $E6
L5D2D:  .byte $66, $D8, $43, $D9, $59, $58, $9A, $24
L5D35:  .byte $0B, $57, $67, $0C, $88, $82, $83, $00
L5D3D:  .byte $41, $71, $23, $C0, $1B, $2D, $04, $48
L5D45:  .byte $A3, $81, $80, $2E, $C3, $30, $80, $01
L5D4D:  .byte $0C, $60, $00, $03, $18, $48, $47, $D6
L5D55:  .byte $12, $1A, $51, $29, $AC, $59, $43, $56
L5D5D:  .byte $78, $9B, $B6, $76, $4B, $6A, $45, $ED
L5D65:  .byte $C7, $DA, $AD, $86, $14, $B7, $1D, $4B
L5D6D:  .byte $B3, $39, $9C, $B2, $78, $2D, $D5, $47
L5D75:  .byte $6B, $E8, $DC, $B5, $76, $6F, $A5, $61
L5D7D:  .byte $B5, $C7, $DC, $7D, $05, $85, $34, $2E
L5D85:  .byte $73, $55, $E2, $92, $5C, $AF, $4C, $4D
L5D8D:  .byte $93, $59, $70, $BD, $32, $37, $8B, $EA
L5D95:  .byte $C5, $C9, $C2, $1C, $A4, $B4, $78, $C5
L5D9D:  .byte $71, $4B, $B6, $68, $9E, $B5, $55, $00
L5DA5:  .byte $D5, $10, $1B, $60, $D6, $76, $03, $8C
L5DAD:  .byte $DA, $E9, $80, $D1, $BA, $1C, $30, $4A
L5DB5:  .byte $B7, $01, $5A, $9B, $52, $40, $10, $66
L5DBD:  .byte $AD, $8D, $41, $4D, $DC, $DB, $AE, $AA
L5DC5:  .byte $18, $2D, $09, $F2, $BE, $AA, $AA, $A5
L5DCD:  .byte $2C, $C9, $F9, $AA, $B2, $92, $8A, $64
L5DD5:  .byte $F5, $AB, $29, $9A, $B3, $4A, $94, $AF
L5DDD:  .byte $B6, $1A, $CE, $2C, $96, $B7, $BA, $62
L5DE5:  .byte $B8, $32, $59, $FE, $EA, $8A, $E1, $CA
L5DED:  .byte $22, $E5, $AB, $2B, $96, $AB, $83, $95
L5DF5:  .byte $8F, $2E, $38, $9B, $50, $49, $B7, $DA
L5DFD:  .byte $E4, $BC, $DD, $38, $EB, $EA, $A2, $F7
L5E05:  .byte $32, $B1, $6C, $A3, $8F, $CE, $5A, $C5
L5E0D:  .byte $BB, $B4, $7E, $29, $8D, $34, $71, $E3
L5E15:  .byte $80, $A5, $2A, $02, $70, $92, $5B, $00
L5E1D:  .byte $8E, $CB, $70, $C0, $4D, $19, $0E, $B8
L5E25:  .byte $BE, $42, $01, $53, $44, $22, $A0, $41
L5E2D:  .byte $32, $30, $40, $CD, $6B, $AB, $6A, $DA
L5E35:  .byte $22, $5C, $F2, $AD, $A6, $D8, $AE, $30
L5E3D:  .byte $CB, $B2, $BA, $EC, $2A, $35, $AB, $ED
L5E45:  .byte $EA, $AB, $B5, $F0, $8A, $2E, $6B, $A8
L5E4D:  .byte $56, $CC, $3B, $BA, $AC, $3E, $5B, $75
L5E55:  .byte $6D, $DD, $B2, $FA, $24, $BD, $B4, $38
L5E5D:  .byte $6B, $1B, $BC, $F2, $89, $86, $AC, $65
L5E65:  .byte $F0, $D2, $37, $12, $D2, $95, $31, $72
L5E6D:  .byte $D9, $6A, $54, $5E, $A6, $24, $E4, $C2
L5E75:  .byte $31, $F9, $9A, $8B, $90, $1E, $73, $47
L5E7D:  .byte $6B, $CA, $42, $67, $CD, $EC, $96, $39
L5E85:  .byte $4B, $99, $6E, $45, $6B, $D6, $AE, $29
L5E8D:  .byte $26, $9D, $2E, $08, $20, $C5, $EC, $34
L5E95:  .byte $A6, $28, $CD, $E6, $71, $CB, $14, $83
L5E9D:  .byte $14, $65, $B6, $29, $53, $8E, $12, $58
L5EA5:  .byte $BE, $7C, $2C, $C5, $B2, $73, $65, $F6
L5EAD:  .byte $B6, $64, $6B, $42, $E3, $5B, $CA, $5A
L5EB5:  .byte $B0, $85, $44, $35, $69, $DB, $71, $AC
L5EBD:  .byte $A6, $12, $AF, $1D, $7B, $5B, $B8, $A3
L5EC5:  .byte $ED, $B0, $26, $16, $29, $E6, $75, $CD
L5ECD:  .byte $AA, $6C, $65, $88, $38, $09, $B3, $57
L5ED5:  .byte $D1, $1C, $9C, $B5, $0D, $51, $46, $72
L5EDD:  .byte $7A, $97, $32, $65, $96, $41, $E1, $4B
L5EE5:  .byte $C2, $52, $8C, $BB, $0A, $B5, $15, $80
L5EED:  .byte $57, $6E, $02, $B0, $2A, $AC, $1C, $55
L5EF5:  .byte $79, $A8, $51, $B6, $B2, $15, $61, $61
L5EFD:  .byte $C1, $DD, $C3, $DE, $2C, $BA, $37, $A4
L5F05:  .byte $6B, $7B, $4F, $A8, $D6, $6A, $B7, $EC
L5F0D:  .byte $A3, $A0, $48, $A9, $B5, $76, $8C, $C1
L5F15:  .byte $2A, $25, $E6, $CA, $31, $9B, $08, $97
L5F1D:  .byte $86, $2B, $C7, $08, $C4, $5A, $6A, $AD
L5F25:  .byte $1C, $23, $09, $73, $9B, $D5, $B4, $F5
L5F2D:  .byte $44, $E4, $E9, $D6, $08, $10, $04, $0F
L5F35:  .byte $02, $BA, $0C, $7B, $FF
L5F3A:  .byte $02, $D8, $42, $45, $01, $4B, $A8, $19 ;phrase 22, TMS5220 speech data
L5F42:  .byte $60, $2A, $35, $03, $0C, $65, $BE, $F2
L5F4A:  .byte $62, $C3, $38, $62, $EB, $AA, $9A, $CF
L5F52:  .byte $14, $F1, $76, $AB, $6C, $CE, $83, $D5
L5F5A:  .byte $B7, $86, $AC, $44, $37, $CE, $6A, $CB
L5F62:  .byte $80, $A8, $CC, $18, $D0, $39, $AA, $02
L5F6A:  .byte $66, $64, $71, $C0, $58, $15, $AD, $E8
L5F72:  .byte $A9, $52, $94, $9C, $AE, $AA, $BA, $08
L5F7A:  .byte $28, $8D, $BF, $EA, $AC, $22, $D9, $BD
L5F82:  .byte $F9, $6A, $B3, $F4, $F2, $E4, $E4, $A3
L5F8A:  .byte $8F, $3A, $5B, $93, $B2, $BB, $3E, $98
L5F92:  .byte $4C, $53, $4E, $0A, $0E, $28, $62, $DB
L5F9A:  .byte $00, $45, $CE, $28, $20, $B3, $E8, $55
L5FA2:  .byte $26, $61, $3D, $CE, $49, $56, $5D, $15
L5FAA:  .byte $D5, $25, $DB, $5E, $75, $55, $94, $63
L5FB2:  .byte $3E, $69, $55, $45, $71, $A6, $E5, $ED
L5FBA:  .byte $55, $56, $C9, $D1, $1E, $B7, $57, $59
L5FC2:  .byte $35, $67, $6A, $5D, $5E, $45, $D3, $14
L5FCA:  .byte $E3, $36, $7B, $E5, $55, $4A, $B4, $FB
L5FD2:  .byte $EC, $95, $57, $25, $D9, $61, $B1, $57
L5FDA:  .byte $3E, $98, $54, $98, $D6, $0D, $C0, $F6
L5FE2:  .byte $6E, $09, $38, $C9, $C3, $01, $37, $BA
L5FEA:  .byte $1B, $E0, $46, $0F, $02, $54, $64, $85
L5FF2:  .byte $80, $02, $D5, $09, $90, $B4, $9B, $00
L5FFA:  .byte $B2, $8E, $50, $40, $D5, $96, $0A, $28
L6002:  .byte $3A, $B2, $B4, $D1, $D8, $29, $5B, $DA
L600A:  .byte $D5, $64, $AD, $6B, $C6, $5E, $5D, $93
L6012:  .byte $B5, $AD, $99, $78, $6D, $6D, $D1, $D6
L601A:  .byte $25, $A2, $6C, $D5, $C9, $D4, $98, $58
L6022:  .byte $D6, $D5, $16, $E3, $5B, $2C, $ED, $56
L602A:  .byte $DB, $A4, $F7, $26, $A5, $69, $4D, $E7
L6032:  .byte $39, $9D, $98, $C6, $01, $C3, $6A, $B6
L603A:  .byte $6C, $07, $F3, $AA, $10, $B7, $B2, $AC
L6042:  .byte $6B, $4A, $24, $E9, $4A, $8B, $F1, $79
L604A:  .byte $B5, $64, $2B, $1D, $5E, $E2, $23, $EC
L6052:  .byte $AD, $2C, $9B, $9C, $36, $CF, $B2, $DA
L605A:  .byte $A6, $33, $26, $2C, $89, $03, $AA, $A9
L6062:  .byte $50, $40, $35, $11, $0E, $C8, $A6, $C2
L606A:  .byte $02, $04, $E8, $BC, $52, $01, $4B, $A4
L6072:  .byte $1B, $E0, $AB, $30, $07, $5C, $E1, $E2
L607A:  .byte $80, $A5, $DC, $1D, $B0, $79, $C4, $8A
L6082:  .byte $BB, $0D, $35, $11, $77, $2B, $EB, $2E
L608A:  .byte $C4, $94, $D5, $39, $E0, $87, $34, $07
L6092:  .byte $5C, $9F, $1E, $80, $6B, $BC, $0C, $70
L609A:  .byte $75, $3A, $01, $06, $14, $01, $07, $4C
L60A2:  .byte $C2, $3E, $96, $31, $D8, $24, $49, $7D
L60AA:  .byte $59, $47, $62, $D5, $46, $F9, $65, $19
L60B2:  .byte $85, $54, $1B, $CD, $B7, $65, $24, $32
L60BA:  .byte $2B, $B4, $56, $96, $9E, $31, $2C, $D1
L60C2:  .byte $5E, $5A, $7B, $44, $B3, $A6, $68, $61
L60CA:  .byte $ED, $09, $D5, $9A, $AD, $B9, $65, $44
L60D2:  .byte $56, $29, $B2, $66, $D6, $EE, $50, $AD
L60DA:  .byte $C8, $BE, $59, $47, $20, $D5, $16, $AB
L60E2:  .byte $62, $EB, $9E, $C4, $9A, $ED, $21, $C0
L60EA:  .byte $3A, $CB, $07, $FF
L60EE:  .byte $0E, $38, $C1, $64, $D5, $63, $94, $8B ;phrase 23, TMS5220 speech data
L60F6:  .byte $B0, $DA, $D5, $F4, $96, $AE, $CE, $69
L60FE:  .byte $57, $D1, $5A, $78, $88, $B5, $5D, $59
L6106:  .byte $EB, $51, $A9, $12, $6F, $A5, $3D, $91
L610E:  .byte $AA, $6B, $D2, $95, $F6, $4C, $66, $26
L6116:  .byte $69, $57, $5E, $73, $45, $18, $47, $59
L611E:  .byte $65, $C9, $11, $AA, $12, $6D, $D5, $B9
L6126:  .byte $64, $8A, $48, $EC, $D5, $A5, $9A, $C5
L612E:  .byte $C6, $53, $56, $9F, $72, $96, $18, $57
L6136:  .byte $5E, $43, $8A, $59, $66, $1C, $75, $8C
L613E:  .byte $D9, $5A, $67, $93, $D8, $36, $D5, $40
L6146:  .byte $59, $83, $E2, $DA, $5C, $1C, $47, $0D
L614E:  .byte $48, $2B, $4B, $31, $54, $55, $60, $2D
L6156:  .byte $2C, $45, $CB, $94, $83, $74, $B7, $26
L615E:  .byte $A9, $93, $82, $CE, $CD, $96, $24, $6F
L6166:  .byte $08, $BA, $23, $80, $CC, $65, $08, $50
L616E:  .byte $36, $03, $01, $5D, $86, $61, $00, $03
L6176:  .byte $18, $00, $05, $78, $4F, $5E, $FA, $52
L617E:  .byte $D8, $D5, $A9, $1E, $02, $B8, $97, $42
L6186:  .byte $00, $53, $AE, $60, $80, $EA, $C4, $5B
L618E:  .byte $91, $13, $9B, $96, $2C, $5A, $79, $2D
L6196:  .byte $A1, $AA, $91, $75, $65, $35, $A9, $AB
L619E:  .byte $47, $DA, $95, $D5, $12, $A1, $A6, $D9
L61A6:  .byte $56, $DE, $5A, $B8, $99, $64, $5B, $75
L61AE:  .byte $4B, $2E, $12, $DE, $75, $55, $BD, $A4
L61B6:  .byte $42, $78, $D3, $55, $B6, $1A, $02, $69
L61BE:  .byte $E9, $56, $D5, $8A, $A9, $24, $B7, $5B
L61C6:  .byte $55, $71, $EC, $99, $E1, $6D, $D5, $35
L61CE:  .byte $4A, $84, $A9, $BB, $D5, $B6, $AC, $11
L61D6:  .byte $CE, $6E, $43, $5D, $A2, $86, $08, $37
L61DE:  .byte $41, $80, $B7, $52, $08, $A0, $C2, $1C
L61E6:  .byte $02, $50, $8B, $9B, $03, $46, $88, $68
L61EE:  .byte $59, $8D, $19, $A6, $62, $B3, $64, $D9
L61F6:  .byte $6A, $B8, $70, $BB, $91, $17, $AD, $A9
L61FE:  .byte $89, $EE, $47, $51, $B9, $B4, $26, $24
L6206:  .byte $2F, $65, $65, $3A, $9A, $20, $5F, $75
L620E:  .byte $41, $58, $9B, $91, $5A, $04, $80, $54
L6216:  .byte $2A, $80, $66, $DD, $0D, $30, $3D, $BB
L621E:  .byte $03, $6E, $93, $0C, $C0, $D6, $16, $06
L6226:  .byte $58, $4C, $83, $00, $19, $56, $20, $20
L622E:  .byte $C1, $2C, $02, $44, $E5, $6E, $80, $62
L6236:  .byte $3D, $0C, $10, $62, $F8, $68, $B2, $D7
L623E:  .byte $36, $C7, $E6, $AD, $CB, $49, $1B, $53
L6246:  .byte $E2, $AE, $AE, $25, $69, $31, $71, $B7
L624E:  .byte $86, $AA, $C3, $35, $78, $CD, $18, $AE
L6256:  .byte $77, $77, $75, $3B, $0E, $58, $DA, $C3
L625E:  .byte $01, $C7, $59, $18, $E0, $7A, $4B, $03
L6266:  .byte $6C, $AB, $A1, $80, $A5, $38, $57, $36
L626E:  .byte $AC, $84, $24, $BB, $5F, $45, $0F, $6C
L6276:  .byte $9E, $92, $6E, $55, $DD, $B1, $79, $59
L627E:  .byte $BA, $D1, $37, $2D, $E1, $C9, $ED, $5A
L6286:  .byte $3F, $AC, $87, $AA, $39, $31, $40, $51
L628E:  .byte $E6, $AB, $6F, $46, $43, $4D, $3B, $8F
L6296:  .byte $B1, $0A, $53, $77, $6F, $AC, $80, $85
L629E:  .byte $C2, $1C, $B0, $85, $C5, $A8, $A6, $EA
L62A6:  .byte $70, $91, $D4, $A3, $CE, $D6, $42, $3D
L62AE:  .byte $16, $AF, $7A, $38, $4B, $09, $EA, $6A
L62B6:  .byte $9A, $2C, $24, $3C, $34, $25, $02, $BC
L62BE:  .byte $B2, $00, $07, $54, $D9, $AA, $80, $1E
L62C6:  .byte $C5, $02, $10, $9D, $CD, $1A, $5B, $D2
L62CE:  .byte $F4, $CE, $2E, $6B, $6B, $59, $D3, $2B
L62D6:  .byte $96, $8E, $AD, $65, $29, $9B, $58, $3A
L62DE:  .byte $F6, $96, $25, $6D, $BD, $B6, $01, $8A
L62E6:  .byte $95, $24, $40, $F6, $94, $08, $60, $92
L62EE:  .byte $0C, $01, $5D, $86, $61, $00, $04, $90
L62F6:  .byte $A5, $B4, $00, $9A, $42, $25, $40, $B3
L62FE:  .byte $E4, $0F, $FF
L6301:  .byte $A2, $74, $31, $43, $D5, $AD, $B8, $D8 ;phrase 24, TMS5220 speech data
L6309:  .byte $E6, $0A, $E2, $AC, $5C, $02, $1F, $3B
L6311:  .byte $52, $25, $F9, $F0, $93, $EB, $6E, $E5
L6319:  .byte $BA, $CB, $C9, $AE, $27, $35, $A2, $2E
L6321:  .byte $B3, $F8, $29, $8B, $48, $BA, $CC, $E2
L6329:  .byte $D3, $22, $BC, $4E, $F1, $8A, $AD, $2C
L6331:  .byte $B1, $DA, $0E, $18, $3C, $AC, $F1, $BB
L6339:  .byte $94, $A6, $69, $AC, $25, $36, $9F, $14
L6341:  .byte $D1, $71, $97, $DC, $7C, $53, $55, $36
L6349:  .byte $5D, $6A, $0D, $A5, $DD, $53, $C7, $00
L6351:  .byte $6D, $85, $09, $A0, $76, $17, $30, $40
L6359:  .byte $AE, $E3, $45, $49, $A3, $C3, $CD, $AD
L6361:  .byte $26, $21, $E5, $C9, $F4, $4C, $DA, $B8
L6369:  .byte $D0, $BB, $5C, $DD, $CE, $E0, $72, $98
L6371:  .byte $D1, $CC, $36, $83, $CB, $61, $46, $32
L6379:  .byte $DA, $0E, $2E, $F9, $6E, $AF, $4C, $32
L6381:  .byte $F8, $92, $D6, $22, $A2, $CD, $10, $B2
L6389:  .byte $4F, $2F, $2F, $AB, $85, $AF, $2E, $A3
L6391:  .byte $2C, $BB, $28, $20, $8A, $74, $06, $78
L6399:  .byte $EE, $42, $80, $C0, $4D, $18, $50, $55
L63A1:  .byte $58, $93, $62, $EE, $0C, $91, $B9, $43
L63A9:  .byte $4A, $B1, $A6, $28, $D2, $0E, $25, $C5
L63B1:  .byte $59, $C9, $6E, $3C, $94, $E4, $66, $32
L63B9:  .byte $B2, $D6, $50, $53, $A8, $AA, $A9, $C6
L63C1:  .byte $43, $2B, $D9, $AD, $3A, $5A, $0D, $BD
L63C9:  .byte $56, $57, $AB, $C8, $36, $F4, $D2, $53
L63D1:  .byte $BC, $2C, $DE, $30, $73, $4D, $B1, $D4
L63D9:  .byte $68, $CA, $4E, $D9, $C9, $5B, $A2, $20
L63E1:  .byte $80, $46, $57, $04, $E8, $62, $DA, $74
L63E9:  .byte $5F, $CA, $CD, $B9, $E9, $D0, $43, $AC
L63F1:  .byte $0C, $E7, $E8, $43, $8F, $B1, $2A, $9C
L63F9:  .byte $C3, $0F, $3D, $C6, $CE, $0C, $0A, $3F
L6401:  .byte $F4, $18, $26, $33, $31, $DA, $D0, $63
L6409:  .byte $98, $AE, $A0, $68, $43, $8F, $7E, $C2
L6411:  .byte $52, $E6, $0E, $3D, $A5, $2A, $B3, $68
L6419:  .byte $3D, $CC, $1C, $CB, $23, $A3, $F2, $B0
L6421:  .byte $4A, $08, $C9, $C8, $2A, $C3, $EC, $31
L6429:  .byte $31, $BD, $26, $0F, $AB, $7B, $C5, $F4
L6431:  .byte $8D, $DB, $EC, $EE, $1D, $D3, $AF, $6E
L6439:  .byte $70, $9A, $55, $0A, $5B, $47, $02, $48
L6441:  .byte $4C, $55, $00, $D5, $88, $32, $A0, $19
L6449:  .byte $33, $01, $0C, $A5, $CE, $80, $69, $C4
L6451:  .byte $11, $50, $A5, $DB, $03, $FF
L6457:  .byte $E3, $C8, $3E, $A6, $52, $D6, $8E, $23 ;phrase 25, TMS5220 speech data
L645F:  .byte $47, $9F, $28, $5B, $BD, $B6, $1A, $AC
L6467:  .byte $3C, $7D, $ED, $DA, $5A, $E1, $D2, $B0
L646F:  .byte $C5, $E3, $28, $CE, $43, $52, $DB, $A4
L6477:  .byte $23, $86, $F2, $24, $4D, $64, $0E, $EF
L647F:  .byte $BC, $8A, $B1, $A9, $DB, $93, $A6, $69
L6487:  .byte $13, $29, $61, $2B, $8A, $6A, $8A, $AC
L648F:  .byte $B4, $A5, $68, $EA, $49, $B2, $B2, $C6
L6497:  .byte $E8, $7D, $5B, $D9, $C9, $EA, $62, $EA
L649F:  .byte $09, $53, $D7, $AB, $CA, $2E, $27, $4C
L64A7:  .byte $5C, $AF, $AA, $4A, $8F, $62, $53, $55
L64AF:  .byte $8A, $A2, $35, $9D, $D8, $8B, $2A, $32
L64B7:  .byte $93, $48, $93, $74, $08, $00, $B6, $0C
L64BF:  .byte $01, $40, $A7, $23, $00, $F3, $70, $04
L64C7:  .byte $00, $11, $0E, $0C, $28, $5E, $8D, $01
L64CF:  .byte $D1, $89, $AF, $BA, $46, $57, $33, $D9
L64D7:  .byte $BC, $9A, $1A, $55, $23, $6C, $F5, $6A
L64DF:  .byte $5A, $56, $2B, $F7, $D5, $AB, $AD, $49
L64E7:  .byte $2A, $23, $56, $AD, $B6, $46, $8D, $C8
L64EF:  .byte $58, $B5, $DA, $6A, $C3, $CC, $A3, $8E
L64F7:  .byte $00, $A2, $63, $47, $40, $30, $E6, $A0
L64FF:  .byte $80, $A8, $CD, $10, $10, $25, $A9, $00
L6507:  .byte $1A, $27, $71, $C0, $AA, $CA, $06, $98
L650F:  .byte $A5, $D3, $01, $2B, $A7, $07, $60, $D5
L6517:  .byte $CC, $00, $CC, $D6, $13, $80, $D9, $3A
L651F:  .byte $03, $30, $5B, $59, $00, $56, $ED, $0C
L6527:  .byte $C0, $6C, $E9, $0E, $98, $C5, $75, $C4
L652F:  .byte $A3, $B8, $81, $79, $93, $95, $8F, $E2
L6537:  .byte $06, $E1, $75, $46, $DB, $8B, $1A, $65
L653F:  .byte $34, $5E, $5B, $2B, $6C, $D2, $B9, $AA
L6547:  .byte $1D, $55, $49, $68, $DB, $12, $04, $48
L654F:  .byte $4D, $89, $00, $61, $BC, $10, $00, $A4
L6557:  .byte $3A, $02, $00, $37, $07, $01, $C4, $A8
L655F:  .byte $45, $80, $58, $48, $11, $D0, $65, $18
L6567:  .byte $06, $30, $E0, $96, $16, $48, $60, $A2
L656F:  .byte $76, $5A, $9A, $87, $08, $AF, $C4, $69
L6577:  .byte $4B, $12, $B3, $3D, $6B, $A5, $3D, $48
L657F:  .byte $CE, $B4, $A9, $95, $F6, $24, $A1, $D7
L6587:  .byte $33, $72, $D8, $B3, $84, $69, $F7, $58
L658F:  .byte $69, $AB, $06, $D2, $22, $52, $97, $B9
L6597:  .byte $58, $49, $55, $6A, $32, $96, $E2, $75
L659F:  .byte $C2, $A4, $D3, $58, $AA, $B3, $C9, $C4
L65A7:  .byte $B5, $6D, $29, $36, $C6, $43, $BA, $0A
L65AF:  .byte $C0, $3B, $4D, $10, $40, $11, $1A, $0C
L65B7:  .byte $C8, $C6, $B4, $D5, $3D, $3B, $8B, $46
L65BF:  .byte $2C, $B5, $14, $A1, $94, $95, $89, $10
L65C7:  .byte $90, $12, $AB, $01, $A6, $0E, $75, $C0
L65CF:  .byte $36, $16, $0E, $98, $36, $C2, $01, $C3
L65D7:  .byte $4F, $11, $20, $41, $56, $50, $40, $37
L65DF:  .byte $68, $0C, $E8, $02, $91, $01, $C3, $23
L65E7:  .byte $97, $B6, $37, $41, $8E, $68, $5C, $9A
L65EF:  .byte $6A, $44, $34, $B8, $75, $EA, $92, $92
L65F7:  .byte $10, $97, $CD, $65, $1C, $5A, $4A, $8C
L65FF:  .byte $DD, $28, $60, $2A, $34, $05, $1C, $27
L6607:  .byte $6E, $80, $A5, $DD, $15, $30, $A5, $39
L660F:  .byte $03, $B2, $51, $0A, $6B, $33, $A6, $22
L6617:  .byte $55, $29, $6D, $DD, $B2, $0A, $55, $9B
L661F:  .byte $B0, $55, $A9, $2A, $5A, $8B, $DC, $D6
L6627:  .byte $84, $AA, $58, $CC, $66, $80, $11, $9E
L662F:  .byte $04, $F0, $CC, $8A, $01, $82, $67, $09
L6637:  .byte $A0, $02, $0A, $01, $4C, $82, $AA, $80
L663F:  .byte $EB, $98, $15, $70, $9D, $A8, $02, $4E
L6647:  .byte $14, $55, $C0, $F6, $11, $0A, $D8, $C6
L664F:  .byte $54, $01, $DB, $58, $09, $E0, $58, $76
L6657:  .byte $02, $04, $E2, $8E, $00, $8E, $3D, $1E
L665F:  .byte $FF
L6660:  .byte $A3, $6E, $C1, $CA, $52, $17, $AF, $B6 ;phrase 26, TMS5220 speech data
L6668:  .byte $44, $2B, $4B, $5F, $BC, $9A, $92, $2C
L6670:  .byte $DD, $6A, $F1, $AA, $4B, $70, $4F, $AF
L6678:  .byte $25, $AB, $2A, $D6, $32, $DB, $27, $8F
L6680:  .byte $2A, $CB, $2C, $AB, $B0, $52, $AA, $A2
L6688:  .byte $D3, $2B, $C2, $A6, $01, $16, $23, $35
L6690:  .byte $C0, $92, $CA, $06, $38, $D1, $C2, $00
L6698:  .byte $D7, $18, $13, $20, $43, $62, $30, $40
L66A0:  .byte $37, $EA, $06, $58, $96, $6C, $D4, $DD
L66A8:  .byte $4B, $89, $73, $D2, $D5, $E5, $E0, $C9
L66B0:  .byte $6E, $EE, $5A, $9F, $0A, $97, $98, $36
L66B8:  .byte $6B, $5D, $EC, $12, $62, $E6, $B4, $75
L66C0:  .byte $71, $68, $8A, $59, $BC, $D1, $C7, $A6
L66C8:  .byte $69, $EA, $C9, $46, $1F, $8B, $65, $B2
L66D0:  .byte $36, $6B, $43, $E8, $D6, $CC, $B9, $A4
L66D8:  .byte $8D, $A1, $45, $8A, $E6, $92, $36, $85
L66E0:  .byte $91, $41, $5A, $AD, $C7, $98, $5C, $0E
L66E8:  .byte $A6, $75, $6E, $63, $88, $91, $DA, $36
L66F0:  .byte $73, $0D, $39, $A8, $59, $46, $A3, $D1
L66F8:  .byte $B5, $C6, $26, $61, $AB, $46, $D9, $AB
L6700:  .byte $08, $BB, $F5, $86, $D4, $34, $A3, $22
L6708:  .byte $66, $B1, $43, $DF, $AD, $0B, $AB, $35
L6710:  .byte $12, $40, $41, $A2, $02, $A8, $98, $04
L6718:  .byte $04, $D0, $BC, $7A, $19, $BB, $24, $E7
L6720:  .byte $30, $5B, $69, $AC, $8E, $52, $55, $D2
L6728:  .byte $84, $B9, $06, $76, $31, $76, $9D, $A6
L6730:  .byte $A2, $D0, $5A, $D3, $75, $19, $8B, $C2
L6738:  .byte $48, $A9, $A4, $A3, $4B, $B6, $D2, $D4
L6740:  .byte $62, $8D, $2E, $E6, $2E, $8B, $48, $BD
L6748:  .byte $9A, $14, $AB, $CD, $D3, $71, $69, $B3
L6750:  .byte $B7, $F2, $12, $87, $08, $E0, $D1, $04
L6758:  .byte $04, $D0, $BD, $25, $02, $94, $10, $45
L6760:  .byte $00, $26, $9C, $A0, $80, $14, $45, $19
L6768:  .byte $E0, $AD, $4A, $18, $8A, $10, $6D, $A9
L6770:  .byte $34, $61, $AE, $92, $74, $B4, $92, $B8
L6778:  .byte $29, $32, $8D, $D5, $8C, $53, $DA, $63
L6780:  .byte $5C, $5C, $54, $9E, $02, $B6, $10, $35
L6788:  .byte $C0, $92, $66, $06, $D8, $26, $DC, $01
L6790:  .byte $DB, $A4, $29, $60, $0A, $D5, $55, $17
L6798:  .byte $EF, $C6, $AE, $6B, $56, $55, $8C, $1B
L67A0:  .byte $A7, $AF, $5D, $65, $B5, $6E, $1A, $9A
L67A8:  .byte $77, $E5, $2D, $B9, $87, $51, $D6, $95
L67B0:  .byte $B7, $6A, $5E, $22, $59, $56, $56, $8B
L67B8:  .byte $65, $B0, $B4, $59, $45, $4D, $1A, $2A
L67C0:  .byte $D6, $38, $95, $45, $43, $47, $74, $EC
L67C8:  .byte $54, $17, $05, $53, $D6, $B6, $53, $9B
L67D0:  .byte $24, $76, $6B, $47, $4E, $7D, $90, $34
L67D8:  .byte $E9, $1D, $39, $4D, $49, $62, $8F, $B6
L67E0:  .byte $95, $B0, $25, $41, $91, $59, $6A, $DD
L67E8:  .byte $E1, $99, $E7, $78, $3A, $2D, $6B, $D1
L67F0:  .byte $A8, $35, $15, $AB, $AD, $CD, $A3, $58
L67F8:  .byte $57, $A5, $B1, $F6, $42, $42, $93, $95
L6800:  .byte $DB, $D6, $23, $B1, $54, $57, $69, $DB
L6808:  .byte $E8, $22, $50, $D9, $78, $AC, $7D, $8A
L6810:  .byte $42, $C6, $A2, $B6, $B5, $CC, $A6, $9E
L6818:  .byte $B5, $DA, $DE, $A5, $84, $64, $58, $6E
L6820:  .byte $7B, $95, $1E, $5A, $51, $79, $4C, $25
L6828:  .byte $6A, $78, $FA, $AC, $36, $97, $60, $A9
L6830:  .byte $E5, $8B, $C7, $54, $B2, $16, $57, $2D
L6838:  .byte $1E, $53, $B3, $9E, $54, $5E, $17, $01
L6840:  .byte $DE, $70, $22, $C0, $6A, $75, $04, $24
L6848:  .byte $AE, $85, $00, $43, $A5, $30, $80, $00
L6850:  .byte $41, $B5, $CC, $66, $B4, $07, $4B, $C4
L6858:  .byte $4C, $5B, $F2, $31, $AC, $16, $B9, $EC
L6860:  .byte $D9, $7B, $B3, $5A, $94, $B2, $A7, $E8
L6868:  .byte $CD, $AA, $D6, $DA, $9E, $82, $B5, $19
L6870:  .byte $27, $6B, $7B, $76, $3A, $E1, $64, $AF
L6878:  .byte $6C, $D9, $FA, $9A, $50, $DA, $B1, $66
L6880:  .byte $E3, $AB, $42, $EE, $DA, $92, $4C, $AC
L6888:  .byte $08, $A6, $2B, $53, $B4, $31, $C6, $94
L6890:  .byte $B5, $74, $C9, $78, $17, $62, $D2, $52
L6898:  .byte $47, $E5, $9D, $28, $EE, $4A, $15, $B5
L68A0:  .byte $8F, $93, $78, $4D, $55, $96, $DA, $45
L68A8:  .byte $CA, $D9, $74, $C9, $54, $39, $B3, $64
L68B0:  .byte $04, $00, $13, $0E, $0F, $FF
L68B6:  .byte $C5, $28, $CE, $C3, $AD, $C6, $2C, $3D ;phrase 27, TMS5220 speech data
L68BE:  .byte $47, $57, $8F, $1A, $B3, $E4, $E4, $2D
L68C6:  .byte $4C, $6B, $4A, $13, $F2, $6C, $36, $CE
L68CE:  .byte $A2, $89, $4B, $BE, $31, $30, $AA, $35
L68D6:  .byte $A1, $78, $57, $97, $14, $9D, $E4, $61
L68DE:  .byte $53, $45, $43, $12, $02, $22, $31, $43
L68E6:  .byte $80, $97, $26, $02, $C8, $2A, $BD, $31
L68EE:  .byte $C9, $47, $7A, $04, $93, $A5, $54, $1B
L68F6:  .byte $9E, $11, $52, $96, $5C, $8D, $54, $86
L68FE:  .byte $CB, $29, $42, $55, $EA, $2D, $14, $2D
L6906:  .byte $08, $C1, $69, $09, $79, $5D, $23, $46
L690E:  .byte $4D, $A3, $14, $69, $98, $24, $74, $54
L6916:  .byte $8B, $26, $41, $00, $31, $95, $08, $00
L691E:  .byte $B2, $02, $01, $5D, $86, $21, $80, $51
L6926:  .byte $55, $04, $00, $6A, $8A, $80, $2E, $C3
L692E:  .byte $10, $10, $B5, $71, $91, $72, $36, $31
L6936:  .byte $8A, $2A, $43, $29, $CA, $3D, $8D, $EF
L693E:  .byte $2C, $AD, $5A, $4E, $F5, $98, $93, $C2
L6946:  .byte $CD, $24, $34, $BC, $8B, $00, $82, $8E
L694E:  .byte $70, $51, $16, $16, $C9, $16, $A7, $C5
L6956:  .byte $85, $AA, $65, $48, $ED, $55, $2C, $93
L695E:  .byte $AE, $8A, $9D, $57, $DE, $6D, $B8, $B2
L6966:  .byte $AE, $5E, $D9, $10, $61, $22, $B6, $5A
L696E:  .byte $01, $19, $A9, $19, $E0, $11, $73, $05
L6976:  .byte $34, $E7, $5C, $BC, $18, $5C, $55, $F5
L697E:  .byte $F1, $F0, $6B, $50, $71, $93, $D9, $2B
L6986:  .byte $EC, $C5, $59, $C2, $A7, $10, $20, $2A
L698E:  .byte $74, $04, $04, $45, $01, $0E, $E8, $3D
L6996:  .byte $75, $19, $C5, $67, $A6, $B6, $94, $61
L699E:  .byte $A7, $9A, $61, $59, $51, $97, $93, $43
L69A6:  .byte $A6, $6A, $55, $49, $4E, $B1, $38, $6A
L69AE:  .byte $EE, $A4, $D9, $CD, $9B, $58, $DA, $E8
L69B6:  .byte $65, $4D, $EF, $C2, $11, $A3, $8B, $5D
L69BE:  .byte $A5, $78, $05, $5B, $0F, $6E, $71, $98
L69C6:  .byte $2D, $EA, $6C, $79, $3D, $B8, $66, $FA
L69CE:  .byte $D4, $11, $C4, $D4, $1E, $95, $66, $56
L69D6:  .byte $58, $F4, $B4, $4B, $C5, $59, $51, $EC
L69DE:  .byte $65, $56, $25, $7B, $05, $B1, $79, $58
L69E6:  .byte $B6, $9D, $E2, $A7, $2C, $C9, $99, $56
L69EE:  .byte $21, $00, $43, $84, $34, $2F, $69, $D3
L69F6:  .byte $F2, $B0, $5A, $BC, $14, $D4, $55, $2A
L69FE:  .byte $6A, $0A, $AB, $31, $75, $F2, $DA, $04
L6A06:  .byte $20, $BE, $AA, $F8, $BD, $90, $91, $4F
L6A0E:  .byte $DD, $E6, $55, $45, $1A, $DB, $75, $97
L6A16:  .byte $D7, $3C, $B3, $76, $95, $5D, $61, $0F
L6A1E:  .byte $CE, $D6, $39, $65, $B9, $CD, $BA, $55
L6A26:  .byte $E5, $D4, $95, $14, $E7, $19, $D5, $51
L6A2E:  .byte $47, $9A, $5C, $46, $7B, $4A, $29, $C5
L6A36:  .byte $52, $AD, $6A, $11, $DA, $00, $9D, $A5
L6A3E:  .byte $2A, $60, $49, $09, $04, $74, $19, $86
L6A46:  .byte $80, $C2, $49, $5A, $D2, $67, $98, $85
L6A4E:  .byte $48, $6D, $59, $EA, $1A, $A6, $94, $36
L6A56:  .byte $15, $BE, $4B, $9A, $51, $DB, $52, $85
L6A5E:  .byte $28, $63, $22, $6B, $4A, $15, $72, $94
L6A66:  .byte $90, $DD, $29, $65, $4A, $59, $8E, $72
L6A6E:  .byte $67, $E4, $29, $98, $BB, $F9, $9C, $91
L6A76:  .byte $D5, $A8, $E2, $E1, $B3, $5B, $56, $23
L6A7E:  .byte $9A, $56, $8E, $51, $79, $36, $64, $11
L6A86:  .byte $19, $D9, $00, $CD, $87, $28, $A0, $7B
L6A8E:  .byte $67, $01, $F4, $90, $2C, $80, $9E, $8B
L6A96:  .byte $86, $DF, $B5, $92, $74, $4D, $59, $E1
L6A9E:  .byte $74, $21, $E0, $31, $65, $44, $C3, $18
L6AA6:  .byte $53, $65, $95, $16, $F5, $A8, $28, $15
L6AAE:  .byte $95, $4B, $DC, $8A, $92, $A6, $4D, $6E
L6AB6:  .byte $51, $33, $AA, $9E, $3C, $27, $05, $D9
L6ABE:  .byte $68, $9A, $F9, $EC, $E4, $47, $2B, $C5
L6AC6:  .byte $56, $89, $93, $1F, $B5, $A5, $5A, $26
L6ACE:  .byte $0D, $7E, $13, $6A, $9C, $2A, $99, $01
L6AD6:  .byte $85, $97, $20, $A0, $CB, $B0, $07, $FF
L6ADE:  .byte $FF                   ;phrase 28, TMS5220 speech data
L6ADF:  .byte $04, $18, $C4, $54, $00, $95, $BA, $29 ;phrase 29, TMS5220 speech data
L6AE7:  .byte $20, $C9, $4C, $03, $64, $EE, $AE, $80
L6AEF:  .byte $66, $42, $07, $57, $82, $05, $56, $D8
L6AF7:  .byte $19, $5C, $49, $E6, $3C, $C3, $6D, $B0
L6AFF:  .byte $39, $A9, $55, $A5, $DB, $C5, $E4, $18
L6B07:  .byte $16, $99, $4A, $17, $9F, $43, $AA, $77
L6B0F:  .byte $DA, $5D, $7C, $D1, $69, $26, $3E, $35
L6B17:  .byte $B9, $C9, $B5, $BB, $79, $D8, $E0, $86
L6B1F:  .byte $E6, $2E, $9C, $51, $9B, $95, $2D, $56
L6B27:  .byte $58, $37, $1D, $56, $DF, $C4, $E6, $D3
L6B2F:  .byte $A4, $38, $A3, $3A, $51, $65, $1D, $02
L6B37:  .byte $64, $0D, $66, $80, $ED, $D4, $86, $D0
L6B3F:  .byte $83, $99, $6A, $54, $19, $42, $4E, $E1
L6B47:  .byte $16, $65, $6E, $70, $39, $45, $AB, $4F
L6B4F:  .byte $98, $22, $56, $9B, $E1, $66, $41, $0C
L6B57:  .byte $D0, $78, $99, $00, $8A, $4C, $61, $40
L6B5F:  .byte $E1, $6A, $41, $6C, $9A, $AC, $85, $BD
L6B67:  .byte $36, $B5, $D2, $2E, $56, $6D, $B6, $CC
L6B6F:  .byte $14, $27, $59, $33, $EE, $B0, $93, $9B
L6B77:  .byte $50, $69, $3B, $CD, $AE, $CA, $2B, $29
L6B7F:  .byte $27, $17, $77, $CA, $8A, $36, $73, $CC
L6B87:  .byte $80, $44, $DD, $11, $D0, $65, $18, $06
L6B8F:  .byte $92, $53, $AC, $B9, $68, $24, $1D, $6E
L6B97:  .byte $F1, $EE, $CC, $39, $35, $78, $C9, $70
L6B9F:  .byte $8B, $45, $1C, $E7, $66, $4B, $A3, $62
L6BA7:  .byte $4E, $93, $59, $3C, $95, $5A, $45, $5D
L6BAF:  .byte $46, $0F, $E2, $9A, $1D, $65, $A9, $3D
L6BB7:  .byte $B0, $7A, $95, $D9, $21, $17, $4B, $D9
L6BBF:  .byte $69, $76, $87, $D6, $3C, $46, $75, $C8
L6BC7:  .byte $35, $6E, $D4, $52, $99, $21, $59, $79
L6BCF:  .byte $DE, $78, $A4, $AA, $D3, $E0, $26, $2F
L6BD7:  .byte $19, $CA, $71, $96, $5D, $AC, $88, $97
L6BDF:  .byte $AF, $5E, $6E, $8F, $C6, $EA, $3E, $75
L6BE7:  .byte $79, $23, $96, $B2, $EA, $9D, $E1, $F5
L6BEF:  .byte $A8, $46, $9A, $53, $A1, $88, $5D, $38
L6BF7:  .byte $5B, $84, $93, $21, $17, $2D, $9E, $59
L6BFF:  .byte $51, $87, $96, $2D, $87, $C7, $38, $31
L6C07:  .byte $5A, $E1, $6A, $13, $5D, $47, $00, $5D
L6C0F:  .byte $1B, $0B, $60, $70, $93, $25, $14, $AB
L6C17:  .byte $A9, $D9, $4A, $16, $5F, $BD, $84, $4D
L6C1F:  .byte $2A, $69, $42, $73, $58, $19, $2E, $87
L6C27:  .byte $01, $C1, $69, $81, $00, $A6, $70, $6B
L6C2F:  .byte $56, $B1, $E4, $56, $E5, $B4, $39, $D5
L6C37:  .byte $A3, $6B, $97, $DC, $E1, $ED, $B2, $21
L6C3F:  .byte $26, $8A, $1D, $B0, $6A, $AB, $03, $56
L6C47:  .byte $5D, $57, $C0, $5C, $63, $C1, $9E, $49
L6C4F:  .byte $59, $34, $92, $36, $BF, $3B, $26, $AD
L6C57:  .byte $AA, $DB, $D2, $16, $49, $3C, $73, $6A
L6C5F:  .byte $C9, $73, $60, $97, $98, $A8, $29, $8B
L6C67:  .byte $99, $DD, $A6, $AD, $84, $2C, $5B, $49
L6C6F:  .byte $8C, $6E, $24, $80, $A6, $49, $04, $90
L6C77:  .byte $49, $08, $A8, $2C, $47, $11, $51, $97
L6C7F:  .byte $4C, $80, $1C, $45, $10, $90, $8B, $E1
L6C87:  .byte $03, $FF
L6C89:  .byte $41, $F6, $35, $93, $3D, $92, $2E, $29 ;phrase 30, TMS5220 speech data
L6C91:  .byte $85, $2A, $E3, $A8, $B3, $E4, $12, $32
L6C99:  .byte $C5, $6A, $4E, $53, $B3, $F5, $A6, $88
L6CA1:  .byte $D0, $41, $F5, $21, $92, $DC, $ED, $04
L6CA9:  .byte $35, $5A, $6E, $35, $8F, $33, $94, $E4
L6CB1:  .byte $CA, $5D, $B5, $DA, $50, $63, $ED, $74
L6CB9:  .byte $96, $78, $43, $4B, $EE, $CA, $0B, $E2
L6CC1:  .byte $2E, $33, $EB, $4E, $33, $AA, $33, $AC
L6CC9:  .byte $9C, $34, $99, $A3, $31, $02, $BC, $77
L6CD1:  .byte $69, $CE, $90, $E9, $AA, $9E, $68, $79
L6CD9:  .byte $39, $57, $68, $64, $94, $15, $94, $D2
L6CE1:  .byte $66, $51, $4B, $56, $50, $62, $AA, $67
L6CE9:  .byte $4D, $59, $61, $69, $E6, $26, $D9, $24
L6CF1:  .byte $C4, $29, $AA, $B9, $4A, $94, $E2, $E7
L6CF9:  .byte $C9, $C5, $EC, $B1, $97, $5B, $A3, $6A
L6D01:  .byte $F8, $D4, $59, $56, $AF, $C6, $61, $55
L6D09:  .byte $A5, $98, $BD, $A2, $79, $B4, $65, $05
L6D11:  .byte $14, $4D, $06, $0A, $98, $D2, $54, $00
L6D19:  .byte $C3, $BA, $22, $20, $2B, $F1, $E6, $34
L6D21:  .byte $27, $E2, $DE, $71, $8B, $D5, $75, $30
L6D29:  .byte $A7, $4F, $11, $C0, $89, $19, $1C, $A0
L6D31:  .byte $40, $72, $53, $B4, $71, $96, $B0, $C5
L6D39:  .byte $4D, $4E, $5A, $C5, $EC, $66, $BB, $98
L6D41:  .byte $BE, $45, $93, $84, $D3, $A5, $C7, $EA
L6D49:  .byte $A1, $9A, $71, $96, $51, $12, $BB, $FB
L6D51:  .byte $44, $6E, $56, $0D, $62, $54, $55, $97
L6D59:  .byte $00, $C9, $B2, $22, $40, $6A, $F1, $24
L6D61:  .byte $4F, $1D, $9E, $61, $B6, $96, $52, $7C
L6D69:  .byte $99, $7A, $8F, $19, $5A, $C9, $97, $92
L6D71:  .byte $9E, $6C, $48, $C5, $57, $A9, $45, $B3
L6D79:  .byte $25, $A4, $94, $65, $11, $4D, $12, $1F
L6D81:  .byte $BD, $A5, $9A, $CB, $0E, $6C, $D0, $D6
L6D89:  .byte $E4, $E6, $2E, $30, $C1, $7A, $43, $B8
L6D91:  .byte $BB, $C4, $05, $A7, $EE, $E2, $89, $93
L6D99:  .byte $D0, $B9, $9B, $AA, $C9, $0D, $62, $36
L6DA1:  .byte $66, $1E, $EA, $84, $01, $51, $A9, $31
L6DA9:  .byte $20, $19, $77, $95, $D9, $DE, $2A, $1E
L6DB1:  .byte $49, $42, $E6, $FC, $36, $AB, $CD, $29
L6DB9:  .byte $79, $30, $33, $C2, $BA, $A4, $E5, $A6
L6DC1:  .byte $B5, $A5, $AB, $DB, $94, $B9, $B2, $CE
L6DC9:  .byte $5A, $71, $43, $E6, $EA, $2A, $5B, $C5
L6DD1:  .byte $35, $99, $4F, $17, $C8, $5D, $57, $25
L6DD9:  .byte $D1, $6E, $31, $65, $5C, $04, $C8, $E4
L6DE1:  .byte $F4, $00, $FF
L6DE4:  .byte $2D, $2B, $83, $9D, $4B, $B2, $8E, $AC ;phrase 31, TMS5220 speech data
L6DEC:  .byte $36, $55, $6C, $4F, $5B, $D2, $14, $C8
L6DF4:  .byte $7D, $23, $49, $48, $A2, $15, $F7, $ED
L6DFC:  .byte $B4, $50, $C2, $94, $55, $3C, $3C, $E9
L6E04:  .byte $88, $F2, $64, $77, $F5, $36, $23, $2C
L6E0C:  .byte $D3, $34, $55, $DB, $AD, $A0, $4C, $D3
L6E14:  .byte $30, $6D, $B7, $C2, $32, $54, $C3, $B5
L6E1C:  .byte $9D, $08, $4B, $17, $D3, $34, $AF, $2D
L6E24:  .byte $CE, $53, $02, $CB, $DA, $A6, $38, $65
L6E2C:  .byte $0E, $49, $6B, $53, $F2, $EC, $A9, $CC
L6E34:  .byte $BC, $D1, $48, $52, $90, $90, $88, $25
L6E3C:  .byte $2B, $AD, $41, $9C, $23, $EB, $AC, $AC
L6E44:  .byte $55, $51, $B1, $6C, $6B, $80, $64, $31
L6E4C:  .byte $19, $50, $0C, $AB, $00, $82, $30, $1B
L6E54:  .byte $79, $33, $2E, $6E, $3E, $67, $E5, $D5
L6E5C:  .byte $89, $AB, $E7, $92, $56, $8E, $28, $EE
L6E64:  .byte $22, $51, $14, $30, $A2, $F8, $CA, $47
L6E6C:  .byte $B4, $60, $95, $A5, $2B, $AB, $DE, $42
L6E74:  .byte $5C, $97, $AD, $2C, $67, $0F, $AA, $6C
L6E7C:  .byte $BD, $F2, $14, $23, $B1, $7C, $49, $29
L6E84:  .byte $B3, $F4, $12, $B3, $4C, $A1, $8B, $D2
L6E8C:  .byte $D3, $2C, $B3, $28, $C0, $B3, $8C, $91
L6E94:  .byte $35, $51, $61, $2A, $75, $56, $99, $6D
L6E9C:  .byte $96, $B1, $2E, $5D, $55, $52, $D1, $4E
L6EA4:  .byte $B2, $B6, $D4, $41, $55, $07, $E9, $93
L6EAC:  .byte $56, $47, $59, $1D, $C4, $4B, $57, $9D
L6EB4:  .byte $6D, $8E, $8A, $AE, $59, $75, $8E, $D5
L6EBC:  .byte $6C, $B6, $64, $D5, $D5, $5A, $58, $D8
L6EC4:  .byte $92, $D5, $34, $A3, $6A, $91, $4B, $52
L6ECC:  .byte $DB, $B4, $98, $56, $B4, $06, $06, $28
L6ED4:  .byte $13, $C5, $80, $C4, $DA, $25, $00, $04
L6EDC:  .byte $70, $41, $AA, $D4, $35, $90, $59, $D4
L6EE4:  .byte $D3, $D1, $B5, $C4, $2A, $9E, $6B, $47
L6EEC:  .byte $D7, $B3, $88, $A8, $3F, $99, $5D, $EB
L6EF4:  .byte $7B, $49, $65, $E6, $26, $AE, $AF, $46
L6EFC:  .byte $44, $2B, $1E, $21, $80, $C6, $68, $D5
L6F04:  .byte $27, $13, $E1, $1A, $89, $E1, $01, $FF
L6F0C:  .byte $0C, $30, $A9, $CC, $71, $D1, $66, $A7 ;phrase 32, TMS5220 speech data
L6F14:  .byte $8A, $12, $C7, $C6, $58, $59, $A2, $5E
L6F1C:  .byte $1C, $1D, $62, $A7, $87, $BB, $0E, $4C
L6F24:  .byte $28, $95, $AE, $EA, $25, $B1, $31, $46
L6F2C:  .byte $45, $8A, $D2, $C0, $84, $DC, $19, $AA
L6F34:  .byte $69, $12, $97, $82, $55, $B5, $D0, $49
L6F3C:  .byte $7C, $0C, $D1, $A1, $A6, $24, $F1, $31
L6F44:  .byte $44, $9B, $B8, $EB, $C0, $B9, $D2, $2D
L6F4C:  .byte $1A, $69, $92, $10, $5D, $B4, $99, $D9
L6F54:  .byte $09, $9C, $CF, $D5, $A2, $96, $26, $09
L6F5C:  .byte $C9, $F8, $B8, $85, $E3, $C4, $87, $E8
L6F64:  .byte $ED, $AA, $49, $0A, $1F, $9C, $77, $84
L6F6C:  .byte $3B, $4E, $9C, $8F, $3E, $2E, $96, $A6
L6F74:  .byte $08, $D9, $69, $59, $99, $DC, $C4, $B9
L6F7C:  .byte $9A, $E3, $AE, $69, $8A, $90, $83, $A4
L6F84:  .byte $97, $29, $2D, $5C, $8C, $3A, $61, $EE
L6F8C:  .byte $B6, $71, $39, $4A, $46, $99, $DA, $C6
L6F94:  .byte $C5, $A8, $9D, $6E, $69, $07, $5F, $92
L6F9C:  .byte $46, $BA, $CB, $1D, $5C, $88, $9E, $95
L6FA4:  .byte $9E, $74, $B0, $21, $58, $57, $A6, $9B
L6FAC:  .byte $C5, $26, $AB, $ED, $19, $4E, $16, $57
L6FB4:  .byte $BC, $96, $A7, $3A, $39, $52, $F1, $5E
L6FBC:  .byte $61, $E1, $64, $31, $C1, $47, $55, $44
L6FC4:  .byte $92, $C5, $E7, $E0, $E5, $29, $8E, $8F
L6FCC:  .byte $94, $A3, $97, $87, $BB, $59, $4C, $F4
L6FD4:  .byte $DE, $15, $E1, $64, $09, $39, $7A, $79
L6FDC:  .byte $89, $EB, $45, $A7, $60, $E5, $1E, $6E
L6FE4:  .byte $8F, $90, $7D, $94, $87, $A9, $39, $74
L6FEC:  .byte $76, $96, $5E, $E6, $ED, $08, $D9, $7A
L6FF4:  .byte $5B, $9A, $D2, $45, $47, $1B, $E5, $15
L6FFC:  .byte $C9, $0E, $97, $5C, $54, $98, $25, $3B
L7004:  .byte $5C, $76, $DE, $56, $EA, $76, $71, $C9
L700C:  .byte $59, $87, $59, $BC, $C3, $17, $67, $15
L7014:  .byte $E9, $76, $17, $1B, $7C, $54, $45, $24
L701C:  .byte $59, $6C, $76, $5A, $15, $E6, $E4, $48
L7024:  .byte $D9, $7B, $85, $A7, $E3, $C5, $44, $1B
L702C:  .byte $D9, $EE, $4E, $0E, $93, $9D, $65, $46
L7034:  .byte $38, $5E, $4C, $72, $DA, $19, $EE, $78
L703C:  .byte $31, $D9, $48, $67, $6B, $92, $C5, $54
L7044:  .byte $CF, $E9, $6D, $4E, $96, $50, $BD, $96
L704C:  .byte $A7, $BB, $1E, $74, $36, $92, $1E, $EA
L7054:  .byte $78, $90, $D5, $6A, $59, $A9, $E2, $41
L705C:  .byte $65, $29, $AD, $A5, $6E, $9A, $50, $B5
L7064:  .byte $86, $B9, $2A, $2E, $72, $72, $1A, $E6
L706C:  .byte $E2, $B0, $28, $29, $9B, $B8, $A9, $E4
L7074:  .byte $A4, $E6, $12, $E6, $6E, $36, $19, $E0
L707C:  .byte $B3, $DA, $03, $36, $59, $6D, $FF
L7083:  .byte $65, $28, $DE, $CD, $D2, $4B, $9B, $36 ;phrase 33, TMS5220 speech data
L708B:  .byte $8B, $54, $1B, $AB, $8C, $00, $69, $3B
L7093:  .byte $10, $90, $4D, $AA, $00, $B2, $16, $6F
L709B:  .byte $4D, $35, $6A, $16, $3E, $A9, $B5, $C5
L70A3:  .byte $09, $7B, $57, $E5, $D4, $66, $87, $39
L70AB:  .byte $5E, $76, $5C, $17, $2D, $75, $5B, $D8
L70B3:  .byte $01, $06, $84, $27, $64, $2A, $5F, $43
L70BB:  .byte $C3, $AC, $6E, $AA, $7C, $33, $0B, $A3
L70C3:  .byte $B6, $A5, $8C, $CD, $D5, $83, $BA, $B5
L70CB:  .byte $22, $15, $53, $2B, $F2, $32, $F2, $DC
L70D3:  .byte $CC, $34, $45, $ED, $C8, $CB, $10, $71
L70DB:  .byte $37, $B5, $23, $2B, $49, $85, $2B, $E2
L70E3:  .byte $95, $2C, $6B, $75, $D5, $A8, $1D, $F2
L70EB:  .byte $A8, $D4, $43, $2A, $8E, $CB, $B2, $92
L70F3:  .byte $D0, $CA, $D8, $0A, $68, $C6, $4D, $01
L70FB:  .byte $2D, $BA, $B6, $B8, $24, $B1, $74, $B3
L7103:  .byte $32, $E2, $98, $2D, $D5, $CD, $E9, $8A
L710B:  .byte $52, $CE, $30, $33, $A7, $2B, $8A, $D5
L7113:  .byte $53, $DD, $DC, $AC, $38, $96, $4C, $31
L711B:  .byte $4F, $3A, $E2, $10, $32, $CC, $B9, $8D
L7123:  .byte $CA, $A2, $EB, $64, $C7, $36, $A5, $4C
L712B:  .byte $BA, $5B, $03, $D2, $8E, $32, $8B, $1E
L7133:  .byte $09, $4C, $33, $CA, $C4, $7B, $24, $A8
L713B:  .byte $CD, $28, $33, $AD, $D1, $C0, $AE, $A3
L7143:  .byte $4A, $7C, $5A, $1D, $D7, $A4, $CA, $C7
L714B:  .byte $2A, $25, $AF, $EF, $6A, $6F, $2A, $54
L7153:  .byte $3D, $AE, $A9, $83, $8A, $08, $37, $27
L715B:  .byte $A6, $CE, $D2, $CC, $CC, $EC, $20, $80
L7163:  .byte $A8, $B0, $07, $FF
L7167:  .byte $A6, $B3, $3A, $32, $3D, $E5, $B8, $2A ;phrase 34, TMS5220 speech data
L716F:  .byte $48, $C9, $8C, $B1, $B5, $B2, $6E, $C2
L7177:  .byte $29, $B3, $D1, $8A, $9A, $0D, $D7, $CA
L717F:  .byte $5A, $CB, $AF, $3A, $2D, $AA, $3A, $2F
L7187:  .byte $B7, $BA, $70, $0B, $6D, $B3, $9C, $5C
L718F:  .byte $3C, $DD, $31, $C9, $B2, $6A, $89, $30
L7197:  .byte $13, $AF, $CB, $A9, $35, $38, $DC, $D3
L719F:  .byte $2C, $BF, $0D, $53, $49, $4D, $1D, $C2
L71A7:  .byte $DA, $5D, $34, $24, $49, $8A, $A6, $6E
L71AF:  .byte $13, $B7, $24, $06, $68, $3C, $64, $B9
L71B7:  .byte $23, $A6, $98, $A6, $E5, $E5, $55, $1B
L71BF:  .byte $1A, $11, $B1, $97, $57, $4C, $44, $64
L71C7:  .byte $AD, $5D, $5E, $B6, $55, $12, $D9, $74
L71CF:  .byte $F9, $39, $CC, $B0, $7B, $ED, $E5, $A7
L71D7:  .byte $38, $65, $C6, $4D, $5B, $90, $65, $96
L71DF:  .byte $B8, $C4, $69, $41, $52, $11, $64, $92
L71E7:  .byte $65, $05, $55, $5A, $58, $7A, $EC, $15
L71EF:  .byte $74, $AB, $22, $1D, $55, $56, $D8, $AD
L71F7:  .byte $B0, $4C, $96, $29, $71, $D3, $2A, $56
L71FF:  .byte $B6, $28, $65, $DD, $9A, $70, $70, $E3
L7207:  .byte $11, $57, $CB, $E2, $13, $53, $56, $DC
L720F:  .byte $B4, $88, $5F, $56, $59, $71, $D3, $2C
L7217:  .byte $7E, $19, $77, $A5, $D5, $B3, $C4, $66
L721F:  .byte $AC, $95, $16, $63, $91, $13, $B1, $46
L7227:  .byte $9A, $42, $65, $8C, $CF, $5A, $59, $0A
L722F:  .byte $93, $D2, $B1, $78, $64, $A9, $AC, $4B
L7237:  .byte $65, $9D, $91, $A7, $BA, $A9, $91, $73
L723F:  .byte $46, $11, $D3, $A6, $A6, $CF, $1E, $65
L7247:  .byte $2C, $15, $96, $39, $67, $D4, $39, $74
L724F:  .byte $69, $DA, $AA, $D1, $66, $97, $65, $E5
L7257:  .byte $AB, $46, $DF, $9C, $A7, $A5, $AD, $32
L725F:  .byte $40, $F0, $5A, $08, $F0, $5A, $06, $01
L7267:  .byte $D4, $46, $20, $40, $CA, $70, $04, $04
L726F:  .byte $6E, $CE, $80, $A9, $D5, $18, $D0, $A5
L7277:  .byte $06, $03, $2A, $4D, $23, $40, $96, $29
L727F:  .byte $0F, $FF
L7281:  .byte $A6, $6B, $96, $1A, $C4, $5B, $BB, $A6 ;phrase 35, TMS5220 speech data
L7289:  .byte $39, $1A, $34, $6B, $1D, $F2, $EA, $75
L7291:  .byte $C0, $BD, $75, $0B, $5B, $94, $65, $83
L7299:  .byte $A4, $CB, $AA, $CE, $C7, $85, $DD, $2C
L72A1:  .byte $B5, $78, $1F, $47, $4D, $BB, $A4, $AC
L72A9:  .byte $BC, $52, $B4, $CD, $E0, $8B, $E9, $76
L72B1:  .byte $85, $A9, $8D, $6B, $DC, $2B, $1C, $CE
L72B9:  .byte $36, $AE, $B2, $E8, $70, $98, $3C, $C4
L72C1:  .byte $CA, $BC, $CA, $A1, $4A, $30, $82, $CD
L72C9:  .byte $56, $D6, $78, $2E, $4D, $B6, $33, $D4
L72D1:  .byte $CB, $10, $20, $BE, $12, $04, $C4, $59
L72D9:  .byte $C2, $80, $34, $87, $05, $90, $9E, $8A
L72E1:  .byte $00, $D2, $11, $61, $40, $EE, $2E, $08
L72E9:  .byte $48, $C5, $08, $01, $5D, $86, $61, $00
L72F1:  .byte $01, $1E, $9B, $22, $40, $51, $35, $04
L72F9:  .byte $64, $E6, $8A, $80, $22, $5C, $10, $90
L7301:  .byte $98, $2B, $02, $02, $33, $45, $80, $67
L7309:  .byte $21, $08, $88, $C2, $15, $01, $9A, $AA
L7311:  .byte $21, $20, $53, $77, $04, $14, $EE, $8A
L7319:  .byte $00, $8F, $55, $10, $90, $89, $29, $02
L7321:  .byte $32, $55, $45, $40, $21, $AA, $08, $C8
L7329:  .byte $DC, $14, $01, $81, $AA, $22, $40, $53
L7331:  .byte $15, $04, $78, $A2, $8C, $00, $43, $54
L7339:  .byte $11, $90, $B8, $08, $02, $02, $55, $41
L7341:  .byte $40, $62, $AA, $08, $48, $CC, $05, $01
L7349:  .byte $81, $A9, $85, $C4, $0B, $09, $C9, $2C
L7351:  .byte $DB, $92, $9C, $C4, $25, $B3, $EC, $0A
L7359:  .byte $73, $F6, $22, $CD, $26, $CB, $2F, $3E
L7361:  .byte $5B, $D9, $DB, $2C, $B7, $B8, $1C, $67
L7369:  .byte $4F, $B3, $AC, $AA, $A3, $43, $2C, $E9
L7371:  .byte $32, $9B, $91, $31, $B5, $D4, $C3, $C8
L7379:  .byte $DE, $93, $43, $53, $35, $33, $4B, $69
L7381:  .byte $71, $75, $12, $9C, $C8, $A5, $35, $DD
L7389:  .byte $09, $89, $22, $97, $54, $F7, $38, $06
L7391:  .byte $68, $59, $8C, $01, $D9, $72, $20, $40
L7399:  .byte $4B, $2F, $20, $40, $CB, $E4, $C3, $1F
L73A1:  .byte $35, $35, $53, $2D, $2F, $BF, $8F, $20
L73A9:  .byte $55, $AF, $BA, $FC, $D1, $46, $45, $64
L73B1:  .byte $F6, $F2, $7B, $1D, $53, $C1, $D9, $2B
L73B9:  .byte $E8, $C5, $D5, $85, $96, $B4, $A8, $C5
L73C1:  .byte $50, $33, $68, $32, $A2, $96, $DD, $4C
L73C9:  .byte $71, $CE, $08, $5B, $36, $55, $91, $AB
L73D1:  .byte $2B, $6C, $C5, $54, $55, $EE, $AC, $A0
L73D9:  .byte $A7, $60, $35, $BD, $BD, $C2, $91, $52
L73E1:  .byte $4C, $FC, $F2, $0A, $87, $0F, $71, $F1
L73E9:  .byte $29, $23, $6A, $56, $D5, $29, $2A, $97
L73F1:  .byte $28, $2B, $0E, $D3, $8E, $53, $E2, $AC
L73F9:  .byte $38, $D5, $2A, $49, $4A, $B2, $E2, $94
L7401:  .byte $88, $34, $21, $8D, $92, $4B, $A2, $92
L7409:  .byte $80, $00, $12, $13, $29, $59, $D7, $69
L7411:  .byte $22, $DA, $A8, $A5, $25, $BB, $88, $67
L7419:  .byte $E5, $95, $D5, $64, $45, $56, $75, $56
L7421:  .byte $D1, $92, $A7, $68, $CE, $19, $55, $49
L7429:  .byte $EA, $12, $5D, $B5, $34, $B5, $9A, $B3
L7431:  .byte $55, $E4, $D4, $B6, $E6, $2E, $64, $61
L7439:  .byte $43, $D7, $1B, $BB, $B1, $47, $4E, $75
L7441:  .byte $4B, $A2, $2E, $56, $AA, $94, $2D, $92
L7449:  .byte $7B, $64, $E4, $51, $D4, $24, $1A, $51
L7451:  .byte $55, $47, $DE, $0A, $B9, $46, $57, $1B
L7459:  .byte $79, $AB, $64, $96, $5D, $B5, $95, $AD
L7461:  .byte $A2, $69, $4E, $DC, $52, $F6, $8E, $A6
L7469:  .byte $D1, $76, $4B, $D9, $17, $89, $68, $C7
L7471:  .byte $09, $55, $1F, $24, $A2, $13, $55, $35
L7479:  .byte $DD, $09, $A1, $79, $23, $04, $74, $19
L7481:  .byte $06, $08, $68, $1A, $95, $01, $DD, $B9
L7489:  .byte $32, $A0, $BB, $49, $02, $D4, $94, $82
L7491:  .byte $80, $14, $99, $E0, $01, $FF
L7497:  .byte $AD, $2E, $31, $93, $39, $AB, $AE, $A2 ;phrase 36, TMS5220 speech data
L749F:  .byte $94, $4C, $B6, $8D, $BA, $D2, $9A, $B2
L74A7:  .byte $54, $7B, $CE, $0A, $AB, $EF, $72, $F5
L74AF:  .byte $3B, $2B, $28, $B1, $DC, $6D, $66, $2F
L74B7:  .byte $BF, $A4, $08, $F1, $8E, $92, $A2, $E2
L74BF:  .byte $DC, $58, $33, $4E, $C8, $BB, $71, $37
L74C7:  .byte $B1, $58, $A0, $80, $A1, $C5, $04, $10
L74CF:  .byte $09, $5B, $CA, $86, $61, $2E, $D2, $36
L74D7:  .byte $25, $1B, $5A, $28, $4D, $BA, $94, $64
L74DF:  .byte $48, $81, $72, $4B, $BB, $C2, $51, $93
L74E7:  .byte $15, $AB, $EE, $0A, $47, $37, $62, $E9
L74EF:  .byte $B8, $2B, $1A, $2D, $40, $B4, $E2, $AE
L74F7:  .byte $68, $74, $07, $B1, $AA, $BB, $E2, $D1
L74FF:  .byte $03, $C5, $B2, $EE, $8A, $C7, $34, $14
L7507:  .byte $AD, $A6, $2B, $1E, $43, $51, $B4, $EA
L750F:  .byte $AE, $78, $2C, $45, $D1, $AE, $BA, $E2
L7517:  .byte $B1, $84, $44, $BA, $EE, $88, $C7, $64
L751F:  .byte $12, $ED, $BA, $23, $19, $83, $48, $75
L7527:  .byte $E2, $B6, $A4, $57, $64, $B1, $71, $5A
L752F:  .byte $D2, $16, $50, $39, $DB, $B1, $2B, $8B
L7537:  .byte $61, $55, $6B, $DB, $A2, $CB, $9C, $A4
L753F:  .byte $3C, $E3, $20, $00, $0A, $2B, $02, $04
L7547:  .byte $A4, $22, $80, $CE, $44, $15, $30, $65
L754F:  .byte $98, $02, $B6, $0C, $33, $C0, $11, $EE
L7557:  .byte $06, $B8, $3A, $DC, $00, $5B, $47, $1A
L755F:  .byte $E0, $78, $73, $04, $74, $19, $06, $0A
L7567:  .byte $18, $C2, $BD, $44, $DB, $44, $B2, $48
L756F:  .byte $9A, $96, $E4, $E4, $41, $5A, $71, $5A
L7577:  .byte $96, $63, $25, $52, $C6, $36, $45, $D2
L757F:  .byte $61, $8C, $9D, $34, $15, $C5, $56, $30
L7587:  .byte $86, $9D, $95, $17, $9B, $25, $D4, $4D
L758F:  .byte $56, $5E, $7C, $06, $6B, $D7, $69, $65
L7597:  .byte $F5, $59, $28, $19, $47, $55, $81, $69
L759F:  .byte $8A, $75, $64, $08, $D9, $54, $A6, $62
L75A7:  .byte $26, $67, $A5, $D5, $45, $30, $D7, $EC
L75AF:  .byte $95, $A6, $1C, $21, $D5, $95, $57, $9A
L75B7:  .byte $63, $97, $44, $4D, $59, $69, $CE, $33
L75BF:  .byte $E4, $35, $7B, $25, $39, $CE, $B0, $55
L75C7:  .byte $E5, $95, $E6, $3C, $43, $36, $95, $57
L75CF:  .byte $96, $DA, $24, $67, $45, $6E, $79, $DA
L75D7:  .byte $15, $3C, $69, $B9, $14, $25, $55, $B1
L75DF:  .byte $A5, $19, $05, $54, $BF, $49, $00, $6F
L75E7:  .byte $59, $10, $10, $A3, $0A, $02, $BA, $0C
L75EF:  .byte $03, $05, $94, $94, $21, $80, $A5, $B3
L75F7:  .byte $05, $70, $4D, $84, $00, $9E, $B1, $54
L75FF:  .byte $C0, $53, $E6, $0C, $C8, $36, $B8, $54
L7607:  .byte $25, $7A, $89, $96, $E5, $56, $E7, $98
L760F:  .byte $2D, $5E, $65, $4A, $93, $4B, $16, $45
L7617:  .byte $97, $4E, $6D, $8E, $D9, $1A, $51, $B0
L761F:  .byte $F4, $25, $55, $4B, $A6, $CD, $32, $E5
L7627:  .byte $E1, $61, $93, $B6, $DB, $9C, $73, $94
L762F:  .byte $77, $5B, $11, $40, $0C, $56, $04, $C8
L7637:  .byte $8E, $0A, $01, $35, $61, $21, $A0, $38
L763F:  .byte $6C, $04, $64, $07, $85, $80, $2E, $C3
L7647:  .byte $30, $80, $01, $0C, $00, $03, $BA, $0C
L764F:  .byte $43, $40, $52, $94, $F0, $00, $FF
L7656:  .byte $04, $A8, $DA, $59, $00, $55, $B9, $29 ;phrase 37, TMS5220 speech data
L765E:  .byte $A0, $49, $73, $03, $74, $19, $DA, $A8
L7666:  .byte $12, $CD, $39, $83, $CA, $A0, $72, $71
L766E:  .byte $D7, $32, $DA, $83, $2C, $31, $4A, $A2
L7676:  .byte $58, $0F, $3A, $C7, $2C, $6D, $A7, $35
L767E:  .byte $B8, $1C, $BC, $6C, $92, $76, $53, $73
L7686:  .byte $51, $D7, $09, $C5, $C3, $CD, $3E, $C2
L768E:  .byte $7C, $42, $8F, $A0, $44, $0F, $B5, $B1
L7696:  .byte $9C, $92, $62, $C3, $4C, $43, $0E, $02
L769E:  .byte $94, $57, $47, $80, $93, $2C, $08, $E8
L76A6:  .byte $32, $0C, $01, $59, $A9, $16, $36, $25
L76AE:  .byte $33, $EA, $B2, $D3, $C4, $EC, $BD, $98
L76B6:  .byte $26, $8E, $09, $4A, $F4, $42, $6E, $BB
L76BE:  .byte $08, $B0, $CD, $03, $04, $50, $AC, $9A
L76C6:  .byte $02, $8A, $AE, $2E, $54, $4C, $DD, $CA
L76CE:  .byte $61, $67, $D0, $B1, $77, $7B, $A6, $E2
L76D6:  .byte $C2, $25, $D7, $AD, $9A, $A2, $15, $90
L76DE:  .byte $55, $39, $03, $32, $0F, $2B, $DC, $31
L76E6:  .byte $EE, $61, $EE, $68, $29, $CD, $5A, $B1
L76EE:  .byte $B4, $B5, $E0, $45, $6F, $26, $5A, $71
L76F6:  .byte $4C, $56, $9D, $15, $52, $C6, $43, $40
L76FE:  .byte $94, $66, $83, $AF, $55, $5C, $32, $24
L7706:  .byte $0F, $B1, $65, $33, $8A, $AA, $3B, $A4
L770E:  .byte $21, $3D, $C0, $BD, $CA, $50, $BA, $2F
L7716:  .byte $27, $D1, $C4, $43, $AD, $D9, $94, $E2
L771E:  .byte $E2, $0C, $A3, $04, $56, $EB, $B5, $A3
L7726:  .byte $B2, $E6, $5D, $44, $66, $AA, $02, $0A
L772E:  .byte $31, $17, $C0, $0B, $2D, $43, $EB, $C5
L7736:  .byte $04, $B3, $6B, $0F, $BB, $46, $D4, $EA
L773E:  .byte $8E, $DB, $9C, $12, $48, $23, $6B, $AA
L7746:  .byte $72, $AB, $23, $89, $8E, $3A, $0A, $A8
L774E:  .byte $C8, $8C, $01, $59, $AA, $0A, $A0, $9B
L7756:  .byte $50, $05, $34, $EB, $DA, $D4, $1A, $44
L775E:  .byte $5C, $27, $76, $B0, $6B, $86, $F4, $9E
L7766:  .byte $2A, $20, $80, $52, $DD, $0C, $30, $62
L776E:  .byte $9A, $02, $9A, $72, $15, $40, $11, $41
L7776:  .byte $02, $A8, $22, $25, $E9, $DD, $A6, $98
L777E:  .byte $64, $E4, $21, $17, $6B, $51, $59, $52
L7786:  .byte $97, $98, $BD, $55, $44, $5A, $6D, $62
L778E:  .byte $D6, $EE, $61, $2E, $DB, $00, $59, $44
L7796:  .byte $28, $A0, $71, $51, $03, $0C, $53, $4A
L779E:  .byte $80, $C6, $42, $10, $10, $B8, $69, $D3
L77A6:  .byte $72, $E6, $E0, $CC, $CA, $C9, $4E, $96
L77AE:  .byte $53, $F2, $92, $2C, $B7, $25, $15, $D1
L77B6:  .byte $98, $B3, $DC, $E6, $58, $A5, $AB, $EA
L77BE:  .byte $70, $9B, $21, $D3, $AE, $A8, $C9, $CB
L77C6:  .byte $0A, $3B, $D2, $E3, $25, $BF, $28, $E8
L77CE:  .byte $48, $4B, $BA, $DC, $E6, $DD, $D4, $B7
L77D6:  .byte $CC, $72, $72, $08, $AB, $2A, $27, $CB
L77DE:  .byte $2C, $2E, $B4, $3B, $ED, $2C, $BD, $C4
L77E6:  .byte $30, $8F, $B1, $53, $CC, $92, $CC, $2C
L77EE:  .byte $CB, $F2, $B2, $6A, $10, $35, $AF, $38
L77F6:  .byte $CB, $EE, $49, $D8, $B2, $E2, $A2, $B4
L77FE:  .byte $7A, $34, $AF, $0E, $33, $BC, $E1, $D8
L7806:  .byte $42, $5C, $EE, $F2, $7B, $74, $D2, $CC
L780E:  .byte $B2, $2B, $E8, $C1, $D1, $26, $EB, $AF
L7816:  .byte $60, $78, $27, $AD, $AA, $16, $FC, $EE
L781E:  .byte $59, $B4, $C7, $8E, $00, $12, $33, $2F
L7826:  .byte $F6, $8E, $C9, $2A, $56, $BB, $39, $3D
L782E:  .byte $92, $48, $76, $D5, $E4, $67, $83, $D5
L7836:  .byte $65, $71, $97, $DF, $AB, $A1, $A7, $47
L783E:  .byte $59, $E1, $F0, $6D, $14, $5A, $B9, $84
L7846:  .byte $D5, $60, $84, $5B, $B5, $E1, $37, $1F
L784E:  .byte $2E, $3E, $63, $97, $97, $43, $44, $D5
L7856:  .byte $5A, $5D, $66, $8E, $61, $3D, $19, $67
L785E:  .byte $C9, $D9, $97, $67, $7B, $9C, $25, $95
L7866:  .byte $68, $11, $D9, $B1, $87, $D2, $54, $46
L786E:  .byte $B8, $5B, $2A, $D2, $D6, $9B, $AA, $9E
L7876:  .byte $C8, $01, $09, $86, $30, $40, $C2, $60
L787E:  .byte $06, $14, $0D, $DC, $8C, $12, $CC, $35
L7886:  .byte $24, $69, $F1, $C3, $54, $75, $E5, $B6
L788E:  .byte $2D, $0C, $4D, $23, $84, $D3, $B6, $24
L7896:  .byte $A4, $4C, $55, $6A, $3D, $B2, $E8, $32
L789E:  .byte $CD, $74, $F3, $CA, $8A, $76, $F7, $B4
L78A6:  .byte $DD, $2B, $6B, $CE, $45, $CA, $16, $8F
L78AE:  .byte $78, $FA, $74, $50, $9D, $63, $92, $6E
L78B6:  .byte $5D, $C8, $AD, $0A, $03, $32, $57, $16
L78BE:  .byte $40, $33, $AE, $C9, $ED, $C9, $98, $3D
L78C6:  .byte $9C, $AE, $A0, $B7, $64, $72, $6B, $3C
L78CE:  .byte $E2, $D6, $8C, $25, $ED, $C9, $88, $9B
L78D6:  .byte $37, $D5, $90, $C7, $23, $6E, $C6, $43
L78DE:  .byte $8C, $96, $98, $A4, $AA, $74, $72, $99
L78E6:  .byte $2D, $80, $44, $CD, $92, $97, $75, $48
L78EE:  .byte $7A, $5A, $29, $6E, $B6, $21, $66, $11
L78F6:  .byte $39, $79, $9D, $8F, $A8, $78, $6C, $06
L78FE:  .byte $74, $B1, $EA, $EC, $E2, $24, $5D, $25
L7906:  .byte $31, $28, $20, $6B, $76, $27, $86, $A9
L790E:  .byte $6E, $A6, $8E, $87, $9A, $5D, $95, $05
L7916:  .byte $AE, $6E, $4A, $CC, $15, $66, $36, $69
L791E:  .byte $A8, $69, $76, $B9, $49, $1C, $30, $40
L7926:  .byte $59, $29, $0E, $D8, $32, $9C, $01, $9D
L792E:  .byte $AA, $04, $A9, $A3, $56, $53, $4B, $6C
L7936:  .byte $CC, $A0, $CD, $53, $B4, $A1, $33, $93
L793E:  .byte $A1, $56, $F5, $26, $C5, $CC, $C9, $8D
L7946:  .byte $4D, $AF, $34, $A7, $59, $73, $4A, $9B
L794E:  .byte $03, $0A, $98, $8A, $9D, $00, $85, $B0
L7956:  .byte $27, $BD, $65, $54, $8D, $B2, $DD, $AC
L795E:  .byte $DE, $58, $34, $3A, $49, $72, $5A, $43
L7966:  .byte $89, $EC, $48, $08, $88, $8A, $1D, $01
L796E:  .byte $5E, $90, $09, $A0, $4A, $13, $05, $4C
L7976:  .byte $E7, $1E, $B8, $EE, $C3, $59, $D9, $69
L797E:  .byte $93, $5A, $52, $D1, $94, $D1, $45, $6E
L7986:  .byte $95, $D9, $32, $2A, $27, $A5, $67, $12
L798E:  .byte $99, $94, $AD, $B4, $16, $C1, $A3, $94
L7996:  .byte $09, $02, $88, $C9, $42, $80, $E6, $AA
L799E:  .byte $C5, $CA, $DA, $D3, $22, $E4, $0C, $2B
L79A6:  .byte $56, $CF, $CC, $94, $33, $9C, $94, $D3
L79AE:  .byte $B5, $BB, $F6, $F0, $72, $9C, $14, $8B
L79B6:  .byte $39, $C3, $2B, $B6, $2B, $A9, $6A, $37
L79BE:  .byte $B7, $98, $48, $E5, $AA, $15, $BC, $26
L79C6:  .byte $3D, $93, $B5, $B1, $F2, $9D, $77, $15
L79CE:  .byte $4B, $81, $41, $4D, $8A, $4B, $35, $92
L79D6:  .byte $14, $AB, $1A, $6C, $49, $F5, $EA, $DC
L79DE:  .byte $A2, $A9, $D5, $23, $A9, $00, $82, $F2
L79E6:  .byte $50, $40, $17, $65, $4D, $CB, $C6, $C3
L79EE:  .byte $B5, $25, $2F, $B3, $86, $32, $B3, $9E
L79F6:  .byte $3C, $AC, $12, $3C, $5C, $7C, $71, $71
L79FE:  .byte $8B, $A5, $34, $CB, $A6, $C5, $AD, $9A
L7A06:  .byte $9A, $DD, $9A, $04, $3F, $49, $1E, $76
L7A0E:  .byte $AF, $D5, $C2, $62, $BC, $39, $DC, $72
L7A16:  .byte $F3, $93, $9B, $54, $0F, $47, $CB, $C9
L7A1E:  .byte $BE, $5B, $BC, $E2, $2E, $27, $C7, $0A
L7A26:  .byte $F3, $6E, $5D, $DC, $2C, $A5, $D5, $C2
L7A2E:  .byte $A9, $08, $92, $94, $51, $4D, $3B, $25
L7A36:  .byte $5A, $A5, $4A, $3C, $15, $0D, $BF, $05
L7A3E:  .byte $0B, $76, $69, $DC, $FC, $1E, $CD, $5D
L7A46:  .byte $34, $8D, $0A, $92, $54, $F7, $F4, $9A
L7A4E:  .byte $CE, $2B, $12, $D7, $C2, $9D, $98, $20
L7A56:  .byte $49, $DE, $D0, $B0, $4C, $00, $53, $34
L7A5E:  .byte $05, $D0, $B8, $99, $F1, $83, $77, $89
L7A66:  .byte $32, $2B, $CB, $2E, $55, $43, $AC, $AB
L7A6E:  .byte $36, $2F, $5B, $D5, $D8, $2C, $6D, $C2
L7A76:  .byte $64, $38, $C3, $23, $70, $0A, $BB, $11
L7A7E:  .byte $71, $AB, $D8, $25, $E8, $4E, $84, $B3
L7A86:  .byte $AB, $98, $A8, $79, $66, $CB, $88, $8D
L7A8E:  .byte $00, $27, $45, $4B, $14, $66, $9A, $78
L7A96:  .byte $5A, $1E, $71, $0E, $5D, $AA, $3D, $67
L7A9E:  .byte $45, $39, $75, $68, $56, $DD, $15, $95
L7AA6:  .byte $10, $1A, $D1, $75, $56, $50, $63, $B2
L7AAE:  .byte $BA, $CD, $11, $40, $F4, $6A, $02, $A8
L7AB6:  .byte $4C, $AD, $28, $39, $98, $98, $47, $94
L7ABE:  .byte $A0, $F9, $6E, $21, $96, $71, $94, $21
L7AC6:  .byte $5B, $BB, $79, $46, $61, $86, $B7, $65
L7ACE:  .byte $E1, $E6, $D8, $E8, $BA, $47, $78, $B8
L7AD6:  .byte $93, $A2, $04, $D7, $4D, $9A, $75, $87
L7ADE:  .byte $1C, $4B, $17, $9B, $37, $69, $72, $CA
L7AE6:  .byte $5D, $E4, $D9, $74, $48, $A9, $74, $51
L7AEE:  .byte $74, $D3, $26, $A5, $5A, $45, $35, $71
L7AF6:  .byte $02, $1B, $6B, $16, $4D, $4A, $31, $9A
L7AFE:  .byte $77, $16, $EC, $29, $5B, $69, $5E, $E9
L7B06:  .byte $08, $87, $1D, $51, $31, $D5, $99, $16
L7B0E:  .byte $89, $59, $5B, $24, $4C, $AA, $D9, $46
L7B16:  .byte $40, $97, $61, $F0, $00, $FF
L7B1C:  .byte $06, $68, $4A, $75, $D1, $3D, $BA, $18 ;phrase 38, TMS5220 speech data
L7B24:  .byte $D9, $94, $C5, $F5, $9A, $66, $98, $41
L7B2C:  .byte $86, $76, $4C, $98, $49, $98, $76, $40
L7B34:  .byte $55, $21, $01, $18, $44, $75, $B0, $5D
L7B3C:  .byte $98, $7A, $64, $A3, $25, $36, $6D, $62
L7B44:  .byte $96, $93, $97, $DE, $62, $29, $8B, $CE
L7B4C:  .byte $1E, $D1, $B6, $15, $C2, $61, $DB, $01
L7B54:  .byte $8D, $46, $04, $60, $70, $4D, $03, $4C
L7B5C:  .byte $A6, $A6, $80, $21, $4C, $1D, $D0, $85
L7B64:  .byte $C7, $A2, $BB, $37, $71, $E1, $39, $8B
L7B6C:  .byte $A9, $A9, $CD, $0D, $D3, $0E, $B6, $44
L7B74:  .byte $8F, $32, $68, $3D, $D8, $EC, $DC, $23
L7B7C:  .byte $A1, $51, $61, $73, $EB, $70, $83, $34
L7B84:  .byte $8B, $AD, $BD, $3D, $0D, $53, $2F, $BE
L7B8C:  .byte $E7, $36, $0E, $A9, $BD, $94, $E1, $52
L7B94:  .byte $D9, $74, $4A, $51, $B7, $29, $13, $B1
L7B9C:  .byte $D8, $0E, $18, $22, $CD, $01, $83, $A7
L7BA4:  .byte $1B, $60, $72, $CF, $44, $65, $12, $15
L7BAC:  .byte $12, $55, $13, $17, $43, $06, $67, $4A
L7BB4:  .byte $09, $4A, $0C, $E3, $22, $2D, $26, $E9
L7BBC:  .byte $39, $5D, $AA, $B4, $A5, $15, $37, $13
L7BC4:  .byte $6B, $1A, $6D, $56, $58, $42, $97, $78
L7BCC:  .byte $2F, $59, $51, $B5, $51, $1A, $BD, $78
L7BD4:  .byte $A5, $DD, $A7, $49, $D4, $9C, $95, $8E
L7BDC:  .byte $E0, $C6, $16, $75, $56, $BA, $BD, $1B
L7BE4:  .byte $69, $CC, $76, $D9, $D6, $62, $9C, $1E
L7BEC:  .byte $19, $14, $30, $89, $19, $02, $0A, $23
L7BF4:  .byte $46, $40, $97, $61, $0F, $FF
L7BFA:  .byte $85, $2E, $4E, $5C, $73, $EC, $2F, $B6 ;phrase 39, TMS5220 speech data
L7C02:  .byte $66, $35, $8E, $B6, $D3, $84, $62, $9C
L7C0A:  .byte $3D, $D3, $4C, $33, $A6, $E9, $70, $D6
L7C12:  .byte $C8, $0C, $C8, $34, $C3, $A9, $45, $41
L7C1A:  .byte $B7, $B9, $9D, $60, $16, $0D, $63, $9E
L7C22:  .byte $71, $96, $DF, $8C, $9B, $99, $DD, $5E
L7C2A:  .byte $61, $71, $EE, $1A, $3E, $6B, $C4, $39
L7C32:  .byte $58, $AA, $E9, $EC, $92, $C4, $10, $A9
L7C3A:  .byte $C2, $4B, $5C, $1C, $9D, $55, $30, $2D
L7C42:  .byte $1A, $51, $F2, $69, $6A, $B2, $7A, $C5
L7C4A:  .byte $CD, $87, $6A, $E8, $EA, $15, $8F, $90
L7C52:  .byte $26, $AA, $AB, $59, $D1, $8D, $89, $46
L7C5A:  .byte $D4, $61, $40, $62, $66, $4D, $1D, $3E
L7C62:  .byte $45, $C4, $6A, $0F, $BD, $55, $27, $4E
L7C6A:  .byte $7F, $62, $CC, $96, $9D, $B8, $7C, $36
L7C72:  .byte $04, $A9, $76, $F2, $B0, $94, $35, $A4
L7C7A:  .byte $1A, $D9, $DC, $6B, $EA, $92, $92, $B3
L7C82:  .byte $8C, $88, $B0, $4B, $8E, $D1, $CA, $A3
L7C8A:  .byte $AC, $0C, $25, $66, $0B, $F7, $B1, $3C
L7C92:  .byte $94, $94, $DC, $DC, $3B, $74, $51, $63
L7C9A:  .byte $F2, $08, $99, $B0, $41, $8B, $C1, $C3
L7CA2:  .byte $A9, $AC, $18, $3D, $E4, $30, $C1, $8D
L7CAA:  .byte $C2, $0C, $5F, $83, $D4, $3B, $16, $36
L7CB2:  .byte $11, $D0, $65, $D8, $03, $FF
L7CB8:  .byte $02, $88, $33, $BC, $21, $B9, $84, $57 ;phrase 40, TMS5220 speech data
L7CC0:  .byte $69, $9C, $B3, $E4, $DC, $EE, $E9, $89
L7CC8:  .byte $CF, $9A, $EB, $84, $67, $38, $39, $73
L7CD0:  .byte $A9, $1D, $9E, $99, $A4, $41, $A5, $75
L7CD8:  .byte $7A, $46, $DC, $06, $97, $BA, $15, $1E
L7CE0:  .byte $71, $1B, $52, $CA, $64, $99, $DB, $09
L7CE8:  .byte $6B, $99, $6D, $E1, $6E, $97, $01, $79
L7CF0:  .byte $18, $23, $20, $1F, $91, $07, $FF
L7CF7:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;ROM fill, 754 bytes of $FF
L7D07:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7D17:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7D27:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7D37:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7D47:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7D57:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7D67:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7D77:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7D87:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7D97:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7DA7:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7DB7:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7DC7:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7DD7:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7DE7:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7DF7:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7E07:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7E17:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7E27:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7E37:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7E47:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7E57:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7E67:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7E77:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7E87:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7E97:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7EA7:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7EB7:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7EC7:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7ED7:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7EE7:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7EF7:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7F07:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7F17:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7F27:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7F37:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7F47:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7F57:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7F67:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7F77:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7F87:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7F97:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7FA7:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7FB7:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7FC7:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7FD7:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L7FE7:  .byte $FF, $FF

;.SBTTL FILL ROM WITH FF'S
FILL:
PBXZ:
L7FE9:  .byte $FF, $FF, $FF         ;.REPT 03  FILL WITH FF'S

CPYRHT:
L7FEC:  .byte $43, $4F, $50, $59, $52, $49, $47, $48 ;.ASCII /COPYRIGHT 1983 ATARI/
L7FF4:  .byte $54, $20, $31, $39, $38, $34, $20, $41
L7FFC:  .byte $54, $41, $52
L7FFF:  .byte $49

.org $C000

TUNTAB:
LC000:  .word SWNUL, SF2V1, SF2V2, SF2V3 ;1-6
LC008:  .word SF2V4, SF2V5, SF2V6
LC00E:  .word BENV1, BENV2, BENV3, BENV4 ;7-10
LC016:  .word TSTV1                 ;TUNTAB goes on, 47 entries in all, a tune being one voice's part. tune 11: voice 3 of sound command $02 (PMTST)
LC018:  .word TSTV2                 ;tune 12: voice 4 of sound command $02 (PMTST)
LC01A:  .word TSTV3                 ;tune 13: voice 1 of sound command $02 (PMTST)
LC01C:  .word TSTV4                 ;tune 14: voice 2 of sound command $02 (PMTST)
LC01E:  .word march_v1              ;tune 15: voice 1 of sound command $2B (PMEND)
LC020:  .word march_v2              ;tune 16: voice 2 of sound command $2B (PMEND)
LC022:  .word march_v3              ;tune 17: voice 3 of sound command $2B (PMEND)
LC024:  .word march_v4              ;tune 18: voice 4 of sound command $2B (PMEND)
LC026:  .word tune_empty            ;tune 19: voice 1 of PMREB, which no command reaches - the empty tune
LC028:  .word tune_empty            ;tune 20: voice 2 of PMREB, which no command reaches - the empty tune
LC02A:  .word tune_empty            ;tune 21: voice 3 of PMREB, which no command reaches - the empty tune
LC02C:  .word tune_empty            ;tune 22: voice 4 of PMREB, which no command reaches - the empty tune
LC02E:  .word tune2c_v1             ;tune 23: voice 1 of sound command $2C (PMRRP)
LC030:  .word tune2c_v2             ;tune 24: voice 2 of sound command $2C (PMRRP)
LC032:  .word tune2c_v3             ;tune 25: voice 3 of sound command $2C (PMRRP)
LC034:  .word tune2c_v4             ;tune 26: voice 4 of sound command $2C (PMRRP)
LC036:  .word theme_v1              ;tune 27: voice 1 of sound command $2E (PMTH5)
LC038:  .word theme_v2              ;tune 28: voice 2 of sound command $2E (PMTH5)
LC03A:  .word theme_v3              ;tune 29: voice 3 of sound command $2E (PMTH5)
LC03C:  .word theme_v4              ;tune 30: voice 4 of sound command $2E (PMTH5)
LC03E:  .word tune31_v1             ;tune 31: voice 1 of sound command $31 (PM4TH)
LC040:  .word tune31_v2             ;tune 32: voice 2 of sound command $31 (PM4TH)
LC042:  .word tune31_v3             ;tune 33: voice 3 of sound command $31 (PM4TH)
LC044:  .word tune31_v4             ;tune 34: voice 4 of sound command $31 (PM4TH)
LC046:  .word tune29_v1             ;tune 35: voice 1 of sound command $29 (PMTHB)
LC048:  .word tune29_v2             ;tune 36: voice 2 of sound command $29 (PMTHB)
LC04A:  .word tune29_v3             ;tune 37: voice 3 of sound command $29 (PMTHB)
LC04C:  .word tune29_v4             ;tune 38: voice 4 of sound command $29 (PMTHB)
LC04E:  .word tune30_v1             ;tune 39: voice 1 of sound command $30 (PMDES)
LC050:  .word tune30_v2             ;tune 40: voice 2 of sound command $30 (PMDES)
LC052:  .word tune30_v3             ;tune 41: voice 3 of sound command $30 (PMDES)
LC054:  .word tune30_v4             ;tune 42: voice 4 of sound command $30 (PMDES)
LC056:  .word vamp_v1               ;tune 43: voice 1 of sound command $2F (PMDAR)
LC058:  .word vamp_v2               ;tune 44: voice 2 of sound command $2F (PMDAR)
LC05A:  .word vamp_v3               ;tune 45: voice 3 of sound command $2F (PMDAR)
LC05C:  .word vamp_v4               ;tune 46: voice 4 of sound command $2F (PMDAR)

;MISCELLANEOUS
;METER= 4/4
;.TITLE STAR WARS THEME
;.CSECT
;.RADIX 16
;FREQUENCY ENVELOPES
;NUL =0 ;NULL
;STR =1 ;STRINGS
;HRN =2 ;HORN
;TRB =3 ;TROMBONE
;BAS =4 ;BASSOON
;GLK =5 ;GLOCKINSPIEL(?)
;WW =6 ;WOODWINDS
;AMPLITUDE ENVELOPES
;NUL =0 ;NULL
;STC =1 ;STACATO
;HRD =2 ;HARD EMPHASIS
;QKR =3 ;QUICK RISING ATTACK
;WRB =4 ;WARBLE
;TUNTAB::
;.WORD SWNUL,SF2V1,SF2V2,SF2V3,SF2V4,SF2V5,SF2V6
;MISCELLANEOUS
;METER= 4/4
;SWNUL:
SF2V1:          ;.CALL 6 ;PARALLEL DESCENDING SEMI-TONE SCALES
SWNUL:
LC05E:  .byte $8D, $06              ;tune data from here to $D936. a step is two bytes: a note number (0 = rest, else the index into NOTTAB once the key offset is added) and a duration ($40 a quarter note, $80 a half, $20 an eighth, $16 $16 $14 a triplet, bit 0 set = tied to the note before, 0 = end of the tune) - or a function $80-$91 and its value (table PKDT: $80 .NRATE, $81 .CRATE, $82 .NVOL, $83 .CVOL, $84 .NKEY, $85 .CKEY, $86 frequency envelope, $87 .AENV, $8A .VC, $8B POKEY control, $8C .SYN, $8D .CALL tune number, $8E .LOOP count, $8F .ENDL), $90 .GOSUB with a two byte address, $91 .RETURN alone
;.CKEY 0
LC060:  .byte $85, $00
;.CALL 5
LC062:  .byte $8D, $05
;.ENDT
LC064:  .byte $00, $00

SF2V2:          ;.CALL 6
LC066:  .byte $8D, $06
;.CKEY -1
LC068:  .byte $85, $FF
;.CALL 5
LC06A:  .byte $8D, $05
;.ENDT
LC06C:  .byte $00, $00

SF2V3:          ;.CALL 6
LC06E:  .byte $8D, $06
;.CKEY -3
LC070:  .byte $85, $FD
;.CALL 5
LC072:  .byte $8D, $05
;.ENDT
LC074:  .byte $00, $00

SF2V4:          ;.CALL 6
LC076:  .byte $8D, $06
;.CKEY -6
LC078:  .byte $85, $FA
;.CALL 5
LC07A:  .byte $8D, $05
;.ENDT
LC07C:  .byte $00, $00

SF2V5:          ;.LOOP 30
LC07E:  .byte $8E, $30
;.NOTE E5XT
LC080:  .byte $41, $04
;.CKEY -1
LC082:  .byte $85, $FF
;.CRATE 1
LC084:  .byte $81, $01
;.ENDL
LC086:  .byte $8F, $00
;.ENDT
LC088:  .byte $00, $00

SF2V6:          ;.NKEY 0
LC08A:  .byte $84, $00
;.NVOL FFF ;MF=9
LC08C:  .byte $82, $0F
;.NRATE 0CF
LC08E:  .byte $80, $CF
;.SYN ON
LC090:  .byte $8C, $FF
;.VC 0A0
LC092:  .byte $8A, $A0
;.AENV 0
LC094:  .byte $87, $00
;.ENDT
LC096:  .byte $00, $00

;END OF FILE
;.END
;.TITLE STAR WARS BEN'S THEME
;.CSECT
;.RADIX 16
;FREQUENCY ENVELOPES
;NUL =0 ;NULL
;STR =1 ;STRINGS
;HRN =2 ;HORN
;TRB =3 ;TROMBONE
;BAS =4 ;BASSOON
;GLK =5 ;GLOCKINSPIEL(?)
;WW =6 ;WOODWINDS
;AMPLITUDE ENVELOPES
;NUL =0 ;NULL
;SDR =1 ;STEEL DRUMS
;HRD =2 ;HARD EMPHASIS
;QKR =3 ;QUICK RISING ATTACK
;TIE =4 ;STEEL DRUM TIES
;TUNTAB::
;.WORD SWNUL,BENV1,BENV2,BENV3,BENV4
;MISCELLANEOUS
;METER= 4/4
;SWNUL:
;.NRATE 84.
BENV1:
LC098:  .byte $80, $54
;.AENV 2
LC09A:  .byte $87, $02
;.NOTE D4E.,D4S
LC09C:  .byte $33, $31
LC09E:  .byte $33, $10
;.CALL 5
;.NOTE R1E,R1E,D4E.,D4S ;1ST R1E SHOULD BE G4E TIED BY LAST NOTE
;.CALL 5
;.NOTE R1Q ;SHOULD BE G4 TIED BY LAST NOTE
;.ENDT
;BENV5:
;.NOTE G4H,A4QT,A4C,BF4C,C5D
LC0A0:  .byte $38, $80
LC0A2:  .byte $3A, $40
LC0A4:  .byte $3A, $17
LC0A6:  .byte $3B, $16
LC0A8:  .byte $3D, $14
;.NOTE BF4H,D4Q,R1E,D4E
LC0AA:  .byte $3B, $80
LC0AC:  .byte $33, $40
LC0AE:  .byte $00, $20
LC0B0:  .byte $33, $20
;.NOTE G4Q.,A4E,BF4E,D4E,BF4C,G4C,D5D
LC0B2:  .byte $38, $60
LC0B4:  .byte $3A, $20
LC0B6:  .byte $3B, $20
LC0B8:  .byte $33, $20
LC0BA:  .byte $3B, $16
LC0BC:  .byte $38, $16
LC0BE:  .byte $3F, $14
;.NOTE C5QT
;.CVOL -1
;.NOTE C5QT
;.CVOL -1
;.NOTE C5QT
;.CVOL -1
;.NOTE C5Q
;.NOTE C5H.,D4E.,D4S
LC0C0:  .byte $3D, $C0
LC0C2:  .byte $33, $30
LC0C4:  .byte $33, $10
;.NOTE G4QT,G4E.,A4S,BF4E.,G4S,D5E.,BF4S
LC0C6:  .byte $38, $40
LC0C8:  .byte $38, $31
LC0CA:  .byte $3A, $10
LC0CC:  .byte $3B, $30
LC0CE:  .byte $38, $10
LC0D0:  .byte $3F, $30
LC0D2:  .byte $3B, $10
;.NOTE G5H,G4Q,BF4C,A4C,G4D
LC0D4:  .byte $44, $80
LC0D6:  .byte $38, $40
LC0D8:  .byte $3B, $16
LC0DA:  .byte $3A, $16
LC0DC:  .byte $38, $14
;.NOTE D5QT,D5C,BF4C,G4D,D4Q,D4E.,D4S
LC0DE:  .byte $3F, $40
LC0E0:  .byte $3F, $17
LC0E2:  .byte $3B, $16
LC0E4:  .byte $38, $14
LC0E6:  .byte $33, $40
LC0E8:  .byte $33, $30
LC0EA:  .byte $33, $10
;.NOTE G4H.
LC0EC:  .byte $38, $C0
LC0EE:  .byte $38, $40, $38, $80, $3A, $40, $3A, $17
LC0F6:  .byte $3B, $16, $3D, $14, $3B, $16, $3A, $16
LC0FE:  .byte $38, $14, $3A, $80, $3F, $30, $3F, $10
LC106:  .byte $3F, $40, $38, $60, $40, $20, $3F, $16
LC10E:  .byte $3B, $16, $38, $14, $3D, $C0, $34, $40
LC116:  .byte $3D, $80, $3F, $40, $3F, $17, $40, $16
LC11E:  .byte $42, $14, $40, $16, $3D, $16, $44, $14
LC126:  .byte $3F, $80, $38, $16, $39, $16, $3B, $14
LC12E:  .byte $3D, $16, $3F, $16, $40, $16, $40, $40
LC136:  .byte $40, $17, $36, $16, $38, $14, $39, $16
LC13E:  .byte $3F, $16, $3D, $14, $40, $16, $42, $16
LC146:  .byte $44, $14, $44, $40, $44, $17, $38, $16
LC14E:  .byte $39, $14, $40, $16, $3F, $16, $3D, $14
LC156:  .byte $42, $16, $44, $16, $45, $14, $45, $80
LC15E:  .byte $42, $40, $3F, $80, $3F, $40, $33, $30
LC166:  .byte $33, $10
;.CALL 5
;.NOTE R1E,R1E,D4E.,D4S ;1ST R1E SHOULD BE G4E TIED BY LAST NOTE
;.CALL 5
;.NOTE R1Q ;SHOULD BE G4 TIED BY LAST NOTE
;.ENDT
;BENV5:
;.NOTE G4H,A4QT,A4C,BF4C,C5D
LC168:  .byte $38, $80
LC16A:  .byte $3A, $40
LC16C:  .byte $3A, $17
LC16E:  .byte $3B, $16
LC170:  .byte $3D, $14
;.NOTE BF4H,D4Q,R1E,D4E
LC172:  .byte $3B, $80
LC174:  .byte $33, $40
LC176:  .byte $00, $20
LC178:  .byte $33, $20
;.NOTE G4Q.,A4E,BF4E,D4E,BF4C,G4C,D5D
LC17A:  .byte $38, $60
LC17C:  .byte $3A, $20
LC17E:  .byte $3B, $20
LC180:  .byte $33, $20
LC182:  .byte $3B, $16
LC184:  .byte $38, $16
LC186:  .byte $3F, $14
;.NOTE C5QT
;.CVOL -1
;.NOTE C5QT
;.CVOL -1
;.NOTE C5QT
;.CVOL -1
;.NOTE C5Q
;.NOTE C5H.,D4E.,D4S
LC188:  .byte $3D, $C0
LC18A:  .byte $33, $30
LC18C:  .byte $33, $10
;.NOTE G4QT,G4E.,A4S,BF4E.,G4S,D5E.,BF4S
LC18E:  .byte $38, $40
LC190:  .byte $38, $31
LC192:  .byte $3A, $10
LC194:  .byte $3B, $30
LC196:  .byte $38, $10
LC198:  .byte $3F, $30
LC19A:  .byte $3B, $10
;.NOTE G5H,G4Q,BF4C,A4C,G4D
LC19C:  .byte $44, $80
LC19E:  .byte $38, $40
LC1A0:  .byte $3B, $16
LC1A2:  .byte $3A, $16
LC1A4:  .byte $38, $14
;.NOTE D5QT,D5C,BF4C,G4D,D4Q,D4E.,D4S
LC1A6:  .byte $3F, $40
LC1A8:  .byte $3F, $17
LC1AA:  .byte $3B, $16
LC1AC:  .byte $38, $14
LC1AE:  .byte $33, $40
LC1B0:  .byte $33, $30
LC1B2:  .byte $33, $10
;.NOTE G4H.
LC1B4:  .byte $38, $C0
;.ENDT
LC1B6:  .byte $00, $00

;.NRATE 84.
BENV2:
LC1B8:  .byte $80, $54
LC1BA:  .byte $87, $01
;.NOTE R1Q
LC1BC:  .byte $00, $40
;.CALL 6
;.NOTE G5E,G5E,FS5C,FS5C,FS5D ;MAKE G'S D'S
;.CALL 6
;.NOTE G5Q
;.ENDT
;BENV6:
;.NOTE R1Q,G5E,R1Q,A5E,R1E,BF5E
LC1BE:  .byte $00, $40
LC1C0:  .byte $44, $20
LC1C2:  .byte $00, $40
LC1C4:  .byte $46, $20
LC1C6:  .byte $00, $20
LC1C8:  .byte $47, $20
;.NOTE R1Q,G5E,R1Q,G5E,FS5C,FS5C,FS5D
LC1CA:  .byte $00, $40
LC1CC:  .byte $44, $20
LC1CE:  .byte $00, $40
LC1D0:  .byte $44, $20
LC1D2:  .byte $43, $16
LC1D4:  .byte $43, $16
LC1D6:  .byte $43, $14
;.NOTE R1Q,G5E,R1Q,BF5E,R1E,BF5E
LC1D8:  .byte $00, $40
LC1DA:  .byte $44, $20
LC1DC:  .byte $00, $40
LC1DE:  .byte $47, $20
LC1E0:  .byte $00, $20
LC1E2:  .byte $47, $20
;.NOTE R1Q
LC1E4:  .byte $00, $40
;.CVOL -1
;.NOTE G5C,G5C,G5DT
LC1E6:  .byte $44, $16
LC1E8:  .byte $44, $16
LC1EA:  .byte $44, $14
;.CVOL -1
;.NOTE G5E,G5E
LC1EC:  .byte $44, $21
LC1EE:  .byte $44, $20
;.CVOL -1
;.NOTE A5E,A5E
LC1F0:  .byte $46, $20
LC1F2:  .byte $46, $20
;.NOTE R1Q,G5E,R1Q,G5E,R1E,G5E
LC1F4:  .byte $00, $40
LC1F6:  .byte $44, $20
LC1F8:  .byte $00, $40
LC1FA:  .byte $44, $20
LC1FC:  .byte $00, $20
LC1FE:  .byte $44, $20
;.NOTE R1Q,BF5E,BF5E,BF5E,BF5E,BF5C,BF5C,BF5D
LC200:  .byte $00, $40
LC202:  .byte $47, $20
LC204:  .byte $47, $20
LC206:  .byte $47, $20
LC208:  .byte $47, $20
LC20A:  .byte $47, $16
LC20C:  .byte $47, $16
LC20E:  .byte $47, $14
;.NOTE R1Q,BF5E,R1Q,A5E,R1E,A5E
LC210:  .byte $00, $40
LC212:  .byte $47, $20
LC214:  .byte $00, $40
LC216:  .byte $46, $20
LC218:  .byte $00, $20
LC21A:  .byte $46, $20
;.NOTE R1Q,G5E,G5E,G5Q
LC21C:  .byte $00, $40
LC21E:  .byte $44, $20
LC220:  .byte $44, $20
LC222:  .byte $44, $40
LC224:  .byte $33, $40, $87, $02, $34, $80, $34, $81
LC22C:  .byte $86, $01, $38, $40, $86, $00, $36, $C0
LC234:  .byte $38, $40, $34, $60, $00, $60, $39, $C0
LC23C:  .byte $31, $40, $39, $80, $39, $40, $39, $17
LC244:  .byte $00, $16, $00, $14, $00, $40, $3B, $80
LC24C:  .byte $00, $40, $00, $40, $3D, $40, $3D, $17
LC254:  .byte $00, $16, $00, $14, $00, $40, $3D, $40
LC25C:  .byte $40, $40, $40, $17, $00, $16, $00, $14
LC264:  .byte $00, $40, $3D, $40, $42, $80, $3D, $40
LC26C:  .byte $38, $80, $37, $40, $00, $40, $87, $01
;.CALL 6
;.NOTE G5E,G5E,FS5C,FS5C,FS5D ;MAKE G'S D'S
;.CALL 6
;.NOTE G5Q
;.ENDT
;BENV6:
;.NOTE R1Q,G5E,R1Q,A5E,R1E,BF5E
LC274:  .byte $00, $40
LC276:  .byte $44, $20
LC278:  .byte $00, $40
LC27A:  .byte $46, $20
LC27C:  .byte $00, $20
LC27E:  .byte $47, $20
;.NOTE R1Q,G5E,R1Q,G5E,FS5C,FS5C,FS5D
LC280:  .byte $00, $40
LC282:  .byte $44, $20
LC284:  .byte $00, $40
LC286:  .byte $44, $20
LC288:  .byte $43, $16
LC28A:  .byte $43, $16
LC28C:  .byte $43, $14
;.NOTE R1Q,G5E,R1Q,BF5E,R1E,BF5E
LC28E:  .byte $00, $40
LC290:  .byte $44, $20
LC292:  .byte $00, $40
LC294:  .byte $47, $20
LC296:  .byte $00, $20
LC298:  .byte $47, $20
;.NOTE R1Q
LC29A:  .byte $00, $40
;.CVOL -1
;.NOTE G5C,G5C,G5DT
LC29C:  .byte $44, $16
LC29E:  .byte $44, $16
LC2A0:  .byte $44, $14
;.CVOL -1
;.NOTE G5E,G5E
LC2A2:  .byte $44, $21
LC2A4:  .byte $44, $20
;.CVOL -1
;.NOTE A5E,A5E
LC2A6:  .byte $46, $20
LC2A8:  .byte $46, $20
;.NOTE R1Q,G5E,R1Q,G5E,R1E,G5E
LC2AA:  .byte $00, $40
LC2AC:  .byte $44, $20
LC2AE:  .byte $00, $40
LC2B0:  .byte $44, $20
LC2B2:  .byte $00, $20
LC2B4:  .byte $44, $20
;.NOTE R1Q,BF5E,BF5E,BF5E,BF5E,BF5C,BF5C,BF5D
LC2B6:  .byte $00, $40
LC2B8:  .byte $47, $20
LC2BA:  .byte $47, $20
LC2BC:  .byte $47, $20
LC2BE:  .byte $47, $20
LC2C0:  .byte $47, $16
LC2C2:  .byte $47, $16
LC2C4:  .byte $47, $14
;.NOTE R1Q,BF5E,R1Q,A5E,R1E,A5E
LC2C6:  .byte $00, $40
LC2C8:  .byte $47, $20
LC2CA:  .byte $00, $40
LC2CC:  .byte $46, $20
LC2CE:  .byte $00, $20
LC2D0:  .byte $46, $20
;.NOTE R1Q,G5E,G5E,G5Q
LC2D2:  .byte $00, $40
LC2D4:  .byte $44, $20
LC2D6:  .byte $44, $20
LC2D8:  .byte $44, $40
;.ENDT
LC2DA:  .byte $00, $00

;.NRATE 84.
BENV3:
LC2DC:  .byte $80, $54
LC2DE:  .byte $87, $01
;.NOTE R1Q
LC2E0:  .byte $00, $40
;.CALL 7
;.NOTE A4E,A4E,A4C,A4C,A4D
;.CALL 7
;.NOTE BF4Q
;.ENDT
;BENV7:
;.NOTE R1Q,BF4E,R1Q,D5E,R1E,FS5E
LC2E2:  .byte $00, $40
LC2E4:  .byte $3B, $20
LC2E6:  .byte $00, $40
LC2E8:  .byte $3F, $20
LC2EA:  .byte $00, $20
LC2EC:  .byte $43, $20
;.NOTE R1Q,D5E,R1Q,BF4E,A4C,A4C,A4D
LC2EE:  .byte $00, $40
LC2F0:  .byte $3F, $20
LC2F2:  .byte $00, $40
LC2F4:  .byte $3B, $20
LC2F6:  .byte $3A, $16
LC2F8:  .byte $3A, $16
LC2FA:  .byte $3A, $14
;.NOTE R1Q,BF4E,R1Q,D5E,R1E,D5E
LC2FC:  .byte $00, $40
LC2FE:  .byte $3B, $20
LC300:  .byte $00, $40
LC302:  .byte $3F, $20
LC304:  .byte $00, $20
LC306:  .byte $3F, $20
;.NOTE R1Q
LC308:  .byte $00, $40
;.CVOL -1
;.NOTE E5C,E5C,E5DT
LC30A:  .byte $41, $16
LC30C:  .byte $41, $16
LC30E:  .byte $41, $14
;.CVOL -1
;.NOTE E5E,E5E
LC310:  .byte $41, $21
LC312:  .byte $41, $20
;.CVOL -1
;.NOTE FS5E,FS5E
LC314:  .byte $43, $20
LC316:  .byte $43, $20
;.NOTE R1Q,BF4E,R1Q,D5E,R1E,BF4E ;CHANGE D TO BF PRIME?
LC318:  .byte $00, $40
LC31A:  .byte $3B, $20
LC31C:  .byte $00, $40
LC31E:  .byte $3F, $20
LC320:  .byte $00, $20
LC322:  .byte $3B, $20
;.NOTE R1Q,EF5E,EF5E,EF5E,EF5E,EF5C,EF5C,EF5D
LC324:  .byte $00, $40
LC326:  .byte $40, $20
LC328:  .byte $40, $20
LC32A:  .byte $40, $20
LC32C:  .byte $40, $20
LC32E:  .byte $40, $16
LC330:  .byte $40, $16
LC332:  .byte $40, $14
;.NOTE R1Q,G5E,R1Q,G5E,R1E,FS5E
LC334:  .byte $00, $40
LC336:  .byte $44, $20
LC338:  .byte $00, $40
LC33A:  .byte $44, $20
LC33C:  .byte $00, $20
LC33E:  .byte $43, $20
;.NOTE R1Q,BF4E,BF4E,BF4Q
LC340:  .byte $00, $40
LC342:  .byte $3B, $20
LC344:  .byte $3B, $20
LC346:  .byte $3B, $40
LC348:  .byte $2F, $40, $87, $02, $2F, $80, $2F, $81
LC350:  .byte $33, $40, $33, $C0, $34, $40, $33, $40
LC358:  .byte $31, $40, $2F, $40, $00, $80, $00, $80
LC360:  .byte $34, $80, $36, $40, $36, $17, $00, $16
LC368:  .byte $00, $14, $38, $40, $38, $80, $33, $40
LC370:  .byte $39, $40, $39, $40, $39, $17, $00, $16
LC378:  .byte $00, $14, $00, $40, $39, $40, $39, $40
LC380:  .byte $39, $17, $00, $16, $00, $14, $39, $40
LC388:  .byte $39, $40, $3D, $80, $39, $40, $31, $80
LC390:  .byte $31, $40, $00, $40, $87, $01
;.CALL 7
;.NOTE A4E,A4E,A4C,A4C,A4D
;.CALL 7
;.NOTE BF4Q
;.ENDT
;BENV7:
;.NOTE R1Q,BF4E,R1Q,D5E,R1E,FS5E
LC396:  .byte $00, $40
LC398:  .byte $3B, $20
LC39A:  .byte $00, $40
LC39C:  .byte $3F, $20
LC39E:  .byte $00, $20
LC3A0:  .byte $43, $20
;.NOTE R1Q,D5E,R1Q,BF4E,A4C,A4C,A4D
LC3A2:  .byte $00, $40
LC3A4:  .byte $3F, $20
LC3A6:  .byte $00, $40
LC3A8:  .byte $3B, $20
LC3AA:  .byte $3A, $16
LC3AC:  .byte $3A, $16
LC3AE:  .byte $3A, $14
;.NOTE R1Q,BF4E,R1Q,D5E,R1E,D5E
LC3B0:  .byte $00, $40
LC3B2:  .byte $3B, $20
LC3B4:  .byte $00, $40
LC3B6:  .byte $3F, $20
LC3B8:  .byte $00, $20
LC3BA:  .byte $3F, $20
;.NOTE R1Q
LC3BC:  .byte $00, $40
;.CVOL -1
;.NOTE E5C,E5C,E5DT
LC3BE:  .byte $41, $16
LC3C0:  .byte $41, $16
LC3C2:  .byte $41, $14
;.CVOL -1
;.NOTE E5E,E5E
LC3C4:  .byte $41, $21
LC3C6:  .byte $41, $20
;.CVOL -1
;.NOTE FS5E,FS5E
LC3C8:  .byte $43, $20
LC3CA:  .byte $43, $20
;.NOTE R1Q,BF4E,R1Q,D5E,R1E,BF4E ;CHANGE D TO BF PRIME?
LC3CC:  .byte $00, $40
LC3CE:  .byte $3B, $20
LC3D0:  .byte $00, $40
LC3D2:  .byte $3F, $20
LC3D4:  .byte $00, $20
LC3D6:  .byte $3B, $20
;.NOTE R1Q,EF5E,EF5E,EF5E,EF5E,EF5C,EF5C,EF5D
LC3D8:  .byte $00, $40
LC3DA:  .byte $40, $20
LC3DC:  .byte $40, $20
LC3DE:  .byte $40, $20
LC3E0:  .byte $40, $20
LC3E2:  .byte $40, $16
LC3E4:  .byte $40, $16
LC3E6:  .byte $40, $14
;.NOTE R1Q,G5E,R1Q,G5E,R1E,FS5E
LC3E8:  .byte $00, $40
LC3EA:  .byte $44, $20
LC3EC:  .byte $00, $40
LC3EE:  .byte $44, $20
LC3F0:  .byte $00, $20
LC3F2:  .byte $43, $20
;.NOTE R1Q,BF4E,BF4E,BF4Q
LC3F4:  .byte $00, $40
LC3F6:  .byte $3B, $20
LC3F8:  .byte $3B, $20
LC3FA:  .byte $3B, $40
;.ENDT
LC3FC:  .byte $00, $00

;.NRATE 84.
BENV4:
LC3FE:  .byte $80, $54
;.AENV 3
LC400:  .byte $87, $03
LC402:  .byte $82, $0A, $00, $40, $20, $80, $1E, $80
LC40A:  .byte $1C, $80, $1B, $80, $20, $80, $1E, $80
LC412:  .byte $1D, $80, $19, $40, $1B, $40, $20, $80
LC41A:  .byte $1E, $80, $1C, $80, $1C, $81, $1B, $80
LC422:  .byte $1B, $80, $20, $C0, $1E, $40, $87, $02
LC42A:  .byte $1C, $20, $20, $20, $23, $20, $28, $60
LC432:  .byte $1C, $40, $20, $40, $27, $40, $27, $20
LC43A:  .byte $22, $20, $1E, $20, $1B, $20, $1C, $20
LC442:  .byte $23, $20, $28, $20, $2C, $20, $23, $40
LC44A:  .byte $1C, $40, $21, $20, $28, $20, $2D, $20
LC452:  .byte $31, $20, $34, $40, $20, $40, $1E, $20
LC45A:  .byte $25, $20, $2A, $20, $2D, $20, $31, $40
LC462:  .byte $2A, $40, $25, $40, $2C, $40, $2C, $20
LC46A:  .byte $27, $20, $23, $20, $20, $20, $21, $80
LC472:  .byte $20, $80, $1E, $80, $1C, $80, $1B, $80
LC47A:  .byte $1B, $80, $1B, $80, $1B, $80, $20, $80
LC482:  .byte $1E, $80, $1C, $80, $1B, $80, $20, $80
LC48A:  .byte $1E, $80, $1D, $80, $19, $40, $1B, $40
LC492:  .byte $20, $80, $1E, $80, $1C, $80, $1C, $81
LC49A:  .byte $1B, $80, $1B, $80, $20, $C0
;.ENDT
LC4A0:  .byte $00, $00

;END OF FILE
;.NRATE 60.
TSTV1:
LC4A2:  .byte $80, $3C
LC4A4:  .byte $90                   ;.GOSUB TSUB
LC4A5:  .word TSUB
;.ENDT
LC4A7:  .byte $00, $00

;.NRATE 60.
TSTV2:
LC4A9:  .byte $80, $3C
;.LOOP 2. ;INITIAL REST (NOW = 0) + 2
LC4AB:  .byte $8E, $02
;.NOTE R1Q
LC4AD:  .byte $00, $40
;.ENDL
LC4AF:  .byte $8F, $00
;.CKEY 4
LC4B1:  .byte $85, $04
LC4B3:  .byte $90                   ;.GOSUB TSUB
LC4B4:  .word TSUB
;.ENDT
LC4B6:  .byte $00, $00

;.NRATE 60.
TSTV3:
LC4B8:  .byte $80, $3C
;.LOOP 4. ;INITIAL REST + 4
LC4BA:  .byte $8E, $04
;.NOTE R1Q
LC4BC:  .byte $00, $40
;.ENDL
LC4BE:  .byte $8F, $00
LC4C0:  .byte $90                   ;.GOSUB TSUB2
LC4C1:  .word TSUB2
;.ENDT
LC4C3:  .byte $00, $00

;.NRATE 60.
TSTV4:
LC4C5:  .byte $80, $3C
;.LOOP 6. ;INITIAL REST + 6
LC4C7:  .byte $8E, $06
;.NOTE R1Q
LC4C9:  .byte $00, $40
;.ENDL
LC4CB:  .byte $8F, $00
;.CKEY 4
LC4CD:  .byte $85, $04
LC4CF:  .byte $90                   ;.GOSUB TSUB2
LC4D0:  .word TSUB2
;.ENDT
LC4D2:  .byte $00, $00

TSUB:          ;.AENV 1
LC4D4:  .byte $87, $01
;.LOOP 2
LC4D6:  .byte $8E, $02
;.NOTE C4C,C4C,C4D
LC4D8:  .byte $31, $16
LC4DA:  .byte $31, $16
LC4DC:  .byte $31, $14
;.CKEY 2
LC4DE:  .byte $85, $02
;.ENDL
LC4E0:  .byte $8F, $00
LC4E2:  .byte $91                   ;.RETURN

TSUB2:          ;.AENV 1
LC4E3:  .byte $87, $01
;.LOOP 2
LC4E5:  .byte $8E, $02
;.NOTE C4S,C4S,C4S,C4S
LC4E7:  .byte $31, $10
LC4E9:  .byte $31, $10
LC4EB:  .byte $31, $10
LC4ED:  .byte $31, $10
;.CKEY 2
LC4EF:  .byte $85, $02
;.ENDL
LC4F1:  .byte $8F, $00
LC4F3:  .byte $91                   ;.RETURN

march_v1:
LC4F4:  .byte $82, $09, $80, $3C    ;tune 15: the Imperial March, voice 1, the melody (.NVOL 9, .NRATE 60, .AENV 3), from .NRATE 120 on the march rhythm in triplets. tunes 15-18 are the four voices sound command $2B starts
;.AENV 3
LC4F8:  .byte $87, $03
;.NOTE G4Q,G4Q
LC4FA:  .byte $38, $40
LC4FC:  .byte $38, $40
;.LOOP 2
LC4FE:  .byte $8E, $02
;.NOTE G4Q,EF4E.,BF4S
LC500:  .byte $38, $40
LC502:  .byte $34, $30
LC504:  .byte $3B, $10
;.ENDL
LC506:  .byte $8F, $00
;.NOTE G4H
LC508:  .byte $38, $80
;.NOTE D5Q,D5Q,D5Q,EF5E.,BF4S
LC50A:  .byte $3F, $40
LC50C:  .byte $3F, $40
LC50E:  .byte $3F, $40
LC510:  .byte $40, $30
LC512:  .byte $3B, $10
;.NOTE GF4Q,EF4E.,BF4S,GN4Q.T
LC514:  .byte $37, $40
LC516:  .byte $34, $30
LC518:  .byte $3B, $10
LC51A:  .byte $38, $80, $44, $40, $38, $30, $38, $10
LC522:  .byte $44, $40, $43, $30, $42, $10, $41, $10
LC52A:  .byte $40, $10, $41, $20, $00, $20, $39, $20
LC532:  .byte $3E, $40, $3D, $30, $3C, $10, $3B, $10
LC53A:  .byte $3A, $10, $3B, $20, $00, $20, $34, $20
LC542:  .byte $37, $40, $34, $30
LC546:  .byte $3B, $10
LC548:  .byte $38, $40
LC54A:  .byte $34, $30
LC54C:  .byte $3B, $10
LC54E:  .byte $38, $60
;.CVOL -1
LC550:  .byte $83, $FF
;.NOTE G4ST
LC552:  .byte $38, $11
;.CVOL -1
LC554:  .byte $83, $FF
;.NOTE G4S
LC556:  .byte $38, $11
LC558:  .byte $87, $01, $82, $09, $80, $78, $8E, $03
LC560:  .byte $38, $60, $00, $20, $38, $40, $38, $16
LC568:  .byte $38, $16, $38, $14, $38, $40, $38, $16
LC570:  .byte $38, $16, $38, $14, $37, $16, $37, $16
LC578:  .byte $37, $14, $37, $40, $8F, $00, $3F, $40
LC580:  .byte $3F, $16, $3F, $16, $3F, $14, $40, $16
LC588:  .byte $40, $16, $40, $14, $42, $40, $44, $40
LC590:  .byte $44, $16, $44, $16, $44, $14, $45, $16
LC598:  .byte $45, $16, $45, $14, $47, $40, $00, $40
LC5A0:  .byte $3F, $16, $3F, $16, $3F, $14, $40, $16
LC5A8:  .byte $40, $16, $40, $14, $3D, $40, $00, $40
LC5B0:  .byte $47, $16, $47, $16, $47, $14, $46, $16
LC5B8:  .byte $46, $16, $46, $14, $43, $16, $43, $16
LC5C0:  .byte $43, $14, $00, $40, $4B, $16, $4B, $16
LC5C8:  .byte $4B, $14, $4A, $16, $4A, $16, $4A, $14
LC5D0:  .byte $46, $16, $46, $16, $46, $14, $49, $16
LC5D8:  .byte $49, $16, $49, $14, $47, $16, $47, $16
LC5E0:  .byte $47, $14, $43, $16, $43, $16, $43, $14
LC5E8:  .byte $40, $16, $40, $16, $40, $14, $00, $40
LC5F0:  .byte $3F, $16, $3F, $16, $3F, $14, $40, $16
LC5F8:  .byte $40, $16, $40, $14, $3D, $40, $00, $40
LC600:  .byte $47, $16, $47, $16, $47, $14, $46, $16
LC608:  .byte $46, $16, $46, $14, $43, $16, $43, $16
LC610:  .byte $43, $14, $00, $40, $50, $16, $50, $16
LC618:  .byte $50, $14, $4B, $16, $4B, $16, $4B, $14
LC620:  .byte $47, $16, $47, $16, $47, $14, $45, $16
LC628:  .byte $45, $16, $45, $14, $40, $16, $40, $16
LC630:  .byte $40, $14, $3C, $16, $3C, $16, $3C, $14
LC638:  .byte $39, $16, $39, $16, $39, $14, $00, $40
LC640:  .byte $33, $16, $33, $16, $33, $14, $34, $16
LC648:  .byte $34, $16, $34, $14, $31, $16, $31, $16
LC650:  .byte $31, $14, $00, $40, $3B, $16, $3B, $16
LC658:  .byte $3B, $14, $3A, $16, $3A, $16, $3A, $14
LC660:  .byte $37, $16, $37, $16, $37, $14, $00, $40
LC668:  .byte $3F, $16, $3F, $16, $3F, $14, $3E, $16
LC670:  .byte $3E, $16, $3E, $14, $3A, $16, $3A, $16
LC678:  .byte $3A, $14, $3D, $16, $3D, $16, $3D, $14
LC680:  .byte $3B, $16, $3B, $16, $3B, $14, $37, $16
LC688:  .byte $37, $16, $37, $14, $34, $16, $34, $16
LC690:  .byte $34, $14, $00, $40, $3C, $16, $3C, $16
LC698:  .byte $3C, $14, $3B, $16, $3B, $16, $3B, $14
LC6A0:  .byte $38, $16, $38, $16, $38, $14, $00, $40
LC6A8:  .byte $40, $16, $40, $16, $40, $14, $3F, $16
LC6B0:  .byte $3F, $16, $3F, $14, $3C, $16, $3C, $16
LC6B8:  .byte $3C, $14, $00, $40, $48, $16, $48, $16
LC6C0:  .byte $48, $14, $47, $16, $47, $16, $47, $14
LC6C8:  .byte $3F, $16, $3F, $16, $3F, $14, $45, $16
LC6D0:  .byte $45, $16, $45, $14, $44, $16, $44, $16
LC6D8:  .byte $44, $14, $41, $16, $41, $16, $41, $14
LC6E0:  .byte $39, $16, $39, $16, $39, $14, $3A, $80
LC6E8:  .byte $3A, $81, $00, $00

march_v2:
LC6EC:  .byte $82, $09, $80, $3C    ;tune 16: the Imperial March, voice 2, the second part under the melody
;.AENV 3
LC6F0:  .byte $87, $03
;.NOTE D4Q,D4Q
LC6F2:  .byte $33, $40
LC6F4:  .byte $33, $40
;.LOOP 2
LC6F6:  .byte $8E, $02
;.NOTE D4Q,BF3E.,EF4S
LC6F8:  .byte $33, $40
LC6FA:  .byte $2F, $30
LC6FC:  .byte $34, $10
;.ENDL
LC6FE:  .byte $8F, $00
;.NOTE D4H
LC700:  .byte $33, $80
;.NOTE D4Q,D4Q,D4Q,EF4E.,BF3S
LC702:  .byte $33, $40
LC704:  .byte $33, $40
LC706:  .byte $33, $40
LC708:  .byte $34, $30
LC70A:  .byte $2F, $10
;.NOTE EF4Q,BF3E.,EF4S,D4Q.T
LC70C:  .byte $34, $40
LC70E:  .byte $2F, $30
LC710:  .byte $34, $10
LC712:  .byte $33, $80, $40, $40, $34, $30, $34, $10
LC71A:  .byte $3F, $40, $3F, $30, $3F, $10, $3E, $20
LC722:  .byte $3E, $20, $00, $40, $39, $40, $39, $30
LC72A:  .byte $39, $10, $37, $20, $37, $20, $00, $40
LC732:  .byte $34, $40, $2F, $30, $37, $10, $2F, $40
LC73A:  .byte $2F, $30, $37, $10, $33, $60, $83, $FF
LC742:  .byte $33, $11, $83, $FF, $33, $11, $87, $01
LC74A:  .byte $82, $09, $86, $01, $80, $78, $8E, $03
LC752:  .byte $38, $60, $00, $20, $38, $40, $38, $16
LC75A:  .byte $38, $16, $38, $14, $38, $40, $38, $16
LC762:  .byte $38, $16, $38, $14, $34, $16, $34, $16
LC76A:  .byte $34, $14, $34, $40, $8F, $00, $3B, $40
LC772:  .byte $3B, $16, $3B, $16, $3B, $14, $3C, $16
LC77A:  .byte $3C, $16, $3C, $14, $3E, $40, $40, $40
LC782:  .byte $40, $16, $40, $16, $40, $14, $41, $16
LC78A:  .byte $41, $16, $41, $14, $43, $40, $00, $40
LC792:  .byte $3B, $16, $3B, $16, $3B, $14, $37, $16
LC79A:  .byte $37, $16, $37, $14, $3A, $40, $00, $40
LC7A2:  .byte $3F, $16, $3F, $16, $3F, $14, $3B, $16
LC7AA:  .byte $3B, $16, $3B, $14, $3E, $16, $3E, $16
LC7B2:  .byte $3E, $14, $00, $40, $43, $16, $43, $16
LC7BA:  .byte $43, $14, $44, $16, $44, $16, $44, $14
LC7C2:  .byte $3E, $16
LC7C4:  .byte $3E, $16
LC7C6:  .byte $3E, $14
LC7C8:  .byte $40, $16
LC7CA:  .byte $40, $16
LC7CC:  .byte $40, $14
LC7CE:  .byte $3F, $16, $3F, $16, $3F, $14, $3B, $16
LC7D6:  .byte $3B, $16, $3B, $14, $37, $16, $37, $16
LC7DE:  .byte $37, $14, $00, $40, $3B, $16, $3B, $16
LC7E6:  .byte $3B, $14, $37, $16, $37, $16, $37, $14
LC7EE:  .byte $3A, $40, $00, $40, $3F, $16, $3F, $16
LC7F6:  .byte $3F, $14, $3B, $16, $3B, $16, $3B, $14
LC7FE:  .byte $3E, $16, $3E, $16, $3E, $14, $00, $40
LC806:  .byte $47, $16, $47, $16, $47, $14, $44, $16
LC80E:  .byte $44, $16, $44, $14, $3F, $16, $3F, $16
LC816:  .byte $3F, $14, $3D, $16, $3D, $16, $3D, $14
LC81E:  .byte $39, $16, $39, $16, $39, $14, $34, $16
LC826:  .byte $34, $16, $34, $14, $36, $16, $36, $16
LC82E:  .byte $36, $14, $00, $40, $2F, $16, $2F, $16
LC836:  .byte $2F, $14, $31, $16, $31, $16, $31, $14
LC83E:  .byte $2E, $16, $2E, $16, $2E, $14, $00, $40
LC846:  .byte $33, $16, $33, $16, $33, $14, $2F, $16
LC84E:  .byte $2F, $16, $2F, $14, $32, $16, $32, $16
LC856:  .byte $32, $14, $00, $40, $37, $16, $37, $16
LC85E:  .byte $37, $14, $38, $16, $38, $16, $38, $14
LC866:  .byte $32, $16, $32, $16, $32, $14, $34, $16
LC86E:  .byte $34, $16, $34, $14, $33, $16, $33, $16
LC876:  .byte $33, $14, $2F, $16, $2F, $16, $2F, $14
LC87E:  .byte $2C, $16, $2C, $16, $2C, $14, $00, $40
LC886:  .byte $2D, $16, $2D, $16, $2D, $14, $30, $16
LC88E:  .byte $30, $16, $30, $14, $33, $16, $33, $16
LC896:  .byte $33, $14, $00, $40, $30, $16, $30, $16
LC89E:  .byte $30, $14, $34, $16, $34, $16, $34, $14
LC8A6:  .byte $39, $16, $39, $16, $39, $14, $00, $40
LC8AE:  .byte $34, $16, $34, $16, $34, $14, $38, $16
LC8B6:  .byte $38, $16, $38, $14, $3C, $16, $3C, $16
LC8BE:  .byte $3C, $14, $31, $16, $31, $16, $31, $14
LC8C6:  .byte $39, $16, $39, $16, $39, $14, $2D, $16
LC8CE:  .byte $2D, $16, $2D, $14, $36, $16, $36, $16
LC8D6:  .byte $36, $14, $35, $80, $35, $81, $00, $00

march_v3:
LC8DE:  .byte $82, $09, $80, $78, $87, $01, $00, $80 ;tune 17: the Imperial March, voice 3: the rhythm figure on G3 switching between .NRATE 120 and 60, then a melody part
LC8E6:  .byte $2C, $16, $2C, $16, $2C, $14, $80, $3C
LC8EE:  .byte $2C, $20, $8E, $02, $00, $20, $2C, $20
LC8F6:  .byte $00, $20, $2B, $20, $8F, $00, $00, $20
LC8FE:  .byte $80, $78, $2C, $16, $2C, $16, $2C, $14
LC906:  .byte $80, $3C, $2C, $20, $2C, $20, $00, $20
LC90E:  .byte $2C, $20, $00, $20, $80, $78, $2C, $16
LC916:  .byte $2C, $16, $2C, $14, $80, $3C, $00, $20
LC91E:  .byte $2C, $20, $00, $20, $2B, $20, $00, $20
LC926:  .byte $2B, $20, $00, $20, $28, $20, $00, $20
LC92E:  .byte $80, $78, $2C, $16, $2C, $16, $2C, $14
LC936:  .byte $2C, $40, $2C, $40, $87, $02, $86, $01
LC93E:  .byte $82, $07, $3B, $80, $44, $16, $38, $16
LC946:  .byte $37, $14, $38, $40, $3B, $80, $3B, $60
LC94E:  .byte $3B, $20, $39, $40, $39, $40, $45, $16
LC956:  .byte $39, $16, $38, $14, $39, $40, $35, $80
LC95E:  .byte $35, $60, $35, $20, $35, $40, $35, $40
LC966:  .byte $47, $16, $3B, $16, $3A, $14, $3B, $40
LC96E:  .byte $2F, $80, $2B, $60, $34, $20, $44, $16
LC976:  .byte $38, $16, $37, $14, $38, $40, $2B, $60
LC97E:  .byte $34, $20, $2F, $C0, $83, $FF, $2F, $21
LC986:  .byte $83, $FF, $2F, $21, $87, $01, $82, $09
LC98E:  .byte $80, $78, $8E, $03, $2C, $60, $00, $20
LC996:  .byte $2C, $40, $2C, $16, $2C, $16, $2C, $14
LC99E:  .byte $2C, $40, $2C, $16, $2C, $16, $2C, $14
LC9A6:  .byte $3B, $16, $3B, $16, $3B, $14, $3B, $40
LC9AE:  .byte $8F, $00, $38, $40, $38, $16, $38, $16
LC9B6:  .byte $38, $14, $39, $16, $39, $16, $39, $14
LC9BE:  .byte $3B, $40, $3D, $40, $3D, $16, $3D, $16
LC9C6:  .byte $3D, $14, $3E, $16, $3E, $16, $3E, $14
LC9CE:  .byte $40, $40, $86, $01, $83, $01, $8E, $02
LC9D6:  .byte $33, $80, $33, $81, $33, $80, $33, $81
LC9DE:  .byte $33, $80, $33, $81, $33, $80, $33, $80
LC9E6:  .byte $8F, $00, $20, $80, $20, $81, $20, $80
LC9EE:  .byte $20, $81, $20, $80, $20, $81, $20, $80
LC9F6:  .byte $20, $80, $21, $80, $21, $81, $21, $80
LC9FE:  .byte $21, $81, $21, $80, $21, $81, $22, $80
LCA06:  .byte $1D, $80, $31, $80, $31, $81, $00, $00

march_v4:
LCA0E:  .byte $85, $F4, $82, $0A, $80, $78, $87, $01 ;tune 18: the Imperial March, voice 4, the bass (.CKEY -12 at first)
LCA16:  .byte $00, $80, $20, $16, $20, $16, $20, $14
LCA1E:  .byte $80, $3C, $20, $20, $8E, $02, $00, $20
LCA26:  .byte $20, $20, $00, $20, $28, $20, $8F, $00
LCA2E:  .byte $00, $20, $80, $78, $20, $16, $20, $16
LCA36:  .byte $20, $14, $80, $3C, $20, $20, $20, $20
LCA3E:  .byte $00, $20, $20, $20, $00, $20, $80, $78
LCA46:  .byte $20, $16, $20, $16, $20, $14, $80, $3C
LCA4E:  .byte $00, $20, $20, $20, $00, $20, $28, $20
LCA56:  .byte $00, $20, $28, $20, $00, $20, $25, $20
LCA5E:  .byte $00, $20, $80, $78, $20, $16, $20, $16
LCA66:  .byte $20, $14, $20, $40, $20, $40, $84, $00
LCA6E:  .byte $80, $3C, $28, $20, $00, $20, $28, $20
LCA76:  .byte $00, $20, $20, $20, $00, $20, $20, $20
LCA7E:  .byte $00, $20, $26, $20, $00, $20, $26, $20
LCA86:  .byte $00, $20, $26, $20, $00, $20, $1A, $20
LCA8E:  .byte $00, $20, $1C, $20, $00, $20, $1C, $20
LCA96:  .byte $00, $20, $28, $20, $00, $20, $23, $20
LCA9E:  .byte $00, $20, $20, $40, $1C, $40, $20, $80
LCAA6:  .byte $87, $01, $82, $09, $80, $78, $8E, $03
LCAAE:  .byte $20, $60, $00, $20, $20, $40, $20, $16
LCAB6:  .byte $20, $16, $20, $14, $20, $40, $20, $16
LCABE:  .byte $20, $16, $20, $14, $1C, $16, $1C, $16
LCAC6:  .byte $1C, $14, $1C, $40, $8F, $00, $8E, $02
LCACE:  .byte $20, $40, $20, $16, $20, $16, $20, $14
LCAD6:  .byte $20, $16, $20, $16, $20, $14, $20, $40
LCADE:  .byte $8F, $00, $83, $01, $8E, $02, $33, $80
LCAE6:  .byte $33, $81, $33, $80, $33, $81, $33, $80
LCAEE:  .byte $33, $81, $33, $80, $33, $80, $8F, $00
LCAF6:  .byte $20, $80, $20, $81, $20, $80, $20, $81
LCAFE:  .byte $20, $80, $20, $81, $20, $80, $20, $80
LCB06:  .byte $21, $80, $21, $81, $21, $80, $21, $81
LCB0E:  .byte $21, $80, $21, $81, $22, $80, $1D, $80
LCB16:  .byte $16, $80, $16, $81, $00, $00

tune_empty:
LCB1C:  .byte $00, $00              ;tunes 19-22: an empty tune, only the end mark. the four voices of PMREB, which no command starts

tune2c_v1:
LCB1E:  .byte $80, $69, $85, $03, $87, $03, $82, $07 ;tune 23: voice 1, the melody, of the music of sound command $2C (.NRATE 105, .CKEY 3, .AENV 3). tunes 23-26 are its four voices
LCB26:  .byte $00, $80, $3E, $60, $00, $10, $87, $01
LCB2E:  .byte $40, $10, $40, $C0, $87, $03, $3E, $40
LCB36:  .byte $3A, $20, $3B, $20, $3E, $10, $00, $20
LCB3E:  .byte $42, $10, $46, $80, $46, $81, $42, $80
LCB46:  .byte $3A, $80, $3A, $81, $45, $40, $45, $11
LCB4E:  .byte $00, $20, $87, $01, $47, $10, $47, $80
LCB56:  .byte $47, $81, $87, $03, $45, $80, $45, $C1
LCB5E:  .byte $82, $0A, $8C, $FF, $87, $01, $3D, $16
LCB66:  .byte $3D, $16, $3D, $14, $3D, $16, $87, $00
LCB6E:  .byte $3E, $16, $40, $14, $42, $16, $44, $16
LCB76:  .byte $45, $14, $47, $16, $45, $16, $44, $14
LCB7E:  .byte $42, $16, $40, $16, $3E, $14, $3D, $40
LCB86:  .byte $3D, $11, $8C, $00, $87, $01, $82, $07
LCB8E:  .byte $00, $20, $47, $10, $47, $80, $47, $81
LCB96:  .byte $87, $03, $3D, $80, $3D, $81, $82, $0F
LCB9E:  .byte $86, $02, $1D, $81, $1D, $81, $1D, $81
LCBA6:  .byte $1D, $81, $86, $00, $82, $07, $84, $F4
LCBAE:  .byte $80, $48, $87, $02, $44, $40, $44, $40
LCBB6:  .byte $8E, $03, $44, $40, $40, $30, $47, $10
LCBBE:  .byte $8F, $00, $87, $01, $82, $07, $84, $00
LCBC6:  .byte $80, $90, $38, $40, $00, $40, $8E, $02
LCBCE:  .byte $38, $40, $38, $16, $38, $16, $38, $14
LCBD6:  .byte $8F, $00, $38, $20, $38, $20, $38, $40
LCBDE:  .byte $38, $40, $00, $40, $8E, $02, $38, $40
LCBE6:  .byte $38, $16, $38, $16, $38, $14, $8F, $00
LCBEE:  .byte $38, $16, $38, $16, $38, $14, $38, $40
LCBF6:  .byte $38, $16, $38, $16, $38, $14, $31, $40
LCBFE:  .byte $31, $C1, $31, $C1, $31, $81, $31, $81
LCC06:  .byte $31, $81, $31, $81, $44, $41, $00, $40
LCC0E:  .byte $44, $40, $44, $16, $44, $16, $44, $14
LCC16:  .byte $40, $16, $40, $16, $40, $14, $44, $40
LCC1E:  .byte $00, $40, $40, $16, $40, $16, $40, $14
LCC26:  .byte $40, $16, $40, $16, $40, $14, $44, $40
LCC2E:  .byte $00, $40, $40, $16, $40, $16, $40, $14
LCC36:  .byte $44, $40, $38, $16, $38, $16, $38, $14
LCC3E:  .byte $38, $40, $00, $00

tune2c_v2:
LCC42:  .byte $80, $69, $85, $03, $87, $03, $82, $0A ;tune 24: voice 2 of the music of sound command $2C, a part under the melody
LCC4A:  .byte $86, $01, $23, $20, $00, $60, $82, $07
LCC52:  .byte $86, $00, $3B, $60, $00, $10, $87, $01
LCC5A:  .byte $3D, $10, $3D, $C0, $87, $03, $3B, $40
LCC62:  .byte $35, $20, $36, $20, $3B, $10, $00, $20
LCC6A:  .byte $3E, $10, $42, $80, $42, $81, $3E, $80
LCC72:  .byte $36, $80, $36, $81, $42, $40, $42, $11
LCC7A:  .byte $00, $20, $87, $01, $44, $10, $44, $80
LCC82:  .byte $44, $81, $87, $03, $42, $80, $42, $C1
LCC8A:  .byte $82, $0A, $8C, $FF, $87, $01, $39, $16
LCC92:  .byte $39, $16, $39, $14, $39, $16, $87, $00
LCC9A:  .byte $3B, $16, $3D, $14, $3E, $16, $40, $16
LCCA2:  .byte $42, $14, $44, $16, $42, $16, $40, $14
LCCAA:  .byte $3E, $16, $3D, $16, $3B, $14, $39, $40
LCCB2:  .byte $39, $11, $8C, $00, $87, $01, $82, $07
LCCBA:  .byte $00, $20, $44, $10, $44, $80, $44, $81
LCCC2:  .byte $87, $03, $39, $80, $39, $81, $82, $0F
LCCCA:  .byte $86, $01, $1D, $81, $1D, $81, $1D, $81
LCCD2:  .byte $1D, $81, $86, $00, $82, $07, $84, $F4
LCCDA:  .byte $80, $48, $87, $02, $3F, $40, $3F, $40
LCCE2:  .byte $3F, $40, $3B, $30, $40, $10, $40, $40
LCCEA:  .byte $3B, $30, $40, $10, $40, $40, $3B, $30
LCCF2:  .byte $40, $10, $87, $01, $80, $90, $82, $03
LCCFA:  .byte $84, $00, $33, $40, $00, $C0, $21, $40
LCD02:  .byte $21, $16, $21, $16, $21, $14, $25, $20
LCD0A:  .byte $26, $20, $27, $40, $28, $40, $00, $40
LCD12:  .byte $29, $40, $29, $16, $29, $16, $29, $14
LCD1A:  .byte $2A, $40, $2A, $16, $2A, $16, $2A, $14
LCD22:  .byte $2B, $16, $2B, $16, $2B, $14, $2B, $40
LCD2A:  .byte $82, $07, $86, $01, $87, $02, $8C, $FF
LCD32:  .byte $2C, $40, $33, $16, $31, $16, $33, $14
LCD3A:  .byte $34, $16, $33, $16, $34, $14, $36, $16
LCD42:  .byte $34, $16, $36, $14, $38, $16, $36, $16
LCD4A:  .byte $38, $14, $39, $16, $38, $16, $39, $14
LCD52:  .byte $3B, $16, $39, $16, $3B, $14, $3D, $16
LCD5A:  .byte $3B, $16, $3D, $14, $3F, $16, $36, $16
LCD62:  .byte $38, $14, $39, $16, $3B, $16, $8E, $02
LCD6A:  .byte $3D, $14, $3F, $16, $40, $16, $42, $14
LCD72:  .byte $44, $16, $45, $16, $47, $14, $49, $16
LCD7A:  .byte $8F, $00, $4B, $16, $4C, $16, $4E, $14
LCD82:  .byte $87, $01, $8C, $00, $50, $40, $00, $40
LCD8A:  .byte $38, $40, $38, $16, $38, $16, $38, $14
LCD92:  .byte $3B, $16, $3B, $16, $3B, $14, $38, $40
LCD9A:  .byte $00, $40, $3A, $16, $3A, $16, $3A, $14
LCDA2:  .byte $3A, $16, $3A, $16, $3A, $14, $38, $40
LCDAA:  .byte $00, $40, $3A, $16, $3A, $16, $3A, $14
LCDB2:  .byte $38, $40, $2C, $16, $2C, $16, $2C, $14
LCDBA:  .byte $2C, $40, $00, $00

tune2c_v3:
LCDBE:  .byte $80, $69, $85, $03, $87, $03, $17, $80 ;tune 25: voice 3 of the music of sound command $2C
LCDC6:  .byte $36, $60, $00, $10, $87, $01, $38, $10
LCDCE:  .byte $38, $C0, $87, $03, $36, $40, $31, $20
LCDD6:  .byte $32, $20, $36, $10, $00, $20, $3B, $10
LCDDE:  .byte $3E, $80, $3E, $81, $3B, $80, $32, $80
LCDE6:  .byte $32, $81, $3D, $40, $3D, $11, $00, $20
LCDEE:  .byte $87, $01, $3F, $10, $3F, $80, $3F, $81
LCDF6:  .byte $87, $03, $3D, $80, $3D, $C1, $87, $01
LCDFE:  .byte $82, $0A, $8C, $FF, $36, $16, $36, $16
LCE06:  .byte $36, $14, $36, $16, $87, $00, $38, $16
LCE0E:  .byte $39, $14, $3B, $16, $3D, $16, $3E, $14
LCE16:  .byte $40, $16, $3E, $16, $3D, $14, $3B, $16
LCE1E:  .byte $39, $16, $38, $14, $36, $40, $36, $11
LCE26:  .byte $8C, $00, $87, $01, $82, $07, $00, $20
LCE2E:  .byte $40, $10, $40, $80, $40, $81, $87, $03
LCE36:  .byte $36, $80, $36, $81, $86, $01, $82, $0F
LCE3E:  .byte $11, $81, $11, $81, $11, $81, $11, $81
LCE46:  .byte $86, $00, $82, $0A, $84, $F4, $80, $48
LCE4E:  .byte $87, $02, $38, $40, $37, $40, $34, $40
LCE56:  .byte $33, $40, $32, $40, $31, $40, $30, $40
LCE5E:  .byte $2F, $40, $87, $01, $80, $90, $82, $0A
LCE66:  .byte $84, $00, $20, $40, $00, $40, $20, $40
LCE6E:  .byte $20, $16, $20, $16, $20, $14, $20, $40
LCE76:  .byte $20, $16, $20, $16, $20, $14, $21, $20
LCE7E:  .byte $21, $20, $21, $40, $21, $40, $00, $40
LCE86:  .byte $22, $40, $22, $16, $22, $16, $22, $14
LCE8E:  .byte $23, $40, $23, $16, $23, $16, $23, $14
LCE96:  .byte $24, $16, $24, $16, $24, $14, $24, $40
LCE9E:  .byte $25, $16, $25, $16, $25, $14, $27, $40
LCEA6:  .byte $27, $C1, $27, $C1, $27, $81, $27, $81
LCEAE:  .byte $27, $81, $27, $81, $20, $41, $00, $40
LCEB6:  .byte $2C, $40, $2C, $16, $2C, $16, $2C, $14
LCEBE:  .byte $2B, $16, $2B, $16, $2B, $14, $20, $40
LCEC6:  .byte $00, $40, $2B, $16, $2B, $16, $2B, $14
LCECE:  .byte $2B, $16, $2B, $16, $2B, $14, $20, $40
LCED6:  .byte $00, $40, $2B, $16, $2B, $16, $2B, $14
LCEDE:  .byte $28, $40, $1B, $16, $1B, $16, $1B, $14
LCEE6:  .byte $20, $40, $00, $00

tune2c_v4:
LCEEA:  .byte $80, $69, $85, $03, $87, $03, $82, $0A ;tune 26: voice 4 of the music of sound command $2C: a bass figure in eighth notes with the volume switched between 10, 7 and 9
LCEF2:  .byte $23, $20, $82, $07, $23, $20, $23, $20
LCEFA:  .byte $82, $09, $25, $20, $8E, $02, $23, $20
LCF02:  .byte $82, $07, $23, $20, $23, $20, $82, $09
LCF0A:  .byte $26, $20, $8F, $00, $23, $20, $82, $07
LCF12:  .byte $23, $20, $23, $20, $82, $09, $25, $20
LCF1A:  .byte $8E, $02, $23, $20, $82, $07, $23, $20
LCF22:  .byte $23, $20, $82, $09, $26, $20, $8F, $00
LCF2A:  .byte $8E, $02, $23, $20, $82, $07, $23, $20
LCF32:  .byte $23, $20, $82, $09, $25, $20, $23, $20
LCF3A:  .byte $82, $07, $23, $20, $23, $20, $82, $09
LCF42:  .byte $26, $20, $8F, $00, $1E, $20, $82, $07
LCF4A:  .byte $1E, $20, $1E, $20, $82, $09, $20, $20
LCF52:  .byte $1E, $20, $82, $07, $1E, $20, $1E, $20
LCF5A:  .byte $82, $09, $21, $20, $1E, $20, $82, $07
LCF62:  .byte $1E, $20, $1E, $20, $82, $09, $20, $20
LCF6A:  .byte $1E, $20, $82, $07, $1E, $20, $1E, $20
LCF72:  .byte $82, $09, $26, $20, $1E, $20, $82, $07
LCF7A:  .byte $1E, $20, $1E, $20, $82, $09, $20, $20
LCF82:  .byte $1E, $20, $82, $07, $1E, $20, $1E, $20
LCF8A:  .byte $82, $09, $25, $20, $8E, $02, $1E, $20
LCF92:  .byte $82, $07, $1E, $20, $1E, $20, $82, $09
LCF9A:  .byte $20, $20, $1E, $20, $82, $07, $1E, $20
LCFA2:  .byte $1E, $20, $82, $09, $28, $20
LCFA8:  .byte $8F, $00, $1E, $20, $82, $07, $1E, $20
LCFB0:  .byte $1E, $20, $82, $09, $20, $20, $1E, $20
LCFB8:  .byte $82, $07, $1E, $20, $1E, $20, $82, $09
LCFC0:  .byte $23, $20, $1E, $20, $82, $07, $1E, $20
LCFC8:  .byte $1E, $20, $82, $09, $20, $20, $82, $0F
LCFD0:  .byte $86, $02, $11, $80, $11, $81, $11, $81
LCFD8:  .byte $11, $81, $86, $00, $82, $0A, $84, $F4
LCFE0:  .byte $80, $48, $87, $02, $20, $40, $20, $40
LCFE8:  .byte $8E, $03, $20, $40, $1C, $30, $23, $10
LCFF0:  .byte $8F, $00, $87, $01, $80, $90, $82, $0A
LCFF8:  .byte $84, $00, $14, $40, $00, $40, $14, $40
LD000:  .byte $14, $40, $14, $40, $00, $40, $14, $40
LD008:  .byte $00, $40, $14, $40, $00, $40, $14, $40
LD010:  .byte $14, $40, $14, $40, $00, $40, $14, $40
LD018:  .byte $14, $40, $14, $40, $19, $40, $19, $C1
LD020:  .byte $19, $C1, $19, $81, $19, $81, $19, $81
LD028:  .byte $19, $81, $14, $41, $00, $40, $20, $40
LD030:  .byte $20, $40, $1F, $40, $14, $40, $00, $40
LD038:  .byte $1F, $40, $86, $01, $1F, $40, $14, $40
LD040:  .byte $00, $40, $1F, $40, $1C, $40, $1B, $40
LD048:  .byte $14, $40, $00, $00

theme_v1:
LD04C:  .byte $80, $48, $87, $02, $82, $03, $47, $40 ;tune 27: the Star Wars main theme, voice 1: a fanfare at .NRATE 72, then the theme at .NRATE 144 as two calls of the subphrase below. tunes 27-30 are the four voices sound command $2E starts
LD054:  .byte $3B, $60, $3B, $20, $3B, $16, $3B, $16
LD05C:  .byte $3B, $14, $3B, $60, $42, $20, $47, $40
LD064:  .byte $45, $16
LD066:  .byte $45, $16
LD068:  .byte $45, $14
LD06A:  .byte $47, $16
LD06C:  .byte $47, $16
LD06E:  .byte $47, $14
LD070:  .byte $42, $16, $42, $16, $42, $14, $42, $40
LD078:  .byte $82, $07, $80, $36, $36, $16, $36, $16
LD080:  .byte $36, $14, $80, $90, $90, $D0, $92, $36
LD088:  .byte $16, $36, $16, $36, $14, $90, $D0, $92
LD090:  .byte $00, $00

theme_v1_sub:
LD092:  .byte $3B, $80, $3B, $81, $42, $80, $42, $81 ;subphrase of tune 27 (.GOSUB): the main theme's melody, ends with .RETURN
LD09A:  .byte $8E, $02, $40, $2A, $3F, $2A, $3D, $2C
LD0A2:  .byte $47, $80, $47, $81, $42, $80, $8F, $00
LD0AA:  .byte $40, $2A, $3F, $2A, $40, $2C, $3D, $80
LD0B2:  .byte $3D, $C1, $91

theme_v2:
LD0B5:  .byte $80, $48, $87, $02, $82, $03, $42, $40 ;tune 28: the Star Wars main theme, voice 2
LD0BD:  .byte $00, $C0, $00, $60, $3B, $20, $42, $40
LD0C5:  .byte $8E, $03, $40, $16, $40, $16, $40, $14
LD0CD:  .byte $8F, $00, $40, $40, $80, $36, $82, $07
LD0D5:  .byte $31, $16, $31, $16, $31, $14, $80, $90
LD0DD:  .byte $90, $D0, $EB, $31, $16, $31, $16, $31
LD0E5:  .byte $14, $90, $D0, $EB, $00, $00

theme_v2_sub:
LD0EB:  .byte $36, $80, $36, $81, $3B, $80, $3B, $81 ;subphrase of tune 28: the second part under the theme's melody
LD0F3:  .byte $8E, $02, $39, $80, $40, $80, $40, $81
LD0FB:  .byte $3B, $80, $8F, $00, $3D, $2A, $3C, $2A
LD103:  .byte $3D, $2C, $3A, $80, $3A, $C1, $91

theme_v3:
LD10A:  .byte $80, $48, $87, $03, $86, $01, $23, $80 ;tune 29: the Star Wars main theme, voice 3
LD112:  .byte $23, $81, $23, $21, $3B, $10, $3B, $10
LD11A:  .byte $90, $D1, $B4, $90, $D1, $B4, $3B, $16
LD122:  .byte $36, $16, $40, $14, $80, $90, $42, $16
LD12A:  .byte $42, $17, $3B, $14, $3B, $16, $3B, $16
LD132:  .byte $3B, $15, $80, $36, $2A, $16, $2A, $16
LD13A:  .byte $2A, $14, $80, $90, $00, $16, $00, $16
LD142:  .byte $00, $14, $00, $16, $2F, $16, $2F, $14
LD14A:  .byte $2F, $80, $2F, $21, $00, $20, $2F, $16
LD152:  .byte $2F, $16, $2F, $14, $2F, $40, $2D, $40
LD15A:  .byte $8E, $02, $00, $40, $2F, $40, $00, $40
LD162:  .byte $2D, $40, $2D, $16, $2D, $17, $2D, $14
LD16A:  .byte $2D, $16, $2D, $16, $2D, $15, $2F, $2A
LD172:  .byte $2F, $2A, $2F, $2C, $8F, $00, $39, $2A
LD17A:  .byte $38, $2A, $39, $2C, $36, $80, $36, $C1
LD182:  .byte $2A, $16, $2A, $16, $2A, $14, $33, $80
LD18A:  .byte $33, $81, $3F, $80, $3F, $81, $8E, $02
LD192:  .byte $3B, $80, $42, $80, $42, $81, $3F, $80
LD19A:  .byte $8F, $00, $39, $2A, $38, $2A, $39, $2C
LD1A2:  .byte $36, $80, $38, $16, $3A, $16, $3B, $14
LD1AA:  .byte $3D, $16, $3F, $16, $40, $14, $42, $40
LD1B2:  .byte $00, $00

theme_run:
LD1B4:  .byte $3B, $16, $36, $16, $40, $14, $42, $16 ;subphrase of tunes 29 and 30: a figure of six triplet notes
LD1BC:  .byte $40, $16, $3B, $14, $91

theme_v4:
LD1C1:  .byte $80, $48, $87, $03, $2F, $60, $2F, $10 ;tune 30: the Star Wars main theme, voice 4, the bass
LD1C9:  .byte $2F, $10, $2F, $60, $2F, $10, $2F, $10
LD1D1:  .byte $84, $F4, $90, $D1, $B4, $84, $00, $2F
LD1D9:  .byte $16, $2A, $16, $34, $14, $36, $16, $2F
LD1E1:  .byte $16, $2F, $14, $34, $16, $2F, $16, $36
LD1E9:  .byte $14, $39, $60, $00, $20, $80, $36, $1E
LD1F1:  .byte $16, $1E, $16, $1E, $14, $80, $90, $00
LD1F9:  .byte $16, $00, $16, $00, $14, $00, $16, $27
LD201:  .byte $16, $27, $14, $27, $80, $27, $21, $00
LD209:  .byte $20, $27, $16, $27, $16, $27, $14, $27
LD211:  .byte $40, $28, $40, $8E, $02, $00, $40, $28
LD219:  .byte $40, $00, $40, $28, $40, $28, $16, $28
LD221:  .byte $17, $28, $14, $28, $16, $28, $16, $28
LD229:  .byte $15, $27, $2A, $27, $2A, $27, $2C, $8F
LD231:  .byte $00, $2D, $2A, $2C, $2A, $2D, $2C, $2A
LD239:  .byte $80, $1E, $C0, $1E, $16, $1E, $16, $1E
LD241:  .byte $14, $23, $80, $22, $80, $22, $60, $22
LD249:  .byte $20, $23, $2A, $23, $2A, $22, $2C, $20
LD251:  .byte $80, $20, $2A, $20, $2B, $28, $2C, $28
LD259:  .byte $2A, $27, $2A, $25, $2C, $23, $2A, $22
LD261:  .byte $2A, $20, $2C, $1E, $80, $20, $40, $22
LD269:  .byte $40, $23, $2A, $22, $2A, $20, $2C, $1E
LD271:  .byte $40, $23, $40, $2A, $80, $1E, $2A, $1E
LD279:  .byte $2A, $1E, $2C, $1E, $C0, $00, $00

tune29_v1:
LD280:  .byte $86, $01, $90, $D3, $CD, $41, $20, $3D ;tune 35: voice 1 of the music of sound command $29 (frequency envelope 1). tunes 35-38 are its four voices
LD288:  .byte $20, $45, $20, $3D, $20, $41, $20, $3D
LD290:  .byte $20, $49, $20, $3D, $20, $8C, $FF, $87
LD298:  .byte $00, $00, $40, $3A, $10, $3C, $10, $90
LD2A0:  .byte $D4, $0C, $4F, $10, $51, $10, $4F, $10
LD2A8:  .byte $4E, $10, $4C, $10, $4A, $10, $49, $10
LD2B0:  .byte $47, $10, $45, $10, $43, $10, $42, $10
LD2B8:  .byte $40, $10, $3E, $10, $3D, $10, $3B, $10
LD2C0:  .byte $39, $10, $37, $40, $37, $10, $39, $10
LD2C8:  .byte $3B, $10, $3C, $10, $3E, $10, $40, $10
LD2D0:  .byte $42, $10, $43, $10, $45, $10, $47, $10
LD2D8:  .byte $48, $10, $4C, $10, $4D, $40, $90, $D4
LD2E0:  .byte $0C, $4E, $10, $50, $10, $8E, $02, $52
LD2E8:  .byte $40, $3A, $10, $3C, $10, $3A, $10, $39
LD2F0:  .byte $10, $3A, $10, $3C, $10, $3E, $10, $3F
LD2F8:  .byte $10, $41, $10, $43, $10, $45, $10, $46
LD300:  .byte $10, $47, $10, $49, $10, $47, $10, $46
LD308:  .byte $10, $44, $10, $42, $10, $41, $10, $40
LD310:  .byte $10, $3F, $10, $41, $10, $3F, $10, $3D
LD318:  .byte $10, $3B, $10, $3A, $10, $38, $10, $36
LD320:  .byte $10, $8F, $00, $35, $40, $3A, $10, $3C
LD328:  .byte $10, $3A, $10, $39, $10, $3A, $10, $3C
LD330:  .byte $10, $3E, $10, $3F, $10, $41, $10, $43
LD338:  .byte $10, $45, $10, $46, $10, $48, $40, $48
LD340:  .byte $10, $4A, $10, $4B, $10, $4D, $10, $4A
LD348:  .byte $10, $4B, $10, $4D, $10, $50, $10, $4E
LD350:  .byte $10, $50, $10, $52, $10, $54, $10, $87
LD358:  .byte $02, $8C, $00, $55, $40, $40, $40, $46
LD360:  .byte $40, $40, $40, $83, $FF, $44, $40, $3F
LD368:  .byte $40, $42, $40, $41, $40, $83, $FF, $3F
LD370:  .byte $40, $3A, $40, $3D, $40, $82, $07, $38
LD378:  .byte $40, $86, $00, $80, $4B, $41, $80, $41
LD380:  .byte $21, $3F, $20, $41, $20, $44, $20, $3F
LD388:  .byte $C0, $36, $40, $3E, $80, $3E, $21, $3D
LD390:  .byte $20, $3E, $20, $42, $20, $3C, $80, $3D
LD398:  .byte $40, $38, $40, $41, $80, $41, $21, $3F
LD3A0:  .byte $20, $41, $20, $44, $20, $42, $60, $40
LD3A8:  .byte $20, $3E, $20, $40, $20, $42, $20, $44
LD3B0:  .byte $20, $45, $20, $44, $20, $42, $60, $44
LD3B8:  .byte $20, $45, $20, $47, $20, $44, $80, $83
LD3C0:  .byte $FE, $44, $41, $83, $FF, $44, $21, $83
LD3C8:  .byte $FF, $44, $21, $00, $00

tune29_open:
LD3CD:  .byte $80, $7A, $87, $02, $00, $40, $30, $20 ;subphrase of tunes 35 and 36: the opening, .NRATE 122, .AENV 2, broken chords in eighth notes
LD3D5:  .byte $38, $20, $37, $20, $38, $20, $33, $20
LD3DD:  .byte $30, $20, $00, $40, $37, $20, $32, $20
LD3E5:  .byte $3A, $20, $37, $20, $3E, $20, $3A, $20
LD3ED:  .byte $00, $40, $3B, $20, $44, $20, $43, $20
LD3F5:  .byte $44, $20, $3F, $20, $3B, $20, $3D, $20
LD3FD:  .byte $31, $20, $35, $20, $31, $20, $39, $20
LD405:  .byte $35, $20, $3D, $20, $39, $20, $91

tune29_scale:
LD40C:  .byte $3D, $10, $3F, $10, $41, $10, $42, $10 ;subphrase of tune 35: a rising scale of ten sixteenth notes from C5
LD414:  .byte $44, $10, $46, $10, $48, $10, $49, $10
LD41C:  .byte $4B, $10, $4D, $10, $91

tune29_v2:
LD421:  .byte $90, $D3, $CD, $35, $80, $35, $80, $82 ;tune 36: voice 2 of the music of sound command $29
LD429:  .byte $0A, $42, $80, $42, $81, $43, $40, $40
LD431:  .byte $40, $3D, $40, $00, $20, $36, $20, $40
LD439:  .byte $80, $40, $81, $3D, $80, $3D, $81, $8E
LD441:  .byte $02, $46, $80, $46, $81, $47, $40, $44
LD449:  .byte $40, $3F, $40, $00, $20, $41, $20, $8F
LD451:  .byte $00, $46, $80, $46, $81, $48, $80, $48
LD459:  .byte $81, $49, $40, $3B, $40, $41, $40, $3D
LD461:  .byte $40, $83, $FF, $40, $40, $3A, $40, $3D
LD469:  .byte $40, $3C, $40, $83, $FF, $3A, $40, $36
LD471:  .byte $40, $39, $40, $34, $40, $80, $4B, $82
LD479:  .byte $07, $3D, $80, $3D, $81, $39, $C0, $00
LD481:  .byte $40, $39, $80, $39, $81, $39, $80, $38
LD489:  .byte $20, $00, $60, $3D, $80, $3D, $81, $3E
LD491:  .byte $60, $00, $20, $00, $80, $42, $40, $00
LD499:  .byte $C0, $40, $80, $83, $FE, $40, $41, $83
LD4A1:  .byte $FF, $40, $21, $83, $FF, $40, $21, $00
LD4A9:  .byte $00

tune29_v3:
LD4AA:  .byte $80, $7A, $87, $02, $86, $02, $00, $40 ;tune 37: voice 3 of the music of sound command $29 (frequency envelope 2)
LD4B2:  .byte $30, $C0, $32, $80, $32, $81, $33, $80
LD4BA:  .byte $33, $81, $35, $80, $35, $81, $31, $80
LD4C2:  .byte $2F, $80, $8E, $02, $42, $20, $3D, $20
LD4CA:  .byte $36, $20, $3D, $20, $8F, $00, $43, $20
LD4D2:  .byte $40, $20, $37, $20, $40, $20, $43, $20
LD4DA:  .byte $40, $20, $37, $20, $42, $20, $8E, $02
LD4E2:  .byte $43, $20, $40, $20, $37, $20, $40, $20
LD4EA:  .byte $8F, $00, $41, $20, $38, $20, $35, $20
LD4F2:  .byte $38, $20, $3D, $20, $41, $20, $44, $20
LD4FA:  .byte $49, $20, $8E, $02, $4D, $20, $46, $20
LD502:  .byte $3E, $20, $46, $20, $4D, $20, $46, $20
LD50A:  .byte $3E, $20, $46, $20, $4B, $20, $44, $20
LD512:  .byte $3B, $20, $44, $20, $4B, $20, $44, $20
LD51A:  .byte $3B, $20, $44, $20, $8F, $00, $8E, $02
LD522:  .byte $4D, $20, $46, $20, $3E, $20, $46, $20
LD52A:  .byte $8F, $00, $8E, $02, $4E, $20, $48, $20
LD532:  .byte $3F, $20, $48, $20, $8F, $00, $41, $40
LD53A:  .byte $38, $40, $3E, $40, $38, $40, $83, $FF
LD542:  .byte $3B, $40, $37, $40, $3A, $40, $39, $40
LD54A:  .byte $83, $FF, $37, $40, $31, $40, $34, $40
LD552:  .byte $2F, $40, $86, $00, $80, $4B, $82, $07
LD55A:  .byte $38, $80, $38, $81, $34, $C0, $00, $40
LD562:  .byte $36, $80, $36, $81, $36, $80, $35, $20
LD56A:  .byte $00, $60, $38, $80, $38, $81, $39, $80
LD572:  .byte $39, $81, $3E, $80, $3E, $81, $3D, $80
LD57A:  .byte $83, $FE, $3D, $41, $83, $FF, $3D, $21
LD582:  .byte $83, $FF, $3D, $21, $00, $00

tune29_v4:
LD588:  .byte $80, $7A, $87, $02, $20, $80, $20, $81 ;tune 38: voice 4 of the music of sound command $29, the bass
LD590:  .byte $22, $80, $22, $81, $23, $80, $23, $81
LD598:  .byte $25, $80, $25, $81, $20, $80, $25, $80
LD5A0:  .byte $1E, $80, $1E, $81, $25, $80, $25, $81
LD5A8:  .byte $18, $80, $18, $81, $19, $80, $19, $81
LD5B0:  .byte $8E, $02, $22, $80, $22, $81, $1D, $C0
LD5B8:  .byte $1D, $21, $19, $20, $8F, $00, $22, $80
LD5C0:  .byte $22, $81, $1E, $80, $1E, $81, $8E, $03
LD5C8:  .byte $25, $80, $25, $81, $83, $FF, $8F, $00
LD5D0:  .byte $87, $00, $80, $4B, $82, $07, $19, $20
LD5D8:  .byte $20, $20, $27, $20, $29, $20, $2C, $80
LD5E0:  .byte $19, $20, $21, $20, $27, $20, $28, $20
LD5E8:  .byte $2A, $20, $2D, $40, $31, $20, $19, $20
LD5F0:  .byte $21, $20, $26, $20, $2A, $20, $2D, $40
LD5F8:  .byte $32, $40, $1A, $20, $21, $20, $26, $20
LD600:  .byte $2A, $20, $29, $20, $25, $40, $20, $20
LD608:  .byte $19, $20, $20, $20, $27, $20, $29, $20
LD610:  .byte $2C, $20, $2E, $20, $31, $20, $35, $20
LD618:  .byte $34, $20, $32, $20, $2F, $20, $2D, $20
LD620:  .byte $2A, $20, $28, $20, $26, $20, $25, $20
LD628:  .byte $82, $09, $23, $60, $1E, $20, $17, $80
LD630:  .byte $82, $07, $19, $20, $20, $20, $27, $20
LD638:  .byte $28, $20, $87, $02, $82, $05, $2C, $40
LD640:  .byte $83, $FF, $2C, $21, $83, $FF, $2C, $21
LD648:  .byte $00, $00

tune31_v1:
LD64A:  .byte $80, $4B, $87, $02, $39, $11, $3A, $10 ;tune 31: voice 1, the melody, of the music of sound command $31 (.NRATE 75). tunes 31-34 are its four voices
LD652:  .byte $3C, $10, $3D, $10, $3F, $10, $41, $10
LD65A:  .byte $87, $01, $8E, $02, $42, $18, $42, $08
LD662:  .byte $42, $80, $41, $20, $3D, $20, $41, $20
LD66A:  .byte $42, $18, $42, $08, $42, $40, $41, $20
LD672:  .byte $3D, $18, $3D, $08, $3D, $60, $8F, $00
LD67A:  .byte $44, $18, $44, $08, $44, $80, $43, $20
LD682:  .byte $3F, $20, $43, $20, $44, $18, $44, $08
LD68A:  .byte $44, $40, $43, $20, $3F, $18, $3F, $08
LD692:  .byte $3F, $60, $46, $18, $46, $08, $46, $80
LD69A:  .byte $49, $20, $46, $20, $42, $20, $3F, $20
LD6A2:  .byte $41, $10, $3F, $10, $3C, $C0, $00, $00

tune31_v2:
LD6AA:  .byte $80, $4B, $87, $01, $00, $60, $8E, $02 ;tune 32: voice 2 of the music of sound command $31
LD6B2:  .byte $3A, $18, $3A, $08, $3A, $80, $38, $20
LD6BA:  .byte $35, $20, $38, $20, $3A, $18, $3A, $08
LD6C2:  .byte $3A, $40, $38, $20, $35, $18, $35, $08
LD6CA:  .byte $35, $60, $8F, $00, $41, $18, $41, $08
LD6D2:  .byte $41, $80, $3C, $60, $3C, $18, $3C, $08
LD6DA:  .byte $3C, $60, $3C, $18, $3C, $08, $3C, $60
LD6E2:  .byte $42, $18, $42, $08, $42, $80, $45, $20
LD6EA:  .byte $42, $20, $3E, $20, $3B, $40, $38, $40
LD6F2:  .byte $82, $05, $38, $11, $3A, $08, $3C, $08
LD6FA:  .byte $3D, $08, $3F, $08, $41, $08, $43, $08
LD702:  .byte $44, $40, $00, $00

tune31_v3:
LD706:  .byte $86, $01, $82, $03, $90, $D7, $39, $3C ;tune 33: voice 3 of the music of sound command $31
LD70E:  .byte $18, $3C, $08, $3C, $20, $82, $0A, $3C
LD716:  .byte $40, $41, $20, $3F, $20, $3C, $20, $33
LD71E:  .byte $20, $35, $60, $30, $20, $37, $60, $33
LD726:  .byte $20, $3A, $80, $3A, $21, $82, $07, $40
LD72E:  .byte $20, $3D, $20, $39, $20, $36, $40, $33
LD736:  .byte $C0, $00, $00

tune31_sub:
LD739:  .byte $80, $4B, $87, $02, $00, $60, $00, $40 ;subphrase of tunes 33 and 34: eighth notes in pairs with rests between, tune 34 plays it two octaves down (.NKEY -24)
LD741:  .byte $42, $20, $3A, $20, $3D, $20, $31, $20
LD749:  .byte $38, $20, $2C, $20, $00, $40, $49, $20
LD751:  .byte $3D, $20, $00, $40, $3D, $20, $31, $20
LD759:  .byte $00, $40, $42, $20, $3A, $20, $3D, $20
LD761:  .byte $31, $20, $38, $20, $2C, $20, $00, $40
LD769:  .byte $44, $20, $38, $20, $00, $40, $49, $20
LD771:  .byte $3D, $20, $91

tune31_v4:
LD774:  .byte $84, $E8, $90, $D7, $39, $84, $00, $00 ;tune 34: voice 4 of the music of sound command $31, the bass
LD77C:  .byte $40, $29, $20, $20, $20, $24, $20, $1B
LD784:  .byte $20, $1F, $20, $18, $20, $00, $40, $24
LD78C:  .byte $20, $1B, $20, $00, $40, $1F, $20, $18
LD794:  .byte $20, $00, $40, $1E, $20, $19, $20, $12
LD79C:  .byte $40, $00, $40, $87, $01, $82, $0D, $00
LD7A4:  .byte $80, $2C, $40, $20, $40, $00, $00

tune30_v1:
LD7AB:  .byte $84, $FD, $80, $55, $87, $02, $82, $05 ;tune 39: voice 1, the melody, of the music of sound command $30 (.NKEY -3, .NRATE 85, .AENV 2, .NVOL 5). tunes 39-42 are its four voices. the melody as written (C G C, A F#, G E C B, A) looks like Yoda's theme
LD7B3:  .byte $3D, $40, $44, $80, $3D, $40, $46, $40
LD7BB:  .byte $43, $80, $43, $81, $44, $40, $41, $40
LD7C3:  .byte $3D, $40, $48, $40, $46, $80, $46, $81
LD7CB:  .byte $44, $40, $41, $40, $3D, $40, $48, $40
LD7D3:  .byte $46, $40, $42, $40, $3F, $40, $49, $40
LD7DB:  .byte $49, $80, $49, $81, $49, $81, $00, $00

tune30_v2:
LD7E3:  .byte $84, $FD, $86, $02, $80, $55, $87, $00 ;tune 40: voice 2 of the music of sound command $30: the same melody with frequency envelope 2 and no amplitude envelope
LD7EB:  .byte $82, $05, $3D, $40, $44, $80, $3D, $40
LD7F3:  .byte $46, $40, $43, $80, $43, $81, $44, $40
LD7FB:  .byte $41, $40, $3D, $40, $48, $40, $46, $80
LD803:  .byte $46, $81, $44, $40, $41, $40, $3D, $40
LD80B:  .byte $48, $40, $46, $40, $42, $40, $3F, $40
LD813:  .byte $49, $40, $49, $80, $35, $80, $35, $81
LD81B:  .byte $00, $00

tune30_v3:
LD81D:  .byte $84, $FD, $86, $01, $80, $55, $87, $02 ;tune 41: voice 3 of the music of sound command $30: broken chords in eighth notes
LD825:  .byte $00, $40, $30, $20, $31, $20, $38, $C0
LD82D:  .byte $31, $20, $33, $20, $37, $20, $3F, $20
LD835:  .byte $3A, $20, $37, $20, $33, $20, $31, $20
LD83D:  .byte $30, $20, $31, $20, $38, $C0, $31, $20
LD845:  .byte $33, $20, $37, $20, $3A, $20, $43, $20
LD84D:  .byte $3F, $20, $3A, $20, $37, $20, $38, $20
LD855:  .byte $35, $20, $31, $C0, $3A, $20, $36, $20
LD85D:  .byte $33, $C0, $25, $40, $2C, $40, $35, $20
LD865:  .byte $38, $20, $3D, $16, $41, $16, $44, $14
LD86D:  .byte $49, $80, $00, $00

tune30_v4:
LD871:  .byte $84, $FD, $80, $55, $87, $03, $82, $09 ;tune 42: voice 4 of the music of sound command $30: one bass note, struck again every whole note
LD879:  .byte $00, $40, $25, $80, $25, $81, $25, $80
LD881:  .byte $25, $81, $25, $80, $25, $81, $25, $80
LD889:  .byte $25, $81, $25, $80, $25, $81, $25, $80
LD891:  .byte $25, $81, $25, $80, $25, $81, $25, $80
LD899:  .byte $00, $00

vamp_v1:
LD89B:  .byte $80, $78, $87, $01, $8E, $14, $38, $60 ;tune 43: the Imperial March's rhythm figure on G4 with E flat, .LOOP 20. tunes 43-46 are the four voices sound command $2F starts, their loop counts are 20, 21, 22 and 23
LD8A3:  .byte $00, $20, $38, $40, $38, $16, $38, $16
LD8AB:  .byte $38, $14, $38, $40, $38, $16, $38, $16
LD8B3:  .byte $38, $14, $34, $16, $34, $16, $34, $14
LD8BB:  .byte $34, $40, $8F, $00, $00, $00

vamp_v2:
LD8C1:  .byte $80, $78, $87, $01, $8E, $15, $2C, $60 ;tune 44: the march rhythm figure on G3 with B flat, .LOOP 21
LD8C9:  .byte $00, $20, $2C, $40, $2C, $16, $2C, $16
LD8D1:  .byte $2C, $14, $2C, $40, $2C, $16, $2C, $16
LD8D9:  .byte $2C, $14, $3B, $16, $3B, $16, $3B, $14
LD8E1:  .byte $3B, $40, $8F, $00, $00, $00

vamp_v3:
LD8E7:  .byte $80, $78, $87, $01, $86, $01, $8E, $16 ;tune 45: the march rhythm figure on G2 with F sharp, frequency envelope 1, .LOOP 22
LD8EF:  .byte $20, $60, $00, $20, $20, $40, $20, $16
LD8F7:  .byte $20, $16, $20, $14, $20, $40, $20, $16
LD8FF:  .byte $20, $16, $20, $14, $37, $16, $37, $16
LD907:  .byte $37, $14, $37, $40, $8F, $00, $00, $00

vamp_v4:
LD90F:  .byte $80, $78, $87, $01, $86, $02, $8E, $17 ;tune 46: the march rhythm figure on G2 with E flat, frequency envelope 2, .LOOP 23
LD917:  .byte $20, $60, $00, $20, $20, $40, $20, $16
LD91F:  .byte $20, $16, $20, $14, $20, $40, $20, $16
LD927:  .byte $20, $16, $20, $14, $1C, $16, $1C, $16
LD92F:  .byte $1C, $14, $1C, $40, $8F, $00, $00, $00

;------------------------------------------------------------------------------
; spk_cmd_03 - sound command $03: queues the word list that follows the routine (phrase 10 of the speech table
;   at L4002) with SPKNEW, behind whatever is being said or waiting
;------------------------------------------------------------------------------
spk_cmd_03:
LD937:  LDD  #$D93D                 ;address of the word list below
LD93A:  JMP  SPKNEW

spk_words_03:
LD93D:  .byte $0A, $FF              ;word list: phrase 10, $FF ends it

;------------------------------------------------------------------------------
; spk_cmd_04 - sound command $04: queues the word list that follows the routine (phrase 15 of the speech table
;   at L4002) with SPKNEW, behind whatever is being said or waiting
;------------------------------------------------------------------------------
spk_cmd_04:
LD93F:  LDD  #$D945                 ;address of the word list below
LD942:  JMP  SPKNEW

spk_words_04:
LD945:  .byte $0F, $FF              ;word list: phrase 15, $FF ends it

;------------------------------------------------------------------------------
; spk_cmd_05 - sound command $05: queues the word list that follows the routine (phrase 9 of the speech table at
;   L4002) with SPKNEW, behind whatever is being said or waiting
;------------------------------------------------------------------------------
spk_cmd_05:
LD947:  LDD  #$D94D                 ;address of the word list below
LD94A:  JMP  SPKNEW

spk_words_05:
LD94D:  .byte $09, $FF              ;word list: phrase 9, $FF ends it

;------------------------------------------------------------------------------
; spk_cmd_06 - sound command $06: says the word list that follows the routine (phrase 1 of the speech table at
;   L4002) through SPITE, so only when nothing is being said and nothing is waiting, else the request is dropped
;------------------------------------------------------------------------------
spk_cmd_06:
LD94F:  LDX  #spk_words_06
LD952:  JMP  SPITE

spk_words_06:
LD955:  .byte $01, $FF              ;word list: phrase 1, $FF ends it

;------------------------------------------------------------------------------
; spk_cmd_07 - sound command $07: queues the word list that follows the routine (phrase 3 of the speech table at
;   L4002) with SPKNEW, behind whatever is being said or waiting
;------------------------------------------------------------------------------
spk_cmd_07:
LD957:  LDD  #$D95D                 ;address of the word list below
LD95A:  JMP  SPKNEW

spk_words_07:
LD95D:  .byte $03, $FF              ;word list: phrase 3, $FF ends it

;------------------------------------------------------------------------------
; spk_cmd_08 - sound command $08: queues the word list that follows the routine (phrase 23 of the speech table
;   at L4002) with SPKNEW, behind whatever is being said or waiting
;------------------------------------------------------------------------------
spk_cmd_08:
LD95F:  LDD  #$D965                 ;address of the word list below
LD962:  JMP  SPKNEW

spk_words_08:
LD965:  .byte $17, $FF              ;word list: phrase 23, $FF ends it

;------------------------------------------------------------------------------
; spk_cmd_09 - sound command $09: queues the word list that follows the routine (phrase 12 of the speech table
;   at L4002) with SPKNEW, behind whatever is being said or waiting
;------------------------------------------------------------------------------
spk_cmd_09:
LD967:  LDD  #$D96D                 ;address of the word list below
LD96A:  JMP  SPKNEW

spk_words_09:
LD96D:  .byte $0C, $FF              ;word list: phrase 12, $FF ends it

;------------------------------------------------------------------------------
; spk_cmd_0a - sound command $0A: queues the word list that follows the routine (phrase 17 of the speech table
;   at L4002) with SPKNEW, behind whatever is being said or waiting
;------------------------------------------------------------------------------
spk_cmd_0a:
LD96F:  LDD  #$D975                 ;address of the word list below
LD972:  JMP  SPKNEW

spk_words_0a:
LD975:  .byte $11, $FF              ;word list: phrase 17, $FF ends it

;------------------------------------------------------------------------------
; spk_cmd_0c - sound command $0C: queues the word list that follows the routine (phrases 4, 2 and 5 of the
;   speech table at L4002) with SPKNEW, behind whatever is being said or waiting
;------------------------------------------------------------------------------
spk_cmd_0c:
LD977:  LDD  #$D97D                 ;address of the word list below
LD97A:  JMP  SPKNEW

spk_words_0c:
LD97D:  .byte $04, $02, $05, $FF    ;word list: phrases 4, 2 and 5, $FF ends it

;------------------------------------------------------------------------------
; spk_cmd_0d - sound command $0D: queues the word list that follows the routine (phrase 6 of the speech table at
;   L4002) with SPKNEW, behind whatever is being said or waiting
;------------------------------------------------------------------------------
spk_cmd_0d:
LD981:  LDD  #$D987                 ;address of the word list below
LD984:  JMP  SPKNEW

spk_words_0d:
LD987:  .byte $06, $FF              ;word list: phrase 6, $FF ends it

;------------------------------------------------------------------------------
; spk_cmd_0e - sound command $0E: queues the word list that follows the routine (phrase 19 of the speech table
;   at L4002) with SPKNEW, behind whatever is being said or waiting
;------------------------------------------------------------------------------
spk_cmd_0e:
LD989:  LDD  #$D98F                 ;address of the word list below
LD98C:  JMP  SPKNEW

spk_words_0e:
LD98F:  .byte $13, $FF              ;word list: phrase 19, $FF ends it

;------------------------------------------------------------------------------
; spk_cmd_0f - sound command $0F: queues the word list that follows the routine (phrase 13 of the speech table
;   at L4002) with SPKNEW, behind whatever is being said or waiting
;------------------------------------------------------------------------------
spk_cmd_0f:
LD991:  LDD  #$D997                 ;address of the word list below
LD994:  JMP  SPKNEW

spk_words_0f:
LD997:  .byte $0D, $FF              ;word list: phrase 13, $FF ends it

;------------------------------------------------------------------------------
; spk_cmd_10 - sound command $10: queues the word list that follows the routine (phrase 20 of the speech table
;   at L4002) with SPKNEW, behind whatever is being said or waiting
;------------------------------------------------------------------------------
spk_cmd_10:
LD999:  LDD  #$D99F                 ;address of the word list below
LD99C:  JMP  SPKNEW

spk_words_10:
LD99F:  .byte $14, $FF              ;word list: phrase 20, $FF ends it

;------------------------------------------------------------------------------
; spk_cmd_11 - sound command $11: queues the word list that follows the routine (phrase 22 of the speech table
;   at L4002) with SPKNEW, behind whatever is being said or waiting
;------------------------------------------------------------------------------
spk_cmd_11:
LD9A1:  LDD  #$D9A7                 ;address of the word list below
LD9A4:  JMP  SPKNEW

spk_words_11:
LD9A7:  .byte $16, $FF              ;word list: phrase 22, $FF ends it

;------------------------------------------------------------------------------
; spk_cmd_12 - sound command $12: queues the word list that follows the routine (phrase 7 of the speech table at
;   L4002) with SPKNEW, behind whatever is being said or waiting
;------------------------------------------------------------------------------
spk_cmd_12:
LD9A9:  LDD  #$D9AF                 ;address of the word list below
LD9AC:  JMP  SPKNEW

spk_words_12:
LD9AF:  .byte $07, $FF              ;word list: phrase 7, $FF ends it

;------------------------------------------------------------------------------
; spk_cmd_14 - sound command $14: queues the word list that follows the routine (phrase 18 of the speech table
;   at L4002) with SPKNEW, behind whatever is being said or waiting
;------------------------------------------------------------------------------
spk_cmd_14:
LD9B1:  LDD  #$D9B7                 ;address of the word list below
LD9B4:  JMP  SPKNEW

spk_words_14:
LD9B7:  .byte $12, $FF              ;word list: phrase 18, $FF ends it

;------------------------------------------------------------------------------
; spk_cmd_15 - sound command $15: queues the word list that follows the routine (phrase 14 of the speech table
;   at L4002) with SPKNEW, behind whatever is being said or waiting
;------------------------------------------------------------------------------
spk_cmd_15:
LD9B9:  LDD  #$D9BF                 ;address of the word list below
LD9BC:  JMP  SPKNEW

spk_words_15:
LD9BF:  .byte $0E, $FF              ;word list: phrase 14, $FF ends it

;------------------------------------------------------------------------------
; spk_cmd_16 - sound command $16: queues the word list that follows the routine (phrase 21 of the speech table
;   at L4002) with SPKNEW, behind whatever is being said or waiting
;------------------------------------------------------------------------------
spk_cmd_16:
LD9C1:  LDD  #$D9C7                 ;address of the word list below
LD9C4:  JMP  SPKNEW

spk_words_16:
LD9C7:  .byte $15, $FF              ;word list: phrase 21, $FF ends it

;------------------------------------------------------------------------------
; spk_cmd_17 - sound command $17: queues the word list that follows the routine (phrase 11 of the speech table
;   at L4002) with SPKNEW, behind whatever is being said or waiting
;------------------------------------------------------------------------------
spk_cmd_17:
LD9C9:  LDD  #$D9CF                 ;address of the word list below
LD9CC:  JMP  SPKNEW

spk_words_17:
LD9CF:  .byte $0B, $FF              ;word list: phrase 11, $FF ends it

;------------------------------------------------------------------------------
; spk_cmd_18 - sound command $18: queues the word list that follows the routine (phrase 8 of the speech table at
;   L4002) with SPKNEW, behind whatever is being said or waiting
;------------------------------------------------------------------------------
spk_cmd_18:
LD9D1:  LDD  #$D9D7                 ;address of the word list below
LD9D4:  JMP  SPKNEW

spk_words_18:
LD9D7:  .byte $08, $FF              ;word list: phrase 8, $FF ends it

;------------------------------------------------------------------------------
; spk_cmd_19 - sound command $19: queues the word list that follows the routine (phrase 24 of the speech table
;   at L4002) with SPKNEW, behind whatever is being said or waiting
;------------------------------------------------------------------------------
spk_cmd_19:
LD9D9:  LDD  #$D9DF                 ;address of the word list below
LD9DC:  JMP  SPKNEW

spk_words_19:
LD9DF:  .byte $18, $FF              ;word list: phrase 24, $FF ends it

;------------------------------------------------------------------------------
; spk_cmd_1a - sound command $1A: queues the word list that follows the routine (phrase 16 of the speech table
;   at L4002) with SPKNEW, behind whatever is being said or waiting
;------------------------------------------------------------------------------
spk_cmd_1a:
LD9E1:  LDD  #$D9E7                 ;address of the word list below
LD9E4:  JMP  SPKNEW

spk_words_1a:
LD9E7:  .byte $10, $FF              ;word list: phrase 16, $FF ends it

;------------------------------------------------------------------------------
; spk_cmd_1b - sound command $1B: queues the word list that follows the routine (phrase 32 of the speech table
;   at L4002) with SPKNEW, behind whatever is being said or waiting
;------------------------------------------------------------------------------
spk_cmd_1b:
LD9E9:  LDD  #$D9EF                 ;address of the word list below
LD9EC:  JMP  SPKNEW

spk_words_1b:
LD9EF:  .byte $20, $FF              ;word list: phrase 32, $FF ends it

;------------------------------------------------------------------------------
; spk_cmd_1c - sound command $1C: queues the word list that follows the routine (phrase 26 of the speech table
;   at L4002) with SPKNEW, behind whatever is being said or waiting
;------------------------------------------------------------------------------
spk_cmd_1c:
LD9F1:  LDD  #$D9F7                 ;address of the word list below
LD9F4:  JMP  SPKNEW

spk_words_1c:
LD9F7:  .byte $1A, $FF              ;word list: phrase 26, $FF ends it

;------------------------------------------------------------------------------
; spk_cmd_1d - sound command $1D: queues the word list that follows the routine (phrase 29 of the speech table
;   at L4002) with SPKNEW, behind whatever is being said or waiting
;------------------------------------------------------------------------------
spk_cmd_1d:
LD9F9:  LDD  #$D9FF                 ;address of the word list below
LD9FC:  JMP  SPKNEW

spk_words_1d:
LD9FF:  .byte $1D, $FF              ;word list: phrase 29, $FF ends it

;------------------------------------------------------------------------------
; spk_cmd_1e - sound command $1E: queues the word list that follows the routine (phrases 35 and 36 of the speech
;   table at L4002) with SPKNEW, behind whatever is being said or waiting
;------------------------------------------------------------------------------
spk_cmd_1e:
LDA01:  LDD  #$DA07                 ;address of the word list below
LDA04:  JMP  SPKNEW

spk_words_1e:
LDA07:  .byte $23, $24, $FF         ;word list: phrases 35 and 36, $FF ends it

;------------------------------------------------------------------------------
; spk_cmd_1f - sound command $1F: queues the word list that follows the routine (phrase 34 of the speech table
;   at L4002) with SPKNEW, behind whatever is being said or waiting
;------------------------------------------------------------------------------
spk_cmd_1f:
LDA0A:  LDD  #$DA10                 ;address of the word list below
LDA0D:  JMP  SPKNEW

spk_words_1f:
LDA10:  .byte $22, $FF              ;word list: phrase 34, $FF ends it

;------------------------------------------------------------------------------
; spk_cmd_20 - sound command $20: queues the word list that follows the routine (phrase 27 of the speech table
;   at L4002) with SPKNEW, behind whatever is being said or waiting
;------------------------------------------------------------------------------
spk_cmd_20:
LDA12:  LDD  #$DA18                 ;address of the word list below
LDA15:  JMP  SPKNEW

spk_words_20:
LDA18:  .byte $1B, $FF              ;word list: phrase 27, $FF ends it

;------------------------------------------------------------------------------
; spk_cmd_21 - sound command $21: queues the word list that follows the routine (phrase 30 of the speech table
;   at L4002) with SPKNEW, behind whatever is being said or waiting
;------------------------------------------------------------------------------
spk_cmd_21:
LDA1A:  LDD  #$DA20                 ;address of the word list below
LDA1D:  JMP  SPKNEW

spk_words_21:
LDA20:  .byte $1E, $FF              ;word list: phrase 30, $FF ends it

;------------------------------------------------------------------------------
; spk_cmd_22 - sound command $22: queues the word list that follows the routine (phrase 37 of the speech table
;   at L4002) with SPKNEW, behind whatever is being said or waiting
;------------------------------------------------------------------------------
spk_cmd_22:
LDA22:  LDD  #$DA28                 ;address of the word list below
LDA25:  JMP  SPKNEW

spk_words_22:
LDA28:  .byte $25, $FF              ;word list: phrase 37, $FF ends it

;------------------------------------------------------------------------------
; spk_cmd_23 - sound command $23: queues the word list that follows the routine (phrase 31 of the speech table
;   at L4002) with SPKNEW, behind whatever is being said or waiting
;------------------------------------------------------------------------------
spk_cmd_23:
LDA2A:  LDD  #$DA30                 ;address of the word list below
LDA2D:  JMP  SPKNEW

spk_words_23:
LDA30:  .byte $1F, $FF              ;word list: phrase 31, $FF ends it

;------------------------------------------------------------------------------
; spk_cmd_24 - sound command $24: queues the word list that follows the routine (phrase 25 of the speech table
;   at L4002) with SPKNEW, behind whatever is being said or waiting
;------------------------------------------------------------------------------
spk_cmd_24:
LDA32:  LDD  #$DA38                 ;address of the word list below
LDA35:  JMP  SPKNEW

spk_words_24:
LDA38:  .byte $19, $FF              ;word list: phrase 25, $FF ends it

;------------------------------------------------------------------------------
; spk_cmd_25 - sound command $25: queues the word list that follows the routine (phrase 38 of the speech table
;   at L4002) with SPKNEW, behind whatever is being said or waiting
;------------------------------------------------------------------------------
spk_cmd_25:
LDA3A:  LDD  #$DA40                 ;address of the word list below
LDA3D:  JMP  SPKNEW

spk_words_25:
LDA40:  .byte $26, $FF              ;word list: phrase 38, $FF ends it

;------------------------------------------------------------------------------
; spk_cmd_26 - sound command $26: queues the word list that follows the routine (phrase 39 of the speech table
;   at L4002) with SPKNEW, behind whatever is being said or waiting
;------------------------------------------------------------------------------
spk_cmd_26:
LDA42:  LDD  #$DA48                 ;address of the word list below
LDA45:  JMP  SPKNEW

spk_words_26:
LDA48:  .byte $27, $FF              ;word list: phrase 39, $FF ends it

;------------------------------------------------------------------------------
; spk_cmd_27 - sound command $27: queues the word list that follows the routine (phrase 33 of the speech table
;   at L4002) with SPKNEW, behind whatever is being said or waiting
;------------------------------------------------------------------------------
spk_cmd_27:
LDA4A:  LDD  #$DA50                 ;address of the word list below
LDA4D:  JMP  SPKNEW

spk_words_27:
LDA50:  .byte $21, $FF              ;word list: phrase 33, $FF ends it

;------------------------------------------------------------------------------
; spk_cmd_28 - sound command $28: says the word list that follows the routine (phrase 40 of the speech table at
;   L4002) through SPITE, so only when nothing is being said and nothing is waiting, else the request is dropped
;------------------------------------------------------------------------------
spk_cmd_28:
LDA52:  LDX  #spk_words_28
LDA55:  JMP  SPITE

spk_words_28:
LDA58:  .byte $28, $FF              ;word list: phrase 40, $FF ends it

;------------------------------------------------------------------------------
; SPKI - INIT SPEECH CHIP, WARMSTART
;------------------------------------------------------------------------------
SPKI:
LDA5A:  LDD  #$0000                 ;SPECIAL FLAG FOR WARMSTART

SPKNEW:
LDA5D:  STD  SP_NXT
LDA5F:  LDB  SP_QTP                 ;UPDATE TO NEXT QUEUE POSITION
LDA61:  INCB
LDA62:  ANDB #$0F                   ;16 ITEMS
LDA64:  STB  SP_QTP
LDA66:  LSLB                        ;ONE WORD EACH
LDA67:  LDX  #SPKQUE                ;SENTENCE FIFO QUEUE
LDA6A:  ABX
LDA6B:  LDD  SP_NXT
LDA6D:  STD  ,X
LDA6F:  RTS

;------------------------------------------------------------------------------
; SPITE - [note] X-->word list: start it with SPKNEW only if the sentence queue is empty (SP_QTP = SP_QBT) and no
;   voice is currently being spoken (SP_STA = 0); otherwise drop the request
;------------------------------------------------------------------------------
SPITE:
LDA70:  LDB  SP_QTP                 ;IF I CAN'T BE FIRST, I WON'T BE AT ALL.
LDA72:  CMPB SP_QBT
LDA74:  BNE  LDA7E                  ;IFEQ  ?NO OTHER VOICES IN THE WAY?
LDA76:  LDB  SP_STA
LDA78:  BNE  LDA7E                  ;IFEQ  ?AND NO VOICE CURRENTLY BEING SPOKEN?
LDA7A:  TFR  X,D
LDA7C:  BRA  SPKNEW
LDA7E:  RTS

;------------------------------------------------------------------------------
; SPKSKP - SKIP OVER WAITING MESSAGES
;------------------------------------------------------------------------------
SPKSKP:
LDA7F:  LDB  SP_QTP
LDA81:  STB  SP_QBT                 ;POINT BOTTOM TO TOP, SKIPPING MESSAGES
LDA83:  RTS

;------------------------------------------------------------------------------
; SPKRES - SPKIRQ - SPEECH IRQ DRIVER
;   RESET THE SPEECH ROUTINE/CHIP
;------------------------------------------------------------------------------
SPKRES:
LDA84:  LDA  #$00                   ;COLDSTART
LDA86:  STA  SP_QBT
LDA88:  STA  SP_QTP                 ;CLEAR ALL WAITING MESSAGES
LDA8A:  STA  SP_DOG                 ;RESET WATCHDOG ALSO

SPKWRM:          ;WARM START THE SPEECH SYSTEM
LDA8C:  LDA  #$FF                   ;BEGIN POWER OFF SEQUENCE
LDA8E:  STA  SP_RES
LDA90:  LDA  SP_QBT
LDA92:  ANDA #$0F                   ;DON'T LOSE SOFTWARE, JUST MAKE IT REASONABLE
LDA94:  STA  SP_QBT
LDA96:  LDA  SP_QTP
LDA98:  ANDA #$0F
LDA9A:  STA  SP_QTP
LDA9C:  RTS

;------------------------------------------------------------------------------
; SPKIRQ - START SPEECH AT FRONT  (comment at the call)
;   THEN END WITH SPEECH, TWICE IN 4 MS  (another call)
;------------------------------------------------------------------------------
SPKIRQ:
LDA9D:  LDA  SP_RES                 ;CHECK RESET-COUNT
LDA9F:  BEQ  LDADB                  ;IFNE  ?RESET MODE?
LDAA1:  BPL  LDAC2                  ;IFMI  ?POWER OF CHIP RESET?
LDAA3:  LSLA
LDAA4:  BPL  LDAB2                  ;IFMI  0FF TO 0C0, 40*TWICE EVERY 4 MS =128 MS
LDAA6:  LDA  PAD
LDAA8:  ORA  #3+BT5                 ;WRITE HI,READ HI,POWER OFF
LDAAA:  STA  PAD
LDAAC:  LDA  #$FF
LDAAE:  STA  PBD                    ;SENDA  PULL DATA LINES HI ALSO
LDAB0:  BRA  LDAB8                  ;ELSE  ---ELSE C0 TO 7F, TIME TO TURN ON CHIP, 128 MS
LDAB2:  LDA  PAD
LDAB4:  ANDA #-1-BT5                ;POWER ON
LDAB6:  STA  PAD
LDAB8:  DEC  SP_RES                 ;STARTS AT 0FF, GOES DOWN TO 7F
LDABA:  BMI  LDAC0                  ;IFPL  ?FINISHED WITH CHIP POWER ON/OFF?
LDABC:  LDA  #$28                   ;TAKES 10. RESET BYTES, FACTOR OF 4 SAFETY
LDABE:  STA  SP_RES
LDAC0:  BRA  LDADA                  ;ELSE  ELSE SENDING RESET DATA TO LIVE CHIP
LDAC2:  LDA  PAD                    ;WSENDA  END ANY PREVIOUS WRITE STROBE
LDAC4:  ORA  #$03
LDAC6:  STA  PAD
LDAC8:  LDA  #$FF                   ;THEN SEND A RESET
LDACA:  STA  PBD                    ;SENDA
LDACC:  LDA  PAD                    ;WSBGNA  START A NEW WRITE STROBE
LDACE:  ANDA #$FE
LDAD0:  STA  PAD
LDAD2:  DEC  SP_RES
LDAD4:  BNE  LDADA                  ;IFEQ  ?FINISHED WITH CHIP RESET?
LDAD6:  LDA  #$00                   ;THEN RESET SOFTWARE TOO
LDAD8:  STA  SP_STA                 ;IDLE STATUS
LDADA:  RTS                         ;END OF SEND RESET
LDADB:  LDA  PAD                    ;CHECK FOR READY
LDADD:  ANDA #$04                   ;?HARDWARE READY?
LDADF:  BEQ  SPKIRQ_5               ;IFNE  ?STILL BUSY?
LDAE1:  LDA  S_INTCT
LDAE3:  ANDA #$03                   ;TWICE EVERY 16 MS IS 8 MS
LDAE5:  BNE  LDAED                  ;IFEQ
LDAE7:  INC  SP_DOG
LDAE9:  LBMI SPKWRM                 ;128. * 8 MILLS IS ONE SECOND
LDAED:  JMP  SPKIRQ_100             ;AT LEAST EXIT IF NOT READY

SPKIRQ_5:          ;---HARDWARE READY
LDAF0:  LDA  #$00
LDAF2:  STA  SP_DOG                 ;TURN DOG OFF FOR A WHILE
LDAF4:  LDA  PAD                    ;WSENDA  END THE WRITE STROBE(EITHER ALREADY ENDED OR WILL
LDAF6:  ORA  #$03
LDAF8:  STA  PAD
;COMPLETE THE WRITE)
LDAFA:  LDA  SP_STA                 ;CHECK TALKSTATUS
LDAFC:  BNE  SPKIRQ_12              ;?IDLE?
LDAFE:  LDA  SP_DLY
LDB00:  BEQ  LDB07                  ;IFNE  ?STILL INTER-MESSAGE DELAYING?
LDB02:  DEC  SP_DLY                 ;THEN TIME IT DOWN
LDB04:  JMP  SPKIRQ_100             ;J
LDB07:  LDB  SP_QBT                 ;GET NEXT SENTENCE FROM FIFO QUEUE, IF ANY
LDB09:  CMPB SP_QTP
LDB0B:  BEQ  SPKIRQ_100             ;B EXIT IF QUEUE EMPTY, ALREADY UNLOADED
LDB0D:  INCB                        ;INDEX TO NEXT SENTENCE
LDB0E:  ANDB #$0F                   ;16 MAX SENTENCE QUEUE
LDB10:  STB  SP_QBT
LDB12:  LSLB                        ;WORD ENTRIES
LDB13:  LDX  #SPKQUE
LDB16:  LDD  B,X                    ;GET THE SENTENCE POINTER
LDB18:  STD  SP_MES                 ;SET IT UP
LDB1A:  LBEQ SPKWRM                 ;SPECIAL CODE FOR SOFTWARE WARMSTART
LDB1E:  LDA  #$03                   ;AND LET 'ER RIP
LDB20:  STA  SP_STA
LDB22:  RTS                         ;END OF BEGIN NEW SENTENCE

SPKIRQ_12:
LDB23:  CMPA #$02
LDB25:  BNE  SPKIRQ_20
;===TALK STATUS 2
LDB27:  LDX  SP_BGN                 ;SEND NEXT SPEECH BYTE
LDB29:  LDA  ,X+
LDB2B:  STA  PBD                    ;SENDA  OUTPUT
LDB2D:  LDA  PAD                    ;WSBGNA  BEGIN WRITE STROBE
LDB2F:  ANDA #$FE
LDB31:  STA  PAD
LDB33:  STX  SP_BGN
LDB35:  CMPX SP_END
LDB37:  BNE  SPKIRQ_100

SPKIRQ_29:          ;END OF WORD DELAY STARTUP
LDB39:  LDA  #$01
LDB3B:  STA  SP_STA                 ;DO DELAY
LDB3D:  LDA  #$80                   ;128.*2MS = 256.MS = 1/4 SECOND PAUSE
LDB3F:  STA  SP_DLY
LDB41:  RTS                         ;END OF TALK STATUS 2

SPKIRQ_20:
LDB42:  BLO  SPKIRQ_30              ;?TALK STATUS 3?
LDB44:  LDX  SP_MES
LDB46:  LDB  ,X+                    ;GET NEXT WORD IN THE MESSAGE
LDB48:  STX  SP_MES                 ;UPDATE MESSAGE POINTER
LDB4A:  CMPB #$FE                   ;FF=END OF MESSAGE, FE=1/4 SECOND PAUSE
LDB4C:  BLO  SPKIRQ_25              ;B IF GOOD MESSAGE POINTER
LDB4E:  BEQ  SPKIRQ_29              ;B IF PAUSE REQUESTED
;ELSE END OF MESSAGE
LDB50:  CLR  SP_STA                 ;NO MORE WORDS -- IDLE LOOP WHILE WAITING FOR MORE
LDB52:  LDA  #$FF                   ;LONG INTER-MESSAGE DELAY
LDB54:  STA  SP_DLY
LDB56:  RTS                         ;END OF TALK STATUS 3

SPKIRQ_25:
LDB57:  LDX  #L4002                 ;GET BASE VOICE TABLE
LDB5A:  ABX                         ;ADD IN INDEX*4
LDB5B:  ABX                         ;ALLOW LOTS OF VOICES (255 MAX)
LDB5C:  ABX
LDB5D:  ABX
LDB5E:  CMPX #L40A6
LDB61:  LBHS SPKRES                 ;B RESET SPEECH ROUTINE/CHIP IF BAD ADDRESSES FOUND
LDB65:  LDD  ,X                     ;GET STARTING AND ENDING ADDRESSES
LDB67:  STD  SP_BGN
LDB69:  LDD  2,X
LDB6B:  STD  SP_END
LDB6D:  LDA  #$60                   ;GENERATE SPEAK EXTERNAL COMMAND
LDB6F:  STA  PBD                    ;SENDA
LDB71:  LDA  PAD                    ;WSBGNA
LDB73:  ANDA #$FE
LDB75:  STA  PAD
LDB77:  DEC  SP_STA
LDB79:  RTS                         ;ENDA OF TALK STATUS 3

SPKIRQ_30:          ;===TALK STATUS 1
LDB7A:  DEC  SP_DLY                 ;INTERWORD DELAY
LDB7C:  BNE  SPKIRQ_100
LDB7E:  LDA  #$03
LDB80:  STA  SP_STA

SPKIRQ_100:
LDB82:  RTS

;.SBTTL VOICE PARAMETERS
;POKEY (VOICE 1)
TVC:
TVC1:
LDB83:  .word VOICE1                ;.TVC 1,PKFL1,16 PKFL1 0
LDB85:  .byte VC1
LDB86:  .word PKFL1
LDB88:  .byte $00
LDB89:  .word PKFL1

;POKEY (VOICE 2)
TVC2:
LDB8B:  .word VOICE2                ;.TVC 2,PKFL2,16 PKFL2 0
LDB8D:  .byte VC2
LDB8E:  .word PKFL2
LDB90:  .byte $00
LDB91:  .word PKFL2

;POKEY (VOICE 3 OR 3A)
TVC3:
LDB93:  .word VOICE3                ;.TVC 3,PKFL3,16 PKFL3 0
LDB95:  .byte VC3
LDB96:  .word PKFL3
LDB98:  .byte $00
LDB99:  .word PKFL3

;*** NON-SPLIT 16 BIT VOICE 4
TVC4:
LDB9B:  .word VOICE4                ;.TVC 4,PKFL4,16 PKFL4 0
LDB9D:  .byte VC4
LDB9E:  .word PKFL4
LDBA0:  .byte $00
LDBA1:  .word PKFL4

TVC5:
LDBA3:  .word VOICE5                ;.TVC 5,PKFL4,16 PKFH4 VC4
LDBA5:  .byte VC5
LDBA6:  .word PKFL4
LDBA8:  .byte VC4
LDBA9:  .word PKFH4

TVC6:
LDBAB:  .word VOICE6                ;.TVC 6,PKFL4,16 PKFH1 VC4!VC5
LDBAD:  .byte VC6
LDBAE:  .word PKFL4
LDBB0:  .byte VC4|VC5
LDBB1:  .word PKFH1

TVC7:
LDBB3:  .word VOICE7                ;.TVC 7,PKFL4,16 PKFH2 VC4!VC5!VC6
LDBB5:  .byte VC7
LDBB6:  .word PKFL4
LDBB8:  .byte VC4|VC5|VC6
LDBB9:  .word PKFH2

TVC8:
LDBBB:  .word VOICE8                ;.TVC 8,PKFL4,16 PKFH3 VC4!VC5!VC6!VC7
LDBBD:  .byte VC8
LDBBE:  .word PKFL4
LDBC0:  .byte VC4|VC5|VC6|VC7
LDBC1:  .word PKFH3

;------------------------------------------------------------------------------
; PMSF2 - MACRO DEFINITIONS
;   SPECIAL EFFECT(PROTON TORPEDO)
;   END OF VOICE RAM BLOCKS
;   (also: TVCZ)
;   in ESB: sound command $2D. the main program's stub for it is never called
;------------------------------------------------------------------------------
PMSF2:
TVCZ:
LDBC3:  JSR  PKCUT1                 ;.TUNE 1,1
LDBC6:  LDB  #$02
LDBC8:  JSR  NWTUNE
LDBCB:  JSR  PKCUT2                 ;.TUNE 2,2
LDBCE:  LDB  #$04
LDBD0:  JSR  NWTUNE
LDBD3:  JSR  PKCUT3                 ;.TUNE 3,3
LDBD6:  LDB  #$06
LDBD8:  JSR  NWTUNE
LDBDB:  JSR  PKCUT4                 ;.TUNE 4,4
LDBDE:  LDB  #$08
LDBE0:  JSR  NWTUNE
LDBE3:  RTS

;------------------------------------------------------------------------------
; PMBEN - BENS THEME (START OF TOWER)
;   in ESB: sound command $2A, sent by the main program when a Jedi letter is awarded. the four tunes are
;   longer than Star Wars's
;------------------------------------------------------------------------------
PMBEN:
LDBE4:  JSR  PKCUT1                 ;.TUNE 1,7
LDBE7:  LDB  #$0E
LDBE9:  JSR  NWTUNE
LDBEC:  JSR  PKCUT2                 ;.TUNE 2,8
LDBEF:  LDB  #$10
LDBF1:  JSR  NWTUNE
LDBF4:  JSR  PKCUT3                 ;.TUNE 3,9
LDBF7:  LDB  #$12
LDBF9:  JSR  NWTUNE
LDBFC:  JSR  PKCUT4                 ;.TUNE 4,10
LDBFF:  LDB  #$14
LDC01:  JSR  NWTUNE
LDC04:  RTS

;------------------------------------------------------------------------------
; PMTST - MUSIC CHANNEL TEST TONES
;   in ESB: sound command $02
;------------------------------------------------------------------------------
PMTST:
LDC05:  JSR  PKCUT3                 ;.TUNE 3,47  CHANNEL #S CHANGED TO BE IN ORDER OF
LDC08:  LDB  #$16
LDC0A:  JSR  NWTUNE
;POKEYS ON BOARD (WAS 1,2,3,4, NOW 3,4,1,2)
LDC0D:  JSR  PKCUT4                 ;.TUNE 4,48
LDC10:  LDB  #$18
LDC12:  JSR  NWTUNE
LDC15:  JSR  PKCUT1                 ;.TUNE 1,49
LDC18:  LDB  #$1A
LDC1A:  JSR  NWTUNE
LDC1D:  JSR  PKCUT2                 ;.TUNE 2,50
LDC20:  LDB  #$1C
LDC22:  JSR  NWTUNE
LDC25:  RTS

;------------------------------------------------------------------------------
; PMEND - (AFTER DETH STAR EXPLOSION)
;   in ESB: sound command $2B. the code is Star Wars's but tunes 15-18 are now the Imperial March (march_v1 -
;   march_v4), sent by the wave 2 setup
;------------------------------------------------------------------------------
PMEND:
LDC26:  JSR  PKCUT1                 ;.TUNE 1,15
LDC29:  LDB  #$1E
LDC2B:  JSR  NWTUNE
LDC2E:  JSR  PKCUT2                 ;.TUNE 2,16
LDC31:  LDB  #$20
LDC33:  JSR  NWTUNE
LDC36:  JSR  PKCUT3                 ;.TUNE 3,17
LDC39:  LDB  #$22
LDC3B:  JSR  NWTUNE
LDC3E:  JSR  PKCUT4                 ;.TUNE 4,18
LDC41:  LDB  #$24
LDC43:  JSR  NWTUNE
LDC46:  RTS

;------------------------------------------------------------------------------
; PMREB - REBEL THEME (TRANSITION INTO TRENCH)
;   in ESB: not in the command table PBX, so nothing calls it, and its tunes 19-22 are all the empty tune at
;   $CB1C
;------------------------------------------------------------------------------
PMREB:
LDC47:  JSR  PKCUT1                 ;.TUNE 1,19
LDC4A:  LDB  #$26
LDC4C:  JSR  NWTUNE
LDC4F:  JSR  PKCUT2                 ;.TUNE 2,20
LDC52:  LDB  #$28
LDC54:  JSR  NWTUNE
LDC57:  JSR  PKCUT3                 ;.TUNE 3,21
LDC5A:  LDB  #$2A
LDC5C:  JSR  NWTUNE
LDC5F:  JSR  PKCUT4                 ;.TUNE 4,22
LDC62:  LDB  #$2C
LDC64:  JSR  NWTUNE
LDC67:  RTS

;------------------------------------------------------------------------------
; PMRRP - REBEL THEME WITH REPEATS(TRENCH WITH REPEATS)
;   in ESB: sound command $2C. tunes 23-26 are new music (tune2c_v1 - tune2c_v4), sent by the wave 3 setup
;------------------------------------------------------------------------------
PMRRP:
LDC68:  JSR  PKCUT1                 ;.TUNE 1,23
LDC6B:  LDB  #$2E
LDC6D:  JSR  NWTUNE
LDC70:  JSR  PKCUT2                 ;.TUNE 2,24
LDC73:  LDB  #$30
LDC75:  JSR  NWTUNE
LDC78:  JSR  PKCUT3                 ;.TUNE 3,25
LDC7B:  LDB  #$32
LDC7D:  JSR  NWTUNE
LDC80:  JSR  PKCUT4                 ;.TUNE 4,26
LDC83:  LDB  #$34
LDC85:  JSR  NWTUNE
LDC88:  RTS

;------------------------------------------------------------------------------
; PMTH5 - MAIN THEME (START OF GAME)
;   in ESB: sound command $2E. tunes 27-30 are the Star Wars main theme (theme_v1 - theme_v4), sent by the
;   wave 1 setup
;------------------------------------------------------------------------------
PMTH5:
LDC89:  JSR  PKCUT1                 ;.TUNE 1,27
LDC8C:  LDB  #$36
LDC8E:  JSR  NWTUNE
LDC91:  JSR  PKCUT2                 ;.TUNE 2,28
LDC94:  LDB  #$38
LDC96:  JSR  NWTUNE
LDC99:  JSR  PKCUT3                 ;.TUNE 3,29
LDC9C:  LDB  #$3A
LDC9E:  JSR  NWTUNE
LDCA1:  JSR  PKCUT4                 ;.TUNE 4,30
LDCA4:  LDB  #$3C
LDCA6:  JSR  NWTUNE
LDCA9:  RTS

;------------------------------------------------------------------------------
; PM4TH - BATTLE MUSIC IN FOURTHS
;   in ESB: sound command $31. tunes 31-34 are new music (tune31_v1 - tune31_v4), sent when the initials entry
;   starts
;------------------------------------------------------------------------------
PM4TH:
LDCAA:  JSR  PKCUT1                 ;.TUNE 1,31
LDCAD:  LDB  #$3E
LDCAF:  JSR  NWTUNE
LDCB2:  JSR  PKCUT2                 ;.TUNE 2,32
LDCB5:  LDB  #$40
LDCB7:  JSR  NWTUNE
LDCBA:  JSR  PKCUT3                 ;.TUNE 3,33
LDCBD:  LDB  #$42
LDCBF:  JSR  NWTUNE
LDCC2:  JSR  PKCUT4                 ;.TUNE 4,34
LDCC5:  LDB  #$44
LDCC7:  JSR  NWTUNE
LDCCA:  RTS

;------------------------------------------------------------------------------
; PMTHB - THEME TYPE B
;   in ESB: sound command $29. tunes 35-38 are new music (tune29_v1 - tune29_v4), sent by the asteroid wave's
;   setup
;------------------------------------------------------------------------------
PMTHB:
LDCCB:  JSR  PKCUT1                 ;.TUNE 1,35
LDCCE:  LDB  #$46
LDCD0:  JSR  NWTUNE
LDCD3:  JSR  PKCUT2                 ;.TUNE 2,36
LDCD6:  LDB  #$48
LDCD8:  JSR  NWTUNE
LDCDB:  JSR  PKCUT3                 ;.TUNE 3,37
LDCDE:  LDB  #$4A
LDCE0:  JSR  NWTUNE
LDCE3:  JSR  PKCUT4                 ;.TUNE 4,38
LDCE6:  LDB  #$4C
LDCE8:  JSR  NWTUNE
LDCEB:  RTS

;------------------------------------------------------------------------------
; PMDES - DESCENT TO DETH STAR
;   in ESB: sound command $30. tunes 39-42 are new music (tune30_v1 - tune30_v4), sent when the game ends
;------------------------------------------------------------------------------
PMDES:
LDCEC:  JSR  PKCUT1                 ;.TUNE 1,39
LDCEF:  LDB  #$4E
LDCF1:  JSR  NWTUNE
LDCF4:  JSR  PKCUT2                 ;.TUNE 2,40
LDCF7:  LDB  #$50
LDCF9:  JSR  NWTUNE
LDCFC:  JSR  PKCUT3                 ;.TUNE 3,41
LDCFF:  LDB  #$52
LDD01:  JSR  NWTUNE
LDD04:  JSR  PKCUT4                 ;.TUNE 4,42
LDD07:  LDB  #$54
LDD09:  JSR  NWTUNE
LDD0C:  RTS

;------------------------------------------------------------------------------
; PMDAR - LORD VADER'S THEME
;   in ESB: sound command $2F. tunes 43-46 are the Imperial March's rhythm figure looped 20 to 23 times
;   (vamp_v1 - vamp_v4), sent by the launch sequence
;------------------------------------------------------------------------------
PMDAR:
LDD0D:  JSR  PKCUT1                 ;.TUNE 1,43
LDD10:  LDB  #$56
LDD12:  JSR  NWTUNE
LDD15:  JSR  PKCUT2                 ;.TUNE 2,44
LDD18:  LDB  #$58
LDD1A:  JSR  NWTUNE
LDD1D:  JSR  PKCUT3                 ;.TUNE 3,45
LDD20:  LDB  #$5A
LDD22:  JSR  NWTUNE
LDD25:  JSR  PKCUT4                 ;.TUNE 4,46
LDD28:  LDB  #$5C
LDD2A:  JSR  NWTUNE
LDD2D:  RTS

;------------------------------------------------------------------------------
; ISND - RPM POKEY INITIALIZATION
;   ISND
;   SUB. TO INITIALIZE POKEY FOR USE
;------------------------------------------------------------------------------
ISND:
LDD2E:  LDA  #$00                   ;SET UP FOR POKEY VOICE 1
LDD30:  STA  PKI1                   ;ALSO, INIT POKEY DEVICES
LDD33:  STA  PKI2
LDD36:  STA  DREF                   ;CLEAR DYN. RECON. FLAG
LDD38:  JSR  PKCUT1                 ;.IRPC VNUM,<12345678>
LDD3B:  JSR  PKCUT2
LDD3E:  JSR  PKCUT3
LDD41:  JSR  PKCUT4
LDD44:  JSR  PKCUT5
LDD47:  JSR  PKCUT6
LDD4A:  JSR  PKCUT7
LDD4D:  JSR  PKCUT8
LDD50:  LDA  #$03
LDD52:  STA  PKI1                   ;OUTPUT SECOND BYTE TO POKEY INIT.
LDD55:  STA  PKI2
LDD58:  LDA  #$78                   ;VOICES 3 AND 4 ARE 16 BIT EACH
LDD5A:  STA  PKC1
LDD5D:  LDA  #$78
LDD5F:  STA  PKC2                   ;TIE CHANNEL 2 TO 1, 4 TO 3
LDD62:  RTS

;------------------------------------------------------------------------------
; RCS - RCS,RCN
;   SET OR RESET DYNAMIC RECONFIGURATION FLAG AND INIT ALL VOICES
;------------------------------------------------------------------------------
RCS:
LDD63:  LDA  #$00                   ;ALL CHANNELS SEPERATE
LDD65:  STA  PKC1
LDD68:  STA  PKC2
LDD6B:  LDA  #$01                   ;SET FLAG THAT ARE ALL 8-BIT VOICES NOW
LDD6D:  BNE  RECON

RCN:
LDD6F:  LDA  #$78                   ;VOICES 3 AND 4 ARE 16 BIT EACH
LDD71:  STA  PKC1
LDD74:  LDA  #$78
LDD76:  STA  PKC2                   ;TIE CHANNEL 2 TO 1, 4 TO 3
LDD79:  CLRA                        ;CLEAR FLAG (NORMAL CONFIGURATION)

RECON:
LDD7A:  STA  DREF                   ;INDICATE CURRENT CONFIGURATION
LDD7C:  BSR  PKCUT1                 ;.IRPC VNUM,<12345678>
LDD7E:  BSR  PKCUT2
LDD80:  BSR  PKCUT3
LDD82:  BSR  PKCUT4
LDD84:  BSR  PKCUT5
LDD86:  BSR  PKCUT6
LDD88:  BSR  PKCUT7
LDD8A:  BSR  PKCUT8
LDD8C:  RTS

;------------------------------------------------------------------------------
; PKCUT1 - [note] Cut (init) POKEY voice 1: A = VCS_1, branch to POKVI; leaves Y-->voice descriptor table
;------------------------------------------------------------------------------
PKCUT1:
LDD8D:  LDA  #VCS_1                 ;.IRPC VNUM,<12345678>
LDD8F:  BRA  POKVI

;------------------------------------------------------------------------------
; PKCUT2 - [note] Cut (init) POKEY voice 2: A = VCS_2, branch to POKVI; leaves Y-->voice descriptor table
;------------------------------------------------------------------------------
PKCUT2:
LDD91:  LDA  #VCS_2
LDD93:  BRA  POKVI

;------------------------------------------------------------------------------
; PKCUT3 - [note] Cut (init) POKEY voice 3: A = VCS_3, branch to POKVI; leaves Y-->voice descriptor table
;------------------------------------------------------------------------------
PKCUT3:
LDD95:  LDA  #VCS_3
LDD97:  BRA  POKVI

;------------------------------------------------------------------------------
; PKCUT4 - [note] Cut (init) POKEY voice 4: A = VCS_4, branch to POKVI; leaves Y-->voice descriptor table
;------------------------------------------------------------------------------
PKCUT4:
LDD99:  LDA  #VCS_4
LDD9B:  BRA  POKVI

;------------------------------------------------------------------------------
; PKCUT5 - [note] Cut (init) POKEY voice 5: A = VCS_5, branch to POKVI; leaves Y-->voice descriptor table
;------------------------------------------------------------------------------
PKCUT5:
LDD9D:  LDA  #VCS_5
LDD9F:  BRA  POKVI

;------------------------------------------------------------------------------
; PKCUT6 - [note] Cut (init) POKEY voice 6: A = VCS_6, branch to POKVI; leaves Y-->voice descriptor table
;------------------------------------------------------------------------------
PKCUT6:
LDDA1:  LDA  #VCS_6
LDDA3:  BRA  POKVI

;------------------------------------------------------------------------------
; PKCUT7 - [note] Cut (init) POKEY voice 7: A = VCS_7, branch to POKVI; leaves Y-->voice descriptor table
;------------------------------------------------------------------------------
PKCUT7:
LDDA5:  LDA  #VCS_7
LDDA7:  BRA  POKVI

;------------------------------------------------------------------------------
; PKCUT8 - [note] Cut (init) POKEY voice 8: A = VCS_8, branch to POKVI; leaves Y-->voice descriptor table
;------------------------------------------------------------------------------
PKCUT8:
LDDA9:  LDA  #VCS_8
LDDAB:  BRA  POKVI

;------------------------------------------------------------------------------
; POKVI - POKVI,Y
;   SUB. TO INIT A POKEY VOICE
;   POKVI:
;   A:=OFFSET INTO VOICE DESCRIPTOR TABLE
;   POKVIY:
;   Y:=POINTER TO THIS VOICE'S DESCRIPTOR TABLE
;------------------------------------------------------------------------------
POKVI:
LDDAD:  LDX  #TVC                   ;BASE OF VOICE
LDDB0:  LEAY A,X                    ;Y-->VOICE DESCRIPTOR TABLE

POKVIY:          ;Y SETUP BY NOW
LDDB2:  LDU  ,Y                     ;U-->VOICE RAM BLOCK
;;; ;NOW IS MAINLINE ROUTINE
;;; ;AVOIDING IRQ INTERACTIONS
LDDB4:  LDA  VCS_BIT,Y              ;BIT FOR THIS VOICE
LDDB6:  COMA                        ;PREPARE TURNOFF MASK
LDDB7:  ANDA VIU
LDDB9:  STA  VIU                    ;TURN OFF VIU BIT
LDDBB:  LDA  #$07
LDDBD:  STA  VVOL,U                 ;SET UP TO MEDIAN VOLUME
LDDBF:  LDA  #$C0                   ;REMEMBER TO PRE-NEGATE
LDDC1:  STA  ORATE,U                ;SET UP TO MED. RATE
LDDC3:  LDA  #$A0                   ;DEFAULT TO PURE TONES
LDDC5:  STA  VAC,U                  ;STORE AS VOICE CONTROL BITS
LDDC7:  LDD  #$0000                 ;CLEARING OUT VARIABLES
LDDCA:  STD  ,U                     ;CLEAR VOICE IN USE FLAG(HI BYTE POINTER)
LDDCC:  STA  OKEY,U                 ;SET BACK TO UNUSED KEY
LDDCE:  STA  VSEQ,U                 ;CLEAR ENV. SEQ. COUNT
LDDD0:  STD  ODUR,U
LDDD2:  STA  VLC,U                  ;CLEAR LOOP COUNT
LDDD5:  STD  OPTSV,U                ;CLEAR SUB-PHRASE POINTER (FLAG)
LDDD8:  STA  VSF,U                  ;CLEAR SYNTH. MODE
LDDDA:  STD  VSA,U                  ;CLEAR SYNTH. MODE ADJUSTMENT
LDDDD:  LDD  FETAB
LDDE0:  STD  APTR,U
LDDE2:  STD  FPTR,U
;TURN OFF POKEY AMPLITUDE
LDDE4:  LDX  VCS_PKF,Y              ;SELECT THE POKEY OUTPUT PORT
LDDE6:  LDB  DREF
LDDE8:  BEQ  POKVIY_62              ;?DYNAMICALLY RECONFIG'D?
LDDEA:  LDX  VCS_PKD,Y              ;THEN USE DRE PORT INSTEAD
LDDEC:  CLR  1,X                    ;ONLY DO LO 8 BITS
LDDEE:  RTS

POKVIY_62:
POKVIY_67:
LDDEF:  CLR  3,X                    ;AMPLITUDE GOES IN SECOND CHANNEL FOR 16 BIT
LDDF1:  RTS

;------------------------------------------------------------------------------
; NWTUNE - NWTUNE
;   SETS UP NEW TUNE INTO GIVEN VOICE
;   MUST BE PRECEEDED BY PKCUT TO CLEAR OUT
;   ANY OLD VOICE AND SETUP Y-->DESCRIPTOR TABLE
;   B:= TUNE # WORD OFFSET INTO TUNE TABLE
;------------------------------------------------------------------------------
NWTUNE:
LDDF2:  LDX  #TUNTAB                ;BASE OF TUNE DIRECTORY
LDDF5:  ABX                         ;ALLOW 128 WORD ENTRIES
LDDF6:  LDD  ,X                     ;POINTER TO TUNE
LDDF8:  LDX  ,Y                     ;X-->VOICE RAM BLOCK
LDDFA:  STD  ,X
LDDFC:  LDA  VIU                    ;SET VOICE IN USE BIT
LDDFE:  ORA  VCS_BIT,Y              ;THATS OUR BIT
LDE00:  STA  VIU
LDE02:  RTS

;------------------------------------------------------------------------------
; PKDR - INTERRUPT ROUTINES, PKDR, POKOUT
;   PKDR
;   POKEY 4MS INTERRUPT DRIVER
;------------------------------------------------------------------------------
PKDR:
LDE03:  LDA  S_INTCT                ;WHICH POKEY TO UPDATE THIS FRAME
LDE05:  LSRA
LDE06:  BCC  PKDR_10                ;IF VOICE 2 THIS FRAME
LDE08:  LDA  #VCS_1
LDE0A:  BSR  POKOUT                 ;OUTPUT TO POKEY (VOICE 1)
LDE0C:  LDA  #VCS_3
LDE0E:  BSR  POKOUT                 ;OUTPUT TO POKEY (VOICE 3)
LDE10:  LDA  #VCS_5                 ;OUTPUT VOICE 5 IF IT EXISTS
LDE12:  BSR  POKOUT
LDE14:  LDA  #VCS_7                 ;OUTPUT VOICE 7 IF IT EXISTS
LDE16:  BSR  POKOUT
LDE18:  RTS

PKDR_10:          ;IF HERE, TIME TO OUTPUT VOICE 2
LDE19:  LDA  #VCS_2
LDE1B:  BSR  POKOUT                 ;OUTPUT TO POKEY (VOICE 2)
LDE1D:  LDA  #VCS_4
LDE1F:  BSR  POKOUT                 ;OUTPUT TO POKEY (VOICE 4 OR 4A)
LDE21:  LDA  #VCS_6                 ;OUTPUT VOICE 6 IF DEFINED
LDE23:  BSR  POKOUT
LDE25:  LDA  #VCS_8                 ;OUTPUT VOICE 8 IF IT EXISTS
LDE27:  BSR  POKOUT
LDE29:  RTS

;------------------------------------------------------------------------------
; POKOUT - POKOUT
;   COMMON OUTPUT ROUTINE FOR ALL POKEY VOICES
;   A:= OFFSET INTO CURRENT VOICE DESCRIPTOR TABLE
;------------------------------------------------------------------------------
POKOUT:
LDE2A:  LDX  #TVC                   ;BASE OF VOICE DESCRIPTOR TABLE
LDE2D:  LEAY A,X                    ;Y--> THIS VOICE'S DESCRIPTOR TABLE
LDE2F:  LDU  ,Y                     ;U--> RAM BLOCK FOR THIS VOICE
LDE31:  LDA  ,U                     ;?VOICE IN USE? (INUSE IF HI POINTER SET)
LDE33:  BNE  POKOUT_3               ;B THEN PROCESS IT
LDE35:  RTS                         ;ELSE, RETURN

;SEE IF TIME TO UPDATE CURRENT NOTE
POKOUT_3:
LDE36:  INC  VSEQ,U                 ;INC. ENVELOPE SEQ. COUNT
LDE38:  BNE  POKOUT_5               ;IF NOT AT END OF ENV. YET
LDE3A:  DEC  VSEQ,U                 ;ELSE, KEEP AT FINAL ENV. COUNT

POKOUT_5:
LDE3C:  LDB  ORATE,U                ;PRE-NEGATED RATE (8 BITS, SIGN IMPLIED)
LDE3E:  LDA  #$FF                   ;EXTEND IMPLIED SIGN
LDE40:  ADDD ODUR,U                 ;BY ADDING NEGATIVE OF CURRENT RATE,
LDE42:  STD  ODUR,U                 ;UPDATE CURRENT NOTE DURATION
LDE44:  LBPL POKSN                  ;B IF STILL SAME NOTE

;------------------------------------------------------------------------------
; POKNL - IF HERE, HAVE A NEW NOTE TO PLAY
;------------------------------------------------------------------------------
POKNL:
LDE48:  LDX  ,U                     ;GET THIS NOTE IN TUNE
LDE4A:  LDB  ,X++                   ;BUMP TO NEXT INSTRUCTION
LDE4C:  STX  ,U
LDE4E:  TSTB                        ;CHECK THE OPCODE(FIRST BYTE)
LDE4F:  LBMI PKFUN                  ;B IF A FUNCTION
LDE53:  BEQ  POKNL_9                ;?SOUNDFUL NOTE?(NOT A REST)
LDE55:  ADDB OKEY,U                 ;THEN POSITION NOTE TO CURRENT KEY

POKNL_9:
LDE57:  LDA  DREF                   ;ELSE NO SPLIT VOICE, BUT HAVE DYN RECONF
LDE59:  BEQ  POKNL_68               ;B IF FULL 16 BIT PORT
LDE5B:  CLRA                        ;ELSE USE 8 BIT VALUE DIRECTLY
LDE5C:  BRA  POKNL_69

POKNL_68:          ;---ELSE IS 16 BIT -- CALC MUSIC NOTE
LDE5E:  LSLB                        ;WORD OFFSET
LDE5F:  LDX  #NOTTAB                ;BASE OF NOTE CONVERSION TABLE
LDE62:  ABX                         ;UNSIGNED, FULL RANGE
LDE63:  LDD  ONOTE,U                ;COMPUTE DELTA BETWEEN NEW AND OLD
LDE65:  SUBD ,X                     ;SUB NEW NOTE VALUE
LDE67:  STD  VSA,U                  ;SAVE DELTA FOR SYNTH MODE
LDE6A:  LDD  ,X                     ;GET NOTE VALUE

POKNL_69:
LDE6C:  STD  ONOTE,U                ;STORE AS OUTPUT NOTE
LDE6E:  LDX  ,U                     ;GET DURATION OF CURRENT NOTE
LDE70:  LDA  -$1,X                  ;(WE PREVIOUSLY BUMPED POINTER TO NEXT NOTE)
LDE72:  BNE  POKNL_30               ;?AT FINAL NOTE?
LDE74:  LDD  OPTSV,U                ;CHECK FOR ENDING SUB-PHRASE OR MAIN TUNE
LDE77:  LBEQ POKVIY                 ;B END OF MAIN TUNE, INIT THIS VOICE
LDE7B:  STD  ,U                     ;IF HERE, RETURNING FROM SUB-PHRASE
LDE7D:  LDD  #$0000
LDE80:  STD  OPTSV,U                ;RESET SUB-PHRASE FLAG
LDE83:  JMP  POKNL                  ;J GET A NOTE GOING

;A:=DURATION (SECOND BYTE)
;X-->FOLLOWING INSTR
POKNL_30:          ;---STILL HAVE A NEW NOTE, GET AND STORE DURATION
LDE86:  CLRB                        ;PREPARE LSB
LDE87:  LSRA                        ;SHIFT AND REMOVE LSB (TIED NOTE FLAG)
LDE88:  LSRA                        ;MULT. DUR * 128 (CARRY IS MSB OF LSB BYTE)
LDE89:  RORB                        ;ROTATE INTO LSB'S
LDE8A:  ADDD ODUR,U                 ;SUBTRACT ANY OVERRUN FROM PREV. NOTE
;SUBD #0FFFF ;(?6502 VERSION)ADD 1 TO COMPENSATE FOR SUBTRACT TEST
LDE8C:  STD  ODUR,U
LDE8E:  LDA  -$1,X                  ;GET BACK DURATION
LDE90:  ANDA #$01                   ;TEST IF NOTE IS TIED
LDE92:  BNE  POKNL_50               ;?NOTE NOT TIED?
LDE94:  STA  VSEQ,U                 ;CLEAR SEQ. COUNTER FOR NOT TIED NOTE
LDE96:  CLRB                        ;AND NO SYNTH ADJUST FOR NOT TIED
LDE97:  STD  VSA,U
LDE9A:  LDA  VIU                    ;TEST IF THIS IS NOT HIGH PRIORITY
LDE9C:  ANDA VCS_PRI,Y              ;IN USE BITS VS PRIORITY MASK
;BEQ PKNOFF ;IF THIS IS HIGH PRIORITY FOR THIS VOICE
LDE9E:  BEQ  POKSN                  ;LET AMPLITUDE ENVELOPE DO PRE-GAP
LDEA0:  LDA  DREF
;BNE PKNOFF
LDEA2:  BNE  POKSN                  ;LET AMPLITUDE ENVELOPE DO PRE-GAP
LDEA4:  RTS                         ;ELSE, DON'T UPDATE POKEY WITH THIS VOICE

POKNL_50:
LDEA5:  LDA  VSF,U                  ;TEST SYNTH MODE FLAG
LDEA7:  BNE  POKSN                  ;B IF SYNTH MODE ON
;NOTE IS TIED AND SYNTH MODE NOT ON, CLEAR FREQ. ADJUSTMENT
LDEA9:  CLRB
LDEAA:  STD  VSA,U                  ;CLEAR SYNTH. ADJUST

POKSN:          ;HAVE SAME NOTE AS LAST TIME, PLAY IT WITH ENVELOPES
LDEAD:  LDA  VIU
LDEAF:  ANDA VCS_PRI,Y              ;IN USE FLAGS VS PRIORITY MASK
LDEB1:  BEQ  POKSN_61               ;IF AT HIGHEST PRIORITY, PLAY NOTE
LDEB3:  LDA  DREF
LDEB5:  BNE  POKSN_61               ;ELSE IF RECONFIGURED, THEN ALL ARE AT BEST PRIORITY
LDEB7:  RTS                         ;ELSE, RETURN WITHOUT POKEY UPDATE

POKSN_61:
LDEB8:  LDA  S_INTCT
LDEBA:  ANDA #$06                   ;?TIME TO CHANGE ADJUST?
LDEBC:  BNE  POKSN_3
LDEBE:  ASR  VSA,U                  ;DIVIDE SYNTH ADJUST BY 2
LDEC1:  ROR  VSA+1,U                ;SO ADD 1/2 AS MUCH EACH TIME

POKSN_3:          ;---FIRST ADD FREQ. ENV. TO NOTE FREQ.
LDEC4:  LDB  VSEQ,U                 ;GET FREQ. ENV. SEQ. #
LDEC6:  LSRB                        ;FOR 128 BYTE TABLE
LDEC7:  LDX  FPTR,U                 ;BASE OF FREQUENCY TABLE
LDEC9:  ABX
LDECA:  LDB  ,X                     ;GET CURRENT FREQ. ENV. SETTING
LDECC:  SEX                         ;CONVERT TO 16 BIT
LDECD:  TST  DREF                   ;MUSIC FREQ IS *8, SOUNDS ARE AS IS.
LDECF:  BNE  POKSN_78               ;B IF RECONFIG'D TO 8 BITS
LDED1:  LSLB                        ;MULT FREQ ENV *8 FOR MUSIC
LDED2:  ROLA
LDED3:  LSLB
LDED4:  ROLA
LDED5:  LSLB
LDED6:  ROLA

POKSN_78:
LDED7:  ADDD ONOTE,U                ;ADD IN THE NOTES FREQUENCY
LDED9:  ADDD VSA,U                  ;ADD SYNTH ADJUST TO SUM OF NOTE FREQ. AND ENV.
LDEDC:  LDX  VCS_PKF,Y              ;SELECT THE POKEY OUTPUT PORT
LDEDE:  TST  DREF
LDEE0:  BEQ  POKSN_62               ;?DYNAMICALLY RECONFIG'D?
LDEE2:  LDX  VCS_PKD,Y              ;THEN USE DRE PORT INSTEAD
LDEE4:  BRA  POKSN_63               ;AND ONLY DO LO 8 BITS

POKSN_62:
LDEE6:  STA  2,X                    ;OUTPUT MSB OF 16 BIT

POKSN_63:
LDEE8:  STB  ,X                     ;OUTPUT LO 8 BIT
LDEEA:  LDD  ONOTE,U                ;CHECK FOR A REST(NO OUTPUT)
LDEEC:  BNE  PKNON                  ;IF NOT A REST

PKNOFF:          ;HAVE A REST OR NOTE IS OFF, SET UP TO FORCE OUTPUT TO OFF
LDEEE:  LDA  #$F0
LDEF0:  STA  FASV                   ;STORE MASK TO ZERO OUT AMPLITUDE
LDEF2:  BRA  PKNC

;------------------------------------------------------------------------------
; PKNON - NOW OUTPUT AMPLITUDE, THIS VOICE
;------------------------------------------------------------------------------
PKNON:
LDEF4:  LDA  #$FF                   ;SET UP MASK TO PERMIT CURRENT VOLUME
LDEF6:  STA  FASV

PKNC:
LDEF8:  LDB  VSEQ,U                 ;;DIVIDE ENV. SEQ # BY 8 (32 BYTE ENV. TABLE)
;USE STRAIGHT, LIMIT AT 31(QUARTER SECOND)
LDEFA:  CMPB #$1F
LDEFC:  BLO  LDF00                  ;IFHS
LDEFE:  LDB  #$1F
LDF00:  LDX  APTR,U
LDF02:  LDA  B,X                    ;GET CURRENT VOLUME ENV. ADJ.
LDF04:  ADDA VVOL,U
LDF06:  BPL  PKNC_5                 ;IF NUM NOT .LT. 0
LDF08:  CLRA                        ;ELSE, SET VOLUME TO OFF

PKNC_5:
LDF09:  CMPA #$10                   ;CHECK FOR VOLUME TOO LARGE
LDF0B:  BLT  LDF0F                  ;IF VOLUME OK
LDF0D:  LDA  #$0F                   ;ELSE, SET TO MAX.
LDF0F:  LDB  SP_DLY                 ;ESB: while the speech routine is talking or in a pause
LDF11:  ORB  SP_STA
LDF13:  BEQ  PKNC_6
LDF15:  LSRA                        ;the music plays at half volume

PKNC_6:
LDF16:  ORA  VAC,U                  ;SET UP CURRENT VOICE CONTROL
LDF18:  ANDA FASV                   ;MASK WITH NOTE ON/OFF SETTING
LDF1A:  LDX  VCS_PKF,Y              ;SELECT THE POKEY OUTPUT PORT
LDF1C:  LDB  DREF
LDF1E:  BEQ  PKNC_62                ;?DYNAMICALLY RECONFIG'D?
LDF20:  LDX  VCS_PKD,Y              ;THEN USE DRE PORT INSTEAD
LDF22:  STA  1,X                    ;ONLY DO LO 8 BITS
LDF24:  RTS                         ;EXIT ALL DONE

PKNC_62:
PKNC_67:
LDF25:  STA  3,X                    ;AMPLITUDE GOES IN SECOND CHANNEL FOR 16 BIT
LDF27:  RTS                         ;EXIT ALL DONE

;------------------------------------------------------------------------------
; PKFUN - HAVE A FUNCTION, NOT A NOTE..
;   B:= OPCODE
;------------------------------------------------------------------------------
PKFUN:
LDF28:  LDX  ,U
LDF2A:  LDA  -$1,X                  ;A:= DATA VALUE
LDF2C:  LSLB
LDF2D:  CMPB #PKDTZ-PKDT
LDF2F:  LBHS POKNL                  ;NULL OUT IF NOT IN RANGE
LDF33:  LDX  #PKDT                  ;DISPATCH BASE
LDF36:  JMP  [B,X]                  ;GOTO ROUTINE

PKDT:          ;DISPATCH TABLE
LDF38:  .word PKARAT, PKCRAT
LDF3C:  .word PKAAMP, PKCAMP
LDF40:  .word PKAKEY, PKCKEY
LDF44:  .word PKFRQE
LDF46:  .word PKAMPE
LDF48:  .word POKNL, POKNL
LDF4C:  .word PKCON, PKPKC
LDF50:  .word PKSYN
LDF52:  .word PKCPH
LDF54:  .word PKSL, PKEL
LDF58:  .word PKGOSB, PKRET

;------------------------------------------------------------------------------
; PKAMPE - HAVE AN AMPLITUDE ENV. FUNCTION
;   (also: PKAMPE)
;------------------------------------------------------------------------------
PKAMPE:
PKDTZ:
LDF5C:  LSLA                        ;WORD POINTER
LDF5D:  TFR  A,B                    ;PREPARE FOR UNSIGNED 256 LENGTH ADD
LDF5F:  LDX  #AETAB                 ;BASE OF AMPLITUDE DIRECTORY
LDF62:  ABX
LDF63:  LDD  ,X                     ;GET AMP POINTER
LDF65:  STD  APTR,U
LDF67:  JMP  POKNL

;------------------------------------------------------------------------------
; PKFRQE - HAVE A FREQ. FUNCITON
;------------------------------------------------------------------------------
PKFRQE:
LDF6A:  LSLA                        ;WORD POINTER
LDF6B:  TFR  A,B                    ;PREPARE FOR 256 LENGTH UNSIGNED ADD
LDF6D:  LDX  #FETAB                 ;BASE OF FREQUENCY TABLE
LDF70:  ABX
LDF71:  LDD  ,X                     ;GET FREQ POINTER
LDF73:  STD  FPTR,U
LDF75:  JMP  POKNL                  ;NEXT INSTRUCTION PLEASE

;------------------------------------------------------------------------------
; PKCRAT - HAVE A RATE FUNCTION
;------------------------------------------------------------------------------
PKCRAT:
LDF78:  SUBA ORATE,U                ;IF CHANGE RATE, ADD NEW(POSITIVE) TO OLD(NEGATIVE

;------------------------------------------------------------------------------
; PKARAT - [note] Tune function (PKDT entry 0), have a new rate: ORATE = -A (stored pre-negated), then POKNL.
;   PKCRAT (change rate) falls into this. A = data value, U-->voice RAM block
;------------------------------------------------------------------------------
PKARAT:
LDF7A:  NEGA                        ;FORM NEGATIVE, 8 BIT VALUE, 9 BIT IMPLIED NEGATIVE
LDF7B:  STA  ORATE,U                ;IF NEW RATE, STORE DESIRED VALUE
LDF7D:  JMP  POKNL

;------------------------------------------------------------------------------
; PKCAMP - HAVE A NEW MEDIAN AMPLITUDE
;------------------------------------------------------------------------------
PKCAMP:
LDF80:  ADDA VVOL,U                 ;IF CHANGE AMPLITUDE, ADD NEW TO OLD

;------------------------------------------------------------------------------
; PKAAMP - [note] Tune function (PKDT entry 2), have a new median amplitude: VVOL = A, then POKNL.
;   PKCAMP (change amplitude) falls into this. A = data value, U-->voice RAM block
;------------------------------------------------------------------------------
PKAAMP:
LDF82:  STA  VVOL,U                 ;IF NEW AMPLITUDE, STORE DESIRED VALUE
LDF84:  JMP  POKNL

;------------------------------------------------------------------------------
; PKCKEY - HAVE A NEW KEY OFFSET
;------------------------------------------------------------------------------
PKCKEY:
LDF87:  ADDA OKEY,U                 ;IF CHANGE KEY, ADD NEW TO OLD

;------------------------------------------------------------------------------
; PKAKEY - [note] Tune function (PKDT entry 4), have a new key offset: OKEY = A, then POKNL.
;   PKCKEY (change key) falls into this. A = data value, U-->voice RAM block
;------------------------------------------------------------------------------
PKAKEY:
LDF89:  STA  OKEY,U                 ;IF NEW KEY, SET DESIRED VALUE
LDF8B:  JMP  POKNL

;------------------------------------------------------------------------------
; PKCON - HAVE NEW VOICE CONTROL BITS
;------------------------------------------------------------------------------
PKCON:
LDF8E:  STA  VAC,U                  ;STORE INTO VOICE CONTROL BITS
LDF90:  JMP  POKNL

;------------------------------------------------------------------------------
; PKPKC - WANT TO SET UP NEW POKEY CONTROL BITS (FOR POKEY 1)
;------------------------------------------------------------------------------
PKPKC:
LDF93:  STA  PKC1                   ;STORE INTO POKEY 1
LDF96:  JMP  POKNL

;------------------------------------------------------------------------------
; PKSYN - WANT TO SET OR RESET SYNTH MODE
;------------------------------------------------------------------------------
PKSYN:
LDF99:  STA  VSF,U                  ;STORE INTO SYNTH. FLAG
LDF9B:  JMP  POKNL

;------------------------------------------------------------------------------
; PKCPH - WANT TO CALL A SUB-PHRASE
;------------------------------------------------------------------------------
PKCPH:
LDF9E:  LSLA                        ;WORD POINTER
LDF9F:  TFR  A,B                    ;PREPARE FOR 256 BYTE TABLE
LDFA1:  LDX  #TUNTAB                ;BASE OF DIRECTORY
LDFA4:  ABX
LDFA5:  LDD  ,U
LDFA7:  STD  OPTSV,U                ;SAVE CURRENT PC
LDFAA:  LDD  ,X                     ;GET NEW SUBTUNE
LDFAC:  STD  ,U
LDFAE:  JMP  POKNL

;------------------------------------------------------------------------------
; PKSL - WANT TO START A PHRASE LOOP
;------------------------------------------------------------------------------
PKSL:
LDFB1:  STA  VLC,U                  ;SAVE LOOP COUNT FOR THIS PHRASE
LDFB4:  LDD  ,U                     ;GET CURRENT PC
LDFB6:  STD  OPTLL,U                ;AND SAVE IT
LDFB9:  JMP  POKNL

;------------------------------------------------------------------------------
; PKEL - WANT TO END A PHRASE LOOP
;------------------------------------------------------------------------------
PKEL:
LDFBC:  DEC  VLC,U                  ;CHECK FOR DONE WITH LOOP
LDFBF:  LBEQ POKNL                  ;B IF DONE WITH LOOP, CONTINUE FROM HERE
;ARE NOT DONE YET WITH LOOP, REINSTATE ADDRESSES OF LOOP START
LDFC3:  LDD  OPTLL,U
LDFC6:  STD  ,U
LDFC8:  JMP  POKNL

;------------------------------------------------------------------------------
; PKGOSB - [note] Tune function, gosub to a subphrase: save the address past this 3 byte instruction in OPTRET, load
;   OPTR from the instruction's last two bytes, then POKNL. U-->voice RAM block
;------------------------------------------------------------------------------
PKGOSB:
LDFCB:  LDX  ,U                     ;LOAD CURRENT PC
LDFCD:  LEAX 1,X                    ;BUMP PAST THE 3 BYTE INSTRUCTION
LDFCF:  STX  OPTRET,U               ;SAVE IT IN RETURN POINTER
LDFD2:  LDD  -$2,X                  ;GET CURRENT ADDRESS TO JUMP TO (SUBPHRASE)
LDFD4:  STD  ,U                     ;PUT IN OLD POINTER
LDFD6:  JMP  POKNL

;------------------------------------------------------------------------------
; PKRET - [note] Tune function, return from gosub: OPTR = OPTRET, then POKNL. U-->voice RAM block
;------------------------------------------------------------------------------
PKRET:
LDFD9:  LDD  OPTRET,U
LDFDC:  STD  ,U
LDFDE:  JMP  POKNL

;.SBTTL RPM NOTE TABLE (FOR 1.512 MHZ CLOCK)
NOTTAB:
LDFE1:  .word $0000                 ;REST
LDFE3:  .word $B493                 ;46227 --OCTAVE 0 ;C 16.3516 HZ
LDFE5:  .word $AA70                 ;43632.1 -- ;C# 17.3239 HZ
LDFE7:  .word $A0DF                 ;41182.8 -- ;D 18.354 HZ
LDFE9:  .word $97D7                 ;38871 -- ;D# 19.4454 HZ
LDFEB:  .word $8F51                 ;36689 -- ;E 20.6017 HZ
LDFED:  .word $8745                 ;34629.4 -- ;F 21.8268 HZ
LDFEF:  .word $7FAD                 ;32685.4 -- ;F# 23.1246 HZ
LDFF1:  .word $7882                 ;30850.5 -- ;G 24.4997 HZ
LDFF3:  .word $71BF                 ;29118.6 -- ;G# 25.9565 HZ
LDFF5:  .word $6B5C                 ;27483.9 -- ;A 27.5 HZ
LDFF7:  .word $6555                 ;25941 -- ;A# 29.1352 HZ
LDFF9:  .word $5FA5                 ;24484.6 -- ;B 30.8677 HZ
LDFFB:  .word $5A46                 ;23110 --OCTAVE 1 ;C 32.7032 HZ
LDFFD:  .word $5535                 ;21812.6 -- ;C# 34.6478 HZ
LDFFF:  .word $506C                 ;20587.9 -- ;D 36.7081 HZ
LE001:  .word $4BE8                 ;19432 -- ;D# 38.8909 HZ
LE003:  .word $47A5                 ;18341 -- ;E 41.2034 HZ
LE005:  .word $439F                 ;17311.2 -- ;F 43.6535 HZ
LE007:  .word $3FD3                 ;16339.2 -- ;F# 46.2493 HZ
LE009:  .word $3C3E                 ;15421.8 -- ;G 48.9994 HZ
LE00B:  .word $38DC                 ;14555.8 -- ;G# 51.9131 HZ
LE00D:  .word $35AA                 ;13738.5 -- ;A 55 HZ
LE00F:  .word $32A7                 ;12967 -- ;A# 58.2705 HZ
LE011:  .word $2FCF                 ;12238.8 -- ;B 61.7354 HZ
LE013:  .word $2D20                 ;11551.5 --OCTAVE 2 ;C 65.4064 HZ
LE015:  .word $2A97                 ;10902.8 -- ;C# 69.2956 HZ
LE017:  .word $2832                 ;10290.5 -- ;D 73.4162 HZ
LE019:  .word $25F1                 ;9712.5 -- ;D# 77.7817 HZ
LE01B:  .word $23CF                 ;9166.99 -- ;E 82.4069 HZ
LE01D:  .word $21CC                 ;8652.09 -- ;F 87.3071 HZ
LE01F:  .word $1FE6                 ;8166.1 -- ;F# 92.4986 HZ
LE021:  .word $1E1B                 ;7707.38 -- ;G 97.9989 HZ
LE023:  .word $1C6A                 ;7274.4 -- ;G# 103.826 HZ
LE025:  .word $1AD2                 ;6865.73 -- ;A 110 HZ
LE027:  .word $1950                 ;6479.99 -- ;A# 116.541 HZ
LE029:  .word $17E4                 ;6115.9 -- ;B 123.471 HZ
LE02B:  .word $168C                 ;5772.25 --OCTAVE 3 ;C 130.813 HZ
LE02D:  .word $1548                 ;5447.89 -- ;C# 138.591 HZ
LE02F:  .word $1416                 ;5141.73 -- ;D 146.832 HZ
LE031:  .word $12F5                 ;4852.75 -- ;D# 155.563 HZ
LE033:  .word $11E4                 ;4580 -- ;E 164.814 HZ
LE035:  .word $10E3                 ;4322.55 -- ;F 174.614 HZ
LE037:  .word $0FF0                 ;4079.55 -- ;F# 184.997 HZ
LE039:  .word $0F0A                 ;3850.19 -- ;G 195.998 HZ
LE03B:  .word $0E32                 ;3633.7 -- ;G# 207.652 HZ
LE03D:  .word $0D65                 ;3429.36 -- ;A 220 HZ
LE03F:  .word $0CA4                 ;3236.5 -- ;A# 233.082 HZ
LE041:  .word $0BEE                 ;3054.45 -- ;B 246.942 HZ
LE043:  .word $0B43                 ;2882.63 --OCTAVE 4 ;C 261.626 HZ
LE045:  .word $0AA0                 ;2720.44 -- ;C# 277.183 HZ
LE047:  .word $0A07                 ;2567.36 -- ;D 293.665 HZ
LE049:  .word $0977                 ;2422.88 -- ;D# 311.127 HZ
LE04B:  .word $08EE                 ;2286.5 -- ;E 329.628 HZ
LE04D:  .word $086E                 ;2157.77 -- ;F 349.228 HZ
LE04F:  .word $07F4                 ;2036.27 -- ;F# 369.994 HZ
LE051:  .word $0782                 ;1921.59 -- ;G 391.995 HZ
LE053:  .word $0715                 ;1813.35 -- ;G# 415.305 HZ
LE055:  .word $06AF                 ;1711.18 -- ;A 440 HZ
LE057:  .word $064F                 ;1614.75 -- ;A# 466.164 HZ
LE059:  .word $05F4                 ;1523.73 -- ;B 493.883 HZ
LE05B:  .word $059E                 ;1437.81 --OCTAVE 5 ;C (MIDDLE C) 523.251 HZ
LE05D:  .word $054D                 ;1356.72 -- ;C# 554.365 HZ
LE05F:  .word $0500                 ;1280.18 -- ;D 587.33 HZ
LE061:  .word $04B8                 ;1207.94 -- ;D# 622.254 HZ
LE063:  .word $0474                 ;1139.75 -- ;E 659.255 HZ
LE065:  .word $0433                 ;1075.39 -- ;F 698.457 HZ
LE067:  .word $03F7                 ;1014.64 -- ;F# 739.989 HZ
LE069:  .word $03BD                 ;957.297 -- ;G 783.991 HZ
LE06B:  .word $0387                 ;903.175 -- ;G# 830.609 HZ
LE06D:  .word $0354                 ;852.091 -- ;A 880 HZ
LE06F:  .word $0324                 ;803.874 -- ;A# 932.328 HZ
LE071:  .word $02F6                 ;758.363 -- ;B 987.766 HZ
LE073:  .word $02CB                 ;715.406 --OCTAVE 6 ;C 1046.5 HZ
LE075:  .word $02A3                 ;674.861 -- ;C# 1108.73 HZ
LE077:  .word $027D                 ;636.591 -- ;D 1174.66 HZ
LE079:  .word $0258                 ;600.469 -- ;D# 1244.51 HZ
LE07B:  .word $0236                 ;566.374 -- ;E 1318.51 HZ
LE07D:  .word $0216                 ;534.193 -- ;F 1396.91 HZ
LE07F:  .word $01F8                 ;503.818 -- ;F# 1479.98 HZ
LE081:  .word $01DB                 ;475.148 -- ;G 1567.98 HZ
LE083:  .word $01C0                 ;448.088 -- ;G# 1661.22 HZ
LE085:  .word $01A7                 ;422.545 -- ;A 1760 HZ
LE087:  .word $018E                 ;398.437 -- ;A# 1864.65 HZ
LE089:  .word $0178                 ;375.681 -- ;B 1975.53 HZ
LE08B:  .word $0162                 ;354.203 --OCTAVE 7 ;C 2093 HZ
LE08D:  .word $014E                 ;333.931 -- ;C# 2217.46 HZ
LE08F:  .word $013B                 ;314.796 -- ;D 2349.32 HZ
LE091:  .word $0129                 ;296.735 -- ;D# 2489.02 HZ
LE093:  .word $0118                 ;279.687 -- ;E 2637.02 HZ
LE095:  .word $0108                 ;263.597 -- ;F 2793.83 HZ
LE097:  .word $00F8                 ;248.409 -- ;F# 2959.96 HZ
LE099:  .word $00EA                 ;234.074 -- ;G 3135.96 HZ
LE09B:  .word $00DD                 ;220.544 -- ;G# 3322.44 HZ
LE09D:  .word $00D0                 ;207.773 -- ;A 3520 HZ
LE09F:  .word $00C4                 ;195.719 -- ;A# 3729.31 HZ
LE0A1:  .word $00B8                 ;184.341 -- ;B 3951.07 HZ
LE0A3:  .word $00AE                 ;173.602 --OCTAVE 8 ;C 4186.01 HZ

;.SBTTL RPM ENVELOPE TABLES
;FREQ. ENV. TABLE
FETAB:
LE0A5:  .word NULENV                ;NULL ENVELOPE
LE0A7:  .word GLOCK                 ;GLOCK (ACTUALLY OFFSET BY 1)
LE0A9:  .word fenv_plus1            ;frequency envelope 2, which Star Wars does not have: the table of +1 steps after GLOCK

;AMPLITUDE ENV. TABLE
AETAB:
LE0AB:  .word NULENV                ;NULL ENVELOPE
LE0AD:  .word aenv_decay            ;amplitude envelopes 1, 2 and 3: the table at $E1B3, EHARD and QKRIZE. Star Wars's fifth entry (TIES) is gone
LE0AF:  .word EHARD
LE0B1:  .word QKRIZE

;FREQUENCY ENVELOPES
;.BYTE 1,1,1,1,0FF,0FF,0FF,0FF
;.BYTE 1,1,1,1,0FF,0FF,0FF,0FF
;.BYTE 1,1,1,1,0FF,0FF,0FF,0FF
;.BYTE 1,1,1,1,0FF,0FF,0FF,0FF
;.BYTE 1,1,1,1,0FF,0FF,0FF,0FF
;.BYTE 1,1,1,1,0FF,0FF,0FF,0FF
;.BYTE 1,1,1,1,0FF,0FF,0FF,0FF
GLOCK:          ;.BYTE 1,1,1,1,0FF,0FF,0FF,0FF
LE0B3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE0BB:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE0C3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE0CB:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE0D3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE0DB:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE0E3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE0EB:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF

fenv_plus1:
LE0F3:  .byte $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01 ;ROM fill, 64 bytes of $01  not fill: frequency envelope 2, 64 steps of +1. a frequency envelope holds signed steps added to the note's divider (times 8 for the 16 bit music voices), indexed by half the voice's step count VSEQ, so POKSN can read 128 of them: envelope 1 (GLOCK, all -1) runs on into this table and this one into NULENV
LE103:  .byte $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
LE113:  .byte $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
LE123:  .byte $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01

NULENV:
LE133:  .word $0000, $0000, $0000, $0000
LE13B:  .word $0000, $0000, $0000, $0000
LE143:  .word $0000, $0000, $0000, $0000
LE14B:  .word $0000, $0000, $0000, $0000
LE153:  .word $0000, $0000, $0000, $0000
LE15B:  .word $0000, $0000, $0000, $0000
LE163:  .word $0000, $0000, $0000, $0000
LE16B:  .word $0000, $0000, $0000, $0000
LE173:  .word $0000, $0000, $0000, $0000
LE17B:  .word $0000, $0000, $0000, $0000
LE183:  .word $0000, $0000, $0000, $0000
LE18B:  .word $0000, $0000, $0000, $0000
LE193:  .word $0000, $0000, $0000, $0000
LE19B:  .word $0000, $0000, $0000, $0000
LE1A3:  .word $0000, $0000, $0000, $0000
LE1AB:  .word $0000, $0000, $0000, $0000

aenv_decay:
LE1B3:  .byte $0A, $08, $06, $04, $02, $01, $00, $00 ;amplitude envelope 1 (.AENV 1), where Star Wars has SDRUM: 32 signed bytes added to the voice's volume VVOL, one for each update of the voice (8 ms) from the start of an untied note, the last one held. this one starts at +10 and falls to -4
LE1BB:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE1C3:  .byte $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE
LE1CB:  .byte $FD, $FD, $FD, $FD, $FD, $FD, $FD, $FC

;.BYTE 0,0,0,0,0,0,0,0
;.BYTE 0,0,0,0,0,0,0,0
EHARD:          ;.BYTE 10.,9.,8.,7,6,5,4,3,2,1,0,0,0,0,0,0
LE1D3:  .byte $03, $07, $07, $06, $05, $05, $04, $04 ;amplitude envelope 2 (.AENV 2), 32 bytes: +3, +7, then down to -1
LE1DB:  .byte $04, $04, $03, $03, $03, $03, $03, $03
LE1E3:  .byte $02, $02, $02, $02, $02, $02, $01, $01
LE1EB:  .byte $01, $01, $01, $01, $00, $00, $00, $FF

;.BYTE 5,5,4,4,3,3,3,3
;.BYTE 2,2,2,2,2,2,1,1
;.BYTE 1,1,1,1,0,0,0,0
QKRIZE:          ;.BYTE 7,7,7,7,7,7,6,6
LE1F3:  .byte $07, $06, $05, $04, $04, $03, $03, $02 ;amplitude envelope 3 (.AENV 3), 32 bytes: +7 falling to -1
LE1FB:  .byte $02, $02, $01, $01, $01, $01, $00, $00
LE203:  .byte $00, $00, $00, $00, $00, $00, $FF, $FF
LE20B:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE213:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ;ROM fill, 1301 bytes of $FF
LE223:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE233:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE243:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE253:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE263:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE273:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE283:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE293:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE2A3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE2B3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE2C3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE2D3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE2E3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE2F3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE303:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE313:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE323:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE333:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE343:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE353:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE363:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE373:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE383:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE393:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE3A3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE3B3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE3C3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE3D3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE3E3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE3F3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE403:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE413:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE423:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE433:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE443:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE453:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE463:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE473:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE483:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE493:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE4A3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE4B3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE4C3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE4D3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE4E3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE4F3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE503:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE513:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE523:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE533:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE543:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE553:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE563:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE573:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE583:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE593:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE5A3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE5B3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE5C3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE5D3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE5E3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE5F3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE603:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE613:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE623:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE633:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE643:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE653:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE663:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE673:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE683:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE693:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE6A3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE6B3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE6C3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE6D3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE6E3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE6F3:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE703:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE713:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LE723:  .byte $FF, $FF, $FF, $FF, $FF
;.SBTTL FILL ROM WITH FF'S
LE728:  .byte $FF, $FF, $FF         ;.REPT 03  FILL WITH FF'S
LE72B:  .byte $43, $4F, $50, $59, $52, $49, $47, $48 ;.ASCII /COPYRIGHT 1983 ATARI/
LE733:  .byte $54, $20, $31, $39, $38, $34, $20, $41
LE73B:  .byte $54, $41, $52, $49

;.SBTTL CHANNEL CONTROL BLOCKS
;RPT,TMR,SND,INC
XL6F:
LE73F:  .byte $01, $02, $06, $00    ;.S 1,2,6,0  XWING LASERS, CHANGE SPIT AT  effect sequences from here to $FA57, the format of all of them: rows of four bytes (Atari's .S) - RPT repeat count, TMR ticks each repeat lasts (a tick is one AUDDO pass, 8 ms), SND the value written to the POKEY register, INC added to it at every repeat - and a zero byte ends a sequence (.SZ). a frequency sequence has no end mark of its own, it runs on into the control sequence after it, and the channel is silent once its control sequence has ended
LE743:  .byte $02, $02, $15, $04    ;.S 2,2,21.,4  BEGINNING
LE747:  .byte $02, $02, $13, $F3    ;.S 2,2,19.,-13.
LE74B:  .byte $01, $02, $11, $00    ;.S 1,2,17.,0
LE74F:  .byte $01, $12, $01, $00    ;.S 1,18.,1,0
LE753:  .byte $15, $02, $09, $01    ;.S 21.,2,9,1
LE757:  .byte $01, $02, $1D, $00    ;.S 1,2,29.,0
LE75B:  .byte $81, $02, $1F, $01    ;.S 81,2,31.,1

XL6C:
LE75F:  .byte $04, $02, $21, $01    ;.S 4,2,21,1
LE763:  .byte $02, $02, $26, $02    ;.S 2,2,26,2
LE767:  .byte $01, $02, $2B, $00    ;.S 1,2,2B,0
LE76B:  .byte $01, $10, $20, $00    ;.S 1,16.,20,0
LE76F:  .byte $01, $06, $2B, $00    ;.S 1,6,2B,0
LE773:  .byte $02, $0A, $2A, $FF    ;.S 2,10.,2A,0FF
LE777:  .byte $02, $0C, $28, $FF    ;.S 2,12.,28,0FF
LE77B:  .byte $01, $0E, $26, $00    ;.S 1,14.,26,0
LE77F:  .byte $01, $10, $25, $00    ;.S 1,16.,25,0
LE783:  .byte $01, $12, $24, $00    ;.S 1,18.,24,0
LE787:  .byte $01, $14, $23, $00    ;.S 1,20.,23,0
LE78B:  .byte $01, $26, $22, $00    ;.S 1,38.,22,0
LE78F:  .byte $01, $32, $21, $00    ;.S 1,50.,21,0

XLZ6C:
XLZ6F:
LE793:  .byte $00                   ;.SZ

XL7F:
LE794:  .byte $01, $12, $1B, $00    ;.S 1,18.,27.,0
LE798:  .byte $02, $02, $15, $04    ;.S 2,2,21.,4
LE79C:  .byte $02, $02, $0C, $05    ;.S 2,2,12.,5
LE7A0:  .byte $01, $02, $00, $00    ;.S 1,2,0,0
LE7A4:  .byte $01, $12, $0A, $00    ;.S 1,18.,10.,0
LE7A8:  .byte $14, $02, $0A, $01    ;.S 20.,2,10.,1
LE7AC:  .byte $01, $02, $1D, $00    ;.S 1,2,29.,0
LE7B0:  .byte $2B, $02, $1F, $01    ;.S 43.,2,31.,1
LE7B4:  .byte $08, $02, $37, $FF    ;.S 8,2,55.,0FF
LE7B8:  .byte $6D, $02, $1F, $01    ;.S 109.,2,31.,1

XL7C:
LE7BC:  .byte $01, $10, $40, $00    ;.S 1,16.,40,0
LE7C0:  .byte $06, $02, $41, $02    ;.S 6,2,41,2
LE7C4:  .byte $01, $12, $40, $00    ;.S 1,18.,40,0
LE7C8:  .byte $03, $08, $8B, $FF    ;.S 3,8,8B,0FF
LE7CC:  .byte $02, $0A, $88, $FF    ;.S 2,10.,88,0FF
LE7D0:  .byte $01, $0C, $86, $00    ;.S 1,12.,86,0
LE7D4:  .byte $01, $0E, $85, $00    ;.S 1,14.,85,0
LE7D8:  .byte $01, $16, $84, $00    ;.S 1,22.,84,0
LE7DC:  .byte $01, $D0, $83, $00    ;.S 1,208.,83,0
LE7E0:  .byte $01, $22, $82, $00    ;.S 1,34.,82,0
LE7E4:  .byte $01, $1C, $81, $00    ;.S 1,28.,81,0

XLZ7C:
XLZ7F:
LE7E8:  .byte $00                   ;.SZ

PB3F:
LE7E9:  .byte $03, $0A, $0C, $01    ;.S 3,10.,12.,1  PASS-BY 1ST CHANNEL
LE7ED:  .byte $02, $08, $0F, $01    ;.S 2,8,15.,1  MAKE GRUNGIER
LE7F1:  .byte $01, $06, $11, $00    ;.S 1,6,17.,0
LE7F5:  .byte $01, $06, $12, $00    ;.S 1,6,18.,0  THIS WAS PM3F,MEDIUM LENGTH PASSBY
LE7F9:  .byte $03, $04, $11, $FF    ;.S 3,4,17.,-1

PS3F:
LE7FD:  .byte $06, $02, $0E, $FF    ;.S 6,2,14.,0FF  SHORT PASSBY
LE801:  .byte $3B, $02, $0A, $01    ;.S 59.,2,10.,1

PB3C:
LE805:  .byte $01, $1A, $81, $00    ;.S 1,26.,81,0  PASSBY
LE809:  .byte $01, $10, $82, $00    ;.S 1,16.,82,0
LE80D:  .byte $01, $06, $83, $00    ;.S 1,6,83,0
LE811:  .byte $01, $04, $84, $00    ;.S 1,4,84,0
LE815:  .byte $01, $06, $85, $00    ;.S 1,6,85,0
LE819:  .byte $02, $04, $86, $01    ;.S 2,4,86,1
LE81D:  .byte $08, $02, $88, $01    ;.S 8,2,88,1
LE821:  .byte $01, $02, $8F, $00    ;.S 1,2,8F,0
LE825:  .byte $01, $04, $8E, $00    ;.S 1,4,8E,0
LE829:  .byte $01, $06, $8D, $00    ;.S 1,6,8D,0
LE82D:  .byte $02, $04, $8C, $FF    ;.S 2,4,8C,-1
LE831:  .byte $02, $06, $8A, $FF    ;.S 2,6,8A,-1
LE835:  .byte $07, $08, $88, $FF    ;.S 7,8,88,0FF
LE839:  .byte $01, $1C, $81, $00    ;.S 1,28.,81,0

PBZ3C:
PBZ3F:
LE83D:  .byte $00                   ;.SZ

PS3C:
LE83E:  .byte $02, $02, $81, $01    ;.S 2,2,81,1  SHORT PASSBY 1ST CHANNEL CONTROL
LE842:  .byte $02, $02, $84, $03    ;.S 2,2,84,3
LE846:  .byte $01, $02, $8B, $00    ;.S 1,2,8B,0
LE84A:  .byte $02, $04, $8F, $FF    ;.S 2,4,8F,0FF
LE84E:  .byte $01, $06, $8D, $00    ;.S 1,6,8D,0
LE852:  .byte $02, $04, $8C, $FF    ;.S 2,4,8C,0FF
LE856:  .byte $02, $06, $8A, $FF    ;.S 2,6,8A,0FF
LE85A:  .byte $07, $08, $88, $FF    ;.S 7,8,88,0FF
LE85E:  .byte $01, $1C, $81, $00    ;.S 1,28.,81,0
LE862:  .byte $00                   ;.SZ

PB4F:
LE863:  .byte $01, $34, $23, $00    ;.S 1,52.,35.,0  PASSBY 2ND CHANNEL FREQ
LE867:  .byte $09, $02, $23, $FF    ;.S 9,2,35.,0FF  THIS WAS PM4F,

;MEDIUM PASSBY 2ND CHANNEL FREQ
PS4F:
LE86B:  .byte $06, $02, $1A, $FF    ;.S 6,2,26.,0FF  SHORT PASSBY 2ND CHANNEL FREQ
LE86F:  .byte $17, $02, $16, $01    ;.S 23.,2,22.,1

PB4C:
LE873:  .byte $01, $34, $C0, $00    ;.S 1,52.,0C0,0
LE877:  .byte $0F, $02, $C1, $01    ;.S 15.,2,0C1,1
LE87B:  .byte $01, $02, $CF, $00    ;.S 1,2,0CF,0
LE87F:  .byte $02, $04, $CE, $FF    ;.S 2,4,0CE,-1
LE883:  .byte $01, $02, $CC, $00    ;.S 1,2,0CC,0
LE887:  .byte $01, $04, $CB, $00    ;.S 1,4,0CB,0
LE88B:  .byte $01, $02, $CA, $00    ;.S 1,2,0CA,0
LE88F:  .byte $01, $04, $C9, $00    ;.S 1,4,0C9,0
LE893:  .byte $01, $02, $C8, $00    ;.S 1,2,0C8,0
LE897:  .byte $01, $04, $C7, $00    ;.S 1,4,0C7,0
LE89B:  .byte $05, $02, $C6, $FF    ;.S 5,2,0C6,0FF
LE89F:  .byte $01, $02, $C2, $00    ;.S 1,2,0C2,0
LE8A3:  .byte $01, $04, $C1, $00    ;.S 1,4,0C1,0

PBZ4C:
PBZ4F:
LE8A7:  .byte $00                   ;.SZ

PS4C:
LE8A8:  .byte $02, $02, $C1, $01    ;.S 2,2,0C1,1  SHORT PASSBY 2ND CHANNEL CONTROL
LE8AC:  .byte $02, $02, $C4, $03    ;.S 2,2,0C4,3
LE8B0:  .byte $01, $02, $CB, $00    ;.S 1,2,0CB,0
LE8B4:  .byte $03, $04, $CF, $FF    ;.S 3,4,0CF,0FF
LE8B8:  .byte $01, $02, $CC, $00    ;.S 1,2,0CC,0
LE8BC:  .byte $01, $04, $CB, $00    ;.S 1,4,0CB,0
LE8C0:  .byte $01, $02, $CA, $00    ;.S 1,2,0CA,0
LE8C4:  .byte $01, $04, $C9, $00    ;.S 1,4,0C9,0
LE8C8:  .byte $01, $02, $C8, $00    ;.S 1,2,0C8,0
LE8CC:  .byte $01, $04, $C7, $00    ;.S 1,4,0C7,0
LE8D0:  .byte $04, $02, $C6, $00    ;.S 4,2,0C6,0
LE8D4:  .byte $02, $04, $C2, $FF    ;.S 2,4,0C2,0FF
LE8D8:  .byte $00                   ;.SZ

;SH4F:
SH6F:
SH8F:
LE8D9:  .byte $01, $38, $03, $00    ;.S 1,56.,3,0  SHIELD

;SH6F: .S 1,56.,1,0
;SH4C:
SH6C:
SH8C:
LE8DD:  .byte $01, $0A, $41, $00    ;.S 1,10.,41,0
LE8E1:  .byte $01, $08, $42, $00    ;.S 1,8,42,0
LE8E5:  .byte $01, $06, $43, $00    ;.S 1,6,43,0
LE8E9:  .byte $01, $04, $44, $00    ;.S 1,4,44,0
LE8ED:  .byte $08, $02, $45, $01    ;.S 8,2,45,1
LE8F1:  .byte $02, $01, $4D, $01    ;.S 2,1,4D,1
LE8F5:  .byte $01, $0A, $4F, $00    ;.S 1,10.,4F,0
LE8F9:  .byte $00                   ;.SZ

PF4F:
LE8FA:  .byte $08, $02, $56, $F8    ;.S 8,2,56,0F8  TOWER PFFFTS

PF4C:
LE8FE:  .byte $03, $02, $81, $01    ;.S 3,2,81,1
LE902:  .byte $02, $02, $86, $04    ;.S 2,2,86,4
LE906:  .byte $03, $02, $8C, $01    ;.S 3,2,8C,1
LE90A:  .byte $00                   ;.SZ

SX5F:
LE90B:  .byte $05, $02, $16, $01    ;.S 5,2,22.,1  SMALL EXPLOSION
LE90F:  .byte $03, $02, $19, $FF    ;.S 3,2,25.,0FF
LE913:  .byte $05, $02, $16, $01    ;.S 5,2,22.,1
LE917:  .byte $03, $02, $19, $FF    ;.S 3,2,25.,0FF
LE91B:  .byte $05, $02, $16, $01    ;.S 5,2,22.,1
LE91F:  .byte $03, $02, $19, $FF    ;.S 3,2,25.,0FF
LE923:  .byte $05, $02, $16, $01    ;.S 5,2,22.,1
LE927:  .byte $03, $02, $19, $FF    ;.S 3,2,25.,0FF
LE92B:  .byte $05, $02, $16, $01    ;.S 5,2,22.,1
LE92F:  .byte $03, $02, $19, $FF    ;.S 3,2,25.,0FF
LE933:  .byte $05, $02, $16, $01    ;.S 5,2,22.,1
LE937:  .byte $03, $02, $19, $FF    ;.S 3,2,25.,0FF
LE93B:  .byte $03, $02, $16, $01    ;.S 3,2,22.,1

SX5C:
LE93F:  .byte $01, $04, $0F, $00    ;.S 1,4,0F,0
LE943:  .byte $01, $06, $00, $00    ;.S 1,6,0,0
LE947:  .byte $03, $0A, $0F, $FF    ;.S 3,10.,0F,0FF
LE94B:  .byte $09, $04, $0C, $FF    ;.S 9,4,0C,0FF
LE94F:  .byte $01, $06, $03, $00    ;.S 1,6,3,0
LE953:  .byte $01, $08, $02, $00    ;.S 1,8,2,0
LE957:  .byte $01, $0C, $01, $00    ;.S 1,12.,1,0
LE95B:  .byte $00                   ;.SZ

df2f:
LE95C:  .byte $02, $90, $47, $00    ;the final explosion's row for channel pair 1: ESB's table uses five channels (pairs 1, 3, 4, 5, 7), each entering this run of rows one row later

DF4F:
LE960:  .byte $02, $90, $49, $00    ;.S 2,144.,73.,0

DF5F:
LE964:  .byte $02, $90, $4B, $00    ;.S 2,144.,75.,0

DF6F:
LE968:  .byte $02, $90, $4C, $00    ;.S 2,144.,76.,0

DF8F:
LE96C:  .byte $02, $90, $4E, $00    ;.S 2,144.,78.,0  DEATH STAR FINAL EXPLOSION

DF1C:
DF2C:
DF3C:
DF4C:
DF5C:
DF6C:
DF7C:
DF8C:
LE970:  .byte $01, $0A, $4F, $00    ;.S 1,10.,4F,0
LE974:  .byte $01, $08, $40, $00    ;.S 1,8,40,0
LE978:  .byte $01, $04, $4F, $00    ;.S 1,4,4F,0
LE97C:  .byte $01, $06, $4E, $00    ;.S 1,6,4E,0
LE980:  .byte $01, $08, $4D, $00    ;.S 1,8,4D,0
LE984:  .byte $01, $0A, $4C, $00    ;.S 1,10.,4C,0
LE988:  .byte $01, $0C, $4B, $00    ;.S 1,12.,4B,0
LE98C:  .byte $01, $0E, $4A, $00    ;.S 1,14.,4A,0
LE990:  .byte $01, $10, $49, $00    ;.S 1,16.,49,0
LE994:  .byte $01, $12, $48, $00    ;.S 1,18.,48,0
LE998:  .byte $01, $14, $47, $00    ;.S 1,20.,47,0
LE99C:  .byte $01, $16, $46, $00    ;.S 1,22.,46,0
LE9A0:  .byte $01, $18, $45, $00    ;.S 1,24.,45,0
LE9A4:  .byte $01, $1A, $44, $00    ;.S 1,26.,44,0
LE9A8:  .byte $01, $1C, $43, $00    ;.S 1,28.,43,0
LE9AC:  .byte $01, $1E, $42, $00    ;.S 1,30.,42,0
LE9B0:  .byte $01, $20, $41, $00    ;.S 1,32.,41,0
LE9B4:  .byte $00                   ;.SZ

CR3F:
CR8F:          ;CRASH INTO BRIDGE OR TOWER
LE9B5:  .byte $01, $5A, $41, $00    ;.S 1,90.,65.,0

CR6F:
LE9B9:  .byte $01, $5A, $3E, $00    ;.S 1,90.,62.,0

CR3C:
CR6C:
CR8C:
LE9BD:  .byte $01, $1A, $4F, $00    ;.S 1,26.,4F,0
LE9C1:  .byte $02, $02, $4E, $FF    ;.S 2,2,4E,0FF
LE9C5:  .byte $09, $04, $4C, $FF    ;.S 9,4,4C,0FF
LE9C9:  .byte $01, $06, $43, $00    ;.S 1,6,43,0
LE9CD:  .byte $01, $08, $42, $00    ;.S 1,8,42,0
LE9D1:  .byte $01, $0A, $41, $00    ;.S 1,10.,41,0
LE9D5:  .byte $00                   ;.SZ

SS8F:
LE9D6:  .byte $01, $0E, $08, $00    ;.S 1,14.,8,0  SHOOTING ENEMY SHOTS

SS8C:
LE9DA:  .byte $01, $02, $41, $00    ;.S 1,2,41,0
LE9DE:  .byte $07, $01, $42, $01    ;.S 7,1,42,1
LE9E2:  .byte $03, $01, $4A, $02    ;.S 3,1,4A,2
LE9E6:  .byte $01, $02, $4F, $00    ;.S 1,2,4F,0
LE9EA:  .byte $00                   ;.SZ

;BLZ1C:
;BLZ1F:
;BLZ2F:
;BLZ2C: .SZ
BL1F:          ;PLAYER'S LASER BLAST
LE9EB:  .byte $32, $01, $37, $04    ;.S 50.,1,55.,4
LE9EF:  .byte $01, $02, $FF, $00    ;.S 1,2,255.,0

bl1c:
LE9F3:  .byte $01, $0C, $A8, $00, $01, $0A, $A7, $00
LE9FB:  .byte $01, $08, $A6, $00, $01, $06, $A5, $00
LEA03:  .byte $01, $04, $A4, $00, $02, $05, $A3, $FF
LEA0B:  .byte $01, $02, $A1, $00    ;.S 1,2,0A1,0
LEA0F:  .byte $00                   ;.SZ

BL2F:
LEA10:  .byte $01, $08, $05, $00    ;.S 1,8,5,0
LEA14:  .byte $2C, $01, $37, $04    ;.S 44.,1,55.,4

bl2c:
LEA18:  .byte $01, $08, $46, $00, $01, $16, $A6, $00
LEA20:  .byte $01, $06, $A5, $00, $01, $04, $A4, $00
LEA28:  .byte $02, $05, $A3, $FF
LEA2C:  .byte $01, $02, $A1, $00    ;.S 1,2,0A1,0
LEA30:  .byte $00                   ;.SZ

PH1F:          ;PORT HOLE SHOT
LEA31:  .byte $05, $01, $23, $01    ;.S 5,1,35.,1
LEA35:  .byte $0D, $01, $2A, $02    ;.S 13.,1,42.,2
LEA39:  .byte $09, $01, $45, $03    ;.S 9,1,69.,3
LEA3D:  .byte $08, $01, $61, $04    ;.S 8,1,97.,4
LEA41:  .byte $04, $01, $83, $05    ;.S 4,1,131.,5
LEA45:  .byte $05, $01, $99, $06    ;.S 5,1,153.,6
LEA49:  .byte $04, $01, $B8, $07    ;.S 4,1,184.,7
LEA4D:  .byte $04, $01, $D5, $09    ;.S 4,1,213.,9

PH2F:
LEA51:  .byte $11, $01, $2D, $02    ;.S 17.,1,45.,2
LEA55:  .byte $0A, $01, $4F, $03    ;.S 10.,1,79.,3
LEA59:  .byte $08, $01, $6E, $04    ;.S 8,1,110.,4
LEA5D:  .byte $05, $01, $90, $05    ;.S 5,1,144.,5
LEA61:  .byte $07, $01, $AA, $06    ;.S 7,1,170.,6
LEA65:  .byte $03, $01, $D7, $07    ;.S 3,1,215.,7
LEA69:  .byte $02, $01, $ED, $08    ;.S 2,1,237.,8

PH3F:
LEA6D:  .byte $04, $01, $33, $01    ;.S 4,1,51.,1
LEA71:  .byte $09, $01, $38, $02    ;.S 9,1,56.,2
LEA75:  .byte $0C, $01, $4B, $03    ;.S 12.,1,75.,3
LEA79:  .byte $07, $01, $6E, $04    ;.S 7,1,110.,4
LEA7D:  .byte $08, $01, $8A, $05    ;.S 8,1,138.,5
LEA81:  .byte $05, $01, $B1, $06    ;.S 5,1,177.,6
LEA85:  .byte $07, $01, $CF, $07    ;.S 7,1,207.,7

PH7F:
LEA89:  .byte $03, $01, $3C, $01    ;.S 3,1,60.,1
LEA8D:  .byte $0A, $01, $40, $02    ;.S 10.,1,64.,2
LEA91:  .byte $0D, $01, $55, $03    ;.S 13.,1,85.,3
LEA95:  .byte $09, $01, $7D, $04    ;.S 9,1,125.,4
LEA99:  .byte $08, $01, $A2, $05    ;.S 8,1,162.,5
LEA9D:  .byte $06, $01, $CB, $06    ;.S 6,1,203.,6
LEAA1:  .byte $03, $01, $F1, $07    ;.S 3,1,241.,7

PH1C:
PH2C:
PH3C:
PH7C:
LEAA5:  .byte $03, $06, $AF, $FF    ;.S 3,6,0AF,0FF
LEAA9:  .byte $03, $06, $AB, $FE    ;.S 3,6,0AB,0FE
LEAAD:  .byte $02, $08, $A4, $FD    ;.S 2,8,0A4,0FD
LEAB1:  .byte $00                   ;.SZ

YEA1F:
LEAB2:  .byte $1E, $01, $51, $FE    ;.S 30.,1,81.,-2  YAY/YEA/YAAAAY/THIS TEST IS GOOD

NAY1F:
LEAB6:  .byte $1E, $01, $A2, $02    ;.S 30.,1,162.,2  NAY/NO WAY JOSE'/FORGET IT/FUCKED UP

NAY1C:
YEA1C:
LEABA:  .byte $01, $1E, $AA, $00    ;.S 1,30.,0AA,0
LEABE:  .byte $00                   ;.SZ

TST1F:          ;TEST CH. 1, POKEY 1
TST5F:
LEABF:  .byte $08, $32, $66, $00    ;.S 8,50.,102.,0

TST1C:
LEAC3:  .byte $01, $28, $AA, $00    ;.S 1,40.,0AA,0
LEAC7:  .byte $00                   ;.SZ

TST2F:
TST6F:
LEAC8:  .byte $08, $32, $5B, $00    ;.S 8,50.,91.,0

TST2C:
LEACC:  .byte $02, $28, $A0, $0A    ;.S 2,40.,0A0,0A
LEAD0:  .byte $00                   ;.SZ

TST3F:
TST7F:
LEAD1:  .byte $08, $32, $51, $00    ;.S 8,50.,81.,0

TST3C:
LEAD5:  .byte $01, $50, $A0, $00    ;.S 1,80.,0A0,0
LEAD9:  .byte $01, $28, $AA, $00    ;.S 1,40.,0AA,0
LEADD:  .byte $00                   ;.SZ

TST4F:
TST8F:
LEADE:  .byte $08, $32, $48, $00    ;.S 8,50.,72.,0

TST4C:
LEAE2:  .byte $01, $78, $A0, $00    ;.S 1,120.,0A0,0
LEAE6:  .byte $01, $28, $AA, $00    ;.S 1,40.,0AA,0
LEAEA:  .byte $00                   ;.SZ

TST5C:
LEAEB:  .byte $01, $A0, $A0, $00    ;.S 1,160.,0A0,0
LEAEF:  .byte $02, $0F, $AA, $F6    ;.S 2,15.,0AA,-0A
LEAF3:  .byte $02, $0F, $AA, $F6    ;.S 2,15.,0AA,-0A
LEAF7:  .byte $00                   ;.SZ

TST6C:
LEAF8:  .byte $01, $DC, $A0, $00    ;.S 1,220.,0A0,0
LEAFC:  .byte $02, $0F, $AA, $F6    ;.S 2,15.,0AA,-0A
LEB00:  .byte $02, $0F, $AA, $F6    ;.S 2,15.,0AA,-0A
LEB04:  .byte $00                   ;.SZ

TST7C:
LEB05:  .byte $02, $8C, $A0, $00    ;.S 2,140.,0A0,0
LEB09:  .byte $02, $0F, $AA, $F6    ;.S 2,15.,0AA,-0A
LEB0D:  .byte $02, $0F, $AA, $F6    ;.S 2,15.,0AA,-0A
LEB11:  .byte $00                   ;.SZ

TST8C:
LEB12:  .byte $02, $AA, $A0, $00    ;.S 2,170.,0A0,0
LEB16:  .byte $02, $0F, $AA, $F6    ;.S 2,15.,0AA,-0A
LEB1A:  .byte $02, $0F, $AA, $F6    ;.S 2,15.,0AA,-0A
LEB1E:  .byte $00                   ;.SZ

fx41_4f:
LEB1F:  .byte $01, $06, $39, $DF, $19, $02, $18, $01 ;from here to $FA57 the sequences of the effects ESB added (commands $41-$51), named by command, channel pair (1-8) and f or c for frequency or control

fx41_4c:
LEB27:  .byte $02, $04, $08, $80, $01, $20, $88, $FF
LEB2F:  .byte $08, $02, $87, $FF, $00

fx41_7f:
LEB34:  .byte $1B, $02, $03, $01

fx41_7c:
LEB38:  .byte $01, $24, $29, $FF, $09, $02, $28, $FF
LEB40:  .byte $00

fx42_1f:
LEB41:  .byte $01, $12, $06, $03, $02, $0E, $09, $FC
LEB49:  .byte $01, $02, $05, $00

fx42_1c:
LEB4D:  .byte $01, $02, $65, $00, $02, $06, $65, $02
LEB55:  .byte $03, $06, $68, $01, $01, $08, $6A, $FF
LEB5D:  .byte $04, $02, $69, $FF, $00

fx43_1f:
LEB62:  .byte $01, $04, $87, $FF, $02, $02, $86, $FF
LEB6A:  .byte $02, $02, $83, $F3, $02, $04, $75, $FE
LEB72:  .byte $01, $04, $6A, $FF, $03, $02, $69, $FF
LEB7A:  .byte $02, $02, $7F, $FF, $03, $02, $7E, $FF
LEB82:  .byte $04, $02, $72, $FF, $01, $04, $64, $FF
LEB8A:  .byte $02, $02, $63, $FF, $02, $08, $77, $F3
LEB92:  .byte $02, $06, $5F, $12, $01, $06, $66, $F4
LEB9A:  .byte $02, $02, $5A, $FF, $02, $02, $59, $13
LEBA2:  .byte $02, $02, $6C, $F5, $02, $02, $61, $F4
LEBAA:  .byte $02, $02, $55, $11, $02, $02, $66, $F3
LEBB2:  .byte $02, $02, $59, $F5, $02, $02, $4E, $11
LEBBA:  .byte $02, $02, $5F, $F5, $02, $02, $54, $F7
LEBC2:  .byte $01, $04, $59, $F5, $02, $02, $4E, $F8
LEBCA:  .byte $02, $02, $46, $0F, $02, $02, $55, $F4
LEBD2:  .byte $02, $04, $40, $11, $02, $02, $46, $F6
LEBDA:  .byte $02, $02, $4E, $F4, $02, $02, $42, $F7
LEBE2:  .byte $03, $02, $49, $F6, $02, $02, $35, $11
LEBEA:  .byte $02, $02, $3B, $F7, $02, $02, $43, $F5
LEBF2:  .byte $02, $02, $2F, $12, $01, $04, $36, $F7
LEBFA:  .byte $02, $02, $2D, $11, $02, $02, $34, $F6
LEC02:  .byte $02, $02, $3C, $F5, $02, $02, $28, $11
LEC0A:  .byte $02, $02, $25, $11, $02, $02, $2B, $F8
LEC12:  .byte $02, $02, $34, $ED, $02, $02, $33, $F5
LEC1A:  .byte $02, $02, $1F, $13, $02, $02, $1D, $14
LEC22:  .byte $02, $02, $25, $F6, $02, $02, $30, $EA
LEC2A:  .byte $02, $02, $2F, $F4, $02, $02, $19, $15
LEC32:  .byte $02, $02, $17, $16, $02, $02, $22, $F4
LEC3A:  .byte $02, $02, $2C, $F5, $02, $02, $15, $16
LEC42:  .byte $02, $02, $20, $F4, $02, $02, $29, $F6
LEC4A:  .byte $02, $02, $13, $15, $02, $02, $1E, $F4
LEC52:  .byte $02, $02, $27, $F6, $02, $02, $11, $15
LEC5A:  .byte $02, $02, $1C, $F4, $03, $02, $25, $F5
LEC62:  .byte $02, $02, $22, $F7, $02, $02, $0D, $13
LEC6A:  .byte $02, $02, $16, $F6

fx43_1c:
LEC6E:  .byte $01, $0A, $A8, $00, $01, $C0, $A8, $FF
LEC76:  .byte $02, $1A, $A7, $FF, $01, $14, $A5, $FF
LEC7E:  .byte $01, $0C, $A4, $FF, $03, $08, $A3, $FF
LEC86:  .byte $00

fx43_2f:
LEC87:  .byte $04, $02, $8B, $FF, $02, $02, $86, $FF
LEC8F:  .byte $02, $02, $83, $F3, $02, $04, $75, $FE
LEC97:  .byte $01, $04, $6A, $FF, $03, $02, $69, $FF
LEC9F:  .byte $02, $02, $7F, $FF, $03, $02, $7E, $FF
LECA7:  .byte $04, $02, $72, $FF, $01, $04, $64, $FF
LECAF:  .byte $02, $02, $63, $FF, $02, $08, $77, $F3
LECB7:  .byte $02, $06, $5F, $12, $01, $06, $66, $F4
LECBF:  .byte $02, $02, $5A, $FF, $02, $02, $59, $13
LECC7:  .byte $02, $02, $6C, $F5, $02, $02, $61, $F4
LECCF:  .byte $02, $02, $55, $11, $02, $02, $66, $F3
LECD7:  .byte $02, $02, $59, $F5, $02, $02, $4E, $11
LECDF:  .byte $02, $02, $5F, $F5, $02, $02, $54, $F7
LECE7:  .byte $01, $04, $59, $F5, $02, $02, $4E, $F8
LECEF:  .byte $02, $02, $46, $0F, $02, $02, $55, $F4
LECF7:  .byte $02, $04, $40, $11, $02, $02, $46, $F6
LECFF:  .byte $02, $02, $4E, $F4, $02, $02, $42, $F7
LED07:  .byte $03, $02, $49, $F6, $02, $02, $35, $11
LED0F:  .byte $02, $02, $3B, $F7, $02, $02, $43, $F5
LED17:  .byte $02, $02, $2F, $12, $01, $04, $36, $F7
LED1F:  .byte $02, $02, $2D, $11, $02, $02, $34, $F6
LED27:  .byte $02, $02, $3C, $F5, $02, $02, $28, $11
LED2F:  .byte $02, $02, $25, $11, $02, $02, $2B, $F8
LED37:  .byte $02, $02, $34, $ED, $02, $02, $33, $F5
LED3F:  .byte $02, $02, $1F, $13, $02, $02, $1D, $14
LED47:  .byte $02, $02, $25, $F6, $02, $02, $30, $EA
LED4F:  .byte $02, $02, $2F, $F4, $02, $02, $19, $15
LED57:  .byte $02, $02, $17, $16, $02, $02, $22, $F4
LED5F:  .byte $02, $02, $2C, $F5, $02, $02, $15, $16
LED67:  .byte $02, $02, $20, $F4, $02, $02, $29, $F6
LED6F:  .byte $02, $02, $13, $15, $02, $02, $1E, $F4
LED77:  .byte $02, $02, $27, $F6, $02, $02, $11, $15
LED7F:  .byte $02, $02, $1C, $F4, $03, $02, $25, $F5
LED87:  .byte $02, $02, $22, $F7, $02, $02, $0D, $13
LED8F:  .byte $02, $02, $16, $F6

fx43_2c:
LED93:  .byte $01, $CE, $A8, $FF, $02, $1A, $A7, $FF
LED9B:  .byte $01, $14, $A5, $FF, $01, $0C, $A4, $FF
LEDA3:  .byte $03, $08, $A3, $FF, $00

fx44_z:
LEDA8:  .byte $00

fx45_1f:
LEDA9:  .byte $01, $3E, $78, $FF, $01, $0E, $77, $FF
LEDB1:  .byte $05, $08, $76, $FF, $02, $02, $72, $FF
LEDB9:  .byte $11, $04, $71, $FF, $02, $04, $5F, $FF
LEDC1:  .byte $03, $04, $5C, $FF, $01, $04, $58, $FF
LEDC9:  .byte $04, $02, $57, $FF, $02, $02, $54, $FF
LEDD1:  .byte $18, $02, $53, $FF, $0A, $02, $3A, $FE
LEDD9:  .byte $24, $02, $24, $FF, $02, $02, $01, $FF
LEDE1:  .byte $01, $1A, $00, $01, $02, $10, $01, $01
LEDE9:  .byte $02, $0A, $02, $01, $02, $14, $03, $01
LEDF1:  .byte $01, $34, $04, $FF, $03, $1A, $03, $01
LEDF9:  .byte $02, $02, $05, $FF, $01, $1C, $04, $01
LEE01:  .byte $01, $0E, $05, $FF, $02, $0C, $04, $FF
LEE09:  .byte $03, $08, $02, $FF, $01, $0A, $00, $00

fx45_1c:
LEE11:  .byte $01, $0A, $8F, $00, $03, $02, $8D, $FF
LEE19:  .byte $02, $02, $8B, $FF, $02, $AA, $8A, $00
LEE21:  .byte $01, $2E, $89, $FF, $03, $10, $88, $FF
LEE29:  .byte $02, $06, $86, $FF, $02, $14, $85, $FF
LEE31:  .byte $02, $22, $84, $FF, $01, $38, $83, $FF
LEE39:  .byte $01, $2E, $82, $FF, $01, $2C, $81, $00
LEE41:  .byte $00

fx45_2f:
LEE42:  .byte $01, $46, $78, $FF, $01, $0E, $77, $FF
LEE4A:  .byte $05, $08, $76, $FF, $02, $02, $72, $FF
LEE52:  .byte $11, $04, $71, $FF, $02, $04, $5F, $FF
LEE5A:  .byte $03, $04, $5C, $FF, $01, $04, $58, $FF
LEE62:  .byte $04, $02, $57, $FF, $02, $02, $54, $FF
LEE6A:  .byte $18, $02, $53, $FF, $0A, $02, $3A, $FE
LEE72:  .byte $24, $02, $24, $FF, $02, $02, $01, $FF
LEE7A:  .byte $01, $3A, $00, $00, $01, $3A, $B9, $00
LEE82:  .byte $01, $E4, $B9, $00

fx45_2c:
LEE86:  .byte $01, $12, $6F, $FE, $03, $02, $6D, $FF
LEE8E:  .byte $02, $02, $8B, $FF, $02, $AA, $8A, $00
LEE96:  .byte $01, $2E, $89, $FF, $02, $14, $88, $05
LEE9E:  .byte $02, $02, $8D, $FF, $02, $06, $8C, $FF
LEEA6:  .byte $02, $02, $8B, $FF, $02, $06, $8A, $FF
LEEAE:  .byte $04, $04, $88, $FF, $02, $02, $85, $FF
LEEB6:  .byte $01, $22, $8F, $FF, $01, $1C, $8E, $FF
LEEBE:  .byte $01, $10, $8D, $FF, $03, $0A, $8C, $FF
LEEC6:  .byte $04, $08, $89, $FF, $02, $06, $85, $FF
LEECE:  .byte $02, $02, $84, $FF, $02, $06, $83, $FF
LEED6:  .byte $02, $04, $82, $FF, $02, $26, $81, $00
LEEDE:  .byte $00

fx47_4f:
LEEDF:  .byte $01, $C8, $78, $00, $01, $C8, $78, $00
LEEE7:  .byte $01, $C8, $78, $00

fx47_4c:
LEEEB:  .byte $01, $08, $81, $00, $02, $08, $81, $01
LEEF3:  .byte $02, $08, $82, $01, $02, $0C, $83, $01
LEEFB:  .byte $02, $08, $84, $01, $02, $0C, $85, $01
LEF03:  .byte $02, $04, $86, $01, $01, $08, $87, $01
LEF0B:  .byte $02, $06, $88, $01, $02, $02, $89, $01
LEF13:  .byte $02, $06, $8A, $01, $02, $04, $8B, $01
LEF1B:  .byte $01, $E8, $8C, $00, $01, $64, $8C, $00
LEF23:  .byte $01, $0E, $8B, $FF, $01, $0C, $8A, $FF
LEF2B:  .byte $03, $0A, $89, $FF, $02, $04, $87, $FF
LEF33:  .byte $02, $04, $86, $FF, $02, $04, $85, $FF
LEF3B:  .byte $02, $02, $84, $FF, $03, $06, $83, $FF
LEF43:  .byte $01, $0A, $81, $00, $00

fx47_5f:
LEF48:  .byte $01, $C8, $86, $00, $01, $C8, $86, $00
LEF50:  .byte $01, $C8, $86, $00

fx47_5c:
LEF54:  .byte $01, $08, $81, $00, $02, $08, $81, $01
LEF5C:  .byte $02, $08, $82, $01, $02, $0C, $83, $01
LEF64:  .byte $02, $08, $84, $01, $02, $0C, $85, $01
LEF6C:  .byte $02, $04, $86, $01, $01, $08, $87, $01
LEF74:  .byte $02, $06, $88, $01, $02, $02, $89, $01
LEF7C:  .byte $02, $06, $8A, $01, $02, $04, $8B, $01
LEF84:  .byte $01, $E8, $8C, $00, $01, $64, $8C, $FF
LEF8C:  .byte $01, $0E, $8B, $FF, $01, $0C, $8A, $FF
LEF94:  .byte $03, $0A, $89, $FF, $02, $04, $87, $FF
LEF9C:  .byte $02, $04, $86, $FF, $02, $04, $85, $FF
LEFA4:  .byte $02, $02, $84, $FF, $03, $06, $83, $FF
LEFAC:  .byte $01, $0A, $81, $00, $00

fx47_6f:
LEFB1:  .byte $01, $C8, $A6, $00, $01, $C8, $A6, $00
LEFB9:  .byte $01, $C8, $A6, $00

fx47_6c:
LEFBD:  .byte $01, $08, $81, $00, $02, $08, $81, $01
LEFC5:  .byte $02, $08, $82, $01, $02, $0C, $83, $01
LEFCD:  .byte $02, $08, $84, $01, $02, $0C, $85, $01
LEFD5:  .byte $02, $04, $86, $01, $01, $08, $87, $01
LEFDD:  .byte $02, $06, $88, $01, $02, $02, $89, $01
LEFE5:  .byte $02, $06, $8A, $01, $02, $04, $8B, $01
LEFED:  .byte $01, $E8, $8C, $00, $01, $64, $8C, $FF
LEFF5:  .byte $01, $0E, $8B, $FF, $01, $0C, $8A, $FF
LEFFD:  .byte $03, $0A, $89, $FF, $02, $04, $87, $FF
LF005:  .byte $02, $04, $86, $FF, $02, $04, $85, $FF
LF00D:  .byte $02, $02, $84, $FF, $03, $06, $83, $FF
LF015:  .byte $01, $0A, $81, $00, $00

fx48_5f:
LF01A:  .byte $02, $0C, $35, $E0, $02, $02, $15, $01
LF022:  .byte $01, $08, $16, $01, $01, $06, $17, $02
LF02A:  .byte $02, $02, $19, $02, $02, $02, $1B, $02
LF032:  .byte $02, $02, $1E, $01, $02, $02, $23, $02
LF03A:  .byte $02, $02, $25, $02, $02, $02, $27, $03
LF042:  .byte $03, $02, $2B, $02, $02, $02, $30, $06
LF04A:  .byte $03, $02, $36, $03, $03, $02, $3C, $03
LF052:  .byte $04, $02, $42, $03, $02, $02, $4B, $04
LF05A:  .byte $02, $02, $4F, $04, $03, $02, $53, $02
LF062:  .byte $05, $02, $5B, $04, $03, $02, $70, $05
LF06A:  .byte $02, $04, $B8, $06, $01, $04, $C5, $07
LF072:  .byte $01, $02, $CC, $00

fx48_5c:
LF076:  .byte $01, $02, $0C, $00, $02, $08, $0C, $FF
LF07E:  .byte $02, $02, $0B, $FF, $02, $0C, $0A, $FF
LF086:  .byte $02, $08, $09, $FF, $02, $12, $08, $FF
LF08E:  .byte $02, $08, $07, $FF, $01, $08, $06, $FF
LF096:  .byte $03, $04, $05, $FF, $01, $06, $03, $00
LF09E:  .byte $00

fx46_4f:
LF09F:  .byte $02, $02, $39, $08, $02, $02, $4C, $ED
LF0A7:  .byte $02, $02, $41, $0B, $02, $02, $39, $08
LF0AF:  .byte $02, $02, $4C, $ED, $02, $02, $41, $0B
LF0B7:  .byte $02, $02, $39, $08, $02, $02, $4C, $ED
LF0BF:  .byte $02, $02, $41, $0B, $02, $02, $39, $08
LF0C7:  .byte $02, $02, $4C, $ED, $02, $02, $41, $0B
LF0CF:  .byte $02, $02, $39, $08, $02, $02, $4C, $ED
LF0D7:  .byte $02, $02, $41, $0B, $02, $02, $39, $08
LF0DF:  .byte $02, $02, $4C, $ED, $02, $02, $41, $0B
LF0E7:  .byte $02, $02, $39, $08, $02, $02, $4C, $ED
LF0EF:  .byte $02, $02, $41, $0B, $02, $02, $39, $08
LF0F7:  .byte $02, $02, $4C, $ED, $02, $02, $41, $0B

fx46_4c:
LF0FF:  .byte $08, $06, $A3, $01, $05, $04, $AB, $01
LF107:  .byte $01, $0A, $AF, $FF, $02, $02, $AE, $01
LF10F:  .byte $01, $0E, $AF, $9E, $00

fx46_7f:
LF114:  .byte $02, $02, $4D, $F6, $02, $02, $3A, $13
LF11C:  .byte $02, $02, $43, $0A, $02, $02, $3A, $09
LF124:  .byte $02, $02, $4D, $ED, $02, $02, $43, $0A
LF12C:  .byte $02, $02, $3A, $09, $02, $02, $4D, $ED
LF134:  .byte $02, $02, $43, $0A, $02, $02, $3A, $09
LF13C:  .byte $02, $02, $4D, $ED, $02, $02, $43, $0A
LF144:  .byte $02, $02, $3A, $09, $02, $02, $4D, $ED
LF14C:  .byte $02, $02, $43, $0A, $02, $02, $3A, $09
LF154:  .byte $02, $02, $4D, $ED, $02, $02, $43, $0A
LF15C:  .byte $02, $02, $3A, $09, $02, $02, $4D, $ED
LF164:  .byte $02, $02, $43, $0A, $02, $02, $3A, $09
LF16C:  .byte $02, $02, $4D, $ED, $02, $02, $43, $0A
LF174:  .byte $02, $02, $3A, $09, $01, $02, $4D, $00

fx46_7c:
LF17C:  .byte $01, $08, $A3, $00, $02, $04, $A3, $01
LF184:  .byte $02, $02, $A4, $01, $02, $04, $A5, $01
LF18C:  .byte $02, $02, $A6, $01, $02, $04, $A7, $01
LF194:  .byte $02, $02, $A8, $01, $02, $04, $A9, $01
LF19C:  .byte $02, $02, $AA, $01, $02, $02, $AB, $01
LF1A4:  .byte $02, $02, $AC, $01, $02, $02, $AD, $01
LF1AC:  .byte $02, $02, $AE, $01, $01, $1E, $AF, $00
LF1B4:  .byte $00

fx49_2f:
LF1B5:  .byte $01, $72, $06, $FA

fx49_2c:
LF1B9:  .byte $01, $0E, $41, $00, $02, $04, $41, $01
LF1C1:  .byte $02, $08, $42, $01, $04, $02, $44, $01
LF1C9:  .byte $02, $02, $47, $01, $02, $02, $48, $01
LF1D1:  .byte $02, $04, $49, $01, $02, $02, $4A, $FF
LF1D9:  .byte $05, $04, $49, $FF, $02, $02, $44, $FF
LF1E1:  .byte $02, $06, $43, $FF, $02, $02, $42, $FF
LF1E9:  .byte $01, $08, $41, $00, $00

fx49_5f:
LF1EE:  .byte $01, $06, $04, $00, $02, $04, $04, $FF
LF1F6:  .byte $01, $24, $03, $FF, $03, $12, $02, $FF

fx49_5c:
LF1FE:  .byte $05, $04, $81, $01, $02, $02, $85, $01
LF206:  .byte $01, $12, $86, $FF, $01, $0E, $85, $FF
LF20E:  .byte $03, $08, $84, $FF, $02, $08, $82, $FF
LF216:  .byte $01, $06, $81, $00, $00

fx4a_3f:
LF21B:  .byte $01, $72, $6B, $C5, $05, $02, $30, $FE
LF223:  .byte $24, $02, $24, $FF, $02, $02, $01, $FF
LF22B:  .byte $02, $06, $00, $01, $02, $02, $01, $01
LF233:  .byte $02, $06, $02, $01, $02, $02, $03, $01
LF23B:  .byte $02, $06, $04, $01, $02, $04, $05, $01
LF243:  .byte $02, $04, $06, $01, $02, $06, $07, $01
LF24B:  .byte $02, $04, $08, $01, $02, $06, $09, $01
LF253:  .byte $02, $04, $0A, $01, $02, $02, $0B, $01
LF25B:  .byte $02, $04, $0C, $01, $02, $02, $0D, $01
LF263:  .byte $03, $04, $0E, $01, $02, $02, $10, $01
LF26B:  .byte $02, $04, $11, $01, $02, $02, $12, $01
LF273:  .byte $02, $04, $13, $01, $02, $02, $14, $01
LF27B:  .byte $06, $04, $15, $01, $31, $02, $1B, $01
LF283:  .byte $01, $02, $4B, $00

fx4a_3c:
LF287:  .byte $01, $C0, $87, $FF, $01, $2E, $86, $FF
LF28F:  .byte $03, $10, $85, $FF, $01, $C2, $83, $F5
LF297:  .byte $00

fx4a_4f:
LF298:  .byte $01, $64, $78, $BF, $35, $02, $37, $FF
LF2A0:  .byte $02, $02, $01, $04, $01, $08, $05, $01
LF2A8:  .byte $02, $06, $06, $01, $02, $02, $07, $01
LF2B0:  .byte $02, $06, $08, $01, $02, $04, $09, $01
LF2B8:  .byte $02, $06, $0A, $01, $02, $04, $0B, $01
LF2C0:  .byte $02, $08, $0C, $01, $02, $06, $0D, $01
LF2C8:  .byte $02, $06, $0E, $01, $02, $06, $0F, $01
LF2D0:  .byte $02, $04, $10, $01, $02, $0E, $11, $01
LF2D8:  .byte $01, $0A, $13, $01, $01, $08, $14, $01
LF2E0:  .byte $02, $06, $15, $01, $02, $02, $18, $01
LF2E8:  .byte $54, $02, $19, $01, $01, $02, $6C, $00

fx4a_4c:
LF2F0:  .byte $01, $08, $6F, $00, $02, $10, $6F, $20
LF2F8:  .byte $02, $04, $8F, $FF, $04, $06, $8E, $FF
LF300:  .byte $02, $02, $8B, $FF, $01, $74, $8A, $FF
LF308:  .byte $01, $3A, $89, $FF, $01, $14, $88, $FF
LF310:  .byte $02, $0C, $87, $FF, $02, $0C, $86, $FF
LF318:  .byte $01, $34, $85, $FF, $02, $14, $84, $05
LF320:  .byte $02, $04, $89, $FF, $02, $0C, $88, $FF
LF328:  .byte $02, $06, $87, $FF, $02, $04, $86, $FF
LF330:  .byte $02, $0A, $85, $FF, $02, $08, $84, $FF
LF338:  .byte $02, $0E, $83, $FF, $02, $10, $82, $FF
LF340:  .byte $01, $08, $81, $00, $00

fx4b_8f:
LF345:  .byte $02, $02, $11, $FD, $07, $02, $0C, $FE
LF34D:  .byte $01, $0A, $00, $01, $0B, $02, $01, $01
LF355:  .byte $01, $0A, $0B, $FF, $0B, $02, $0A, $FF
LF35D:  .byte $01, $0C, $00, $01, $09, $02, $01, $01
LF365:  .byte $01, $08, $09, $FF, $09, $02, $08, $FF
LF36D:  .byte $01, $0E, $00, $01, $0A, $02, $01, $01
LF375:  .byte $01, $0A, $0A, $FF, $02, $02, $09, $FE
LF37D:  .byte $07, $02, $06, $FF, $01, $08, $00, $01
LF385:  .byte $0B, $02, $01, $01, $01, $0A, $0B, $FE
LF38D:  .byte $0A, $02, $09, $FF, $01, $0A, $00, $01
LF395:  .byte $08, $02, $01, $01, $01, $06, $08, $FF
LF39D:  .byte $08, $02, $07, $FF, $01, $0C, $00, $01
LF3A5:  .byte $03, $02, $01, $01, $02, $08, $03, $FF
LF3AD:  .byte $02, $04, $01, $FF, $01, $02, $00, $00

fx4b_8c:
LF3B5:  .byte $0A, $02, $84, $01, $01, $08, $8D, $FE
LF3BD:  .byte $0B, $02, $8B, $FF, $01, $08, $81, $01
LF3C5:  .byte $08, $02, $82, $01, $03, $04, $89, $01
LF3CD:  .byte $01, $08, $8B, $FF, $01, $04, $8A, $FF
LF3D5:  .byte $06, $02, $89, $FF, $02, $02, $82, $FF
LF3DD:  .byte $01, $08, $81, $01, $0A, $02, $82, $01
LF3E5:  .byte $01, $06, $8B, $FF, $0A, $02, $8A, $FF
LF3ED:  .byte $01, $0E, $81, $01, $02, $02, $82, $01
LF3F5:  .byte $02, $02, $83, $01, $06, $02, $84, $01
LF3FD:  .byte $01, $04, $89, $FF, $05, $02, $88, $FF
LF405:  .byte $02, $02, $84, $FF, $02, $02, $83, $FF
LF40D:  .byte $02, $02, $82, $FF, $01, $10, $81, $01
LF415:  .byte $05, $04, $82, $01, $01, $06, $86, $FF
LF41D:  .byte $03, $04, $85, $FF, $02, $02, $82, $FF
LF425:  .byte $01, $12, $81, $01, $03, $04, $82, $01
LF42D:  .byte $01, $10, $84, $FF, $01, $08, $83, $FF
LF435:  .byte $02, $04, $82, $FF, $01, $04, $81, $00
LF43D:  .byte $00

fx4d_3f:
LF43E:  .byte $02, $02, $0F, $0A, $03, $02, $20, $09
LF446:  .byte $02, $02, $59, $0F, $02, $02, $74, $0C
LF44E:  .byte $02, $02, $8F, $0F

fx4d_3c:
LF452:  .byte $02, $02, $84, $02, $03, $02, $87, $01
LF45A:  .byte $06, $02, $A9, $FF, $00

fx4e_4f:
LF45F:  .byte $02, $02, $01, $0B, $02, $02, $16, $0C
LF467:  .byte $02, $02, $2B, $0D, $02, $02, $46, $06
LF46F:  .byte $02, $02, $53, $08, $02, $02, $64, $0D
LF477:  .byte $02, $02, $7F, $12, $02, $02, $A1, $D2
LF47F:  .byte $02, $02, $67, $EF, $01, $08, $0A, $F9
LF487:  .byte $02, $06, $03, $06, $02, $06, $04, $03
LF48F:  .byte $02, $06, $05, $02, $02, $04, $05, $02
LF497:  .byte $02, $02, $07, $FF, $02, $02, $06, $01
LF49F:  .byte $01, $04, $07, $FF, $02, $02, $06, $01
LF4A7:  .byte $01, $04, $07, $FF, $02, $02, $06, $01
LF4AF:  .byte $01, $04, $07, $00

fx4e_4c:
LF4B3:  .byte $01, $1A, $8F, $FF, $05, $02, $8E, $FF
LF4BB:  .byte $03, $02, $62, $01, $02, $02, $64, $01
LF4C3:  .byte $02, $02, $65, $01, $01, $22, $66, $FF
LF4CB:  .byte $01, $08, $65, $FF, $02, $06, $64, $FF
LF4D3:  .byte $03, $04, $63, $FF, $00

fx4e_5f:
LF4D8:  .byte $02, $02, $6D, $E9, $02, $02, $48, $F1
LF4E0:  .byte $02, $02, $2F, $F9, $02, $02, $20, $FD
LF4E8:  .byte $02, $02, $64, $E7, $02, $02, $3B, $F2
LF4F0:  .byte $02, $02, $23, $F8, $01, $02, $16, $00

fx4e_5c:
LF4F8:  .byte $05, $02, $A5, $01, $04, $02, $A8, $FF
LF500:  .byte $06, $02, $A6, $01, $00

fx_spare_f:
LF505:  .byte $02, $02, $11, $FB, $02, $02, $08, $FE ;a frequency sequence and at $F551 its control sequence that no effect table points to: it starts like the one at $F5AE (command $4F), which looks like its later version
LF50D:  .byte $04, $02, $02, $01, $02, $02, $07, $02
LF515:  .byte $02, $02, $0A, $01, $03, $02, $0B, $FF
LF51D:  .byte $03, $02, $07, $FF, $03, $02, $03, $01
LF525:  .byte $02, $02, $07, $01, $03, $02, $07, $FF
LF52D:  .byte $02, $02, $03, $FE, $05, $02, $02, $01
LF535:  .byte $02, $02, $09, $FD, $02, $02, $05, $FF
LF53D:  .byte $05, $02, $01, $01, $02, $02, $0A, $FD
LF545:  .byte $07, $02, $06, $FF, $01, $10, $00, $00
LF54D:  .byte $03, $02, $84, $02

fx_spare_c:
LF551:  .byte $02, $02, $89, $01, $03, $02, $89, $FF
LF559:  .byte $02, $02, $85, $FE, $02, $02, $82, $FF
LF561:  .byte $03, $02, $82, $01, $04, $02, $86, $01
LF569:  .byte $02, $02, $88, $FF, $02, $02, $85, $FF
LF571:  .byte $03, $02, $82, $01, $02, $02, $86, $03
LF579:  .byte $06, $02, $87, $FF, $03, $02, $83, $01
LF581:  .byte $02, $02, $87, $02, $02, $02, $86, $FE
LF589:  .byte $02, $02, $83, $FE, $02, $02, $82, $01
LF591:  .byte $02, $02, $86, $03, $02, $02, $86, $FD
LF599:  .byte $02, $02, $82, $FF, $02, $02, $82, $01
LF5A1:  .byte $02, $02, $86, $03, $02, $02, $86, $FD
LF5A9:  .byte $02, $02, $82, $FF, $00

fx4f_8f:
LF5AE:  .byte $02, $02, $11, $FB, $02, $02, $08, $FE
LF5B6:  .byte $04, $02, $02, $01, $02, $02, $07, $01
LF5BE:  .byte $02, $02, $0A, $01, $03, $02, $0B, $FF
LF5C6:  .byte $03, $02, $07, $FF, $04, $02, $03, $01
LF5CE:  .byte $03, $02, $08, $FF, $02, $02, $04, $FF
LF5D6:  .byte $06, $02, $01, $01, $02, $02, $09, $FD
LF5DE:  .byte $02, $02, $05, $FF, $05, $02, $01, $01
LF5E6:  .byte $02, $02, $0A, $FD, $06, $02, $06, $FF
LF5EE:  .byte $02, $02, $02, $02, $04, $02, $05, $02
LF5F6:  .byte $03, $02, $09, $FE

fx4f_8c:
LF5FA:  .byte $02, $02, $29, $02, $02, $02, $2C, $01
LF602:  .byte $02, $02, $2F, $FE, $02, $02, $2C, $FF
LF60A:  .byte $03, $02, $29, $FE, $02, $02, $24, $01
LF612:  .byte $06, $02, $28, $01, $02, $02, $2C, $FF
LF61A:  .byte $03, $02, $29, $FE, $02, $02, $27, $02
LF622:  .byte $02, $02, $2A, $02, $02, $02, $2D, $FE
LF62A:  .byte $02, $02, $2A, $FD, $02, $02, $26, $FF
LF632:  .byte $04, $02, $26, $01, $02, $02, $2B, $FF
LF63A:  .byte $02, $02, $28, $FF, $03, $02, $25, $01
LF642:  .byte $02, $02, $29, $01, $02, $02, $28, $FE
LF64A:  .byte $02, $02, $25, $FF, $02, $02, $25, $02
LF652:  .byte $02, $02, $28, $02, $02, $02, $28, $FE
LF65A:  .byte $02, $02, $25, $FF, $00

fx4c_1f:
LF65F:  .byte $01, $56, $79, $00

fx4c_1c:
LF663:  .byte $01, $0A, $A9, $00, $09, $02, $A8, $FF
LF66B:  .byte $06, $02, $A9, $FF, $02, $02, $A4, $05
LF673:  .byte $01, $1A, $A9, $FF, $08, $02, $A8, $FF
LF67B:  .byte $00

fx4c_2f:
LF67C:  .byte $01, $56, $51, $00

fx4c_2c:
LF680:  .byte $01, $0A, $A9, $A9, $09, $02, $A8, $FF
LF688:  .byte $07, $02, $A9, $FF, $01, $1C, $A9, $FF
LF690:  .byte $08, $02, $A8, $FF, $00

fx50_8f:
LF695:  .byte $02, $02, $5B, $0F, $02, $02, $76, $1C
LF69D:  .byte $01, $12, $ED, $00, $01, $0C, $00, $00
LF6A5:  .byte $02, $02, $5B, $0F, $02, $02, $76, $1C
LF6AD:  .byte $01, $12, $ED, $00, $01, $0C, $00, $00
LF6B5:  .byte $02, $02, $5B, $0F, $02, $02, $76, $1C
LF6BD:  .byte $01, $12, $ED, $00, $01, $0C, $00, $00
LF6C5:  .byte $02, $02, $5B, $0F, $02, $02, $76, $1C
LF6CD:  .byte $01, $12, $ED, $00, $01, $0C, $00, $00
LF6D5:  .byte $02, $02, $5B, $0F, $02, $02, $76, $1C
LF6DD:  .byte $01, $12, $ED, $00, $01, $0C, $00, $00
LF6E5:  .byte $02, $02, $5B, $0F, $02, $02, $76, $1C
LF6ED:  .byte $01, $12, $ED, $00, $01, $0C, $00, $00
LF6F5:  .byte $02, $02, $5B, $0F, $02, $02, $76, $1C
LF6FD:  .byte $01, $12, $ED, $00, $01, $0C, $00, $00
LF705:  .byte $02, $02, $5B, $0F, $02, $02, $76, $1C
LF70D:  .byte $01, $12, $ED, $00, $01, $0C, $00, $00
LF715:  .byte $02, $02, $5B, $0F, $02, $02, $76, $1C
LF71D:  .byte $01, $12, $ED, $00, $01, $0C, $00, $00
LF725:  .byte $02, $02, $5B, $0F, $02, $02, $76, $1C
LF72D:  .byte $01, $12, $ED, $00, $01, $0C, $00, $00
LF735:  .byte $02, $02, $5B, $0F, $02, $02, $76, $1C
LF73D:  .byte $01, $12, $ED, $00, $01, $0C, $00, $00
LF745:  .byte $02, $02, $5B, $0F, $02, $02, $76, $1C
LF74D:  .byte $01, $12, $ED, $00, $01, $0C, $00, $00
LF755:  .byte $02, $02, $5B, $0F, $02, $02, $76, $1C
LF75D:  .byte $01, $12, $ED, $00, $01, $0C, $00, $00
LF765:  .byte $02, $02, $5B, $0F, $02, $02, $76, $1C
LF76D:  .byte $01, $12, $ED, $00, $01, $0C, $00, $00
LF775:  .byte $02, $02, $5B, $0F, $02, $02, $76, $1C
LF77D:  .byte $01, $12, $ED, $00, $01, $0C, $00, $00
LF785:  .byte $02, $02, $5B, $0F, $02, $02, $76, $1C
LF78D:  .byte $01, $12, $ED, $00, $01, $0C, $00, $00
LF795:  .byte $02, $02, $5B, $0F, $02, $02, $76, $1C
LF79D:  .byte $01, $12, $ED, $00, $01, $0C, $00, $00
LF7A5:  .byte $02, $02, $5B, $0F, $02, $02, $76, $1C
LF7AD:  .byte $01, $12, $ED, $00, $01, $0C, $00, $00
LF7B5:  .byte $02, $02, $5B, $0F, $02, $02, $76, $1C
LF7BD:  .byte $01, $12, $ED, $00, $01, $0C, $00, $00
LF7C5:  .byte $02, $02, $5B, $0F, $02, $02, $76, $1C
LF7CD:  .byte $01, $12, $ED, $00, $01, $0C, $00, $00

fx50_8c:
LF7D5:  .byte $01, $06, $AF, $00, $02, $02, $AE, $FF
LF7DD:  .byte $06, $02, $AD, $FF, $02, $02, $A6, $FC
LF7E5:  .byte $01, $02, $00, $00, $01, $0A, $00, $00
LF7ED:  .byte $01, $06, $AF, $00, $02, $02, $AE, $FF
LF7F5:  .byte $06, $02, $AD, $FF, $02, $02, $A6, $FC
LF7FD:  .byte $01, $02, $00, $00, $01, $0A, $00, $00
LF805:  .byte $01, $06, $AF, $00, $02, $02, $AE, $FF
LF80D:  .byte $06, $02, $AD, $FF, $02, $02, $A6, $FC
LF815:  .byte $01, $02, $00, $00, $01, $0A, $00, $00
LF81D:  .byte $01, $06, $AF, $00, $02, $02, $AE, $FF
LF825:  .byte $06, $02, $AD, $FF, $02, $02, $A6, $FC
LF82D:  .byte $01, $02, $00, $00, $01, $0A, $00, $00
LF835:  .byte $01, $06, $AF, $00, $02, $02, $AE, $FF
LF83D:  .byte $06, $02, $AD, $FF, $02, $02, $A6, $FC
LF845:  .byte $01, $02, $00, $00, $01, $0A, $00, $00
LF84D:  .byte $01, $06, $AF, $00, $02, $02, $AE, $FF
LF855:  .byte $06, $02, $AD, $FF, $02, $02, $A6, $FC
LF85D:  .byte $01, $02, $00, $00, $01, $0A, $00, $00
LF865:  .byte $01, $06, $AF, $00, $02, $02, $AE, $FF
LF86D:  .byte $06, $02, $AD, $FF, $02, $02, $A6, $FC
LF875:  .byte $01, $02, $00, $00, $01, $0A, $00, $00
LF87D:  .byte $01, $06, $AF, $00, $02, $02, $AE, $FF
LF885:  .byte $06, $02, $AD, $FF, $02, $02, $A6, $FC
LF88D:  .byte $01, $02, $00, $00, $01, $0A, $00, $00
LF895:  .byte $01, $06, $AF, $00, $02, $02, $AE, $FF
LF89D:  .byte $06, $02, $AD, $FF, $02, $02, $A6, $FC
LF8A5:  .byte $01, $02, $00, $00, $01, $0A, $00, $00
LF8AD:  .byte $01, $06, $AF, $00, $02, $02, $AE, $FF
LF8B5:  .byte $06, $02, $AD, $FF, $02, $02, $A6, $FC
LF8BD:  .byte $01, $02, $00, $00, $01, $0A, $00, $00
LF8C5:  .byte $01, $06, $AF, $00, $02, $02, $AE, $FF
LF8CD:  .byte $06, $02, $AD, $FF, $02, $02, $A6, $FC
LF8D5:  .byte $01, $02, $00, $00, $01, $0A, $00, $00
LF8DD:  .byte $01, $06, $AF, $00, $02, $02, $AE, $FF
LF8E5:  .byte $06, $02, $AD, $FF, $02, $02, $A6, $FC
LF8ED:  .byte $01, $02, $00, $00, $01, $0A, $00, $00
LF8F5:  .byte $01, $06, $AF, $00, $02, $02, $AE, $FF
LF8FD:  .byte $06, $02, $AD, $FF, $02, $02, $A6, $FC
LF905:  .byte $01, $02, $00, $00, $01, $0A, $00, $00
LF90D:  .byte $01, $06, $AF, $00, $02, $02, $AE, $FF
LF915:  .byte $06, $02, $AD, $FF, $02, $02, $A6, $FC
LF91D:  .byte $01, $02, $00, $00, $01, $0A, $00, $00
LF925:  .byte $01, $06, $AF, $00, $02, $02, $AE, $FF
LF92D:  .byte $06, $02, $AD, $FF, $02, $02, $A6, $FC
LF935:  .byte $01, $02, $00, $00, $01, $0A, $00, $00
LF93D:  .byte $01, $06, $AF, $00, $02, $02, $AE, $FF
LF945:  .byte $06, $02, $AD, $FF, $02, $02, $A6, $FC
LF94D:  .byte $01, $02, $00, $00, $01, $0A, $00, $00
LF955:  .byte $01, $06, $AF, $00, $02, $02, $AE, $FF
LF95D:  .byte $06, $02, $AD, $FF, $02, $02, $A6, $FC
LF965:  .byte $01, $02, $00, $00, $01, $0A, $00, $00
LF96D:  .byte $01, $06, $AF, $00, $02, $02, $AE, $FF
LF975:  .byte $06, $02, $AD, $FF, $02, $02, $A6, $FC
LF97D:  .byte $01, $02, $00, $00, $01, $0A, $00, $00
LF985:  .byte $01, $06, $AF, $00, $02, $02, $AE, $FF
LF98D:  .byte $06, $02, $AD, $FF, $02, $02, $A6, $FC
LF995:  .byte $01, $02, $00, $00, $01, $0A, $00, $00
LF99D:  .byte $01, $06, $AF, $00, $02, $02, $AE, $FF
LF9A5:  .byte $06, $02, $AD, $FF, $02, $02, $A6, $FC
LF9AD:  .byte $01, $02, $00, $00, $01, $0A, $00, $00

fx_unused_z:
LF9B5:  .byte $00

fx51_4f:
LF9B6:  .byte $01, $52, $91, $00

fx51_4c:
LF9BA:  .byte $01, $0E, $80, $00, $02, $02, $80, $0F
LF9C2:  .byte $01, $10, $8F, $FF, $01, $08, $8E, $FF
LF9CA:  .byte $03, $06, $8D, $FF, $01, $04, $8A, $FF
LF9D2:  .byte $09, $02, $89, $FF, $00

fx51_5f:
LF9D7:  .byte $01, $0E, $35, $00, $01, $0E, $15, $01
LF9DF:  .byte $01, $0A, $16, $01, $01, $06, $17, $02
LF9E7:  .byte $02, $02, $19, $02, $02, $02, $1B, $02
LF9EF:  .byte $02, $02, $1E, $01, $02, $02, $23, $02
LF9F7:  .byte $02, $02, $25, $02, $02, $02, $27, $03
LF9FF:  .byte $03, $02, $2B, $02, $02, $02, $30, $06
LFA07:  .byte $03, $02, $36, $03, $03, $02, $3C, $03
LFA0F:  .byte $04, $02, $42, $03, $02, $02, $4B, $04
LFA17:  .byte $02, $02, $4F, $04, $03, $02, $53, $02
LFA1F:  .byte $05, $02, $5B, $04, $03, $02, $70, $05
LFA27:  .byte $02, $04, $B8, $06, $01, $04, $C5, $07
LFA2F:  .byte $01, $02, $CC, $00

fx51_5c:
LFA33:  .byte $01, $08, $0C, $FF, $04, $02, $0B, $FE
LFA3B:  .byte $02, $06, $0B, $FF, $02, $08, $0A, $FF
LFA43:  .byte $02, $0C, $09, $FF, $02, $0E, $08, $FF
LFA4B:  .byte $02, $0C, $07, $FF, $04, $04, $06, $FF
LFA53:  .byte $01, $06, $03, $00, $00

tab_xl:
LFA58:  .byte $06                   ;sound effect tables (Atari's OFFSET statements), read by AUDNEW: a mask byte, bit 7 = channel pair 0 down to bit 0 = pair 7 (pairs 0-3 are the four channels of POKEY chip 0, pairs 4-7 of chip 1), then for each set bit two addresses, the sequence for the frequency register and the sequence for the control register. Atari's XL0, X-wing laser: mask $06 = chip 1 channel 2, chip 1 channel 3, about 3.3 s
LFA59:  .word XL6F
LFA5B:  .word XL6C
LFA5D:  .word XL7F
LFA5F:  .word XL7C

tab_xlz:
LFA61:  .byte $02                   ;Atari's XLZ0, end of the X-wing laser sound: mask $02 = chip 1 channel 3, both sequences are just an end mark, so the channel is silenced
LFA62:  .word XLZ7C
LFA64:  .word XLZ7C

tab_pb:
LFA66:  .byte $30                   ;Atari's PB0, pass-by: mask $30 = chip 0 channel 3, chip 0 channel 4, about 1.6 s
LFA67:  .word PB3F
LFA69:  .word PB3C
LFA6B:  .word PB4F
LFA6D:  .word PB4C

tab_sh:
LFA6F:  .byte $05                   ;Atari's SH0, shield: mask $05 = chip 1 channel 2, chip 1 channel 4, about 0.4 s
LFA70:  .word SH6F
LFA72:  .word SH6C
LFA74:  .word SH6F
LFA76:  .word SH6C

tab_pf:
LFA78:  .byte $10                   ;Atari's PF0, tower pfffts: mask $10 = chip 0 channel 4, about 0.1 s
LFA79:  .word PF4F
LFA7B:  .word PF4C

tab_sx:
LFA7D:  .byte $08                   ;Atari's SX0, small explosion: mask $08 = chip 1 channel 1, about 0.8 s
LFA7E:  .word SX5F
LFA80:  .word SX5C

tab_df:
LFA82:  .byte $5D                   ;Atari's DF0, Death Star final explosion: mask $5D = chip 0 channel 2, chip 0 channel 4, chip 1 channel 1, chip 1 channel 2, chip 1 channel 4, about 2.3 s
LFA83:  .word df2f
LFA85:  .word DF1C
LFA87:  .word DF4F
LFA89:  .word DF1C
LFA8B:  .word DF5F
LFA8D:  .word DF1C
LFA8F:  .word DF6F
LFA91:  .word DF1C
LFA93:  .word DF8F
LFA95:  .word DF1C

tab_cr:
LFA97:  .byte $25                   ;Atari's CR0, crash into bridge or tower: mask $25 = chip 0 channel 3, chip 1 channel 2, chip 1 channel 4, about 0.7 s
LFA98:  .word CR3F
LFA9A:  .word CR3C
LFA9C:  .word CR6F
LFA9E:  .word CR3C
LFAA0:  .word CR3F
LFAA2:  .word CR3C

tab_ps:
PS0:
LFAA4:  .byte $30                   ;OFFSET PS  SHORT PASSBY  Atari's PS0, short pass-by: mask $30 = chip 0 channel 3, chip 0 channel 4, about 1.0 s
LFAA5:  .word PS3F
LFAA7:  .word PS3C
LFAA9:  .word PS4F
LFAAB:  .word PS4C

tab_ss:
SS0:
LFAAD:  .byte $01                   ;OFFSET SS  SHOOT SHOTS  Atari's SS0, shoot shots: mask $01 = chip 1 channel 4, about 0.1 s
LFAAE:  .word SS8F
LFAB0:  .word SS8C

tab_bl:
BL0:
LFAB2:  .byte $C0                   ;OFFSET BL  PLAYER'S LASER BLAST  Atari's BL0, player's laser blast: mask $C0 = chip 0 channel 1, chip 0 channel 2, about 0.4 s
LFAB3:  .word BL1F
LFAB5:  .word bl1c
LFAB7:  .word BL2F
LFAB9:  .word bl2c

tab_ph:
PH0:
LFABB:  .byte $E2                   ;OFFSET PH  PORT HOLE SHOT  Atari's PH0, port hole shot: mask $E2 = chip 0 channel 1, chip 0 channel 2, chip 0 channel 3, chip 1 channel 3, about 0.4 s
LFABC:  .word PH1F
LFABE:  .word PH1C
LFAC0:  .word PH2F
LFAC2:  .word PH2C
LFAC4:  .word PH3F
LFAC6:  .word PH3C
LFAC8:  .word PH7F
LFACA:  .word PH7C

tab_pbz:
LFACC:  .byte $30                   ;Atari's PBZ0, end of the pass-by sound: mask $30 = chip 0 channel 3, chip 0 channel 4, both sequences are just an end mark, so the channel is silenced
LFACD:  .word PBZ3C
LFACF:  .word PBZ3C
LFAD1:  .word PBZ4C
LFAD3:  .word PBZ4C

tab_yea:
LFAD5:  .byte $80                   ;Atari's YEA0, yea, test successful: mask $80 = chip 0 channel 1, about 0.2 s
LFAD6:  .word YEA1F
LFAD8:  .word NAY1C

tab_nay:
LFADA:  .byte $80                   ;Atari's NAY0, nay, test failed: mask $80 = chip 0 channel 1, about 0.2 s
LFADB:  .word NAY1F
LFADD:  .word NAY1C

tab_tst:
LFADF:  .byte $FF                   ;Atari's TST0, test tones: mask $FF = chip 0 channel 1, chip 0 channel 2, chip 0 channel 3, chip 0 channel 4, chip 1 channel 1, chip 1 channel 2, chip 1 channel 3, chip 1 channel 4, about 3.2 s
LFAE0:  .word TST1F
LFAE2:  .word TST1C
LFAE4:  .word TST2F
LFAE6:  .word TST2C
LFAE8:  .word TST3F
LFAEA:  .word TST3C
LFAEC:  .word TST4F
LFAEE:  .word TST4C
LFAF0:  .word TST1F
LFAF2:  .word TST5C
LFAF4:  .word TST2F
LFAF6:  .word TST6C
LFAF8:  .word TST3F
LFAFA:  .word TST7C
LFAFC:  .word TST4F
LFAFE:  .word TST8C

tab_fx41:
LFB00:  .byte $12                   ;effect of sound command $41: mask $12 = chip 0 channel 4, chip 1 channel 3, about 0.4 s
LFB01:  .word fx41_4f
LFB03:  .word fx41_4c
LFB05:  .word fx41_7f
LFB07:  .word fx41_7c

tab_fx42:
LFB09:  .byte $80                   ;effect of sound command $42: mask $80 = chip 0 channel 1, about 0.4 s
LFB0A:  .word fx42_1f
LFB0C:  .word fx42_1c

tab_fx43:
LFB0E:  .byte $C0                   ;effect of sound command $43: mask $C0 = chip 0 channel 1, chip 0 channel 2, about 2.5 s
LFB0F:  .word fx43_1f
LFB11:  .word fx43_1c
LFB13:  .word fx43_2f
LFB15:  .word fx43_2c

tab_fx44:
LFB17:  .byte $C0                   ;effect of sound command $44: mask $C0 = chip 0 channel 1, chip 0 channel 2, both sequences are just an end mark, so the channel is silenced
LFB18:  .word fx44_z
LFB1A:  .word fx44_z
LFB1C:  .word fx44_z
LFB1E:  .word fx44_z

tab_fx45:
LFB20:  .byte $C0                   ;effect of sound command $45: mask $C0 = chip 0 channel 1, chip 0 channel 2, about 6.1 s
LFB21:  .word fx45_1f
LFB23:  .word fx45_1c
LFB25:  .word fx45_2f
LFB27:  .word fx45_2c

tab_fx46:
LFB29:  .byte $12                   ;effect of sound command $46: mask $12 = chip 0 channel 4, chip 1 channel 3, about 0.8 s
LFB2A:  .word fx46_4f
LFB2C:  .word fx46_4c
LFB2E:  .word fx46_7f
LFB30:  .word fx46_7c

tab_fx47:
LFB32:  .byte $1C                   ;effect of sound command $47: mask $1C = chip 0 channel 4, chip 1 channel 1, chip 1 channel 2, about 4.8 s
LFB33:  .word fx47_4f
LFB35:  .word fx47_4c
LFB37:  .word fx47_5f
LFB39:  .word fx47_5c
LFB3B:  .word fx47_6f
LFB3D:  .word fx47_6c

tab_fx48:
LFB3F:  .byte $08                   ;effect of sound command $48: mask $08 = chip 1 channel 1, about 1.1 s
LFB40:  .word fx48_5f
LFB42:  .word fx48_5c

tab_fx49:
LFB44:  .byte $48                   ;effect of sound command $49: mask $48 = chip 0 channel 2, chip 1 channel 1, about 0.9 s
LFB45:  .word fx49_2f
LFB47:  .word fx49_2c
LFB49:  .word fx49_5f
LFB4B:  .word fx49_5c

tab_fx4a:
LFB4D:  .byte $30                   ;effect of sound command $4A: mask $30 = chip 0 channel 3, chip 0 channel 4, about 4.5 s
LFB4E:  .word fx4a_3f
LFB50:  .word fx4a_3c
LFB52:  .word fx4a_4f
LFB54:  .word fx4a_4c

tab_fx4b:
LFB56:  .byte $01                   ;effect of sound command $4B: mask $01 = chip 1 channel 4, about 2.8 s
LFB57:  .word fx4b_8f
LFB59:  .word fx4b_8c

tab_fx4c:
LFB5B:  .byte $C0                   ;effect of sound command $4C: mask $C0 = chip 0 channel 1, chip 0 channel 2, about 0.7 s
LFB5C:  .word fx4c_1f
LFB5E:  .word fx4c_1c
LFB60:  .word fx4c_2f
LFB62:  .word fx4c_2c

tab_fx4d:
LFB64:  .byte $20                   ;effect of sound command $4D: mask $20 = chip 0 channel 3, about 0.2 s
LFB65:  .word fx4d_3f
LFB67:  .word fx4d_3c

tab_fx4e:
LFB69:  .byte $18                   ;effect of sound command $4E: mask $18 = chip 0 channel 4, chip 1 channel 1, about 0.9 s
LFB6A:  .word fx4e_4f
LFB6C:  .word fx4e_4c
LFB6E:  .word fx4e_5f
LFB70:  .word fx4e_5c

tab_fx4f:
LFB72:  .byte $01                   ;effect of sound command $4F: mask $01 = chip 1 channel 4, about 0.9 s
LFB73:  .word fx4f_8f
LFB75:  .word fx4f_8c

tab_fx50:
LFB77:  .byte $01                   ;effect of sound command $50: mask $01 = chip 1 channel 4, about 6.1 s
LFB78:  .word fx50_8f
LFB7A:  .word fx50_8c

tab_fx51:
LFB7C:  .byte $18                   ;effect of sound command $51: mask $18 = chip 0 channel 4, chip 1 channel 1, about 1.1 s
LFB7D:  .word fx51_4f
LFB7F:  .word fx51_4c
LFB81:  .word fx51_5f
LFB83:  .word fx51_5c

tab_fx_unused:
NAY0:
LFB85:  .byte $80                   ;OFFSET NAY  NAY, TEST BIT BIG ONE  an effect table only the uncalled code at $FC6A loads: mask $80 = chip 0 channel 1, both sequences are just an end mark, so the channel is silenced
LFB86:  .word fx_unused_z
LFB88:  .word fx_unused_z

;------------------------------------------------------------------------------
; aud_start_3f - start the sound effect of command $3F: Star Wars' AUDXL by the table it loads (the BL table)
;------------------------------------------------------------------------------
aud_start_3f:
LFB8A:  LDY  #tab_bl                ;tab_bl: player's laser blast
LFB8E:  JMP  AUDNEW

;------------------------------------------------------------------------------
; aud_start_35 - start the sound effect of command $35: Star Wars' AUDPB by the table it loads
;------------------------------------------------------------------------------
aud_start_35:
LFB91:  LDY  #tab_pb                ;tab_pb: pass-by
LFB95:  JMP  AUDNEW

;------------------------------------------------------------------------------
; aud_start_36 - start the sound effect of command $36: Star Wars' AUDPBZ by the table it loads
;------------------------------------------------------------------------------
aud_start_36:
LFB98:  LDY  #tab_pbz               ;tab_pbz: end of the pass-by sound
LFB9C:  JMP  AUDNEW

;------------------------------------------------------------------------------
; aud_start_3a - start the sound effect of command $3A: Star Wars' AUDSH by the table it loads
;------------------------------------------------------------------------------
aud_start_3a:
LFB9F:  LDY  #tab_sh                ;tab_sh: shield
LFBA3:  JMP  AUDNEW

;------------------------------------------------------------------------------
; aud_start_37 - start the sound effect of command $37: Star Wars' AUDPF by the table it loads
;------------------------------------------------------------------------------
aud_start_37:
LFBA6:  LDY  #tab_pf                ;tab_pf: tower pfffts
LFBAA:  JMP  AUDNEW

;------------------------------------------------------------------------------
; aud_tie_cannon - R2 SHAVE
;------------------------------------------------------------------------------
aud_tie_cannon:
AUDRS:
LFBAD:  LDY  #tab_xl
LFBB1:  JMP  AUDNEW

;------------------------------------------------------------------------------
; aud_tie_cannon_off - THRUSTING DOWN TO DEATH STAR
;------------------------------------------------------------------------------
aud_tie_cannon_off:
AUDTH:
LFBB4:  LDY  #tab_xlz
LFBB8:  JMP  AUDNEW

;------------------------------------------------------------------------------
; aud_small_expl - PORT HOLE SHOT
;------------------------------------------------------------------------------
aud_small_expl:
AUDPH:
LFBBB:  LDY  #tab_sx
LFBBF:  JMP  AUDNEW

;------------------------------------------------------------------------------
; aud_final_expl - R2 SHAVE
;------------------------------------------------------------------------------
aud_final_expl:
LFBC2:  LDY  #tab_df
LFBC6:  JMP  AUDNEW

;------------------------------------------------------------------------------
; aud_passby_short - THRUSTING DOWN TO DEATH STAR
;------------------------------------------------------------------------------
aud_passby_short:
LFBC9:  LDY  #tab_ps
LFBCD:  JMP  AUDNEW

;------------------------------------------------------------------------------
; aud_crash - PORT HOLE SHOT
;------------------------------------------------------------------------------
aud_crash:
LFBD0:  LDY  #tab_cr
LFBD4:  JMP  AUDNEW

;------------------------------------------------------------------------------
; aud_shoot_shots - R2 SHAVE
;------------------------------------------------------------------------------
aud_shoot_shots:
LFBD7:  LDY  #tab_ss
LFBDB:  JMP  AUDNEW

;------------------------------------------------------------------------------
; aud_port_hole - THRUSTING DOWN TO DEATH STAR
;------------------------------------------------------------------------------
aud_port_hole:
LFBDE:  LDY  #tab_ph
LFBE2:  JMP  AUDNEW

;------------------------------------------------------------------------------
; aud_yea - PORT HOLE SHOT
;------------------------------------------------------------------------------
aud_yea:
LFBE5:  LDY  #tab_yea
LFBE9:  JMP  AUDNEW

;------------------------------------------------------------------------------
; aud_nay - R2 SHAVE
;------------------------------------------------------------------------------
aud_nay:
LFBEC:  LDY  #tab_nay
LFBF0:  JMP  AUDNEW

;------------------------------------------------------------------------------
; aud_test_tones - THRUSTING DOWN TO DEATH STAR
;------------------------------------------------------------------------------
aud_test_tones:
LFBF3:  LDY  #tab_tst
LFBF7:  JMP  AUDNEW

;------------------------------------------------------------------------------
; aud_fx41 - PORT HOLE SHOT
;------------------------------------------------------------------------------
aud_fx41:
LFBFA:  LDY  #tab_fx41
LFBFE:  JMP  AUDNEW

;------------------------------------------------------------------------------
; aud_fx42 - R2 SHAVE
;------------------------------------------------------------------------------
aud_fx42:
LFC01:  LDY  #tab_fx42
LFC05:  JMP  AUDNEW

;------------------------------------------------------------------------------
; aud_fx43 - THRUSTING DOWN TO DEATH STAR
;------------------------------------------------------------------------------
aud_fx43:
LFC08:  LDY  #tab_fx43
LFC0C:  JMP  AUDNEW

;------------------------------------------------------------------------------
; aud_fx44 - PORT HOLE SHOT
;------------------------------------------------------------------------------
aud_fx44:
LFC0F:  LDY  #tab_fx44
LFC13:  JMP  AUDNEW

;------------------------------------------------------------------------------
; aud_fx45 - R2 SHAVE
;------------------------------------------------------------------------------
aud_fx45:
LFC16:  LDY  #tab_fx45
LFC1A:  JMP  AUDNEW

;------------------------------------------------------------------------------
; aud_fx46 - THRUSTING DOWN TO DEATH STAR
;------------------------------------------------------------------------------
aud_fx46:
LFC1D:  LDY  #tab_fx46
LFC21:  JMP  AUDNEW

;------------------------------------------------------------------------------
; aud_fx47 - PORT HOLE SHOT
;------------------------------------------------------------------------------
aud_fx47:
LFC24:  LDY  #tab_fx47
LFC28:  JMP  AUDNEW

;------------------------------------------------------------------------------
; aud_fx48 - R2 SHAVE
;------------------------------------------------------------------------------
aud_fx48:
LFC2B:  LDY  #tab_fx48
LFC2F:  JMP  AUDNEW

;------------------------------------------------------------------------------
; aud_fx49 - THRUSTING DOWN TO DEATH STAR
;------------------------------------------------------------------------------
aud_fx49:
LFC32:  LDY  #tab_fx49
LFC36:  JMP  AUDNEW

;------------------------------------------------------------------------------
; aud_fx4a - PORT HOLE SHOT
;------------------------------------------------------------------------------
aud_fx4a:
LFC39:  LDY  #tab_fx4a
LFC3D:  JMP  AUDNEW

;------------------------------------------------------------------------------
; aud_fx4b - R2 SHAVE
;------------------------------------------------------------------------------
aud_fx4b:
LFC40:  LDY  #tab_fx4b
LFC44:  JMP  AUDNEW

;------------------------------------------------------------------------------
; aud_fx4c - THRUSTING DOWN TO DEATH STAR
;------------------------------------------------------------------------------
aud_fx4c:
LFC47:  LDY  #tab_fx4c
LFC4B:  JMP  AUDNEW

;------------------------------------------------------------------------------
; aud_fx4d - PORT HOLE SHOT
;------------------------------------------------------------------------------
aud_fx4d:
LFC4E:  LDY  #tab_fx4d
LFC52:  JMP  AUDNEW

;------------------------------------------------------------------------------
; aud_start_4e - start the sound effect of command $4E: an effect ESB added
;------------------------------------------------------------------------------
aud_start_4e:
LFC55:  LDY  #tab_fx4e              ;tab_fx4e: effect of command $4E
LFC59:  JMP  AUDNEW

;------------------------------------------------------------------------------
; aud_start_4f - start the sound effect of command $4F: an effect ESB added
;------------------------------------------------------------------------------
aud_start_4f:
LFC5C:  LDY  #tab_fx4f              ;tab_fx4f: effect of command $4F
LFC60:  JMP  AUDNEW

;------------------------------------------------------------------------------
; aud_start_50 - start the sound effect of command $50: an effect ESB added
;------------------------------------------------------------------------------
aud_start_50:
LFC63:  LDY  #tab_fx50              ;tab_fx50: effect of command $50
LFC67:  JMP  AUDNEW

;------------------------------------------------------------------------------
; AUDNAY - NAY, TEST FAIL
;------------------------------------------------------------------------------
AUDNAY:
LFC6A:  LDY  #NAY0                  ;code no table entry or instruction reaches: LDY #$FB85 / JMP AUDNEW, which would silence chip 0 channel 1 with the table at $FB85
LFC6E:  JMP  AUDNEW

;------------------------------------------------------------------------------
; aud_fx51 - TEST TONES
;------------------------------------------------------------------------------
aud_fx51:
AUDTST:
LFC71:  LDY  #tab_fx51
LFC75:  JMP  AUDNEW

;------------------------------------------------------------------------------
; AUDNEW - AUDNEW - NEW AUDIO
;   Y-->POINTER TABLE
;------------------------------------------------------------------------------
AUDNEW:
LFC78:  LDA  ,Y+
LFC7A:  STA  AU_SHF
LFC7D:  LDX  #AU_BLK

AUDNEW_10:
LFC80:  LSL  AU_SHF
LFC83:  BCC  AUDNEW_30
LFC85:  LDD  ,Y++                   ;FREQ POINTER
LFC87:  STD  ,X
LFC89:  LDD  ,Y++                   ;CONTROL/VOLUME POINTER
LFC8B:  STD  AUS_PNT+AUS_IZ,X
LFC8D:  LDA  #$01
LFC8F:  STA  AUS_RPT,X
LFC91:  STA  AUS_TMR,X
LFC93:  STA  AUS_RPT+AUS_IZ,X
LFC95:  STA  AUS_TMR+AUS_IZ,X

AUDNEW_30:
LFC97:  LEAX 2*AUS_IZ,X
LFC99:  LDA  AU_SHF
LFC9C:  BNE  AUDNEW_10
LFC9E:  RTS

;------------------------------------------------------------------------------
; AUDDO - AUDDO - UPDATE AUDIO EVERY 16 MILS
;   AUDIO DO - EVERY 16 MILS
;------------------------------------------------------------------------------
AUDDO:
LFC9F:  LDX  #AU_BLK                ;AUDIO CHANNEL INFO
LFCA2:  LDB  #$00                   ;POKEY CHANNEL OFFSET

AUDDO_10:
LFCA4:  LDY  ,X                     ;Y-->AUDIO PHRASE TABLE
LFCA7:  BEQ  AUDDO_55               ;? POINTER VALID?
LFCA9:  DEC  AUS_TMR,X              ;THEN PROCEED WITH CHANNEL
LFCAB:  BNE  AUDDO_55               ;? DONE WITH CURRENT NOTE?
LFCAD:  DEC  AUS_RPT,X
LFCAF:  BNE  AUDDO_40               ;? DONE WITH CURRENT PHRASE?
LFCB1:  LEAY TAS_IZ,Y               ;THEN BUMP TO NEXT PHRASE
LFCB3:  STY  ,X
LFCB6:  LDA  TAS_RPT-TAS_IZ,Y
LFCB8:  BNE  AUDDO_35               ;?END OF ALL PHRASES?
LFCBA:  STA  ,X                     ;THEN TURN OFF AUDIO POINTER
LFCBC:  STA  AUS_PNT+1,X
LFCBE:  STA  4,X                    ;ESB: and forget the last value written
LFCC0:  BRA  LFCD4                  ;J TURN OFF CHANNEL

AUDDO_35:          ;---ANOTHER PHRASE EXISTS
LFCC2:  STA  AUS_RPT,X              ;REPEAT COUNT
LFCC4:  LDA  TAS_SND-TAS_IZ,Y       ;NEW CURRENT SOUND
LFCC6:  STA  AUS_SND,X
LFCC8:  BRA  AUDDO_42               ;J BEGIN NEW SOUND

AUDDO_40:          ;---ELSE CONTINUE WITH PHRASE
LFCCA:  LDA  AUS_SND,X              ;INCREMENT SOUND CHANNEL VALUE
LFCCC:  ADDA TAS_INC-TAS_IZ,Y
LFCCE:  STA  AUS_SND,X

AUDDO_42:
LFCD0:  LDA  TAS_TMR-TAS_IZ,Y       ;RESET TIMER FOR PHRASE
LFCD2:  STA  AUS_TMR,X
LFCD4:  LDA  AUS_SND,X
LFCD6:  BITB #$01                   ;odd offsets are the control registers (distortion and volume)
LFCD8:  BEQ  AUDDO_45
LFCDA:  TST  SP_DLY                 ;ESB: while the speech routine is in a pause
LFCDC:  BNE  LFCE2
LFCDE:  TST  SP_STA                 ;or talking
LFCE0:  BEQ  AUDDO_45
LFCE2:  ANDA #$0F                   ;the volume nibble
LFCE4:  LSRA                        ;half of it
LFCE5:  NEGA
LFCE6:  ADDA 4,X                    ;taken off the control value: the effect plays at half volume under speech

;A:=NEW CHANNEL VALUE
AUDDO_45:
LFCE8:  LDY  #P_BASE                ;Y-->POKEY CHANNELS
LFCEC:  STA  B,Y                    ;OFFSET IN BREG

AUDDO_55:          ;---END IFEQ
AUDDO_60:          ;---END IFNE
LFCEE:  LEAX AUS_IZ,X
LFCF0:  INCB
LFCF1:  CMPB #AUS_EQ
LFCF3:  BLO  AUDDO_10
LFCF5:  RTS
LFCF6:  .word tab_xl                ;the addresses of the 34 effect tables in the order of their routines (Atari's OFFSET POINTERS), no code reads it
LFCF8:  .word tab_xlz
LFCFA:  .word tab_pb
LFCFC:  .word tab_sh
LFCFE:  .word tab_pf
LFD00:  .word tab_sx
LFD02:  .word tab_df
LFD04:  .word tab_cr
LFD06:  .word tab_ps
LFD08:  .word tab_ss
LFD0A:  .word tab_bl
LFD0C:  .word tab_ph
LFD0E:  .word tab_pbz
LFD10:  .word tab_yea
LFD12:  .word tab_nay
LFD14:  .word tab_tst
LFD16:  .word tab_fx41
LFD18:  .word tab_fx42
LFD1A:  .word tab_fx43
LFD1C:  .word tab_fx44
LFD1E:  .word tab_fx45
LFD20:  .word tab_fx46
LFD22:  .word tab_fx47
LFD24:  .word tab_fx48
LFD26:  .word tab_fx49
LFD28:  .word tab_fx4a
LFD2A:  .word tab_fx4b
LFD2C:  .word tab_fx4c
LFD2E:  .word tab_fx4d
LFD30:  .word tab_fx4e
LFD32:  .word tab_fx4f
LFD34:  .word tab_fx50
LFD36:  .word tab_fx51
LFD38:  .word tab_fx_unused

;------------------------------------------------------------------------------
; RESET - MAINLINE
;------------------------------------------------------------------------------
RESET:
LFD3A:  JMP  INIT

;------------------------------------------------------------------------------
; MAIN - [note] Mainline loop: enable IRQ, wait for SYNC (4 ms), resetting if RAM, DP or IRQ fail; send watchdog
;   PBXS_OK to SOUT, count S_INTCT, step test tones if test switch on, then SPKIRQ, DOCMD, FM bit, AUDDO, PKDR
;------------------------------------------------------------------------------
MAIN:
LFD3D:  ANDCC #$EF                  ;CLI
LFD3F:  LDX  #$014D                 ;IRQ TIMEOUT--WAIT ABOUT 8 MILLS(12000. CYCLES)
;DO ALL THE WATCHDOG AND SAFETY THINGS THAT
;IRQ DOESN'T HAVE TIME FOR
LFD42:  LDA  S_GARBG
LFD44:  CMPA #$3F
LFD46:  BNE  RESET                  ;B RESET IF FIRST RAM BYTE GETS BLITZED
;(9 CYCLES)
LFD48:  TFR  DP,A
LFD4A:  CMPA #DPRAM/$100
LFD4C:  BNE  RESET                  ;B RESET IF DPAGE REGISTER GETS CREAMED
;(11 CYCLES)
LFD4E:  LEAX -$1,X
LFD50:  BEQ  RESET                  ;B RESET IF IRQ HASN'T BEEN WORKING (TIMED OUT)
;(8 CYCLES)
LFD52:  LSR  SYNC                   ;NOW WE CHECK IF IRQ HAS KICKED US (EVERY 4 MS)
LFD54:  BCC  LFD42                  ;CSEND  (9 CYCLES)
;HERE WE GO!!!!
LFD56:  LDA  #PBXS_OK               ;THIS IS THE WATCHDOG VALUE
LFD58:  STA  SOUT                   ;MAIN PCB CHECKS FOR THIS EVERY VG UPDATE
;AND RESETS SOUND BOARD IF NOT CORRECT
LFD5B:  INC  S_INTCT                ;COUNTER FOR EVERY 4 MILLS
LFD5D:  BNE  LFD8B                  ;IFEQ
LFD5F:  INC  S_INTHI                ;SECONDS COUNTER
LFD61:  LDA  #$03                   ;TRY EVERY 4 SECONDS
LFD63:  LDB  DG_SEQ                 ;B:=DG.SEQ
LFD65:  CMPB #DGS_VIB               ;NOT ONLY VIBRATTO OFF DURING TEST, BUT ALSO
;SEQUENCE MORE SLOWLY
LFD67:  BLO  LFD6B                  ;IFHS  ?NOT DOING TEST TONES ANYMORE?
LFD69:  LDA  #$01                   ;THEN CYCLE EVERY 2 SECONDS INSTEAD
LFD6B:  ANDA S_INTHI
LFD6D:  BNE  LFD8B                  ;IFEQ  ?EVERY 2 SECONDS?
LFD6F:  CLR  >TESTON
LFD72:  LDA  TESTSW
LFD74:  ANDA #TESTBT
LFD76:  BNE  LFD8B                  ;IFEQ  ?TEST SWITCH ON?(LO TRUE)
LFD78:  INC  >TESTON
;B:=DG.SEQ
LFD7B:  INCB
LFD7C:  CMPB #PBXS_EQ               ;the sequence runs through commands $01-$52, and $52 has no routine (see the end of PBX)
LFD7E:  BLO  LFD82                  ;IFHS  ?PAST TOP ENTRY?
LFD80:  LDB  #$01
LFD82:  STB  DG_SEQ                 ;SAVE CURRENT DIAG SEQUENCE
LFD84:  LDX  #PBX                   ;SHOW OFF NEXT PBX ROUTINE
LFD87:  ABX
LFD88:  ABX
LFD89:  JSR  [,X]                   ;ACTIVATE NEXT ROUTINE
LFD8B:  JSR  SPKIRQ                 ;START SPEECH AT FRONT
LFD8E:  JSR  DOCMD                  ;DO ANY NEW COMMANDS
;SET FM DUE TO CURRENT SOUND OUTPUT
LFD91:  LDB  PAD                    ;B:= ORIGINAL OUTPUT VALUE

MAIN_50:          ;ELSE TURN FM OFF
LFD93:  ORB  #BT3                   ;HI FALSE

MAIN_58:
LFD95:  STB  PAD                    ;SHOVE NEW FM OUT
LFD97:  LDA  S_INTCT
LFD99:  LSRA
LFD9A:  BCS  LFD9F                  ;IFCC  ?8 MILL BOUNDARY?
LFD9C:  JSR  AUDDO                  ;THEN AUDIO SPECIAL EFFECTS
LFD9F:  JSR  PKDR                   ;DONT FORGET THE MUSIC (OK, THEN JUST HUM)
LFDA2:  JSR  SPKIRQ                 ;THEN END WITH SPEECH, TWICE IN 4 MS
LFDA5:  JMP  MAIN

;------------------------------------------------------------------------------
; DOCMD - DOCMD - DO ANY NEW COMMANDS
;------------------------------------------------------------------------------
DOCMD:
LFDA8:  LDB  CMDBTM
LFDAA:  CMPB CMDTOP
LFDAC:  BEQ  LFDC7                  ;IFNE  ?SOME NEW COMMANDS IN BUFFER?
LFDAE:  INCB
LFDAF:  ANDB #$1F                   ;HANDLE WRAPAROUND
LFDB1:  STB  CMDBTM                 ;JUST HANDLE ONE NEW REQUEST PER IRQ
LFDB3:  LDX  #CMD
LFDB6:  LDB  B,X                    ;GOT OUR COMMAND
LFDB8:  LBEQ FIRQ                   ;START OVER IF ZERO COMMAND FOUND
LFDBC:  CMPB #PBXS_EQ               ;MAX NUMBER ALLOWED VIA PBX
LFDBE:  BHI  LFDC7                  ;IFLS  ?WITHIN RANGE? DROP ON FLOOR IF NOT
LFDC0:  LDX  #PBX
LFDC3:  ABX
LFDC4:  ABX                         ;WORD POINTER, 255 MAX ENTRIES
LFDC5:  JSR  [,X]                   ;ACTIVATE THE ROUTINE REQUESTED
LFDC7:  RTS

;------------------------------------------------------------------------------
; IRQ - RIRQ - REAL IRQ ROUTINE
;   SETUP OUR FAST COMMAND HANDLER
;   (also: RIRQ)
;------------------------------------------------------------------------------
IRQ:
RIRQ:
LFDC8:  LDB  CMDTOP                 ;B:=DISP TO LATEST COMMAND
LFDCA:  LDX  #CMD                   ;X-->STORE COMMANDS IN THIS BUFFER
LFDCD:  LDA  PAD                    ;SAFER TO USE PRESENCE BIT RATHER THAN EDGE BIT
LFDCF:  BPL  LFDDB                  ;IFMI  ?MAINLINE HAVE NEW BYTE FOR US?
;[LDA RIF] ;RIF CLEARS PIA7 EDGE, DONE IN TIMER SECTION
LFDD1:  LDA  SIN                    ;GET THE COMMAND
;TELL OTHER BOARD RIGHT AWAY
;DONT SLOW HIM DOWN
LFDD4:  BEQ  FIRQ                   ;SUPERCOMMAND ZERO SAYS RESET RIGHT NOW
;X-->COMMAND BUFFER
;B:= DISP INTO COMMAND BUFFER, LATEST COMMAND
LFDD6:  INCB
LFDD7:  ANDB #$1F                   ;ROOM FOR PRECISELY 32.
LFDD9:  STA  B,X
;NOW FOR SOME FAST FOOTWORK TO HANDLE
;FAST SEQUENTIAL REQUESTS
;AND OUR SLOW IRQ LATENCY
;X-->COMMAND BUFFER
;B:= DISP INTO COMMAND BUFFER, LATEST COMMAND
;FIRST HANDLE ANY TIMER INTERRUPT
LFDDB:  LDA  RIF                    ;RIF D7==>TIMER, D6==>PIA GOT SOME NEW DATA
;READING CLEARS PIA FLAG
;***THIS WILL CLEAR ANY PREVIOUS NEW DATA IRQ
LFDDD:  BPL  RIRQ_80                ;IFMI  ?TIMER CAUSED?
LFDDF:  LDA  #$06                   ;MAKE INTO 4 MS
LFDE1:  STA  E1024T                 ;START UP THE TIMER AGAIN
LFDE3:  INC  SYNC                   ;KICK THE MAINLINE
LFDE5:  BVS  FIRQ                   ;B RESET US IF MAINLINE IS STUCK

;X-->COMMAND BUFFER
;B:= DISP INTO COMMAND BUFFER, LATEST COMMAND
RIRQ_80:
LFDE7:  LDA  PAD                    ;CHECK MAIN BYTE FLAG (SAFER THAN PIA7 EDGE)
LFDE9:  BPL  LFDF9                  ;IFMI  ?ANOTHER COMMAND WAITING?
LFDEB:  LDA  RIF                    ;CLEAR ANY PIA7 EDGE TO CLEAR THE IRQ
LFDED:  LDA  SIN                    ;MUST CLEAR PIA7 EDGE BEFORE TELLING MAIN PCB
LFDF0:  BEQ  FIRQ                   ;RESET IF SUPERCOMMAND 0 IS SENT
;X-->COMMAND BUFFER
;B:= DISP INTO COMMAND BUFFER, LATEST COMMAND
LFDF2:  INCB                        ;NEXT LOC
LFDF3:  ANDB #$1F                   ;HANDLE WRAPAROUND
LFDF5:  STA  B,X
LFDF7:  BRA  RIRQ_80                ;LOOP AGAIN QUICKLY TO HANDLE SEQUENTIAL REQUESTS
;X-->COMMAND BUFFER
;B:= DISP INTO COMMAND BUFFER, LATEST COMMAND
LFDF9:  STB  CMDTOP                 ;SAVE OUR TOP OF COMMAND POINTER
LFDFB:  RTI

;------------------------------------------------------------------------------
; FIRQ - INIT - RESET INITIALISER
;   INITIALISE
;   (also: NMI, SWI0, SWI2, SWI3, INIT)
;------------------------------------------------------------------------------
FIRQ:
INIT:
NMI:
SWI0:
SWI2:
SWI3:
LFDFC:  ORCC #$10                   ;SEI  JUST HOPE THE PROCESSOR AT LEAST FUNCTIONS
LFDFE:  LDA  SIN                    ;MAIN BOARD DIAG, CLEAR INPUT
LFE01:  LDS  #$107F                 ;STACK WILL BE IN 6532 RAM
LFE05:  LDA  #DPRAM/$100
LFE07:  TFR  A,DP                   ;DIRECT PAGE WILL ALSO BE IN 6532 RAM
LFE09:  LDA  #$FF                   ;SET UP PBD AS OUTPUTS
LFE0B:  STA  PBDD
LFE0D:  STA  PBD                    ;ALL ONES IS THE SAFEST
LFE0F:  STA  PAD                    ;MAKE SURE CONTROL STROBES ARE HIGH
LFE11:  LDB  #$2B                   ;SET UP PAD
LFE13:  STB  PADD
;PROVIDE SLOP TIME FOR MAIN DIAG
LFE15:  LDX  #P_SND                 ;INIT POKEYS
LFE18:  LDD  #$0000

INIT_20:
LFE1B:  STD  ,X++
LFE1D:  CMPX #P_SNDZ_1820
LFE20:  BLO  INIT_20
LFE22:  LDA  SIN                    ;MAIN BOARD DIAG -- LOOP BACK DATA
LFE25:  STA  SOUT
LFE28:  LDX  #RAM                   ;CLEAR RAM
LFE2B:  LDD  #$0000

INIT_10:
LFE2E:  STD  ,X++
LFE30:  CMPX #RAMZ
LFE33:  BLO  INIT_10
LFE35:  LDX  #DPRAM
LFE38:  STD  ,X++
LFE3A:  CMPX #DPRAMZ
LFE3D:  BLO  LFE38                  ;HSEND
LFE3F:  STA  P_BGN1                 ;BEGIN POKEY INIT-ALLOW TIME TO SETTLE.
LFE42:  STA  P_BGN2
LFE45:  STA  P_BGN3
LFE48:  STA  P_BGN4
LFE4B:  STA  P_ACT1
LFE4E:  STA  P_ACT2
LFE51:  STA  P_ACT3
LFE54:  STA  P_ACT4
LFE57:  LDA  #$07                   ;FAST SCAN
LFE59:  STA  P_BGN1
LFE5C:  STA  P_BGN2                 ;FINISH POKEY INIT
LFE5F:  STA  P_BGN3
LFE62:  STA  P_BGN4
LFE65:  LDA  TESTSW                 ;TEST SWITCH ON?
LFE67:  ANDA #TESTBT
LFE69:  BNE  LFE6D                  ;IFEQ  YES
LFE6B:  BRA  TEST
LFE6D:  LDA  #$3F                   ;TRAP OUT FIRST BYTE RAM
LFE6F:  STA  S_GARBG
LFE71:  JSR  ISND                   ;PM MUSIC INITIALIZOR
LFE74:  JSR  SPKRES                 ;RESET SPEECH CHIP/ROUTINE
LFE77:  LDA  RIF                    ;MAKE SURE PA7 FLAG IS RESET
LFE79:  LDA  SIN                    ;AND THEN CLEAR MAINFLAG SO MAIN PCB CAN TALK AGAIN
LFE7C:  LDA  #PBXS_OK               ;OK VAL FOR THIS VERSION
LFE7E:  STA  SOUT                   ;TELL CURIOUS MAIN PCB THAT WE ARE GOING AGAIN
LFE81:  LDA  #$06                   ;SET UP 4 MS IRQ TIMER
LFE83:  STA  E1024T
LFE85:  STA  EIPED                  ;ENABLE PA7 INTERRUPTS WITH POSITIVE EDGE DETECTS
LFE87:  JMP  MAIN

;.SBTTL SELF TEST
TRAMP:          ;TABLE OF RAM POINTERS FOR TEST
LFE8A:  .word RAM, RAM+$800         ;2K*8
LFE8E:  .byte $01                   ;ERROR CODE
LFE8F:  .word DPRAM, DPRAM+$80      ;128.*8
LFE93:  .byte $02                   ;ERROR CODE

TRAMPZ:
TROMP:          ;TABLE OF ROM POINTERS
LFE94:  .word ROM0                  ;8K*8
LFE96:  .word $C000, $6000, $E000   ;ESB tests the ROMs as two pairs of 8K blocks, each pair summed into one word: $4000 with $C000 (136031-113) and $6000 with $E000 (136031-112)

;------------------------------------------------------------------------------
; TEST - TEST ROUTINE
;   RAM TEST FIRST
;------------------------------------------------------------------------------
TEST:
LFE9C:  LDA  #$00                   ;SET FLAG FOR NO ERRORS
LFE9E:  LDU  #TRAMP
LFEA1:  LDX  ,U                     ;STARTING ADDRESS
LFEA3:  LEAY 1,X                    ;STARTING PATTERN IS ADDRESS + 1
LFEA5:  STY  ,X++                   ;STORE ADDRESS IN RAM
LFEA8:  LEAY -$FF,Y                 ;NEXT PATTERN
LFEAC:  CMPX 2,U
LFEAE:  BLO  LFEA5                  ;HSEND
LFEB0:  LDX  ,U                     ;STARTING ADDRESS
LFEB2:  LEAY 1,X                    ;STARTING PATTERN
LFEB4:  CMPY ,X++                   ;CHECK RAM FOR DATA STORED
LFEB7:  BEQ  LFEBB                  ;IFNE  ERROR -- SET APPROPRIATE BIT
LFEB9:  ORA  4,U                    ;OR I ERROR CODE
LFEBB:  LEAY -$FF,Y                 ;NEXT WORD
LFEBF:  CMPX 2,U                    ;ENDING ADDRESS?
LFEC1:  BLO  LFEB4                  ;HSEND  IF SO, DONE

TEST_50:
LFEC3:  LEAU 5,U                    ;DO NEXT RAM
LFEC5:  CMPU #TRAMPZ                ;END OF RAM TABLE?
LFEC9:  BLO  LFEA1                  ;HSEND
;ROM TEST
LFECB:  TFR  D,S                    ;SAVE CURRENT ERRORS
LFECD:  LDU  #TROMP                 ;TABLE OF ROMS
LFED0:  LDX  ,U++                   ;STARTING ADDRESS
LFED2:  TFR  X,D                    ;USE STARTING ADDRESS AS SEED
LFED4:  LDY  #$2000                 ;8K, counted in words
LFED8:  ANDCC #$FE                  ;sum with end-around carry
LFEDA:  ADDD ,X++
LFEDC:  ADCB #$00
LFEDE:  ADCA #$00
LFEE0:  LEAY -2,Y
LFEE2:  BNE  LFEDA
LFEE4:  LDX  ,U++                   ;the second block of the pair goes into the same sum
LFEE6:  LDY  #$2000
LFEEA:  ADDD ,X++
LFEEC:  ADCB #$00
LFEEE:  ADCA #$00
LFEF0:  LEAY -2,Y
LFEF2:  BNE  LFEEA
LFEF4:  ADDD #$0001                 ;a good pair sums to $FFFF
LFEF7:  STD  $016C,U                ;U + $16C wraps to $0004 and then $0008, in the SOUT range: the sum is written to the latch of the main board (Star Wars stored it in the ROM for a logic analyzer), zero = good
LFEFB:  BEQ  LFF0D                  ;IFNE  ERROR
LFEFD:  TFR  S,D                    ;RETRIEVE ERRORS TO DATE
LFEFF:  CMPU #TEST                  ;U = TROMP + 4 after the first pair, TEST after the second
LFF03:  BHS  LFF09                  ;IFLO  ROM 0
LFF05:  ORA  #$04
LFF07:  BRA  LFF0B                  ;ELSE  ROM 1
LFF09:  ORA  #$08
LFF0B:  TFR  D,S                    ;SAVE IT IN Y AGAIN
LFF0D:  CMPU #TEST                  ;DONE?
LFF11:  BLO  LFED0                  ;HSEND
;REPORT ERRORS/NON-ERRORS VIA POKEY
LFF13:  TFR  S,D                    ;GET ERRORS IN A
LFF15:  LDB  #$03
LFF17:  LSRA                        ;SHIFT CODE TO CARRY
LFF18:  BCC  LFF22                  ;IFCS  ERROR
LFF1A:  LDU  #$CFA8                 ;LOW TONE ON POKEY 0 MEANS ERROR
LFF1D:  STU  P_SND                  ;POKEY 0 VOICE 0
LFF20:  BRA  LFF28                  ;ELSE
LFF22:  LDU  #$20A8                 ;HI TONE ON POKEY 1 MEANS OK
LFF25:  STU  P_SND+$A               ;POKEY 1 VOICE 1
LFF28:  LDX  #$8000                 ;DELAY WHILE SOUND IS ON
LFF2B:  LEAX -$1,X
LFF2D:  BNE  LFF2B                  ;EQEND
LFF2F:  LDU  #$0000                 ;TURN OFF SOUNDS
LFF32:  STU  P_SND
LFF35:  STU  P_SND+$A
LFF38:  LDX  #$8000                 ;NOW DELAY FOR THE QUIET
LFF3B:  TSTB
LFF3C:  BNE  LFF42                  ;IFEQ  LAST DELAY, MAKE IT A LONG ONE
LFF3E:  LEAX $7FFF,X
LFF42:  LEAX -$1,X
LFF44:  BNE  LFF42                  ;EQEND
LFF46:  DECB                        ;DONE WITH ALL DEVICES
LFF47:  BPL  LFF17                  ;MIEND
LFF49:  JMP  RESET

;.SBTTL SNDPBX - XMT,RCV ROUTINE TAGS
PBX:
LFF4C:  .word RESET                 ;ENTRY 0 DOES A RESET
LFF4E:  .word aud_test_tones        ;command $01: aud_test_tones, the test tones on the eight effect channels
LFF50:  .word PMTST                 ;command $02: PMTST, the test tones on the four music voices (tunes 11-14)
LFF52:  .word spk_cmd_03            ;command $03: speech, phrase 10
LFF54:  .word spk_cmd_04            ;command $04: speech, phrase 15
LFF56:  .word spk_cmd_05            ;command $05: speech, phrase 9
LFF58:  .word spk_cmd_06            ;command $06: speech, phrase 1, only when no speech is under way
LFF5A:  .word spk_cmd_07            ;command $07: speech, phrase 3
LFF5C:  .word spk_cmd_08            ;command $08: speech, phrase 23
LFF5E:  .word spk_cmd_09            ;command $09: speech, phrase 12
LFF60:  .word spk_cmd_0a            ;command $0A: speech, phrase 17
LFF62:  .word SPKI                  ;command $0B: SPKI, warm start of the speech chip, queued like a sentence
LFF64:  .word spk_cmd_0c            ;command $0C: speech, phrases 4, 2 and 5
LFF66:  .word spk_cmd_0d            ;command $0D: speech, phrase 6
LFF68:  .word spk_cmd_0e            ;command $0E: speech, phrase 19
LFF6A:  .word spk_cmd_0f            ;command $0F: speech, phrase 13
LFF6C:  .word spk_cmd_10            ;command $10: speech, phrase 20
LFF6E:  .word spk_cmd_11            ;command $11: speech, phrase 22
LFF70:  .word spk_cmd_12            ;command $12: speech, phrase 7
LFF72:  .word SPKSKP                ;command $13: SPKSKP, drop the speech still waiting in the queue
LFF74:  .word spk_cmd_14            ;command $14: speech, phrase 18
LFF76:  .word spk_cmd_15            ;command $15: speech, phrase 14
LFF78:  .word spk_cmd_16            ;command $16: speech, phrase 21
LFF7A:  .word spk_cmd_17            ;command $17: speech, phrase 11
LFF7C:  .word spk_cmd_18            ;command $18: speech, phrase 8
LFF7E:  .word spk_cmd_19            ;command $19: speech, phrase 24
LFF80:  .word spk_cmd_1a            ;command $1A: speech, phrase 16
LFF82:  .word spk_cmd_1b            ;command $1B: speech, phrase 32
LFF84:  .word spk_cmd_1c            ;command $1C: speech, phrase 26
LFF86:  .word spk_cmd_1d            ;command $1D: speech, phrase 29
LFF88:  .word spk_cmd_1e            ;command $1E: speech, phrases 35 and 36
LFF8A:  .word spk_cmd_1f            ;command $1F: speech, phrase 34
LFF8C:  .word spk_cmd_20            ;command $20: speech, phrase 27
LFF8E:  .word spk_cmd_21            ;command $21: speech, phrase 30
LFF90:  .word spk_cmd_22            ;command $22: speech, phrase 37
LFF92:  .word spk_cmd_23            ;command $23: speech, phrase 31
LFF94:  .word spk_cmd_24            ;command $24: speech, phrase 25
LFF96:  .word spk_cmd_25            ;command $25: speech, phrase 38
LFF98:  .word spk_cmd_26            ;command $26: speech, phrase 39
LFF9A:  .word spk_cmd_27            ;command $27: speech, phrase 33
LFF9C:  .word spk_cmd_28            ;command $28: speech, phrase 40, only when no speech is under way
LFF9E:  .word PMTHB                 ;command $29: PMTHB, tunes 35-38: music whose melody is not identified, sent by the asteroid wave's setup
LFFA0:  .word PMBEN                 ;command $2A: PMBEN, tunes 7-10: Ben's theme, sent when a Jedi letter is awarded
LFFA2:  .word PMEND                 ;command $2B: PMEND, tunes 15-18: the Imperial March, sent by the wave 2 setup
LFFA4:  .word PMRRP                 ;command $2C: PMRRP, tunes 23-26: music whose melody is not identified, sent by the wave 3 setup
LFFA6:  .word PMSF2                 ;command $2D: PMSF2, tunes 1-4: the special effect of descending semitone scales, no called stub of the main program sends it
LFFA8:  .word PMTH5                 ;command $2E: PMTH5, tunes 27-30: the Star Wars main theme, sent by the wave 1 setup
LFFAA:  .word PMDAR                 ;command $2F: PMDAR, tunes 43-46: the Imperial March's rhythm figure looped, sent by the launch sequence
LFFAC:  .word PMDES                 ;command $30: PMDES, tunes 39-42: music that looks like Yoda's theme, sent when the game ends
LFFAE:  .word PM4TH                 ;command $31: PM4TH, tunes 31-34: music whose melody is not identified, sent when the initials entry starts
LFFB0:  .word aud_crash             ;command $32: effect tab_cr, Atari's CR0: crash into bridge or tower
LFFB2:  .word aud_final_expl        ;command $33: effect tab_df, Atari's DF0: Death Star final explosion
LFFB4:  .word aud_nay               ;command $34: effect tab_nay, Atari's NAY0: nay, test failed
LFFB6:  .word aud_start_35          ;command $35: effect tab_pb, Atari's PB0: pass-by
LFFB8:  .word aud_start_36          ;command $36: effect tab_pbz, Atari's PBZ0: end of the pass-by sound
LFFBA:  .word aud_start_37          ;command $37: effect tab_pf, Atari's PF0: tower pfffts
LFFBC:  .word aud_port_hole         ;command $38: effect tab_ph, Atari's PH0: port hole shot
LFFBE:  .word aud_passby_short      ;command $39: effect tab_ps, Atari's PS0: short pass-by
LFFC0:  .word aud_start_3a          ;command $3A: effect tab_sh, Atari's SH0: shield
LFFC2:  .word aud_shoot_shots       ;command $3B: effect tab_ss, Atari's SS0: shoot shots
LFFC4:  .word aud_small_expl        ;command $3C: effect tab_sx, Atari's SX0: small explosion
LFFC6:  .word aud_tie_cannon        ;command $3D: effect tab_xl, Atari's XL0 data, which Star Wars's AUDTC (TIE fighter cannon) plays
LFFC8:  .word aud_tie_cannon_off    ;command $3E: effect tab_xlz, ends the sound of command $3D (Star Wars's AUDTCZ)
LFFCA:  .word aud_start_3f          ;command $3F: effect tab_bl, Atari's BL0, player's laser blast (Star Wars's AUDXL)
LFFCC:  .word aud_yea               ;command $40: effect tab_yea, Atari's YEA0: yea, test successful
LFFCE:  .word aud_fx41              ;command $41: effect tab_fx41: 2 channels, distortion $00, $20, $80 (noise), about 0.4 s
LFFD0:  .word aud_fx42              ;command $42: effect tab_fx42: 1 channel, distortion $60, about 0.4 s
LFFD2:  .word aud_fx43              ;command $43: effect tab_fx43: 2 channels, distortion $A0 (pure tone), about 2.5 s
LFFD4:  .word aud_fx44              ;command $44: effect tab_fx44: silences chip 0 channel 1, chip 0 channel 2
LFFD6:  .word aud_fx45              ;command $45: effect tab_fx45: 2 channels, distortion $60, $80 (noise), about 6.1 s
LFFD8:  .word aud_fx46              ;command $46: effect tab_fx46: 2 channels, distortion $A0 (pure tone), about 0.8 s
LFFDA:  .word aud_fx47              ;command $47: effect tab_fx47: 3 channels, distortion $80 (noise), about 4.8 s
LFFDC:  .word aud_fx48              ;command $48: effect tab_fx48: 1 channel, distortion $00, about 1.1 s
LFFDE:  .word aud_fx49              ;command $49: effect tab_fx49: 2 channels, distortion $40, $80 (noise), about 0.9 s
LFFE0:  .word aud_fx4a              ;command $4A: effect tab_fx4a: 2 channels, distortion $60, $80 (noise), about 4.5 s
LFFE2:  .word aud_fx4b              ;command $4B: effect tab_fx4b: 1 channel, distortion $80 (noise), about 2.8 s
LFFE4:  .word aud_fx4c              ;command $4C: effect tab_fx4c: 2 channels, distortion $A0 (pure tone), about 0.7 s
LFFE6:  .word aud_fx4d              ;command $4D: effect tab_fx4d: 1 channel, distortion $80 (noise), $A0 (pure tone), about 0.2 s
LFFE8:  .word aud_start_4e          ;command $4E: effect tab_fx4e: 2 channels, distortion $60, $80 (noise), $A0 (pure tone), about 0.9 s
LFFEA:  .word aud_start_4f          ;command $4F: effect tab_fx4f: 1 channel, distortion $20, about 0.9 s
LFFEC:  .word aud_start_50          ;command $50: effect tab_fx50: 1 channel, distortion $00, $A0 (pure tone), about 6.1 s
LFFEE:  .word aud_fx51              ;command $51: effect tab_fx51: 2 channels, distortion $00, $80 (noise), about 1.1 s
LFFF0:  .word $9CA7                 ;not a table entry: by its place the checksum word of this ROM, as at $7FF0 in Star Wars - both sums of TEST come out right with it. DOCMD and the test sequence of MAIN still take command $52 through it, to $9CA7, where there is no ROM
LFFF2:  .word FIRQ                  ;the 6809 vectors: SWI3, SWI2, FIRQ, IRQ, SWI, NMI, RESET. as DOCMD lets command $53 through, that command jumps through the first of them to INIT
LFFF4:  .word FIRQ
LFFF6:  .word FIRQ
LFFF8:  .word IRQ
LFFFA:  .word FIRQ
LFFFC:  .word FIRQ
LFFFE:  .word RESET
