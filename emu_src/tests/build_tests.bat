@echo off
rem Build esbrun.exe (x64, VS2022 cl): the machine without a window, for the
rem test runs of tests\run_tests.py.  Objects in ..\obj\tests.
call "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\VsDevCmd.bat" -arch=amd64 -no_logo
cd /d "%~dp0\.."

if not exist obj mkdir obj
if not exist obj\tests mkdir obj\tests

cl /nologo /O2 /W3 /std:c++17 /EHsc /MD /D_CRT_SECURE_NO_WARNINGS /I. /Icpu /c cpu\cpu_m6809.cpp tms5220.cpp /Foobj\tests\ || exit /b 1
cl /nologo /O2 /W4 /std:c11 /MD /D_CRT_SECURE_NO_WARNINGS /I. /c avg.c mathbox.c x2212.c riot6532.c slapstic101.c /Foobj\tests\ || exit /b 1
cl /nologo /O2 /W4 /std:c++17 /EHsc /MD /D_CRT_SECURE_NO_WARNINGS /I. /Icpu /c hw.cpp board.cpp tests\esbrun.cpp /Foobj\tests\ || exit /b 1
link /nologo /OUT:tests\esbrun.exe obj\tests\*.obj || exit /b 1
echo TESTS BUILD OK
