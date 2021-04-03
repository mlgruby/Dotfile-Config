#!/bin/bash

rm ~/.profile ~/.zprofile ~/.gitconfig ~/.aliases ~/.config/git/ignore ~/.config/htop/htoprc

stow -vSt ~ bash htop zsh
cd git && stow -vSt ~ work && cd ..
cd shell && stow -vSt ~ wsl && cd ..
