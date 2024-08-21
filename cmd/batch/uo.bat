@echo off
for %%i in ("%cd%") do set "PROJECT=%%~ni"
set UPROJECTS=%USERPROFILE%\Documents\"Unreal Projects"
set UOPEN=%UPROJECTS%\Open.bat
call %UOPEN% %PROJECT%

