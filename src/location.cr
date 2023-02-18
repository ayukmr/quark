module Quark
  # location from sql
  class Location
    @path  : String
    @times : Int32
    @last  : Time
    @score : Float64

    # create location
    def initialize(path, times, last)
      @path  = path
      @times = times
      @last  = Time.parse(last, "%F %T", Time::Location::UTC)
      @score = (Math.log(@times * 10) * 1.5 - (Math.log((Time.utc - @last) / 3600) / 2)).abs
    end

    # compare with other locations
    def <=>(other)
      score <=> other.score
    end

    # class variables
    def path;  @path  end
    def times; @times end
    def last;  @last  end
    def score; @score end
  end
end
