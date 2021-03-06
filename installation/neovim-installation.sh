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
echo ''
echo '[*] Preparing Neovim config directory ...'
mkdir -p ~/.config/nvim

# Install nvim (and its dependencies: pip3, git), Python 3 and ctags (for tagbar)
echo '[*] App installing Neovim dependencies, and dependencies for tagbar (exuberant-ctags) ...'
sudo apt update
sudo apt install neovim python3 python3-pip python3-venv git curl exuberant-ctags -y

# Install virtualenv to containerize dependencies
echo '[*] Pip installing venv to containerize Neovim dependencies (instead of installing them onto your system) ...'
python3 -m venv ~/.config/nvim/env

# Install pip modules for Neovim within the virtual environment created
echo '[*] Activating virtualenv and pip installing Neovim (for Python plugin support), libraries for async autocompletion support (jedi, psutil, setproctitle), and library for pep8-style formatting (yapf) ...'
source ~/.config/nvim/env/bin/activate
pip install pynvim jedi psutil setproctitle yapf doq mypy black # run `pip uninstall neovim pynvim` if still using old neovim module
deactivate

# Install vim-plug plugin manager
echo '[*] Downloading vim-plug, the best minimalistic vim plugin manager ...'
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# (Optional but recommended) Install a nerd font for icons and a beautiful airline bar (https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts) (I'll be using Iosevka for Powerline)
echo "[*] Downloading patch font into ~/.local/share/fonts ..."
curl -fLo ~/.fonts/Iosevka\ Term\ Nerd\ Font\ Complete.ttf --create-dirs https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Iosevka/Regular/complete/Iosevka%20Term%20Nerd%20Font%20Complete.ttf

# Enter Neovim and install plugins using a temporary init.vim, which avoids warnings about missing colorschemes, functions, etc
# echo -e '[*] Running :PlugInstall within nvim ...'
# sed '/call plug#end/q' init.vim >~/.config/nvim/init.vim
# nvim -c ':PlugInstall' -c ':UpdateRemotePlugins' -c ':qall'
# rm ~/.config/nvim/init.vim

# # Copy init.vim in current working directory to nvim's config location ...
# echo '[*] Copying init.vim -> ~/.config/nvim/init.vim'
# cp init.vim ~/.config/nvim/

echo -e "[+] Done, welcome to \033[1m\033[92mNeoVim\033[0m! Try it by running: nvim/vim. Want to customize it? Modify ~/.config/nvim/init.vim"
