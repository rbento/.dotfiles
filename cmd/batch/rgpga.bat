@echo off
gpgconf --kill gpg-agent
gpg-connect-agent /bye
gpg-agent