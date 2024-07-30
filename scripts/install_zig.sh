#!/bin/bash

DOWNLOAD_ZIG_LANG_URL=""
ZIG_ENV_PATH="$HOME/.local/zig"
ZIG_ENV_RELEASE_PATH="${ZIG_ENV_PATH}/release"
ZIG_ENV_LANGUAGE_SERVER_PATH="${ZIG_ENV_PATH}/language_server"

DIALOG_MARGIN="   "
HEADER_PREFIX="-- "

function create_zig_environment () {    
    if [ ! -d "${ZIG_ENV_PATH}" ]; then
        printf "%b" "${DIALOG_MARGIN}Creating zig environment in ${ZIG_ENV_PATH}... "
        mkdir "${ZIG_ENV_PATH}"
        mkdir "${ZIG_ENV_RELEASE_PATH}"
        mkdir "${ZIG_ENV_LANGUAGE_SERVER_PATH}"  
        printf "%b\n" "Done."      
    else
        printf "%b" "${DIALOG_MARGIN}Zig environment found. "
        delete_zig_environment
        create_zig_environment        
    fi
}

function delete_zig_environment() {
    printf "%b" "Deleting zig environment... "
    rm -rf "${ZIG_ENV_PATH}"
    printf "%b\n" "Done."
}


function ask_user_continue_or_exit () {
    printf "${DIALOG_MARGIN}Continue? y/n "
    read USER_OK
    case "$USER_OK" in
        "y" | "Y" | "yes" | "Yes")
            printf "%b\n" " "
            ;;

        "n" | "N" | "no" | "No")
            printf "\n%b\n" "${DIALOG_MARGIN}Goodbye."
            exit
            ;;
        *)
            printf "\n%b\n" "${DIALOG_MARGIN}This script does not speak that language. Exiting..."
            exit
            ;;
    esac
}

function install_language () {
    exit_if_invalid_url "${DOWNLOAD_ZIG_LANG_URL}"
    printf "%b\n" "install still running"
}

function install_language_server () {
    printf "TODO"
}

function install_shell_completion () {
    printf "TODO"
}

function exit_if_invalid_url() {
    local _URL=$1
    # POSIX way of looking for substring
    case "${_URL}" in
        *"https"* | *"http"*)            
            # printf "%b\n" "test url looks ok"
            ;;
        *)
            printf "%b\n" "Url not ok. Exiting..."
            exit
            ;;
    esac

}



############################################################################################################
## MAIN


printf "%b\n" "-------------------------------------------------------"
printf "%b\n" "-- (Re)Install and configure zig and related tooling --"
printf "%b\n" "   "

ask_user_continue_or_exit

printf "%b\n" "${HEADER_PREFIX}Preparing zig environment:"
create_zig_environment

printf "%b\n" "Install language:"
printf "%b\n" "Step 1: Open zig download page and copy the url to the desired version, https://ziglang.org/download/"
printf "%b\n" "Step 2: Paste url here + ENTER: "
read DOWNLOAD_ZIG_LANG_URL
install_language

# printf "You wrote:"
# printf "$DOWNLOAD_ZIG_LANG_URL"


