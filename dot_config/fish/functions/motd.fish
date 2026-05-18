function motd --description 'Print the Ubuntu MOTD/update status'
    if test -s /run/motd.dynamic
        cat /run/motd.dynamic
    else if test -f /var/lib/update-notifier/updates-available
        cat /var/lib/update-notifier/updates-available
    else
        echo "No MOTD cache found. Try running 'sudo apt update' to refresh system status."
    end
end
