module Quark
  # command for cli
  module Command
    # run command
    def self.run(command, args)
      # commands and methods
      case command
      when "run"
        run_quark(args)

      when "hook"
        run_hook(args)

      when "list"
        list_locations

      else
        error("command `#{command}` does not exist")
      end
    end
  end
end
