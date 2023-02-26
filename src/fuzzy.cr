module Quark
  # fuzzy searching
  class Fuzzy
    # fuzzy find locations
    def self.fuzz_locations(input, rows)
      locations = [] of Quark::Location

      rows.each do
        location =
          Quark::Location.new(
            rows.read(String),
            rows.read(Int32),
            rows.read(String)
          )

        # assemble regex
        escaped = Regex.escape(input)
        regex   = Regex.new(escaped.split("").join(".*"), Regex::Options::IGNORE_CASE)

        # add to locations
        locations.push(location) if File.basename(location.path).match(regex)
      end

      locations
    end
  end
end
