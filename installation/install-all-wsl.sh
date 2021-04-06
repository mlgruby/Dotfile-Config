#!/bin/bash

echo '[*] Making all installation script executable ...'
chmod +x *.sh
echo '[*] Installing fzf ...'
./fzf-installation.sh
echo '[*] Installing coursier cli ...'
./coursier-cli-installation.sh
echo '[*] Installing forgit ...'
./forgit-installation.sh
echo '[*] Starting installation of neovim and required plugins ...'
./neovim-installation.sh
echo '[*] Installing zsh and oh-my-zsh ...'
./zsh-installation.sh
echo '[*] Installing zsh required autocomplition plugins ...'
./zsh-plugin-installation.sh
echo '[*] Installing zsh poweline10k theme ...'
./powerlevel10k-theme-installation.sh
echo '[+]Done, Your terminal is ready with zsh and neovim configurations!'
