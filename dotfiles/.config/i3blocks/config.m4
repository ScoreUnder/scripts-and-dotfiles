interval=5
command=~/bin/i3blocks/$BLOCK_NAME

[media]
signal=1

[disk]
label=H
instance=/home
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

ifelse(GPU_TEMPERATURE_FILE(), `', `', `dnl
[temperature]
instance=GPU_TEMPERATURE_FILE()
label=G

')dnl
[cpu_usage]
min_width=00.00%

[load_average]

[time]
command=date '+%a %F %T'
