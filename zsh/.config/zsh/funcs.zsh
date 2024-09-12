# Function to Source a File
function zsh_add_file() {
    [ -f "$ZSH_PLUGINS/$1" ] && source "$ZSH_PLUGINS/$1"
}

# Function to add a Plugins
function zsh_add_plugin() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)

    if [ ! -d "$ZSH_PLUGINS/$PLUGIN_NAME" ]; then 
        echo "$ZSH_PLUGINS/$PLUGIN_NAME"
        git clone "https://github.com/$1.git" "$ZSH_PLUGINS/$PLUGIN_NAME"
    fi

    if [ -z "$2" ]; then
        zsh_add_file "$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || 
            zsh_add_file "$PLUGIN_NAME/$PLUGIN_NAME.zsh" ||
            zsh_add_file "$PLUGIN_NAME/$PLUGIN_NAME.zsh"
    else
        zsh_add_file "$PLUGIN_NAME/$2"
    fi
}

function alias_cat() {
    if command -v "bat" &> /dev/null; then
        bat "$@"
    else
        cat "$@"
    fi
}
