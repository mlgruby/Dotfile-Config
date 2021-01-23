#!/bin/bash

# remove yourself
rm $0

# install zsh-autocomplete
GITHUB_USER="marlonrichert"
GITHUB_REPO="zsh-autocomplete"
SOURCE=https://github.com/${GITHUB_USER}/${GITHUB_REPO}.git
TARGET=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/${GITHUB_REPO}

git clone ${SOURCE} ${TARGET}


# install zsh-z
GITHUB_USER="agkozak"
GITHUB_REPO="zsh-z"
SOURCE=https://github.com/${GITHUB_USER}/${GITHUB_REPO}.git
TARGET=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/${GITHUB_REPO}

git clone ${SOURCE} ${TARGET}


# install zsh-syntax-highlighting
GITHUB_USER="zsh-users"
GITHUB_REPO="zsh-syntax-highlighting"
SOURCE=https://github.com/${GITHUB_USER}/${GITHUB_REPO}.git
TARGET=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/${GITHUB_REPO}

git clone ${SOURCE} ${TARGET}


# install zsh-autosuggestions
GITHUB_USER="zsh-users"
GITHUB_REPO="zsh-autosuggestions"
SOURCE=https://github.com/${GITHUB_USER}/${GITHUB_REPO}.git
TARGET=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/${GITHUB_REPO}

git clone ${SOURCE} ${TARGET}