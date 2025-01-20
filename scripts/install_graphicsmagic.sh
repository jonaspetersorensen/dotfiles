#!/bin/bash

# http://www.graphicsmagick.org/
# Unfortunately this is not a single install
# It is a bunch of util libs + a command line tool to wrangle them all
# This script is based in instructions from https://gist.github.com/neoneye/00fad388e38f5b0361f66cc1a3b2f57e
# Note that files are now only available from https://sourceforge.net/projects/graphicsmagick/files/graphicsmagick/
# FTP has been shut down


############################################
# Prepare for installing GraphicsMagick

HOME_DIRECTORY="/home/$USER"
TMP_DIRECTORY="$HOME_DIRECTORY/tmp_graphicsmagick"
GM_VERSION=1.3.38

if [ ! -d "$TMP_DIRECTORY" ]; then
  echo "$TMP_DIRECTORY does not exist. Creating..."
  mkdir -p "$TMP_DIRECTORY"
fi
cd "$TMP_DIRECTORY"
pwd

sudo apt -y update
sudo apt -qq install \
    libbz2-dev \
    libfreetype6-dev \
    libjbig-dev \
    liblcms2-dev \
    liblzma-dev \
    libpng-dev \
    libtiff-dev \
    libtool \
    libwebp-dev \
    libwmf-dev \
    libx11-dev \
    libxdmcp-dev \
    libxext-dev \
    libxft-dev \
    libxml2-dev \
    libxt-dev \
    libzstd-dev \
    zlib1g-dev \
    libperl-dev


############################################
# Download and unpack GraphicsMagick

wget "https://sourceforge.net/projects/graphicsmagick/files/graphicsmagick/${GM_VERSION}/GraphicsMagick-${GM_VERSION}.tar.gz"
tar -xzf "GraphicsMagick-${GM_VERSION}.tar.gz"

############################################
# Build it

cd "GraphicsMagick-${GM_VERSION}"
./configure
make
sudo make install

############################################
# Clean up and done

cd "$HOME_DIRECTORY"
rm -rf "$TMP_DIRECTORY"

gm version


