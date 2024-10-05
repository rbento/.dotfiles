@ECHO OFF

SETLOCAL

CALL uvars.bat || EXIT /B

IF "%1" == "" (
    ECHO ABORTED: Unreal project name was not provided
    EXIT /B
)

SET PROJECT=%1
SET SERVER_IP=%2
SET PORT=%3

IF NOT DEFINED SERVER_IP SET SERVER_IP=127.0.0.1
IF NOT DEFINED PORT SET PORT=7777

ECHO Launching %PROJECT% client connected to server at %SERVER_IP%:%PORT% ...

CALL %UE_EDITOR_EXE% %UE_PROJECTS_HOME%\%PROJECT%\%PROJECT%.uproject" %SERVER_IP%:%PORT% -game -log
