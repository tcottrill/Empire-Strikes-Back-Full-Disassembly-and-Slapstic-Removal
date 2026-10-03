;The Empire Strikes Back (Atari, 1985) - annotated disassembly of slapstic
;page 3 of $8000-$9FFF (MAME 'esb': the second half of 136031-106.2u).
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
P3_8000:  BITA P3_8000                ;arms the slapstic
P3_8003:  RTS
P3_8004:  BITA P3_8000
P3_8007:  RTS
P3_8008:  BITA P3_8000
P3_800B:  RTS
P3_800C:  BITA P3_8000
P3_800F:  RTS
P3_8010:  BITA P3_8000
P3_8013:  RTS
P3_8014:  BITA P3_8000
P3_8017:  RTS
P3_8018:  BITA P3_8000
P3_801B:  RTS
P3_801C:  BITA P3_8000
P3_801F:  RTS
P3_8020:  BITA P3_8000
P3_8023:  RTS
P3_8024:  BITA P3_8000
P3_8027:  RTS
P3_8028:  BITA P3_8000
P3_802B:  RTS
P3_802C:  BITA P3_8000
P3_802F:  RTS
P3_8030:  BITA P3_8000
P3_8033:  RTS
P3_8034:  BITA P3_8000
P3_8037:  RTS
P3_8038:  BITA P3_8000
P3_803B:  RTS
P3_803C:  BITA P3_8000
P3_803F:  RTS
P3_8040:  BITA P3_8000
P3_8043:  RTS
P3_8044:  BITA P3_8000
P3_8047:  RTS
P3_8048:  BITA P3_8000
P3_804B:  RTS
P3_804C:  BITA P3_8000
P3_804F:  RTS
P3_8050:  BITA P3_8000
P3_8053:  RTS
P3_8054:  BITA P3_8000
P3_8057:  RTS
P3_8058:  BITA P3_8000
P3_805B:  RTS
P3_805C:  BITA P3_8000
P3_805F:  RTS
P3_8060:  BITA P3_8000
P3_8063:  RTS
P3_8064:  BITA P3_8000
P3_8067:  RTS
P3_8068:  BITA P3_8000
P3_806B:  RTS
P3_806C:  BITA P3_8000
P3_806F:  RTS
P3_8070:  BITA P3_8000
P3_8073:  RTS
P3_8074:  BITA P3_8000
P3_8077:  RTS
P3_8078:  BITA P3_8000
P3_807B:  RTS
P3_807C:  BITA P3_8000
P3_807F:  RTS
P3_8080:  BITA P3_8000                ;arms the slapstic
P3_8083:  RTS
P3_8084:  BITA P3_8000
P3_8087:  RTS
P3_8088:  BITA P3_8000
P3_808B:  RTS
P3_808C:  BITA P3_8000
P3_808F:  RTS
P3_8090:  BITA P3_8000                ;arms the slapstic
P3_8093:  RTS
P3_8094:  BITA P3_8000
P3_8097:  RTS
P3_8098:  BITA P3_8000
P3_809B:  RTS
P3_809C:  BITA P3_8000
P3_809F:  RTS
P3_80A0:  BITA P3_8000                ;arms the slapstic
P3_80A3:  RTS
P3_80A4:  BITA P3_8000
P3_80A7:  RTS
P3_80A8:  BITA P3_8000
P3_80AB:  RTS
P3_80AC:  BITA P3_8000
P3_80AF:  RTS
P3_80B0:  BITA P3_8000                ;arms the slapstic
P3_80B3:  RTS
P3_80B4:  BITA P3_8000
P3_80B7:  RTS
P3_80B8:  BITA P3_8000
P3_80BB:  RTS
P3_80BC:  BITA P3_8000
P3_80BF:  RTS
P3_80C0:  BITA P3_8000
P3_80C3:  RTS
P3_80C4:  BITA P3_8000
P3_80C7:  RTS
P3_80C8:  BITA P3_8000
P3_80CB:  RTS
P3_80CC:  BITA P3_8000
P3_80CF:  RTS
P3_80D0:  BITA P3_8000
P3_80D3:  RTS
P3_80D4:  BITA P3_8000
P3_80D7:  RTS
P3_80D8:  BITA P3_8000
P3_80DB:  RTS
P3_80DC:  BITA P3_8000
P3_80DF:  RTS
P3_80E0:  BITA P3_8000
P3_80E3:  RTS
P3_80E4:  BITA P3_8000
P3_80E7:  RTS
P3_80E8:  BITA P3_8000
P3_80EB:  RTS
P3_80EC:  BITA P3_8000
P3_80EF:  RTS
P3_80F0:  BITA P3_8000
P3_80F3:  RTS
P3_80F4:  BITA P3_8000
P3_80F7:  RTS
P3_80F8:  BITA P3_8000
P3_80FB:  RTS
P3_80FC:  BITA P3_8000
P3_80FF:  RTS
P3_8100:  JSR  P3_8080                ;live: select page 0
P3_8103:  JMP  P3_8109                ;live
P3_8106:  JSR  P3_8080                ;decoy
P3_8109:  JSR  P3_8100                ;live
P3_810C:  JMP  P3_80B0                ;decoy
P3_810F:  JSR  P3_8106                ;decoy
P3_8112:  JSR  P3_810F                ;decoy
P3_8115:  JMP  CPU                    ;live: the routine
P3_8118:  JMP  P3_8080                ;live: select page 0
P3_811B:  JMP  P3_8090                ;live: select page 1
P3_811E:  JMP  P3_80A0                ;live: select page 2
P3_8121:  JSR  P3_811E                ;decoy
P3_8124:  JSR  P3_8121                ;decoy
P3_8127:  JSR  P3_8121                ;decoy
P3_812A:  JSR  P3_8090                ;live: select page 1
P3_812D:  JMP  P3_8133                ;live
P3_8130:  JSR  P3_8090                ;decoy
P3_8133:  JSR  P3_812A                ;live
P3_8136:  JMP  P3_80B0                ;decoy
P3_8139:  JSR  P3_8133                ;decoy
P3_813C:  JSR  P3_8136                ;decoy
P3_813F:  JSR  P3_8139                ;decoy
P3_8142:  JSR  P3_813F                ;decoy
P3_8145:  JMP  man_tie_setup          ;live: the routine
P3_8148:  JMP  P3_8080                ;live: select page 0
P3_814B:  JMP  P3_8090                ;live: select page 1
P3_814E:  JMP  P3_80A0                ;live: select page 2
P3_8151:  JSR  P3_8154                ;decoy
P3_8154:  JSR  P3_8090                ;live: select page 1
P3_8157:  JMP  P3_815D                ;live
P3_815A:  JSR  P3_8090                ;decoy
P3_815D:  JSR  P3_8154                ;live
P3_8160:  JMP  P3_80B0                ;decoy
P3_8163:  JSR  P3_815A                ;decoy
P3_8166:  JSR  P3_8169                ;decoy
P3_8169:  JSR  P3_8090                ;live: select page 1
P3_816C:  JMP  P3_8172                ;live
P3_816F:  JSR  P3_8090                ;decoy
P3_8172:  JSR  P3_8169                ;live
P3_8175:  JMP  P3_80B0                ;decoy
P3_8178:  JSR  P3_817B                ;decoy
P3_817B:  JSR  P3_8175                ;decoy
P3_817E:  JSR  P3_8181                ;decoy
P3_8181:  JSR  P3_817E                ;decoy
P3_8184:  JMP  lz_hit_walker          ;live: the routine
P3_8187:  JMP  P3_8080                ;live: select page 0
P3_818A:  JMP  P3_8090                ;live: select page 1
P3_818D:  JMP  P3_80A0                ;live: select page 2
P3_8190:  JSR  P3_8193                ;decoy
P3_8193:  JSR  P3_80A0                ;live: select page 2
P3_8196:  JMP  P3_819C                ;live
P3_8199:  JSR  P3_80A0                ;decoy
P3_819C:  JSR  P3_8193                ;live
P3_819F:  JMP  P3_80B0                ;decoy
P3_81A2:  JMP  P3_81A8                ;decoy
P3_81A5:  JSR  P3_81A2                ;decoy
P3_81A8:  JSR  P3_81A5                ;decoy
P3_81AB:  JMP  xmit_init              ;live: the routine
P3_81AE:  JMP  P3_8080                ;live: select page 0
P3_81B1:  JMP  P3_8090                ;live: select page 1
P3_81B4:  JMP  P3_80A0                ;live: select page 2
P3_81B7:  JMP  P3_81BD                ;decoy
P3_81BA:  JSR  P3_81B1                ;decoy
P3_81BD:  JSR  P3_81B7                ;decoy
P3_81C0:  JSR  P3_8090                ;live: select page 1
P3_81C3:  JSR  P3_8FF7                ;decoy
P3_81C6:  JMP  P3_80B0                ;decoy
P3_81C9:  JSR  P3_81C3                ;decoy
P3_81CC:  JSR  P3_81C6                ;decoy
P3_81CF:  JSR  P3_8090                ;live: select page 1
P3_81D2:  JMP  P3_81D8                ;live
P3_81D5:  JSR  P3_8090                ;decoy
P3_81D8:  JSR  P3_81CF                ;live
P3_81DB:  JMP  P3_80B0                ;decoy
P3_81DE:  JSR  P3_81D8                ;decoy
P3_81E1:  JSR  P3_8090                ;live: select page 1
P3_81E4:  JMP  P3_81EA                ;live
P3_81E7:  JSR  P3_8090                ;decoy
P3_81EA:  JSR  P3_81E1                ;live
P3_81ED:  JMP  P3_80B0                ;decoy
P3_81F0:  JSR  P3_81EA                ;decoy
P3_81F3:  JMP  P3_81F9                ;decoy
P3_81F6:  JSR  P3_81F3                ;decoy
P3_81F9:  JMP  SNVW                   ;live: the routine
P3_81FC:  JMP  P3_8080                ;live: select page 0
P3_81FF:  JMP  P3_8090                ;live: select page 1
P3_8202:  JMP  P3_80A0                ;live: select page 2
P3_8205:  JSR  P3_8208                ;decoy
P3_8208:  JSR  P3_8202                ;decoy
P3_820B:  JSR  P3_8208                ;decoy
P3_820E:  JSR  P3_8080                ;decoy
P3_8211:  JMP  P3_8217                ;decoy
P3_8214:  JSR  P3_8080                ;decoy
P3_8217:  JSR  P3_820E                ;decoy
P3_821A:  JMP  P3_80B0                ;decoy
P3_821D:  JSR  P3_8217                ;decoy
P3_8220:  JSR  P3_80A0                ;live: select page 2
P3_8223:  JSR  CPHTSA                 ;live: the routine
P3_8226:  JMP  P3_80B0                ;live: select page 3
P3_8229:  JSR  P3_822C                ;decoy
P3_822C:  JSR  P3_8090                ;live: select page 1
P3_822F:  JMP  P3_8235                ;live
P3_8232:  JSR  P3_8090                ;decoy
P3_8235:  JSR  P3_822C                ;live
P3_8238:  JMP  P3_80B0                ;decoy
P3_823B:  JSR  P3_8235                ;decoy
P3_823E:  JMP  P3_8244                ;decoy
P3_8241:  JSR  P3_823E                ;decoy
P3_8244:  JSR  P3_8080                ;live: select page 0
P3_8247:  JMP  P3_824D                ;live
P3_824A:  JSR  P3_8080                ;decoy
P3_824D:  JSR  P3_8244                ;live
P3_8250:  JMP  P3_80B0                ;decoy
P3_8253:  JSR  P3_824A                ;decoy
P3_8256:  JSR  P3_8259                ;decoy
P3_8259:  JSR  P3_80A0                ;live: select page 2
P3_825C:  JMP  P3_8262                ;live
P3_825F:  JSR  P3_80A0                ;decoy
P3_8262:  JSR  P3_8259                ;live
P3_8265:  JMP  P3_80B0                ;decoy
P3_8268:  JSR  P3_8262                ;decoy
P3_826B:  JSR  P3_8268                ;decoy
P3_826E:  JSR  P3_8271                ;decoy
P3_8271:  JSR  P3_8090                ;live: select page 1
P3_8274:  JMP  P3_827A                ;live
P3_8277:  JSR  P3_8090                ;decoy
P3_827A:  JSR  P3_8271                ;live
P3_827D:  JMP  P3_80B0                ;decoy
P3_8280:  JSR  P3_8283                ;decoy
P3_8283:  JSR  P3_8090                ;live: select page 1
P3_8286:  JMP  P3_828C                ;live
P3_8289:  JSR  P3_8090                ;decoy
P3_828C:  JSR  P3_8283                ;live
P3_828F:  JMP  P3_80B0                ;decoy
P3_8292:  JSR  P3_8295                ;decoy
P3_8295:  JSR  P3_8090                ;live: select page 1
P3_8298:  JSR  P3_9062+1              ;decoy
P3_829B:  JMP  P3_80B0                ;decoy
P3_829E:  JSR  P3_82A1                ;decoy
P3_82A1:  JMP  P3_82A7                ;decoy
P3_82A4:  JSR  P3_82A1                ;decoy
P3_82A7:  JMP  tie_wave_init          ;live: the routine
P3_82AA:  JMP  P3_8080                ;live: select page 0
P3_82AD:  JMP  P3_8090                ;live: select page 1
P3_82B0:  JMP  P3_80A0                ;live: select page 2
P3_82B3:  JSR  P3_82AD                ;decoy
P3_82B6:  JSR  P3_8080                ;decoy
P3_82B9:  JMP  P3_82BF                ;decoy
P3_82BC:  JSR  P3_8080                ;decoy
P3_82BF:  JSR  P3_82B6                ;decoy
P3_82C2:  JMP  P3_80B0                ;decoy
P3_82C5:  JMP  P3_82CB                ;decoy
P3_82C8:  JSR  P3_8090                ;live: select page 1
P3_82CB:  JMP  P3_82D1                ;live
P3_82CE:  JSR  P3_8090                ;decoy
P3_82D1:  JSR  P3_82C8                ;live
P3_82D4:  JMP  P3_80B0                ;decoy
P3_82D7:  JSR  P3_82DA                ;decoy
P3_82DA:  JSR  P3_82D7                ;decoy
P3_82DD:  JMP  P3_82E3                ;decoy
P3_82E0:  JSR  P3_82DD                ;decoy
P3_82E3:  JMP  CPURET                 ;live: the routine
P3_82E6:  JMP  P3_8080                ;live: select page 0
P3_82E9:  JMP  P3_8090                ;live: select page 1
P3_82EC:  JMP  P3_80A0                ;live: select page 2
P3_82EF:  JSR  P3_82E6                ;decoy
P3_82F2:  JSR  P3_82EC                ;decoy
P3_82F5:  JSR  P3_82F8                ;decoy
P3_82F8:  JSR  P3_8090                ;live: select page 1
P3_82FB:  JSR  xmit_hit               ;live: the routine
P3_82FE:  JMP  P3_80B0                ;live: select page 3
P3_8301:  JSR  P3_8304                ;decoy
P3_8304:  JSR  P3_8301                ;decoy
P3_8307:  JMP  TSTLAZ                 ;live: the routine
P3_830A:  JMP  P3_8080                ;live: select page 0
P3_830D:  JMP  P3_8090                ;live: select page 1
P3_8310:  JMP  P3_80A0                ;live: select page 2
P3_8313:  JMP  P3_8319                ;decoy
P3_8316:  JSR  P3_8313                ;decoy
P3_8319:  JMP  ADASHP                 ;live: the routine
P3_831C:  JMP  P3_8080                ;live: select page 0
P3_831F:  JMP  P3_8090                ;live: select page 1
P3_8322:  JMP  P3_80A0                ;live: select page 2
P3_8325:  JSR  P3_8328                ;decoy
P3_8328:  JSR  P3_832B                ;decoy
P3_832B:  JSR  P3_8080                ;live: select page 0
P3_832E:  JMP  P3_8334                ;live
P3_8331:  JSR  P3_8080                ;decoy
P3_8334:  JSR  P3_832B                ;live
P3_8337:  JMP  P3_80B0                ;decoy
P3_833A:  JSR  P3_8337                ;decoy
P3_833D:  JSR  P3_8337                ;decoy
P3_8340:  JMP  P3_8346                ;decoy
P3_8343:  JSR  P3_80A0                ;live: select page 2
P3_8346:  JMP  P3_834C                ;live
P3_8349:  JSR  P3_80A0                ;decoy
P3_834C:  JSR  P3_8343                ;live
P3_834F:  JMP  P3_80B0                ;decoy
P3_8352:  JSR  P3_8355                ;decoy
P3_8355:  JSR  P3_8352                ;decoy
P3_8358:  JMP  NWNSHP_P3              ;decoy
P3_835B:  JMP  P3_8080                ;decoy
P3_835E:  JMP  P3_8090                ;decoy
P3_8361:  JMP  P3_80A0                ;decoy
P3_8364:  JMP  P3_836A                ;decoy
P3_8367:  JSR  P3_8364                ;decoy
P3_836A:  JMP  CPU                    ;live: the routine
P3_836D:  JMP  P3_8080                ;live: select page 0
P3_8370:  JMP  P3_8090                ;live: select page 1
P3_8373:  JMP  P3_80A0                ;live: select page 2
P3_8376:  JSR  P3_8379                ;decoy
P3_8379:  JSR  P3_837C                ;decoy
P3_837C:  JSR  P3_80A0                ;live: select page 2
P3_837F:  JMP  P3_8385                ;live
P3_8382:  JSR  P3_80A0                ;decoy
P3_8385:  JSR  P3_837C                ;live
P3_8388:  JMP  P3_80B0                ;decoy
P3_838B:  JSR  P3_8385                ;decoy
P3_838E:  JSR  P3_8080                ;live: select page 0
P3_8391:  JMP  P3_8397                ;live
P3_8394:  JSR  P3_8080                ;decoy
P3_8397:  JSR  P3_838E                ;live
P3_839A:  JMP  P3_80B0                ;decoy
P3_839D:  JSR  P3_8397                ;decoy
P3_83A0:  JSR  P3_839D                ;decoy
P3_83A3:  JMP  xmit_launch            ;live: the routine
P3_83A6:  JMP  P3_8080                ;live: select page 0
P3_83A9:  JMP  P3_8090                ;live: select page 1
P3_83AC:  JMP  P3_80A0                ;live: select page 2
P3_83AF:  JSR  P3_83A9                ;decoy
P3_83B2:  JSR  P3_83B5                ;decoy
P3_83B5:  JSR  P3_8090                ;live: select page 1
P3_83B8:  JMP  P3_83BE                ;live
P3_83BB:  JSR  P3_8090                ;decoy
P3_83BE:  JSR  P3_83B5                ;live
P3_83C1:  JMP  P3_80B0                ;decoy
P3_83C4:  JSR  P3_83C1                ;decoy
P3_83C7:  JSR  P3_83C4                ;decoy
P3_83CA:  JMP  xmit_init              ;live: the routine
P3_83CD:  JMP  P3_8080                ;live: select page 0
P3_83D0:  JMP  P3_8090                ;live: select page 1
P3_83D3:  JMP  P3_80A0                ;live: select page 2
P3_83D6:  JSR  P3_83D0                ;decoy
P3_83D9:  JMP  P3_83DF                ;decoy
P3_83DC:  JSR  P3_8080                ;live: select page 0
P3_83DF:  JMP  P3_83E5                ;live
P3_83E2:  JSR  P3_8080                ;decoy
P3_83E5:  JSR  P3_83DC                ;live
P3_83E8:  JMP  P3_80B0                ;decoy
P3_83EB:  JSR  P3_83E5                ;decoy
P3_83EE:  JSR  P3_83EB                ;decoy
P3_83F1:  JMP  lz_hit_probot          ;live: the routine
P3_83F4:  JMP  P3_8080                ;live: select page 0
P3_83F7:  JMP  P3_8090                ;live: select page 1
P3_83FA:  JMP  P3_80A0                ;live: select page 2
P3_83FD:  JSR  P3_8400                ;decoy
P3_8400:  JSR  P3_8090                ;live: select page 1
P3_8403:  JMP  P3_8409                ;live
P3_8406:  JSR  P3_8090                ;decoy
P3_8409:  JSR  P3_8400                ;live
P3_840C:  JMP  P3_80B0                ;decoy
P3_840F:  JSR  P3_8409                ;decoy
P3_8412:  JSR  P3_840F                ;decoy
P3_8415:  JSR  P3_840F                ;decoy
P3_8418:  JSR  P3_80A0                ;live: select page 2
P3_841B:  JMP  P3_8421                ;live
P3_841E:  JSR  P3_80A0                ;decoy
P3_8421:  JSR  P3_8418                ;live
P3_8424:  JMP  P3_80B0                ;decoy
P3_8427:  JSR  P3_8424                ;decoy
P3_842A:  JSR  P3_8090                ;live: select page 1
P3_842D:  JMP  P3_8433                ;live
P3_8430:  JSR  P3_8090                ;decoy
P3_8433:  JSR  P3_842A                ;live
P3_8436:  JMP  P3_80B0                ;decoy
P3_8439:  JSR  P3_8430                ;decoy
P3_843C:  JSR  P3_8439                ;decoy
P3_843F:  JMP  xmit_move_all          ;live: the routine
P3_8442:  JMP  P3_8080                ;live: select page 0
P3_8445:  JMP  P3_8090                ;live: select page 1
P3_8448:  JMP  P3_80A0                ;live: select page 2
P3_844B:  JSR  P3_844E                ;decoy
P3_844E:  JMP  P3_8454                ;decoy
P3_8451:  JSR  P3_80A0                ;live: select page 2
P3_8454:  JMP  P3_845A                ;live
P3_8457:  JSR  P3_80A0                ;decoy
P3_845A:  JSR  P3_8451                ;live
P3_845D:  JMP  P3_80B0                ;decoy
P3_8460:  JSR  P3_8463                ;decoy
P3_8463:  JSR  P3_8460                ;decoy
P3_8466:  JMP  xmit_view_all          ;live: the routine
P3_8469:  JMP  P3_8080                ;live: select page 0
P3_846C:  JMP  P3_8090                ;live: select page 1
P3_846F:  JMP  P3_80A0                ;live: select page 2
P3_8472:  JSR  P3_846C                ;decoy
P3_8475:  JSR  P3_8478                ;decoy
P3_8478:  JSR  P3_846F                ;decoy
P3_847B:  JSR  P3_8080                ;live: select page 0
P3_847E:  JMP  P3_8484                ;live
P3_8481:  JSR  P3_8080                ;decoy
P3_8484:  JSR  P3_847B                ;live
P3_8487:  JMP  P3_80B0                ;decoy
P3_848A:  JSR  P3_8487                ;decoy
P3_848D:  JSR  P3_8487                ;decoy
P3_8490:  JMP  P3_8496                ;decoy
P3_8493:  JSR  P3_8490                ;decoy
P3_8496:  JMP  SNVW                   ;live: the routine
P3_8499:  JMP  P3_8080                ;live: select page 0
P3_849C:  JMP  P3_8090                ;live: select page 1
P3_849F:  JMP  P3_80A0                ;live: select page 2
P3_84A2:  JSR  P3_8499                ;decoy
P3_84A5:  JSR  P3_80A0                ;live: select page 2
P3_84A8:  JMP  P3_84AE                ;live
P3_84AB:  JSR  P3_80A0                ;decoy
P3_84AE:  JSR  P3_84A5                ;live
P3_84B1:  JMP  P3_80B0                ;decoy
P3_84B4:  JSR  P3_84B1                ;decoy
P3_84B7:  JSR  P3_84B4                ;decoy
P3_84BA:  JMP  lz_hit_space           ;live: the routine
P3_84BD:  JMP  P3_8080                ;live: select page 0
P3_84C0:  JMP  P3_8090                ;live: select page 1
P3_84C3:  JMP  P3_80A0                ;live: select page 2
P3_84C6:  JSR  P3_84BD                ;decoy
P3_84C9:  JSR  P3_8090                ;live: select page 1
P3_84CC:  JMP  P3_84D2                ;live
P3_84CF:  JSR  P3_8090                ;decoy
P3_84D2:  JSR  P3_84C9                ;live
P3_84D5:  JMP  P3_80B0                ;decoy
P3_84D8:  JSR  P3_84DB                ;decoy
P3_84DB:  JSR  P3_80A0                ;live: select page 2
P3_84DE:  JMP  P3_84E4                ;live
P3_84E1:  JSR  P3_80A0                ;decoy
P3_84E4:  JSR  P3_84DB                ;live
P3_84E7:  JMP  P3_80B0                ;decoy
P3_84EA:  JSR  P3_84E7                ;decoy
P3_84ED:  JSR  P3_84E4                ;decoy
P3_84F0:  JSR  P3_8090                ;live: select page 1
P3_84F3:  JSR  P3_8F8A+1              ;decoy
P3_84F6:  JMP  P3_80B0                ;decoy
P3_84F9:  JSR  P3_84F0                ;decoy
P3_84FC:  JSR  P3_8080                ;live: select page 0
P3_84FF:  JMP  P3_8505                ;live
P3_8502:  JSR  P3_8080                ;decoy
P3_8505:  JSR  P3_84FC                ;live
P3_8508:  JMP  P3_80B0                ;decoy
P3_850B:  JSR  P3_8508                ;decoy
P3_850E:  JSR  P3_8505                ;decoy
P3_8511:  JSR  P3_8090                ;live: select page 1
P3_8514:  JMP  P3_851A                ;live
P3_8517:  JSR  P3_8090                ;decoy
P3_851A:  JSR  P3_8511                ;live
P3_851D:  JMP  P3_80B0                ;decoy
P3_8520:  JSR  P3_8517                ;decoy
P3_8523:  JSR  P3_80A0                ;live: select page 2
P3_8526:  JMP  P3_852C                ;live
P3_8529:  JSR  P3_80A0                ;decoy
P3_852C:  JSR  P3_8523                ;live
P3_852F:  JMP  P3_80B0                ;decoy
P3_8532:  JSR  P3_8529                ;decoy
P3_8535:  JSR  P3_8080                ;live: select page 0
P3_8538:  JMP  P3_853E                ;live
P3_853B:  JSR  P3_8080                ;decoy
P3_853E:  JSR  P3_8535                ;live
P3_8541:  JMP  P3_80B0                ;decoy
P3_8544:  JSR  P3_853B                ;decoy
P3_8547:  JSR  P3_853E                ;decoy
P3_854A:  JSR  P3_8547                ;decoy
P3_854D:  JSR  P3_8090                ;live: select page 1
P3_8550:  JMP  P3_8556                ;live
P3_8553:  JSR  P3_8090                ;decoy
P3_8556:  JSR  P3_854D                ;live
P3_8559:  JMP  P3_80B0                ;decoy
P3_855C:  JSR  P3_8556                ;decoy
P3_855F:  JSR  P3_8562                ;decoy
P3_8562:  JSR  P3_855F                ;decoy
P3_8565:  JMP  view_lazars            ;live: the routine
P3_8568:  JMP  P3_8080                ;live: select page 0
P3_856B:  JMP  P3_8090                ;live: select page 1
P3_856E:  JMP  P3_80A0                ;live: select page 2
P3_8571:  JMP  P3_8577                ;decoy
P3_8574:  JSR  P3_856E                ;decoy
P3_8577:  JMP  P3_857D                ;decoy
P3_857A:  JSR  P3_8090                ;live: select page 1
P3_857D:  JSR  TBG1D2_P3+5            ;decoy
P3_8580:  JMP  P3_80B0                ;decoy
P3_8583:  JSR  P3_8580                ;decoy
P3_8586:  JMP  P3_858C                ;decoy
P3_8589:  JSR  P3_8090                ;live: select page 1
P3_858C:  JMP  P3_8592                ;live
P3_858F:  JSR  P3_8090                ;decoy
P3_8592:  JSR  P3_8589                ;live
P3_8595:  JMP  P3_80B0                ;decoy
P3_8598:  JSR  P3_858F                ;decoy
P3_859B:  JSR  P3_80A0                ;live: select page 2
P3_859E:  JMP  P3_85A4                ;live
P3_85A1:  JSR  P3_80A0                ;decoy
P3_85A4:  JSR  P3_859B                ;live
P3_85A7:  JMP  P3_80B0                ;decoy
P3_85AA:  JMP  P3_85B0                ;decoy
P3_85AD:  JSR  P3_85A4                ;decoy
P3_85B0:  JSR  P3_8080                ;decoy
P3_85B3:  JMP  P3_85B9                ;decoy
P3_85B6:  JSR  P3_8080                ;decoy
P3_85B9:  JSR  P3_85B0                ;decoy
P3_85BC:  JMP  P3_80B0                ;decoy
P3_85BF:  JMP  P3_85C5                ;decoy
P3_85C2:  JSR  P3_85BF                ;decoy
P3_85C5:  JSR  P3_8090                ;live: select page 1
P3_85C8:  JMP  P3_85CE                ;live
P3_85CB:  JSR  P3_8090                ;decoy
P3_85CE:  JSR  P3_85C5                ;live
P3_85D1:  JMP  P3_80B0                ;decoy
P3_85D4:  JSR  P3_85D7                ;decoy
P3_85D7:  JSR  P3_8090                ;live: select page 1
P3_85DA:  JMP  P3_85E0                ;live
P3_85DD:  JSR  P3_8090                ;decoy
P3_85E0:  JSR  P3_85D7                ;live
P3_85E3:  JMP  P3_80B0                ;decoy
P3_85E6:  JMP  tie_wave_init          ;decoy
P3_85E9:  JSR  P3_85E6                ;decoy

;------------------------------------------------------------------------------
; tie_wave_init - page 3 half of the set-up of the TIE fighter part (wave3_setup, phase $47), made from the
;   alien loop of Star Wars' IPGEN: starts at level 0 of the wave set (WV_LVL), gives each of the three alien
;   records its unit vector block (M_AL on, $20 apart) and block index (MS_ALBC on, 4 apart), marks it dead and
;   sets its fire delay (byte 4, ESB's addition to the record) to 8. NWNSHP_P3 then makes the first ships
;------------------------------------------------------------------------------
tie_wave_init:
P3_85EC:  LDA  #$00
P3_85EE:  STA  WV_LVL                 ;start at level 0 of the wave set (the Star Wars line set the star brightness)
P3_85F0:  LDX  #ALIEN
P3_85F3:  LDU  #M_AL
P3_85F6:  LDB  #MS_ALBC
P3_85F8:  LDA  #$08                   ;8 frames before the ship may fire
P3_85FA:  STA  4,X                    ;byte 4 of the record, ESB's addition: the fire delay
P3_85FC:  CLR  3,X                    ;type 0: no ship in this record

IPGEN_30:
P3_85FE:  STU  ,X
P3_8600:  STB  AS_BIC,X
P3_8602:  LEAU $20,U
P3_8605:  ADDB #$04
P3_8607:  LEAX AS_IZE,X
P3_860A:  CMPX #ALIENZ
P3_860D:  BLO  P3_85F8
P3_860F:  JSR  NWNSHP_P3              ;make the first ships of the part
P3_8612:  RTS

;------------------------------------------------------------------------------
; man_tie_setup - set-up for the TIE fighter pages of the training manual, called by man_init_tie (which passes
;   the page number in B, not used here): initialises the three alien records as tie_wave_init does, then makes
;   the first one a live TIE fighter by hand, the way NWASHP does - unit vectors facing the player, placed at x
;   $1000, y 0, z 0, 1 hit, the choreography man_tie_chor, which keeps it in place while it yaws, pitches and
;   rolls, and object 0 loaded through bank 1 KD868
;------------------------------------------------------------------------------
man_tie_setup:
P3_8613:  LDX  #ALIEN
P3_8616:  LDU  #M_AL
P3_8619:  LDB  #$1C                   ;MS_ALBC, the first alien's block index
P3_861B:  LDA  #$08
P3_861D:  STA  4,X                    ;fire delay
P3_861F:  CLR  3,X                    ;no ship
P3_8621:  STU  ,X
P3_8623:  STB  AS_BIC,X
P3_8625:  LEAU $20,U
P3_8628:  ADDB #$04
P3_862A:  LEAX AS_IZE,X
P3_862D:  CMPX #ALIENZ
P3_8630:  BLO  P3_861B
P3_8632:  LDX  #ALIEN                 ;the first record becomes the manual's one TIE fighter
P3_8635:  LDA  #$01
P3_8637:  STA  AS_TYP,X               ;LIVE ALIEN
P3_8639:  LDU  ,X
P3_863B:  JSR  UNITV
P3_863E:  LDU  ,X
P3_8640:  LDA  #$C0                   ;FACE ALIEN TOWARDS PLAYER
P3_8642:  STA  MS_AX,U
P3_8644:  STA  MS_BY,U
P3_8646:  LDD  #$1000                 ;universe position: x $1000
P3_8649:  STD  8,U
P3_864B:  LDD  #$0000                 ;y 0
P3_864E:  STD  10,U
P3_8650:  LDD  #$0000                 ;z 0
P3_8653:  STD  12,U
P3_8655:  CLRA
P3_8656:  STA  10,X                   ;forced roll, damage count, glow, dying and target bytes cleared
P3_8658:  STA  9,X
P3_865A:  STA  7,X
P3_865C:  STA  6,X
P3_865E:  STA  12,X
P3_8660:  LDA  #$01                   ;one hit destroys it
P3_8662:  STA  8,X
P3_8664:  LDD  #man_tie_chor          ;its choreography: man_tie_chor
P3_8667:  STD  13,X
P3_8669:  JSR  NWCHOR
P3_866C:  LDB  #$00                   ;picture: object 0, the TIE fighter
P3_866E:  STB  5,X
P3_8670:  JSR  L60A8                  ;bank 1 KD868: load the object's points, as Star Wars' ADBOBJ
P3_8673:  RTS

;------------------------------------------------------------------------------
; SNVW - SNVW VIEW ALIEN SHIP
;------------------------------------------------------------------------------
SNVW:
P3_8674:  LDX  #ALIEN                 ;SHIP PARAMS

SNVW_10:          ;---LOOP THRU SHIPS
P3_8677:  STX  S2_PRM
P3_8679:  LDA  AS_TYP,X
P3_867B:  BEQ  SNVW_90                ;?SOMEWHAT ALIVE?
P3_867D:  JSR  S2VW                   ;VIEW THE SHIP

SNVW_90:
P3_8680:  LDX  S2_PRM                 ;NEXT SHIP
P3_8682:  LEAX AS_IZE,X
P3_8685:  CMPX #ALIENZ
P3_8688:  BLO  SNVW_10

RTS1:
SNVW_96:
P3_868A:  RTS

;------------------------------------------------------------------------------
; S2VW - VIEW THE SHIP  (comment at the call)
;   in ESB: the Darth Vader speeches are gone and the ship is drawn through bank 1 (BJCNTR, JOBJBPNT, KDA2C,
;   KD8AC). the record fields from the picture number on are one byte further on than in Star Wars
;------------------------------------------------------------------------------
S2VW:
P3_868B:  LDX  S2_PRM
P3_868D:  CLRA
P3_868E:  LDB  AS_BIC,X
P3_8690:  ADDB #$03
P3_8692:  STD  M_BIC
P3_8695:  LDA  #MS_PSB2
P3_8697:  JSR  MGOWT
P3_869A:  LDA  M_XP
P3_869D:  LSLA                        ;-4000<X<4000 FOR VALID SQUARING
P3_869E:  BVS  S2VW_12
P3_86A0:  LDA  M_YP
P3_86A3:  LSLA
P3_86A4:  BVS  S2VW_12
P3_86A6:  LDA  M_ZP
P3_86A9:  LSLA
P3_86AA:  BVS  S2VW_12
P3_86AC:  LDD  M_XPS                  ;CHECK FOR COLLISION
P3_86AF:  ADDD M_YPS
P3_86B2:  ADDD M_ZPS
P3_86B5:  TFR  D,U

S2VW_114:
P3_86B7:  CMPU #$0900
P3_86BB:  BHI  P3_86C5                ;IFLS  ?PLAYER AT MIDDISTANCE?
P3_86BD:  LDD  AS_CHST,X
P3_86C0:  ORA  #((CS_PM&$FF00)/$100)  ;CHSET C$PM  THEN SET PLAYER MIDDLE DISTANCE
P3_86C2:  STD  AS_CHST,X
P3_86C5:  CMPU #$0100
P3_86C9:  BHI  P3_86D3                ;IFLS  ?PLAYER NEARBY?
P3_86CB:  LDD  AS_CHST,X
P3_86CE:  ORA  #((CS_PN&$FF00)/$100)  ;CHSET C$PN  THEN SET PLAYER NEAR
P3_86D0:  STD  AS_CHST,X
P3_86D3:  CMPU #$00A0
P3_86D7:  BHI  P3_8709                ;IFLS  ?PLAYER NEARBY?
P3_86D9:  LDA  Q_PBB
P3_86DC:  BNE  P3_86EE                ;IFEQ  ?NO SHIP CURRENTLY PASSING BY?
P3_86DE:  LDA  AS_BIC,X
P3_86E0:  STA  Q_PBB                  ;THEN START THIS SHIP PASSING BY
P3_86E3:  JSR  spk_cmd_06
P3_86E6:  JSR  aud_cmd_35
P3_86E9:  STU  Q_PBD                  ;INIT CURRENT DISTANCE
P3_86EC:  BRA  P3_8707                ;ELSE  ELSE IS BIC OF SHIP IS PASSING BY
P3_86EE:  CMPA AS_BIC,X
P3_86F0:  BNE  P3_8707                ;IFEQ  ?IS THIS THE SHIP CURRENTLY PASSINGBY?
P3_86F2:  CMPU Q_PBD                  ;THEN CHECK FOR CHANGES IN DISTANCE AWAY
P3_86F6:  BGT  P3_86FD                ;IFLE  ?NOT MOVING AWAY YET? NOTE SIGNED FLAG TEST
P3_86F8:  STU  Q_PBD                  ;THEN SAVE THIS LATEST DISTANCE
P3_86FB:  BRA  P3_8707                ;ELSE  ELSE IS DEFINITLY MOVING AWAY
P3_86FD:  BLO  P3_8707                ;IFHS  ?MINUS FLAG STILL CLEAR? ONE TIME ONLY
P3_86FF:  LDA  #$FF
P3_8701:  STA  Q_PBD                  ;SET DISTANCE TO MINUS, END PASSBY FLAG
P3_8704:  JSR  aud_cmd_39
P3_8707:  BRA  S2VW_12                ;ELSE  ELSE NOT NEAR TO PLAYER
P3_8709:  LDA  AS_BIC,X
P3_870B:  CMPA Q_PBB
P3_870E:  BNE  S2VW_12                ;IFEQ  ?WAS THIS THE SHIP DOING A PASSBY?
P3_8710:  CLR  Q_PBB                  ;THEN PREPARE FOR NEXT SHIP

S2VW_12:
P3_8713:  LDD  M_XP
P3_8716:  CMPD #$0010
P3_871A:  LBLE RTS1
P3_871E:  CMPD #$7F00
P3_8722:  LBHI RTS1

S2VW_19:          ;----SAVE NEW X
P3_8726:  STD  M_DVD
P3_8729:  STD  M_XT
P3_872C:  LDD  M_YP
P3_872F:  STD  M_YT
P3_8732:  LDD  M_YPS
P3_8735:  SUBD M_XPS                  ;X SQUARED
P3_8738:  LBHS RTS1                   ;B OUT OF VIEW

S2VW_28:
P3_873C:  LDD  M_ZP
P3_873F:  STD  M_ZT
P3_8742:  LDD  M_ZPS
P3_8745:  SUBD M_XPS                  ;X SQUARED
P3_8748:  LBHS RTS1

S2VW_31:
P3_874C:  LDX  S2_PRM
P3_874E:  LDD  AS_CHST,X
P3_8751:  ORA  #((CS_PV&$FF00)/$100)  ;CHSET C$PV  WITHIN PLAYERS VIEW SCREEN
P3_8753:  STD  AS_CHST,X
P3_8756:  LDA  AS_BIC,X
P3_8758:  JSR  IS2UV                  ;DOWNLOAD SHIP 2 UNIT VECTORS
P3_875B:  JSR  L60B4                  ;bank 1 BJCNTR: blank vector to the ship's centre
P3_875E:  LDD  #$0050                 ;JUST TRY IT -- SHUT DOWN CPU AND TEST
P3_8761:  STD  M_YP                   ;GET SHIP SIZE
P3_8764:  LDA  #MS_PERS
P3_8766:  JSR  MGOWT
P3_8769:  LDD  M_YP
P3_876C:  ADDD #$000A                 ;ADDIN CURSOR SIZE
P3_876F:  STD  TMPSIZ_4801
P3_8771:  LDD  >BJ_CX
P3_8774:  SUBD >LZ_CX
P3_8777:  BPL  P3_877D                ;IFMI
P3_8779:  COMA                        ;NEGD  ABSD
P3_877A:  NEGB
P3_877B:  SBCA #$FF
P3_877D:  STD  TMPXD                  ;SAVE X DISTANCE
P3_877F:  STD  TMPOCT_4803            ;PREPARE FOR OCTAGON COLLISION DETECT
P3_8781:  LDD  >BJ_CY
P3_8784:  SUBD >LZ_CY
P3_8787:  BPL  P3_878D                ;IFMI
P3_8789:  COMA                        ;NEGD
P3_878A:  NEGB
P3_878B:  SBCA #$FF
P3_878D:  STD  TMPYD                  ;SAVE Y DISTANCE
P3_878F:  ADDD TMPOCT_4803
P3_8791:  STD  TMPOCT_4803            ;OCTAGON CHECK
P3_8793:  LDD  TMPXD
P3_8795:  SUBD TMPSIZ_4801
P3_8797:  BGT  P3_87B7                ;IFLE  LE FOR LIBERALITY
P3_8799:  LDD  TMPYD
P3_879B:  SUBD TMPSIZ_4801
P3_879D:  BGT  P3_87B7                ;IFLE  ?WITHIN Y ALSO?
P3_879F:  LDD  TMPSIZ_4801
P3_87A1:  LSRA                        ;LSRD
P3_87A2:  RORB
P3_87A3:  ADDD TMPSIZ_4801            ;MAKE 1.5 FOR OCTAGON
P3_87A5:  SUBD TMPOCT_4803
P3_87A7:  BLT  P3_87B7                ;IFGE  ?ALSO WITHIN OCTAGON?
P3_87A9:  LDD  M_XT                   ;THEN SEE IF WE ARE THE CLOSEST ALIEN
P3_87AC:  CMPD CL_ADS                 ;SHIP DISTANCE
P3_87AF:  BHS  P3_87B7                ;IFLO  ?ALSO THE NEAREST SHIP SO FAR?
P3_87B1:  STD  CL_ADS                 ;REMEMBER ITS DISTANCE
P3_87B3:  LDX  S2_PRM                 ;THEN WE GOT A HIT
P3_87B5:  STX  CL_AP                  ;RECORD WHO WE ARE
P3_87B7:  LDD  TMPSIZ_4801            ;?AIM IS NEARING ALIEN?
P3_87B9:  ADDD TMPSIZ_4801
P3_87BB:  ADDD TMPSIZ_4801            ;ALLOW LARGER WARNING AREA
P3_87BD:  SUBD TMPOCT_4803
P3_87BF:  BLO  S2VW_86                ;IFHS
P3_87C1:  LDX  S2_PRM
P3_87C3:  LDA  AS_TYP,X
P3_87C5:  CMPA #$01
P3_87C7:  BNE  S2VW_86                ;?ALIVE?
P3_87C9:  LDD  AS_CHST,X
P3_87CC:  ORA  #((CS_PS&$FF00)/$100)  ;CHSET C$PS  STATUS: ALIEN IN PLAYER SITES
P3_87CE:  STD  AS_CHST,X

;SET BRITENESS
;ELSE HANDLE GLOW
S2VW_86:
P3_87D1:  LDX  S2_PRM
P3_87D3:  LDB  7,X                    ;glow timer, byte 7 of ESB's record (Star Wars AS_GLW)
P3_87D5:  LDU  #TVWCL                 ;GET GLOW COLORS
P3_87D8:  LSLB
P3_87D9:  LDD  B,U
P3_87DB:  STD  ,Y++

S2VW_55:
P3_87DD:  LDA  #MS_CNCT
P3_87DF:  JSR  MGOWT
P3_87E2:  LDB  5,X                    ;picture number, byte 5 (Star Wars AS_PIC)
P3_87E4:  JSR  L60D2                  ;bank 1 JOBJBPNT: perspect the object's points
P3_87E7:  JSR  L60E4                  ;bank 1 KDA2C: draw the object
P3_87EA:  JSR  L60BA                  ;bank 1 KD8AC: back to the screen centre
P3_87ED:  RTS

TVWCL:          ;VIEW SHIP COLOR BRITE IF HIT
P3_87EE:  .word (VGCOPC&$F000)+(($82&$F)*$100)+($82&$F0) ;TVWBYT 082,037,82,37,82,47,82,47
P3_87F0:  .word (VGCOPC&$F000)+(($37&$F)*$100)+($37&$F0)
P3_87F2:  .word (VGCOPC&$F000)+(($82&$F)*$100)+($82&$F0)
P3_87F4:  .word (VGCOPC&$F000)+(($37&$F)*$100)+($37&$F0)
P3_87F6:  .word (VGCOPC&$F000)+(($82&$F)*$100)+($82&$F0)
P3_87F8:  .word (VGCOPC&$F000)+(($47&$F)*$100)+($47&$F0)
P3_87FA:  .word (VGCOPC&$F000)+(($82&$F)*$100)+($82&$F0)
P3_87FC:  .word (VGCOPC&$F000)+(($47&$F)*$100)+($47&$F0)
P3_87FE:  .word (VGCOPC&$F000)+(($82&$F)*$100)+($82&$F0) ;TVWBYT 082,057,82,057,082,067,082,067
P3_8800:  .word (VGCOPC&$F000)+(($57&$F)*$100)+($57&$F0)
P3_8802:  .word (VGCOPC&$F000)+(($82&$F)*$100)+($82&$F0)
P3_8804:  .word (VGCOPC&$F000)+(($57&$F)*$100)+($57&$F0)
P3_8806:  .word (VGCOPC&$F000)+(($82&$F)*$100)+($82&$F0)
P3_8808:  .word (VGCOPC&$F000)+(($67&$F)*$100)+($67&$F0)
P3_880A:  .word (VGCOPC&$F000)+(($82&$F)*$100)+($82&$F0)
P3_880C:  .word (VGCOPC&$F000)+(($67&$F)*$100)+($67&$F0)
P3_880E:  .word (VGCOPC&$F000)+(($82&$F)*$100)+($82&$F0) ;TVWBYT 082,077,082,077,082,087,082,087
P3_8810:  .word (VGCOPC&$F000)+(($77&$F)*$100)+($77&$F0)
P3_8812:  .word (VGCOPC&$F000)+(($82&$F)*$100)+($82&$F0)
P3_8814:  .word (VGCOPC&$F000)+(($77&$F)*$100)+($77&$F0)
P3_8816:  .word (VGCOPC&$F000)+(($82&$F)*$100)+($82&$F0)
P3_8818:  .word (VGCOPC&$F000)+(($87&$F)*$100)+($87&$F0)
P3_881A:  .word (VGCOPC&$F000)+(($82&$F)*$100)+($82&$F0)
P3_881C:  .word (VGCOPC&$F000)+(($87&$F)*$100)+($87&$F0)
P3_881E:  .word (VGCOPC&$F000)+(($82&$F)*$100)+($82&$F0) ;TVWBYT 082,087,082,087,082,087,0C7,0C7
P3_8820:  .word (VGCOPC&$F000)+(($87&$F)*$100)+($87&$F0)
P3_8822:  .word (VGCOPC&$F000)+(($82&$F)*$100)+($82&$F0)
P3_8824:  .word (VGCOPC&$F000)+(($87&$F)*$100)+($87&$F0)
P3_8826:  .word (VGCOPC&$F000)+(($82&$F)*$100)+($82&$F0)
P3_8828:  .word (VGCOPC&$F000)+(($87&$F)*$100)+($87&$F0)
P3_882A:  .word (VGCOPC&$F000)+(($C7&$F)*$100)+($C7&$F0)
P3_882C:  .word (VGCOPC&$F000)+(($C7&$F)*$100)+($C7&$F0)

;------------------------------------------------------------------------------
; SNPTU - PITCH UP
;   ALIEN USAGE ONLY
;------------------------------------------------------------------------------
SNPTU:
P3_882E:  JSR  SNPOS
P3_8831:  INC  CP_PT
P3_8833:  JMP  SNPT

;------------------------------------------------------------------------------
; SNPTD - PITCH DOWN
;------------------------------------------------------------------------------
SNPTD:
P3_8836:  JSR  SNNEG
P3_8839:  DEC  CP_PT
P3_883B:  JMP  SNPT

;------------------------------------------------------------------------------
; SNRLL - ROLL LEFT
;------------------------------------------------------------------------------
SNRLL:
P3_883E:  JSR  SNNEG
P3_8841:  DEC  CP_RL
P3_8843:  JMP  SNRL

;------------------------------------------------------------------------------
; SNRLR - ROLL RIGHT
;------------------------------------------------------------------------------
SNRLR:
P3_8846:  JSR  SNPOS
P3_8849:  INC  CP_RL
P3_884B:  JMP  SNRL

;------------------------------------------------------------------------------
; SNYWL - YAW LEFT
;------------------------------------------------------------------------------
SNYWL:
P3_884E:  JSR  SNPOS
P3_8851:  DEC  CP_YW
P3_8853:  JMP  SNYW

;------------------------------------------------------------------------------
; SNYWR - YAW RIGHT
;------------------------------------------------------------------------------
SNYWR:
P3_8856:  JSR  SNNEG
P3_8859:  INC  CP_YW
P3_885B:  JMP  SNYW

;------------------------------------------------------------------------------
; SNPOS - POSITIVE ANGLES FOR CPU
;------------------------------------------------------------------------------
SNPOS:
P3_885E:  LDA  #$14
P3_8860:  LDU  #TSNGLE
P3_8863:  LEAU A,U
P3_8865:  LDD  ,U
P3_8867:  STD  M_SIN
P3_886A:  LDD  2,U
P3_886C:  STD  M_COS
P3_886F:  RTS

;------------------------------------------------------------------------------
; SNNEG - [note] Negative angles for CPU: M_SIN = minus the sine and M_COS = the cosine of the TSNGLE entry at offset $14
;------------------------------------------------------------------------------
SNNEG:
P3_8870:  LDA  #$14
P3_8872:  LDU  #TSNGLE                ;8 ENTRIES, DOUBLEWORD EACH
P3_8875:  LEAU A,U
P3_8877:  LDD  #$0000
P3_887A:  SUBD ,U
P3_887C:  STD  M_SIN
P3_887F:  LDD  2,U
P3_8881:  STD  M_COS
P3_8884:  RTS

TSNGLE:          ;CPU ANGLES
P3_8885:  .word $00B5, $3FFF          ;.63
P3_8889:  .word $0100, $3FFE          ;.90
P3_888D:  .word $016A, $3FFC          ;1.27
P3_8891:  .word $021F, $3FF7          ;1.90
P3_8895:  .word $03DF, $3FE2          ;3.47
P3_8899:  .word $04FF, $3FCE          ;4.48
P3_889D:  .word $0590, $3FC2          ;4.99
P3_88A1:  .word $0590, $3FC2          ;4.99

;------------------------------------------------------------------------------
; SNRL - ROLL ALIEN SHIP
;------------------------------------------------------------------------------
SNRL:
P3_88A5:  CLRA
P3_88A6:  LDB  AS_BIC,X
P3_88A8:  STD  M_BIC
P3_88AB:  LDA  #MS_ROLL
P3_88AD:  JMP  MGOWT

;------------------------------------------------------------------------------
; SNPT - PITCH ALIEN SHIP
;------------------------------------------------------------------------------
SNPT:
P3_88B0:  CLRA
P3_88B1:  LDB  AS_BIC,X
P3_88B3:  STD  M_BIC
P3_88B6:  LDA  #MS_PTCH
P3_88B8:  JMP  MGOWT

;------------------------------------------------------------------------------
; SNYW - YAW ALIEN SHIP
;------------------------------------------------------------------------------
SNYW:
P3_88BB:  CLRA
P3_88BC:  LDB  AS_BIC,X
P3_88BE:  STD  M_BIC
P3_88C1:  LDA  #MS_YAW
P3_88C3:  JMP  MGOWT

;------------------------------------------------------------------------------
; SNMVF2 - MOVE FORWARD TWICE AS FAST
;------------------------------------------------------------------------------
SNMVF2:
P3_88C6:  LDD  MS_AX,U                ;X VECTOR
P3_88C8:  JSR  ASRD5_B0
P3_88CB:  ADDD MS_VX,U
P3_88CD:  STD  MS_VX,U
P3_88CF:  LDD  MS_BX,U
P3_88D1:  JSR  ASRD5_B0
P3_88D4:  ADDD MS_VY,U
P3_88D6:  STD  MS_VY,U
P3_88D8:  LDD  ,U
P3_88DA:  JSR  ASRD5_B0
P3_88DD:  ADDD MS_VZ,U
P3_88DF:  STD  MS_VZ,U
P3_88E1:  RTS

;------------------------------------------------------------------------------
; SNMVF - MOVE FORWARD
;------------------------------------------------------------------------------
SNMVF:
P3_88E2:  LDD  MS_AX,U                ;X VECTOR
P3_88E4:  JSR  ASRD6
P3_88E7:  ADDD MS_VX,U
P3_88E9:  STD  MS_VX,U
P3_88EB:  LDD  MS_BX,U
P3_88ED:  JSR  ASRD6
P3_88F0:  ADDD MS_VY,U
P3_88F2:  STD  MS_VY,U
P3_88F4:  LDD  ,U
P3_88F6:  JSR  ASRD6
P3_88F9:  ADDD MS_VZ,U
P3_88FB:  STD  MS_VZ,U
P3_88FD:  RTS

;------------------------------------------------------------------------------
; SNMVU - MOVE UP
;------------------------------------------------------------------------------
SNMVU:
P3_88FE:  LDD  MS_AZ,U                ;Z VECTOR
P3_8900:  JSR  ASRD6
P3_8903:  ADDD MS_VX,U
P3_8905:  STD  MS_VX,U
P3_8907:  LDD  MS_BZ,U
P3_8909:  JSR  ASRD6
P3_890C:  ADDD MS_VY,U
P3_890E:  STD  MS_VY,U
P3_8910:  LDD  MS_CZ,U
P3_8912:  JSR  ASRD6
P3_8915:  ADDD MS_VZ,U
P3_8917:  STD  MS_VZ,U
P3_8919:  RTS

;------------------------------------------------------------------------------
; SNMVU2 - MOVE UP TWICE AS FAST
;------------------------------------------------------------------------------
SNMVU2:
P3_891A:  LDD  MS_AZ,U                ;Z VECTOR
P3_891C:  JSR  ASRD5_B0
P3_891F:  ADDD MS_VX,U
P3_8921:  STD  MS_VX,U
P3_8923:  LDD  MS_BZ,U
P3_8925:  JSR  ASRD5_B0
P3_8928:  ADDD MS_VY,U
P3_892A:  STD  MS_VY,U
P3_892C:  LDD  MS_CZ,U
P3_892E:  JSR  ASRD5_B0
P3_8931:  ADDD MS_VZ,U
P3_8933:  STD  MS_VZ,U
P3_8935:  RTS

;------------------------------------------------------------------------------
; SNMVD - MOVE DOWN
;------------------------------------------------------------------------------
SNMVD:
P3_8936:  LDD  #$0000                 ;NEGATE Z VECTOR
P3_8939:  SUBD MS_AZ,U
P3_893B:  JSR  ASRD6
P3_893E:  ADDD MS_VX,U
P3_8940:  STD  MS_VX,U
P3_8942:  LDD  #$0000
P3_8945:  SUBD MS_BZ,U
P3_8947:  JSR  ASRD6
P3_894A:  ADDD MS_VY,U
P3_894C:  STD  MS_VY,U
P3_894E:  LDD  #$0000
P3_8951:  SUBD MS_CZ,U
P3_8953:  JSR  ASRD6
P3_8956:  ADDD MS_VZ,U
P3_8958:  STD  MS_VZ,U
P3_895A:  RTS

;------------------------------------------------------------------------------
; SNMVD2 - MOVE DOWN TWICE AS FAST
;------------------------------------------------------------------------------
SNMVD2:
P3_895B:  LDD  #$0000                 ;NEGATE Z VECTOR
P3_895E:  SUBD MS_AZ,U
P3_8960:  JSR  ASRD5_B0
P3_8963:  ADDD MS_VX,U
P3_8965:  STD  MS_VX,U
P3_8967:  LDD  #$0000
P3_896A:  SUBD MS_BZ,U
P3_896C:  JSR  ASRD5_B0
P3_896F:  ADDD MS_VY,U
P3_8971:  STD  MS_VY,U
P3_8973:  LDD  #$0000
P3_8976:  SUBD MS_CZ,U
P3_8978:  JSR  ASRD5_B0
P3_897B:  ADDD MS_VZ,U
P3_897D:  STD  MS_VZ,U
P3_897F:  RTS

S_CPY1:
P3_8980:  .byte $54, $CD, $E5, $2D, $3F, $14, $12, $CD ;.IRPC .A,<GREGR did THIS also>
P3_8988:  .byte $69, $F6, $AD, $33, $AA, $28, $A6, $0B
P3_8990:  .byte $F7, $58, $D1

;------------------------------------------------------------------------------
; DOAMOV - MOVE ALIEN
;   PLAYER SHIP
;   X--> A. PARAMETER
;   U--> UVP
;   VELOCITIES ALREADY SET
;------------------------------------------------------------------------------
DOAMOV:
P3_8993:  LDD  MS_VX,U
P3_8995:  ADDD MS_TX,U
P3_8997:  BVS  DOAMOV_50              ;IFVC
P3_8999:  STD  MS_TX,U                ;NEW LOCAL POSITION

DOAMOV_50:          ;---HANDLE Y TRANSLATION
P3_899B:  LDD  MS_VY,U
P3_899D:  ADDD MS_TY,U
P3_899F:  BVS  DOAMOV_60              ;IFVC
P3_89A1:  STD  MS_TY,U                ;NEW TRANSLATION LOCATION

DOAMOV_60:          ;--- TRANSLATE Y
P3_89A3:  LDD  MS_TZ,U
P3_89A5:  ADDD MS_VZ,U                ;COMPUTE NEW Z
P3_89A7:  BVS  DOAMOV_68              ;IFVC
P3_89A9:  STD  MS_TZ,U

DOAMOV_68:
P3_89AB:  RTS

;------------------------------------------------------------------------------
; CPHTSA - COLLISION
;   SPACE LAZAR HIT ALIEN SHIP
;   in ESB: the Darth Vader score is gone, and Star Wars' XPSA is in line at the end (P3_8A31): it counts
;   WV_LIV down, frees the record and starts the explosion through bank 1 KE57C, scores 100 points while
;   bonus_left is running and 1,000 after, and the kill that brings bonus_left to 0 scores the 5,000 point
;   bonus, awards the Jedi letter (page 1 P1_9573) and raises quota_tie
;------------------------------------------------------------------------------
CPHTSA:
P3_89AC:  LDX  CL_AP                  ;X-->ALIEN PARMS
P3_89AE:  LDA  AS_TYP,X
P3_89B0:  CMPA #$01
P3_89B2:  BNE  CPHTSA_5               ;NO DOUBLE JEOPARDY IF NOT ALIVE
P3_89B4:  LDA  7,X                    ;glow timer, byte 7 (Star Wars AS_GLW)
P3_89B6:  BEQ  P3_89B9                ;IFNE  ?OR IS IT GLOWING FROM A HIT?

CPHTSA_5:
P3_89B8:  RTS                         ;LEAVE ALONE FOR A WHILE
P3_89B9:  JSR  rnd_set
P3_89BC:  LDA  AS_TYP,X
P3_89BE:  CMPA #$01
P3_89C0:  BNE  CPHTSA_30              ;?A LIVE ALIEN?
P3_89C2:  LDD  AS_CHST,X
P3_89C5:  ORB  #(CS_AH&$FF)           ;CHSET C$AH  STATUS: THIS ALIEN DAMAGED
P3_89C7:  STD  AS_CHST,X

CPHTSA_30:
P3_89CA:  LDX  CL_AP                  ;X--> HIT ALIEN PARM
P3_89CC:  INC  9,X                    ;damage count, byte 9 (Star Wars AS_DMC)
P3_89CE:  DEC  8,X                    ;hits left, byte 8 (Star Wars AS_HTA)
P3_89D0:  LBLE P3_8A31                ;NO HITS LEFT - EXPLODE SPACE ALIEN
;INDICATE DAMAGE
;IMPART GUN VELOCITY TO SHIP
P3_89D4:  LDA  #$05                   ;hits left: back to 5, which kept Darth Vader alive in Star Wars. every ship of ESB's tables has 1 hit, so this path is not taken
P3_89D6:  STA  8,X
;FORCE GLOW
P3_89D8:  LDA  #$1F                   ;TWO OR SO SECONDS
P3_89DA:  STA  10,X                   ;forced roll timer, byte 10 (Star Wars AS_ROL)
P3_89DC:  STA  7,X                    ;glow timer
P3_89DE:  LDX  #M_S1
P3_89E1:  LDU  CL_AP
P3_89E3:  LDU  ,U                     ;ALIEN UVP
;=== THROW SHIP FOR A LOOP
P3_89E5:  LDD  #$0000                 ;CLRD
P3_89E8:  STD  MS_VX,U                ;THRO SHIP INDEPENDENT OF PREVIOUS MOTION
P3_89EA:  STD  MS_VY,U
P3_89EC:  STD  MS_VZ,U
P3_89EE:  LDA  #$02
P3_89F0:  STA  TMPLP

CPHTSA_40:
P3_89F2:  LDD  #$4000
P3_89F5:  SUBD CL_ADS
P3_89F7:  LDB  MS_AX,X
P3_89F9:  MUL
P3_89FA:  TFR  A,B
P3_89FC:  LSLB                        ;LSLD
P3_89FD:  ROLA
P3_89FE:  SEX
P3_89FF:  ADDD MS_VX,U
P3_8A01:  STD  MS_VX,U                ;PORTION OF FORWARD VELOCITY
P3_8A03:  LDA  RND_S1
P3_8A05:  ORA  #$80                   ;AT LEAST SOME ANGLE
P3_8A07:  LDB  MS_BX,X
P3_8A09:  MUL
P3_8A0A:  BCS  CPHTSA_43              ;RANDOM BIT
P3_8A0C:  NEGA

CPHTSA_43:
P3_8A0D:  TFR  A,B
P3_8A0F:  NOP
P3_8A10:  SEX
P3_8A11:  ADDD MS_VY,U
P3_8A13:  STD  MS_VY,U                ;PORTION OF Y VELOCITY
P3_8A15:  LDA  RND_S2
P3_8A17:  ORA  #$80
P3_8A19:  LDB  ,X
P3_8A1B:  MUL
P3_8A1C:  BCS  CPHTSA_53              ;RANDOM BIT
P3_8A1E:  NEGA

CPHTSA_53:
P3_8A1F:  TFR  A,B
P3_8A21:  NOP
P3_8A22:  SEX                         ;FULL WORD
P3_8A23:  ADDD MS_VZ,U
P3_8A25:  STD  MS_VZ,U
P3_8A27:  LEAX 2,X
P3_8A29:  DEC  TMPLP
P3_8A2B:  BPL  CPHTSA_40
P3_8A2D:  JSR  aud_cmd_3c
P3_8A30:  RTS
P3_8A31:  LDX  CL_AP                  ;Star Wars' XPSA from here: explode the alien of CL_AP
P3_8A33:  JSR  aud_cmd_3c
P3_8A36:  LDA  2,X                    ;its block index
P3_8A38:  CMPA Q_PBB
P3_8A3B:  BNE  P3_8A40
P3_8A3D:  JSR  aud_cmd_36             ;the ship passing by: end the pass-by sound
P3_8A40:  DEC  WV_LIV                 ;one ship less alive in the wave, not below 0
P3_8A42:  BGT  P3_8A46
P3_8A44:  CLR  WV_LIV
P3_8A46:  JSR  L618C                  ;bank 1 KE57C: free the record and start the explosion (BGAXP)
P3_8A49:  LDA  bonus_left             ;bonus count still running: 100 points
P3_8A4C:  BEQ  P3_8A53
P3_8A4E:  JSR  scr_tie_100
P3_8A51:  BRA  P3_8A56
P3_8A53:  JSR  scr_tie_1000           ;quota met: 1,000 points
P3_8A56:  LDA  bonus_left
P3_8A59:  BEQ  P3_8A69
P3_8A5B:  DEC  bonus_left             ;count the kill
P3_8A5E:  BNE  P3_8A69
P3_8A60:  JSR  scr_tie_quota          ;the kill that brings the count to 0: 5,000 points, then the Jedi letter
P3_8A63:  JSR  P3_81E4                ;calls page 1 jedi_award
P3_8A66:  INC  quota_tie              ;the quota is one higher the next time
P3_8A69:  RTS

;------------------------------------------------------------------------------
; CPU - CPU-COMPUTER DRONES
;   COMPUTER
;   in ESB: after CPUAL each live ship also has its fire delay counted down (tie_fire_delay)
;------------------------------------------------------------------------------
CPU:
P3_8A6A:  LDX  #ALIEN

CPU_20:
P3_8A6D:  STX  S1_PRM
P3_8A6F:  LDU  ,X
P3_8A71:  LDA  AS_TYP,X               ;IGNORE DEAD ONES
P3_8A73:  BEQ  CPU_40_P3
P3_8A75:  JSR  CPUAL                  ;ALIEN CPU, LOCAL
P3_8A78:  JSR  tie_fire_delay         ;ESB: count the ship's fire delay down

CPU_40_P3:
P3_8A7B:  LDX  S1_PRM
P3_8A7D:  LEAX AS_IZE,X
P3_8A80:  CMPX #ALIENZ
P3_8A83:  BLO  CPU_20
P3_8A85:  RTS

;------------------------------------------------------------------------------
; tie_fire_delay - ESB's addition to the loop of CPU, X = alien record: counts the ship's fire delay (byte 4 of
;   the record) down by one a frame until it is 0. CPUAL lets the ship fire only when it is 0 and page 1
;   tie_fire_try loads it again from the shot table. the frame mask in front of it is 0, so every frame counts
;------------------------------------------------------------------------------
tie_fire_delay:
P3_8A86:  LDA  FRAMEL
P3_8A88:  ANDA #$00                   ;mask 0: every frame counts
P3_8A8A:  BNE  CPU_90
P3_8A8C:  LDA  4,X                    ;fire delay, byte 4 of the record
P3_8A8E:  BEQ  CPU_90
P3_8A90:  DEC  4,X

CPU_90:
P3_8A92:  RTS

;------------------------------------------------------------------------------
; CPURET - COMPUTER DRONES RUN AWAY  (comment at the call)
;   in ESB: runs for the end of the TIE fighter part (phe_tie_flee, phase $28): the ships close in on the
;   centre line and race away ahead of the player until their x overflows, then their records are freed. there
;   is no Death Star to go back to
;------------------------------------------------------------------------------
CPURET:
P3_8A93:  LDX  #ALIEN
P3_8A96:  STX  S1_PRM
P3_8A98:  LDU  ,X
P3_8A9A:  LDA  AS_TYP,X
P3_8A9C:  CMPA #$01
P3_8A9E:  BNE  P3_8AE3                ;IFEQ  ?ALIVE?
;MOVE Y AND Z TO CENTER
P3_8AA0:  LDA  MS_TY,U
P3_8AA2:  CMPA #$09
P3_8AA4:  BLT  P3_8AA8                ;IFGE
P3_8AA6:  SUBA #$02
P3_8AA8:  CMPA #$F7
P3_8AAA:  BGT  P3_8AAE                ;IFLE
P3_8AAC:  ADDA #$02
P3_8AAE:  STA  MS_TY,U                ;SAVE RESULT
P3_8AB0:  LDA  MS_TZ,U
P3_8AB2:  CMPA #$09
P3_8AB4:  BLT  P3_8AB8                ;IFGE
P3_8AB6:  SUBA #$03
P3_8AB8:  CMPA #$F7
P3_8ABA:  BGT  P3_8ABE                ;IFLE
P3_8ABC:  ADDA #$03
P3_8ABE:  STA  MS_TZ,U                ;SAVE RESULT
P3_8AC0:  LDD  MS_TX,U
P3_8AC2:  ADDD #$0400                 ;RACE BACK TO DETH STAR
P3_8AC5:  BVS  P3_8ACB                ;IFVC
P3_8AC7:  STD  MS_TX,U
P3_8AC9:  BRA  P3_8AE3                ;ELSE  ELSE OVERFLOWED TO DETH STAR, SO TURN OFF
P3_8ACB:  LDA  MS_TY,U
P3_8ACD:  TSTA                        ;ABSA
P3_8ACE:  BPL  P3_8AD1
P3_8AD0:  NEGA
P3_8AD1:  CMPA #$08
P3_8AD3:  BGT  P3_8AE3                ;IFLE
P3_8AD5:  LDA  MS_TZ,U
P3_8AD7:  TSTA                        ;ABSA
P3_8AD8:  BPL  P3_8ADB
P3_8ADA:  NEGA
P3_8ADB:  CMPA #$08
P3_8ADD:  BGT  P3_8AE3                ;IFLE  ?BOTH Y AND Z CLOSE TO DETH STAR ALSO?
P3_8ADF:  LDA  #$00                   ;THEN TURN OFF ALIEN
P3_8AE1:  STA  AS_TYP,X
P3_8AE3:  LDX  S1_PRM                 ;LOOP WITH NEXT ALIEN
P3_8AE5:  LEAX AS_IZE,X
P3_8AE8:  CMPX #ALIENZ
P3_8AEB:  BLO  P3_8A96                ;HSEND
P3_8AED:  RTS

;------------------------------------------------------------------------------
; CPUAL - ALIEN CPU, LOCAL  (comment at the call)
;   in ESB: the shot itself is left to page 1 tie_fire, called once the ship's fire delay (byte 4 of the
;   record) has run out, which takes the place of Star Wars' probability table TGPROB and its search for a
;   free gun. carry set on return means a shot was started
;------------------------------------------------------------------------------
CPUAL:
P3_8AEE:  JSR  CHOPDO
P3_8AF1:  LDD  #$0000                 ;CLEAR ACTIONS REQUESTED
P3_8AF4:  STA  CP_AC
P3_8AF6:  STA  CP_RL
P3_8AF8:  STA  CP_PT
P3_8AFA:  STA  CP_YW
P3_8AFC:  LDA  AS_CHST,X
P3_8AFF:  ANDA #CS_PV/$100            ;SAVE IF IN VIEW FOR GUNS
P3_8B01:  LDB  P_RND1
P3_8B04:  ANDB #CS_R1+CS_R2
P3_8B06:  STD  AS_CHST,X              ;PREPARE NEW CHOREG STATUS
P3_8B09:  LDA  10,X                   ;forced roll timer, byte 10 (Star Wars AS_ROL)
P3_8B0B:  DECA
P3_8B0C:  BMI  CPUAL_18
P3_8B0E:  STA  10,X
P3_8B10:  LDD  #$1640                 ;20.34 DEGREES
P3_8B13:  STD  M_SIN
P3_8B16:  LDD  #$3C02
P3_8B19:  STD  M_COS
P3_8B1C:  JSR  SNRL
P3_8B1F:  BRA  P3_8B50

CPUAL_18:
P3_8B21:  LDB  AS_CHTW,X              ;TWIRL INFO
P3_8B24:  STB  CP_SHF

CPUAL_20:
P3_8B26:  LSR  CP_SHF
P3_8B28:  BCC  CPUAL_21
P3_8B2A:  JSR  SNRLL

CPUAL_21:
P3_8B2D:  LSR  CP_SHF
P3_8B2F:  BCC  CPUAL_22
P3_8B31:  JSR  SNRLR

CPUAL_22:
P3_8B34:  LSR  CP_SHF
P3_8B36:  BCC  CPUAL_23
P3_8B38:  JSR  SNPTU

CPUAL_23:
P3_8B3B:  LSR  CP_SHF
P3_8B3D:  BCC  CPUAL_24
P3_8B3F:  JSR  SNPTD

CPUAL_24:
P3_8B42:  LSR  CP_SHF
P3_8B44:  BCC  CPUAL_25
P3_8B46:  JSR  SNYWR

CPUAL_25:
P3_8B49:  LSR  CP_SHF
P3_8B4B:  BCC  P3_8B50
P3_8B4D:  JSR  SNYWL
P3_8B50:  JSR  CPUMVL                 ;move the ship
P3_8B53:  JSR  CPCHKL
P3_8B56:  LDA  AS_TYP,X
P3_8B58:  CMPA #$01                   ;?NOT LIVE SHIP?
P3_8B5A:  LBNE CPUAL_60               ;B THEN NO SHOTS
P3_8B5E:  LDA  AS_BIC,X
P3_8B60:  JSR  IS1UV                  ;DOWNLOAD VECTORS
P3_8B63:  LDX  S1_PRM
P3_8B65:  CLR  11,X                   ;byte 11 (Star Wars AS_AIM): cleared, set below when the player is in front
P3_8B67:  CLRA
P3_8B68:  LDB  #MS_S1BC+3             ;CHASE PLAYER'S ONE SHIP
P3_8B6A:  STD  M_BIC
P3_8B6D:  LDA  AS_CHTW,X              ;AIM IN FRONT OF PLAYER
P3_8B70:  BITA #CS_T9
P3_8B72:  BEQ  P3_8B8D                ;IFNE
P3_8B74:  LDD  MS_TX+M_S1
P3_8B77:  ADDD #$1000                 ;GO IN FRONT OF PLAYER
P3_8B7A:  STD  MS_TX+M_S1
P3_8B7D:  LDA  #MS_PSB2               ;NOW VIEW PLAYER'S SHIP
P3_8B7F:  JSR  MGOWT
P3_8B82:  LDD  MS_TX+M_S1
P3_8B85:  SUBD #$1000                 ;RESTORE M$TX
P3_8B88:  STD  MS_TX+M_S1
P3_8B8B:  BRA  P3_8B92                ;ELSE
P3_8B8D:  LDA  #MS_PSB2               ;VIEW PLAYERS SHIP
P3_8B8F:  JSR  MGOWT
P3_8B92:  LDD  M_XP                   ;?PLAYER IN FRONT?
P3_8B95:  BMI  P3_8BBA                ;B IGNORE GUNS IF IN BACK
P3_8B97:  INC  11,X
P3_8B99:  SUBD #$4000
P3_8B9C:  BGE  P3_8BBA                ;IGNORE GUN IF TOO FAR AWAY
P3_8B9E:  LDD  AS_CHST,X              ;SET PLAYER IN ALIENS VIEW
P3_8BA1:  ORB  #(CS_AV&$FF)           ;CHSET C$AV
P3_8BA3:  STD  AS_CHST,X
P3_8BA6:  LDD  M_YPS
P3_8BA9:  ADDD M_ZPS
P3_8BAC:  CMPD #$0020                 ;?AIMING NEAR SHIP?
P3_8BB0:  BHI  P3_8BBA
P3_8BB2:  LDD  AS_CHST,X              ;PLAYER IN ALIENS SITES
P3_8BB5:  ORB  #(CS_AS&$FF)           ;CHSET C$AS
P3_8BB7:  STD  AS_CHST,X
P3_8BBA:  LDA  4,X                    ;ESB: fire delay not run out, no shot
P3_8BBC:  BNE  CPUAL_38

CPUAL_140:
P3_8BBE:  LDD  AS_CHST,X
P3_8BC1:  BITA #CS_PV/$100
P3_8BC3:  BEQ  CPUAL_38               ;NO SHOOTING GUNS IF PLAYER CANT SEE US
P3_8BC5:  LDD  AS_CHTW,X
P3_8BC8:  BITA #CS_T9
P3_8BCA:  BNE  CPUAL_38               ;B NO SHOOT IF AIMMING IN FRONT
P3_8BCC:  LDD  M_XP
P3_8BCF:  SUBD #$0800
P3_8BD2:  BLE  CPUAL_38               ;B TOO CLOSE
P3_8BD4:  LDA  7,X                    ;glowing from a hit: no shot
P3_8BD6:  BNE  CPUAL_38
P3_8BD8:  JSR  P3_857A                ;calls page 1 tie_fire
P3_8BDB:  BCC  CPUAL_38               ;carry set: a shot was started
P3_8BDD:  LDD  AS_CHST,X              ;TELL ALIEN HE FIRED A GUN
P3_8BE0:  ORB  #(CS_AG&$FF)           ;CHSET C$AG
P3_8BE2:  STD  AS_CHST,X

;AIM AT PLAYER
CPUAL_38:
CPUAL_40:
P3_8BE5:  LDX  S1_PRM
P3_8BE7:  LDA  AS_CHTW,X
P3_8BEA:  BITA #CS_T0
P3_8BEC:  BEQ  CPUAL_60

CPUAL_41:
P3_8BEE:  LDA  CP_YW
P3_8BF0:  BNE  CPUAL_50
P3_8BF2:  LDA  M_YP
P3_8BF5:  BMI  CPUAL_42
P3_8BF7:  JSR  SNYWR
P3_8BFA:  BRA  CPUAL_45

CPUAL_42:
P3_8BFC:  JSR  SNYWL

CPUAL_45:
P3_8BFF:  LDA  CP_RL
P3_8C01:  BNE  CPUAL_50               ;?HELP YAW BY ROLLING?
P3_8C03:  LDB  M_ZP
P3_8C06:  SEX
P3_8C07:  ADDB #$01
P3_8C09:  CMPB #$01
P3_8C0B:  BLS  CPUAL_50               ;?FAR ENOUGH AWAY? AVOID JITTER
P3_8C0D:  EORA M_YP                   ;INVOLVE GUADRANT
P3_8C10:  BMI  CPUAL_48
P3_8C12:  JSR  SNRLL                  ;+Z UP, +Y RIGHT QUAD
P3_8C15:  BRA  CPUAL_50

CPUAL_48:
P3_8C17:  JSR  SNRLR

CPUAL_50:
P3_8C1A:  LDA  CP_PT
P3_8C1C:  BNE  CPUAL_60
P3_8C1E:  LDA  M_ZP
P3_8C21:  BMI  CPUAL_52
P3_8C23:  JSR  SNPTU
P3_8C26:  BRA  CPUAL_55

CPUAL_52:
P3_8C28:  JSR  SNPTD

CPUAL_55:
P3_8C2B:  LDA  CP_RL
P3_8C2D:  BNE  CPUAL_60               ;?ROLL AVAILABLE TO HELP PITCH?
P3_8C2F:  LDB  M_YP
P3_8C32:  SEX
P3_8C33:  ADDB #$01
P3_8C35:  CMPB #$01
P3_8C37:  BLS  CPUAL_60               ;AVOID JITTER
P3_8C39:  EORA M_ZP                   ;INVOLVE QUADRANTS
P3_8C3C:  BMI  CPUAL_58
P3_8C3E:  JSR  SNRLR                  ;+Z UP, +Y RIGHT QUAD
P3_8C41:  BRA  CPUAL_60

CPUAL_58:
P3_8C43:  JSR  SNRLL

CPUAL_60:
CPUAL_80:
CPUAL_90:
P3_8C46:  LDX  S1_PRM
P3_8C48:  LDD  AS_CHST,X
P3_8C4B:  ANDA #-1-(CS_PV/$100)
P3_8C4D:  STD  AS_CHST,X
P3_8C50:  RTS

;------------------------------------------------------------------------------
; CPUMVL - Star Wars' CPUMVL (move locally), the same code with ESB's record offsets, which is why the matcher
;   missed it: unless the ship of S1_PRM is glowing from a hit (byte 7) its velocity is cleared and built again
;   from the move flags AS_CHMV of the current choreography step, one bit each for down, down twice, up, up twice,
;   forward and forward twice (SNMVD to SNMVF2). DOAMOV then adds the velocity to the position
;------------------------------------------------------------------------------
CPUMVL:
P3_8C51:  LDX  S1_PRM
P3_8C53:  LDU  ,X
P3_8C55:  LDA  7,X                    ;glow timer, byte 7 (Star Wars AS_GLW)
P3_8C57:  BNE  CPUMVL_32              ;B NO NEW VELOCITY IF HIT
P3_8C59:  LDB  AS_CHMV,X              ;MOVE INFO
P3_8C5C:  STB  CP_SHF
P3_8C5E:  LDU  ,X
P3_8C60:  LDD  #$0000                 ;SET VELOCITY TO ZERO
P3_8C63:  STD  MS_VX,U
P3_8C65:  STD  MS_VY,U
P3_8C67:  STD  MS_VZ,U                ;NOW LET US SLIP

CPUMVL_20:
P3_8C69:  LSR  CP_SHF
P3_8C6B:  BCC  CPUMVL_22
P3_8C6D:  JSR  SNMVD

CPUMVL_22:
P3_8C70:  LSR  CP_SHF
P3_8C72:  BCC  CPUMVL_24
P3_8C74:  JSR  SNMVD2

CPUMVL_24:
P3_8C77:  LSR  CP_SHF
P3_8C79:  BCC  CPUMVL_26
P3_8C7B:  JSR  SNMVU

CPUMVL_26:
P3_8C7E:  LSR  CP_SHF
P3_8C80:  BCC  CPUMVL_28
P3_8C82:  JSR  SNMVU2

CPUMVL_28:
P3_8C85:  LSR  CP_SHF
P3_8C87:  BCC  CPUMVL_30
P3_8C89:  JSR  SNMVF

CPUMVL_30:
P3_8C8C:  LSR  CP_SHF
P3_8C8E:  BCC  CPUMVL_32
P3_8C90:  JSR  SNMVF2

CPUMVL_32:
CPUMVL_40:
P3_8C93:  JSR  DOAMOV                 ;AN ALIEN MOVE
P3_8C96:  RTS

;------------------------------------------------------------------------------
; CPCHKL - [note] Check alien's distance away, X-->alien parms: keep the high byte of MS_TX, MS_TY and MS_TZ of its
;   unit vectors (AS_UVP) in range, limiting to $7CFF (positive) and $8300 (negative)
;------------------------------------------------------------------------------
CPCHKL:
P3_8C97:  LDU  ,X                     ;ALIEN UNIT VECTORS
P3_8C99:  LDD  MS_TX,U                ;.IRPC .1,<XYZ>  DO FOR 3 AXIS
P3_8C9B:  CMPA #$7D
P3_8C9D:  BLT  P3_8CA2
P3_8C9F:  LDD  #$7CFF
P3_8CA2:  CMPA #$82
P3_8CA4:  BGT  P3_8CA9
P3_8CA6:  LDD  #$8300
P3_8CA9:  STD  MS_TX,U
P3_8CAB:  LDD  MS_TY,U
P3_8CAD:  CMPA #$7D
P3_8CAF:  BLT  P3_8CB4
P3_8CB1:  LDD  #$7CFF
P3_8CB4:  CMPA #$82
P3_8CB6:  BGT  P3_8CBB
P3_8CB8:  LDD  #$8300
P3_8CBB:  STD  MS_TY,U
P3_8CBD:  LDD  MS_TZ,U
P3_8CBF:  CMPA #$7D
P3_8CC1:  BLT  P3_8CC6
P3_8CC3:  LDD  #$7CFF
P3_8CC6:  CMPA #$82
P3_8CC8:  BGT  P3_8CCD
P3_8CCA:  LDD  #$8300
P3_8CCD:  STD  MS_TZ,U
P3_8CCF:  RTS

;------------------------------------------------------------------------------
; NWCHOR - CHOREOGRAPHY ROUTINES
;   NEW CHOREOG
;------------------------------------------------------------------------------
NWCHOR:
P3_8CD0:  LDD  #$0000
P3_8CD3:  STD  AS_CHTW,X              ;NO TWIST OR MOVE
P3_8CD6:  STA  AS_CHTM,X              ;TIME LEFT PER ROUTINE
P3_8CD9:  STD  AS_CHCN,X              ;UNTIL CONTROL MASK
P3_8CDC:  STD  AS_CHST,X              ;STATUS FLAGS

CHNXT:
P3_8CDF:  LDU  AS_CHPC,X
P3_8CE1:  LDA  ,U
P3_8CE3:  STA  AS_CHOP,X
P3_8CE5:  BEQ  CHCN_D                 ;DECODE CONTROL IMMEDIATELY

;------------------------------------------------------------------------------
; CHOPDO - DO THE OP-CODE
;------------------------------------------------------------------------------
CHOPDO:
P3_8CE7:  LDD  AS_CHST,X              ;CHECK CONTROL FLAGS FIRST
P3_8CEA:  ANDA AS_CHCN,X
P3_8CED:  BNE  CHCN_E                 ;DO CONTROL
P3_8CEF:  ANDB AS_CHCN+1,X
P3_8CF2:  BNE  CHCN_E                 ;DO CONTROL
P3_8CF4:  LDA  AS_CHOP,X
P3_8CF6:  ANDA #$07
P3_8CF8:  LSLA
P3_8CF9:  LDU  #TCHOP
P3_8CFC:  JMP  [A,U]

;------------------------------------------------------------------------------
; CHCN_D - DECODE CONTROL
;------------------------------------------------------------------------------
CHCN_D:
P3_8CFE:  LDD  1,U                    ;U--> CHINST
P3_8D00:  STD  AS_CHCN,X
P3_8D03:  LEAU 3,U
P3_8D05:  STU  AS_CHPC,X
P3_8D07:  BRA  CHNXT

;------------------------------------------------------------------------------
; CHCN_E - [note] Control mask matched status (from CHOPDO): skip 3-byte choreography entries at AS_CHPC until one
;   whose first byte is 0, then go to CHNXT
;------------------------------------------------------------------------------
CHCN_E:
P3_8D09:  LDU  AS_CHPC,X

CHCN_E_10:
P3_8D0B:  LDA  ,U                     ;U--> CHINST
P3_8D0D:  BEQ  CHNXT
P3_8D0F:  LEAU 3,U                    ;CONTROL STATUS CHECK
P3_8D11:  STU  AS_CHPC,X              ;SKIP UNTIL PROPER ROUTINE FOUND
P3_8D13:  BRA  CHCN_E_10

TCHOP:
P3_8D15:  .word CHIF_D                ;0:IF
P3_8D17:  .word CHGO_D                ;1: GOTO
P3_8D19:  .word CHGS_D                ;2: GOSUB
P3_8D1B:  .word CHRT_D                ;3: RETURN
P3_8D1D:  .word CHTW_D, CHTW_E        ;4,5: TWIRL
P3_8D21:  .word chor_bad_op           ;6,7: unassigned
P3_8D23:  .word chor_bad_op

;------------------------------------------------------------------------------
; chor_bad_op - choreography opcodes 6 and 7, which are not assigned: jumps to NWCHOR, which starts the step at
;   AS_CHPC again. Star Wars has CHERR here, a SWI. no table on this page holds such an opcode, and one would loop
;   for ever since the step is never passed over
;------------------------------------------------------------------------------
chor_bad_op:
P3_8D25:  JMP  NWCHOR

;------------------------------------------------------------------------------
; CHIF_D - IF MASK IS TRUE
;------------------------------------------------------------------------------
CHIF_D:
P3_8D28:  LDU  AS_CHPC,X

CHIF_D_10:
P3_8D2A:  LDD  1,U
P3_8D2C:  BEQ  CHIF_D_50              ;B DEFAULT IF, ALWAYS TRUE
P3_8D2E:  ANDA AS_CHST,X
P3_8D31:  BNE  CHIF_D_50              ;B HI MASK IS TRUE
P3_8D33:  ANDB AS_CHST+1,X
P3_8D36:  BNE  CHIF_D_50              ;B LO MASK IS TRUE

CHIF_D_20:          ;SKIP TO NEXT IF
P3_8D38:  LEAU 3,U
P3_8D3A:  LDA  ,U
P3_8D3C:  LSLA
P3_8D3D:  BNE  CHIF_D_20              ;NON-ZERO OP==>TRY AGAIN
P3_8D3F:  BCC  CHIF_D_20              ;ALL ZERO==>UNTIL OP
P3_8D41:  BRA  CHIF_D_10              ;J OP=80==>'IF' FOUND

CHIF_D_50:
P3_8D43:  LEAU 3,U
P3_8D45:  STU  AS_CHPC,X
P3_8D47:  JMP  CHNXT

;------------------------------------------------------------------------------
; CHGO_D - GOTO
;------------------------------------------------------------------------------
CHGO_D:
P3_8D4A:  LDU  AS_CHPC,X
P3_8D4C:  LDU  1,U                    ;SET NEW PC
P3_8D4E:  STU  AS_CHPC,X
P3_8D50:  JMP  CHNXT

;------------------------------------------------------------------------------
; CHGS_D - GOSUB
;------------------------------------------------------------------------------
CHGS_D:
P3_8D53:  LDU  AS_CHPC,X              ;SAVE RETURN ADDRESS
P3_8D55:  LEAU 3,U                    ;RETURN ADDRESS
P3_8D57:  STU  AS_CHRT,X
P3_8D5A:  LDU  -$2,U                  ;PREVIOUS PARM IS GOSUB ADDRESS
P3_8D5C:  STU  AS_CHPC,X
P3_8D5E:  JMP  CHNXT

;------------------------------------------------------------------------------
; CHRT_D - RETURN
;------------------------------------------------------------------------------
CHRT_D:
P3_8D61:  LDU  AS_CHRT,X              ;RESTORE PC
P3_8D64:  STU  AS_CHPC,X
P3_8D66:  JMP  CHNXT

;------------------------------------------------------------------------------
; CHTW_D - TWIRL, DECODE
;------------------------------------------------------------------------------
CHTW_D:
P3_8D69:  LDU  AS_CHPC,X
P3_8D6B:  LDB  ,U                     ;PULL IN TIMER IN QUARTER SECONDS
P3_8D6D:  LSRB
P3_8D6E:  STB  AS_CHTM,X
P3_8D71:  LDD  1,U                    ;TWIRL AND MOVE
P3_8D73:  STD  AS_CHTW,X
P3_8D76:  LEAU 3,U
P3_8D78:  STU  AS_CHPC,X
P3_8D7A:  INC  AS_CHOP,X              ;BUMP TO EXECUTE PHASE
P3_8D7C:  RTS

;------------------------------------------------------------------------------
; CHTW_E - TWIRL, EXECUTE
;------------------------------------------------------------------------------
CHTW_E:
P3_8D7D:  DEC  AS_CHTM,X              ;TRICK OFF TIMER
P3_8D80:  LBMI CHNXT                  ;B IF DONE, GET NEXT OP
P3_8D84:  RTS                         ;ELSE WAIT FOR NEXT FRAME

;------------------------------------------------------------------------------
; NWNSHP_P3 - Star Wars' NWNSHP (new alien ships) without its first instruction, the JSR INOBJ, which is why the
;   matcher missed it. picks the set of wave lists for the TIE fighter level SP_WAV from TSPWAV_P3 (past the sixth
;   set the last two take turns), takes the list for level WV_LVL of the set into WV_LP, clears WV_LIV and the
;   three alien records and makes a ship with NWASHP for each entry of the list, three at most. called by
;   tie_wave_init
;------------------------------------------------------------------------------
NWNSHP_P3:
P3_8D85:  LDB  SP_WAV                 ;CURRENT SPACE WAVE
P3_8D88:  LSLB
P3_8D89:  LDX  #TSPWAV_P3             ;TABLE OF SPACE WAVE GROUPS
P3_8D8C:  ABX
P3_8D8D:  CMPX #SETA1_P3              ;PAST END OF TABLE?
P3_8D90:  BLO  P3_8DA0                ;IFHS  YEP
P3_8D92:  LDA  SP_WAV
P3_8D95:  LSRA
P3_8D96:  BCS  P3_8D9D                ;IFCC  EVEN ==> ODD SELECTED WAVE
P3_8D98:  LDX  #SETA1_P3-4            ;DARTH COMES SECOND ON SELECTED ODD WAVES
P3_8D9B:  BRA  P3_8DA0                ;ELSE
P3_8D9D:  LDX  #SETA1_P3-2            ;USE LAST ENTRY IN TABLE, DARTH FIRST WITH MUSIC
P3_8DA0:  LDX  ,X                     ;POINTS TO CURRENT SET OF WAVES
P3_8DA2:  LDB  WV_LVL                 ;INDEX INTO SET OF WAVES
P3_8DA4:  CMPB ,X+                    ;GET SIZE OF THIS SET
P3_8DA6:  BLS  P3_8DAA                ;IFHI  KEEP IT WITHIN RANGE
P3_8DA8:  LDB  -$1,X
P3_8DAA:  LSLB                        ;INDEX INTO WORD TABLE
P3_8DAB:  LDD  B,X
P3_8DAD:  STD  WV_LP                  ;LOOP TABLE POINTER
P3_8DAF:  CLR  WV_LIV                 ;NO ALIENS CURRENTLY ALIVE
P3_8DB1:  LDX  #ALIEN

NWNSHP_20:
P3_8DB4:  STX  S1_PRM
P3_8DB6:  CLR  AS_TYP,X               ;KILL ALL ALIENS FIRST
P3_8DB8:  LDU  WV_LP
P3_8DBA:  BEQ  NWNSHP_90              ;IGNORE ALIEN IF NO CHOREOG SET
P3_8DBC:  LDA  ,U
P3_8DBE:  BEQ  NWNSHP_90              ;?CONSTRUCT THIS SHIP?
P3_8DC0:  INC  WV_LIV                 ;ONE MORE LIFE IN THIS WAVE
P3_8DC2:  LDD  ,U
P3_8DC4:  STD  WV_SHP                 ;SHIP SHAPE AND PARMS
P3_8DC6:  LDD  2,U
P3_8DC8:  STD  WV_CHP                 ;CHOREOGRAPHY
P3_8DCA:  LDD  4,U
P3_8DCC:  STD  WV_BGP                 ;BEGIN LOCATION
P3_8DCE:  LEAU 6,U
P3_8DD0:  STU  WV_LP
P3_8DD2:  JSR  NWASHP

NWNSHP_90:          ;---NEXT ALIEN
P3_8DD5:  LDX  S1_PRM
P3_8DD7:  LEAX AS_IZE,X
P3_8DDA:  CMPX #ALIENZ
P3_8DDD:  BLO  NWNSHP_20
P3_8DDF:  RTS

;------------------------------------------------------------------------------
; NWASHP - [note] Make alien record X a live ship: unit vectors (UNITV) facing the player, hits AS_HTA from WV_SHP,
;   location from WV_BGP, choreography WV_CHP (NWCHOR), picture AS_PIC; adds its object with ADBOBJ
;   in ESB: the record fields sit one byte further on than in Star Wars from the picture number on, since ESB
;   put the fire delay at byte 4: picture 5, dying 6, glow 7, hits 8, damage 9, forced roll 10, aim 11, target
;   12. the object is loaded by bank 1 KD868 through L60A8
;------------------------------------------------------------------------------
NWASHP:
P3_8DE0:  LDA  #$01
P3_8DE2:  STA  AS_TYP,X               ;LIVE ALIEN
P3_8DE4:  LDU  ,X
P3_8DE6:  JSR  UNITV
P3_8DE9:  LDU  ,X
P3_8DEB:  LDA  #$C0                   ;FACE ALIEN TOWARDS PLAYER
P3_8DED:  STA  MS_AX,U
P3_8DEF:  STA  MS_BY,U
P3_8DF1:  CLRA
P3_8DF2:  STA  10,X                   ;forced roll, damage count, glow, dying and target bytes cleared (10, 9, 7, 6, 12 in ESB's record)
P3_8DF4:  STA  9,X
P3_8DF6:  STA  7,X
P3_8DF8:  STA  6,X
P3_8DFA:  STA  12,X
P3_8DFC:  LDU  WV_SHP
P3_8DFE:  LDA  1,U                    ;second byte of the shape entry: hits before dying
P3_8E00:  STA  8,X                    ;hits left, byte 8 (Star Wars AS_HTA)
P3_8E02:  LDU  ,X
P3_8E04:  LDX  WV_BGP                 ;BEGINNING LOCATION
P3_8E06:  LDD  ,X
P3_8E08:  STD  MS_TX,U
P3_8E0A:  LDD  2,X
P3_8E0C:  STD  MS_TY,U
P3_8E0E:  LDD  4,X
P3_8E10:  STD  MS_TZ,U
P3_8E12:  LDX  S1_PRM
P3_8E14:  LDD  WV_CHP
P3_8E16:  STD  AS_CHPC,X
P3_8E18:  JSR  NWCHOR
P3_8E1B:  LDX  S1_PRM
P3_8E1D:  LDB  [WV_SHP]               ;first byte of the shape entry: the object number
P3_8E21:  STB  5,X                    ;picture number, byte 5
P3_8E23:  JSR  L60A8                  ;bank 1 KD868: load the object's points, as Star Wars' ADBOBJ
P3_8E26:  RTS

;------------------------------------------------------------------------------
; ADASHP - [note] Add one alien ship from loop table WV_LP (next WV_LVL of the SP_WAV group when the level ends) into
;   the first empty ALIEN slot, set up as in NWASHP but with no ADBOBJ; INC WV_LIV; exits if no slot or entry
;   in ESB: here the object is loaded too: the routine ends with the call of bank 1 KD868 (L60A8) that Star
;   Wars' ADASHP leaves out. called by wave3_exec while fewer than three ships are alive
;------------------------------------------------------------------------------
ADASHP:
P3_8E27:  LDU  WV_LP
P3_8E29:  BEQ  ADASHP_20              ;RESTART IF INVALID WITHIN WAVES
P3_8E2B:  LDA  ,U
P3_8E2D:  BNE  P3_8E5D                ;IFEQ  ?END OF CURRENT LEVEL IN WAVE?

ADASHP_20:
P3_8E2F:  INC  WV_LVL                 ;GET NEXT LEVEL WITHIN WAVE
P3_8E31:  LDB  SP_WAV                 ;CURRENT SPACE WAVE
P3_8E34:  LSLB
P3_8E35:  LDX  #TSPWAV_P3             ;TABLE OF SPACE WAVE GROUPS
P3_8E38:  ABX
P3_8E39:  CMPX #SETA1_P3              ;PAST END OF TABLE?
P3_8E3C:  BLO  P3_8E4C                ;IFHS  YEP
P3_8E3E:  LDA  SP_WAV
P3_8E41:  LSRA
P3_8E42:  BCS  P3_8E49                ;IFCC  EVEN ==> ODD SELECTED WAVE
P3_8E44:  LDX  #SETA1_P3-4            ;DARTH COMES SECOND ON SELECTED ODD WAVES
P3_8E47:  BRA  P3_8E4C                ;ELSE
P3_8E49:  LDX  #SETA1_P3-2            ;USE LAST ENTRY IN TABLE, DARTH FIRST WITH MUSIC
P3_8E4C:  LDX  ,X                     ;POINTS TO CURRENT SET OF WAVES
P3_8E4E:  LDB  WV_LVL                 ;INDEX INTO SET OF WAVES
P3_8E50:  CMPB ,X+                    ;GET SIZE OF THIS SET
P3_8E52:  BLS  P3_8E56                ;IFHI  KEEP IT WITHIN RANGE
P3_8E54:  LDB  -$1,X
P3_8E56:  STB  WV_LVL                 ;KEEP IT CORRECT
P3_8E58:  LSLB                        ;INDEX INTO WORD TABLE
P3_8E59:  LDD  B,X
P3_8E5B:  STD  WV_LP                  ;LOOP TABLE POINTER
P3_8E5D:  LDX  #ALIEN
P3_8E60:  STX  S1_PRM
P3_8E62:  LDA  AS_TYP,X
P3_8E64:  BEQ  ADASHP_50              ;DO IT IF AN EMPTY SLOT
P3_8E66:  LDX  S1_PRM
P3_8E68:  LEAX AS_IZE,X
P3_8E6B:  CMPX #ALIENZ
P3_8E6E:  BLO  P3_8E60                ;HSEND
P3_8E70:  BRA  P3_8ED2                ;IF NO SLOTS AVAILABLE, EXIT NOW

ADASHP_50:
P3_8E72:  LDU  WV_LP
P3_8E74:  BEQ  P3_8ED2                ;IGNORE ALIEN IF NO CHOREOG SET
P3_8E76:  LDA  ,U
P3_8E78:  BEQ  P3_8ED2                ;?CONSTRUCT THIS SHIP?
P3_8E7A:  INC  WV_LIV                 ;ONE MORE LIFE IN THIS WAVE
P3_8E7C:  LDD  ,U
P3_8E7E:  STD  WV_SHP                 ;SHIP SHAPE AND PARMS
P3_8E80:  LDD  2,U
P3_8E82:  STD  WV_CHP                 ;CHOREOGRAPHY
P3_8E84:  LDD  4,U
P3_8E86:  STD  WV_BGP                 ;BEGIN LOCATION
P3_8E88:  LEAU 6,U
P3_8E8A:  STU  WV_LP
P3_8E8C:  LDA  #$01
P3_8E8E:  STA  AS_TYP,X               ;LIVE ALIEN
P3_8E90:  LDU  ,X
P3_8E92:  JSR  UNITV
P3_8E95:  LDU  ,X
P3_8E97:  LDA  #$C0                   ;FACE ALIEN TOWARDS PLAYER
P3_8E99:  STA  MS_AX,U
P3_8E9B:  STA  MS_BY,U
P3_8E9D:  CLRA
P3_8E9E:  STA  10,X                   ;forced roll timer, byte 10
P3_8EA0:  STA  9,X                    ;byte 9, in ESB's record the damage count (Star Wars AS_DMC, which is 8 there)
P3_8EA2:  STA  7,X                    ;glow timer, byte 7
P3_8EA4:  STA  6,X                    ;byte 6, in ESB's record the process of dying (Star Wars AS_DIE, which is 5 there)
P3_8EA6:  STA  12,X                   ;byte 12 (Star Wars AS_TRGT)
P3_8EA8:  LDU  WV_SHP
P3_8EAA:  LDA  1,U                    ;DRONES DIE ON N HITS
P3_8EAC:  STA  8,X                    ;hits left, byte 8
P3_8EAE:  LDU  ,X
P3_8EB0:  LDX  WV_BGP                 ;BEGINNING LOCATION
P3_8EB2:  LDD  ,X
P3_8EB4:  STD  MS_TX,U
P3_8EB6:  LDD  2,X
P3_8EB8:  STD  MS_TY,U
P3_8EBA:  LDD  4,X
P3_8EBC:  STD  MS_TZ,U
P3_8EBE:  LDX  S1_PRM
P3_8EC0:  LDD  WV_CHP
P3_8EC2:  STD  AS_CHPC,X
P3_8EC4:  JSR  NWCHOR
P3_8EC7:  LDX  S1_PRM
P3_8EC9:  LDB  [WV_SHP]               ;first byte of the shape entry: the object number
P3_8ECD:  STB  5,X                    ;picture number, byte 5
P3_8ECF:  JSR  L60A8                  ;ESB: load the object's points here too (bank 1 KD868)
P3_8ED2:  RTS

TS_TIE_P3:
P3_8ED3:  .byte $00, $01              ;shape entry .WS TIE,1: object 0, 1 hit. the only shape entry, Star Wars' TS_RTH for Darth Vader's ship is gone

TBG1A1_P3:
P3_8ED5:  .word $7C00, $0000, $2000   ;starting locations, x y z words, front to back, left to right, top to bottom as in Star Wars but 8 times as far apart sideways: 1A1 0,0,$2000

TBG1A2_P3:
P3_8EDB:  .word $7C00, $E000, $0000   ;1A2 0,-$2000,0

TBG1A3_P3:
P3_8EE1:  .word $7C00, $2000, $0000   ;1A3 0,$2000,0

TBG1B1_P3:
P3_8EE7:  .word $7C00, $0000, $2000   ;1B1 0,0,$2000

TBG1B2_P3:
P3_8EED:  .word $7C00, $E000, $0000   ;1B2 0,-$2000,0

TBG1B3_P3:
P3_8EF3:  .word $7C00, $2000, $0000   ;1B3 0,$2000,0

TBG1C1_P3:
P3_8EF9:  .word $7C00, $0000, $2000   ;1C1 0,0,$2000

TBG1C2_P3:
P3_8EFF:  .word $7C00, $E000, $0000   ;1C2 0,-$2000,0

TBG1C3_P3:
P3_8F05:  .word $7C00, $2000, $0000   ;1C3 0,$2000,0

TBG1D1_P3:
P3_8F0B:  .word $7C00, $C000, $0000   ;1D1 0,-$4000,0

TBG1D2_P3:
P3_8F11:  .word $7C00, $4000, $0000   ;1D2 0,$4000,0

TBG1D3_P3:
P3_8F17:  .word $7C00, $0000, $4000   ;1D3 0,0,$4000

TSPWAV_P3:
P3_8F1D:  .word SETA1_P3              ;table of space wave sets, one for each TIE fighter level SP_WAV 0-5
P3_8F1F:  .word SETA2_P3
P3_8F21:  .word SETA3_P3
P3_8F23:  .word SETA4_P3
P3_8F25:  .word SETA5_P3              ;the set before the last, used past the table on even levels
P3_8F27:  .word SETA6_P3              ;the last set, used past the table on odd levels

SETA1_P3:
P3_8F29:  .byte $03                   ;set A1: number of lists less 1, then TWV1A, TWV2B, TWV2C, TWV2Z. also the end of TSPWAV (Star Wars ZSPWAV)
P3_8F2A:  .word TWV1A_P3
P3_8F2C:  .word TWV2B_P3
P3_8F2E:  .word TWV2C_P3
P3_8F30:  .word TWV2Z_P3

SETA2_P3:
P3_8F32:  .byte $04                   ;set A2: TWV1B, TRTH1D, TWV2D, TWV2C, TWV2Z
P3_8F33:  .word TWV1B_P3
P3_8F35:  .word TRTH1D_P3
P3_8F37:  .word TWV2D_P3
P3_8F39:  .word TWV2C_P3
P3_8F3B:  .word TWV2Z_P3

SETA3_P3:
P3_8F3D:  .byte $06                   ;set A3: TWV1C, TRTH1D, TWV2D, TWV2A, TWV2B, TWV2C, TWV2Z
P3_8F3E:  .word TWV1C_P3
P3_8F40:  .word TRTH1D_P3
P3_8F42:  .word TWV2D_P3
P3_8F44:  .word TWV2A_P3
P3_8F46:  .word TWV2B_P3
P3_8F48:  .word TWV2C_P3
P3_8F4A:  .word TWV2Z_P3

SETA4_P3:
P3_8F4C:  .byte $05                   ;set A4: TRTH1D, TWV2D, TWV2A, TWV2B, TWV2C, TWV2Z
P3_8F4D:  .word TRTH1D_P3
P3_8F4F:  .word TWV2D_P3
P3_8F51:  .word TWV2A_P3
P3_8F53:  .word TWV2B_P3
P3_8F55:  .word TWV2C_P3
P3_8F57:  .word TWV2Z_P3

SETA5_P3:
P3_8F59:  .byte $05                   ;set A5: TWV1D, TRTH1D, TWV2C, TWV2D, TWV2B, TWV2Z
P3_8F5A:  .word TWV1D_P3
P3_8F5C:  .word TRTH1D_P3
P3_8F5E:  .word TWV2C_P3
P3_8F60:  .word TWV2D_P3
P3_8F62:  .word TWV2B_P3
P3_8F64:  .word TWV2Z_P3

SETA6_P3:
P3_8F66:  .byte $05                   ;set A6: TRTH1D, TWV2D, TWV2B, TWV2D, TWV2C, TWV2Z
P3_8F67:  .word TRTH1D_P3
P3_8F69:  .word TWV2D_P3
P3_8F6B:  .word TWV2B_P3
P3_8F6D:  .word TWV2D_P3
P3_8F6F:  .word TWV2C_P3
P3_8F71:  .word TWV2Z_P3

TWV1A_P3:
P3_8F73:  .word TS_TIE_P3             ;wave list: for each ship three words - shape entry, choreography, starting location - and a 0 byte at the end. .WV TIE,1A1,1A1 / 1A2 / 1A3
P3_8F75:  .word TCH1A1_P3
P3_8F77:  .word TBG1A1_P3
P3_8F79:  .word TS_TIE_P3
P3_8F7B:  .word TCH1A2_P3
P3_8F7D:  .word TBG1A2_P3
P3_8F7F:  .word TS_TIE_P3
P3_8F81:  .word TCH1A3_P3
P3_8F83:  .word TBG1A3_P3
P3_8F85:  .byte $00

TWV1B_P3:
P3_8F86:  .word TS_TIE_P3             ;.WV TIE,1B1,1B1 / 1B2 / 1B3
P3_8F88:  .word TCH1B1_P3
P3_8F8A:  .word TBG1B1_P3
P3_8F8C:  .word TS_TIE_P3
P3_8F8E:  .word TCH1B2_P3
P3_8F90:  .word TBG1B2_P3
P3_8F92:  .word TS_TIE_P3
P3_8F94:  .word TCH1B3_P3
P3_8F96:  .word TBG1B3_P3
P3_8F98:  .byte $00

TWV1C_P3:
P3_8F99:  .word TS_TIE_P3             ;.WV TIE,1C1,1C1 / 1C2 / 1C3
P3_8F9B:  .word TCH1C1_P3
P3_8F9D:  .word TBG1C1_P3
P3_8F9F:  .word TS_TIE_P3
P3_8FA1:  .word TCH1C2_P3
P3_8FA3:  .word TBG1C2_P3
P3_8FA5:  .word TS_TIE_P3
P3_8FA7:  .word TCH1C3_P3
P3_8FA9:  .word TBG1C3_P3
P3_8FAB:  .byte $00

TWV1D_P3:
P3_8FAC:  .word TS_TIE_P3             ;.WV TIE,1D1,1D1 / 1D2 / 1D3
P3_8FAE:  .word TCH1D1_P3
P3_8FB0:  .word TBG1D1_P3
P3_8FB2:  .word TS_TIE_P3
P3_8FB4:  .word TCH1D2_P3
P3_8FB6:  .word TBG1D2_P3
P3_8FB8:  .word TS_TIE_P3
P3_8FBA:  .word TCH1D3_P3
P3_8FBC:  .word TBG1D3_P3
P3_8FBE:  .byte $00

TRTH1D_P3:
P3_8FBF:  .word TS_TIE_P3             ;Star Wars' list with Darth Vader as the third ship: here the same three TIE fighters as TWV1D
P3_8FC1:  .word TCH1D1_P3
P3_8FC3:  .word TBG1D1_P3
P3_8FC5:  .word TS_TIE_P3
P3_8FC7:  .word TCH1D2_P3
P3_8FC9:  .word TBG1D2_P3
P3_8FCB:  .word TS_TIE_P3
P3_8FCD:  .word TCH1D3_P3
P3_8FCF:  .word TBG1D3_P3
P3_8FD1:  .byte $00

TWV2A_P3:
P3_8FD2:  .word TS_TIE_P3             ;.WV TIE,2A1,1A1 / 2A2 / 2A3: the 2 choreographies start with a gosub of SPLIT
P3_8FD4:  .word TCH2A1_P3
P3_8FD6:  .word TBG1A1_P3
P3_8FD8:  .word TS_TIE_P3
P3_8FDA:  .word TCH2A2_P3
P3_8FDC:  .word TBG1A2_P3
P3_8FDE:  .word TS_TIE_P3
P3_8FE0:  .word TCH2A3_P3
P3_8FE2:  .word TBG1A3_P3
P3_8FE4:  .byte $00

TWV2B_P3:
P3_8FE5:  .word TS_TIE_P3             ;.WV TIE,2B1,1B1 / 2B2 / 2B3
P3_8FE7:  .word TCH2B1_P3
P3_8FE9:  .word TBG1B1_P3
P3_8FEB:  .word TS_TIE_P3
P3_8FED:  .word TCH2B2_P3
P3_8FEF:  .word TBG1B2_P3
P3_8FF1:  .word TS_TIE_P3
P3_8FF3:  .word TCH2B3_P3
P3_8FF5:  .word TBG1B3_P3
P3_8FF7:  .byte $00

TWV2C_P3:
P3_8FF8:  .word TS_TIE_P3             ;.WV TIE,2C1,1C1 / 2C2 / 2C3
P3_8FFA:  .word TCH2C1_P3
P3_8FFC:  .word TBG1C1_P3
P3_8FFE:  .word TS_TIE_P3
P3_9000:  .word TCH2C2_P3
P3_9002:  .word TBG1C2_P3
P3_9004:  .word TS_TIE_P3
P3_9006:  .word TCH2C3_P3
P3_9008:  .word TBG1C3_P3
P3_900A:  .byte $00

TWV2D_P3:
P3_900B:  .word TS_TIE_P3             ;.WV TIE,2D1,1D1 / 2D2 / 2D3
P3_900D:  .word TCH2D1_P3
P3_900F:  .word TBG1D1_P3
P3_9011:  .word TS_TIE_P3
P3_9013:  .word TCH2D2_P3
P3_9015:  .word TBG1D2_P3
P3_9017:  .word TS_TIE_P3
P3_9019:  .word TCH2D3_P3
P3_901B:  .word TBG1D3_P3
P3_901D:  .byte $00

TWV2Z_P3:
P3_901E:  .word TS_TIE_P3             ;the last list of every set, 18 ships: 2A, 2D, 2B, 2D, 2C, 2D
P3_9020:  .word TCH2A1_P3
P3_9022:  .word TBG1A1_P3
P3_9024:  .word TS_TIE_P3
P3_9026:  .word TCH2A2_P3
P3_9028:  .word TBG1A2_P3
P3_902A:  .word TS_TIE_P3
P3_902C:  .word TCH2A3_P3
P3_902E:  .word TBG1A3_P3
P3_9030:  .word TS_TIE_P3
P3_9032:  .word TCH2D1_P3
P3_9034:  .word TBG1D1_P3
P3_9036:  .word TS_TIE_P3
P3_9038:  .word TCH2D2_P3
P3_903A:  .word TBG1D2_P3
P3_903C:  .word TS_TIE_P3
P3_903E:  .word TCH2D3_P3
P3_9040:  .word TBG1D3_P3
P3_9042:  .word TS_TIE_P3
P3_9044:  .word TCH2B1_P3
P3_9046:  .word TBG1B1_P3
P3_9048:  .word TS_TIE_P3
P3_904A:  .word TCH2B2_P3
P3_904C:  .word TBG1B2_P3
P3_904E:  .word TS_TIE_P3
P3_9050:  .word TCH2B3_P3
P3_9052:  .word TBG1B3_P3
P3_9054:  .word TS_TIE_P3
P3_9056:  .word TCH2D1_P3
P3_9058:  .word TBG1D1_P3
P3_905A:  .word TS_TIE_P3
P3_905C:  .word TCH2D2_P3
P3_905E:  .word TBG1D2_P3
P3_9060:  .word TS_TIE_P3
P3_9062:  .word TCH2D3_P3
P3_9064:  .word TBG1D3_P3
P3_9066:  .word TS_TIE_P3
P3_9068:  .word TCH2C1_P3
P3_906A:  .word TBG1C1_P3
P3_906C:  .word TS_TIE_P3
P3_906E:  .word TCH2C2_P3
P3_9070:  .word TBG1C2_P3
P3_9072:  .word TS_TIE_P3
P3_9074:  .word TCH2C3_P3
P3_9076:  .word TBG1C3_P3
P3_9078:  .word TS_TIE_P3
P3_907A:  .word TCH2D1_P3
P3_907C:  .word TBG1D1_P3
P3_907E:  .word TS_TIE_P3
P3_9080:  .word TCH2D2_P3
P3_9082:  .word TBG1D2_P3
P3_9084:  .word TS_TIE_P3
P3_9086:  .word TCH2D3_P3
P3_9088:  .word TBG1D3_P3
P3_908A:  .byte $00

man_tie_chor:
P3_908B:  .byte $24, $00, $00, $14, $10, $00, $14, $04 ;choreography of the training manual's TIE fighter, 3 bytes a step: twirl for 18 frames with no flags, then yaw right, pitch up and roll left for 10 frames each, over and over, never moving
P3_9093:  .byte $00, $14, $01, $00, $01, $90, $8E

TCH2A1_P3:
P3_909A:  .byte $02, $92, $DD         ;choreography steps are 3 bytes: op $00 until (status mask word), $80 if (mask word), 1 goto, 2 gosub, 3 return (address word), else low bits 4 = twirl for op/2 frames with twirl flags and move flags. the times are half Star Wars' (first byte n*4+4 for n*8+4)

TCH1A1_P3:
P3_909D:  .byte $44, $00, $10, $44, $00, $20, $24, $04 ;1A1: forward, forward fast, pitch up, then aim at the player until he is in its sights
P3_90A5:  .byte $10, $00, $00, $04, $24, $80, $00, $00
P3_90AD:  .byte $04, $00, $44, $81, $10, $00, $00, $04
P3_90B5:  .byte $24, $80, $00, $00, $00, $00, $01, $91
P3_90BD:  .byte $18

TCH2A2_P3:
P3_90BE:  .byte $02, $92, $DD

TCH1A2_P3:
P3_90C1:  .byte $44, $02, $20, $24, $10, $10, $00, $00 ;1A2: roll right and yaw right, aiming
P3_90C9:  .byte $04, $24, $90, $10, $00, $00, $00, $44
P3_90D1:  .byte $02, $10, $00, $00, $04, $24, $90, $10
P3_90D9:  .byte $00, $00, $00, $24, $02, $20, $00, $00
P3_90E1:  .byte $04, $24, $90, $10, $00, $00, $00, $01
P3_90E9:  .byte $91, $18

TCH2A3_P3:
P3_90EB:  .byte $02, $92, $DD

TCH1A3_P3:
P3_90EE:  .byte $44, $01, $20, $24, $20, $10, $00, $00 ;1A3: the mirror image, roll left and yaw left
P3_90F6:  .byte $04, $24, $A0, $10, $00, $00, $00, $44
P3_90FE:  .byte $01, $10, $00, $00, $04, $24, $A0, $10
P3_9106:  .byte $00, $00, $00, $24, $01, $20, $00, $00
P3_910E:  .byte $04, $24, $A0, $10
P3_9112:  .byte $00                   ;.CUNTIL 0
P3_9113:  .word $0000
P3_9115:  .byte $01
P3_9116:  .word TCH1AZ_P3

TCH1AZ_P3:
P3_9118:  .byte $00                   ;.CUNTIL C$AS+C$AG
P3_9119:  .word CS_AS+CS_AG
P3_911B:  .byte $24, $82, $20, $00, $00, $40, $24, $01 ;be mean to player, Star Wars' TCH1AZ: roll right aiming and fast forward until it has fired, roll left away, up, again
P3_9123:  .byte $20, $01, $91, $18, $00, $00, $00, $14
P3_912B:  .byte $00, $08
P3_912D:  .byte $01                   ;.CGOTO 10$
P3_912E:  .word TCH1AZ_P3

TCH2B1_P3:
P3_9130:  .byte $02                   ;.CGOSUB SPLIT
P3_9131:  .word SPLIT_P3

TCH1B1_P3:
P3_9133:  .byte $24, $00, CS_MF+CS_MU ;.CT 10,0,C$MF+C$MU
P3_9136:  .byte $24, $00, CS_MF+CS_MD ;.CT 10,0,C$MF+C$MD  PARTNERS PASS PLAYER
P3_9139:  .byte $24, $00, CS_MF+CS_MU ;.CT 10,0,C$MF+C$MU
P3_913C:  .byte $24, $00, CS_MF+CS_MD ;.CT 10,0,C$MF+C$MD
P3_913F:  .byte $24, $04, $10, $00, $00, $04, $24, $80
P3_9147:  .byte $00, $00, $00, $00, $24, $00, $14, $24
P3_914F:  .byte $00, $11, $44, $80, $14, $24, $00, $14
P3_9157:  .byte $24, $00, $11, $00, $00, $04, $24, $80
P3_915F:  .byte $04, $00, $00, $00, $01, $91, $A5

TCH2B2_P3:
P3_9166:  .byte $02, $92, $DD

TCH1B2_P3:
P3_9169:  .byte $14, $00, $18, $14, $00, $12, $14, $00 ;1B2: fast weave up and down, then aim while moving down, then up
P3_9171:  .byte $28, $14, $00, $22, $00, $00, $04, $24
P3_9179:  .byte $80, $11, $00, $00, $00, $00, $00, $04
P3_9181:  .byte $24, $80, $14, $00, $00, $00, $01, $91
P3_9189:  .byte $A5

TCH2B3_P3:
P3_918A:  .byte $02, $92, $DD

TCH1B3_P3:
P3_918D:  .byte $14, $00, $18, $14, $00, $12, $14, $00 ;1B3: the same, aiming while moving down
P3_9195:  .byte $28, $14, $00, $22, $00, $00, $04, $24
P3_919D:  .byte $80, $11, $00, $00, $00, $01, $91, $A5

TCH1BZ_P3:
P3_91A5:  .byte $00, $00, $44, $24, $82, $20, $00, $00 ;be mean to player, Star Wars' TCH1BZ. its step at $91BD is a twirl whose time byte came out as $80 (.CT 80 in Star Wars, $FC there): the interpreter reads it as an if with mask $8210
P3_91AD:  .byte $40, $24, $02, $20, $01, $91, $A5, $00
P3_91B5:  .byte $00, $00, $14, $00, $08, $00, $04, $00
P3_91BD:  .byte $80, $82, $10, $00, $00, $00, $24, $82
P3_91C5:  .byte $08, $24, $81, $02, $24, $81, $08, $24
P3_91CD:  .byte $82, $02, $01, $91, $A5

TCH2C1_P3:
P3_91D2:  .byte $02, $92, $DD

TCH1C1_P3:
P3_91D5:  .byte $14, $00, $14, $14, $00, $11, $14, $00 ;1C1: short weave, pitch up, aim
P3_91DD:  .byte $14, $14, $00, $11, $24, $04, $10, $00
P3_91E5:  .byte $00, $04, $24, $80, $00, $00, $00, $00
P3_91ED:  .byte $00, $00, $04, $24, $80, $04, $00, $00
P3_91F5:  .byte $00

TCH2C2_P3:
P3_91F6:  .byte $02, $92, $DD

TCH1C2_P3:
P3_91F9:  .byte $24, $82, $14, $24, $82, $24, $24, $10 ;1C2: roll right aiming while climbing, yaw right
P3_9201:  .byte $14, $00, $00, $04, $24, $90, $14, $00
P3_9209:  .byte $00, $00, $01, $92, $26

TCH2C3_P3:
P3_920E:  .byte $02, $92, $DD

TCH1C3_P3:
P3_9211:  .byte $24, $81, $14, $24, $81, $24, $24, $20 ;1C3: the mirror image
P3_9219:  .byte $14, $00, $00, $04, $24, $A0, $14, $00
P3_9221:  .byte $00, $00, $01, $92, $26

TCH1CZ_P3:
P3_9226:  .byte $00, $00, $44, $24, $82, $24, $00, $00 ;be mean to player, Star Wars' TCH1CZ
P3_922E:  .byte $40, $24, $01, $20, $01, $92, $26, $00
P3_9236:  .byte $00, $00, $14, $00, $02, $01, $92, $26

TCH2D1_P3:
P3_923E:  .byte $02, $92, $DD

TCH1D1_P3:
P3_9241:  .byte $00, $04, $00, $80, $82, $18, $00, $00 ;1D1: wait for the player to come near, then the four long rolls of Star Wars, whose time bytes are $80 here and read as ifs
P3_9249:  .byte $00, $80, $82, $08, $80, $82, $08, $80
P3_9251:  .byte $82, $08, $80, $82, $08, $00, $00, $04
P3_9259:  .byte $24, $81, $08, $00, $00, $00, $01, $93
P3_9261:  .byte $16

TCH2D2_P3:
P3_9262:  .byte $02, $92, $DD

TCH1D2_P3:
P3_9265:  .byte $00, $04, $00, $80, $82, $18, $00, $00 ;1D2: wait for the player to come near, rolls left and right picked by random bit 1
P3_926D:  .byte $00, $44, $81, $08, $80, $00, $10, $24
P3_9275:  .byte $82, $08, $80, $00, $00, $44, $81, $08
P3_927D:  .byte $80, $00, $10, $24, $81, $08, $80, $00
P3_9285:  .byte $00, $44, $81, $08, $00, $00, $04, $24
P3_928D:  .byte $82, $08, $00, $00, $00, $01, $93, $16

TCH2D3_P3:
P3_9295:  .byte $02, $92, $DD

TCH1D3_P3:
P3_9298:  .byte $00, $04, $00, $0C, $80, $18, $0C, $80 ;1D3: wait for the player to come near, zigzag up and down aiming, evade with yaw and pitch pairs when a ship near by is hit
P3_92A0:  .byte $12, $0C, $80, $18, $0C, $80, $12, $0C
P3_92A8:  .byte $80, $18, $0C, $80, $12, $0C, $80, $18
P3_92B0:  .byte $0C, $80, $12, $00, $00, $00, $00, $00
P3_92B8:  .byte $01, $24, $B0, $08, $24, $8C, $08, $24
P3_92C0:  .byte $B0, $02, $24, $8C, $02, $24, $B0, $08
P3_92C8:  .byte $24, $8C, $08, $24, $B0, $02, $24, $8C
P3_92D0:  .byte $02, $00, $00, $04, $24, $81, $10
P3_92D7:  .byte $00                   ;.CUNTIL 0
P3_92D8:  .word $0000
P3_92DA:  .byte $01                   ;.CGOTO TCH1DZ
P3_92DB:  .word TCH1DZ_P3

SPLIT_P3:
P3_92DD:  .byte $08, $80, $10, $80, $00, $10, $01, $92 ;SPLIT, the opening of the 2 choreographies: by the random bits R1 and R2 one of four ways off - up or down, with or without a roll right - then by R2 a roll left aiming ahead of the player, and return. the first step is Star Wars' .CT 01, $08 here, which reads as an if with mask $8010 (R1)
P3_92E5:  .byte $F8, $80, $00, $20, $24, $80, $3C, $01
P3_92ED:  .byte $93, $0A, $80, $00, $00, $24, $80, $33
P3_92F5:  .byte $01, $93, $0A

SPLIT_20_P3:
P3_92F8:  .byte $80, $00, $20, $24, $82, $3C, $01, $93 ;SPLIT 20$: the two ways with a roll right
P3_9300:  .byte $0A, $80, $00, $00, $24, $82, $33, $01
P3_9308:  .byte $93, $0A

SPLIT_40_P3:
P3_930A:  .byte $80, $00, $20, $24, $41, $20 ;SPLIT 40$
P3_9310:  .byte $80                   ;.CIF 0
P3_9311:  .word $0000
P3_9313:  .byte $03                   ;.CRETURN
P3_9314:  .word $0000

TCH1DZ_P3:
P3_9316:  .byte $14, $00, $08, $00, $04, $00, $44, $81 ;be mean to player, Star Wars' TCH1DZ
P3_931E:  .byte $20, $00, $00, $44, $24, $82, $20, $00
P3_9326:  .byte $00, $40, $24, $01, $10, $00, $00, $00
P3_932E:  .byte $00, $0C, $00, $44, $81, $20, $00, $08
P3_9336:  .byte $44, $24, $82, $20, $00, $08, $40, $24
P3_933E:  .byte $01, $10, $00, $00, $00, $80, $08, $00
P3_9346:  .byte $01, $93, $4F, $80, $00, $00, $01, $93
P3_934E:  .byte $16

TCH1DZ_20_P3:
P3_934F:  .byte $80, $00, $10, $24, $02, $08, $01, $93 ;TCH1DZ 20$: the player has it in his sights, break away up or forward by random bit 1
P3_9357:  .byte $16, $80, $00, $00, $24, $01, $20, $01
P3_935F:  .byte $93, $16

tie_copy_tail:
P3_9361:  .byte $C8, $20, $CB, $04, $30, $88, $19, $8C ;from here to $9560 the bytes are those of page 2 at the same addresses, a copy of the ship code assembled elsewhere and not reached on this page: these 16 are the end of its record loop (LEAU $20,U less its first byte, ADDB #4, LEAX $19,X, CMPX #ALIENZ, BLO, JSR $9ACC, RTS)
P3_9369:  .byte $4A, $1D, $25, $E9, $BD, $9A, $CC, $39

;------------------------------------------------------------------------------
; tie_setup_copy - not reached on this page. from $9361 to $9560 page 3 holds the same bytes as page 2 (and from
;   $9472 on as page 0): a copy of the code at P3_8613-P3_87FF assembled at other addresses. this routine is
;   man_tie_setup again and SNVW and S2VW follow it. its JSR $9A1A is NWCHOR on page 0, on this page it lands in
;   the middle of xmit_trail_shift, and its choreography address $9C56 does not fit this page either. no maze
;   entry and no code of page 3 calls it
;------------------------------------------------------------------------------
tie_setup_copy:
P3_9371:  LDX  #ALIEN
P3_9374:  LDU  #M_AL
P3_9377:  LDB  #$1C
P3_9379:  LDA  #$08
P3_937B:  STA  4,X
P3_937D:  CLR  3,X
P3_937F:  STU  ,X
P3_9381:  STB  AS_BIC,X
P3_9383:  LEAU $20,U
P3_9386:  ADDB #$04
P3_9388:  LEAX AS_IZE,X
P3_938B:  CMPX #ALIENZ
P3_938E:  BLO  P3_9379
P3_9390:  LDX  #ALIEN
P3_9393:  LDA  #$01
P3_9395:  STA  AS_TYP,X               ;LIVE ALIEN
P3_9397:  LDU  ,X
P3_9399:  JSR  UNITV
P3_939C:  LDU  ,X
P3_939E:  LDA  #$C0                   ;FACE ALIEN TOWARDS PLAYER
P3_93A0:  STA  MS_AX,U
P3_93A2:  STA  MS_BY,U
P3_93A4:  LDD  #$1000
P3_93A7:  STD  8,U
P3_93A9:  LDD  #$0000
P3_93AC:  STD  10,U
P3_93AE:  LDD  #$0000
P3_93B1:  STD  12,U
P3_93B3:  CLRA
P3_93B4:  STA  10,X
P3_93B6:  STA  9,X
P3_93B8:  STA  7,X
P3_93BA:  STA  6,X
P3_93BC:  STA  12,X
P3_93BE:  LDA  #$01
P3_93C0:  STA  8,X
P3_93C2:  LDD  #$9C56                 ;the copy's choreography address, which is not one on this page
P3_93C5:  STD  13,X
P3_93C7:  JSR  xmit_above_tst         ;NWCHOR in the copy's build (and on page 0), on this page the middle of xmit_trail_shift
P3_93CA:  LDB  #$00
P3_93CC:  STB  5,X
P3_93CE:  JSR  L60A8
P3_93D1:  RTS

;------------------------------------------------------------------------------
; P3_93D2
;   (no caller found)
;------------------------------------------------------------------------------
P3_93D2:  LDX  #ALIEN                 ;SHIP PARAMS
P3_93D5:  STX  S2_PRM
P3_93D7:  LDA  AS_TYP,X
P3_93D9:  BEQ  P3_93DE                ;?SOMEWHAT ALIVE?
P3_93DB:  JSR  s2vw_old_p3            ;VIEW THE SHIP
P3_93DE:  LDX  S2_PRM                 ;NEXT SHIP
P3_93E0:  LEAX AS_IZE,X
P3_93E3:  CMPX #ALIENZ
P3_93E6:  BLO  P3_93D5
P3_93E8:  RTS

;------------------------------------------------------------------------------
; s2vw_old_p3 - VIEW THE SHIP  (comment at the call)
;   in ESB: part of the stale copy at $9361-$9560, cut off after 10 words of its colour table by TSTLAZ at
;   $9561. only its last instructions matter on this page: lz_hit_probot and lz_hit_space read $9548 and $9540
;   to put the slapstic in its bitwise mode
;------------------------------------------------------------------------------
s2vw_old_p3:
P3_93E9:  LDX  S2_PRM
P3_93EB:  CLRA
P3_93EC:  LDB  AS_BIC,X
P3_93EE:  ADDB #$03
P3_93F0:  STD  M_BIC
P3_93F3:  LDA  #MS_PSB2
P3_93F5:  JSR  MGOWT
P3_93F8:  LDA  M_XP
P3_93FB:  LSLA                        ;-4000<X<4000 FOR VALID SQUARING
P3_93FC:  BVS  P3_9471
P3_93FE:  LDA  M_YP
P3_9401:  LSLA
P3_9402:  BVS  P3_9471
P3_9404:  LDA  M_ZP
P3_9407:  LSLA
P3_9408:  BVS  P3_9471
P3_940A:  LDD  M_XPS                  ;CHECK FOR COLLISION
P3_940D:  ADDD M_YPS
P3_9410:  ADDD M_ZPS
P3_9413:  TFR  D,U
P3_9415:  CMPU #$0900
P3_9419:  BHI  P3_9423                ;IFLS  ?PLAYER AT MIDDISTANCE?
P3_941B:  LDD  AS_CHST,X
P3_941E:  ORA  #((CS_PM&$FF00)/$100)  ;CHSET C$PM  THEN SET PLAYER MIDDLE DISTANCE
P3_9420:  STD  AS_CHST,X
P3_9423:  CMPU #$0100
P3_9427:  BHI  P3_9431                ;IFLS  ?PLAYER NEARBY?
P3_9429:  LDD  AS_CHST,X
P3_942C:  ORA  #((CS_PN&$FF00)/$100)  ;CHSET C$PN  THEN SET PLAYER NEAR
P3_942E:  STD  AS_CHST,X
P3_9431:  CMPU #$00A0
P3_9435:  BHI  P3_9467                ;IFLS  ?PLAYER NEARBY?
P3_9437:  LDA  Q_PBB
P3_943A:  BNE  P3_944C                ;IFEQ  ?NO SHIP CURRENTLY PASSING BY?
P3_943C:  LDA  AS_BIC,X
P3_943E:  STA  Q_PBB                  ;THEN START THIS SHIP PASSING BY
P3_9441:  JSR  spk_cmd_06
P3_9444:  JSR  aud_cmd_35
P3_9447:  STU  Q_PBD                  ;INIT CURRENT DISTANCE
P3_944A:  BRA  P3_9465                ;ELSE  ELSE IS BIC OF SHIP IS PASSING BY
P3_944C:  CMPA AS_BIC,X
P3_944E:  BNE  P3_9465                ;IFEQ  ?IS THIS THE SHIP CURRENTLY PASSINGBY?
P3_9450:  CMPU Q_PBD                  ;THEN CHECK FOR CHANGES IN DISTANCE AWAY
P3_9454:  BGT  P3_945B                ;IFLE  ?NOT MOVING AWAY YET? NOTE SIGNED FLAG TEST
P3_9456:  STU  Q_PBD                  ;THEN SAVE THIS LATEST DISTANCE
P3_9459:  BRA  P3_9465                ;ELSE  ELSE IS DEFINITLY MOVING AWAY
P3_945B:  BLO  P3_9465                ;IFHS  ?MINUS FLAG STILL CLEAR? ONE TIME ONLY
P3_945D:  LDA  #$FF
P3_945F:  STA  Q_PBD                  ;SET DISTANCE TO MINUS, END PASSBY FLAG
P3_9462:  JSR  aud_cmd_39
P3_9465:  BRA  P3_9471                ;ELSE  ELSE NOT NEAR TO PLAYER
P3_9467:  LDA  AS_BIC,X
P3_9469:  CMPA Q_PBB
P3_946C:  BNE  P3_9471                ;IFEQ  ?WAS THIS THE SHIP DOING A PASSBY?
P3_946E:  CLR  Q_PBB                  ;THEN PREPARE FOR NEXT SHIP
P3_9471:  LDD  M_XP
P3_9474:  CMPD #$0010
P3_9478:  LBLE P3_93E8
P3_947C:  CMPD #$7F00
P3_9480:  LBHI P3_93E8
P3_9484:  STD  M_DVD
P3_9487:  STD  M_XT
P3_948A:  LDD  M_YP
P3_948D:  STD  M_YT
P3_9490:  LDD  M_YPS
P3_9493:  SUBD M_XPS                  ;X SQUARED
P3_9496:  LBHS P3_93E8                ;B OUT OF VIEW
P3_949A:  LDD  M_ZP
P3_949D:  STD  M_ZT
P3_94A0:  LDD  M_ZPS
P3_94A3:  SUBD M_XPS                  ;X SQUARED
P3_94A6:  LBHS P3_93E8
P3_94AA:  LDX  S2_PRM
P3_94AC:  LDD  AS_CHST,X
P3_94AF:  ORA  #((CS_PV&$FF00)/$100)  ;CHSET C$PV  WITHIN PLAYERS VIEW SCREEN
P3_94B1:  STD  AS_CHST,X
P3_94B4:  LDA  AS_BIC,X
P3_94B6:  JSR  IS2UV                  ;DOWNLOAD SHIP 2 UNIT VECTORS
P3_94B9:  JSR  L60B4
P3_94BC:  LDD  #$0050                 ;JUST TRY IT -- SHUT DOWN CPU AND TEST
P3_94BF:  STD  M_YP                   ;GET SHIP SIZE
P3_94C2:  LDA  #MS_PERS
P3_94C4:  JSR  MGOWT
P3_94C7:  LDD  M_YP
P3_94CA:  ADDD #$000A                 ;ADDIN CURSOR SIZE
P3_94CD:  STD  TMPSIZ_4801
P3_94CF:  LDD  >BJ_CX
P3_94D2:  SUBD >LZ_CX
P3_94D5:  BPL  P3_94DB                ;IFMI
P3_94D7:  COMA                        ;NEGD  ABSD
P3_94D8:  NEGB
P3_94D9:  SBCA #$FF
P3_94DB:  STD  TMPXD                  ;SAVE X DISTANCE
P3_94DD:  STD  TMPOCT_4803            ;PREPARE FOR OCTAGON COLLISION DETECT
P3_94DF:  LDD  >BJ_CY
P3_94E2:  SUBD >LZ_CY
P3_94E5:  BPL  P3_94EB                ;IFMI
P3_94E7:  COMA                        ;NEGD
P3_94E8:  NEGB
P3_94E9:  SBCA #$FF
P3_94EB:  STD  TMPYD                  ;SAVE Y DISTANCE
P3_94ED:  ADDD TMPOCT_4803
P3_94EF:  STD  TMPOCT_4803            ;OCTAGON CHECK
P3_94F1:  LDD  TMPXD
P3_94F3:  SUBD TMPSIZ_4801
P3_94F5:  BGT  P3_9515                ;IFLE  LE FOR LIBERALITY
P3_94F7:  LDD  TMPYD
P3_94F9:  SUBD TMPSIZ_4801
P3_94FB:  BGT  P3_9515                ;IFLE  ?WITHIN Y ALSO?
P3_94FD:  LDD  TMPSIZ_4801
P3_94FF:  LSRA                        ;LSRD
P3_9500:  RORB
P3_9501:  ADDD TMPSIZ_4801            ;MAKE 1.5 FOR OCTAGON
P3_9503:  SUBD TMPOCT_4803
P3_9505:  BLT  P3_9515                ;IFGE  ?ALSO WITHIN OCTAGON?
P3_9507:  LDD  M_XT                   ;THEN SEE IF WE ARE THE CLOSEST ALIEN
P3_950A:  CMPD CL_ADS                 ;SHIP DISTANCE
P3_950D:  BHS  P3_9515                ;IFLO  ?ALSO THE NEAREST SHIP SO FAR?
P3_950F:  STD  CL_ADS                 ;REMEMBER ITS DISTANCE
P3_9511:  LDX  S2_PRM                 ;THEN WE GOT A HIT
P3_9513:  STX  CL_AP                  ;RECORD WHO WE ARE
P3_9515:  LDD  TMPSIZ_4801            ;?AIM IS NEARING ALIEN?
P3_9517:  ADDD TMPSIZ_4801
P3_9519:  ADDD TMPSIZ_4801            ;ALLOW LARGER WARNING AREA
P3_951B:  SUBD TMPOCT_4803
P3_951D:  BLO  P3_952F                ;IFHS
P3_951F:  LDX  S2_PRM
P3_9521:  LDA  AS_TYP,X
P3_9523:  CMPA #$01
P3_9525:  BNE  P3_952F                ;?ALIVE?
P3_9527:  LDD  AS_CHST,X
P3_952A:  ORA  #((CS_PS&$FF00)/$100)  ;CHSET C$PS  STATUS: ALIEN IN PLAYER SITES

;------------------------------------------------------------------------------
; s2vw_end_p3 - stale image, never run as code: the last instructions of the S2VW copy, the same on all four
;   pages. lz_hit_probot and lz_hit_space read $9548 and $9540 here as data, which puts the slapstic into its
;   bitwise mode before a maze call - see docs/SLAPSTIC.md
;------------------------------------------------------------------------------
s2vw_end_p3:
P3_952C:  STD  AS_CHST,X
;SET BRITENESS
;ELSE HANDLE GLOW
P3_952F:  LDX  S2_PRM
P3_9531:  LDB  7,X
P3_9533:  LDU  #P3_954C               ;GET GLOW COLORS
P3_9536:  LSLB
P3_9537:  LDD  B,U
P3_9539:  STD  ,Y++
P3_953B:  LDA  #MS_CNCT
P3_953D:  JSR  MGOWT
P3_9540:  LDB  5,X
P3_9542:  JSR  L60D2
P3_9545:  JSR  L60E4
P3_9548:  JSR  L60BA
P3_954B:  RTS
P3_954C:  .word (VGCOPC&$F000)+(($82&$F)*$100)+($82&$F0) ;TVWBYT 082,037,82,37,82,47,82,47
P3_954E:  .word (VGCOPC&$F000)+(($37&$F)*$100)+($37&$F0)
P3_9550:  .word (VGCOPC&$F000)+(($82&$F)*$100)+($82&$F0)
P3_9552:  .word (VGCOPC&$F000)+(($37&$F)*$100)+($37&$F0)
P3_9554:  .word (VGCOPC&$F000)+(($82&$F)*$100)+($82&$F0)
P3_9556:  .word (VGCOPC&$F000)+(($47&$F)*$100)+($47&$F0)
P3_9558:  .word (VGCOPC&$F000)+(($82&$F)*$100)+($82&$F0)
P3_955A:  .word (VGCOPC&$F000)+(($47&$F)*$100)+($47&$F0)
P3_955C:  .word (VGCOPC&$F000)+(($82&$F)*$100)+($82&$F0) ;TVWBYT 082,057,82,057,082,067,082,067
P3_955E:  .word (VGCOPC&$F000)+(($57&$F)*$100)+($57&$F0)
P3_9560:  .byte $D6                   ;last byte of the stale copy, the first byte of an instruction on page 2

;------------------------------------------------------------------------------
; TSTLAZ - LASAR -- S1LAZ,MVLAZ,VWLAZ,CL1LAZ
;   TEST IF LAZARS SHOULD BE ON IN MAINLINE
;   >0 ==> STICK LASAR ONTO HIT FOR A WHILE
;   <0 ==> GLANCED OFF, NOT STUCK
;   in ESB: ESB also copies the fire switch bits to lz_sw_edge, picks the lazar sound by wave_type (aud_cmd_4d
;   in the probot and walker parts, aud_cmd_3f in the two space parts, the force flag Q_FRC is gone) and
;   resets the distances of its own targets: probot, transmission, AT-AT, AT-ST and asteroid
;------------------------------------------------------------------------------
TSTLAZ:
P3_9561:  LDA  LZ_HIT                 ;CHECK IF A HIT HAS OCCURRED LAST FRAME
P3_9563:  BLE  P3_956F                ;IFGT
P3_9565:  DEC  LZ_HIT                 ;TIME IT OUT
P3_9567:  LDA  #$00
P3_9569:  STA  LZ_EDG                 ;LAZAR FREEZES IN POSITION
P3_956B:  STA  LZ_ON                  ;AND NO SHOW REGULAR LAZARS
P3_956D:  BRA  P3_9573                ;ELSE
P3_956F:  LDA  #$00
P3_9571:  STA  LZ_HIT
P3_9573:  LDA  #$00
P3_9575:  STA  LZ_ON                  ;AND STOP ALL LAZARS
P3_9577:  STA  lz_sw_edge             ;ESB: no fire switch edge seen yet this frame
P3_957A:  ORCC #$10                   ;SEI  ***PREVENT POSSIBLE IRQ/MAINLINE INTERACTIONS
P3_957C:  LDA  VG_LON                 ;GET ON SWITCH FROM IRQ
P3_957E:  BEQ  P3_958E                ;IFNE
P3_9580:  STA  lz_sw_edge             ;ESB: keep the switch bits that fired for this frame
P3_9583:  INC  LZ_ALT                 ;EDGED ALTERNATION
P3_9586:  CLR  LZ_HIT                 ;STOP THE HIT PICTURE, ALLOW SWEEPING LAZARS
P3_9588:  LDB  #$08
P3_958A:  STB  LZ_EDG
P3_958C:  CLR  VG_LON                 ;PREPARE IRQ FOR NEXT MAINLINE
P3_958E:  LDA  LZ_EDG
P3_9590:  BLE  P3_95A6                ;IFGT  ?HAVE AN EDG TO DETECT?
P3_9592:  DEC  LZ_EDG
P3_9594:  STA  LZ_ON                  ;TURN ON LAZARS TOO
P3_9596:  LDD  VG_RSX                 ;16 BIT REAL SITE VALUE, FOR LAZAR
P3_9598:  STD  LZ_RSX
P3_959A:  LDD  VG_RSY
P3_959C:  STD  LZ_RSY
P3_959E:  LDD  VG_CX                  ;10 BIT CURRENT SITE VALUE, FOR LAZAR
P3_95A0:  STD  LZ_CX
P3_95A2:  LDD  VG_CY
P3_95A4:  STD  LZ_CY
P3_95A6:  ANDCC #$EF                  ;CLI  ***REALLOW INTERFERENCE
P3_95A8:  LDA  LZ_EDG
P3_95AA:  CMPA #$07                   ;CHEAP DETECT OF EVERY EDGE
P3_95AC:  BNE  P3_95BD                ;IFEQ
P3_95AE:  LDA  wave_type              ;ESB: the lazar sound depends on the part
P3_95B1:  CMPA #$02
P3_95B3:  BCC  P3_95BA
P3_95B5:  JSR  aud_cmd_4d             ;probots and walkers
P3_95B8:  BRA  P3_95BD
P3_95BA:  JSR  aud_cmd_3f             ;TIE fighters and asteroids
P3_95BD:  LDA  #$FF                   ;set up for collision: nothing under the cursor yet, every distance negative
P3_95BF:  STA  CL_ADS
P3_95C1:  STA  CL_GDS                 ;enemy shot
P3_95C3:  STA  prob_hit_d             ;probot
P3_95C6:  STA  xmit_hit_d             ;transmission
P3_95C9:  STA  atat_hit_d             ;AT-AT
P3_95CC:  STA  atst_hit_d             ;AT-ST
P3_95CF:  STA  astr_hit_d             ;asteroid
P3_95D2:  RTS

;------------------------------------------------------------------------------
; view_lazars - ESB's form of Star Wars' VWLAZ (view lazars), rewritten around a table: nothing unless LZ_ON or
;   LZ_HIT is set. takes the gun positions of the player's craft from lz_gun_tab (8 bytes for each craft_type 0-2,
;   a higher type is put back to 0) and draws the beams of one side with LAZVW, the left guns when LZ_ALT is odd
;   and the right ones when it is even. craft type 0 has one gun a side, types 1 and 2 a second pair, whose entry
;   is $18 bytes further on. for each beam it writes the blank vector to the gun (its position plus the gun shift
;   LZ_GY, LZ_GX) and leaves the distance from there to the sight in TMPDY and TMPDX. Y is the display list, X and
;   U are kept
;------------------------------------------------------------------------------
view_lazars:
P3_95D3:  PSHS X,U
P3_95D5:  LDA  LZ_ON                  ;nothing to draw unless the lazars are on or a hit is being shown
P3_95D7:  ORA  LZ_HIT
P3_95D9:  BNE  P3_95DD
P3_95DB:  PULS X,U,PC
P3_95DD:  LDX  #lz_gun_tab            ;gun positions, 8 bytes for each craft type
P3_95E0:  LDB  craft_type
P3_95E3:  CMPB #$02                   ;a type above 2 is put back to 0
P3_95E5:  BLS  P3_95EC
P3_95E7:  LDB  #$00
P3_95E9:  STB  craft_type
P3_95EC:  ASLB
P3_95ED:  ASLB
P3_95EE:  ASLB
P3_95EF:  ABX
P3_95F0:  LDA  LZ_ALT                 ;the sides take turns: odd fires the left guns, even the right ones
P3_95F3:  ANDA #$01
P3_95F5:  BEQ  P3_9656
P3_95F7:  LDD  LZ_GY                  ;start of the beam in y: the gun's y plus the gun shift
P3_95FA:  ADDD ,X
P3_95FC:  ANDA #$1F
P3_95FE:  STD  ,Y++
P3_9600:  LDD  LZ_CY                  ;y distance left to the sight
P3_9602:  SUBD LZ_GY
P3_9605:  SUBD 2,X
P3_9607:  STD  scratch_3              ;TMPDY
P3_9609:  LDD  LZ_GX                  ;start in x: the left gun
P3_960C:  ADDD 4,X
P3_960E:  ANDA #$1F
P3_9610:  STD  ,Y++
P3_9612:  LDD  LZ_CX                  ;x distance left to the sight
P3_9614:  SUBD LZ_GX
P3_9617:  SUBD 4,X
P3_9619:  STD  scratch_1              ;TMPDX
P3_961B:  LDB  #$08                   ;offset into the fire colours TLZFR
P3_961D:  JSR  LAZVW
P3_9620:  LDA  craft_type             ;craft type 0 has one gun a side
P3_9623:  CMPA #$01
P3_9625:  BCS  P3_9654
P3_9627:  LEAX >$0018,X               ;the entry of the second pair of guns, three entries on
P3_962B:  LDD  LZ_GY
P3_962E:  ADDD ,X
P3_9630:  ANDA #$1F
P3_9632:  STD  ,Y++
P3_9634:  LDD  LZ_CY
P3_9636:  SUBD LZ_GY
P3_9639:  SUBD 2,X
P3_963B:  STD  scratch_3
P3_963D:  LDD  LZ_GX
P3_9640:  ADDD 4,X
P3_9642:  ANDA #$1F
P3_9644:  STD  ,Y++
P3_9646:  LDD  LZ_CX
P3_9648:  SUBD LZ_GX
P3_964B:  SUBD 4,X
P3_964D:  STD  scratch_1
P3_964F:  LDB  #$00
P3_9651:  JSR  LAZVW
P3_9654:  BRA  P3_96B3
P3_9656:  LDD  LZ_GY                  ;the right guns: the same with the x word at offset 6
P3_9659:  ADDD ,X
P3_965B:  ANDA #$1F
P3_965D:  STD  ,Y++
P3_965F:  LDD  LZ_CY
P3_9661:  SUBD LZ_GY
P3_9664:  SUBD 2,X
P3_9666:  STD  scratch_3
P3_9668:  LDD  LZ_GX
P3_966B:  ADDD 6,X
P3_966D:  ANDA #$1F
P3_966F:  STD  ,Y++
P3_9671:  LDD  LZ_CX
P3_9673:  SUBD LZ_GX
P3_9676:  SUBD 6,X
P3_9678:  STD  scratch_1
P3_967A:  LDB  #$00
P3_967C:  JSR  LAZVW
P3_967F:  LDA  craft_type             ;craft type 0 has one gun a side
P3_9682:  CMPA #$01
P3_9684:  BCS  P3_96B3
P3_9686:  LEAX >$0018,X               ;the second pair
P3_968A:  LDD  LZ_GY
P3_968D:  ADDD ,X
P3_968F:  ANDA #$1F
P3_9691:  STD  ,Y++
P3_9693:  LDD  LZ_CY
P3_9695:  SUBD LZ_GY
P3_9698:  SUBD 2,X
P3_969A:  STD  scratch_3
P3_969C:  LDD  LZ_GX
P3_969F:  ADDD 6,X
P3_96A1:  ANDA #$1F
P3_96A3:  STD  ,Y++
P3_96A5:  LDD  LZ_CX
P3_96A7:  SUBD LZ_GX
P3_96AA:  SUBD 6,X
P3_96AC:  STD  scratch_1
P3_96AE:  LDB  #$08
P3_96B0:  JSR  LAZVW
P3_96B3:  PULS X,U,PC

lz_gun_tab:
P3_96B5:  .word $FE40, $FEA8, $FF58, $00A8 ;craft type 0 (probot and walker parts): y of the guns on the screen -448, the same y in the sight's coordinates -344, x of the left gun -168, x of the right gun 168
P3_96BD:  .word $FE50, $FEB8, $FF38, $00C8 ;craft type 1 (TIE fighter and asteroid parts), first pair: -432, -328, -200, 200
P3_96C5:  .word $FDFB, $FF71, $FE75, $018B ;craft type 2, which nothing sets, first pair: -517, -143, -395, 395, the lower guns of the Star Wars X-wing but for the second word
P3_96CD:  .word $0000, $0000, $0000, $0000 ;second pair of type 0: not used
P3_96D5:  .word $FE50, $FEB8, $FF6A, $0096 ;second pair of type 1: -432, -328, -150, 150
P3_96DD:  .word $FF98, $0000, $FE7A, $0186 ;second pair of type 2: -104, 0, -390, 390, the upper guns of the Star Wars X-wing

;------------------------------------------------------------------------------
; LAZVW - ---VECTOR TO LAZAR SITE AND DISPLAY
;------------------------------------------------------------------------------
LAZVW:
P3_96E5:  LDU  #TLZFR                 ;FULL FIRE COLORS
P3_96E8:  LEAU B,U                    ;ADD OFFSET TO COLORS
P3_96EA:  LDA  LZ_HIT
P3_96EC:  BLE  LAZVW_20               ;IFGT  ?HIT SOMETHING IMPORTANT?
P3_96EE:  LDB  #$3F                   ;SPREAD OUT HIT COUNT INTO FULL BRITE
P3_96F0:  MUL                         ;RESULT BRITE IN B
P3_96F1:  LDA  #((VGCTRQ*$100)+VGCOPC)/$100 ;USED LAZAR GOES BRITE TO DIM
P3_96F3:  STD  ,Y++
P3_96F5:  BRA  LAZVW_88

LAZVW_20:
P3_96F7:  LDD  ,U++                   ;PULL THE APPROPRIATE COLOR
P3_96F9:  STD  ,Y++
P3_96FB:  LDD  TMPDY                  ;CURRENT DELTA TO SITE
P3_96FD:  BMI  LAZVW_22
P3_96FF:  ADDD #$0001                 ;ROUND POSITIVE UP

LAZVW_22:
P3_9702:  ASRA
P3_9703:  RORB                        ;DIVIDE BY 2
P3_9704:  STD  ,Y                     ;TEMP SAVE
P3_9706:  COMA                        ;NEGD
P3_9707:  NEGB
P3_9708:  SBCA #$FF
P3_970A:  ADDD TMPDY                  ;REDUCE ORIGINAL APPROPRIATE AMOUNT
P3_970C:  STD  TMPDY
P3_970E:  LDD  ,Y                     ;GET Y PORTION AGAIN
P3_9710:  ANDA #$1F
P3_9712:  STD  ,Y++                   ;AND VECTORIZE Y
P3_9714:  LDD  TMPDX                  ;CURRENT DELTA TO SITE
P3_9716:  BMI  LAZVW_26
P3_9718:  ADDD #$0001                 ;ROUND POSITIVE UP

LAZVW_26:
P3_971B:  ASRA
P3_971C:  RORB                        ;DIVIDE BY 2
P3_971D:  STD  ,Y                     ;TEMP SAVE
P3_971F:  COMA                        ;NEGD
P3_9720:  NEGB
P3_9721:  SBCA #$FF
P3_9723:  ADDD TMPDX                  ;REDUCE ORIGINAL APPROPRIATE AMOUNT
P3_9725:  STD  TMPDX
P3_9727:  LDD  ,Y                     ;GET X PORTION AGAIN
P3_9729:  ORA  #$E0                   ;DEFAULT BRITE
P3_972B:  STD  ,Y++                   ;AND VECTORIZE X
P3_972D:  LDD  TMPDX                  ;KEEP GOING TILL WE ARRIVE AT SITE
P3_972F:  ADDD #$0008
P3_9732:  BLT  LAZVW_20               ;RELOOP IF <-8
P3_9734:  SUBD #$0010
P3_9737:  BGT  LAZVW_20               ;RELOOP IF DX>8
P3_9739:  LDD  TMPDY
P3_973B:  ADDD #$0008
P3_973E:  BLT  LAZVW_20               ;RELOOP IF <-8
P3_9740:  SUBD #$0010
P3_9743:  BGT  LAZVW_20               ;RELOOP IF DY>8
P3_9745:  LDD  ,U++
P3_9747:  STD  ,Y++                   ;SETUP APPROPRIATE COLOR

LAZVW_88:          ;---DISPLAY REST OF LAZAR LINE
P3_9749:  LDD  TMPDY
P3_974B:  ANDA #$1F
P3_974D:  STD  ,Y++
P3_974F:  LDD  TMPDX
P3_9751:  ORA  #$E0                   ;BRITE
P3_9753:  STD  ,Y++
P3_9755:  LDA  LZ_HIT
P3_9757:  BLE  P3_9760                ;IFGT  ?HIT SOMETHING?
P3_9759:  LDD  #$A009                 ;SHOW LAZAR SPLASH
P3_975C:  STD  ,Y++
P3_975E:  BRA  P3_979E                ;ELSE
P3_9760:  BGE  P3_979E                ;IFLT  ?OR SPLASHING AGAINST SOMETHING?
P3_9762:  LDB  SP_LOC                 ;X DISTANCE, USE TO SCALE
P3_9765:  LDA  #((VGSCAL-$100)&$FF00)/$100 ;MAKE IT A SCALE INSTRUCTION
;LARGER PLEASE
P3_9767:  STD  ,Y++
P3_9769:  LDD  SP_COL                 ;COLOR, DEPENDS ON WHAT WAS HIT
P3_976C:  STD  ,Y++
P3_976E:  LDA  SP_TYP                 ;QUADRANT DATA
P3_9771:  ANDA #$01                   ;UP-RIGHT?
P3_9773:  BEQ  P3_977A                ;IFNE  YES
P3_9775:  LDD  #$AA01
P3_9778:  STD  ,Y++
P3_977A:  LDA  SP_TYP
P3_977D:  ANDA #$02                   ;UP-LEFT?
P3_977F:  BEQ  P3_9786                ;IFNE  YES
P3_9781:  LDD  #$AA08
P3_9784:  STD  ,Y++
P3_9786:  LDA  SP_TYP
P3_9789:  ANDA #$04                   ;DOWN-LEFT?
P3_978B:  BEQ  P3_9792                ;IFNE  YES
P3_978D:  LDD  #$AA0F
P3_9790:  STD  ,Y++
P3_9792:  LDA  SP_TYP
P3_9795:  ANDA #$08                   ;DOWN-RIGHT?
P3_9797:  BEQ  P3_979E                ;IFNE  YES
P3_9799:  LDD  #$AA16
P3_979C:  STD  ,Y++
P3_979E:  LDD  #VGSCAL                ;RESTORE SCALE
P3_97A1:  STD  ,Y++
P3_97A3:  LDD  #VGCNTR                ;CENTER
P3_97A6:  STD  ,Y++
P3_97A8:  RTS

TLZFR:          ;COLORS FOR LAZAR FIRE
P3_97A9:  .word VJLZF0                ;.IRP .A,<0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F>
P3_97AB:  .word VJLZF1
P3_97AD:  .word VJLZF2
P3_97AF:  .word VJLZF3
P3_97B1:  .word VJLZF4
P3_97B3:  .word VJLZF5
P3_97B5:  .word VJLZF6
P3_97B7:  .word VJLZF7
P3_97B9:  .word VJLZF0                ;.IRP .A,<0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F>
P3_97BB:  .word VJLZF1
P3_97BD:  .word VJLZF2
P3_97BF:  .word VJLZF3
P3_97C1:  .word VJLZF4
P3_97C3:  .word VJLZF5
P3_97C5:  .word VJLZF6
P3_97C7:  .word VJLZF7
P3_97C9:  .word $A001                 ;one more VJLZF0, the entry Star Wars adds after the table for safety

;------------------------------------------------------------------------------
; lz_hit_walker - lazar collision test of the walker part, called by vew_walker and vew_walker_end after
;   everything is drawn, the walker form of lz_hit_probot. does nothing while LZ_ON is 0. an enemy shot (CL_GDS)
;   nearer than the AT-AT (atat_hit_d) and the AT-ST (atst_hit_d) under the cursor is hit through GNHTSG on page
;   1, a call, so the walker test still follows. then the nearer of the two walkers is hit with LZ_HIT = 4, an AT-
;   AT through page 0 P0_9003 and an AT-ST through page 1 atst_killed. when the record word that goes with the
;   distance is 0 the lazar only splashes at that distance (P3_9817)
;------------------------------------------------------------------------------
lz_hit_walker:
P3_97CB:  LDA  LZ_ON
P3_97CD:  BNE  P3_97D0
P3_97CF:  RTS
P3_97D0:  LDD  CL_GDS                 ;an enemy shot under the cursor?
P3_97D2:  BMI  P3_97E7
P3_97D4:  CMPD atat_hit_d             ;nearer than the AT-AT
P3_97D8:  BCC  P3_97E7
P3_97DA:  CMPD atst_hit_d             ;and nearer than the AT-ST: the shot is hit
P3_97DE:  BCC  P3_97E7
P3_97E0:  LDA  #$04                   ;LZ_HIT = 4: display the hit for a while
P3_97E2:  STA  LZ_HIT
P3_97E4:  JSR  P3_85C8                ;calls page 1 GNHTSG
P3_97E7:  LDD  atat_hit_d             ;an AT-AT under the cursor?
P3_97EA:  BMI  P3_97FD
P3_97EC:  SUBD atst_hit_d             ;nearer than the AT-ST?
P3_97EF:  BCC  P3_97FD
P3_97F1:  LDD  atat_hit_rec
P3_97F4:  BEQ  P3_980F                ;record word 0: the lazar only splashes against the AT-AT
P3_97F6:  LDA  #$04                   ;LZ_HIT = 4: display the hit for a while
P3_97F8:  STA  LZ_HIT
P3_97FA:  JMP  P3_8538                ;calls page 0 atat_eye_shot
P3_97FD:  LDD  atst_hit_d             ;an AT-ST under the cursor?
P3_9800:  BMI  P3_980E                ;no AT-ST under the cursor: nothing hit
P3_9802:  LDD  atst_hit_rec
P3_9805:  BEQ  P3_9814                ;record word 0: the cursor is on the AT-ST's body, the lazar only splashes
P3_9807:  LDA  #$04
P3_9809:  STA  LZ_HIT                 ;LZ_HIT = 4: display the hit for a while
P3_980B:  JMP  P3_858C                ;calls page 1 atst_killed
P3_980E:  RTS
P3_980F:  LDA  atat_hit_d             ;splash at the AT-AT's distance
P3_9812:  BRA  P3_9817
P3_9814:  LDA  atst_hit_d             ;splash at the AT-ST's distance
P3_9817:  CMPA #$3E                   ;lazar splash against something that is not destroyed, A = high byte of its view distance
P3_9819:  BCS  P3_981D
P3_981B:  LDA  #$3E
P3_981D:  ASLA                        ;splash scale = 4 * the distance, $D0 at most
P3_981E:  ASLA
P3_981F:  CMPA #$D0
P3_9821:  BLS  P3_9825
P3_9823:  LDA  #$D0
P3_9825:  STA  SP_LOC
P3_9828:  LDA  #$FF                   ;no hit, but splash
P3_982A:  STA  LZ_HIT
P3_982C:  LDA  #$0F                   ;all four quadrants of the splash
P3_982E:  STA  SP_TYP
P3_9831:  LDD  #$6280                 ;splash colour: green, brightness $80 (yellow in Star Wars' CLGT)
P3_9834:  STD  SP_COL
P3_9837:  RTS

;------------------------------------------------------------------------------
; lz_hit_probot - lazar collision test of the probot part, called by vew_probot after everything is drawn, the
;   ESB form of Star Wars' CLGLZ. does nothing while LZ_ON is 0. of the three things the cursor can be on - an
;   enemy shot (CL_GDS), a probot (prob_hit_d) and a transmission (xmit_hit_d), each a view distance with a
;   negative high byte for none - it takes the nearest: a shot goes to GNHTSG on page 1, a probot to page 2
;   P2_92EE, a transmission to xmit_hit, each with LZ_HIT = 4. when the record word that goes with the probot or
;   the transmission is 0 the lazar only splashes at that distance (P3_9817). the call to xmit_hit is made through
;   a slapstic decoy
;------------------------------------------------------------------------------
lz_hit_probot:
P3_9838:  LDA  LZ_ON
P3_983A:  BNE  P3_983D
P3_983C:  RTS
P3_983D:  LDD  CL_GDS                 ;an enemy shot under the cursor?
P3_983F:  BMI  P3_9854
P3_9841:  CMPD prob_hit_d             ;nearer than the probot
P3_9845:  BCC  P3_9854
P3_9847:  CMPD xmit_hit_d             ;and nearer than the transmission: the shot is hit
P3_984B:  BCC  P3_9854
P3_984D:  LDA  #$04
P3_984F:  STA  LZ_HIT
P3_9851:  JMP  P3_85C8                ;calls page 1 GNHTSG
P3_9854:  LDD  prob_hit_d             ;a probot under the cursor?
P3_9857:  BMI  P3_986B
P3_9859:  CMPD xmit_hit_d             ;nearer than the transmission?
P3_985D:  BCC  P3_986B
P3_985F:  LDD  prob_hit_rec
P3_9862:  BEQ  P3_9886                ;no record: the lazar only splashes against it
P3_9864:  LDA  #$04
P3_9866:  STA  LZ_HIT
P3_9868:  JMP  P3_8454                ;calls page 2 probot_shot_down
P3_986B:  LDD  xmit_hit_d             ;a transmission under the cursor?
P3_986E:  BMI  P3_987F
P3_9870:  LDD  xmit_hit_rec
P3_9873:  BEQ  P3_9880                ;no record: splash
P3_9875:  LDB  P3_9548                ;slapstic: EN -> BIT1
P3_9878:  LDA  #$04                   ;slapstic decoy: the read of $9548 above put the chip in its bitwise mode, so the page select of the maze entry jumped to below (written as a call of page 1) is not taken as one and the call lands on this page's xmit_hit
P3_987A:  STA  LZ_HIT                 ;LZ_HIT = 4: display the hit for a while
P3_987C:  JMP  P3_82F8                ;calls page 3 xmit_hit; chip was in state BIT1
P3_987F:  RTS
P3_9880:  LDA  xmit_hit_d             ;splash at the transmission's distance
P3_9883:  JMP  P3_9817
P3_9886:  LDA  prob_hit_d             ;splash at the probot's distance
P3_9889:  JMP  P3_9817

;------------------------------------------------------------------------------
; lz_hit_space - lazar collision test of the TIE fighter and asteroid parts, called by their views, made from
;   Star Wars' CLSLZ. does nothing while LZ_ON is 0. an enemy shot nearer than the alien ship and the asteroid
;   goes to GNHTSG, else an alien ship nearer than the asteroid goes to CPHTSA (through a slapstic decoy), else an
;   asteroid under the cursor: its record word astr_hit_rec is only ever written as 0, so the lazar splashes at
;   its distance (P3_9817) and the call of page 2 P2_9C16 is never made
;------------------------------------------------------------------------------
lz_hit_space:
P3_988C:  LDA  LZ_ON
P3_988E:  BNE  P3_9891
P3_9890:  RTS
P3_9891:  LDD  CL_GDS                 ;an enemy shot under the cursor?
P3_9893:  BMI  P3_98A7
P3_9895:  CMPD CL_ADS                 ;nearer than the alien ship
P3_9898:  BCC  P3_98A7
P3_989A:  CMPD astr_hit_d             ;and nearer than the asteroid: the shot is hit
P3_989E:  BCC  P3_98A7
P3_98A0:  LDA  #$04
P3_98A2:  STA  LZ_HIT
P3_98A4:  JMP  P3_85C8                ;calls page 1 GNHTSG
P3_98A7:  LDA  CL_ADS                 ;an alien ship under the cursor? only A is loaded: the compare below uses B as the first test left it, the low byte of CL_GDS
P3_98A9:  BMI  P3_98BB
P3_98AB:  CMPD astr_hit_d             ;nearer than the asteroid?
P3_98AF:  BCC  P3_98BB
P3_98B1:  LDB  P3_9540                ;slapstic: EN -> BIT1
P3_98B4:  LDA  #$04                   ;slapstic decoy: the read of $9540 above put the chip in its bitwise mode, so the page select of the maze entry jumped to below (written as a call of page 1) is not taken as one and the call lands on this page's CPHTSA
P3_98B6:  STA  LZ_HIT                 ;LZ_HIT = 4: display the hit for a while
P3_98B8:  JMP  P3_8220                ;calls page 3 CPHTSA; chip was in state BIT1
P3_98BB:  LDA  astr_hit_d             ;an asteroid under the cursor?
P3_98BE:  BMI  P3_98CC
P3_98C0:  LDD  astr_hit_rec
P3_98C3:  BEQ  P3_98CD                ;always 0 (page 2 P2_9C0C is its only writer): splash
P3_98C5:  LDA  #$04
P3_98C7:  STA  LZ_HIT
P3_98C9:  JMP  P3_8346                ;calls page 2 astrd_lz_hit
P3_98CC:  RTS
P3_98CD:  LDA  astr_hit_d             ;splash at the asteroid's distance
P3_98D0:  JMP  P3_9817

;------------------------------------------------------------------------------
; xmit_init - set-up of the probot transmissions, called by the probot part's set-up and by man_init_probot:
;   loads object 8, the hexagon a transmission is drawn with, into the math RAM (bank 1 KD868 through L60A8) and
;   frees the three $28-byte records at xmit_atst
;------------------------------------------------------------------------------
xmit_init:
P3_98D3:  LDB  #$08                   ;object 8, the transmission hexagon
P3_98D5:  JSR  L60A8
P3_98D8:  LDX  #xmit_atst
P3_98DB:  LDA  #$00                   ;free the three records
P3_98DD:  STA  ,X
P3_98DF:  LEAX $28,X
P3_98E2:  CMPX #xmit_atst+(3*$28)
P3_98E5:  BCS  P3_98DD                ;end of the third record
P3_98E7:  RTS

;------------------------------------------------------------------------------
; xmit_launch - makes a probot launch a transmission: xmit_launch_do with X and U kept. called by page 2
;   (P2_919B) and by the training manual (bank 0 LB1D9) with the probot's position in M_XT2, M_YT2, M_ZT2. carry
;   set when a transmission was launched, clear when all three records are in use
;------------------------------------------------------------------------------
xmit_launch:
P3_98E8:  PSHS X,U
P3_98EA:  JSR  xmit_launch_do
P3_98ED:  PULS X,U,PC

;------------------------------------------------------------------------------
; xmit_launch_do - takes a free transmission record (xmit_find_free, which returns to this routine's caller with
;   carry clear when there is none) and fills it: status 1, life timer $FF, kind 1 while a manual page is shown
;   and else 1 to 3 at random (the square of a random byte times 3, so 1 is the most likely), climb speed $10, no
;   sideways speed, and all five trail points at the probot's position M_XT2, M_YT2, M_ZT2 with x and y taken
;   relative to the player. sends sound command $43 and returns carry set
;------------------------------------------------------------------------------
xmit_launch_do:
P3_98EF:  JSR  xmit_find_free         ;U = a free record, or out with carry clear
P3_98F2:  STU  xmit_cur
P3_98F5:  JSR  rnd_set
P3_98F8:  LDA  #$FF                   ;life timer: 255 frames
P3_98FA:  STA  3,U
P3_98FC:  LDA  #$01                   ;status: live
P3_98FE:  STA  ,U
P3_9900:  LDA  man_running
P3_9903:  BEQ  P3_9909
P3_9905:  LDA  #$01                   ;the manual's transmission rises straight
P3_9907:  BRA  P3_9913
P3_9909:  LDA  RND_S1                 ;kind = 1 + 3 * (random byte squared / 256) / 256: 1, 2 or 3
P3_990B:  LDB  RND_S1
P3_990D:  MUL
P3_990E:  LDB  #$03
P3_9910:  MUL
P3_9911:  ADDA #$01
P3_9913:  STA  2,U
P3_9915:  LDD  #$0010                 ;climb speed
P3_9918:  STD  8,U
P3_991A:  LDD  #$0000                 ;no x and y speed
P3_991D:  STD  4,U
P3_991F:  STD  6,U
P3_9921:  LDD  M_XT2                  ;the probot's x relative to the player: all five trail points start there
P3_9924:  SUBD s1_tx
P3_9927:  STD  10,U
P3_9929:  STD  $10,U
P3_992C:  STD  $16,U
P3_992F:  STD  $1C,U
P3_9932:  STD  $22,U
P3_9935:  LDD  M_YT2                  ;its y relative to the player
P3_9938:  SUBD s1_ty
P3_993B:  STD  12,U
P3_993D:  STD  $12,U
P3_9940:  STD  $18,U
P3_9943:  STD  $1E,U
P3_9946:  STD  $24,U
P3_9949:  LDD  M_ZT2                  ;its height
P3_994C:  STD  14,U
P3_994E:  STD  $14,U
P3_9951:  STD  $1A,U
P3_9954:  STD  $20,U
P3_9957:  STD  $26,U
P3_995A:  JSR  aud_cmd_43             ;the transmission tone
P3_995D:  ORCC #$01                   ;carry set: launched
P3_995F:  RTS

;------------------------------------------------------------------------------
; xmit_find_free - finds a free transmission record: U = the first of the three records at xmit_atst whose byte
;   0 is 0. when all are in use it drops its own return address and returns to its caller's caller with carry
;   clear
;------------------------------------------------------------------------------
xmit_find_free:
P3_9960:  LDU  #xmit_atst
P3_9963:  LDA  ,U
P3_9965:  BEQ  P3_9974
P3_9967:  LEAU $28,U
P3_996A:  CMPU #xmit_atst+(3*$28)
P3_996E:  BCS  P3_9963
P3_9970:  LEAS 2,S                    ;none free: drop the return address
P3_9972:  ANDCC #$FE                  ;and return to the caller's caller with carry clear
P3_9974:  RTS

;------------------------------------------------------------------------------
; xmit_escape - removes the transmission at U that has got away: nothing if it is one the lazar has hit (status
;   bit 2). else frees the record, clears its timer and, outside the training manual, calls page 1
;   xmit_got_through, which starts the flash of the next mark of the transmissions indicator
;------------------------------------------------------------------------------
xmit_escape:
P3_9975:  LDA  ,U
P3_9977:  BITA #$04                   ;shot down: it did not get away
P3_9979:  BNE  P3_9988
P3_997B:  CLRB
P3_997C:  STB  ,U
P3_997E:  STB  3,U
P3_9980:  LDA  man_running
P3_9983:  BNE  P3_9988
P3_9985:  JSR  P3_8274                ;calls page 1 xmit_got_through
P3_9988:  RTS

;------------------------------------------------------------------------------
; xmit_move_all - moves the probot transmissions, called every frame of the probot part and by man_move_probot.
;   for each of the three records: a hit transmission that was not on screen in the last view is freed at once,
;   and a record in use is moved by the routine xmit_move_tab gives for its kind (byte 2). keeps X and U
;------------------------------------------------------------------------------
xmit_move_all:
P3_9989:  PSHS X,U
P3_998B:  LDU  #xmit_atst
P3_998E:  LDA  1,U
P3_9990:  BITA #$10                   ;on screen in the last view?
P3_9992:  BNE  P3_999C
P3_9994:  LDA  ,U
P3_9996:  BITA #$04                   ;no: if it has been hit there is nothing to show, free it
P3_9998:  BEQ  P3_999C
P3_999A:  CLR  ,U
P3_999C:  LDA  ,U
P3_999E:  BEQ  P3_99AE
P3_99A0:  LDB  2,U                    ;kind 0-3
P3_99A2:  ASLB
P3_99A3:  CMPB #$08
P3_99A5:  BCS  P3_99A9
P3_99A7:  LDB  #$01                   ;never taken: the kind is 3 at most (an odd index would read across two entries)
P3_99A9:  LDX  #xmit_move_tab
P3_99AC:  JSR  [B,X]
P3_99AE:  LEAU $28,U
P3_99B1:  CMPU #xmit_atst+(3*$28)
P3_99B5:  BCS  P3_998E
P3_99B7:  PULS X,U,PC

;------------------------------------------------------------------------------
; xmit_mv_hit - move routine of kind 0, a transmission the lazar has hit: it stays where it is while its trail
;   closes up (xmit_trail_shift) and its timer, set to $0F by xmit_hit, runs down, then the record is freed
;------------------------------------------------------------------------------
xmit_mv_hit:
P3_99B9:  JSR  xmit_trail_shift
P3_99BC:  DEC  3,U                    ;fade timer of the hit
P3_99BE:  BNE  P3_99C5
P3_99C0:  CLRB
P3_99C1:  STB  ,U
P3_99C3:  STB  3,U
P3_99C5:  RTS

;------------------------------------------------------------------------------
; xmit_mv_straight - move routine of kind 1: shifts the trail, counts the life timer down and frees the record
;   at 0, else moves the head (xmit_step) and raises the climb speed by $10 a frame up to $03F0. with no sideways
;   speed the transmission rises straight up
;------------------------------------------------------------------------------
xmit_mv_straight:
P3_99C6:  JSR  xmit_trail_shift
P3_99C9:  DEC  3,U                    ;life timer
P3_99CB:  BNE  P3_99D2
P3_99CD:  CLRB
P3_99CE:  STB  ,U
P3_99D0:  BRA  P3_99E2
P3_99D2:  JSR  xmit_step
P3_99D5:  LDD  8,U                    ;climb faster
P3_99D7:  ADDD #$0010
P3_99DA:  CMPD #$0400
P3_99DE:  BCC  P3_99E2
P3_99E0:  STD  8,U
P3_99E2:  RTS

;------------------------------------------------------------------------------
; xmit_trail_shift - shifts the trail of the transmission at U: the four newest points (bytes $0A-$21) move one
;   place down to $10-$27, so the head's position is in the first two places until the move routine steps it.
;   then, if the transmission was not on screen in the last view, it is taken as got away (xmit_escape) when its
;   oldest point is higher than the player's height plus its distance from the player in x and in y, that is out
;   of the top of the view
;------------------------------------------------------------------------------
xmit_trail_shift:
P3_99E3:  LEAX 10,U                   ;address of the head's place, the loop's end
P3_99E5:  STX  scratch_1
P3_99E7:  LEAX $22,U
P3_99EA:  LDD  ,--X                   ;move each point's three words 6 bytes down, oldest first
P3_99EC:  STD  6,X
P3_99EE:  LDD  ,--X
P3_99F0:  STD  6,X
P3_99F2:  LDD  ,--X
P3_99F4:  STD  6,X
P3_99F6:  CMPX scratch_1
P3_99F8:  BHI  P3_99EA
P3_99FA:  LDA  1,U
P3_99FC:  BITA #$10                   ;on screen in the last view: it has not got away
P3_99FE:  BNE  P3_9A25
P3_9A00:  LDD  $22,U                  ;the oldest point's x distance from the player
P3_9A03:  BPL  P3_9A09
P3_9A05:  COMA
P3_9A06:  NEGB
P3_9A07:  SBCA #$FF
P3_9A09:  ADDD s1_tz                  ;plus the player's height, against the point's height
P3_9A0C:  SUBD $26,U
P3_9A0F:  BCC  P3_9A25
P3_9A11:  LDD  $24,U                  ;the same with its y distance
P3_9A14:  BPL  xmit_above_tst
P3_9A16:  COMA
P3_9A17:  NEGB
P3_9A18:  SBCA #$FF

xmit_above_tst:
P3_9A1A:  ADDD s1_tz
P3_9A1D:  SUBD $26,U
P3_9A20:  BCC  P3_9A25
P3_9A22:  JSR  xmit_escape
P3_9A25:  RTS

;------------------------------------------------------------------------------
; xmit_step - moves the head of the transmission at U: adds the three speed words (bytes 4, 6, 8) to the head's
;   x, y and z (bytes $0A, $0C, $0E). a head that has climbed above $8000 is taken as got away (xmit_escape)
;------------------------------------------------------------------------------
xmit_step:
P3_9A26:  LDD  10,U
P3_9A28:  ADDD 4,U
P3_9A2A:  STD  10,U
P3_9A2C:  LDD  12,U
P3_9A2E:  ADDD 6,U
P3_9A30:  STD  12,U
P3_9A32:  LDD  14,U
P3_9A34:  ADDD 8,U
P3_9A36:  STD  14,U
P3_9A38:  CMPD #$8000                 ;climbed above $8000: gone
P3_9A3C:  BLS  P3_9A41
P3_9A3E:  JSR  xmit_escape
P3_9A41:  RTS

;------------------------------------------------------------------------------
; xmit_mv_drift - move routine of kind 2: as xmit_mv_straight, and each frame two random words scaled by an
;   eighth of the climb speed (MS_PERS) are added to the x and y speeds, so the transmission wanders sideways more
;   and more as it climbs. xmit_vel_limit then keeps it in range
;------------------------------------------------------------------------------
xmit_mv_drift:
P3_9A42:  JSR  xmit_trail_shift
P3_9A45:  DEC  3,U
P3_9A47:  BNE  P3_9A50
P3_9A49:  CLRB
P3_9A4A:  STB  ,U
P3_9A4C:  STB  3,U
P3_9A4E:  BRA  P3_9A92
P3_9A50:  JSR  xmit_step
P3_9A53:  JSR  rnd_set
P3_9A56:  LDD  8,U                    ;climb faster, $03F0 at most
P3_9A58:  ADDD #$0010
P3_9A5B:  CMPD #$0400
P3_9A5F:  BCC  P3_9A63
P3_9A61:  STD  8,U
P3_9A63:  CMPD #$0010                 ;D = the climb speed, $10 at least
P3_9A67:  BGE  P3_9A6C
P3_9A69:  LDD  #$0010
P3_9A6C:  JSR  ASRD3                  ;an eighth of it is the multiplier
P3_9A6F:  STD  M_XP
P3_9A72:  LDD  RND_S1                 ;two random words
P3_9A74:  STD  M_YP
P3_9A77:  LDD  RND_S2
P3_9A79:  STD  M_ZP
P3_9A7C:  LDA  #$86                   ;MS_PERS: both times M_XP
P3_9A7E:  JSR  MGOWT
P3_9A81:  LDD  M_YP                   ;added to the x speed
P3_9A84:  ADDD 4,U
P3_9A86:  STD  4,U
P3_9A88:  LDD  M_ZP                   ;and to the y speed
P3_9A8B:  ADDD 6,U
P3_9A8D:  STD  6,U
P3_9A8F:  JSR  xmit_vel_limit
P3_9A92:  RTS

;------------------------------------------------------------------------------
; xmit_mv_jitter - move routine of kind 3: as xmit_mv_drift, but the two random words are scaled by half the
;   climb speed and replace the x and y speeds instead of adding to them, so the transmission jumps about a
;   straight climb
;------------------------------------------------------------------------------
xmit_mv_jitter:
P3_9A93:  JSR  xmit_trail_shift
P3_9A96:  DEC  3,U
P3_9A98:  BNE  P3_9AA1
P3_9A9A:  CLRB
P3_9A9B:  STB  ,U
P3_9A9D:  STB  3,U
P3_9A9F:  BRA  P3_9ADF
P3_9AA1:  JSR  xmit_step
P3_9AA4:  JSR  rnd_set
P3_9AA7:  LDD  8,U
P3_9AA9:  ADDD #$0010
P3_9AAC:  CMPD #$0400
P3_9AB0:  BCC  P3_9AB4
P3_9AB2:  STD  8,U
P3_9AB4:  CMPD #$0010
P3_9AB8:  BGE  P3_9ABD
P3_9ABA:  LDD  #$0010
P3_9ABD:  JSR  ASRD1                  ;half the climb speed is the multiplier
P3_9AC0:  STD  M_XP
P3_9AC3:  LDD  RND_S1
P3_9AC5:  STD  M_YP
P3_9AC8:  LDD  RND_S2
P3_9ACA:  STD  M_ZP
P3_9ACD:  LDA  #$86                   ;MS_PERS: both times M_XP
P3_9ACF:  JSR  MGOWT
P3_9AD2:  LDD  M_YP                   ;the x speed is the first product
P3_9AD5:  STD  4,U
P3_9AD7:  LDD  M_ZP                   ;the y speed the second
P3_9ADA:  STD  6,U
P3_9ADC:  JSR  xmit_vel_limit
P3_9ADF:  RTS

;------------------------------------------------------------------------------
; xmit_vel_limit - keeps a transmission's sideways distance from the player in range: for x (head word $0A,
;   speed word 4) and then y (head word $0C, speed word 6) the speed is set to 0 when the head is beyond $4000 and
;   still moving away, or nearer than $0800 and moving towards the centre line, on either side. when the first
;   test of an axis loads the speed, the second test compares that speed and not the position
;------------------------------------------------------------------------------
xmit_vel_limit:
P3_9AE0:  LDD  10,U                   ;the head's x relative to the player
P3_9AE2:  BMI  P3_9B04
P3_9AE4:  CMPD #$4000                 ;beyond $4000 and moving away: stop
P3_9AE8:  BLE  P3_9AF3
P3_9AEA:  LDD  4,U
P3_9AEC:  BMI  P3_9AF3
P3_9AEE:  LDD  #$0000
P3_9AF1:  STD  4,U
P3_9AF3:  CMPD #$0800                 ;nearer than $0800 and moving in: stop
P3_9AF7:  BGE  P3_9B02
P3_9AF9:  LDD  4,U
P3_9AFB:  BPL  P3_9B02
P3_9AFD:  LDD  #$0000
P3_9B00:  STD  4,U
P3_9B02:  BRA  P3_9B22
P3_9B04:  CMPD #$C000                 ;the same on the negative side
P3_9B08:  BGE  P3_9B13
P3_9B0A:  LDD  4,U
P3_9B0C:  BPL  P3_9B13
P3_9B0E:  LDD  #$0000
P3_9B11:  STD  4,U
P3_9B13:  CMPD #$F800
P3_9B17:  BLE  P3_9B22
P3_9B19:  LDD  4,U
P3_9B1B:  BMI  P3_9B22
P3_9B1D:  LDD  #$0000
P3_9B20:  STD  4,U
P3_9B22:  LDD  12,U                   ;the head's y relative to the player, the same tests
P3_9B24:  BMI  P3_9B46
P3_9B26:  CMPD #$4000
P3_9B2A:  BLE  P3_9B35
P3_9B2C:  LDD  6,U
P3_9B2E:  BMI  P3_9B35
P3_9B30:  LDD  #$0000
P3_9B33:  STD  6,U
P3_9B35:  CMPD #$0800
P3_9B39:  BGE  P3_9B44
P3_9B3B:  LDD  6,U
P3_9B3D:  BPL  P3_9B44
P3_9B3F:  LDD  #$0000
P3_9B42:  STD  6,U
P3_9B44:  BRA  P3_9B64
P3_9B46:  CMPD #$C000
P3_9B4A:  BGE  P3_9B55
P3_9B4C:  LDD  6,U
P3_9B4E:  BPL  P3_9B55
P3_9B50:  LDD  #$0000
P3_9B53:  STD  6,U
P3_9B55:  CMPD #$F800
P3_9B59:  BLE  P3_9B64
P3_9B5B:  LDD  6,U
P3_9B5D:  BMI  P3_9B64
P3_9B5F:  LDD  #$0000
P3_9B62:  STD  6,U
P3_9B64:  RTS

xmit_move_tab:
P3_9B65:  .word xmit_mv_hit           ;move routines by kind: 0 hit, 1 straight, 2 drifting, 3 jittering
P3_9B67:  .word xmit_mv_straight
P3_9B69:  .word xmit_mv_drift
P3_9B6B:  .word xmit_mv_jitter

;------------------------------------------------------------------------------
; xmit_view_all - view of the probot transmissions, called by the probot views and by man_view_probot. sets the
;   ship 2 block to unit vectors (UNITV), then for each record in use and each of its five trail points, newest
;   first: the point, with the player's x and y added back, goes through MS_PSB2 in the scratch block. a point in
;   front of the player and inside the 45 degree view cone sets the on-screen flag (byte 1 bit 4), is tested
;   against the lazar (xmit_lz_test, the head only) and drawn (xmit_draw_pt). keeps X and U
;------------------------------------------------------------------------------
xmit_view_all:
P3_9B6D:  PSHS X,U
P3_9B6F:  LDU  #M_CX2                 ;ship 2 block: unit vectors, for the MS_CNCT of xmit_draw_pt
P3_9B72:  JSR  UNITV
P3_9B75:  LDU  #xmit_atst
P3_9B78:  STU  xmit_cur
P3_9B7B:  CLR  1,U                    ;clear the flags, bit 4 is set below when a point is on screen
P3_9B7D:  LEAX $26,U                  ;end of the loop over the trail points
P3_9B80:  STX  xmit_pts_end
P3_9B83:  LDA  ,U
P3_9B85:  BEQ  P3_9C01
P3_9B87:  LDA  #$00                   ;trail point index * 2
P3_9B89:  STA  xmit_pt_ix
P3_9B8C:  LDA  3,U                    ;brightness from the timer's low four bits, used when the transmission has been hit
P3_9B8E:  ASLA
P3_9B8F:  ASLA
P3_9B90:  ASLA
P3_9B91:  ASLA
P3_9B92:  ORA  #$0F
P3_9B94:  STA  xmit_brt
P3_9B97:  LEAX 10,U                   ;X = the head, the first trail point
P3_9B99:  LDD  ,X                     ;the point in universe coordinates: the player's x and y added back
P3_9B9B:  ADDD s1_tx
P3_9B9E:  STD  M_X0
P3_9BA1:  LDD  2,X
P3_9BA3:  ADDD s1_ty
P3_9BA6:  STD  M_Y0
P3_9BA9:  LDD  XPS_CZ,X
P3_9BAB:  STD  M_Z0
P3_9BAE:  LDD  #MS_X0BC               ;scratch block
P3_9BB1:  STD  M_BIC
P3_9BB4:  LDA  #MS_PSB2
P3_9BB6:  JSR  MGOWT
P3_9BB9:  LDD  M_XP
P3_9BBC:  BLT  P3_9BF2                ;behind the player: not drawn
P3_9BBE:  STD  M_DVD                  ;start the divide for the perspective
P3_9BC1:  STD  M_XT
P3_9BC4:  LDD  M_ZP
P3_9BC7:  STD  M_ZT
P3_9BCA:  BPL  P3_9BD0                ;IFMI
P3_9BCC:  COMA                        ;NEGD
P3_9BCD:  NEGB
P3_9BCE:  SBCA #$FF
P3_9BD0:  SUBD M_XP                   ;|z| not less than x: outside the view
P3_9BD3:  BCC  P3_9BF2
P3_9BD5:  LDD  M_YP
P3_9BD8:  STD  M_YT
P3_9BDB:  BPL  P3_9BE1                ;IFMI
P3_9BDD:  COMA                        ;NEGD
P3_9BDE:  NEGB
P3_9BDF:  SBCA #$FF
P3_9BE1:  SUBD M_XP                   ;|y| not less than x: outside the view
P3_9BE4:  BCC  P3_9BF2
P3_9BE6:  LDA  1,U                    ;flag: on screen in this view
P3_9BE8:  ORA  #$10
P3_9BEA:  STA  1,U
P3_9BEC:  JSR  xmit_lz_test
P3_9BEF:  JSR  xmit_draw_pt
P3_9BF2:  LDA  xmit_pt_ix
P3_9BF5:  ADDA #$02
P3_9BF7:  STA  xmit_pt_ix
P3_9BFA:  LEAX 6,X                    ;next trail point
P3_9BFC:  CMPX xmit_pts_end
P3_9BFF:  BCS  P3_9B99
P3_9C01:  LDU  xmit_cur
P3_9C04:  LEAU $28,U                  ;next record
P3_9C07:  CMPU #xmit_atst+(3*$28)
P3_9C0B:  LBCS P3_9B78
P3_9C0F:  PULS X,U,PC

;------------------------------------------------------------------------------
; xmit_draw_pt - draws one trail point of a transmission as object 8, a hexagon: the colour word by the point's
;   place in the trail from xmit_col_tab (a hit transmission is drawn in colour 5 with xmit_brt, $10 less for each
;   point), a blank vector to the point (bank 1 BJCNTR), the scale word from xmit_scal_tab, each older point
;   smaller, MS_CNCT, then the object's points and lines (bank 1 JOBJBPNT, KDA2C) and back to the centre (KD8AC).
;   Y is the display list
;------------------------------------------------------------------------------
xmit_draw_pt:
P3_9C11:  PSHS X
P3_9C13:  LDA  ,U
P3_9C15:  BITA #$04                   ;hit by the lazar?
P3_9C17:  BEQ  P3_9C2B
P3_9C19:  LDB  xmit_brt               ;yes: each point of the trail $10 dimmer than the one before
P3_9C1C:  SUBB #$10
P3_9C1E:  BCC  P3_9C22
P3_9C20:  LDB  #$00
P3_9C22:  STB  xmit_brt
P3_9C25:  LDA  #$65                   ;colour 5 (purple) with that brightness
P3_9C27:  STD  ,Y++
P3_9C29:  BRA  P3_9C3B
P3_9C2B:  LDB  xmit_pt_ix             ;live: the colour word by the point's place in the trail
P3_9C2E:  CMPB #$0A
P3_9C30:  BCS  P3_9C34
P3_9C32:  LDB  #$08                   ;never taken: the index is 8 at most
P3_9C34:  LDX  #xmit_col_tab
P3_9C37:  LDD  B,X
P3_9C39:  STD  ,Y++
P3_9C3B:  JSR  L60B4                  ;bank 1 BJCNTR: blank vector to the point
P3_9C3E:  LDB  xmit_pt_ix             ;the scale word by the point's place in the trail
P3_9C41:  CMPB #$0A
P3_9C43:  BCS  P3_9C47
P3_9C45:  LDB  #$08
P3_9C47:  LDX  #xmit_scal_tab
P3_9C4A:  LDD  B,X
P3_9C4C:  STD  ,Y++
P3_9C4E:  LDA  #$40                   ;MS_CNCT: ship 2 (unit vectors) viewed from the player's ship
P3_9C50:  JSR  MGOWT
P3_9C53:  LDB  #$08                   ;object 8: perspect its points
P3_9C55:  JSR  L60D2
P3_9C58:  JSR  L60E4                  ;bank 1 KDA2C: draw the object
P3_9C5B:  JSR  L60BA                  ;bank 1 KD8AC: back to the screen centre
P3_9C5E:  PULS X,PC

xmit_col_tab:
P3_9C60:  .word $A013                 ;JSRL $0026  colour words of the five trail points: JSRL $0026 for the head, then white $A0, yellow $70, $50, $20
P3_9C62:  .word $67A0                 ;STAT colour 7, brightness $A0
P3_9C64:  .word $6670                 ;STAT colour 6, brightness $70
P3_9C66:  .word $6650                 ;STAT colour 6, brightness $50
P3_9C68:  .word $6620                 ;STAT colour 6, brightness $20

xmit_scal_tab:
P3_9C6A:  .word $7200                 ;SCAL 2,$00  scale words of the five trail points: binary scale 2, linear $00 for the head to $80 for the oldest
P3_9C6C:  .word $7220                 ;SCAL 2,$20
P3_9C6E:  .word $7240                 ;SCAL 2,$40
P3_9C70:  .word $7260                 ;SCAL 2,$60
P3_9C72:  .word $7280                 ;SCAL 2,$80

;------------------------------------------------------------------------------
; xmit_lz_test - lazar test on the head of a transmission, called by xmit_view_all with the point's view
;   coordinates in M_XT, M_YT, M_ZT. only for trail point 0 of a transmission that is live and not hit, and nearer
;   than the nearest one found so far (xmit_hit_d). the cursor (LZ_CX, LZ_CY) has to be within 10 screen units
;   plus a radius of the head's screen position: the radius is $3C at that distance across, and half the climb
;   speed up and down. a transmission that passes is recorded by xmit_lz_take
;------------------------------------------------------------------------------
xmit_lz_test:
P3_9C74:  LDA  xmit_pt_ix             ;the head only
P3_9C77:  BNE  P3_9CE7
P3_9C79:  LDA  ,U                     ;live
P3_9C7B:  BITA #$03
P3_9C7D:  BEQ  P3_9CE7
P3_9C7F:  BITA #$04                   ;and not hit already
P3_9C81:  BNE  P3_9CE7
P3_9C83:  LDD  M_XT                   ;nearer than the nearest transmission so far?
P3_9C86:  CMPD xmit_hit_d
P3_9C8A:  BCC  P3_9CE7
P3_9C8C:  STD  M_DVD                  ;start the divide: M_QUO = 1 / distance
P3_9C8F:  LDD  M_YT
P3_9C92:  STD  M_YP
P3_9C95:  LDD  #$003C                 ;radius across: $3C
P3_9C98:  STD  M_ZP
P3_9C9B:  LDD  M_QUO
P3_9C9E:  STD  M_XP                   ;GET X FOR PROPER SCREEN CONVERSION
P3_9CA1:  LDA  #MS_PERS
P3_9CA3:  JSR  MGOWT
P3_9CA6:  LDD  M_YP                   ;the head's screen x against the cursor
P3_9CA9:  SUBD LZ_CX
P3_9CAB:  BPL  P3_9CB1
P3_9CAD:  COMA
P3_9CAE:  NEGB
P3_9CAF:  SBCA #$FF
P3_9CB1:  SUBD #$000A                 ;within 10 plus the radius?
P3_9CB4:  SUBD M_ZP
P3_9CB7:  BGT  P3_9CE7
P3_9CB9:  LDD  M_ZT
P3_9CBC:  STD  M_YP
P3_9CBF:  LDD  8,U                    ;radius up and down: half the climb speed
P3_9CC1:  BPL  P3_9CC7
P3_9CC3:  COMA
P3_9CC4:  NEGB
P3_9CC5:  SBCA #$FF
P3_9CC7:  ASRA
P3_9CC8:  RORB
P3_9CC9:  STD  M_ZP
P3_9CCC:  LDA  #MS_PERS
P3_9CCE:  JSR  MGOWT                  ;DO THE MULTIPLYS
P3_9CD1:  LDD  M_YP                   ;NOW TEST UNROTATED VIDEO LOC
P3_9CD4:  SUBD LZ_CY
P3_9CD6:  BPL  P3_9CDC
P3_9CD8:  COMA
P3_9CD9:  NEGB
P3_9CDA:  SBCA #$FF
P3_9CDC:  SUBD #$000A                 ;within 10 plus the radius?
P3_9CDF:  SUBD M_ZP
P3_9CE2:  BGT  P3_9CE7
P3_9CE4:  JSR  xmit_lz_take
P3_9CE7:  RTS

;------------------------------------------------------------------------------
; xmit_lz_take - records the transmission at U as the nearest one under the lazar cursor: xmit_hit_rec = U,
;   xmit_hit_d = its view distance M_XT
;------------------------------------------------------------------------------
xmit_lz_take:
P3_9CE8:  STU  xmit_hit_rec
P3_9CEB:  LDD  M_XT
P3_9CEE:  STD  xmit_hit_d
P3_9CF1:  RTS

;------------------------------------------------------------------------------
; xmit_hit - the lazar has hit the transmission in xmit_hit_rec: reached from lz_hit_probot through the maze. if
;   the record is still in use it is marked hit (status bit 2 set, bit 0 cleared), its timer is set to $0F and its
;   kind to 0, so it fades out in place over 15 frames. sound command $44 silences the transmission tone when no
;   other transmission is live, then the hit sound (aud_cmd_3b) and 5 points (scr_xmit_5). keeps U
;------------------------------------------------------------------------------
xmit_hit:
P3_9CF2:  PSHS U
P3_9CF4:  LDU  xmit_hit_rec
P3_9CF7:  LDA  ,U
P3_9CF9:  BEQ  P3_9D29                ;record freed meanwhile: nothing
P3_9CFB:  ORA  #$04                   ;status: hit, no longer live
P3_9CFD:  ANDA #$FE
P3_9CFF:  STA  ,U
P3_9D01:  LDA  #$0F                   ;15 frames to fade out
P3_9D03:  STA  3,U
P3_9D05:  LDA  #$FF
P3_9D07:  STA  xmit_brt
P3_9D0A:  LDA  #$00                   ;kind 0: stays in place
P3_9D0C:  STA  2,U
P3_9D0E:  LDU  #xmit_atst             ;any transmission still live?
P3_9D11:  LDA  ,U
P3_9D13:  BITA #$01
P3_9D15:  BNE  P3_9D23
P3_9D17:  LEAU $28,U
P3_9D1A:  CMPU #xmit_atst+(3*$28)
P3_9D1E:  BCS  P3_9D11
P3_9D20:  JSR  aud_cmd_44             ;none: silence the transmission tone
P3_9D23:  JSR  aud_cmd_3b
P3_9D26:  JSR  scr_xmit_5
P3_9D29:  PULS U,PC
P3_9D2B:  .byte $FF, $27, $08, $B7, $46, $E0, $86, $00 ;not reached: from here to the common tail the page holds a copy of the IRQ handler of bank 0 from $EB01 on (its CMPA operand, then IRQ_112 and DOVG), linked at another address. it differs from bank 0 only in this byte ($FF for $D3) and in three addresses of the handler's own module, which are $4DD6 lower. the copy runs on into the tail at $9DCD
P3_9D33:  .byte $B7, $44, $00, $96, $0A, $84, $03, $26
P3_9D3B:  .byte $48, $B6, $48, $1C, $8B, $01, $81, $FA
P3_9D43:  .byte $25, $02, $86, $00, $B7, $48, $1C, $26
P3_9D4B:  .byte $38, $B6, $48, $1B, $8B, $01, $19, $B7
P3_9D53:  .byte $48, $1B, $B6, $48, $1A, $89, $00, $19
P3_9D5B:  .byte $25, $03, $B7, $48, $1A, $B6, $4C, $38
P3_9D63:  .byte $8B, $01, $19, $B7, $4C, $38, $B6, $4C
P3_9D6B:  .byte $37, $89, $00, $19, $B7, $4C, $37, $B6
P3_9D73:  .byte $4C, $36, $89, $00, $19, $B7, $4C, $36
P3_9D7B:  .byte $B6, $4C, $35, $89, $00, $19, $B7, $4C
P3_9D83:  .byte $35, $0A, $47, $28, $0C, $B7, $46, $20
P3_9D8B:  .byte $F6, $48, $CD, $BD, $A3, $42, $7E, $9E
P3_9D93:  .byte $E6, $10, $2A, $01, $4E, $B6, $43, $20
P3_9D9B:  .byte $48, $10, $2A, $01, $46, $96, $46, $2A
P3_9DA3:  .byte $19, $B6, $00, $00, $84, $0A, $27, $02
P3_9DAB:  .byte $86, $14, $8A, $00, $97, $46, $C6, $1D
P3_9DB3:  .byte $44, $84, $0A, $88, $0A, $8A, $E0, $FD
P3_9DBB:  .byte $00, $00, $0A, $29, $2A, $05, $0F, $29
P3_9DC3:  .byte $BD, $9F, $44, $BD, $9F, $E2, $D6, $41
P3_9DCB:  .byte $CB, $02, $C1, $10, $25, $01, $5F, $D7 ;from $9DCD to the end of the page the bytes are the same on all four pages (see irq_old_tail on page 0)
P3_9DD3:  .byte $41, $8E, $00, $04, $3A, $CE, $B9, $22
P3_9DDB:  .byte $EC, $C1, $ED, $83, $8C, $00, $02, $2E
P3_9DE3:  .byte $F7, $8E, $00, $12, $11, $83, $B9, $32
P3_9DEB:  .byte $24, $06, $EC, $C1, $ED, $83, $20, $F4
P3_9DF3:  .byte $D6, $42, $CB, $02, $8E, $9E, $02, $F6
P3_9DFB:  .byte $4C, $5A, $3A, $A6, $00, $48, $39, $00 ;$9DFE: LDA 0,X / ASLA / RTS, the helper page 1 calls for the slapstic's alternate sequence. nothing calls it on this page. from $9E02 16 bytes of $00 and $FF, read by nothing
P3_9E03:  .byte $00, $00, $FF, $00, $00, $FF, $00, $FF
P3_9E0B:  .byte $00, $FF, $FF, $00, $FF, $FF, $FF, $C1
P3_9E13:  .byte $08, $25, $01, $5F, $D7, $38, $CE, $B9
P3_9E1B:  .byte $3A, $EC, $C5, $FD, $00, $1A, $D6, $38
P3_9E23:  .byte $CE, $B9, $42, $EC, $C5, $FD, $00, $1E
P3_9E2B:  .byte $0A, $39

;------------------------------------------------------------------------------
; irq_old_tail_p3 - not a routine start: the middle of the leftover copy of bank 0's irq_handler, the same bytes
;   as on page 0, where irq_old_tail describes it. on this page the copy starts at $9D2C, behind xmit_hit. nothing
;   runs it: the one live routine of the tail $9DCD-$9FFF, the helper at $9DFE, is called on page 1 only
;------------------------------------------------------------------------------
irq_old_tail_p3:
P3_9E2D:  BGT  P3_9E46
P3_9E2F:  LDB  #$01
P3_9E31:  STB  pic1c_timer

;===LAZAR SPLASH
DOVG_48_P3:
P3_9E33:  LDB  pic1c_index
P3_9E35:  ADDB #$02
P3_9E37:  CMPB #$08
P3_9E39:  BLO  P3_9E3C                ;IFHS
P3_9E3B:  CLRB
P3_9E3C:  STB  pic1c_index
P3_9E3E:  LDU  #VTGNT
P3_9E41:  LDD  B,U
P3_9E43:  STD  $001C                  ;ONE PICTURE ONLY
;ALIEN GUN SHOT, BASE SPARKLE
P3_9E46:  DEC  lzs_timer
P3_9E48:  BGT  P3_9E61                ;IFLE
P3_9E4A:  LDB  #$02                   ;EVERY FOURTH SCREEN, CHANGE PICTURE TYPE
P3_9E4C:  STB  lzs_timer

;===LAZAR SPLASH
DOVG_48_P3_2:
P3_9E4E:  LDB  VG_LZS
P3_9E50:  ADDB #$02
P3_9E52:  CMPB #$08
P3_9E54:  BLO  P3_9E57                ;IFHS
P3_9E56:  CLRB
P3_9E57:  STB  VG_LZS
P3_9E59:  LDU  #spark_tab
P3_9E5C:  LDD  B,U
P3_9E5E:  STD  VRLZS                  ;ONE PICTURE ONLY
;ALIEN GUN SHOT, BASE SPARKLE
P3_9E61:  DEC  VF_GNB
P3_9E63:  BGT  P3_9E7C                ;IFLE
P3_9E65:  LDB  #$01                   ;EVERY FOURTH SCREEN, CHANGE PICTURE TYPE
P3_9E67:  STB  VF_GNB

;===LAZAR SPLASH
DOVG_48_P3_3:
P3_9E69:  LDB  gnx_index
P3_9E6B:  ADDB #$02
P3_9E6D:  CMPB #$08
P3_9E6F:  BLO  P3_9E72                ;IFHS
P3_9E71:  CLRB
P3_9E72:  STB  gnx_index
P3_9E74:  LDU  #sparks_tab
P3_9E77:  LDD  B,U
P3_9E79:  STD  VRGNX
;ALIEN GUN SHOT, TIP FUSE
P3_9E7C:  DEC  VF_GNT
P3_9E7E:  BGT  P3_9E97                ;IFLE
P3_9E80:  LDB  #$01                   ;EVERY SCREEN, CHANGE PICTURE TYPE
P3_9E82:  STB  VF_GNT
P3_9E84:  LDB  VG_GNT
P3_9E86:  ADDB #$02
P3_9E88:  CMPB #$08
P3_9E8A:  BLO  P3_9E8D                ;IFHS
P3_9E8C:  CLRB
P3_9E8D:  STB  VG_GNT
P3_9E8F:  LDU  #tri_tab
P3_9E92:  LDD  B,U
P3_9E94:  STD  VRGNT                  ;ONE PICTURE ONLY
P3_9E97:  LDB  VG_FLS                 ;BRITE FLASH
P3_9E99:  ADDB #$02
P3_9E9B:  CMPB #VTFLSZ-VTFLS
P3_9E9D:  BLO  P3_9EA0                ;IFHS  ?OVERFLOWED?
P3_9E9F:  CLRB
P3_9EA0:  STB  VG_FLS
P3_9EA2:  LDU  #VTFLS
P3_9EA5:  LDD  B,U
P3_9EA7:  STD  VRFLS                  ;ONE PICTURE ONLY
P3_9EAA:  LDB  gs_fade
P3_9EAC:  STD  $002E
P3_9EAF:  LDB  #$80
P3_9EB1:  SUBB flash_fade
P3_9EB4:  STD  $0032
P3_9EB7:  LDD  #VGRTSL
P3_9EBA:  STD  $0028
P3_9EBD:  STD  $0030
P3_9EC0:  STD  $0034                  ;AND RETURN VG
P3_9EC3:  LDB  VG_MFL                 ;MEDIUM FLASH
P3_9EC5:  ADDB #$02
P3_9EC7:  CMPB #VTMFLZ-VTMFL
P3_9EC9:  BLO  P3_9ECC                ;IFHS  ?OVERFLOWED TABLE?
P3_9ECB:  CLRB                        ;THEN START AT BEGINNING
P3_9ECC:  STB  VG_MFL
P3_9ECE:  LDU  #VTMFL
P3_9ED1:  LDD  B,U
P3_9ED3:  STD  VRMFL                  ;ONE PICTURE ONLY
P3_9ED6:  LDD  #VGRTSL
P3_9ED9:  STD  VRMFL+2                ;AND RETURN VG
P3_9EDC:  JSR  SPLASH                 ;OSCILLATE LAZAR SPLASH PICS
P3_9EDF:  STA  VGGO                   ;START VGEN AGAIN
P3_9EE2:  LDA  #$05
P3_9EE4:  STA  VGTIMR

DOVG_90_P3:
P3_9EE6:  STA  IRCLR                  ;ALLOW NEXT IRQ
P3_9EE9:  RTS

;------------------------------------------------------------------------------
; DEBNCE_P3 - A=NEW VAL
;   X-->RAM AREA
;   in ESB: copy of bank 0's DEBNCE inside the leftover irq_handler copy that ends every page ($9DCD-$9FFF,
;   see irq_old_tail on page 0), never run
;------------------------------------------------------------------------------
DEBNCE_P3:
P3_9EEA:  LDB  ,X                     ;NW: PREVIOUS NEW
P3_9EEC:  STB  1,X                    ;OL: -->OLD
P3_9EEE:  STA  ,X                     ;NW: SAVE NEWEST
P3_9EF0:  ANDA 1,X                    ;OL: SAME BITS ON
P3_9EF2:  ORA  2,X                    ;SW:
P3_9EF4:  STA  2,X                    ;SW: SAVE DEBOUNCED ON BITS
P3_9EF6:  ORB  ,X++                   ;NW: SAME BITS OFF
P3_9EF8:  ANDB ,X                     ;SW:
P3_9EFA:  STB  ,X+                    ;SW: SAVE DEBOUNCED OFF BITS,
;(X)+: PREPARE FOR NEXT SWITCH SET
P3_9EFC:  RTS

;------------------------------------------------------------------------------
; DOPOTS_P3 - HANDLE READING POT VALUES
;   in ESB: copy of bank 0's DOPOTS inside the leftover irq_handler copy that ends every page, never run
;------------------------------------------------------------------------------
DOPOTS_P3:
P3_9EFD:  LDA  S_INTCT
P3_9EFF:  LSRA                        ;?WHICH POT?
P3_9F00:  LDY  #PT_VL                 ;ASSUME POT 1
P3_9F04:  BCS  P3_9F0A                ;IFCC  NOPE, IT'S THE OTHER ONE
P3_9F06:  LDY  #PT_VL+PTS_IZ          ;POT 2
;POKEY FILTER
;REQUIRE 2 SAMPLES ALL HIGHER (OR LOWER)
;THAN CURRENT SAVED VALUE.
;THEN UPDATE TO CLOSEST HI (LO) VALUE
P3_9F0A:  LDB  1,Y                    ;B:=VNEW PREVIOUS NEW BECOMES CURRENT OLD
P3_9F0C:  LDA  R_CHN
P3_9F0F:  STA  1,Y                    ;A:=VNEW UPDATE CURRENT NEW
P3_9F11:  CMPA ,Y                     ;VL
P3_9F13:  BLO  P3_9F23                ;IFHS  ?NEW VALUE HIGHER THAN STANDARD VALUE?
P3_9F15:  CMPB ,Y                     ;VL
P3_9F17:  BLS  P3_9F21                ;IFHI  ?AND OLD VALUE HIGHER ALSO?
P3_9F19:  CMPB 1,Y                    ;VNEW
P3_9F1B:  BLS  P3_9F1F                ;IFHI  ?VNEW IS CLOSER?
P3_9F1D:  LDB  1,Y                    ;VNEW
P3_9F1F:  STB  ,Y                     ;VL SAVE CLOSEST OF HIGHER VALUES
P3_9F21:  BRA  P3_9F2F                ;ELSE  ELSE NEW VALUE IS LOWER THAN STANDARD VALUE
P3_9F23:  CMPB ,Y                     ;VL
P3_9F25:  BHS  P3_9F2F                ;IFLO  ?OLD VALUE ALSO LOWER?
P3_9F27:  CMPB 1,Y                    ;VNEW
P3_9F29:  BHS  P3_9F2D                ;IFLO  ?VNEW IS CLOSER?
P3_9F2B:  LDB  1,Y                    ;VNEW
P3_9F2D:  STB  ,Y                     ;VL SAVE CLOSEST OF LOWER VALUES
P3_9F2F:  CMPY #PT_VL                 ;START NEXT A-D CONVERSION
P3_9F33:  BNE  P3_9F3D                ;IFEQ
P3_9F35:  STA  W_CHN0                 ;SELECT CHANNEL 0
P3_9F38:  STA  W_CHN0                 ;START GOOD CONVERSION
P3_9F3B:  BRA  P3_9F43                ;ELSE
P3_9F3D:  STA  W_CHN1                 ;SELECT CHANNEL 1
P3_9F40:  STA  W_CHN1                 ;AND START IT CLEANLY
P3_9F43:  RTS

;------------------------------------------------------------------------------
; RHCTRL_P3 - IRQ VG HANDLES CONTROLS
;   in ESB: copy of bank 0's RHCTRL inside the leftover irq_handler copy that ends every page, never run
;------------------------------------------------------------------------------
RHCTRL_P3:
P3_9F44:  LDX  #RHEOP                 ;DO PITCH POT
P3_9F47:  LDA  PT_VL2                 ;UP/DOWN VG Y
P3_9F49:  NOP
P3_9F4A:  JSR  RHLIM_P3               ;LIMIT AND SCALE RHESTAT
P3_9F4D:  LDA  RHS_NML,X              ;NOW LIMIT THE POT BY THE VG SCREEN
P3_9F4F:  CMPA #VGCURT                ;HI LIMIT - CURSOR SIZE, SCALED TO +-128
P3_9F51:  BLE  P3_9F55                ;IFGT
P3_9F53:  LDA  #VGCURT
P3_9F55:  CMPA #VGCURB&$FF            ;TOP CURSOR POSITION, SCALED DOWN +-512 TO +-128
P3_9F57:  BGE  P3_9F5B                ;IFLT
P3_9F59:  LDA  #VGCURB&$FF
P3_9F5B:  STA  RHS_NML,X
P3_9F5D:  JSR  RHPOS_P3
P3_9F60:  LDX  #RHEOY                 ;DO YAW POT
P3_9F63:  LDA  PT_VL1                 ;LEFT/RIGHT VG X
P3_9F65:  NOP
P3_9F66:  JSR  RHLIM_P3               ;LIMIT AND SCALE RHESTAT
P3_9F69:  LDA  RHS_NML,X              ;NOW LIMIT TO CURSOR SCREEN SIZE
P3_9F6B:  CMPA #VGCURR
P3_9F6D:  BLE  P3_9F71                ;IFGT
P3_9F6F:  LDA  #VGCURR
P3_9F71:  CMPA #VGCURL&$FF
P3_9F73:  BGE  P3_9F77                ;IFLT
P3_9F75:  LDA  #VGCURL&$FF
P3_9F77:  STA  RHS_NML,X
P3_9F79:  JSR  RHPOS_P3
P3_9F7C:  RTS

;------------------------------------------------------------------------------
; RHLIM_P3 - ---LIMIT AND SCALE
;   in ESB: copy of bank 0's RHLIM inside the leftover irq_handler copy that ends every page, never run
;------------------------------------------------------------------------------
RHLIM_P3:
P3_9F7D:  CMPA ,X                     ;A=RHEOSTAT VALUE
;X==>RAM BLOCK
;Y==>DATA TABLE
P3_9F7F:  BHS  P3_9F87                ;IFLO  ?LESS THAN LO?
P3_9F81:  CMPA RHS_LT,X
P3_9F83:  BLO  P3_9F87                ;IFHS  ?HIGHER THAN TRIAL LO?
P3_9F85:  DEC  ,X                     ;APPROACH NEW DEGLITCHED LO
P3_9F87:  STA  RHS_LT,X               ;SAVE OUR NEW TRIAL LO
P3_9F89:  CMPA ,X                     ;?LESS THAN LOWER LIMIT?
P3_9F8B:  BHS  P3_9F8F                ;IFLO
P3_9F8D:  LDA  ,X                     ;THEN REPLACE WITH LOWER LIMIT
P3_9F8F:  SUBA ,X                     ;BASE AT ZERO
P3_9F91:  STA  RH_DIR                 ;TEMP STORAGE OF POT BASED VALUE
P3_9F93:  LDB  RHS_SP,X               ;SPREAD THE VALUES-SCAL
P3_9F95:  MUL
P3_9F96:  ADDA RH_DIR                 ;MULTS BY 1XX SO VALUE GOES ABOVE 7F
P3_9F98:  BNE  P3_9F9C                ;IFEQ  ?UNDERFLOW?
P3_9F9A:  LDA  #$01                   ;RANGE IS -7F TO 7F (ALLOWS PROPER NEGATE)
P3_9F9C:  BCS  P3_9FA2                ;IFCC  ?OVERFLOW?
P3_9F9E:  CLR  RHS_ST,X               ;PREPARE TIMER FOR NEXT TOO-HIGH POT VALUE
P3_9FA0:  BRA  P3_9FAE                ;ELSE
P3_9FA2:  LDA  #$FF                   ;THEN LIMIT VALUE
P3_9FA4:  INC  RHS_ST,X               ;TIME THESE EXCESSES
P3_9FA6:  LDB  RHS_ST,X
P3_9FA8:  CMPB #$02
P3_9FAA:  BLO  P3_9FAE                ;IFHS  ?TOO LARGE FOR TOO LONG?
P3_9FAC:  DEC  RHS_SP,X               ;THEN DECREASE SPREAD
P3_9FAE:  CLRB
P3_9FAF:  SUBA #$80                   ;CHANGE TO SIGNED VALUE
P3_9FB1:  STA  RHS_NML,X
P3_9FB3:  RTS

;------------------------------------------------------------------------------
; RHPOS_P3 - CONVERT NML VALUE TO SCREEN POSITION
;   SLEWED POSITIONAL
;   in ESB: copy of bank 0's RHPOS inside the leftover irq_handler copy that ends every page, never run
;------------------------------------------------------------------------------
RHPOS_P3:
P3_9FB4:  CLR  RH_DIR                 ;START WITH POSITIVE DIRECTION TO TRAVEL
P3_9FB6:  LDA  RHS_NML,X              ;CURRENT -7F TO 7F POT
P3_9FB8:  LDB  #$80                   ;HALF WAY INTO POTS STAMP
P3_9FBA:  SUBD RHS_POS,X              ;CURRENT SCREEN POSITION
P3_9FBC:  BGE  P3_9FC1                ;IFLT  ?WANT TO GO IN NEGATIVE DIRECTION?
P3_9FBE:  NEGA                        ;THEN CHANGE DELTA TO POSITIVE 8-BIT
P3_9FBF:  DEC  RH_DIR                 ;AND SAVE NEGATIVE INDICATOR
P3_9FC1:  BLE  P3_9FC6                ;IFGT  ?SLIGHTLY POSITIVE?
P3_9FC3:  ADDD #$00FF                 ;TRUNCATE UPWARD -- ALWAYS SLEW SOME
P3_9FC6:  CMPA #$F8
P3_9FC8:  BLS  P3_9FCC                ;IFHI
P3_9FCA:  LDA  #$F8                   ;PREVENT OVERFLOWS DURING LATER TRUNCATIONS
P3_9FCC:  LDB  #$60                   ;HOW QUICKLY TO SKEW TO DESIRED LOCATION
P3_9FCE:  CMPA #$40                   ;ONE-QUARTER SCREEN
P3_9FD0:  BHS  P3_9FD4                ;IFLO  ?CLOSE ENUF?
P3_9FD2:  LDB  #$30                   ;SLOWER WHEN CLOSER
P3_9FD4:  MUL
P3_9FD5:  TST  RH_DIR                 ;RESTORE ORIGINAL DIRECTION
P3_9FD7:  BPL  P3_9FDD                ;IFMI
P3_9FD9:  COMA                        ;NEGD
P3_9FDA:  NEGB
P3_9FDB:  SBCA #$FF
P3_9FDD:  ADDD RHS_POS,X              ;NOW UPDATE OUR CURSOR POSITION
P3_9FDF:  STD  RHS_POS,X              ;RH$POS IS EQUATED TO VG.RSX,VG.RSY
P3_9FE1:  RTS
P3_9FE2:  .byte $D6, $6A, $96, $6B, $84, $C0, $48, $59 ;the start of a copy of GNSITE, as bank 0 LEDB8-LEDD4, cut off by the end of the page
P3_9FEA:  .byte $24, $02, $8A, $3F, $49, $59, $49, $DD
P3_9FF2:  .byte $30, $C3, $FF, $98, $84, $1F, $FD, $00
P3_9FFA:  .byte $14, $D6, $73, $96, $74, $FF
