@echo off

set USERDOTFILES=C:\Users\YOUR_NAME\.dotfiles

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
del /q /a %USERPROFILE%\AppData\Roaming\.emacs
del /q /a .gitconfig
del /q /a .gitignore-global
del /q _ideavimrc
del /q _vimrc
rd /q .vim
echo : OK

echo(
echo + Creating symbolic links...
mklink %USERPROFILE%\AppData\Roaming\.emacs %USERDOTFILES%\emacs\emacs
mklink .gitconfig %USERDOTFILES%\git\gitconfig
mklink .gitignore-global %USERDOTFILES%\git\gitignore-global
mklink _ideavimrc %USERDOTFILES%\vim\ideavimrc
mklink _vimrc %USERDOTFILES%\vim\vimrc
mklink /D .vim %USERDOTFILES%\vim
echo : OK

echo(
echo + Setting up ripgrep config
mklink /D %USERPROFILE%\AppData\Roaming\ripgrep %USERDOTFILES%\config\ripgrep
echo : OK

echo(
echo + Setting up vim colors
cd /D %USERPROFILE%\vimfiles
rd /q colors
mklink /D colors %USERDOTFILES%\vim\colors
cd /D %USERPROFILE%
echo : OK

echo(
echo + Installing core applications and services
winget install --accept-package-agreements --accept-source-agreements ^
  7zip.7zip ^
  Amazon.Kindle ^
  BaldurKarlsson.RenderDoc ^
  BurntSushi.ripgrep.MSVC ^
  Cppcheck.Cppcheck ^
  dandavison.delta ^
  DEVCOM.Lua ^
  EpicGames.EpicGamesLauncher ^
  ezwinports.make ^
  GNU.Emacs ^
  Git.Git ^
  GitHub.GitLFS ^
  GnuPG.GnuPG ^
  Hibbiki.Chromium ^
  JFLarvoire.Ag ^
  JetBrains.Toolbox ^
  jqlang.jq ^
  junegunn.fzf ^
  KhronosGroup.VulkanSDK ^
  Kitware.CMake ^
  KronosGroup.VulkanRT ^
  LLVM.LLVM ^
  Microsoft.OpenJDK.21 ^
  Microsoft.PIX ^
  Microsoft.PerfView ^
  Microsoft.PowerShell ^
  Microsoft.PowerToys ^
  Microsoft.Sysinternals ^
  Microsoft.VisualStudio.Community ^
  Microsoft.WinDbg ^
  Microsoft.WindowsTerminal ^
  Ninja-build.Ninja ^
  sharkdp.bat ^
  sharkdp.fd ^
  UniversalCtags.Ctags ^
  Vim.Vim ^
  WiresharkFoundation.Wireshark
echo : OK

setx FZF_DEFAULT_COMMAND "fd --type f --follow --exclude *~ --exclude *# --exclude *.o --exclude *.class"
setx FZF_DEFAULT_OPTS "--border --inline-info"

echo(
echo + Installing FZF Vim plugin
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |^
    ni $HOME/vimfiles/autoload/plug.vim -Force

echo(
echo + Removing extraneous Windows components
Get-AppxPackage *3DBuilder* | Remove-AppxPackage
Get-AppxPackage *549981C3F5F10* | Remove-AppxPackage
Get-AppxPackage *BingNews* | Remove-AppxPackage
Get-AppxPackage *BingSearch* | Remove-AppxPackage
Get-AppxPackage *BingWeather* | Remove-AppxPackage
Get-AppxPackage *CandyCrush* | Remove-AppxPackage
Get-AppxPackage *Clipchamp* | Remove-AppxPackage
Get-AppxPackage *Copilot* | Remove-AppxPackage
Get-AppxPackage *Cortana* | Remove-AppxPackage
Get-AppxPackage *CrossDevice* | Remove-AppxPackage
Get-AppxPackage *DevHome* | Remove-AppxPackage
Get-AppxPackage *Disney* | Remove-AppxPackage
Get-AppxPackage *Facebook* | Remove-AppxPackage
Get-AppxPackage *Family* | Remove-AppxPackage
Get-AppxPackage *Feedback* | Remove-AppxPackage
Get-AppxPackage *GetHelp* | Remove-AppxPackage
Get-AppxPackage *Getstarted* | Remove-AppxPackage
Get-AppxPackage *Journal* | Remove-AppxPackage
Get-AppxPackage *LinkedInforWindows* | Remove-AppxPackage
Get-AppxPackage *Messaging* | Remove-AppxPackage
Get-AppxPackage *Microsoft3DViewer* | Remove-AppxPackage
Get-AppxPackage *MixedReality* | Remove-AppxPackage
Get-AppxPackage *Netflix* | Remove-AppxPackage
Get-AppxPackage *NetworkSpeedTest* | Remove-AppxPackage
Get-AppxPackage *OfficeHub* | Remove-AppxPackage
Get-AppxPackage *OneConnect* | Remove-AppxPackage
Get-AppxPackage *OneNote* | Remove-AppxPackage
Get-AppxPackage *OutlookForWindows* | Remove-AppxPackage
Get-AppxPackage *People* | Remove-AppxPackage
Get-AppxPackage *Phone* | Remove-AppxPackage
Get-AppxPackage *PowerAutomate* | Remove-AppxPackage
Get-AppxPackage *PowerBI* | Remove-AppxPackage
Get-AppxPackage *Print3D* | Remove-AppxPackage
Get-AppxPackage *QuickAssist* | Remove-AppxPackage
Get-AppxPackage *SkypeApp* | Remove-AppxPackage
Get-AppxPackage *SolitaireCollection* | Remove-AppxPackage
Get-AppxPackage *SoundRecorder* | Remove-AppxPackage
Get-AppxPackage *StickyNotes* | Remove-AppxPackage
Get-AppxPackage *Teams* | Remove-AppxPackage
Get-AppxPackage *TikTok* | Remove-AppxPackage
Get-AppxPackage *Todos* | Remove-AppxPackage
Get-AppxPackage *Wallet* | Remove-AppxPackage
Get-AppxPackage *Whiteboard* | Remove-AppxPackage
Get-AppxPackage *WindowsAlarms* | Remove-AppxPackage
Get-AppxPackage *WindowsMaps* | Remove-AppxPackage
Get-AppxPackage *XboxGamingOverlay* | Remove-AppxPackage
Get-AppxPackage *XboxSpeechToTextOverlay* | Remove-AppxPackage
Get-AppxPackage *YourPhone* | Remove-AppxPackage
Get-AppxPackage *ZuneMusic* | Remove-AppxPackage
Get-AppxPackage *ZuneVideo* | Remove-AppxPackage
Get-AppxPackage *communicationsapps* | Remove-AppxPackage
Get-AppxPackage *king.com* | Remove-AppxPackage
echo : OK

echo(
echo + Removing widgets
Get-AppxPackage *WebExperience* | Remove-AppxPackage
reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v AllowNewsAndInterests /t REG_DWORD /d 0 /f
echo : OK

echo(
echo + Turning off Copilot
reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v TurnOffWindowsCopilot /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v TurnOffWindowsCopilot /t REG_DWORD /d 1 /f
echo : OK

echo(
echo + Turning off Visual Studio Copilot
reg add "HKLM\SOFTWARE\Policies\Microsoft\VisualStudio\Copilot" /v Enabled /t REG_DWORD /d 0 /f
echo : OK

echo(
echo + Turning off Recall
dism /Online /Disable-Feature /FeatureName:Recall /NoRestart
reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsAI" /v DisableAIDataAnalysis /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v DisableAIDataAnalysis /t REG_DWORD /d 1 /f
echo : OK

echo(
echo + Disabling lock screen clock
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v NoLockScreen /t REG_DWORD /d 1 /f
echo : OK

echo(
echo + Disabling telemetry, ad/consumer junk, legacy features
sc config DiagTrack start=disabled
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v DisabledByGroupPolicy /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v DisableSearchBoxSuggestions /t REG_DWORD /d 1 /f
dism /Online /Disable-Feature /FeatureName:MicrosoftWindowsPowerShellV2Root /NoRestart
dism /Online /Disable-Feature /FeatureName:SMB1Protocol /NoRestart
dism /Online /Disable-Feature /FeatureName:Printing-XPSServices-Features /NoRestart
dism /Online /Disable-Feature /FeatureName:WorkFolders-Client /NoRestart

echo(
echo + Disable Game DVR - No background recording for less overhead 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f

echo(
echo + Enable Windows Subsystems
dism /Online /Enable-Feature /FeatureName:Microsoft-Windows-Subsystem-Linux /All /NoRestart
dism /Online /Enable-Feature /FeatureName:VirtualMachinePlatform /All /NoRestart
dism /Online /Enable-Feature /FeatureName:Microsoft-Hyper-V-All /All /NoRestart
dism /Online /Enable-Feature /FeatureName:Containers-DisposableClientVM /All /NoRestart
dism /Online /Enable-Feature /FeatureName:NetFx3 /All /NoRestart

echo(
echo + Enable QOL environment feature
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v LongPathsEnabled /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /v AllowDevelopmentWithoutDevLicense /t REG_DWORD /d 1 /f

echo(
echo : Done
