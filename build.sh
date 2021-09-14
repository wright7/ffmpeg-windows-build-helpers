#!/bin/bash

# required for WSL
sudo bash -c 'echo 0 > /proc/sys/fs/binfmt_misc/WSLInterop'

SRC="$(pwd)/../ffmpeg-fork"
BUILD_DEPS="n"
ARCH=2

#git clone https://github.com/SamsungDForum/ffmpeg-fork.git --branch ffmpeg-4.3.1 "$SRC"
echo $ARCH | ./cross_compile_ffmpeg.sh --build-ffmpeg-static=n --build-ffmpeg-shared=y --disable-nonfree=y --prefer-stable=y --build-dependencies=$BUILD_DEPS --ffmpeg-source-dir="$SRC"

for f in "$SRC/bin/*.dll"; do upx --best $f; done
7z a libffmpeg.7z "$SRC/bin/*.dll"
