# dotfiles

Simple dotfile repo for my short lived ubuntu installations.  
That said, this repo is more for misc install instructions, as a pure dotfile repo where I simply copy the same dotfiles to new installs does
not always work that well for me due to the particulars of any given system and use case.


## Table of Contents

Install and customization:
- [Base installation](#base-installation)
- [How to customize .bashrc](#how-to-customize-bashrc)
- [How to manage ssh](#how-to-manage-ssh)
- [Graphics and CUDA support](#graphics-and-cuda-support)

Misc
- [Docs](#docs)


## Base installation
1. Update to latest: `. ./scripts/update-all.sh`
1. Install default tools: run script `. ./scripts/install-defaults.sh`
1. Add custom settings to `.bashrc`, see [instructions](#how-to-customize-bashrc)
1. [Add ssh keys](#how-to-manage-ssh)
1. (WSL) [Install pretty shell](./oh-my-posh.md)
1. [Install tmux](./tmux.md)  
   1. Then copy config file `./configs/.tmux.conf` to `~/.tmux.conf`

Languages:
- [Install rust](./rust.md)


## Docs

- [Connect USB device to WSL2 via network](./wsl-usb.md#Connect-USB-device-to-WSL2-via-network)


## How to customize .bashrc

All custom settings are stored in a separate file `.bashrc_extras` in order to keep `.bashrc` as clean and default as possible (quite handy when handling lots of installs).

1. Open `.bashrc` in an editor
1. At the bottom of the file, add the following and save  
   NB! Make sure the path is correct for your system.
   ```sh
   ### Extras
   . ~/dev/dotfiles/configs/.bashrc_extras
   ```
1. Restart shell
1. Done!


## How to manage ssh

I use [keychain](https://www.funtoo.org/Funtoo:Keychain) for easier management of ssh keys.  
Install and settings are handled by default install and bashrc extras.

1. Copy keys to `~/.ssh`
1. Set permissions: run script `. ./scripts/set-ssh-permissions.sh`
1. Done!


## Graphics and CUDA support

### Works out of the box

- [Run Linux GUI apps on the Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/tutorials/gui-apps)  
  Graphics are enabled via [WSLg] by default on win 11. It use a vGPU behinds the sceen and then open a window on the host via FreeRDP.

### Require installation

#### x11
- `sudo apt install x11-xserver-utils` so you can use things like `xhost`

#### CUDA
1. Follow the manual installation steps in nvidia doc [CUDA on WSL](https://docs.nvidia.com/cuda/wsl-user-guide/index.html#getting-started-with-cuda-on-wsl)
   1. Remove old key as instructed
   1. Then run "Option 1: Installation of Linux x86 CUDA Toolkit using WSL-Ubuntu Package – Recommended"
   1. Done!
1. Docker should work with CUDA out of the box with the latest version of Docker installed on win11 as described in [WSL 2 GPU Support for Docker Desktop on NVIDIA GPUs](https://www.docker.com/blog/wsl-2-gpu-support-for-docker-desktop-on-nvidia-gpus/)
1. You can verify CUDA installation by running the machine learning framework container and sample as described on [Get started with GPU acceleration for ML in WSL](https://docs.microsoft.com/en-us/windows/wsl/tutorials/gpu-compute)







