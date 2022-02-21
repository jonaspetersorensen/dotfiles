#!/usr/bin/env bash

echo "Update base..."
echo "------------------------------------"
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt autoremove
echo "------------------------------------"
echo "Done."

