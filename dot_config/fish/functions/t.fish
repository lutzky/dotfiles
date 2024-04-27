function t -a "session_name" -d "Attach to a new or existing tmux session"
    if [ -z "$session_name" ]
        tmux ls
        return
    end

    if ! tmux has-session -t $session_name > /dev/null 2>&1
        tmux new-session -d -s $session_name
    end

    if [ -n "$TMUX" ]
        tmux switch-client -t $session_name
    else
        tmux attach-session -t $session_name
    end
end
