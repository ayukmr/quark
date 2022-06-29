module Quark
  # quark hook
  class Hook
    # run quark hook
    def self.run(item)
      # check if hook exists
      has_hook =
        Dir[File.expand_path(File.join("hook", "*"), __DIR__)]
          .map { |file| File.basename(file) }
          .includes?("hook.#{item}")

      if item.nil?
        run_hook
      elsif has_hook
        # get hook
        puts File.read(File.expand_path(
          File.join("hook", "hook.#{item}"), __DIR__
        ))
      else
        error("hook for `#{item}` does not exist", 1)
      end
    end

    # run hook
    def self.run_hook
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
