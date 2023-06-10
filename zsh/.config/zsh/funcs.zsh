# Function to Source a File
function zsh_add_file() {
    [ -f "$ZSH_PLUGINS/$1" ] && source "$ZSH_PLUGINS/$1"
}

# Function to add a Plugins
function zsh_add_plugin() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZSH_PLUGINS/$PLUGIN_NAME" ]; then 
        # For plugins
        zsh_add_file "$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || 
        zsh_add_file "$PLUGIN_NAME/$PLUGIN_NAME.zsh"
    else
        git clone "https://github.com/$1.git" "$ZSH_PLUGINS/$PLUGIN_NAME"
        zsh_add_file "$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || 
        zsh_add_file "$PLUGIN_NAME/$PLUGIN_NAME.zsh"
    fi
}

function sayHello(){
    echo "Hello"
}

function is_on_mac(){
  if [[ "$OSTYPE" == "darwin"* ]]; then
        return true
    else
        return false
    fi
}
