@echo off
SET PROJECT=%1
SET MAP=%2
IF DEFINED MAP SET MAP=/Game/%1/%2
IF DEFINED MAP echo Launching '%PROJECT%' on map '%MAP%' ...
IF NOT DEFINED MAP echo Launching '%PROJECT%' on default map ...
"C:\Program Files\Epic Games\UE_5.3\Engine\Binaries\Win64\UnrealEditor.exe" "%USERPROFILE%\Documents\Unreal Projects\%PROJECT%\%PROJECT%.uproject" %MAP% -game -log

