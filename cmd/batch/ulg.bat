@ECHO OFF

SETLOCAL

CALL uvars.bat || EXIT /B

IF "%1" == "" (
    ECHO ABORTED: Unreal project name was not provided
    EXIT /B
)

SET PROJECT=%1
SET MAP=%2

IF DEFINED MAP SET MAP=/Game/%1/%2
IF DEFINED MAP ECHO Launching '%PROJECT%' standalone on map '%MAP%' ...
IF NOT DEFINED MAP ECHO Launching '%PROJECT%' standalone on default map ...

CALL %UE_EDITOR_EXE% %UE_PROJECTS_HOME%\%PROJECT%\%PROJECT%.uproject" %MAP% -game -log