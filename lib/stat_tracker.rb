require_relative './league_stats'
require_relative './stat_data'

class StatTracker < StatData
  attr_reader :games,
              :teams, 
              :game_teams
  
  def initialize(locations)
    super(locations)
    @league_stats = LeagueStats.new(locations)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def count_of_teams
    @teams.length
  end

  def best_offense
    @league_stats.best_offense
  end

  def worst_offense
    @league_stats.worst_offense
  end
  
  def highest_scoring_visitor
    @league_stats.highest_scoring_visitor
  end

  def highest_scoring_home_team
    @league_stats.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    @league_stats.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    @league_stats.lowest_scoring_home_team
  end
end
