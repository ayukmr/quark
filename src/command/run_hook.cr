module Quark
  module Command
    # run quark hook
    def self.run_hook(args)
      hooks = {
        "bash" => <<-BASH,
        # run hook on pwd change
        function _quark_hook {
            [[ "$PREVPWD" != "$PWD" ]] && quark add
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
        BASH

        "zsh" => <<-ZSH,
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
        ZSH

        "fish" => <<-FISH,
        # run hook on pwd change
        function _quark_hook --on-variable PWD
            quark add
        end

        # add q command
        function q
            if count $argv > /dev/null
                cd (quark run $argv)
            else
                quark run
            end
        end
        FISH
      }

      shell = args[0]?
      hook = hooks[shell]?

      if hook
        # print hook
        puts hook
      else
        error "hook for `#{shell}` does not exist", 1
      end
    end
  end
end
