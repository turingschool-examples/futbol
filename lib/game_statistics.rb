require 'csv'
require './lib/game_stat_module'
require './lib/game_statistics'
# require_relative '/spec_helper'

class GameStatistics 
  include GameStatsable

  def initialize
    @games_data = CSV.read './data/mock_games.csv', headers: true, header_converters: :symbol
    @game_teams_data = CSV.read './data/mock_game_teams.csv', headers: true, header_converters: :symbol
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