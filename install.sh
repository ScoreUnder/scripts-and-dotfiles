#!/bin/sh
my_tempdir=  # Generated later

if echo test | read -s -n1 testvar 2>/dev/null; then
    sread() { read -s -n1 "$@"; }
else
    sread() { read "$@"; }
fi

_colour_diff_fallback() {
    colour_red=$(printf '\033[31m')
    colour_green=$(printf '\033[32m')
    colour_reset=$(printf '\033[0m')
    sed "s/^-/${colour_red}-/;s/^\+/${colour_green}+/;s/$/${colour_reset}/"
}

_colour_diff() {
    if command -v delta >/dev/null; then
        delta --paging never
    elif command -v colordiff >/dev/null; then
        colordiff
    else
        _colour_diff_fallback
    fi
}

_install() {
    install -pvTDm "$3" -- "$1" "$2"
}

_copy_to_git() {
    install -pTm "$3" -- "$2" "$1"
}

render_m4() { ./render-m4 "$1" >"$2"; }

print_hr() {
    eval "$(resize 2>/dev/null)"
    printf '━%.0s' $(seq "${COLUMNS:-80}")
    printf \\n
}

get_mode() {
    stat -c%a "$1"
}

get_and_compare_mode() {
    path=$1
    desired_mode=$2

    actual_mode=$(get_mode "$path")
    printf %s\\n "$actual_mode"
    [ "$actual_mode" = "$desired_mode" ]
}

replace_right_file() {
    display_path=$1
    awk -v path="$display_path" '
        BEGIN { go = 1 }
        go && /^\+\+\+ / { $0 = "+++ " path; go = 0 }
        { print }
    '
}

safecopy() {
    local operation answer path dest_path display_path orig_path readonly
    path=$1 dest_path=$2 readonly=false

    display_path=$path

    [ "${path%.inc.m4}" != "$path" ] && return  # Don't copy .inc.m4 files

    desired_mode=$(get_mode "$path")

    # If the path ends in .m4, render it first
    if [ "${path%.m4}" != "$path" ]; then
        display_path=${display_path%.m4}  # Hide the .m4 from the user :^)
        dest_path=${dest_path%.m4}        # Install without .m4 too
        orig_path=$path
        path=$my_tempdir/m4_out  # Why not just mktemp? Because it would be more of a pain to clean up.
        readonly=true            # Can't copy this back to git after it's rendered
        if ! render_m4 "$orig_path" "$path"; then
            printf >&2 'Failed to render %s\n'
            return 1
        fi
    fi

    operation=_install
    if [ -r "$dest_path" ]; then
        if ! diff=$(diff -U5 -- "$dest_path" "$path") \
                || ! actual_mode=$(get_and_compare_mode "$dest_path" "$desired_mode"); then
            print_hr
            if [ -n "$diff" ]; then
                printf %s\\n "$diff" | replace_right_file "$display_path" | _colour_diff
            else
                printf 'Permissions differ for %s: %s -> %s\n' "$display_path" "$actual_mode" "$desired_mode"
            fi

            printf 'You have a different version of %s - if you install, the above changes will be applied.\n' "$display_path"

            answer=
            while :; do case $answer in
                [iI]) operation=_install; break;;
                [gG])
                    if $readonly; then
                        answer=  # Forget we said anything and prompt again
                    else
                        operation=_copy_to_git
                        break
                    fi
                    ;;
                [vV]) operation=vimdiff; break;;
                [sS]) return 0;;
                [qQ]) exit 0;;
                *)
                    if $readonly; then
                        echo "What should I do? (I)nstall, (V)imdiff, (S)kip, (Q)uit"
                    else
                        echo "What should I do? (I)nstall, Update in (G)it repo, (V)imdiff, (S)kip, (Q)uit"
                    fi
                    sread answer
                    ;;
            esac; done
        else
            return 0
        fi
    fi
    "$operation" "$path" "$dest_path" "$desired_mode"
}

recurse() {
    local file
    for file in "$2"/* "$2"/.*; do
        case "$(basename "$file")" in
            # Handle globbed ./..
            .|..) continue;;
            # Handle failed globs (blah/* where * doesn't exist)
            *) [ -e "$file" ] || continue;;
        esac

        if [ -d "$file" ]; then
            recurse "$1" "$file"
        elif [ -f "$file" ]; then
            "$1" "$file"
        fi
    done
    true
}

# Ensure we are in the script's directory
[ "$0" = "${0%/*}" ] || cd -- "${0%/*}"

# Set cleanup traps and then create a temporary working area
cleanup() { rm -rf -- "${my_tempdir:?}"; }
trap cleanup EXIT
trap 'exit 1' INT HUP TERM PIPE  # dash doesn't call EXIT traps on interrupt etc.
my_tempdir=$(mktemp -d) || exit

# Start copying scripts and dotfiles over
_copy_loop() { safecopy "$1" "$HOME/$1"; }
recurse _copy_loop bin

_dotfiles_copy_loop() { safecopy "$1" "$HOME/${1#*/}"; }
recurse _dotfiles_copy_loop dotfiles

echo 'As always, make sure you have pulled submodules!'
# Install pomfclip
cd pomfclip && ./install.sh
