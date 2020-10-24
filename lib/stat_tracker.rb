class StatTracker
  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    @league_statistics = LeagueStatistics.new(locations[:games], locations[:teams])
  end
end
