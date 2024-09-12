if type "eza" > /dev/null; then
    alias ls='eza -g --group-directories-first'
fi

alias ll='exa -l --group-directories-first --icons'
alias dots='cd $(find -L ~/.config -type d -maxdepth 1 | fzf --height=40% --border || echo ".")'
alias projs='cd $(find -L ~/dev/projects -type d -maxdepth 1 | fzf --height=40% --border || echo ".")'

alias cat="alias_cat"
