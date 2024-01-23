# i3 config file (v4)
#
# Please see http://i3wm.org/docs/userguide.html for a complete reference!

set $mod Mod4

# Font for window titles. Will also be used by the bar unless a different font
# is used in the bar {} block below. ISO 10646 = Unicode
font pango:FREETYPE_NEW_NAME(`lucy', `Tewi'), M+ 2c, IPA Gothic 9px

# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod

# start a terminal
bindsym $mod+Return exec i3-sensible-terminal
bindsym $mod+Shift+Return exec i3-sensible-terminal -e busybox sh

# kill focused window
bindsym $mod+Shift+q kill

# start dmenu (a program launcher)
bindsym $mod+d exec dmenu_run_mru -fn 'FREETYPE_NEW_NAME(`lucy', `Tewi')-9'
bindsym $mod+Shift+d exec i3-dmenu-desktop

# change focus
bindsym $mod+j focus left
bindsym $mod+k focus down
bindsym $mod+l focus up
bindsym $mod+semicolon focus right

# alternatively, you can use the cursor keys:
bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right

# move focused window
bindsym $mod+Shift+j move left
bindsym $mod+Shift+k move down
bindsym $mod+Shift+l move up
bindsym $mod+Shift+semicolon move right

# alternatively, you can use the cursor keys:
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right

# split in horizontal orientation
bindsym $mod+h split h

# split in vertical orientation
bindsym $mod+v split v

# enter fullscreen mode for the focused container
bindsym $mod+f fullscreen

# change container layout (stacked, tabbed, toggle split)
bindsym $mod+s layout stacking
bindsym $mod+w layout tabbed
bindsym $mod+e layout toggle split

# toggle tiling / floating
bindsym $mod+Shift+space floating toggle

# change focus between tiling / floating windows
bindsym $mod+space focus mode_toggle

# focus the parent container
bindsym $mod+a focus parent

# focus the child container
bindsym $mod+z focus child

# switch to workspace
bindsym $mod+grave exec i3-input -P 'Go to workspace ' -F 'workspace %s'
bindsym $mod+1 workspace 1
bindsym $mod+2 workspace 2
bindsym $mod+3 workspace 3
bindsym $mod+4 workspace 4
bindsym $mod+5 workspace 5
bindsym $mod+6 workspace 6
bindsym $mod+7 workspace 7
bindsym $mod+8 workspace 8
bindsym $mod+9 workspace 9
bindsym $mod+0 workspace 10

bindsym $mod+comma  workspace prev_on_output
bindsym $mod+period workspace next_on_output

# move focused container to workspace
bindsym $mod+Shift+notsign exec i3-input -P 'Move to workspace ' -F 'move to workspace %s'
bindsym $mod+Shift+1 move container to workspace 1
bindsym $mod+Shift+2 move container to workspace 2
bindsym $mod+Shift+3 move container to workspace 3
bindsym $mod+Shift+4 move container to workspace 4
bindsym $mod+Shift+5 move container to workspace 5
bindsym $mod+Shift+6 move container to workspace 6
bindsym $mod+Shift+7 move container to workspace 7
bindsym $mod+Shift+8 move container to workspace 8
bindsym $mod+Shift+9 move container to workspace 9
bindsym $mod+Shift+0 move container to workspace 10

bindsym $mod+Shift+comma  move container to workspace prev
bindsym $mod+Shift+period move container to workspace next

bindsym $mod+t move workspace to output right

# read 1 character and mark the current window with this character
bindsym $mod+Shift+m exec i3-input -F 'mark %s' -l 1 -P 'Mark: '

# read 1 character and go to the window with the character
bindsym $mod+m exec i3-input -F '[con_mark="%s"] focus' -l 1 -P 'Goto: '

# reload the configuration file
bindsym $mod+Shift+c reload
# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+r restart
# exit i3 (logs you out of your X session)
bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"

# resize window (you can also use the mouse for that)
mode "resize" {
        # These bindings trigger as soon as you enter the resize mode

        # Pressing left will shrink the window’s width.
        # Pressing right will grow the window’s width.
        # Pressing up will shrink the window’s height.
        # Pressing down will grow the window’s height.
        bindsym j resize shrink width 10 px or 10 ppt
        bindsym k resize grow height 10 px or 10 ppt
        bindsym l resize shrink height 10 px or 10 ppt
        bindsym semicolon resize grow width 10 px or 10 ppt

        # same bindings, but for the arrow keys
        bindsym Left resize shrink width 10 px or 10 ppt
        bindsym Down resize grow height 10 px or 10 ppt
        bindsym Up resize shrink height 10 px or 10 ppt
        bindsym Right resize grow width 10 px or 10 ppt

        # back to normal: Enter or Escape
        bindsym Return mode "default"
        bindsym Escape mode "default"
}

bindsym $mod+r mode "resize"

# Start i3bar to display a workspace bar (plus the system information i3status
# finds out, if available)
bar {
    status_command "exec I3_STATUS_COMMAND()"
    colors {
        background #000000
        statusline #ffffff
        separator  #666666

        focused_workspace  #4c7899 #285577 #ffffff
        active_workspace   #333333 #5f676a #ffffff
        inactive_workspace #333333 #000000 #888888
        urgent_workspace   #2f343a #900000 #ffffff
    }
ifelse(PRIMARY_MONITOR(), `', `',dnl
    tray_output PRIMARY_MONITOR()
)dnl
}

bindsym $mod+Shift+b bar mode toggle

hide_edge_borders both
new_window 1pixel
for_window [class="URxvt"] border 1pixel
for_window [class="Sakura"] border 1pixel
for_window [class="Xfce4-notifyd"] floating enable, border none
for_window [class="Truecrypt"] floating enable
for_window [title="Firefox Preferences"] floating enable
for_window [class="Guake"] floating enable, border none
for_window [class="rdesktop"] border none, floating disable
for_window [title="Please wait..."] floating enable, border none
for_window [title="Steam Keyboard" class="steam"] floating enable
for_window [class="Yad"] floating enable
assign [class="Steam"] 10
assign [class="steam"] 10
assign [class="steamwebhelper"] 10
bindsym XF86HomePage exec sensible-browser
bindsym XF86AudioNext exec press-next
bindsym XF86AudioPrev exec press-prev
bindsym XF86AudioPlay exec press-pause
bindsym XF86AudioPause exec press-pause
bindsym XF86AudioStop exec press-stop

bindsym XF86Display exec arandr

bindsym XF86AudioRaiseVolume exec pw-volume-change +0.05
bindsym XF86AudioLowerVolume exec pw-volume-change -0.05
bindsym XF86AudioMute exec pw-volume-change mute

# For keyboards with only volume keys
bindsym Shift+XF86AudioRaiseVolume exec press-next
bindsym Shift+XF86AudioLowerVolume exec press-prev
bindsym Shift+XF86AudioMute exec press-pause

bindsym $mod+b border toggle
bindsym Ctrl+$mod+l exec sensible-lock
bindsym Ctrl+$mod+Shift+l exec sensible-lock --suspend
bindsym XF86ScreenSaver exec sensible-lock
bindsym Ctrl+$mod+b exec bg-random
bindsym $mod+slash scratchpad show
bindsym $mod+Shift+slash move to scratchpad
bindsym Print exec take-screenshot
bindsym Ctrl+Print exec pomfclip
bindsym Ctrl+Shift+Print exec pomfclip --service='FILE_UPLOAD_SERVICE()'
bindsym Mod1+Sys_Req exec take-screenshot -s
bindsym Shift+Print exec screenshot-and-copy
bindsym $mod+Shift+s sticky toggle

# Dunst bindings
mode "dunst" {
    bindsym space exec dunstctl close
    bindsym Shift+space exec dunstctl close-all, mode default
    bindsym grave exec dunstctl history-pop
    bindsym period exec dunstctl context, mode default
    bindsym Return exec dunstctl action, mode default
    bindsym Escape mode default
}
bindsym $mod+n mode dunst

focus_follows_mouse yes
mouse_warping none

mode "keyquote" {
    bindsym $mod+BackSpace mode default
}
bindsym $mod+BackSpace mode keyquote

mode "run" {
    bindsym Escape mode default

    bindsym Return exec i3-sensible-terminal, mode default
    bindsym f exec FIREFOX_CMD(), mode default
    bindsym h exec i3-sensible-terminal -e htop, mode default
    bindsym j exec tagainijisho, mode default
    bindsym l exec luakit, mode default
ifelse(SOUND_SERVER(), `alsa',`dnl
    bindsym m exec i3-sensible-terminal -e alsamixer -c ALSA_CARD(), mode default
',`dnl
    bindsym m exec pavucontrol, mode default
')dnl
    bindsym p exec palemoon, mode default
    bindsym s exec ssh-add -c, mode default
    bindsym x exec xsel -x, mode default
}
bindsym $mod+x mode run

# class                 border  backgr. text    indicator
client.focused          #4c7899 #285577 #ffffff #2e9ef4
client.focused_inactive #333333 #5f676a #ffffff #484e50
client.unfocused        #333333 #222222 #888888 #292d2e
client.urgent           #2f343a #900000 #ffffff #900000
