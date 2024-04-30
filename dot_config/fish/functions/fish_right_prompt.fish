function fish_right_prompt
    set -l cmd_status $status

    set -l duration (__human_duration $CMD_DURATION)
    if [ -n "$duration" ]
        echo -n ' '(set_color normal)$duration
    end

    if test $cmd_status -ne 0
        echo -n (set_color red)" ✘ $cmd_status"
    end

    echo -n (set_color normal; fish_git_prompt)

    echo -n (set_color normal; set_color $fish_color_comment)' '
    echo -n (set_color 000 --background $fish_color_comment; date '+%H:%M:%S')
    echo -n (set_color normal; set_color $fish_color_comment)''

    set_color normal
end
