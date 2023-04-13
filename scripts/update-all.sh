#!/bin/bash

echo "Update base..."
echo "------------------------------------"
sudo apt -y update
sudo apt -y upgrade
sudo apt -y dist-upgrade
sudo apt -y autoremove
# Update usb/ip client tool
sudo update-alternatives --install /usr/local/bin/usbip usbip `ls /usr/lib/linux-tools/*/usbip | tail -n1` 20
echo "------------------------------------"
echo "Done."

