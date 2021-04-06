#!/bin/bash

echo '[*] Removing default configurations ...'
rm ~/.profile ~/.zprofile ~/.gitconfig ~/.aliases ~/.config/git/ignore ~/.config/htop/htoprc

echo '[*] Stowing/Creating simlinks for aliases, git, htop, zsh, neovim & zprofile ...'
stow -vSt ~ bash htop zsh neovim
cd git && stow -vSt ~ space && cd ..
cd shell && stow -vSt ~ nix && cd ..

echo '[*] Installing/Updating Neovim plugins ...'
nvim -c ':PlugInstall' -c ':UpdateRemotePlugins' -c ':qall'
