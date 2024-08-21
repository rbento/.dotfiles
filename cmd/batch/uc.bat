@echo off
for %%i in ("%cd%") do set "PROJECT=%%~ni"
set UPROJECTS=%USERPROFILE%\Documents\"Unreal Projects"
set UCLEAN=%UPROJECTS%\Clean.bat
call %UCLEAN% %PROJECT%

