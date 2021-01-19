 
#!/bin/sh -e
# CreateFPMDesktopFile.sh

FPMVERSION="2.2"
FPMDESKTOPFILENAME="FasterProjectPlus-${FPMVERSION}"
PWD=$(pwd)
APPIMAGENAME="Faster_Project_M-${FPMVERSION}-x86_64.AppImage"
APPIMAGELOCATION="${PWD}/${APPIMAGENAME}"

# --- Create FPM desktop file
sudo rm -f ~/.local/share/applications/${FPMDESKTOPFILENAME}.desktop # Remove existing desktop file if it exists
touch ~/.local/share/applications/${FPMDESKTOPFILENAME}.desktop
echo "[Desktop Entry]
Type=Application
GenericName=Wii/GameCube Emulator
Comment=Ishiiruka fork for SSBPM
Exec=${APPIMAGELOCATION}
Categories=Emulator;Game;
Icon=ishiiruka;dolphin-emu;
Keywords=ProjectM;Project M;ProjectPlus;Project Plus;Project+
Name=Faster Project M" >> ~/.local/share/applications/${FPMDESKTOPFILENAME}.desktop
# ---