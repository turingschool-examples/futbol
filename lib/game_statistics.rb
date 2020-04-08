# require './lib/stat_tracker'
require './lib/statistics'
require 'pry'


class GameStatistics < Statistics
  attr_reader :stat_tracker

  def highest_total_score
    total = @csv_games.map do |row|
      row[:home_goals].to_i + row[:away_goals].to_i
    end
    total.max_by{|score| score}
  end

  def lowest_total_score
    total = @csv_games.map do |row|
      row[:home_goals].to_i + row[:away_goals].to_i
    end
    total.min_by{|score| score}
  end

  def percentage_home_wins
    home_games = @csv_game_teams.find_all do |game|
      game[:hoa] == "home"
    end
    won_home_games = home_games.find_all do |game|
      game[:result]  == "WIN"
    end
    (won_home_games.length.to_f / home_games.length) *100
  end

  def percentage_visitor_wins
    away_games = @csv_game_teams.find_all do |game|
      game[:hoa] == "away"
    end
    won_away_games = away_games.find_all do |game|
      game[:result]  == "WIN"
    end
    (won_away_games.length.to_f / away_games.length) *100
  end

end
