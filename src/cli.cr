module Quark
  # cli for quark
  class Cli
    # run cli with argv
    def self.run(argv)
      command = argv[0]?

      # help command
      help if command == "help" || command.nil?

      command, *args = argv
      Quark::Command.run(command, args)
    end

    # show help and exit
    def self.help
      puts <<-HELP
      #{"Usage".magenta.bold}:
        #{"quark".cyan} #{"<COMMAND>".yellow}

      #{"Commands".magenta.bold}:
        #{"run".cyan}  #{"<TEXT>".yellow}   fuzz locations for text
        #{"hook".cyan} #{"<SHELL>".yellow}  get hook for shell
        #{"hook".cyan}          hook to add location
        #{"list".cyan}          list all locations
      HELP

      exit 0
    end
  end
end
