#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
. ~/.environment

alias ls='ls --color=auto -F'
alias l='ls -l'
alias lh='l -Ah'

HISTIGNORE=l:ls:lh
HISTCONTROL=ignoreboth

shopt -s autocd

stty -ixon

printf -v _shell_depth_str '%*s' "$((SHLVL-1))" ''
_shell_depth_str=${_shell_depth_str:+${_shell_depth_str// />} }
PS1='\[\e[0m\]'$_shell_depth_str'\[\e[1;34m\]\u\[\e[0m\]@\[\e[HOST_COLOR()m\]\h \[\e[1;37m\]\w \[\e[0m\]\$ '
unset _shell_depth_str
