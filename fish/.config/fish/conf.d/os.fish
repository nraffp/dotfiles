# This config snippet is for OS specific configurations

if status is-interactive
    switch (uname) 
        case Darwin
            fish_add_path -mpP "/opt/homebrew/bin"
    end
end
