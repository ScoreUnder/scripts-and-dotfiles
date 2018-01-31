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

# Ensure that the cursor starts at the start of the line after a command was
# executed. If not, print a highlighted dollar sign and a newline before
# the prompt is output.
cursor_ensure_newline() {
    local col row IFS dummy
    history -a
    printf "\033]0;%s@%s:%s\007" "${USER}" "HOSTNAME()" "${PWD/#$HOME/\~}"
    printf '\033[6n'
    IFS=';['
    read -s -d R dummy row col
    if [ "$col" != 1 ]; then
        printf '\033[47;30m$\033[0m\n'
    fi
}
PROMPT_COMMAND=cursor_ensure_newline

printf -v _shell_depth_str '%*s' "$((SHLVL-1))" ''
_shell_depth_str=${_shell_depth_str:+${_shell_depth_str// />} }
PS1='\[\e[0m\]'$_shell_depth_str'\[\e[1;34m\]\u\[\e[0m\]@\[\e[HOST_COLOR()m\]\h \[\e[1;37m\]\w \[\e[0m\]\$ '
unset _shell_depth_str
