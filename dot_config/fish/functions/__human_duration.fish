function __human_duration --argument-names ms
    if ! set -q show_duration_threshold_ms
        set -f show_duration_threshold_ms 0
    end

    set --query ms[1] || return
    test $ms -gt $show_duration_threshold_ms || return

    set --local secs (math --scale=1 $ms/1000 % 60)
    set --local mins (math --scale=0 $ms/60000 % 60)
    set --local hours (math --scale=0 $ms/3600000)

    test $hours -gt 0 && echo -n {$hours}"h "
    test $mins -gt 0 && echo -n {$mins}"m "
    echo -n {$secs}"s"
end

