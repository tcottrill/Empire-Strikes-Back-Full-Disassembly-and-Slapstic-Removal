;The Empire Strikes Back (Atari, 1985) - annotated disassembly of slapstic
;page 0 of $8000-$9FFF (MAME 'esb': the first half of 136031-105.3u).
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
P0_8000:  BITA P0_8000                ;arms the slapstic
P0_8003:  RTS
P0_8004:  BITA P0_8000
P0_8007:  RTS
P0_8008:  BITA P0_8000
P0_800B:  RTS
P0_800C:  BITA P0_8000
P0_800F:  RTS
P0_8010:  BITA P0_8000
P0_8013:  RTS
P0_8014:  BITA P0_8000
P0_8017:  RTS
P0_8018:  BITA P0_8000
P0_801B:  RTS
P0_801C:  BITA P0_8000
P0_801F:  RTS
P0_8020:  BITA P0_8000
P0_8023:  RTS
P0_8024:  BITA P0_8000
P0_8027:  RTS
P0_8028:  BITA P0_8000
P0_802B:  RTS
P0_802C:  BITA P0_8000
P0_802F:  RTS
P0_8030:  BITA P0_8000
P0_8033:  RTS
P0_8034:  BITA P0_8000
P0_8037:  RTS
P0_8038:  BITA P0_8000
P0_803B:  RTS
P0_803C:  BITA P0_8000
P0_803F:  RTS
P0_8040:  BITA P0_8000
P0_8043:  RTS
P0_8044:  BITA P0_8000
P0_8047:  RTS
P0_8048:  BITA P0_8000
P0_804B:  RTS
P0_804C:  BITA P0_8000
P0_804F:  RTS
P0_8050:  BITA P0_8000
P0_8053:  RTS
P0_8054:  BITA P0_8000
P0_8057:  RTS
P0_8058:  BITA P0_8000
P0_805B:  RTS
P0_805C:  BITA P0_8000
P0_805F:  RTS
P0_8060:  BITA P0_8000
P0_8063:  RTS
P0_8064:  BITA P0_8000
P0_8067:  RTS
P0_8068:  BITA P0_8000
P0_806B:  RTS
P0_806C:  BITA P0_8000
P0_806F:  RTS
P0_8070:  BITA P0_8000
P0_8073:  RTS
P0_8074:  BITA P0_8000
P0_8077:  RTS
P0_8078:  BITA P0_8000
P0_807B:  RTS
P0_807C:  BITA P0_8000
P0_807F:  RTS
P0_8080:  BITA P0_8000                ;arms the slapstic
P0_8083:  RTS
P0_8084:  BITA P0_8000
P0_8087:  RTS
P0_8088:  BITA P0_8000
P0_808B:  RTS
P0_808C:  BITA P0_8000
P0_808F:  RTS
P0_8090:  BITA P0_8000                ;arms the slapstic
P0_8093:  RTS
P0_8094:  BITA P0_8000
P0_8097:  RTS
P0_8098:  BITA P0_8000
P0_809B:  RTS
P0_809C:  BITA P0_8000
P0_809F:  RTS
P0_80A0:  BITA P0_8000                ;arms the slapstic
P0_80A3:  RTS
P0_80A4:  BITA P0_8000
P0_80A7:  RTS
P0_80A8:  BITA P0_8000
P0_80AB:  RTS
P0_80AC:  BITA P0_8000
P0_80AF:  RTS
P0_80B0:  BITA P0_8000                ;arms the slapstic
P0_80B3:  RTS
P0_80B4:  BITA P0_8000
P0_80B7:  RTS
P0_80B8:  BITA P0_8000
P0_80BB:  RTS
P0_80BC:  BITA P0_8000
P0_80BF:  RTS
P0_80C0:  BITA P0_8000
P0_80C3:  RTS
P0_80C4:  BITA P0_8000
P0_80C7:  RTS
P0_80C8:  BITA P0_8000
P0_80CB:  RTS
P0_80CC:  BITA P0_8000
P0_80CF:  RTS
P0_80D0:  BITA P0_8000
P0_80D3:  RTS
P0_80D4:  BITA P0_8000
P0_80D7:  RTS
P0_80D8:  BITA P0_8000
P0_80DB:  RTS
P0_80DC:  BITA P0_8000
P0_80DF:  RTS
P0_80E0:  BITA P0_8000
P0_80E3:  RTS
P0_80E4:  BITA P0_8000
P0_80E7:  RTS
P0_80E8:  BITA P0_8000
P0_80EB:  RTS
P0_80EC:  BITA P0_8000
P0_80EF:  RTS
P0_80F0:  BITA P0_8000
P0_80F3:  RTS
P0_80F4:  BITA P0_8000
P0_80F7:  RTS
P0_80F8:  BITA P0_8000
P0_80FB:  RTS
P0_80FC:  BITA P0_8000
P0_80FF:  RTS
P0_8100:  JSR  P0_80FC+1              ;decoy
P0_8103:  JMP  atat_init              ;live: the routine
P0_8106:  JMP  P0_8090                ;live: select page 1
P0_8109:  JMP  P0_80A0                ;live: select page 2
P0_810C:  JMP  P0_80B0                ;live: select page 3
P0_810F:  JSR  P0_8106                ;decoy
P0_8112:  JSR  P0_80B0                ;live: select page 3
P0_8115:  JSR  P0_8112                ;live
P0_8118:  JSR  P0_80B0                ;decoy
P0_811B:  JSR  P0_8A69+1              ;decoy
P0_811E:  JMP  P0_8080                ;decoy
P0_8121:  JSR  P0_811E                ;decoy
P0_8124:  JSR  P0_8121                ;decoy
P0_8127:  JSR  P0_8121                ;decoy
P0_812A:  JSR  P0_8090                ;live: select page 1
P0_812D:  JSR  P0_812A                ;live
P0_8130:  JSR  P0_8090                ;decoy
P0_8133:  JSR  P0_8EFC                ;decoy
P0_8136:  JMP  P0_8080                ;decoy
P0_8139:  JSR  P0_8133                ;decoy
P0_813C:  JSR  P0_8136                ;decoy
P0_813F:  JSR  P0_8139                ;decoy
P0_8142:  JSR  P0_80B0                ;live: select page 3
P0_8145:  JSR  P0_8142                ;live
P0_8148:  JSR  P0_80B0                ;decoy
P0_814B:  JSR  P0_8612+1              ;decoy
P0_814E:  JMP  P0_8080                ;decoy
P0_8151:  JSR  P0_8154                ;decoy
P0_8154:  JSR  P0_8090                ;live: select page 1
P0_8157:  JSR  P0_8154                ;live
P0_815A:  JSR  P0_8090                ;decoy
P0_815D:  JSR  P0_9644+1              ;decoy
P0_8160:  JMP  P0_8080                ;decoy
P0_8163:  JSR  P0_815A                ;decoy
P0_8166:  JSR  P0_8169                ;decoy
P0_8169:  JSR  P0_8090                ;live: select page 1
P0_816C:  JSR  P0_8169                ;live
P0_816F:  JSR  P0_8090                ;decoy
P0_8172:  JSR  P0_9663                ;decoy
P0_8175:  JMP  P0_8080                ;decoy
P0_8178:  JSR  P0_817B                ;decoy
P0_817B:  JSR  P0_8175                ;decoy
P0_817E:  JSR  P0_8181                ;decoy
P0_8181:  JSR  P0_80B0                ;live: select page 3
P0_8184:  JSR  P0_8181                ;live
P0_8187:  JSR  P0_80B0                ;decoy
P0_818A:  JSR  P0_97CB                ;decoy
P0_818D:  JMP  P0_8080                ;decoy
P0_8190:  JSR  P0_8193                ;decoy
P0_8193:  JSR  P0_80A0                ;live: select page 2
P0_8196:  JSR  P0_8193                ;live
P0_8199:  JSR  P0_80A0                ;decoy
P0_819C:  JSR  P0_8FB7                ;decoy
P0_819F:  JMP  P0_8080                ;decoy
P0_81A2:  JMP  P0_81A8                ;decoy
P0_81A5:  JSR  P0_81A2                ;decoy
P0_81A8:  JSR  P0_80B0                ;live: select page 3
P0_81AB:  JSR  P0_81A8                ;live
P0_81AE:  JSR  P0_80B0                ;decoy
P0_81B1:  JSR  P0_98D2+1              ;decoy
P0_81B4:  JMP  P0_8080                ;decoy
P0_81B7:  JMP  P0_81BD                ;decoy
P0_81BA:  JSR  P0_81B1                ;decoy
P0_81BD:  JSR  P0_81B7                ;decoy
P0_81C0:  JSR  P0_8090                ;live: select page 1
P0_81C3:  JSR  P0_8FF6+1              ;decoy
P0_81C6:  JMP  P0_8080                ;decoy
P0_81C9:  JSR  P0_81C3                ;decoy
P0_81CC:  JSR  P0_81C6                ;decoy
P0_81CF:  JSR  P0_8090                ;live: select page 1
P0_81D2:  JSR  P0_81CF                ;live
P0_81D5:  JSR  P0_8090                ;decoy
P0_81D8:  JSR  P0_922B                ;decoy
P0_81DB:  JMP  P0_8080                ;decoy
P0_81DE:  JSR  P0_81D8                ;decoy
P0_81E1:  JSR  P0_8090                ;live: select page 1
P0_81E4:  JSR  P0_81E1                ;live
P0_81E7:  JSR  P0_8090                ;decoy
P0_81EA:  JSR  P0_9572+1              ;decoy
P0_81ED:  JMP  P0_8080                ;decoy
P0_81F0:  JSR  P0_81EA                ;decoy
P0_81F3:  JMP  P0_81F9                ;decoy
P0_81F6:  JSR  P0_80B0                ;live: select page 3
P0_81F9:  JSR  P0_81F6                ;live
P0_81FC:  JSR  P0_80B0                ;decoy
P0_81FF:  JSR  atat_demo_init         ;decoy
P0_8202:  JMP  P0_8080                ;decoy
P0_8205:  JSR  P0_8208                ;decoy
P0_8208:  JSR  P0_8202                ;decoy
P0_820B:  JSR  P0_8208                ;decoy
P0_820E:  JSR  P0_820B                ;decoy
P0_8211:  JMP  cable_attach           ;live: the routine
P0_8214:  JMP  P0_8090                ;decoy
P0_8217:  JMP  P0_80A0                ;decoy
P0_821A:  JMP  P0_80B0                ;decoy
P0_821D:  JSR  P0_8217                ;decoy
P0_8220:  JSR  P0_80A0                ;decoy
P0_8223:  JSR  P0_89AC                ;decoy
P0_8226:  JMP  P0_8080                ;decoy
P0_8229:  JSR  P0_822C                ;decoy
P0_822C:  JSR  P0_8090                ;live: select page 1
P0_822F:  JSR  P0_822C                ;live
P0_8232:  JSR  P0_8090                ;decoy
P0_8235:  JSR  P0_866A+5              ;decoy
P0_8238:  JMP  P0_8080                ;decoy
P0_823B:  JSR  P0_8235                ;decoy
P0_823E:  JMP  P0_8244                ;decoy
P0_8241:  JSR  P0_823E                ;decoy
P0_8244:  JSR  P0_8241                ;decoy
P0_8247:  JMP  cable_init             ;live: the routine
P0_824A:  JMP  P0_8090                ;live: select page 1
P0_824D:  JMP  P0_80A0                ;live: select page 2
P0_8250:  JMP  P0_80B0                ;live: select page 3
P0_8253:  JSR  P0_824A                ;decoy
P0_8256:  JSR  P0_8259                ;decoy
P0_8259:  JSR  P0_80A0                ;live: select page 2
P0_825C:  JSR  P0_8259                ;live
P0_825F:  JSR  P0_80A0                ;decoy
P0_8262:  JSR  P0_86C7                ;decoy
P0_8265:  JMP  P0_8080                ;decoy
P0_8268:  JSR  P0_8262                ;decoy
P0_826B:  JSR  P0_8268                ;decoy
P0_826E:  JSR  P0_8271                ;decoy
P0_8271:  JSR  P0_8090                ;decoy
P0_8274:  JSR  P0_8271                ;decoy
P0_8277:  JSR  P0_8090                ;decoy
P0_827A:  JSR  P0_99F8                ;decoy
P0_827D:  JMP  P0_8080                ;decoy
P0_8280:  JSR  P0_8283                ;decoy
P0_8283:  JSR  P0_8090                ;live: select page 1
P0_8286:  JSR  P0_8283                ;live
P0_8289:  JSR  P0_8090                ;decoy
P0_828C:  JSR  P0_99C3                ;decoy
P0_828F:  JMP  P0_8080                ;decoy
P0_8292:  JSR  P0_8295                ;decoy
P0_8295:  JSR  P0_8090                ;live: select page 1
P0_8298:  JSR  P0_9063                ;decoy
P0_829B:  JMP  P0_8080                ;decoy
P0_829E:  JSR  P0_82A1                ;decoy
P0_82A1:  JMP  P0_82A7                ;decoy
P0_82A4:  JSR  P0_80B0                ;live: select page 3
P0_82A7:  JSR  P0_82A4                ;live
P0_82AA:  JSR  P0_80B0                ;decoy
P0_82AD:  JSR  atat_init              ;decoy
P0_82B0:  JMP  P0_8080                ;decoy
P0_82B3:  JSR  P0_82AD                ;decoy
P0_82B6:  JSR  P0_82B3                ;decoy
P0_82B9:  JMP  cable_fire_save        ;decoy
P0_82BC:  JMP  P0_8090                ;decoy
P0_82BF:  JMP  P0_80A0                ;decoy
P0_82C2:  JMP  P0_80B0                ;decoy
P0_82C5:  JMP  P0_82CB                ;decoy
P0_82C8:  JSR  P0_8090                ;live: select page 1
P0_82CB:  JSR  P0_82C8                ;live
P0_82CE:  JSR  P0_8090                ;decoy
P0_82D1:  JSR  P0_9A0E                ;decoy
P0_82D4:  JMP  P0_8080                ;decoy
P0_82D7:  JSR  P0_82DA                ;decoy
P0_82DA:  JSR  P0_82D7                ;decoy
P0_82DD:  JMP  P0_82E3                ;decoy
P0_82E0:  JSR  P0_80B0                ;live: select page 3
P0_82E3:  JSR  P0_82E0                ;live
P0_82E6:  JSR  P0_80B0                ;decoy
P0_82E9:  JSR  P0_8A92+1              ;decoy
P0_82EC:  JMP  P0_8080                ;decoy
P0_82EF:  JSR  P0_82E6                ;decoy
P0_82F2:  JSR  P0_82EC                ;decoy
P0_82F5:  JSR  P0_82F8                ;decoy
P0_82F8:  JSR  P0_8090                ;decoy
P0_82FB:  JSR  P0_9CF2                ;decoy
P0_82FE:  JMP  P0_8080                ;decoy
P0_8301:  JSR  P0_8304                ;decoy
P0_8304:  JSR  P0_80B0                ;live: select page 3
P0_8307:  JSR  P0_8304                ;live
P0_830A:  JSR  P0_80B0                ;decoy
P0_830D:  JSR  cable_init             ;decoy
P0_8310:  JMP  P0_8080                ;decoy
P0_8313:  JMP  P0_8319                ;decoy
P0_8316:  JSR  P0_80B0                ;live: select page 3
P0_8319:  JSR  P0_8316                ;live
P0_831C:  JSR  P0_80B0                ;decoy
P0_831F:  JSR  P0_8E27                ;decoy
P0_8322:  JMP  P0_8080                ;decoy
P0_8325:  JSR  P0_8328                ;decoy
P0_8328:  JSR  P0_832B                ;decoy
P0_832B:  JSR  P0_8328                ;decoy
P0_832E:  JMP  atat_view_all          ;live: the routine
P0_8331:  JMP  P0_8090                ;live: select page 1
P0_8334:  JMP  P0_80A0                ;live: select page 2
P0_8337:  JMP  P0_80B0                ;live: select page 3
P0_833A:  JSR  P0_8337                ;decoy
P0_833D:  JSR  P0_8337                ;decoy
P0_8340:  JMP  P0_8346                ;decoy
P0_8343:  JSR  P0_80A0                ;decoy
P0_8346:  JSR  P0_8343                ;decoy
P0_8349:  JSR  P0_80A0                ;decoy
P0_834C:  JSR  P0_9C16                ;decoy
P0_834F:  JMP  P0_8080                ;decoy
P0_8352:  JSR  P0_8355                ;decoy
P0_8355:  JSR  P0_80B0                ;decoy
P0_8358:  JSR  P0_8355                ;decoy
P0_835B:  JSR  P0_80B0                ;decoy
P0_835E:  JSR  P0_8D85                ;decoy
P0_8361:  JMP  P0_8080                ;decoy
P0_8364:  JMP  P0_836A                ;decoy
P0_8367:  JSR  P0_80B0                ;live: select page 3
P0_836A:  JSR  P0_8367                ;live
P0_836D:  JSR  P0_80B0                ;decoy
P0_8370:  JSR  P0_8A69+1              ;decoy
P0_8373:  JMP  P0_8080                ;decoy
P0_8376:  JSR  P0_8379                ;decoy
P0_8379:  JSR  P0_837C                ;decoy
P0_837C:  JSR  P0_80A0                ;live: select page 2
P0_837F:  JSR  P0_837C                ;live
P0_8382:  JSR  P0_80A0                ;decoy
P0_8385:  JSR  P0_877B+1              ;decoy
P0_8388:  JMP  P0_8080                ;decoy
P0_838B:  JSR  P0_8385                ;decoy
P0_838E:  JSR  P0_838B                ;decoy
P0_8391:  JMP  atat_demo_init         ;live: the routine
P0_8394:  JMP  P0_8090                ;live: select page 1
P0_8397:  JMP  P0_80A0                ;live: select page 2
P0_839A:  JMP  P0_80B0                ;live: select page 3
P0_839D:  JSR  P0_8397                ;decoy
P0_83A0:  JSR  P0_80B0                ;live: select page 3
P0_83A3:  JSR  P0_83A0                ;live
P0_83A6:  JSR  P0_80B0                ;decoy
P0_83A9:  JSR  P0_98E7+1              ;decoy
P0_83AC:  JMP  P0_8080                ;decoy
P0_83AF:  JSR  P0_83A9                ;decoy
P0_83B2:  JSR  P0_83B5                ;decoy
P0_83B5:  JSR  P0_8090                ;live: select page 1
P0_83B8:  JSR  P0_83B5                ;live
P0_83BB:  JSR  P0_8090                ;decoy
P0_83BE:  JSR  P0_99D7                ;decoy
P0_83C1:  JMP  P0_8080                ;decoy
P0_83C4:  JSR  P0_83C1                ;decoy
P0_83C7:  JSR  P0_80B0                ;live: select page 3
P0_83CA:  JSR  P0_83C7                ;live
P0_83CD:  JSR  P0_80B0                ;decoy
P0_83D0:  JSR  P0_98D2+1              ;decoy
P0_83D3:  JMP  P0_8080                ;decoy
P0_83D6:  JSR  P0_83D0                ;decoy
P0_83D9:  JMP  P0_83DF                ;decoy
P0_83DC:  JSR  P0_83D9                ;decoy
P0_83DF:  JMP  cable_move             ;live: the routine
P0_83E2:  JMP  P0_8090                ;live: select page 1
P0_83E5:  JMP  P0_80A0                ;live: select page 2
P0_83E8:  JMP  P0_80B0                ;live: select page 3
P0_83EB:  JSR  P0_83E5                ;decoy
P0_83EE:  JSR  P0_80B0                ;live: select page 3
P0_83F1:  JSR  P0_83EE                ;live
P0_83F4:  JSR  P0_80B0                ;decoy
P0_83F7:  JSR  P0_9836+2              ;decoy
P0_83FA:  JMP  P0_8080                ;decoy
P0_83FD:  JSR  P0_8400                ;decoy
P0_8400:  JSR  P0_8090                ;live: select page 1
P0_8403:  JSR  P0_8400                ;live
P0_8406:  JSR  P0_8090                ;decoy
P0_8409:  JSR  P0_95EF+2              ;decoy
P0_840C:  JMP  P0_8080                ;decoy
P0_840F:  JSR  P0_8409                ;decoy
P0_8412:  JSR  P0_840F                ;decoy
P0_8415:  JSR  P0_840F                ;decoy
P0_8418:  JSR  P0_80A0                ;live: select page 2
P0_841B:  JSR  P0_8418                ;live
P0_841E:  JSR  P0_80A0                ;decoy
P0_8421:  JSR  cable_mode_fly+1       ;decoy
P0_8424:  JMP  P0_8080                ;decoy
P0_8427:  JSR  P0_8424                ;decoy
P0_842A:  JSR  P0_8090                ;live: select page 1
P0_842D:  JSR  P0_842A                ;live
P0_8430:  JSR  P0_8090                ;decoy
P0_8433:  JSR  cable_init             ;decoy
P0_8436:  JMP  P0_8080                ;decoy
P0_8439:  JSR  P0_8430                ;decoy
P0_843C:  JSR  P0_80B0                ;live: select page 3
P0_843F:  JSR  P0_843C                ;live
P0_8442:  JSR  P0_80B0                ;decoy
P0_8445:  JSR  P0_9989                ;decoy
P0_8448:  JMP  P0_8080                ;decoy
P0_844B:  JSR  P0_844E                ;decoy
P0_844E:  JMP  P0_8454                ;decoy
P0_8451:  JSR  P0_80A0                ;decoy
P0_8454:  JSR  P0_8451                ;decoy
P0_8457:  JSR  P0_80A0                ;decoy
P0_845A:  JSR  P0_92E9+5              ;decoy
P0_845D:  JMP  P0_8080                ;decoy
P0_8460:  JSR  P0_8463                ;decoy
P0_8463:  JSR  P0_80B0                ;live: select page 3
P0_8466:  JSR  P0_8463                ;live
P0_8469:  JSR  P0_80B0                ;decoy
P0_846C:  JSR  P0_9B6D                ;decoy
P0_846F:  JMP  P0_8080                ;decoy
P0_8472:  JSR  P0_846C                ;decoy
P0_8475:  JSR  P0_8478                ;decoy
P0_8478:  JSR  P0_846F                ;decoy
P0_847B:  JSR  P0_8478                ;decoy
P0_847E:  JMP  atat_move_all          ;live: the routine
P0_8481:  JMP  P0_8090                ;live: select page 1
P0_8484:  JMP  P0_80A0                ;live: select page 2
P0_8487:  JMP  P0_80B0                ;live: select page 3
P0_848A:  JSR  P0_8487                ;decoy
P0_848D:  JSR  P0_8487                ;decoy
P0_8490:  JMP  P0_8496                ;decoy
P0_8493:  JSR  P0_80B0                ;live: select page 3
P0_8496:  JSR  P0_8493                ;live
P0_8499:  JSR  P0_80B0                ;decoy
P0_849C:  JSR  atat_demo_init         ;decoy
P0_849F:  JMP  P0_8080                ;decoy
P0_84A2:  JSR  P0_8499                ;decoy
P0_84A5:  JSR  P0_80A0                ;live: select page 2
P0_84A8:  JSR  P0_84A5                ;live
P0_84AB:  JSR  P0_80A0                ;decoy
P0_84AE:  JSR  P0_96DE+2              ;decoy
P0_84B1:  JMP  P0_8080                ;decoy
P0_84B4:  JSR  P0_84B1                ;decoy
P0_84B7:  JSR  P0_80B0                ;live: select page 3
P0_84BA:  JSR  P0_84B7                ;live
P0_84BD:  JSR  P0_80B0                ;decoy
P0_84C0:  JSR  P0_988A+2              ;decoy
P0_84C3:  JMP  P0_8080                ;decoy
P0_84C6:  JSR  P0_84BD                ;decoy
P0_84C9:  JSR  P0_8090                ;live: select page 1
P0_84CC:  JSR  P0_84C9                ;live
P0_84CF:  JSR  P0_8090                ;decoy
P0_84D2:  JSR  P0_9185                ;decoy
P0_84D5:  JMP  P0_8080                ;decoy
P0_84D8:  JSR  P0_84DB                ;decoy
P0_84DB:  JSR  P0_80A0                ;live: select page 2
P0_84DE:  JSR  P0_84DB                ;live
P0_84E1:  JSR  P0_80A0                ;decoy
P0_84E4:  JSR  cable_init             ;decoy
P0_84E7:  JMP  P0_8080                ;decoy
P0_84EA:  JSR  P0_84E7                ;decoy
P0_84ED:  JSR  P0_84E4                ;decoy
P0_84F0:  JSR  P0_8090                ;live: select page 1
P0_84F3:  JSR  P0_8F8A+1              ;decoy
P0_84F6:  JMP  P0_8080                ;decoy
P0_84F9:  JSR  P0_84F0                ;decoy
P0_84FC:  JSR  P0_84F9                ;decoy
P0_84FF:  JMP  cable_view             ;live: the routine
P0_8502:  JMP  P0_8090                ;live: select page 1
P0_8505:  JMP  P0_80A0                ;live: select page 2
P0_8508:  JMP  P0_80B0                ;live: select page 3
P0_850B:  JSR  P0_8508                ;decoy
P0_850E:  JSR  P0_8505                ;decoy
P0_8511:  JSR  P0_8090                ;live: select page 1
P0_8514:  JSR  P0_8511                ;live
P0_8517:  JSR  P0_8090                ;decoy
P0_851A:  JSR  P0_86E1                ;decoy
P0_851D:  JMP  P0_8080                ;decoy
P0_8520:  JSR  P0_8517                ;decoy
P0_8523:  JSR  P0_80A0                ;live: select page 2
P0_8526:  JSR  P0_8523                ;live
P0_8529:  JSR  P0_80A0                ;decoy
P0_852C:  JSR  P0_9983                ;decoy
P0_852F:  JMP  P0_8080                ;decoy
P0_8532:  JSR  P0_8529                ;decoy
P0_8535:  JSR  P0_8532                ;decoy
P0_8538:  JMP  atat_eye_shot          ;live: the routine
P0_853B:  JMP  P0_8090                ;decoy
P0_853E:  JMP  P0_80A0                ;decoy
P0_8541:  JMP  P0_80B0                ;live: select page 3
P0_8544:  JSR  P0_853B                ;decoy
P0_8547:  JSR  P0_853E                ;decoy
P0_854A:  JSR  P0_8547                ;decoy
P0_854D:  JSR  P0_8090                ;live: select page 1
P0_8550:  JSR  P0_854D                ;live
P0_8553:  JSR  P0_8090                ;decoy
P0_8556:  JSR  P0_88FB+2              ;decoy
P0_8559:  JMP  P0_8080                ;decoy
P0_855C:  JSR  P0_8556                ;decoy
P0_855F:  JSR  P0_8562                ;decoy
P0_8562:  JSR  P0_80B0                ;live: select page 3
P0_8565:  JSR  P0_8562                ;live
P0_8568:  JSR  P0_80B0                ;decoy
P0_856B:  JSR  P0_95D2+1              ;decoy
P0_856E:  JMP  P0_8080                ;decoy
P0_8571:  JMP  P0_8577                ;decoy
P0_8574:  JSR  P0_856E                ;decoy
P0_8577:  JMP  P0_857D                ;decoy
P0_857A:  JSR  P0_8090                ;live: select page 1
P0_857D:  JSR  P0_8F16                ;decoy
P0_8580:  JMP  P0_8080                ;decoy
P0_8583:  JSR  P0_8580                ;decoy
P0_8586:  JMP  P0_858C                ;decoy
P0_8589:  JSR  P0_8090                ;decoy
P0_858C:  JSR  P0_8589                ;decoy
P0_858F:  JSR  P0_8090                ;decoy
P0_8592:  JSR  P0_8E33                ;decoy
P0_8595:  JMP  P0_8080                ;decoy
P0_8598:  JSR  P0_858F                ;decoy
P0_859B:  JSR  P0_80A0                ;live: select page 2
P0_859E:  JSR  P0_859B                ;live
P0_85A1:  JSR  P0_80A0                ;decoy
P0_85A4:  JSR  atat_init              ;decoy
P0_85A7:  JMP  P0_8080                ;decoy
P0_85AA:  JMP  P0_85B0                ;decoy
P0_85AD:  JSR  P0_85A4                ;decoy
P0_85B0:  JSR  P0_85AD                ;decoy
P0_85B3:  JMP  anim_track_pos         ;live: the routine
P0_85B6:  JMP  P0_8090                ;live: select page 1
P0_85B9:  JMP  P0_80A0                ;decoy
P0_85BC:  JMP  P0_80B0                ;decoy
P0_85BF:  JMP  P0_85C5                ;decoy
P0_85C2:  JSR  P0_85BF                ;decoy
P0_85C5:  JSR  P0_8090                ;decoy
P0_85C8:  JSR  P0_85C5                ;decoy
P0_85CB:  JSR  P0_8090                ;decoy
P0_85CE:  JSR  P0_9501+1              ;decoy
P0_85D1:  JMP  P0_8080                ;decoy
P0_85D4:  JSR  P0_85D7                ;decoy
P0_85D7:  JSR  P0_8090                ;live: select page 1
P0_85DA:  JSR  P0_85D7                ;live
P0_85DD:  JSR  P0_8090                ;decoy
P0_85E0:  JSR  atat_init              ;decoy
P0_85E3:  JMP  P0_8080                ;decoy
P0_85E6:  JMP  atat_init              ;decoy
P0_85E9:  JSR  P0_85E6                ;decoy

;------------------------------------------------------------------------------
; atat_init - set-up of the AT-ATs for the walker part, called by wave2_setup: loads the points of objects $17
;   and $18 into the math box, clears atat_under and fills the three $19-byte records at atat_rec from
;   atat_init_tab with their type byte left 0 (free), then sets w2_spawn_b to 3 so that atat_move_all brings them
;   in one at a time
;------------------------------------------------------------------------------
atat_init:
P0_85EC:  LDB  #$17                   ;object $17, the AT-AT's body: load its points into the math box (bank 1 JADOBJ)
P0_85EE:  JSR  L60A8
P0_85F1:  LDB  #$18                   ;object $18, the AT-AT's head
P0_85F3:  JSR  L60A8
P0_85F6:  LDD  #$0000
P0_85F9:  STD  atat_under             ;the player is under no walker
P0_85FC:  LDX  #atat_init_tab
P0_85FF:  LDU  #atat_rec
P0_8602:  STU  S2_PRM
P0_8604:  LDA  #$00
P0_8606:  STA  ,U                     ;byte 0, the type: 0 = record free, the spawn routine P0_9163 makes it $29
P0_8608:  STA  1,U                    ;byte 1, the flags of the frame
P0_860A:  LDA  #$08                   ;byte 3, the delay before the head may shoot
P0_860C:  STA  3,U
P0_860E:  LDD  ,X++                   ;bytes 5-6, x position, from the table
P0_8610:  STD  5,U
P0_8612:  LDD  #$06D6                 ;bytes 11-16: where the head is from the centre, x $06D6, y 0, z $02A3
P0_8615:  STD  11,U
P0_8617:  LDD  ,X++                   ;bytes 7-8, y position
P0_8619:  STD  7,U
P0_861B:  LDD  #$0000
P0_861E:  STD  13,U
P0_8620:  LDD  ,X++                   ;bytes 9-10, z position (height)
P0_8622:  STD  9,U
P0_8624:  LDD  #$02A3
P0_8627:  STD  15,U
P0_8629:  LDA  ,X+                    ;byte $11, the head's yaw angle
P0_862B:  STA  $11,U
P0_862E:  LDA  ,X+                    ;byte $13, the head's pitch angle
P0_8630:  STA  $13,U
P0_8633:  LDA  #$00                   ;byte $15, the walk cycle counter
P0_8635:  STA  $15,U
P0_8638:  LDD  ,X++                   ;byte $16, which set of leg tracks (atat_gait_tab), and byte 4, the movement mode
P0_863A:  STA  $16,U
P0_863D:  STB  4,U
P0_863F:  CMPX #atat_init_tab+30      ;the table has three entries
P0_8642:  BCS  P0_8647
P0_8644:  LDX  #atat_init_tab
P0_8647:  LEAU $19,U
P0_864A:  CMPU #cable_rec             ;end of the three records
P0_864E:  BCS  P0_8602
P0_8650:  LDA  #$03                   ;three walkers to bring in
P0_8652:  STA  w2_spawn_b
P0_8655:  RTS

atat_init_tab:
P0_8656:  .word $5000, $0000, $2000   ;AT-AT set-up row 0: x, y, z, then four bytes  10 bytes a walker: x word, y word, z word, head yaw, head pitch, leg set, movement mode (1 = walk)
P0_865C:  .byte $C0, $40, $00, $01
P0_8660:  .word $4000, $E000, $2000   ;AT-AT set-up row 1: x, y, z, then four bytes
P0_8666:  .byte $DF, $00, $01, $01
P0_866A:  .word $7000, $1000, $2000   ;AT-AT set-up row 2: x, y, z, then four bytes
P0_8670:  .byte $D8, $60, $02, $01

;------------------------------------------------------------------------------
; atat_demo_init - set-up of the demo AT-AT of the training manual, called by man_init_walker and man_show_atat
;   with B = the manual page: fills the first record from entry B of atat_demo_tab (entry 0 when B is over 2) as a
;   standing walker, frees the other two records, loads the points of objects $17 and $18 and clears w2_spawn_b so
;   that nothing is spawned
;------------------------------------------------------------------------------
atat_demo_init:
P0_8674:  LDD  #$0000
P0_8677:  STD  atat_under
P0_867A:  LDX  #atat_demo_tab
P0_867D:  LDA  #$0A                   ;B = manual page: 10 bytes a table entry
P0_867F:  MUL
P0_8680:  CMPB #$1E                   ;a page over 2 uses entry 0
P0_8682:  BCS  P0_8686
P0_8684:  LDB  #$00
P0_8686:  ABX
P0_8687:  LDU  #atat_rec
P0_868A:  LDA  #$00
P0_868C:  STA  1,U
P0_868E:  LDA  #$08
P0_8690:  STA  3,U
P0_8692:  LDD  ,X++
P0_8694:  STD  5,U
P0_8696:  LDD  #$06D6
P0_8699:  STD  11,U
P0_869B:  LDD  ,X++
P0_869D:  STD  7,U
P0_869F:  LDD  #$0000
P0_86A2:  STD  13,U
P0_86A4:  LDD  ,X++
P0_86A6:  STD  9,U
P0_86A8:  LDD  #$02A3
P0_86AB:  STD  15,U
P0_86AD:  LDA  ,X+
P0_86AF:  STA  $11,U
P0_86B2:  LDA  ,X+
P0_86B4:  STA  $13,U
P0_86B7:  LDA  #$00
P0_86B9:  STA  $15,U
P0_86BC:  LDD  ,X++
P0_86BE:  STA  $16,U                  ;byte $16, the leg set
P0_86C1:  STB  ,U                     ;byte 0, the type, from the table: the record is live at once
P0_86C3:  LDA  #$00                   ;movement mode 0: the demo walker stands
P0_86C5:  STA  4,U
P0_86C7:  LEAU $19,U
P0_86CA:  LDA  #$00                   ;free the other two records
P0_86CC:  STA  ,U
P0_86CE:  LEAU $19,U
P0_86D1:  CMPU #cable_rec
P0_86D5:  BCS  P0_86CC
P0_86D7:  LDB  #$17
P0_86D9:  JSR  L60A8
P0_86DC:  LDB  #$18
P0_86DE:  JSR  L60A8
P0_86E1:  LDA  #$00                   ;no spawning in the manual
P0_86E3:  STA  w2_spawn_b
P0_86E6:  RTS

atat_demo_tab:
P0_86E7:  .word $C000, $0000, $2000   ;AT-AT manual row 0: x, y, z, then four bytes  10 bytes a manual page: x word, y word, z word, head yaw, head pitch, leg set, type byte
P0_86ED:  .byte $C0, $40, $00, $01
P0_86F1:  .word $C000, $0000, $2000   ;AT-AT manual row 1: x, y, z, then four bytes
P0_86F7:  .byte $DF, $00, $01, $01
P0_86FB:  .word $C000, $0000, $2000   ;AT-AT manual row 2: x, y, z, then four bytes
P0_8701:  .byte $D8, $60, $02, $09

;------------------------------------------------------------------------------
; atat_move_all - per-frame movement of the AT-ATs, called by the walker phases and by man_move_walker. while
;   w2_spawn_b is positive it respawns one free record (atat_spawn), when it is negative (end of the part) it
;   frees the walkers that are neither falling nor in view nor over the player, then it awards the legs bonus when
;   the player comes under a walker (atat_under remembers which one until the player has left it), and for every
;   live record counts it in w2_active_b, runs down its shot delay, swings the head, moves it by its mode and
;   steps the walk cycle. a falling walker carries the height of the tow cable's centre down with it
;------------------------------------------------------------------------------
atat_move_all:
P0_8705:  LDB  w2_spawn_b             ;spawn count: positive while walkers are to be brought in
P0_8708:  BLE  P0_8726
P0_870A:  LDU  #atat_rec
P0_870D:  LDA  ,U
P0_870F:  BNE  P0_871A                ;a free record among the first w2_spawn_b
P0_8711:  LDA  #$00
P0_8713:  STA  1,U
P0_8715:  JSR  atat_spawn             ;place it far from the player and make it live, one a frame
P0_8718:  BRA  P0_8726
P0_871A:  DECB
P0_871B:  BLE  P0_8726
P0_871D:  LEAU $19,U
P0_8720:  CMPU #cable_rec
P0_8724:  BCS  P0_870D
P0_8726:  LDB  w2_spawn_b             ;negative at the end of the part: let the walkers go
P0_8729:  BGE  P0_8770
P0_872B:  LDA  cable_rec              ;not while the tow cable is out
P0_872E:  BNE  P0_8770
P0_8730:  LDU  #atat_rec
P0_8733:  LDA  ,U
P0_8735:  BEQ  P0_8767
P0_8737:  BITA #$02                   ;a falling walker stays
P0_8739:  BNE  P0_8767
P0_873B:  LDA  1,U                    ;so does one that was drawn this frame
P0_873D:  BITA #$10
P0_873F:  BNE  P0_8767
P0_8741:  LDD  5,U
P0_8743:  SUBD s1_tx
P0_8746:  BPL  P0_874C
P0_8748:  COMA
P0_8749:  NEGB
P0_874A:  SBCA #$FF
P0_874C:  SUBD #$0BB8                 ;and one the player is under: within $0BB8 in x
P0_874F:  BCC  P0_8761
P0_8751:  LDD  7,U
P0_8753:  SUBD MS_TY+M_S1
P0_8756:  BPL  P0_875C                ;IFMI
P0_8758:  COMA                        ;NEGD  ABSOLUTE VALUE
P0_8759:  NEGB
P0_875A:  SBCA #$FF
P0_875C:  SUBD #$05DC                 ;and within $05DC in y
P0_875F:  BCS  P0_8767
P0_8761:  LDA  #$00                   ;free the record
P0_8763:  STA  ,U
P0_8765:  STA  1,U
P0_8767:  LEAU $19,U
P0_876A:  CMPU #cable_rec
P0_876E:  BCS  P0_8733
P0_8770:  LDU  #atat_rec
P0_8773:  LDA  ,U
P0_8775:  BEQ  P0_879F
P0_8777:  CMPU atat_under             ;the walker the player was under
P0_877B:  BNE  P0_879F
P0_877D:  LDD  5,U
P0_877F:  SUBD s1_tx
P0_8782:  BPL  P0_8788                ;IFMI
P0_8784:  COMA                        ;NEGD  ABSOLUTE VALUE
P0_8785:  NEGB
P0_8786:  SBCA #$FF
P0_8788:  SUBD #$0BB8                 ;still within $0BB8 in x
P0_878B:  BCC  P0_879F
P0_878D:  LDD  7,U
P0_878F:  SUBD MS_TY+M_S1
P0_8792:  BPL  P0_8798                ;IFMI
P0_8794:  COMA                        ;NEGD  ABSOLUTE VALUE
P0_8795:  NEGB
P0_8796:  SBCA #$FF
P0_8798:  SUBD #$05DC                 ;and $05DC in y: no new bonus yet
P0_879B:  BCC  P0_879F
P0_879D:  BRA  P0_87AE
P0_879F:  LEAU $19,U
P0_87A2:  CMPU #cable_rec
P0_87A6:  BCS  P0_8773
P0_87A8:  LDD  #$0000                 ;the player has left it
P0_87AB:  STD  atat_under
P0_87AE:  LDD  atat_under             ;under no walker: look for one
P0_87B1:  BNE  P0_87EE
P0_87B3:  LDU  #atat_rec
P0_87B6:  LDA  ,U
P0_87B8:  BEQ  P0_87E5
P0_87BA:  LDD  5,U
P0_87BC:  SUBD s1_tx
P0_87BF:  BPL  P0_87C5                ;IFMI
P0_87C1:  COMA                        ;NEGD  ABSOLUTE VALUE
P0_87C2:  NEGB
P0_87C3:  SBCA #$FF
P0_87C5:  SUBD #$07D0                 ;within $07D0 in x
P0_87C8:  BCC  P0_87E5
P0_87CA:  LDD  7,U
P0_87CC:  SUBD MS_TY+M_S1
P0_87CF:  BPL  P0_87D5                ;IFMI
P0_87D1:  COMA                        ;NEGD  ABSOLUTE VALUE
P0_87D2:  NEGB
P0_87D3:  SBCA #$FF
P0_87D5:  SUBD #$03E8                 ;and $03E8 in y: the player passes under this walker
P0_87D8:  BCC  P0_87E5
P0_87DA:  STU  atat_under             ;remember it, score the legs bonus
P0_87DD:  JSR  scr_legs_bonus
P0_87E0:  JSR  hold_adv_legs
P0_87E3:  BRA  P0_87EE
P0_87E5:  LEAU $19,U
P0_87E8:  CMPU #cable_rec
P0_87EC:  BCS  P0_87B6
P0_87EE:  CLR  w2_active_b            ;count the live walkers afresh
P0_87F1:  LDU  #atat_rec
P0_87F4:  LDA  ,U
P0_87F6:  BEQ  P0_881E
P0_87F8:  INC  w2_active_b
P0_87FB:  LDB  3,U                    ;run the shot delay down to 0
P0_87FD:  BEQ  P0_8801
P0_87FF:  DEC  3,U
P0_8801:  JSR  atat_head_swing
P0_8804:  JSR  atat_move_mode
P0_8807:  LDA  ,U                     ;it may have been blown up
P0_8809:  BEQ  P0_881E                ;free now: nothing more
P0_880B:  BITA #$02                   ;bit 1 of the type: falling, caught by the tow cable
P0_880D:  BNE  P0_8814
P0_880F:  JSR  atat_step_anim
P0_8812:  BRA  P0_881E
P0_8814:  LDD  9,U                    ;falling: the cable's centre comes down with it, at half the walker's height + $0300
P0_8816:  LSRA
P0_8817:  RORB
P0_8818:  ADDD #$0300
P0_881B:  STD  cable_tz
P0_881E:  LEAU $19,U
P0_8821:  CMPU #cable_rec
P0_8825:  BCS  P0_87F4
P0_8827:  RTS

;------------------------------------------------------------------------------
; atat_head_swing - moves the head of the AT-AT record at U: adds the pitch rate to the pitch angle and the yaw
;   rate to the yaw angle, turning a rate round at random when the angle would leave its range, and takes the size
;   of each rate (1 to 3) from a table indexed by the angle. when the head saw the player in the last view but was
;   not yet aimed, the two rates are first pointed towards the player by the signs atat_head_aim left in bytes $17
;   and $18
;------------------------------------------------------------------------------
atat_head_swing:
P0_8828:  PSHS X
P0_882A:  JSR  rnd_set
P0_882D:  LDA  1,U                    ;bit 2: the head saw the player last frame
P0_882F:  BITA #$04
P0_8831:  BEQ  P0_8855
P0_8833:  BITA #$02                   ;bit 1: already aimed, leave the rates alone
P0_8835:  BNE  P0_8855
P0_8837:  LDA  $14,U                  ;pitch rate against the player's height as seen from the head
P0_883A:  EORA $17,U
P0_883D:  BPL  P0_8846
P0_883F:  LDA  $14,U                  ;signs differ: turn the pitch rate round
P0_8842:  NEGA
P0_8843:  STA  $14,U
P0_8846:  LDA  $12,U                  ;yaw rate against the player's side as seen from the head
P0_8849:  EORA $18,U
P0_884C:  BMI  P0_8855
P0_884E:  LDA  $12,U                  ;signs equal: turn the yaw rate round
P0_8851:  NEGA
P0_8852:  STA  $12,U
P0_8855:  LDB  $13,U                  ;pitch angle, kept in $80-$FF (a positive one restarts from $C0)
P0_8858:  BMI  P0_885C
P0_885A:  LDB  #$C0
P0_885C:  ADDB $14,U                  ;add the pitch rate
P0_885F:  BMI  P0_886F
P0_8861:  LDA  RND_S1                 ;would leave the range: keep the angle and, one time in two, reverse the rate
P0_8863:  BPL  P0_886D
P0_8865:  LDA  $14,U
P0_8868:  EORA #$80
P0_886A:  STA  $14,U
P0_886D:  BRA  P0_8872
P0_886F:  STB  $13,U
P0_8872:  LDB  $13,U                  ;size of the pitch rate from the angle: slow at the ends, fast in the middle
P0_8875:  ANDB #$7F
P0_8877:  LSRB
P0_8878:  LSRB
P0_8879:  LSRB
P0_887A:  LDX  #atat_pit_rate
P0_887D:  LDB  B,X
P0_887F:  LDA  $14,U                  ;keep the rate's sign
P0_8882:  BPL  P0_8885
P0_8884:  NEGB
P0_8885:  STB  $14,U
P0_8888:  LDB  $11,U
P0_888B:  ADDB $12,U                  ;add the yaw rate
P0_888E:  BVC  P0_889E
P0_8890:  LDA  RND_S2                 ;would pass +-$80: keep the angle and, one time in two, reverse the rate
P0_8892:  BPL  P0_889C
P0_8894:  LDA  $12,U
P0_8897:  EORA #$80
P0_8899:  STA  $12,U
P0_889C:  BRA  P0_88A1
P0_889E:  STB  $11,U
P0_88A1:  LDB  $11,U                  ;size of the yaw rate from the angle: slow near $80, fast near 0
P0_88A4:  LSRB
P0_88A5:  LSRB
P0_88A6:  LSRB
P0_88A7:  LSRB
P0_88A8:  LDX  #atat_yaw_rate
P0_88AB:  LDB  B,X
P0_88AD:  LDA  $12,U                  ;keep the rate's sign
P0_88B0:  BPL  P0_88B3
P0_88B2:  NEGB
P0_88B3:  STB  $12,U
P0_88B6:  PULS X,PC

atat_pit_rate:
P0_88B8:  .byte $01, $01, $01, $02, $02, $02, $03, $03 ;pitch rate sizes, indexed by (pitch and $7F) / 8
P0_88C0:  .byte $03, $03, $02, $02, $02, $01, $01, $01

atat_yaw_rate:
P0_88C8:  .byte $03, $03, $03, $02, $02, $02, $01, $01 ;yaw rate sizes, indexed by yaw / 16
P0_88D0:  .byte $01, $01, $02, $02, $02, $03, $03, $03

atat_move_tab:
P0_88D8:  .word atat_mode_stand       ;movement routines by mode: 0 stand
P0_88DA:  .word atat_mode_walk        ;1 walk
P0_88DC:  .word atat_mode_fall        ;2 fall

;------------------------------------------------------------------------------
; atat_move_mode - calls the movement routine for the mode in byte 4 of the AT-AT record at U through
;   atat_move_tab: 0 stand, 1 walk, 2 fall (a mode over 2 counts as 0)
;------------------------------------------------------------------------------
atat_move_mode:
P0_88DE:  PSHS X
P0_88E0:  LDB  4,U                    ;movement mode
P0_88E2:  ASLB
P0_88E3:  CMPB #$06                   ;a mode over 2 counts as 0
P0_88E5:  BCS  P0_88E9
P0_88E7:  LDB  #$00
P0_88E9:  LDX  #atat_move_tab
P0_88EC:  JSR  [B,X]
P0_88EE:  PULS X,PC

;------------------------------------------------------------------------------
; atat_mode_stand - movement mode 0 of an AT-AT, standing: does nothing. reached through atat_move_tab, hence no
;   caller found
;------------------------------------------------------------------------------
atat_mode_stand:
P0_88F0:  RTS

;------------------------------------------------------------------------------
; atat_mode_walk - movement mode 1 of an AT-AT, walking: adds $33 to the x position of the record at U. reached
;   through atat_move_tab, hence no caller found
;------------------------------------------------------------------------------
atat_mode_walk:
P0_88F1:  LDD  5,U                    ;walk: $33 a frame along x
P0_88F3:  ADDD #$0033
P0_88F6:  STD  5,U
P0_88F8:  RTS

;------------------------------------------------------------------------------
; atat_mode_fall - movement mode 2 of an AT-AT, falling after the tow cable caught its legs: lowers the height
;   of the record at U by $0400 a frame and, when it reaches the ground, calls P0_9006 which blows the walker up,
;   scores it and respawns it. reached through atat_move_tab, hence no caller found
;------------------------------------------------------------------------------
atat_mode_fall:
P0_88F9:  LDD  5,U
P0_88FB:  ADDD #$0000                 ;no movement along x
P0_88FE:  STD  5,U
P0_8900:  LDD  9,U                    ;the height comes down by $0400 a frame
P0_8902:  SUBD #$0400
P0_8905:  STD  9,U
P0_8907:  BGE  P0_8911                ;on the ground: blow it up
P0_8909:  LDD  #$0000
P0_890C:  STD  9,U
P0_890E:  JSR  atat_destroy
P0_8911:  RTS

;------------------------------------------------------------------------------
; atat_step_anim - adds 1 to the walk cycle counter in byte $15 of the AT-AT record at U, the time the leg
;   drawing (P0_8C27) follows the leg tracks with
;------------------------------------------------------------------------------
atat_step_anim:
P0_8912:  LDA  $15,U
P0_8915:  INCA
P0_8916:  STA  $15,U
P0_8919:  RTS

;------------------------------------------------------------------------------
; atat_view_all - view of the AT-ATs, called by vew_walker, by the game over view and by man_view_walker with Y
;   at the display list. for every live record it clears the frame's flags in byte 1 (the hit flash is kept only
;   while the walker was drawn last frame), writes the colour (green, or the flash list when hit), sets the ship 2
;   block to a unit matrix and concatenates it, crashes the ship (P0_913C) when it is under a falling walker, and
;   draws the body, the legs and the head
;------------------------------------------------------------------------------
atat_view_all:
P0_891A:  LDU  #atat_rec
P0_891D:  STU  S2_PRM                 ;the record being viewed, for P0_913C
P0_891F:  LDA  ,U
P0_8921:  BEQ  P0_8982
P0_8923:  LDA  1,U                    ;the hit flash (bit 7) lasts only while the walker was drawn last frame (bit 4)
P0_8925:  BITA #$10
P0_8927:  BNE  P0_892B
P0_8929:  ANDA #$7F
P0_892B:  ANDA #$80                   ;all other flags of the frame cleared
P0_892D:  STA  1,U
P0_892F:  STY  atat_col_ptr           ;where the colour goes in the display list, for P0_913C to change
P0_8933:  LDA  1,U
P0_8935:  BITA #$80
P0_8937:  BEQ  P0_893E
P0_8939:  LDD  #$A013                 ;hit: JSRL to the flash colour list
P0_893C:  BRA  P0_8941
P0_893E:  LDD  #$6280                 ;green, brightness $80
P0_8941:  STD  ,Y++
P0_8943:  LDU  #M_CX2                 ;the ship 2 block: a unit matrix, the body is not turned
P0_8946:  JSR  UNITV
P0_8949:  LDU  S2_PRM
P0_894B:  LDA  #$40                   ;MS_CNCT: view ship 2 from ship 1
P0_894D:  JSR  MGOWT
P0_8950:  LDA  ,U
P0_8952:  BITA #$02                   ;falling
P0_8954:  BEQ  P0_8979
P0_8956:  LDD  s1_tx
P0_8959:  SUBD 5,U
P0_895B:  BPL  P0_8961
P0_895D:  COMA
P0_895E:  NEGB
P0_895F:  SBCA #$FF
P0_8961:  SUBD #$0BB8                 ;and the player under it, within $0BB8 in x
P0_8964:  BCC  P0_8979
P0_8966:  LDD  s1_ty
P0_8969:  SUBD 7,U
P0_896B:  BPL  P0_8971
P0_896D:  COMA
P0_896E:  NEGB
P0_896F:  SBCA #$FF
P0_8971:  SUBD #$05DC                 ;and $05DC in y
P0_8974:  BCC  P0_8979
P0_8976:  JSR  atat_crash             ;the ship runs into it
P0_8979:  JSR  atat_view_body
P0_897C:  JSR  atat_view_legs
P0_897F:  JSR  atat_view_head
P0_8982:  LEAU $19,U
P0_8985:  CMPU #cable_rec
P0_8989:  BCS  P0_891D
P0_898B:  RTS

;------------------------------------------------------------------------------
; atat_view_body - views the centre of the AT-AT at U from the ship (pre-subtract MS_PSB2 on its position),
;   keeps the result in M_XT, M_YT and M_ZT for the legs and the head, and calls atat_draw_body when the centre is
;   ahead between $0010 and $4000 and within 45 degrees of the line of sight both ways
;------------------------------------------------------------------------------
atat_view_body:
P0_898C:  LDD  5,U
P0_898E:  STD  M_X0
P0_8991:  LDD  7,U
P0_8993:  STD  M_Y0
P0_8996:  LDD  9,U
P0_8998:  STD  4+M_X0                 ;UP/DOWN VID Y IS MATH Z
P0_899B:  LDD  #MS_X0BC               ;the scratch block M_X0
P0_899E:  STD  M_BIC
P0_89A1:  LDA  #$67                   ;MS_PSB2: the centre as seen from the ship
P0_89A3:  JSR  MGOWT
P0_89A6:  LDD  M_ZP
P0_89A9:  STD  M_ZT                   ;FOR LATER SAFEKEEPING
P0_89AC:  LDD  M_YP
P0_89AF:  STD  M_YT                   ;LAZAR VIDEO LOC IF SHIP NOT ROTATED
P0_89B2:  LDD  M_XP
P0_89B5:  STD  M_XT
P0_89B8:  CMPD #$0010                 ;x is the distance ahead: not behind or too near
P0_89BC:  BLE  P0_89E3
P0_89BE:  CMPD #$4000
P0_89C2:  BHS  P0_89E3                ;IFLO  NOT TOO FAR ==> WITIN RANGE
;CHECK FOR 45 DEGREES
P0_89C4:  LDD  M_YP                   ;YP
P0_89C7:  BPL  P0_89CD                ;IFMI
P0_89C9:  COMA                        ;NEGD
P0_89CA:  NEGB
P0_89CB:  SBCA #$FF
P0_89CD:  SUBD M_XP
P0_89D0:  BHS  P0_89E3                ;IFLO  ?OBJECT NOW DEFINATELY VISIBLE?
;CHECK FOR 45 DEGREES
P0_89D2:  LDD  M_ZP                   ;YP
P0_89D5:  BPL  P0_89DB                ;IFMI
P0_89D7:  COMA                        ;NEGD
P0_89D8:  NEGB
P0_89D9:  SBCA #$FF
P0_89DB:  SUBD M_XP
P0_89DE:  BHS  P0_89E3                ;IFLO  ?OBJECT NOW DEFINATELY VISIBLE?
P0_89E0:  JSR  atat_draw_body
P0_89E3:  RTS

;------------------------------------------------------------------------------
; atat_draw_body - draws the body of the AT-AT at U, object $17: marks the record drawn and its body in view
;   (bits $10 and $40 of byte 1), dims the colour with the distance beyond $2000, has bank 1 view and draw the
;   object's points and tests the lazar against the body (P0_8EE1)
;------------------------------------------------------------------------------
atat_draw_body:
P0_89E4:  LDA  1,U                    ;bit 4: drawn this frame, bit 6: the body is in view
P0_89E6:  ORA  #$50
P0_89E8:  STA  1,U
P0_89EA:  LDD  M_XT                   ;beyond $2000 the colour dims with the distance
P0_89ED:  SUBD #$2000
P0_89F0:  BLE  P0_8A0D
P0_89F2:  LDD  #$4000                 ;$4000 - distance, held to 0-$0800
P0_89F5:  SUBD M_XT
P0_89F8:  BGE  P0_89FD
P0_89FA:  LDD  #$0000
P0_89FD:  CMPD #$0800
P0_8A01:  BLE  P0_8A06
P0_8A03:  LDD  #$0800
P0_8A06:  JSR  lsrd4                  ;/16: brightness 0-$80
P0_8A09:  LDA  #$62                   ;green with that brightness
P0_8A0B:  STD  ,Y++
P0_8A0D:  LDB  #$17                   ;object $17, the body: view its points (JOBJBPNT)
P0_8A0F:  JSR  L60D2
P0_8A12:  JSR  L60E4                  ;draw the object
P0_8A15:  JSR  L60BA                  ;end of the object
P0_8A18:  JSR  atat_body_hit          ;lazar against the body
P0_8A1B:  RTS

;------------------------------------------------------------------------------
; atat_view_legs - draws the four legs of the AT-AT at U: only a call of P0_8C27
;------------------------------------------------------------------------------
atat_view_legs:
P0_8A1C:  JSR  atat_legs
P0_8A1F:  RTS

;------------------------------------------------------------------------------
; atat_view_head - views the head of the AT-AT at U: post-adds the head's offset in bytes 11 to 16 of the record
;   to the viewed centre and, when that point is ahead between $0010 and $4000 and within 45 degrees both ways,
;   sets the colour (dimmed beyond $2000, else full brightness unless the hit flash is on), makes the point the
;   new M_XT, M_YT, M_ZT and calls atat_draw_head
;------------------------------------------------------------------------------
atat_view_head:
P0_8A20:  LDD  11,U                   ;the head's place from the centre
P0_8A22:  STD  M_X0
P0_8A25:  LDD  13,U
P0_8A27:  STD  M_Y0
P0_8A2A:  LDD  15,U
P0_8A2C:  STD  M_Z0
P0_8A2F:  LDD  #MS_X0BC
P0_8A32:  STD  M_BIC
P0_8A35:  LDA  #$50                   ;MS_PAD: add the viewed centre
P0_8A37:  JSR  MGOWT
P0_8A3A:  LDD  M_XP
P0_8A3D:  CMPD #$0010                 ;not behind or too near
P0_8A41:  BLE  P0_8AA4
P0_8A43:  CMPD #$4000                 ;not too far
P0_8A47:  BCC  P0_8AA4
P0_8A49:  LDD  M_YP
P0_8A4C:  STD  M_YT
P0_8A4F:  BPL  P0_8A55                ;IFMI
P0_8A51:  COMA                        ;NEGD
P0_8A52:  NEGB
P0_8A53:  SBCA #$FF
P0_8A55:  SUBD M_XP
P0_8A58:  BCC  P0_8AA4
P0_8A5A:  LDD  M_ZP
P0_8A5D:  STD  M_ZT
P0_8A60:  BPL  P0_8A66                ;IFMI
P0_8A62:  COMA                        ;NEGD
P0_8A63:  NEGB
P0_8A64:  SBCA #$FF
P0_8A66:  SUBD M_XP
P0_8A69:  BCC  P0_8AA4
P0_8A6B:  LDD  M_XT                   ;beyond $2000 the colour dims with the distance
P0_8A6E:  SUBD #$2000
P0_8A71:  BLE  P0_8A90
P0_8A73:  LDD  #$4000
P0_8A76:  SUBD M_XT
P0_8A79:  BGE  P0_8A7E
P0_8A7B:  LDD  #$0000
P0_8A7E:  CMPD #$0C00                 ;held to 0-$0C00: brightness 0-$C0
P0_8A82:  BLE  P0_8A87
P0_8A84:  LDD  #$0C00
P0_8A87:  JSR  lsrd4
P0_8A8A:  LDA  #$62
P0_8A8C:  STD  ,Y++
P0_8A8E:  BRA  P0_8A9B
P0_8A90:  LDA  1,U                    ;near: full colour, unless the hit flash is on
P0_8A92:  BITA #$80
P0_8A94:  BNE  P0_8A9B
P0_8A96:  LDD  #$62C0                 ;green, brightness $C0
P0_8A99:  STD  ,Y++
P0_8A9B:  LDD  M_XP                   ;the head's centre is now the viewed centre
P0_8A9E:  STD  M_XT
P0_8AA1:  JSR  atat_draw_head
P0_8AA4:  RTS

;------------------------------------------------------------------------------
; atat_head_aim - aim of the head's guns at the player, called while the head is drawn with U at the AT-AT
;   record. only when the head faces the ship: finds the muzzle of the gun on the side given by bit 7 of the type
;   byte, moves the ship 2 block there and views the player from it. with the player in front the head turns red,
;   bit 2 of byte 1 is set and the player's side and height are left in bytes $17 and $18 for atat_head_swing.
;   with the player within 45 degrees (always from w2_level_b 9 up) the head flashes, bit 1 is set and, when the
;   record may shoot and its delay has run out, a shot is started on page 1 (P1_8F8B) and the gun side changed.
;   ends with the lazar test on the guns (P0_8FA6)
;------------------------------------------------------------------------------
atat_head_aim:
P0_8AA5:  PSHS X,U
P0_8AA7:  LDD  #$6240                 ;green, brightness $40: replaced below when the head sees the player
P0_8AAA:  STD  ,Y++
P0_8AAC:  LDA  M_AX                   ;A.X of the concatenated head matrix: only when negative, the head facing the ship
P0_8AAF:  LBPL P0_8B80
P0_8AB3:  LDD  #$05DC                 ;the gun's muzzle in the head's coordinates: x $05DC forward
P0_8AB6:  STD  M_X0
P0_8AB9:  LDA  ,U                     ;bit 7 of the type: which side's gun
P0_8ABB:  BITA #$80
P0_8ABD:  BNE  P0_8AC4
P0_8ABF:  LDD  #$01C2                 ;y +$01C2
P0_8AC2:  BRA  P0_8AC7                ;ELSE
P0_8AC4:  LDD  #$FE3E                 ;or y -$01C2
P0_8AC7:  STD  M_Y0
P0_8ACA:  LDD  #$FD5D                 ;LEFT POINT
P0_8ACD:  STD  M_Z0
P0_8AD0:  LDD  #MS_X0BC
P0_8AD3:  STD  M_BIC
P0_8AD6:  LDA  #$50
P0_8AD8:  JSR  MGOWT                  ;PRESUB 2
P0_8ADB:  LDD  M_XP                   ;the muzzle as seen from the ship, doubled, into the ship 2 block's position
P0_8ADE:  ASLB
P0_8ADF:  ROLA
P0_8AE0:  STD  M_XT2
P0_8AE3:  LDD  M_YP
P0_8AE6:  ASLB
P0_8AE7:  ROLA
P0_8AE8:  STD  M_YT2
P0_8AEB:  LDD  M_ZP
P0_8AEE:  ASLB
P0_8AEF:  ROLA
P0_8AF0:  STD  M_ZT2
P0_8AF3:  LDD  #$000C                 ;BIC of M_XT2
P0_8AF6:  STD  M_BIC
P0_8AF9:  LDA  #MS_S1UN               ;program $60: back to universe coordinates
P0_8AFB:  JSR  MGOWT
P0_8AFE:  LDD  M_XP                   ;the ship 2 block now sits at the muzzle
P0_8B01:  STD  M_XT2
P0_8B04:  LDD  M_YP
P0_8B07:  STD  M_YT2
P0_8B0A:  LDD  M_ZP
P0_8B0D:  STD  M_ZT2
P0_8B10:  LDD  #$0013                 ;BIC of the player's position, $5098
P0_8B13:  STD  M_BIC
P0_8B16:  JSR  presub_via_u2          ;the player as seen from the head
P0_8B19:  LDD  M_XP
P0_8B1C:  STD  M_DVD
P0_8B1F:  LBLE P0_8B80                ;the player is behind the head: no aim
P0_8B23:  LDD  #$6480                 ;red in place of the green written above
P0_8B26:  STD  -2,Y
P0_8B28:  LDA  1,U                    ;bit 2: the head sees the player
P0_8B2A:  ORA  #$04
P0_8B2C:  STA  1,U
P0_8B2E:  LDA  M_ZP                   ;the player's height and side from the head, for atat_head_swing
P0_8B31:  STA  $17,U
P0_8B34:  LDA  M_YP
P0_8B37:  STA  $18,U
P0_8B3A:  LDA  w2_level_b             ;from level 9 up the head shoots whatever the angle
P0_8B3D:  CMPA #$09
P0_8B3F:  BGE  P0_8B5D
P0_8B41:  LDD  M_YP
P0_8B44:  BGE  P0_8B4A
P0_8B46:  COMA                        ;NEGD  ABSOLUTE VALUE
P0_8B47:  NEGB
P0_8B48:  SBCA #$FF
P0_8B4A:  SUBD M_XP
P0_8B4D:  BGE  P0_8B7D                ;IFLT  ?Y IN FRONT VIEW?
P0_8B4F:  LDD  M_ZP
P0_8B52:  BGE  P0_8B58
P0_8B54:  COMA                        ;NEGD  ABSOLUTE VALUE
P0_8B55:  NEGB
P0_8B56:  SBCA #$FF
P0_8B58:  SUBD M_XP
P0_8B5B:  BGE  P0_8B7D                ;IFLT  ?Z IN FRONT VIEW?
P0_8B5D:  LDD  #$A015                 ;aimed: JSRL to VRMFL, the head flashes
P0_8B60:  STD  -2,Y
P0_8B62:  LDA  1,U                    ;bit 1: aimed
P0_8B64:  ORA  #$02
P0_8B66:  STA  1,U
P0_8B68:  LDA  ,U                     ;bit 5 of the type: this walker shoots
P0_8B6A:  BITA #$20
P0_8B6C:  BEQ  P0_8B7D
P0_8B6E:  LDA  3,U                    ;and its delay has run out
P0_8B70:  BNE  P0_8B7D
P0_8B72:  JSR  P0_84F0                ;calls page 1 atat_fire
P0_8B75:  BCC  P0_8B7D                ;carry set: a shot was started
P0_8B77:  LDA  ,U                     ;the other gun next time
P0_8B79:  EORA #$80
P0_8B7B:  STA  ,U
P0_8B7D:  JSR  atat_eye_hit           ;lazar against the guns
P0_8B80:  PULS X,U,PC

;------------------------------------------------------------------------------
; atat_draw_head - draws the head of the AT-AT at U: marks the record drawn, yaws and pitches the ship 2 block
;   by a quarter of the head's two angles and concatenates it, views the points of object $18, the head, and draws
;   the neck (object $1A, only when the body is in view, since its lines run from points of the body to the back
;   of the head), the head itself (object $18) and, after the lazar test on the head (atat_head_hit) and
;   atat_head_aim, the eye (object $19) in the colour atat_head_aim left
;------------------------------------------------------------------------------
atat_draw_head:
P0_8B82:  LDA  1,U                    ;bit 4: drawn this frame
P0_8B84:  ORA  #$10
P0_8B86:  STA  1,U
P0_8B88:  LDD  #$0009                 ;BIC of the ship 2 block
P0_8B8B:  STD  M_BIC
P0_8B8E:  LDB  $11,U                  ;a quarter of the head's yaw angle: 45 degrees each way at most
P0_8B91:  ASRB
P0_8B92:  ASRB
P0_8B93:  JSR  yaw_by_angle
P0_8B96:  LDD  #$0009
P0_8B99:  STD  M_BIC
P0_8B9C:  LDB  $13,U                  ;a quarter of the head's pitch angle
P0_8B9F:  ASRB
P0_8BA0:  ASRB
P0_8BA1:  JSR  pitch_by_angle
P0_8BA4:  LDA  #$40                   ;MS_CNCT: view the turned head from the ship
P0_8BA6:  JSR  MGOWT
P0_8BA9:  LDB  #$18                   ;object $18, the head: view its points (JOBJBPNT)
P0_8BAB:  JSR  L60D2
P0_8BAE:  LDA  1,U                    ;the body is in view
P0_8BB0:  BITA #$40
P0_8BB2:  BEQ  P0_8BB9
P0_8BB4:  LDB  #$1A                   ;then object $1A is drawn, from the head's points
P0_8BB6:  JSR  L60EA
P0_8BB9:  LDB  #$18                   ;draw object $18
P0_8BBB:  JSR  L60EA
P0_8BBE:  JSR  atat_head_hit          ;lazar against the head
P0_8BC1:  JSR  atat_head_aim
P0_8BC4:  LDB  #$19                   ;draw object $19
P0_8BC6:  JSR  L60EA
P0_8BC9:  JSR  L60BA                  ;end of the object
P0_8BCC:  RTS

atat_gait_tab:
P0_8BCD:  .word atat_legs_0           ;leg sets by byte $16 of the record: each a list of four leg records
P0_8BCF:  .word atat_legs_1
P0_8BD1:  .word atat_legs_2

atat_legs_0:
P0_8BD3:  .word atat_leg_recs         ;leg set 0: pointers to its four leg records
P0_8BD5:  .word P0_8BF0
P0_8BD7:  .word P0_8BF5
P0_8BD9:  .word P0_8BFA

atat_legs_1:
P0_8BDB:  .word P0_8BFF               ;leg set 1
P0_8BDD:  .word P0_8C04
P0_8BDF:  .word P0_8C09
P0_8BE1:  .word P0_8C0E

atat_legs_2:
P0_8BE3:  .word P0_8C13               ;leg set 2
P0_8BE5:  .word P0_8C18
P0_8BE7:  .word P0_8C1D
P0_8BE9:  .word P0_8C22

atat_leg_recs:
P0_8BEB:  .byte $04                   ;AT-AT leg record 0: a byte and two words  leg records, 5 bytes: number of the leg's first track (P0_93B4 takes it and the next two), then where the leg joins the body, x word and y word
P0_8BEC:  .word $04DC, $01F1
P0_8BF0:  .byte $07                   ;AT-AT leg record 1: a byte and two words
P0_8BF1:  .word $04DC, $FE0F
P0_8BF5:  .byte $0A                   ;AT-AT leg record 2: a byte and two words
P0_8BF6:  .word $FB24, $FE0F
P0_8BFA:  .byte $0D                   ;AT-AT leg record 3: a byte and two words
P0_8BFB:  .word $FB24, $01F1
P0_8BFF:  .byte $10                   ;AT-AT leg record 4: a byte and two words
P0_8C00:  .word $04DC, $01F1
P0_8C04:  .byte $13                   ;AT-AT leg record 5: a byte and two words
P0_8C05:  .word $04DC, $FE0F
P0_8C09:  .byte $16                   ;AT-AT leg record 6: a byte and two words
P0_8C0A:  .word $FB24, $FE0F
P0_8C0E:  .byte $19                   ;AT-AT leg record 7: a byte and two words
P0_8C0F:  .word $FB24, $01F1
P0_8C13:  .byte $1C                   ;AT-AT leg record 8: a byte and two words
P0_8C14:  .word $04DC, $01F1
P0_8C18:  .byte $1F                   ;AT-AT leg record 9: a byte and two words
P0_8C19:  .word $04DC, $FE0F
P0_8C1D:  .byte $22                   ;AT-AT leg record 10: a byte and two words
P0_8C1E:  .word $FB24, $FE0F
P0_8C22:  .byte $25                   ;AT-AT leg record 11: a byte and two words
P0_8C23:  .word $FB24, $01F1

;------------------------------------------------------------------------------
; atat_legs - draws the four legs of the AT-AT at U, called by atat_view_legs: puts the walk cycle counter (byte
;   $15 of the record) in anim_frame, takes the leg set for byte $16 from atat_gait_tab (set 0 when it is over 2)
;   and calls atat_leg_set with X at the set's four leg record pointers
;------------------------------------------------------------------------------
atat_legs:
P0_8C27:  PSHS X
P0_8C29:  LDA  $15,U                  ;the walk cycle counter of the record
P0_8C2C:  STA  anim_frame
P0_8C2F:  LDX  #atat_gait_tab
P0_8C32:  LDB  $16,U                  ;byte $16: leg set 0-2
P0_8C35:  ABX
P0_8C36:  ABX
P0_8C37:  CMPX #atat_legs_0           ;past the three sets: set 0
P0_8C3A:  BCS  P0_8C3F
P0_8C3C:  LDX  #atat_gait_tab
P0_8C3F:  LDX  ,X                     ;X = the set's four leg record pointers
P0_8C41:  JSR  atat_leg_set
P0_8C44:  PULS X,PC

;------------------------------------------------------------------------------
; atat_leg_set - draws the four legs of one leg set: X points at four pointers to 5-byte leg records, the first
;   two (front legs) go to atat_front_leg and the last two (rear legs) to atat_rear_leg
;------------------------------------------------------------------------------
atat_leg_set:
P0_8C46:  PSHS X
P0_8C48:  JSR  atat_front_leg         ;the two front legs
P0_8C4B:  LEAX 2,X
P0_8C4D:  JSR  atat_front_leg
P0_8C50:  LEAX 2,X
P0_8C52:  JSR  atat_rear_leg          ;the two rear legs
P0_8C55:  LEAX 2,X
P0_8C57:  JSR  atat_rear_leg
P0_8C5A:  PULS X,PC

;------------------------------------------------------------------------------
; atat_front_leg - works out and draws one front leg of the AT-AT at U. X points at the pointer to the leg
;   record (first track number, hip x word, hip y word). restarts the perspected points at BJ_PNT and views three
;   points of the hip (atat_front_hip) and three of the knee (atat_knee, which also tests the tow cable). only
;   when the knee is within 45 degrees left and right of straight ahead it marks the walker drawn, sets the
;   brightness or crashes the ship (atat_leg_shade), views the ankle and the foot (atat_ankle_foot) and has bank 1
;   draw object $1B through the 12 points. ends by storing anim_frame back in byte $15 of the record
;------------------------------------------------------------------------------
atat_front_leg:
P0_8C5C:  PSHS X
P0_8C5E:  LDX  ,X                     ;X = leg record: first track number, hip x, hip y
P0_8C60:  JSR  L60CC                  ;bank 1 KD9EF: perspected points from the start of BJ_PNT
P0_8C63:  LDD  1,X
P0_8C65:  STD  M_X0
P0_8C68:  LDD  3,X
P0_8C6A:  STD  M_Y0
P0_8C6D:  JSR  atat_front_hip         ;three points of the hip
P0_8C70:  LDD  1,X
P0_8C72:  STD  M_X0
P0_8C75:  LDD  3,X
P0_8C77:  STD  M_Y0
P0_8C7A:  JSR  atat_knee              ;three points of the knee, and the tow cable test
P0_8C7D:  LDD  #MS_X0BC               ;the scratch point is now the knee's last point
P0_8C80:  STD  M_BIC
P0_8C83:  LDA  #$50
P0_8C85:  JSR  MGOWT                  ;PRESUB 2
P0_8C88:  LDD  M_YP                   ;is the knee within 45 degrees left and right of straight ahead
P0_8C8B:  BPL  P0_8C8F
P0_8C8D:  COMA                        ;NEGD
P0_8C8E:  COMB
P0_8C8F:  SUBD M_XP
P0_8C92:  BGE  P0_8CB2                ;no: the lower leg is not worked out and the leg is not drawn
P0_8C94:  LDA  1,U                    ;bit 4: the walker was drawn this frame
P0_8C96:  ORA  #$10
P0_8C98:  STA  1,U
P0_8C9A:  JSR  atat_leg_shade         ;dim with the distance, or crash into the leg
P0_8C9D:  LDD  1,X
P0_8C9F:  STD  M_X0
P0_8CA2:  LDD  3,X
P0_8CA4:  STD  M_Y0
P0_8CA7:  JSR  atat_ankle_foot        ;three points of the ankle and three of the foot
P0_8CAA:  LDB  #$1B                   ;object $1B, the leg: bank 1 draws it through the 12 points
P0_8CAC:  JSR  L60EA
P0_8CAF:  JSR  L60BA                  ;end of the object
P0_8CB2:  LDA  anim_frame             ;the cycle counter back to the record, 0 when the cycle has wrapped
P0_8CB5:  STA  $15,U
P0_8CB8:  PULS X,PC

;------------------------------------------------------------------------------
; atat_rear_leg - works out and draws one rear leg of the AT-AT at U: the same code as atat_front_leg except
;   that the hip points come from atat_rear_hip
;------------------------------------------------------------------------------
atat_rear_leg:
P0_8CBA:  PSHS X
P0_8CBC:  LDX  ,X
P0_8CBE:  JSR  L60CC                  ;perspected points from the start of BJ_PNT
P0_8CC1:  LDD  1,X
P0_8CC3:  STD  M_X0
P0_8CC6:  LDD  3,X
P0_8CC8:  STD  M_Y0
P0_8CCB:  JSR  atat_rear_hip          ;three points of the hip
P0_8CCE:  LDD  1,X
P0_8CD0:  STD  M_X0
P0_8CD3:  LDD  3,X
P0_8CD5:  STD  M_Y0
P0_8CD8:  JSR  atat_knee              ;three points of the knee, and the tow cable test
P0_8CDB:  LDD  #MS_X0BC
P0_8CDE:  STD  M_BIC
P0_8CE1:  LDA  #$50
P0_8CE3:  JSR  MGOWT                  ;PRESUB 2
P0_8CE6:  LDD  M_YP                   ;is the knee within 45 degrees left and right of straight ahead
P0_8CE9:  BPL  P0_8CED
P0_8CEB:  COMA                        ;NEGD
P0_8CEC:  COMB
P0_8CED:  SUBD M_XP
P0_8CF0:  BGE  P0_8D10                ;no: the leg is not drawn
P0_8CF2:  LDA  1,U
P0_8CF4:  ORA  #$10
P0_8CF6:  STA  1,U
P0_8CF8:  JSR  atat_leg_shade
P0_8CFB:  LDD  1,X
P0_8CFD:  STD  M_X0
P0_8D00:  LDD  3,X
P0_8D02:  STD  M_Y0
P0_8D05:  JSR  atat_ankle_foot        ;three points of the ankle and three of the foot
P0_8D08:  LDB  #$1B                   ;object $1B, the leg
P0_8D0A:  JSR  L60EA
P0_8D0D:  JSR  L60BA
P0_8D10:  LDA  anim_frame
P0_8D13:  STA  $15,U
P0_8D16:  PULS X,PC

;------------------------------------------------------------------------------
; atat_leg_shade - called for a leg whose knee is in view. when the walker's centre (M_XT) is farther than $2000
;   it writes the colour word for the leg, colour 2 with a brightness of ($4000 - distance, held to 0-$0800) / 16.
;   when the walker is nearer and the knee is less than $0280 ahead of the ship (M_XP) the ship has flown into the
;   leg and atat_crash is called
;------------------------------------------------------------------------------
atat_leg_shade:
P0_8D18:  LDD  M_XT                   ;distance of the walker's centre, left by atat_view_body
P0_8D1B:  SUBD #$2000
P0_8D1E:  BLE  P0_8D3D                ;$2000 or nearer: full colour, test for a crash
P0_8D20:  LDD  #$4000                 ;$4000 - distance, held to 0-$0800
P0_8D23:  SUBD M_XT
P0_8D26:  BGE  P0_8D2B
P0_8D28:  LDD  #$0000
P0_8D2B:  CMPD #$0800
P0_8D2F:  BLE  P0_8D34
P0_8D31:  LDD  #$0800
P0_8D34:  JSR  lsrd4                  ;/16: brightness 0-$80
P0_8D37:  LDA  #$62                   ;colour 2 (green) with that brightness
P0_8D39:  STD  ,Y++
P0_8D3B:  BRA  P0_8D48
P0_8D3D:  LDD  M_XP                   ;how far ahead of the ship the knee is
P0_8D40:  SUBD #$0280
P0_8D43:  BCC  P0_8D48                ;less than $0280: the ship runs into the leg
P0_8D45:  JSR  atat_crash
P0_8D48:  RTS

;------------------------------------------------------------------------------
; atat_rear_hip - hip of a rear leg: with the hip's x and y already in M_X0 and M_Y0 it sets z to 0, adds the
;   offset of the leg's first track (atat_add_track) and views the three points of the joint (atat_joint_pts)
;------------------------------------------------------------------------------
atat_rear_hip:
P0_8D49:  LDD  #$0000                 ;rear hip: z 0
P0_8D4C:  STD  M_Z0
P0_8D4F:  BSR  atat_add_track
P0_8D51:  JSR  atat_joint_pts
P0_8D54:  RTS

;------------------------------------------------------------------------------
; atat_front_hip - hip of a front leg: as atat_rear_hip but with z $0117 and the three slanted points of
;   atat_fr_hip_pts
;------------------------------------------------------------------------------
atat_front_hip:
P0_8D55:  LDD  #$0117                 ;front hip: z $0117
P0_8D58:  STD  M_Z0
P0_8D5B:  BSR  atat_add_track
P0_8D5D:  JSR  atat_fr_hip_pts
P0_8D60:  RTS

;------------------------------------------------------------------------------
; atat_add_track - takes the track number in the first byte of the leg record at X, has anim_track_pos (maze
;   entry P0_85B3) interpolate that track for anim_frame and adds the offset it leaves in anim_dx, anim_dy and
;   anim_dz to the scratch point M_X0, M_Y0, M_Z0
;------------------------------------------------------------------------------
atat_add_track:
P0_8D61:  LDB  ,X                     ;track number of the hip
P0_8D63:  JSR  P0_85B3                ;calls page 0 anim_track_pos
P0_8D66:  LDD  anim_dx
P0_8D69:  ADDD M_X0
P0_8D6C:  STD  M_X0
P0_8D6F:  LDD  anim_dy
P0_8D72:  ADDD M_Y0
P0_8D75:  STD  M_Y0
P0_8D78:  LDD  anim_dz
P0_8D7B:  ADDD M_Z0
P0_8D7E:  STD  M_Z0
P0_8D81:  RTS

;------------------------------------------------------------------------------
; atat_knee - knee of the leg whose record is at X, hip x and y already in M_X0 and M_Y0: z is half way down the
;   walker's height (word 9 of the record at U) plus $0300, in the half units the leg points use, the offset of
;   the leg's second track is added, the tow cable is tested against the knee (cable_leg_test) and the three
;   points of the joint are viewed (atat_joint_pts)
;------------------------------------------------------------------------------
atat_knee:
P0_8D82:  LDD  #$0000
P0_8D85:  SUBD 9,U                    ;word 9 of the record: the walker's height, $2000 standing
P0_8D87:  ASRA
P0_8D88:  RORB
P0_8D89:  ADDD #$0300
P0_8D8C:  ASRA
P0_8D8D:  RORB
P0_8D8E:  STD  M_Z0                   ;knee z from the body, in half units: half way down plus $0300
P0_8D91:  LDB  ,X
P0_8D93:  ADDB #$01                   ;the knee's track follows the hip's
P0_8D95:  JSR  P0_85B3                ;calls page 0 anim_track_pos
P0_8D98:  LDD  anim_dx
P0_8D9B:  ADDD M_X0
P0_8D9E:  STD  M_X0
P0_8DA1:  LDD  anim_dy
P0_8DA4:  ADDD M_Y0
P0_8DA7:  STD  M_Y0
P0_8DAA:  LDD  anim_dz
P0_8DAD:  ADDD M_Z0
P0_8DB0:  STD  M_Z0
P0_8DB3:  JSR  cable_leg_test         ;has the tow cable reached this knee
P0_8DB6:  JSR  atat_joint_pts
P0_8DB9:  RTS

;------------------------------------------------------------------------------
; atat_ankle_foot - ankle and foot of the leg whose record is at X, hip x and y already in M_X0 and M_Y0: the
;   ankle is $0300 above the ground plus the offset of the leg's third track and gives three points
;   (atat_joint_pts), then z is set to the ground plus the track's z offset and the three points of the foot are
;   viewed around the place the ankle's points ended (atat_foot_pts)
;------------------------------------------------------------------------------
atat_ankle_foot:
P0_8DBA:  LDD  #$0000
P0_8DBD:  SUBD 9,U
P0_8DBF:  ADDD #$0300
P0_8DC2:  ASRA
P0_8DC3:  RORB
P0_8DC4:  STD  M_Z0                   ;ankle z from the body, in half units: $0300 above the ground
P0_8DC7:  LDB  ,X
P0_8DC9:  ADDB #$02                   ;the ankle's track is the third of the leg
P0_8DCB:  JSR  P0_85B3                ;calls page 0 anim_track_pos
P0_8DCE:  LDD  anim_dx
P0_8DD1:  ADDD M_X0
P0_8DD4:  STD  M_X0
P0_8DD7:  LDD  anim_dy
P0_8DDA:  ADDD M_Y0
P0_8DDD:  STD  M_Y0
P0_8DE0:  LDD  anim_dz
P0_8DE3:  ADDD M_Z0
P0_8DE6:  STD  M_Z0
P0_8DE9:  JSR  atat_joint_pts
P0_8DEC:  LDD  #$0000
P0_8DEF:  SUBD 9,U
P0_8DF1:  ASRA
P0_8DF2:  RORB
P0_8DF3:  ADDD anim_dz                ;foot z: the ground plus the ankle track's z offset
P0_8DF6:  STD  M_Z0
P0_8DF9:  JSR  atat_foot_pts          ;x and y still at the ankle's last point
P0_8DFC:  RTS

;------------------------------------------------------------------------------
; atat_fr_hip_pts - views three points around the scratch point for a front hip, each through bank 1 KD9F6
;   (L60DE) which adds the next perspected point to BJ_PNT: x - $0100 and z - $60, then x + $0100, y + $80 and z +
;   $60, then the same with y - $80. it leaves M_X0, M_Y0 and M_Z0 at the last point
;------------------------------------------------------------------------------
atat_fr_hip_pts:
P0_8DFD:  LDD  #$FF00
P0_8E00:  ADDD M_X0
P0_8E03:  STD  M_X0
P0_8E06:  LDD  #$FFA0
P0_8E09:  ADDD M_Z0
P0_8E0C:  STD  M_Z0
P0_8E0F:  JSR  L60DE                  ;bank 1 KD9F6: view the scratch point, its screen x and y go to the next 5 bytes of BJ_PNT
P0_8E12:  LDD  #$0200
P0_8E15:  ADDD M_X0
P0_8E18:  STD  M_X0
P0_8E1B:  LDD  #$0080
P0_8E1E:  ADDD M_Y0
P0_8E21:  STD  M_Y0
P0_8E24:  LDD  #$00C0
P0_8E27:  ADDD M_Z0
P0_8E2A:  STD  M_Z0
P0_8E2D:  JSR  L60DE
P0_8E30:  LDD  #$FF00
P0_8E33:  ADDD M_Y0
P0_8E36:  STD  M_Y0
P0_8E39:  JSR  L60DE
P0_8E3C:  RTS

;------------------------------------------------------------------------------
; atat_joint_pts - views three points around the scratch point M_X0, M_Y0, M_Z0 for one joint of a leg, each
;   through bank 1 KD9F6 (L60DE): x - $0100, then x + $0100 and y + $80, then x + $0100 and y - $80, all at the
;   same z. it leaves M_X0 and M_Y0 at the last point
;------------------------------------------------------------------------------
atat_joint_pts:
P0_8E3D:  LDD  #$FF00
P0_8E40:  ADDD M_X0
P0_8E43:  STD  M_X0
P0_8E46:  JSR  L60DE
P0_8E49:  LDD  #$0200
P0_8E4C:  ADDD M_X0
P0_8E4F:  STD  M_X0
P0_8E52:  LDD  #$0080
P0_8E55:  ADDD M_Y0
P0_8E58:  STD  M_Y0
P0_8E5B:  JSR  L60DE
P0_8E5E:  LDD  #$FF00
P0_8E61:  ADDD M_Y0
P0_8E64:  STD  M_Y0
P0_8E67:  JSR  L60DE
P0_8E6A:  RTS

;------------------------------------------------------------------------------
; atat_foot_pts - views the three points of a foot through bank 1 KD9F6 (L60DE), starting from the last point of
;   the ankle: with the ankle's centre as origin they are x - $0200, then x + $0200 and y + $0100, then x + $0200
;   and y - $0100, a triangle twice the size of a joint's
;------------------------------------------------------------------------------
atat_foot_pts:
P0_8E6B:  LDD  #$FD00
P0_8E6E:  ADDD M_X0
P0_8E71:  STD  M_X0
P0_8E74:  LDD  #$0080
P0_8E77:  ADDD M_Y0
P0_8E7A:  STD  M_Y0
P0_8E7D:  JSR  L60DE
P0_8E80:  LDD  #$0400
P0_8E83:  ADDD M_X0
P0_8E86:  STD  M_X0
P0_8E89:  LDD  #$0100
P0_8E8C:  ADDD M_Y0
P0_8E8F:  STD  M_Y0
P0_8E92:  JSR  L60DE
P0_8E95:  LDD  #$FE00
P0_8E98:  ADDD M_Y0
P0_8E9B:  STD  M_Y0
P0_8E9E:  JSR  L60DE
P0_8EA1:  RTS

;------------------------------------------------------------------------------
; atat_oct_dist - octagon distance from the laser cursor (LZ_CX, LZ_CY) to the perspected point at X, as in Star
;   Wars' S2VW and VWGUN hit tests: the larger of the absolute x and y differences or 9/16 of their sum, whichever
;   is greater, less 10, not below 0. returns it in D. page 1 has its own copy, cursor_oct_dist
;------------------------------------------------------------------------------
atat_oct_dist:
P0_8EA2:  LDD  ,X
P0_8EA4:  SUBD >LZ_CX
P0_8EA7:  BPL  P0_8EAD                ;IFMI
P0_8EA9:  COMA                        ;NEGD  ABSD
P0_8EAA:  NEGB
P0_8EAB:  SBCA #$FF
P0_8EAD:  STD  TMPOCT                 ;PREPARE FOR OCTAGON COLLISION DETECT
P0_8EAF:  STD  scratch_1
P0_8EB1:  LDD  2,X
P0_8EB3:  SUBD >LZ_CY
P0_8EB6:  BPL  P0_8EBC                ;IFMI
P0_8EB8:  COMA                        ;NEGD
P0_8EB9:  NEGB
P0_8EBA:  SBCA #$FF
P0_8EBC:  CMPD TMPSIZ
P0_8EBF:  BLE  P0_8EC3
P0_8EC1:  STD  scratch_3              ;$4803 (TMPOCT) = the larger of the two distances
P0_8EC3:  ADDD scratch_1
P0_8EC5:  LSRA
P0_8EC6:  RORB
P0_8EC7:  STD  scratch_1              ;half the sum
P0_8EC9:  LSRA
P0_8ECA:  RORB
P0_8ECB:  LSRA
P0_8ECC:  RORB
P0_8ECD:  LSRA
P0_8ECE:  RORB
P0_8ECF:  ADDD scratch_1              ;plus an eighth of that: 9/16 of the sum
P0_8ED1:  CMPD scratch_3
P0_8ED4:  BGE  P0_8ED8
P0_8ED6:  LDD  scratch_3
P0_8ED8:  SUBD #$000A                 ;less 10, not below 0
P0_8EDB:  BGE  P0_8EE0
P0_8EDD:  LDD  #$0000
P0_8EE0:  RTS

;------------------------------------------------------------------------------
; atat_body_hit - laser cursor test on the body of an AT-AT, called by atat_draw_body after object $17 is drawn.
;   only when the walker (M_XT) is nearer than atat_hit_d: finds the screen size of a length of $02EE at the
;   walker's distance and tests the cursor against the body's perspected points 21 to 24 with atat_oct_dist. when
;   the cursor is on one of them it records the distance in atat_hit_d with atat_hit_rec 0, so a shot stops on the
;   body and destroys nothing, and counts w2_spk_cnt, which starts the speech spk_cmd_03 after 20 such frames in a
;   row and then parks at $80. when it is on none the count starts again
;------------------------------------------------------------------------------
atat_body_hit:
P0_8EE1:  LDD  M_XT
P0_8EE4:  CMPD atat_hit_d             ;something nearer is already under the cursor
P0_8EE8:  BCC  P0_8F44
P0_8EEA:  SUBD #$02EE                 ;distance less $02EE, at least $02EE, to the divider
P0_8EED:  CMPD #$02EE
P0_8EF1:  BGE  P0_8EF6
P0_8EF3:  LDD  #$02EE
P0_8EF6:  STD  M_DVD
P0_8EF9:  LDD  #$02EE                 ;a length of $02EE in both multiplier inputs
P0_8EFC:  STD  M_YP
P0_8EFF:  LDD  #$02EE
P0_8F02:  STD  M_ZP
P0_8F05:  LDD  M_QUO                  ;the reciprocal of the distance
P0_8F08:  STD  M_XP                   ;M_YP and M_ZP = that length as seen on the screen
P0_8F0B:  LDA  #MS_PERS
P0_8F0D:  JSR  MGOWT
P0_8F10:  LDX  #BJ_PNT+$69            ;perspected points 21 to 24, the last four of the body (its points start at BJ_PNT+5)
P0_8F13:  JSR  atat_oct_dist
P0_8F16:  SUBD M_YP                   ;cursor nearer to the point than that length: on the body
P0_8F19:  BLT  P0_8F45
P0_8F1B:  LDX  #BJ_PNT+$6E
P0_8F1E:  JSR  atat_oct_dist
P0_8F21:  SUBD M_YP
P0_8F24:  BLT  P0_8F45
P0_8F26:  LDX  #BJ_PNT+$73
P0_8F29:  JSR  atat_oct_dist
P0_8F2C:  SUBD M_ZP
P0_8F2F:  BLT  P0_8F45
P0_8F31:  LDX  #BJ_PNT+$78
P0_8F34:  JSR  atat_oct_dist
P0_8F37:  SUBD M_ZP
P0_8F3A:  BLT  P0_8F45
P0_8F3C:  LDA  w2_spk_cnt             ;cursor not on the body: the count starts again, unless the speech has been given
P0_8F3F:  BMI  P0_8F44
P0_8F41:  CLR  w2_spk_cnt
P0_8F44:  RTS
P0_8F45:  LDD  #$0000                 ;on the body: no record, the shot stops here and destroys nothing
P0_8F48:  STD  atat_hit_rec
P0_8F4B:  LDD  M_XT                   ;the nearest thing under the cursor so far
P0_8F4E:  STD  atat_hit_d
P0_8F51:  LDA  w2_spk_cnt             ;$80: the speech has been given
P0_8F54:  BMI  P0_8F63
P0_8F56:  INCA
P0_8F57:  CMPA #$14                   ;20 frames in a row on a body
P0_8F59:  BNE  P0_8F60
P0_8F5B:  JSR  spk_cmd_03
P0_8F5E:  LDA  #$80
P0_8F60:  STA  w2_spk_cnt
P0_8F63:  RTS

;------------------------------------------------------------------------------
; atat_head_hit - laser cursor test on the head of an AT-AT, called by atat_draw_head after object $18 is drawn.
;   only when the head (M_XT) is nearer than atat_hit_d: finds the screen size of a length of $0271 at the head's
;   distance (less $01F4, at least $01F4) and, when the cursor is within it of perspected point 42, records the
;   distance in atat_hit_d with atat_hit_rec 0, a hit that destroys nothing
;------------------------------------------------------------------------------
atat_head_hit:
P0_8F64:  LDD  M_XT
P0_8F67:  CMPD atat_hit_d
P0_8F6B:  BCC  P0_8F98
P0_8F6D:  SUBD #$01F4                 ;distance less $01F4, at least $01F4, to the divider
P0_8F70:  CMPD #$01F4
P0_8F74:  BGE  P0_8F79
P0_8F76:  LDD  #$01F4
P0_8F79:  STD  M_DVD
P0_8F7C:  LDD  #$0271                 ;a length of $0271
P0_8F7F:  STD  M_YP
P0_8F82:  LDD  M_QUO                  ;the reciprocal of the distance
P0_8F85:  STD  M_XP                   ;M_YP = that length as seen on the screen
P0_8F88:  LDA  #MS_PERS
P0_8F8A:  JSR  MGOWT
P0_8F8D:  LDX  #BJ_PNT+$D2            ;perspected point 42, the last of the head (its points start at BJ_PNT+$6E)
P0_8F90:  JSR  atat_oct_dist
P0_8F93:  SUBD M_YP
P0_8F96:  BLT  P0_8F99
P0_8F98:  RTS
P0_8F99:  LDD  #$0000                 ;on the head: no record, the shot stops here and destroys nothing
P0_8F9C:  STD  atat_hit_rec
P0_8F9F:  LDD  M_XT
P0_8FA2:  STD  atat_hit_d
P0_8FA5:  RTS

;------------------------------------------------------------------------------
; atat_eye_hit - laser cursor test on the four-sided figure of the head that object $19 draws (perspected points
;   38 to 41), the one atat_head_aim turns red, called at the end of atat_head_aim with U at the AT-AT record.
;   when the head (M_XT) is not farther than atat_hit_d and the cursor lies inside the box around the four points,
;   it puts U in atat_hit_rec and the distance in atat_hit_d: this walker is the one a laser shot destroys
;------------------------------------------------------------------------------
atat_eye_hit:
P0_8FA6:  LDD  M_XT
P0_8FA9:  CMPD atat_hit_d
P0_8FAD:  BHI  P0_8FF8                ;equal counts as nearer, so the eye wins over its own head
P0_8FAF:  LDX  #BJ_PNT+$C3            ;X = perspected point 39. points 38 to 41 are the corners object $19 draws
P0_8FB2:  LDD  -3,X                   ;the smaller y of points 38 and 39
P0_8FB4:  CMPD 2,X
P0_8FB7:  BLE  P0_8FBB
P0_8FB9:  LDD  2,X
P0_8FBB:  SUBD #$0000
P0_8FBE:  SUBD >LZ_CY
P0_8FC1:  BGT  P0_8FF8                ;the cursor's y is smaller still: miss
P0_8FC3:  LDD  7,X                    ;the larger y of points 40 and 41
P0_8FC5:  CMPD 12,X
P0_8FC8:  BGE  P0_8FCC
P0_8FCA:  LDD  12,X
P0_8FCC:  ADDD #$0000
P0_8FCF:  SUBD >LZ_CY
P0_8FD2:  BLT  P0_8FF8                ;the cursor's y is larger still: miss
P0_8FD4:  LDD  5,X                    ;the smaller x of points 40 and 38
P0_8FD6:  CMPD -5,X
P0_8FD9:  BLE  P0_8FDD
P0_8FDB:  LDD  -5,X
P0_8FDD:  SUBD #$0000
P0_8FE0:  SUBD >LZ_CX
P0_8FE3:  BGT  P0_8FF8
P0_8FE5:  LDD  10,X                   ;the larger x of points 41 and 39
P0_8FE7:  CMPD ,X
P0_8FEA:  BGE  P0_8FEE
P0_8FEC:  LDD  ,X
P0_8FEE:  ADDD #$0000
P0_8FF1:  SUBD >LZ_CX
P0_8FF4:  BLT  P0_8FF8
P0_8FF6:  BRA  P0_8FF9
P0_8FF8:  RTS
P0_8FF9:  STU  atat_hit_rec           ;inside the box: this walker is the laser's target
P0_8FFC:  LDD  M_XT
P0_8FFF:  STD  atat_hit_d
P0_9002:  RTS

;------------------------------------------------------------------------------
; atat_eye_shot - reached through the maze entry P0_8538 from the laser routine of page 3 (P3_97FA) when the
;   nearest thing under the cursor is the eye of an AT-AT: loads U with atat_hit_rec and falls into atat_destroy
;------------------------------------------------------------------------------
atat_eye_shot:
P0_9003:  LDU  atat_hit_rec

;------------------------------------------------------------------------------
; atat_destroy - destroys the AT-AT at U, shot in the eye or fallen to the ground (atat_mode_fall): starts the
;   three-piece explosion of bank 1 BGTWXP at the walker's position plus its head offset, frees the tow cable
;   record when the walker was caught by the cable, respawns or frees the record (atat_spawn), holds up the
;   walkers' advance (hold_adv_kill) and scores: 75 points while bonus_left is open and, when this kill closes it,
;   5000 points, the Jedi letter (page 1 P1_9573) and one more on quota_walker, else 750 points. ends with the
;   sound aud_cmd_51
;------------------------------------------------------------------------------
atat_destroy:
P0_9006:  LDD  5,U                    ;centre of the explosion: the walker's position plus the head's offset
P0_9008:  ADDD 11,U
P0_900A:  STD  M_XT
P0_900D:  LDD  7,U
P0_900F:  ADDD 13,U
P0_9011:  STD  M_YT
P0_9014:  LDD  9,U
P0_9016:  ADDD 15,U
P0_9018:  STD  M_ZT
P0_901B:  JSR  L6192                  ;bank 1 BGTWXP: three explosion pieces around M_XT, M_YT, M_ZT
P0_901E:  LDA  ,U
P0_9020:  BITA #$02                   ;bit 1 of the type: brought down by the tow cable
P0_9022:  BEQ  P0_9029
P0_9024:  LDA  #$00                   ;the cable's record is free again
P0_9026:  STA  cable_rec
P0_9029:  JSR  atat_spawn             ;a new walker in this record, or the record freed
P0_902C:  JSR  hold_adv_kill
P0_902F:  LDA  bonus_left             ;bonus quota still open: 75 points and one less to go
P0_9032:  BEQ  P0_9047
P0_9034:  JSR  scr_atat_75
P0_9037:  DEC  bonus_left
P0_903A:  BNE  P0_9045
P0_903C:  JSR  scr_walker_quota       ;that was the last: 5000 points and the Jedi letter
P0_903F:  JSR  P0_81E4                ;calls page 1 jedi_award
P0_9042:  INC  quota_walker           ;the quota is one more next time
P0_9045:  BRA  P0_904A
P0_9047:  JSR  scr_atat_750           ;quota closed: 750 points
P0_904A:  JSR  aud_cmd_51
P0_904D:  RTS

;------------------------------------------------------------------------------
; cable_leg_test - tests the tow cable against the knee just worked out in M_X0 and M_Y0 for the AT-AT at U,
;   called by atat_knee. nothing when the walker is already falling or no cable is out (cable_rec 0). the knee's
;   universe x (twice the point's x plus the walker's) must be within $02AA, the distance of each end of the cable
;   from its centre, plus the cable's step of this frame (cable_vx) of the cable's centre (cable_tx), and the same
;   in y, then cable_catch is called
;------------------------------------------------------------------------------
cable_leg_test:
P0_904E:  LDA  ,U
P0_9050:  BITA #$02                   ;already falling
P0_9052:  BNE  P0_90A4
P0_9054:  LDA  cable_rec              ;no cable out
P0_9057:  BEQ  P0_90A4
P0_9059:  LDD  M_X0                   ;the knee's universe x: twice the point's x plus the walker's
P0_905C:  ASLB
P0_905D:  ROLA
P0_905E:  ADDD 5,U
P0_9060:  SUBD cable_tx               ;distance in x from the cable's centre
P0_9063:  BPL  P0_9069
P0_9065:  COMA
P0_9066:  NEGB
P0_9067:  SBCA #$FF
P0_9069:  TST  cable_vx               ;less the size of the cable's x step this frame
P0_906C:  BMI  P0_9073
P0_906E:  SUBD cable_vx
P0_9071:  BRA  P0_9076
P0_9073:  ADDD cable_vx
P0_9076:  BVS  P0_90A4
P0_9078:  SUBD #$02AA                 ;within $02AA
P0_907B:  BGE  P0_90A4
P0_907D:  LDD  M_Y0                   ;the same in y
P0_9080:  ASLB
P0_9081:  ROLA
P0_9082:  ADDD 7,U
P0_9084:  SUBD cable_ty
P0_9087:  BPL  P0_908D
P0_9089:  COMA
P0_908A:  NEGB
P0_908B:  SBCA #$FF
P0_908D:  TST  cable_vy
P0_9090:  BMI  P0_9097
P0_9092:  SUBD cable_vy
P0_9095:  BRA  P0_909A
P0_9097:  ADDD cable_vy
P0_909A:  BVS  P0_90A4
P0_909C:  SUBD #$02AA
P0_909F:  BGE  P0_90A4
P0_90A1:  JSR  cable_catch            ;the cable has caught this leg
P0_90A4:  RTS

;------------------------------------------------------------------------------
; cable_catch - the tow cable has caught a leg of the AT-AT at U: moves the cable's centre to the knee, holds up
;   the advance (hold_adv_catch), scores as atat_destroy does (75 points and the count down of bonus_left with the
;   5000 points and Jedi letter when it closes, else 750 points), sets bit 1 of the type byte and movement mode 2
;   so that the walker falls, and marks the cable attached (cable_attach)
;------------------------------------------------------------------------------
cable_catch:
P0_90A5:  LDD  M_X0                   ;the cable's centre goes to the knee
P0_90A8:  ASLB
P0_90A9:  ROLA
P0_90AA:  ADDD 5,U
P0_90AC:  STD  cable_tx
P0_90AF:  LDD  M_Y0
P0_90B2:  ASLB
P0_90B3:  ROLA
P0_90B4:  ADDD 7,U
P0_90B6:  STD  cable_ty
P0_90B9:  JSR  hold_adv_catch
P0_90BC:  LDA  bonus_left             ;scored as a kill: 75 points while the quota is open
P0_90BF:  BEQ  P0_90D4
P0_90C1:  JSR  scr_atat_75
P0_90C4:  DEC  bonus_left
P0_90C7:  BNE  P0_90D2
P0_90C9:  JSR  scr_walker_quota       ;the last of the quota: 5000 points and the Jedi letter
P0_90CC:  JSR  P0_81E4                ;calls page 1 jedi_award
P0_90CF:  INC  quota_walker
P0_90D2:  BRA  P0_90D7
P0_90D4:  JSR  scr_atat_750           ;quota closed: 750 points
P0_90D7:  LDA  ,U                     ;bit 1 of the type: falling
P0_90D9:  ORA  #$02
P0_90DB:  STA  ,U
P0_90DD:  LDA  #$02                   ;movement mode 2: atat_mode_fall
P0_90DF:  STA  4,U
P0_90E1:  JSR  P0_8211                ;calls page 0 cable_attach
P0_90E4:  RTS

;------------------------------------------------------------------------------
; hold_adv_kill - called when an AT-AT is destroyed: while bonus_left is not 0 adds hold_add to adv_hold, the
;   frames the walkers' advance is held up ($FF at most), and takes 1 off hold_add while it is over 15. the first
;   of three identical copies
;------------------------------------------------------------------------------
hold_adv_kill:
P0_90E5:  LDA  bonus_left             ;only while the bonus quota is open
P0_90E8:  BEQ  P0_9101
P0_90EA:  LDA  adv_hold               ;hold the advance hold_add frames longer, $FF at most
P0_90ED:  ADDA hold_add
P0_90F0:  BCC  P0_90F4
P0_90F2:  LDA  #$FF
P0_90F4:  STA  adv_hold
P0_90F7:  LDA  hold_add               ;the next hit holds it one frame less, 15 at least
P0_90FA:  CMPA #$0F
P0_90FC:  BLS  P0_9101
P0_90FE:  DEC  hold_add
P0_9101:  RTS

;------------------------------------------------------------------------------
; hold_adv_catch - called when the tow cable catches an AT-AT: the same code as hold_adv_kill
;------------------------------------------------------------------------------
hold_adv_catch:
P0_9102:  LDA  bonus_left
P0_9105:  BEQ  P0_911E
P0_9107:  LDA  adv_hold
P0_910A:  ADDA hold_add
P0_910D:  BCC  P0_9111
P0_910F:  LDA  #$FF
P0_9111:  STA  adv_hold
P0_9114:  LDA  hold_add
P0_9117:  CMPA #$0F
P0_9119:  BLS  P0_911E
P0_911B:  DEC  hold_add
P0_911E:  RTS

;------------------------------------------------------------------------------
; hold_adv_legs - called by atat_move_all when the player flies under an AT-AT and the legs bonus is scored: the
;   same code as hold_adv_kill
;------------------------------------------------------------------------------
hold_adv_legs:
P0_911F:  LDA  bonus_left
P0_9122:  BEQ  P0_913B
P0_9124:  LDA  adv_hold
P0_9127:  ADDA hold_add
P0_912A:  BCC  P0_912E
P0_912C:  LDA  #$FF
P0_912E:  STA  adv_hold
P0_9131:  LDA  hold_add
P0_9134:  CMPA #$0F
P0_9136:  BLS  P0_913B
P0_9138:  DEC  hold_add
P0_913B:  RTS

;------------------------------------------------------------------------------
; atat_crash - the ship has run into the AT-AT being viewed (record in S2_PRM), called for a leg close in front
;   (atat_leg_shade) and under a falling walker (atat_view_all): replaces the walker's colour word in the display
;   list (atat_col_ptr) with the flash list call $A013 and sets bit 7 of byte 1 so that it is written again next
;   frame, starts the shield hit glow (BG1GLW) and the crash sound aud_cmd_32, and sets the roll from the hit
;   S_ROL to $20, with the sign it already has or, when it is 0, the sign of the high byte of M_YP
;------------------------------------------------------------------------------
atat_crash:
P0_913C:  LDD  #$A013                 ;AVG JSRL $0026, the flash list call atat_view_all uses for a hit walker
P0_913F:  LDU  atat_col_ptr           ;over the walker's colour word in the display list
P0_9142:  STD  ,U
P0_9144:  LDU  S2_PRM                 ;the record being viewed
P0_9146:  LDA  1,U                    ;bit 7: the hit flash, kept while the walker is drawn
P0_9148:  ORA  #$80
P0_914A:  STA  1,U
P0_914C:  JSR  BG1GLW                 ;the shield hit glow
P0_914F:  JSR  aud_cmd_32
P0_9152:  LDA  S_ROL                  ;already rolling from a hit: keep the direction
P0_9154:  BNE  P0_915A
P0_9156:  LDA  M_YP                   ;else the side comes from the sign of the last viewed point's y
P0_9159:  NOP
P0_915A:  LDB  #$20                   ;a roll of $20 one way or the other
P0_915C:  TSTA
P0_915D:  BPL  P0_9160
P0_915F:  NEGB
P0_9160:  STB  S_ROL
P0_9162:  RTS

;------------------------------------------------------------------------------
; atat_spawn - puts a new AT-AT in the record at U, called by atat_move_all for a free record and by
;   atat_destroy. when w2_spawn_b is not positive the record is freed instead. a walker that was not drawn this
;   frame restarts half the world ($8000) from the player in x, one that was drawn moves half the world in x or,
;   one time in two, half the world in y with a random x. in the first two cases y gets a random step added, is
;   cut to a multiple of $1000 and gets 0-$03FC added. the height is $2000, the mode 1 (walk), the type $29 and
;   the flags 0. the head angles, the walk cycle counter and the leg set are kept
;------------------------------------------------------------------------------
atat_spawn:
P0_9163:  LDA  w2_spawn_b             ;spawn count: positive while walkers are brought in
P0_9166:  BGT  P0_916F
P0_9168:  LDA  #$00                   ;none to bring in: free the record
P0_916A:  STA  ,U
P0_916C:  STA  1,U
P0_916E:  RTS
P0_916F:  JSR  rnd_set
P0_9172:  LDA  1,U                    ;bit 4: the walker was drawn this frame
P0_9174:  BITA #$10
P0_9176:  BNE  P0_917F
P0_9178:  LDD  s1_tx                  ;not drawn: start from the player's x
P0_917B:  STD  5,U
P0_917D:  BRA  P0_9183
P0_917F:  LDA  RND_S1                 ;drawn: one of two moves at random
P0_9181:  BMI  P0_91A1
P0_9183:  LDD  5,U                    ;half the world away in x
P0_9185:  ADDD #$8000
P0_9188:  STD  5,U
P0_918A:  LDA  RND_S2                 ;y high byte: 0, $40, $80 or $C0 added, cut to a multiple of $10, low byte 0
P0_918C:  ANDA #$C0
P0_918E:  ADDA 7,U
P0_9190:  ANDA #$F0
P0_9192:  CLRB
P0_9193:  STD  7,U
P0_9195:  LDA  #$04                   ;plus 4 * a random byte
P0_9197:  LDB  P_RND1
P0_919A:  MUL
P0_919B:  ADDD 7,U
P0_919D:  STD  7,U
P0_919F:  BRA  P0_91AC
P0_91A1:  LDD  7,U                    ;or half the world away in y
P0_91A3:  ADDD #$8000
P0_91A6:  STD  7,U
P0_91A8:  LDD  RND_S3                 ;with a random x
P0_91AA:  STD  5,U
P0_91AC:  LDD  #$2000                 ;height of a standing walker
P0_91AF:  STD  9,U                    ;the walker's z
P0_91B1:  LDA  #$01                   ;movement mode 1: walk
P0_91B3:  STA  4,U
P0_91B5:  LDA  #$29                   ;type $29: live
P0_91B7:  STA  ,U
P0_91B9:  LDA  #$00                   ;no flags
P0_91BB:  STA  1,U
P0_91BD:  RTS

anim_keys:
P0_91BE:  .word $0000, $0000, $0000   ;ring 0 key 0: offset 0, 0, 0  keyframe rings for anim_track_pos. a key is 7 bytes: x, y and z offset words and a frame count. a key with count 0 ends a ring: its offsets repeat the first key's and the address of the first key follows it. this ring: one key at 0, 0, 0 for 80 frames, the track of a part that does not move
P0_91C4:  .byte $50                   ;for 80 frames
P0_91C5:  .word $0000, $0000, $0000   ;ring 0 key 1: offset 0, 0, 0
P0_91CB:  .byte $00                   ;end of ring 0
P0_91CC:  .word anim_keys             ;back to the ring's first key
P0_91CE:  .word $0190, $0000, $0000   ;ring 1 key 0: offset 400, 0, 0  ring of the AT-AT knee: 10 keys, 80 frames, x from -$0190 to $0320 and z up to $7D. ends with the link at $921B
P0_91D4:  .byte $05                   ;for 5 frames
P0_91D5:  .word $01AD, $0000, $0008   ;ring 1 key 1: offset 429, 0, 8
P0_91DB:  .byte $0A                   ;for 10 frames
P0_91DC:  .word $01E8, $0000, $0019   ;ring 1 key 2: offset 488, 0, 25
P0_91E2:  .byte $0A                   ;for 10 frames
P0_91E3:  .word $01AD, $0000, $0008   ;ring 1 key 3: offset 429, 0, 8
P0_91E9:  .byte $05                   ;for 5 frames
P0_91EA:  .word $0190, $0000, $0000   ;ring 1 key 4: offset 400, 0, 0
P0_91F0:  .byte $0F                   ;for 15 frames
P0_91F1:  .word $0064, $0000, $FFE7   ;ring 1 key 5: offset 100, 0, -25
P0_91F7:  .byte $0F                   ;for 15 frames
P0_91F8:  .word $FE70, $0000, $0000   ;ring 1 key 6: offset -400, 0, 0
P0_91FE:  .byte $05                   ;for 5 frames
P0_91FF:  .word $01E8, $0000, $0019   ;ring 1 key 7: offset 488, 0, 25
P0_9205:  .byte $05                   ;for 5 frames
P0_9206:  .word $02D5, $0000, $0064   ;ring 1 key 8: offset 725, 0, 100
P0_920C:  .byte $05                   ;for 5 frames
P0_920D:  .word $0320, $0000, $007D   ;ring 1 key 9: offset 800, 0, 125
P0_9213:  .byte $05                   ;for 5 frames
P0_9214:  .word $0190, $0000, $0000   ;ring 1 key 10: offset 400, 0, 0
P0_921A:  .byte $00                   ;end of ring 1
P0_921B:  .word P0_91CE               ;back to the ring's first key
P0_921D:  .word $0320, $0000, $0000   ;ring 2 key 0: offset 800, 0, 0
P0_9223:  .byte $05                   ;for 5 frames
P0_9224:  .word $02A5, $0000, $0000   ;ring 2 key 1: offset 677, 0, 0
P0_922A:  .byte $0A                   ;for 10 frames
P0_922B:  .word $0190, $0000, $0000   ;ring 2 key 2: offset 400, 0, 0
P0_9231:  .byte $0A                   ;for 10 frames
P0_9232:  .word $0085, $0000, $0000   ;ring 2 key 3: offset 133, 0, 0
P0_9238:  .byte $05                   ;for 5 frames
P0_9239:  .word $0000, $0000, $0000   ;ring 2 key 4: offset 0, 0, 0
P0_923F:  .byte $0F                   ;for 15 frames
P0_9240:  .word $FE70, $0000, $0000   ;ring 2 key 5: offset -400, 0, 0
P0_9246:  .byte $0F                   ;for 15 frames
P0_9247:  .word $FCE0, $0000, $0000   ;ring 2 key 6: offset -800, 0, 0
P0_924D:  .byte $05                   ;for 5 frames
P0_924E:  .word $FCE0, $0000, $01C2   ;ring 2 key 7: offset -800, 0, 450
P0_9254:  .byte $05                   ;for 5 frames
P0_9255:  .word $FEF6, $0000, $012C   ;ring 2 key 8: offset -266, 0, 300
P0_925B:  .byte $05                   ;for 5 frames
P0_925C:  .word $010A, $0000, $0096   ;ring 2 key 9: offset 266, 0, 150
P0_9262:  .byte $05                   ;for 5 frames
P0_9263:  .word $0320, $0000, $0000   ;ring 2 key 10: offset 800, 0, 0
P0_9269:  .byte $00                   ;end of ring 2
P0_926A:  .word P0_921D               ;back to the ring's first key
P0_926C:  .word $0000, $0000, $0000   ;ring 3 key 0: offset 0, 0, 0
P0_9272:  .byte $06                   ;for 6 frames
P0_9273:  .word $0000, $0000, $0000   ;ring 3 key 1: offset 0, 0, 0
P0_9279:  .byte $06                   ;for 6 frames
P0_927A:  .word $0000, $0000, $0000   ;ring 3 key 2: offset 0, 0, 0
P0_9280:  .byte $00                   ;end of ring 3
P0_9281:  .word P0_926C               ;back to the ring's first key
P0_9283:  .word $0000, $0000, $0000   ;ring 4 key 0: offset 0, 0, 0  still ring of 12 frames, used by the tracks of page 1's AT-ST
P0_9289:  .byte $0C                   ;for 12 frames
P0_928A:  .word $0000, $0000, $0000   ;ring 4 key 1: offset 0, 0, 0
P0_9290:  .byte $00                   ;end of ring 4
P0_9291:  .word P0_9283               ;back to the ring's first key
P0_9293:  .word $FF2E, $0000, $FFA9   ;ring 5 key 0: offset -210, 0, -87  first of three rings of 6 keys and 12 frames for the AT-ST of page 1, at $9293, $92C6 and $92F9
P0_9299:  .byte $02                   ;for 2 frames
P0_929A:  .word $FF1F, $0000, $0000   ;ring 5 key 1: offset -225, 0, 0
P0_92A0:  .byte $02                   ;for 2 frames
P0_92A1:  .word $FF24, $0000, $0037   ;ring 5 key 2: offset -220, 0, 55
P0_92A7:  .byte $02                   ;for 2 frames
P0_92A8:  .word $FF2E, $0000, $0057   ;ring 5 key 3: offset -210, 0, 87
P0_92AE:  .byte $02                   ;for 2 frames
P0_92AF:  .word $FF2E, $0000, $0057   ;ring 5 key 4: offset -210, 0, 87
P0_92B5:  .byte $02                   ;for 2 frames
P0_92B6:  .word $FF1F, $0000, $0000   ;ring 5 key 5: offset -225, 0, 0
P0_92BC:  .byte $02                   ;for 2 frames
P0_92BD:  .word $FF2E, $0000, $FFA9   ;ring 5 key 6: offset -210, 0, -87
P0_92C3:  .byte $00                   ;end of ring 5
P0_92C4:  .word P0_9293               ;back to the ring's first key
P0_92C6:  .word $FFB8, $0000, $FFC2   ;ring 6 key 0: offset -72, 0, -62
P0_92CC:  .byte $02                   ;for 2 frames
P0_92CD:  .word $FF29, $0000, $FFFB   ;ring 6 key 1: offset -215, 0, -5
P0_92D3:  .byte $02                   ;for 2 frames
P0_92D4:  .word $FED4, $0000, $003E   ;ring 6 key 2: offset -300, 0, 62
P0_92DA:  .byte $02                   ;for 2 frames
P0_92DB:  .word $FEAF, $0000, $006B   ;ring 6 key 3: offset -337, 0, 107
P0_92E1:  .byte $02                   ;for 2 frames
P0_92E2:  .word $FEAF, $0000, $006B   ;ring 6 key 4: offset -337, 0, 107
P0_92E8:  .byte $02                   ;for 2 frames
P0_92E9:  .word $FF1F, $0000, $0000   ;ring 6 key 5: offset -225, 0, 0
P0_92EF:  .byte $02                   ;for 2 frames
P0_92F0:  .word $FFB8, $0000, $FFC2   ;ring 6 key 6: offset -72, 0, -62
P0_92F6:  .byte $00                   ;end of ring 6
P0_92F7:  .word P0_92C6               ;back to the ring's first key
P0_92F9:  .word $0087, $0000, $0000   ;ring 7 key 0: offset 135, 0, 0
P0_92FF:  .byte $02                   ;for 2 frames
P0_9300:  .word $FFD3, $0000, $0000   ;ring 7 key 1: offset -45, 0, 0
P0_9306:  .byte $02                   ;for 2 frames
P0_9307:  .word $FF1F, $0000, $0000   ;ring 7 key 2: offset -225, 0, 0
P0_930D:  .byte $02                   ;for 2 frames
P0_930E:  .word $FEAC, $0000, $001E   ;ring 7 key 3: offset -340, 0, 30
P0_9314:  .byte $02                   ;for 2 frames
P0_9315:  .word $FF83, $0000, $00A7   ;ring 7 key 4: offset -125, 0, 167
P0_931B:  .byte $02                   ;for 2 frames
P0_931C:  .word $0000, $0000, $0096   ;ring 7 key 5: offset 0, 0, 150
P0_9322:  .byte $02                   ;for 2 frames
P0_9323:  .word $0089, $0000, $0000   ;ring 7 key 6: offset 137, 0, 0
P0_9329:  .byte $00                   ;end of ring 7
P0_932A:  .word P0_92F9               ;back to the ring's first key

anim_track_tab:
P0_932C:  .word anim_keys             ;track table of anim_track_pos, 68 words: the key each track starts its cycle on. tracks 0-3 the still ring, then from track 4 the 12 AT-AT legs (3 leg sets of 4), three tracks a leg: hip (still), knee and ankle, the four legs of a set starting 20 frames apart in the 80-frame rings
P0_932E:  .word anim_keys
P0_9330:  .word anim_keys
P0_9332:  .word anim_keys
P0_9334:  .word anim_keys
P0_9336:  .word P0_91D5
P0_9338:  .word P0_9224
P0_933A:  .word anim_keys
P0_933C:  .word P0_91F1
P0_933E:  .word P0_9240
P0_9340:  .word anim_keys
P0_9342:  .word P0_91FF
P0_9344:  .word P0_924E
P0_9346:  .word anim_keys
P0_9348:  .word P0_91E3
P0_934A:  .word P0_9232
P0_934C:  .word anim_keys
P0_934E:  .word P0_91FF
P0_9350:  .word P0_924E
P0_9352:  .word anim_keys
P0_9354:  .word P0_91E3
P0_9356:  .word P0_9232
P0_9358:  .word anim_keys
P0_935A:  .word P0_91D5
P0_935C:  .word P0_9224
P0_935E:  .word anim_keys
P0_9360:  .word P0_91F1
P0_9362:  .word P0_9240
P0_9364:  .word anim_keys
P0_9366:  .word P0_91F1
P0_9368:  .word P0_9240
P0_936A:  .word anim_keys
P0_936C:  .word P0_91FF
P0_936E:  .word P0_924E
P0_9370:  .word anim_keys
P0_9372:  .word P0_91E3
P0_9374:  .word P0_9232
P0_9376:  .word anim_keys
P0_9378:  .word P0_91D5
P0_937A:  .word P0_9224
P0_937C:  .word P0_9283               ;tracks 40 to 67, used by the AT-ST legs of page 1 (four tracks a leg, leg records at P1_8B6C)
P0_937E:  .word P0_9283
P0_9380:  .word P0_9283
P0_9382:  .word P0_9283
P0_9384:  .word P0_9283
P0_9386:  .word P0_9293
P0_9388:  .word P0_92C6
P0_938A:  .word P0_92F9
P0_938C:  .word P0_9283
P0_938E:  .word P0_92A8
P0_9390:  .word P0_92DB
P0_9392:  .word P0_930E
P0_9394:  .word P0_9283
P0_9396:  .word P0_929A
P0_9398:  .word P0_92CD
P0_939A:  .word P0_9300
P0_939C:  .word P0_9283
P0_939E:  .word P0_92AF
P0_93A0:  .word P0_92E2
P0_93A2:  .word P0_9315
P0_93A4:  .word P0_9283
P0_93A6:  .word P0_92A1
P0_93A8:  .word P0_92D4
P0_93AA:  .word P0_9307
P0_93AC:  .word P0_9283
P0_93AE:  .word P0_92B6
P0_93B0:  .word P0_92E9
P0_93B2:  .word P0_931C

;------------------------------------------------------------------------------
; anim_track_pos - keyframe interpolation for the legs of the walkers, called through the maze entry P0_85B3 by
;   the AT-AT code of this page and the AT-ST code of page 1. B = track number, anim_frame = frames into the walk
;   cycle. takes the track's starting key from anim_track_tab (track 0 when B is past the table), walks round the
;   ring of 7-byte keys taking each key's frame count off the time, and blends the offsets of the key the time
;   falls in and of the next one by the fraction of the key that has passed, with the divider and the matrix
;   multiply MS_PERS. returns the x, y and z offset in anim_dx, anim_dy and anim_dz. when the walk comes back to
;   the starting key the cycle is over and anim_frame is cleared. leaves the divider's numerator at $0200. the
;   routine runs on to $9471
;------------------------------------------------------------------------------
anim_track_pos:
P0_93B4:  PSHS X,U
P0_93B6:  LDA  anim_frame             ;frames into the walk cycle
P0_93B9:  STA  anim_left
P0_93BC:  LDX  #anim_track_tab        ;B = track number
P0_93BF:  ABX
P0_93C0:  ABX
P0_93C1:  CMPX #anim_track_tab+136    ;past the end of the table: track 0
P0_93C4:  BCS  P0_93C9
P0_93C6:  LDX  #anim_track_tab
P0_93C9:  LDU  ,X                     ;U = the key this track starts its cycle on
P0_93CB:  STU  anim_start             ;kept to see when the ring has been gone round
P0_93CE:  LDA  6,U                    ;the key's frame count
P0_93D0:  BNE  P0_93D6
P0_93D2:  LDU  7,U                    ;0: end of the ring, go on at its first key
P0_93D4:  BRA  P0_93CE
P0_93D6:  LDA  anim_left              ;time left, less this key's frames
P0_93D9:  SUBA 6,U
P0_93DB:  BCS  P0_93ED                ;the time falls in this key
P0_93DD:  LEAU 7,U                    ;next key
P0_93DF:  CMPU anim_start
P0_93E3:  BNE  P0_93E8
P0_93E5:  CLR  anim_frame             ;back at the starting key: the walk cycle starts again
P0_93E8:  STA  anim_left
P0_93EB:  BRA  P0_93CE
P0_93ED:  LDB  anim_left              ;frames into the key over the key's frame count
P0_93F0:  CLRA
P0_93F1:  STD  M_DVN
P0_93F4:  LDB  6,U
P0_93F6:  CLRA
P0_93F7:  STD  M_DVD
P0_93FA:  ORCC #$00                   ;time for the divider
P0_93FC:  LDD  M_PCGO                 ;the quotient (M_QUO, the same address as M_PCGO): the fraction of the key that has passed
P0_93FF:  STD  M_XP                   ;times the offsets of the next key, then the rest of the fraction times this key's
P0_9402:  LDD  7,U                    ;the next keyframe's x
P0_9404:  STD  M_YP
P0_9407:  LDA  #$86                   ;MS_PERS: times the fraction of the way to it in M_XP
P0_9409:  JSR  MGOWT
P0_940C:  LDD  M_YP
P0_940F:  STD  anim_dx
P0_9412:  LDD  9,U                    ;the next keyframe's y and z
P0_9414:  STD  M_YP
P0_9417:  LDD  11,U
P0_9419:  STD  M_ZP
P0_941C:  LDA  #$86
P0_941E:  JSR  MGOWT
P0_9421:  LDD  M_YP
P0_9424:  STD  anim_dy
P0_9427:  LDD  M_ZP
P0_942A:  STD  anim_dz
P0_942D:  LDD  #$4000                 ;$4000 is 1: the rest of the fraction
P0_9430:  SUBD M_XP
P0_9433:  STD  M_XP
P0_9436:  LDD  ,U                     ;this keyframe's x
P0_9438:  STD  M_YP
P0_943B:  LDA  #$86
P0_943D:  JSR  MGOWT
P0_9440:  LDD  M_YP                   ;the two parts added: the interpolated x
P0_9443:  ADDD anim_dx
P0_9446:  STD  anim_dx
P0_9449:  LDD  2,U                    ;this keyframe's y and z
P0_944B:  STD  M_YP
P0_944E:  LDD  4,U
P0_9450:  STD  M_ZP
P0_9453:  LDA  #$86
P0_9455:  JSR  MGOWT
P0_9458:  LDD  M_YP
P0_945B:  ADDD anim_dy
P0_945E:  STD  anim_dy
P0_9461:  LDD  M_ZP
P0_9464:  ADDD anim_dz
P0_9467:  STD  anim_dz
P0_946A:  LDD  #$0200                 ;the divider's numerator back to its usual $0200
P0_946D:  STD  M_DVN
P0_9470:  PULS X,U,PC

;------------------------------------------------------------------------------
; s2vw_old_tail - leftover, never run: the last $EF bytes of a copy of Star Wars' S2VW (view an alien ship,
;   lazar hit test, glow colour from TVWCL) assembled for $93E9-$954B, as page 2 still has it whole. page 0's own
;   code ends at $9471 and overwrote the start, so the header address falls in the middle of an instruction (the
;   first real one is CMPD #$0010 at $9474) and its long branches to $93E8 land inside the keyframe routine.
;   nothing on page 0 jumps here - the maze instructions that do are decoys. $9472-$9560 is identical on pages 0,
;   2 and 3 and $952B-$9560 on all four, the bytes the slapstic's bitwise addresses $9540-$955F fall on
;------------------------------------------------------------------------------
s2vw_old_tail:
P0_9472:  .byte $50, $00              ;leftover of an S2VW copy from here to $9560. these two bytes are the operand of an LDD M_XP whose opcode page 0's own code overwrote and the next four are CMPD #$0010, not what is shown

;------------------------------------------------------------------------------
; s2vw_old_p0 - stale image, never run: the tail of a copy of Star Wars' S2VW from an earlier build, read from
;   its first whole instruction. the bytes from $952B on are the same on all four pages
;------------------------------------------------------------------------------
s2vw_old_p0:
P0_9474:  CMPD #$0010
P0_9478:  LBLE P0_93E8
P0_947C:  CMPD #$7F00
P0_9480:  LBHI P0_93E8

S2VW_19_P0:
P0_9484:  STD  M_DVD
P0_9487:  STD  M_XT
P0_948A:  LDD  M_YP
P0_948D:  STD  M_YT
P0_9490:  LDD  M_YPS
P0_9493:  SUBD M_XPS                  ;X SQUARED
P0_9496:  LBHS P0_93E8                ;B OUT OF VIEW

S2VW_28_P0:
P0_949A:  LDD  M_ZP
P0_949D:  STD  M_ZT
P0_94A0:  LDD  M_ZPS
P0_94A3:  SUBD M_XPS                  ;X SQUARED
P0_94A6:  LBHS P0_93E8

S2VW_31_P0:
P0_94AA:  LDX  S2_PRM
P0_94AC:  LDD  AS_CHST,X
P0_94AF:  ORA  #((CS_PV&$FF00)/$100)  ;CHSET C$PV  WITHIN PLAYERS VIEW SCREEN
P0_94B1:  STD  AS_CHST,X
P0_94B4:  LDA  AS_BIC,X
P0_94B6:  JSR  IS2UV                  ;DOWNLOAD SHIP 2 UNIT VECTORS
P0_94B9:  JSR  L60B4
P0_94BC:  LDD  #$0050                 ;JUST TRY IT -- SHUT DOWN CPU AND TEST
P0_94BF:  STD  M_YP                   ;GET SHIP SIZE
P0_94C2:  LDA  #MS_PERS
P0_94C4:  JSR  MGOWT
P0_94C7:  LDD  M_YP
P0_94CA:  ADDD #$000A                 ;ADDIN CURSOR SIZE
P0_94CD:  STD  TMPSIZ_4801
P0_94CF:  LDD  >BJ_CX
P0_94D2:  SUBD >LZ_CX
P0_94D5:  BPL  P0_94DB                ;IFMI
P0_94D7:  COMA                        ;NEGD  ABSD
P0_94D8:  NEGB
P0_94D9:  SBCA #$FF
P0_94DB:  STD  TMPXD                  ;SAVE X DISTANCE
P0_94DD:  STD  TMPOCT_4803            ;PREPARE FOR OCTAGON COLLISION DETECT
P0_94DF:  LDD  >BJ_CY
P0_94E2:  SUBD >LZ_CY
P0_94E5:  BPL  P0_94EB                ;IFMI
P0_94E7:  COMA                        ;NEGD
P0_94E8:  NEGB
P0_94E9:  SBCA #$FF
P0_94EB:  STD  TMPYD                  ;SAVE Y DISTANCE
P0_94ED:  ADDD TMPOCT_4803
P0_94EF:  STD  TMPOCT_4803            ;OCTAGON CHECK
P0_94F1:  LDD  TMPXD
P0_94F3:  SUBD TMPSIZ_4801
P0_94F5:  BGT  P0_9515                ;IFLE  LE FOR LIBERALITY
P0_94F7:  LDD  TMPYD
P0_94F9:  SUBD TMPSIZ_4801
P0_94FB:  BGT  P0_9515                ;IFLE  ?WITHIN Y ALSO?
P0_94FD:  LDD  TMPSIZ_4801
P0_94FF:  LSRA                        ;LSRD
P0_9500:  RORB
P0_9501:  ADDD TMPSIZ_4801            ;MAKE 1.5 FOR OCTAGON
P0_9503:  SUBD TMPOCT_4803
P0_9505:  BLT  P0_9515                ;IFGE  ?ALSO WITHIN OCTAGON?
P0_9507:  LDD  M_XT                   ;THEN SEE IF WE ARE THE CLOSEST ALIEN
P0_950A:  CMPD CL_ADS                 ;SHIP DISTANCE
P0_950D:  BHS  P0_9515                ;IFLO  ?ALSO THE NEAREST SHIP SO FAR?
P0_950F:  STD  CL_ADS                 ;REMEMBER ITS DISTANCE
P0_9511:  LDX  S2_PRM                 ;THEN WE GOT A HIT
P0_9513:  STX  CL_AP                  ;RECORD WHO WE ARE
P0_9515:  LDD  TMPSIZ_4801            ;?AIM IS NEARING ALIEN?
P0_9517:  ADDD TMPSIZ_4801
P0_9519:  ADDD TMPSIZ_4801            ;ALLOW LARGER WARNING AREA
P0_951B:  SUBD TMPOCT_4803
P0_951D:  BLO  S2VW_86_P0             ;IFHS
P0_951F:  LDX  S2_PRM
P0_9521:  LDA  AS_TYP,X
P0_9523:  CMPA #$01
P0_9525:  BNE  S2VW_86_P0             ;?ALIVE?
P0_9527:  LDD  AS_CHST,X
P0_952A:  ORA  #((CS_PS&$FF00)/$100)  ;CHSET C$PS  STATUS: ALIEN IN PLAYER SITES

;------------------------------------------------------------------------------
; s2vw_end_p0 - stale image, never run: the last instructions of the S2VW copy, the same on all four pages. they
;   are here so that the slapstic's bitwise addresses $9540-$955F hold something that looks like code - page 3
;   reads $9540 and $9548 as data to enter that mode
;------------------------------------------------------------------------------
s2vw_end_p0:
P0_952C:  STD  AS_CHST,X

;SET BRITENESS
;ELSE HANDLE GLOW
S2VW_86_P0:
P0_952F:  LDX  S2_PRM
P0_9531:  LDB  7,X
P0_9533:  LDU  #TVWCL_P0              ;GET GLOW COLORS
P0_9536:  LSLB
P0_9537:  LDD  B,U
P0_9539:  STD  ,Y++

S2VW_55_P0:
P0_953B:  LDA  #MS_CNCT
P0_953D:  JSR  MGOWT
P0_9540:  LDB  5,X
P0_9542:  JSR  L60D2
P0_9545:  JSR  L60E4
P0_9548:  JSR  L60BA
P0_954B:  RTS

TVWCL_P0:
P0_954C:  .word (VGCOPC&$F000)+(($82&$F)*$100)+($82&$F0) ;TVWBYT 082,037,82,37,82,47,82,47
P0_954E:  .word (VGCOPC&$F000)+(($37&$F)*$100)+($37&$F0)
P0_9550:  .word (VGCOPC&$F000)+(($82&$F)*$100)+($82&$F0)
P0_9552:  .word (VGCOPC&$F000)+(($37&$F)*$100)+($37&$F0)
P0_9554:  .word (VGCOPC&$F000)+(($82&$F)*$100)+($82&$F0)
P0_9556:  .word (VGCOPC&$F000)+(($47&$F)*$100)+($47&$F0)
P0_9558:  .word (VGCOPC&$F000)+(($82&$F)*$100)+($82&$F0)
P0_955A:  .word (VGCOPC&$F000)+(($47&$F)*$100)+($47&$F0)
P0_955C:  .word (VGCOPC&$F000)+(($82&$F)*$100)+($82&$F0) ;TVWBYT 082,057,82,057,082,067,082,067
P0_955E:  .word (VGCOPC&$F000)+(($57&$F)*$100)+($57&$F0)
P0_9560:  .byte $D6                   ;one more leftover byte, read by nothing

;------------------------------------------------------------------------------
; cable_init - tow cable set-up for the walker part, called by wave2_setup: loads the points of object $1F (the
;   pointed body drawn at each end of the cable) into the math box, clears the cable record cable_rec, gives the
;   player 4 + kill_count/5 cables (kill_count held to 25, so 4 to 9) in cables_left and clears kill_count,
;   hit_spk_done and cables_used
;------------------------------------------------------------------------------
cable_init:
P0_9561:  LDB  #$1F                   ;object $1F, drawn at each end of the cable: load its points into the math box (bank 1 JADOBJ)
P0_9563:  JSR  L60A8
P0_9566:  LDX  #cable_rec
P0_9569:  CLR  ,X                     ;no cable out
P0_956B:  LDA  kill_count             ;AT-STs shot in the last walker part (atst_killed on page 1 counts them, AT-ATs are not counted), held to 25 here
P0_956E:  CMPA #$19
P0_9570:  BLS  P0_9574
P0_9572:  LDA  #$19
P0_9574:  LDB  #$03                   ;4 + count / 5
P0_9576:  INCB
P0_9577:  SUBA #$05
P0_9579:  BPL  P0_9576
P0_957B:  CMPB #$09                   ;9 at most
P0_957D:  BLS  P0_9581
P0_957F:  LDB  #$09
P0_9581:  STB  cables_left
P0_9584:  LDA  #$00
P0_9586:  STA  kill_count
P0_9589:  STA  hit_spk_done
P0_958C:  STA  cables_used
P0_958F:  RTS

;------------------------------------------------------------------------------
; cable_fire_save - cable_fire with X and U saved, called by cable_view when a thumb button was pressed
;------------------------------------------------------------------------------
cable_fire_save:
P0_9590:  PSHS X,U
P0_9592:  BSR  cable_fire
P0_9594:  PULS X,U,PC

;------------------------------------------------------------------------------
; cable_fire - fires a tow cable if one is left and none is out: fills cable_rec (live, mode 1 flying, timer 40
;   frames, the four angles 0), takes one from cables_left, counts cables_used and sends sound $4B. the cable's
;   unit vector block at M_AL gets the ship's matrix and position as downloaded for this frame's view, and its
;   velocity is the vector from the ship to a point $0600 ahead and 3 times the gun sight's screen x and y to the
;   side, put back into universe coordinates. returns carry set when fired, carry clear and A = 0 when not
;------------------------------------------------------------------------------
cable_fire:
P0_9596:  LDA  cables_left            ;no cable left: nothing is fired
P0_9599:  BLE  P0_9607
P0_959B:  BSR  cable_idle_chk         ;comes back only when no cable is out
P0_959D:  LDA  #$28                   ;byte 3, the timer: 40 frames of flight
P0_959F:  STA  3,X
P0_95A1:  LDA  #$01                   ;byte 0: the cable is out
P0_95A3:  STA  ,X
P0_95A5:  LDB  #$01                   ;byte 2, the mode: 1 = in flight
P0_95A7:  STB  2,X
P0_95A9:  LDA  #$00                   ;bytes 4 and 6: the roll angles of the two ends, never changed from 0
P0_95AB:  STA  4,X
P0_95AD:  LDA  #$00
P0_95AF:  STA  6,X
P0_95B1:  LDA  #$00                   ;bytes 5 and 7: the angles of the two ends round the centre
P0_95B3:  STA  5,X
P0_95B5:  STA  7,X
P0_95B7:  DEC  cables_left
P0_95BA:  JSR  aud_cmd_4b
P0_95BD:  INC  cables_used
P0_95C0:  LDU  #M_AL                  ;the cable's block: the ship's matrix and position as downloaded for this frame's view
P0_95C3:  JSR  store_u1_block
P0_95C6:  LDD  #$0600                 ;a point $0600 ahead of the ship
P0_95C9:  STD  M_X0
P0_95CC:  LDD  LZ_CX                  ;3 times the gun sight's screen x to the side
P0_95CE:  ASLB
P0_95CF:  ROLA
P0_95D0:  ADDD LZ_CX
P0_95D2:  STD  M_Y0
P0_95D5:  LDD  LZ_CY                  ;and 3 times its screen y up or down
P0_95D7:  ASLB
P0_95D8:  ROLA
P0_95D9:  ADDD LZ_CY
P0_95DB:  STD  M_Z0
P0_95DE:  LDD  #MS_X0BC               ;the scratch block M_X0
P0_95E1:  STD  M_BIC
P0_95E4:  LDA  #MS_S1UN               ;program $60: the point in universe coordinates
P0_95E6:  JSR  MGOWT
P0_95E9:  LDD  M_XP                   ;less the ship's position: the cable's x step per frame, cable_vx (MS_VX of its block)
P0_95EC:  SUBD s1_tx
P0_95EF:  STD  cable_vx
P0_95F2:  LDD  M_YP                   ;the y step, cable_vy
P0_95F5:  SUBD s1_ty
P0_95F8:  STD  cable_vy
P0_95FB:  LDD  M_ZP                   ;the z step, which nothing reads
P0_95FE:  SUBD s1_tz
P0_9601:  STD  cable_vz
P0_9604:  COMA                        ;carry set: a cable was fired
P0_9605:  BRA  P0_9608
P0_9607:  CLRA                        ;carry clear, A = 0: none fired
P0_9608:  RTS

;------------------------------------------------------------------------------
; cable_idle_chk - X = cable_rec. returns normally while no cable is out, otherwise drops its return address and
;   returns to the caller's caller with A = 0, so cable_fire does nothing while a cable is out
;------------------------------------------------------------------------------
cable_idle_chk:
P0_9609:  LDX  #cable_rec
P0_960C:  LDA  ,X
P0_960E:  BEQ  P0_9613                ;no cable out: go on
P0_9610:  LEAS 2,S                    ;a cable is out: drop the return address and go back to the caller's caller
P0_9612:  CLRA
P0_9613:  RTS

;------------------------------------------------------------------------------
; cable_move - per-frame movement of the tow cable, called by the three play phases of the walker part
;   (wave2_exec, wave2_end_exec, wave2_exit_exec): while the record is live it calls the routine for the mode in
;   byte 2 through cable_mode_tab with X = cable_rec (a mode over 2 counts as 0)
;------------------------------------------------------------------------------
cable_move:
P0_9614:  PSHS X,U
P0_9616:  LDX  #cable_rec
P0_9619:  LDA  ,X
P0_961B:  BEQ  P0_962B
P0_961D:  LDB  2,X                    ;the mode
P0_961F:  ASLB
P0_9620:  CMPB #$06                   ;a mode over 2 counts as 0
P0_9622:  BCS  P0_9626
P0_9624:  LDB  #$00
P0_9626:  LDU  #cable_mode_tab
P0_9629:  JSR  [B,U]
P0_962B:  PULS X,U,PC

;------------------------------------------------------------------------------
; cable_count_down - counts the cable's timer (byte 3 of the record at X) down and frees the record when it runs
;   out. a cable that runs out without having caught a walker starts speech $09, once in a walker part
;   (hit_spk_done) and only while cables are left
;------------------------------------------------------------------------------
cable_count_down:
P0_962D:  DEC  3,X                    ;the timer
P0_962F:  BNE  P0_964A
P0_9631:  LDA  ,X
P0_9633:  BITA #$08                   ;bit 3: it caught a walker, no speech
P0_9635:  BNE  P0_9647
P0_9637:  LDA  hit_spk_done           ;the speech was made earlier in this part
P0_963A:  BNE  P0_9647
P0_963C:  LDA  cables_left            ;no cables left: no speech
P0_963F:  BEQ  P0_9647
P0_9641:  JSR  spk_cmd_09
P0_9644:  INC  hit_spk_done
P0_9647:  CLRB                        ;the cable is gone
P0_9648:  STB  ,X
P0_964A:  RTS

;------------------------------------------------------------------------------
; cable_mode_0 - cable mode 0: only the timer. reached through cable_mode_tab, and no code sets mode 0
;------------------------------------------------------------------------------
cable_mode_0:
P0_964B:  BSR  cable_count_down
P0_964D:  RTS

;------------------------------------------------------------------------------
; cable_mode_caught - cable mode 2, after cable_attach: the timer, and the two ends turn round the centre faster
;   and at unequal rates, -45 and +69 a frame (256 to the turn). the centre is not moved here - atat_move_all
;   carries its height down with the falling walker. reached through cable_mode_tab
;------------------------------------------------------------------------------
cable_mode_caught:
P0_964E:  BSR  cable_count_down
P0_9650:  LDA  5,X                    ;first end: -45 a frame, 256 to the turn
P0_9652:  ADDA #$D3
P0_9654:  STA  5,X
P0_9656:  LDA  7,X                    ;second end: +69 a frame
P0_9658:  ADDA #$45
P0_965A:  STA  7,X
P0_965C:  RTS

;------------------------------------------------------------------------------
; cable_mode_fly - cable mode 1, in flight: the timer, the two ends turn round the centre in opposite directions
;   by 33 a frame, and while the cable is still live its centre moves by the x and y velocity and its height goes
;   a quarter of the way to $1300 each frame. reached through cable_mode_tab
;------------------------------------------------------------------------------
cable_mode_fly:
P0_965D:  BSR  cable_count_down
P0_965F:  LDA  5,X                    ;first end: -33 a frame
P0_9661:  ADDA #$DF
P0_9663:  STA  5,X
P0_9665:  LDA  7,X                    ;second end: +33 a frame
P0_9667:  ADDA #$21
P0_9669:  STA  7,X
P0_966B:  LDA  4,X                    ;the two roll angles: 0 added, they stay 0
P0_966D:  ADDA #$00
P0_966F:  STA  4,X
P0_9671:  LDA  6,X
P0_9673:  ADDA #$00
P0_9675:  STA  6,X
P0_9677:  LDA  ,X                     ;the timer has just run out: no move
P0_9679:  BEQ  P0_9696
P0_967B:  LDU  #M_AL
P0_967E:  LDD  8,U                    ;x position + x velocity (MS_TX and MS_VX of the block)
P0_9680:  ADDD -10,U
P0_9682:  STD  8,U
P0_9684:  LDD  10,U                   ;y position + y velocity
P0_9686:  ADDD -2,U
P0_9688:  STD  10,U
P0_968A:  LDD  #$1300                 ;the height goes a quarter of the way to $1300
P0_968D:  SUBD 12,U
P0_968F:  JSR  ASRD2
P0_9692:  ADDD 12,U
P0_9694:  STD  12,U
P0_9696:  RTS

cable_mode_tab:
P0_9697:  .word cable_mode_0          ;movement routines by mode: 0 timer only
P0_9699:  .word cable_mode_fly        ;1 in flight
P0_969B:  .word cable_mode_caught     ;2 a walker caught

;------------------------------------------------------------------------------
; cable_view - view of the tow cable, called by vew_walker and vew_walker_end with Y at the display list. first
;   fires a cable when a thumb button went down this frame (lz_sw_edge). then, with a cable out, views its centre
;   from the ship (MS_PSB2 on the position of the block at M_AL), keeps the result in cable_viewx/y/z and, when it
;   is ahead and within 45 degrees both ways, its screen position in cable_scrx and cable_scry, views and draws
;   the two ends and draws the lines
;------------------------------------------------------------------------------
cable_view:
P0_969D:  PSHS X,U
P0_969F:  LDA  #$00                   ;nothing in view yet: the centre, the first end, the second end
P0_96A1:  STA  cable_seen
P0_96A4:  STA  end1_seen
P0_96A7:  STA  end2_seen
P0_96AA:  LDA  lz_sw_edge             ;the switch edges TSTLAZ took from the IRQ for this frame
P0_96AD:  ANDA #$30                   ;THMBT: a thumb button went down
P0_96AF:  BEQ  P0_96B4
P0_96B1:  JSR  cable_fire_save        ;fire a cable
P0_96B4:  LDX  #cable_rec
P0_96B7:  LDA  ,X
P0_96B9:  BEQ  P0_9729                ;no cable out: nothing to view
P0_96BB:  LDD  #$001F                 ;BIC of the position words of the cable's block ($50F8)
P0_96BE:  STD  M_BIC
P0_96C1:  LDA  #$67                   ;MS_PSB2: the centre as seen from the ship
P0_96C3:  JSR  MGOWT
P0_96C6:  LDD  M_ZP                   ;kept for the two ends, which are viewed relative to it
P0_96C9:  STD  cable_viewz
P0_96CC:  LDD  M_YP
P0_96CF:  STD  cable_viewy
P0_96D2:  LDD  M_XP
P0_96D5:  STD  cable_viewx
P0_96D8:  CMPD #$0001                 ;x is the distance ahead: not behind the ship
P0_96DC:  BLE  P0_9720
P0_96DE:  STD  M_DVD                  ;starts the divide for 1/x
P0_96E1:  STD  M_XT
P0_96E4:  LDD  M_YP
P0_96E7:  STD  M_YT
P0_96EA:  BPL  P0_96F0                ;IFMI
P0_96EC:  COMA                        ;NEGD
P0_96ED:  NEGB
P0_96EE:  SBCA #$FF
P0_96F0:  SUBD M_XP
P0_96F3:  BCC  P0_9720                ;more than 45 degrees to the side
P0_96F5:  LDD  M_ZP
P0_96F8:  STD  M_ZT
P0_96FB:  BPL  P0_9701                ;IFMI
P0_96FD:  COMA                        ;NEGD
P0_96FE:  NEGB
P0_96FF:  SBCA #$FF
P0_9701:  SUBD M_XP
P0_9704:  BCC  P0_9720                ;more than 45 degrees up or down
P0_9706:  INC  cable_seen             ;the centre is in view
P0_9709:  LDD  M_QUO
P0_970C:  STD  M_XP                   ;GET X FOR PROPER SCREEN CONVERSION
P0_970F:  LDA  #MS_PERS
P0_9711:  JSR  MGOWT
P0_9714:  LDD  M_YP
P0_9717:  STD  cable_scrx             ;screen x of the centre. the cable's temps lie over the start of the star queues ST_QU
P0_971A:  LDD  M_ZP
P0_971D:  STD  cable_scry             ;Y,Z CONVERTED TO SCREEN COORDS
P0_9720:  JSR  cable_view_end1        ;the two ends are viewed even when the centre is not in view
P0_9723:  JSR  cable_view_end2
P0_9726:  JSR  cable_draw_lines
P0_9729:  PULS X,U,PC

;------------------------------------------------------------------------------
; cable_view_end1 - first end of the cable, X = cable_rec: downloads the cable's block as ship 2, yaws it by the
;   angle in byte 5 and views a point $02AA to one side of the centre ($0355 once a walker is caught). when the
;   point is ahead and within 45 degrees it keeps its screen position in end1_scrx and end1_scry, sets end1_seen
;   and has bank 1 view and draw object $1F there, rolled by byte 4
;------------------------------------------------------------------------------
cable_view_end1:
P0_972B:  LDD  cable_viewx            ;the viewed centre, the post-add input
P0_972E:  STD  M_XT
P0_9731:  LDD  cable_viewy
P0_9734:  STD  M_YT
P0_9737:  LDD  cable_viewz
P0_973A:  STD  M_ZT
P0_973D:  LDA  #$1C                   ;BIC of the cable's block at M_AL: download it as ship 2
P0_973F:  JSR  IS2UV
P0_9742:  LDD  #$0009                 ;BIC of the ship 2 download block
P0_9745:  STD  M_BIC
P0_9748:  LDB  5,X                    ;byte 5: the first end's angle round the centre
P0_974A:  JSR  yaw_by_angle
P0_974D:  LDA  #$40                   ;MS_CNCT: view ship 2 from ship 1
P0_974F:  JSR  MGOWT
P0_9752:  LDD  #$0000
P0_9755:  STD  M_X0
P0_9758:  LDA  ,X                     ;bit 3: a walker is caught
P0_975A:  BITA #$08
P0_975C:  BNE  P0_9763
P0_975E:  LDD  #$FD56                 ;the end is $02AA to one side of the centre
P0_9761:  BRA  P0_9766
P0_9763:  LDD  #$FCAB                 ;$0355 once a walker is caught
P0_9766:  STD  M_Y0
P0_9769:  LDD  #$0000
P0_976C:  STD  M_Z0                   ;the point (0, y, 0) in the cable's coordinates
P0_976F:  LDD  #MS_X0BC
P0_9772:  STD  M_BIC
P0_9775:  LDA  #$50                   ;MS_PAD: the point as seen from the ship
P0_9777:  JSR  MGOWT
P0_977A:  LDD  M_XP                   ;not behind the ship
P0_977D:  CMPD #$0001
P0_9781:  BLE  P0_97E9
P0_9783:  STD  M_DVD
P0_9786:  STD  M_XT                   ;the end is the viewed centre for the object drawn there
P0_9789:  STD  end1_viewx             ;kept, and read by nothing
P0_978C:  LDD  M_YP
P0_978F:  STD  M_YT
P0_9792:  STD  end1_viewy
P0_9795:  BPL  P0_979B                ;IFMI
P0_9797:  COMA                        ;NEGD
P0_9798:  NEGB
P0_9799:  SBCA #$FF
P0_979B:  SUBD M_XP
P0_979E:  BHS  P0_97E9                ;IFLO  ?OBJECT NOW DEFINATELY VISIBLE?
P0_97A0:  LDD  M_ZP
P0_97A3:  STD  M_ZT
P0_97A6:  STD  end1_viewz
P0_97A9:  BPL  P0_97AF                ;IFMI
P0_97AB:  COMA                        ;NEGD
P0_97AC:  NEGB
P0_97AD:  SBCA #$FF
P0_97AF:  SUBD M_XP
P0_97B2:  BHS  P0_97E9                ;IFLO  ?OBJECT NOW DEFINATELY VISIBLE?
P0_97B4:  INC  end1_seen              ;the first end is in view
P0_97B7:  LDD  M_QUO
P0_97BA:  STD  M_XP                   ;GET X FOR PROPER SCREEN CONVERSION
P0_97BD:  LDA  #MS_PERS
P0_97BF:  JSR  MGOWT
P0_97C2:  LDD  M_YP
P0_97C5:  STD  end1_scrx              ;screen x of the first end
P0_97C8:  LDD  M_ZP
P0_97CB:  STD  end1_scry              ;Y,Z CONVERTED TO SCREEN COORDS
P0_97CE:  LDD  #$0009
P0_97D1:  STD  M_BIC
P0_97D4:  LDB  4,X                    ;byte 4: roll of the object, always 0
P0_97D6:  JSR  roll_by_angle
P0_97D9:  LDA  #$40
P0_97DB:  JSR  MGOWT
P0_97DE:  LDB  #$1F                   ;object $1F: view its points (JOBJBPNT)
P0_97E0:  JSR  L60D2
P0_97E3:  JSR  L60E4                  ;draw the object
P0_97E6:  JSR  L60BA                  ;end of the object
P0_97E9:  RTS

;------------------------------------------------------------------------------
; cable_view_end2 - second end of the cable, as cable_view_end1 with the angle in byte 7, the point $02AA to the
;   other side ($0200 once a walker is caught), the roll in byte 6 and the results in end2_scrx, end2_scry and
;   end2_seen
;------------------------------------------------------------------------------
cable_view_end2:
P0_97EA:  LDD  cable_viewx
P0_97ED:  STD  M_XT
P0_97F0:  LDD  cable_viewy
P0_97F3:  STD  M_YT
P0_97F6:  LDD  cable_viewz
P0_97F9:  STD  M_ZT
P0_97FC:  LDA  #$1C
P0_97FE:  JSR  IS2UV
P0_9801:  LDD  #$0009
P0_9804:  STD  M_BIC
P0_9807:  LDB  7,X                    ;byte 7: the second end's angle round the centre
P0_9809:  JSR  yaw_by_angle
P0_980C:  LDA  #$40
P0_980E:  JSR  MGOWT
P0_9811:  LDD  #$0000
P0_9814:  STD  M_X0
P0_9817:  LDA  ,X
P0_9819:  BITA #$08
P0_981B:  BNE  P0_9822
P0_981D:  LDD  #$02AA                 ;the end is $02AA to the other side of the centre
P0_9820:  BRA  P0_9825
P0_9822:  LDD  #$0200                 ;$0200 once a walker is caught
P0_9825:  STD  M_Y0
P0_9828:  LDD  #$0000
P0_982B:  STD  M_Z0                   ;the point (0, y, 0) in the cable's coordinates
P0_982E:  LDD  #MS_X0BC
P0_9831:  STD  M_BIC
P0_9834:  LDA  #$50
P0_9836:  JSR  MGOWT
P0_9839:  LDD  M_XP
P0_983C:  CMPD #$0001
P0_9840:  BLE  P0_98A8
P0_9842:  STD  M_DVD
P0_9845:  STD  M_XT
P0_9848:  STD  end2_viewx
P0_984B:  LDD  M_YP
P0_984E:  STD  M_YT
P0_9851:  STD  end2_viewy
P0_9854:  BPL  P0_985A                ;IFMI
P0_9856:  COMA                        ;NEGD
P0_9857:  NEGB
P0_9858:  SBCA #$FF
P0_985A:  SUBD M_XP
P0_985D:  BHS  P0_98A8                ;IFLO  ?OBJECT NOW DEFINATELY VISIBLE?
P0_985F:  LDD  M_ZP
P0_9862:  STD  M_ZT
P0_9865:  STD  end2_viewz
P0_9868:  BPL  P0_986E                ;IFMI
P0_986A:  COMA                        ;NEGD
P0_986B:  NEGB
P0_986C:  SBCA #$FF
P0_986E:  SUBD M_XP
P0_9871:  BHS  P0_98A8                ;IFLO  ?OBJECT NOW DEFINATELY VISIBLE?
P0_9873:  INC  end2_seen              ;the second end is in view
P0_9876:  LDD  M_QUO
P0_9879:  STD  M_XP                   ;GET X FOR PROPER SCREEN CONVERSION
P0_987C:  LDA  #MS_PERS
P0_987E:  JSR  MGOWT
P0_9881:  LDD  M_YP
P0_9884:  STD  end2_scrx              ;screen x of the second end
P0_9887:  LDD  M_ZP
P0_988A:  STD  end2_scry              ;Y,Z CONVERTED TO SCREEN COORDS
P0_988D:  LDD  #$0009
P0_9890:  STD  M_BIC
P0_9893:  LDB  6,X                    ;byte 6: roll of the object, always 0
P0_9895:  JSR  roll_by_angle
P0_9898:  LDA  #$40
P0_989A:  JSR  MGOWT
P0_989D:  LDB  #$1F                   ;object $1F again
P0_989F:  JSR  L60D2
P0_98A2:  JSR  L60E4
P0_98A5:  JSR  L60BA
P0_98A8:  RTS

;------------------------------------------------------------------------------
; cable_draw_lines - draws the cable itself when its centre is in view: a white colour word, then for each end
;   that is in view a blank move from the beam's position (BJ_CX, BJ_CY) to the centre and a line from the centre
;   to the end, and last bank 1's end of object, which brings the beam back to the middle of the screen
;------------------------------------------------------------------------------
cable_draw_lines:
P0_98A9:  LDA  cable_seen             ;the centre is not in view: no lines
P0_98AC:  BEQ  P0_9914
P0_98AE:  LDD  #$6780                 ;white, brightness $80
P0_98B1:  STD  ,Y++
P0_98B3:  LDA  end1_seen
P0_98B6:  BEQ  P0_98E2
P0_98B8:  LDD  cable_scry             ;blank move from where the beam is to the centre: dy
P0_98BB:  SUBD BJ_CY
P0_98BD:  ANDA #$1F
P0_98BF:  STD  ,Y++
P0_98C1:  LDD  cable_scrx             ;dx, intensity 0
P0_98C4:  SUBD BJ_CX
P0_98C6:  ANDA #$1F
P0_98C8:  STD  ,Y++
P0_98CA:  LDD  end1_scry              ;line from the centre to the first end: dy, and the beam's new y
P0_98CD:  STD  BJ_CY
P0_98CF:  SUBD cable_scry
P0_98D2:  ANDA #$1F
P0_98D4:  STD  ,Y++
P0_98D6:  LDD  end1_scrx              ;dx with intensity 7, and the beam's new x
P0_98D9:  STD  BJ_CX
P0_98DB:  SUBD cable_scrx
P0_98DE:  ORA  #$E0
P0_98E0:  STD  ,Y++
P0_98E2:  LDA  end2_seen
P0_98E5:  BEQ  P0_9911
P0_98E7:  LDD  cable_scry             ;blank move back to the centre
P0_98EA:  SUBD BJ_CY
P0_98EC:  ANDA #$1F
P0_98EE:  STD  ,Y++
P0_98F0:  LDD  cable_scrx
P0_98F3:  SUBD BJ_CX
P0_98F5:  ANDA #$1F
P0_98F7:  STD  ,Y++
P0_98F9:  LDD  end2_scry              ;line from the centre to the second end
P0_98FC:  STD  BJ_CY
P0_98FE:  SUBD cable_scry
P0_9901:  ANDA #$1F
P0_9903:  STD  ,Y++
P0_9905:  LDD  end2_scrx
P0_9908:  STD  BJ_CX
P0_990A:  SUBD cable_scrx
P0_990D:  ORA  #$E0
P0_990F:  STD  ,Y++
P0_9911:  JSR  L60BA                  ;end of the object: the beam back to the middle of the screen
P0_9914:  RTS

;------------------------------------------------------------------------------
; cable_attach - marks the cable attached to a walker, called by cable_catch (P0_90E1) when the cable has caught
;   a leg and the walker starts to fall: sets bit 3 of the record, mode 2 and a timer of 10 frames and sends sound
;   $4F
;------------------------------------------------------------------------------
cable_attach:
P0_9915:  LDA  cable_rec              ;bit 3: the cable has caught a walker
P0_9918:  ORA  #$08
P0_991A:  STA  cable_rec
P0_991D:  LDA  #$0A                   ;the timer: 10 more frames
P0_991F:  STA  cable_timer
P0_9922:  LDB  #$02                   ;mode 2
P0_9924:  STB  cable_mode
P0_9927:  JSR  aud_cmd_4f
P0_992A:  RTS
P0_992B:  .byte $60, $A4, $8F, $AA, $20, $73, $3C, $1C ;from here to $9940 22 bytes that no code reads
P0_9933:  .byte $D4, $25, $88, $C0, $2E, $CA, $CB, $6A
P0_993B:  .byte $4A, $D1, $B8, $4A, $4B, $A8, $EA, $CF ;$9941-$9942 are page 0's word of the signature the self test shows after NO ERRORS DETECTED (bank 0 LF187)

CPYRT0_P0:
P0_9943:  .byte $43, $4F, $50, $59, $52, $49, $47, $48 ;ascii COPYRIGHT 1984 ATARI, to $9956
P0_994B:  .byte $54, $20, $31, $39, $38, $34, $20, $41
P0_9953:  .byte $54, $41, $52, $49, $FF, $50, $02, $2B ;$9957 is $FF. from $9958 leftover code shown as bytes, an earlier copy of what page 3 has from P3_8BF2: the end of CPUAL
P0_995B:  .byte $05, $BD, $95, $9C, $20, $03, $BD, $95
P0_9963:  .byte $A4, $96, $4C, $26, $28, $B6, $50, $04
P0_996B:  .byte $2B, $05, $BD, $95, $8C, $20, $03, $BD
P0_9973:  .byte $95, $94, $96, $4D, $26, $17, $F6, $50
P0_997B:  .byte $02, $1D, $CB, $01, $C1, $01, $23, $0D
P0_9983:  .byte $B8, $50, $04, $2B, $05, $BD
P0_9989:  .byte $95, $A4, $20, $03, $BD, $95, $9C, $9E
P0_9991:  .byte $5A, $EC, $88, $15, $84, $EF, $ED, $88
P0_9999:  .byte $15, $39, $9E, $5A, $EE, $84, $A6, $07 ;$999B: leftover copy of CPUMVL, to $99E0
P0_99A1:  .byte $26, $3A, $E6, $88, $12, $D7, $4F, $EE
P0_99A9:  .byte $84, $CC, $00, $00, $ED, $56, $ED, $5E
P0_99B1:  .byte $ED, $46, $04, $4F, $24, $03, $BD, $96
P0_99B9:  .byte $80, $04, $4F, $24, $03, $BD, $96, $A5
P0_99C1:  .byte $04, $4F
P0_99C3:  .byte $24, $03, $BD, $96, $48, $04, $4F, $24
P0_99CB:  .byte $03, $BD, $96, $64, $04, $4F, $24, $03
P0_99D3:  .byte $BD, $96, $2C, $04
P0_99D7:  .byte $4F, $24, $03, $BD, $96, $10, $BD, $96
P0_99DF:  .byte $DD, $39, $EE, $84, $EC, $48, $81, $7D ;$99E1: leftover copy of CPCHKL, to $9A19
P0_99E7:  .byte $2D, $03, $CC, $7C, $FF, $81, $82, $2E
P0_99EF:  .byte $03, $CC, $83, $00, $ED, $48, $EC, $4A
P0_99F7:  .byte $81
P0_99F8:  .byte $7D, $2D, $03, $CC, $7C, $FF, $81, $82
P0_9A00:  .byte $2E, $03, $CC, $83, $00, $ED, $4A, $EC
P0_9A08:  .byte $4C, $81, $7D, $2D, $03, $CC
P0_9A0E:  .byte $7C, $FF, $81, $82, $2E, $03, $CC, $83
P0_9A16:  .byte $00, $ED, $4C, $39

;------------------------------------------------------------------------------
; NWCHOR_P0 - CHOREOGRAPHY ROUTINES
;   NEW CHOREOG
;   in ESB: this copy is never called: $9958-$9C19 is an earlier assembly of the choreography and wave code
;   whose working copy is on page 3 (NWCHOR_P3 at P3_8CD0), left behind in the unused part of page 0.
;   $9958-$9A19, shown as bytes before it, is the same leftover: the end of CPUAL, CPUMVL and CPCHKL
;------------------------------------------------------------------------------
NWCHOR_P0:
P0_9A1A:  LDD  #$0000
P0_9A1D:  STD  AS_CHTW,X              ;NO TWIST OR MOVE
P0_9A20:  STA  AS_CHTM,X              ;TIME LEFT PER ROUTINE
P0_9A23:  STD  AS_CHCN,X              ;UNTIL CONTROL MASK
P0_9A26:  STD  AS_CHST,X              ;STATUS FLAGS

CHNXT_P0:
P0_9A29:  LDU  AS_CHPC,X
P0_9A2B:  LDA  ,U
P0_9A2D:  STA  AS_CHOP,X
P0_9A2F:  BEQ  CHCN_D_P0              ;DECODE CONTROL IMMEDIATELY

;------------------------------------------------------------------------------
; CHOPDO_P0 - DO THE OP-CODE
;   in ESB: part of the leftover copy at $9958-$9C19, never called. the working copy is on page 3
;------------------------------------------------------------------------------
CHOPDO_P0:
P0_9A31:  LDD  AS_CHST,X              ;CHECK CONTROL FLAGS FIRST
P0_9A34:  ANDA AS_CHCN,X
P0_9A37:  BNE  CHCN_E_P0              ;DO CONTROL
P0_9A39:  ANDB AS_CHCN+1,X
P0_9A3C:  BNE  CHCN_E_P0              ;DO CONTROL
P0_9A3E:  LDA  AS_CHOP,X
P0_9A40:  ANDA #$07
P0_9A42:  LSLA
P0_9A43:  LDU  #TCHOP_P0
P0_9A46:  JMP  [A,U]

;------------------------------------------------------------------------------
; CHCN_D_P0 - DECODE CONTROL
;   in ESB: part of the leftover copy at $9958-$9C19, never called. the working copy is on page 3
;------------------------------------------------------------------------------
CHCN_D_P0:
P0_9A48:  LDD  1,U                    ;U--> CHINST
P0_9A4A:  STD  AS_CHCN,X
P0_9A4D:  LEAU 3,U
P0_9A4F:  STU  AS_CHPC,X
P0_9A51:  BRA  CHNXT_P0

;------------------------------------------------------------------------------
; CHCN_E_P0 - [note] Control mask matched status (from CHOPDO): skip 3-byte choreography entries at AS_CHPC until one
;   whose first byte is 0, then go to CHNXT
;   in ESB: part of the leftover copy at $9958-$9C19, never called. the working copy is on page 3
;------------------------------------------------------------------------------
CHCN_E_P0:
P0_9A53:  LDU  AS_CHPC,X

CHCN_E_10_P0:
P0_9A55:  LDA  ,U                     ;U--> CHINST
P0_9A57:  BEQ  CHNXT_P0
P0_9A59:  LEAU 3,U                    ;CONTROL STATUS CHECK
P0_9A5B:  STU  AS_CHPC,X              ;SKIP UNTIL PROPER ROUTINE FOUND
P0_9A5D:  BRA  CHCN_E_10_P0

TCHOP_P0:
P0_9A5F:  .word CHIF_D_P0             ;0:IF
P0_9A61:  .word CHGO_D_P0             ;1: GOTO
P0_9A63:  .word CHGS_D_P0             ;2: GOSUB
P0_9A65:  .word CHRT_D_P0             ;3: RETURN
P0_9A67:  .word CHTW_D_P0, CHTW_E_P0  ;4,5: TWIRL
P0_9A6B:  .word CHIF_D_P0
P0_9A6D:  .word CHIF_D_P0

;------------------------------------------------------------------------------
; CHIF_D_P0 - IF MASK IS TRUE
;   in ESB: part of the leftover copy at $9958-$9C19, never called. the working copy is on page 3
;------------------------------------------------------------------------------
CHIF_D_P0:
P0_9A6F:  LDU  AS_CHPC,X

CHIF_D_10_P0:
P0_9A71:  LDD  1,U
P0_9A73:  BEQ  CHIF_D_50_P0           ;B DEFAULT IF, ALWAYS TRUE
P0_9A75:  ANDA AS_CHST,X
P0_9A78:  BNE  CHIF_D_50_P0           ;B HI MASK IS TRUE
P0_9A7A:  ANDB AS_CHST+1,X
P0_9A7D:  BNE  CHIF_D_50_P0           ;B LO MASK IS TRUE

CHIF_D_20_P0:
P0_9A7F:  LEAU 3,U
P0_9A81:  LDA  ,U
P0_9A83:  LSLA
P0_9A84:  BNE  CHIF_D_20_P0           ;NON-ZERO OP==>TRY AGAIN
P0_9A86:  BCC  CHIF_D_20_P0           ;ALL ZERO==>UNTIL OP
P0_9A88:  BRA  CHIF_D_10_P0           ;J OP=80==>'IF' FOUND

CHIF_D_50_P0:
P0_9A8A:  LEAU 3,U
P0_9A8C:  STU  AS_CHPC,X
P0_9A8E:  JMP  CHNXT_P0

;------------------------------------------------------------------------------
; CHGO_D_P0 - GOTO
;   in ESB: part of the leftover copy at $9958-$9C19, never called. the working copy is on page 3
;------------------------------------------------------------------------------
CHGO_D_P0:
P0_9A91:  LDU  AS_CHPC,X
P0_9A93:  LDU  1,U                    ;SET NEW PC
P0_9A95:  STU  AS_CHPC,X
P0_9A97:  JMP  CHNXT_P0

;------------------------------------------------------------------------------
; CHGS_D_P0 - GOSUB
;   in ESB: part of the leftover copy at $9958-$9C19, never called. the working copy is on page 3
;------------------------------------------------------------------------------
CHGS_D_P0:
P0_9A9A:  LDU  AS_CHPC,X              ;SAVE RETURN ADDRESS
P0_9A9C:  LEAU 3,U                    ;RETURN ADDRESS
P0_9A9E:  STU  AS_CHRT,X
P0_9AA1:  LDU  -$2,U                  ;PREVIOUS PARM IS GOSUB ADDRESS
P0_9AA3:  STU  AS_CHPC,X
P0_9AA5:  JMP  CHNXT_P0

;------------------------------------------------------------------------------
; CHRT_D_P0 - RETURN
;   in ESB: part of the leftover copy at $9958-$9C19, never called. the working copy is on page 3
;------------------------------------------------------------------------------
CHRT_D_P0:
P0_9AA8:  LDU  AS_CHRT,X              ;RESTORE PC
P0_9AAB:  STU  AS_CHPC,X
P0_9AAD:  JMP  CHNXT_P0

;------------------------------------------------------------------------------
; CHTW_D_P0 - TWIRL, DECODE
;   in ESB: part of the leftover copy at $9958-$9C19, never called. the working copy is on page 3
;------------------------------------------------------------------------------
CHTW_D_P0:
P0_9AB0:  LDU  AS_CHPC,X
P0_9AB2:  LDB  ,U                     ;PULL IN TIMER IN QUARTER SECONDS
P0_9AB4:  LSRB
P0_9AB5:  STB  AS_CHTM,X
P0_9AB8:  LDD  1,U                    ;TWIRL AND MOVE
P0_9ABA:  STD  AS_CHTW,X
P0_9ABD:  LEAU 3,U
P0_9ABF:  STU  AS_CHPC,X
P0_9AC1:  INC  AS_CHOP,X              ;BUMP TO EXECUTE PHASE
P0_9AC3:  RTS

;------------------------------------------------------------------------------
; CHTW_E_P0 - TWIRL, EXECUTE
;   in ESB: part of the leftover copy at $9958-$9C19, never called. the working copy is on page 3
;------------------------------------------------------------------------------
CHTW_E_P0:
P0_9AC4:  DEC  AS_CHTM,X              ;TRICK OFF TIMER
P0_9AC7:  LBMI CHNXT_P0               ;B IF DONE, GET NEXT OP
P0_9ACB:  RTS                         ;ELSE WAIT FOR NEXT FRAME

;------------------------------------------------------------------------------
; NWNSHP - Star Wars' NWNSHP without its first instruction JSR INOBJ, which is why the matcher missed it: picks
;   the list of ships for SP_WAV and WV_LVL from TSPWAV, frees all alien records and builds one ship per list
;   entry with NWASHP. part of the leftover copy at $9958-$9C19 - no caller on this page, the copy in use is on
;   page 3 (NWCHOR_P3 at P3_8CD0 and what follows), and the table bytes at $9C1C do not have the form this code
;   reads
;------------------------------------------------------------------------------
NWNSHP:
P0_9ACC:  LDB  SP_WAV                 ;CURRENT SPACE WAVE
P0_9ACF:  LSLB
P0_9AD0:  LDX  #TSPWAV                ;TABLE OF SPACE WAVE GROUPS
P0_9AD3:  ABX
P0_9AD4:  CMPX #P0_9C20               ;PAST END OF TABLE?
P0_9AD7:  BLO  P0_9AE7                ;IFHS  YEP
P0_9AD9:  LDA  SP_WAV
P0_9ADC:  LSRA
P0_9ADD:  BCS  P0_9AE4                ;IFCC  EVEN ==> ODD SELECTED WAVE
P0_9ADF:  LDX  #TSPWAV                ;DARTH COMES SECOND ON SELECTED ODD WAVES
P0_9AE2:  BRA  P0_9AE7                ;ELSE
P0_9AE4:  LDX  #P0_9C1E               ;USE LAST ENTRY IN TABLE, DARTH FIRST WITH MUSIC
P0_9AE7:  LDX  ,X                     ;POINTS TO CURRENT SET OF WAVES
P0_9AE9:  LDB  WV_LVL                 ;INDEX INTO SET OF WAVES
P0_9AEB:  CMPB ,X+                    ;GET SIZE OF THIS SET
P0_9AED:  BLS  P0_9AF1                ;IFHI  KEEP IT WITHIN RANGE
P0_9AEF:  LDB  -$1,X
P0_9AF1:  LSLB                        ;INDEX INTO WORD TABLE
P0_9AF2:  LDD  B,X
P0_9AF4:  STD  WV_LP                  ;LOOP TABLE POINTER
P0_9AF6:  CLR  WV_LIV                 ;NO ALIENS CURRENTLY ALIVE
P0_9AF8:  LDX  #ALIEN

NWNSHP_20_P0:
P0_9AFB:  STX  S1_PRM
P0_9AFD:  CLR  AS_TYP,X               ;KILL ALL ALIENS FIRST
P0_9AFF:  LDU  WV_LP
P0_9B01:  BEQ  NWNSHP_90_P0           ;IGNORE ALIEN IF NO CHOREOG SET
P0_9B03:  LDA  ,U
P0_9B05:  BEQ  NWNSHP_90_P0           ;?CONSTRUCT THIS SHIP?
P0_9B07:  INC  WV_LIV                 ;ONE MORE LIFE IN THIS WAVE
P0_9B09:  LDD  ,U
P0_9B0B:  STD  WV_SHP                 ;SHIP SHAPE AND PARMS
P0_9B0D:  LDD  2,U
P0_9B0F:  STD  WV_CHP                 ;CHOREOGRAPHY
P0_9B11:  LDD  4,U
P0_9B13:  STD  WV_BGP                 ;BEGIN LOCATION
P0_9B15:  LEAU 6,U
P0_9B17:  STU  WV_LP
P0_9B19:  JSR  NWASHP_P0

NWNSHP_90_P0:
P0_9B1C:  LDX  S1_PRM
P0_9B1E:  LEAX AS_IZE,X
P0_9B21:  CMPX #ALIENZ
P0_9B24:  BLO  NWNSHP_20_P0
P0_9B26:  RTS

;------------------------------------------------------------------------------
; NWASHP_P0 - [note] Make alien record X a live ship: unit vectors (UNITV) facing the player, hits AS_HTA from WV_SHP,
;   location from WV_BGP, choreography WV_CHP (NWCHOR), picture AS_PIC; adds its object with ADBOBJ
;   in ESB: part of the leftover copy at $9958-$9C19, never called. the working copy is on page 3
;------------------------------------------------------------------------------
NWASHP_P0:
P0_9B27:  LDA  #$01
P0_9B29:  STA  AS_TYP,X               ;LIVE ALIEN
P0_9B2B:  LDU  ,X
P0_9B2D:  JSR  UNITV
P0_9B30:  LDU  ,X
P0_9B32:  LDA  #$C0                   ;FACE ALIEN TOWARDS PLAYER
P0_9B34:  STA  MS_AX,U
P0_9B36:  STA  MS_BY,U
P0_9B38:  CLRA
P0_9B39:  STA  10,X
P0_9B3B:  STA  9,X
P0_9B3D:  STA  7,X
P0_9B3F:  STA  6,X
P0_9B41:  STA  12,X
P0_9B43:  LDU  WV_SHP
P0_9B45:  LDA  1,U
P0_9B47:  STA  8,X
P0_9B49:  LDU  ,X
P0_9B4B:  LDX  WV_BGP                 ;BEGINNING LOCATION
P0_9B4D:  LDD  ,X
P0_9B4F:  STD  MS_TX,U
P0_9B51:  LDD  2,X
P0_9B53:  STD  MS_TY,U
P0_9B55:  LDD  4,X
P0_9B57:  STD  MS_TZ,U
P0_9B59:  LDX  S1_PRM
P0_9B5B:  LDD  WV_CHP
P0_9B5D:  STD  AS_CHPC,X
P0_9B5F:  JSR  NWCHOR_P0
P0_9B62:  LDX  S1_PRM
P0_9B64:  LDB  [WV_SHP]
P0_9B68:  STB  5,X
P0_9B6A:  JSR  L60A8
P0_9B6D:  RTS

;------------------------------------------------------------------------------
; ADASHP_P0 - [note] Add one alien ship from loop table WV_LP (next WV_LVL of the SP_WAV group when the level ends) into
;   the first empty ALIEN slot, set up as in NWASHP but with no ADBOBJ; INC WV_LIV; exits if no slot or entry
;   in ESB: part of the leftover copy at $9958-$9C19, never called. the working copy is on page 3
;------------------------------------------------------------------------------
ADASHP_P0:
P0_9B6E:  LDU  WV_LP
P0_9B70:  BEQ  ADASHP_20_P0           ;RESTART IF INVALID WITHIN WAVES
P0_9B72:  LDA  ,U
P0_9B74:  BNE  P0_9BA4                ;IFEQ  ?END OF CURRENT LEVEL IN WAVE?

ADASHP_20_P0:
P0_9B76:  INC  WV_LVL                 ;GET NEXT LEVEL WITHIN WAVE
P0_9B78:  LDB  SP_WAV                 ;CURRENT SPACE WAVE
P0_9B7B:  LSLB
P0_9B7C:  LDX  #TSPWAV                ;TABLE OF SPACE WAVE GROUPS
P0_9B7F:  ABX
P0_9B80:  CMPX #P0_9C20               ;PAST END OF TABLE?
P0_9B83:  BLO  P0_9B93                ;IFHS  YEP
P0_9B85:  LDA  SP_WAV
P0_9B88:  LSRA
P0_9B89:  BCS  P0_9B90                ;IFCC  EVEN ==> ODD SELECTED WAVE
P0_9B8B:  LDX  #TSPWAV                ;DARTH COMES SECOND ON SELECTED ODD WAVES
P0_9B8E:  BRA  P0_9B93                ;ELSE
P0_9B90:  LDX  #P0_9C1E               ;USE LAST ENTRY IN TABLE, DARTH FIRST WITH MUSIC
P0_9B93:  LDX  ,X                     ;POINTS TO CURRENT SET OF WAVES
P0_9B95:  LDB  WV_LVL                 ;INDEX INTO SET OF WAVES
P0_9B97:  CMPB ,X+                    ;GET SIZE OF THIS SET
P0_9B99:  BLS  P0_9B9D                ;IFHI  KEEP IT WITHIN RANGE
P0_9B9B:  LDB  -$1,X
P0_9B9D:  STB  WV_LVL                 ;KEEP IT CORRECT
P0_9B9F:  LSLB                        ;INDEX INTO WORD TABLE
P0_9BA0:  LDD  B,X
P0_9BA2:  STD  WV_LP                  ;LOOP TABLE POINTER
P0_9BA4:  LDX  #ALIEN
P0_9BA7:  STX  S1_PRM
P0_9BA9:  LDA  AS_TYP,X
P0_9BAB:  BEQ  ADASHP_50_P0           ;DO IT IF AN EMPTY SLOT
P0_9BAD:  LDX  S1_PRM
P0_9BAF:  LEAX AS_IZE,X
P0_9BB2:  CMPX #ALIENZ
P0_9BB5:  BLO  P0_9BA7                ;HSEND
P0_9BB7:  BRA  P0_9C19                ;IF NO SLOTS AVAILABLE, EXIT NOW

ADASHP_50_P0:
P0_9BB9:  LDU  WV_LP
P0_9BBB:  BEQ  P0_9C19                ;IGNORE ALIEN IF NO CHOREOG SET
P0_9BBD:  LDA  ,U
P0_9BBF:  BEQ  P0_9C19                ;?CONSTRUCT THIS SHIP?
P0_9BC1:  INC  WV_LIV                 ;ONE MORE LIFE IN THIS WAVE
P0_9BC3:  LDD  ,U
P0_9BC5:  STD  WV_SHP                 ;SHIP SHAPE AND PARMS
P0_9BC7:  LDD  2,U
P0_9BC9:  STD  WV_CHP                 ;CHOREOGRAPHY
P0_9BCB:  LDD  4,U
P0_9BCD:  STD  WV_BGP                 ;BEGIN LOCATION
P0_9BCF:  LEAU 6,U
P0_9BD1:  STU  WV_LP
P0_9BD3:  LDA  #$01
P0_9BD5:  STA  AS_TYP,X               ;LIVE ALIEN
P0_9BD7:  LDU  ,X
P0_9BD9:  JSR  UNITV
P0_9BDC:  LDU  ,X
P0_9BDE:  LDA  #$C0                   ;FACE ALIEN TOWARDS PLAYER
P0_9BE0:  STA  MS_AX,U
P0_9BE2:  STA  MS_BY,U
P0_9BE4:  CLRA
P0_9BE5:  STA  10,X
P0_9BE7:  STA  9,X
P0_9BE9:  STA  7,X
P0_9BEB:  STA  6,X
P0_9BED:  STA  12,X
P0_9BEF:  LDU  WV_SHP
P0_9BF1:  LDA  1,U                    ;DRONES DIE ON N HITS
P0_9BF3:  STA  8,X
P0_9BF5:  LDU  ,X
P0_9BF7:  LDX  WV_BGP                 ;BEGINNING LOCATION
P0_9BF9:  LDD  ,X
P0_9BFB:  STD  MS_TX,U
P0_9BFD:  LDD  2,X
P0_9BFF:  STD  MS_TY,U
P0_9C01:  LDD  4,X
P0_9C03:  STD  MS_TZ,U
P0_9C05:  LDX  S1_PRM
P0_9C07:  LDD  WV_CHP
P0_9C09:  STD  AS_CHPC,X
P0_9C0B:  JSR  NWCHOR_P0
P0_9C0E:  LDX  S1_PRM
P0_9C10:  LDB  [WV_SHP]
P0_9C14:  STB  5,X
P0_9C16:  JSR  L60A8
P0_9C19:  RTS
P0_9C1A:  .byte $00, $01              ;leftover data: 0, 1 - the shape entry TS_TIE of Star Wars' wave tables (object 0, the TIE fighter, 1 hit)

;.SBTTL WAVE DATA
TSPWAV:          ;TABLE OF SPACE WAVE SETS
P0_9C1C:  .word P0_9C20
P0_9C1E:  .word P0_9C20               ;the second entry points at $9C20 as well
P0_9C20:  .byte $9C, $1A, $9C, $5C, $00, $9C, $1A, $9C ;ten leftover ship lists to $9C55, each ship a pointer to $9C1A and a pointer into the choreography bytes below, each list ended by a 0. not the form NWNSHP and ADASHP above read: they take a count byte and a list of words at $9C20, and 6 bytes for each ship
P0_9C28:  .byte $74, $00, $9C, $1A, $9C, $8C, $00, $9C
P0_9C30:  .byte $1A, $9C, $9E, $00, $9C, $1A, $9C, $9E
P0_9C38:  .byte $00, $9C, $1A, $9C, $59, $9C, $1A, $9C
P0_9C40:  .byte $5F, $00, $9C, $1A, $9C, $71, $00, $9C
P0_9C48:  .byte $1A, $9C, $89, $00, $9C, $1A, $9C, $9B
P0_9C50:  .byte $00, $9C, $1A, $9C, $59, $00, $24, $00 ;from $9C56 leftover choreography, 3 bytes an instruction as NWCHOR reads them: $x4 twirl, 1 goto, 2 gosub, 0 control mask. the gosubs go to $9CA4
P0_9C58:  .byte $00, $02, $9C, $A4, $44, $00, $10, $02
P0_9C60:  .byte $9C, $A4, $44, $02, $20, $02, $9C, $A4
P0_9C68:  .byte $44, $01, $20, $14, $00, $08, $01, $9C
P0_9C70:  .byte $6B, $02, $9C, $A4, $24, $00, $14, $01
P0_9C78:  .byte $9C, $83, $02, $9C, $A4, $02, $9C, $A4
P0_9C80:  .byte $14, $00, $22, $24, $02, $20, $00, $00
P0_9C88:  .byte $00, $02, $9C, $A4, $24, $04, $10, $00
P0_9C90:  .byte $00, $04, $02, $9C, $A4, $02, $9C, $A4
P0_9C98:  .byte $00, $00, $44, $02, $9C, $A4, $02, $9C
P0_9CA0:  .byte $A4, $02, $9C, $A4, $14, $00, $08, $AE ;the choreography stops at $9CA6 without its return. from $9CA7 code: the leftover copy of bank 0's irq_handler, starting LDX 10,U / CMPX #$6000
P0_9CA8:  .byte $4A, $8C, $60, $00, $24, $00, $8C, $EA
P0_9CB0:  .byte $80, $25, $05, $8C, $F0, $00, $24, $00
P0_9CB8:  .byte $86, $48, $1F, $8B, $96, $00, $81, $3F
P0_9CC0:  .byte $27, $00, $0A, $45, $2A, $08, $86, $0B
P0_9CC8:  .byte $97, $45, $0C, $44, $28, $00, $0C, $0A
P0_9CD0:  .byte $0C, $CC, $BD, $C6, $7A, $96, $15, $81
P0_9CD8:  .byte $24, $25, $00, $8E, $48, $1D, $B6, $43
P0_9CE0:  .byte $00, $BD, $9E, $EA, $B6, $43, $20, $BD
P0_9CE8:  .byte $9E, $EA, $B6, $43, $40, $BD, $9E, $EA
P0_9CF0:  .byte $B6, $43
P0_9CF2:  .byte $60, $BD, $9E, $EA, $96, $34, $97, $35
P0_9CFA:  .byte $B6, $48, $22, $84, $30, $A7, $7F, $B6
P0_9D02:  .byte $48, $1F, $84, $CF, $AA, $7F, $97, $34
P0_9D0A:  .byte $98, $35, $94, $35, $97, $33, $96, $33
P0_9D12:  .byte $84, $F0, $27, $04, $9A, $32, $97, $32
P0_9D1A:  .byte $BD, $9E, $FD, $96, $0A, $26, $15, $B6
P0_9D22:  .byte $44, $01, $48, $2A, $07, $B6, $44, $00
P0_9D2A:  .byte $81, $D3, $27, $08, $B7, $46, $E0, $86
P0_9D32:  .byte $00, $B7, $44, $00, $96, $0A, $84, $03
P0_9D3A:  .byte $26, $48, $B6, $48, $1C, $8B, $01, $81
P0_9D42:  .byte $FA, $25, $02, $86, $00, $B7, $48, $1C
P0_9D4A:  .byte $26, $38, $B6, $48, $1B, $8B, $01, $19
P0_9D52:  .byte $B7, $48, $1B, $B6, $48, $1A, $89, $00
P0_9D5A:  .byte $19, $25, $03, $B7, $48, $1A, $B6, $4C
P0_9D62:  .byte $38, $8B, $01, $19, $B7, $4C, $38, $B6
P0_9D6A:  .byte $4C, $37, $89, $00, $19, $B7, $4C, $37
P0_9D72:  .byte $B6, $4C, $36, $89, $00, $19, $B7, $4C
P0_9D7A:  .byte $36, $B6, $4C, $35, $89, $00, $19, $B7
P0_9D82:  .byte $4C, $35, $0A, $47, $28, $0C, $B7, $46
P0_9D8A:  .byte $20, $F6, $48, $CD, $BD, $A3, $42, $7E
P0_9D92:  .byte $9E, $E6, $10, $2A, $01, $4E, $B6, $43
P0_9D9A:  .byte $20, $48, $10, $2A, $01, $46, $96, $46
P0_9DA2:  .byte $2A, $19, $B6, $00, $00, $84, $0A, $27
P0_9DAA:  .byte $02, $86, $14, $8A, $00, $97, $46, $C6
P0_9DB2:  .byte $1D, $44, $84, $0A, $88, $0A, $8A, $E0
P0_9DBA:  .byte $FD, $00, $00, $0A, $29, $2A, $05, $0F
P0_9DC2:  .byte $29, $BD, $9F, $44, $BD, $9F, $E2, $D6 ;from $9DCD the bytes are the same on all four pages
P0_9DCA:  .byte $41, $CB, $02, $C1, $10, $25, $01, $5F
P0_9DD2:  .byte $D7, $41, $8E, $00, $04, $3A, $CE, $B9
P0_9DDA:  .byte $22, $EC, $C1, $ED, $83, $8C, $00, $02
P0_9DE2:  .byte $2E, $F7, $8E, $00, $12, $11, $83, $B9
P0_9DEA:  .byte $32, $24, $06, $EC, $C1, $ED, $83, $20
P0_9DF2:  .byte $F4, $D6, $42, $CB, $02, $8E, $9E, $02 ;$9DF7-$9E01: LDX #$9E02 / LDB diff_adder / ABX / LDA 0,X / ASLA / RTS, put over the handler copy's instructions. nothing jumps to $9DF7
P0_9DFA:  .byte $F6, $4C, $5A, $3A, $A6, $00, $48, $39 ;$9DFE: LDA 0,X / ASLA / RTS, the helper page 1 calls with X = $9B5C + n for the slapstic's alternate sequence
P0_9E02:  .byte $00, $00, $00, $FF, $00, $00, $FF, $00 ;16 bytes of $00 and $FF that the LDX above points at, read by nothing. with the 11 bytes before them they take the place of the 27 bytes of bank 0 LEBCD-LEBE7
P0_9E0A:  .byte $FF, $00, $FF, $FF, $00, $FF, $FF, $FF
P0_9E12:  .byte $C1, $08, $25, $01, $5F, $D7, $38, $CE ;the handler copy goes on, as bank 0 from LEBE8: CMPB #$08
P0_9E1A:  .byte $B9, $3A, $EC, $C5, $FD, $00, $1A, $D6
P0_9E22:  .byte $38, $CE, $B9, $42, $EC, $C5, $FD, $00
P0_9E2A:  .byte $1E, $0A, $39

;------------------------------------------------------------------------------
; irq_old_tail - not a routine start: the middle of the DOVG part of a second copy of bank 0's irq_handler,
;   assembled to run at $9CA7 (the listing shows $9CA7-$9E2C as bytes). the copy has no SWI traps and no watchdog
;   write, calls COINS and load_vg_set at their bank 0 addresses and its own copies of DEBNCE, DOPOTS, RHCTRL,
;   RHLIM and RHPOS at $9EEA-$9FE1, and the copy of GNSITE that starts at $9FE2 is cut off by the end of the page
;   - bank 0 at $A000 does not continue it. from here to $9EDB the bytes are those of bank 0 LEC03-LECB1. it
;   cannot run: the IRQ goes to irq_handler in bank 0, the only words on the page that point at this code are the
;   operands of the copy's own JSR and JMP instructions, the wave tables before it point no higher than $9CA4, and
;   27 bytes of it at $9DF7-$9E11 have been replaced by the slapstic helper and a table, so the copy would return
;   at $9E01 without restarting the vector generator or clearing the IRQ. $9DCD-$9FFF is byte for byte the same on
;   all four pages, $9D2C up on page 3 and $9C1B up on page 2. the one live thing in it is the helper at $9DFE
;   (LDA 0,X / ASLA / RTS), called by four routines of page 1 only for the slapstic's alternate sequence
;------------------------------------------------------------------------------
irq_old_tail:
P0_9E2D:  BGT  P0_9E46                ;as bank 0 LEC03, in the middle of the handler copy
P0_9E2F:  LDB  #$01
P0_9E31:  STB  pic1c_timer

;===LAZAR SPLASH
DOVG_48_P0:
P0_9E33:  LDB  pic1c_index
P0_9E35:  ADDB #$02
P0_9E37:  CMPB #$08
P0_9E39:  BLO  P0_9E3C                ;IFHS
P0_9E3B:  CLRB
P0_9E3C:  STB  pic1c_index
P0_9E3E:  LDU  #VTGNT
P0_9E41:  LDD  B,U
P0_9E43:  STD  $001C                  ;ONE PICTURE ONLY
;ALIEN GUN SHOT, BASE SPARKLE
P0_9E46:  DEC  lzs_timer
P0_9E48:  BGT  P0_9E61                ;IFLE
P0_9E4A:  LDB  #$02                   ;EVERY FOURTH SCREEN, CHANGE PICTURE TYPE
P0_9E4C:  STB  lzs_timer

;===LAZAR SPLASH
DOVG_48_P0_2:
P0_9E4E:  LDB  VG_LZS
P0_9E50:  ADDB #$02
P0_9E52:  CMPB #$08
P0_9E54:  BLO  P0_9E57                ;IFHS
P0_9E56:  CLRB
P0_9E57:  STB  VG_LZS
P0_9E59:  LDU  #spark_tab
P0_9E5C:  LDD  B,U
P0_9E5E:  STD  VRLZS                  ;ONE PICTURE ONLY
;ALIEN GUN SHOT, BASE SPARKLE
P0_9E61:  DEC  VF_GNB
P0_9E63:  BGT  P0_9E7C                ;IFLE
P0_9E65:  LDB  #$01                   ;EVERY FOURTH SCREEN, CHANGE PICTURE TYPE
P0_9E67:  STB  VF_GNB

;===LAZAR SPLASH
DOVG_48_P0_3:
P0_9E69:  LDB  gnx_index
P0_9E6B:  ADDB #$02
P0_9E6D:  CMPB #$08
P0_9E6F:  BLO  P0_9E72                ;IFHS
P0_9E71:  CLRB
P0_9E72:  STB  gnx_index
P0_9E74:  LDU  #sparks_tab
P0_9E77:  LDD  B,U
P0_9E79:  STD  VRGNX
;ALIEN GUN SHOT, TIP FUSE
P0_9E7C:  DEC  VF_GNT
P0_9E7E:  BGT  P0_9E97                ;IFLE
P0_9E80:  LDB  #$01                   ;EVERY SCREEN, CHANGE PICTURE TYPE
P0_9E82:  STB  VF_GNT
P0_9E84:  LDB  VG_GNT
P0_9E86:  ADDB #$02
P0_9E88:  CMPB #$08
P0_9E8A:  BLO  P0_9E8D                ;IFHS
P0_9E8C:  CLRB
P0_9E8D:  STB  VG_GNT
P0_9E8F:  LDU  #tri_tab
P0_9E92:  LDD  B,U
P0_9E94:  STD  VRGNT                  ;ONE PICTURE ONLY
P0_9E97:  LDB  VG_FLS                 ;BRITE FLASH
P0_9E99:  ADDB #$02
P0_9E9B:  CMPB #VTFLSZ-VTFLS
P0_9E9D:  BLO  P0_9EA0                ;IFHS  ?OVERFLOWED?
P0_9E9F:  CLRB
P0_9EA0:  STB  VG_FLS
P0_9EA2:  LDU  #VTFLS
P0_9EA5:  LDD  B,U
P0_9EA7:  STD  VRFLS                  ;ONE PICTURE ONLY
P0_9EAA:  LDB  gs_fade
P0_9EAC:  STD  $002E
P0_9EAF:  LDB  #$80
P0_9EB1:  SUBB flash_fade
P0_9EB4:  STD  $0032
P0_9EB7:  LDD  #VGRTSL
P0_9EBA:  STD  $0028
P0_9EBD:  STD  $0030
P0_9EC0:  STD  $0034                  ;AND RETURN VG
P0_9EC3:  LDB  VG_MFL                 ;MEDIUM FLASH
P0_9EC5:  ADDB #$02
P0_9EC7:  CMPB #VTMFLZ-VTMFL
P0_9EC9:  BLO  P0_9ECC                ;IFHS  ?OVERFLOWED TABLE?
P0_9ECB:  CLRB                        ;THEN START AT BEGINNING
P0_9ECC:  STB  VG_MFL
P0_9ECE:  LDU  #VTMFL
P0_9ED1:  LDD  B,U
P0_9ED3:  STD  VRMFL                  ;ONE PICTURE ONLY
P0_9ED6:  LDD  #VGRTSL
P0_9ED9:  STD  VRMFL+2                ;AND RETURN VG
P0_9EDC:  JSR  SPLASH                 ;OSCILLATE LAZAR SPLASH PICS
P0_9EDF:  STA  VGGO                   ;START VGEN AGAIN
P0_9EE2:  LDA  #$05
P0_9EE4:  STA  VGTIMR

DOVG_90_P0:
P0_9EE6:  STA  IRCLR                  ;ALLOW NEXT IRQ
P0_9EE9:  RTS

;------------------------------------------------------------------------------
; DEBNCE_P0 - A=NEW VAL
;   X-->RAM AREA
;   in ESB: copy of bank 0's DEBNCE inside the leftover irq_handler copy that fills $9CA7-$9FFF, the same on
;   all four pages. called only by that copy, which never runs
;------------------------------------------------------------------------------
DEBNCE_P0:
P0_9EEA:  LDB  ,X                     ;NW: PREVIOUS NEW
P0_9EEC:  STB  1,X                    ;OL: -->OLD
P0_9EEE:  STA  ,X                     ;NW: SAVE NEWEST
P0_9EF0:  ANDA 1,X                    ;OL: SAME BITS ON
P0_9EF2:  ORA  2,X                    ;SW:
P0_9EF4:  STA  2,X                    ;SW: SAVE DEBOUNCED ON BITS
P0_9EF6:  ORB  ,X++                   ;NW: SAME BITS OFF
P0_9EF8:  ANDB ,X                     ;SW:
P0_9EFA:  STB  ,X+                    ;SW: SAVE DEBOUNCED OFF BITS,
;(X)+: PREPARE FOR NEXT SWITCH SET
P0_9EFC:  RTS

;------------------------------------------------------------------------------
; DOPOTS_P0 - HANDLE READING POT VALUES
;   in ESB: copy of bank 0's DOPOTS inside the leftover irq_handler copy, the same on all four pages, never
;   run
;------------------------------------------------------------------------------
DOPOTS_P0:
P0_9EFD:  LDA  S_INTCT
P0_9EFF:  LSRA                        ;?WHICH POT?
P0_9F00:  LDY  #PT_VL                 ;ASSUME POT 1
P0_9F04:  BCS  P0_9F0A                ;IFCC  NOPE, IT'S THE OTHER ONE
P0_9F06:  LDY  #PT_VL+PTS_IZ          ;POT 2
;POKEY FILTER
;REQUIRE 2 SAMPLES ALL HIGHER (OR LOWER)
;THAN CURRENT SAVED VALUE.
;THEN UPDATE TO CLOSEST HI (LO) VALUE
P0_9F0A:  LDB  1,Y                    ;B:=VNEW PREVIOUS NEW BECOMES CURRENT OLD
P0_9F0C:  LDA  R_CHN
P0_9F0F:  STA  1,Y                    ;A:=VNEW UPDATE CURRENT NEW
P0_9F11:  CMPA ,Y                     ;VL
P0_9F13:  BLO  P0_9F23                ;IFHS  ?NEW VALUE HIGHER THAN STANDARD VALUE?
P0_9F15:  CMPB ,Y                     ;VL
P0_9F17:  BLS  P0_9F21                ;IFHI  ?AND OLD VALUE HIGHER ALSO?
P0_9F19:  CMPB 1,Y                    ;VNEW
P0_9F1B:  BLS  P0_9F1F                ;IFHI  ?VNEW IS CLOSER?
P0_9F1D:  LDB  1,Y                    ;VNEW
P0_9F1F:  STB  ,Y                     ;VL SAVE CLOSEST OF HIGHER VALUES
P0_9F21:  BRA  P0_9F2F                ;ELSE  ELSE NEW VALUE IS LOWER THAN STANDARD VALUE
P0_9F23:  CMPB ,Y                     ;VL
P0_9F25:  BHS  P0_9F2F                ;IFLO  ?OLD VALUE ALSO LOWER?
P0_9F27:  CMPB 1,Y                    ;VNEW
P0_9F29:  BHS  P0_9F2D                ;IFLO  ?VNEW IS CLOSER?
P0_9F2B:  LDB  1,Y                    ;VNEW
P0_9F2D:  STB  ,Y                     ;VL SAVE CLOSEST OF LOWER VALUES
P0_9F2F:  CMPY #PT_VL                 ;START NEXT A-D CONVERSION
P0_9F33:  BNE  P0_9F3D                ;IFEQ
P0_9F35:  STA  W_CHN0                 ;SELECT CHANNEL 0
P0_9F38:  STA  W_CHN0                 ;START GOOD CONVERSION
P0_9F3B:  BRA  P0_9F43                ;ELSE
P0_9F3D:  STA  W_CHN1                 ;SELECT CHANNEL 1
P0_9F40:  STA  W_CHN1                 ;AND START IT CLEANLY
P0_9F43:  RTS

;------------------------------------------------------------------------------
; RHCTRL_P0 - IRQ VG HANDLES CONTROLS
;   in ESB: copy of bank 0's RHCTRL inside the leftover irq_handler copy, the same on all four pages, never
;   run. it calls the copies of RHLIM and RHPOS that follow it
;------------------------------------------------------------------------------
RHCTRL_P0:
P0_9F44:  LDX  #RHEOP                 ;DO PITCH POT
P0_9F47:  LDA  PT_VL2                 ;UP/DOWN VG Y
P0_9F49:  NOP
P0_9F4A:  JSR  RHLIM_P0               ;LIMIT AND SCALE RHESTAT
P0_9F4D:  LDA  RHS_NML,X              ;NOW LIMIT THE POT BY THE VG SCREEN
P0_9F4F:  CMPA #VGCURT                ;HI LIMIT - CURSOR SIZE, SCALED TO +-128
P0_9F51:  BLE  P0_9F55                ;IFGT
P0_9F53:  LDA  #VGCURT
P0_9F55:  CMPA #VGCURB&$FF            ;TOP CURSOR POSITION, SCALED DOWN +-512 TO +-128
P0_9F57:  BGE  P0_9F5B                ;IFLT
P0_9F59:  LDA  #VGCURB&$FF
P0_9F5B:  STA  RHS_NML,X
P0_9F5D:  JSR  RHPOS_P0
P0_9F60:  LDX  #RHEOY                 ;DO YAW POT
P0_9F63:  LDA  PT_VL1                 ;LEFT/RIGHT VG X
P0_9F65:  NOP
P0_9F66:  JSR  RHLIM_P0               ;LIMIT AND SCALE RHESTAT
P0_9F69:  LDA  RHS_NML,X              ;NOW LIMIT TO CURSOR SCREEN SIZE
P0_9F6B:  CMPA #VGCURR
P0_9F6D:  BLE  P0_9F71                ;IFGT
P0_9F6F:  LDA  #VGCURR
P0_9F71:  CMPA #VGCURL&$FF
P0_9F73:  BGE  P0_9F77                ;IFLT
P0_9F75:  LDA  #VGCURL&$FF
P0_9F77:  STA  RHS_NML,X
P0_9F79:  JSR  RHPOS_P0
P0_9F7C:  RTS

;------------------------------------------------------------------------------
; RHLIM_P0 - ---LIMIT AND SCALE
;   in ESB: copy of bank 0's RHLIM inside the leftover irq_handler copy, the same on all four pages, never run
;------------------------------------------------------------------------------
RHLIM_P0:
P0_9F7D:  CMPA ,X                     ;A=RHEOSTAT VALUE
;X==>RAM BLOCK
;Y==>DATA TABLE
P0_9F7F:  BHS  P0_9F87                ;IFLO  ?LESS THAN LO?
P0_9F81:  CMPA RHS_LT,X
P0_9F83:  BLO  P0_9F87                ;IFHS  ?HIGHER THAN TRIAL LO?
P0_9F85:  DEC  ,X                     ;APPROACH NEW DEGLITCHED LO
P0_9F87:  STA  RHS_LT,X               ;SAVE OUR NEW TRIAL LO
P0_9F89:  CMPA ,X                     ;?LESS THAN LOWER LIMIT?
P0_9F8B:  BHS  P0_9F8F                ;IFLO
P0_9F8D:  LDA  ,X                     ;THEN REPLACE WITH LOWER LIMIT
P0_9F8F:  SUBA ,X                     ;BASE AT ZERO
P0_9F91:  STA  RH_DIR                 ;TEMP STORAGE OF POT BASED VALUE
P0_9F93:  LDB  RHS_SP,X               ;SPREAD THE VALUES-SCAL
P0_9F95:  MUL
P0_9F96:  ADDA RH_DIR                 ;MULTS BY 1XX SO VALUE GOES ABOVE 7F
P0_9F98:  BNE  P0_9F9C                ;IFEQ  ?UNDERFLOW?
P0_9F9A:  LDA  #$01                   ;RANGE IS -7F TO 7F (ALLOWS PROPER NEGATE)
P0_9F9C:  BCS  P0_9FA2                ;IFCC  ?OVERFLOW?
P0_9F9E:  CLR  RHS_ST,X               ;PREPARE TIMER FOR NEXT TOO-HIGH POT VALUE
P0_9FA0:  BRA  P0_9FAE                ;ELSE
P0_9FA2:  LDA  #$FF                   ;THEN LIMIT VALUE
P0_9FA4:  INC  RHS_ST,X               ;TIME THESE EXCESSES
P0_9FA6:  LDB  RHS_ST,X
P0_9FA8:  CMPB #$02
P0_9FAA:  BLO  P0_9FAE                ;IFHS  ?TOO LARGE FOR TOO LONG?
P0_9FAC:  DEC  RHS_SP,X               ;THEN DECREASE SPREAD
P0_9FAE:  CLRB
P0_9FAF:  SUBA #$80                   ;CHANGE TO SIGNED VALUE
P0_9FB1:  STA  RHS_NML,X
P0_9FB3:  RTS

;------------------------------------------------------------------------------
; RHPOS_P0 - CONVERT NML VALUE TO SCREEN POSITION
;   SLEWED POSITIONAL
;   in ESB: copy of bank 0's RHPOS inside the leftover irq_handler copy, the same on all four pages, never run
;------------------------------------------------------------------------------
RHPOS_P0:
P0_9FB4:  CLR  RH_DIR                 ;START WITH POSITIVE DIRECTION TO TRAVEL
P0_9FB6:  LDA  RHS_NML,X              ;CURRENT -7F TO 7F POT
P0_9FB8:  LDB  #$80                   ;HALF WAY INTO POTS STAMP
P0_9FBA:  SUBD RHS_POS,X              ;CURRENT SCREEN POSITION
P0_9FBC:  BGE  P0_9FC1                ;IFLT  ?WANT TO GO IN NEGATIVE DIRECTION?
P0_9FBE:  NEGA                        ;THEN CHANGE DELTA TO POSITIVE 8-BIT
P0_9FBF:  DEC  RH_DIR                 ;AND SAVE NEGATIVE INDICATOR
P0_9FC1:  BLE  P0_9FC6                ;IFGT  ?SLIGHTLY POSITIVE?
P0_9FC3:  ADDD #$00FF                 ;TRUNCATE UPWARD -- ALWAYS SLEW SOME
P0_9FC6:  CMPA #$F8
P0_9FC8:  BLS  P0_9FCC                ;IFHI
P0_9FCA:  LDA  #$F8                   ;PREVENT OVERFLOWS DURING LATER TRUNCATIONS
P0_9FCC:  LDB  #$60                   ;HOW QUICKLY TO SKEW TO DESIRED LOCATION
P0_9FCE:  CMPA #$40                   ;ONE-QUARTER SCREEN
P0_9FD0:  BHS  P0_9FD4                ;IFLO  ?CLOSE ENUF?
P0_9FD2:  LDB  #$30                   ;SLOWER WHEN CLOSER
P0_9FD4:  MUL
P0_9FD5:  TST  RH_DIR                 ;RESTORE ORIGINAL DIRECTION
P0_9FD7:  BPL  P0_9FDD                ;IFMI
P0_9FD9:  COMA                        ;NEGD
P0_9FDA:  NEGB
P0_9FDB:  SBCA #$FF
P0_9FDD:  ADDD RHS_POS,X              ;NOW UPDATE OUR CURSOR POSITION
P0_9FDF:  STD  RHS_POS,X              ;RH$POS IS EQUATED TO VG.RSX,VG.RSY
P0_9FE1:  RTS
P0_9FE2:  .byte $D6, $6A, $96, $6B, $84, $C0, $48, $59 ;the start of a copy of GNSITE, as bank 0 LEDB8-LEDD4
P0_9FEA:  .byte $24, $02, $8A, $3F, $49, $59, $49, $DD
P0_9FF2:  .byte $30, $C3, $FF, $98, $84, $1F, $FD, $00
P0_9FFA:  .byte $14, $D6, $73, $96, $74, $FF ;the last byte is $FF where GNSITE goes on with ANDA #$C0: the copy is cut off by the end of the page
