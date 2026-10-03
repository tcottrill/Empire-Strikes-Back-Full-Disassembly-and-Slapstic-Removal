;The Empire Strikes Back (Atari, 1985) - annotated disassembly of slapstic
;page 2 of $8000-$9FFF (MAME 'esb': the first half of 136031-106.2u).
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
P2_8000:  BITA P2_8000                ;arms the slapstic
P2_8003:  RTS
P2_8004:  BITA P2_8000
P2_8007:  RTS
P2_8008:  BITA P2_8000
P2_800B:  RTS
P2_800C:  BITA P2_8000
P2_800F:  RTS
P2_8010:  BITA P2_8000
P2_8013:  RTS
P2_8014:  BITA P2_8000
P2_8017:  RTS
P2_8018:  BITA P2_8000
P2_801B:  RTS
P2_801C:  BITA P2_8000
P2_801F:  RTS
P2_8020:  BITA P2_8000
P2_8023:  RTS
P2_8024:  BITA P2_8000
P2_8027:  RTS
P2_8028:  BITA P2_8000
P2_802B:  RTS
P2_802C:  BITA P2_8000
P2_802F:  RTS
P2_8030:  BITA P2_8000
P2_8033:  RTS
P2_8034:  BITA P2_8000
P2_8037:  RTS
P2_8038:  BITA P2_8000
P2_803B:  RTS
P2_803C:  BITA P2_8000
P2_803F:  RTS
P2_8040:  BITA P2_8000
P2_8043:  RTS
P2_8044:  BITA P2_8000
P2_8047:  RTS
P2_8048:  BITA P2_8000
P2_804B:  RTS
P2_804C:  BITA P2_8000
P2_804F:  RTS
P2_8050:  BITA P2_8000
P2_8053:  RTS
P2_8054:  BITA P2_8000
P2_8057:  RTS
P2_8058:  BITA P2_8000
P2_805B:  RTS
P2_805C:  BITA P2_8000
P2_805F:  RTS
P2_8060:  BITA P2_8000
P2_8063:  RTS
P2_8064:  BITA P2_8000
P2_8067:  RTS
P2_8068:  BITA P2_8000
P2_806B:  RTS
P2_806C:  BITA P2_8000
P2_806F:  RTS
P2_8070:  BITA P2_8000
P2_8073:  RTS
P2_8074:  BITA P2_8000
P2_8077:  RTS
P2_8078:  BITA P2_8000
P2_807B:  RTS
P2_807C:  BITA P2_8000
P2_807F:  RTS
P2_8080:  BITA P2_8000                ;arms the slapstic
P2_8083:  RTS
P2_8084:  BITA P2_8000
P2_8087:  RTS
P2_8088:  BITA P2_8000
P2_808B:  RTS
P2_808C:  BITA P2_8000
P2_808F:  RTS
P2_8090:  BITA P2_8000                ;arms the slapstic
P2_8093:  RTS
P2_8094:  BITA P2_8000
P2_8097:  RTS
P2_8098:  BITA P2_8000
P2_809B:  RTS
P2_809C:  BITA P2_8000
P2_809F:  RTS
P2_80A0:  BITA P2_8000                ;arms the slapstic
P2_80A3:  RTS
P2_80A4:  BITA P2_8000
P2_80A7:  RTS
P2_80A8:  BITA P2_8000
P2_80AB:  RTS
P2_80AC:  BITA P2_8000
P2_80AF:  RTS
P2_80B0:  BITA P2_8000                ;arms the slapstic
P2_80B3:  RTS
P2_80B4:  BITA P2_8000
P2_80B7:  RTS
P2_80B8:  BITA P2_8000
P2_80BB:  RTS
P2_80BC:  BITA P2_8000
P2_80BF:  RTS
P2_80C0:  BITA P2_8000
P2_80C3:  RTS
P2_80C4:  BITA P2_8000
P2_80C7:  RTS
P2_80C8:  BITA P2_8000
P2_80CB:  RTS
P2_80CC:  BITA P2_8000
P2_80CF:  RTS
P2_80D0:  BITA P2_8000
P2_80D3:  RTS
P2_80D4:  BITA P2_8000
P2_80D7:  RTS
P2_80D8:  BITA P2_8000
P2_80DB:  RTS
P2_80DC:  BITA P2_8000
P2_80DF:  RTS
P2_80E0:  BITA P2_8000
P2_80E3:  RTS
P2_80E4:  BITA P2_8000
P2_80E7:  RTS
P2_80E8:  BITA P2_8000
P2_80EB:  RTS
P2_80EC:  BITA P2_8000
P2_80EF:  RTS
P2_80F0:  BITA P2_8000
P2_80F3:  RTS
P2_80F4:  BITA P2_8000
P2_80F7:  RTS
P2_80F8:  BITA P2_8000
P2_80FB:  RTS
P2_80FC:  BITA P2_8000
P2_80FF:  RTS
P2_8100:  JSR  P2_8080                ;live: select page 0
P2_8103:  JMP  P2_8106                ;live
P2_8106:  JSR  P2_8100                ;live
P2_8109:  JSR  probot_setup           ;decoy
P2_810C:  JMP  P2_8080                ;decoy
P2_810F:  JSR  P2_8106                ;decoy
P2_8112:  JSR  P2_80B0                ;live: select page 3
P2_8115:  JMP  P2_811B                ;live
P2_8118:  JSR  P2_80B0                ;decoy
P2_811B:  JSR  P2_8112                ;live
P2_811E:  JMP  P2_80A0                ;decoy
P2_8121:  JSR  P2_811E                ;decoy
P2_8124:  JSR  P2_8121                ;decoy
P2_8127:  JSR  P2_8121                ;decoy
P2_812A:  JSR  P2_8090                ;live: select page 1
P2_812D:  JMP  P2_8130                ;live
P2_8130:  JSR  P2_812A                ;live
P2_8133:  JSR  P2_8EFC                ;decoy
P2_8136:  JMP  P2_8090                ;decoy
P2_8139:  JSR  P2_8133                ;decoy
P2_813C:  JSR  P2_8136                ;decoy
P2_813F:  JSR  P2_8139                ;decoy
P2_8142:  JSR  P2_80B0                ;live: select page 3
P2_8145:  JMP  P2_814B                ;live
P2_8148:  JSR  P2_80B0                ;decoy
P2_814B:  JSR  P2_8142                ;live
P2_814E:  JMP  P2_80A0                ;decoy
P2_8151:  JSR  P2_8154                ;decoy
P2_8154:  JSR  P2_8090                ;live: select page 1
P2_8157:  JMP  P2_815A                ;live
P2_815A:  JSR  P2_8154                ;live
P2_815D:  JSR  P2_9640+5              ;decoy
P2_8160:  JMP  P2_8090                ;decoy
P2_8163:  JSR  P2_815A                ;decoy
P2_8166:  JSR  P2_8169                ;decoy
P2_8169:  JSR  P2_8090                ;live: select page 1
P2_816C:  JMP  P2_816F                ;live
P2_816F:  JSR  P2_8169                ;live
P2_8172:  JSR  P2_9663                ;decoy
P2_8175:  JMP  P2_8090                ;decoy
P2_8178:  JSR  P2_817B                ;decoy
P2_817B:  JSR  P2_8175                ;decoy
P2_817E:  JSR  P2_8181                ;decoy
P2_8181:  JSR  P2_80B0                ;live: select page 3
P2_8184:  JMP  P2_818A                ;live
P2_8187:  JSR  P2_80B0                ;decoy
P2_818A:  JSR  P2_8181                ;live
P2_818D:  JMP  P2_80A0                ;decoy
P2_8190:  JSR  P2_8193                ;decoy
P2_8193:  JSR  P2_8190                ;decoy
P2_8196:  JMP  probots_view           ;live: the routine
P2_8199:  JMP  P2_8080                ;live: select page 0
P2_819C:  JMP  P2_8090                ;live: select page 1
P2_819F:  JMP  P2_80B0                ;live: select page 3
P2_81A2:  JMP  P2_81A8                ;decoy
P2_81A5:  JSR  P2_81A2                ;decoy
P2_81A8:  JSR  P2_80B0                ;live: select page 3
P2_81AB:  JMP  P2_81B1                ;live
P2_81AE:  JSR  P2_80B0                ;decoy
P2_81B1:  JSR  P2_81A8                ;live
P2_81B4:  JMP  P2_80A0                ;decoy
P2_81B7:  JMP  P2_81BD                ;decoy
P2_81BA:  JSR  P2_81B1                ;decoy
P2_81BD:  JSR  P2_81B7                ;decoy
P2_81C0:  JSR  P2_8090                ;live: select page 1
P2_81C3:  JSR  P2_8FF7                ;decoy
P2_81C6:  JMP  P2_80A0                ;decoy
P2_81C9:  JSR  P2_81C3                ;decoy
P2_81CC:  JSR  P2_81C6                ;decoy
P2_81CF:  JSR  P2_8090                ;live: select page 1
P2_81D2:  JMP  P2_81D5                ;live
P2_81D5:  JSR  P2_81CF                ;live
P2_81D8:  JSR  P2_922A+1              ;decoy
P2_81DB:  JMP  P2_8090                ;decoy
P2_81DE:  JSR  P2_81D8                ;decoy
P2_81E1:  JSR  P2_8090                ;live: select page 1
P2_81E4:  JMP  P2_81E7                ;live
P2_81E7:  JSR  P2_81E1                ;live
P2_81EA:  JSR  P2_9573                ;decoy
P2_81ED:  JMP  P2_8090                ;decoy
P2_81F0:  JSR  P2_81EA                ;decoy
P2_81F3:  JMP  P2_81F9                ;decoy
P2_81F6:  JSR  P2_80B0                ;live: select page 3
P2_81F9:  JMP  P2_81FF                ;live
P2_81FC:  JSR  P2_80B0                ;decoy
P2_81FF:  JSR  P2_81F6                ;live
P2_8202:  JMP  P2_80A0                ;decoy
P2_8205:  JSR  P2_8208                ;decoy
P2_8208:  JSR  P2_8202                ;decoy
P2_820B:  JSR  P2_8208                ;decoy
P2_820E:  JSR  P2_8080                ;decoy
P2_8211:  JMP  P2_8214                ;decoy
P2_8214:  JSR  P2_820E                ;decoy
P2_8217:  JSR  P2_9913+2              ;decoy
P2_821A:  JMP  P2_8080                ;decoy
P2_821D:  JSR  P2_8217                ;decoy
P2_8220:  JSR  P2_80A0                ;decoy
P2_8223:  JSR  P2_89AC                ;decoy
P2_8226:  JMP  P2_80A0                ;decoy
P2_8229:  JSR  P2_822C                ;decoy
P2_822C:  JSR  P2_8090                ;live: select page 1
P2_822F:  JMP  P2_8232                ;live
P2_8232:  JSR  P2_822C                ;live
P2_8235:  JSR  probot_init_tab+3      ;decoy
P2_8238:  JMP  P2_8090                ;decoy
P2_823B:  JSR  P2_8235                ;decoy
P2_823E:  JMP  P2_8244                ;decoy
P2_8241:  JSR  P2_823E                ;decoy
P2_8244:  JSR  P2_8080                ;live: select page 0
P2_8247:  JMP  P2_824A                ;live
P2_824A:  JSR  P2_8244                ;live
P2_824D:  JSR  astrd_init             ;decoy
P2_8250:  JMP  P2_8080                ;decoy
P2_8253:  JSR  P2_824A                ;decoy
P2_8256:  JSR  P2_8259                ;decoy
P2_8259:  JSR  P2_8256                ;decoy
P2_825C:  JMP  man_probot_setup       ;live: the routine
P2_825F:  JMP  P2_8080                ;live: select page 0
P2_8262:  JMP  P2_8090                ;live: select page 1
P2_8265:  JMP  P2_80B0                ;live: select page 3
P2_8268:  JSR  P2_8262                ;decoy
P2_826B:  JSR  P2_8268                ;decoy
P2_826E:  JSR  P2_8271                ;decoy
P2_8271:  JSR  P2_8090                ;decoy
P2_8274:  JMP  P2_8277                ;decoy
P2_8277:  JSR  P2_8271                ;decoy
P2_827A:  JSR  P2_99F6+2              ;decoy
P2_827D:  JMP  P2_8090                ;decoy
P2_8280:  JSR  P2_8283                ;decoy
P2_8283:  JSR  P2_8090                ;live: select page 1
P2_8286:  JMP  P2_8289                ;live
P2_8289:  JSR  P2_8283                ;live
P2_828C:  JSR  P2_99C1+2              ;decoy
P2_828F:  JMP  P2_8090                ;decoy
P2_8292:  JSR  P2_8295                ;decoy
P2_8295:  JSR  P2_8090                ;live: select page 1
P2_8298:  JSR  P2_9063                ;decoy
P2_829B:  JMP  P2_80A0                ;decoy
P2_829E:  JSR  P2_82A1                ;decoy
P2_82A1:  JMP  P2_82A7                ;decoy
P2_82A4:  JSR  P2_80B0                ;live: select page 3
P2_82A7:  JMP  P2_82AD                ;live
P2_82AA:  JSR  P2_80B0                ;decoy
P2_82AD:  JSR  P2_82A4                ;live
P2_82B0:  JMP  P2_80A0                ;decoy
P2_82B3:  JSR  P2_82AD                ;decoy
P2_82B6:  JSR  P2_8080                ;decoy
P2_82B9:  JMP  P2_82BC                ;decoy
P2_82BC:  JSR  P2_82B6                ;decoy
P2_82BF:  JSR  P2_958F+1              ;decoy
P2_82C2:  JMP  P2_8080                ;decoy
P2_82C5:  JMP  P2_82CB                ;decoy
P2_82C8:  JSR  P2_8090                ;live: select page 1
P2_82CB:  JMP  P2_82CE                ;live
P2_82CE:  JSR  P2_82C8                ;live
P2_82D1:  JSR  P2_9A0E                ;decoy
P2_82D4:  JMP  P2_8090                ;decoy
P2_82D7:  JSR  P2_82DA                ;decoy
P2_82DA:  JSR  P2_82D7                ;decoy
P2_82DD:  JMP  P2_82E3                ;decoy
P2_82E0:  JSR  P2_80B0                ;live: select page 3
P2_82E3:  JMP  P2_82E9                ;live
P2_82E6:  JSR  P2_80B0                ;decoy
P2_82E9:  JSR  P2_82E0                ;live
P2_82EC:  JMP  P2_80A0                ;decoy
P2_82EF:  JSR  P2_82E6                ;decoy
P2_82F2:  JSR  P2_82EC                ;decoy
P2_82F5:  JSR  P2_82F8                ;decoy
P2_82F8:  JSR  P2_8090                ;decoy
P2_82FB:  JSR  P2_9CF2                ;decoy
P2_82FE:  JMP  P2_80A0                ;decoy
P2_8301:  JSR  P2_8304                ;decoy
P2_8304:  JSR  P2_80B0                ;live: select page 3
P2_8307:  JMP  P2_830D                ;live
P2_830A:  JSR  P2_80B0                ;decoy
P2_830D:  JSR  P2_8304                ;live
P2_8310:  JMP  P2_80A0                ;decoy
P2_8313:  JMP  P2_8319                ;decoy
P2_8316:  JSR  P2_80B0                ;live: select page 3
P2_8319:  JMP  P2_831F                ;live
P2_831C:  JSR  P2_80B0                ;decoy
P2_831F:  JSR  P2_8316                ;live
P2_8322:  JMP  P2_80A0                ;decoy
P2_8325:  JSR  P2_8328                ;decoy
P2_8328:  JSR  P2_832B                ;decoy
P2_832B:  JSR  P2_8080                ;live: select page 0
P2_832E:  JMP  P2_8331                ;live
P2_8331:  JSR  P2_832B                ;live
P2_8334:  JSR  P2_891A                ;decoy
P2_8337:  JMP  P2_8080                ;decoy
P2_833A:  JSR  P2_8337                ;decoy
P2_833D:  JSR  P2_8337                ;decoy
P2_8340:  JMP  P2_8346                ;decoy
P2_8343:  JSR  P2_8340                ;decoy
P2_8346:  JMP  astrd_lz_hit           ;live: the routine
P2_8349:  JMP  P2_8080                ;decoy
P2_834C:  JMP  P2_8090                ;decoy
P2_834F:  JMP  P2_80B0                ;live: select page 3
P2_8352:  JSR  P2_8355                ;decoy
P2_8355:  JSR  P2_80B0                ;decoy
P2_8358:  JMP  P2_835E                ;decoy
P2_835B:  JSR  P2_80B0                ;decoy
P2_835E:  JSR  P2_8355                ;decoy
P2_8361:  JMP  P2_80A0                ;decoy
P2_8364:  JMP  P2_836A                ;decoy
P2_8367:  JSR  P2_80B0                ;live: select page 3
P2_836A:  JMP  P2_8370                ;live
P2_836D:  JSR  P2_80B0                ;decoy
P2_8370:  JSR  P2_8367                ;live
P2_8373:  JMP  P2_80A0                ;decoy
P2_8376:  JSR  P2_8379                ;decoy
P2_8379:  JSR  P2_837C                ;decoy
P2_837C:  JSR  P2_8379                ;decoy
P2_837F:  JMP  probots_move           ;live: the routine
P2_8382:  JMP  P2_8080                ;live: select page 0
P2_8385:  JMP  P2_8090                ;live: select page 1
P2_8388:  JMP  P2_80B0                ;live: select page 3
P2_838B:  JSR  P2_8385                ;decoy
P2_838E:  JSR  P2_8080                ;live: select page 0
P2_8391:  JMP  P2_8394                ;live
P2_8394:  JSR  P2_838E                ;live
P2_8397:  JSR  P2_8674                ;decoy
P2_839A:  JMP  P2_8080                ;decoy
P2_839D:  JSR  P2_8397                ;decoy
P2_83A0:  JSR  P2_80B0                ;live: select page 3
P2_83A3:  JMP  P2_83A9                ;live
P2_83A6:  JSR  P2_80B0                ;decoy
P2_83A9:  JSR  P2_83A0                ;live
P2_83AC:  JMP  P2_80A0                ;decoy
P2_83AF:  JSR  P2_83A9                ;decoy
P2_83B2:  JSR  P2_83B5                ;decoy
P2_83B5:  JSR  P2_8090                ;live: select page 1
P2_83B8:  JMP  P2_83BB                ;live
P2_83BB:  JSR  P2_83B5                ;live
P2_83BE:  JSR  P2_99D7                ;decoy
P2_83C1:  JMP  P2_8090                ;decoy
P2_83C4:  JSR  P2_83C1                ;decoy
P2_83C7:  JSR  P2_80B0                ;live: select page 3
P2_83CA:  JMP  P2_83D0                ;live
P2_83CD:  JSR  P2_80B0                ;decoy
P2_83D0:  JSR  P2_83C7                ;live
P2_83D3:  JMP  P2_80A0                ;decoy
P2_83D6:  JSR  P2_83D0                ;decoy
P2_83D9:  JMP  P2_83DF                ;decoy
P2_83DC:  JSR  P2_8080                ;live: select page 0
P2_83DF:  JMP  P2_83E2                ;live
P2_83E2:  JSR  P2_83DC                ;live
P2_83E5:  JSR  P2_9614                ;decoy
P2_83E8:  JMP  P2_8080                ;decoy
P2_83EB:  JSR  P2_83E5                ;decoy
P2_83EE:  JSR  P2_80B0                ;live: select page 3
P2_83F1:  JMP  P2_83F7                ;live
P2_83F4:  JSR  P2_80B0                ;decoy
P2_83F7:  JSR  P2_83EE                ;live
P2_83FA:  JMP  P2_80A0                ;decoy
P2_83FD:  JSR  P2_8400                ;decoy
P2_8400:  JSR  P2_8090                ;live: select page 1
P2_8403:  JMP  P2_8406                ;live
P2_8406:  JSR  P2_8400                ;live
P2_8409:  JSR  P2_95F0+1              ;decoy
P2_840C:  JMP  P2_8090                ;decoy
P2_840F:  JSR  P2_8409                ;decoy
P2_8412:  JSR  P2_840F                ;decoy
P2_8415:  JSR  P2_840F                ;decoy
P2_8418:  JSR  P2_8415                ;decoy
P2_841B:  JMP  astrd_man_init         ;live: the routine
P2_841E:  JMP  P2_8080                ;live: select page 0
P2_8421:  JMP  P2_8090                ;live: select page 1
P2_8424:  JMP  P2_80B0                ;live: select page 3
P2_8427:  JSR  P2_8424                ;decoy
P2_842A:  JSR  P2_8090                ;live: select page 1
P2_842D:  JMP  P2_8430                ;live
P2_8430:  JSR  P2_842A                ;live
P2_8433:  JSR  astrd_init             ;decoy
P2_8436:  JMP  P2_8090                ;decoy
P2_8439:  JSR  P2_8430                ;decoy
P2_843C:  JSR  P2_80B0                ;live: select page 3
P2_843F:  JMP  P2_8445                ;live
P2_8442:  JSR  P2_80B0                ;decoy
P2_8445:  JSR  P2_843C                ;live
P2_8448:  JMP  P2_80A0                ;decoy
P2_844B:  JSR  P2_844E                ;decoy
P2_844E:  JMP  P2_8454                ;decoy
P2_8451:  JSR  P2_844E                ;decoy
P2_8454:  JMP  probot_shot_down       ;live: the routine
P2_8457:  JMP  P2_8080                ;decoy
P2_845A:  JMP  P2_8090                ;decoy
P2_845D:  JMP  P2_80B0                ;live: select page 3
P2_8460:  JSR  P2_8463                ;decoy
P2_8463:  JSR  P2_80B0                ;live: select page 3
P2_8466:  JMP  P2_846C                ;live
P2_8469:  JSR  P2_80B0                ;decoy
P2_846C:  JSR  P2_8463                ;live
P2_846F:  JMP  P2_80A0                ;decoy
P2_8472:  JSR  P2_846C                ;decoy
P2_8475:  JSR  P2_8478                ;decoy
P2_8478:  JSR  P2_846F                ;decoy
P2_847B:  JSR  P2_8080                ;live: select page 0
P2_847E:  JMP  P2_8481                ;live
P2_8481:  JSR  P2_847B                ;live
P2_8484:  JSR  P2_8705                ;decoy
P2_8487:  JMP  P2_8080                ;decoy
P2_848A:  JSR  P2_8487                ;decoy
P2_848D:  JSR  P2_8487                ;decoy
P2_8490:  JMP  P2_8496                ;decoy
P2_8493:  JSR  P2_80B0                ;live: select page 3
P2_8496:  JMP  P2_849C                ;live
P2_8499:  JSR  P2_80B0                ;decoy
P2_849C:  JSR  P2_8493                ;live
P2_849F:  JMP  P2_80A0                ;decoy
P2_84A2:  JSR  P2_8499                ;decoy
P2_84A5:  JSR  P2_84A2                ;decoy
P2_84A8:  JMP  astrd_move_all         ;live: the routine
P2_84AB:  JMP  P2_8080                ;live: select page 0
P2_84AE:  JMP  P2_8090                ;live: select page 1
P2_84B1:  JMP  P2_80B0                ;live: select page 3
P2_84B4:  JSR  P2_84B1                ;decoy
P2_84B7:  JSR  P2_80B0                ;live: select page 3
P2_84BA:  JMP  P2_84C0                ;live
P2_84BD:  JSR  P2_80B0                ;decoy
P2_84C0:  JSR  P2_84B7                ;live
P2_84C3:  JMP  P2_80A0                ;decoy
P2_84C6:  JSR  P2_84BD                ;decoy
P2_84C9:  JSR  P2_8090                ;live: select page 1
P2_84CC:  JMP  P2_84CF                ;live
P2_84CF:  JSR  P2_84C9                ;live
P2_84D2:  JSR  P2_9183+2              ;decoy
P2_84D5:  JMP  P2_8090                ;decoy
P2_84D8:  JSR  P2_84DB                ;decoy
P2_84DB:  JSR  P2_84D8                ;decoy
P2_84DE:  JMP  astrd_init             ;live: the routine
P2_84E1:  JMP  P2_8080                ;live: select page 0
P2_84E4:  JMP  P2_8090                ;live: select page 1
P2_84E7:  JMP  P2_80B0                ;live: select page 3
P2_84EA:  JSR  P2_84E7                ;decoy
P2_84ED:  JSR  P2_84E4                ;decoy
P2_84F0:  JSR  P2_8090                ;live: select page 1
P2_84F3:  JSR  P2_8F8B                ;decoy
P2_84F6:  JMP  P2_80A0                ;decoy
P2_84F9:  JSR  P2_84F0                ;decoy
P2_84FC:  JSR  P2_8080                ;live: select page 0
P2_84FF:  JMP  P2_8502                ;live
P2_8502:  JSR  P2_84FC                ;live
P2_8505:  JSR  P2_969A+3              ;decoy
P2_8508:  JMP  P2_8080                ;decoy
P2_850B:  JSR  P2_8508                ;decoy
P2_850E:  JSR  P2_8505                ;decoy
P2_8511:  JSR  P2_8090                ;live: select page 1
P2_8514:  JMP  P2_8517                ;live
P2_8517:  JSR  P2_8511                ;live
P2_851A:  JSR  P2_86E1                ;decoy
P2_851D:  JMP  P2_8090                ;decoy
P2_8520:  JSR  P2_8517                ;decoy
P2_8523:  JSR  P2_8520                ;decoy
P2_8526:  JMP  astrd_view_all         ;live: the routine
P2_8529:  JMP  P2_8080                ;live: select page 0
P2_852C:  JMP  P2_8090                ;live: select page 1
P2_852F:  JMP  P2_80B0                ;live: select page 3
P2_8532:  JSR  P2_8529                ;decoy
P2_8535:  JSR  P2_8080                ;decoy
P2_8538:  JMP  P2_853B                ;decoy
P2_853B:  JSR  P2_8535                ;decoy
P2_853E:  JSR  P2_9002+1              ;decoy
P2_8541:  JMP  P2_8080                ;decoy
P2_8544:  JSR  P2_853B                ;decoy
P2_8547:  JSR  P2_853E                ;decoy
P2_854A:  JSR  P2_8547                ;decoy
P2_854D:  JSR  P2_8090                ;live: select page 1
P2_8550:  JMP  P2_8553                ;live
P2_8553:  JSR  P2_854D                ;live
P2_8556:  JSR  P2_88FC+1              ;decoy
P2_8559:  JMP  P2_8090                ;decoy
P2_855C:  JSR  P2_8556                ;decoy
P2_855F:  JSR  P2_8562                ;decoy
P2_8562:  JSR  P2_80B0                ;live: select page 3
P2_8565:  JMP  P2_856B                ;live
P2_8568:  JSR  P2_80B0                ;decoy
P2_856B:  JSR  P2_8562                ;live
P2_856E:  JMP  P2_80A0                ;decoy
P2_8571:  JMP  P2_8577                ;decoy
P2_8574:  JSR  P2_856E                ;decoy
P2_8577:  JMP  P2_857D                ;decoy
P2_857A:  JSR  P2_8090                ;live: select page 1
P2_857D:  JSR  P2_8F16                ;decoy
P2_8580:  JMP  P2_80A0                ;decoy
P2_8583:  JSR  P2_8580                ;decoy
P2_8586:  JMP  P2_858C                ;decoy
P2_8589:  JSR  P2_8090                ;decoy
P2_858C:  JMP  P2_858F                ;decoy
P2_858F:  JSR  P2_8589                ;decoy
P2_8592:  JSR  P2_8E32+1              ;decoy
P2_8595:  JMP  P2_8090                ;decoy
P2_8598:  JSR  P2_858F                ;decoy
P2_859B:  JSR  P2_8598                ;decoy
P2_859E:  JMP  probot_setup           ;live: the routine
P2_85A1:  JMP  P2_8080                ;live: select page 0
P2_85A4:  JMP  P2_8090                ;live: select page 1
P2_85A7:  JMP  P2_80B0                ;live: select page 3
P2_85AA:  JMP  P2_85B0                ;decoy
P2_85AD:  JSR  P2_85A4                ;decoy
P2_85B0:  JSR  P2_8080                ;decoy
P2_85B3:  JMP  P2_85B6                ;decoy
P2_85B6:  JSR  P2_85B0                ;decoy
P2_85B9:  JSR  P2_93B4                ;decoy
P2_85BC:  JMP  P2_8080                ;decoy
P2_85BF:  JMP  P2_85C5                ;decoy
P2_85C2:  JSR  P2_85BF                ;decoy
P2_85C5:  JSR  P2_8090                ;decoy
P2_85C8:  JMP  P2_85CB                ;decoy
P2_85CB:  JSR  P2_85C5                ;decoy
P2_85CE:  JSR  P2_9501+1              ;decoy
P2_85D1:  JMP  P2_8090                ;decoy
P2_85D4:  JSR  P2_85D7                ;decoy
P2_85D7:  JSR  P2_8090                ;live: select page 1
P2_85DA:  JMP  P2_85DD                ;live
P2_85DD:  JSR  P2_85D7                ;live
P2_85E0:  JSR  probot_setup           ;decoy
P2_85E3:  JMP  P2_8090                ;decoy
P2_85E6:  JMP  probot_setup           ;decoy
P2_85E9:  JSR  P2_85E6                ;decoy

;------------------------------------------------------------------------------
; probot_setup - wave 1 set-up of the probots, called once from wave1_setup (phase $45) through maze entry
;   MZ_859E. loads the points of objects 4-7 and 9-$10 into math RAM through the cross-bank JADOBJ entry L60A8 (B
;   = object number), keeping the math RAM address before and after objects 9-$10 in w1_anim_pts and w1_anim_end
;   for the point animation at P2_8E86, then frees all five $1A-byte records at ALIEN and presets each one's
;   height ($0200), spin angle and rate and part mask from the table at P2_866C, state 4 and both timers 8. ends
;   with w1_spawn = 5 so that probots_move fills the records one per frame
;------------------------------------------------------------------------------
probot_setup:
P2_85EC:  LDB  #$04                   ;objects 4-7 into math RAM: B = object number for JADOBJ in bank 1
P2_85EE:  JSR  L60A8
P2_85F1:  LDB  #$05
P2_85F3:  JSR  L60A8
P2_85F6:  LDB  #$06
P2_85F8:  JSR  L60A8
P2_85FB:  LDB  #$07
P2_85FD:  JSR  L60A8
P2_8600:  LDD  BJ_RAM                 ;math RAM address after object 7: the points of objects 9-$10 start here
P2_8602:  STD  w1_anim_pts
P2_8605:  LDB  #$09                   ;objects 9-$10, four points each
P2_8607:  JSR  L60A8
P2_860A:  LDB  #$0A
P2_860C:  JSR  L60A8
P2_860F:  LDB  #$0B
P2_8611:  JSR  L60A8
P2_8614:  LDB  #$0C
P2_8616:  JSR  L60A8
P2_8619:  LDB  #$0D
P2_861B:  JSR  L60A8
P2_861E:  LDB  #$0E
P2_8620:  JSR  L60A8
P2_8623:  LDB  #$0F
P2_8625:  JSR  L60A8
P2_8628:  LDB  #$10
P2_862A:  JSR  L60A8
P2_862D:  LDD  BJ_RAM                 ;math RAM address after object $10: end of the animated points
P2_862F:  STD  w1_anim_end
P2_8632:  LDX  #probot_init_tab
P2_8635:  LDU  #ALIEN                 ;five records of $1A bytes, up to xmit_atst
P2_8638:  STU  S2_PRM
P2_863A:  LDA  #$00
P2_863C:  STA  ,U                     ;type 0: the record is free
P2_863E:  STA  1,U
P2_8640:  LDD  #$0200                 ;height
P2_8643:  STD  9,U
P2_8645:  LDD  #$0000
P2_8648:  STD  13,U                   ;bob offset
P2_864A:  LDD  ,X++                   ;spin angle and spin rate
P2_864C:  STD  11,U
P2_864E:  LDD  ,X++                   ;part mask in A, the fourth table byte is not used
P2_8650:  STA  $13,U
P2_8653:  JSR  probot_set_fixed       ;state 4
P2_8656:  LDA  #$08                   ;both timers 8
P2_8658:  STA  3,U
P2_865A:  STA  $14,U
P2_865D:  LEAU $1A,U
P2_8660:  CMPU #xmit_atst
P2_8664:  BCS  P2_8638
P2_8666:  LDA  #$05                   ;keep five records filled
P2_8668:  STA  w1_spawn
P2_866B:  RTS

probot_init_tab:
P2_866C:  .byte $33, $03, $AA, $00    ;probot set-up row 0  4 bytes per record: spin angle, spin rate, part mask (one bit per object 9-$10 drawn by P2_91CC), unused. six rows, the code reads five
P2_8670:  .byte $10, $FD, $55, $00    ;probot set-up row 1
P2_8674:  .byte $27, $03, $56, $00    ;probot set-up row 2
P2_8678:  .byte $5A, $FD, $A9, $00    ;probot set-up row 3
P2_867C:  .byte $45, $03, $A3, $00    ;probot set-up row 4
P2_8680:  .byte $60, $FD, $33, $00    ;probot set-up row 5

;------------------------------------------------------------------------------
; probot_spawn - brings the free record at U to life: type 7, flags 0, and a place on the far edge of the square
;   round the player - by the sign of a random byte either x or y gets $8000 added and the other axis gets a
;   random value in -$4000..$3FFF - then state 2 (close in on the player). called by probots_move, which clears x
;   and y first
;------------------------------------------------------------------------------
probot_spawn:
P2_8684:  JSR  probot_pos_rel         ;no effect on a fresh record: its type byte is 0
P2_8687:  LDA  #$07                   ;type 7: bit $02 lets it shoot, bit $04 lets it transmit
P2_8689:  STA  ,U
P2_868B:  LDA  #$00
P2_868D:  STA  1,U
P2_868F:  JSR  rnd_set
P2_8692:  LDA  >RND_S1                ;random: which axis is put at the far edge
P2_8695:  BPL  P2_86AE
P2_8697:  LDD  5,U
P2_8699:  ADDD #$8000                 ;x was cleared by the caller: x = $8000
P2_869C:  STD  5,U
P2_869E:  LDD  >RND_S1
P2_86A1:  ASLB                        ;random bit: the other axis is 0..$3FFF or $C000..$FFFF
P2_86A2:  BCC  P2_86A8
P2_86A4:  ANDA #$3F
P2_86A6:  BRA  P2_86AA
P2_86A8:  ORA  #$C0
P2_86AA:  STD  7,U
P2_86AC:  BRA  P2_86C3
P2_86AE:  LDD  7,U
P2_86B0:  ADDD #$8000                 ;y = $8000, and x gets the random value
P2_86B3:  STD  7,U
P2_86B5:  LDD  >RND_S1
P2_86B8:  ASLB
P2_86B9:  BCC  P2_86BF
P2_86BB:  ANDA #$3F
P2_86BD:  BRA  P2_86C1
P2_86BF:  ORA  #$C0
P2_86C1:  STD  5,U
P2_86C3:  JSR  probot_set_close       ;state 2: close in on the player
P2_86C6:  RTS

;------------------------------------------------------------------------------
; man_probot_setup - training manual set-up of the demo probot, called from man_init_probot through maze entry
;   MZ_825C with B = manual page 0-2 (anything higher is taken as 0). fills the first record at ALIEN from the
;   10-byte row of the table at P2_875E for that page (x, y, height, spin angle and rate, part mask, type), state
;   0 so that it holds still, frees the other four records, loads objects 4-7 and 9-$10 into math RAM as
;   probot_setup does, and sets w1_spawn to 0 so that nothing is spawned
;------------------------------------------------------------------------------
man_probot_setup:
P2_86C7:  LDA  #$0A                   ;B = manual page: 10 bytes per page
P2_86C9:  MUL
P2_86CA:  CMPB #$1E                   ;page 3 or more: use page 0
P2_86CC:  BCS  P2_86D0
P2_86CE:  LDB  #$00
P2_86D0:  LDX  #man_probot_tab
P2_86D3:  ABX
P2_86D4:  LDU  #ALIEN
P2_86D7:  LDD  ,X++                   ;x, y and height
P2_86D9:  STD  5,U
P2_86DB:  LDD  ,X++
P2_86DD:  STD  7,U
P2_86DF:  LDD  ,X++
P2_86E1:  STD  9,U
P2_86E3:  LDD  #$0000                 ;bob offset
P2_86E6:  STD  13,U
P2_86E8:  LDD  ,X++                   ;spin angle and spin rate
P2_86EA:  STD  11,U
P2_86EC:  LDD  ,X++                   ;part mask and type byte
P2_86EE:  STA  $13,U
P2_86F1:  STB  ,U
P2_86F3:  LDA  #$00
P2_86F5:  STA  1,U
P2_86F7:  LDA  #$00                   ;state 0: hold still
P2_86F9:  STA  4,U
P2_86FB:  LDA  #$08
P2_86FD:  STA  3,U
P2_86FF:  STA  $14,U
P2_8702:  LEAU $1A,U
P2_8705:  LDA  #$00                   ;free the other four records
P2_8707:  STA  ,U
P2_8709:  LEAU $1A,U
P2_870C:  CMPU #xmit_atst
P2_8710:  BCS  P2_8707
P2_8712:  LDB  #$04                   ;the probot objects into math RAM, as in probot_setup
P2_8714:  JSR  L60A8
P2_8717:  LDB  #$05
P2_8719:  JSR  L60A8
P2_871C:  LDB  #$06
P2_871E:  JSR  L60A8
P2_8721:  LDB  #$07
P2_8723:  JSR  L60A8
P2_8726:  LDD  BJ_RAM
P2_8728:  STD  w1_anim_pts
P2_872B:  LDB  #$09
P2_872D:  JSR  L60A8
P2_8730:  LDB  #$0A
P2_8732:  JSR  L60A8
P2_8735:  LDB  #$0B
P2_8737:  JSR  L60A8
P2_873A:  LDB  #$0C
P2_873C:  JSR  L60A8
P2_873F:  LDB  #$0D
P2_8741:  JSR  L60A8
P2_8744:  LDB  #$0E
P2_8746:  JSR  L60A8
P2_8749:  LDB  #$0F
P2_874B:  JSR  L60A8
P2_874E:  LDB  #$10
P2_8750:  JSR  L60A8
P2_8753:  LDD  BJ_RAM
P2_8755:  STD  w1_anim_end
P2_8758:  LDA  #$00                   ;spawn none
P2_875A:  STA  w1_spawn
P2_875D:  RTS

man_probot_tab:
P2_875E:  .word $0400, $0000, $0200   ;probot manual row 0: x, y, z, then four bytes  10 bytes per manual page: x, y, height (words), spin angle, spin rate, part mask, type byte. three pages
P2_8764:  .byte $33, $01, $AA, $01
P2_8768:  .word $0400, $0000, $0200   ;probot manual row 1: x, y, z, then four bytes
P2_876E:  .byte $10, $FF, $55, $01
P2_8772:  .word $0400, $0000, $0200   ;probot manual row 2: x, y, z, then four bytes
P2_8778:  .byte $5A, $FF, $A9, $11

;------------------------------------------------------------------------------
; probots_move - per-frame move of the wave 1 probots, called through maze entry MZ_837F from wave1_exec (phase
;   $1A), wave1_end_exec (phase $1C) and the manual's man_move_probot. with w1_spawn above 0 it spawns one probot
;   in the first free record among the first w1_spawn records, with w1_spawn minus it frees every record that is
;   not in view (flag $10 of byte 1 clear). then it counts the live records into w1_active and for each one runs
;   the head, spin and bob animation, the behaviour, the point animation (P2_8E86) and the two timers (P2_8F9A)
;------------------------------------------------------------------------------
probots_move:
P2_877C:  LDB  w1_spawn
P2_877F:  BLE  P2_87A0                ;0 or minus: spawn none
P2_8781:  LDU  #ALIEN
P2_8784:  LDA  ,U
P2_8786:  BNE  P2_8794                ;a free record: spawn one probot there and stop looking
P2_8788:  LDD  #$0000                 ;x and y 0 before the spawn
P2_878B:  STD  5,U
P2_878D:  STD  7,U
P2_878F:  JSR  probot_spawn
P2_8792:  BRA  P2_87A0
P2_8794:  DECB                        ;only the first w1_spawn records are looked at
P2_8795:  BLE  P2_87A0
P2_8797:  LEAU $1A,U
P2_879A:  CMPU #xmit_atst
P2_879E:  BCS  P2_8784
P2_87A0:  LDA  w1_spawn
P2_87A3:  BGE  P2_87BF                ;minus (end of the wave): free the probots that are out of view
P2_87A5:  LDU  #ALIEN
P2_87A8:  LDA  ,U
P2_87AA:  BEQ  P2_87B6
P2_87AC:  LDA  1,U
P2_87AE:  BITA #$10                   ;$10 = in view, set by the view routine P2_8FD3
P2_87B0:  BNE  P2_87B6
P2_87B2:  LDA  #$00
P2_87B4:  STA  ,U
P2_87B6:  LEAU $1A,U
P2_87B9:  CMPU #xmit_atst
P2_87BD:  BCS  P2_87A8
P2_87BF:  CLR  w1_active              ;count the live records afresh
P2_87C2:  LDU  #ALIEN
P2_87C5:  LDA  ,U
P2_87C7:  BEQ  P2_87D8
P2_87C9:  INC  w1_active
P2_87CC:  JSR  probot_turn_bob
P2_87CF:  JSR  probot_behave
P2_87D2:  JSR  probot_legs_anim
P2_87D5:  JSR  probot_timers
P2_87D8:  LEAU $1A,U
P2_87DB:  CMPU #xmit_atst
P2_87DF:  BCS  P2_87C5
P2_87E1:  RTS

;------------------------------------------------------------------------------
; probot_turn_bob - animation of the probot record at U. the head angle (byte $10) moves by a quarter of its
;   rate (byte $11) each frame: while the angle is more than $20 from the target (byte $12) the rate grows away
;   from zero, up to $11 or down to $F3, and within $20 of the target a rate of exactly +1 or -1 takes a new
;   random target and reverses (probot_head_back, probot_head_fwd), any other rate is left as it is. the body spin
;   angle (byte 11) advances by its rate (byte 12), and the bob offset (word at 13) counts up and down between 0
;   and $2F, reversing its direction byte (15) at either end
;------------------------------------------------------------------------------
probot_turn_bob:
P2_87E2:  JSR  rnd_set
P2_87E5:  LDB  $11,U                  ;head turn rate
P2_87E8:  LDA  $10,U                  ;head angle less the target angle
P2_87EB:  SUBA $12,U
P2_87EE:  TSTA
P2_87EF:  BPL  P2_87F2
P2_87F1:  NEGA
P2_87F2:  CMPA #$20                   ;more than $20 from the target: speed up
P2_87F4:  BHI  P2_8809
P2_87F6:  TSTB
P2_87F7:  BMI  P2_8801
P2_87F9:  DECB                        ;near the target: only a rate of exactly 1 or -1 does anything. the changed B is not stored
P2_87FA:  BNE  P2_87FF
P2_87FC:  JSR  probot_head_back
P2_87FF:  BRA  P2_8807
P2_8801:  INCB
P2_8802:  BMI  P2_8807
P2_8804:  JSR  probot_head_fwd
P2_8807:  BRA  P2_881F
P2_8809:  TSTB
P2_880A:  BMI  P2_8815
P2_880C:  INCB
P2_880D:  CMPB #$11                   ;rate up to $11 at most
P2_880F:  BLS  P2_8813
P2_8811:  LDB  #$11
P2_8813:  BRA  P2_881C
P2_8815:  DECB
P2_8816:  CMPB #$F3                   ;rate down to $F3 at most
P2_8818:  BCC  P2_881C
P2_881A:  LDB  #$F3
P2_881C:  STB  $11,U
P2_881F:  LDB  $11,U
P2_8822:  ASRB                        ;head angle += rate / 4
P2_8823:  ASRB
P2_8824:  ADDB $10,U
P2_8827:  STB  $10,U
P2_882A:  LDB  12,U                   ;body spin angle += spin rate
P2_882C:  ADDB 11,U
P2_882E:  STB  11,U
P2_8830:  LDA  15,U                   ;bob direction
P2_8832:  BMI  P2_8839
P2_8834:  LDD  #$0001
P2_8837:  BRA  P2_883C
P2_8839:  LDD  #$FFFF
P2_883C:  ADDD 13,U
P2_883E:  CMPD #$0030                 ;outside 0..$2F: keep the offset and reverse the direction
P2_8842:  BCC  P2_8848
P2_8844:  STD  13,U
P2_8846:  BRA  P2_884E
P2_8848:  LDB  15,U
P2_884A:  EORB #$FF
P2_884C:  STB  15,U
P2_884E:  RTS

;------------------------------------------------------------------------------
; probot_head_fwd - gives the probot at U a new random head target angle (byte $12 from RND_S1), reverses its
;   bob direction (byte 15) and sets the head rate to +1
;------------------------------------------------------------------------------
probot_head_fwd:
P2_884F:  LDB  >RND_S1                ;new random target angle for the head
P2_8852:  STB  $12,U
P2_8855:  LDB  15,U                   ;reverse the bob direction
P2_8857:  EORB #$FF
P2_8859:  STB  15,U
P2_885B:  LDB  #$01
P2_885D:  STB  $11,U
P2_8860:  RTS

;------------------------------------------------------------------------------
; probot_head_back - as probot_head_fwd with the head rate set to -1
;------------------------------------------------------------------------------
probot_head_back:
P2_8861:  LDB  >RND_S1                ;new random target angle for the head
P2_8864:  STB  $12,U
P2_8867:  LDB  15,U                   ;reverse the bob direction
P2_8869:  EORB #$FF
P2_886B:  STB  15,U
P2_886D:  LDB  #$FF
P2_886F:  STB  $11,U
P2_8872:  RTS

probot_state_tab:
P2_8873:  .word probot_st_hold        ;state handlers, indexed by byte 4 of the record (JSR [B,X] at P2_8912): 0 hold, 1 drift, 2 close in, 3 back away, 4 fixed place, 5 fly with a speed, 6 go to goal, 7 go to goal at a limited step, 8 circle the player, 9 go to goal, 10 circle a point, 11 fly off and free
P2_8875:  .word probot_st_drift
P2_8877:  .word probot_do_approach
P2_8879:  .word probot_do_retreat
P2_887B:  .word probot_st_fixed
P2_887D:  .word probot_do_drift
P2_887F:  .word probot_do_seek
P2_8881:  .word probot_do_seek2
P2_8883:  .word probot_do_circle
P2_8885:  .word probot_do_seek
P2_8887:  .word probot_do_orbit
P2_8889:  .word probot_do_leave

probot_start_tab:
P2_888B:  .word probot_set_drift      ;state start routines, one picked at random by probot_pick_state (JSR ,X at P2_88ED): they start states 1, 2, 3, 4, 5, 6, 7, 8, 9 and 10 in this order
P2_888D:  .word probot_set_close
P2_888F:  .word probot_go_retreat
P2_8891:  .word probot_set_fixed
P2_8893:  .word probot_go_drift
P2_8895:  .word probot_go_point
P2_8897:  .word probot_go_point2
P2_8899:  .word probot_go_circle
P2_889B:  .word probot_go_ahead
P2_889D:  .word probot_go_orbit

probot_early_tab:
P2_889F:  .word probot_set_fixed      ;the last four entries are also the table for the first 150 frames, indexed by w1_level and 3: states 4, 8, 9 and 10
P2_88A1:  .word probot_go_circle
P2_88A3:  .word probot_go_ahead
P2_88A5:  .word probot_go_orbit

;------------------------------------------------------------------------------
; probot_pick_state - picks a new behaviour for the probot at U by calling one state start routine, which stores
;   the state number in byte 4 and may set a goal or speed. state 0 (the manual's demo probot) is left alone. with
;   w1_spawn minus (end of the wave) it is P2_8A9D, state 11, fly off and free the record. a probot that is out of
;   view and not already in state 9 gets P2_8C14, state 9, a goal in front of the player. otherwise during the
;   first 150 frames of the phase (PH_TIM below $96) the entry of the 4-word table at P2_889F for w1_level and 3
;   is used, and after that a random one of the ten entries of the table at P2_888B
;------------------------------------------------------------------------------
probot_pick_state:
P2_88A7:  LDA  4,U                    ;state 0 (manual demo): never changed
P2_88A9:  CMPA #$00
P2_88AB:  BEQ  P2_88EF
P2_88AD:  LDB  w1_spawn               ;minus: the wave is ending
P2_88B0:  BPL  P2_88B7
P2_88B2:  LDX  #probot_go_leave       ;state 11: fly off and free the record
P2_88B5:  BRA  P2_88EA
P2_88B7:  CMPA #$09                   ;state 9 already, or in view: pick by time and level or at random
P2_88B9:  BEQ  P2_88C6
P2_88BB:  LDA  1,U
P2_88BD:  BITA #$10
P2_88BF:  BNE  P2_88C6
P2_88C1:  LDX  #probot_go_ahead       ;out of view: state 9, a goal in front of the player
P2_88C4:  BRA  P2_88EA
P2_88C6:  LDD  PH_TIM                 ;first 150 frames of the phase: pick by level
P2_88C9:  SUBD #$0096
P2_88CC:  BCC  P2_88DB
P2_88CE:  LDA  w1_level               ;level and 3 picks state 4, 8, 9 or 10
P2_88D1:  ANDA #$03
P2_88D3:  ASLA
P2_88D4:  LDX  #probot_early_tab
P2_88D7:  LDX  A,X
P2_88D9:  BRA  P2_88EA
P2_88DB:  JSR  rnd_set
P2_88DE:  LDA  #$0A                   ;10 * random byte / 256: 0-9
P2_88E0:  LDB  >rnd_s4
P2_88E3:  MUL
P2_88E4:  ASLA                        ;word index into the ten start routines
P2_88E5:  LDX  #probot_start_tab
P2_88E8:  LDX  A,X
P2_88EA:  JSR  rnd_set
P2_88ED:  JSR  ,X                     ;start the state: X = routine from one of the three choices above
P2_88EF:  RTS

;------------------------------------------------------------------------------
; probot_behave - per-frame behaviour of the probot at U. on every fourth frame with one chance in eight it
;   picks a new behaviour (probot_pick_state), then it calls the handler of the current state: byte 4 of the
;   record indexes the table of twelve routine addresses at P2_8873, a state above 11 is run as state 2. unless
;   the state is 0 it then eases the height (probot_height) and, when the position is held relative to the player
;   and is within $0200 of him on both axes, starts state 3 (P2_8A3E, back away). X is preserved
;------------------------------------------------------------------------------
probot_behave:
P2_88F0:  PSHS X
P2_88F2:  JSR  rnd_set
P2_88F5:  LDA  >FRAMEL                ;every fourth frame
P2_88F8:  ANDA #$03
P2_88FA:  BNE  P2_8906
P2_88FC:  LDA  >RND_S1                ;one chance in eight: new behaviour
P2_88FF:  ANDA #$07
P2_8901:  BNE  P2_8906
P2_8903:  JSR  probot_pick_state
P2_8906:  LDB  4,U                    ;state number
P2_8908:  ASLB
P2_8909:  CMPB #$18                   ;above 11: run state 2
P2_890B:  BCS  P2_890F
P2_890D:  LDB  #$04
P2_890F:  LDX  #probot_state_tab
P2_8912:  JSR  [B,X]                  ;the state's handler
P2_8914:  LDA  4,U                    ;state 0: no height easing and no back away
P2_8916:  CMPA #$00
P2_8918:  BEQ  P2_8940
P2_891A:  JSR  probot_height
P2_891D:  LDA  ,U                     ;bit $08: position is absolute, skip the closeness test
P2_891F:  BITA #$08
P2_8921:  BNE  P2_8940
P2_8923:  LDD  5,U                    ;size of x under $0200
P2_8925:  BPL  P2_892B
P2_8927:  COMA
P2_8928:  NEGB
P2_8929:  SBCA #$FF
P2_892B:  SUBD #$0200
P2_892E:  BCC  P2_8940
P2_8930:  LDD  7,U                    ;and size of y under $0200: too close to the player
P2_8932:  BPL  P2_8938
P2_8934:  COMA
P2_8935:  NEGB
P2_8936:  SBCA #$FF
P2_8938:  SUBD #$0200
P2_893B:  BCC  P2_8940
P2_893D:  JSR  probot_go_retreat      ;state 3: back away
P2_8940:  PULS X,PC

;------------------------------------------------------------------------------
; probot_height - eases the height of the probot at U (word at 9) a quarter of the way to $0200 plus eight times
;   its bob offset (word at 13)
;------------------------------------------------------------------------------
probot_height:
P2_8942:  LDD  13,U                   ;bob offset * 8
P2_8944:  JSR  LSLD3
P2_8947:  ADDD #$0200
P2_894A:  SUBD 9,U                    ;less the height, a quarter of the difference is added
P2_894C:  JSR  ASRD2
P2_894F:  ADDD 9,U
P2_8951:  STD  9,U
P2_8953:  RTS

;------------------------------------------------------------------------------
; probot_drift - moves the player-relative position of the probot at U (words at 5 and 7) against the player's
;   motion: the matrix processor's perspective multiply (MS_PERS) scales the player's speeds s1_vx and s1_vy by a
;   quarter of the sum of the sizes of the probot's x and y, and the products are subtracted from x and y. used by
;   the state handlers that keep the position relative to the player
;------------------------------------------------------------------------------
probot_drift:
P2_8954:  LDD  5,U                    ;size of x (ones complement)
P2_8956:  BPL  P2_895A
P2_8958:  COMA
P2_8959:  COMB
P2_895A:  STD  M_XP
P2_895D:  LDD  7,U
P2_895F:  BPL  P2_8963
P2_8961:  COMA
P2_8962:  COMB
P2_8963:  ADDD M_XP                   ;plus size of y, the sum divided by 4
P2_8966:  LSRA
P2_8967:  RORB
P2_8968:  LSRA
P2_8969:  RORB
P2_896A:  STD  M_XP
P2_896D:  LDD  s1_vx                  ;the player's speeds, to be multiplied by it
P2_8970:  STD  M_YP
P2_8973:  LDD  s1_vy
P2_8976:  STD  M_ZP
P2_8979:  LDA  #$86                   ;MS_PERS, perspective multiply
P2_897B:  JSR  MGOWT
P2_897E:  LDD  5,U                    ;x and y less the scaled player speed
P2_8980:  SUBD M_YP
P2_8983:  STD  5,U
P2_8985:  LDD  7,U
P2_8987:  SUBD M_ZP
P2_898A:  STD  7,U
P2_898C:  RTS

;------------------------------------------------------------------------------
; probot_goal_drift - as probot_drift, but the scaled player speeds are subtracted from the probot's goal
;   position (words at $15 and $17) and not from its own position. used by the go-to-goal states 6, 7 and 9
;------------------------------------------------------------------------------
probot_goal_drift:
P2_898D:  LDD  5,U                    ;size of x (ones complement)
P2_898F:  BPL  P2_8993
P2_8991:  COMA
P2_8992:  COMB
P2_8993:  STD  M_XP
P2_8996:  LDD  7,U
P2_8998:  BPL  P2_899C
P2_899A:  COMA
P2_899B:  COMB
P2_899C:  ADDD M_XP                   ;plus size of y, the sum divided by 4
P2_899F:  LSRA
P2_89A0:  RORB
P2_89A1:  LSRA
P2_89A2:  RORB
P2_89A3:  STD  M_XP
P2_89A6:  LDD  s1_vx
P2_89A9:  STD  M_YP
P2_89AC:  LDD  s1_vy
P2_89AF:  STD  M_ZP
P2_89B2:  LDA  #$86                   ;MS_PERS, perspective multiply
P2_89B4:  JSR  MGOWT
P2_89B7:  LDD  $15,U                  ;goal x and y less the scaled player speed
P2_89BA:  SUBD M_YP
P2_89BD:  STD  $15,U
P2_89C0:  LDD  $17,U
P2_89C3:  SUBD M_ZP
P2_89C6:  STD  $17,U
P2_89C9:  RTS

;------------------------------------------------------------------------------
; probot_set_hold - makes the position of the probot at U relative to the player (P2_8E54) and stores state 0,
;   hold still. nothing calls or points to it: dead code. the manual set-up stores state 0 itself
;------------------------------------------------------------------------------
probot_set_hold:
P2_89CA:  JSR  probot_pos_rel
P2_89CD:  LDA  #$00                   ;state 0
P2_89CF:  STA  4,U
P2_89D1:  RTS

;------------------------------------------------------------------------------
; probot_st_hold - state 0 handler: only makes the position relative to the player (P2_8E54), so the probot
;   stays where it is in front of him. the state of the training manual's demo probot, which probot_pick_state
;   never changes
;------------------------------------------------------------------------------
probot_st_hold:
P2_89D2:  JSR  probot_pos_rel
P2_89D5:  RTS

;------------------------------------------------------------------------------
; probot_set_drift - state start routine, entry 0 of the table at P2_888B: stores state 1 (drift) in byte 4 of
;   the record at U
;------------------------------------------------------------------------------
probot_set_drift:
P2_89D6:  LDA  #$01
P2_89D8:  STA  4,U
P2_89DA:  RTS

;------------------------------------------------------------------------------
; probot_st_drift - state 1 handler: makes the position relative to the player and drifts it against the
;   player's motion (probot_drift). when the probot is out of view it picks a new behaviour
;------------------------------------------------------------------------------
probot_st_drift:
P2_89DB:  JSR  probot_pos_rel
P2_89DE:  JSR  probot_drift
P2_89E1:  LDA  1,U                    ;in view: keep drifting
P2_89E3:  BITA #$10
P2_89E5:  BNE  P2_89EA
P2_89E7:  JSR  probot_pick_state
P2_89EA:  RTS

;------------------------------------------------------------------------------
; probot_set_fixed - state start routine, entry 3 of the table at P2_888B and entry 0 of the table at P2_889F,
;   also called by probot_setup for every record: stores state 4 (stay at a fixed place) in byte 4 of the record
;   at U
;------------------------------------------------------------------------------
probot_set_fixed:
P2_89EB:  LDA  #$04
P2_89ED:  STA  4,U
P2_89EF:  RTS

;------------------------------------------------------------------------------
; probot_st_fixed - state 4 handler: makes the position absolute (P2_8E6D adds the player's position once and
;   sets bit $08 of the type byte), so the probot stays at one place on the ground while the player moves. when it
;   is out of view it picks a new behaviour
;------------------------------------------------------------------------------
probot_st_fixed:
P2_89F0:  JSR  probot_pos_abs
P2_89F3:  LDA  1,U                    ;in view: stay
P2_89F5:  BITA #$10
P2_89F7:  BNE  P2_89FC
P2_89F9:  JSR  probot_pick_state
P2_89FC:  RTS

;------------------------------------------------------------------------------
; probot_set_close - state start routine, entry 1 of the table at P2_888B, also called by probot_spawn: stores
;   state 2 (close in on the player) in byte 4 of the record at U
;------------------------------------------------------------------------------
probot_set_close:
P2_89FD:  LDA  #$02
P2_89FF:  STA  4,U
P2_8A01:  RTS

;------------------------------------------------------------------------------
; probot_do_approach - per-frame handler of probot state 2 (entry 2 of the handler table P2_8873, also used for
;   a state number past 11): closes in on the player. U = the probot record. makes the position player-relative
;   (P2_8E54), and when both |x| and |y| are under $0300 picks a new behaviour (P2_88A7). otherwise applies
;   P2_8954 and moves x and y a sixteenth of the way towards zero
;------------------------------------------------------------------------------
probot_do_approach:
P2_8A02:  JSR  probot_pos_rel         ;position to player-relative if it was absolute
P2_8A05:  LDD  7,U                    ;|y|
P2_8A07:  BPL  P2_8A0D
P2_8A09:  COMA
P2_8A0A:  NEGB
P2_8A0B:  SBCA #$FF
P2_8A0D:  SUBD #$0300                 ;$0300 or more away on either axis: keep closing in
P2_8A10:  BCC  P2_8A22
P2_8A12:  LDD  5,U
P2_8A14:  BPL  P2_8A1A
P2_8A16:  COMA
P2_8A17:  NEGB
P2_8A18:  SBCA #$FF
P2_8A1A:  SUBD #$0300
P2_8A1D:  BCC  P2_8A22
P2_8A1F:  JMP  probot_pick_state      ;near the player on both axes: pick a new behaviour
P2_8A22:  JSR  probot_drift
P2_8A25:  LDD  #$0000                 ;x = x - x/16
P2_8A28:  SUBD 5,U
P2_8A2A:  JSR  ASRD4_B0
P2_8A2D:  ADDD 5,U
P2_8A2F:  STD  5,U
P2_8A31:  LDD  #$0000                 ;y = y - y/16
P2_8A34:  SUBD 7,U
P2_8A36:  JSR  ASRD4_B0
P2_8A39:  ADDD 7,U
P2_8A3B:  STD  7,U
P2_8A3D:  RTS

;------------------------------------------------------------------------------
; probot_go_retreat - puts the probot at U in state 3, moving away from the player, and pushes its x and y $10
;   further from zero so the handler's growth has something to work on. one of the ten entries P2_88A7 picks at
;   random (table P2_888B), and called by P2_88F0 when a probot in player-relative coordinates is within $0200 of
;   the player on both axes
;------------------------------------------------------------------------------
probot_go_retreat:
P2_8A3E:  LDA  #$03                   ;state 3: move away from the player
P2_8A40:  STA  4,U
P2_8A42:  LDD  5,U                    ;x $10 further from zero, whichever its sign
P2_8A44:  BPL  P2_8A4B
P2_8A46:  SUBD #$0010
P2_8A49:  BRA  P2_8A4E
P2_8A4B:  ADDD #$0010
P2_8A4E:  STD  5,U
P2_8A50:  LDD  7,U                    ;the same for y
P2_8A52:  BPL  P2_8A59
P2_8A54:  SUBD #$0010
P2_8A57:  BRA  P2_8A5C
P2_8A59:  ADDD #$0010
P2_8A5C:  STD  7,U
P2_8A5E:  RTS

;------------------------------------------------------------------------------
; probot_do_retreat - per-frame handler of probot state 3: moves away from the player. U = the probot record.
;   makes the position player-relative, then adds an eighth of x to x and an eighth of y to y. when |x| or |y| has
;   reached $4000, or an addition overflows, it picks a new behaviour (P2_88A7) instead
;------------------------------------------------------------------------------
probot_do_retreat:
P2_8A5F:  JSR  probot_pos_rel
P2_8A62:  LDD  7,U
P2_8A64:  BPL  P2_8A6A
P2_8A66:  COMA
P2_8A67:  NEGB
P2_8A68:  SBCA #$FF
P2_8A6A:  SUBD #$4000                 ;|y| $4000 or more: far enough, pick a new behaviour
P2_8A6D:  BCS  P2_8A72
P2_8A6F:  JMP  probot_pick_state
P2_8A72:  LDD  5,U
P2_8A74:  BPL  P2_8A7A
P2_8A76:  COMA
P2_8A77:  NEGB
P2_8A78:  SBCA #$FF
P2_8A7A:  SUBD #$4000                 ;the same limit for |x|
P2_8A7D:  BCS  P2_8A82
P2_8A7F:  JMP  probot_pick_state
P2_8A82:  LDD  5,U                    ;x = x + x/8
P2_8A84:  JSR  ASRD3
P2_8A87:  ADDD 5,U
P2_8A89:  BVS  P2_8A99                ;overflow: pick a new behaviour
P2_8A8B:  STD  5,U
P2_8A8D:  LDD  7,U                    ;y = y + y/8
P2_8A8F:  JSR  ASRD3
P2_8A92:  ADDD 7,U
P2_8A94:  BVS  P2_8A99
P2_8A96:  STD  7,U
P2_8A98:  RTS
P2_8A99:  JSR  probot_pick_state
P2_8A9C:  RTS

;------------------------------------------------------------------------------
; probot_go_leave - puts the probot at U in state 11, leaving the field, and pushes its x and y $10 further from
;   zero. not called directly: P2_88A7 loads its address and calls it through JSR ,X when w1_spawn is minus, which
;   the end of the wave sets
;------------------------------------------------------------------------------
probot_go_leave:
P2_8A9D:  LDA  #$0B                   ;state 11: leave the field
P2_8A9F:  STA  4,U
P2_8AA1:  LDD  5,U
P2_8AA3:  BPL  P2_8AAA
P2_8AA5:  SUBD #$0010
P2_8AA8:  BRA  P2_8AAD
P2_8AAA:  ADDD #$0010
P2_8AAD:  STD  5,U
P2_8AAF:  LDD  7,U
P2_8AB1:  BPL  P2_8AB8
P2_8AB3:  SUBD #$0010
P2_8AB6:  BRA  P2_8ABB
P2_8AB8:  ADDD #$0010
P2_8ABB:  STD  7,U
P2_8ABD:  RTS

;------------------------------------------------------------------------------
; probot_do_leave - per-frame handler of probot state 11: the probot flies off at the end of the wave. U = the
;   probot record. makes the position player-relative and adds an eighth of x and y to themselves each frame, as
;   the state 3 handler does. when |x| or |y| reaches $7800, or an addition overflows, it frees the record by
;   clearing bytes 0 and 1
;------------------------------------------------------------------------------
probot_do_leave:
P2_8ABE:  JSR  probot_pos_rel
P2_8AC1:  LDD  7,U
P2_8AC3:  BPL  P2_8AC9
P2_8AC5:  COMA
P2_8AC6:  NEGB
P2_8AC7:  SBCA #$FF
P2_8AC9:  SUBD #$7800                 ;|y| $7800 or more: gone
P2_8ACC:  BCS  P2_8AD5
P2_8ACE:  LDA  #$00                   ;free the record
P2_8AD0:  STA  ,U
P2_8AD2:  STA  1,U
P2_8AD4:  RTS
P2_8AD5:  LDD  5,U
P2_8AD7:  BPL  P2_8ADD
P2_8AD9:  COMA
P2_8ADA:  NEGB
P2_8ADB:  SBCA #$FF
P2_8ADD:  SUBD #$7800                 ;the same limit for |x|
P2_8AE0:  BCS  P2_8AE9
P2_8AE2:  LDA  #$00
P2_8AE4:  STA  ,U
P2_8AE6:  STA  1,U
P2_8AE8:  RTS
P2_8AE9:  LDD  5,U                    ;x = x + x/8
P2_8AEB:  JSR  ASRD3
P2_8AEE:  ADDD 5,U
P2_8AF0:  BVS  P2_8B00
P2_8AF2:  STD  5,U
P2_8AF4:  LDD  7,U                    ;y = y + y/8
P2_8AF6:  JSR  ASRD3
P2_8AF9:  ADDD 7,U
P2_8AFB:  BVS  P2_8B00
P2_8AFD:  STD  7,U
P2_8AFF:  RTS
P2_8B00:  LDA  #$00                   ;overflow: free the record
P2_8B02:  STA  ,U
P2_8B04:  STA  1,U
P2_8B06:  RTS

;------------------------------------------------------------------------------
; probot_go_drift - puts the probot at U in state 5 and gives it a random velocity in words $15 and $17 of the
;   record: two random words multiplied (matrix program MS_PERS) by twice the sum of the high bytes of |x| and
;   |y|, at least $0100, so a distant probot gets a larger one. one of the ten entries P2_88A7 picks at random
;------------------------------------------------------------------------------
probot_go_drift:
P2_8B07:  JSR  probot_pos_rel
P2_8B0A:  LDA  #$05                   ;state 5: drift
P2_8B0C:  STA  4,U
P2_8B0E:  LDD  >RND_S1                ;two random words, RND_S1/S2 and RND_S2/S3
P2_8B11:  STD  M_YP
P2_8B14:  LDD  >RND_S2
P2_8B17:  STD  M_ZP
P2_8B1A:  LDA  5,U                    ;high byte of |x| (one's complement when minus)
P2_8B1C:  BPL  P2_8B1F
P2_8B1E:  COMA
P2_8B1F:  STA  M_XP
P2_8B22:  LDA  7,U
P2_8B24:  BPL  P2_8B27
P2_8B26:  COMA
P2_8B27:  ADDA M_XP                   ;plus the high byte of |y|, times 2
P2_8B2A:  LDB  #$02
P2_8B2C:  MUL
P2_8B2D:  CMPD #$0100                 ;multiplier at least $0100
P2_8B31:  BHI  P2_8B36
P2_8B33:  LDD  #$0100
P2_8B36:  STD  M_XP
P2_8B39:  LDA  #$86                   ;random words times the multiplier
P2_8B3B:  JSR  MGOWT
P2_8B3E:  LDD  M_YP                   ;the products are the x and y velocity
P2_8B41:  STD  $15,U
P2_8B44:  LDD  M_ZP
P2_8B47:  STD  $17,U
P2_8B4A:  RTS

;------------------------------------------------------------------------------
; probot_do_drift - per-frame handler of probot state 5: moves by the velocity in words $15 and $17 of the
;   record. U = the probot record. while the probot is in view (bit $10 of byte 1) the velocity loses a thirty-
;   second each frame and P2_8954 is applied. then the velocity is added to x and y, and a velocity component that
;   points outwards while its coordinate is past +$4000 or -$4000 is negated, so the probot turns back
;------------------------------------------------------------------------------
probot_do_drift:
P2_8B4B:  JSR  probot_pos_rel
P2_8B4E:  LDA  1,U
P2_8B50:  BITA #$10                   ;bit $10 of byte 1: the probot is in view
P2_8B52:  BEQ  P2_8B75
P2_8B54:  LDD  #$0000                 ;in view: x velocity = x velocity - x velocity/32
P2_8B57:  SUBD $15,U
P2_8B5A:  JSR  ASRD5_B0
P2_8B5D:  ADDD $15,U
P2_8B60:  STD  $15,U
P2_8B63:  LDD  #$0000                 ;the same for the y velocity
P2_8B66:  SUBD $17,U
P2_8B69:  JSR  ASRD5_B0
P2_8B6C:  ADDD $17,U
P2_8B6F:  STD  $17,U
P2_8B72:  JSR  probot_drift
P2_8B75:  LDD  5,U                    ;x = x + x velocity
P2_8B77:  ADDD $15,U
P2_8B7A:  STD  5,U
P2_8B7C:  LDD  7,U                    ;y = y + y velocity
P2_8B7E:  ADDD $17,U
P2_8B81:  STD  7,U
P2_8B83:  LDD  5,U
P2_8B85:  CMPD #$4000                 ;x past +$4000 and still moving out: negate the x velocity
P2_8B89:  BLE  P2_8B99
P2_8B8B:  LDD  $15,U
P2_8B8E:  BMI  P2_8B97
P2_8B90:  COMA
P2_8B91:  NEGB
P2_8B92:  SBCA #$FF
P2_8B94:  STD  $15,U
P2_8B97:  BRA  P2_8BAB
P2_8B99:  CMPD #$C000                 ;x past -$4000 and still moving out: negate the x velocity
P2_8B9D:  BGE  P2_8BAB
P2_8B9F:  LDD  $15,U
P2_8BA2:  BPL  P2_8BAB
P2_8BA4:  COMA
P2_8BA5:  NEGB
P2_8BA6:  SBCA #$FF
P2_8BA8:  STD  $15,U
P2_8BAB:  LDD  7,U
P2_8BAD:  CMPD #$4000                 ;the same two tests for y and the y velocity
P2_8BB1:  BLE  P2_8BC1
P2_8BB3:  LDD  $17,U
P2_8BB6:  BMI  P2_8BBF
P2_8BB8:  COMA
P2_8BB9:  NEGB
P2_8BBA:  SBCA #$FF
P2_8BBC:  STD  $17,U
P2_8BBF:  BRA  P2_8BD3
P2_8BC1:  CMPD #$C000
P2_8BC5:  BGE  P2_8BD3
P2_8BC7:  LDD  $17,U
P2_8BCA:  BPL  P2_8BD3
P2_8BCC:  COMA
P2_8BCD:  NEGB
P2_8BCE:  SBCA #$FF
P2_8BD0:  STD  $17,U
P2_8BD3:  RTS

;------------------------------------------------------------------------------
; probot_go_point - puts the probot at U in state 6 and picks the point it flies to, kept player-relative in
;   words $15 and $17 of the record: on each axis a random distance of up to $1FE0 plus $0200 plus the player's
;   height s1_tz, with a random sign. one of the ten entries P2_88A7 picks at random. P2_8CD6 is the same code for
;   state 7
;------------------------------------------------------------------------------
probot_go_point:
P2_8BD4:  JSR  probot_pos_rel
P2_8BD7:  LDA  #$06                   ;state 6: fly to a point
P2_8BD9:  STA  4,U
P2_8BDB:  LDB  >RND_S1
P2_8BDE:  LDA  >RND_S2
P2_8BE1:  MUL                         ;high byte of RND_S1 * RND_S2, times $20: 0 to $1FE0
P2_8BE2:  LDB  #$20
P2_8BE4:  MUL
P2_8BE5:  ADDD #$0200
P2_8BE8:  ADDD s1_tz                  ;plus $0200 plus the player's height
P2_8BEB:  TST  >RND_S1                ;sign of RND_S1 decides the side
P2_8BEE:  BPL  P2_8BF4
P2_8BF0:  COMA                        ;NEGD
P2_8BF1:  NEGB
P2_8BF2:  SBCA #$FF
P2_8BF4:  STD  $15,U                  ;x of the point
P2_8BF7:  LDA  >RND_S3
P2_8BFA:  LDB  >rnd_s4
P2_8BFD:  MUL                         ;the same for y with RND_S3 and the fourth saved random byte
P2_8BFE:  LDB  #$20
P2_8C00:  MUL
P2_8C01:  ADDD #$0200
P2_8C04:  ADDD s1_tz
P2_8C07:  TST  >RND_S3
P2_8C0A:  BPL  P2_8C10
P2_8C0C:  COMA
P2_8C0D:  NEGB
P2_8C0E:  SBCA #$FF
P2_8C10:  STD  $17,U                  ;y of the point
P2_8C13:  RTS

;------------------------------------------------------------------------------
; probot_go_ahead - puts the probot at U in state 9 and picks the point it flies to: a scratch block point with
;   x a random distance ($0200 plus the player's height plus up to $1FE0), y a random part of that distance with a
;   random sign, and z 0 goes through matrix program $60, and the result less the player's position ($5098, s1_ty)
;   is stored in words $15 and $17 of the record. P2_88A7 calls it for a probot that is not in view and not
;   already in state 9, as one of its ten random entries, and by w1_level in the last $96 counts of the phase
;   timer
;------------------------------------------------------------------------------
probot_go_ahead:
P2_8C14:  JSR  probot_pos_rel
P2_8C17:  LDA  #$09                   ;state 9: fly to a point given through the matrix processor
P2_8C19:  STA  4,U
P2_8C1B:  LDB  >RND_S1
P2_8C1E:  LDA  >RND_S2
P2_8C21:  MUL                         ;high byte of RND_S1 * RND_S2, times $20: 0 to $1FE0
P2_8C22:  LDB  #$20
P2_8C24:  MUL
P2_8C25:  ADDD #$0200
P2_8C28:  ADDD s1_tz                  ;plus $0200 plus the player's height
P2_8C2B:  STD  M_X0                   ;scratch block x = that distance
P2_8C2E:  LDB  >RND_S3                ;its high byte times RND_S3: a random part of the distance
P2_8C31:  MUL
P2_8C32:  TST  >rnd_s4                ;sign from the fourth saved random byte
P2_8C35:  BPL  P2_8C3B
P2_8C37:  COMA
P2_8C38:  NEGB
P2_8C39:  SBCA #$FF
P2_8C3B:  STD  M_Y0                   ;scratch block y
P2_8C3E:  LDD  #$0000
P2_8C41:  STD  M_Z0                   ;scratch block z = 0
P2_8C44:  LDD  #MS_X0BC
P2_8C47:  STD  M_BIC
P2_8C4A:  LDA  #MS_S1UN               ;program $60 on the scratch block
P2_8C4C:  JSR  MGOWT
P2_8C4F:  LDD  M_XP                   ;result less the player's x and y: the point, player-relative
P2_8C52:  SUBD s1_tx
P2_8C55:  STD  $15,U
P2_8C58:  LDD  M_YP
P2_8C5B:  SUBD s1_ty
P2_8C5E:  STD  $17,U
P2_8C61:  RTS

;------------------------------------------------------------------------------
; probot_do_seek - per-frame handler of probot states 6 and 9: flies to the point in words $15 and $17 of the
;   record. U = the probot record. applies P2_898D to the point, then moves x and y by a sixteenth of the distance
;   left, a step that is halved until it is within +-$0400. when the probot is within $0200 of the point on both
;   axes it picks a new behaviour (P2_88A7)
;------------------------------------------------------------------------------
probot_do_seek:
P2_8C62:  JSR  probot_pos_rel
P2_8C65:  JSR  probot_goal_drift      ;P2_8954 for the point in words $15 and $17
P2_8C68:  LDD  $15,U                  ;x step = (point x - x) / 16
P2_8C6B:  SUBD 5,U
P2_8C6D:  JSR  ASRD4_B0
P2_8C70:  TSTA
P2_8C71:  BMI  P2_8C7F
P2_8C73:  CMPD #$0400                 ;halve a positive step until it is $0400 or less
P2_8C77:  BLE  P2_8C7D
P2_8C79:  ASRA
P2_8C7A:  RORB
P2_8C7B:  BRA  P2_8C73
P2_8C7D:  BRA  P2_8C89
P2_8C7F:  CMPD #$FC00                 ;halve a negative step until it is -$0400 or more
P2_8C83:  BGE  P2_8C89
P2_8C85:  ASRA
P2_8C86:  RORB
P2_8C87:  BRA  P2_8C7F
P2_8C89:  ADDD 5,U                    ;x = x + step
P2_8C8B:  STD  5,U
P2_8C8D:  LDD  $17,U                  ;y step = (point y - y) / 16, limited the same way
P2_8C90:  SUBD 7,U
P2_8C92:  JSR  ASRD4_B0
P2_8C95:  TSTA
P2_8C96:  BMI  P2_8CA4
P2_8C98:  CMPD #$0400
P2_8C9C:  BLE  P2_8CA2
P2_8C9E:  ASRA
P2_8C9F:  RORB
P2_8CA0:  BRA  P2_8C98
P2_8CA2:  BRA  P2_8CAE
P2_8CA4:  CMPD #$FC00
P2_8CA8:  BGE  P2_8CAE
P2_8CAA:  ASRA
P2_8CAB:  RORB
P2_8CAC:  BRA  P2_8CA4
P2_8CAE:  ADDD 7,U                    ;y = y + step
P2_8CB0:  STD  7,U
P2_8CB2:  LDD  5,U                    ;|x - point x|
P2_8CB4:  SUBD $15,U
P2_8CB7:  BPL  P2_8CBD
P2_8CB9:  COMA
P2_8CBA:  NEGB
P2_8CBB:  SBCA #$FF
P2_8CBD:  SUBD #$0200
P2_8CC0:  BHI  P2_8CD5                ;more than $0200 from the point: carry on
P2_8CC2:  LDD  7,U                    ;|y - point y|
P2_8CC4:  SUBD $17,U
P2_8CC7:  BPL  P2_8CCD
P2_8CC9:  COMA
P2_8CCA:  NEGB
P2_8CCB:  SBCA #$FF
P2_8CCD:  SUBD #$0200
P2_8CD0:  BHI  P2_8CD5
P2_8CD2:  JSR  probot_pick_state      ;at the point: pick a new behaviour
P2_8CD5:  RTS

;------------------------------------------------------------------------------
; probot_go_point2 - puts the probot at U in state 7 and picks the point it flies to, in words $15 and $17 of
;   the record. the same code as P2_8BD4 but for the state number: a random distance of up to $1FE0 plus $0200
;   plus the player's height on each axis, with a random sign. one of the ten entries P2_88A7 picks at random
;------------------------------------------------------------------------------
probot_go_point2:
P2_8CD6:  JSR  probot_pos_rel
P2_8CD9:  LDA  #$07                   ;state 7: fly to a point, the same pick as state 6
P2_8CDB:  STA  4,U
P2_8CDD:  LDB  >RND_S1
P2_8CE0:  LDA  >RND_S2
P2_8CE3:  MUL
P2_8CE4:  LDB  #$20
P2_8CE6:  MUL
P2_8CE7:  ADDD #$0200
P2_8CEA:  ADDD s1_tz
P2_8CED:  TST  >RND_S1
P2_8CF0:  BPL  P2_8CF6
P2_8CF2:  COMA
P2_8CF3:  NEGB
P2_8CF4:  SBCA #$FF
P2_8CF6:  STD  $15,U                  ;x of the point
P2_8CF9:  LDA  >RND_S3
P2_8CFC:  LDB  >rnd_s4
P2_8CFF:  MUL
P2_8D00:  LDB  #$20
P2_8D02:  MUL
P2_8D03:  ADDD #$0200
P2_8D06:  ADDD s1_tz
P2_8D09:  TST  >RND_S3
P2_8D0C:  BPL  P2_8D12
P2_8D0E:  COMA
P2_8D0F:  NEGB
P2_8D10:  SBCA #$FF
P2_8D12:  STD  $17,U                  ;y of the point
P2_8D15:  RTS

;------------------------------------------------------------------------------
; probot_do_seek2 - per-frame handler of probot state 7: flies to the point in words $15 and $17 of the record.
;   the same as the handler of states 6 and 9 (P2_8C62) except that a step past +-$0400 is cut to $0400 or -$0400
;   and not halved. when the probot is within $0200 of the point on both axes it picks a new behaviour (P2_88A7)
;------------------------------------------------------------------------------
probot_do_seek2:
P2_8D16:  JSR  probot_pos_rel
P2_8D19:  JSR  probot_goal_drift
P2_8D1C:  LDD  $15,U                  ;x step = (point x - x) / 16
P2_8D1F:  SUBD 5,U
P2_8D21:  JSR  ASRD4_B0
P2_8D24:  TSTA
P2_8D25:  BMI  P2_8D32
P2_8D27:  CMPD #$0400                 ;cut to +-$0400
P2_8D2B:  BLE  P2_8D30
P2_8D2D:  LDD  #$0400
P2_8D30:  BRA  P2_8D3B
P2_8D32:  CMPD #$FC00
P2_8D36:  BGE  P2_8D3B
P2_8D38:  LDD  #$FC00
P2_8D3B:  ADDD 5,U                    ;x = x + step
P2_8D3D:  STD  5,U
P2_8D3F:  LDD  $17,U                  ;y step = (point y - y) / 16, cut the same way
P2_8D42:  SUBD 7,U
P2_8D44:  JSR  ASRD4_B0
P2_8D47:  TSTA
P2_8D48:  BMI  P2_8D55
P2_8D4A:  CMPD #$0400
P2_8D4E:  BLE  P2_8D53
P2_8D50:  LDD  #$0400
P2_8D53:  BRA  P2_8D5E
P2_8D55:  CMPD #$FC00
P2_8D59:  BGE  P2_8D5E
P2_8D5B:  LDD  #$FC00
P2_8D5E:  ADDD 7,U                    ;y = y + step
P2_8D60:  STD  7,U
P2_8D62:  LDD  5,U
P2_8D64:  SUBD $15,U
P2_8D67:  BPL  P2_8D6D
P2_8D69:  COMA
P2_8D6A:  NEGB
P2_8D6B:  SBCA #$FF
P2_8D6D:  SUBD #$0200
P2_8D70:  BHI  P2_8D85                ;more than $0200 from the point: carry on
P2_8D72:  LDD  7,U
P2_8D74:  SUBD $17,U
P2_8D77:  BPL  P2_8D7D
P2_8D79:  COMA
P2_8D7A:  NEGB
P2_8D7B:  SBCA #$FF
P2_8D7D:  SUBD #$0200
P2_8D80:  BHI  P2_8D85
P2_8D82:  JSR  probot_pick_state      ;at the point: pick a new behaviour
P2_8D85:  RTS

;------------------------------------------------------------------------------
; probot_go_circle - puts the probot at U in state 8 and stores a random turn rate in word $15 of the record:
;   $0100 to $03FD, positive or negative by the sign of RND_S3. one of the ten entries P2_88A7 picks at random,
;   and one of the four it picks by w1_level in the last $96 counts of the phase timer
;------------------------------------------------------------------------------
probot_go_circle:
P2_8D86:  JSR  probot_pos_rel
P2_8D89:  LDA  #$08                   ;state 8: circle the player
P2_8D8B:  STA  4,U
P2_8D8D:  LDA  >RND_S1                ;RND_S1 * 3: 0 to $02FD
P2_8D90:  LDB  #$03
P2_8D92:  MUL
P2_8D93:  TST  >RND_S3                ;sign of RND_S3 decides the direction
P2_8D96:  BPL  P2_8D9D
P2_8D98:  ADDD #$0100                 ;plus $0100
P2_8D9B:  BRA  P2_8DA4
P2_8D9D:  COMA                        ;or negated, minus $0100
P2_8D9E:  NEGB
P2_8D9F:  SBCA #$FF
P2_8DA1:  SUBD #$0100
P2_8DA4:  STD  $15,U                  ;turn rate
P2_8DA7:  RTS

;------------------------------------------------------------------------------
; probot_do_circle - per-frame handler of probot state 8: circles the player. U = the probot record. applies
;   P2_8954, then multiplies x and y by the turn rate in word $15 of the record (matrix program MS_PERS) and takes
;   the y product off x and adds the x product to y, a small rotation of the player-relative position about the
;   player. it never picks a new behaviour itself: P2_88F0 does that at random
;------------------------------------------------------------------------------
probot_do_circle:
P2_8DA8:  JSR  probot_pos_rel
P2_8DAB:  JSR  probot_drift
P2_8DAE:  LDD  $15,U                  ;multiplier = the turn rate
P2_8DB1:  STD  M_XP
P2_8DB4:  LDD  5,U
P2_8DB6:  STD  M_YP
P2_8DB9:  LDD  7,U
P2_8DBB:  STD  M_ZP
P2_8DBE:  LDA  #$86                   ;x * rate and y * rate
P2_8DC0:  JSR  MGOWT
P2_8DC3:  LDD  5,U                    ;x = x - y * rate
P2_8DC5:  SUBD M_ZP
P2_8DC8:  STD  5,U
P2_8DCA:  LDD  7,U                    ;y = y + x * rate
P2_8DCC:  ADDD M_YP
P2_8DCF:  STD  7,U
P2_8DD1:  RTS

;------------------------------------------------------------------------------
; probot_go_orbit - puts the probot at U in state 10 and picks the point its handler (P2_8E1D) turns it around,
;   in words $15 and $17 of the record: $0400 to one side of the probot on one axis, side and axis random, and a
;   random -$0400 to +$03F8 from it on the other axis. one of the ten entries P2_88A7 picks at random, and one of
;   the four it picks by w1_level in the last $96 counts of the phase timer
;------------------------------------------------------------------------------
probot_go_orbit:
P2_8DD2:  JSR  probot_pos_rel
P2_8DD5:  LDA  #$0A                   ;state 10: turn around a point near the probot
P2_8DD7:  STA  4,U
P2_8DD9:  LDD  #$0400                 ;$0400: distance of the point
P2_8DDC:  STD  M_XP
P2_8DDF:  LDD  M_XP
P2_8DE2:  TST  >RND_S1                ;sign of RND_S1 decides the side
P2_8DE5:  BPL  P2_8DEB
P2_8DE7:  COMA
P2_8DE8:  NEGB
P2_8DE9:  SBCA #$FF
P2_8DEB:  TST  >RND_S2                ;sign of RND_S2 decides the axis
P2_8DEE:  BPL  P2_8E07
P2_8DF0:  ADDD 5,U                    ;point x = x +- $0400
P2_8DF2:  STD  $15,U
P2_8DF5:  LDA  M_XP                   ;8 * RND_S3 - $0400: -$0400 to +$03F8
P2_8DF8:  ASLA
P2_8DF9:  LDB  >RND_S3
P2_8DFC:  MUL
P2_8DFD:  SUBD M_XP
P2_8E00:  ADDD 7,U                    ;point y = y + that
P2_8E02:  STD  $17,U
P2_8E05:  BRA  P2_8E1C
P2_8E07:  ADDD 7,U                    ;point y = y +- $0400
P2_8E09:  STD  $17,U
P2_8E0C:  LDA  M_XP                   ;8 * RND_S3 - $0400: -$0400 to +$03F8
P2_8E0F:  ASLA
P2_8E10:  LDB  >RND_S3
P2_8E13:  MUL
P2_8E14:  SUBD M_XP
P2_8E17:  ADDD 5,U                    ;point x = x + that
P2_8E19:  STD  $15,U
P2_8E1C:  RTS

;------------------------------------------------------------------------------
; probot_do_orbit - per-frame handler of probot state 10 (entry 10 of the handler table P2_8873): turns the
;   probot around the point in words $15 and $17 of its record, which P2_8DD2 picked. U = the probot record. makes
;   the position player-relative, multiplies the offset from the point by $0800 or -$0800 (matrix program
;   MS_PERS), the sign taken from the head angle (byte $10), and takes the y product off x and adds the x product
;   to y, a small rotation about the point. it never picks a new behaviour itself
;------------------------------------------------------------------------------
probot_do_orbit:
P2_8E1D:  JSR  probot_pos_rel
P2_8E20:  LDA  $10,U                  ;sign of the head angle decides the direction of the turn
P2_8E23:  BMI  P2_8E2A
P2_8E25:  LDD  #$0800                 ;multiplier $0800 or -$0800
P2_8E28:  BRA  P2_8E2D
P2_8E2A:  LDD  #$F800
P2_8E2D:  STD  M_XP
P2_8E30:  LDD  5,U                    ;x and y offset from the point in words $15 and $17
P2_8E32:  SUBD $15,U
P2_8E35:  STD  M_YP
P2_8E38:  LDD  7,U
P2_8E3A:  SUBD $17,U
P2_8E3D:  STD  M_ZP
P2_8E40:  LDA  #$86                   ;MS_PERS: both offsets times the multiplier
P2_8E42:  JSR  MGOWT
P2_8E45:  LDD  5,U                    ;x = x - y offset * rate
P2_8E47:  SUBD M_ZP
P2_8E4A:  STD  5,U
P2_8E4C:  LDD  7,U                    ;y = y + x offset * rate
P2_8E4E:  ADDD M_YP
P2_8E51:  STD  7,U
P2_8E53:  RTS

;------------------------------------------------------------------------------
; probot_pos_rel - makes the position of the probot at U player-relative: when bit $08 of byte 0 is set it
;   clears the bit and takes the player's position (s1_tx, s1_ty) off the x and y words at 5 and 7. does nothing
;   when the position is relative already. called first by nearly every state routine
;------------------------------------------------------------------------------
probot_pos_rel:
P2_8E54:  LDA  ,U
P2_8E56:  BITA #$08                   ;bit $08: the position is in universe coordinates
P2_8E58:  BEQ  P2_8E6C
P2_8E5A:  ANDA #$F7
P2_8E5C:  STA  ,U
P2_8E5E:  LDD  5,U                    ;x and y less the player's position
P2_8E60:  SUBD s1_tx
P2_8E63:  STD  5,U
P2_8E65:  LDD  7,U
P2_8E67:  SUBD s1_ty
P2_8E6A:  STD  7,U
P2_8E6C:  RTS

;------------------------------------------------------------------------------
; probot_pos_abs - the reverse of P2_8E54: when bit $08 of byte 0 of the record at U is clear it sets the bit
;   and adds the player's position (s1_tx, s1_ty) to the x and y words at 5 and 7, so the probot holds a place in
;   the universe. called by the fixed place state (P2_89F0) and when a probot is shot down
;------------------------------------------------------------------------------
probot_pos_abs:
P2_8E6D:  LDA  ,U
P2_8E6F:  BITA #$08                   ;bit $08 set: absolute already
P2_8E71:  BNE  P2_8E85
P2_8E73:  ORA  #$08
P2_8E75:  STA  ,U
P2_8E77:  LDD  s1_tx                  ;x and y plus the player's position
P2_8E7A:  ADDD 5,U
P2_8E7C:  STD  5,U
P2_8E7E:  LDD  s1_ty
P2_8E81:  ADDD 7,U
P2_8E83:  STD  7,U
P2_8E85:  RTS

;------------------------------------------------------------------------------
; probot_legs_anim - animates the legs of the probots by moving the points of objects 9-$10 in math RAM, from
;   w1_anim_pts to w1_anim_end: eight legs of four 8-byte points, whose spare bytes 6 and 7 serve as a timer and a
;   mode. for each leg, bytes 6 and 7 of point 0 count a random time of up to $70 calls and hold a random mode: 0
;   moves points 1, 2 and 3, $01 moves points 2 and 3, $80 or $81 moves point 3 alone. the first point moved has
;   its own timer (up to $3F calls) and a random direction 0-7 that picks the move routine from the table at
;   P2_8F1F, and the same routine is run for every point moved. point 0, the root at the body, never moves. called
;   by P2_877C once for every live probot in a frame, and all probots draw the same points. X and U are preserved
;------------------------------------------------------------------------------
probot_legs_anim:
P2_8E86:  PSHS X,U
P2_8E88:  LDX  w1_anim_pts            ;first point of object 9 in math RAM
P2_8E8B:  DEC  6,X                    ;byte 6 of the leg's point 0: time left in the current mode
P2_8E8D:  BGT  P2_8E9E
P2_8E8F:  JSR  rnd_set                ;run out: a new time of 0-$70 and a new mode of $00, $01, $80 or $81
P2_8E92:  LDA  >RND_S1
P2_8E95:  ANDA #$70
P2_8E97:  LDB  >RND_S2
P2_8E9A:  ANDB #$81
P2_8E9C:  STD  6,X
P2_8E9E:  LDB  7,X                    ;mode 0: move points 1-3. $01: points 2 and 3. minus: point 3 alone
P2_8EA0:  BEQ  P2_8EC5
P2_8EA2:  BGT  P2_8EEF
P2_8EA4:  LEAX $18,X                  ;point 3, the tip
P2_8EA7:  DEC  6,X                    ;the point's own timer
P2_8EA9:  BGT  P2_8EBA
P2_8EAB:  JSR  rnd_set                ;run out: a new time of 0-$3F and a new direction
P2_8EAE:  LDA  >RND_S1
P2_8EB1:  ANDA #$3F
P2_8EB3:  LDB  >RND_S2
P2_8EB6:  ANDB #$0E
P2_8EB8:  STD  6,X
P2_8EBA:  LDB  7,X                    ;direction 0-7 as a word index
P2_8EBC:  ANDB #$0E
P2_8EBE:  LDU  #leg_move_tab
P2_8EC1:  JSR  [B,U]                  ;move the tip
P2_8EC3:  BRA  P2_8F14
P2_8EC5:  LEAX 8,X                    ;point 1
P2_8EC7:  DEC  6,X
P2_8EC9:  BGT  P2_8EDA
P2_8ECB:  JSR  rnd_set
P2_8ECE:  LDA  >RND_S1
P2_8ED1:  ANDA #$3F
P2_8ED3:  LDB  >RND_S2
P2_8ED6:  ANDB #$0E
P2_8ED8:  STD  6,X
P2_8EDA:  LDB  7,X                    ;direction from point 1
P2_8EDC:  ANDB #$0E
P2_8EDE:  LDU  #leg_move_tab
P2_8EE1:  LDU  B,U
P2_8EE3:  JSR  ,U                     ;the same move for points 1, 2 and 3
P2_8EE5:  LEAX 8,X
P2_8EE7:  JSR  ,U
P2_8EE9:  LEAX 8,X
P2_8EEB:  JSR  ,U
P2_8EED:  BRA  P2_8F14
P2_8EEF:  LEAX $10,X                  ;point 2
P2_8EF2:  DEC  6,X
P2_8EF4:  BGT  P2_8F05
P2_8EF6:  JSR  rnd_set
P2_8EF9:  LDA  >RND_S1
P2_8EFC:  ANDA #$3F
P2_8EFE:  LDB  >RND_S2
P2_8F01:  ANDB #$0E
P2_8F03:  STD  6,X
P2_8F05:  LDB  7,X                    ;direction from point 2
P2_8F07:  ANDB #$0E
P2_8F09:  LDU  #leg_move_tab
P2_8F0C:  LDU  B,U
P2_8F0E:  JSR  ,U                     ;the same move for points 2 and 3
P2_8F10:  LEAX 8,X
P2_8F12:  JSR  ,U
P2_8F14:  LEAX 8,X                    ;first point of the next leg
P2_8F16:  CMPX w1_anim_end            ;until the end of object $10's points
P2_8F19:  LBCS P2_8E8B
P2_8F1D:  PULS X,U,PC

leg_move_tab:
P2_8F1F:  .word leg_pt_x_up           ;leg point moves by direction 0-7: x up, y up, x and y up, y up and x down, x down, y down, x and y down, y down and x up. direction + 4 is the opposite
P2_8F21:  .word leg_pt_y_up
P2_8F23:  .word leg_pt_xy_up
P2_8F25:  .word leg_pt_yup_xdn
P2_8F27:  .word leg_pt_x_dn
P2_8F29:  .word leg_pt_y_dn
P2_8F2B:  .word leg_pt_xy_dn
P2_8F2D:  .word leg_pt_ydn_xup

;------------------------------------------------------------------------------
; leg_pt_ydn_xup - leg point move 7 of the table at P2_8F1F: y one step down (P2_8F7C), then falls into P2_8F31
;   for x one step up. X = the point
;------------------------------------------------------------------------------
leg_pt_ydn_xup:
P2_8F2F:  BSR  leg_pt_y_dn

;------------------------------------------------------------------------------
; leg_pt_x_up - leg point move 0 of the table at P2_8F1F: raises by 1 the x offset of the point at X from the
;   point before it (8 bytes back) and stores x again as the previous point's x plus the offset, so a point
;   follows the one before it. an offset that passes $20 is held at $20 and the direction is reversed (P2_8F93)
;------------------------------------------------------------------------------
leg_pt_x_up:
P2_8F31:  LDD  ,X                     ;x offset from the previous point, plus 1
P2_8F33:  SUBD -8,X
P2_8F35:  ADDD #$0001
P2_8F38:  CMPD #$0020                 ;past $20: hold it there and reverse
P2_8F3C:  BLE  P2_8F43
P2_8F3E:  BSR  leg_pt_reverse
P2_8F40:  LDD  #$0020
P2_8F43:  ADDD -8,X                   ;x = previous point's x + offset
P2_8F45:  STD  ,X
P2_8F47:  RTS

;------------------------------------------------------------------------------
; leg_pt_xy_up - leg point move 2 of the table at P2_8F1F: x one step up (P2_8F31), then falls into P2_8F4A for
;   y one step up. X = the point
;------------------------------------------------------------------------------
leg_pt_xy_up:
P2_8F48:  BSR  leg_pt_x_up

;------------------------------------------------------------------------------
; leg_pt_y_up - leg point move 1 of the table at P2_8F1F: as P2_8F31 for the y word of the point at X (offset
;   2), its offset from the previous point's y raised by 1 and held at $20
;------------------------------------------------------------------------------
leg_pt_y_up:
P2_8F4A:  LDD  2,X                    ;y offset from the previous point, plus 1
P2_8F4C:  SUBD -6,X
P2_8F4E:  ADDD #$0001
P2_8F51:  CMPD #$0020
P2_8F55:  BLE  P2_8F5C
P2_8F57:  BSR  leg_pt_reverse
P2_8F59:  LDD  #$0020
P2_8F5C:  ADDD -6,X
P2_8F5E:  STD  2,X
P2_8F60:  RTS

;------------------------------------------------------------------------------
; leg_pt_yup_xdn - leg point move 3 of the table at P2_8F1F: y one step up (P2_8F4A), then falls into P2_8F63
;   for x one step down. X = the point
;------------------------------------------------------------------------------
leg_pt_yup_xdn:
P2_8F61:  BSR  leg_pt_y_up

;------------------------------------------------------------------------------
; leg_pt_x_dn - leg point move 4 of the table at P2_8F1F: lowers by 1 the x offset of the point at X from the
;   point before it and stores x as the previous point's x plus the offset. an offset below -$20 is held at -$20
;   and the direction is reversed (P2_8F93)
;------------------------------------------------------------------------------
leg_pt_x_dn:
P2_8F63:  LDD  ,X                     ;x offset from the previous point, minus 1
P2_8F65:  SUBD -8,X
P2_8F67:  SUBD #$0001
P2_8F6A:  CMPD #$FFE0                 ;below -$20: hold it there and reverse
P2_8F6E:  BGE  P2_8F75
P2_8F70:  BSR  leg_pt_reverse
P2_8F72:  LDD  #$FFE0
P2_8F75:  ADDD -8,X
P2_8F77:  STD  ,X
P2_8F79:  RTS

;------------------------------------------------------------------------------
; leg_pt_xy_dn - leg point move 6 of the table at P2_8F1F: x one step down (P2_8F63), then falls into P2_8F7C
;   for y one step down. X = the point
;------------------------------------------------------------------------------
leg_pt_xy_dn:
P2_8F7A:  BSR  leg_pt_x_dn

;------------------------------------------------------------------------------
; leg_pt_y_dn - leg point move 5 of the table at P2_8F1F: as P2_8F63 for the y word of the point at X (offset
;   2), its offset from the previous point's y lowered by 1 and held at -$20
;------------------------------------------------------------------------------
leg_pt_y_dn:
P2_8F7C:  LDD  2,X                    ;y offset from the previous point, minus 1
P2_8F7E:  SUBD -6,X
P2_8F80:  SUBD #$0001
P2_8F83:  CMPD #$FFE0
P2_8F87:  BGE  P2_8F8E
P2_8F89:  BSR  leg_pt_reverse
P2_8F8B:  LDD  #$FFE0
P2_8F8E:  ADDD -6,X
P2_8F90:  STD  2,X
P2_8F92:  RTS

;------------------------------------------------------------------------------
; leg_pt_reverse - flips bit 3 of byte 7 of the point at X, which turns each of the eight move directions into
;   its opposite (0 and 4, 1 and 5, 2 and 6, 3 and 7). called by a move routine when the point's offset reaches
;   its limit. the byte is that of the point being moved, so for the second and third point of a run it is not the
;   byte the direction was read from
;------------------------------------------------------------------------------
leg_pt_reverse:
P2_8F93:  LDA  7,X
P2_8F95:  EORA #$08
P2_8F97:  STA  7,X
P2_8F99:  RTS

;------------------------------------------------------------------------------
; probot_timers - counts down the two timers of the probot at U, each until it is 0: byte 3, the time to the
;   next shot, and byte $14, the time to the next transmission. called by P2_877C every frame for every live
;   probot. the frame counter is masked with 0 before each count, so both count every frame
;------------------------------------------------------------------------------
probot_timers:
P2_8F9A:  LDA  >FRAMEL
P2_8F9D:  ANDA #$00                   ;mask 0: the branch is never taken, the timer counts every frame
P2_8F9F:  BNE  P2_8FA7
P2_8FA1:  LDA  3,U                    ;shot timer
P2_8FA3:  BEQ  P2_8FA7
P2_8FA5:  DEC  3,U
P2_8FA7:  LDA  >FRAMEL
P2_8FAA:  ANDA #$00
P2_8FAC:  BNE  P2_8FB6
P2_8FAE:  LDA  $14,U                  ;transmission timer
P2_8FB1:  BEQ  P2_8FB6
P2_8FB3:  DEC  $14,U
P2_8FB6:  RTS

;------------------------------------------------------------------------------
; probots_view - view of the wave 1 probots, called from bank 0 through maze entry MZ_8196 by vew_probot,
;   vew_probot_end, vew_probot_die and the training manual's man_view_probot. for each of the five $1A-byte
;   records from ALIEN up to xmit_atst it sets S2_PRM to the record, clears the per-frame flags in byte 1 and,
;   when the record is live, views the probot (P2_8FD3). Y = the display list
;------------------------------------------------------------------------------
probots_view:
P2_8FB7:  LDU  #ALIEN
P2_8FBA:  STU  S2_PRM
P2_8FBC:  LDA  1,U                    ;clear the in view and lined up flags of the last frame
P2_8FBE:  ANDA #$00
P2_8FC0:  STA  1,U
P2_8FC2:  LDA  ,U                     ;0 = free record
P2_8FC4:  BEQ  P2_8FC9
P2_8FC6:  JSR  probot_view
P2_8FC9:  LEAU $1A,U                  ;next of the five $1A-byte records
P2_8FCC:  CMPU #xmit_atst
P2_8FD0:  BCS  P2_8FBA
P2_8FD2:  RTS

;------------------------------------------------------------------------------
; probot_view - views the probot at U. its position (words 5, 7 and the height at 9, with the player's position
;   added when it is held player-relative) goes through matrix program MS_PSB2 into the player's view, and the
;   result is kept in M_XT, M_YT, M_ZT. the probot is left out when its depth is $0100 or less or $3C00 or more,
;   or when it is outside the 45 degree pyramid on either side or up and down. otherwise bit $10 of byte 1 is set
;   (in view), bit $80 is set when it is near enough to the middle of the screen from side to side, the test that
;   allows a transmission, and the body, the colour of the head and the head are drawn (P2_909A, P2_9080, P2_90FD)
;------------------------------------------------------------------------------
probot_view:
P2_8FD3:  LDA  ,U
P2_8FD5:  ANDA #$08                   ;bit $08: the position is in universe coordinates
P2_8FD7:  BEQ  P2_8FE5
P2_8FD9:  LDD  5,U
P2_8FDB:  STD  M_X0
P2_8FDE:  LDD  7,U
P2_8FE0:  STD  M_Y0
P2_8FE3:  BRA  P2_8FF5
P2_8FE5:  LDD  5,U                    ;player-relative: add the player's position
P2_8FE7:  ADDD s1_tx
P2_8FEA:  STD  M_X0
P2_8FED:  LDD  7,U
P2_8FEF:  ADDD s1_ty
P2_8FF2:  STD  M_Y0
P2_8FF5:  LDD  9,U
P2_8FF7:  STD  M_Z0                   ;the probot's height
P2_8FFA:  LDD  #MS_X0BC
P2_8FFD:  STD  M_BIC
P2_9000:  LDA  #MS_PSB2               ;into the player's view: M_XP depth, M_YP left/right, M_ZP up/down
P2_9002:  JSR  MGOWT
P2_9005:  LDD  M_XP
P2_9008:  STD  M_XT
P2_900B:  CMPD #$0100                 ;depth $0100 or less: too near or behind
P2_900F:  BLE  P2_907F
P2_9011:  CMPD #$3C00                 ;depth $3C00 or more: too far
P2_9015:  BCC  P2_907F
P2_9017:  LDD  M_YP
P2_901A:  STD  M_YT
P2_901D:  BPL  P2_9023                ;IFMI
P2_901F:  COMA                        ;NEGD
P2_9020:  NEGB
P2_9021:  SBCA #$FF
P2_9023:  SUBD M_XP                   ;left/right distance not less than the depth: off the screen
P2_9026:  BCC  P2_907F
P2_9028:  LDD  M_ZP
P2_902B:  STD  M_ZT
P2_902E:  BPL  P2_9034                ;IFMI
P2_9030:  COMA                        ;NEGD
P2_9031:  NEGB
P2_9032:  SBCA #$FF
P2_9034:  SUBD M_XP                   ;up/down distance not less than the depth: off the screen
P2_9037:  BCC  P2_907F
P2_9039:  LDA  1,U                    ;bit $10: in view this frame
P2_903B:  ORA  #$10
P2_903D:  STA  1,U
P2_903F:  LDD  PH_TIM                 ;factor for the lined up test: $80 with 300 or more on the phase timer, $C0 with 150 or more
P2_9042:  CMPD #$012C
P2_9046:  BCS  P2_904C
P2_9048:  LDB  #$80
P2_904A:  BRA  P2_9063
P2_904C:  CMPD #$0096
P2_9050:  BCS  P2_9056
P2_9052:  LDB  #$C0
P2_9054:  BRA  P2_9063
P2_9056:  LDA  w1_level               ;under 150: $C0 from level 2 up, $FF below
P2_9059:  CMPA #$02
P2_905B:  BLT  P2_9061
P2_905D:  LDB  #$C0
P2_905F:  BRA  P2_9063
P2_9061:  LDB  #$FF
P2_9063:  LDA  M_YP                   ;high byte of the left/right distance, doubled, times the factor
P2_9066:  BPL  P2_9069
P2_9068:  COMA
P2_9069:  ASLA
P2_906A:  MUL
P2_906B:  CMPA M_XP                   ;less than the depth: the probot is near the middle from side to side
P2_906E:  BCC  P2_9076
P2_9070:  LDA  1,U                    ;bit $80: lined up, it may transmit
P2_9072:  ORA  #$80
P2_9074:  STA  1,U
P2_9076:  JSR  probot_draw_body
P2_9079:  JSR  probot_xmit_col
P2_907C:  JSR  probot_draw_head
P2_907F:  RTS

;------------------------------------------------------------------------------
; probot_xmit_col - writes the colour word $67C0 to the display list ahead of the head when the probot at U is
;   about to transmit: transmission timer (byte $14) under 4, prog_count under 4 and bit $04 of byte 0 set.
;   otherwise the head is drawn in the colour of the body
;------------------------------------------------------------------------------
probot_xmit_col:
P2_9080:  LDA  $14,U                  ;transmission timer
P2_9083:  CMPA #$04                   ;4 or more: not yet
P2_9085:  BCC  P2_9099
P2_9087:  LDA  prog_count
P2_908A:  CMPA #$04
P2_908C:  BGE  P2_9099
P2_908E:  LDA  ,U                     ;bit $04: this probot transmits
P2_9090:  BITA #$04
P2_9092:  BEQ  P2_9099
P2_9094:  LDD  #$67C0
P2_9097:  STD  ,Y++
P2_9099:  RTS

;------------------------------------------------------------------------------
; probot_draw_body - draws the legs and body of the probot whose record is in S2_PRM. sets the ship 2 block to
;   unit vectors (UNITV), yaws it by the body spin angle (byte 11) and concatenates it with the player's view
;   (MS_CNCT). then the legs (P2_91CC), colour $62C0, the points of object 4 and of object 5 raised by the bob
;   offset (P2_90CC), the draw routine those two objects share, the beam back to the centre (bank 1 KD8AC) and the
;   lazar aim test on the body (P2_9272). leaves U = the record
;------------------------------------------------------------------------------
probot_draw_body:
P2_909A:  LDU  #M_CX2                 ;ship 2 block to unit vectors
P2_909D:  JSR  UNITV
P2_90A0:  LDU  S2_PRM
P2_90A2:  LDD  #$0009                 ;block index 9 for the yaw and the concatenate
P2_90A5:  STD  M_BIC
P2_90A8:  LDB  11,U                   ;body spin angle
P2_90AA:  JSR  yaw_by_angle
P2_90AD:  LDA  #$40                   ;MS_CNCT: view the turned block from the player's ship
P2_90AF:  JSR  MGOWT
P2_90B2:  JSR  probot_draw_legs
P2_90B5:  LDD  #$62C0                 ;colour of the body
P2_90B8:  STD  ,Y++
P2_90BA:  LDB  #$04                   ;points of object 4, the body
P2_90BC:  JSR  L60D2
P2_90BF:  JSR  probot_neck_pts
P2_90C2:  JSR  L60E4                  ;draw with the routine of object 5, which bank 1 shares with object 4
P2_90C5:  JSR  L60BA                  ;beam back to the centre
P2_90C8:  JSR  probot_body_aim
P2_90CB:  RTS

;------------------------------------------------------------------------------
; probot_neck_pts - moves the centre used for the next object points up the probot's own axis by the bob offset
;   (word 13 of the record at U): the point 0, 0, offset goes through matrix program MS_PAD and the result
;   replaces M_XT, M_YT and M_ZT. then processes the points of object 5 (JOBJBPNT), the ring the head sits on. the
;   head drawn afterwards uses the same raised centre
;------------------------------------------------------------------------------
probot_neck_pts:
P2_90CC:  LDD  #$0000
P2_90CF:  STD  M_X0
P2_90D2:  STD  M_Y0
P2_90D5:  LDD  13,U                   ;bob offset
P2_90D7:  STD  4+M_X0                 ;UP/DOWN VID Y IS MATH Z
P2_90DA:  LDD  #MS_X0BC
P2_90DD:  STD  M_BIC
P2_90E0:  LDA  #$50                   ;MS_PAD: the raised centre in view coordinates
P2_90E2:  JSR  MGOWT
P2_90E5:  LDD  M_XP
P2_90E8:  STD  M_XT                   ;it replaces the probot's centre for the points that follow
P2_90EB:  LDD  M_YP
P2_90EE:  STD  M_YT
P2_90F1:  LDD  M_ZP
P2_90F4:  STD  M_ZT
P2_90F7:  LDB  #$05                   ;points of object 5, placed after those of object 4
P2_90F9:  JSR  L60D2
P2_90FC:  RTS

;------------------------------------------------------------------------------
; probot_draw_head - draws the head of the probot at U. yaws the ship 2 block by the head angle (byte $10) on
;   top of the body spin and concatenates it again, processes the points of object 6 and draws it, runs the lazar
;   aim test on the head (P2_92B0) and the launches (P2_9125), then draws object 7, which uses the points of
;   object 6 and comes out in the colour P2_9125 set, and returns the beam to the centre
;------------------------------------------------------------------------------
probot_draw_head:
P2_90FD:  LDD  #$0009
P2_9100:  STD  M_BIC
P2_9103:  LDB  $10,U                  ;head angle
P2_9106:  JSR  yaw_by_angle
P2_9109:  LDA  #$40                   ;MS_CNCT
P2_910B:  JSR  MGOWT
P2_910E:  LDB  #$06                   ;points of object 6, the head
P2_9110:  JSR  L60D2
P2_9113:  JSR  L60E4                  ;draw object 6
P2_9116:  JSR  probot_head_aim
P2_9119:  JSR  probot_head_acts
P2_911C:  LDB  #$07                   ;draw object 7 from the same points
P2_911E:  JSR  L60EA
P2_9121:  JSR  L60BA
P2_9124:  RTS

;------------------------------------------------------------------------------
; probot_head_acts - writes colour $6480 for the last part of the head, puts the universe position of the probot
;   at U (words 5, 7 and 9, the player's position added when it is held player-relative) in M_XT2, M_YT2 and M_ZT2
;   as the place a transmission or a shot starts from, and tries both launches (P2_9158). X and U are preserved
;------------------------------------------------------------------------------
probot_head_acts:
P2_9125:  PSHS X,U
P2_9127:  LDD  #$6480                 ;colour for object 7
P2_912A:  STD  ,Y++
P2_912C:  LDA  ,U                     ;bit $08: the position is in universe coordinates
P2_912E:  ANDA #$08
P2_9130:  BEQ  P2_913E
P2_9132:  LDD  5,U
P2_9134:  STD  M_XT2
P2_9137:  LDD  7,U
P2_9139:  STD  M_YT2
P2_913C:  BRA  P2_914E
P2_913E:  LDD  5,U                    ;player-relative: add the player's position
P2_9140:  ADDD s1_tx
P2_9143:  STD  M_XT2
P2_9146:  LDD  7,U
P2_9148:  ADDD s1_ty
P2_914B:  STD  M_YT2
P2_914E:  LDD  9,U                    ;height
P2_9150:  STD  M_ZT2
P2_9153:  JSR  probot_launch
P2_9156:  PULS X,U,PC

;------------------------------------------------------------------------------
; probot_launch - tries to launch a transmission (P2_9175) and then a shot (P2_915F) from the probot at U, whose
;   depth is in M_XT and whose universe position is in M_XT2, M_YT2, M_ZT2. called when the head is drawn and once
;   more when the probot is shot down
;------------------------------------------------------------------------------
probot_launch:
P2_9158:  JSR  probot_try_xmit
P2_915B:  JSR  probot_try_shot
P2_915E:  RTS

;------------------------------------------------------------------------------
; probot_try_shot - lets the probot at U fire at the player: when its depth M_XT is above $0400, bit $02 of byte
;   0 is set and the shot timer (byte 3) has run out, it calls page 1 P1_9063, which reloads the timer and may
;   start a shot from the position in M_XT2, M_YT2, M_ZT2
;------------------------------------------------------------------------------
probot_try_shot:
P2_915F:  LDD  M_XT
P2_9162:  SUBD #$0400                 ;nearer than $0400: no shot
P2_9165:  BLE  P2_9174
P2_9167:  LDA  ,U
P2_9169:  BITA #$02                   ;bit $02: this probot shoots
P2_916B:  BEQ  P2_9174
P2_916D:  LDA  3,U                    ;shot timer still running
P2_916F:  BNE  P2_9174
P2_9171:  JSR  P2_8295                ;calls page 1 probot_fire
P2_9174:  RTS

;------------------------------------------------------------------------------
; probot_try_xmit - lets the probot at U send a transmission: when its depth M_XT is above $0400 and under
;   $3000, prog_count is under 4, bit $04 of byte 0 is set, bit $80 of byte 1 is set (near the middle of the
;   screen) and the transmission timer (byte $14) has run out, it calls page 3 P3_98E8, which starts a
;   transmission at the position in M_XT2, M_YT2, M_ZT2 and returns carry set when a record was free. then the bob
;   direction (byte 15) is set to $FF, downwards, and the timer is loaded again (P2_91A8)
;------------------------------------------------------------------------------
probot_try_xmit:
P2_9175:  LDD  M_XT
P2_9178:  CMPD #$0400                 ;nearer than $0400: no transmission
P2_917C:  BLE  P2_91A7
P2_917E:  SUBD #$3000                 ;$3000 or further: none either
P2_9181:  BGE  P2_91A7
P2_9183:  LDA  prog_count             ;the wave's count is full
P2_9186:  CMPA #$04
P2_9188:  BGE  P2_91A7
P2_918A:  LDA  ,U
P2_918C:  BITA #$04                   ;bit $04: this probot transmits
P2_918E:  BEQ  P2_91A7
P2_9190:  LDA  1,U
P2_9192:  BITA #$80                   ;bit $80: lined up this frame
P2_9194:  BEQ  P2_91A7
P2_9196:  LDA  $14,U                  ;transmission timer still running
P2_9199:  BNE  P2_91A7
P2_919B:  JSR  P2_83A3                ;calls page 3 xmit_launch
P2_919E:  BCC  P2_91A7                ;carry clear: no free transmission record
P2_91A0:  LDA  #$FF                   ;bob direction down
P2_91A2:  STA  15,U
P2_91A4:  JSR  probot_xmit_delay
P2_91A7:  RTS

;------------------------------------------------------------------------------
; probot_xmit_delay - loads the transmission timer (byte $14) of the probot at U: the entry of the table at
;   P2_91C3 for w1_pace (8 at most), plus a random part of the same entry, plus 4. the entries fall from $3F to 2,
;   so the probots transmit more often as the pace rises. X is changed
;------------------------------------------------------------------------------
probot_xmit_delay:
P2_91A8:  LDB  w1_pace                ;pace, 8 at most
P2_91AB:  CMPB #$08
P2_91AD:  BLS  P2_91B1
P2_91AF:  LDB  #$08
P2_91B1:  LDX  #xmit_delay_tab
P2_91B4:  ABX
P2_91B5:  LDB  ,X                     ;table entry
P2_91B7:  LDA  P_RND1                 ;a random part of it
P2_91BA:  MUL
P2_91BB:  ADDA ,X                     ;plus the entry, plus 4
P2_91BD:  ADDA #$04
P2_91BF:  STA  $14,U
P2_91C2:  RTS

xmit_delay_tab:
P2_91C3:  .byte $3F, $2F, $1F, $18, $14, $10, $0C, $08 ;transmission delay by w1_pace 0-8
P2_91CB:  .byte $02

;------------------------------------------------------------------------------
; probot_draw_legs - draws the legs of the probot at U: one of objects 9-$10 for each bit set in the part mask
;   (byte $13), bit 0 for object 9. the four points of the leg are processed (JOBJBPNT) and the width of 6 units
;   at the probot's depth is worked out with the divider and MS_PERS. the leg is drawn down from the body with the
;   draw routine of object 9 and BJ_CX moved by that width, then back up with the draw routine of object 10 and
;   BJ_CX moved the other way, so the two passes lie one width either side of the points and meet at the tip. a
;   width of 2 or less gives a single line. the beam returns to the centre after each leg
;------------------------------------------------------------------------------
probot_draw_legs:
P2_91CC:  LDB  $13,U                  ;part mask: one bit for each of objects 9-$10
P2_91CF:  STB  leg_mask
P2_91D2:  LDB  #$09                   ;object 9 goes with bit 0
P2_91D4:  STB  leg_obj
P2_91D7:  LSR  leg_mask               ;next bit of the mask
P2_91DA:  BCC  P2_922A                ;clear: this leg is missing
P2_91DC:  LDB  leg_obj                ;points of this leg
P2_91DF:  JSR  L60D2
P2_91E2:  LDD  M_XT                   ;X
P2_91E5:  STD  M_DVD
P2_91E8:  ORCC #$00                   ;TOTAL OF 7.5 CYCLE DELAY BEFORE READ
P2_91EA:  LDD  M_QUO                  ;GET 1/X, RECIPROCAL
P2_91ED:  STD  M_XP
P2_91F0:  LDD  #$0006                 ;6 units, to be scaled by the reciprocal of the depth
P2_91F3:  STD  M_YP
P2_91F6:  LDA  #MS_PERS
P2_91F8:  JSR  MGOWT
P2_91FB:  LDD  M_YP                   ;the width on the screen
P2_91FE:  CMPD #$0002                 ;2 or less: none, the leg is a single line
P2_9202:  BGT  P2_9207
P2_9204:  LDD  #$0000
P2_9207:  STD  leg_width
P2_920A:  LDD  BJ_CX                  ;move BJ_CX so that the pass down the leg lies one width to the side
P2_920C:  SUBD leg_width
P2_920F:  STD  BJ_CX
P2_9211:  LDB  #$09                   ;draw routine of object 9: beam to point 0, then points 1, 2 and 3
P2_9213:  JSR  L60EA
P2_9216:  LDD  leg_width              ;no width: one pass only
P2_9219:  BLE  P2_9227
P2_921B:  ADDD leg_width              ;move BJ_CX two widths the other way
P2_921E:  ADDD BJ_CX
P2_9220:  STD  BJ_CX
P2_9222:  LDB  #$0A                   ;draw routine of object 10: back through points 2, 1 and 0
P2_9224:  JSR  L60EA
P2_9227:  JSR  L60BA
P2_922A:  INC  leg_obj                ;next object number
P2_922D:  LDB  leg_mask               ;until no bits are left
P2_9230:  BNE  P2_91D7
P2_9232:  RTS

;------------------------------------------------------------------------------
; lz_oct_dist - distance on the screen from the lazar cursor (LZ_CX, LZ_CY) to the perspected point at X (x
;   word, y word), by the octagon rule the Star Wars collision tests use in line: the larger of the bigger axis
;   distance and 9/16 of the sum of the two. returns it in D less 10, not below 0. uses scratch_1 and scratch_3
;------------------------------------------------------------------------------
lz_oct_dist:
P2_9233:  LDD  ,X                     ;x distance from the lazar cursor
P2_9235:  SUBD >LZ_CX
P2_9238:  BPL  P2_923E                ;IFMI
P2_923A:  COMA                        ;NEGD  ABSD
P2_923B:  NEGB
P2_923C:  SBCA #$FF
P2_923E:  STD  TMPOCT                 ;PREPARE FOR OCTAGON COLLISION DETECT
P2_9240:  STD  scratch_1
P2_9242:  LDD  2,X                    ;y distance
P2_9244:  SUBD >LZ_CY
P2_9247:  BPL  P2_924D                ;IFMI
P2_9249:  COMA                        ;NEGD
P2_924A:  NEGB
P2_924B:  SBCA #$FF
P2_924D:  CMPD TMPSIZ                 ;the larger of the two in $4803
P2_9250:  BLE  P2_9254
P2_9252:  STD  scratch_3
P2_9254:  ADDD scratch_1              ;(x + y) / 2
P2_9256:  LSRA
P2_9257:  RORB
P2_9258:  STD  scratch_1
P2_925A:  LSRA                        ;plus (x + y) / 16
P2_925B:  RORB
P2_925C:  LSRA
P2_925D:  RORB
P2_925E:  LSRA
P2_925F:  RORB
P2_9260:  ADDD scratch_1
P2_9262:  CMPD scratch_3              ;the larger of that and the bigger axis distance
P2_9265:  BGE  P2_9269
P2_9267:  LDD  scratch_3
P2_9269:  SUBD #$000A                 ;less 10, not below 0
P2_926C:  BGE  P2_9271
P2_926E:  LDD  #$0000
P2_9271:  RTS

;------------------------------------------------------------------------------
; probot_body_aim - lazar aim test on the body of the probot at U, after its points are processed. when the
;   probot's depth M_XT is less than the depth of the nearest probot found so far (prob_hit_d) and the cursor is
;   within the size of 45 units at that depth from point 18 of object 4, the middle of the body (lz_oct_dist), it
;   records this probot in prob_hit_rec and its depth in prob_hit_d. page 3 lz_hit_probot reads them when the
;   lazars fire
;------------------------------------------------------------------------------
probot_body_aim:
P2_9272:  LDD  M_XT                   ;depth of this probot
P2_9275:  CMPD prob_hit_d             ;not nearer than the one already found
P2_9279:  BCC  P2_92AF
P2_927B:  SUBD #$0014                 ;depth less 20, at least 20, to the divider
P2_927E:  CMPD #$0014
P2_9282:  BGE  P2_9287
P2_9284:  LDD  #$0014
P2_9287:  STD  M_DVD
P2_928A:  LDD  #$002D                 ;45 units: the size of the body
P2_928D:  STD  M_YP
P2_9290:  LDD  M_QUO                  ;reciprocal of the depth
P2_9293:  STD  M_XP
P2_9296:  LDA  #MS_PERS               ;the size on the screen
P2_9298:  JSR  MGOWT
P2_929B:  LDX  #BJ_PNT+$5F            ;point 18 of object 4, the middle of the body
P2_929E:  JSR  lz_oct_dist
P2_92A1:  SUBD M_YP                   ;cursor outside the size: no hit
P2_92A4:  BGE  P2_92AF
P2_92A6:  STU  prob_hit_rec           ;this probot is the nearest one under the cursor
P2_92A9:  LDD  M_XT
P2_92AC:  STD  prob_hit_d
P2_92AF:  RTS

;------------------------------------------------------------------------------
; probot_head_aim - lazar aim test on the head of the probot at U: the same as P2_9272 with a size of 30 units
;   and point 19 of object 6, the middle of the head
;------------------------------------------------------------------------------
probot_head_aim:
P2_92B0:  LDD  M_XT
P2_92B3:  CMPD prob_hit_d
P2_92B7:  BCC  P2_92ED
P2_92B9:  SUBD #$0014                 ;depth less 20, at least 20, to the divider
P2_92BC:  CMPD #$0014
P2_92C0:  BGE  P2_92C5
P2_92C2:  LDD  #$0014
P2_92C5:  STD  M_DVD
P2_92C8:  LDD  #$001E                 ;30 units: the size of the head
P2_92CB:  STD  M_YP
P2_92CE:  LDD  M_QUO                  ;reciprocal of the depth
P2_92D1:  STD  M_XP
P2_92D4:  LDA  #MS_PERS
P2_92D6:  JSR  MGOWT
P2_92D9:  LDX  #BJ_PNT+$5F            ;point 19 of object 6, the middle of the head
P2_92DC:  JSR  lz_oct_dist
P2_92DF:  SUBD M_YP
P2_92E2:  BGE  P2_92ED
P2_92E4:  STU  prob_hit_rec           ;this probot is the nearest one under the cursor
P2_92E7:  LDD  M_XT
P2_92EA:  STD  prob_hit_d
P2_92ED:  RTS

;------------------------------------------------------------------------------
; probot_shot_down - the probot in prob_hit_rec is hit by the lazars: jumped to from page 3 lz_hit_probot
;   through maze entry P3_8454 when a probot is under the cursor and nearer than the enemy shot and the
;   transmission under it. the first time in a game it sends speech command $05 (foa_said). it makes the probot's
;   position absolute, starts the explosion there (bank 1 BGBKXP through L6198), scores 25 points while bonus_left
;   is not 0 and 250 after, sends sound $4E, gives the probot a last try at a transmission and a shot
;   (probot_launch) and frees the record. while bonus_left is not 0 it is counted down, and the kill that brings
;   it to 0 scores 5,000, awards the Jedi letter (page 1 jedi_award) and raises quota_probot by one
;------------------------------------------------------------------------------
probot_shot_down:
P2_92EE:  LDA  foa_said               ;speech only for the first probot shot down in a game
P2_92F1:  BNE  P2_92F9
P2_92F3:  JSR  spk_cmd_05
P2_92F6:  INC  foa_said
P2_92F9:  LDU  prob_hit_rec           ;the probot the cursor was on
P2_92FC:  JSR  probot_pos_abs
P2_92FF:  LDD  5,U                    ;its universe position for the explosion and for the last launches
P2_9301:  STD  M_XT
P2_9304:  STD  M_XT2
P2_9307:  LDD  7,U
P2_9309:  STD  M_YT
P2_930C:  STD  M_YT2
P2_930F:  LDD  9,U
P2_9311:  STD  M_ZT
P2_9314:  STD  M_ZT2
P2_9317:  JSR  L6198                  ;bank 1 BGBKXP: start the explosion
P2_931A:  LDA  bonus_left             ;quota still open: 25 points, else 250
P2_931D:  BEQ  P2_9324
P2_931F:  JSR  scr_probot_25
P2_9322:  BRA  P2_9327
P2_9324:  JSR  scr_probot_250
P2_9327:  JSR  aud_cmd_4e
P2_932A:  LDD  prob_hit_d             ;the probot's depth back in M_XT for the launch tests
P2_932D:  STD  M_XT
P2_9330:  JSR  probot_launch          ;a last transmission and shot if the tests allow
P2_9333:  LDA  #$00                   ;free the record
P2_9335:  STA  ,U
P2_9337:  LDA  bonus_left             ;quota already met: nothing more
P2_933A:  BEQ  P2_934A
P2_933C:  DEC  bonus_left
P2_933F:  BNE  P2_934A                ;this kill meets the quota: 5,000 points and the letter
P2_9341:  JSR  scr_probot_quota
P2_9344:  JSR  P2_81E4                ;calls page 1 jedi_award
P2_9347:  INC  quota_probot           ;one more probot to shoot for the next letter
P2_934A:  RTS
P2_934B:  .byte $00, $97, $C2, $8E, $49, $D2, $CE, $50 ;not a table: dead code from an earlier build, never reached (see the questions). the opcode of its first instruction, LDA #$00, lies under the RTS at P2_934A. $934C is STA WV_LVL and $934E-$93D1 is the alien record set-up that page 3 has at P3_85F0-P3_8673
P2_9353:  .byte $F0, $C6, $1C, $86, $08, $A7, $04, $6F
P2_935B:  .byte $03, $EF, $84, $E7, $02, $33, $C8, $20
P2_9363:  .byte $CB, $04, $30, $88, $19, $8C, $4A, $1D
P2_936B:  .byte $25, $E9, $BD, $9A, $CC, $39, $8E, $49
P2_9373:  .byte $D2, $CE, $50, $F0, $C6, $1C, $86, $08
P2_937B:  .byte $A7, $04, $6F, $03, $EF, $84, $E7, $02
P2_9383:  .byte $33, $C8, $20, $CB, $04, $30, $88, $19
P2_938B:  .byte $8C, $4A, $1D, $25, $E9, $8E, $49, $D2
P2_9393:  .byte $86, $01, $A7, $03, $EE, $84, $BD, $B3
P2_939B:  .byte $41, $EE, $84, $86, $C0, $A7, $50, $A7
P2_93A3:  .byte $5A, $CC, $10, $00, $ED, $48, $CC, $00
P2_93AB:  .byte $00, $ED, $4A, $CC, $00, $00, $ED, $4C
P2_93B3:  .byte $4F
P2_93B4:  .byte $A7, $0A, $A7, $09, $A7, $07, $A7, $06
P2_93BC:  .byte $A7, $0C, $86, $01, $A7, $08, $CC, $9C
P2_93C4:  .byte $56, $ED, $0D, $BD, $9A, $1A, $C6, $00
P2_93CC:  .byte $E7, $05, $BD, $60, $A8, $39

;------------------------------------------------------------------------------
; SNVW_P2 - SNVW VIEW ALIEN SHIP
;   in ESB: this copy is not reached on page 2: from $9361 to $9560 the page holds the same bytes as page 3,
;   left from an earlier build, and $934C-$93D1 before it is leftover TIE fighter set-up code. no maze entry
;   of page 2 leads here, bank 0 views the TIE fighters through SNVW_P3 on page 3
;------------------------------------------------------------------------------
SNVW_P2:
P2_93D2:  LDX  #ALIEN                 ;SHIP PARAMS

SNVW_10_P2:
P2_93D5:  STX  S2_PRM
P2_93D7:  LDA  AS_TYP,X
P2_93D9:  BEQ  SNVW_90_P2             ;?SOMEWHAT ALIVE?
P2_93DB:  JSR  S2VW_P2                ;VIEW THE SHIP

SNVW_90_P2:
P2_93DE:  LDX  S2_PRM                 ;NEXT SHIP
P2_93E0:  LEAX AS_IZE,X
P2_93E3:  CMPX #ALIENZ
P2_93E6:  BLO  SNVW_10_P2

RTS1_P2:
SNVW_96_P2:
P2_93E8:  RTS

;------------------------------------------------------------------------------
; S2VW_P2 - VIEW THE SHIP  (comment at the call)
;   in ESB: part of the same leftover: called only by the SNVW in front of it, which nothing reaches. its end,
;   $952B-$9560, is the same on all four pages
;------------------------------------------------------------------------------
S2VW_P2:
P2_93E9:  LDX  S2_PRM
P2_93EB:  CLRA
P2_93EC:  LDB  AS_BIC,X
P2_93EE:  ADDB #$03
P2_93F0:  STD  M_BIC
P2_93F3:  LDA  #MS_PSB2
P2_93F5:  JSR  MGOWT
P2_93F8:  LDA  M_XP
P2_93FB:  LSLA                        ;-4000<X<4000 FOR VALID SQUARING
P2_93FC:  BVS  S2VW_12_P2
P2_93FE:  LDA  M_YP
P2_9401:  LSLA                        ;from P2_93D2 to P2_9560 the bytes are the same as on page 3, and no maze entry of page 2 leads to this copy of SNVW and S2VW
P2_9402:  BVS  S2VW_12_P2
P2_9404:  LDA  M_ZP
P2_9407:  LSLA
P2_9408:  BVS  S2VW_12_P2
P2_940A:  LDD  M_XPS                  ;CHECK FOR COLLISION
P2_940D:  ADDD M_YPS
P2_9410:  ADDD M_ZPS
P2_9413:  TFR  D,U

S2VW_114_P2:
P2_9415:  CMPU #$0900
P2_9419:  BHI  P2_9423                ;IFLS  ?PLAYER AT MIDDISTANCE?
P2_941B:  LDD  AS_CHST,X
P2_941E:  ORA  #((CS_PM&$FF00)/$100)  ;CHSET C$PM  THEN SET PLAYER MIDDLE DISTANCE
P2_9420:  STD  AS_CHST,X
P2_9423:  CMPU #$0100
P2_9427:  BHI  P2_9431                ;IFLS  ?PLAYER NEARBY?
P2_9429:  LDD  AS_CHST,X
P2_942C:  ORA  #((CS_PN&$FF00)/$100)  ;CHSET C$PN  THEN SET PLAYER NEAR
P2_942E:  STD  AS_CHST,X
P2_9431:  CMPU #$00A0
P2_9435:  BHI  P2_9467                ;IFLS  ?PLAYER NEARBY?
P2_9437:  LDA  Q_PBB
P2_943A:  BNE  P2_944C                ;IFEQ  ?NO SHIP CURRENTLY PASSING BY?
P2_943C:  LDA  AS_BIC,X
P2_943E:  STA  Q_PBB                  ;THEN START THIS SHIP PASSING BY
P2_9441:  JSR  spk_cmd_06
P2_9444:  JSR  aud_cmd_35
P2_9447:  STU  Q_PBD                  ;INIT CURRENT DISTANCE
P2_944A:  BRA  P2_9465                ;ELSE  ELSE IS BIC OF SHIP IS PASSING BY
P2_944C:  CMPA AS_BIC,X
P2_944E:  BNE  P2_9465                ;IFEQ  ?IS THIS THE SHIP CURRENTLY PASSINGBY?
P2_9450:  CMPU Q_PBD                  ;THEN CHECK FOR CHANGES IN DISTANCE AWAY
P2_9454:  BGT  P2_945B                ;IFLE  ?NOT MOVING AWAY YET? NOTE SIGNED FLAG TEST
P2_9456:  STU  Q_PBD                  ;THEN SAVE THIS LATEST DISTANCE
P2_9459:  BRA  P2_9465                ;ELSE  ELSE IS DEFINITLY MOVING AWAY
P2_945B:  BLO  P2_9465                ;IFHS  ?MINUS FLAG STILL CLEAR? ONE TIME ONLY
P2_945D:  LDA  #$FF
P2_945F:  STA  Q_PBD                  ;SET DISTANCE TO MINUS, END PASSBY FLAG
P2_9462:  JSR  aud_cmd_39
P2_9465:  BRA  S2VW_12_P2             ;ELSE  ELSE NOT NEAR TO PLAYER
P2_9467:  LDA  AS_BIC,X
P2_9469:  CMPA Q_PBB
P2_946C:  BNE  S2VW_12_P2             ;IFEQ  ?WAS THIS THE SHIP DOING A PASSBY?
P2_946E:  CLR  Q_PBB                  ;THEN PREPARE FOR NEXT SHIP

S2VW_12_P2:
P2_9471:  LDD  M_XP                   ;not drawn when its distance ahead is $10 or less or above $7F00
P2_9474:  CMPD #$0010
P2_9478:  LBLE RTS1_P2
P2_947C:  CMPD #$7F00
P2_9480:  LBHI RTS1_P2

S2VW_19_P2:
P2_9484:  STD  M_DVD
P2_9487:  STD  M_XT
P2_948A:  LDD  M_YP
P2_948D:  STD  M_YT
P2_9490:  LDD  M_YPS
P2_9493:  SUBD M_XPS                  ;X SQUARED
P2_9496:  LBHS RTS1_P2                ;B OUT OF VIEW

S2VW_28_P2:
P2_949A:  LDD  M_ZP
P2_949D:  STD  M_ZT
P2_94A0:  LDD  M_ZPS
P2_94A3:  SUBD M_XPS                  ;X SQUARED
P2_94A6:  LBHS RTS1_P2

S2VW_31_P2:
P2_94AA:  LDX  S2_PRM
P2_94AC:  LDD  AS_CHST,X
P2_94AF:  ORA  #((CS_PV&$FF00)/$100)  ;CHSET C$PV  WITHIN PLAYERS VIEW SCREEN
P2_94B1:  STD  AS_CHST,X
P2_94B4:  LDA  AS_BIC,X
P2_94B6:  JSR  IS2UV                  ;DOWNLOAD SHIP 2 UNIT VECTORS
P2_94B9:  JSR  L60B4                  ;bank 1 BJCNTR: vector from the screen centre to the ship's centre
P2_94BC:  LDD  #$0050                 ;JUST TRY IT -- SHUT DOWN CPU AND TEST
P2_94BF:  STD  M_YP                   ;GET SHIP SIZE
P2_94C2:  LDA  #MS_PERS
P2_94C4:  JSR  MGOWT
P2_94C7:  LDD  M_YP
P2_94CA:  ADDD #$000A                 ;ADDIN CURSOR SIZE
P2_94CD:  STD  TMPSIZ_4801
P2_94CF:  LDD  >BJ_CX
P2_94D2:  SUBD >LZ_CX
P2_94D5:  BPL  P2_94DB                ;IFMI
P2_94D7:  COMA                        ;NEGD  ABSD
P2_94D8:  NEGB
P2_94D9:  SBCA #$FF
P2_94DB:  STD  TMPXD                  ;SAVE X DISTANCE
P2_94DD:  STD  TMPOCT_4803            ;PREPARE FOR OCTAGON COLLISION DETECT
P2_94DF:  LDD  >BJ_CY
P2_94E2:  SUBD >LZ_CY
P2_94E5:  BPL  P2_94EB                ;IFMI
P2_94E7:  COMA                        ;NEGD
P2_94E8:  NEGB
P2_94E9:  SBCA #$FF
P2_94EB:  STD  TMPYD                  ;SAVE Y DISTANCE
P2_94ED:  ADDD TMPOCT_4803
P2_94EF:  STD  TMPOCT_4803            ;OCTAGON CHECK
P2_94F1:  LDD  TMPXD
P2_94F3:  SUBD TMPSIZ_4801
P2_94F5:  BGT  P2_9515                ;IFLE  LE FOR LIBERALITY
P2_94F7:  LDD  TMPYD
P2_94F9:  SUBD TMPSIZ_4801
P2_94FB:  BGT  P2_9515                ;IFLE  ?WITHIN Y ALSO?
P2_94FD:  LDD  TMPSIZ_4801
P2_94FF:  LSRA                        ;LSRD
P2_9500:  RORB
P2_9501:  ADDD TMPSIZ_4801            ;MAKE 1.5 FOR OCTAGON
P2_9503:  SUBD TMPOCT_4803
P2_9505:  BLT  P2_9515                ;IFGE  ?ALSO WITHIN OCTAGON?
P2_9507:  LDD  M_XT                   ;THEN SEE IF WE ARE THE CLOSEST ALIEN
P2_950A:  CMPD CL_ADS                 ;SHIP DISTANCE
P2_950D:  BHS  P2_9515                ;IFLO  ?ALSO THE NEAREST SHIP SO FAR?
P2_950F:  STD  CL_ADS                 ;REMEMBER ITS DISTANCE
P2_9511:  LDX  S2_PRM                 ;THEN WE GOT A HIT
P2_9513:  STX  CL_AP                  ;RECORD WHO WE ARE
P2_9515:  LDD  TMPSIZ_4801            ;?AIM IS NEARING ALIEN?
P2_9517:  ADDD TMPSIZ_4801
P2_9519:  ADDD TMPSIZ_4801            ;ALLOW LARGER WARNING AREA
P2_951B:  SUBD TMPOCT_4803
P2_951D:  BLO  S2VW_86_P2             ;IFHS
P2_951F:  LDX  S2_PRM
P2_9521:  LDA  AS_TYP,X
P2_9523:  CMPA #$01
P2_9525:  BNE  S2VW_86_P2             ;?ALIVE?
P2_9527:  LDD  AS_CHST,X
P2_952A:  ORA  #((CS_PS&$FF00)/$100)  ;CHSET C$PS  STATUS: ALIEN IN PLAYER SITES

;------------------------------------------------------------------------------
; s2vw_end_p2 - stale image, never run: the last instructions of a copy of Star Wars' S2VW, the same on all four
;   pages - see s2vw_end_p0 on page 0
;------------------------------------------------------------------------------
s2vw_end_p2:
P2_952C:  STD  AS_CHST,X

;SET BRITENESS
;ELSE HANDLE GLOW
S2VW_86_P2:
P2_952F:  LDX  S2_PRM
P2_9531:  LDB  7,X
P2_9533:  LDU  #TVWCL_P2              ;GET GLOW COLORS
P2_9536:  LSLB
P2_9537:  LDD  B,U
P2_9539:  STD  ,Y++

S2VW_55_P2:
P2_953B:  LDA  #MS_CNCT
P2_953D:  JSR  MGOWT
P2_9540:  LDB  5,X
P2_9542:  JSR  L60D2                  ;bank 1 JOBJBPNT: project the points of object 5,X
P2_9545:  JSR  L60E4                  ;bank 1: draw the object
P2_9548:  JSR  L60BA                  ;bank 1: beam back to the centre
P2_954B:  RTS

TVWCL_P2:
P2_954C:  .word (VGCOPC&$F000)+(($82&$F)*$100)+($82&$F0) ;TVWBYT 082,037,82,37,82,47,82,47
P2_954E:  .word (VGCOPC&$F000)+(($37&$F)*$100)+($37&$F0)
P2_9550:  .word (VGCOPC&$F000)+(($82&$F)*$100)+($82&$F0)
P2_9552:  .word (VGCOPC&$F000)+(($37&$F)*$100)+($37&$F0)
P2_9554:  .word (VGCOPC&$F000)+(($82&$F)*$100)+($82&$F0)
P2_9556:  .word (VGCOPC&$F000)+(($47&$F)*$100)+($47&$F0)
P2_9558:  .word (VGCOPC&$F000)+(($82&$F)*$100)+($82&$F0)
P2_955A:  .word (VGCOPC&$F000)+(($47&$F)*$100)+($47&$F0)
P2_955C:  .word (VGCOPC&$F000)+(($82&$F)*$100)+($82&$F0) ;TVWBYT 082,057,82,057,082,067,082,067
P2_955E:  .word (VGCOPC&$F000)+(($57&$F)*$100)+($57&$F0)
P2_9560:  .byte $D6                   ;the last byte that is the same as on page 3: page 2's own code starts at the next address

;------------------------------------------------------------------------------
; astrd_init - set-up of the asteroid field, called by asteroid_setup (phase $48) when the asteroid part begins.
;   puts objects $20-$22, the asteroid shapes, into the math box, presets the ten asteroid records ($17 bytes
;   each, from ALIENZ up to MESBLK) from astrd_init_tab with random spin angles and leaves them all free, sets
;   astrd_max from w4_level through astrd_max_tab (3 to 10) and clears the launch delay
;------------------------------------------------------------------------------
astrd_init:
P2_9561:  LDB  #$20                   ;objects $20, $21, $22, the asteroid shapes, into the math box (bank 1 KD868)
P2_9563:  JSR  L60A8
P2_9566:  LDB  #$21
P2_9568:  JSR  L60A8
P2_956B:  LDB  #$22
P2_956D:  JSR  L60A8
P2_9570:  LDX  #astrd_init_tab
P2_9573:  LDU  #ALIENZ                ;ten records of $17 bytes, the last ends at MESBLK
P2_9576:  STU  S2_PRM
P2_9578:  JSR  rnd_set
P2_957B:  LDA  #$00
P2_957D:  STA  ,U                     ;status 0: every record starts free
P2_957F:  LDA  #$00
P2_9581:  STA  1,U
P2_9583:  LDD  ,X++                   ;x, y, z
P2_9585:  STD  6,U
P2_9587:  LDD  ,X++
P2_9589:  STD  8,U
P2_958B:  LDD  ,X++
P2_958D:  STD  10,U
P2_958F:  LDA  ,X+                    ;yaw rate and pitch rate
P2_9591:  STA  $13,U
P2_9594:  LDA  ,X+
P2_9596:  STA  $15,U
P2_9599:  LDD  RND_S1                 ;random yaw and pitch angles
P2_959B:  STA  $12,U
P2_959E:  STB  $14,U
P2_95A1:  LDD  ,X++                   ;size index and movement type
P2_95A3:  STA  5,U
P2_95A5:  STB  4,U
P2_95A7:  LDD  #$0000                 ;x velocity
P2_95AA:  STD  12,U
P2_95AC:  LEAU $17,U
P2_95AF:  CMPU #MESBLK
P2_95B3:  BCS  P2_9576
P2_95B5:  LDB  w4_level
P2_95B8:  CMPB #$19                   ;level 25 and up use the last entry
P2_95BA:  BLS  P2_95BE
P2_95BC:  LDB  #$19
P2_95BE:  LDX  #astrd_max_tab
P2_95C1:  LDB  B,X
P2_95C3:  STB  astrd_max
P2_95C6:  LDA  #$00
P2_95C8:  STA  astrd_delay            ;no launch delay
P2_95CB:  RTS

astrd_max_tab:
P2_95CC:  .byte $03, $03, $03, $03, $04, $04, $04, $04 ;asteroids in flight at once by w4_level 0-25: 3 to 10
P2_95D4:  .byte $05, $05, $05, $06, $06, $06, $06, $07
P2_95DC:  .byte $07, $07, $08, $08, $08, $08, $09, $09
P2_95E4:  .byte $09, $0A

astrd_init_tab:
P2_95E6:  .word $7000, $0000, $2000   ;asteroid row 0: three words, then four bytes  preset of the records, 10 bytes each: x, y, z words, yaw rate, pitch rate, size index, movement type. 12 entries, of which astrd_init uses ten
P2_95EC:  .byte $07, $01, $00, $03
P2_95F0:  .word $4000, $4000, $2800   ;asteroid row 1: three words, then four bytes
P2_95F6:  .byte $F9, $01, $00, $03
P2_95FA:  .word $8000, $8000, $3000   ;asteroid row 2: three words, then four bytes
P2_9600:  .byte $06, $FE, $00, $03
P2_9604:  .word $C000, $C000, $4000   ;asteroid row 3: three words, then four bytes
P2_960A:  .byte $F8, $FE, $00, $03
P2_960E:  .word $3000, $A000, $1000   ;asteroid row 4: three words, then four bytes
P2_9614:  .byte $05, $02, $00, $03
P2_9618:  .word $6000, $E000, $2000   ;asteroid row 5: three words, then four bytes
P2_961E:  .byte $F7, $02, $00, $03
P2_9622:  .word $0000, $0000, $3000   ;asteroid row 6: three words, then four bytes
P2_9628:  .byte $01, $07, $00, $03
P2_962C:  .word $4000, $4000, $4000   ;asteroid row 7: three words, then four bytes
P2_9632:  .byte $FF, $07, $00, $03
P2_9636:  .word $8000, $8000, $1000   ;asteroid row 8: three words, then four bytes
P2_963C:  .byte $02, $F8, $00, $03
P2_9640:  .word $C000, $C000, $1000   ;asteroid row 9: three words, then four bytes
P2_9646:  .byte $FE, $F8, $00, $03
P2_964A:  .word $2000, $A000, $0800   ;asteroid row 10: three words, then four bytes
P2_9650:  .byte $03, $05, $00, $03
P2_9654:  .word $6000, $E000, $1800   ;asteroid row 11: three words, then four bytes
P2_965A:  .byte $FD, $05, $00, $03

;------------------------------------------------------------------------------
; astrd_man_init - set-up of the asteroid pages of the training manual, called by man_init_asteroid with B = the
;   manual page. takes entry B of astrd_man_tab (entry 0 for page 3 and up) and makes the first record one
;   asteroid at rest $1000 ahead of the player with that entry's spin rates, frees the other nine records, puts
;   objects $20-$22 into the math box and sets astrd_max to 0 so that nothing is launched
;------------------------------------------------------------------------------
astrd_man_init:
P2_965E:  LDX  #astrd_man_tab
P2_9661:  LDA  #$0A                   ;10 bytes an entry
P2_9663:  MUL
P2_9664:  CMPB #$1E                   ;manual page 3 and up: entry 0
P2_9666:  BCS  P2_966A
P2_9668:  LDB  #$00
P2_966A:  ABX
P2_966B:  LDU  #ALIENZ
P2_966E:  LDA  #$00
P2_9670:  STA  1,U
P2_9672:  LDD  ,X++
P2_9674:  STD  6,U
P2_9676:  LDD  ,X++
P2_9678:  STD  8,U
P2_967A:  LDD  ,X++
P2_967C:  STD  10,U
P2_967E:  LDA  ,X+
P2_9680:  STA  $13,U
P2_9683:  LDA  ,X+
P2_9685:  STA  $15,U
P2_9688:  LDD  ,X++
P2_968A:  STA  5,U
P2_968C:  STB  ,U                     ;status 1: in use, position relative to the player
P2_968E:  LDA  #$01                   ;movement type 1: stay
P2_9690:  STA  4,U
P2_9692:  LDD  #$0000
P2_9695:  STD  12,U
P2_9697:  LEAU $17,U
P2_969A:  CMPU #ALIENZ+$17            ;the end of the first record: only one asteroid is set up
P2_969E:  BCS  P2_966E
P2_96A0:  LDA  #$00                   ;the other nine records are freed
P2_96A2:  STA  ,U
P2_96A4:  LEAU $17,U
P2_96A7:  CMPU #MESBLK
P2_96AB:  BCS  P2_96A2
P2_96AD:  LDB  #$20
P2_96AF:  JSR  L60A8
P2_96B2:  LDB  #$21
P2_96B4:  JSR  L60A8
P2_96B7:  LDB  #$22
P2_96B9:  JSR  L60A8
P2_96BC:  LDA  #$00                   ;nothing is launched
P2_96BE:  STA  astrd_max
P2_96C1:  RTS

astrd_man_tab:
P2_96C2:  .word $1000, $0000, $0000   ;asteroid manual row 0: three words, then four bytes  one entry per manual page 0-2: x, y, z words, yaw rate, pitch rate, size index, status
P2_96C8:  .byte $02, $02, $01, $01
P2_96CC:  .word $1000, $0000, $0000   ;asteroid manual row 1: three words, then four bytes
P2_96D2:  .byte $FD, $02, $01, $01
P2_96D6:  .word $1000, $0000, $0000   ;asteroid manual row 2: three words, then four bytes
P2_96DC:  .byte $03, $01, $01, $01

;------------------------------------------------------------------------------
; astrd_move_all - one frame of the asteroid field, called by the asteroid phase ($2C), by the death in the
;   field (phase $3C) and by the manual. counts the launch delay down and, when it is 0 and one of the first
;   astrd_max records is free, launches an asteroid into it (astrd_launch) and takes the next delay from
;   astrd_delay_tab by w4_level + diff_adder. when the field is stopped (astrd_max minus) it frees every asteroid
;   that was not in view in the last frame. then spins and moves every record in use
;------------------------------------------------------------------------------
astrd_move_all:
P2_96E0:  LDA  astrd_delay            ;launch delay, counted down to 0
P2_96E3:  DECA
P2_96E4:  BGE  P2_96E7
P2_96E6:  CLRA
P2_96E7:  STA  astrd_delay
P2_96EA:  BGT  P2_971D
P2_96EC:  LDB  astrd_max              ;B = how many records may be in use, none when the field is stopped
P2_96EF:  BLE  P2_971D
P2_96F1:  LDU  #ALIENZ
P2_96F4:  LDA  ,U
P2_96F6:  BNE  P2_9711
P2_96F8:  JSR  astrd_launch           ;a free record among the first astrd_max: launch into it
P2_96FB:  LDB  w4_level
P2_96FE:  ADDB diff_adder
P2_9701:  CMPB #$2C                   ;level + difficulty, 44 at most
P2_9703:  BLS  P2_9707
P2_9705:  LDB  #$2C
P2_9707:  LDX  #astrd_delay_tab
P2_970A:  LDB  B,X
P2_970C:  STB  astrd_delay            ;frames until the next launch
P2_970F:  BRA  P2_971D
P2_9711:  DECB
P2_9712:  BLE  P2_971D
P2_9714:  LEAU $17,U
P2_9717:  CMPU #MESBLK
P2_971B:  BCS  P2_96F4
P2_971D:  LDB  astrd_max
P2_9720:  BGE  P2_973E                ;field stopped (astrd_max minus)?
P2_9722:  LDU  #ALIENZ
P2_9725:  LDA  ,U
P2_9727:  BEQ  P2_9735
P2_9729:  LDA  1,U
P2_972B:  BITA #$10                   ;flag bit 4: it was in view in the last frame, keep it
P2_972D:  BNE  P2_9735
P2_972F:  LDA  #$00
P2_9731:  STA  ,U
P2_9733:  STA  1,U
P2_9735:  LEAU $17,U
P2_9738:  CMPU #MESBLK
P2_973C:  BCS  P2_9725
P2_973E:  LDU  #ALIENZ                ;spin and move every record in use
P2_9741:  LDA  ,U
P2_9743:  BEQ  P2_974B
P2_9745:  JSR  astrd_spin
P2_9748:  JSR  astrd_move_one
P2_974B:  LEAU $17,U
P2_974E:  CMPU #MESBLK
P2_9752:  BCS  P2_9741
P2_9754:  RTS

astrd_delay_tab:
P2_9755:  .byte $0C, $09, $09, $08, $08, $08, $07, $07 ;frames between launches by w4_level + diff_adder 0-44: 12 down to 2
P2_975D:  .byte $07, $07, $06, $06, $06, $06, $06, $05
P2_9765:  .byte $05, $05, $05, $05, $05, $04, $04, $04
P2_976D:  .byte $04, $04, $04, $04, $03, $03, $03, $03
P2_9775:  .byte $03, $03, $03, $03, $02, $02, $02, $02
P2_977D:  .byte $02, $02, $02, $02, $02

;------------------------------------------------------------------------------
; astrd_spin - turns the asteroid at U: adds the yaw rate (byte $13) to the yaw angle (byte $12) and the pitch
;   rate (byte $15) to the pitch angle (byte $14)
;------------------------------------------------------------------------------
astrd_spin:
P2_9782:  LDA  $12,U
P2_9785:  ADDA $13,U
P2_9788:  STA  $12,U
P2_978B:  LDA  $14,U
P2_978E:  ADDA $15,U
P2_9791:  STA  $14,U
P2_9794:  RTS

astrd_move_tab:
P2_9795:  .word astrd_mv_follow       ;movement routines by type 0-6, byte 4 of the record
P2_9797:  .word astrd_mv_stay
P2_9799:  .word astrd_mv_close
P2_979B:  .word astrd_mv_home
P2_979D:  .word astrd_mv_straight
P2_979F:  .word astrd_mv_home_y
P2_97A1:  .word astrd_mv_home_z

;------------------------------------------------------------------------------
; astrd_move_one - moves the asteroid at U: runs the hit flash timer (astrd_flash_tmr) and, if the record is
;   still in use, calls the movement routine of its type (byte 4, 0-6) through astrd_move_tab. X is preserved
;------------------------------------------------------------------------------
astrd_move_one:
P2_97A3:  PSHS X
P2_97A5:  JSR  astrd_flash_tmr
P2_97A8:  LDA  ,U
P2_97AA:  BEQ  P2_97BA
P2_97AC:  LDB  4,U
P2_97AE:  ASLB
P2_97AF:  CMPB #$0E                   ;type 7 and up does not occur: the 1 loaded for it is not a valid offset into the table
P2_97B1:  BCS  P2_97B5
P2_97B3:  LDB  #$01
P2_97B5:  LDX  #astrd_move_tab
P2_97B8:  JSR  [B,X]
P2_97BA:  PULS X,PC

;------------------------------------------------------------------------------
; astrd_flash_tmr - timer of the hit flash, byte 3 of the record at U: when it is running it goes down by 2 a
;   frame, and when it runs out with status bit 5 or 4 set the record is freed
;------------------------------------------------------------------------------
astrd_flash_tmr:
P2_97BC:  LDA  3,U                    ;byte 3: timer of the hit flash
P2_97BE:  BEQ  P2_97CF
P2_97C0:  DEC  3,U
P2_97C2:  DEC  3,U
P2_97C4:  BGT  P2_97CF
P2_97C6:  LDA  ,U
P2_97C8:  BITA #$30                   ;status bits 5 and 4
P2_97CA:  BEQ  P2_97CF
P2_97CC:  JSR  astrd_free
P2_97CF:  RTS

;------------------------------------------------------------------------------
; astrd_mv_follow - movement type 0, reached through astrd_move_tab: only makes the position relative to the
;   player (astrd_to_rel), so the asteroid keeps its place in front of the ship. astrd_hit_player gives this type
;   to an asteroid that has hit, whose record then holds a screen position and is left alone
;------------------------------------------------------------------------------
astrd_mv_follow:
P2_97D0:  JSR  astrd_to_rel
P2_97D3:  RTS

;------------------------------------------------------------------------------
; astrd_mv_stay - movement type 1, reached through astrd_move_tab: only makes the position a universe position
;   (astrd_to_univ), so the asteroid stays where it is and the player flies past. the type of the manual's
;   asteroid
;------------------------------------------------------------------------------
astrd_mv_stay:
P2_97D4:  JSR  astrd_to_univ
P2_97D7:  RTS

;------------------------------------------------------------------------------
; astrd_mv_close - movement type 2, reached through astrd_move_tab: with the position relative to the player it
;   takes a quarter off x and a sixteenth off y and z each frame, and changes to type 1 once x is under $1000. no
;   instruction was found that gives a record this type
;------------------------------------------------------------------------------
astrd_mv_close:
P2_97D8:  JSR  astrd_to_rel
P2_97DB:  LDD  #$0000                 ;x = x - x/4
P2_97DE:  SUBD 6,U
P2_97E0:  JSR  ASRD2
P2_97E3:  ADDD 6,U
P2_97E5:  STD  6,U
P2_97E7:  LDD  #$0000                 ;y = y - y/16
P2_97EA:  SUBD 8,U
P2_97EC:  JSR  ASRD4_B0
P2_97EF:  ADDD 8,U
P2_97F1:  STD  8,U
P2_97F3:  LDD  #$0000                 ;z = z - z/16
P2_97F6:  SUBD 10,U
P2_97F8:  JSR  ASRD4_B0
P2_97FB:  ADDD 10,U
P2_97FD:  STD  10,U
P2_97FF:  LDD  6,U
P2_9801:  CMPD #$1000                 ;nearer than $1000: type 1, stay there
P2_9805:  BCC  P2_980B
P2_9807:  LDA  #$01
P2_9809:  STA  4,U
P2_980B:  RTS

;------------------------------------------------------------------------------
; astrd_mv_home - movement type 3, reached through astrd_move_tab: homes on the player. with the position
;   relative to the player the velocity (words 12, 14, $10) becomes minus 1/32 of the position on each axis and is
;   added, then the position is made a universe position again. when the y and z velocities are both $0200 or less
;   in size the type becomes 4, straight flight with that velocity. only the preset of astrd_init gives this type,
;   to records it leaves free
;------------------------------------------------------------------------------
astrd_mv_home:
P2_980C:  JSR  astrd_to_rel
P2_980F:  LDD  #$0000                 ;x velocity = -x/32, kept in word 12
P2_9812:  SUBD 6,U
P2_9814:  JSR  ASRD5_B0
P2_9817:  STD  12,U
P2_9819:  ADDD 6,U
P2_981B:  STD  6,U
P2_981D:  LDD  #$0000                 ;y velocity = -y/32, kept in word 14
P2_9820:  SUBD 8,U
P2_9822:  JSR  ASRD5_B0
P2_9825:  STD  14,U
P2_9827:  ADDD 8,U
P2_9829:  STD  8,U
P2_982B:  LDD  #$0000                 ;z velocity = -z/32, kept in word $10
P2_982E:  SUBD 10,U
P2_9830:  JSR  ASRD5_B0
P2_9833:  STD  $10,U
P2_9836:  ADDD 10,U
P2_9838:  STD  10,U
P2_983A:  JSR  astrd_to_univ
P2_983D:  LDD  14,U                   ;size of the y velocity
P2_983F:  BPL  P2_9845
P2_9841:  COMA
P2_9842:  NEGB
P2_9843:  SBCA #$FF
P2_9845:  SUBD #$0200
P2_9848:  BHI  P2_985C
P2_984A:  LDD  $10,U                  ;size of the z velocity
P2_984D:  BPL  P2_9853
P2_984F:  COMA
P2_9850:  NEGB
P2_9851:  SBCA #$FF
P2_9853:  SUBD #$0200
P2_9856:  BHI  P2_985C
P2_9858:  LDA  #$04                   ;both $0200 or less: type 4, straight on
P2_985A:  STA  4,U
P2_985C:  LDD  6,U
P2_985E:  SUBD s1_tx
P2_9861:  CMPD #$0000                 ;the carry is always clear after a compare with 0, so the branch is always taken and type 1 is never set here
P2_9865:  BCC  P2_986B
P2_9867:  LDA  #$01
P2_9869:  STA  4,U
P2_986B:  RTS

;------------------------------------------------------------------------------
; astrd_mv_home_y - movement type 5, reached through astrd_move_tab: astrd_mv_home with the y velocity minus
;   1/16 of the y position instead of 1/32. one of the two types astrd_launch picks at random
;------------------------------------------------------------------------------
astrd_mv_home_y:
P2_986C:  JSR  astrd_to_rel
P2_986F:  LDD  #$0000
P2_9872:  SUBD 6,U
P2_9874:  JSR  ASRD5_B0
P2_9877:  STD  12,U
P2_9879:  ADDD 6,U
P2_987B:  STD  6,U
P2_987D:  LDD  #$0000
P2_9880:  SUBD 8,U
P2_9882:  JSR  ASRD4_B0               ;y closes by 1/16 a frame
P2_9885:  STD  14,U
P2_9887:  ADDD 8,U
P2_9889:  STD  8,U
P2_988B:  LDD  #$0000
P2_988E:  SUBD 10,U
P2_9890:  JSR  ASRD5_B0
P2_9893:  STD  $10,U
P2_9896:  ADDD 10,U
P2_9898:  STD  10,U
P2_989A:  JSR  astrd_to_univ
P2_989D:  LDD  14,U
P2_989F:  BPL  P2_98A5
P2_98A1:  COMA
P2_98A2:  NEGB
P2_98A3:  SBCA #$FF
P2_98A5:  SUBD #$0200
P2_98A8:  BHI  P2_98BC
P2_98AA:  LDD  $10,U
P2_98AD:  BPL  P2_98B3
P2_98AF:  COMA
P2_98B0:  NEGB
P2_98B1:  SBCA #$FF
P2_98B3:  SUBD #$0200
P2_98B6:  BHI  P2_98BC
P2_98B8:  LDA  #$04                   ;both sideways velocities $0200 or less: type 4, straight on
P2_98BA:  STA  4,U
P2_98BC:  LDD  6,U
P2_98BE:  SUBD s1_tx
P2_98C1:  CMPD #$0000                 ;always followed by the branch, as at P2_9861
P2_98C5:  BCC  P2_98CB
P2_98C7:  LDA  #$01
P2_98C9:  STA  4,U
P2_98CB:  RTS

;------------------------------------------------------------------------------
; astrd_mv_home_z - movement type 6, reached through astrd_move_tab: astrd_mv_home with the z velocity minus
;   1/16 of the z position instead of 1/32. the other type astrd_launch picks
;------------------------------------------------------------------------------
astrd_mv_home_z:
P2_98CC:  JSR  astrd_to_rel
P2_98CF:  LDD  #$0000
P2_98D2:  SUBD 6,U
P2_98D4:  JSR  ASRD5_B0
P2_98D7:  STD  12,U
P2_98D9:  ADDD 6,U
P2_98DB:  STD  6,U
P2_98DD:  LDD  #$0000
P2_98E0:  SUBD 8,U
P2_98E2:  JSR  ASRD5_B0
P2_98E5:  STD  14,U
P2_98E7:  ADDD 8,U
P2_98E9:  STD  8,U
P2_98EB:  LDD  #$0000
P2_98EE:  SUBD 10,U
P2_98F0:  JSR  ASRD4_B0               ;z closes by 1/16 a frame
P2_98F3:  STD  $10,U
P2_98F6:  ADDD 10,U
P2_98F8:  STD  10,U
P2_98FA:  JSR  astrd_to_univ
P2_98FD:  LDD  14,U
P2_98FF:  BPL  P2_9905
P2_9901:  COMA
P2_9902:  NEGB
P2_9903:  SBCA #$FF
P2_9905:  SUBD #$0200
P2_9908:  BHI  P2_991C
P2_990A:  LDD  $10,U
P2_990D:  BPL  P2_9913
P2_990F:  COMA
P2_9910:  NEGB
P2_9911:  SBCA #$FF
P2_9913:  SUBD #$0200
P2_9916:  BHI  P2_991C
P2_9918:  LDA  #$04                   ;both sideways velocities $0200 or less: type 4, straight on
P2_991A:  STA  4,U
P2_991C:  LDD  6,U
P2_991E:  SUBD s1_tx
P2_9921:  CMPD #$0000                 ;always followed by the branch, as at P2_9861
P2_9925:  BCC  P2_992B
P2_9927:  LDA  #$01
P2_9929:  STA  4,U
P2_992B:  RTS

;------------------------------------------------------------------------------
; astrd_mv_straight - movement type 4, reached through astrd_move_tab: makes the position a universe position
;   and adds the velocity words 12, 14 and $10 to it, a straight flight with the velocity the homing types left
;------------------------------------------------------------------------------
astrd_mv_straight:
P2_992C:  JSR  astrd_to_univ
P2_992F:  LDD  12,U
P2_9931:  ADDD 6,U
P2_9933:  STD  6,U
P2_9935:  LDD  14,U
P2_9937:  ADDD 8,U
P2_9939:  STD  8,U
P2_993B:  LDD  $10,U
P2_993E:  ADDD 10,U
P2_9940:  STD  10,U
P2_9942:  RTS

;------------------------------------------------------------------------------
; astrd_to_rel - if the position of the asteroid at U is a universe position (status bit 6 set) it takes the
;   player's position (s1_tx, s1_ty, s1_tz) off x, y and z and clears the bit: the position is now relative to the
;   player
;------------------------------------------------------------------------------
astrd_to_rel:
P2_9943:  LDA  ,U
P2_9945:  BITA #$40                   ;status bit 6: the position is a universe position
P2_9947:  BEQ  P2_9962
P2_9949:  ANDA #$BF
P2_994B:  STA  ,U
P2_994D:  LDD  6,U
P2_994F:  SUBD s1_tx                  ;less the player's x
P2_9952:  STD  6,U
P2_9954:  LDD  8,U
P2_9956:  SUBD s1_ty
P2_9959:  STD  8,U
P2_995B:  LDD  10,U
P2_995D:  SUBD s1_tz
P2_9960:  STD  10,U
P2_9962:  RTS

;------------------------------------------------------------------------------
; astrd_to_univ - the reverse of astrd_to_rel: if the position of the asteroid at U is relative to the player
;   (status bit 6 clear) it adds the player's position to x, y and z and sets the bit
;------------------------------------------------------------------------------
astrd_to_univ:
P2_9963:  LDA  ,U
P2_9965:  BITA #$40                   ;status bit 6 set: a universe position already
P2_9967:  BNE  P2_9982
P2_9969:  ORA  #$40
P2_996B:  STA  ,U
P2_996D:  LDD  s1_tx                  ;plus the player's x
P2_9970:  ADDD 6,U
P2_9972:  STD  6,U
P2_9974:  LDD  s1_ty
P2_9977:  ADDD 8,U
P2_9979:  STD  8,U
P2_997B:  LDD  s1_tz
P2_997E:  ADDD 10,U
P2_9980:  STD  10,U
P2_9982:  RTS

;------------------------------------------------------------------------------
; astrd_view_all - views the asteroid records, called with Y at the display list by the view routines of the
;   asteroid phase (LA5F9), of the death in the field (LA66A) and of the manual (man_view_asteroid). for every
;   record in use, with S2_PRM pointing at it: one that has hit the player (status bit 5) gets its flash drawn
;   (astrd_flash_view), any other has its flags byte cleared and is viewed by astrd_view_one
;------------------------------------------------------------------------------
astrd_view_all:
P2_9983:  LDU  #ALIENZ
P2_9986:  STU  S2_PRM
P2_9988:  LDA  ,U
P2_998A:  BEQ  P2_999E
P2_998C:  BITA #$20                   ;status bit 5: it has hit the player, only the flash is shown
P2_998E:  BEQ  P2_9995
P2_9990:  JSR  astrd_flash_view
P2_9993:  BRA  P2_999E
P2_9995:  LDA  1,U
P2_9997:  ANDA #$00                   ;flags cleared: not in view so far
P2_9999:  STA  1,U
P2_999B:  JSR  astrd_view_one
P2_999E:  LEAU $17,U
P2_99A1:  CMPU #MESBLK
P2_99A5:  BCS  P2_9986
P2_99A7:  RTS

;------------------------------------------------------------------------------
; astrd_view_one - views the asteroid at U. its universe position goes through the math box (MS_PSB2 on the
;   scratch block) to give its place in the player's view. it is freed when its distance ahead is $0100 or less or
;   when it is outside the view to the side or above or below. otherwise flag bit 4 (in view) is set, the asteroid
;   hits the player (astrd_hit_player) when its distance is no more than its own x speed plus the player's plus
;   $0200, and it is drawn (astrd_draw)
;------------------------------------------------------------------------------
astrd_view_one:
P2_99A8:  LDA  ,U
P2_99AA:  BITA #$40                   ;status bit 6 clear: add the player's position
P2_99AC:  BEQ  P2_99BF
P2_99AE:  LDD  6,U
P2_99B0:  STD  M_X0
P2_99B3:  LDD  8,U
P2_99B5:  STD  M_Y0
P2_99B8:  LDD  10,U
P2_99BA:  STD  M_Z0
P2_99BD:  BRA  P2_99D7
P2_99BF:  LDD  6,U
P2_99C1:  ADDD s1_tx                  ;the player's x
P2_99C4:  STD  M_X0
P2_99C7:  LDD  8,U
P2_99C9:  ADDD s1_ty
P2_99CC:  STD  M_Y0
P2_99CF:  LDD  10,U
P2_99D1:  ADDD s1_tz
P2_99D4:  STD  M_Z0                   ;scratch block point = the asteroid's universe position
P2_99D7:  LDD  #MS_X0BC
P2_99DA:  STD  M_BIC
P2_99DD:  LDA  #MS_PSB2
P2_99DF:  JSR  MGOWT
P2_99E2:  LDD  M_XP
P2_99E5:  STD  M_XT
P2_99E8:  STD  M_DVD                  ;starts the divide for the perspective
P2_99EB:  CMPD #$0100                 ;$0100 or less ahead: gone
P2_99EF:  LBLE astrd_free
P2_99F3:  LDD  M_YP
P2_99F6:  STD  M_YT
P2_99F9:  BPL  P2_99FF                ;IFMI
P2_99FB:  COMA                        ;NEGD
P2_99FC:  NEGB
P2_99FD:  SBCA #$FF
P2_99FF:  SUBD M_XP
P2_9A02:  LBHS astrd_free             ;as far to the side as ahead, or more: out of view, gone
P2_9A06:  LDD  M_ZP
P2_9A09:  STD  M_ZT
P2_9A0C:  BPL  P2_9A12                ;IFMI
P2_9A0E:  COMA                        ;NEGD
P2_9A0F:  NEGB
P2_9A10:  SBCA #$FF
P2_9A12:  SUBD M_XP
P2_9A15:  LBHS astrd_free             ;the same up and down
P2_9A19:  LDA  1,U
P2_9A1B:  ORA  #$10                   ;flag bit 4: in view this frame
P2_9A1D:  STA  1,U
P2_9A1F:  LDD  12,U
P2_9A21:  BPL  P2_9A27                ;IFMI
P2_9A23:  COMA                        ;NEGD  ABSD
P2_9A24:  NEGB
P2_9A25:  SBCA #$FF
P2_9A27:  ADDD s1_vx                  ;size of its x velocity + the player's speed + $0200
P2_9A2A:  ADDD #$0200
P2_9A2D:  CMPD M_XP
P2_9A31:  BLT  P2_9A36                ;no farther than that: it hits the player
P2_9A33:  JSR  astrd_hit_player
P2_9A36:  JSR  astrd_draw
P2_9A39:  RTS

;------------------------------------------------------------------------------
; astrd_draw - draws the asteroid of S2_PRM at the place astrd_view_one left in M_XT, M_YT, M_ZT: fresh unit
;   vectors in the ship 2 download block are yawed and pitched by the record's two angles and concatenated with
;   the player's view (MS_CNCT), bank 1 projects the points of object $21, the lazar test astrd_lz_test is made,
;   and the object is drawn in the colour of its size index
;------------------------------------------------------------------------------
astrd_draw:
P2_9A3A:  LDU  #M_CX2                 ;unit vectors into the ship 2 download block
P2_9A3D:  JSR  UNITV
P2_9A40:  LDU  S2_PRM
P2_9A42:  LDD  #$0009                 ;block 9, the ship 2 download block
P2_9A45:  STD  M_BIC
P2_9A48:  LDB  $12,U                  ;yaw angle
P2_9A4B:  JSR  yaw_by_angle
P2_9A4E:  LDD  #$0009
P2_9A51:  STD  M_BIC
P2_9A54:  LDB  $14,U                  ;pitch angle
P2_9A57:  JSR  pitch_by_angle
P2_9A5A:  LDA  #$40                   ;MS_CNCT: view ship 2 from ship 1
P2_9A5C:  JSR  MGOWT
P2_9A5F:  LDX  #astrd_obj_tab
P2_9A62:  LDB  #$01                   ;the index is always 1: object $21 whatever the size index
P2_9A64:  ANDB #$03
P2_9A66:  LDB  B,X
P2_9A68:  JSR  L60D2                  ;bank 1 JOBJBPNT: project the object's points
P2_9A6B:  JSR  astrd_lz_test
P2_9A6E:  LDX  #astrd_col_tab
P2_9A71:  LDB  5,U                    ;colour by size index
P2_9A73:  ANDB #$03
P2_9A75:  ASLB
P2_9A76:  LDD  B,X
P2_9A78:  STD  ,Y++
P2_9A7A:  JSR  L60E4                  ;bank 1: draw the object
P2_9A7D:  JSR  L60BA                  ;bank 1: beam back to the centre
P2_9A80:  RTS

astrd_obj_tab:
P2_9A81:  .byte $20, $21, $22, $22    ;object number by index: $20 radius 1000, $21 radius 500, $22

astrd_col_tab:
P2_9A85:  .word $62C0                 ;STAT colour 2, brightness $C0  colour instruction by size index: $62C0, then $6280 three times
P2_9A87:  .word $6280                 ;STAT colour 2, brightness $80
P2_9A89:  .word $6280                 ;STAT colour 2, brightness $80
P2_9A8B:  .word $6280                 ;STAT colour 2, brightness $80

;------------------------------------------------------------------------------
; astrd_flash_view - view of an asteroid that has hit the player: a blank vector from the screen centre to the
;   screen position astrd_hit_player saved in words 6 and 8, then falls into astrd_flash_draw
;------------------------------------------------------------------------------
astrd_flash_view:
P2_9A8D:  LDD  6,U                    ;blank vector to the saved screen position: y
P2_9A8F:  ANDA #$1F
P2_9A91:  STD  ,Y++
P2_9A93:  LDD  8,U                    ;x, intensity 0
P2_9A95:  ANDA #$1F
P2_9A97:  STD  ,Y++

;------------------------------------------------------------------------------
; astrd_flash_draw - draws the hit flash at the beam's position: a scale instruction and a colour 7 instruction
;   that both take their low byte from the flash timer (byte 3) times 16, then the picture whose JSRL is at index
;   byte $16 of bank 0's table LB962, and bank 1 brings the beam back to the centre. entered from astrd_hit_player
;   for the first frame and by falling in from astrd_flash_view after that
;------------------------------------------------------------------------------
astrd_flash_draw:
P2_9A99:  LDA  3,U                    ;scale instruction $70nn, nn = flash timer * 16
P2_9A9B:  LDB  #$10
P2_9A9D:  MUL
P2_9A9E:  LDA  #$70
P2_9AA0:  STD  ,Y++
P2_9AA2:  LDB  3,U                    ;colour 7, brightness = flash timer * 16
P2_9AA4:  ASLB
P2_9AA5:  ASLB
P2_9AA6:  ASLB
P2_9AA7:  ASLB
P2_9AA8:  LDA  #$67
P2_9AAA:  STD  ,Y++
P2_9AAC:  LDX  #aflash_tab            ;bank 0's table of picture JSRLs
P2_9AAF:  LDB  $16,U
P2_9AB2:  LDD  B,X
P2_9AB4:  STD  ,Y++
P2_9AB6:  JSR  L60BA                  ;bank 1: beam back to the centre
P2_9AB9:  RTS

;------------------------------------------------------------------------------
; astrd_hit_player - an asteroid at U has run into the player. bank 1 draws the vector to its centre and the y
;   and x of that vector are saved in words 6 and 8 as the screen position of the flash, picture index 8, status
;   bit 5 set (bits 6, 3 and 0 cleared), type 0, flash timer $0F. the ship starts to glow (BG1GLW, which costs a
;   shield), the roll after a hit is cancelled, the shield and asteroid hit sounds are sent and the first frame of
;   the flash is drawn
;------------------------------------------------------------------------------
astrd_hit_player:
P2_9ABA:  JSR  L60B4                  ;bank 1 BJCNTR: vector from the screen centre to the asteroid's centre
P2_9ABD:  LDD  -4,Y                   ;its y, 13 bits made 16
P2_9ABF:  BITA #$10
P2_9AC1:  BEQ  P2_9AC5
P2_9AC3:  ORA  #$F0
P2_9AC5:  STD  6,U
P2_9AC7:  LDD  -2,Y                   ;its x
P2_9AC9:  BITA #$10
P2_9ACB:  BEQ  P2_9ACF
P2_9ACD:  ORA  #$F0
P2_9ACF:  STD  8,U
P2_9AD1:  LDB  #$08                   ;picture index 8: the JSRL at LB96A
P2_9AD3:  STB  $16,U
P2_9AD6:  LDA  ,U
P2_9AD8:  ORA  #$20                   ;status: bit 5 on, bits 6, 3 and 0 off
P2_9ADA:  ANDA #$B6
P2_9ADC:  STA  ,U
P2_9ADE:  LDA  #$00                   ;movement type 0
P2_9AE0:  STA  4,U
P2_9AE2:  LDA  #$0F                   ;flash timer, 2 off a frame: 8 frames
P2_9AE4:  STA  3,U
P2_9AE6:  JSR  BG1GLW
P2_9AE9:  LDA  >S_ROL                 ;the roll after a hit is cancelled
P2_9AEC:  BEQ  P2_9AF3
P2_9AEE:  LDB  #$00
P2_9AF0:  STB  >S_ROL
P2_9AF3:  JSR  aud_cmd_3a
P2_9AF6:  JSR  aud_cmd_49
P2_9AF9:  JSR  astrd_flash_draw
P2_9AFC:  RTS

;------------------------------------------------------------------------------
; astrd_free - frees the asteroid record at U: status and flags bytes 0
;------------------------------------------------------------------------------
astrd_free:
P2_9AFD:  LDA  #$00
P2_9AFF:  STA  ,U
P2_9B01:  STA  1,U
P2_9B03:  RTS

;------------------------------------------------------------------------------
; astrd_launch - launches an asteroid into the free record at U: status $41 (in use, universe position), flags,
;   flash timer and size index 0, movement type 5 or 6 by the sign of a random byte, a random yaw rate of 0-7
;   either way, and a second random value up to 7 either way stored in the pitch angle. the scratch point x $7000
;   with random y and z, a point far ahead in the player's view, goes through math box program MS_S1UN and the
;   result, in universe coordinates, becomes the record's position
;------------------------------------------------------------------------------
astrd_launch:
P2_9B04:  JSR  rnd_set
P2_9B07:  LDA  #$41                   ;in use, universe position
P2_9B09:  STA  ,U
P2_9B0B:  LDA  #$00
P2_9B0D:  STA  1,U
P2_9B0F:  STA  3,U
P2_9B11:  LDA  #$00
P2_9B13:  STA  5,U
P2_9B15:  LDA  P_RND1                 ;movement type 5 or 6 by a random bit
P2_9B18:  BMI  P2_9B1E
P2_9B1A:  LDA  #$05
P2_9B1C:  BRA  P2_9B20
P2_9B1E:  LDA  #$06
P2_9B20:  STA  4,U
P2_9B22:  LDA  RND_S1                 ;yaw rate 0-7
P2_9B24:  LDB  #$08
P2_9B26:  MUL
P2_9B27:  STA  $13,U
P2_9B2A:  NEGA                        ;12 - yaw rate, 8 at most
P2_9B2B:  ADDA #$0C
P2_9B2D:  CMPA #$08
P2_9B2F:  BLE  P2_9B33
P2_9B31:  LDA  #$08
P2_9B33:  LDB  RND_S3                 ;times a random byte: 0-7
P2_9B35:  MUL
P2_9B36:  LDB  RND_S3
P2_9B38:  BPL  P2_9B3B
P2_9B3A:  NEGA
P2_9B3B:  STA  $14,U                  ;stored in the pitch angle. the pitch rate at $15 is the one astrd_init preset
P2_9B3E:  LSRB                        ;bit 0 of the random byte: yaw the other way
P2_9B3F:  BCC  P2_9B48
P2_9B41:  LDA  $13,U
P2_9B44:  NEGA
P2_9B45:  STA  $13,U
P2_9B48:  JSR  rnd_set
P2_9B4B:  LDD  #$7000                 ;scratch point: x $7000
P2_9B4E:  STD  0+M_X0
P2_9B51:  LDD  RND_S1
P2_9B53:  STD  2+M_X0                 ;LEFT/RIGHT VID X IS MATH Y
P2_9B56:  LDD  RND_S3
P2_9B58:  STD  4+M_X0                 ;UP/DOWN VID Y IS MATH Z
P2_9B5B:  LDD  #MS_X0BC
P2_9B5E:  STD  M_BIC
P2_9B61:  LDA  #MS_S1UN               ;MS_S1UN on the scratch block: from the player's view to universe coordinates
P2_9B63:  JSR  MGOWT
P2_9B66:  LDD  M_XP                   ;the result is the record's position
P2_9B69:  STD  6,U
P2_9B6B:  LDD  M_YP
P2_9B6E:  STD  8,U
P2_9B70:  LDD  M_ZP
P2_9B73:  STD  10,U
P2_9B75:  LDA  #$00
P2_9B77:  STA  5,U
P2_9B79:  RTS

;------------------------------------------------------------------------------
; astrd_oct_dist - octagon distance from the screen point in M_YP (x) and M_ZP (y) to the lazar cursor LZ_CX,
;   LZ_CY: the larger of the two absolute distances, or 9/16 of their sum if that is more, less 10 for the cursor,
;   not below 0. result in D. uses the temps at $4801 and $4803. called by astrd_lz_test
;------------------------------------------------------------------------------
astrd_oct_dist:
P2_9B7A:  LDD  M_YP
P2_9B7D:  SUBD >LZ_CX
P2_9B80:  BPL  P2_9B86                ;IFMI
P2_9B82:  COMA                        ;NEGD  ABSD
P2_9B83:  NEGB
P2_9B84:  SBCA #$FF
P2_9B86:  STD  TMPOCT                 ;PREPARE FOR OCTAGON COLLISION DETECT
P2_9B88:  STD  scratch_1
P2_9B8A:  LDD  M_ZP
P2_9B8D:  SUBD >LZ_CY
P2_9B90:  BPL  P2_9B96                ;IFMI
P2_9B92:  COMA                        ;NEGD
P2_9B93:  NEGB
P2_9B94:  SBCA #$FF
P2_9B96:  CMPD TMPSIZ                 ;$4803 = the larger of the two distances
P2_9B99:  BLE  P2_9B9D
P2_9B9B:  STD  scratch_3
P2_9B9D:  ADDD scratch_1              ;half the sum of the two
P2_9B9F:  LSRA
P2_9BA0:  RORB
P2_9BA1:  STD  scratch_1
P2_9BA3:  LSRA                        ;an eighth of that
P2_9BA4:  RORB
P2_9BA5:  LSRA
P2_9BA6:  RORB
P2_9BA7:  LSRA
P2_9BA8:  RORB
P2_9BA9:  ADDD scratch_1              ;9/16 of the sum
P2_9BAB:  CMPD scratch_3              ;the larger of the two measures
P2_9BAE:  BGE  P2_9BB2
P2_9BB0:  LDD  scratch_3
P2_9BB2:  SUBD #$000A                 ;less 10 for the cursor
P2_9BB5:  BGE  P2_9BBA
P2_9BB7:  LDD  #$0000
P2_9BBA:  RTS

astrd_size_tab:
P2_9BBB:  .word $03E8, $01F4, $00FA, $00FA ;asteroid radius by size index: 1000, 500, 250, 250

;------------------------------------------------------------------------------
; astrd_lz_test - lazar test of the asteroid being drawn (U = record, its view position in M_XT, M_YT, M_ZT),
;   called by astrd_draw. skipped when the asteroid is not nearer than astr_hit_d. it projects the radius of the
;   record's size index (astrd_size_tab) and the centre to the screen, and when the cursor's octagon distance to
;   the centre is less than that radius it records the asteroid as the nearest under the cursor: astr_hit_d = its
;   distance, astr_hit_rec = 0. X is preserved
;------------------------------------------------------------------------------
astrd_lz_test:
P2_9BC3:  LDD  M_XT
P2_9BC6:  CMPD astr_hit_d             ;not nearer than the nearest under the cursor so far: no test
P2_9BCA:  BCC  P2_9C08
P2_9BCC:  STD  M_DVD                  ;starts the divide: 1/distance
P2_9BCF:  LDA  5,U
P2_9BD1:  ANDA #$03
P2_9BD3:  ASLA
P2_9BD4:  STX  scratch_5              ;$4805 keeps X
P2_9BD6:  LDX  #astrd_size_tab
P2_9BD9:  LDD  A,X
P2_9BDB:  LDX  scratch_5
P2_9BDD:  STD  M_YP                   ;radius
P2_9BE0:  LDD  M_QUO
P2_9BE3:  STD  M_XP                   ;GET X FOR PROPER SCREEN CONVERSION
P2_9BE6:  LDA  #MS_PERS
P2_9BE8:  JSR  MGOWT
P2_9BEB:  LDD  M_YP
P2_9BEE:  STD  scratch_5              ;$4805 = radius on the screen
P2_9BF0:  LDD  M_YT
P2_9BF3:  STD  M_YP
P2_9BF6:  LDD  M_ZT
P2_9BF9:  STD  M_ZP
P2_9BFC:  LDA  #$86                   ;MS_PERS: the centre on the screen
P2_9BFE:  JSR  MGOWT
P2_9C01:  JSR  astrd_oct_dist
P2_9C04:  SUBD scratch_5              ;cursor inside the radius?
P2_9C06:  BLT  P2_9C09
P2_9C08:  RTS
P2_9C09:  LDD  #$0000                 ;no record: the lazar only splashes against it
P2_9C0C:  STD  astr_hit_rec
P2_9C0F:  LDD  M_XT                   ;its distance is the nearest so far
P2_9C12:  STD  astr_hit_d
P2_9C15:  RTS

;------------------------------------------------------------------------------
; astrd_lz_hit - loads U from astr_hit_rec and returns. reached through the maze from page 3 (P3_98C9) when the
;   lazar's nearest target is an asteroid whose astr_hit_rec is not 0 - which astrd_lz_test never makes it, so the
;   lazar only splashes against an asteroid and this entry is not reached
;------------------------------------------------------------------------------
astrd_lz_hit:
P2_9C16:  LDU  astr_hit_rec
P2_9C19:  RTS
P2_9C1A:  .byte $FF, $01, $9C, $20, $9C, $20, $9C, $1A ;not used by page 2: from $9C1B these bytes are the same as on page 0, where $9C1C is TSPWAV, the Star Wars table of space wave sets with its sets and scripts, to $9CA6. the pointers still read $9Cxx
P2_9C22:  .byte $9C, $5C, $00, $9C, $1A, $9C, $74, $00
P2_9C2A:  .byte $9C, $1A, $9C, $8C, $00, $9C, $1A, $9C
P2_9C32:  .byte $9E, $00, $9C, $1A, $9C, $9E, $00, $9C
P2_9C3A:  .byte $1A, $9C, $59, $9C, $1A, $9C, $5F, $00
P2_9C42:  .byte $9C, $1A, $9C, $71, $00, $9C, $1A, $9C
P2_9C4A:  .byte $89, $00, $9C, $1A, $9C, $9B, $00, $9C
P2_9C52:  .byte $1A, $9C, $59, $00, $24, $00, $00, $02
P2_9C5A:  .byte $9C, $A4, $44, $00, $10, $02, $9C, $A4
P2_9C62:  .byte $44, $02, $20, $02, $9C, $A4, $44, $01
P2_9C6A:  .byte $20, $14, $00, $08, $01, $9C, $6B, $02
P2_9C72:  .byte $9C, $A4, $24, $00, $14, $01, $9C, $83
P2_9C7A:  .byte $02, $9C, $A4, $02, $9C, $A4, $14, $00
P2_9C82:  .byte $22, $24, $02, $20, $00, $00, $00, $02
P2_9C8A:  .byte $9C, $A4, $24, $04, $10, $00, $00, $04
P2_9C92:  .byte $02, $9C, $A4, $02, $9C, $A4, $00, $00
P2_9C9A:  .byte $44, $02, $9C, $A4, $02, $9C, $A4, $02
P2_9CA2:  .byte $9C, $A4, $14, $00, $08, $AE, $4A, $8C ;from $9CA7 the bytes are code no routine of page 2 reaches: a second copy of the IRQ routine (bank 0 irq_handler) without its SWI traps and watchdog write, calling COINS and load_vg_set in bank 0 and the copies of DEBNCE ($9EEA), DOPOTS ($9EFD), RHCTRL ($9F44) and GNSITE ($9FE2) in the page's tail, into which it runs on at $9DCD
P2_9CAA:  .byte $60, $00, $24, $00, $8C, $EA, $80, $25
P2_9CB2:  .byte $05, $8C, $F0, $00, $24, $00, $86, $48
P2_9CBA:  .byte $1F, $8B, $96, $00, $81, $3F, $27, $00
P2_9CC2:  .byte $0A, $45, $2A, $08, $86, $0B, $97, $45
P2_9CCA:  .byte $0C, $44, $28, $00, $0C, $0A, $0C, $CC
P2_9CD2:  .byte $BD, $C6, $7A, $96, $15, $81, $24, $25
P2_9CDA:  .byte $00, $8E, $48, $1D, $B6, $43, $00, $BD
P2_9CE2:  .byte $9E, $EA, $B6, $43, $20, $BD, $9E, $EA
P2_9CEA:  .byte $B6, $43, $40, $BD, $9E, $EA, $B6, $43
P2_9CF2:  .byte $60, $BD, $9E, $EA, $96, $34, $97, $35
P2_9CFA:  .byte $B6, $48, $22, $84, $30, $A7, $7F, $B6
P2_9D02:  .byte $48, $1F, $84, $CF, $AA, $7F, $97, $34
P2_9D0A:  .byte $98, $35, $94, $35, $97, $33, $96, $33
P2_9D12:  .byte $84, $F0, $27, $04, $9A, $32, $97, $32
P2_9D1A:  .byte $BD, $9E, $FD, $96, $0A, $26, $15, $B6
P2_9D22:  .byte $44, $01, $48, $2A, $07, $B6, $44, $00
P2_9D2A:  .byte $81, $D3, $27, $08, $B7, $46, $E0, $86
P2_9D32:  .byte $00, $B7, $44, $00, $96, $0A, $84, $03
P2_9D3A:  .byte $26, $48, $B6, $48, $1C, $8B, $01, $81
P2_9D42:  .byte $FA, $25, $02, $86, $00, $B7, $48, $1C
P2_9D4A:  .byte $26, $38, $B6, $48, $1B, $8B, $01, $19
P2_9D52:  .byte $B7, $48, $1B, $B6, $48, $1A, $89, $00
P2_9D5A:  .byte $19, $25, $03, $B7, $48, $1A, $B6, $4C
P2_9D62:  .byte $38, $8B, $01, $19, $B7, $4C, $38, $B6
P2_9D6A:  .byte $4C, $37, $89, $00, $19, $B7, $4C, $37
P2_9D72:  .byte $B6, $4C, $36, $89, $00, $19, $B7, $4C
P2_9D7A:  .byte $36, $B6, $4C, $35, $89, $00, $19, $B7
P2_9D82:  .byte $4C, $35, $0A, $47, $28, $0C, $B7, $46
P2_9D8A:  .byte $20, $F6, $48, $CD, $BD, $A3, $42, $7E ;the copy's JMP to $9EE6, the tail's copy of DOVG_90
P2_9D92:  .byte $9E, $E6, $10, $2A, $01, $4E, $B6, $43
P2_9D9A:  .byte $20, $48, $10, $2A, $01, $46, $96, $46
P2_9DA2:  .byte $2A, $19, $B6, $00, $00, $84, $0A, $27
P2_9DAA:  .byte $02, $86, $14, $8A, $00, $97, $46, $C6
P2_9DB2:  .byte $1D, $44, $84, $0A, $88, $0A, $8A, $E0
P2_9DBA:  .byte $FD, $00, $00, $0A, $29, $2A, $05, $0F
P2_9DC2:  .byte $29, $BD, $9F, $44, $BD, $9F, $E2, $D6
P2_9DCA:  .byte $41, $CB, $02, $C1, $10, $25, $01, $5F ;from $9DCD to the end of the page the bytes are the same on all four pages (see irq_old_tail on page 0)
P2_9DD2:  .byte $D7, $41, $8E, $00, $04, $3A, $CE, $B9
P2_9DDA:  .byte $22, $EC, $C1, $ED, $83, $8C, $00, $02
P2_9DE2:  .byte $2E, $F7, $8E, $00, $12, $11, $83, $B9
P2_9DEA:  .byte $32, $24, $06, $EC, $C1, $ED, $83, $20
P2_9DF2:  .byte $F4, $D6, $42, $CB, $02, $8E, $9E, $02
P2_9DFA:  .byte $F6, $4C, $5A, $3A, $A6, $00, $48, $39 ;$9DFE: LDA 0,X / ASLA / RTS, the helper page 1 calls for the slapstic's alternate sequence. nothing calls it on this page
P2_9E02:  .byte $00, $00, $00, $FF, $00, $00, $FF, $00 ;16 bytes of $00 and $FF that the LDX #$9E02 at $9DF7 points at, read by nothing
P2_9E0A:  .byte $FF, $00, $FF, $FF, $00, $FF, $FF, $FF
P2_9E12:  .byte $C1, $08, $25, $01, $5F, $D7, $38, $CE
P2_9E1A:  .byte $B9, $3A, $EC, $C5, $FD, $00, $1A, $D6
P2_9E22:  .byte $38, $CE, $B9, $42, $EC, $C5, $FD, $00
P2_9E2A:  .byte $1E, $0A, $39

;------------------------------------------------------------------------------
; irq_old_tail_p2 - not a routine start: the middle of the leftover copy of bank 0's irq_handler, the same bytes
;   as on page 0, where irq_old_tail describes it. on this page the copy starts at $9CA7, after the leftover wave
;   tables from $9C1B. nothing runs it: the one live routine of the tail $9DCD-$9FFF, the helper at $9DFE, is
;   called on page 1 only
;------------------------------------------------------------------------------
irq_old_tail_p2:
P2_9E2D:  BGT  P2_9E46
P2_9E2F:  LDB  #$01
P2_9E31:  STB  pic1c_timer

;===LAZAR SPLASH
DOVG_48_P2:
P2_9E33:  LDB  pic1c_index
P2_9E35:  ADDB #$02
P2_9E37:  CMPB #$08
P2_9E39:  BLO  P2_9E3C                ;IFHS
P2_9E3B:  CLRB
P2_9E3C:  STB  pic1c_index
P2_9E3E:  LDU  #VTGNT
P2_9E41:  LDD  B,U
P2_9E43:  STD  $001C                  ;ONE PICTURE ONLY
;ALIEN GUN SHOT, BASE SPARKLE
P2_9E46:  DEC  lzs_timer
P2_9E48:  BGT  P2_9E61                ;IFLE
P2_9E4A:  LDB  #$02                   ;EVERY FOURTH SCREEN, CHANGE PICTURE TYPE
P2_9E4C:  STB  lzs_timer

;===LAZAR SPLASH
DOVG_48_P2_2:
P2_9E4E:  LDB  VG_LZS
P2_9E50:  ADDB #$02
P2_9E52:  CMPB #$08
P2_9E54:  BLO  P2_9E57                ;IFHS
P2_9E56:  CLRB
P2_9E57:  STB  VG_LZS
P2_9E59:  LDU  #spark_tab
P2_9E5C:  LDD  B,U
P2_9E5E:  STD  VRLZS                  ;ONE PICTURE ONLY
;ALIEN GUN SHOT, BASE SPARKLE
P2_9E61:  DEC  VF_GNB
P2_9E63:  BGT  P2_9E7C                ;IFLE
P2_9E65:  LDB  #$01                   ;EVERY FOURTH SCREEN, CHANGE PICTURE TYPE
P2_9E67:  STB  VF_GNB

;===LAZAR SPLASH
DOVG_48_P2_3:
P2_9E69:  LDB  gnx_index
P2_9E6B:  ADDB #$02
P2_9E6D:  CMPB #$08
P2_9E6F:  BLO  P2_9E72                ;IFHS
P2_9E71:  CLRB
P2_9E72:  STB  gnx_index
P2_9E74:  LDU  #sparks_tab
P2_9E77:  LDD  B,U
P2_9E79:  STD  VRGNX
;ALIEN GUN SHOT, TIP FUSE
P2_9E7C:  DEC  VF_GNT
P2_9E7E:  BGT  P2_9E97                ;IFLE
P2_9E80:  LDB  #$01                   ;EVERY SCREEN, CHANGE PICTURE TYPE
P2_9E82:  STB  VF_GNT
P2_9E84:  LDB  VG_GNT
P2_9E86:  ADDB #$02
P2_9E88:  CMPB #$08
P2_9E8A:  BLO  P2_9E8D                ;IFHS
P2_9E8C:  CLRB
P2_9E8D:  STB  VG_GNT
P2_9E8F:  LDU  #tri_tab
P2_9E92:  LDD  B,U
P2_9E94:  STD  VRGNT                  ;ONE PICTURE ONLY
P2_9E97:  LDB  VG_FLS                 ;BRITE FLASH
P2_9E99:  ADDB #$02
P2_9E9B:  CMPB #VTFLSZ-VTFLS
P2_9E9D:  BLO  P2_9EA0                ;IFHS  ?OVERFLOWED?
P2_9E9F:  CLRB
P2_9EA0:  STB  VG_FLS
P2_9EA2:  LDU  #VTFLS
P2_9EA5:  LDD  B,U
P2_9EA7:  STD  VRFLS                  ;ONE PICTURE ONLY
P2_9EAA:  LDB  gs_fade
P2_9EAC:  STD  $002E
P2_9EAF:  LDB  #$80
P2_9EB1:  SUBB flash_fade
P2_9EB4:  STD  $0032
P2_9EB7:  LDD  #VGRTSL
P2_9EBA:  STD  $0028
P2_9EBD:  STD  $0030
P2_9EC0:  STD  $0034                  ;AND RETURN VG
P2_9EC3:  LDB  VG_MFL                 ;MEDIUM FLASH
P2_9EC5:  ADDB #$02
P2_9EC7:  CMPB #VTMFLZ-VTMFL
P2_9EC9:  BLO  P2_9ECC                ;IFHS  ?OVERFLOWED TABLE?
P2_9ECB:  CLRB                        ;THEN START AT BEGINNING
P2_9ECC:  STB  VG_MFL
P2_9ECE:  LDU  #VTMFL
P2_9ED1:  LDD  B,U
P2_9ED3:  STD  VRMFL                  ;ONE PICTURE ONLY
P2_9ED6:  LDD  #VGRTSL
P2_9ED9:  STD  VRMFL+2                ;AND RETURN VG
P2_9EDC:  JSR  SPLASH                 ;OSCILLATE LAZAR SPLASH PICS
P2_9EDF:  STA  VGGO                   ;START VGEN AGAIN
P2_9EE2:  LDA  #$05
P2_9EE4:  STA  VGTIMR

DOVG_90_P2:
P2_9EE6:  STA  IRCLR                  ;ALLOW NEXT IRQ
P2_9EE9:  RTS

;------------------------------------------------------------------------------
; DEBNCE_P2 - A=NEW VAL
;   X-->RAM AREA
;   in ESB: copy of bank 0's DEBNCE inside the leftover irq_handler copy that ends every page ($9DCD-$9FFF,
;   see irq_old_tail on page 0), never run
;------------------------------------------------------------------------------
DEBNCE_P2:
P2_9EEA:  LDB  ,X                     ;NW: PREVIOUS NEW
P2_9EEC:  STB  1,X                    ;OL: -->OLD
P2_9EEE:  STA  ,X                     ;NW: SAVE NEWEST
P2_9EF0:  ANDA 1,X                    ;OL: SAME BITS ON
P2_9EF2:  ORA  2,X                    ;SW:
P2_9EF4:  STA  2,X                    ;SW: SAVE DEBOUNCED ON BITS
P2_9EF6:  ORB  ,X++                   ;NW: SAME BITS OFF
P2_9EF8:  ANDB ,X                     ;SW:
P2_9EFA:  STB  ,X+                    ;SW: SAVE DEBOUNCED OFF BITS,
;(X)+: PREPARE FOR NEXT SWITCH SET
P2_9EFC:  RTS

;------------------------------------------------------------------------------
; DOPOTS_P2 - HANDLE READING POT VALUES
;   in ESB: copy of bank 0's DOPOTS inside the leftover irq_handler copy that ends every page, never run
;------------------------------------------------------------------------------
DOPOTS_P2:
P2_9EFD:  LDA  S_INTCT
P2_9EFF:  LSRA                        ;?WHICH POT?
P2_9F00:  LDY  #PT_VL                 ;ASSUME POT 1
P2_9F04:  BCS  P2_9F0A                ;IFCC  NOPE, IT'S THE OTHER ONE
P2_9F06:  LDY  #PT_VL+PTS_IZ          ;POT 2
;POKEY FILTER
;REQUIRE 2 SAMPLES ALL HIGHER (OR LOWER)
;THAN CURRENT SAVED VALUE.
;THEN UPDATE TO CLOSEST HI (LO) VALUE
P2_9F0A:  LDB  1,Y                    ;B:=VNEW PREVIOUS NEW BECOMES CURRENT OLD
P2_9F0C:  LDA  R_CHN
P2_9F0F:  STA  1,Y                    ;A:=VNEW UPDATE CURRENT NEW
P2_9F11:  CMPA ,Y                     ;VL
P2_9F13:  BLO  P2_9F23                ;IFHS  ?NEW VALUE HIGHER THAN STANDARD VALUE?
P2_9F15:  CMPB ,Y                     ;VL
P2_9F17:  BLS  P2_9F21                ;IFHI  ?AND OLD VALUE HIGHER ALSO?
P2_9F19:  CMPB 1,Y                    ;VNEW
P2_9F1B:  BLS  P2_9F1F                ;IFHI  ?VNEW IS CLOSER?
P2_9F1D:  LDB  1,Y                    ;VNEW
P2_9F1F:  STB  ,Y                     ;VL SAVE CLOSEST OF HIGHER VALUES
P2_9F21:  BRA  P2_9F2F                ;ELSE  ELSE NEW VALUE IS LOWER THAN STANDARD VALUE
P2_9F23:  CMPB ,Y                     ;VL
P2_9F25:  BHS  P2_9F2F                ;IFLO  ?OLD VALUE ALSO LOWER?
P2_9F27:  CMPB 1,Y                    ;VNEW
P2_9F29:  BHS  P2_9F2D                ;IFLO  ?VNEW IS CLOSER?
P2_9F2B:  LDB  1,Y                    ;VNEW
P2_9F2D:  STB  ,Y                     ;VL SAVE CLOSEST OF LOWER VALUES
P2_9F2F:  CMPY #PT_VL                 ;START NEXT A-D CONVERSION
P2_9F33:  BNE  P2_9F3D                ;IFEQ
P2_9F35:  STA  W_CHN0                 ;SELECT CHANNEL 0
P2_9F38:  STA  W_CHN0                 ;START GOOD CONVERSION
P2_9F3B:  BRA  P2_9F43                ;ELSE
P2_9F3D:  STA  W_CHN1                 ;SELECT CHANNEL 1
P2_9F40:  STA  W_CHN1                 ;AND START IT CLEANLY
P2_9F43:  RTS

;------------------------------------------------------------------------------
; RHCTRL_P2 - IRQ VG HANDLES CONTROLS
;   in ESB: copy of bank 0's RHCTRL inside the leftover irq_handler copy that ends every page, never run
;------------------------------------------------------------------------------
RHCTRL_P2:
P2_9F44:  LDX  #RHEOP                 ;DO PITCH POT
P2_9F47:  LDA  PT_VL2                 ;UP/DOWN VG Y
P2_9F49:  NOP
P2_9F4A:  JSR  RHLIM_P2               ;LIMIT AND SCALE RHESTAT
P2_9F4D:  LDA  RHS_NML,X              ;NOW LIMIT THE POT BY THE VG SCREEN
P2_9F4F:  CMPA #VGCURT                ;HI LIMIT - CURSOR SIZE, SCALED TO +-128
P2_9F51:  BLE  P2_9F55                ;IFGT
P2_9F53:  LDA  #VGCURT
P2_9F55:  CMPA #VGCURB&$FF            ;TOP CURSOR POSITION, SCALED DOWN +-512 TO +-128
P2_9F57:  BGE  P2_9F5B                ;IFLT
P2_9F59:  LDA  #VGCURB&$FF
P2_9F5B:  STA  RHS_NML,X
P2_9F5D:  JSR  RHPOS_P2
P2_9F60:  LDX  #RHEOY                 ;DO YAW POT
P2_9F63:  LDA  PT_VL1                 ;LEFT/RIGHT VG X
P2_9F65:  NOP
P2_9F66:  JSR  RHLIM_P2               ;LIMIT AND SCALE RHESTAT
P2_9F69:  LDA  RHS_NML,X              ;NOW LIMIT TO CURSOR SCREEN SIZE
P2_9F6B:  CMPA #VGCURR
P2_9F6D:  BLE  P2_9F71                ;IFGT
P2_9F6F:  LDA  #VGCURR
P2_9F71:  CMPA #VGCURL&$FF
P2_9F73:  BGE  P2_9F77                ;IFLT
P2_9F75:  LDA  #VGCURL&$FF
P2_9F77:  STA  RHS_NML,X
P2_9F79:  JSR  RHPOS_P2
P2_9F7C:  RTS

;------------------------------------------------------------------------------
; RHLIM_P2 - ---LIMIT AND SCALE
;   in ESB: copy of bank 0's RHLIM inside the leftover irq_handler copy that ends every page, never run
;------------------------------------------------------------------------------
RHLIM_P2:
P2_9F7D:  CMPA ,X                     ;A=RHEOSTAT VALUE
;X==>RAM BLOCK
;Y==>DATA TABLE
P2_9F7F:  BHS  P2_9F87                ;IFLO  ?LESS THAN LO?
P2_9F81:  CMPA RHS_LT,X
P2_9F83:  BLO  P2_9F87                ;IFHS  ?HIGHER THAN TRIAL LO?
P2_9F85:  DEC  ,X                     ;APPROACH NEW DEGLITCHED LO
P2_9F87:  STA  RHS_LT,X               ;SAVE OUR NEW TRIAL LO
P2_9F89:  CMPA ,X                     ;?LESS THAN LOWER LIMIT?
P2_9F8B:  BHS  P2_9F8F                ;IFLO
P2_9F8D:  LDA  ,X                     ;THEN REPLACE WITH LOWER LIMIT
P2_9F8F:  SUBA ,X                     ;BASE AT ZERO
P2_9F91:  STA  RH_DIR                 ;TEMP STORAGE OF POT BASED VALUE
P2_9F93:  LDB  RHS_SP,X               ;SPREAD THE VALUES-SCAL
P2_9F95:  MUL
P2_9F96:  ADDA RH_DIR                 ;MULTS BY 1XX SO VALUE GOES ABOVE 7F
P2_9F98:  BNE  P2_9F9C                ;IFEQ  ?UNDERFLOW?
P2_9F9A:  LDA  #$01                   ;RANGE IS -7F TO 7F (ALLOWS PROPER NEGATE)
P2_9F9C:  BCS  P2_9FA2                ;IFCC  ?OVERFLOW?
P2_9F9E:  CLR  RHS_ST,X               ;PREPARE TIMER FOR NEXT TOO-HIGH POT VALUE
P2_9FA0:  BRA  P2_9FAE                ;ELSE
P2_9FA2:  LDA  #$FF                   ;THEN LIMIT VALUE
P2_9FA4:  INC  RHS_ST,X               ;TIME THESE EXCESSES
P2_9FA6:  LDB  RHS_ST,X
P2_9FA8:  CMPB #$02
P2_9FAA:  BLO  P2_9FAE                ;IFHS  ?TOO LARGE FOR TOO LONG?
P2_9FAC:  DEC  RHS_SP,X               ;THEN DECREASE SPREAD
P2_9FAE:  CLRB
P2_9FAF:  SUBA #$80                   ;CHANGE TO SIGNED VALUE
P2_9FB1:  STA  RHS_NML,X
P2_9FB3:  RTS

;------------------------------------------------------------------------------
; RHPOS_P2 - CONVERT NML VALUE TO SCREEN POSITION
;   SLEWED POSITIONAL
;   in ESB: copy of bank 0's RHPOS inside the leftover irq_handler copy that ends every page, never run
;------------------------------------------------------------------------------
RHPOS_P2:
P2_9FB4:  CLR  RH_DIR                 ;START WITH POSITIVE DIRECTION TO TRAVEL
P2_9FB6:  LDA  RHS_NML,X              ;CURRENT -7F TO 7F POT
P2_9FB8:  LDB  #$80                   ;HALF WAY INTO POTS STAMP
P2_9FBA:  SUBD RHS_POS,X              ;CURRENT SCREEN POSITION
P2_9FBC:  BGE  P2_9FC1                ;IFLT  ?WANT TO GO IN NEGATIVE DIRECTION?
P2_9FBE:  NEGA                        ;THEN CHANGE DELTA TO POSITIVE 8-BIT
P2_9FBF:  DEC  RH_DIR                 ;AND SAVE NEGATIVE INDICATOR
P2_9FC1:  BLE  P2_9FC6                ;IFGT  ?SLIGHTLY POSITIVE?
P2_9FC3:  ADDD #$00FF                 ;TRUNCATE UPWARD -- ALWAYS SLEW SOME
P2_9FC6:  CMPA #$F8
P2_9FC8:  BLS  P2_9FCC                ;IFHI
P2_9FCA:  LDA  #$F8                   ;PREVENT OVERFLOWS DURING LATER TRUNCATIONS
P2_9FCC:  LDB  #$60                   ;HOW QUICKLY TO SKEW TO DESIRED LOCATION
P2_9FCE:  CMPA #$40                   ;ONE-QUARTER SCREEN
P2_9FD0:  BHS  P2_9FD4                ;IFLO  ?CLOSE ENUF?
P2_9FD2:  LDB  #$30                   ;SLOWER WHEN CLOSER
P2_9FD4:  MUL
P2_9FD5:  TST  RH_DIR                 ;RESTORE ORIGINAL DIRECTION
P2_9FD7:  BPL  P2_9FDD                ;IFMI
P2_9FD9:  COMA                        ;NEGD
P2_9FDA:  NEGB
P2_9FDB:  SBCA #$FF
P2_9FDD:  ADDD RHS_POS,X              ;NOW UPDATE OUR CURSOR POSITION
P2_9FDF:  STD  RHS_POS,X              ;RH$POS IS EQUATED TO VG.RSX,VG.RSY
P2_9FE1:  RTS
P2_9FE2:  .byte $D6, $6A, $96, $6B, $84, $C0, $48, $59 ;the start of a copy of GNSITE, as bank 0 LEDB8-LEDD4, cut off by the end of the page
P2_9FEA:  .byte $24, $02, $8A, $3F, $49, $59, $49, $DD
P2_9FF2:  .byte $30, $C3, $FF, $98, $84, $1F, $FD, $00
P2_9FFA:  .byte $14, $D6, $73, $96, $74, $FF
