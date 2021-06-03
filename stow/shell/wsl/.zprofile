# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Homebrew
if [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi

# set PATH so it includes coursier bin if it exists
if [ -d "$HOME/.local/share/coursier/bin" ]; then
    PATH="$PATH:$HOME/.local/share/coursier/bin"
fi

# source local settings
if [ -f "$HOME/.local/.profile" ]; then
    source "$HOME/.local/.profile"
fi

# environment variables
export EDITOR="/usr/local/bin/nvim"
export VISUAL=$EDITOR

# fzf
export FZF_DEFAULT_COMMAND='fd --type f --color=never --hidden'
export FZF_DEFAULT_OPTS='--no-height --color=bg+:#343d46,gutter:-1,pointer:#ff3c3c,info:#0dbc79,hl:#0dbc79,hl+:#23d18b'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :50 {}'"

export FZF_ALT_C_COMMAND='fd --type d . --color=never --hidden'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -50'"

# java option
export JAVA_TOOL_OPTIONS="
-Dconfig.override_with_env_vars=true
-Djava.net.preferIPv4Stack=true
-Duser.timezone=UTC"

# cache ssh key at login
keychain --nogui --quiet $HOME/.ssh/id_rsa
source $HOME/.keychain/$(hostname)-sh

# xserver config for wsl
export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
export LIBGL_ALWAYS_INDIRECT=1


# >>> JVM installed by coursier >>>
export JAVA_HOME="/home/satya/.cache/coursier/jvm/graalvm-ce-java11@21.0.0"
export PATH="$PATH:/home/satya/.cache/coursier/jvm/graalvm-ce-java11@21.0.0/bin"
# <<< JVM installed by coursier <<<

# pyenv executable 
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
