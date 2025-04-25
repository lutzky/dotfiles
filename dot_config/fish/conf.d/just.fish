if not status is-interactive || not type -q just
	exit
end

just --completions=fish | source
