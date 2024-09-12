#!/bin/zsh

autoload -Uz colors; colors
typeset -U path

#### Sources ####
source "$HOME/.config/zsh/funcs.zsh"
source "$HOME/.config/zsh/alias.zsh"

## Plugins ##
zsh_add_plugin "zsh-users/zsh-syntax-highlighting" &&
# zsh_add_plugin "zsh-users/zsh-autosuggestions" &&
# zsh_add_plugin "jeffreytse/zsh-vi-mode" &&
# zsh_add_plugin "spaceship-prompt/spaceship-prompt" "spaceship.zsh" &&


## Linux Settings
if [ $(uname -s) = "Linux" ];then
fi

## Mac Settings
if [[ "$OSTYPE" == "darwin"* ]]; then 
    export PATH=/opt/homebrew/bin:$PATH
    export PATH=/opt/homebrew/sbin:$PATH
fi

## Prompt ##
autoload -U promptinit; promptinit
# if type "starship" > /dev/null; then
#     eval "$(starship init zsh)"
# fi

#### Menu Select ####
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
