function fish_greeting
    if type -q tmux && [ -z $TMUX ]
        echo "Active tmux sessions: (remember t, C-a w)"
        if tmux has-session > /dev/null 2>&1
            tmux ls
        else
            echo "(none)"
        end
    end

    type -q _fish_greeting_work && _fish_greeting_work

    if type -q bidiv
        set rtl_fixer bidiv -j -w (math min $COLUMNS,60)
    else
        set rtl_fixer cat
    end

    if [ -f ~/.fortunes/fortunes ]
        echo -n "🥠 "
        fortune ~/.fortunes/fortunes | $rtl_fixer
    end
end
