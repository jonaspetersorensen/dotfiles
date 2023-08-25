#!/bin/bash

# USB/IP info: https://github.com/dorssel/usbipd-win/wiki/WSL-support 
# - WSL client tools: linux-tools-virtual hwdata

file=./update-all.sh
if [ -f "$file" ]; then
  source "$file"
fi

echo "Install tools and libs..."
echo "------------------------------------"
sudo apt -qq install unzip jq build-essential tmux keychain linux-tools-virtual hwdata x11-xserver-utils
echo "------------------------------------"
echo "All done!"
