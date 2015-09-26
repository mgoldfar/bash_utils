# TODO: This will not work with links
_src_dir=$(dirname ${BASH_SOURCE[0]})

source "${_src_dir}/colors.sh"

_uname=$(uname -s)
_is_macosx=0
_is_linux=0
if [[ $_uname = "Darwin" ]]; then
    _is_macosx=1
elif [[ $_uname = "Linux" ]]; then
    _is_linux=1
fi

function _cpu_utilization {
    local cpu_util=$(ps -eo "%C" | awk '{s+=$0} END { printf "%d", s }')
    
    local color=""
    if (( $cpu_util > 75 )); then
	color=$BLD$RED
    elif (( $cpu_util > 50 )); then
	color=$LRED
    elif (( $cpu_util > 25 )); then
	color=$YLW
    else
	color=$GRN
    fi

    echo -e "${color}${cpu_util}%${NORM}"
}

function _mem_utilization {
    local mem_util="?"
    if (( _is_maxosx == 1 )); then
       echo ""
    elif (( _is_linux == 1 )); then
	local awksrc='/total\smemory/ {tot=$1} /free\smemory/{free=$1} '
	awksrc=$awksrc'END {p=free/tot; printf "%d", 100*p; }'

	mem_util=$(vmstat -s | awk "$awksrc" )
    fi

    local color=""
    if [[ $mem_util!="?" ]]; then
	if (( $mem_util > 75 )); then
	    color=$GRN
	elif (( $mem_util > 50 )); then
	    color=$YLW
	elif (( $mem_util > 25 )); then
	    color=$LRED
	else
	    color=$BOLD$RED
	fi
    fi
    
    echo -e "${color}${mem_util}%${NORM}"
}

function _prompt {
    local cpu_util=$(_cpu_utilization)
    local mem_util=$(_mem_utilization)
    export PS1="$BOLD\\t|$BLU\\u$NORM C:$cpu_util M:$mem_util \\w\\n\\$ "
}
export PROMPT_COMMAND=_prompt


