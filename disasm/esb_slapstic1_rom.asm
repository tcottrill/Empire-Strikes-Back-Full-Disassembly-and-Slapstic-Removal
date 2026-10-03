;The Empire Strikes Back (Atari, 1985) - annotated disassembly of slapstic
;page 1 of $8000-$9FFF (MAME 'esb': the second half of 136031-105.3u).
;The slapstic 137412-101 selects one of four pages here; see slapstic.py and
;docs/SLAPSTIC.md.  $8000-$80FF (the page-select stubs) is the same on every
;page; $8100-$85EB is the maze, different on every page.  Code here runs with
;bank 0 selected, so L labels are bank 0's.
;Names and upper-case comments are Atari's, carried over from the Star Wars
;source wherever this code is the same instruction for instruction (swmatch.py);
;everything in lower case was written for this disassembly.
;Every line below was re-encoded and byte-compared with the ROM (verify.py).
;Syntax: Motorola 6809 mnemonics and operands; .alias, .byte, .word (big-endian);
;( ) groups expressions; ~ is one's complement, | is OR, ^ is exclusive OR.
;.dpage gives the direct page the assembler assumed; < and > before an operand
;force the short and the long form.

.org $8000

.include "esb_defines.asm"

.dpage $48
P1_8000:  BITA P1_8000                ;arms the slapstic
P1_8003:  RTS
P1_8004:  BITA P1_8000
P1_8007:  RTS
P1_8008:  BITA P1_8000
P1_800B:  RTS
P1_800C:  BITA P1_8000
P1_800F:  RTS
P1_8010:  BITA P1_8000
P1_8013:  RTS
P1_8014:  BITA P1_8000
P1_8017:  RTS
P1_8018:  BITA P1_8000
P1_801B:  RTS
P1_801C:  BITA P1_8000
P1_801F:  RTS
P1_8020:  BITA P1_8000
P1_8023:  RTS
P1_8024:  BITA P1_8000
P1_8027:  RTS
P1_8028:  BITA P1_8000
P1_802B:  RTS
P1_802C:  BITA P1_8000
P1_802F:  RTS
P1_8030:  BITA P1_8000
P1_8033:  RTS
P1_8034:  BITA P1_8000
P1_8037:  RTS
P1_8038:  BITA P1_8000
P1_803B:  RTS
P1_803C:  BITA P1_8000
P1_803F:  RTS
P1_8040:  BITA P1_8000
P1_8043:  RTS
P1_8044:  BITA P1_8000
P1_8047:  RTS
P1_8048:  BITA P1_8000
P1_804B:  RTS
P1_804C:  BITA P1_8000
P1_804F:  RTS
P1_8050:  BITA P1_8000
P1_8053:  RTS
P1_8054:  BITA P1_8000
P1_8057:  RTS
P1_8058:  BITA P1_8000
P1_805B:  RTS
P1_805C:  BITA P1_8000
P1_805F:  RTS
P1_8060:  BITA P1_8000
P1_8063:  RTS
P1_8064:  BITA P1_8000
P1_8067:  RTS
P1_8068:  BITA P1_8000
P1_806B:  RTS
P1_806C:  BITA P1_8000
P1_806F:  RTS
P1_8070:  BITA P1_8000
P1_8073:  RTS
P1_8074:  BITA P1_8000
P1_8077:  RTS
P1_8078:  BITA P1_8000
P1_807B:  RTS
P1_807C:  BITA P1_8000
P1_807F:  RTS
P1_8080:  BITA P1_8000                ;arms the slapstic
P1_8083:  RTS
P1_8084:  BITA P1_8000
P1_8087:  RTS
P1_8088:  BITA P1_8000
P1_808B:  RTS
P1_808C:  BITA P1_8000
P1_808F:  RTS
P1_8090:  BITA P1_8000                ;arms the slapstic
P1_8093:  RTS
P1_8094:  BITA P1_8000
P1_8097:  RTS
P1_8098:  BITA P1_8000
P1_809B:  RTS
P1_809C:  BITA P1_8000
P1_809F:  RTS
P1_80A0:  BITA P1_8000                ;arms the slapstic
P1_80A3:  RTS
P1_80A4:  BITA P1_8000
P1_80A7:  RTS
P1_80A8:  BITA P1_8000
P1_80AB:  RTS
P1_80AC:  BITA P1_8000
P1_80AF:  RTS
P1_80B0:  BITA P1_8000                ;arms the slapstic
P1_80B3:  RTS
P1_80B4:  BITA P1_8000
P1_80B7:  RTS
P1_80B8:  BITA P1_8000
P1_80BB:  RTS
P1_80BC:  BITA P1_8000
P1_80BF:  RTS
P1_80C0:  BITA P1_8000
P1_80C3:  RTS
P1_80C4:  BITA P1_8000
P1_80C7:  RTS
P1_80C8:  BITA P1_8000
P1_80CB:  RTS
P1_80CC:  BITA P1_8000
P1_80CF:  RTS
P1_80D0:  BITA P1_8000
P1_80D3:  RTS
P1_80D4:  BITA P1_8000
P1_80D7:  RTS
P1_80D8:  BITA P1_8000
P1_80DB:  RTS
P1_80DC:  BITA P1_8000
P1_80DF:  RTS
P1_80E0:  BITA P1_8000
P1_80E3:  RTS
P1_80E4:  BITA P1_8000
P1_80E7:  RTS
P1_80E8:  BITA P1_8000
P1_80EB:  RTS
P1_80EC:  BITA P1_8000
P1_80EF:  RTS
P1_80F0:  BITA P1_8000
P1_80F3:  RTS
P1_80F4:  BITA P1_8000
P1_80F7:  RTS
P1_80F8:  BITA P1_8000
P1_80FB:  RTS
P1_80FC:  BITA P1_8000
P1_80FF:  RTS
P1_8100:  JSR  P1_8080                ;live: select page 0
P1_8103:  JSR  P1_8100                ;live
P1_8106:  JSR  P1_8080                ;decoy
P1_8109:  JSR  atst_init              ;decoy
P1_810C:  JMP  P1_8090                ;decoy
P1_810F:  JSR  P1_8106                ;decoy
P1_8112:  JSR  P1_80B0                ;live: select page 3
P1_8115:  JMP  P1_8118                ;live
P1_8118:  JSR  P1_8112                ;live
P1_811B:  JSR  P1_8A68+2              ;decoy
P1_811E:  JMP  P1_80B0                ;decoy
P1_8121:  JSR  P1_811E                ;decoy
P1_8124:  JSR  P1_8121                ;decoy
P1_8127:  JSR  P1_8121                ;decoy
P1_812A:  JSR  P1_8127                ;decoy
P1_812D:  JMP  gun_init               ;live: the routine
P1_8130:  JMP  P1_8080                ;live: select page 0
P1_8133:  JMP  P1_80A0                ;live: select page 2
P1_8136:  JMP  P1_80B0                ;live: select page 3
P1_8139:  JSR  P1_8133                ;decoy
P1_813C:  JSR  P1_8136                ;decoy
P1_813F:  JSR  P1_8139                ;decoy
P1_8142:  JSR  P1_80B0                ;live: select page 3
P1_8145:  JMP  P1_8148                ;live
P1_8148:  JSR  P1_8142                ;live
P1_814B:  JSR  P1_8612+1              ;decoy
P1_814E:  JMP  P1_80B0                ;decoy
P1_8151:  JSR  P1_8154                ;decoy
P1_8154:  JSR  P1_8151                ;decoy
P1_8157:  JMP  jedi_on_update         ;live: the routine
P1_815A:  JMP  P1_8080                ;live: select page 0
P1_815D:  JMP  P1_80A0                ;live: select page 2
P1_8160:  JMP  P1_80B0                ;live: select page 3
P1_8163:  JSR  P1_815A                ;decoy
P1_8166:  JSR  P1_8169                ;decoy
P1_8169:  JSR  P1_8166                ;decoy
P1_816C:  JMP  jedi_draw              ;live: the routine
P1_816F:  JMP  P1_8080                ;live: select page 0
P1_8172:  JMP  P1_80A0                ;live: select page 2
P1_8175:  JMP  P1_80B0                ;live: select page 3
P1_8178:  JSR  P1_817B                ;decoy
P1_817B:  JSR  P1_8175                ;decoy
P1_817E:  JSR  P1_8181                ;decoy
P1_8181:  JSR  P1_80B0                ;live: select page 3
P1_8184:  JMP  P1_8187                ;live
P1_8187:  JSR  P1_8181                ;live
P1_818A:  JSR  P1_97CA+1              ;decoy
P1_818D:  JMP  P1_80B0                ;decoy
P1_8190:  JSR  P1_8193                ;decoy
P1_8193:  JSR  P1_80A0                ;live: select page 2
P1_8196:  JMP  P1_8199                ;live
P1_8199:  JSR  P1_8193                ;live
P1_819C:  JSR  P1_8FB7                ;decoy
P1_819F:  JMP  P1_80A0                ;decoy
P1_81A2:  JMP  P1_81A8                ;decoy
P1_81A5:  JSR  P1_81A2                ;decoy
P1_81A8:  JSR  P1_80B0                ;live: select page 3
P1_81AB:  JMP  P1_81AE                ;live
P1_81AE:  JSR  P1_81A8                ;live
P1_81B1:  JSR  P1_98D1+2              ;decoy
P1_81B4:  JMP  P1_80B0                ;decoy
P1_81B7:  JMP  P1_81BD                ;decoy
P1_81BA:  JSR  P1_81B1                ;decoy
P1_81BD:  JSR  P1_81B7                ;decoy
P1_81C0:  JSR  P1_8090                ;live: select page 1
P1_81C3:  JSR  atst_fire              ;live: the routine
P1_81C6:  JMP  P1_8090                ;live: select page 1
P1_81C9:  JSR  P1_81C3                ;decoy
P1_81CC:  JSR  P1_81C6                ;decoy
P1_81CF:  JSR  P1_81CC                ;decoy
P1_81D2:  JMP  VWGUN                  ;live: the routine
P1_81D5:  JMP  P1_8080                ;live: select page 0
P1_81D8:  JMP  P1_80A0                ;live: select page 2
P1_81DB:  JMP  P1_80B0                ;live: select page 3
P1_81DE:  JSR  P1_81D8                ;decoy
P1_81E1:  JSR  P1_81DE                ;decoy
P1_81E4:  JMP  jedi_award             ;live: the routine
P1_81E7:  JMP  P1_8080                ;live: select page 0
P1_81EA:  JMP  P1_80A0                ;live: select page 2
P1_81ED:  JMP  P1_80B0                ;live: select page 3
P1_81F0:  JSR  P1_81EA                ;decoy
P1_81F3:  JMP  P1_81F9                ;decoy
P1_81F6:  JSR  P1_80B0                ;live: select page 3
P1_81F9:  JMP  P1_81FC                ;live
P1_81FC:  JSR  P1_81F6                ;live
P1_81FF:  JSR  P1_8674                ;decoy
P1_8202:  JMP  P1_80B0                ;decoy
P1_8205:  JSR  P1_8208                ;decoy
P1_8208:  JSR  P1_8202                ;decoy
P1_820B:  JSR  P1_8208                ;decoy
P1_820E:  JSR  P1_8080                ;decoy
P1_8211:  JSR  P1_820E                ;decoy
P1_8214:  JSR  P1_8080                ;decoy
P1_8217:  JSR  P1_9914+1              ;decoy
P1_821A:  JMP  P1_8090                ;decoy
P1_821D:  JSR  P1_8217                ;decoy
P1_8220:  JSR  P1_80A0                ;decoy
P1_8223:  JSR  P1_89AA+2              ;decoy
P1_8226:  JMP  P1_8090                ;decoy
P1_8229:  JSR  P1_822C                ;decoy
P1_822C:  JSR  P1_8229                ;decoy
P1_822F:  JMP  man_atst_init          ;live: the routine
P1_8232:  JMP  P1_8080                ;live: select page 0
P1_8235:  JMP  P1_80A0                ;live: select page 2
P1_8238:  JMP  P1_80B0                ;live: select page 3
P1_823B:  JSR  P1_8235                ;decoy
P1_823E:  JMP  P1_8244                ;decoy
P1_8241:  JSR  P1_823E                ;decoy
P1_8244:  JSR  P1_8080                ;live: select page 0
P1_8247:  JSR  P1_8244                ;live
P1_824A:  JSR  P1_8080                ;decoy
P1_824D:  JSR  jedi_clear             ;decoy
P1_8250:  JMP  P1_8090                ;decoy
P1_8253:  JSR  P1_824A                ;decoy
P1_8256:  JSR  P1_8259                ;decoy
P1_8259:  JSR  P1_80A0                ;live: select page 2
P1_825C:  JMP  P1_825F                ;live
P1_825F:  JSR  P1_8259                ;live
P1_8262:  JSR  man_atst_tab+4         ;decoy
P1_8265:  JMP  P1_80A0                ;decoy
P1_8268:  JSR  P1_8262                ;decoy
P1_826B:  JSR  P1_8268                ;decoy
P1_826E:  JSR  P1_8271                ;decoy
P1_8271:  JSR  P1_826E                ;decoy
P1_8274:  JMP  xmit_got_through       ;live: the routine
P1_8277:  JMP  P1_8080                ;decoy
P1_827A:  JMP  P1_80A0                ;decoy
P1_827D:  JMP  P1_80B0                ;live: select page 3
P1_8280:  JSR  P1_8283                ;decoy
P1_8283:  JSR  P1_8280                ;decoy
P1_8286:  JMP  probot_ind_init        ;live: the routine
P1_8289:  JMP  P1_8080                ;live: select page 0
P1_828C:  JMP  P1_80A0                ;live: select page 2
P1_828F:  JMP  P1_80B0                ;live: select page 3
P1_8292:  JSR  P1_8295                ;decoy
P1_8295:  JSR  P1_8090                ;live: select page 1
P1_8298:  JSR  probot_fire            ;live: the routine
P1_829B:  JMP  P1_8090                ;live: select page 1
P1_829E:  JSR  P1_82A1                ;decoy
P1_82A1:  JMP  P1_82A7                ;decoy
P1_82A4:  JSR  P1_80B0                ;live: select page 3
P1_82A7:  JMP  P1_82AA                ;live
P1_82AA:  JSR  P1_82A4                ;live
P1_82AD:  JSR  atst_init              ;decoy
P1_82B0:  JMP  P1_80B0                ;decoy
P1_82B3:  JSR  P1_82AD                ;decoy
P1_82B6:  JSR  P1_8080                ;decoy
P1_82B9:  JSR  P1_82B6                ;decoy
P1_82BC:  JSR  P1_8080                ;decoy
P1_82BF:  JSR  P1_958F+1              ;decoy
P1_82C2:  JMP  P1_8090                ;decoy
P1_82C5:  JMP  P1_82CB                ;decoy
P1_82C8:  JSR  P1_82C5                ;decoy
P1_82CB:  JMP  vw_wave_ind            ;live: the routine
P1_82CE:  JMP  P1_8080                ;live: select page 0
P1_82D1:  JMP  P1_80A0                ;live: select page 2
P1_82D4:  JMP  P1_80B0                ;live: select page 3
P1_82D7:  JSR  P1_82DA                ;decoy
P1_82DA:  JSR  P1_82D7                ;decoy
P1_82DD:  JMP  P1_82E3                ;decoy
P1_82E0:  JSR  P1_80B0                ;live: select page 3
P1_82E3:  JMP  P1_82E6                ;live
P1_82E6:  JSR  P1_82E0                ;live
P1_82E9:  JSR  P1_8A91+2              ;decoy
P1_82EC:  JMP  P1_80B0                ;decoy
P1_82EF:  JSR  P1_82E6                ;decoy
P1_82F2:  JSR  P1_82EC                ;decoy
P1_82F5:  JSR  P1_82F8                ;decoy
P1_82F8:  JSR  P1_8090                ;decoy
P1_82FB:  JSR  P1_9CF2                ;decoy
P1_82FE:  JMP  P1_8090                ;decoy
P1_8301:  JSR  P1_8304                ;decoy
P1_8304:  JSR  P1_80B0                ;live: select page 3
P1_8307:  JMP  P1_830A                ;live
P1_830A:  JSR  P1_8304                ;live
P1_830D:  JSR  jedi_clear             ;decoy
P1_8310:  JMP  P1_80B0                ;decoy
P1_8313:  JMP  P1_8319                ;decoy
P1_8316:  JSR  P1_80B0                ;live: select page 3
P1_8319:  JMP  P1_831C                ;live
P1_831C:  JSR  P1_8316                ;live
P1_831F:  JSR  P1_8E26+1              ;decoy
P1_8322:  JMP  P1_80B0                ;decoy
P1_8325:  JSR  P1_8328                ;decoy
P1_8328:  JSR  P1_832B                ;decoy
P1_832B:  JSR  P1_8080                ;live: select page 0
P1_832E:  JSR  P1_832B                ;live
P1_8331:  JSR  P1_8080                ;decoy
P1_8334:  JSR  P1_8918+2              ;decoy
P1_8337:  JMP  P1_8090                ;decoy
P1_833A:  JSR  P1_8337                ;decoy
P1_833D:  JSR  P1_8337                ;decoy
P1_8340:  JMP  P1_8346                ;decoy
P1_8343:  JSR  P1_80A0                ;decoy
P1_8346:  JMP  P1_8349                ;decoy
P1_8349:  JSR  P1_8343                ;decoy
P1_834C:  JSR  P1_9C15+1              ;decoy
P1_834F:  JMP  P1_80A0                ;decoy
P1_8352:  JSR  P1_8355                ;decoy
P1_8355:  JSR  P1_80B0                ;decoy
P1_8358:  JMP  P1_835B                ;decoy
P1_835B:  JSR  P1_8355                ;decoy
P1_835E:  JSR  atst_body_hit+2        ;decoy
P1_8361:  JMP  P1_80B0                ;decoy
P1_8364:  JMP  P1_836A                ;decoy
P1_8367:  JSR  P1_80B0                ;live: select page 3
P1_836A:  JMP  P1_836D                ;live
P1_836D:  JSR  P1_8367                ;live
P1_8370:  JSR  P1_8A68+2              ;decoy
P1_8373:  JMP  P1_80B0                ;decoy
P1_8376:  JSR  P1_8379                ;decoy
P1_8379:  JSR  P1_837C                ;decoy
P1_837C:  JSR  P1_80A0                ;live: select page 2
P1_837F:  JMP  P1_8382                ;live
P1_8382:  JSR  P1_837C                ;live
P1_8385:  JSR  P1_877B+1              ;decoy
P1_8388:  JMP  P1_80A0                ;decoy
P1_838B:  JSR  P1_8385                ;decoy
P1_838E:  JSR  P1_8080                ;live: select page 0
P1_8391:  JSR  P1_838E                ;live
P1_8394:  JSR  P1_8080                ;decoy
P1_8397:  JSR  P1_8674                ;decoy
P1_839A:  JMP  P1_8090                ;decoy
P1_839D:  JSR  P1_8397                ;decoy
P1_83A0:  JSR  P1_80B0                ;live: select page 3
P1_83A3:  JMP  P1_83A6                ;live
P1_83A6:  JSR  P1_83A0                ;live
P1_83A9:  JSR  P1_98E8                ;decoy
P1_83AC:  JMP  P1_80B0                ;decoy
P1_83AF:  JSR  P1_83A9                ;decoy
P1_83B2:  JSR  P1_83B5                ;decoy
P1_83B5:  JSR  P1_83B2                ;decoy
P1_83B8:  JMP  walker_ind_init        ;live: the routine
P1_83BB:  JMP  P1_8080                ;live: select page 0
P1_83BE:  JMP  P1_80A0                ;live: select page 2
P1_83C1:  JMP  P1_80B0                ;live: select page 3
P1_83C4:  JSR  P1_83C1                ;decoy
P1_83C7:  JSR  P1_80B0                ;live: select page 3
P1_83CA:  JMP  P1_83CD                ;live
P1_83CD:  JSR  P1_83C7                ;live
P1_83D0:  JSR  P1_98D1+2              ;decoy
P1_83D3:  JMP  P1_80B0                ;decoy
P1_83D6:  JSR  P1_83D0                ;decoy
P1_83D9:  JMP  P1_83DF                ;decoy
P1_83DC:  JSR  P1_8080                ;live: select page 0
P1_83DF:  JSR  P1_83DC                ;live
P1_83E2:  JSR  P1_8080                ;decoy
P1_83E5:  JSR  P1_9614                ;decoy
P1_83E8:  JMP  P1_8090                ;decoy
P1_83EB:  JSR  P1_83E5                ;decoy
P1_83EE:  JSR  P1_80B0                ;live: select page 3
P1_83F1:  JMP  P1_83F4                ;live
P1_83F4:  JSR  P1_83EE                ;live
P1_83F7:  JSR  P1_9838                ;decoy
P1_83FA:  JMP  P1_80B0                ;decoy
P1_83FD:  JSR  P1_8400                ;decoy
P1_8400:  JSR  P1_83FD                ;decoy
P1_8403:  JMP  jedi_time_run          ;live: the routine
P1_8406:  JMP  P1_8080                ;live: select page 0
P1_8409:  JMP  P1_80A0                ;live: select page 2
P1_840C:  JMP  P1_80B0                ;live: select page 3
P1_840F:  JSR  P1_8409                ;decoy
P1_8412:  JSR  P1_840F                ;decoy
P1_8415:  JSR  P1_840F                ;decoy
P1_8418:  JSR  P1_80A0                ;live: select page 2
P1_841B:  JMP  P1_841E                ;live
P1_841E:  JSR  P1_8418                ;live
P1_8421:  JSR  jedi_rate_tab+3        ;decoy
P1_8424:  JMP  P1_80A0                ;decoy
P1_8427:  JSR  P1_8424                ;decoy
P1_842A:  JSR  P1_8427                ;decoy
P1_842D:  JMP  jedi_clear             ;live: the routine
P1_8430:  JMP  P1_8080                ;live: select page 0
P1_8433:  JMP  P1_80A0                ;live: select page 2
P1_8436:  JMP  P1_80B0                ;live: select page 3
P1_8439:  JSR  P1_8430                ;decoy
P1_843C:  JSR  P1_80B0                ;live: select page 3
P1_843F:  JMP  P1_8442                ;live
P1_8442:  JSR  P1_843C                ;live
P1_8445:  JSR  P1_9989                ;decoy
P1_8448:  JMP  P1_80B0                ;decoy
P1_844B:  JSR  P1_844E                ;decoy
P1_844E:  JMP  P1_8454                ;decoy
P1_8451:  JSR  P1_80A0                ;decoy
P1_8454:  JMP  P1_8457                ;decoy
P1_8457:  JSR  P1_8451                ;decoy
P1_845A:  JSR  P1_92EE                ;decoy
P1_845D:  JMP  P1_80A0                ;decoy
P1_8460:  JSR  P1_8463                ;decoy
P1_8463:  JSR  P1_80B0                ;live: select page 3
P1_8466:  JMP  P1_8469                ;live
P1_8469:  JSR  P1_8463                ;live
P1_846C:  JSR  P1_9B6D                ;decoy
P1_846F:  JMP  P1_80B0                ;decoy
P1_8472:  JSR  P1_846C                ;decoy
P1_8475:  JSR  P1_8478                ;decoy
P1_8478:  JSR  P1_846F                ;decoy
P1_847B:  JSR  P1_8080                ;live: select page 0
P1_847E:  JSR  P1_847B                ;live
P1_8481:  JSR  P1_8080                ;decoy
P1_8484:  JSR  P1_8705                ;decoy
P1_8487:  JMP  P1_8090                ;decoy
P1_848A:  JSR  P1_8487                ;decoy
P1_848D:  JSR  P1_8487                ;decoy
P1_8490:  JMP  P1_8496                ;decoy
P1_8493:  JSR  P1_80B0                ;live: select page 3
P1_8496:  JMP  P1_8499                ;live
P1_8499:  JSR  P1_8493                ;live
P1_849C:  JSR  P1_8674                ;decoy
P1_849F:  JMP  P1_80B0                ;decoy
P1_84A2:  JSR  P1_8499                ;decoy
P1_84A5:  JSR  P1_80A0                ;live: select page 2
P1_84A8:  JMP  P1_84AB                ;live
P1_84AB:  JSR  P1_84A5                ;live
P1_84AE:  JSR  P1_96DF+1              ;decoy
P1_84B1:  JMP  P1_80A0                ;decoy
P1_84B4:  JSR  P1_84B1                ;decoy
P1_84B7:  JSR  P1_80B0                ;live: select page 3
P1_84BA:  JMP  P1_84BD                ;live
P1_84BD:  JSR  P1_84B7                ;live
P1_84C0:  JSR  P1_988C                ;decoy
P1_84C3:  JMP  P1_80B0                ;decoy
P1_84C6:  JSR  P1_84BD                ;decoy
P1_84C9:  JSR  P1_84C6                ;decoy
P1_84CC:  JMP  MVGUN                  ;live: the routine
P1_84CF:  JMP  P1_8080                ;live: select page 0
P1_84D2:  JMP  P1_80A0                ;live: select page 2
P1_84D5:  JMP  P1_80B0                ;live: select page 3
P1_84D8:  JSR  P1_84DB                ;decoy
P1_84DB:  JSR  P1_80A0                ;live: select page 2
P1_84DE:  JMP  P1_84E1                ;live
P1_84E1:  JSR  P1_84DB                ;live
P1_84E4:  JSR  jedi_clear             ;decoy
P1_84E7:  JMP  P1_80A0                ;decoy
P1_84EA:  JSR  P1_84E7                ;decoy
P1_84ED:  JSR  P1_84E4                ;decoy
P1_84F0:  JSR  P1_8090                ;live: select page 1
P1_84F3:  JSR  atat_fire              ;live: the routine
P1_84F6:  JMP  P1_8090                ;live: select page 1
P1_84F9:  JSR  P1_84F0                ;decoy
P1_84FC:  JSR  P1_8080                ;live: select page 0
P1_84FF:  JSR  P1_84FC                ;live
P1_8502:  JSR  P1_8080                ;decoy
P1_8505:  JSR  P1_969B+2              ;decoy
P1_8508:  JMP  P1_8090                ;decoy
P1_850B:  JSR  P1_8508                ;decoy
P1_850E:  JSR  P1_8505                ;decoy
P1_8511:  JSR  P1_850E                ;decoy
P1_8514:  JMP  atst_move_all          ;live: the routine
P1_8517:  JMP  P1_8080                ;live: select page 0
P1_851A:  JMP  P1_80A0                ;live: select page 2
P1_851D:  JMP  P1_80B0                ;live: select page 3
P1_8520:  JSR  P1_8517                ;decoy
P1_8523:  JSR  P1_80A0                ;live: select page 2
P1_8526:  JMP  P1_8529                ;live
P1_8529:  JSR  P1_8523                ;live
P1_852C:  JSR  P1_9983                ;decoy
P1_852F:  JMP  P1_80A0                ;decoy
P1_8532:  JSR  P1_8529                ;decoy
P1_8535:  JSR  P1_8080                ;decoy
P1_8538:  JSR  P1_8535                ;decoy
P1_853B:  JSR  P1_8080                ;decoy
P1_853E:  JSR  P1_9002+1              ;decoy
P1_8541:  JMP  P1_8090                ;decoy
P1_8544:  JSR  P1_853B                ;decoy
P1_8547:  JSR  P1_853E                ;decoy
P1_854A:  JSR  P1_8547                ;decoy
P1_854D:  JSR  P1_854A                ;decoy
P1_8550:  JMP  atst_view_all          ;live: the routine
P1_8553:  JMP  P1_8080                ;live: select page 0
P1_8556:  JMP  P1_80A0                ;live: select page 2
P1_8559:  JMP  P1_80B0                ;live: select page 3
P1_855C:  JSR  P1_8556                ;decoy
P1_855F:  JSR  P1_8562                ;decoy
P1_8562:  JSR  P1_80B0                ;live: select page 3
P1_8565:  JMP  P1_8568                ;live
P1_8568:  JSR  P1_8562                ;live
P1_856B:  JSR  P1_95D2+1              ;decoy
P1_856E:  JMP  P1_80B0                ;decoy
P1_8571:  JMP  P1_8577                ;decoy
P1_8574:  JSR  P1_856E                ;decoy
P1_8577:  JMP  P1_857D                ;decoy
P1_857A:  JSR  P1_8090                ;live: select page 1
P1_857D:  JSR  tie_fire               ;live: the routine
P1_8580:  JMP  P1_8090                ;live: select page 1
P1_8583:  JSR  P1_8580                ;decoy
P1_8586:  JMP  P1_858C                ;decoy
P1_8589:  JSR  P1_8586                ;decoy
P1_858C:  JMP  atst_killed            ;live: the routine
P1_858F:  JMP  P1_8080                ;decoy
P1_8592:  JMP  P1_80A0                ;decoy
P1_8595:  JMP  P1_80B0                ;live: select page 3
P1_8598:  JSR  P1_858F                ;decoy
P1_859B:  JSR  P1_80A0                ;live: select page 2
P1_859E:  JMP  P1_85A1                ;live
P1_85A1:  JSR  P1_859B                ;live
P1_85A4:  JSR  atst_init              ;decoy
P1_85A7:  JMP  P1_80A0                ;decoy
P1_85AA:  JMP  P1_85B0                ;decoy
P1_85AD:  JSR  P1_85A4                ;decoy
P1_85B0:  JSR  P1_8080                ;live: select page 0
P1_85B3:  JSR  P1_85B0                ;live
P1_85B6:  JSR  P1_8080                ;decoy
P1_85B9:  JSR  P1_93B3+1              ;decoy
P1_85BC:  JMP  P1_8090                ;decoy
P1_85BF:  JMP  P1_85C5                ;decoy
P1_85C2:  JSR  P1_85BF                ;decoy
P1_85C5:  JSR  P1_85C2                ;decoy
P1_85C8:  JMP  GNHTSG                 ;live: the routine
P1_85CB:  JMP  P1_8080                ;decoy
P1_85CE:  JMP  P1_80A0                ;decoy
P1_85D1:  JMP  P1_80B0                ;live: select page 3
P1_85D4:  JSR  P1_85D7                ;decoy
P1_85D7:  JSR  P1_85D4                ;decoy
P1_85DA:  JMP  atst_init              ;live: the routine
P1_85DD:  JMP  P1_8080                ;live: select page 0
P1_85E0:  JMP  P1_80A0                ;live: select page 2
P1_85E3:  JMP  P1_80B0                ;live: select page 3
P1_85E6:  JMP  atst_init              ;decoy
P1_85E9:  JSR  P1_85E6                ;decoy

;------------------------------------------------------------------------------
; atst_init - wave 2 set-up of the AT-STs, called from wave2_setup: has the points of objects 17 and 18 (the AT-
;   ST head) put in math RAM, fills the three $11-byte records at xmit_atst from atst_init_tab - all free, fire
;   delay 8, height $0800, movement mode 6 (walk), each with its own head angle and leg set - and sets the spawn
;   count w2_spawn_a to 3
;------------------------------------------------------------------------------
atst_init:
P1_85EC:  LDB  #$11                   ;object 17, the AT-ST head: its points into math RAM (bank 1 KD868)
P1_85EE:  JSR  L60A8
P1_85F1:  LDB  #$12                   ;object 18, which has the same 18 points
P1_85F3:  JSR  L60A8
P1_85F6:  LDX  #atst_init_tab         ;10 bytes per AT-ST: x, y, z words, a byte not used and the head angle, the leg set and the movement mode
P1_85F9:  LDU  #xmit_atst
P1_85FC:  STU  S2_PRM
P1_85FE:  LDA  #$00                   ;byte 0, the status: 0 = free until atst_move_all spawns it
P1_8600:  STA  ,U
P1_8602:  LDA  #$00
P1_8604:  STA  1,U
P1_8606:  LDA  #$08                   ;byte 3, the fire delay: 8 frames
P1_8608:  STA  3,U
P1_860A:  LDD  ,X++                   ;bytes 5-10: x, y and z ($0800 for all)
P1_860C:  STD  5,U
P1_860E:  LDD  ,X++
P1_8610:  STD  7,U
P1_8612:  LDD  ,X++
P1_8614:  STD  9,U
P1_8616:  LDA  #$00                   ;byte 11, the heading
P1_8618:  STA  11,U
P1_861A:  LDD  ,X++                   ;byte 12, the head angle (the first byte of the pair is not used)
P1_861C:  STB  12,U
P1_861E:  LDD  ,X++                   ;byte 15, the leg set, and byte 4, the movement mode (6 for all: walk)
P1_8620:  STA  15,U
P1_8622:  STB  4,U
P1_8624:  LEAU $11,U
P1_8627:  CMPU #atat_rec
P1_862B:  BCS  P1_85FC
P1_862D:  LDA  #$03                   ;three AT-STs are kept in play
P1_862F:  STA  w2_spawn_a
P1_8632:  RTS

atst_init_tab:
P1_8633:  .word $0000, $0000, $0800   ;AT-ST set-up row 0: x, y, z, then four bytes  six entries of 10 bytes, of which atst_init uses the first three
P1_8639:  .byte $00, $40, $00, $06
P1_863D:  .word $4000, $4000, $0800   ;AT-ST set-up row 1: x, y, z, then four bytes
P1_8643:  .byte $00, $00, $01, $06
P1_8647:  .word $8000, $8000, $0800   ;AT-ST set-up row 2: x, y, z, then four bytes
P1_864D:  .byte $00, $60, $02, $06
P1_8651:  .word $C000, $C000, $0800   ;AT-ST set-up row 3: x, y, z, then four bytes
P1_8657:  .byte $00, $00, $00, $06
P1_865B:  .word $2000, $A000, $0800   ;AT-ST set-up row 4: x, y, z, then four bytes
P1_8661:  .byte $00, $90, $01, $06
P1_8665:  .word $6000, $E000, $0800   ;AT-ST set-up row 5: x, y, z, then four bytes
P1_866B:  .byte $00, $00, $02, $06

;------------------------------------------------------------------------------
; man_atst_init - training manual set-up of the demo AT-ST, called from man_init_walker with B = manual page:
;   fills the first record from the 10-byte entry of man_atst_tab for that page (entry 0 for a page above 2) with
;   movement mode 0, so it stays put in front of the player, frees the other two records, has objects 17 and 18
;   put in math RAM and clears w2_spawn_a so that nothing is spawned or freed
;------------------------------------------------------------------------------
man_atst_init:
P1_866F:  LDX  #man_atst_tab
P1_8672:  LDA  #$0A                   ;B = manual page: 10 bytes per entry
P1_8674:  MUL
P1_8675:  CMPB #$1E                   ;a page above 2 takes entry 0
P1_8677:  BCS  P1_867B
P1_8679:  LDB  #$00
P1_867B:  ABX
P1_867C:  LDU  #xmit_atst
P1_867F:  LDA  #$00
P1_8681:  STA  1,U
P1_8683:  LDA  #$08                   ;byte 3, the fire delay
P1_8685:  STA  3,U
P1_8687:  LDD  ,X++
P1_8689:  STD  5,U
P1_868B:  LDD  ,X++
P1_868D:  STD  7,U
P1_868F:  LDD  ,X++
P1_8691:  STD  9,U
P1_8693:  LDD  ,X++                   ;byte 11, the heading, and byte 12, the head angle
P1_8695:  STA  11,U
P1_8697:  STB  12,U
P1_8699:  LDD  ,X++                   ;byte 15, the leg set, and byte 0, the status
P1_869B:  STA  15,U
P1_869D:  STB  ,U
P1_869F:  LDA  #$00                   ;movement mode 0: it stays where it is in front of the player
P1_86A1:  STA  4,U
P1_86A3:  LEAU $11,U
P1_86A6:  LDA  #$00                   ;the other two records are free
P1_86A8:  STA  ,U
P1_86AA:  LEAU $11,U
P1_86AD:  CMPU #atat_rec
P1_86B1:  BCS  P1_86A8
P1_86B3:  LDB  #$11
P1_86B5:  JSR  L60A8
P1_86B8:  LDB  #$12
P1_86BA:  JSR  L60A8
P1_86BD:  LDA  #$00                   ;spawn count 0: nothing is spawned and nothing freed
P1_86BF:  STA  w2_spawn_a
P1_86C2:  RTS

man_atst_tab:
P1_86C3:  .word $F400, $0000, $0800   ;AT-ST manual row 0: x, y, z, then four bytes  three entries of 10 bytes, one per manual page: x, y, z words, heading, head angle, leg set, status
P1_86C9:  .byte $80, $E0, $00, $01
P1_86CD:  .word $F400, $0000, $0800   ;AT-ST manual row 1: x, y, z, then four bytes
P1_86D3:  .byte $80, $20, $01, $01
P1_86D7:  .word $F400, $0000, $0800   ;AT-ST manual row 2: x, y, z, then four bytes
P1_86DD:  .byte $80, $00, $00, $09

;------------------------------------------------------------------------------
; atst_move_all - per-frame movement of the AT-STs, called from wave2_exec, wave2_end_exec and man_move_walker.
;   while w2_spawn_a is above 0 it spawns one AT-ST a frame (P1_8E99) in the first free record among the first
;   w2_spawn_a, when it is minus it frees every record that was not in view in the last frame. then for each live
;   record it counts it in w2_active_a, counts the fire delay down and calls atst_head_turn, atst_move and
;   atst_walk_tick
;------------------------------------------------------------------------------
atst_move_all:
P1_86E1:  LDB  w2_spawn_a
P1_86E4:  BLE  P1_8702                ;spawn count 0 or minus: no spawning
P1_86E6:  LDU  #xmit_atst
P1_86E9:  LDA  ,U
P1_86EB:  BNE  P1_86F6                ;a free record among the first w2_spawn_a: spawn an AT-ST in it, and no more this frame
P1_86ED:  LDA  #$00
P1_86EF:  STA  1,U
P1_86F1:  JSR  atst_place
P1_86F4:  BRA  P1_8702
P1_86F6:  DECB
P1_86F7:  BLE  P1_8702
P1_86F9:  LEAU $11,U
P1_86FC:  CMPU #atat_rec
P1_8700:  BCS  P1_86E9
P1_8702:  LDB  w2_spawn_a
P1_8705:  BGE  P1_8721                ;spawn count minus, the wave is over: free every AT-ST that is not in view
P1_8707:  LDU  #xmit_atst
P1_870A:  LDA  ,U
P1_870C:  BEQ  P1_8718
P1_870E:  LDA  1,U
P1_8710:  BITA #$10                   ;view flag $10: it was in view in the last frame
P1_8712:  BNE  P1_8718
P1_8714:  LDA  #$00
P1_8716:  STA  ,U
P1_8718:  LEAU $11,U
P1_871B:  CMPU #atat_rec
P1_871F:  BCS  P1_870A
P1_8721:  CLR  w2_active_a
P1_8724:  LDU  #xmit_atst
P1_8727:  LDA  ,U
P1_8729:  BEQ  P1_873D
P1_872B:  INC  w2_active_a
P1_872E:  LDB  3,U                    ;byte 3, the fire delay, counts down to 0
P1_8730:  BEQ  P1_8734
P1_8732:  DEC  3,U
P1_8734:  JSR  atst_head_turn
P1_8737:  JSR  atst_move
P1_873A:  JSR  atst_walk_tick
P1_873D:  LEAU $11,U
P1_8740:  CMPU #atat_rec
P1_8744:  BCS  P1_8727
P1_8746:  RTS

;------------------------------------------------------------------------------
; atst_head_turn - swings the head of the AT-ST in U and turns its body after it. while the AT-ST is in view and
;   its guns are not on the player the swing is reversed if its sign equals that of byte 16, the side the player
;   was seen on. when the head is more than half way out and still swinging outwards the heading (byte 11) follows
;   by 4 a frame, or by 1 when the player is ahead of the guns. the swing speed (byte 13) is added to the head
;   angle (byte 12) and its size taken anew from one of three tables by the head angle: slow when the guns are on
;   the player, medium when the player is ahead of them, else fast
;------------------------------------------------------------------------------
atst_head_turn:
P1_8747:  PSHS X
P1_8749:  JSR  rnd_set
P1_874C:  LDA  1,U
P1_874E:  BITA #$10                   ;view flag $10: in view
P1_8750:  BEQ  P1_8762
P1_8752:  BITA #$02                   ;view flag $02: the guns are on the player - the swing is left alone
P1_8754:  BNE  P1_8762
P1_8756:  LDA  13,U                   ;byte 13, the swing speed, against byte 16, the side the player was seen on
P1_8758:  EORA $10,U
P1_875B:  BMI  P1_8762
P1_875D:  LDA  13,U                   ;same sign: reverse the swing
P1_875F:  NEGA
P1_8760:  STA  13,U
P1_8762:  LDA  12,U
P1_8764:  BPL  P1_8767
P1_8766:  NEGA
P1_8767:  CMPA #$40                   ;head angle beyond +/-$40: the head is more than half way out (it is drawn at half this angle from the body)
P1_8769:  BLS  P1_8787
P1_876B:  LDA  12,U                   ;and still swinging outwards
P1_876D:  EORA 13,U
P1_876F:  BMI  P1_8787
P1_8771:  LDA  12,U                   ;then the body turns after the head, 4 a frame
P1_8773:  BMI  P1_8779
P1_8775:  LDA  #$04
P1_8777:  BRA  P1_877B
P1_8779:  LDA  #$FC
P1_877B:  LDB  1,U
P1_877D:  BITB #$04                   ;view flag $04, the player is ahead of the guns: 1 a frame
P1_877F:  BEQ  P1_8783
P1_8781:  ASRA
P1_8782:  ASRA
P1_8783:  ADDA 11,U                   ;byte 11, the heading
P1_8785:  STA  11,U
P1_8787:  LDB  12,U
P1_8789:  ADDB 13,U
P1_878B:  BVC  P1_8799                ;the head angle would overflow: it is not stored, and on a random bit the swing reverses
P1_878D:  LDA  RND_S2
P1_878F:  BPL  P1_8797
P1_8791:  LDA  13,U
P1_8793:  EORA #$80
P1_8795:  STA  13,U
P1_8797:  BRA  P1_879B
P1_8799:  STB  12,U
P1_879B:  LDA  1,U
P1_879D:  BITA #$02                   ;the size of the swing speed: the slow table while the guns are on the player
P1_879F:  BEQ  P1_87A6
P1_87A1:  LDX  #head_spd_aimed
P1_87A4:  BRA  P1_87B2
P1_87A6:  BITA #$04                   ;the middle table while the player is ahead of the guns
P1_87A8:  BEQ  P1_87AF
P1_87AA:  LDX  #head_spd_ahead
P1_87AD:  BRA  P1_87B2
P1_87AF:  LDX  #head_spd_search       ;else the fast table
P1_87B2:  LDB  12,U
P1_87B4:  LSRB                        ;index = the top four bits of the head angle: fastest facing forward, slowest facing backward
P1_87B5:  LSRB
P1_87B6:  LSRB
P1_87B7:  LSRB
P1_87B8:  LDB  B,X
P1_87BA:  LDA  13,U                   ;the speed keeps its sign
P1_87BC:  BPL  P1_87BF
P1_87BE:  NEGB
P1_87BF:  STB  13,U
P1_87C1:  PULS X,PC

head_spd_aimed:
P1_87C3:  .byte $05, $04, $04, $03, $03, $02, $02, $01
P1_87CB:  .byte $01, $02, $02, $03, $03, $04, $05, $05

head_spd_ahead:
P1_87D3:  .byte $09, $08, $08, $07, $07, $06, $06, $05
P1_87DB:  .byte $05, $06, $06, $07, $07, $08, $09, $09

head_spd_search:
P1_87E3:  .byte $10, $0E, $0E, $0C, $0C, $0A, $0A, $08
P1_87EB:  .byte $08, $0A, $0A, $0C, $0C, $0E, $10, $10

atst_move_tab:
P1_87F3:  .word atst_mv_hold_rel
P1_87F5:  .word atst_mv_close_rel
P1_87F7:  .word atst_mv_away_rel
P1_87F9:  .word atst_mv_hold_uni
P1_87FB:  .word atst_mv_close_uni
P1_87FD:  .word atst_mv_away_uni
P1_87FF:  .word atst_mv_walk

;------------------------------------------------------------------------------
; atst_move - moves the AT-ST in U by its movement mode (byte 4, 0-6) through the routine table atst_move_tab.
;   the game uses mode 6 and the manual mode 0, the only two this stretch stores besides the 0 and 3 that modes 2
;   and 5 end in
;------------------------------------------------------------------------------
atst_move:
P1_8801:  PSHS X
P1_8803:  LDB  4,U
P1_8805:  ASLB                        ;byte 4, the movement mode, as a word offset
P1_8806:  CMPB #$0E
P1_8808:  BCS  P1_880C
P1_880A:  LDB  #$03                   ;out of range: offset 3, which is not an entry boundary of the word table (mode 3 would be 6)
P1_880C:  LDX  #atst_move_tab
P1_880F:  JSR  [B,X]
P1_8811:  PULS X,PC

;------------------------------------------------------------------------------
; atst_mv_hold_rel - movement mode 0, reached through atst_move_tab: keeps the position relative to the player,
;   so the AT-ST stays where it is on the screen. the mode of the manual's demo AT-ST
;------------------------------------------------------------------------------
atst_mv_hold_rel:
P1_8813:  JSR  atst_pos_to_rel
P1_8816:  RTS

;------------------------------------------------------------------------------
; atst_mv_close_rel - movement mode 1, reached through atst_move_tab: with the position relative to the player,
;   x and y each move an eighth of the way to zero every frame, so the AT-ST closes on the player
;------------------------------------------------------------------------------
atst_mv_close_rel:
P1_8817:  JSR  atst_pos_to_rel
P1_881A:  LDD  #$0000                 ;x and y each move an eighth of the way to 0, the player
P1_881D:  SUBD 5,U
P1_881F:  JSR  ASRD3
P1_8822:  ADDD 5,U
P1_8824:  STD  5,U
P1_8826:  LDD  #$0000
P1_8829:  SUBD 7,U
P1_882B:  JSR  ASRD3
P1_882E:  ADDD 7,U
P1_8830:  STD  7,U
P1_8832:  RTS

;------------------------------------------------------------------------------
; atst_mv_away_rel - movement mode 2, reached through atst_move_tab: with the position relative to the player, x
;   and y each grow by an eighth every frame, so the AT-ST draws away. when either overflows the mode becomes 0
;------------------------------------------------------------------------------
atst_mv_away_rel:
P1_8833:  JSR  atst_pos_to_rel
P1_8836:  LDD  5,U                    ;x and y each grow by an eighth
P1_8838:  JSR  ASRD3
P1_883B:  ADDD 5,U
P1_883D:  BVS  P1_884D
P1_883F:  STD  5,U
P1_8841:  LDD  7,U
P1_8843:  JSR  ASRD3
P1_8846:  ADDD 7,U
P1_8848:  BVS  P1_884D
P1_884A:  STD  7,U
P1_884C:  RTS
P1_884D:  LDB  #$00                   ;overflow: mode 0, hold
P1_884F:  STB  4,U
P1_8851:  RTS

;------------------------------------------------------------------------------
; atst_mv_hold_uni - movement mode 3, reached through atst_move_tab: keeps the position in universe coordinates,
;   so the AT-ST stands still on the ground
;------------------------------------------------------------------------------
atst_mv_hold_uni:
P1_8852:  JSR  atst_pos_to_uni
P1_8855:  RTS

;------------------------------------------------------------------------------
; atst_mv_close_uni - movement mode 4, reached through atst_move_tab: with the position in universe coordinates,
;   replaces x by (x - player x)/8 - x and y likewise. by its place between modes 3 and 5 it is the universe form
;   of mode 1, but as written it does not subtract an eighth of the distance from the position
;------------------------------------------------------------------------------
atst_mv_close_uni:
P1_8856:  JSR  atst_pos_to_uni
P1_8859:  LDD  5,U                    ;(x - player x)/8 - x is stored
P1_885B:  SUBD s1_tx
P1_885E:  JSR  ASRD3
P1_8861:  SUBD 5,U
P1_8863:  STD  5,U
P1_8865:  LDD  7,U
P1_8867:  SUBD s1_ty
P1_886A:  JSR  ASRD3
P1_886D:  SUBD 7,U
P1_886F:  STD  7,U
P1_8871:  RTS

;------------------------------------------------------------------------------
; atst_mv_away_uni - movement mode 5, reached through atst_move_tab: with the position in universe coordinates,
;   adds an eighth of the distance from the player to x and to y every frame, so the AT-ST draws away. when either
;   overflows the mode becomes 3
;------------------------------------------------------------------------------
atst_mv_away_uni:
P1_8872:  JSR  atst_pos_to_uni
P1_8875:  LDD  5,U                    ;x and y each move away by an eighth of the distance from the player
P1_8877:  SUBD s1_tx
P1_887A:  JSR  ASRD3
P1_887D:  ADDD 5,U
P1_887F:  BVS  P1_8892
P1_8881:  STD  5,U
P1_8883:  LDD  7,U
P1_8885:  SUBD s1_ty
P1_8888:  JSR  ASRD3
P1_888B:  ADDD 7,U
P1_888D:  BVS  P1_8892
P1_888F:  STD  7,U
P1_8891:  RTS
P1_8892:  LDB  #$03                   ;overflow: mode 3, hold
P1_8894:  STB  4,U
P1_8896:  RTS

;------------------------------------------------------------------------------
; atst_mv_walk - movement mode 6, reached through atst_move_tab, the mode of the game: with the position in
;   universe coordinates, walks 180 units a frame along the heading (byte 11) - x plus 180 times the cosine, y
;   minus 180 times the sine, multiplied by the math box
;------------------------------------------------------------------------------
atst_mv_walk:
P1_8897:  JSR  atst_pos_to_uni
P1_889A:  LDD  #$00B4                 ;the step: 180
P1_889D:  STD  M_XP
P1_88A0:  LDB  11,U                   ;byte 11, the heading
P1_88A2:  JSR  set_sin_cos
P1_88A5:  LDD  M_SIN
P1_88A8:  STD  M_YP
P1_88AB:  LDD  M_COS
P1_88AE:  STD  M_ZP
P1_88B1:  LDA  #$86                   ;MS_PERS: M_YP = 180 * sine, M_ZP = 180 * cosine
P1_88B3:  JSR  MGOWT
P1_88B6:  LDD  5,U
P1_88B8:  ADDD M_ZP
P1_88BB:  STD  5,U
P1_88BD:  LDD  7,U
P1_88BF:  SUBD M_YP
P1_88C2:  STD  7,U
P1_88C4:  RTS

;------------------------------------------------------------------------------
; atst_pos_to_rel - makes the position of the AT-ST in U relative to the player: if status bit $40 is set it
;   clears it and subtracts the player's x and y (s1_tx, s1_ty) from bytes 5-8. called by the movement modes 0-2
;------------------------------------------------------------------------------
atst_pos_to_rel:
P1_88C5:  LDA  ,U
P1_88C7:  BITA #$40                   ;status $40: the position is in universe coordinates
P1_88C9:  BEQ  P1_88DD
P1_88CB:  ANDA #$BF
P1_88CD:  STA  ,U
P1_88CF:  LDD  5,U
P1_88D1:  SUBD s1_tx
P1_88D4:  STD  5,U
P1_88D6:  LDD  7,U
P1_88D8:  SUBD s1_ty
P1_88DB:  STD  7,U
P1_88DD:  RTS

;------------------------------------------------------------------------------
; atst_pos_to_uni - puts the position of the AT-ST in U in universe coordinates: if status bit $40 is clear it
;   sets it and adds the player's x and y (s1_tx, s1_ty) to bytes 5-8. called by the movement modes 3-6
;------------------------------------------------------------------------------
atst_pos_to_uni:
P1_88DE:  LDA  ,U
P1_88E0:  BITA #$40                   ;status $40: the position is in universe coordinates already
P1_88E2:  BNE  P1_88F6
P1_88E4:  ORA  #$40
P1_88E6:  STA  ,U
P1_88E8:  LDD  s1_tx
P1_88EB:  ADDD 5,U
P1_88ED:  STD  5,U
P1_88EF:  LDD  s1_ty
P1_88F2:  ADDD 7,U
P1_88F4:  STD  7,U
P1_88F6:  RTS

;------------------------------------------------------------------------------
; atst_walk_tick - steps byte 14 of the AT-ST in U, the walk counter that the leg drawing turns into the
;   positions of the leg joints
;------------------------------------------------------------------------------
atst_walk_tick:
P1_88F7:  LDA  14,U
P1_88F9:  INCA
P1_88FA:  STA  14,U
P1_88FC:  RTS

;------------------------------------------------------------------------------
; atst_view_all - view routine of the AT-STs, called from the walker views (vew_walker, the game over view and
;   man_view_walker) with Y = display list: for each live record it leaves U in S2_PRM, clears the view flags of
;   byte 1 - the crash flag $80 is kept while the AT-ST was in view - and calls atst_view
;------------------------------------------------------------------------------
atst_view_all:
P1_88FD:  LDU  #xmit_atst
P1_8900:  STU  S2_PRM
P1_8902:  LDA  ,U
P1_8904:  BEQ  P1_8915
P1_8906:  LDA  1,U                    ;byte 1, the view flags: all cleared, but the crash flag $80 stays while the AT-ST was in view ($10)
P1_8908:  BITA #$10
P1_890A:  BNE  P1_890E
P1_890C:  ANDA #$7F
P1_890E:  ANDA #$80
P1_8910:  STA  1,U
P1_8912:  JSR  atst_view
P1_8915:  LEAU $11,U
P1_8918:  CMPU #atat_rec
P1_891C:  BCS  P1_8900
P1_891E:  RTS

;------------------------------------------------------------------------------
; atst_view - views one AT-ST, U = record: transforms its position to the player's view and returns if it is
;   nearer than $10, $4000 or more away or more than 45 degrees off the line of sight. otherwise sets the in-view
;   flag $10, and if it is nearer than $380 with the player below height $0A76 it is a crash: flag $80, shield
;   glow through BG1GLW, the crash sound and a roll of the ship, the Star Wars tower crash code. then draws the
;   legs (atst_view_body) and the head (atst_view_head)
;------------------------------------------------------------------------------
atst_view:
P1_891F:  LDA  ,U
P1_8921:  BITA #$40                   ;status $40: the position is in universe coordinates already
P1_8923:  BEQ  P1_8936
P1_8925:  LDD  5,U
P1_8927:  STD  M_X0
P1_892A:  LDD  7,U
P1_892C:  STD  M_Y0
P1_892F:  LDD  9,U
P1_8931:  STD  M_Z0
P1_8934:  BRA  P1_894B
P1_8936:  LDD  5,U                    ;else relative to the player: add the player's x and y
P1_8938:  ADDD s1_tx
P1_893B:  STD  M_X0
P1_893E:  LDD  7,U
P1_8940:  ADDD s1_ty
P1_8943:  STD  M_Y0
P1_8946:  LDD  9,U                    ;z is the same in both forms
P1_8948:  STD  M_Z0
P1_894B:  LDD  #MS_X0BC
P1_894E:  STD  M_BIC
P1_8951:  LDA  #MS_PSB2               ;the AT-ST in the player's view: M_XP is the distance ahead
P1_8953:  JSR  MGOWT
P1_8956:  LDD  M_XP
P1_8959:  STD  M_XT
P1_895C:  CMPD #$0010                 ;not viewed nearer than $10
P1_8960:  BLE  P1_89C3
P1_8962:  CMPD #$4000                 ;or from $4000 away
P1_8966:  BCC  P1_89C3
P1_8968:  LDD  M_YP
P1_896B:  STD  M_YT
P1_896E:  BPL  P1_8974                ;IFMI
P1_8970:  COMA                        ;NEGD
P1_8971:  NEGB
P1_8972:  SBCA #$FF
P1_8974:  SUBD M_XP                   ;more than 45 degrees to the side: not viewed
P1_8977:  BCC  P1_89C3
P1_8979:  LDD  M_ZP
P1_897C:  STD  M_ZT
P1_897F:  BPL  P1_8985                ;IFMI
P1_8981:  COMA                        ;NEGD
P1_8982:  NEGB
P1_8983:  SBCA #$FF
P1_8985:  SUBD M_XP                   ;or more than 45 degrees up or down
P1_8988:  BCC  P1_89C3
P1_898A:  LDA  1,U
P1_898C:  ORA  #$10                   ;view flag $10: in view
P1_898E:  STA  1,U
P1_8990:  LDD  M_XP
P1_8993:  SUBD #$0380                 ;nearer than $380
P1_8996:  BGE  P1_89BD
P1_8998:  LDD  s1_tz
P1_899B:  CMPD #$0A76                 ;and the player's height under $0A76: a crash into the AT-ST
P1_899F:  BGE  P1_89BD
P1_89A1:  LDA  1,U
P1_89A3:  ORA  #$80                   ;view flag $80: crashed into - drawn in the flash colour from now on
P1_89A5:  STA  1,U
P1_89A7:  JSR  BG1GLW
P1_89AA:  JSR  aud_cmd_32
P1_89AD:  LDA  S_ROL
P1_89AF:  BNE  P1_89B5                ;IFEQ  ?ANY PREVIOUS DIRECTION PREFERRED?
P1_89B1:  LDA  M_YP                   ;IF NOT, THEN SELECT ONE
P1_89B4:  NEGA
P1_89B5:  LDB  #$20                   ;AMOUNT TO ROLL
P1_89B7:  TSTA
P1_89B8:  BPL  P1_89BB                ;IFMI  ?WHICH DIRECTION TO CHOOSE?
P1_89BA:  NEGB
P1_89BB:  STB  S_ROL
P1_89BD:  JSR  atst_view_body
P1_89C0:  JSR  atst_view_head
P1_89C3:  RTS

;------------------------------------------------------------------------------
; atst_view_body - sets ship 2's matrix block to the unit matrix turned by the AT-ST's heading (byte 11) and
;   concatenates it with the player's, writes the colour word - green, or a JSRL to the flash colour VRFLS once
;   the AT-ST has been crashed into - and draws the legs with atst_draw_legs. U is reloaded from S2_PRM
;------------------------------------------------------------------------------
atst_view_body:
P1_89C4:  LDU  #M_CX2                 ;ship 2's matrix block = the unit matrix
P1_89C7:  JSR  UNITV
P1_89CA:  LDU  S2_PRM
P1_89CC:  LDD  #$0009                 ;block index 9: ship 2's matrix
P1_89CF:  STD  M_BIC
P1_89D2:  LDB  11,U                   ;turned by the heading
P1_89D4:  JSR  yaw_by_angle
P1_89D7:  LDA  #$40                   ;MS_CNCT: the AT-ST's matrix as the player sees it
P1_89D9:  JSR  MGOWT
P1_89DC:  LDA  1,U
P1_89DE:  BITA #$80
P1_89E0:  BEQ  P1_89E7
P1_89E2:  LDD  #$A013                 ;crashed into: JSRL VRFLS, the flash colour
P1_89E5:  BRA  P1_89EA
P1_89E7:  LDD  #$6280                 ;else green at brightness $80
P1_89EA:  STD  ,Y++
P1_89EC:  JSR  atst_draw_legs
P1_89EF:  RTS

;------------------------------------------------------------------------------
; atst_view_head - transforms the AT-ST's own origin to the player's view with the body matrix and, if it is
;   between $100 and $3C00 ahead and within 45 degrees of the line of sight, draws the head with atst_draw_head
;------------------------------------------------------------------------------
atst_view_head:
P1_89F0:  LDD  #$0000
P1_89F3:  STD  M_X0
P1_89F6:  STD  M_Y0
P1_89F9:  STD  M_Z0
P1_89FC:  LDD  #MS_X0BC
P1_89FF:  STD  M_BIC
P1_8A02:  LDA  #$50                   ;MS_PAD: the AT-ST's origin in the player's view
P1_8A04:  JSR  MGOWT
P1_8A07:  LDD  M_XP
P1_8A0A:  STD  M_XT
P1_8A0D:  CMPD #$0100                 ;the head is drawn from $100
P1_8A11:  BLE  P1_8A3E
P1_8A13:  CMPD #$3C00                 ;to $3C00 ahead
P1_8A17:  BCC  P1_8A3E
P1_8A19:  LDD  M_YP
P1_8A1C:  STD  M_YT
P1_8A1F:  BPL  P1_8A25                ;IFMI
P1_8A21:  COMA                        ;NEGD
P1_8A22:  NEGB
P1_8A23:  SBCA #$FF
P1_8A25:  SUBD M_XP
P1_8A28:  BCC  P1_8A3E
P1_8A2A:  LDD  M_ZP
P1_8A2D:  STD  M_ZT
P1_8A30:  BPL  P1_8A36                ;IFMI
P1_8A32:  COMA                        ;NEGD
P1_8A33:  NEGB
P1_8A34:  SBCA #$FF
P1_8A36:  SUBD M_XP
P1_8A39:  BCC  P1_8A3E
P1_8A3B:  JSR  atst_draw_head
P1_8A3E:  RTS

;------------------------------------------------------------------------------
; atst_draw_head - draws the head of the AT-ST in U: turns ship 2's matrix further by half of byte 12, the
;   head's angle from the body, and concatenates, writes the colour, has the 18 points of object 17 perspected and
;   the object drawn, tests the lazar sight against it (P1_8D83), runs the aim test atst_aim, which leaves the
;   colour for object 18, and draws object 18 from the same points
;------------------------------------------------------------------------------
atst_draw_head:
P1_8A3F:  LDD  #$0009
P1_8A42:  STD  M_BIC
P1_8A45:  LDB  12,U                   ;half of byte 12, the head's angle from the body: ship 2's matrix already holds the heading
P1_8A47:  ASRB
P1_8A48:  JSR  yaw_by_angle
P1_8A4B:  LDA  #$40                   ;MS_CNCT
P1_8A4D:  JSR  MGOWT
P1_8A50:  LDA  1,U
P1_8A52:  BITA #$80
P1_8A54:  BEQ  P1_8A5B
P1_8A56:  LDD  #$A013                 ;crashed into: JSRL VRFLS, the flash colour
P1_8A59:  BRA  P1_8A5E
P1_8A5B:  LDD  #$62C0                 ;else green at brightness $C0
P1_8A5E:  STD  ,Y++
P1_8A60:  LDB  #$11                   ;object 17: its 18 points perspected into BJ_PNT
P1_8A62:  JSR  L60D2
P1_8A65:  JSR  L60E4                  ;and drawn
P1_8A68:  JSR  atst_body_hit          ;the lazar sight against two of its points
P1_8A6B:  JSR  atst_aim
P1_8A6E:  LDB  #$12                   ;object 18, from the same points, in the colour atst_aim left
P1_8A70:  JSR  L60EA
P1_8A73:  JSR  L60BA
P1_8A76:  RTS

;------------------------------------------------------------------------------
; atst_aim - aim test of the AT-ST in U, done only when its head faces the player (M_AX minus). works out where
;   the player is as seen from the point between the two guns, in the head's axes, keeps the side in byte 16 for
;   atst_head_turn and sets the colour word of object 18: dim green, red when the player is ahead of the guns
;   (flag $04), bright red within 45 degrees, the medium flash colour when the guns are on the player (flag $02) -
;   then, if status bit $20 is set and the fire delay has run out, the AT-ST fires (page 1 P1_8FF7). ends with the
;   lazar test of the head (P1_8DD6) whenever the player is ahead of the guns
;------------------------------------------------------------------------------
atst_aim:
P1_8A77:  PSHS X,U
P1_8A79:  LDD  #$6240                 ;green at brightness $40: the word that is replaced below when the player is ahead of the guns
P1_8A7C:  STD  ,Y++
P1_8A7E:  LDA  M_AX                   ;M_AX high byte from the MS_CNCT: plus, the head faces away - no aim test and no lazar test
P1_8A81:  LBPL P1_8B58
P1_8A85:  LDD  #$00DC                 ;the point between the two guns: 220, 0, -105 (points 0 and 1 of object 17 are 220, +/-50, -105)
P1_8A88:  STD  M_X0
P1_8A8B:  LDD  #$0000
P1_8A8E:  STD  M_Y0
P1_8A91:  LDD  #$FF97
P1_8A94:  STD  M_Z0
P1_8A97:  LDD  #MS_X0BC
P1_8A9A:  STD  M_BIC
P1_8A9D:  LDA  #$50
P1_8A9F:  JSR  MGOWT                  ;MS_PAD: the point in the player's view
P1_8AA2:  LDD  M_XP                   ;doubled
P1_8AA5:  ASLB
P1_8AA6:  ROLA
P1_8AA7:  STD  M_XT2
P1_8AAA:  LDD  M_YP
P1_8AAD:  ASLB
P1_8AAE:  ROLA
P1_8AAF:  STD  M_YT2
P1_8AB2:  LDD  M_ZP
P1_8AB5:  ASLB
P1_8AB6:  ROLA
P1_8AB7:  STD  M_ZT2
P1_8ABA:  LDD  #$000C                 ;block index $0C: M_XT2
P1_8ABD:  STD  M_BIC
P1_8AC0:  LDA  #MS_S1UN               ;MS_S1UN: from the player's view to universe coordinates
P1_8AC2:  JSR  MGOWT
P1_8AC5:  LDD  M_XP                   ;the guns' universe position becomes ship 2's position
P1_8AC8:  STD  M_XT2
P1_8ACB:  LDD  M_YP
P1_8ACE:  STD  M_YT2
P1_8AD1:  LDD  M_ZP
P1_8AD4:  STD  M_ZT2
P1_8AD7:  LDD  #$0013                 ;block index $13: s1_tx, the player's position
P1_8ADA:  STD  M_BIC
P1_8ADD:  JSR  presub_via_u2          ;the player as seen from the guns, in the head's axes: M_XP ahead, M_YP to the side, M_ZP up
P1_8AE0:  LDA  M_YP                   ;byte 16: the side the player is on, for atst_head_turn
P1_8AE3:  STA  $10,U
P1_8AE6:  LDD  M_XP
P1_8AE9:  STD  M_DVD
P1_8AEC:  LBLE P1_8B58                ;the player is not ahead of the guns: no more
P1_8AF0:  LDD  #$6480                 ;red at brightness $80 over the colour word stored at entry
P1_8AF3:  STD  -2,Y
P1_8AF5:  LDA  1,U                    ;view flag $04: the player is ahead of the guns
P1_8AF7:  ORA  #$04
P1_8AF9:  STA  1,U
P1_8AFB:  LDD  M_YP
P1_8AFE:  BGE  P1_8B07
P1_8B00:  COMA
P1_8B01:  NEGB
P1_8B02:  SBCA #$FF
P1_8B04:  STD  M_YP
P1_8B07:  SUBD M_XP                   ;more than 45 degrees to the side: no more
P1_8B0A:  BGE  P1_8B55
P1_8B0C:  LDD  M_ZP
P1_8B0F:  BGE  P1_8B18
P1_8B11:  COMA
P1_8B12:  NEGB
P1_8B13:  SBCA #$FF
P1_8B15:  STD  M_ZP
P1_8B18:  SUBD M_XP                   ;or more than 45 degrees up or down
P1_8B1B:  BGE  P1_8B55
P1_8B1D:  LDD  #$64E0                 ;within 45 degrees: red at brightness $E0
P1_8B20:  STD  -2,Y
P1_8B22:  LDD  M_QUO                  ;1 / distance, from the divide started at P1_8AE9
P1_8B25:  STD  M_XP                   ;GET X FOR PROPER SCREEN CONVERSION
P1_8B28:  LDA  #MS_PERS
P1_8B2A:  JSR  MGOWT
P1_8B2D:  LDD  M_YP
P1_8B30:  SUBD #$0100                 ;the side offset over the distance under $100
P1_8B33:  BGE  P1_8B55
P1_8B35:  LDD  M_ZP
P1_8B38:  SUBD #$0200                 ;and the height offset over the distance under $200: the guns are on the player
P1_8B3B:  BGE  P1_8B55
P1_8B3D:  LDD  #$A015                 ;JSRL VRMFL, the medium flash colour
P1_8B40:  STD  -2,Y
P1_8B42:  LDA  1,U                    ;view flag $02: the guns are on the player
P1_8B44:  ORA  #$02
P1_8B46:  STA  1,U
P1_8B48:  LDA  ,U
P1_8B4A:  BITA #$20                   ;status $20: this AT-ST may fire
P1_8B4C:  BEQ  P1_8B55
P1_8B4E:  LDA  3,U                    ;byte 3, the fire delay, must have run out
P1_8B50:  BNE  P1_8B55
P1_8B52:  JSR  P1_81C0                ;calls page 1 atst_fire
P1_8B55:  JSR  atst_window_hit        ;the lazar sight against the head: this AT-ST may become the lazar's target
P1_8B58:  PULS X,U,PC

atst_leg_sets:
P1_8B5A:  .word atst_leg_pairs        ;one pointer per leg set, to its two leg pointers
P1_8B5C:  .word P1_8B64
P1_8B5E:  .word P1_8B68

atst_leg_pairs:
P1_8B60:  .word atst_leg_defs         ;two pointers per leg set, to the six 5-byte leg definitions from $8B6C: first joint track number for page 0 P0_93B4 ($2C-$40 in fours), hip x word (40), hip y word (+80 or -80)
P1_8B62:  .word P1_8B71
P1_8B64:  .word P1_8B76
P1_8B66:  .word P1_8B7B
P1_8B68:  .word P1_8B80
P1_8B6A:  .word P1_8B85

atst_leg_defs:
P1_8B6C:  .byte $2C                   ;AT-ST leg record 0: a byte and two words
P1_8B6D:  .word $0028, $0050
P1_8B71:  .byte $30                   ;AT-ST leg record 1: a byte and two words
P1_8B72:  .word $0028, $FFB0
P1_8B76:  .byte $34                   ;AT-ST leg record 2: a byte and two words
P1_8B77:  .word $0028, $0050
P1_8B7B:  .byte $38                   ;AT-ST leg record 3: a byte and two words
P1_8B7C:  .word $0028, $FFB0
P1_8B80:  .byte $3C                   ;AT-ST leg record 4: a byte and two words
P1_8B81:  .word $0028, $0050
P1_8B85:  .byte $40                   ;AT-ST leg record 5: a byte and two words
P1_8B86:  .word $0028, $FFB0

;------------------------------------------------------------------------------
; atst_draw_legs - draws the two legs of the AT-ST in U: writes the body colour, copies the walk counter (byte
;   14) to anim_frame and takes the pair of leg definitions for the record's leg set (byte 15, 0-2, set 0 if out
;   of range) from atst_leg_sets
;------------------------------------------------------------------------------
atst_draw_legs:
P1_8B8A:  PSHS X
P1_8B8C:  LDA  1,U
P1_8B8E:  BITA #$80
P1_8B90:  BEQ  P1_8B97
P1_8B92:  LDD  #$A013                 ;crashed into: JSRL VRFLS, the flash colour
P1_8B95:  BRA  P1_8B9A
P1_8B97:  LDD  #$6280                 ;else green at brightness $80
P1_8B9A:  STD  ,Y++
P1_8B9C:  LDA  14,U                   ;byte 14, the walk counter, to anim_frame for the joint routine
P1_8B9E:  STA  anim_frame
P1_8BA1:  LDX  #atst_leg_sets
P1_8BA4:  LDB  15,U                   ;byte 15: the leg set, 0-2
P1_8BA6:  ABX
P1_8BA7:  ABX
P1_8BA8:  CMPX #atst_leg_pairs        ;out of range: set 0
P1_8BAB:  BCS  P1_8BB0
P1_8BAD:  LDX  #atst_leg_sets
P1_8BB0:  LDX  ,X
P1_8BB2:  JSR  atst_leg_pair
P1_8BB5:  PULS X,PC

;------------------------------------------------------------------------------
; atst_leg_pair - X = pointer to two pointers to leg definitions: draws the two legs with atst_draw_leg
;------------------------------------------------------------------------------
atst_leg_pair:
P1_8BB7:  PSHS X
P1_8BB9:  JSR  atst_draw_leg
P1_8BBC:  LEAX 2,X
P1_8BBE:  JSR  atst_draw_leg
P1_8BC1:  PULS X,PC

;------------------------------------------------------------------------------
; atst_draw_leg - draws one leg, X = pointer to the pointer to its 5-byte definition (joint track number, hip x
;   word, hip y word). starts a new point list in BJ_PNT, has the four parts of the leg worked out by
;   atst_leg_part0 to atst_leg_part3 - each from the hip position and the next joint track of page 0
;   anim_track_pos at the walk time in anim_frame - and has the 18 points drawn as object 19. the walk counter is
;   copied back from anim_frame to byte 14
;------------------------------------------------------------------------------
atst_draw_leg:
P1_8BC3:  PSHS X
P1_8BC5:  LDX  ,X                     ;X = the leg definition
P1_8BC7:  JSR  L60CC                  ;start a new point list at BJ_PNT (bank 1 KD9EF)
P1_8BCA:  LDD  1,X                    ;the hip's x and y, set again for each of the four parts
P1_8BCC:  STD  M_X0
P1_8BCF:  LDD  3,X
P1_8BD1:  STD  M_Y0
P1_8BD4:  JSR  atst_leg_part0
P1_8BD7:  LDD  1,X
P1_8BD9:  STD  M_X0
P1_8BDC:  LDD  3,X
P1_8BDE:  STD  M_Y0
P1_8BE1:  JSR  atst_leg_part1
P1_8BE4:  LDD  1,X
P1_8BE6:  STD  M_X0
P1_8BE9:  LDD  3,X
P1_8BEB:  STD  M_Y0
P1_8BEE:  JSR  atst_leg_part2
P1_8BF1:  LDD  1,X
P1_8BF3:  STD  M_X0
P1_8BF6:  LDD  3,X
P1_8BF8:  STD  M_Y0
P1_8BFB:  JSR  atst_leg_part3
P1_8BFE:  LDB  #$13                   ;object 19, the leg: drawn from the 18 points just made
P1_8C00:  JSR  L60EA                  ;bank 1 KDA2A: draw object $13, the AT-ST leg, from the 18 points just perspected
P1_8C03:  JSR  L60BA                  ;bank 1 KD8AC: adds the word $B956 (a JSRL) to the display list and sets the current position BJ_CX, BJ_CY to 0, $68
P1_8C06:  LDA  anim_frame             ;the walk counter back to the record: anim_track_pos clears anim_frame when the walk cycle has gone round
P1_8C09:  STA  14,U
P1_8C0B:  PULS X,PC

;------------------------------------------------------------------------------
; atst_leg_part0 - first of the four parts of one AT-ST leg. X points at the leg record (track number, hip x
;   word, hip y word) and M_X0, M_Y0 hold the hip offset. sets M_Z0 to -50, has page 0 P0_93B4 interpolate
;   keyframe track (leg's track number + 0) for the current walk frame, and passes the four points of
;   atst_leg_pts0 through atst_leg_points
;------------------------------------------------------------------------------
atst_leg_part0:
P1_8C0D:  LDD  #$FFCE                 ;-50
P1_8C10:  STD  M_Z0
P1_8C13:  LDB  ,X                     ;the leg's first keyframe track, which P0_93B4 interpolates for the walk frame into anim_dx, anim_dy, anim_dz
P1_8C15:  JSR  P1_85B3                ;calls page 0 anim_track_pos
P1_8C18:  PSHS U
P1_8C1A:  LDU  #atst_leg_pts0
P1_8C1D:  JSR  atst_leg_points
P1_8C20:  PULS U,PC

;------------------------------------------------------------------------------
; atst_leg_part1 - second part of an AT-ST leg, as atst_leg_part0: M_Z0 -50, keyframe track + 1, the four points
;   of atst_leg_pts1
;------------------------------------------------------------------------------
atst_leg_part1:
P1_8C22:  LDD  #$FFCE
P1_8C25:  STD  M_Z0
P1_8C28:  LDB  ,X
P1_8C2A:  ADDB #$01
P1_8C2C:  JSR  P1_85B3                ;calls page 0 anim_track_pos
P1_8C2F:  PSHS U
P1_8C31:  LDU  #atst_leg_pts1
P1_8C34:  JSR  atst_leg_points
P1_8C37:  PULS U,PC

;------------------------------------------------------------------------------
; atst_leg_part2 - third part of an AT-ST leg, as atst_leg_part0: M_Z0 -716, keyframe track + 2, the four points
;   of atst_leg_pts2
;------------------------------------------------------------------------------
atst_leg_part2:
P1_8C39:  LDD  #$FD34                 ;-716
P1_8C3C:  STD  M_Z0
P1_8C3F:  LDB  ,X
P1_8C41:  ADDB #$02
P1_8C43:  JSR  P1_85B3                ;calls page 0 anim_track_pos
P1_8C46:  PSHS U
P1_8C48:  LDU  #atst_leg_pts2
P1_8C4B:  JSR  atst_leg_points
P1_8C4E:  PULS U,PC

;------------------------------------------------------------------------------
; atst_leg_part3 - fourth and lowest part of an AT-ST leg, as atst_leg_part0: M_Z0 -1024, keyframe track + 3,
;   the four points of atst_leg_pts3, then two more points stepped from the last one by (128, 37, -50) and (0,
;   -37, 0). with them the leg has its 18 perspected points
;------------------------------------------------------------------------------
atst_leg_part3:
P1_8C50:  LDD  #$FC00                 ;-1024
P1_8C53:  STD  M_Z0
P1_8C56:  LDB  ,X
P1_8C58:  ADDB #$03
P1_8C5A:  JSR  P1_85B3                ;calls page 0 anim_track_pos
P1_8C5D:  PSHS U
P1_8C5F:  LDU  #atst_leg_pts3
P1_8C62:  JSR  atst_leg_points
P1_8C65:  LDD  #$0080                 ;fifth point of this part: step by (128, 37, -50)
P1_8C68:  ADDD M_X0
P1_8C6B:  STD  M_X0
P1_8C6E:  LDD  #$0025
P1_8C71:  ADDD M_Y0
P1_8C74:  STD  M_Y0
P1_8C77:  LDD  #$FFCE
P1_8C7A:  ADDD M_Z0
P1_8C7D:  STD  M_Z0
P1_8C80:  JSR  L60DE                  ;bank 1 KD9F6: transform and perspect the point into the next BJ_PNT entry
P1_8C83:  LDD  #$0000                 ;sixth point: step by (0, -37, 0)
P1_8C86:  ADDD M_X0
P1_8C89:  STD  M_X0
P1_8C8C:  LDD  #$FFDB
P1_8C8F:  ADDD M_Y0
P1_8C92:  STD  M_Y0
P1_8C95:  LDD  #$0000
P1_8C98:  ADDD M_Z0
P1_8C9B:  STD  M_Z0
P1_8C9E:  JSR  L60DE
P1_8CA1:  PULS U,PC

atst_leg_pts0:
P1_8CA3:  .word $0000, $0032, $FFCE, $0000 ;four steps (dx, dy, dz) from the leg part's start point to its four points, each step taken from the point before
P1_8CAB:  .word $0000, $0064, $0000, $FF9C
P1_8CB3:  .word $0000, $0000, $0000, $FF9C

atst_leg_pts1:
P1_8CBB:  .word $0025, $0025, $FFDB, $FFB5
P1_8CC3:  .word $0000, $004B, $0000, $FFB5
P1_8CCB:  .word $0000, $004B, $0000, $FFB5

atst_leg_pts2:
P1_8CD3:  .word $0019, $0019, $0019, $FFCE
P1_8CDB:  .word $0000, $FFCE, $0000, $FFCE
P1_8CE3:  .word $0000, $0032, $0000, $0032

atst_leg_pts3:
P1_8CEB:  .word $0032, $0012, $0032, $FFCE
P1_8CF3:  .word $0006, $FFCE, $0000, $FFCE
P1_8CFB:  .word $0000, $0032, $0006, $0032

;------------------------------------------------------------------------------
; atst_leg_points - adds the animation offset anim_dx, anim_dy, anim_dz to the point in M_X0, M_Y0, M_Z0, then
;   four times adds the next (dx, dy, dz) step from the table at U to it and has bank 1 (L60DE) transform and
;   perspect the point into the next entry of BJ_PNT. U is left after the table, X is kept
;------------------------------------------------------------------------------
atst_leg_points:
P1_8D03:  PSHS X
P1_8D05:  LDD  anim_dx
P1_8D08:  ADDD M_X0
P1_8D0B:  STD  M_X0
P1_8D0E:  LDD  anim_dy
P1_8D11:  ADDD M_Y0
P1_8D14:  STD  M_Y0
P1_8D17:  LDD  anim_dz
P1_8D1A:  ADDD M_Z0
P1_8D1D:  STD  M_Z0
P1_8D20:  LDX  #$0004                 ;four points
P1_8D23:  LDD  ,U++
P1_8D25:  ADDD M_X0
P1_8D28:  STD  M_X0
P1_8D2B:  LDD  ,U++
P1_8D2D:  ADDD M_Y0
P1_8D30:  STD  M_Y0
P1_8D33:  LDD  ,U++
P1_8D35:  ADDD M_Z0
P1_8D38:  STD  M_Z0
P1_8D3B:  JSR  L60DE                  ;bank 1 KD9F6: transform and perspect the point into the next BJ_PNT entry
P1_8D3E:  LEAX -1,X
P1_8D40:  BNE  P1_8D23
P1_8D42:  PULS X,PC

;------------------------------------------------------------------------------
; cursor_oct_dist - octagon distance from the laser cursor LZ_CX, LZ_CY to the perspected point at X (x word, y
;   word): the larger of max(dx, dy) and 9/16 of dx + dy, less 10 and not below 0, returned in D. the same
;   arithmetic as the octagon tests of Star Wars' VWGUN and S2VW. uses scratch_1 and scratch_3. pages 0 and 2 have
;   their own copies (atat_oct_dist, lz_oct_dist, astrd_oct_dist)
;------------------------------------------------------------------------------
cursor_oct_dist:
P1_8D44:  LDD  ,X                     ;x of the point less the cursor's
P1_8D46:  SUBD >LZ_CX
P1_8D49:  BPL  P1_8D4F                ;IFMI
P1_8D4B:  COMA                        ;NEGD  ABSD
P1_8D4C:  NEGB
P1_8D4D:  SBCA #$FF
P1_8D4F:  STD  TMPOCT                 ;PREPARE FOR OCTAGON COLLISION DETECT
P1_8D51:  STD  scratch_1
P1_8D53:  LDD  2,X                    ;y of the point less the cursor's
P1_8D55:  SUBD >LZ_CY
P1_8D58:  BPL  P1_8D5E                ;IFMI
P1_8D5A:  COMA                        ;NEGD
P1_8D5B:  NEGB
P1_8D5C:  SBCA #$FF
P1_8D5E:  CMPD TMPSIZ                 ;$4803 = dx: keep the larger of dx and dy there
P1_8D61:  BLE  P1_8D65
P1_8D63:  STD  scratch_3
P1_8D65:  ADDD scratch_1              ;dx + dy
P1_8D67:  LSRA                        ;half of it
P1_8D68:  RORB
P1_8D69:  STD  scratch_1
P1_8D6B:  LSRA
P1_8D6C:  RORB
P1_8D6D:  LSRA
P1_8D6E:  RORB
P1_8D6F:  LSRA
P1_8D70:  RORB
P1_8D71:  ADDD scratch_1              ;plus a sixteenth: 9/16 of dx + dy
P1_8D73:  CMPD scratch_3              ;the octagon distance is the larger of the two
P1_8D76:  BGE  P1_8D7A
P1_8D78:  LDD  scratch_3
P1_8D7A:  SUBD #$000A                 ;10 units of allowance
P1_8D7D:  BGE  P1_8D82
P1_8D7F:  LDD  #$0000
P1_8D82:  RTS

;------------------------------------------------------------------------------
; atst_body_hit - laser test on the body of the AT-ST head just perspected (object $11), called while it is
;   drawn with its view distance in M_XT. does nothing if a nearer hit is already in atst_hit_d. otherwise turns a
;   radius of 110 into screen units at that distance and, if the cursor is within it of perspected point 16 or 17
;   (the two points on the head's centre line), records the distance in atst_hit_d and clears atst_hit_rec: the
;   shot stops on the armour and kills nothing
;------------------------------------------------------------------------------
atst_body_hit:
P1_8D83:  LDD  M_XT
P1_8D86:  CMPD atst_hit_d             ;a nearer hit is already recorded: leave
P1_8D8A:  BCC  P1_8DC8
P1_8D8C:  SUBD #$006E                 ;view distance less 110, at least 110
P1_8D8F:  CMPD #$006E
P1_8D93:  BGE  P1_8D98
P1_8D95:  LDD  #$006E
P1_8D98:  STD  M_DVD                  ;the divider gives its reciprocal
P1_8D9B:  LDD  #$006E                 ;radius 110 for point 16
P1_8D9E:  STD  M_YP
P1_8DA1:  LDD  #$006E
P1_8DA4:  STD  M_ZP                   ;radius 110 for point 17
P1_8DA7:  LDD  M_QUO                  ;the reciprocal of the distance
P1_8DAA:  STD  M_XP                   ;perspective multiply: both radii in screen units
P1_8DAD:  LDA  #MS_PERS
P1_8DAF:  JSR  MGOWT
P1_8DB2:  LDX  #BJ_PNT+$50            ;perspected point 16 of the head
P1_8DB5:  JSR  cursor_oct_dist
P1_8DB8:  SUBD M_YP
P1_8DBB:  BLT  P1_8DC9                ;the cursor is within the radius: the body is hit
P1_8DBD:  LDX  #BJ_PNT+$55            ;perspected point 17 of the head
P1_8DC0:  JSR  cursor_oct_dist
P1_8DC3:  SUBD M_ZP
P1_8DC6:  BLT  P1_8DC9
P1_8DC8:  RTS
P1_8DC9:  LDD  #$0000                 ;no record: the shot stops on the body without a kill
P1_8DCC:  STD  atst_hit_rec
P1_8DCF:  LDD  M_XT
P1_8DD2:  STD  atst_hit_d
P1_8DD5:  RTS

;------------------------------------------------------------------------------
; atst_window_hit - laser test on the front window of the AT-ST head, U = the AT-ST record, view distance in
;   M_XT. if no nearer hit is recorded and the cursor is inside the rectangle spanned by perspected points 12 to
;   15 of the head (the four corners of the window), stores U in atst_hit_rec and the distance in atst_hit_d: this
;   AT-ST is the one the laser will destroy
;------------------------------------------------------------------------------
atst_window_hit:
P1_8DD6:  LDD  M_XT
P1_8DD9:  CMPD atst_hit_d             ;a nearer hit is already recorded: leave
P1_8DDD:  BHI  P1_8E28
P1_8DDF:  LDX  #BJ_PNT+$41            ;X at perspected point 13: point 12 is at -5, 14 at 5, 15 at 10
P1_8DE2:  LDD  7,X                    ;the lower of the y of points 14 and 15, the window's bottom corners
P1_8DE4:  CMPD 12,X
P1_8DE7:  BLE  P1_8DEB
P1_8DE9:  LDD  12,X
P1_8DEB:  SUBD #$0000
P1_8DEE:  SUBD >LZ_CY
P1_8DF1:  BGT  P1_8E28                ;the cursor is below the window
P1_8DF3:  LDD  -3,X                   ;the higher of the y of points 12 and 13, the top corners
P1_8DF5:  CMPD 2,X
P1_8DF8:  BGE  P1_8DFC
P1_8DFA:  LDD  2,X
P1_8DFC:  ADDD #$0000
P1_8DFF:  SUBD >LZ_CY
P1_8E02:  BLT  P1_8E28                ;the cursor is above the window
P1_8E04:  LDD  -5,X                   ;the smaller of the x of points 12 and 14
P1_8E06:  CMPD 5,X
P1_8E09:  BLE  P1_8E0D
P1_8E0B:  LDD  5,X
P1_8E0D:  SUBD #$0000
P1_8E10:  SUBD >LZ_CX
P1_8E13:  BGT  P1_8E28                ;the cursor is to one side of the window
P1_8E15:  LDD  ,X                     ;the larger of the x of points 13 and 15
P1_8E17:  CMPD 10,X
P1_8E1A:  BGE  P1_8E1E
P1_8E1C:  LDD  10,X
P1_8E1E:  ADDD #$0000
P1_8E21:  SUBD >LZ_CX
P1_8E24:  BLT  P1_8E28                ;the cursor is to the other side
P1_8E26:  BRA  P1_8E29
P1_8E28:  RTS
P1_8E29:  STU  atst_hit_rec           ;the cursor is on the window: this AT-ST is the laser's target
P1_8E2C:  LDD  M_XT
P1_8E2F:  STD  atst_hit_d
P1_8E32:  RTS

;------------------------------------------------------------------------------
; atst_killed - the laser has hit an AT-ST window: jumped to through the maze from page 3 P3_980B with the
;   record in atst_hit_rec. puts the AT-ST's universe position in M_XT, M_YT, M_ZT and starts the three-piece
;   explosion there (bank 1 KE718 through L61A4), places the record anew or frees it (atst_place), scores 50
;   points while bonus_left is not zero and 500 after, sends the explosion sound and counts the kill in kill_count
;   (50 at most). the kill that brings bonus_left to zero also scores the walker quota bonus, awards the Jedi
;   letter (P1_9573) and bumps quota_walker
;------------------------------------------------------------------------------
atst_killed:
P1_8E33:  LDU  atst_hit_rec
P1_8E36:  LDA  ,U
P1_8E38:  BITA #$40                   ;$40: the record holds universe coordinates, otherwise they are relative to the player
P1_8E3A:  BEQ  P1_8E4D
P1_8E3C:  LDD  5,U
P1_8E3E:  STD  M_XT
P1_8E41:  LDD  7,U
P1_8E43:  STD  M_YT
P1_8E46:  LDD  9,U
P1_8E48:  STD  M_ZT
P1_8E4B:  BRA  P1_8E62
P1_8E4D:  LDD  5,U
P1_8E4F:  ADDD s1_tx
P1_8E52:  STD  M_XT
P1_8E55:  LDD  7,U
P1_8E57:  ADDD s1_ty
P1_8E5A:  STD  M_YT
P1_8E5D:  LDD  9,U
P1_8E5F:  STD  M_ZT
P1_8E62:  JSR  L61A4                  ;bank 1 KE718: start the three-piece explosion at M_XT, M_YT, M_ZT
P1_8E65:  JSR  atst_place             ;place the AT-ST anew or free the record
P1_8E68:  LDA  bonus_left             ;quota not yet met: 50 points, otherwise 500
P1_8E6B:  BEQ  P1_8E72
P1_8E6D:  JSR  scr_atst_50
P1_8E70:  BRA  P1_8E75
P1_8E72:  JSR  scr_atst_500
P1_8E75:  JSR  aud_cmd_3c
P1_8E78:  LDA  kill_count
P1_8E7B:  INCA
P1_8E7C:  CMPA #$32                   ;the kill count stops at 50
P1_8E7E:  BLS  P1_8E82
P1_8E80:  LDA  #$32
P1_8E82:  STA  kill_count
P1_8E85:  LDA  bonus_left
P1_8E88:  BEQ  P1_8E98
P1_8E8A:  DEC  bonus_left
P1_8E8D:  BNE  P1_8E98                ;the quota is met with this kill
P1_8E8F:  JSR  scr_walker_quota       ;5000 points
P1_8E92:  JSR  P1_81E4                ;calls page 1 jedi_award
P1_8E95:  INC  quota_walker
P1_8E98:  RTS

;------------------------------------------------------------------------------
; atst_place - U = an AT-ST record. if the spawn count w2_spawn_a is zero or negative the record is freed (bytes
;   0 and 1 cleared). otherwise the record is made a fresh AT-ST: status $29 (the coordinate flag $40 kept), flags
;   cleared, and a new place - one of x and y, chosen at random, gets $8000 added and the other a random value
;   from -$4000 to $3FFF. an AT-ST that was not on screen is first put at the player's position, so it starts half
;   the universe away. called for a free record by the AT-ST mover P1_86E1 and after a kill
;------------------------------------------------------------------------------
atst_place:
P1_8E99:  LDA  w2_spawn_a             ;nothing left to spawn: free the record
P1_8E9C:  BGT  P1_8EA5
P1_8E9E:  LDA  #$00
P1_8EA0:  STA  1,U
P1_8EA2:  STA  ,U
P1_8EA4:  RTS
P1_8EA5:  JSR  rnd_set
P1_8EA8:  LDA  1,U                    ;$10: the AT-ST was on screen at the last draw
P1_8EAA:  BITA #$10
P1_8EAC:  BNE  P1_8EB7
P1_8EAE:  LDD  #$0000                 ;not on screen: start from the player's position (relative 0, 0)
P1_8EB1:  STA  ,U
P1_8EB3:  STD  5,U
P1_8EB5:  STD  7,U
P1_8EB7:  LDA  ,U                     ;keep the coordinate flag, status $29
P1_8EB9:  ANDA #$40
P1_8EBB:  ORA  #$29
P1_8EBD:  STA  ,U
P1_8EBF:  LDA  #$00
P1_8EC1:  STA  1,U
P1_8EC3:  LDA  RND_S1                 ;random choice of the axis that gets the half-universe step
P1_8EC5:  BPL  P1_8EDD
P1_8EC7:  LDD  5,U                    ;x half the universe away
P1_8EC9:  ADDD #$8000
P1_8ECC:  STD  5,U
P1_8ECE:  LDD  RND_S1                 ;y random, -$4000 to $3FFF
P1_8ED0:  ASLB
P1_8ED1:  BCC  P1_8ED7
P1_8ED3:  ANDA #$3F
P1_8ED5:  BRA  P1_8ED9
P1_8ED7:  ORA  #$C0
P1_8ED9:  STD  7,U
P1_8EDB:  BRA  P1_8EF1
P1_8EDD:  LDD  7,U                    ;y half the universe away
P1_8EDF:  ADDD #$8000
P1_8EE2:  STD  7,U
P1_8EE4:  LDD  RND_S1                 ;x random, -$4000 to $3FFF
P1_8EE6:  ASLB
P1_8EE7:  BCC  P1_8EED
P1_8EE9:  ANDA #$3F
P1_8EEB:  BRA  P1_8EEF
P1_8EED:  ORA  #$C0
P1_8EEF:  STD  5,U
P1_8EF1:  RTS

gun_move_tab:
P1_8EF2:  .word gun_mov_stay          ;move routines of the gun shots by kind (byte 4 of the gun record), used by P1_9185: kind 0
P1_8EF4:  .word gun_mov_home          ;kind 1, TIE fighter shot
P1_8EF6:  .word gun_mov_home          ;kind 2, AT-AT shot
P1_8EF8:  .word gun_mov_home          ;kind 3, AT-ST shot
P1_8EFA:  .word gun_mov_home          ;kind 4, probot shot

;------------------------------------------------------------------------------
; gun_init - the last part of Star Wars' IPGEN (the IPGEN_40 loop), called from init_general in bank 0: gives
;   each of the six gun shot records from GUN to BJBIC its 8-byte block in math RAM from M_GN, its BIC from
;   MS_GNBC, and clears its type so that it is free
;------------------------------------------------------------------------------
gun_init:
P1_8EFC:  LDX  #GUN
P1_8EFF:  LDU  #M_GN
P1_8F02:  LDB  #MS_GNBC

IPGEN_40:
P1_8F04:  STU  ,X
P1_8F06:  STB  GS_BIC,X
P1_8F08:  CLR  GS_TYP,X
P1_8F0A:  LEAU 8,U
P1_8F0C:  ADDB #$01
P1_8F0E:  LEAX 8,X
P1_8F10:  CMPX #BJBIC
P1_8F13:  BCS  IPGEN_40
P1_8F15:  RTS

;------------------------------------------------------------------------------
; tie_fire - makes a TIE fighter fire a shot: X = the alien record, carry set on return if a shot was started.
;   called from page 3 CPUAL and from man_tie_fire in bank 0. it first runs the slapstic's alternate sequence for
;   page 3, so that the page select on the way back through the maze, which names page 1, selects page 3, the
;   caller's page. in the training manual the shot is started at once in the first gun record, otherwise
;   tie_fire_try decides. close copies: atat_fire, atst_fire and P1_9063
;------------------------------------------------------------------------------
tie_fire:
P1_8F16:  PSHS X,U
P1_8F18:  LEAU ,X                     ;U = the alien record
P1_8F1A:  LDX  #$9B5F                 ;the number $9B5C + 3, an address the slapstic watches for, not a place in vw_walker_ind: its read at slap_alt_read is the alternate sequence for page 3
P1_8F1D:  JSR  slap_alt_read          ;slapstic alternate sequence: the next page select will select page 3
P1_8F20:  LDA  man_running            ;training manual: fire at once from the first gun record
P1_8F23:  BEQ  P1_8F2D
P1_8F25:  LDX  #GUN
P1_8F28:  JSR  tie_shot_start
P1_8F2B:  BRA  P1_8F30
P1_8F2D:  JSR  tie_fire_try
P1_8F30:  PULS X,U,PC

;------------------------------------------------------------------------------
; tie_fire_try - U = the alien record. takes the entry of the shot table P1_90E4 for fire_level (17 entries of 4
;   bytes, the level halved during 16 frames of every 64): byte 0 becomes the alien's reload time (byte 4 of its
;   record), no shot is fired unless a random byte is above byte 1, and the word is the highest gun record that
;   may be used. looks for a free record from there down (P1_90D2, which returns to this routine's caller with
;   carry clear if there is none) and falls into tie_shot_start. returns carry clear when it does not fire
;------------------------------------------------------------------------------
tie_fire_try:
P1_8F32:  LDX  #gun_fire_tab          ;shot table: reload time, random threshold, highest gun record
P1_8F35:  LDB  fire_level
P1_8F38:  LDA  ph_tim_lo              ;for 16 frames in every 64 the level counts half
P1_8F3B:  BITA #$30
P1_8F3D:  BNE  P1_8F40
P1_8F3F:  LSRB
P1_8F40:  CMPB #$11                   ;the table has entries 0-$10
P1_8F42:  BCS  P1_8F46
P1_8F44:  LDB  #$10
P1_8F46:  ASLB
P1_8F47:  ASLB
P1_8F48:  LEAX B,X
P1_8F4A:  LDB  ,X
P1_8F4C:  STB  4,U                    ;the alien's reload time
P1_8F4E:  LDA  P_RND1                 ;fire only if the random byte is above the entry's threshold
P1_8F51:  CMPA 1,X
P1_8F53:  BLS  P1_8F88
P1_8F55:  LDX  2,X                    ;highest gun record to try
P1_8F57:  JSR  gun_find_free          ;find a free one from there down, or leave with carry clear

;------------------------------------------------------------------------------
; tie_shot_start - X = a free gun record, U = the alien record. starts a TIE fighter shot: life timer $40, type
;   1, kind 1, aim offsets from P1_9168, and the shot's point in math RAM set to the alien's position (MS_TX,
;   MS_TY, MS_TZ of its block) less the player's. sends sound aud_cmd_3d and returns carry set
;------------------------------------------------------------------------------
tie_shot_start:
P1_8F5A:  LDB  #$40                   ;life timer of the shot
P1_8F5C:  STB  5,X
P1_8F5E:  LDB  #$01                   ;type 1: the record is in use
P1_8F60:  STB  3,X
P1_8F62:  LDB  #$01                   ;kind 1: TIE fighter shot
P1_8F64:  STB  4,X
P1_8F66:  JSR  gun_aim_error          ;aim offsets, bytes 6 and 7
P1_8F69:  LDX  ,X                     ;the shot's point in math RAM
P1_8F6B:  LDU  ,U                     ;the alien's block in math RAM
P1_8F6D:  LDD  8,U                    ;the alien's position less the player's
P1_8F6F:  SUBD s1_tx
P1_8F72:  STD  ,X
P1_8F74:  LDD  10,U
P1_8F76:  SUBD s1_ty
P1_8F79:  STD  2,X
P1_8F7B:  LDD  12,U
P1_8F7D:  SUBD s1_tz
P1_8F80:  STD  4,X
P1_8F82:  JSR  aud_cmd_3d
P1_8F85:  ORCC #$01                   ;carry set: fired
P1_8F87:  RTS
P1_8F88:  ANDCC #$FE                  ;carry clear: no shot
P1_8F8A:  RTS

;------------------------------------------------------------------------------
; atat_fire - makes an AT-AT fire a shot: U = the AT-AT record, carry set on return if a shot was started.
;   called from page 0 P0_8B72 and from man_atat_fire in bank 0. it first runs the slapstic's alternate sequence
;   for page 0, so that the page select on the way back through the maze, which names page 1, selects page 0, the
;   caller's page. in the training manual the shot is started at once in the first gun record, otherwise
;   atat_fire_try decides. a close copy of tie_fire
;------------------------------------------------------------------------------
atat_fire:
P1_8F8B:  PSHS X,U
P1_8F8D:  LDX  #$9B5C                 ;$9B5C + 0: the alternate sequence for page 0
P1_8F90:  JSR  slap_alt_read          ;slapstic alternate sequence: the next page select will select page 0
P1_8F93:  LDA  man_running            ;training manual: fire at once from the first gun record
P1_8F96:  BEQ  P1_8FA0
P1_8F98:  LDX  #GUN
P1_8F9B:  JSR  atat_shot_start
P1_8F9E:  BRA  P1_8FA3
P1_8FA0:  JSR  atat_fire_try
P1_8FA3:  PULS X,U,PC

;------------------------------------------------------------------------------
; atat_fire_try - U = the AT-AT record. as tie_fire_try without the halving of the level: the shot table entry
;   for fire_level gives the reload time (byte 3 of the record), the random threshold and the highest gun record
;   to use. falls into atat_shot_start when a record is free, returns carry clear when it does not fire
;------------------------------------------------------------------------------
atat_fire_try:
P1_8FA5:  LDX  #gun_fire_tab          ;shot table: reload time, random threshold, highest gun record
P1_8FA8:  LDB  fire_level
P1_8FAB:  CMPB #$11                   ;the table has entries 0-$10
P1_8FAD:  BCS  P1_8FB1
P1_8FAF:  LDB  #$10
P1_8FB1:  ASLB
P1_8FB2:  ASLB
P1_8FB3:  LEAX B,X
P1_8FB5:  LDB  ,X
P1_8FB7:  STB  3,U                    ;the AT-AT's reload time
P1_8FB9:  LDA  P_RND1                 ;fire only if the random byte is above the entry's threshold
P1_8FBC:  CMPA 1,X
P1_8FBE:  BLS  P1_8FF4
P1_8FC0:  LDX  2,X                    ;highest gun record to try
P1_8FC2:  JSR  gun_find_free          ;find a free one from there down, or leave with carry clear

;------------------------------------------------------------------------------
; atat_shot_start - X = a free gun record. starts an AT-AT shot: life timer $70, type $41, kind 2, aim offsets
;   from P1_9168, and the shot's point in math RAM set to the muzzle position the caller left in M_XT2, M_YT2,
;   M_ZT2 less the player's position. sends sound aud_cmd_41 and returns carry set
;------------------------------------------------------------------------------
atat_shot_start:
P1_8FC5:  LDA  #$70                   ;life timer of the shot
P1_8FC7:  STA  5,X
P1_8FC9:  LDA  #$41                   ;type $41
P1_8FCB:  STA  3,X
P1_8FCD:  LDB  #$02                   ;kind 2: AT-AT shot
P1_8FCF:  STB  4,X
P1_8FD1:  JSR  gun_aim_error          ;aim offsets, bytes 6 and 7
P1_8FD4:  LDX  ,X                     ;the shot's point in math RAM
P1_8FD6:  LDD  M_XT2                  ;the muzzle position the caller computed, less the player's position
P1_8FD9:  SUBD s1_tx
P1_8FDC:  STD  ,X
P1_8FDE:  LDD  M_YT2
P1_8FE1:  SUBD s1_ty
P1_8FE4:  STD  2,X
P1_8FE6:  LDD  M_ZT2
P1_8FE9:  SUBD s1_tz
P1_8FEC:  STD  4,X
P1_8FEE:  JSR  aud_cmd_41
P1_8FF1:  ORCC #$01                   ;carry set: fired
P1_8FF3:  RTS
P1_8FF4:  ANDCC #$FE                  ;carry clear: no shot
P1_8FF6:  RTS

;------------------------------------------------------------------------------
; atst_fire - makes an AT-ST fire a shot: U = the AT-ST record, carry set on return if a shot was started.
;   called from P1_8B52 on this page and from man_atst_fire in bank 0. it runs the slapstic's alternate sequence
;   for page 1, which the maze's page select names anyway, so this copy only keeps the pattern of tie_fire and
;   atat_fire. in the training manual the shot is started at once in the first gun record (P1_9031), otherwise
;   P1_9011 decides from the shot table
;------------------------------------------------------------------------------
atst_fire:
P1_8FF7:  PSHS X,U
P1_8FF9:  LDX  #$9B5D                 ;$9B5C + 1: the alternate sequence for page 1
P1_8FFC:  JSR  slap_alt_read          ;slapstic alternate sequence: the next page select will select page 1
P1_8FFF:  LDA  man_running
P1_9002:  BEQ  P1_900C
P1_9004:  LDX  #GUN                   ;manual page: fire from the first gun record at once
P1_9007:  JSR  atst_shot_start
P1_900A:  BRA  P1_900F
P1_900C:  JSR  atst_fire_try
P1_900F:  PULS X,U,PC

;------------------------------------------------------------------------------
; atst_fire_try - decides whether the AT-ST at U fires, for P1_8FF7 in play. takes the gun_fire_tab entry of
;   fire_level (held at 16), stores its first byte in byte 3 of the walker record - the count the caller tests for
;   zero before it asks to fire again - and gives up with carry clear unless the random byte is above the entry's
;   second byte. else gun_find_free looks for a free gun record from the entry's record downwards and the code
;   falls into atst_shot_start. with no free record gun_find_free returns straight to this routine's caller, carry
;   clear
;------------------------------------------------------------------------------
atst_fire_try:
P1_9011:  LDX  #gun_fire_tab
P1_9014:  LDB  fire_level
P1_9017:  CMPB #$11                   ;levels above 16 use entry 16
P1_9019:  BCS  P1_901D
P1_901B:  LDB  #$10
P1_901D:  ASLB                        ;4 bytes an entry
P1_901E:  ASLB
P1_901F:  LEAX B,X
P1_9021:  LDB  ,X                     ;entry byte 0: the count the AT-ST must wait before it asks again
P1_9023:  STB  3,U
P1_9025:  LDA  P_RND1
P1_9028:  CMPA 1,X                    ;entry byte 1: fire only when the random byte is above it
P1_902A:  BLS  P1_9060
P1_902C:  LDX  2,X                    ;entry word: the highest gun record this level may use
P1_902E:  JSR  gun_find_free          ;free record from there down, or out to the caller with carry clear

;------------------------------------------------------------------------------
; atst_shot_start - starts an AT-ST shot in the gun record at X: timer $70, type $41 (live, and bit 6 that marks
;   a walker's shot), move routine 3, aim offsets from gun_aim_error, position = the firing point the caller left
;   in M_XT2, M_YT2, M_ZT2 minus the player's position, and the sound of aud_cmd_41. returns carry set. the
;   training manual calls it with X = GUN to fire at once. the AT-AT's copy at P1_8FC5 differs only in move
;   routine 2
;------------------------------------------------------------------------------
atst_shot_start:
P1_9031:  LDA  #$70                   ;$70 frames to live
P1_9033:  STA  5,X
P1_9035:  LDA  #$41                   ;live, bit 6: a walker's shot
P1_9037:  STA  3,X
P1_9039:  LDB  #$03                   ;move routine 3
P1_903B:  STB  4,X
P1_903D:  JSR  gun_aim_error
P1_9040:  LDX  ,X                     ;the shot's block in math RAM
P1_9042:  LDD  M_XT2                  ;firing point minus the player's position: the shot is kept relative to the player
P1_9045:  SUBD s1_tx
P1_9048:  STD  ,X
P1_904A:  LDD  M_YT2
P1_904D:  SUBD s1_ty
P1_9050:  STD  2,X
P1_9052:  LDD  M_ZT2
P1_9055:  SUBD s1_tz
P1_9058:  STD  4,X
P1_905A:  JSR  aud_cmd_41
P1_905D:  ORCC #$01                   ;carry set: a shot was fired
P1_905F:  RTS
P1_9060:  ANDCC #$FE                  ;carry clear: none
P1_9062:  RTS

;------------------------------------------------------------------------------
; probot_fire - the probot at U asks to fire a shot: called through maze entry MZ_8295 by page 2 (P2_9171, when
;   byte 3 of the probot is 0) and by the training manual script of bank 0 (LB1D2). it begins with the slapstic's
;   alternate sequence, so that the page select of the maze's return path selects page 2, the page of its caller.
;   while a manual page is shown it starts the shot in the first gun record at once, else probot_fire_try decides.
;   carry set if a shot was fired. a close copy of P1_8F16, P1_8F8B and P1_8FF7
;------------------------------------------------------------------------------
probot_fire:
P1_9063:  PSHS X,U
P1_9065:  LDX  #$9B5E                 ;$9B5C+2: page 2
P1_9068:  JSR  slap_alt_read          ;slapstic alternate sequence: the next page select will select page 2
P1_906B:  LDA  man_running
P1_906E:  BEQ  P1_9078
P1_9070:  LDX  #GUN                   ;manual page: fire from the first gun record at once
P1_9073:  JSR  probot_shot_start
P1_9076:  BRA  P1_907B
P1_9078:  JSR  probot_fire_try
P1_907B:  PULS X,U,PC

;------------------------------------------------------------------------------
; probot_fire_try - decides whether the probot at U fires: as atst_fire_try, but with the probots' own table
;   probot_fire_tab, 16 entries, fire_level held at 15. stores the entry's first byte in byte 3 of the probot
;   record, needs the random byte above the entry's second byte and a free gun record from the entry's record
;   downwards, then falls into probot_shot_start
;------------------------------------------------------------------------------
probot_fire_try:
P1_907D:  LDX  #probot_fire_tab
P1_9080:  LDB  fire_level
P1_9083:  CMPB #$10                   ;levels above 15 use entry 15
P1_9085:  BCS  P1_9089
P1_9087:  LDB  #$0F
P1_9089:  ASLB
P1_908A:  ASLB
P1_908B:  LEAX B,X
P1_908D:  LDB  ,X                     ;entry byte 0: the count the probot must wait before it asks again
P1_908F:  STB  3,U
P1_9091:  LDA  P_RND1
P1_9094:  CMPA 1,X                    ;entry byte 1: fire only when the random byte is above it
P1_9096:  BLS  P1_90CC
P1_9098:  LDX  2,X                    ;entry word: the highest gun record this level may use
P1_909A:  JSR  gun_find_free

;------------------------------------------------------------------------------
; probot_shot_start - starts a probot shot in the gun record at X: timer $70, type $01 (live), move routine 4,
;   aim offsets from gun_aim_error, position = the firing point in M_XT2, M_YT2, M_ZT2 minus the player's
;   position, and the sound of aud_cmd_3d. returns carry set
;------------------------------------------------------------------------------
probot_shot_start:
P1_909D:  LDA  #$70                   ;$70 frames to live
P1_909F:  STA  5,X
P1_90A1:  LDA  #$01                   ;live
P1_90A3:  STA  3,X
P1_90A5:  LDB  #$04                   ;move routine 4
P1_90A7:  STB  4,X
P1_90A9:  JSR  gun_aim_error
P1_90AC:  LDX  ,X
P1_90AE:  LDD  M_XT2                  ;firing point minus the player's position
P1_90B1:  SUBD s1_tx
P1_90B4:  STD  ,X
P1_90B6:  LDD  M_YT2
P1_90B9:  SUBD s1_ty
P1_90BC:  STD  2,X
P1_90BE:  LDD  M_ZT2
P1_90C1:  SUBD s1_tz
P1_90C4:  STD  4,X
P1_90C6:  JSR  aud_cmd_3d
P1_90C9:  ORCC #$01                   ;carry set: a shot was fired
P1_90CB:  RTS
P1_90CC:  ANDCC #$FE                  ;carry clear: none
P1_90CE:  RTS

;------------------------------------------------------------------------------
; gun_find_last - X = the last gun record ($4928), falling into gun_find_free. an entry nothing calls
;------------------------------------------------------------------------------
gun_find_last:
P1_90CF:  LDX  #$4928                 ;LDX #$4928, the last gun record: a way into gun_find_free that nothing uses

;------------------------------------------------------------------------------
; gun_find_free - finds a free gun record: starts at X and goes down one 8 byte record at a time to GUN, returns
;   with X and GN_PTR at the first record whose type byte is 0. if there is none it drops its return address and
;   returns to the caller's caller with carry clear. Star Wars' TSTAVAIL searched upwards from X to GUNZ, here the
;   start record is the highest one a level may use, so it limits how many shots can be in flight
;------------------------------------------------------------------------------
gun_find_free:
P1_90D2:  STX  GN_PTR
P1_90D4:  LDA  3,X                    ;type 0: free
P1_90D6:  BEQ  P1_90E3
P1_90D8:  LEAX -8,X                   ;next lower record
P1_90DA:  CMPX #GUN
P1_90DD:  BCC  gun_find_free
P1_90DF:  LEAS 2,S                    ;none free: drop the return address, the caller's caller gets carry clear
P1_90E1:  ANDCC #$FE
P1_90E3:  RTS

gun_fire_tab:
P1_90E4:  .byte $0F, $80              ;gun_fire_tab row 0: wait, random threshold, gun record  17 entries of 4 bytes for fire_level 0-16, to $9127: wait count, random threshold, highest gun record. used for the TIE fighters, the AT-ATs and the AT-STs
P1_90E6:  .word $4900
P1_90E8:  .byte $0F, $80              ;gun_fire_tab row 1: wait, random threshold, gun record
P1_90EA:  .word $4900
P1_90EC:  .byte $0F, $80              ;gun_fire_tab row 2: wait, random threshold, gun record
P1_90EE:  .word $4908
P1_90F0:  .byte $0F, $40              ;gun_fire_tab row 3: wait, random threshold, gun record
P1_90F2:  .word $4910
P1_90F4:  .byte $07, $80              ;gun_fire_tab row 4: wait, random threshold, gun record
P1_90F6:  .word $4918
P1_90F8:  .byte $07, $20              ;gun_fire_tab row 5: wait, random threshold, gun record
P1_90FA:  .word $4920
P1_90FC:  .byte $07, $20              ;gun_fire_tab row 6: wait, random threshold, gun record
P1_90FE:  .word $4920
P1_9100:  .byte $07, $20              ;gun_fire_tab row 7: wait, random threshold, gun record
P1_9102:  .word $4928
P1_9104:  .byte $07, $20              ;gun_fire_tab row 8: wait, random threshold, gun record
P1_9106:  .word $4928
P1_9108:  .byte $03, $80              ;gun_fire_tab row 9: wait, random threshold, gun record
P1_910A:  .word $4928
P1_910C:  .byte $03, $80              ;gun_fire_tab row 10: wait, random threshold, gun record
P1_910E:  .word $4928
P1_9110:  .byte $03, $60              ;gun_fire_tab row 11: wait, random threshold, gun record
P1_9112:  .word $4928
P1_9114:  .byte $03, $60              ;gun_fire_tab row 12: wait, random threshold, gun record
P1_9116:  .word $4928
P1_9118:  .byte $03, $40              ;gun_fire_tab row 13: wait, random threshold, gun record
P1_911A:  .word $4928
P1_911C:  .byte $03, $40              ;gun_fire_tab row 14: wait, random threshold, gun record
P1_911E:  .word $4928
P1_9120:  .byte $03, $30              ;gun_fire_tab row 15: wait, random threshold, gun record
P1_9122:  .word $4928
P1_9124:  .byte $03, $30              ;gun_fire_tab row 16: wait, random threshold, gun record
P1_9126:  .word $4928

probot_fire_tab:
P1_9128:  .byte $20, $C0              ;probot_fire_tab row 0: wait, random threshold, gun record  16 entries of the same form for the probots, fire_level 0-15, to $9167
P1_912A:  .word $4900
P1_912C:  .byte $20, $C0              ;probot_fire_tab row 1: wait, random threshold, gun record
P1_912E:  .word $4900
P1_9130:  .byte $20, $B0              ;probot_fire_tab row 2: wait, random threshold, gun record
P1_9132:  .word $4908
P1_9134:  .byte $20, $B0              ;probot_fire_tab row 3: wait, random threshold, gun record
P1_9136:  .word $4908
P1_9138:  .byte $10, $A0              ;probot_fire_tab row 4: wait, random threshold, gun record
P1_913A:  .word $4910
P1_913C:  .byte $10, $A0              ;probot_fire_tab row 5: wait, random threshold, gun record
P1_913E:  .word $4910
P1_9140:  .byte $08, $90              ;probot_fire_tab row 6: wait, random threshold, gun record
P1_9142:  .word $4918
P1_9144:  .byte $08, $90              ;probot_fire_tab row 7: wait, random threshold, gun record
P1_9146:  .word $4918
P1_9148:  .byte $04, $80              ;probot_fire_tab row 8: wait, random threshold, gun record
P1_914A:  .word $4920
P1_914C:  .byte $04, $80              ;probot_fire_tab row 9: wait, random threshold, gun record
P1_914E:  .word $4920
P1_9150:  .byte $04, $60              ;probot_fire_tab row 10: wait, random threshold, gun record
P1_9152:  .word $4928
P1_9154:  .byte $04, $60              ;probot_fire_tab row 11: wait, random threshold, gun record
P1_9156:  .word $4928
P1_9158:  .byte $04, $40              ;probot_fire_tab row 12: wait, random threshold, gun record
P1_915A:  .word $4928
P1_915C:  .byte $04, $40              ;probot_fire_tab row 13: wait, random threshold, gun record
P1_915E:  .word $4928
P1_9160:  .byte $04, $20              ;probot_fire_tab row 14: wait, random threshold, gun record
P1_9162:  .word $4928
P1_9164:  .byte $04, $20              ;probot_fire_tab row 15: wait, random threshold, gun record
P1_9166:  .word $4928

;------------------------------------------------------------------------------
; gun_aim_error - sets the two aim offset bytes 6 and 7 of the gun record at X: when a 5 bit random number is
;   below fire_level both get the random byte P_RND1, else both are 0 and the shot homes on the player exactly.
;   gun_mov_home adds six times each byte, signed, to the y and z of the point it steers for
;------------------------------------------------------------------------------
gun_aim_error:
P1_9168:  LDA  P_RND1
P1_916B:  ANDA #$1F                   ;5 bit random number
P1_916D:  CMPA fire_level
P1_9170:  BLT  P1_917A
P1_9172:  LDA  #$00                   ;not below the level: no offset, the shot homes exactly
P1_9174:  STA  6,X
P1_9176:  STA  7,X
P1_9178:  BRA  P1_9184
P1_917A:  LDA  P_RND1                 ;below it: both offsets from the random byte
P1_917D:  STA  6,X
P1_917F:  LDA  P_RND1
P1_9182:  STA  7,X
P1_9184:  RTS

;------------------------------------------------------------------------------
; MVGUN - Star Wars' MVGUN, move guns, not matched because two instructions differ: for every gun record in use
;   it calls the move routine of byte 4 through the table at P1_8EF2 (0 gun_mov_stay, 1 to 4 gun_mov_home). called
;   every frame by the phases of all four parts through maze entry MZ_84CC. where Star Wars has SWI for a routine
;   number out of range this code loads index 1, an odd offset into the table
;------------------------------------------------------------------------------
MVGUN:
P1_9185:  LDX  #GUN
P1_9188:  STX  GN_PTR
P1_918A:  LDA  3,X
P1_918C:  BEQ  P1_919C                ;record not in use
P1_918E:  LDB  4,X
P1_9190:  ASLB                        ;move routine number * 2
P1_9191:  CMPB #$0A
P1_9193:  BCS  P1_9197
P1_9195:  LDB  #$01                   ;number above 4: index 1, an odd offset into the table. Star Wars has SWI here
P1_9197:  LDU  #gun_move_tab
P1_919A:  JSR  [B,U]
P1_919C:  LDX  GN_PTR
P1_919E:  LEAX 8,X
P1_91A0:  CMPX #BJBIC
P1_91A3:  BCS  P1_9188
P1_91A5:  RTS

;------------------------------------------------------------------------------
; gun_timer - counts down the timer of the gun record at X, the common start of both move routines. when it runs
;   out a shot that is neither hurt nor glowing becomes a hurt one (type bit $20 set, live and pretty bits
;   cleared) with 8 frames left, so a shot that timed out bursts like one the player hit, and a hurt or glowing
;   one is freed (type and timer 0). returns Z set only when the record was freed
;------------------------------------------------------------------------------
gun_timer:
P1_91A6:  DEC  5,X
P1_91A8:  BGT  P1_91C1                ;timer still running
P1_91AA:  LDA  3,X
P1_91AC:  BITA #$30                   ;hurt or glowing already: free the record
P1_91AE:  BNE  P1_91BC
P1_91B0:  ORA  #$20                   ;else it becomes a hurt shot, no longer live
P1_91B2:  ANDA #$FC
P1_91B4:  STA  3,X
P1_91B6:  LDA  #$08                   ;for 8 more frames
P1_91B8:  STA  5,X
P1_91BA:  BRA  P1_91C1
P1_91BC:  CLRB
P1_91BD:  STB  3,X
P1_91BF:  STB  5,X
P1_91C1:  RTS

;------------------------------------------------------------------------------
; gun_mov_stay - move routine 0 (MOVS_ST, stay in place), reached through the table at P1_8EF2: only gun_timer.
;   Star Wars' MOVST freed the record when the timer ran out
;------------------------------------------------------------------------------
gun_mov_stay:
P1_91C2:  BSR  gun_timer
P1_91C4:  RTS

;------------------------------------------------------------------------------
; gun_mov_home - move routines 1 to 4, reached through the table at P1_8EF2: after gun_timer it puts a point in
;   the scratch block - the player's position from M_XT1, M_YT1, M_ZT1 with six times the aim offset bytes 6 and 7
;   added to y and z - runs matrix program $2A on it and moves the shot one eighth of the way from where it is to
;   the result in M_XP, M_YP, M_ZP. it takes the place of Star Wars' MOVAM, which moved the shot one eighth of the
;   way to 0,0,0
;------------------------------------------------------------------------------
gun_mov_home:
P1_91C5:  BSR  gun_timer
P1_91C7:  BEQ  P1_922A                ;record freed
P1_91C9:  LDU  ,X                     ;the shot's block in math RAM
P1_91CB:  LDD  M_XT1                  ;point x: the player's
P1_91CE:  STD  M_X0
P1_91D1:  LDB  #$06                   ;6 * offset byte 6, signed
P1_91D3:  LDA  6,X
P1_91D5:  BMI  P1_91DA
P1_91D7:  MUL
P1_91D8:  BRA  P1_91E0
P1_91DA:  NEGA
P1_91DB:  MUL
P1_91DC:  COMA
P1_91DD:  NEGB
P1_91DE:  SBCA #$FF
P1_91E0:  ADDD M_YT1                  ;point y: the player's plus that
P1_91E3:  STD  M_Y0
P1_91E6:  LDB  #$06                   ;6 * offset byte 7, signed
P1_91E8:  LDA  7,X
P1_91EA:  BMI  P1_91EF
P1_91EC:  MUL
P1_91ED:  BRA  P1_91F5
P1_91EF:  NEGA
P1_91F0:  MUL
P1_91F1:  COMA
P1_91F2:  NEGB
P1_91F3:  SBCA #$FF
P1_91F5:  ADDD M_ZT1                  ;point z: the player's plus that
P1_91F8:  STD  M_Z0
P1_91FB:  LDD  #MS_X0BC               ;the scratch block
P1_91FE:  STD  M_BIC
P1_9201:  LDA  #$2A                   ;matrix program $2A (MS_PSUB in Star Wars)
P1_9203:  JSR  MGOWT
P1_9206:  LDD  M_XP                   ;x = x + (result x - x) / 8
P1_9209:  SUBD ,U
P1_920B:  JSR  ASRD3
P1_920E:  ADDD ,U
P1_9210:  STD  ,U
P1_9212:  LDD  M_YP                   ;the same for y
P1_9215:  SUBD 2,U
P1_9217:  JSR  ASRD3
P1_921A:  ADDD 2,U
P1_921C:  STD  2,U
P1_921E:  LDD  M_ZP                   ;and z
P1_9221:  SUBD 4,U
P1_9223:  JSR  ASRD3
P1_9226:  ADDD 4,U
P1_9228:  STD  4,U
P1_922A:  RTS

;------------------------------------------------------------------------------
; VWGUN - VIEW GUNS
;   in ESB: ESB adds the Jedi force: while jedi_on is set a shot that is not yet hurt and has |y| / 2 + x of
;   $7000 or less is destroyed where it is and scored (3 points, 7 for a walker's shot). the lazar may kill a
;   shot about to hit only if CL_GDS shows that a shot was in the sights this frame. the centre is processed
;   and restored through bank 1 (OBJCEN at L60B4, KD8AC at L60BA)
;------------------------------------------------------------------------------
VWGUN:
P1_922B:  LDX  #GUN                   ;X--> GUN PACKETS

VWGUN_10:
P1_922E:  STX  GN_PTR
P1_9230:  LDA  GS_TYP,X
P1_9232:  LBEQ VWGUN_95               ;?GUN BEING USED?
P1_9236:  BITA #TYPS_GL               ;?GLOWING AGAINST OUR SHIELDS?
P1_9238:  BEQ  P1_9240                ;IFNE
P1_923A:  JSR  GLOWVW                 ;THEN SHOW GUN AGAINST OUR SCREENS
P1_923D:  JMP  VWGUN_95               ;J
P1_9240:  BITA #TYPS_UN               ;?VIEW RELATIVE TO UNIVERSE?
P1_9242:  BEQ  P1_9258                ;IFNE
P1_9244:  LDD  MS_TX+M_S1             ;RESTORE DOWNLOADED UNIT VECTOR
P1_9247:  STD  MS_TX+M_U1
P1_924A:  LDD  MS_TY+M_S1
P1_924D:  STD  MS_TY+M_U1
P1_9250:  LDD  MS_TZ+M_S1
P1_9253:  STD  MS_TZ+M_U1
P1_9256:  BRA  P1_9264                ;ELSE  ELSE RELATIVE TO PLAYER
P1_9258:  LDD  #$0000                 ;CLRD
P1_925B:  STD  MS_TX+M_U1             ;GUNS ARE RELATIVE TO PLAYER
P1_925E:  STD  MS_TY+M_U1
P1_9261:  STD  MS_TZ+M_U1
P1_9264:  CLRA
P1_9265:  LDB  GS_BIC,X
P1_9267:  STD  M_BIC
P1_926A:  LDA  #MS_PSB2
P1_926C:  JSR  MGOWT
P1_926F:  LDD  M_XP                   ;X
P1_9272:  CMPD #$0001
P1_9276:  LBLE VWGUN_90
P1_927A:  CMPD #$7F00
P1_927E:  LBHI VWGUN_90
P1_9282:  STD  M_DVD
P1_9285:  STD  M_XT
P1_9288:  LDD  M_YP
P1_928B:  STD  M_YT
P1_928E:  BPL  P1_9294                ;IFMI
P1_9290:  COMA                        ;NEGD
P1_9291:  NEGB
P1_9292:  SBCA #$FF
P1_9294:  SUBD M_XP
P1_9297:  LBHS VWGUN_90
P1_929B:  LDD  M_ZP
P1_929E:  STD  M_ZT
P1_92A1:  BPL  P1_92A7                ;IFMI
P1_92A3:  COMA                        ;NEGD
P1_92A4:  NEGB
P1_92A5:  SBCA #$FF
P1_92A7:  SUBD M_XP
P1_92AA:  LBHS VWGUN_90
P1_92AE:  LDA  3,X                    ;ESB: the Jedi force destroys shots that come near
P1_92B0:  BITA #$20                   ;hurt already
P1_92B2:  BNE  P1_92EB
P1_92B4:  LDA  jedi_on                ;force not on
P1_92B7:  BEQ  P1_92EB
P1_92B9:  LDD  M_YP                   ;|y| / 2 + x
P1_92BC:  BPL  P1_92C2                ;IFMI
P1_92BE:  COMA                        ;NEGD  ABSOLUTE VALUE
P1_92BF:  NEGB
P1_92C0:  SBCA #$FF
P1_92C2:  LSRA
P1_92C3:  RORB
P1_92C4:  ADDD M_XP
P1_92C7:  CMPD #$7000                 ;above $7000: not near enough yet
P1_92CB:  BHI  P1_92EB
P1_92CD:  LDA  3,X                    ;make the shot hurt, not live
P1_92CF:  ORA  #$20
P1_92D1:  ANDA #$FC
P1_92D3:  STA  3,X
P1_92D5:  LDA  #$00                   ;stay in place
P1_92D7:  STA  4,X
P1_92D9:  LDA  #$0F                   ;fade timer
P1_92DB:  STA  5,X
P1_92DD:  LDA  3,X
P1_92DF:  BITA #$40                   ;bit 6, a walker's shot: 7 points, else 3
P1_92E1:  BEQ  P1_92E8
P1_92E3:  JSR  scr_shot_7
P1_92E6:  BRA  P1_92EB
P1_92E8:  JSR  scr_shot_3
P1_92EB:  JSR  L60B4                  ;bank 1 OBJCEN: process centre of gunshot
P1_92EE:  LDX  GN_PTR
P1_92F0:  LDA  GS_TYP,X
P1_92F2:  BITA #TYPS_LV+TYPS_PR       ;CAN ONLY HIT LIVE OR PRETTY SHOTS
P1_92F4:  BEQ  P1_9344                ;IFNE  ?ALLOWED TO HIT THIS SHOT?
P1_92F6:  LDD  #$0080                 ;FAT CHANCE OF COMPUTING THIS, TURNOFF GAS AND TEST IT
P1_92F9:  STD  M_YP
P1_92FC:  LDA  #MS_PERS
P1_92FE:  JSR  MGOWT
P1_9301:  LDD  M_YP
P1_9304:  ADDD #$000A                 ;SIZE OF CURSOR
P1_9307:  STD  TMPSIZ
P1_9309:  LDD  BJ_CX                  ;OBJECT CENTER
P1_930B:  SUBD LZ_CX                  ;LAZAR CENTER
P1_930D:  BPL  P1_9313                ;IFMI
P1_930F:  COMA                        ;NEGD  ABSD
P1_9310:  NEGB
P1_9311:  SBCA #$FF
P1_9313:  STD  scratch_1              ;PREPARE FOR OCTAGON COLLISION DETECT
P1_9315:  SUBD TMPSIZ
P1_9317:  BGT  P1_9344                ;IFLE  LE FOR LIBERALITY
P1_9319:  LDD  BJ_CY
P1_931B:  SUBD LZ_CY                  ;NOW CHECKING Y COORDS
P1_931D:  BPL  P1_9323                ;IFMI
P1_931F:  COMA                        ;NEGD
P1_9320:  NEGB
P1_9321:  SBCA #$FF
P1_9323:  CMPD TMPSIZ
P1_9326:  BGT  P1_9344                ;IFLE  ?WITHIN Y ALSO?
P1_9328:  ADDD scratch_1              ;THEN ADD TO OCTAGON TEST
P1_932A:  STD  scratch_1
P1_932C:  LDD  TMPSIZ
P1_932E:  LSRA                        ;LSRD
P1_932F:  RORB
P1_9330:  ADDD TMPSIZ                 ;MAKE 1.5 FOR OCTAGON
P1_9332:  SUBD scratch_1
P1_9334:  BLT  P1_9344                ;IFGE  ?ALSO WITHIN OCTAGON?
P1_9336:  LDD  M_XT                   ;THEN SEE IF WE ARE THE CLOSEST ALIEN
P1_9339:  CMPD CL_GDS                 ;GUN DISTANCE
P1_933C:  BHS  P1_9344                ;IFLO  ?ALSO THE NEAREST GUN SO FAR?
P1_933E:  STD  CL_GDS
P1_9340:  LDX  GN_PTR                 ;THEN WE GOT A HIT
P1_9342:  STX  CL_GP                  ;RECORD WHO WE ARE
P1_9344:  LDA  GS_TYP,X
P1_9346:  BITA #TYPS_LV
P1_9348:  BEQ  VWGUN_50               ;IFNE  ?LIVE SHELL HAS COLLISIONS ALLOWED?
P1_934A:  LDD  M_XT
P1_934D:  LSLB                        ;LSLD  SCALE BACK UP TO REGULAR COORDS
P1_934E:  ROLA
P1_934F:  BMI  VWGUN_50
P1_9351:  LDU  (MS_VX+M_S1)&$FFFF
P1_9354:  CMPU #$0200
P1_9358:  BLT  P1_935F                ;IFGE  ?PLAYER SHIP FAST ENUF?
P1_935A:  SUBD (MS_VX+M_S1)&$FFFF     ;THEN USE ITS SPEED
P1_935D:  BRA  P1_9362                ;ELSE  ELSE
P1_935F:  SUBD #$0200                 ;MIN DISTANCE LEST SHOTS ARE TOO LARGE
P1_9362:  BLE  VWGUN_40               ;B COLLISION IF WITHIN FORWARD MOVEMENT
P1_9364:  SUBD #$0110                 ;MAX GUN SPEED PLUS FUDGE
P1_9367:  BGT  VWGUN_50               ;IFLE  ?COLLISION DUE TO PLAYER SPEED OR GUN SPEED?

VWGUN_40:
P1_9369:  LDD  BJ_CX                  ;CENTER OF GUNSHOT ON SCREEN
P1_936B:  BMI  P1_9374                ;IFPL  ?RIGHT HALF OF SCREEN?
P1_936D:  SUBD #VGCURR*4              ;+-128*4==>=-512 SCREEN COORDS
P1_9370:  BGE  VWGUN_50               ;B EXIT IF NO CHANCE OF CURSOR HITTING IT
P1_9372:  BRA  P1_9379                ;ELSE  ELSE CHECK LEFT SITE LIMIT
P1_9374:  SUBD #VGCURL*4
P1_9377:  BLE  VWGUN_50
P1_9379:  LDD  BJ_CY                  ;CHECK UP/DOWN LIMITS
P1_937B:  BMI  P1_9384                ;IFPL
P1_937D:  SUBD #VGCURT*4              ;TOP LIMIT
P1_9380:  BGE  VWGUN_50               ;B EXIT IF TOO HI TO HIT
P1_9382:  BRA  P1_9389                ;ELSE  ELSE ON BOTTOM HALF OF SCREEN
P1_9384:  SUBD #VGCURB*4
P1_9387:  BLE  VWGUN_50               ;B NO COLLISION IF OUT OF SITE REACH
P1_9389:  LDA  CL_GDS                 ;CL_GDS still at its preset $FF: no shot in the sights this frame, so no kill
P1_938B:  BMI  P1_939C
P1_938D:  CMPX CL_GP                  ;?CAN WE HIT THIS GUN?
P1_938F:  BNE  P1_939C                ;IFEQ
P1_9391:  LDA  LZ_ON                  ;?AND LAZARS ARE ON?
P1_9393:  BEQ  P1_939C                ;IFNE
P1_9395:  JSR  GNHTSG                 ;THEN KILL THIS GUN NOW
P1_9398:  LDX  GN_PTR                 ;SAFE RESTORE
P1_939A:  BRA  VWGUN_50               ;AND NO MORE COLLIDE WITH SHIELDS
;ELSE IT SURELY HIT US
P1_939C:  JSR  GNAHIT                 ;RECORD GUNS HIT ON OUR SHIELDS
P1_939F:  JSR  L60BA                  ;bank 1 KD8AC: object centre back to its default, JSRL to scale and centre
P1_93A2:  JSR  GLOWVW                 ;AND GLOW THE SHELL
P1_93A5:  JMP  VWGUN_95               ;J DO NEXT SHELL

VWGUN_50:
P1_93A8:  JSR  GN1DRW                 ;DRAW GUN TYPE 2
P1_93AB:  BRA  VWGUN_95

VWGUN_90:          ;SHOT NOT VISIBLE
P1_93AD:  LDA  GS_TYP,X
P1_93AF:  BITA #TYPS_LV
P1_93B1:  BEQ  P1_93B7                ;IFNE
;;; LDA #TYP$PR ;REPLACE LIVE SHOT WITH PRETTY ONE(BUT A DUD)
P1_93B3:  LDA  #$00                   ;KILL IT OFF FOR NOW
P1_93B5:  BRA  P1_93B8                ;ELSE
P1_93B7:  CLRA                        ;ELSE TURN SHOT OFF
P1_93B8:  STA  GS_TYP,X

VWGUN_95:          ;NEXT GUN SHOT
P1_93BA:  LDX  GN_PTR
P1_93BC:  LEAX 8,X
P1_93BE:  CMPX #GUNZ
P1_93C1:  LBLO VWGUN_10
P1_93C5:  LDD  MS_TX+M_S1             ;RESTORE DOWNLOADED UNIT VECTOR
P1_93C8:  STD  MS_TX+M_U1
P1_93CB:  LDD  MS_TY+M_S1
P1_93CE:  STD  MS_TY+M_U1
P1_93D1:  LDD  MS_TZ+M_S1
P1_93D4:  STD  MS_TZ+M_U1
P1_93D7:  RTS

;------------------------------------------------------------------------------
; GN1DRW - DRAW NORMAL GUN
;   in ESB: ESB draws a live shot in red at full brightness and picks the picture by type bit 6: JSRL $001A,
;   or $0020 for a walker's shot. a hurt shot is purple with JSRL $001E, or for a walker's shot half as bright
;   with JSRL $0022. scale and centre are restored by bank 1 KD8AC
;------------------------------------------------------------------------------
GN1DRW:
P1_93D8:  LDX  GN_PTR
;---DETERMINE SCALE
P1_93DA:  LDA  #$08                   ;MAX FOR BINARY SCALE
;CLOSEST IS 100,
P1_93DC:  STA  TMPBIN
P1_93DE:  LDD  M_XT

GN1DRW_10:          ;---LOOP FOR BINARY SCALE
P1_93E1:  DEC  TMPBIN
P1_93E3:  BEQ  GN1DRW_20
P1_93E5:  LSLB
P1_93E6:  ROLA
P1_93E7:  BPL  GN1DRW_10
P1_93E9:  ANDA #$7F                   ;MAX FOR LINEAR SCALE

GN1DRW_20:
P1_93EB:  STA  TMPLIN
;DO THE FIREBALL
P1_93ED:  LDA  GS_TYP,X
P1_93EF:  BITA #$20
P1_93F1:  BNE  P1_9412                ;IFEQ  NO, DO NORMAL SHELL
P1_93F3:  LDA  TMPBIN                 ;USE CALCULATED SCALE FOR NORMAL SHELLS
P1_93F5:  ORA  #(VGSCAL&$F000)/$100
P1_93F7:  LDB  TMPLIN
P1_93F9:  STD  ,Y++
P1_93FB:  LDD  #$64FF                 ;colour 4 (red), full brightness
P1_93FE:  STD  ,Y++
P1_9400:  LDA  3,X                    ;a walker's shot?
P1_9402:  BITA #$40
P1_9404:  BNE  P1_940B
P1_9406:  LDD  #$A00D                 ;JSRL $001A: the gun shot picture the IRQ changes every fourth frame
P1_9409:  BRA  P1_940E
P1_940B:  LDD  #$A010                 ;JSR TO THE SPARKLER  JSRL $0020 (the slot named VRLZS): the sparkle picture, drawn for a walker's shot, which the IRQ changes every second field
P1_940E:  STD  ,Y++
P1_9410:  BRA  P1_944D                ;ELSE  YES, SHELL HURT
;LIMIT SCALE FOR HURT SHOTS
P1_9412:  LDB  TMPLIN
P1_9414:  LDA  TMPBIN
P1_9416:  INCA                        ;2 * SMALLER ( USING LARGER STAMPS )
P1_9417:  CMPA #$03                   ;DON'T LET IT GET TOO LARGE
P1_9419:  BHS  P1_9420                ;IFLO  LIMIT IT
P1_941B:  LDA  #$03                   ;BINARY OF THREE
P1_941D:  CLRB                        ;LINEAR OF 0
P1_941E:  BRA  P1_9427                ;ELSE
P1_9420:  CMPA #$06                   ;BUT MAKE SURE ITS VISIBLE FAR AWAY
P1_9422:  BLO  P1_9427                ;IFHS  LIMIT IT TO A MINIMUM SIZE
P1_9424:  LDA  #$06                   ;BINARY OF 6
P1_9426:  CLRB                        ;LINEAR OF 0
P1_9427:  ORA  #(VGSCAL&$F000)/$100
P1_9429:  STD  ,Y++
P1_942B:  LDB  GS_TMR,X               ;FADE USING TIMER
P1_942D:  ASLB                        ;*16 FOR Z
P1_942E:  ASLB
P1_942F:  ASLB
P1_9430:  LDA  3,X                    ;a walker's shot?
P1_9432:  BITA #$40
P1_9434:  BNE  P1_9442
P1_9436:  ASLB
P1_9437:  ORB  #$0F                   ;A LITTLE BRIGHTER
P1_9439:  LDA  #(VGCOLR/$100)+VGCPRP  ;MAKE IT PURPLE
P1_943B:  STD  ,Y++
P1_943D:  LDD  #$A00F                 ;EXPLOSION SPARKLER
P1_9440:  BRA  P1_944B
P1_9442:  ORB  #$07                   ;walker's shot: half as bright
P1_9444:  LDA  #$65                   ;purple as well
P1_9446:  STD  ,Y++
P1_9448:  LDD  #$A011                 ;JSRL $0022 (the slot named VRGNX): the ring of sparkles, the burst of a walker's shot, which the IRQ changes every field
P1_944B:  STD  ,Y++
P1_944D:  JSR  L60BA                  ;bank 1 KD8AC: object centre back to its default, JSRL to scale and centre

GN1DRW_90:
P1_9450:  RTS

;------------------------------------------------------------------------------
; GLOWVW - THEN SHOW GUN AGAINST OUR SCREENS  (comment at the call)
;   AND GLOW THE SHELL  (another call)
;   in ESB: ESB picks the picture by type bit 6: JSRL $001E, or $0022 for a walker's shot. scale and centre
;   are restored by bank 1 KD8AC
;------------------------------------------------------------------------------
GLOWVW:
P1_9451:  LDX  GN_PTR
P1_9453:  LDU  ,X                     ;GET VECTOR TO FACEPLATE POSITION
P1_9455:  LDD  ,U
P1_9457:  STD  ,Y++
P1_9459:  LDD  2,U
P1_945B:  STD  ,Y++
P1_945D:  LDA  GS_TMR,X               ;USE TIMER TO SETUP SIZE, USE 70C0 TO 7000
P1_945F:  LDB  #$10                   ;MAX SCALE(SMALLEST SIZE)/TIMER
P1_9461:  MUL
P1_9462:  LDA  #(VGSCAL&$F000)/$100   ;MAKES IT A SCALE INSTRUCTION
P1_9464:  STD  ,Y++
P1_9466:  LDB  GS_TMR,X               ;NOW SET UP THE COLOR
P1_9468:  ASLB                        ;BRIGHTNESS DEPENDS ON TIME
P1_9469:  ASLB
P1_946A:  ASLB
P1_946B:  ASLB
P1_946C:  LDA  #(VGCOLR/$100)+VGCWHT  ;ALWAYS WHITE
P1_946E:  STD  ,Y++
P1_9470:  LDA  3,X                    ;a walker's shot?
P1_9472:  BITA #$40
P1_9474:  BNE  P1_947B
P1_9476:  LDD  #$A00F                 ;JSRL $001E: the shot explosion picture the IRQ changes every fourth frame
P1_9479:  BRA  P1_947E
P1_947B:  LDD  #$A011                 ;JSR TO THE SPARKLER WITHOUT CENTER LINES  JSRL $0022: the ring of sparkles, for a walker's shot
P1_947E:  STD  ,Y++
P1_9480:  JSR  L60BA                  ;bank 1 KD8AC: object centre back to its default, JSRL to scale and centre

GLOWVW_90:
P1_9483:  RTS

;------------------------------------------------------------------------------
; GNAHIT - ALIEN GUN HIT PLAYER
;   X-->GUN BLOCK
;   in ESB: ESB keeps the other type bits when it sets the glow bit, and its speech is different: none on a
;   manual page. on the first hit of a part with shields left (hit_said) spk_cmd_13 and a phrase in the TIE
;   fighter part (spk_cmd_1d) or the asteroid part (spk_cmd_25). on a hit while the shield already glows
;   (glow_said, once a part) spk_cmd_13 and spk_cmd_19 in the probot and walker parts or spk_cmd_27 in the
;   other two. the hit sound is aud_cmd_3a
;------------------------------------------------------------------------------
GNAHIT:
P1_9484:  LDU  ,X                     ;* * * MUST FOLLOW OBJCENT * * *
;USES PREVIOUS VG INSTRUCTION
P1_9486:  LDD  -$4,Y                  ;GET VECTOR TO FACEPLATE POSITION
P1_9488:  STD  ,U
P1_948A:  LDD  -$2,Y
P1_948C:  STD  2,U
P1_948E:  LDA  3,X                    ;glowing, no longer live or pretty, the other type bits kept
P1_9490:  ORA  #$10
P1_9492:  ANDA #$FC
P1_9494:  STA  GS_TYP,X
P1_9496:  LDA  #$0F
P1_9498:  STA  GS_TMR,X               ;SHOW SHELL DISSOLVING
P1_949A:  LDA  #MOVS_ST               ;SHELL STAYS IN PLACE
P1_949C:  STA  GS_MOV,X
P1_949E:  LDA  man_running            ;manual page: no speech
P1_94A1:  BNE  P1_94EC
P1_94A3:  LDA  GS_GLW                 ;shield glowing from an earlier hit?
P1_94A5:  BNE  P1_94CE
P1_94A7:  LDA  S_GAS                  ;no shield left: no speech
P1_94A9:  BLE  P1_94CC
P1_94AB:  LDA  hit_said               ;first hit of this part: said once
P1_94AE:  BNE  P1_94CC
P1_94B0:  INC  hit_said
P1_94B3:  LDA  wave_type
P1_94B6:  CMPA #$02                   ;TIE fighter part
P1_94B8:  BNE  P1_94C2
P1_94BA:  JSR  spk_cmd_13
P1_94BD:  JSR  spk_cmd_1d
P1_94C0:  BRA  P1_94CC
P1_94C2:  CMPA #$03                   ;asteroid part
P1_94C4:  BNE  P1_94CC
P1_94C6:  JSR  spk_cmd_13
P1_94C9:  JSR  spk_cmd_25
P1_94CC:  BRA  P1_94EC
P1_94CE:  LDA  S_GAS                  ;hit while the shield glows, with shields left
P1_94D0:  BLE  P1_94EC
P1_94D2:  LDA  glow_said              ;said once a part
P1_94D5:  BNE  P1_94EC
P1_94D7:  INC  glow_said
P1_94DA:  JSR  spk_cmd_13
P1_94DD:  LDA  wave_type
P1_94E0:  CMPA #$02                   ;probots and walkers one phrase, TIE fighters and asteroids another
P1_94E2:  BCC  P1_94E9
P1_94E4:  JSR  spk_cmd_19
P1_94E7:  BRA  P1_94EC
P1_94E9:  JSR  spk_cmd_27
P1_94EC:  JSR  BG1GLW
P1_94EF:  LDA  S_ROL
P1_94F1:  BNE  P1_94F6                ;IFEQ  ?NO CURRENT DIRECTION?
P1_94F3:  LDA  P_RND1                 ;THEN CHOOSE WHICH WAY
P1_94F6:  LDB  #$20                   ;AMOUNT TO ROLL
P1_94F8:  TSTA                        ;CHECK CURRENT DIRECTION
P1_94F9:  BPL  P1_94FC                ;IFMI
P1_94FB:  NEGB
P1_94FC:  STB  S_ROL                  ;ROLL US IN RESPONSE
P1_94FE:  JSR  aud_cmd_3a
P1_9501:  RTS

;------------------------------------------------------------------------------
; GNHTSG - SPACE LAZAR HIT ALIEN GUN
;   PROTON HIT BASE GUN
;   CL.GP-->GUN BLOCK
;   (also: PTHTBG)
;   in ESB: ESB keeps the type bits other than live and pretty, and scores 3 points or, for a walker's shot
;   (type bit 6), 7
;------------------------------------------------------------------------------
GNHTSG:
PTHTBG:
P1_9502:  LDU  CL_GP                  ;U-->ALIEN GUN
P1_9504:  LDA  GS_TYP,U
P1_9506:  BEQ  P1_952A                ;IFNE  ?SHOT ALIVE?
P1_9508:  ORA  #TYPS_HR               ;MAKE IT HURT
P1_950A:  ANDA #$FC                   ;no longer live or pretty, the other type bits kept
P1_950C:  STA  GS_TYP,U
P1_950E:  LDA  #$0F                   ;FADE TIMER
P1_9510:  STA  GS_TMR,U
P1_9512:  LDA  #MOVS_ST               ;MAKE SHELL 'STAY' IN PLACE
P1_9514:  STA  GS_MOV,U
P1_9516:  LDA  3,U
P1_9518:  BITA #$40                   ;a walker's shot: 7 points, else 3
P1_951A:  BNE  P1_9521
P1_951C:  JSR  scr_shot_3
P1_951F:  BRA  P1_9524
P1_9521:  JSR  scr_shot_7
P1_9524:  JSR  aud_cmd_3e
P1_9527:  JSR  aud_cmd_3b
P1_952A:  RTS

;------------------------------------------------------------------------------
; s2vw_remnant - not a routine: $952B-$9560 is the same on all four pages and is the end of Star Wars' S2VW (its
;   L79E5 to L7A1B) from the middle of an instruction - the glow colour from TVWCL, the object's points and lines
;   - followed by the first ten words of the table TVWCL and one stray byte. nothing refers to it and each page's
;   own code ends just before it and starts again at $9561, so it looks like a leftover in the ROM image. the
;   first four bytes $08 $ED $88 $15 are the operand of a cut-off ORA and STD $15,X, which the listing shows as
;   ASL and EORA
;------------------------------------------------------------------------------
s2vw_remnant:
P1_952B:  .byte $08                   ;really $08, the last byte of a cut-off ORA #, then ED 88 15 = STD $15,X (Star Wars L79E4, L79E6)

;------------------------------------------------------------------------------
; s2vw_end_p1 - stale image, never run: the last instructions of a copy of Star Wars' S2VW, the same on all four
;   pages - see s2vw_end_p0 on page 0
;------------------------------------------------------------------------------
s2vw_end_p1:
P1_952C:  STD  $15,X
P1_952F:  LDX  S2_PRM
P1_9531:  LDB  7,X                    ;Star Wars: LDB AS_GLW,X
P1_9533:  LDU  #TVWCL_P1
P1_9536:  ASLB
P1_9537:  LDD  B,U
P1_9539:  STD  ,Y++
P1_953B:  LDA  #$40
P1_953D:  JSR  MGOWT
P1_9540:  LDB  5,X
P1_9542:  JSR  L60D2
P1_9545:  JSR  L60E4
P1_9548:  JSR  L60BA
P1_954B:  RTS

TVWCL_P1:
P1_954C:  .word (VGCOPC&$F000)+(($82&$F)*$100)+($82&$F0) ;TVWBYT 082,037,82,37,82,47,82,47
P1_954E:  .word (VGCOPC&$F000)+(($37&$F)*$100)+($37&$F0)
P1_9550:  .word (VGCOPC&$F000)+(($82&$F)*$100)+($82&$F0)
P1_9552:  .word (VGCOPC&$F000)+(($37&$F)*$100)+($37&$F0)
P1_9554:  .word (VGCOPC&$F000)+(($82&$F)*$100)+($82&$F0)
P1_9556:  .word (VGCOPC&$F000)+(($47&$F)*$100)+($47&$F0)
P1_9558:  .word (VGCOPC&$F000)+(($82&$F)*$100)+($82&$F0)
P1_955A:  .word (VGCOPC&$F000)+(($47&$F)*$100)+($47&$F0)
P1_955C:  .word (VGCOPC&$F000)+(($82&$F)*$100)+($82&$F0) ;TVWBYT 082,057,82,057,082,067,082,067
P1_955E:  .word (VGCOPC&$F000)+(($57&$F)*$100)+($57&$F0)
P1_9560:  .byte $D6                   ;stray byte, the table is cut off after ten words

;------------------------------------------------------------------------------
; jedi_clear - clears the Jedi letters: display state, animation scale and fade, the letter bits and the warning
;   flag. called through maze entry MZ_842D by bank 0 at L63A8 and L6797, and by jedi_draw when the animation of
;   the fourth letter has ended
;------------------------------------------------------------------------------
jedi_clear:
P1_9561:  LDA  #$00
P1_9563:  STA  jedi_show
P1_9566:  STA  jedi_scale
P1_9569:  STA  jedi_fade
P1_956C:  STA  jedi_let
P1_956F:  STA  jedi_warned
P1_9572:  RTS

;------------------------------------------------------------------------------
; jedi_award - awards a Jedi letter, called through maze entry MZ_81E4 by the kill that brings bonus_left to 0
;   in each part (pages 0, 1, 2, 3 and bank 0 L71D1). with bit 5 of the option byte $4D7B set the letters come in
;   order, else it is the letter of the part played (J probots, E walkers, D TIE fighters, I asteroids). starts
;   the letter's animation (jedi_show 1) and a speech, another one for the third letter. when all four are held it
;   scores scr_jedi, starts the tune of tune_cmd_2a, sets jedi_done and, unless option bit 4 is set, starts the
;   force period: jedi_time = $01C0 and jedi_count one up
;------------------------------------------------------------------------------
jedi_award:
P1_9573:  PSHS X
P1_9575:  LDA  OPTS1                  ;option byte
P1_9578:  BITA #$20                   ;bit 5: letters are given in order
P1_957A:  BEQ  P1_958F
P1_957C:  ORCC #$01                   ;shift one more letter bit in
P1_957E:  ROL  jedi_let
P1_9581:  LDA  #$FF                   ;index of the highest bit held: the new letter
P1_9583:  LDB  jedi_let
P1_9586:  INCA
P1_9587:  LSRB
P1_9588:  BNE  P1_9586
P1_958A:  STA  jedi_new
P1_958D:  BRA  P1_95A0
P1_958F:  LDB  wave_type              ;else the letter of the part played: 0 J, 1 E, 2 D, 3 I
P1_9592:  STB  jedi_new
P1_9595:  LDX  #jedi_bit_tab
P1_9598:  LDA  jedi_let
P1_959B:  ORA  B,X
P1_959D:  STA  jedi_let
P1_95A0:  LDA  #$00                   ;the new letter starts at full size
P1_95A2:  STA  jedi_scale
P1_95A5:  LDA  #$80                   ;the other letters start at brightness $80
P1_95A7:  STA  jedi_fade
P1_95AA:  LDA  #$01                   ;state 1: a letter is growing into place
P1_95AC:  STA  jedi_show
P1_95AF:  LDA  jedi_let               ;count the letters held
P1_95B2:  CLRB
P1_95B3:  LSRA
P1_95B4:  BCC  P1_95B7
P1_95B6:  INCB
P1_95B7:  TSTA
P1_95B8:  BNE  P1_95B3
P1_95BA:  CMPB #$03                   ;the third letter has its own phrase
P1_95BC:  BNE  P1_95C3
P1_95BE:  JSR  spk_cmd_14
P1_95C1:  BRA  P1_95C6
P1_95C3:  JSR  spk_cmd_07
P1_95C6:  LDA  jedi_let
P1_95C9:  CMPA #$0F                   ;all four?
P1_95CB:  BNE  P1_95EB
P1_95CD:  LDA  OPTS1                  ;option bit 4: no force period
P1_95D0:  ANDA #$10
P1_95D2:  BNE  P1_95E0
P1_95D4:  LDD  #$01C0                 ;448 units of force time
P1_95D7:  STD  jedi_time
P1_95DA:  INC  jedi_count             ;each period runs down faster than the one before
P1_95DD:  CLR  jedi_warned            ;warning sound not yet sent
P1_95E0:  LDB  #$01
P1_95E2:  STB  jedi_done
P1_95E5:  JSR  tune_cmd_2a
P1_95E8:  JSR  scr_jedi
P1_95EB:  PULS X,PC

jedi_bit_tab:
P1_95ED:  .byte $01, $02, $04, $08    ;letter bit by index: J, E, D, I

;------------------------------------------------------------------------------
; jedi_time_run - runs the Jedi force time down, called every frame by the playing phases through maze entry
;   MZ_8403: takes the rate of jedi_rate_tab for jedi_count (held at 3) off the 24 bit time jedi_time,
;   jedi_time_lo, jedi_frac, and at the end clears it and sends aud_cmd_52. once the time is under $60 it sends
;   the warning sound aud_cmd_50, once. falls into jedi_on_update
;------------------------------------------------------------------------------
jedi_time_run:
P1_95F1:  LDA  jedi_time              ;nothing to do while the 24 bit time is 0
P1_95F4:  ORA  jedi_time_lo
P1_95F7:  ORA  jedi_frac
P1_95FA:  BEQ  P1_962F
P1_95FC:  PSHS X
P1_95FE:  LDX  #jedi_rate_tab
P1_9601:  LDB  jedi_count
P1_9604:  CMPB #$03                   ;rate index held at 3
P1_9606:  BLS  P1_960D
P1_9608:  LDB  #$03
P1_960A:  STB  jedi_count
P1_960D:  ASLB
P1_960E:  ABX
P1_960F:  LDD  jedi_time_lo           ;low byte and fraction minus the rate
P1_9612:  SUBD ,X
P1_9614:  STD  jedi_time_lo
P1_9617:  LDA  jedi_time              ;borrow into the high byte
P1_961A:  SBCA #$00
P1_961C:  STA  jedi_time
P1_961F:  BPL  P1_962D                ;below 0: the time is up
P1_9621:  LDD  #$0000
P1_9624:  STA  jedi_time
P1_9627:  STD  jedi_time_lo
P1_962A:  JSR  aud_cmd_52
P1_962D:  PULS X
P1_962F:  LDD  jedi_time
P1_9632:  BEQ  jedi_on_update
P1_9634:  CMPD #$0060                 ;under $60 left
P1_9638:  BGE  jedi_on_update
P1_963A:  LDA  jedi_warned            ;warning sound, once
P1_963D:  BNE  jedi_on_update
P1_963F:  JSR  aud_cmd_50
P1_9642:  INC  jedi_warned

;------------------------------------------------------------------------------
; jedi_on_update - makes jedi_on for this frame - 1 while jedi_time is not zero or a letter is growing into
;   place (jedi_show 1), else 0 - and steps jedi_blink. the end of jedi_time_run, and called alone through maze
;   entry MZ_8157 by the phases that do not run the time down
;------------------------------------------------------------------------------
jedi_on_update:
P1_9645:  CLR  jedi_on
P1_9648:  LDD  jedi_time
P1_964B:  BNE  P1_9654
P1_964D:  LDA  jedi_show              ;or a letter growing into place
P1_9650:  CMPA #$01
P1_9652:  BNE  P1_9657
P1_9654:  INC  jedi_on
P1_9657:  INC  jedi_blink
P1_965A:  RTS

jedi_rate_tab:
P1_965B:  .word $0180, $01C0, $0200, $0240 ;time taken off per frame, 8.8 fixed point, by jedi_count: 1.5, 1.75, 2, 2.25

;------------------------------------------------------------------------------
; jedi_draw - draws the Jedi letters, called through maze entry MZ_816C by the playing phases and by the bank 0
;   screens from LA3AE on. with letters held and jedi_show not 0 it draws the four letters (jedi_letter_draw) and
;   in state 1 steps the animation: jedi_scale up by 5 to $F0, then state 2, and if all four letters were held
;   they are cleared, jedi_fade down by 3. while jedi_time runs it also draws the word JEDI (jedi_word_draw),
;   blinking in the last $60 units and left out while GS_HIT is set, and the time frame (jedi_frame_draw)
;------------------------------------------------------------------------------
jedi_draw:
P1_9663:  PSHS X,U
P1_9665:  LDA  jedi_let
P1_9668:  BEQ  P1_96AF
P1_966A:  LDA  jedi_show
P1_966D:  BEQ  P1_96AF
P1_966F:  LDA  #$00                   ;the four letters
P1_9671:  STA  jedi_idx
P1_9674:  JSR  jedi_letter_draw
P1_9677:  LDA  jedi_idx
P1_967A:  INCA
P1_967B:  CMPA #$04
P1_967D:  BCS  P1_9671
P1_967F:  LDA  jedi_show              ;state 1: step the animation
P1_9682:  CMPA #$01
P1_9684:  BNE  P1_96AF
P1_9686:  LDA  jedi_scale
P1_9689:  CMPA #$F0
P1_968B:  BCC  P1_9694
P1_968D:  ADDA #$05                   ;the new letter shrinks by 5 a frame
P1_968F:  STA  jedi_scale
P1_9692:  BRA  P1_96A3
P1_9694:  LDA  jedi_let               ;in place: if that was the fourth letter, clear them all
P1_9697:  CMPA #$0F
P1_9699:  BNE  P1_969E
P1_969B:  JSR  jedi_clear
P1_969E:  LDA  #$02                   ;state 2: letters shown
P1_96A0:  STA  jedi_show
P1_96A3:  LDA  jedi_fade              ;the other letters fade by 3 a frame
P1_96A6:  CMPA #$08
P1_96A8:  BCS  P1_96AF
P1_96AA:  SUBA #$03
P1_96AC:  STA  jedi_fade
P1_96AF:  LDD  jedi_time
P1_96B2:  BEQ  P1_96C6
P1_96B4:  CMPD #$0060                 ;last $60 units: the word blinks, left out while bit 3 of the time is set
P1_96B8:  BCC  P1_96BE
P1_96BA:  ANDB #$08
P1_96BC:  BNE  P1_96C6
P1_96BE:  LDA  >GS_HIT                ;not while the loss of a shield is shown
P1_96C1:  BNE  P1_96C6
P1_96C3:  JSR  jedi_word_draw
P1_96C6:  LDD  jedi_time
P1_96C9:  BEQ  P1_96CE
P1_96CB:  JSR  jedi_frame_draw
P1_96CE:  PULS X,U,PC

;------------------------------------------------------------------------------
; jedi_word_draw - draws the word JEDI at half size in the flash colour, 464 units above the centre, one letter
;   at a time through P1_98E5: shown while the force time runs
;------------------------------------------------------------------------------
jedi_word_draw:
P1_96D0:  LDD  #$A015                 ;JSRL VRMFL: the flash colour
P1_96D3:  STD  ,Y++
P1_96D5:  LDB  #$00
P1_96D7:  STB  jedi_idx
P1_96DA:  LDD  #$01D0                 ;464 up from the centre
P1_96DD:  STD  ,Y++
P1_96DF:  LDD  #$0000                 ;pen position for the strokes: 0,0
P1_96E2:  STD  >scratch_3
P1_96E5:  STD  >scratch_1
P1_96E8:  STD  ,Y++
P1_96EA:  LDD  #$7300                 ;half size
P1_96ED:  STD  ,Y++
P1_96EF:  LDB  jedi_idx               ;strokes of letter jedi_idx
P1_96F2:  JSR  jedi_letter_strokes
P1_96F5:  LDD  #$8040                 ;centre
P1_96F8:  STD  ,Y++
P1_96FA:  LDD  #VGSCAL
P1_96FD:  STD  ,Y++                   ;RESTORE SCALE
P1_96FF:  LDB  jedi_idx
P1_9702:  INCB
P1_9703:  CMPB #$04
P1_9705:  STB  jedi_idx
P1_9708:  BCS  P1_96DA
P1_970A:  RTS

;------------------------------------------------------------------------------
; jedi_frame_draw - draws the force time as a frame 448 wide and 180 high around the word JEDI, from its top
;   left corner at y 550, x -224: the left side and the first jedi_time units of the bottom and top edges in the
;   flash colour, the rest of the edges and the right side in colour 0, so the frame gets shorter from the right
;   as the time runs out. jedi_time above $01C0 is cut to that. if $4C87 is not zero it draws the whole frame in
;   green with that brightness on odd values and nothing on even ones
;------------------------------------------------------------------------------
jedi_frame_draw:
P1_970B:  LDD  #$0226                 ;to y 550, x -224: top left corner of the frame
P1_970E:  STD  ,Y++
P1_9710:  LDD  #$1F20
P1_9713:  STD  ,Y++
P1_9715:  LDB  $4C87                  ;not 0: the whole frame in green instead, on odd values only
P1_9718:  BEQ  P1_9758
P1_971A:  BITB #$01
P1_971C:  BEQ  P1_9752
P1_971E:  ASLB                        ;BRIGHTNESS DEPENDS ON TIME
P1_971F:  ASLB
P1_9720:  ASLB
P1_9721:  ASLB
P1_9722:  LDA  #$62                   ;colour 2 (green)
P1_9724:  STD  ,Y++
P1_9726:  LDD  #$1F4C                 ;down 180
P1_9729:  STD  ,Y++
P1_972B:  LDD  #$E000
P1_972E:  STD  ,Y++
P1_9730:  LDD  #$0000
P1_9733:  STD  ,Y++
P1_9735:  LDD  #$01C0                 ;right 448
P1_9738:  ORA  #$E0
P1_973A:  STD  ,Y++
P1_973C:  LDD  #$00B4                 ;up 180
P1_973F:  STD  ,Y++
P1_9741:  LDD  #$E000
P1_9744:  STD  ,Y++
P1_9746:  LDD  #$0000
P1_9749:  STD  ,Y++
P1_974B:  LDD  #$1E40                 ;left 448
P1_974E:  ORA  #$E0
P1_9750:  STD  ,Y++
P1_9752:  LDD  #$8040
P1_9755:  STD  ,Y++
P1_9757:  RTS
P1_9758:  LDD  jedi_time
P1_975B:  BEQ  P1_976E
P1_975D:  CMPD #$01C1                 ;held at 448
P1_9761:  BCS  P1_9769
P1_9763:  LDD  #$01C0
P1_9766:  STD  jedi_time
P1_9769:  LDD  #$A015                 ;JSRL VRMFL: the flash colour
P1_976C:  BRA  P1_9771
P1_976E:  LDD  #$6080
P1_9771:  STD  ,Y++
P1_9773:  LDD  #$1F4C                 ;left side: down 180
P1_9776:  STD  ,Y++
P1_9778:  LDD  #$E000
P1_977B:  STD  ,Y++
P1_977D:  LDD  #$0000
P1_9780:  STD  ,Y++
P1_9782:  LDD  jedi_time              ;bottom edge: jedi_time units to the right
P1_9785:  ORA  #$E0
P1_9787:  STD  ,Y++
P1_9789:  LDD  #$6080                 ;colour 0 for what is used up
P1_978C:  STD  ,Y++
P1_978E:  LDD  #$0000
P1_9791:  STD  ,Y++
P1_9793:  LDD  #$01C0                 ;rest of the bottom edge
P1_9796:  SUBD jedi_time
P1_9799:  ORA  #$E0
P1_979B:  STD  ,Y++
P1_979D:  LDD  #$00B4                 ;right side: up 180
P1_97A0:  STD  ,Y++
P1_97A2:  LDD  #$E000
P1_97A5:  STD  ,Y++
P1_97A7:  LDD  #$0000
P1_97AA:  STD  ,Y++
P1_97AC:  LDD  jedi_time              ;top edge: back by 448 - jedi_time
P1_97AF:  SUBD #$01C0
P1_97B2:  ORA  #$E0
P1_97B4:  STD  ,Y++
P1_97B6:  LDD  jedi_time
P1_97B9:  BEQ  P1_97D0
P1_97BB:  LDD  #$A015                 ;the flash colour again
P1_97BE:  STD  ,Y++
P1_97C0:  LDD  #$0000
P1_97C3:  STD  ,Y++
P1_97C5:  LDD  jedi_time              ;top edge: back to the corner
P1_97C8:  COMA
P1_97C9:  NEGB
P1_97CA:  SBCA #$FF
P1_97CC:  ORA  #$E0
P1_97CE:  STD  ,Y++
P1_97D0:  LDD  #$8040
P1_97D3:  STD  ,Y++
P1_97D5:  RTS

jedi_home_x:
P1_97D6:  .word $01A0                 ;home point x: 416

jedi_home_y:
P1_97D8:  .word $0288                 ;home point y: 648

;------------------------------------------------------------------------------
; jedi_letter_draw - draws Jedi letter jedi_idx. the beam goes to the home point (y 648, x 416), then the
;   letter's strokes are drawn by P1_98E5 from absolute points at a scale, so a smaller scale pulls the letter
;   towards the upper right corner. state 2: scale $7428, an earned letter in the flash colour, the others in
;   colour 1 at brightness $80. state 1: the new letter jedi_new in the flash colour at scale $7200 + jedi_scale
;   (held at $C8), shrinking into place, with lines from six of its points to the home point, the other letters
;   full size in colour 1 at brightness jedi_fade. ends with centre and the default scale. runs on to $98E4
;------------------------------------------------------------------------------
jedi_letter_draw:
P1_97DA:  LDD  jedi_home_y            ;beam to the home point, which is also the pen position for the strokes
P1_97DD:  STD  scratch_3
P1_97DF:  ANDA #$1F
P1_97E1:  STD  ,Y++                   ;Y LONG VECTOR
P1_97E3:  LDD  jedi_home_x
P1_97E6:  STD  scratch_1
P1_97E8:  ANDA #$1F
P1_97EA:  STD  ,Y++                   ;X LONG VECTOR
P1_97EC:  LDA  jedi_show              ;state 2: letters shown small
P1_97EF:  CMPA #$02
P1_97F1:  BNE  P1_980F
P1_97F3:  LDD  #$7428                 ;about a fifth of full size
P1_97F6:  STD  ,Y++
P1_97F8:  LDB  jedi_let               ;letter earned: flash colour, else colour 1 at brightness $80
P1_97FB:  LDX  #jedi_bit_tab
P1_97FE:  LDA  jedi_idx
P1_9801:  ANDB A,X                    ;is the letter being drawn among the letters earned (bit masks at P1_95ED)
P1_9803:  BEQ  P1_980A
P1_9805:  LDD  #$A015                 ;earned: JSRL $002A, the flash colour word kept in vector RAM
P1_9808:  BRA  P1_980D
P1_980A:  LDD  #$6180                 ;not earned: colour 1, brightness $80
P1_980D:  BRA  P1_982E
P1_980F:  LDB  jedi_idx
P1_9812:  CMPB jedi_new               ;jedi_show 1: is this the letter just earned
P1_9815:  BNE  P1_9829
P1_9817:  LDA  #$72                   ;yes: scale word $72nn, its linear part goes from 0 to $C8 and shrinks the letter from the default size into its place
P1_9819:  LDB  jedi_scale
P1_981C:  CMPB #$C8
P1_981E:  BCS  P1_9822
P1_9820:  LDB  #$C8
P1_9822:  STD  ,Y++
P1_9824:  LDD  #$A015                 ;in the flash colour
P1_9827:  BRA  P1_982E
P1_9829:  LDA  #$61                   ;the other letters: colour 1 at the brightness that falls while the new letter comes in
P1_982B:  LDB  jedi_fade
P1_982E:  STD  ,Y++
P1_9830:  JSR  jedi_letter_strokes    ;the letter's strokes, returns X = its point table
P1_9833:  LDA  jedi_show
P1_9836:  CMPA #$01                   ;only while a letter is coming in: rays at intensity 3 between the anchor point (P1_97D8 y, P1_97D6 x) and the six points of the letter
P1_9838:  LBNE P1_98DA
P1_983C:  LDD  jedi_home_y            ;from point 5, where the strokes ended, to the anchor
P1_983F:  SUBD $14,X
P1_9842:  ANDA #$1F
P1_9844:  STD  ,Y++
P1_9846:  LDD  jedi_home_x
P1_9849:  SUBD $16,X
P1_984C:  ANDA #$1F
P1_984E:  ORA  #$60
P1_9850:  STD  ,Y++
P1_9852:  LDD  $10,X                  ;anchor to point 4
P1_9855:  SUBD jedi_home_y
P1_9858:  ANDA #$1F
P1_985A:  STD  ,Y++
P1_985C:  LDD  $12,X
P1_985F:  SUBD jedi_home_x
P1_9862:  ANDA #$1F
P1_9864:  ORA  #$60
P1_9866:  STD  ,Y++
P1_9868:  LDD  12,X                   ;dark move to point 3
P1_986A:  SUBD $10,X
P1_986D:  ANDA #$1F
P1_986F:  STD  ,Y++
P1_9871:  LDD  14,X
P1_9873:  SUBD $12,X
P1_9876:  ANDA #$1F
P1_9878:  STD  ,Y++
P1_987A:  LDD  jedi_home_y            ;point 3 to the anchor
P1_987D:  SUBD 12,X
P1_987F:  ANDA #$1F
P1_9881:  STD  ,Y++
P1_9883:  LDD  jedi_home_x
P1_9886:  SUBD 14,X
P1_9888:  ANDA #$1F
P1_988A:  ORA  #$60
P1_988C:  STD  ,Y++
P1_988E:  LDD  8,X                    ;anchor to point 2
P1_9890:  SUBD jedi_home_y
P1_9893:  ANDA #$1F
P1_9895:  STD  ,Y++
P1_9897:  LDD  10,X
P1_9899:  SUBD jedi_home_x
P1_989C:  ANDA #$1F
P1_989E:  ORA  #$60
P1_98A0:  STD  ,Y++
P1_98A2:  LDD  4,X                    ;dark move to point 1
P1_98A4:  SUBD 8,X
P1_98A6:  ANDA #$1F
P1_98A8:  STD  ,Y++
P1_98AA:  LDD  6,X
P1_98AC:  SUBD 10,X
P1_98AE:  ANDA #$1F
P1_98B0:  STD  ,Y++
P1_98B2:  LDD  jedi_home_y            ;point 1 to the anchor
P1_98B5:  SUBD 4,X
P1_98B7:  ANDA #$1F
P1_98B9:  STD  ,Y++
P1_98BB:  LDD  jedi_home_x
P1_98BE:  SUBD 6,X
P1_98C0:  ANDA #$1F
P1_98C2:  ORA  #$60
P1_98C4:  STD  ,Y++
P1_98C6:  LDD  ,X                     ;anchor to point 0
P1_98C8:  SUBD jedi_home_y
P1_98CB:  ANDA #$1F
P1_98CD:  STD  ,Y++
P1_98CF:  LDD  2,X
P1_98D1:  SUBD jedi_home_x
P1_98D4:  ANDA #$1F
P1_98D6:  ORA  #$60
P1_98D8:  STD  ,Y++
P1_98DA:  LDD  #VGCNTR
P1_98DD:  STD  ,Y++
P1_98DF:  LDD  #VGSCAL
P1_98E2:  STD  ,Y++
P1_98E4:  RTS

;------------------------------------------------------------------------------
; jedi_letter_strokes - draws one of the four letters J, E, D, I through Y as vectors between six points. the
;   letter number is taken from $4C7E, the current beam position in the letters' coordinates from the temps $4803
;   (y) and $4801 (x), which are left at the last point. each byte of the letter's stroke list names a point (bits
;   2-4) and says whether to move there dark (bit 0 set) or draw at intensity 7, $FF ends the list. returns X =
;   the letter's point table, which P1_97DA then uses for its rays. called by P1_97DA and P1_96D0
;------------------------------------------------------------------------------
jedi_letter_strokes:
P1_98E5:  LDB  jedi_idx
P1_98E8:  ASLB                        ;letter number * 2
P1_98E9:  CMPB #$08                   ;a number above 4 is drawn as letter 0 (4 itself would pass, the callers use 0-3)
P1_98EB:  BLS  P1_98EE
P1_98ED:  CLRB
P1_98EE:  LDX  #jedi_pts_ptrs         ;X = the letter's point table: six points, y word and x word each
P1_98F1:  LDX  B,X
P1_98F3:  LDU  #jedi_strk_ptrs        ;U = the letter's stroke list
P1_98F6:  LDU  B,U
P1_98F8:  LDB  ,U+
P1_98FA:  BITB #$01                   ;bit 0 set: dark move. clear: draw at intensity 7
P1_98FC:  BEQ  P1_9902
P1_98FE:  LDA  #$00
P1_9900:  BRA  P1_9904
P1_9902:  LDA  #$E0
P1_9904:  STA  scratch_5
P1_9906:  ANDB #$1C                   ;bits 2-4: point number * 4, the offset of the point's y
P1_9908:  STB  scratch_6
P1_990A:  LDD  B,X                    ;y of the point less y of the current position
P1_990C:  SUBD scratch_3
P1_990E:  ANDA #$1F
P1_9910:  STD  ,Y++
P1_9912:  LDB  scratch_6
P1_9914:  ADDB #$02
P1_9916:  LDD  B,X                    ;x of the point less x of the current position, with the intensity
P1_9918:  SUBD scratch_1
P1_991A:  ANDA #$1F
P1_991C:  ORA  scratch_5
P1_991E:  STD  ,Y++
P1_9920:  LDB  scratch_6              ;the point is the new current position
P1_9922:  LDD  B,X
P1_9924:  STD  scratch_3
P1_9926:  LDB  scratch_6
P1_9928:  ADDB #$02
P1_992A:  LDD  B,X
P1_992C:  STD  scratch_1
P1_992E:  LDB  ,U+
P1_9930:  CMPB #$FF                   ;$FF ends the list
P1_9932:  BNE  P1_98FA
P1_9934:  RTS

jedi_pts_ptrs:
P1_9935:  .word jedi_j_pts            ;point tables of J, E, D, I
P1_9937:  .word jedi_e_pts
P1_9939:  .word jedi_d_pts
P1_993B:  .word jedi_i_pts

jedi_strk_ptrs:
P1_993D:  .word jedi_j_strokes        ;stroke lists of J, E, D, I
P1_993F:  .word jedi_e_strokes
P1_9941:  .word jedi_d_strokes
P1_9943:  .word jedi_i_strokes

jedi_j_pts:
P1_9945:  .word $FFBA, $FE5C, $FF97, $FE5C ;points of J, y then x: the four letters share one coordinate system, x from -420 to 385
P1_994D:  .word $FF97, $FEC5, $0069, $FEC5
P1_9955:  .word $0069, $FE7F, $0069, $FF0B

jedi_e_pts:
P1_995D:  .word $FF97, $FFDD, $FF97, $FF51 ;points of E
P1_9965:  .word $0000, $FF51, $0069, $FF51
P1_996D:  .word $0069, $FFDD, $0000, $FF97

jedi_d_pts:
P1_9975:  .word $FF97, $0023, $FF97, $008C ;points of D
P1_997D:  .word $FFBA, $00AF, $0023
P1_9983:  .word $00AF, $0069, $0069
P1_9989:  .word $0069, $0023          ;from $998D: points of I

jedi_i_pts:
P1_998D:  .word $FF97, $00F5, $FF97, $013B
P1_9995:  .word $FF97, $0181, $0069, $00F5
P1_999D:  .word $0069, $013B, $0069, $0181

jedi_j_strokes:
P1_99A5:  .byte $01, $04, $08, $0C, $11, $14, $FF

jedi_e_strokes:
P1_99AC:  .byte $01, $04, $08, $0C, $10, $09, $14, $FF

jedi_d_strokes:
P1_99B4:  .byte $15, $00, $04, $08, $0C, $10, $14, $FF

jedi_i_strokes:
P1_99BC:  .byte $01, $08, $05, $10, $0D, $14, $FF

;------------------------------------------------------------------------------
; probot_ind_init - start of the probot part (bank 0 L6BCC): clears prog_count, the mark flash and adv_hold and
;   sets the status message to $34, IMPERIAL PROBOTS SEARCHING FOR REBELS
;------------------------------------------------------------------------------
probot_ind_init:
P1_99C3:  LDB  #$00
P1_99C5:  STB  prog_count
P1_99C8:  STB  ind_flash
P1_99CB:  STB  flash_fade
P1_99CE:  STB  adv_hold
P1_99D1:  LDB  #$34                   ;message $34, IMPERIAL PROBOTS SEARCHING FOR REBELS
P1_99D3:  STB  status_msg
P1_99D6:  RTS

;------------------------------------------------------------------------------
; walker_ind_init - start of the walker part (bank 0 L6DF9): clears the mark flash and adv_hold, sets the status
;   message to $3A, prog_count to 4 marks, the advance walk_adv to -400, the left end of the indicator, and the
;   hold a hit adds ($4CA5) to 30 frames
;------------------------------------------------------------------------------
walker_ind_init:
P1_99D7:  LDB  #$00
P1_99D9:  STB  ind_flash
P1_99DC:  STB  flash_fade
P1_99DF:  STB  adv_hold
P1_99E2:  LDB  #$3A                   ;message $3A, IMPERIAL WALKERS ATTACKING POWER GENERATOR
P1_99E4:  STB  status_msg
P1_99E7:  LDB  #$04                   ;four marks
P1_99E9:  STB  prog_count
P1_99EC:  LDD  #$FE70                 ;-400, the left end of the indicator
P1_99EF:  STD  walk_adv
P1_99F2:  LDA  #$1E                   ;30 frames of hold for the first hit
P1_99F4:  STA  hold_add
P1_99F7:  RTS

;------------------------------------------------------------------------------
; xmit_got_through - probot part: called by page 3 P3_9975 when it removes a transmission that was not shot,
;   outside the training manual. unless a mark is already flashing in it starts the flash of the next mark of the
;   indicator (falling into ind_flash_start), with sound effect $46 when no manual page is shown. the mark is
;   counted in prog_count when its flash has faded (vw_xmit_mark_new)
;------------------------------------------------------------------------------
xmit_got_through:
P1_99F8:  LDB  ind_flash              ;a mark is already flashing in: this transmission is not counted
P1_99FB:  BNE  P1_9A0D
P1_99FD:  LDB  man_running            ;no sound while a training manual page is shown
P1_9A00:  BNE  ind_flash_start
P1_9A02:  JSR  aud_cmd_46

;------------------------------------------------------------------------------
; ind_flash_start - sets flash_fade and the mark flash flag $4CA7 to $7F: a mark of the indicator is changing.
;   entered from xmit_got_through in the probot part and called by vw_walker_ind when the walkers' advance takes a
;   mark
;------------------------------------------------------------------------------
ind_flash_start:
P1_9A05:  LDB  #$7F                   ;full level, and the flag that a mark is changing
P1_9A07:  STB  flash_fade
P1_9A0A:  STB  ind_flash
P1_9A0D:  RTS

;------------------------------------------------------------------------------
; vw_wave_ind - draws the indicator and the status messages at the top of the screen through Y, called by the
;   views of the probot part and of the walker part in bank 0 (vew_probot, vew_probot_end, vew_walker). wave_type
;   0 gives the transmission indicator and the probot messages, any other value the walkers' advance indicator and
;   the walker messages. X preserved
;------------------------------------------------------------------------------
vw_wave_ind:
P1_9A0E:  PSHS X
P1_9A10:  LDA  wave_type              ;part 0, probots: the transmission indicator. any other part: the walkers' advance
P1_9A13:  BNE  P1_9A1D
P1_9A15:  JSR  vw_probot_ind
P1_9A18:  JSR  probot_status_msg
P1_9A1B:  BRA  P1_9A23
P1_9A1D:  JSR  vw_walker_ind
P1_9A20:  JSR  walker_status_msg
P1_9A23:  PULS X,PC

;------------------------------------------------------------------------------
; vw_probot_ind - probot part: draws the indicator of transmissions sent, a frame 800 wide and 150 high (pseudo
;   ROM $28DE) with four dashed slots ($28F4), one mark for each count of prog_count (vw_xmit_marks) and the mark
;   that is flashing in (vw_xmit_mark_new). with all four marks the frame and the slots take the flash colour
;------------------------------------------------------------------------------
vw_probot_ind:
P1_9A25:  LDD  #$00EE                 ;from the centre to y 238, x -150
P1_9A28:  STD  ,Y++
P1_9A2A:  LDD  #$1F6A
P1_9A2D:  STD  ,Y++
P1_9A2F:  LDA  prog_count             ;four marks: the frame in the flash colour (JSRL $002A), else in colour 1
P1_9A32:  CMPA #$04
P1_9A34:  BCS  P1_9A3B
P1_9A36:  LDD  #$A015
P1_9A39:  BRA  P1_9A3E
P1_9A3B:  LDD  #$6180
P1_9A3E:  STD  ,Y++
P1_9A40:  LDD  #$B46F                 ;JSRL $28DE in the pseudo ROM: the frame, 800 wide and 150 high
P1_9A43:  STD  ,Y++
P1_9A45:  LDD  #$00EE
P1_9A48:  STD  ,Y++
P1_9A4A:  LDD  #$1F6A
P1_9A4D:  STD  ,Y++
P1_9A4F:  LDA  prog_count             ;the slots: flash colour with four marks, else colour 7
P1_9A52:  CMPA #$04
P1_9A54:  BCS  P1_9A5B
P1_9A56:  LDD  #$A015
P1_9A59:  BRA  P1_9A5E
P1_9A5B:  LDD  #$6780
P1_9A5E:  STD  ,Y++
P1_9A60:  LDD  #$B47A                 ;JSRL $28F4: the four dashed slots
P1_9A63:  STD  ,Y++
P1_9A65:  JSR  vw_xmit_marks
P1_9A68:  LDA  ind_flash              ;a mark is flashing in
P1_9A6B:  BEQ  P1_9A70
P1_9A6D:  JSR  vw_xmit_mark_new
P1_9A70:  LDD  #$8040
P1_9A73:  STD  ,Y++
P1_9A75:  RTS

;------------------------------------------------------------------------------
; vw_xmit_marks - draws prog_count marks (the picture at pseudo ROM $293A) at y 238 and x -150, -50, 50, 150, in
;   colour 1, or in the flash colour when there are four. holds prog_count at 4. leaves the x of the last mark
;   drawn in the temp word $4802
;------------------------------------------------------------------------------
vw_xmit_marks:
P1_9A76:  LDD  #$FF06                 ;x -250: the marks go at -150, -50, 50, 150
P1_9A79:  STD  scratch_2
P1_9A7B:  LDB  prog_count
P1_9A7E:  BEQ  P1_9AB0
P1_9A80:  CMPB #$04
P1_9A82:  BCS  P1_9A90
P1_9A84:  BLS  P1_9A8B                ;more than 4: hold the count at 4
P1_9A86:  LDB  #$04
P1_9A88:  STB  prog_count
P1_9A8B:  LDX  #$A015                 ;the display list word $A015, JSRL $002A (flash colour), not a program address
P1_9A8E:  BRA  P1_9A93
P1_9A90:  LDX  #$6180                 ;the display list word $6180, colour 1, not a program address
P1_9A93:  STX  ,Y++
P1_9A95:  STB  scratch_1              ;marks still to draw
P1_9A97:  LDD  #$00EE                 ;y 238
P1_9A9A:  STD  ,Y++
P1_9A9C:  LDD  scratch_2              ;x of the next slot
P1_9A9E:  ADDD #$0064
P1_9AA1:  STD  scratch_2
P1_9AA3:  ANDA #$1F
P1_9AA5:  STD  ,Y++
P1_9AA7:  LDD  #$B49D                 ;JSRL $293A: the mark picture
P1_9AAA:  STD  ,Y++
P1_9AAC:  DEC  scratch_1
P1_9AAE:  BNE  P1_9A97
P1_9AB0:  RTS

;------------------------------------------------------------------------------
; vw_xmit_mark_new - while the mark flash flag is set and fewer than four marks count: draws the next mark in
;   the slot after the last one, in the fading flash colour of vector RAM $0032, and steps flash_fade down by 8 a
;   frame. when the level runs out it counts the mark in prog_count and clears the flag
;------------------------------------------------------------------------------
vw_xmit_mark_new:
P1_9AB1:  LDB  prog_count
P1_9AB4:  CMPB #$04
P1_9AB6:  BCC  P1_9AE9
P1_9AB8:  LDD  #$A019                 ;JSRL $0032: the flash colour the IRQ keeps there, its brightness follows flash_fade
P1_9ABB:  STD  ,Y++
P1_9ABD:  LDD  #$00EE
P1_9AC0:  STD  ,Y++
P1_9AC2:  LDD  scratch_2              ;the slot after the last mark drawn
P1_9AC4:  ADDD #$0064
P1_9AC7:  ANDA #$1F
P1_9AC9:  STD  ,Y++
P1_9ACB:  LDD  #$B49D
P1_9ACE:  STD  ,Y++
P1_9AD0:  LDA  >FRAMEL
P1_9AD3:  ANDA #$00                   ;the mask is 0: never skips, the level steps every frame
P1_9AD5:  BNE  P1_9AE9
P1_9AD7:  LDA  flash_fade
P1_9ADA:  SUBA #$08
P1_9ADC:  BPL  P1_9AE6
P1_9ADE:  INC  prog_count             ;faded out: the mark counts from now on
P1_9AE1:  LDA  #$00
P1_9AE3:  STA  ind_flash
P1_9AE6:  STA  flash_fade
P1_9AE9:  RTS

;------------------------------------------------------------------------------
; probot_status_msg - probot part: every 32 frames picks the status message for the top line from probot_msg_tab
;   by prog_count and FRAMEL bits 5-6, keeps it in $4CA8 and draws it every frame with do_message. message $37,
;   SHOOT nn PROBOTS FOR BONUS, gets bonus_left drawn into its gap as one or two digits, and is replaced by
;   message $4A, 5,000 POINTS AND JEDI LETTER AWARDED, once bonus_left is 0
;------------------------------------------------------------------------------
probot_status_msg:
P1_9AEA:  LDA  >FRAMEL
P1_9AED:  BITA #$1F                   ;every 32 frames: choose the message
P1_9AEF:  BNE  P1_9B0A
P1_9AF1:  LDB  prog_count             ;a row of four messages for each count
P1_9AF4:  ASLB
P1_9AF5:  ASLB
P1_9AF6:  BITA #$20                   ;FRAMEL bits 5 and 6 step through the row, 32 frames for each message
P1_9AF8:  BEQ  P1_9AFC
P1_9AFA:  ADDB #$01
P1_9AFC:  BITA #$40
P1_9AFE:  BEQ  P1_9B02
P1_9B00:  ADDB #$02
P1_9B02:  LDX  #probot_msg_tab
P1_9B05:  LDB  B,X
P1_9B07:  STB  status_msg
P1_9B0A:  LDB  status_msg
P1_9B0D:  CMPB #$37                   ;$37 is SHOOT nn PROBOTS FOR BONUS: the number goes into its gap
P1_9B0F:  BNE  P1_9B52
P1_9B11:  LDA  bonus_left
P1_9B14:  BEQ  P1_9B50
P1_9B16:  LDD  #$6780                 ;colour 7
P1_9B19:  STD  ,Y++
P1_9B1B:  LDD  #$0150                 ;y 336, the line of the message
P1_9B1E:  STD  ,Y++
P1_9B20:  LDA  #$01                   ;blank one leading zero
P1_9B22:  STA  BT_SUP
P1_9B24:  LDA  bonus_left
P1_9B27:  LDX  #$0008                 ;8 shifts: one byte to BCD
P1_9B2A:  JSR  BINBCD_B0
P1_9B2D:  LDA  bcd_lo
P1_9B30:  CMPA #$10
P1_9B32:  BCS  P1_9B3E
P1_9B34:  LDX  #$1F51                 ;two digits: x -175
P1_9B37:  STX  ,Y++
P1_9B39:  JSR  VWBYTE
P1_9B3C:  BRA  P1_9B46
P1_9B3E:  LDX  #$1F5D                 ;one digit: x -163
P1_9B41:  STX  ,Y++
P1_9B43:  JSR  VWBYT1
P1_9B46:  LDD  #$8040
P1_9B49:  STD  ,Y++
P1_9B4B:  LDB  status_msg
P1_9B4E:  BRA  P1_9B52
P1_9B50:  LDB  #$4A                   ;quota reached: message $4A, 5,000 POINTS AND JEDI LETTER AWARDED, in its place
P1_9B52:  JSR  do_message
P1_9B55:  RTS

;------------------------------------------------------------------------------
; vw_walker_ind - walker part: draws the advance indicator, a frame 800 wide and 75 high (pseudo ROM $2986) with
;   four dashed slots ($299C), the marks left (vw_gen_marks), the burst of a mark just lost (vw_gen_mark_lost) and
;   the advance itself, a bar 75 high at x = walk_adv with a lazar splash picture at each end, red while adv_hold
;   holds it up. then it moves the advance: adv_hold is counted down, or walk_adv goes up by 5 or 6 a frame to 400
;   at most, and each time it passes the x of the next mark (-150, -50, 50, 150) prog_count loses one, the burst
;   starts and a sound and at the first and last mark a speech are sent
;------------------------------------------------------------------------------
vw_walker_ind:
P1_9B56:  LDD  #$00EE                 ;from the centre to y 238, x -150
P1_9B59:  STD  ,Y++
P1_9B5B:  LDD  #$1F6A
P1_9B5E:  STD  ,Y++
P1_9B60:  LDD  #$6180
P1_9B63:  STD  ,Y++
P1_9B65:  LDD  #$B4C3                 ;JSRL $2986 in the pseudo ROM: the frame, 800 wide and 75 high
P1_9B68:  STD  ,Y++
P1_9B6A:  LDD  #$00EE
P1_9B6D:  STD  ,Y++
P1_9B6F:  LDD  #$1F6A
P1_9B72:  STD  ,Y++
P1_9B74:  LDD  #$6780
P1_9B77:  STD  ,Y++
P1_9B79:  LDD  #$B4CE                 ;JSRL $299C: the four dashed slots
P1_9B7C:  STD  ,Y++
P1_9B7E:  JSR  vw_gen_marks
P1_9B81:  LDA  ind_flash              ;a mark was just lost: its burst
P1_9B84:  BEQ  P1_9B89
P1_9B86:  JSR  vw_gen_mark_lost
P1_9B89:  LDD  #$8040
P1_9B8C:  STD  ,Y++
P1_9B8E:  LDD  #$00EE                 ;y 238, x = the advance
P1_9B91:  STD  ,Y++
P1_9B93:  LDD  walk_adv
P1_9B96:  ANDA #$1F
P1_9B98:  STD  ,Y++
P1_9B9A:  LDA  adv_hold
P1_9B9D:  BNE  P1_9BA4
P1_9B9F:  LDD  #$A009                 ;moving: JSRL $0012, the animated lazar splash picture the IRQ keeps there
P1_9BA2:  BRA  P1_9BAC
P1_9BA4:  LDD  #$64C0                 ;held up: colour 4 and JSRL VGLZS3, the larger lazar splash circle
P1_9BA7:  STD  ,Y++
P1_9BA9:  LDD  #$B9C8
P1_9BAC:  STD  ,Y++
P1_9BAE:  LDA  adv_hold
P1_9BB1:  BNE  P1_9BB8
P1_9BB3:  LDD  #$A015                 ;the bar: flash colour while moving, colour 4 while held up
P1_9BB6:  BRA  P1_9BBB
P1_9BB8:  LDD  #$64C0
P1_9BBB:  STD  ,Y++
P1_9BBD:  LDD  #$004B                 ;a line 75 up
P1_9BC0:  STD  ,Y++
P1_9BC2:  LDD  #$E000
P1_9BC5:  STD  ,Y++
P1_9BC7:  LDA  adv_hold               ;the same picture at the upper end
P1_9BCA:  BNE  P1_9BD1
P1_9BCC:  LDD  #$A009
P1_9BCF:  BRA  P1_9BD9
P1_9BD1:  LDD  #$64C0
P1_9BD4:  STD  ,Y++
P1_9BD6:  LDD  #$B9C8
P1_9BD9:  STD  ,Y++
P1_9BDB:  LDD  #$8040
P1_9BDE:  STD  ,Y++
P1_9BE0:  LDA  adv_hold
P1_9BE3:  BEQ  P1_9BEA
P1_9BE5:  DEC  adv_hold               ;held up: count the hold down, no advance this frame
P1_9BE8:  BRA  P1_9C53
P1_9BEA:  LDA  >FRAMEL
P1_9BED:  ANDA #$03                   ;5 on every fourth frame, 6 on the others
P1_9BEF:  BNE  P1_9BF9
P1_9BF1:  LDD  walk_adv
P1_9BF4:  ADDD #$0005
P1_9BF7:  BRA  P1_9BFF
P1_9BF9:  LDD  walk_adv
P1_9BFC:  ADDD #$0006
P1_9BFF:  CMPD #$0190                 ;400 is the right end
P1_9C03:  BLE  P1_9C08
P1_9C05:  LDD  #$0190
P1_9C08:  STD  walk_adv
P1_9C0B:  LDX  #adv_mark_x-2          ;adv_mark_x less 2: the count is 1-4 here
P1_9C0E:  LDB  prog_count
P1_9C11:  BLE  P1_9C53
P1_9C13:  ASLB
P1_9C14:  ABX
P1_9C15:  LDD  walk_adv               ;has the advance passed the x of the next mark
P1_9C18:  CMPD ,X
P1_9C1B:  BLE  P1_9C53
P1_9C1D:  DEC  prog_count             ;yes: one mark less, and its burst starts
P1_9C20:  JSR  ind_flash_start
P1_9C23:  LDA  prog_count             ;last mark: the final explosion effect, else effect $48
P1_9C26:  BNE  P1_9C2D
P1_9C28:  JSR  aud_cmd_33
P1_9C2B:  BRA  P1_9C30
P1_9C2D:  JSR  aud_cmd_48
P1_9C30:  LDA  prog_count             ;first mark lost and no tow cable fired yet in this part: speech $17
P1_9C33:  CMPA #$03
P1_9C35:  BNE  P1_9C3F
P1_9C37:  LDA  cables_used
P1_9C3A:  BNE  P1_9C3F
P1_9C3C:  JSR  spk_cmd_17
P1_9C3F:  LDA  prog_count             ;last mark lost: speech $12 in a wave with an even GM_WAV, $15 with an odd one
P1_9C42:  BNE  P1_9C53
P1_9C44:  LDA  GM_WAV
P1_9C47:  ANDA #$01
P1_9C49:  BNE  P1_9C50
P1_9C4B:  JSR  spk_cmd_12
P1_9C4E:  BRA  P1_9C53
P1_9C50:  JSR  spk_cmd_15
P1_9C53:  RTS

adv_mark_x:
P1_9C54:  .word $0096, $0032, $FFCE, $FF6A ;x the advance has to pass to take a mark, for a count of 1, 2, 3, 4: 150, 50, -50, -150

;------------------------------------------------------------------------------
; vw_gen_marks - walker part: draws prog_count marks (the picture at pseudo ROM $29E4) in colour 1 at y 238 and
;   x 150, 50, -50, -150, so that the leftmost ones go first as the count falls. holds prog_count at 4. leaves the
;   x of the last mark drawn in the temp word $4802
;------------------------------------------------------------------------------
vw_gen_marks:
P1_9C5C:  LDD  #$00FA                 ;x 250: the marks go at 150, 50, -50, -150
P1_9C5F:  STD  scratch_2
P1_9C61:  LDB  prog_count
P1_9C64:  BEQ  P1_9C8F
P1_9C66:  CMPB #$04                   ;more than 4: hold the count at 4
P1_9C68:  BLS  P1_9C6F
P1_9C6A:  LDB  #$04
P1_9C6C:  STB  prog_count
P1_9C6F:  STB  scratch_1
P1_9C71:  LDD  #$6180                 ;colour 1
P1_9C74:  STD  ,Y++
P1_9C76:  LDD  #$00EE
P1_9C79:  STD  ,Y++
P1_9C7B:  LDD  scratch_2
P1_9C7D:  SUBD #$0064
P1_9C80:  STD  scratch_2
P1_9C82:  ANDA #$1F
P1_9C84:  STD  ,Y++
P1_9C86:  LDD  #$B4F2                 ;JSRL $29E4: the mark picture
P1_9C89:  STD  ,Y++
P1_9C8B:  DEC  scratch_1
P1_9C8D:  BNE  P1_9C76
P1_9C8F:  RTS

;------------------------------------------------------------------------------
; vw_gen_mark_lost - walker part, while the mark flash flag is set: draws the burst picture (pseudo ROM $2A0A)
;   in the slot of the mark just lost, with flash_fade as the linear scale and twice flash_fade as the brightness,
;   so that it grows and fades, and steps flash_fade down by 8 a frame. clears the flag when the level runs out
;------------------------------------------------------------------------------
vw_gen_mark_lost:
P1_9C90:  LDD  #$00EE
P1_9C93:  STD  ,Y++
P1_9C95:  LDD  scratch_2              ;the slot after the last mark drawn: the mark just lost
P1_9C97:  SUBD #$0064
P1_9C9A:  ANDA #$1F
P1_9C9C:  STD  ,Y++
P1_9C9E:  LDA  #$71                   ;scale: binary 1 with the level as the linear part, the burst grows as the level falls
P1_9CA0:  LDB  flash_fade
P1_9CA3:  STD  ,Y++
P1_9CA5:  LDA  #$61                   ;colour 1 at twice the level: it fades out
P1_9CA7:  LDB  flash_fade
P1_9CAA:  ASLB
P1_9CAB:  STD  ,Y++
P1_9CAD:  LDD  #$B505                 ;JSRL $2A0A: the burst picture
P1_9CB0:  STD  ,Y++
P1_9CB2:  LDD  #$7200                 ;back to the default scale
P1_9CB5:  STD  ,Y++
P1_9CB7:  LDA  >FRAMEL                ;the mask is 0: never skips, the level steps every frame
P1_9CBA:  ANDA #$00
P1_9CBC:  BNE  P1_9CCD
P1_9CBE:  LDA  flash_fade
P1_9CC1:  SUBA #$08
P1_9CC3:  BPL  P1_9CCA
P1_9CC5:  LDA  #$00
P1_9CC7:  STA  ind_flash
P1_9CCA:  STA  flash_fade
P1_9CCD:  RTS

;------------------------------------------------------------------------------
; walker_status_msg - walker part: every 32 frames picks the status message for the top line from walker_msg_tab
;   by prog_count and FRAMEL bits 5-6, keeps it in $4CA8 and draws it every frame. message $3E, SHOOT nn WALKERS
;   FOR BONUS, gets bonus_left drawn into its gap and is replaced by message $4C, 5,000 POINTS AND JEDI LETTER
;   AWARDED, once bonus_left is 0. message $3B becomes $3C, SHOOT RED EYE WITH LASERS, when no tow cable is left.
;   then the second line at y 200: while legs_bon_tmr runs, legs_bonus as six digits with message $44, BONUS
;   POINTS FOR TRICK FLYING, otherwise the tow cables left with message $41, $42 or $43
;------------------------------------------------------------------------------
walker_status_msg:
P1_9CCE:  LDA  >FRAMEL
P1_9CD1:  BITA #$1F                   ;every 32 frames: choose the message
P1_9CD3:  BNE  P1_9CED
P1_9CD5:  LDB  prog_count
P1_9CD8:  ASLB                        ;count * 2 only, where the table is laid out as four messages for each count: the rows used overlap and the last row is never read
P1_9CD9:  BITA #$20
P1_9CDB:  BEQ  P1_9CDF
P1_9CDD:  ADDB #$01
P1_9CDF:  BITA #$40
P1_9CE1:  BEQ  P1_9CE5
P1_9CE3:  ADDB #$02
P1_9CE5:  LDX  #walker_msg_tab
P1_9CE8:  LDB  B,X
P1_9CEA:  STB  status_msg
P1_9CED:  LDB  status_msg
P1_9CF0:  CMPB #$3E                   ;$3E is SHOOT nn WALKERS FOR BONUS: the number goes into its gap
P1_9CF2:  BNE  P1_9D37
P1_9CF4:  LDA  bonus_left
P1_9CF7:  BEQ  P1_9D33
P1_9CF9:  LDD  #$6780                 ;colour 7
P1_9CFC:  STD  ,Y++
P1_9CFE:  LDD  #$0150                 ;y 336, the line of the message
P1_9D01:  STD  ,Y++
P1_9D03:  LDA  #$01
P1_9D05:  STA  BT_SUP
P1_9D07:  LDA  bonus_left
P1_9D0A:  LDX  #$0008
P1_9D0D:  JSR  BINBCD_B0
P1_9D10:  LDA  bcd_lo
P1_9D13:  CMPA #$10
P1_9D15:  BCS  P1_9D21
P1_9D17:  LDX  #$1F51                 ;two digits: x -175
P1_9D1A:  STX  ,Y++
P1_9D1C:  JSR  VWBYTE
P1_9D1F:  BRA  P1_9D29
P1_9D21:  LDX  #$1F5D                 ;one digit: x -163
P1_9D24:  STX  ,Y++
P1_9D26:  JSR  VWBYT1
P1_9D29:  LDD  #$8040
P1_9D2C:  STD  ,Y++
P1_9D2E:  LDB  status_msg
P1_9D31:  BRA  P1_9D35
P1_9D33:  LDB  #$4C                   ;quota reached: message $4C, 5,000 POINTS AND JEDI LETTER AWARDED, in its place
P1_9D35:  BRA  P1_9D42
P1_9D37:  CMPB #$3B                   ;$3B, SHOOT RED EYE OR USE TOW CABLE ON LEGS, becomes $3C, SHOOT RED EYE WITH LASERS, when no tow cable is left
P1_9D39:  BNE  P1_9D42
P1_9D3B:  LDA  cables_left
P1_9D3E:  BNE  P1_9D42
P1_9D40:  LDB  #$3C
P1_9D42:  JSR  do_message
P1_9D45:  LDA  legs_bon_tmr           ;second line: the legs bonus while its timer runs, else the tow cables left
P1_9D48:  BEQ  P1_9D6F
P1_9D4A:  DEC  legs_bon_tmr
P1_9D4D:  LDD  #$6680                 ;colour 6
P1_9D50:  STD  ,Y++
P1_9D52:  LDD  #$00C8                 ;y 200, x -416
P1_9D55:  STD  ,Y++
P1_9D57:  LDD  #$1E60
P1_9D5A:  STD  ,Y++
P1_9D5C:  LDA  #$03                   ;blank up to three leading zeros
P1_9D5E:  STA  BT_SUP
P1_9D60:  LDU  #legs_bonus
P1_9D63:  JSR  view_6dig
P1_9D66:  LDD  #$8040
P1_9D69:  STD  ,Y++
P1_9D6B:  LDB  #$44                   ;message $44, BONUS POINTS FOR TRICK FLYING
P1_9D6D:  BRA  P1_9DA0
P1_9D6F:  LDA  cables_left
P1_9D72:  BNE  P1_9D78
P1_9D74:  LDB  #$43                   ;message $43, ALL TOW CABLES GONE
P1_9D76:  BRA  P1_9DA0
P1_9D78:  CMPA #$01
P1_9D7A:  BNE  P1_9D80
P1_9D7C:  LDB  #$42                   ;message $42, 1 TOW CABLE
P1_9D7E:  BRA  P1_9DA0
P1_9D80:  LDD  #$6780
P1_9D83:  STD  ,Y++
P1_9D85:  LDD  #$00C8                 ;y 200, x -140: the digit in front of message $41, TOW CABLES
P1_9D88:  STD  ,Y++
P1_9D8A:  LDD  #$1F74
P1_9D8D:  STD  ,Y++
P1_9D8F:  LDA  #$01
P1_9D91:  STA  BT_SUP
P1_9D93:  LDA  cables_left
P1_9D96:  JSR  VWBYT1
P1_9D99:  LDD  #$8040
P1_9D9C:  STD  ,Y++
P1_9D9E:  LDB  #$41
P1_9DA0:  JSR  do_message
P1_9DA3:  RTS

probot_msg_tab:
P1_9DA4:  .byte $34, $37, $35, $37, $36, $37, $35, $37 ;four messages for each count 0-4: $34 probots searching, $35 shoot probots and transmissions, $36 partial transmission sent, $38 Darth Vader alerted, $39 Empire launching troops, and $37 shoot nn probots for bonus as every second one
P1_9DAC:  .byte $36, $37, $35, $37, $36, $37, $35, $37
P1_9DB4:  .byte $38, $37, $39, $37

walker_msg_tab:
P1_9DB8:  .byte $3F, $3E, $40, $3E, $3D, $3E, $3B, $3E ;laid out as four messages for each count 0-4, read at count * 2: $3F rebels evacuating, $40 power generator destroyed, $3D partial generator damage, $3B shoot red eye or use tow cable, $3A walkers attacking, and $3E shoot nn walkers for bonus as every second one
P1_9DC0:  .byte $3D, $3E, $3B, $3E, $3D, $3E, $3B, $3E
P1_9DC8:  .byte $3A, $3E, $3B, $3E, $FF, $C1, $10, $25 ;the row for a count of 4, which the index never reaches, then at $9DCC a filler byte $FF before the code that is the same on all four pages
P1_9DD0:  .byte $01, $5F, $D7, $41, $8E, $00, $04, $3A ;from $9DCD to the end of the page the bytes are the same on all four pages: the back part of a copy of bank 0's irq_handler that nothing runs (see irq_old_tail on page 0), shown as bytes up to $9E2C
P1_9DD8:  .byte $CE, $B9, $22, $EC, $C1, $ED, $83, $8C
P1_9DE0:  .byte $00, $02, $2E, $F7, $8E, $00, $12, $11
P1_9DE8:  .byte $83, $B9, $32, $24, $06, $EC, $C1, $ED
P1_9DF0:  .byte $83, $20, $F4, $D6, $42, $CB, $02, $8E
P1_9DF8:  .byte $9E, $02, $F6, $4C, $5A, $3A ;$9DF7-$9DFD: LDX #$9E02 / LDB diff_adder / ABX, put over the handler copy in front of the helper. nothing enters there

;------------------------------------------------------------------------------
; slap_alt_read - LDA 0,X / ASLA / RTS, the one live routine in the tail $9DCD-$9FFF that is the same on all
;   four pages. tie_fire, atat_fire, atst_fire and probot_fire call it with X = $9B5C + n: the jump to $9DFE and
;   the read of $9B5C + n are the slapstic's alternate sequence, after which the next page select selects page n,
;   the page of the routine's caller. the byte read is not used. only page 1 calls it
;------------------------------------------------------------------------------
slap_alt_read:
P1_9DFE:  LDA  +0,X
P1_9E00:  ASLA
P1_9E01:  RTS
P1_9E02:  .byte $00, $00, $00, $FF, $00, $00, $FF, $00 ;16 bytes of $00 and $FF that the LDX above points at, read by nothing
P1_9E0A:  .byte $FF, $00, $FF, $FF, $00, $FF, $FF, $FF
P1_9E12:  .byte $C1, $08, $25, $01, $5F, $D7, $38, $CE ;the handler copy goes on, as bank 0 from LEBE8
P1_9E1A:  .byte $B9, $3A, $EC, $C5, $FD, $00, $1A, $D6
P1_9E22:  .byte $38, $CE, $B9, $42, $EC, $C5, $FD, $00
P1_9E2A:  .byte $1E, $0A, $39

;------------------------------------------------------------------------------
; irq_old_tail_p1 - not a routine start: the middle of the leftover copy of bank 0's irq_handler that ends every
;   page, the same bytes as on page 0, where irq_old_tail describes it. nothing runs it. of $9DCD-$9FFF only
;   slap_alt_read at $9DFE is live, and only on this page
;------------------------------------------------------------------------------
irq_old_tail_p1:
P1_9E2D:  BGT  P1_9E46
P1_9E2F:  LDB  #$01
P1_9E31:  STB  pic1c_timer

;===LAZAR SPLASH
DOVG_48_P1:
P1_9E33:  LDB  pic1c_index
P1_9E35:  ADDB #$02
P1_9E37:  CMPB #$08
P1_9E39:  BLO  P1_9E3C                ;IFHS
P1_9E3B:  CLRB
P1_9E3C:  STB  pic1c_index
P1_9E3E:  LDU  #VTGNT
P1_9E41:  LDD  B,U
P1_9E43:  STD  $001C                  ;ONE PICTURE ONLY
;ALIEN GUN SHOT, BASE SPARKLE
P1_9E46:  DEC  lzs_timer
P1_9E48:  BGT  P1_9E61                ;IFLE
P1_9E4A:  LDB  #$02                   ;EVERY FOURTH SCREEN, CHANGE PICTURE TYPE
P1_9E4C:  STB  lzs_timer

;===LAZAR SPLASH
DOVG_48_P1_2:
P1_9E4E:  LDB  VG_LZS
P1_9E50:  ADDB #$02
P1_9E52:  CMPB #$08
P1_9E54:  BLO  P1_9E57                ;IFHS
P1_9E56:  CLRB
P1_9E57:  STB  VG_LZS
P1_9E59:  LDU  #spark_tab
P1_9E5C:  LDD  B,U
P1_9E5E:  STD  VRLZS                  ;ONE PICTURE ONLY
;ALIEN GUN SHOT, BASE SPARKLE
P1_9E61:  DEC  VF_GNB
P1_9E63:  BGT  P1_9E7C                ;IFLE
P1_9E65:  LDB  #$01                   ;EVERY FOURTH SCREEN, CHANGE PICTURE TYPE
P1_9E67:  STB  VF_GNB

;===LAZAR SPLASH
DOVG_48_P1_3:
P1_9E69:  LDB  gnx_index
P1_9E6B:  ADDB #$02
P1_9E6D:  CMPB #$08
P1_9E6F:  BLO  P1_9E72                ;IFHS
P1_9E71:  CLRB
P1_9E72:  STB  gnx_index
P1_9E74:  LDU  #sparks_tab
P1_9E77:  LDD  B,U
P1_9E79:  STD  VRGNX
;ALIEN GUN SHOT, TIP FUSE
P1_9E7C:  DEC  VF_GNT
P1_9E7E:  BGT  P1_9E97                ;IFLE
P1_9E80:  LDB  #$01                   ;EVERY SCREEN, CHANGE PICTURE TYPE
P1_9E82:  STB  VF_GNT
P1_9E84:  LDB  VG_GNT
P1_9E86:  ADDB #$02
P1_9E88:  CMPB #$08
P1_9E8A:  BLO  P1_9E8D                ;IFHS
P1_9E8C:  CLRB
P1_9E8D:  STB  VG_GNT
P1_9E8F:  LDU  #tri_tab
P1_9E92:  LDD  B,U
P1_9E94:  STD  VRGNT                  ;ONE PICTURE ONLY
P1_9E97:  LDB  VG_FLS                 ;BRITE FLASH
P1_9E99:  ADDB #$02
P1_9E9B:  CMPB #VTFLSZ-VTFLS
P1_9E9D:  BLO  P1_9EA0                ;IFHS  ?OVERFLOWED?
P1_9E9F:  CLRB
P1_9EA0:  STB  VG_FLS
P1_9EA2:  LDU  #VTFLS
P1_9EA5:  LDD  B,U
P1_9EA7:  STD  VRFLS                  ;ONE PICTURE ONLY
P1_9EAA:  LDB  gs_fade
P1_9EAC:  STD  $002E
P1_9EAF:  LDB  #$80
P1_9EB1:  SUBB flash_fade
P1_9EB4:  STD  $0032
P1_9EB7:  LDD  #VGRTSL
P1_9EBA:  STD  $0028
P1_9EBD:  STD  $0030
P1_9EC0:  STD  $0034                  ;AND RETURN VG
P1_9EC3:  LDB  VG_MFL                 ;MEDIUM FLASH
P1_9EC5:  ADDB #$02
P1_9EC7:  CMPB #VTMFLZ-VTMFL
P1_9EC9:  BLO  P1_9ECC                ;IFHS  ?OVERFLOWED TABLE?
P1_9ECB:  CLRB                        ;THEN START AT BEGINNING
P1_9ECC:  STB  VG_MFL
P1_9ECE:  LDU  #VTMFL
P1_9ED1:  LDD  B,U
P1_9ED3:  STD  VRMFL                  ;ONE PICTURE ONLY
P1_9ED6:  LDD  #VGRTSL
P1_9ED9:  STD  VRMFL+2                ;AND RETURN VG
P1_9EDC:  JSR  SPLASH                 ;OSCILLATE LAZAR SPLASH PICS
P1_9EDF:  STA  VGGO                   ;START VGEN AGAIN
P1_9EE2:  LDA  #$05
P1_9EE4:  STA  VGTIMR

DOVG_90_P1:
P1_9EE6:  STA  IRCLR                  ;ALLOW NEXT IRQ
P1_9EE9:  RTS

;------------------------------------------------------------------------------
; DEBNCE_P1 - A=NEW VAL
;   X-->RAM AREA
;   in ESB: copy of bank 0's DEBNCE inside the leftover irq_handler copy that ends every page ($9DCD-$9FFF,
;   see irq_old_tail on page 0), never run
;------------------------------------------------------------------------------
DEBNCE_P1:
P1_9EEA:  LDB  ,X                     ;NW: PREVIOUS NEW
P1_9EEC:  STB  1,X                    ;OL: -->OLD
P1_9EEE:  STA  ,X                     ;NW: SAVE NEWEST
P1_9EF0:  ANDA 1,X                    ;OL: SAME BITS ON
P1_9EF2:  ORA  2,X                    ;SW:
P1_9EF4:  STA  2,X                    ;SW: SAVE DEBOUNCED ON BITS
P1_9EF6:  ORB  ,X++                   ;NW: SAME BITS OFF
P1_9EF8:  ANDB ,X                     ;SW:
P1_9EFA:  STB  ,X+                    ;SW: SAVE DEBOUNCED OFF BITS,
;(X)+: PREPARE FOR NEXT SWITCH SET
P1_9EFC:  RTS

;------------------------------------------------------------------------------
; DOPOTS_P1 - HANDLE READING POT VALUES
;   in ESB: copy of bank 0's DOPOTS inside the leftover irq_handler copy that ends every page, never run
;------------------------------------------------------------------------------
DOPOTS_P1:
P1_9EFD:  LDA  S_INTCT
P1_9EFF:  LSRA                        ;?WHICH POT?
P1_9F00:  LDY  #PT_VL                 ;ASSUME POT 1
P1_9F04:  BCS  P1_9F0A                ;IFCC  NOPE, IT'S THE OTHER ONE
P1_9F06:  LDY  #PT_VL+PTS_IZ          ;POT 2
;POKEY FILTER
;REQUIRE 2 SAMPLES ALL HIGHER (OR LOWER)
;THAN CURRENT SAVED VALUE.
;THEN UPDATE TO CLOSEST HI (LO) VALUE
P1_9F0A:  LDB  1,Y                    ;B:=VNEW PREVIOUS NEW BECOMES CURRENT OLD
P1_9F0C:  LDA  R_CHN
P1_9F0F:  STA  1,Y                    ;A:=VNEW UPDATE CURRENT NEW
P1_9F11:  CMPA ,Y                     ;VL
P1_9F13:  BLO  P1_9F23                ;IFHS  ?NEW VALUE HIGHER THAN STANDARD VALUE?
P1_9F15:  CMPB ,Y                     ;VL
P1_9F17:  BLS  P1_9F21                ;IFHI  ?AND OLD VALUE HIGHER ALSO?
P1_9F19:  CMPB 1,Y                    ;VNEW
P1_9F1B:  BLS  P1_9F1F                ;IFHI  ?VNEW IS CLOSER?
P1_9F1D:  LDB  1,Y                    ;VNEW
P1_9F1F:  STB  ,Y                     ;VL SAVE CLOSEST OF HIGHER VALUES
P1_9F21:  BRA  P1_9F2F                ;ELSE  ELSE NEW VALUE IS LOWER THAN STANDARD VALUE
P1_9F23:  CMPB ,Y                     ;VL
P1_9F25:  BHS  P1_9F2F                ;IFLO  ?OLD VALUE ALSO LOWER?
P1_9F27:  CMPB 1,Y                    ;VNEW
P1_9F29:  BHS  P1_9F2D                ;IFLO  ?VNEW IS CLOSER?
P1_9F2B:  LDB  1,Y                    ;VNEW
P1_9F2D:  STB  ,Y                     ;VL SAVE CLOSEST OF LOWER VALUES
P1_9F2F:  CMPY #PT_VL                 ;START NEXT A-D CONVERSION
P1_9F33:  BNE  P1_9F3D                ;IFEQ
P1_9F35:  STA  W_CHN0                 ;SELECT CHANNEL 0
P1_9F38:  STA  W_CHN0                 ;START GOOD CONVERSION
P1_9F3B:  BRA  P1_9F43                ;ELSE
P1_9F3D:  STA  W_CHN1                 ;SELECT CHANNEL 1
P1_9F40:  STA  W_CHN1                 ;AND START IT CLEANLY
P1_9F43:  RTS

;------------------------------------------------------------------------------
; RHCTRL_P1 - IRQ VG HANDLES CONTROLS
;   in ESB: copy of bank 0's RHCTRL inside the leftover irq_handler copy that ends every page, never run
;------------------------------------------------------------------------------
RHCTRL_P1:
P1_9F44:  LDX  #RHEOP                 ;DO PITCH POT
P1_9F47:  LDA  PT_VL2                 ;UP/DOWN VG Y
P1_9F49:  NOP
P1_9F4A:  JSR  RHLIM_P1               ;LIMIT AND SCALE RHESTAT
P1_9F4D:  LDA  RHS_NML,X              ;NOW LIMIT THE POT BY THE VG SCREEN
P1_9F4F:  CMPA #VGCURT                ;HI LIMIT - CURSOR SIZE, SCALED TO +-128
P1_9F51:  BLE  P1_9F55                ;IFGT
P1_9F53:  LDA  #VGCURT
P1_9F55:  CMPA #VGCURB&$FF            ;TOP CURSOR POSITION, SCALED DOWN +-512 TO +-128
P1_9F57:  BGE  P1_9F5B                ;IFLT
P1_9F59:  LDA  #VGCURB&$FF
P1_9F5B:  STA  RHS_NML,X
P1_9F5D:  JSR  RHPOS_P1
P1_9F60:  LDX  #RHEOY                 ;DO YAW POT
P1_9F63:  LDA  PT_VL1                 ;LEFT/RIGHT VG X
P1_9F65:  NOP
P1_9F66:  JSR  RHLIM_P1               ;LIMIT AND SCALE RHESTAT
P1_9F69:  LDA  RHS_NML,X              ;NOW LIMIT TO CURSOR SCREEN SIZE
P1_9F6B:  CMPA #VGCURR
P1_9F6D:  BLE  P1_9F71                ;IFGT
P1_9F6F:  LDA  #VGCURR
P1_9F71:  CMPA #VGCURL&$FF
P1_9F73:  BGE  P1_9F77                ;IFLT
P1_9F75:  LDA  #VGCURL&$FF
P1_9F77:  STA  RHS_NML,X
P1_9F79:  JSR  RHPOS_P1
P1_9F7C:  RTS

;------------------------------------------------------------------------------
; RHLIM_P1 - ---LIMIT AND SCALE
;   in ESB: copy of bank 0's RHLIM inside the leftover irq_handler copy that ends every page, never run
;------------------------------------------------------------------------------
RHLIM_P1:
P1_9F7D:  CMPA ,X                     ;A=RHEOSTAT VALUE
;X==>RAM BLOCK
;Y==>DATA TABLE
P1_9F7F:  BHS  P1_9F87                ;IFLO  ?LESS THAN LO?
P1_9F81:  CMPA RHS_LT,X
P1_9F83:  BLO  P1_9F87                ;IFHS  ?HIGHER THAN TRIAL LO?
P1_9F85:  DEC  ,X                     ;APPROACH NEW DEGLITCHED LO
P1_9F87:  STA  RHS_LT,X               ;SAVE OUR NEW TRIAL LO
P1_9F89:  CMPA ,X                     ;?LESS THAN LOWER LIMIT?
P1_9F8B:  BHS  P1_9F8F                ;IFLO
P1_9F8D:  LDA  ,X                     ;THEN REPLACE WITH LOWER LIMIT
P1_9F8F:  SUBA ,X                     ;BASE AT ZERO
P1_9F91:  STA  RH_DIR                 ;TEMP STORAGE OF POT BASED VALUE
P1_9F93:  LDB  RHS_SP,X               ;SPREAD THE VALUES-SCAL
P1_9F95:  MUL
P1_9F96:  ADDA RH_DIR                 ;MULTS BY 1XX SO VALUE GOES ABOVE 7F
P1_9F98:  BNE  P1_9F9C                ;IFEQ  ?UNDERFLOW?
P1_9F9A:  LDA  #$01                   ;RANGE IS -7F TO 7F (ALLOWS PROPER NEGATE)
P1_9F9C:  BCS  P1_9FA2                ;IFCC  ?OVERFLOW?
P1_9F9E:  CLR  RHS_ST,X               ;PREPARE TIMER FOR NEXT TOO-HIGH POT VALUE
P1_9FA0:  BRA  P1_9FAE                ;ELSE
P1_9FA2:  LDA  #$FF                   ;THEN LIMIT VALUE
P1_9FA4:  INC  RHS_ST,X               ;TIME THESE EXCESSES
P1_9FA6:  LDB  RHS_ST,X
P1_9FA8:  CMPB #$02
P1_9FAA:  BLO  P1_9FAE                ;IFHS  ?TOO LARGE FOR TOO LONG?
P1_9FAC:  DEC  RHS_SP,X               ;THEN DECREASE SPREAD
P1_9FAE:  CLRB
P1_9FAF:  SUBA #$80                   ;CHANGE TO SIGNED VALUE
P1_9FB1:  STA  RHS_NML,X
P1_9FB3:  RTS

;------------------------------------------------------------------------------
; RHPOS_P1 - CONVERT NML VALUE TO SCREEN POSITION
;   SLEWED POSITIONAL
;   in ESB: copy of bank 0's RHPOS inside the leftover irq_handler copy that ends every page, never run
;------------------------------------------------------------------------------
RHPOS_P1:
P1_9FB4:  CLR  RH_DIR                 ;START WITH POSITIVE DIRECTION TO TRAVEL
P1_9FB6:  LDA  RHS_NML,X              ;CURRENT -7F TO 7F POT
P1_9FB8:  LDB  #$80                   ;HALF WAY INTO POTS STAMP
P1_9FBA:  SUBD RHS_POS,X              ;CURRENT SCREEN POSITION
P1_9FBC:  BGE  P1_9FC1                ;IFLT  ?WANT TO GO IN NEGATIVE DIRECTION?
P1_9FBE:  NEGA                        ;THEN CHANGE DELTA TO POSITIVE 8-BIT
P1_9FBF:  DEC  RH_DIR                 ;AND SAVE NEGATIVE INDICATOR
P1_9FC1:  BLE  P1_9FC6                ;IFGT  ?SLIGHTLY POSITIVE?
P1_9FC3:  ADDD #$00FF                 ;TRUNCATE UPWARD -- ALWAYS SLEW SOME
P1_9FC6:  CMPA #$F8
P1_9FC8:  BLS  P1_9FCC                ;IFHI
P1_9FCA:  LDA  #$F8                   ;PREVENT OVERFLOWS DURING LATER TRUNCATIONS
P1_9FCC:  LDB  #$60                   ;HOW QUICKLY TO SKEW TO DESIRED LOCATION
P1_9FCE:  CMPA #$40                   ;ONE-QUARTER SCREEN
P1_9FD0:  BHS  P1_9FD4                ;IFLO  ?CLOSE ENUF?
P1_9FD2:  LDB  #$30                   ;SLOWER WHEN CLOSER
P1_9FD4:  MUL
P1_9FD5:  TST  RH_DIR                 ;RESTORE ORIGINAL DIRECTION
P1_9FD7:  BPL  P1_9FDD                ;IFMI
P1_9FD9:  COMA                        ;NEGD
P1_9FDA:  NEGB
P1_9FDB:  SBCA #$FF
P1_9FDD:  ADDD RHS_POS,X              ;NOW UPDATE OUR CURSOR POSITION
P1_9FDF:  STD  RHS_POS,X              ;RH$POS IS EQUATED TO VG.RSX,VG.RSY
P1_9FE1:  RTS
P1_9FE2:  .byte $D6, $6A, $96, $6B, $84, $C0, $48, $59 ;the start of a copy of GNSITE, as bank 0 LEDB8-LEDD4, cut off by the end of the page
P1_9FEA:  .byte $24, $02, $8A, $3F, $49, $59, $49, $DD
P1_9FF2:  .byte $30, $C3, $FF, $98, $84, $1F, $FD, $00
P1_9FFA:  .byte $14, $D6, $73, $96, $74, $FF
