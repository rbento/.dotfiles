@echo off
doskey b=git branch -avv
doskey c=cls
doskey d=cd %USERPROFILE%\Desktop
doskey e=explorer $*
doskey g=git status
doskey gg=git ls $*
doskey h=cd %USERPROFILE%
doskey hexdump=powershell Format-Hex $*
doskey l=ls -alF
doskey pipenv=python -m pipenv $*
doskey r=cd \
doskey touch=powershell New-Item $* -ItemType file
doskey venv=python -m venv .venv
doskey vc=python -m venv .venv
doskey va=.venv\Scripts\activate
doskey vd=.venv\Scripts\deactivate
doskey vr=rd /s /q .venv
doskey vim=start /b "" "C:\Program Files (x86)\Vim\vim82\gvim.exe" $*
doskey w=cd C:\Workspace

