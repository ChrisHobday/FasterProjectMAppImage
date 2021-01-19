# Faster Project M AppImage
AppImage for Faster Project M and tools to create it

## Steps for making AppImage
1) Fresh Ubuntu install (18.04)
2) Run Scripts/BuildFPMAppImage.sh

The AppImage will be located at Scripts/FasterProjectPlus-VERSION/Ishiiruka/build/FasterProjectPlus-VERSION.AppImage

## Optional Linux configuration steps
1) Run Scripts/AddGCAdapterRules.sh (if you don't already have the controller rules set on your system)
2) Run Scripts/CreateFPMDesktopFile.sh from inside the same directory as the AppImage (creates a desktop file to AppImage in the same directory)

##### Note:
Moving the AppImage after creating the desktop file will cause the desktop file to no longer work

## Steps for running AppImage
1) Make AppImage executable (chmod +x FasterProjectPlus-VERSION.AppImage)
2) Launch AppImage (./FasterProjectPlus-VERSION.AppImage)

## Dolphin configuration steps
1) In Config>Paths add the "ISO Directory" that has the P+ ELF files
2) In Config>Paths set the "Default ISO" to the brawl ISO file
3) In Config>Paths set the "SD Card Path" to the P+ SD Card file

##### Note:
1) You will have to provide Brawl.iso, Project+.elf, sd.raw and optionally icon.png
2) User configuration files are located at ~/.local/share/ishiiruka, ~/.config/ishiiruka, ~/.cache/ishiiruka and ~/.ishiiruka

## Launching P+
1) Doubleclick the P+ ELF file in the main dolphin window