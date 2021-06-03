#!/bin/bash

echo '[*] Making all installation script executable ...'
chmod +x *.sh
echo '[*] Installing fzf ...'
./fzf-installation.sh
echo '[*] Installing coursier cli ...'
./coursier-cli-installation.sh
echo '[*] Installing stow and keychain ...'
sudo apt install stow keychain -y
echo '[*] Installing forgit ...'
./forgit-installation.sh
echo '[*] Installing pyenv and poetry ...'
curl https://pyenv.run | bash 
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
echo '[*] Installing zsh and oh-my-zsh ...'
./zsh-installation.sh
echo '[*] Installing zsh required autocomplition plugins ...'
./zsh-plugin-installation.sh
echo '[*] Installing zsh poweline10k theme ...'
./powerlevel10k-theme-installation.sh
echo '[+]Done, Your terminal is ready with zsh and neovim configurations!'
echo '[*] Starting installation of neovim and required plugins ...'
./neovim-installation.sh
