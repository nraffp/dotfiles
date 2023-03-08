#!/bin/zsh

autoload -Uz colors; colors
typeset -U path

#### Sources ####
source "$ZDOTDIR/functions.zsh"
source "$ZDOTDIR/alias.zsh"

## Plugins ##
zsh_add_plugin "zsh-users/zsh-syntax-highlighting" &&

## Linux Settings
if [ $(uname -s) = "Linux" ];then
fi

## Mac Settings
if is_on_mac; then 
    export PATH=/opt/homebrew/bin:$PATH
    export PATH=/opt/homebrew/sbin:$PATH
fi

## Prompt ##
autoload -U promptinit; promptinit
eval "$(starship init zsh)"

#### Menu Select ####
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select

#### NVM ####
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

#### SSH and GPG ####
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

## Source the zshrc override file if it exsists.
if [ -e .zshrc_override ]
then
    source .zshrc_override
fi
