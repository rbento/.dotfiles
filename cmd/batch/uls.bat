@ECHO OFF

SETLOCAL

CALL uvars.bat || EXIT /B

IF "%1" == "" (
    ECHO ABORTED: Unreal project name was not provided
    EXIT /B
)

SET PROJECT=%1
SET MAP=%2

IF NOT DEFINED MAP SET MAP=Main
SET MAP=/Game/%1/%MAP%?listen

ECHO Launching '%PROJECT%' server on map '%MAP%'...

CALL %UE_EDITOR_EXE% %UE_PROJECTS_HOME%\%PROJECT%\%PROJECT%.uproject" %MAP% -server -log