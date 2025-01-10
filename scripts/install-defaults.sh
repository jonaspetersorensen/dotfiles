#!/bin/bash

# USB/IP info: https://github.com/dorssel/usbipd-win/wiki/WSL-support 
# As of v4.0.0 you no longer have to install any client-side tooling.
# Pre v4 info: 
# - WSL client tools: linux-tools-virtual hwdata
# - Update usb/ip client tool:
#   sudo update-alternatives --install /usr/local/bin/usbip usbip `ls /usr/lib/linux-tools/*/usbip | tail -n1` 20

WORK_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

file="${WORK_DIR}/update-all.sh"
if [ -f "$file" ]; then
  source "$file"
fi

echo "Install tools and libs..."
echo "------------------------------------"
sudo apt -qq install unzip jq build-essential tmux keychain x11-xserver-utils usbutils git-lfs
echo "------------------------------------"
echo "All done!"
