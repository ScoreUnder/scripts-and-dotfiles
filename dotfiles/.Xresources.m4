URxvt.geometry: 120x40
URxvt.font: xft:FREETYPE_NEW_NAME(`lucy', `Tewi'):pixelsize=9:antialias=false,xft:IPA Gothic
URxvt.preeditType: OnTheSpot

! Allow switching between different fonts on-the-fly
URxvt.keysym.C-1: command:\033]50;xft:FREETYPE_NEW_NAME(`lucy', `Tewi'):pixelsize=9:antialias=false,xft:IPA Gothic\007
URxvt.keysym.C-2: command:\033]50;xft:FREETYPE_NEW_NAME(`xos4', `Terminus'):pixelsize=14:antialias=false,xft:IPA Gothic\007
URxvt.keysym.C-3: command:\033]50;xft:Source Code Pro:pixelsize=20:antialias=false,xft:IPA Gothic\007

URxvt.saveLines: 10000

URxvt.scrollBar: false
URxvt.internalBorder: 0

URxvt.urgentOnBell: true

! URxvt.iconFile: /usr/share/icons/Humanity/apps/48/bash.svg

URxvt.iso14755: off
URxvt.iso14755_52: off

URxvt.scrollTtyKeypress: on
URxvt.scrollTtyOutput: off
URxvt.scrollWithBuffer: on

URxvt.perl-lib: .urxvt/
URxvt.perl-ext-common: default,matcher,xim-onthespot
URxvt.matcher.launcher: /usr/bin/xdg-open
URxvt.keysym.C-Delete: matcher:select

! Rebind default copy/paste keys to include shift key (so it never conflicts
! with terminal control codes).  This is also consistent with other terminal
! emulators
URxvt.keysym.S-C-C: eval:selection_to_clipboard
URxvt.keysym.S-C-V: eval:paste_clipboard
URxvt.keysym.M-C-c: builtin-string:
URxvt.keysym.M-C-v: builtin-string:

! Tabs: gray background, ~white text
! and the opposite for the currently focused tab
URxvt.tabbed.tabbar-fg: 7
URxvt.tabbed.tabbar-bg: 8
URxvt.tabbed.tab-fg: 8
URxvt.tabbed.tab-bg: 7

! Display the title of terminal next to tabs list
URxvt.tabbed.title: true
URxvt.tabbed.title-bg: 8
URxvt.tabbed.title-fg: 7

! correct name so that applications detects a 256 color
! enabled terminal emulator
URxvt*termName: rxvt-unicode-256color

! Characters to break a word at
! Note: the quote symbol is repeated twice to avoid cpp complaining
!       the backslash is repeated twice because it doesnt seem to work otherwise (?)
changequote(`{:', `:}')dnl
URxvt.cutchars: \\`"'"&()*,;<=>?@[]^{|}:$#
changequote({:`:}, {:':})dnl

! emulate xterm-style control codes for ctrl+arrows and alt+arrows, etc
URxvt.keysym.S-Up:        \033[1;2A
URxvt.keysym.S-Down:      \033[1;2B
URxvt.keysym.S-Right:     \033[1;2C
URxvt.keysym.S-Left:      \033[1;2D
URxvt.keysym.M-Up:        \033[1;3A
URxvt.keysym.M-Down:      \033[1;3B
URxvt.keysym.M-Right:     \033[1;3C
URxvt.keysym.M-Left:      \033[1;3D
URxvt.keysym.S-M-Up:      \033[1;4A
URxvt.keysym.S-M-Down:    \033[1;4B
URxvt.keysym.S-M-Right:   \033[1;4C
URxvt.keysym.S-M-Left:    \033[1;4D
URxvt.keysym.C-Up:        \033[1;5A
URxvt.keysym.C-Down:      \033[1;5B
URxvt.keysym.C-Right:     \033[1;5C
URxvt.keysym.C-Left:      \033[1;5D
URxvt.keysym.S-C-Up:      \033[1;6A
URxvt.keysym.S-C-Down:    \033[1;6B
URxvt.keysym.S-C-Right:   \033[1;6C
URxvt.keysym.S-C-Left:    \033[1;6D
URxvt.keysym.M-C-Up:      \033[1;7A
URxvt.keysym.M-C-Down:    \033[1;7B
URxvt.keysym.M-C-Right:   \033[1;7C
URxvt.keysym.M-C-Left:    \033[1;7D
URxvt.keysym.S-M-C-Up:    \033[1;8A
URxvt.keysym.S-M-C-Down:  \033[1;8B
URxvt.keysym.S-M-C-Right: \033[1;8C
URxvt.keysym.S-M-C-Left:  \033[1;8D

! Modified version of a "non standard colour scheme"
! I found it on an online man page somewhere.
! http://linux.die.net/man/7/urxvt
! See also http://xcolors.net/dl/gnometerm for a more standard set
URxvt.cursorColor:  #dc74d1
URxvt.cursorColor2: #000000
URxvt.pointerColor: #dc74d1
!URxvt.background:   #0e0e0e
!URxvt.foreground:   #4ad5e1
URxvt.color0:       #000000
URxvt.color8:       #8b8f93
URxvt.color1:       #dc5471
URxvt.color9:       #ff74a1
URxvt.color2:       #0eb867
URxvt.color10:      #4ed897
URxvt.color3:       #dfe324
URxvt.color11:      #dff345
URxvt.color4:       #4040c0
URxvt.color12:      #8080ff
URxvt.color5:       #ce88f0
URxvt.color13:      #fea8ff
URxvt.color6:       #73f7ff
URxvt.color14:      #a8f7ff
URxvt.color7:       #e1dddd
URxvt.color15:      #ffffff

URxvt*foreground: #ffffff
URxvt*depth: 32
URxvt*background: rgba:0000/0000/0000/e000

URxvt*fading: 30

Xft.lcdfilter: lcddefault
Xft.hintstyle: hintslight
Xft.hinting: 1
Xft.autohint: 0
Xft.antialias: 1
Xft.rgba: rgb

xterm*faceName: FREETYPE_NEW_NAME(`lucy', `Tewi')
xterm*faceSize: 9px
xterm*termName: xterm-256color
xterm*locale: true
xterm*metaSendsEscape: true
xterm*foreground: rgb:cc/cc/cc
xterm*background: rgb:00/00/00
