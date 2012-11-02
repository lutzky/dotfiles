#!/bin/bash

# Thanks to http://askubuntu.com/questions/130393/how-to-configure-the-touchpad-middle-click

usage() {
	cat <<-EOF
Usage: $0 [install]

	Run with no parameters to configure 3-finger touch as middle-click

	Run with "install" to have this run automatically.
	EOF
}
case $1 in
	"")
		synclient TapButton3=2;;
	"install")
		gsettings set \
			org.gnome.settings-daemon.peripherals.input-devices \
			hotplug-command $(readlink -f $0);;
	*)
 		usage
		exit 1
		;;
esac
