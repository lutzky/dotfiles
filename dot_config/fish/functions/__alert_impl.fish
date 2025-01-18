function __alert_impl -a _title _status _cmdline
    set message $_title
    if [ $_status = 0 ]
        set message "$message: OK"
    else
        set message "$message: ERROR ($_status)"
    end
    multi_notify "$message" "$_cmdline"
end

