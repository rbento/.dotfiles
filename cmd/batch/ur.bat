@echo off
for %%i in ("%cd%") do set "PROJECT=%%~ni"
set UPROJECTS=%USERPROFILE%\Documents\"Unreal Projects"
set UREFRESH=%UPROJECTS%\Refresh.bat
call %UREFRESH% %PROJECT%

