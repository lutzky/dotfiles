#!/bin/bash

# Thanks to http://askubuntu.com/questions/130393/how-to-configure-the-touchpad-middle-click

usage() {
	cat <<-EOF
Usage: $0 [install]

	Run with "install" to have this run automatically.

	Run with anything else to configure 3-finger touch as middle-click

	EOF
}
case $1 in
	-h) usage;;
	"install")
		gsettings set \
			org.gnome.settings-daemon.peripherals.input-devices \
			hotplug-command $(readlink -f $0);;
	*) synclient TapButton3=2;;
esac
