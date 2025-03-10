#!/bin/bash

## PURPOSE
# 
# Install or update ffmpeg on WSL with latest static binary due to disto packages are always outdated

## DOCS
# - https://www.johnvansickle.com/ffmpeg/faq/

VERSION_NAME="ffmpeg-git-amd64-static" #"ffmpeg-7.0.2-amd64-static"
LOCAL_NAME="ffmpeg"
TAR_FILENAME="${VERSION_NAME}.tar.xz"
DOWNLOAD_URL="https://johnvansickle.com/ffmpeg/releases/${TAR_FILENAME}"
# git master build has a different download url than releases
if [[ "${TAR_FILENAME}" == *"-git-"* ]]; then
    DOWNLOAD_URL="https://johnvansickle.com/ffmpeg/builds/${TAR_FILENAME}"
fi
BIN_DIR="$HOME/.local"
TMP_DIR="$HOME/tmp"

DIALOG_MARGIN="   "
HEADER_PREFIX="-- "
DIALOG_SUBLIST_MARKER="${DIALOG_MARGIN}+ "

function delete_previous_version() {
    if [ -d "${BIN_DIR}/${LOCAL_NAME}" ]; then     
        rm -rf "${BIN_DIR}/${LOCAL_NAME}"
    fi
}

function cleanup() {
    if [ -f "${TMP_DIR}/${TAR_FILENAME}" ]; then
        rm -rf "${TMP_DIR}/${TAR_FILENAME}"
    fi
    if [ -d "${TMP_DIR}/${LOCAL_NAME}" ]; then
        rm -rf "${TMP_DIR}/${LOCAL_NAME}"
    fi
}

function install_static_bin() {    
    mkdir -p "${TMP_DIR}/${LOCAL_NAME}"
    
    cd "${TMP_DIR}"
    curl -OL "${DOWNLOAD_URL}"
    # The content of the tar file is a directory which we do not want, hence --strip-components=1 to go 1 level deeper and extract the contents into our target dir
    tar -xf "${TAR_FILENAME}" -C "${TMP_DIR}/${LOCAL_NAME}" --strip-components=1

    # CD back
    cd -;

    mv "${TMP_DIR}/${LOCAL_NAME}" "${BIN_DIR}/"

}




############################################################################################################
## MAIN

printf "%b\n" "-------------------------------------------------------"
printf "%b\n" "-- (Re)Install ffmpeg static binary --"
printf "%b\n" "   "

printf "%b" "${HEADER_PREFIX}Remove old version:"
delete_previous_version
printf "%b\n" "${DIALOG_MARGIN}Done."

printf "%b" "${HEADER_PREFIX}Installing ${VERSION_NAME}:"
install_static_bin
printf "%b\n" "${DIALOG_MARGIN}Done."

printf "\n%b" "${HEADER_PREFIX}Clean up install:"
cleanup
printf "%b\n" "${DIALOG_MARGIN}Done."


printf "\n%b\n" "${DIALOG_MARGIN}SCRIPT DONE!"
