# vim: ft=sh
alias ls='ls --color=auto -F'
alias l='ls -l'
alias ll='l -go'
alias lh='l -Ah'
alias grep='grep --color=auto'
alias ..=cd\ ..
alias ...=cd\ ../..
alias ....=cd\ ../../..

HISTFILE=~/.mksh_history

# Lol.
eval "$(awk -F: 'function san(str) {gsub(/[^a-zA-Z0-9_]/, "_", str);return str;} $6!="/"{$6=san($6); $1=san($1); print "_homedir_" $6 "=" $1}' /etc/passwd)"
_pretty_path() {
    part=$1
    while [ "${part%/*}" != "$part" ]; do
        eval "pretty_dir=\$_homedir_${part//[!a-zA-Z0-9_]/_}"
        [ -n "$pretty_dir" ] && break
        part=${part%/*}
    done
    if [ -z "$pretty_dir" ]; then
        pretty_dir=$1
    elif [ "$pretty_dir" = "$USER" ]; then
        pretty_dir=\~${1#$part}
    else
        pretty_dir=\~$pretty_dir${1#$part}
    fi
    print -r -- "$pretty_dir"
    _last_pwd=$1
}
PS1=$'\001\r$(_exitcode)\001\e[1;34m\001'"$USER"$'\001\e[0m\001@\001\e[HOST_COLOR()m\001'$(hostname)$' \001\e[1;37m\001$(_pretty_path "$PWD")\001\e[0m\001$(_vcsinfo) \$ '

# {{{ This code mostly taken from grml-dash-config
# Some are modified for efficiency on mksh
_exitcode() {
    integer code="$?" cols
    if (( code )); then
        cols=$(tput cols)
        print -n '\001'
        tput cuf $((cols-3))
        print -n ':('
        tput cub $((cols-1))
        print -nr $'\033[91;1m\001'"$code "
    fi
}

_vcs_prompt() {
    print -nr $' \001\033[35m\001(\001\033[39m\001'"$1"$'\001\033[35m\001)\001\033[33m\001-\001\033[35m\001[\001\033[32m\001'"$2"
    (( $# == 3 )) && print -nr $'\001\033[31m\001:\001\033[33m\001'"$3"
    print -nr $'\001\033[35m\001]\001\033[0m\001'
}

_vcsinfo() {
    local evidence="$PWD" branch
    # Handle the simple case first
    if [ -r CVS/Repository ]; then
        _vcs_prompt cvs "$(cat CVS/Repository)"
        return
    fi

    # If PWD doesn't start with a /, exit to avoid an infinite loop
    # This "should never happen" but we all know what happens when
    # things "should never happen"...
    [ "${evidence#/}" = "$evidence" ] && return 1

    # bzr is dog slow, some others probably are too.
    # Scanning for evidence of each VCS in each parent directory is *much*
    # faster than launching each VCS to do the scanning and directory
    # traversal itself.
    while [ -n "$evidence" ]; do
        if [ -d "$evidence/.git" ] && branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null); then
            [ "$branch" = HEAD ] && branch=$(git rev-parse --short HEAD)...
            _vcs_prompt git "$branch"
            return
        fi
        if [ -d "$evidence/.hg" ] && branch=$(hg branch 2>/dev/null); then
            _vcs_prompt hg "$branch"
            return
        fi
        if [ -d "$evidence/.bzr" ] && branch=$(bzr nick 2>/dev/null); then
            _vcs_prompt bzr "$branch" "$(bzr revno)"
            return
        fi
        if [ -d "$evidence/.svn" ] && info=$(svn info --non-interactive); then
            local line wcrp= dir= revs= nl=$'\n' IFS
            IFS="$nl"
            for line in $info; do
                case "$line" in
                    "Working Copy Root Path: "*)
                        wcrp=${line#*: }
                        break;;
                esac
            done
            [ -n "$wcrp" ] && [ "$wcrp" != "$PWD" ] && info=$(svn info --non-interactive -- "$wcrp")
            for line in $info; do
                case "$line" in
                    "URL: "*) dir=${line#*: }; dir=${dir##*/};;
                    "Revision: "*) revs=${line#*: };;
                esac
            done
            [ -n "$dir" -a -n "$revs" ] && _vcs_prompt svn "$dir" "$revs" && return
        fi
        # Go up a directory
        evidence=${evidence%/*}
    done
}

_dir_stack_size=20
_dir_stack=()
pushd() {
    local old_dir="$PWD"
    \cd "$@" || return
    _dir_stack=("$old_dir" "${_dir_stack[@]}")
    if (( ${#_dir_stack[@]} > _dir_stack_size )); then
        # Cut array down to size
        unset '_dir_stack[$((_dir_stack_size-1))]'
    fi
}

popd() {
    if (( ${#_dir_stack[@]} == 0 )); then
        echo >&2 'popd: directory stack empty'
        false
    else
        cd -- "${_dir_stack[0]}"; result=$?
        for d in "${_dir_stack[@]}"; do print -n -- "$(_pretty_path "$d") "; done; echo
        unset '_dir_stack[0]'
        _dir_stack=("${_dir_stack[@]}")
        return "$result"
    fi
}

alias cd=pushd
# }}}
