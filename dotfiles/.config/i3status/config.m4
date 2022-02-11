general {
        output_format = i3bar
        colors = true
        interval = 5
}

order += "disk /"
ifelse(HOSTNAME, `kirisame',dnl
order += "disk /mnt/win"
)dnl
order += "ethernet DEFAULT_LAN_IFACE()"
ifelse(WIFI_IFACE, `', `',dnl
order += "wireless WIFI_IFACE()"
)dnl
define(BATTERY_ORDER, `ifelse($1, `', `', `order += "battery $1"
BATTERY_ORDER(shift($@))')')dnl
BATTERY_ORDER(BATTERY())dnl
order += "cpu_temperature cpu"
ifelse(HOSTNAME, `kirisame',dnl
order += "cpu_temperature mobo"
)dnl
order += "load"
order += "cpu_usage"
order += "tztime local"

ethernet DEFAULT_LAN_IFACE() {
        # if you use %speed, i3status requires root privileges
        format_up = "E %ip (%speed)"
        format_down = "E"
}

ifelse(WIFI_IFACE, `', `', `dnl
wireless WIFI_IFACE() {
        format_up = "W %ip %bitrate %essid"
        format_down = "W"
}
')dnl

define(BATTERY_FORMAT, `ifelse($1, `', `', `dnl
battery $1 {
        format = "%status %percentage %remaining %emptytime %consumption"
        low_threshold = "5"
}

BATTERY_FORMAT(shift($@))')')dnl
BATTERY_FORMAT(BATTERY())dnl
tztime local {
        format = "%Y-%m-%d %H:%M:%S"
}

load {
        format = "%1min"
}

cpu_usage {
        format = "%usage%%"
}

cpu_temperature cpu {
        format = "C %degrees°C"
        path = "CPU_TEMPERATURE_FILE()"
}

ifelse(HOSTNAME, `kirisame',dnl
cpu_temperature mobo {
        format = "M %degrees°C"
        path = "/sys/class/hwmon/hwmon1/temp1_input"
}

disk "/" {
        format = "L %free/%total"
}

disk "/mnt/win" {
        format = "W %free/%total"
}
,dnl
disk "/" {
        format = "%free/%total"
}
)dnl
