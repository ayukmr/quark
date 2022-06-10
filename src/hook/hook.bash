# run quark-hook on pwd change
function _quark_hook {
    [[ "$PREVPWD" != "$PWD" ]] && quark hook
    export PREVPWD="$PWD"
}

# run _quark_hook on prompt
PROMPT_COMMAND="_quark_hook${PROMPT_COMMAND:+;$PROMPT_COMMAND}"

# add q command
function q {
    if [[ $# == 0 ]]; then
        quark run
    else
        cd $(quark run $@)
    fi
}
