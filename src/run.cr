module Quark
  # run functions
  class Run
    # get location using text
    def self.get_path(text)
      if text
        db = DB.connect("sqlite3://#{File.expand_path("~/.quark.db", home: true)}")
        ensure_table(db)

        location = Quark::Fuzzy.fuzz_locations(
          text, db.query("SELECT * FROM locations")
        ).max?

        # check if location is valid
        if location && !Dir.exists?(location.path)
          db.exec("DELETE FROM locations WHERE path = ?", location.path)
          puts Dir.current

          return
        end

        if location
          # return location's path
          puts location.path
        elsif Dir.exists?(text)
          # return text if it is a valid path
          puts text
        else
          # default to current directory
          puts Dir.current
        end
      else
        help
      end
    end

    # show help and exit
    def self.help
      puts <<-HELP
      #{"Usage".magenta.bold}:
        #{"q".cyan} #{"<TEXT>".yellow}

      #{"Examples".magenta.bold}:
        #{"q".cyan} #{"foo".yellow}  fuzz dirs for `foo`
      HELP

      exit 0
    end
  end
end
