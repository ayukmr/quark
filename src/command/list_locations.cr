module Quark
  module Command
    # list locations
    def self.list_locations
      db = DB.connect("sqlite3://#{File.expand_path("~/.quark.db", home: true)}")
      ensure_table(db)

      locations = [] of Quark::Location
      rs = db.query("SELECT * FROM locations")

      rs.each do
        location =
          Quark::Location.new(
            rs.read(String),
            rs.read(Int32),
            rs.read(String)
          )

        locations.push(location)
      end

      locations.sort!
      locations.reverse!

      path_length  = [locations.map { |location| tilde(location.path).size      }.max, 4].max
      times_length = [locations.map { |location| location.times.to_s.size       }.max, 5].max
      last_length  = [locations.map { |location| location.last.to_s.size        }.max, 4].max
      score_length = [locations.map { |location| location.score.trunc.to_s.size }.max, 5].max

      # draw header
      puts "┌#{"─" * (path_length + 2)}┬#{"─" * (times_length + 2)}┬#{"─" * (last_length + 2)}┬#{"─" * (score_length + 2)}┐"
      puts "│ #{"path".ljust(path_length).green.bold} │ #{"times".ljust(times_length).green.bold} │ #{"last".ljust(last_length).green.bold} │ #{"score".ljust(score_length).green.bold} │"
      puts "├#{"─" * (path_length + 2)}┼#{"─" * (times_length + 2)}┼#{"─" * (last_length + 2)}┼#{"─" * (score_length + 2)}┤"

      locations.each do |location|
        path  = tilde(location.path)
        times = location.times.to_s
        last  = location.last.to_s
        score = location.score.trunc.to_s

        # draw table cells
        puts \
          "│ #{path.ljust(path_length).blue} " \
          "│ #{times.ljust(times_length).magenta} " \
          "│ #{last.ljust(last_length).cyan} " \
          "│ #{score.ljust(score_length).yellow} │"
      end

      # draw bottom
      puts "└#{"─" * (path_length + 2)}┴#{"─" * (times_length + 2)}┴#{"─" * (last_length + 2)}┴#{"─" * (score_length + 2)}┘"
    end
  end
end
