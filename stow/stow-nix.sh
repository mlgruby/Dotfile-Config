#!/bin/bash

rm ~/.profile ~/.zprofile ~/.gitconfig ~/.aliases ~/.config/git/ignore ~/.config/htop/htoprc

stow -vSt ~ bash htop zsh neovim
cd git && stow -vSt ~ space && cd ..
cd shell && stow -vSt ~ nix && cd ..
