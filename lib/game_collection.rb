require 'csv'
require_relative './game'

class GameCollection
  attr_reader :games
  def initialize(game_data)
    @games = create_games(game_data)
  end

  def create_games(game_data)
    game_data.map do |row|
      Game.new(row.to_h)
    end
  end

  def highest_total_score
    games.map do |game|
      game.home_goals + game.away_goals
    end.max
  end

  def lowest_total_score
    games.map do |game|
      game.home_goals + game.away_goals
    end.min
  end

  def biggest_blowout
    games.map do |game|
      Math.sqrt((game.home_goals - game.away_goals)**2).to_i
    end.max
  end

  def percentage_home_wins
    home_wins = games.find_all do |game|
      game.home_goals > game.away_goals
    end
    (home_wins.length.to_f / games.length).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = games.find_all do |game|
      game.away_goals > game.home_goals
    end
    (visitor_wins.length.to_f / games.length).round(2)
  end

  def percentage_ties
    ties = games.find_all do |game|
      game.home_goals == game.away_goals
    end.length
    (ties / games.length.to_f).round(2)
  end

  def count_of_games_by_season
    games_per_season = Hash.new(0)
      games.each do |game|
      games_per_season[game.season] += 1
    end
    games_per_season
  end

  def average_goals_per_game
    total_goals_per_game = games.map do |game|
      game.home_goals + game.away_goals
    end
    (total_goals_per_game.sum.to_f / games.length).round(2)
  end

  def average_goals_by_season
    games_grouped_by_season = games.group_by do |game|
      game.season
    end
    games_grouped_by_season.each_pair do |season, games_by_season|
      total_goals = games_by_season.map do |single_game|
        single_game.home_goals + single_game.away_goals
      end
    average = (total_goals.sum.to_f / total_goals.length).round(2)
    games_grouped_by_season[season] = average
    end
  end
end
