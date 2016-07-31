general {
        output_format = i3bar
        colors = true
        interval = 5
}

order += "disk /"
ifelse(HOSTNAME, `kirisame',dnl
order += "disk /mnt/win"
order += "ethernet enp3s0"
order += "cpu_temperature cpu"
order += "cpu_temperature mobo"
,dnl
ifelse(HOSTNAME, `konpaku',dnl
order += "ethernet eno1"
order += "wireless wlo1"
order += "battery 0"
order += "cpu_temperature cpu"
,dnl
))dnl
order += "load"
order += "cpu_usage"
order += "tztime local"

ifelse(HOSTNAME, `kirisame',dnl
ethernet enp3s0 {
        # if you use %speed, i3status requires root privileges
        format_up = "E: %ip (%speed)"
        format_down = "E: down"
}
,dnl
ifelse(HOSTNAME, `konpaku',dnl
ethernet eno1 {
        # if you use %speed, i3status requires root privileges
        format_up = "E %ip (%speed)"
        format_down = "E"
}

wireless wlo1 {
        format_up = "W %ip %bitrate %essid"
        format_down = "W"
}

battery 0 {
        format = "%status %percentage %remaining %emptytime %consumption"
        low_threshold = "5"
}
,dnl
))dnl

tztime local {
        format = "%Y-%m-%d %H:%M:%S"
}

load {
        format = "%1min"
}

cpu_usage {
        format = "%usage%%"
}

ifelse(HOSTNAME, `kirisame',dnl
cpu_temperature cpu {
        format = "C %degrees°C"
        path = "/sys/class/hwmon/hwmon0/temp1_input"
}

cpu_temperature mobo {
        format = "M %degrees°C"
        path = "/sys/class/hwmon/hwmon0/temp2_input"
}

disk "/" {
        format = "L %free/%total"
}

disk "/mnt/win" {
        format = "W %free/%total"
}
,dnl
ifelse(HOSTNAME, `konpaku',dnl
cpu_temperature cpu {
        format = "C %degrees°C"
        path = "/sys/class/thermal/thermal_zone0/temp"
}

disk "/" {
        format = "%free/%total"
}
,dnl
))dnl
