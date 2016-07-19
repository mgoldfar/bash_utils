# TODO: This will not work with links
_src_dir=$(dirname ${BASH_SOURCE[0]})/bashenv

_uname=$(uname -s)
export IS_MACOSX=0
export IS_LINUX=0
if [[ $_uname = "Darwin" ]]; then
    export IS_MACOSX=1
elif [[ $_uname = "Linux" ]]; then
    export IS_LINUX=1
else
    echo "Unsupported system: ${_uname} -- bash environment will not be loaded."
    return
fi

source "${_src_dir}/util.sh"
source "${_src_dir}/colors.sh"
source "${_src_dir}/toolcheck.sh"
source "${_src_dir}/prompt.sh"
source "${_src_dir}/aliases.sh"

# On MacOS X remap erase key to ^H to get consisten
# delete key behavior in emacs
if (( IS_MACOSX == 1 )); then
    stty erase ^H
fi
