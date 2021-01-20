#!/bin/sh -e
# CreateFPMDesktopFile.sh

# Check if given absolute path
if [[ $1 == /* ]]; then # Absolute path
  PATHTOAPPIMAGE=$1
else # Relative path
  PATHTOAPPIMAGE="$(pwd)/$1"
fi

FPMVERSION="2.2"
FPMDESKTOPFILENAME="FasterProjectPlus-${FPMVERSION}"

# --- Create FPM desktop file
rm -f ~/.local/share/applications/${FPMDESKTOPFILENAME}.desktop # Remove existing desktop file if it exists
touch ~/.local/share/applications/${FPMDESKTOPFILENAME}.desktop
echo "[Desktop Entry]
Type=Application
GenericName=Wii/GameCube Emulator
Comment=Ishiiruka fork for SSBPM
Exec=${PATHTOAPPIMAGE}
Categories=Emulator;Game;
Icon=ishiiruka
Keywords=ProjectM;Project M;ProjectPlus;Project Plus;Project+
Name=Faster Project M" >> ~/.local/share/applications/${FPMDESKTOPFILENAME}.desktop
# ---

echo "~/.local/share/applications/${FPMDESKTOPFILENAME}.desktop created with ${PATHTOAPPIMAGE} path"