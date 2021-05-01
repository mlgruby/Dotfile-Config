# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/satya/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=1

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    docker
    docker-compose
    extract
    mosh
    timer
    # zsh-autocomplete
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-z
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

up_widget() {
  BUFFER="cd .."
  zle accept-line
}

zle -N up_widget
bindkey "^\\" up_widget

# source global settings
if [ -f "$HOME/.aliases" ] ; then
  source "$HOME/.aliases"
fi

if [ -f "$HOME/.fzf.zsh" ] ; then
  source "$HOME/.fzf.zsh"
fi

# source local settings
if [ -f "$HOME/.local/.zshrc" ] ; then
  source "$HOME/.local/.zshrc"
fi

if [ -f "$HOME/.local/.bash_aliases" ] ; then
  source "$HOME/.local/.bash_aliases"
fi

# source .profile in zsh
[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# stow (th stands for target=home)
stowth() {
  stow -vSt ~ $1
}

unstowth() {
  stow -vDt ~ $1
}

# forgit
source ~/.forgit.plugin.zsh

fzf-z-search() {
        local res=$(history -n 1 | tail -f | fzf)
        if [ -n "$res" ]; then
            BUFFER+="$res"
            zle accept-line
        else
            return 0
        fi
    }
zle -N fzf-z-search
bindkey '^s' fzf-z-search

select-history() {
        BUFFER=$(history -n -r 1 \
            | awk 'length($0) > 2' \
            | rg -v "^...$" \
            | rg -v "^....$" \
            | rg -v "^.....$" \
            | rg -v "^......$" \
            | rg -v "^exit$" \
            | uniq -u \
            | fzf-tmux --no-sort +m --query "$LBUFFER" --prompt="History > ")
        CURSOR=$#BUFFER
    }
zle -N select-history
bindkey '^r' select-history

# process search and kill
psk() { ps -afx|  fzf |  xargs -0 -I {} echo {} | awk '{ printf $1 }' | xargs -0 -I {}  kill -9  {}; }

# find-in-file - usage: fif <SEARCH_TERM>
fif() {
  if [ ! "$#" -gt 0 ]; then
    echo "Need a string to search for!";
    return 1;
  fi
  rg --files-with-matches --no-messages "$1" | fzf $FZF_PREVIEW_WINDOW --preview "rg --ignore-case --pretty --context 10 '$1' {}"
}

# vevn
function activate-venv() {
  source "$HOME/.venv/$(ls ~/.venv/ | fzf)/bin/activate"
}

# Select a docker container to start and attach to
function da() {
  local cid
  cid=$(docker ps -a | sed 1d | fzf -1 -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker start "$cid" && docker attach "$cid"
}
# Select a running docker container to stop
function ds() {
  local cid
  cid=$(docker ps | sed 1d | fzf -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker stop "$cid"
}
# Select a docker container to remove
function drm() {
  local cid
  cid=$(docker ps -a | sed 1d | fzf -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker rm "$cid"
}

# Coursier
function fcsi() { # fzf coursier install
  function csl() {
    unzip -l "$(cs fetch "$1":latest.stable)" | grep json | sed -r 's/.*:[0-9]{2}\s*(.+)\.json$/\1/'
  }

  cs install --contrib "$(cat <(csl io.get-coursier:apps) <(csl io.get-coursier:apps-contrib) | sort -r | fzf)"
}

function fcsji() { # fzf coursier java install
  cs java --jvm $(cs java --available | fzf) --setup
}

function fcsrt() { # fzf coursier resolve tree
  $(cs resolve -t "$1" | fzf --reverse --ansi)
}

# git default branch
gitdefaultbranch(){
  git remote show origin | grep 'HEAD' | cut -d':' -f2 | sed -e 's/^ *//g' -e 's/ *$//g'
}
alias gitdb=gitdefaultbranch
alias gcodb='g checkout $(gitdb)'

# git current branch
gitcurrentbranch() {
  git symbolic-ref --short HEAD | tr -d "\n"
}
alias gcb=gitcurrentbranch

gitpull() {
  git pull --rebase origin $(gcb)
}
alias gpull=gitpull
gpush() {
  git push -u origin $(gcb)
}
alias gpush=gpush
gitcompush() {
  git add -A
  git commit --signoff -m $1
  git push -u origin $2
}
alias gitcompush=gitcompush
alias gcp='gitcompush $1 "$(gcb)"'

git-remote-add-merge() {
  git remote add upstream $1
  git fetch upstream
  git merge upstream/$(gitdb)
}
alias grfa=git-remote-add-merge

git-remote-merge() {
  git fetch upstream
  git merge upstream/$(gitdb)
}
alias grf=git-remote-merge

# ssh-keygen
rsagen() {
  ssh-keygen -t rsa -b 4096 -N $1 -f $HOME/.ssh/$2 -C $USER
}

sshls() {
  rg "Host " $HOME/.ssh/config | awk '{print $2}' | rg -v "\*"
}
alias sshls=sshls

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/satya/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/satya/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/satya/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/saftya/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# START: Added by Airflow Breeze autocomplete setup
# for bcfile in ~/.bash_completion.d/* ; do
#     . ${bcfile}
# done
# END: Added by Airflow Breeze autocomplete setup

# coursier bin
export PATH="$PATH:/home/satya/.local/share/coursier/bin"

# Pyenv setup 
export PATH="/home/satya/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)" 