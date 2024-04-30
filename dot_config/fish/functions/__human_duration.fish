function __human_duration --argument-names ms
    set --query ms[1] || return
    test $ms -gt 3000 || return

    set --local secs (math --scale=1 $ms/1000 % 60)
    set --local mins (math --scale=0 $ms/60000 % 60)
    set --local hours (math --scale=0 $ms/3600000)

    test $hours -gt 0 && echo -n {$hours}"h "
    test $mins -gt 0 && echo -n {$mins}"m "
    echo -n {$secs}"s"
end

