optimize_result() {
    f=$1; size=$2; newsize=$3
    if [ "$newsize" = 0 ]; then
        printf '%s: Optimization failed\n' "$f"
        false
    elif [ "$size" -gt "$newsize" ]; then
        printf '%s: %d → %d bytes (%s%% saved)\n' "$f" "$size" "$newsize" "$(printf 'scale=1;100*(%s-%s)/%s\n' "$size" "$newsize" "$size"|bc)"
        true
    elif [ "$size" = "$newsize" ]; then
        printf '%s: No change in size\n' "$f"
        true
    else
        printf '%s: Cannot optimize (%s < %s)\n' "$f" "$size" "$newsize"
        false
    fi
}

# Changes traps. Use only as the last function in the script or as a subshell.
# Usage: optimize_with_func optimize "$@"
# where optimize is a shell function taking 2 parameters (original file, file to write to)
optimize_with_func() {
    tmpfile=
    cleanup() { ret=$?; rm -f -- "$tmpfile"; exit "$ret"; }
    trap cleanup EXIT HUP INT TERM
    tmpfile=$(mktemp)

    optimize=$1; shift
    for f do
        size=$(stat -c%s -- "$f") || continue
        "$optimize" "$f" "$tmpfile" &&
            newsize=$(stat -c%s -- "$tmpfile") ||
            newsize=0
        optimize_result "$f" "$size" "$newsize" &&
            cp -- "$tmpfile" "$f"
    done
}
