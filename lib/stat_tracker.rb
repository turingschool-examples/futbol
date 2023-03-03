require 'csv'

class StatTracker 
  attr_reader :game, :league, :season

  def initialize(locations)
    @game = GameStatistics.new(locations)
    @league = LeagueStatistics.new(locations)
    @season = SeasonStatistics.new(locations)
  end
  
  def self.from_csv(locations)
    # Stats.new(locations)
    StatTracker.new(locations)
  end
end

