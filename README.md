# dotfiles

Simple dotfile repo for my short lived installations, mainly in wsl2 + ubuntu.  
That said, this repo is more for misc install instructions, as a pure dotfile repo where I simply copy the same dotfiles to new installs does
not always work that well for me due to the particulars of any given system and use case.


## Table of Contents

Install and customization:
- [Base installation](#base-installation)
- [How to customize .bashrc](#how-to-customize-bashrc)
- [How to manage ssh](#how-to-manage-ssh)
- [Graphics and CUDA support](#graphics-and-cuda-support)
- [Docker](#docker)
- [Compacting to free up space](#compacting-to-free-up-space)

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

Go to Nvidia for updated instructions (see below).  
The main challenge with CUDA on WSL is that the default Ubuntu package for CUDA Toolkit comes with a driver. This driver will overwrite the link to the windows driver. The solution is to install a WSL-Ubuntu specific package for CUDA toolkit directly from Nvidia.

1. Follow the manual installation steps in nvidia doc [CUDA on WSL](https://docs.nvidia.com/cuda/wsl-user-guide/index.html#getting-started-with-cuda-on-wsl)
1. Remove old key as instructed
1. Then run "Option 1: Installation of Linux x86 CUDA Toolkit using WSL-Ubuntu Package – Recommended"  
   If `gpg` hangs then modify the command to say `gpg --no-use-agent` as it is most likely wsl/ubuntu waiting for the agent to start up. 
1. Done!

##### `libcuda.so.1 is not a symbolic link`

Updating the nvidia driver in windows can sometimes mess with the symbolic links that WSL depend on. 

The fix is to recreate the links in windows, then update links in wsl like so:
1. Run CMD in Windows (as Administrator)
   ```sh
   C:
   cd \Windows\System32\lxss\lib
   del libcuda.so
   del libcuda.so.1
   mklink libcuda.so libcuda.so.1.1
   mklink libcuda.so.1 libcuda.so.1.1
   ```
2. Open WSL bash
   ```sh
   sudo ldconfig
   ```
   If this last command fail then restart wsl and run it again.  



##### Docker + CUDA
1. Install [nvidia container toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker)
1. Docker should work with CUDA out of the box with the latest version of Docker installed on win11 as described in [WSL 2 GPU Support for Docker Desktop on NVIDIA GPUs](https://www.docker.com/blog/wsl-2-gpu-support-for-docker-desktop-on-nvidia-gpus/)
1. You can verify CUDA installation by running the examples found in the page above, or simply run CUDA benchmark like so:  
   ```sh
   docker run --rm --gpus=all nvidia/cuda:11.6.2-base-ubuntu20.04 nvidia-smi
   ```

Note that the parameter `--gpus=all` is the way to tell docker to use gpu, otherwise it will just use the cpu.


##### docker-compose + CUDA

To enable gpus then define gpu as a capability under the `deploy` tag.  
[docs](https://docs.docker.com/compose/gpu-support/)

```sh
# Example docker-compose.yaml

demo:
   build: something
   command: something
   deploy:
      resources:
         reservations:
            devices:
               - capabilities: [gpu]
```


## Docker

### Docker desktop failed to stop

Sometimes installs in wsl (like nvidia-container-tools) can mess up the docker wsl distro which will set docker in a bad state.  

Fix:
1. Close docker desktop
1. Unregister the docker wsl distro: 
   1. In windows, open a cmd as admin and run `wslconfig.exe /u docker-desktop`
1. Start docker desktop


## Compacting to free up space

WSL2 lives inside a virtual disk which is usually stored by windows in a `ext4.vhdx` file.  
This file will grow over time even if contents inside WSL2 are deleted. This "feature" is one of the small quirks of virtual file systems, they tend to eat up space on the host system usage over time goes up.  
You can reclaim this space by trimming the `.vhdx` file.

1. See post from [iuriguilherme](https://github.com/microsoft/WSL/issues/4699#issuecomment-1136319012)
1. See post from [MS](https://learn.microsoft.com/en-us/windows/wsl/vhd-size)

`optimize-vhd` require windows feature "virtual platform" to be installed.  
`diskpart` is available in all windows distros, and can be used to shrink virtual drives like this:
```sh
diskpart
select vdisk file="C:\Users\<user>\AppData\local\Docker\wsl\data\ext4.vhdx"
attach vdisk readonly
compact vdisk
detach vdisk
```

