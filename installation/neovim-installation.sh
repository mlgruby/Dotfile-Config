#!/bin/bash

FALLBACK_VERSION="0.4.4"

if [ "$1" == "" ]; then
    VERSION="v$FALLBACK_VERSION"
else
    VERSION="v$1"
fi

SOURCE=https://github.com/neovim/neovim/releases/download/$VERSION/nvim.appimage
TARGET=/usr/local/bin/nvim

# install curl
sudo apt install -yqqq curl

# install neovim
sudo curl -L $SOURCE -o $TARGET

sudo chmod 755 $TARGET

echo
nvim --version | head -1

echo
echo '"nvim" is now on the path'
