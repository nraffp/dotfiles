function ls
    if command -q eza
        command eza -g --group-directories-first $argv
    else
        command ls $argv
    end
end
