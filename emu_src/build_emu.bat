@echo off
rem Build the Empire Strikes Back emulator (x64, VS2022 cl): esb_emu.exe in emu_src\,
rem next to esb_emu.ini / esb_emu.log / esb.nv.
rem
rem   esb_emu.exe  the ROMs on two 6809 cores (cpu\, AAE's core) on the chip
rem                models (hw.cpp, board.cpp) and the slapstic model
rem                (slapstic101.c), behind the Star Wars project's window,
rem                sound and controls.
rem
rem Everything it is built from is in this directory.
rem
rem It reads the ROM images at run time from ..\disasm\build
rem (python ..\disasm\gen_from_roms.py; python ..\disasm\unslap.py for --set noslap;
rem python ..\disasm\pcb27256.py for --set pcb27256).
call "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\VsDevCmd.bat" -arch=amd64 -no_logo
cd /d "%~dp0"
rem __FILE__ without this directory, so no local path ends up in the exe
set TRIM=/d1trimfile:"%CD%"

for %%d in (obj obj\fw) do if not exist %%d mkdir %%d

rem ---- vendored framework, chip cores, the 6809 core (their own warning level)
cl /nologo %TRIM% /O2 /W3 /MD /D_CRT_SECURE_NO_WARNINGS /DUNICODE /D_UNICODE /c ^
   platform\windows\sys_gl.c platform\windows\glew.c ^
   platform\windows\log.c platform\windows\vector_draw.c ^
   platform\windows\mat4.c platform\windows\rawinput.c ^
   platform\windows\mixer.c platform\windows\fileio.c ^
   platform\windows\miniz.c platform\windows\ini.c ^
   platform\windows\joystick.c ^
   /Foobj\fw\ || exit /b 1
cl /nologo %TRIM% /O2 /W3 /std:c11 /MD /D_CRT_SECURE_NO_WARNINGS /I. /c c012294.c /Foobj\ || exit /b 1
cl /nologo %TRIM% /O2 /W3 /std:c++17 /EHsc /MD /D_CRT_SECURE_NO_WARNINGS /I. /Icpu /c cpu\cpu_m6809.cpp tms5220.cpp /Foobj\ || exit /b 1

rem ---- the chip models, the board, the machine and the backend ---------------
cl /nologo %TRIM% /O2 /W4 /std:c11 /MD /D_CRT_SECURE_NO_WARNINGS /I. /c avg.c mathbox.c x2212.c riot6532.c slapstic101.c /Foobj\ || exit /b 1
echo === esb_emu.exe
cl /nologo %TRIM% /O2 /W4 /std:c++17 /EHsc /MD /D_CRT_SECURE_NO_WARNINGS /I. /Icpu /c hw.cpp board.cpp emu_main.cpp /Foobj\ || exit /b 1
cl /nologo %TRIM% /O2 /W4 /std:c11 /MD /D_CRT_SECURE_NO_WARNINGS /DUNICODE /D_UNICODE /I. /Foobj\ ^
   platform\windows\plat_win.c ^
   obj\hw.obj obj\board.obj obj\emu_main.obj ^
   obj\avg.obj obj\mathbox.obj obj\x2212.obj obj\riot6532.obj obj\slapstic101.obj ^
   obj\c012294.obj obj\cpu_m6809.obj obj\tms5220.obj ^
   obj\fw\*.obj ^
   /Fe:esb_emu.exe ^
   /link /SUBSYSTEM:WINDOWS user32.lib gdi32.lib winmm.lib ole32.lib dwmapi.lib || exit /b 1

echo EMU BUILD OK
