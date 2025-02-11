# This config snippet is for OS specific configurations

if status is-interactive
    switch (uname) 
        case Darwin
            fish_add_path -P "/opt/homebrew/bin"
    end
end
