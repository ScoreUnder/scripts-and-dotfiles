function dmn { ( "$@" & ) < /dev/null >& /dev/null; }
makepkg() {
    ionice -n 7 makepkg "$@"
}

_print_shlvl_chevrons() {
    [ "${SHLVL:-0}" -le 1 ] && return
    local i
    for ((i=1; i < $SHLVL; i++)) {
        echo -n '>'
    }
    echo ' '
}

function prompt_customgrml_precmd() {
    emulate -L zsh
    local grmltheme=customgrml
    local -a left_items right_items

    left_items=(subsh rc change-root user at host path percent) # vcs
    right_items=(sad-smiley)

    prompt_grml_precmd_worker
}

host_color() {
    case ${HOSTNAME=$(hostname)} in
        konpaku)  echo 95;;
        kirisame) echo 93;;
        *)        echo 94;;
    esac
}

function prompt_customgrml_setup() {
    zstyle - ":prompt:customgrml:left:items:subsh" token "$(_print_shlvl_chevrons)"
    zstyle - ":prompt:customgrml:left:items:host" pre "$(printf "%%{\x1b[$(host_color)m%%}")"
    zstyle - ":prompt:customgrml:left:items:path" pre "%B%F{white}"

    grml_prompt_setup customgrml
}

# {{{ Bindkey setup
# Home/end for mosh
bindkey "\e[7~" beginning-of-line
bindkey "\e[8~" end-of-line
# }}}

prompt_themes+=(customgrml)
prompt customgrml

READNULLCMD=less

stty -ixon

. ~/.environment
umask 077
