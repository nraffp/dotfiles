function fish_prompt
    printf '%s%s%s%s \n 󰘍 ' (set_color $fish_color_cwd) (prompt_pwd) (fish_git_prompt) (set_color $fish_color_normal)
end

# Print a newline between each prompt
function foo --on-event fish_prompt
    printf "\n"
end
