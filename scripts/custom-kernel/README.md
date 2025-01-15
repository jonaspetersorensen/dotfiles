# How to build a custom WSL kernel

Microsoft has not enabled the media drivers in WSL kernel that are required for making most, if not all, usb cameras work.  
To enable them you will have to build your own kernel, and this is a guide how to.

Sources: 
- [Connect USB devices | Microsoft](https://learn.microsoft.com/en-us/windows/wsl/connect-usb)
- [WSL2-USB-Camera | Tutorial](https://github.com/randomwons/WSL2-USB-Camera)
- [WSL2-Linux-Kernel | Official repo](https://github.com/microsoft/WSL2-Linux-Kernel)
- [wslu - A collection of utilities for WSL | repo](https://github.com/wslutilities/wslu)
- [asciicam](https://www.makeuseof.com/asciicam-display-webcam-in-linux-terminal/) - For testing video feed in terminal


## Update WSL2 Kernel

To use the camera in WSL2, you need to update the Linux kernel

You need to have the packages required for kernel update installed. If they are already installed, you can proceed.

In WSL2 terminal
```bash
sudo apt update
sudo apt upgrade -y

# Install required packages
sudo apt install build-essential flex bison libssl-dev libelf-dev libncurses-dev autoconf libudev-dev libtool dwarves bc wslu
```

In WSL2 terminal, clone a repository of WSL2-Linux-Kernel
```bash
WSL_VERSION=$(uname -r | cut -d '-' -f1)
git clone --depth 1 -b linux-msft-wsl-${WSL_VERSION} https://github.com/microsoft/WSL2-Linux-Kernel.git
cd WSL2-Linux-Kernel
```
Copy config.gz
```bash
sudo cp /proc/config.gz config.gz
sudo gunzip config.gz
sudo mv config .config
```

Modifiy config
```bash
sudo scripts/config --enable CONFIG_MEDIA_SUPPORT
sudo scripts/config --enable CONFIG_MEDIA_SUPPORT_FILTER
sudo scripts/config --enable CONFIG_MEDIA_SUBDRV_AUTOSELECT
sudo scripts/config --enable CONFIG_MEDIA_CAMERA_SUPPORT
sudo scripts/config --enable CONFIG_VIDEO_V4L2_SUBDEV_API
sudo scripts/config --enable CONFIG_MEDIA_USB_SUPPORT
sudo scripts/config --enable CONFIG_USB_VIDEO_CLASS
sudo scripts/config --enable CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV
sudo scripts/config --enable CONFIG_USB_GSPCA

sudo make olddefconfig
```

build
```bash
sudo make modules -j$(nproc)
sudo make modules_install
sudo make -j$(nproc)
sudo make install
```
Copy bzImage to Host PC(windows)

```bash
HOST_USERNAME=$(wslpath "$(wslvar USERPROFILE)" | cut -d '/' -f5) 
sudo cp arch/x86/boot/bzImage /mnt/c/Users/${HOST_USERNAME}/usb-media-bzImage
```

Set C:/Users/${HOST_USERNAME}/.wslconfig
```bash
[wsl2]
kernel=path_to_image # example kernel=C:\\Users\\{HOSTNAME}\\usb-media-bzImage
```

Restart wsl
```bash
wsl --shutdown

or

wsl --terminate <Distro>
```
