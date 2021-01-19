AppImage for Faster Project M and tools to create it

##Steps for making AppImage
1) Fresh Ubuntu install (18.04)
3) Run Scripts/InstallUbuntuDependencies.sh
4) Run Scripts/P+Installer.sh
5) Run Scripts/BuildAppImage.sh

The AppImage will be located at Scripts/FasterProjectPlus-2.15/Ishiiruka/build/FasterProjectPlus-2.15.AppImage

##Steps for running AppImage
1) Make AppImage executable (chmod +x FasterProjectPlus-2.15.AppImage)
2) Launch AppImage (./FasterProjectPlus-2.15.AppImage)

##Note:
1) You will have to provide Brawl.iso, Project+.elf, sd.raw and optionally icon.png
2) User configuration files are located at ~/.local/share/ishiiruka, ~/.config/ishiiruka, ~/.cache/ishiiruka and ~/.ishiiruka