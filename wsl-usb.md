# WSL + USB

## Connect USB device to WSL2 via network

Install `usbipd-win`:
1. [Install usbipd-win in windows](https://github.com/dorssel/usbipd-win)
1. [Install usbipd-win in wsl](https://github.com/dorssel/usbipd-win/wiki/WSL-support)  
   Summary when in a hurry:
   1. Install package
   1. Update sudoers
   1. Add alias to shell config
 1. Update udev rules for devices:  
    1. Copy [OpenOCD/contrib/60-openocd.rules](https://github.com/arduino/OpenOCD/blob/c404ff5d3a2ec568daa106455845dd403b08dab4/contrib/60-openocd.rules) file to /etc/udev/rules.d/
    1. Reload udev `sudo udevadm control --reload`

### How to use `usbpid-win`

1. Connect device to usb so that windows can find it
1. Attach (or detach) device to wsl via **windows command prompt (admin)**:  
   ```sh
   # List all usb devices in windows
   usbipd wsl list
   # Attach device with BUSID=x-x to default distro, and reattach when connection is lost (handy for arduino rebooting etc)
   usbipd wsl attach --auto-attach --busid x-x
   ```
1. Verify that device is available in **linux shell**:  
   ```sh
   lsusb # List all usb devices in linux 
   ```
1. Done!

Note: The device will automatically stop sharing if it is unplugged or the computer is restarted.
