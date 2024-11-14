#!/bin/sh
# A default terminal to be executed by i3
exec ifelse(
    TERMINAL(), `urxvt', `urxvtc-auto',
    TERMINAL(), `kitty', `kitty --instance-group auto --single-instance',
    `TERMINAL()'
) "$@"
