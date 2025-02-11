function fish_prompt
    printf '[%s@%s] %s%s%s%s \n 󰘍 ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) (fish_git_prompt)
end

# Print a newline between each prompt
function foo --on-event fish_prompt
    printf "\n"
end
