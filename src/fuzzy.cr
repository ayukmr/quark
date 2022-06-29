module Quark
  # fuzzy searching
  class Fuzzy
    # fuzzy find locations
    def self.fuzz_locations(input, rs)
      locations = [] of Quark::Location

      rs.each do
        location =
          Quark::Location.new(
            rs.read(String),
            rs.read(Int32),
            rs.read(String)
          )

        # assemble regex
        escaped = Regex.escape(input)
        regex = Regex.new(escaped.split("").join(".*"), Regex::Options::IGNORE_CASE)

        # add to locations
        locations.push(location) if File.basename(location.path).match(regex)
      end

      locations
    end
  end
end
