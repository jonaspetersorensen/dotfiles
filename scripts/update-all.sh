#!/bin/bash

echo "Update base..."
echo "------------------------------------"
sudo apt -y update
sudo apt -y upgrade
sudo apt -y dist-upgrade
sudo apt -y autoremove
echo "------------------------------------"
echo "Done."

# Enable tmux again by removing the flag
if [ -f "$HOME/TMUX_UPDATE_IN_PROGRESS" ]; then
   rm "$HOME/TMUX_UPDATE_IN_PROGRESS"
fi