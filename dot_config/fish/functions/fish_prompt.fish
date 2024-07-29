function fish_prompt
    # This prompt is designed to be ocassionally copied-and-pasted. For this
    # reason, we:
    #
    # * Avoid fish_right_prompt - this is on the same line as the actual
    #   command (multiple lines are not supported). It also makes resizing a
    #   bit ugly.
    # * Use $ and # in the prompt instead of prettier characters. This is
    #   sometimes treated specially by "copy this commandline" doc renderers.

    set -l cmd_status $status
    set -l duration (__human_duration $CMD_DURATION)

    if type -q _fish_prompt.work
        _fish_prompt.work
        echo -n (set_color $fish_color_quote)''(set_color normal)
    end

    echo -n (set_color fff --background $fish_color_quote)' '(date '+%H:%M:%S')' '
    echo -n (set_color --background $fish_color_host_remote $fish_color_quote)' '
    echo -n (set_color fff --background $fish_color_host_remote)(prompt_hostname)' '
    echo -n (set_color --background $fish_color_cwd $fish_color_host_remote)' '
    echo -n (set_color fff --background $fish_color_cwd)(prompt_pwd)' '
    echo -n (set_color normal; set_color $fish_color_cwd)' '

    if test -n "$fish_private_mode"
        echo -n (set_color $fish_color_user)'<P> '
    end

    if [ -n "$TMUX" ]
        set shlvl_threshold 2
    else
        set shlvl_threshold 1
    end

    if [ $SHLVL -gt $shlvl_threshold ]
        echo -n (set_color $fish_color_quote)"SH:$SHLVL "
    end

    if [ -n "$duration" ]
        echo -n (set_color normal)$duration' '
    end

    if test $cmd_status -ne 0
        echo -n (set_color red)"✘ $cmd_status "
    end

    echo -n (set_color normal; string trim -l (fish_git_prompt))

    set_color normal
    echo

    set -l symbol '$'

    if [ $cmd_status -ne 0 ]
        set_color $fish_color_status
    else
        if fish_is_root_user
            set_color $fish_color_cwd_root
            set -l symbol '#'
        else
            set_color $fish_color_user
        end
    end

    echo -n $symbol' '
    set_color normal
end
