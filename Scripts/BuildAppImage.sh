#!/bin/bash -e
# BuildAppImage.sh

# --- Change into build directory
cd FasterProjectPlus-2.15/Ishiiruka/build
# ---

APPIMAGE_STRING="Faster_Project_M-x86_64.AppImage"

LINUXDEPLOY_PATH="https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous"
LINUXDEPLOY_FILE="linuxdeploy-x86_64.AppImage"
LINUXDEPLOY_URL="${LINUXDEPLOY_PATH}/${LINUXDEPLOY_FILE}"

APPIMAGETOOL_PATH="https://github.com/AppImage/AppImageKit/releases/download/continuous"
APPIMAGETOOL_FILE="appimagetool-x86_64.AppImage"
APPIMAGETOOL_URL="${APPIMAGETOOL_PATH}/${APPIMAGETOOL_FILE}"

APPDIR_BIN="AppDir/usr/bin"

# --- Download linuxdeploy and appimagetool if not already there
if [ ! -e linuxdeploy ]; then
	wget ${LINUXDEPLOY_URL} -O linuxdeploy
	chmod +x linuxdeploy
fi
if [ ! -e appimagetool ]; then
	wget ${APPIMAGETOOL_URL} -O appimagetool
	chmod +x appimagetool
fi
# ---

# --- Run linuxdepoly on AppDir
./linuxdeploy --appdir AppDir
# ---

# --- Remove autogenerated AppDir/AppRun
rm -f AppDir/AppRun
# ---

# --- Create new AppRun which sets relative library path before calling binary
cat > ./AppDir/AppRun <<\EOF
#!/bin/bash
APPDIR="$(dirname "$(readlink -f "${0}")")"
export LD_LIBRARY_PATH="${APPDIR}/usr/lib:${LD_LIBRARY_PATH}"
${APPDIR}/usr/bin/ishiiruka
EOF
# ---

# Copy needed files/folders
cp Binaries/license.txt ${APPDIR_BIN}
cp Binaries/Changelog.txt ${APPDIR_BIN}
cp Binaries/traversal_server ${APPDIR_BIN}

# -- Remove appimage if it exists already
rm -f ${APPIMAGE_STRING}

# --- Make appimage
./appimagetool AppDir
