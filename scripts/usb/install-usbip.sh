#!/bin/bash

echo "Install usbip..."
echo "------------------------------------"
sudo apt install linux-tools-virtual hwdata
sudo update-alternatives --install /usr/local/bin/usbip usbip `ls /usr/lib/linux-tools/*/usbip | tail -n1` 20
echo "------------------------------------"
echo "Done."

