interval=5
command=~/bin/i3blocks/$BLOCK_NAME

[media]
signal=1

[disk]
label=G
instance=/mnt/green1
interval=30

[disk]
label=/
instance=/
interval=30

[iface]
instance=DEFAULT_LAN_IFACE()
color=#00FF00
label=E

[temperature]
instance=CPU_TEMPERATURE_FILE()
label=C

[temperature]
instance=/sys/class/hwmon/hwmon1/temp1_input
label=M

[cpu_usage]
min_width=00.00%

[load_average]

[time]
command=date '+%a %F %T'
