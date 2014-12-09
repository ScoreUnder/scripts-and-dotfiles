#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

_shell_depth_str=$(seq 2 "$SHLVL" | tr -dc '\n' | tr '\n' '>')
_shell_depth_str=${_shell_depth_str:+$_shell_depth_str }
PS1='\e[0m'"$_shell_depth_str"'\e[1;34m\u\e[0m@\e[93m\h \e[1;37m\w \e[0m\$ '
