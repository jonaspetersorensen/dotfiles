# dotfiles

Simple dotfile repo for my short lived installations, mainly in wsl2 + ubuntu.  
That said, this repo is more for misc install instructions, as a pure dotfile repo where I simply copy the same dotfiles to new installs does
not always work that well for me due to the particulars of any given system and use case.

Note:  
The Store version of WSL is now the default version of WSL. You should not enable the "Windows Subsystem for Linux" optional component, nor install the WSL kernel or WSLg MSI packages as they are no longer needed. Using the Store version of WSL allows you to get updates to WSL much faster compared to when it was a Windows component. WSLg is also now bundled.

**Warning: Ubuntu 24.04 is a special needs distro**  
Gui is borked and some other problems. See fixes below,
- [Ubuntu 24.04 + WSLg where some files are not created for the ubuntu user (uid 1000) causing Wayland to fall back to X11](https://stackoverflow.com/questions/79151910/how-to-fix-errors-in-wsl-gui)
- [After Ubuntu 24.04 upgrade, GUI apps are extremely slow to open #1250](https://github.com/microsoft/wslg/issues/1250)


## Table of Contents

Install and customization:
- [Base installation](#base-installation)
- [How to customize .bashrc](#how-to-customize-bashrc)
- [How to manage ssh](#how-to-manage-ssh)
- [How to build a custom kernel](./scripts/custom-kernel/)
- [Graphics and CUDA support](#graphics-and-cuda-support)
  - [Docker + CUDA](#docker--cuda)
- [Desktop](#desktop)
- [Docker](#docker)
- [Compacting to free up space](#compacting-to-free-up-space)
- [Mount external and network drives](#mount-external-and-network-drives)
- [WSL and GUI apps](#WSL-and-GUI-apps)
- [Serial over USB](#serial-over-usb)
- [Permissions for devices under `/dev/tty*`](#permissions-for-devices-under-devtty)
- [Setting permissions after copying dirs between distros](#setting-permissions-after-copying-dirs-between-distros)
- [Fix corrupt VHD](#fix-corrupted-vhd)
- [Troubleshooting WSL | Microsoft](https://learn.microsoft.com/en-us/windows/wsl/troubleshooting)
- [Kill WSL](#kill-wsl)

Misc
- [Docs](#docs)


## Base installation

_Fix PATH in .profile_  
In Ubuntu-22.04 they messed up the order of things so that required paths are not set until after `.bashrc` is executed.
1. `nano ~/.profile`
1. Find the block that starts with `# if running bash`
1. Move that block so that it is the _last_ thing executed in the file (we want any PATH stuff to be above it)
1. Save and reload shell

_Configure ssh key for github and clone repo_  
1. Create the dir for all ssh keys, `mkdir ~/.ssh`
2. [Generating a new SSH key and adding it to the ssh-agent| Github Docs](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
3. Start the ssh agent, run `eval $(ssh-agent -s)`
4. Add the private ssh key to the agent, example `ssh-add ~/.ssh/id_github_home`
5. Create development dir: `mkdir ~/dev && cd ~/dev`
6. Finally clone this repo, the final path should be `~/dev/dotfiles`

_Update and install defaults_
1. Update to latest, run script: `. ~/dev/dotfiles/scripts/update_all.sh`
1. Install default tools: run script: `. ~/dev/dotfiles/scripts/install_defaults.sh`
1. Add custom settings to `~/.bashrc`, see [instructions](#how-to-customize-bashrc)
1. [Add ssh keys](#how-to-manage-ssh)
1. (WSL) [Install pretty shell](./oh-my-posh.md)
1. [Install tmux](./tmux.md)  
   1. Then symlink config file `~/dev/dotfiles/configs/.tmux.conf` to `~/.tmux.conf`  
      ```sh
       ln -sf ~/dev/dotfiles/configs/.tmux.conf ~/.tmux.conf
      ```

## Desktop

You most likely will require a few extra utils to be able to run typical desktop apps.  
This has only been tested in Ubunty 22.04.
```sh
# Install desktop tooling for WSL
sudo apt install desktop-file-utils xdg-utils
# Install FUSE (required by AppImage)
sudo apt install libfuse2
```


## Docs

- [Connect USB device to WSL2 via network](./wsl-usb.md#Connect-USB-device-to-WSL2-via-network)
- [How to manage WSL disk space | Microsoft](https://learn.microsoft.com/en-us/windows/wsl/disk-space)  
  Very nice doc for handling some of the weird errors you see once in a lifetime


## How to customize .bashrc

All custom settings are stored in a separate file `.bashrc_dotfiles` in order to keep `.bashrc` as clean and default as possible (quite handy when handling lots of installs).

1. Open `.bashrc` in an editor
1. At the bottom of the file, add the following and save  
   NB! Make sure the path is correct for your system.
   ```sh
   ### dotfiles: shared settings
   source "$HOME/dev/dotfiles/configs/.bashrc_dotfiles"
   ### 
   ```
1. Reload shell
1. Done!


## How to manage ssh

I use [keychain](https://www.funtoo.org/Funtoo:Keychain) for easier management of ssh keys.  
Install and configuration of keychain are handled by default install script and bashrc extras config file.  
All you need to do is to prepare the ssh keys for usage:

1. Copy keys to `~/.ssh`
1. Set required permissions: run script `. ./scripts/set-ssh-permissions.sh`
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

   # If you run into permission trouble then first make sure you are using CMD in Administrator mode.
   # If still no-go, open explorer.exe and attempt to delete the file there, as you will get a different error message:
   # Open explorer at current location
   explorer.exe .
   # Usually it turns out to be TrustedInstaller that is the owner.
   # First take ownership of the file
   takeown /f libcuda.so
   # Then give admins the rights to change it
   icacls libcuda.so /grant Administrators:F /T
   # ...And now you should be able to delete and recreate the links as described above
   ```
2. Open WSL bash
   ```sh
   sudo ldconfig
   ```
   If this last command fail then restart wsl and run it again.  



##### Docker + CUDA

1. Install [nvidia container toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker)
1. Docker should work with CUDA out of the box with the latest version of Docker installed on win11 as described in [WSL 2 GPU Support for Docker Desktop on NVIDIA GPUs](https://www.docker.com/blog/wsl-2-gpu-support-for-docker-desktop-on-nvidia-gpus/)
1. You can verify that CUDA is available in docker by  
   a. Running the examples found in the docker page above, 
   b. or simply run CUDA benchmark like so (run both to be sure):  
      ```sh
      # Option: Use local dockerfiles (easy to use in k8s as well if you need to test gpu on node)
      docker build -t cuda-test -f docker/cuda-test.dockerfile docker/.
      docker build -t nvidia-smi -f docker/nvidia-smi.dockerfile docker/.
      # nvidia-smi will dump some gpu info in stdout
      docker run --rm --gpus=all nvidia-smi
      # cuda-test will rune some simple calculations using the cuda core and dump result in stdout
      docker run -it --rm --gpus=all cuda-test

      # Option: Use external 
      docker run --rm --gpus=all nvidia/cuda:11.6.2-base-ubuntu20.04 nvidia-smi
      docker run -it --gpus=all --rm nvcr.io/nvidia/k8s/cuda-sample:nbody nbody -benchmark
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

### Reclaim docker space

Run a container (provided by Docker themselves) to send TRIM commands to the hardware abstraction layer:
```sh
docker run --rm --privileged --pid=host docker/desktop-reclaim-space
```

## Compacting to free up space
2025:  
WSL can automatically trim drives, see post from [MS](https://learn.microsoft.com/en-us/windows/wsl/vhd-size)

Docker can still be "special", see docker notes for how to use a special image to send trim command to the host.


## Mount external and network drives

Note: Mounting works for _drives_.  
To access usb devices like microcontrollers etc then use _usbipd_.


### Mount usb drive

Examle where the drive is available under `f:` in windows

```sh
# WSL
sudo mkdir /mnt/f
sudo mount -t drvfs f: /mnt/f
```
### Mount network drive

Example where networked storage is already showing in Windows under `\\server\share`

```sh
# WSL
sudo mkdir /mnt/share
sudo mount -t drvfs '\\server\share' /mnt/share
```

## WSL and GUI apps

Access control seems to be disabled in WSL as `xhost` will print the following:  
```text
access control disabled, clients can connect from any host
SI:localuser:wslg
```
This means there is no point fiddling with `xhost + something` in WSL.

## Serial over USB

Example use case: read serial output from an arduino nano.  

This works quite well when using `usbipd-win`.  
You can inspect the traffic in linux terminal using the tool `minicom`.

Install and configure minicom for usb:
1. Install package `sudo apt install minicom`
1. First check with `dmesg | grep tty` if system recognize your adapter 
1. Then try to run minicom with `sudo minicom -s`, go to "Serial port setup" and change the first line to `/dev/ttyUSB0`
1. Finally save config as default with "Save setup as dfl"

Connect minicom to device:
1. `sudo minicom --device /dev/ttyUSB0`
1. Select "comm Paramenters" and speed to what ever the device is using
1. You should now see output from device


## Permissions for devices under `/dev/tty*`

This comes into play when you want to access misc USB stuff or other devices.  
The `/dev` directory is recreated at every boot, so any settings via `chmod` will vanish.  

In late 2023 MS enabled `systemd` by default for WSL2, which means we should no longer run into problems with permissions.

PRE 2023 UPDATE (systemd is not running) INFO:  
Normally the group `dialout` should be the owner for serial devices.  
Unfortunately there is a bug in WSL2 where group `root` is the only owner, ref [microsoft/WSL/issues/9247](https://github.com/microsoft/WSL/issues/9247).  
Use `chmod` option until fixed in WSL to avoid breaking stuff.

### Option: Use chmod before every time you want to use the device  

This setting will not survive reboot.

```sh
sudo chmod a+rw /dev/ttyACM0
```

### Option: Join group that owns `/dev/tty*`

This setting is permanent.  

```sh
# Find owner group. If this is root then we should not add users to it...
ls -l /dev/ttyACM0

# Add user to group. BEWARE: check group first, do not join root!
sudo adduser $USER $(stat --format="%G" /dev/ttyACM0)
```


## Setting permissions after copying dirs between distros

Aka "why do the directory have a green background?"

Apart from coloring files based on their type (turquoise for audio files, bright red for Archives and compressed files, and purple for images and videos), ls also colors files and directories based on their attributes:

- Black text with green background indicates that a directory is writable by others apart from the owning user and group, and has the sticky bit set (o+w, +t).
- Blue text with green background indicates that a directory is writable by others apart from the owning user and group, and does not have the sticky bit set (o+w, -t).

A "de-greener" command to get back the rights,

```sh
chmod -R a-x,o-w,+X thatGreenFolderWithSubfolders/
```

Sources: 
- [1 - What causes this green background in ls output? | stackexchange](https://unix.stackexchange.com/a/94505)
- [1 - What causes this green background in ls output? | stackexchange](https://unix.stackexchange.com/a/333647)

## Kill WSL

1. Open CMD with admin access
1. Run the following commands:
   ```sh
   taskkill /F /FI "IMAGENAME eq wsl.exe"
   taskkill /F /FI "IMAGENAME eq wslhost.exe"
   taskkill /F /FI "IMAGENAME eq wslservice.exe"
   ```

## Fix Corrupted VHD

Once in a blue moon you will see a system error message containing "Read-only file system" when running normal operations that should work.
This is usually down to corrupted VHD, and for Ubuntu in particular that is `/dev/sdb`.

The linux tool `e2fsck` can fix this as long as it can work _outside_ the VHD. Meaning you cannot run it properly from inside the distro that has a bad VHD.  
The workaround is to use another distro for this task.

Example:  
I have two distros installed:
- Ubuntu
- docker-desktop

"Ubuntu" is the distro that has a bad VHD. I can then use "docker-desktop" to fix that VHD.

1. Shutdown all wsl distros: `wsl --shutdown`
1. Mount the VHD:  
   ```sh
   wsl --mount %LOCALAPPDATA%\Packages\CanonicalGroupLimited.Ubuntu24.04LTS_79rhkp1fndgsc\LocalState\ext4.vhdx --vhd --bare
   ```
1. Fix the VHD from the other distro: `wsl -d docker-desktop -u root e2fsck -f -y /dev/sdc`
1. Unmount when done: `wsl --unmount %LOCALAPPDATA%\Packages\CanonicalGroupLimited.Ubuntu24.04LTS_79rhkp1fndgsc\LocalState\ext4.vhdx`
1. Done!

Source: [how-to-repair-a-vhd-mounting-error? the tutorial not work at all! | wsl git issue](https://github.com/microsoft/WSL/issues/10169#issuecomment-1581863587)
