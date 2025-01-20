#!/bin/bash

## PURPOSE
# Install gstreamer and all the extras
# GStreamer recommend that you use the distro packages, even though these seems always to be outdated

## DOCS
# - https://gstreamer.freedesktop.org/documentation/installing/on-linux.html


PACKAGES="libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-bad1.0-dev gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-tools gstreamer1.0-x gstreamer1.0-alsa gstreamer1.0-gl gstreamer1.0-gtk3 gstreamer1.0-qt5 gstreamer1.0-pulseaudio"

DIALOG_MARGIN="   "
HEADER_PREFIX="-- "
DIALOG_SUBLIST_MARKER="${DIALOG_MARGIN}+ "



function install_packages(){
    sudo apt install -y "${PACKAGES}"
}

function remove_packages(){
    sudo apt remove -y "${PACKAGES}"
}

function ask_user_continue_or_exit () {
    printf "${DIALOG_MARGIN}What do you want to do? (i)nstall | (r)emove | (e)xit"
    read USER_OK
    case "$USER_OK" in
        "i" | "I" | "install" | "Install")
            printf "\n%b\n" "${DIALOG_MARGIN}Installing..."
            install_packages
            ;;

        "e" | "E" | "exit" | "Exit")
            printf "\n%b\n" "${DIALOG_MARGIN}Goodbye."
            exit
            ;;
        *)
            printf "\n%b\n" "${DIALOG_MARGIN}This script does not speak that language. Exiting..."
            exit
            ;;
    esac
}
