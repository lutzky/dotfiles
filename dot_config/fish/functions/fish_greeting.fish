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
        set rtl_fixer bidiv -w (math min $COLUMNS,60)
    else
        set rtl_fixer cat
    end

    if [ -f ~/.fortunes/fortunes ]
        echo -n "🥠 "
        fortune ~/.fortunes/fortunes | $rtl_fixer
    end

    set max_fortunes_age (math '3600*24*30')

    if test (path mtime -R ~/.fortunes/fortunes || echo $max_fortunes_age) -ge $max_fortunes_age
        echo "~/.fortunes stale or missing; run ~/.fortunes/update_fortunes.sh"
    end
end
