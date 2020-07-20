require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'
require_relative 'stats'
require_relative 'game_stats'

class StatTracker
  attr_reader :game_stats
              # :team_stats,
              # :league_stats,
              # :season_stats

  def self.from_csv(data)
    StatTracker.new(data)
  end

  def initialize(data)
    @game_stats   = GameStats.new(data)
    # @team_stats   = TeamStats.new(data)
    # @league_stats = LeagueStats.new(data)
    # @season_stats = SeasonStats.new(data)
  end

# game stats

  def highest_total_score
    @game_stats.highest_total_score
  end

  def lowest_total_score
    @game_stats.lowest_total_score
  end

  def percentage_home_wins
    @game_stats.percentage_home_wins
  end

  def percentage_visitor_wins
    @game_stats.percentage_visitor_wins
  end

  def percentage_ties
    @game_stats.percentage_ties
  end

  def count_of_games_by_season
    @game_stats.count_of_games_by_season
  end

  def average_goals_per_game
    @game_stats.average_goals_per_game
  end

  def average_goals_by_season
    @game_stats.average_goals_by_season
  end
#league stats
  def best_offense
    @game_stats.best_offense
  end

  def worst_offense
    @game_stats.worst_offense
  end
#team stats

#season stats


end
