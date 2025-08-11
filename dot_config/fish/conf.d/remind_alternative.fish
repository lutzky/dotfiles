function remind_alternative --on-event=fish_postexec
    set -l last_command_name (string split " " $argv[1])
    set -l last_command_name (string trim $last_command_name[1])

    switch "$last_command_name"
        case top
            set -f alternative btop
        case ps
            set -f alternative procs
        case find
            set -f alternative fd
        case ncdu
            set -f alternative dua
        case rename
            set -f alternative vidir
        case '*'
            return
    end

    if not type -q $alternative
        return
    end

    if alias | string match -q "alias $last_command_name $alternative"
        return
    end

    set -l uni_var_name "alternative_reminder_timestamp_$alternative"

    set -l reminder_due 0 # true

    # Check if the universal variable is set
    if set -q $uni_var_name
        set -l last_shown_time (string trim $$uni_var_name)

        set -l current_time (date +%s)
        set -l one_day_seconds 86400

        if test (math $current_time - $last_shown_time) -lt $one_day_seconds
            set reminder_due 1
        end
    else
        set reminder_due 0
    end

    if test $reminder_due -eq 0
        echo -e "\nℹ️ Reminder: You might prefer \033[92;1m$alternative\033[0m"
        set -U $uni_var_name (date +%s)
    end
end
