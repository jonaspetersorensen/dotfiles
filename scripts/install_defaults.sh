#!/bin/bash

WORK_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

file="${WORK_DIR}/update-all.sh"
if [ -f "$file" ]; then
  source "$file"
fi

echo "Install tools and libs..."
echo "------------------------------------"
sudo apt -qq install unzip jq build-essential tmux keychain x11-xserver-utils usbutils git-lfs python-is-python3 python3-pip python3-venv hwdata
echo "------------------------------------"
echo "All done!"
