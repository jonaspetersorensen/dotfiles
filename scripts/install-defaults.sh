#!/usr/bin/env bash

file=./update-all.sh
if [ -f "$file" ]; then
  source "$file"
fi

echo "Install tools and libs..."
echo "------------------------------------"
sudo apt -qq install unzip jq build-essential tmux keychain
echo "------------------------------------"
echo "All done!"
