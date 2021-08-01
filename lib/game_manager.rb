require 'CSV'
require_relative './game'

class GameManager
  attr_reader :games

  def initialize(file_path)
    @file_path = file_path
    @games = {}
    load
  end

  def load
    data = CSV.read(@file_path, headers: true)
    data.each do |row|
      @games[row["game_id"]] = Game.new(row)
    end
  end

  def highest_total_score
    max = 0
    @games.each do |game_id, game|
      current = game.away_goals.to_i + game.home_goals.to_i
      max = current if current > max
    end
    max
  end

  def lowest_total_score
    min = 100000
    @games.each do |game_id, game|
      current = game.away_goals.to_i + game.home_goals.to_i
      min = current if current < min
    end
    min
  end

  def percentage_home_wins
    home_wins = 0
    @games.each do |game_id, game|
      if game.away_goals.to_i < game.home_goals.to_i
        home_wins += 1
      end
    end
    (home_wins / @games.length.to_f).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = 0
    @games.each do |game_id, game|
      if game.away_goals.to_i > game.home_goals.to_i
        visitor_wins += 1
      end
    end
    (visitor_wins / @games.length.to_f).round(2)
  end

  def percentage_ties
    ties = 0
    @games.each do |game_id, game|
      if game.away_goals.to_i == game.home_goals.to_i
        ties += 1
      end
    end
    (ties / @games.length.to_f).round(2)
  end

  def count_of_games_by_season
    season_data = {}
    @games.each do |game_id, game|
      if season_data.include?(game.season)
        season_data[game.season] += 1
      else
        season_data[game.season] = 1
      end
    end
    season_data
  end

  def average_goals_per_game
    goals = 0
    @games.each do |game_id, game|
      goals += (game.away_goals.to_i + game.home_goals.to_i)
    end
    (goals / @games.length.to_f).round(2)
  end

  def average_goals_per_season
    season_data = {}
    total_games = "games"
    total_goals = "goals"
    @games.each do |game_id, game|
      if season_data.include?(game.season)
        season_data[game.season][total_games] += 1
        season_data[game.season][total_goals] += (game.away_goals.to_i + game.home_goals.to_i)
      else
        season_data[game.season] = {
          total_games => 1,
          total_goals => (game.away_goals.to_i + game.home_goals.to_i)
        }
      end
    end
    result = {}
    season_data.each do |season, data|
      result[season] = (data["goals"] / data["games"].to_f).round(2)
    end
    result
  end

  def seasons
    @games.map do |game_id, game|
      game.season
    end.uniq
  end
end
