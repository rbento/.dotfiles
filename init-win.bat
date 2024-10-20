@echo off

set USERDOTFILES=C:\\Users\\YOUR_NAME\\.dotfiles

echo(
echo + Installing...

echo(
echo + Using DOTFILES at %USERDOTFILES%

echo(
echo + Changing directory to %USERPROFILE% 
cd /D %USERPROFILE%
echo At %cd%
echo : OK

echo(
echo + Removing symbolic links...
del /q /a %USERPROFILE%\\AppData\\Roaming\\.emacs
del /q /a .gitconfig
del /q /a .gitignore-global
del /q _ideavimrc
del /q _vimrc
rd /q .vim
echo : OK

echo(
echo + Creating symbolic links...
mklink %USERPROFILE%\\AppData\\Roaming\\.emacs %USERDOTFILES%\\emacs\\emacs
mklink .gitconfig %USERDOTFILES%\\git\\gitconfig
mklink .gitignore-global %USERDOTFILES%\\git\\gitignore-global
mklink _ideavimrc %USERDOTFILES%\\vim\\ideavimrc
mklink _vimrc %USERDOTFILES%\\vim\\vimrc
mklink /D .vim %USERDOTFILES%\\vim
echo : OK

echo(
echo + Setting up vim colors
cd /D %USERPROFILE%\\vimfiles
rd /q colors
mklink /D colors %USERDOTFILES%\\vim\\colors
cd /D %USERPROFILE%
echo : OK

echo(
echo + Installing core applications and services
winget install --accept-package-agreements --accept-source-agreements 7zip.7zip BurntSushi.ripgrep.MSVC Amazon.Kindle dandavison.delta DEVCOM.Lua EpicGames.EpicGamesLauncher JFLarvoire.Ag junegunn.fzf Git.Git GitHub.GitLFS GnuPG.GnuPG Google.Chrome jqlang.jq KhronosGroup.VulkanSDK KronosGroup.VulkanRT Microsoft.PIX Microsoft.VisualStudio.2022.Community Oracle.JDK.23 Renderdoc sharkdp.bat sharkdp.fd UniversalCtags.Ctags Vim.Vim WiresharkFoundation.Wireshark
echo : OK

setx FZF_DEFAULT_COMMAND "fd --type f --follow"
setx FZF_DEFAULT_OPTS "--border"

echo(
echo : Done

rem echo(
rem echo + Unregistering init.cmd...
rem reg delete "HKCU\Software\Microsoft\Command Processor" /v AutoRun /f
rem echo : OK

rem del /q init.cmd 
rem mklink init.cmd %USERDOTFILES%\\cmd\\init.cmd

rem echo(
rem echo + Registering init.cmd...
rem reg add "HKCU\Software\Microsoft\Command Processor" /v AutoRun /t REG_EXPAND_SZ /d "%"USERPROFILE"%\init.cmd" /f
rem echo : OK

rem echo(
rem echo : PS
rem echo : - Run: reg add "HKCU\Software\Microsoft\Command Processor" /v AutoRun /t REG_EXPAND_SZ /d "%"USERPROFILE"%\init.cmd" /f
rem echo : - Add your name and e-mail to .gitconfig and review the editor and mergetool settings
