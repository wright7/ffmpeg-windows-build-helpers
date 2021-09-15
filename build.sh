#!/bin/bash

############
# SETTINGS #
############

# Builds ffmpeg dependencies, turning off when dependencies are already built can greatly reduce build time.
# Required for first-time build!
BUILD_DEPS="y"

# ffmpeg source options
SRC="$(pwd)/../ffmpeg-fork"
CLEAN_SOURCE="n"

# MinGW-w64 version choice
# ------------------------
# 1. Both Win32 and Win64
# 2. Win32 (32-bit only)
# 3. Win64 (64-bit only)
# 4. Local native
# 5. Exit
ARCH=2

# Building on WSL?
WSL="y"

# Required packages
AUTO_INSTALL_REQUIRED_PACKAGES="n"

#########
# BUILD #
#########

# Install dependencies
if [ "$AUTO_INSTALL_REQUIRED_PACKAGES" == "y" ]; then
  sudo apt update
  sudo apt upgrade -y
  sudo apt-get install subversion ragel curl texinfo g++ bison flex cvs yasm automake libtool autoconf gcc cmake git make pkg-config zlib1g-dev unzip pax nasm gperf autogen bzip2 autoconf-archive p7zip-full meson clang python3-distutils upx-ucl -y
fi

# required for WSL
if [ "$WSL" == "y" ]; then
  sudo bash -c 'echo 0 > /proc/sys/fs/binfmt_misc/WSLInterop'
fi

# clone
if [ ! -d "$SRC/.git" ]; then
  git clone https://github.com/SamsungDForum/ffmpeg-fork.git --branch ffmpeg-4.3.1 "$SRC"
fi
if [ "$CLEAN_SOURCE" == "y" ]; then
  git -C "$SRC" reset --hard
  git -C "$SRC" clean -fd
  git -C "$SRC" status
fi

#build
echo $ARCH | ./cross_compile_ffmpeg.sh --build-ffmpeg-static=n --build-ffmpeg-shared=y --disable-nonfree=y --prefer-stable=y --build-dependencies=$BUILD_DEPS --ffmpeg-source-dir="$SRC"
if [$? -ne 0 ]; then
  exit 1
fi

# compress and pack
for f in "$SRC/bin/*.dll"; do upx --best $f; done
7z a libffmpeg.7z "$SRC/bin/*.dll"
7z l libffmpeg.7z 
