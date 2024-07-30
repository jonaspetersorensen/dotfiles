#!/bin/bash

ZIG_ENV_PATH="$HOME/.local/zig"
ZIG_ENV_RELEASE_PATH="${ZIG_ENV_PATH}/release"
ZIG_ENV_LANGUAGE_SERVER_PATH="${ZIG_ENV_PATH}/language_server"
ZIG_ENV_SHELL_COMPLETION_PATH="${ZIG_ENV_PATH}"
ZIG_TMP_PATH="$HOME/tmp_zig_install"

DIALOG_MARGIN="   "
HEADER_PREFIX="-- "
DIALOG_SUBLIST_MARKER="${DIALOG_MARGIN}+ "

function create_zig_environment () {    
    if [ ! -d "${ZIG_ENV_PATH}" ]; then
        printf "%b"  "${DIALOG_SUBLIST_MARKER}"
        printf "%b" "Creating zig environment in ${ZIG_ENV_PATH}... "
        mkdir "${ZIG_ENV_PATH}"
        mkdir "${ZIG_ENV_RELEASE_PATH}"
        mkdir "${ZIG_ENV_LANGUAGE_SERVER_PATH}"  
        printf "%b\n" "Done."      
    else
        printf "%b\n" "${DIALOG_MARGIN}Zig environment found. Starting clean-up: "
        printf "%b"  "${DIALOG_SUBLIST_MARKER}"
        delete_zig_environment
        create_zig_environment        
    fi    
}

function create_install_dir() {
    if [ -d "${ZIG_TMP_PATH}" ]; then
        rm -rf "${ZIG_TMP_PATH}"
    fi
    mkdir "${ZIG_TMP_PATH}"
    cd "${ZIG_TMP_PATH}"
    printf "%b\n"  "${DIALOG_SUBLIST_MARKER}Created tmp dir for installation in ${ZIG_TMP_PATH}"
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
    local DOWNLOAD_URL=""
    local FILE_AND_SUFFIX=""
    local FILENAME=""
    local DIR_NAME=""

    printf "%b\n" "${DIALOG_SUBLIST_MARKER}Step 1: Open zig download page and copy the url to the desired version, https://ziglang.org/download/"
    printf "%b" "${DIALOG_SUBLIST_MARKER}Step 2: Paste url here + ENTER: "
    read DOWNLOAD_URL
    exit_if_invalid_url "${DOWNLOAD_URL}"
    
    cd "${ZIG_TMP_PATH}"
    curl -OL "${DOWNLOAD_URL}"
    FILE_AND_SUFFIX=${DOWNLOAD_URL##*/}
    TAR_FILENAME=${FILE_AND_SUFFIX%%[?#]*}
    DIR_NAME=${TAR_FILENAME%%.tar*}
    tar -xf "${TAR_FILENAME}"
    cp -r "${DIR_NAME}"/* "${ZIG_ENV_RELEASE_PATH}"
    # Clean up
    rm -rf "${DIR_NAME}"
    rm -rf "${TAR_FILENAME}"

    printf "%b\n" "${DIALOG_MARGIN}Done, zig is installed in ${ZIG_ENV_RELEASE_PATH}"
}

function install_language_server () {
    local DOWNLOAD_URL=""
    local FILE_AND_SUFFIX=""
    local FILENAME=""

    printf "%b\n" "${DIALOG_SUBLIST_MARKER}Step 1: Open zig language server download page and copy the url to the desired version (must match zig version), https://github.com/zigtools/zls/releases"
    printf "%b" "${DIALOG_SUBLIST_MARKER}Step 2: Paste url here + ENTER: "
    read DOWNLOAD_URL
    exit_if_invalid_url "${DOWNLOAD_URL}"
    
    cd "${ZIG_TMP_PATH}"
    mkdir tmp-zls
    curl -OL "${DOWNLOAD_URL}"
    FILE_AND_SUFFIX=${DOWNLOAD_URL##*/}
    TAR_FILENAME=${FILE_AND_SUFFIX%%[?#]*}
    tar -xf "${TAR_FILENAME}" --directory tmp-zls
    cp -r tmp-zls/zls "${ZIG_ENV_LANGUAGE_SERVER_PATH}"
    # Clean up
    rm -rf tmp-zls
    rm -rf "${TAR_FILENAME}"

    printf "%b\n" "${DIALOG_MARGIN}Done, zig language is installed in ${ZIG_ENV_LANGUAGE_SERVER_PATH}"
}

function install_shell_completion () {
    local DOWNLOAD_URL="https://raw.githubusercontent.com/ziglang/shell-completions/master/_zig.bash"
    local FILENAME="_zig.bash"

    printf "%b\n" "${DIALOG_MARGIN}Installing for bash. If you want anything else then please look at instructions at https://github.com/ziglang/shell-completions ."

    
    cd "${ZIG_TMP_PATH}"
    curl -OL "${DOWNLOAD_URL}"
    cp "${FILENAME}" "${ZIG_ENV_SHELL_COMPLETION_PATH}"
    # Clean up
    rm -rf "${FILENAME}"

    printf "%b\n" "${DIALOG_MARGIN}Done, zig language is installed in ${ZIG_ENV_SHELL_COMPLETION_PATH}/${FILENAME}, please add the path to ${HOME}/.bashrc"
}

function exit_if_invalid_url() {
    local _URL=$1
    # POSIX way of looking for substring
    case "${_URL}" in
        *"https"* | *"http"*)            
            # printf "%b\n" "test url looks ok"
            ;;
        *)
            printf "\n%b\n" "${DIALOG_MARGIN}Url does not look ok. Exiting..."
            exit
            ;;
    esac

}

function print_bashrc_instructions() {
    printf "%b\n" '##################################################################'
    printf "%b\n" '### Zig'
    printf "%b\n" 'if [ -d "$HOME/.local/zig/release" ]; then'
    printf "%b\n" '	export PATH="$PATH:$HOME/.local/zig/release"'
    
    printf "%b\n" ''
    printf "%b\n" '	if [ -f "$HOME/.local/zig/language_server/zls" ]; then'
    printf "%b\n" '		export PATH="$PATH:$HOME/.local/zig/language_server"'
    printf "%b\n" '	else'
    printf "%b\n" '		echo "Binary for zig language server not found in expected dir $HOME/.local/zig/language_server"'
    printf "%b\n" '	fi'
    
    printf "%b\n" ''
    printf "%b\n" '	if [ -f "$HOME/.local/zig/_zig.bash" ]; then'
    printf "%b\n" '		. "$HOME/.local/zig/_zig.bash"'
    printf "%b\n" '	fi'
    printf "%b\n" 'fi'
}


############################################################################################################
## MAIN

printf "%b\n" "-------------------------------------------------------"
printf "%b\n" "-- (Re)Install and configure zig and related tooling --"
printf "%b\n" "   "

ask_user_continue_or_exit

printf "%b\n" "${HEADER_PREFIX}Preparing zig environment:"
create_zig_environment

printf "\n%b\n" "${HEADER_PREFIX}Preparing install:"
create_install_dir

printf "\n%b\n" "${HEADER_PREFIX}Install language:"
install_language

printf "\n%b\n" "${HEADER_PREFIX}Install language server:"
install_language_server

printf "\n%b\n" "${HEADER_PREFIX}Install shell completion:"
install_shell_completion

printf "\n%b\n" "${HEADER_PREFIX}Clean up install:"
rm -rf "${ZIG_TMP_PATH}"
printf "%b\n" "${DIALOG_MARGIN}Done."

printf "\n%b\n\n" "${HEADER_PREFIX}Manually add the paths to ${HOME}/.bashrc:"
print_bashrc_instructions
printf "\n%b\n" "${DIALOG_MARGIN}And finally reload the shell."

printf "\n%b\n" "${DIALOG_MARGIN}SCRIPT DONE!"
