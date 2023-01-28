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
picom &
# urxvtd because I use the terminal every minute of every day
urxvtd -q -o &
# Set default input configuration (mouse sensitivity, keyboard layout, etc)
set-default-input-config &
# Load i3 workspaces if applicable
~/.i3/scripts/when-i3-starts ~/.i3/scripts/load-workspaces &
