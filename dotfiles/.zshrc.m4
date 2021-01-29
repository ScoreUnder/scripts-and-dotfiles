. ~/.environment
function dmn { ( "$@" & ) < /dev/null >& /dev/null; }
makepkg() {
    ionice -n 7 makepkg "$@"
}

# {{{ Prompt setup
_print_shlvl_chevrons() {
    if ((SHLVL <= 1)) return
    local i="$(printf '%*s' "$((SHLVL-1))" '')"
    echo "${i// />} "
}

prompt_customgrml_precmd() {
    emulate -L zsh
    local grmltheme=customgrml
    local -a left_items right_items

    left_items=(subsh rc change-root user at host path vcs percent)
    right_items=(sad-smiley)

    prompt_grml_precmd_worker
}

prompt_customgrml_setup() {
    zstyle - ":prompt:customgrml:left:items:subsh" token "$(_print_shlvl_chevrons)"
    zstyle - ":prompt:customgrml:left:items:host" pre "$(printf "%%{\x1b[HOST_COLOR()m%%}")"
    zstyle - ":prompt:customgrml:left:items:path" pre "%B%F{white}"

    grml_prompt_setup customgrml
}

prompt_themes+=(customgrml)
command -v prompt >/dev/null && prompt customgrml
# }}}

# {{{ Bindkey setup
# Home/end for mosh
bindkey "\e[7~" beginning-of-line
bindkey "\e[8~" end-of-line
# }}}

# {{{ Bugfixes
# Fix multiline command visual duplication in rxvt
set_title() {
    printf '\033]0;%s\007' "${*//$'\n'/ }"
}
# }}}

READNULLCMD=less

stty -ixon

umask 077
