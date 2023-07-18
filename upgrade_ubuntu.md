# Upgrade Ubuntu distro

There are two ways: 
1. The regular "make ubuntu update itself" in linux (the current wsl distro)
2. Install a new distro in windows, then migrate

Source: ["Upgrade Ubuntu in WSL2 from 20.04 to 22.04" | askubunt](https://askubuntu.com/questions/1428423/upgrade-ubuntu-in-wsl2-from-20-04-to-22-04)

## Option - Upgrade in linux

```sh
sudo apt update && sudo apt full-upgrade
# restart Ubuntu
sudo do-release-upgrade
```

## Option - Install new distro in Windows

List all distros that you can install from a Command Prompt:
```sh
wsl --list --online
```
The list contained the desired Ubuntu-22.04, so we can install it with:

```sh
wsl --install -d Ubuntu-22.04
```
It is also possible to install it on a GUI with the Windows Store, just search for "Ubuntu 22.04" and pick the Canonical provided item.

To get a shell into the newly installed Ubuntu-22.04 container run:
```sh
wsl -d Ubuntu-22.04
```
or to set it as the default container:
```sh
wsl --setdefault Ubuntu-22.04
```
after which running just:
```sh
wsl
```
will use Ubuntu-22.04 by default.
