#!/usr/bin/env bash

echo "Update base..."
echo "------------------------------------"
sudo apt -y update
sudo apt -y upgrade
sudo apt -y dist-upgrade
sudo apt -y autoremove
echo "------------------------------------"
echo "Done."

