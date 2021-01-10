#!/bin/bash -e
# build-appimage.sh

ZSYNC_STRING="gh-releases-zsync|Ishiiruka|latest|P+.AppImage.zsync"
APPIMAGE_STRING="P+.AppImage"

LINUXDEPLOY_PATH="https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous"
LINUXDEPLOY_FILE="linuxdeploy-x86_64.AppImage"
LINUXDEPLOY_URL="${LINUXDEPLOY_PATH}/${LINUXDEPLOY_FILE}"

UPDATEPLUG_PATH="https://github.com/linuxdeploy/linuxdeploy-plugin-appimage/releases/download/continuous"
UPDATEPLUG_FILE="linuxdeploy-plugin-appimage-x86_64.AppImage"
UPDATEPLUG_URL="${UPDATEPLUG_PATH}/${UPDATEPLUG_FILE}"

UPDATETOOL_PATH="https://github.com/AppImage/AppImageUpdate/releases/download/continuous"
UPDATETOOL_FILE="appimageupdatetool-x86_64.AppImage"
UPDATETOOL_URL="${UPDATETOOL_PATH}/${UPDATETOOL_FILE}"

APPDIR_BIN="AppDir/usr/bin"

# Grab various appimage binaries from GitHub if we don't have them
if [ ! -e Tools/linuxdeploy ]; then
	wget ${LINUXDEPLOY_URL} -O Tools/linuxdeploy
	chmod +x Tools/linuxdeploy
fi
if [ ! -e Tools/linuxdeploy-update-plugin ]; then
	wget ${UPDATEPLUG_URL} -O Tools/linuxdeploy-update-plugin
	chmod +x Tools/linuxdeploy-update-plugin
fi
if [ ! -e Tools/appimageupdatetool ]; then
	wget ${UPDATETOOL_URL} -O Tools/appimageupdatetool
	chmod +x Tools/appimageupdatetool
fi

# Delete the AppDir folder to prevent build issues
rm -rf AppDir/

# Build the AppDir directory for this image
mkdir -p AppDir
Tools/linuxdeploy \
	--appdir=./AppDir \
	-e ./build/Binaries/ishiiruka \
	-d ./build/Binaries/ishiiruka.desktop \
	-i ./Data/ishiiruka.svg


# Copy needed directories to AppDir
# cp -r Data/Sys ${APPDIR_BIN}
cp -r build/Binaries/Sys ${APPDIR_BIN}
# cp -r build/Binaries/User ${APPDIR_BIN}
# cp build/Binaries/portable.txt ${APPDIR_BIN}
# cp -r build/Binaries/Launcher ${APPDIR_BIN}
cp build/Binaries/license.txt ${APPDIR_BIN}
cp build/Binaries/Changelog.txt ${APPDIR_BIN}
cp build/Binaries/traversal_server ${APPDIR_BIN}

# Remove AppImage if it exists already
rm -f ${APPIMAGE_STRING}

# Package up the update tool within the AppImage
		cp ./Tools/appimageupdatetool ./AppDir/usr/bin/

		# Bake an AppImage with the update metadata
		UPDATE_INFORMATION="${ZSYNC_STRING}" \
			./Tools/linuxdeploy-update-plugin --appdir=./AppDir/
