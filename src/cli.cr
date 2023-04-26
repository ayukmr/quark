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
      #{"usage".magenta.bold}:
        #{"quark".blue} #{"<command>".yellow}

      #{"commands".magenta.bold}:
        #{"run".blue}  #{"<text>".yellow}   fuzz locations for text
        #{"hook".blue} #{"<shell>".yellow}  get hook for shell
        #{"add".blue}           add location to database
        #{"list".blue}          list all locations
        #{"clean".blue}         clean locations in database
        #{"help".blue}          show this message
      HELP

      exit 0
    end
  end
end
