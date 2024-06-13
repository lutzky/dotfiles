function fish_prompt
    set -l cmd_status $status

    if type -q _fish_prompt.work
        _fish_prompt.work
        echo -n (set_color -r $fish_color_host_remote)' '(set_color normal)
    end

    echo -n (set_color 996 --background $fish_color_host_remote)@
    echo -n (set_color fff --background $fish_color_host_remote)(prompt_hostname)' '
    echo -n (set_color --background $fish_color_cwd $fish_color_host_remote)' '
    echo -n (set_color fff --background $fish_color_cwd)(prompt_pwd)' '
    echo -n (set_color normal; set_color $fish_color_cwd)' '

    if [ -n "$TMUX" ]
        set shlvl_threshold 2
    else
        set shlvl_threshold 1
    end

    if [ $SHLVL -gt $shlvl_threshold ]
        echo -n (set_color $fish_color_quote)"SH:$SHLVL "
    end

    set_color normal
    echo

    if [ $cmd_status -eq 0 ]
        set_color brgreen
    else
        set_color $fish_color_status
    end

    echo -n '❯ '

    set_color normal
end
