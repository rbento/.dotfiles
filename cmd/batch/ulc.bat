@echo off
SET PROJECT=%1
SET SERVER_IP=%2
SET PORT=%3
IF NOT DEFINED SERVER_IP SET SERVER_IP=127.0.0.1
IF NOT DEFINED PORT SET PORT=7777
echo Launching %PROJECT% client connected to server at %SERVER_IP%:%PORT% ...
"C:\Program Files\Epic Games\UE_5.3\Engine\Binaries\Win64\UnrealEditor.exe" "%USERPROFILE%\Documents\Unreal Projects\%PROJECT%\%PROJECT%.uproject" %SERVER_IP%:%PORT% -game -log

