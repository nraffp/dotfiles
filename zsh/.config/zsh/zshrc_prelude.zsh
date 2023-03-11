#!/bin/zsh

autoload -Uz colors; colors
typeset -U path

#### Sources ####
source "$HOME/.zfuncs"
source "$HOME/.config/zsh/alias.zsh"

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
