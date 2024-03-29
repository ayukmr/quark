module Quark
  module Command
    # clean locations
    def self.clean_locations
      db = db_connect
      ensure_table(db)

      db.query("SELECT * FROM locations") do |rows|
        rows.each do
          path = rows.read(String)

          # remove location if invalid
          if !Dir.exists?(path)
            db.exec("DELETE FROM locations WHERE path = ?", path)
            puts "#{"removing".red.bold} `#{path.tilde}`"
          end
        end
      end

      puts "#{"cleaned locations".magenta.bold}"
    end
  end
end
