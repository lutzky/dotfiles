if not status is-interactive || not type -q jj
	exit
end

COMPLETE=fish jj | source
