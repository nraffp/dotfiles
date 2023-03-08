## Sets default Editor
export EDITOR="nvim"

## User Bin added to path
export PATH=$HOME/bin:$PATH

## EXA Configuration
export EXA_ICON_SPACING=2

## Source the zshenv override file if it exsists.
if [ -e .zshenv_override ]
then
    source .zshenv_override
fi
