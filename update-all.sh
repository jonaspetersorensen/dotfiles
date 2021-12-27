#!/usr/bin/env bash

echo "Update base..."
echo "------------------------------------"
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt autoremove
echo "------------------------------------"
echo "Done."

echo "Install tools and libs..."
echo "------------------------------------"
sudo apt -qq install unzip jq build-essential
echo "------------------------------------"
echo "All done!"
