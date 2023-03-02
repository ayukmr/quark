module Quark
  # quark cli
  class CLI
    # run cli with argv
    def self.run(argv)
      command = argv[0]?

      # help command
      help if command == "help" || !command

      command, *args = argv
      Quark::Command.run(command, args)
    end

    # show help and exit
    def self.help
      puts <<-HELP
      #{"Usage".magenta.bold}:
        #{"quark".cyan} #{"<command>".yellow}

      #{"Commands".magenta.bold}:
        #{"run".cyan}  #{"<text>".yellow}   fuzz locations for text
        #{"hook".cyan} #{"<shell>".yellow}  get hook for shell
        #{"add".cyan}           add location to database
        #{"list".cyan}          list all locations
        #{"clean".cyan}         clean locations in database
        #{"help".cyan}          show this message
      HELP

      exit 0
    end
  end
end
