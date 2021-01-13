#!/bin/sh -e
# P+Installer.sh

# --- Config links
FPPVERSION="2.15" # Name of FPP version, used in folder name
CONFIGNAME="fppconfig"
COMMITHASH="d6800a124dbba118e297188900d07adfea661b87" # Full commit hash
CONFIGLINK="https://github.com/Birdthulu/FPM-Installer/raw/master/config/$FPPVERSION-$CONFIGNAME.tar.gz" # Packed configs, can be found under config/ or config/legacy/
GITCLONELINK="https://github.com/Birdthulu/Ishiiruka" # Version of Ishiiruka
SdCardFileName="ProjectPlusSdCard215.tar.gz"
SdCardDlHash="0anckw4hrxlqn5i"
SdCardLink="http://www.mediafire.com/file/$SdCardDlHash/$SdCardFileName/file"
# ---

# --- Delete FasterProjectPlus folders
rm -rf FasterProjectPlus*/
echo "Deleted all FPP folders!"
# ---

# --- Set FOLDERNAME based on FPP version
FOLDERNAME="FasterProjectPlus-${FPPVERSION}"

# --- Add Gamecube adapter rules
# sudo rm -f /etc/udev/rules.d/51-gcadapter.rules # Remove even if doesn't exist
# echo '#GameCube Controller Adapter
# 			SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", TAG+="uaccess"

# 			#Mayflash DolphinBar
# 			SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0306", TAG+="uaccess"' | sudo tee /etc/udev/rules.d/51-gcadapter.rules > /dev/null # pipe to write-protected file, remove STDOUT
# sudo udevadm control --reload-rules
# echo "Gamecube adapter rules added!"
# ---

# --- Make folder, enter and download then extract needed files
echo ""
mkdir "$FOLDERNAME" && cd "$FOLDERNAME"
echo "Downloading config files..."
curl -LO# $CONFIGLINK
echo "Extracting config files..."
tar -xzf "$FPPVERSION-$CONFIGNAME.tar.gz" --checkpoint-action='exec=printf "%d/410 records extracted.\r" $TAR_CHECKPOINT' --totals
rm "$FPPVERSION-$CONFIGNAME.tar.gz"
echo ""
echo "Downloading tarball..."
curl -LO# "$GITCLONELINK/archive/$COMMITHASH.tar.gz"
echo "Extracting tarball..."
tar -xzf "$COMMITHASH.tar.gz" --checkpoint-action='exec=printf "%d/12130 records extracted.\r" $TAR_CHECKPOINT' --totals
rm "$COMMITHASH.tar.gz"
echo "" #spacing
mv "Ishiiruka-$COMMITHASH" Ishiiruka
cd Ishiiruka
# ---

# --- Patch tarball to display correct hash to other netplay clients
echo "Patching tarball..."
sed -i "s|\${GIT_EXECUTABLE} rev-parse HEAD|echo ${COMMITHASH}|g" CMakeLists.txt  # --set scm_rev_str everywhere to actual commit hash when downloaded
sed -i "s|\${GIT_EXECUTABLE} describe --always --long --dirty|echo FM v$FPPVERSION|g" CMakeLists.txt # ensures compatibility w/ netplay
sed -i "s|\${GIT_EXECUTABLE} rev-parse --abbrev-ref HEAD|echo HEAD|g" CMakeLists.txt
# ---

# --- Patch DiscExtractor.h
echo "Patching DiscExtractor.h"
sed -i "s|#include <optional>|#include <optional>\n#include <string>|g" Source/Core/DiscIO/DiscExtractor.h
# ---

# --- Patch wxWidgets3 for Ubuntu 20.04
echo "Patching wxWidgets3 for Ubuntu 20.04 based distros"
sed -i "s| OR NOT X11_Xinerama_FOUND||g" Externals/wxWidgets3/CMakeLists.txt
sed -i "s|needs Xinerama and|needs|g" Externals/wxWidgets3/CMakeLists.txt
sed -i "s|\t\t\${X11_Xinerama_LIB}||g" Externals/wxWidgets3/CMakeLists.txt
# ---

# --- Move wx files into source
cp Externals/wxWidgets3/include/wx Source/Core/ -r
cp Externals/wxWidgets3/wx/* Source/Core/wx/ 
# ---

# --- Move necessary config files into the build folder
echo "Adding FPP config files..."
mkdir build && cd build
mv ../../Binaries .
cp ../Data/ishiiruka.png Binaries/
# ---

# --- Cmake and compile
echo "Cmaking..."
cmake .. -DLINUX_LOCAL_DEV=true -DCMAKE_INSTALL_PREFIX=/usr
echo "Compiling..."
make -j$(nproc) # Make with all cores
# ---

# --- Create .desktop file
touch Binaries/ishiiruka.desktop
echo "[Desktop Entry]
Type=Application
GenericName=Wii/GameCube Emulator
Comment=Ishiiruka fork for SSBPM
Exec=ishiiruka
Categories=Emulator;Game;
Icon=ishiiruka
Keywords=ProjectM;Project M;ProjectPlus;Project Plus;Project+
Name=Faster Project M" >> Binaries/ishiiruka.desktop
cp Binaries/ishiiruka.desktop ../Data/ishiiruka.desktop
# ---

# --- Delete existing AppDir, make a new one and Make install into it
rm -rf AppDir/
mkdir AppDir
make install DESTDIR=AppDir
# ---