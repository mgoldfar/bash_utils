# Strips control sequences from the given string.
# Note this is not a comprehensive function its mainly here to strip colors.
function _strip_control_sequence {
    if (( IS_MACOSX == 1 )); then
        # Mac OSX has the BSD version of sed, requires -E to enable "modern" regex.
        echo "$@" | sed -E $'s/\e\[[0-9][0-9]?[0-9]?m//g'
    else
        echo "$@" | sed $'s/\e\[[0-9][0-9]\\?[0-9]\\?m//g'
    fi
}
