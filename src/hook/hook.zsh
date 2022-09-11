autoload -Uz add-zsh-hook

# run quark-hook on chpwd
function _quark_hook {
    quark add
}
add-zsh-hook chpwd _quark_hook

# add q command
function q {
    if [[ $# == 0 ]]; then
        quark run
    else
        cd $(quark run $@)
    fi
}
