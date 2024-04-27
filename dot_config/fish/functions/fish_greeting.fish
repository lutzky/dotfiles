function fish_greeting
    fortune ~/.fortunes/fortunes | bidiv -j
    if [ -z $TMUX ]
        echo "Active tmux sessions: (remember t, C-a w)"
        if tmux has-session > /dev/null 2>&1
            tmux ls
        else
            echo "(none)"
        end
    end
end
