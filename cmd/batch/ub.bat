@echo off
for %%i in ("%cd%") do set "PROJECT=%%~ni"
set UPROJECTS=%USERPROFILE%\Documents\"Unreal Projects"
set UBUILD=%UPROJECTS%\Build.bat
call %UBUILD% %PROJECT%

