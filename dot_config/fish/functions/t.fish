function t -a "session_name" -d "Attach to a new or existing tmux session"
    if [ -z "$session_name" ]
        tmux ls
        return
    end

    if type -q tmx2
        set tmx_launcher tmx2
    else
        set tmx_launcher tmux
    end

    if ! TMUX= tmux has-session -t $session_name > /dev/null 2>&1
        TMUX= $tmx_launcher new-session -d -s $session_name
    end

    if [ -n "$TMUX" ]
        tmux switch-client -t $session_name
    else
        $tmx_launcher attach-session -t $session_name
    end
end
