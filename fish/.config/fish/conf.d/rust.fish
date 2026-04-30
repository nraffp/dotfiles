# This config snippet is for rust toolchain related addtitions.

if test -e "$HOME/.cargo/env.sh"
    source "$HOME/.cargo/env.fish"
end

if test -e "$HOME/.cargo/bin"
    fish_add_path -mpP "$HOME/.cargo/bin"
end
