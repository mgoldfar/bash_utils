
function toolcheck {
    if ! command -v $1 2>&1 >/dev/null; then
        export HAVE_$1=0
    else
        export HAVE_$1=1
    fi
}

toolcheck git
toolcheck python
toolcheck ipython
