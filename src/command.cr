module Quark
  # command for cli
  module Command
    # run command
    def self.run(command, args)
      case command
      # run quark
      when "run"
        run_quark(args)

      # run shell hook
      when "hook"
        run_hook(args)

      # add location
      when "add"
        add_location

      # list locations
      when "list"
        list_locations

      else
        error "command `#{command}` does not exist"
      end
    end
  end
end
