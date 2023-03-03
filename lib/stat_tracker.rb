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

  def percentage_home_wins
    @game.percentage_home_wins
  end

  def percentage_visitor_wins
    @game.percentage_visitor_wins
  end

  def percentage_ties
    @game.percentage_ties
  end
end

