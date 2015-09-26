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
    local cpu_util=$(ps -eo "%cpu" | awk '{s+=$0} END { printf "%d", s }')
    
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
    if (( _is_macosx == 1 )); then
        local total_hw_mem_bytes=$(sysctl hw.memsize | cut -d' ' -f2)
        local page_size=$(sysctl vm.pagesize | cut -d' ' -f2)
        local total_hw_pages=$((total_hw_mem_bytes / page_size))
        local num_page_free=$(sysctl vm.page_free_count | cut -d' ' -f2)
        local num_page_purgable=$(sysctl vm.page_purgeable_count | cut -d' ' -f2)
        local num_page_reusable=$(sysctl vm.page_reusable_count | cut -d' ' -f2)
        mem_util=$(( (num_page_free+num_page_purgable+num_page_reusable)*100/total_hw_pages))

    elif (( _is_linux == 1 )); then
	local awksrc='/total\smemory/ {tot=$1} /free\smemory/{free=$1} '
	awksrc=$awksrc'END {p=free/tot; printf "%d", 100*p; }'
	mem_util=$(vmstat -s | awk "$awksrc" )
    fi

    local color=""
    if [[ $mem_util != "?" ]]; then
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
    export PS1="[\\t] $BLU\\u@\h$NORM C:$cpu_util M:$mem_util \\w\\n\\$ "
}
export PROMPT_COMMAND=_prompt
