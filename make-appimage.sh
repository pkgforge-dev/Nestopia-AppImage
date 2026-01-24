#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q fceux | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/pixmaps/fceux1.png
export DESKTOP=/usr/share/applications/fceux.desktop

# Deploy dependencies
quick-sharun /usr/bin/fceux

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage
