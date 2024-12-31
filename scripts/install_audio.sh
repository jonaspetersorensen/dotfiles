#!/bin/bash

# DOCS
# - https://linux.die.net/man/1/sox
# - https://github.com/microsoft/wslg/blob/main/README.md, see "Pulse Audio"
# - https://github.com/microsoft/WSL/issues/5816, see latest comments from 2024

echo "By default WSLg support audio via Pulse Audio, see https://github.com/microsoft/wslg/blob/main/README.md"
echo "SoX - Sound eXchange, the Swiss Army knife of audio manipulation on linux."
echo "This script will install sox and related libs for pulse audio and mp3."
echo "Usage example: play some-sound.mp3"
echo "------------------------------------"
sudo apt -qq sox libsox-fmt-pulse libsox-fmt-mp3
echo "------------------------------------"
echo "All done!"
echo ""
echo "For some reason the required environment variable is missing, please update your shell environment with the following:"
echo "export PULSE_SERVER=unix:/mnt/wslg/PulseServer"