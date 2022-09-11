module Quark
  module Command
    # add location
    def self.add_location
      return if Dir.current == Path.home

      db = DB.connect("sqlite3://#{File.expand_path("~/.quark.db", home: true)}")
      ensure_table(db)

      set = db.query("SELECT path FROM locations WHERE path = ?", Dir.current)

      if !set.move_next
        # create location
        db.exec("INSERT INTO locations (path) VALUES (?)", Dir.current)
      else
        # increment times for location
        db.exec <<-SQL, Dir.current
          UPDATE locations
          SET times = times + 1, last = CURRENT_TIMESTAMP
          WHERE path = ?
        SQL
      end
    end
  end
end
