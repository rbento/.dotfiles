@echo off
SET PROJECT=%1
SET MAP=%2
IF NOT DEFINED MAP SET MAP=Main
SET MAP=/Game/%1/%MAP%?listen
echo Launching '%PROJECT%' server on map '%MAP%' ...
"C:\Program Files\Epic Games\UE_5.3\Engine\Binaries\Win64\UnrealEditor.exe" "%USERPROFILE%\Documents\Unreal Projects\%PROJECT%\%PROJECT%.uproject" %MAP% -server -log