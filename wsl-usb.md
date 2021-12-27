# WSL + USB

## Connect USB device to WSL2 via network

Install `usbipd-win`:
1. [Install usbipd-win in windows](https://github.com/dorssel/usbipd-win)
1. [Install usbipd-win in wsl](https://github.com/dorssel/usbipd-win/wiki/WSL-support)  
   Summary when in a hurry:
   1. Install package
   1. Update sudoers
   1. Add alias to shell config

### How to use `usbpid-win`

1. Connect device to usb so that windows can find it
1. Attach (or detach) device to wsl via **windows command prompt (admin)**:  
   ```sh
   usbipd wsl list # List all usb devices in windows
   usbipd wsl attach --busid x-x # Attach device with BUSID=x-x to default distro
   ```
1. Verify that device is available in **linux shell**:  
   ```sh
   lsusb # List all usb devices in linux 
   ```
1. Done!

Note: The device will automatically stop sharing if it is unplugged or the computer is restarted.