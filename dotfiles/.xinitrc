#!/bin/sh
exec >> ~/.xsession-errors 2>&1

# Include xinitrc.d files (e.g. systemd user session support)
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

. ~/.xprofile
exec i3
