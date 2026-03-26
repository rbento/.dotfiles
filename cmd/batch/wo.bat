@ECHO OFF

IF "%USER_PROJECTS_HOME%" == "" (
    ECHO ABORTED: Environment Variable 'USER_PROJECTS_HOME' is not defined
    EXIT /B 1
)

cd /D %USER_PROJECTS_HOME%