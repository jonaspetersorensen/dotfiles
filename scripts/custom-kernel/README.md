# How to build a custom WSL kernel

Microsoft has not enabled the media drivers in WSL kernel that are required for making most, if not all, usb cameras work.  
To enable them you will have to build your own kernel, and this is a script that will do that for you.

Sources: 
- [Connect USB devices | Microsoft](https://learn.microsoft.com/en-us/windows/wsl/connect-usb)
- [WSL2-USB-Camera | Tutorial](https://github.com/randomwons/WSL2-USB-Camera) - The main source for the build and install script
- [WSL2-Linux-Kernel | Official repo](https://github.com/microsoft/WSL2-Linux-Kernel)
- [wslu - A collection of utilities for WSL | repo](https://github.com/wslutilities/wslu)
- [asciicam](https://www.makeuseof.com/asciicam-display-webcam-in-linux-terminal/) - For testing video feed in terminal


```sh
# Build custom script that add support for usb camera, then copy the kernel to windows user and creates a new .wslconfig
./install.sh
```
