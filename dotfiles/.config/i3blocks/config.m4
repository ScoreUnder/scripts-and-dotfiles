interval=5
command=~/bin/i3blocks/$BLOCK_NAME

[media]
signal=1

[disk-green]
label=G
command=~/bin/i3blocks/disk
instance=/mnt/green1
interval=30

[disk-root]
label=/
command=~/bin/i3blocks/disk
instance=/
interval=30

[network]
instance=enp3s0
color=#00FF00
label=E

[temperature-cpu]
command=~/bin/i3blocks/temperature /sys/class/hwmon/hwmon1/temp1_input
label=C

[temperature-mobo]
command=~/bin/i3blocks/temperature /sys/class/hwmon/hwmon1/temp2_input
label=M

[cpu_usage]
min_width=00.00%

[load_average]

[time]
command=date '+%F %T'
