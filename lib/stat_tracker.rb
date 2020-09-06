class StatTracker

  attr_reader :from_csv

  class << self
    self # => #<Class:StatTracker>

    def from_csv(locations)
      StatTracker.new(locations[:games])
      StatTracker.new(locations[:teams])
      StatTracker.new(locations[:game_teams])
    end
  end
end
