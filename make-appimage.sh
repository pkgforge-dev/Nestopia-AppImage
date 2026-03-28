#!/bin/sh

set -eu

ARCH=$(uname -m)
export ARCH
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=https://gitlab.com/jgemu/nestopia/-/raw/master/icons/nestopia256.png?ref_type=heads
export DESKTOP=https://gitlab.com/jgemu/nestopia/-/raw/master/nestopia-jg.desktop
export DEPLOY_OPENGL=1

# Deploy dependencies
quick-sharun /usr/bin/nestopia

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the app normally quits before that time
# then skip this or check if some flag can be passed that makes it stay open
quick-sharun --simple-test ./dist/*.AppImage
