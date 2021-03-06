# Generate aliases for ..1, ..2, ..3 etc
_back=".."
for (( i = 1; i < 64; i++ )); do
	alias "..${i}"="cd ${_back}"
	_back="../${_back}"
done

# ls and ll
if (( ${IS_LINUX} == 1 )); then
	alias ls='ls --color'
elif (( ${IS_MACOSX} == 1 )); then
	alias ls='ls -G'
fi
alias ll='ls -alh'

# grep
alias grep='grep --color'
alias egrep='egrep --color'

# IPython to load numpy and matplotlib
if (( HAVE_ipython == 1 )); then
    _launch_ipython() {
        # Default is to launch console with --pylab
        # but if other commands are given just take them
        # directly to avoid conflicting options
        if (( $# >= 1 )); then
            ipython $@
        else
            ipython --pylab
        fi
    }
    alias ipython=_launch_ipython
fi
