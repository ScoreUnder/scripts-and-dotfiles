#!/bin/sh
# /etc/acpi/default.sh
# Default acpi script that takes an entry for all actions

set $*

group=${1%%/*}
action=${1#*/}
device=$2
id=$3
value=$4

log_unhandled() {
	logger "ACPI event unhandled: $*"
}

case "$group" in
	button)
		case "$action" in
			up|down|left|right)
				;;

			power)
				/etc/acpi/actions/powerbtn.sh
				;;

			sleep)
				echo mem > /sys/power/state
				;;

			# if your laptop doesnt turn on/off the display via hardware
			# switch and instead just generates an acpi event, you can force
			# X to turn off the display via dpms.  note you will have to run
			# 'xhost +local:0' so root can access the X DISPLAY.
			#lid)
			#	xset dpms force off
			#	;;

			prog1)
				# ThinkVantage button
				#button/prog1 PROG1 00000080 00000000 K
				rc-service wpa_supplicant restart
				;;

			wlan)
				if rfkill list | grep -q 'Soft blocked: yes'; then
					op=unblock
				else
					op=block
				fi
				rfkill list | awk -F: '/^[[:digit:]]/{print $1}' | while IFS= read -r dev; do
					rfkill "$op" "$dev"
				done
				;;

			*)	log_unhandled $* ;;
		esac
		;;

	video)
		case $action in
			brightnessdown)
				/usr/local/sbin/set-brightness -20
				;;

			brightnessup)
				/usr/local/sbin/set-brightness +20
				;;

			*)	log_unhandled $* ;;
		esac
		;;

	ac_adapter)
		case "$value" in
			# Add code here to handle when the system is unplugged
			# (maybe change cpu scaling to powersave mode).  For
			# multicore systems, make sure you set powersave mode
			# for each core!
			*0)
				cpupower frequency-set -g powersave
				;;

			# Add code here to handle when the system is plugged in
			# (maybe change cpu scaling to performance mode).  For
			# multicore systems, make sure you set performance mode
			# for each core!
			*1)
				cpupower frequency-set -g performance
				;;

			*)	log_unhandled $* ;;
		esac
		;;

	*)	log_unhandled $* ;;
esac
