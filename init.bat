@echo off

set USERDOTFILES=C:\\Workspace\\.dotfiles

echo(
echo + Installing...

echo(
echo + Using DOTFILES at %USERDOTFILES%

echo(
echo + Changing directory to %USERPROFILE% 
cd %USERPROFILE%
echo : OK

echo(
echo + Unregistering init.cmd...
reg delete "HKCU\Software\Microsoft\Command Processor" /v AutoRun /f
echo : OK

echo(
echo + Removing symbolic links...
del /q /a .gitconfig
del /q /a .gitignore-global
del /q init.cmd 
del /q _ideavimrc
del /q _vimrc
rd /q .vim
echo : OK

echo(
echo + Creating symbolic links...
mklink .gitconfig %USERDOTFILES%\\git\\gitconfig
mklink .gitignore-global %USERDOTFILES%\\git\\gitignore-global
mklink init.cmd %USERDOTFILES%\\cmd\\init.cmd
mklink _ideavimrc %USERDOTFILES%\\vim\\ideavimrc
mklink _vimrc %USERDOTFILES%\\vim\\vimrc
mklink /D .vim %USERDOTFILES%\\vim
echo : OK

echo(
echo + Setting up vim colors
cd %USERPROFILE%\\vimfiles
rd /q colors
mklink /D colors %USERDOTFILES%\\vim\\colors
cd %USERPROFILE%
echo : OK

rem echo(
rem echo + Registering init.cmd...
rem reg add "HKCU\Software\Microsoft\Command Processor" /v AutoRun /t REG_EXPAND_SZ /d "%"USERPROFILE"%\init.cmd" /f
rem echo : OK

echo(
echo : Done

echo(
echo : PS
echo : - Run: reg add "HKCU\Software\Microsoft\Command Processor" /v AutoRun /t REG_EXPAND_SZ /d "%"USERPROFILE"%\init.cmd" /f
echo : - Add your name and e-mail to .gitconfig and review the editor and mergetool settings
