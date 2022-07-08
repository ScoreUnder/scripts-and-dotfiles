changequote([, ])dnl
define(APOS, ['])dnl
changequote(`, ')dnl
#!/bin/sh
# Import important environment vars
. ~/.environment

# Set up screens
~/.screenlayout/default.sh &

# Read in settings in Xresources
xrdb ~/.Xresources

# Set up QT Theme (manage with qt5ct)
export QT_QPA_PLATFORMTHEME=qt5ct

ifelse(IME_NAME(), `', `', `dnl
`#' Turn on IME_NAME() for Japanese input
ifelse(
    IME_NAME(), `uim', ``uim-xim'',
    IME_NAME(), `ibus', ``ibus-daemon -drx'',
    `:'
) &
export GTK_IM_MODULE=APOS()ifelse(IME_NAME(), `xim', ``none'', `IME_NAME()')APOS()
export QT_IM_MODULE=APOS()IME_NAME()APOS()
export XMODIFIERS=APOS()@im=IME_NAME()APOS()
')dnl

# Run SSH agent
eval "$(ssh-agent)"

# Setup for launching pipewire on gentoo (& actually launching it)
if [ -x /usr/bin/gentoo-pipewire-launcher ]; then
    # XDG Runtime Dir
    # Using a custom script in /usr/local/sbin to create it in the place firejail expects
    # But the way recommended on the wiki is here commented out
    if test -z "$XDG_RUNTIME_DIR"; then
        #export XDG_RUNTIME_DIR="$(mktemp -d /tmp/"$(id -u)"-runtime-dir.XXX)" \
        #    && chmod 700 -- "$XDG_RUNTIME_DIR"
        export XDG_RUNTIME_DIR=$(sudo create-runuser)
    fi

    # DBUS
    if command -v dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
        eval "$(dbus-launch --sh-syntax --exit-with-session)"
    fi

    # Pipewire
    /usr/bin/gentoo-pipewire-launcher &
fi

# Notification daemon
dunst &
# Auto-lock screen
xautolock -locker ~/bin/sensible-lock -time 15 &
# Random wallpapers on boot and every 10 mins
wallpaper-cycler &
# Compositing for transparency and forced vsync
picom --experimental-backends &
# urxvtd because I use the terminal every minute of every day
urxvtd -q -o &
# Num lock!
numlockx &
# Set up key map
setxkbmap -option -print gb+level3\(ralt_switch_multikey\)+mykeyboard \
    | xkbcomp -I`$HOME'/.config/xkb - "$DISPLAY" &
# Disable mouse acceleration
xinput | perl -lne '/Razer Razer Naga Chroma.*pointer/ or next; /\bid=(\d+)\b/ or next; print $1' | xargs -I{} xinput set-prop {} 'libinput Accel Speed' -1 &
# Set up sensible finger tapping options
xinput set-prop 'SynPS/2 Synaptics TouchPad' 'Synaptics Two-Finger Scrolling' 1 1 &
xinput set-prop 'SynPS/2 Synaptics TouchPad' 'Synaptics Tap Action' 0 0 0 0 1 2 3 &
# Enable palm detection
xinput set-prop 'SynPS/2 Synaptics TouchPad' 'Synaptics Palm Detection' 1 &
xinput set-prop 'SynPS/2 Synaptics TouchPad' 'Synaptics Palm Dimensions' 6 10 &
# Use TrackPoint wheel emulation (middle mouse + trackpoint drag)
xinput set-prop 'TPPS/2 IBM TrackPoint' 'Evdev Wheel Emulation' 1 &
xinput set-prop 'TPPS/2 IBM TrackPoint' 'Evdev Wheel Emulation Button' 2 &
xinput set-prop 'TPPS/2 IBM TrackPoint' 'Evdev Wheel Emulation Axes' 6 7 4 5 &
# Load i3 workspaces if applicable
~/.i3/scripts/when-i3-starts ~/.i3/scripts/load-workspaces &
