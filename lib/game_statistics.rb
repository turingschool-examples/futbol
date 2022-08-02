require 'csv'
require_relative 'game_stat_module'

class GameStatistics 
  include GameStatsable

  def initialize(games_data, game_teams_data)
    @games_data = games_data
    @game_teams_data = game_teams_data
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  # Game statistics 
  def highest_total_score
    goals_scored.max
  end

  def lowest_total_score
    goals_scored.min
  end

  def percentage_home_wins
    percentage_wins_for_team_playing('home')
  end

  def percentage_visitor_wins
    percentage_wins_for_team_playing('away')
  end

  def percentage_ties
    ties_percentage
  end

  def count_of_games_by_season    
    season_game_count
  end

  def average_goals_per_game
    ave_goals_a_game
  end

  def average_goals_by_season
    ave_goals_a_season
  end
end 