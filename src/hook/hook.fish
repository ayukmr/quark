# run quark-hook on pwd change
function _quark_hook --on-variable PWD
    quark hook
end

# add q command
function q
    if count $argv > /dev/null
        cd (quark run $argv)
    else
        quark run
    end
end
