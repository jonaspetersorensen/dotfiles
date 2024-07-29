#!/bin/bash

DOWNLOAD_ZIG_LANG_URL=""
ZIG_ENV_PATH="$HOME/.local/zig"
ZIG_ENV_RELEASE_PATH="${ZIG_ENV_PATH}/release"
ZIG_ENV_LANGUAGE_SERVER_PATH="${ZIG_ENV_PATH}/language_server"

function create_zig_environment () {    
    if [ ! -d "${ZIG_ENV_PATH}" ]; then
        printf "%s" "Creating zig environment in ${ZIG_ENV_PATH}... "
        mkdir "${ZIG_ENV_PATH}"
        mkdir "${ZIG_ENV_RELEASE_PATH}"
        mkdir "${ZIG_ENV_LANGUAGE_SERVER_PATH}"        
    else
        printf "%$" "Zig environment found, removing ye olde version... "
        
    fi
    printf "Done.\n"
}

function delete_zig_environment() {
    printf "%$" "Deleting zig environment... "
    rm -rf "${ZIG_ENV_PATH}"    
}


function ask_user_continue_or_exit () {
    local margin="   "
    printf "${margin}Continue? y/n "
    read USER_OK
    case "$USER_OK" in
        "y" | "Y" | "yes" | "Yes")
            printf "All is good in the world."
            ;;

        "n" | "N" | "no" | "No")
            printf "Exiting...\n"
            exit
            ;;
        *)
            printf "User don't know what they want, exiting... \n"
            exit
    esac
}

function install_language () {

}

function install_language_server () {
    
}

function install_shell_completion () {
    
}



############################################################################################################
## MAIN


printf "%b\n" "-------------------------------------------------------"
printf "%b\n" "-- (Re)Install and configure zig and related tooling --"
printf "%b\n" "   "

ask_user_continue_or_exit

printf "Install language:"
printf "Step 1: Open zig download page and copy the url to the desired version, https://ziglang.org/download/"
printf "Step 2: Paste url here + ENTER: "

# read DOWNLOAD_ZIG_LANG_URL

# printf "You wrote:"
# printf "$DOWNLOAD_ZIG_LANG_URL"


