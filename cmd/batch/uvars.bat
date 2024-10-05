@ECHO OFF

SETLOCAL

IF "%UE_VERSION%" == "" (
    ECHO ABORTED: Environment Variable 'UE_VERSION' is not defined
    EXIT /B 1
)

IF "%UE_HOME%" == "" (
    ECHO ABORTED: Environment Variable 'UE_HOME' is not defined
    EXIT /B 2
)

IF "%UE_PROJECTS_HOME%" == "" (
    ECHO ABORTED: Environment Variable 'UE_PROJECTS_HOME' is not defined
    EXIT /B 3
)

SET UE=%UE_HOME%%UE_VERSION%

SET UE_EDITOR_EXE=%UE%\Engine\Binaries\Win64\UnrealEditor.exe
SET UE_EDITOR_CMD_EXE=%UE%\Engine\Binaries\Win64\UnrealEditor-Cmd.exe
SET UE_BUILD_TOOL_BAT=%UE%\Engine\Build\BatchFiles\Build.bat