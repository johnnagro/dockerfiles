#!/bin/bash

# Check to see if the 1Password installer has already been run
if [ ! -f /root/.wine/drive_c/Program\ Files\ \(x86\)/1Password\ 4/1Password.exe ];
then
  wine /usr/src/1Password-4.6.0.604.exe /SILENT
fi

# then proceed to run 1Password
wine /root/.wine/drive_c/Program\ Files\ \(x86\)/1Password\ 4/1Password.exe
