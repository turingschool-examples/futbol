require 'csv'
require 'simplecov'
require './lib/stat_tracker'

SimpleCov.start

class GameStats
  attr_reader :game_data
  def initialize(game_data)
    #@game_data = CSV.read("./data/sample_games.csv")
  end

  def highest_total_score
    @game_data = CSV.parse(File.read("./data/sample_games.csv"), headers: true)
    max_score = 0
    @game_data.each do |game|
      sum = game["away_goals"].to_i + game["home_goals"].to_i
      if sum > max_score
        max_score = sum
      end
    end
    max_score
  end

  def lowest_total_score
    @game_data = CSV.parse(File.read("./data/sample_games.csv"), headers: true)
    low_score = 100
    @game_data.each do |game|
      sum = game["away_goals"].to_i + game["home_goals"].to_i
      if sum < low_score
        low_score = sum
      end
    end
    low_score
  end

  def percentage_home_wins
    @game_data = CSV.parse(File.read("./data/sample_games.csv"), headers: true)
    home_wins = 0
    total_game = 0
    @game_data.each do |game|
      total_game += 1
      if game["home_goals"] > game["away_goals"]
        home_wins += 1
      else
      end
    end
    x = (home_wins.to_f / total_game.to_f)
    (x * 100.0).round(2)
  end

  def percentage_away_wins
    @game_data = CSV.parse(File.read("./data/sample_games.csv"), headers: true)
    away_wins = 0
    total_game = 0
    @game_data.each do |game|
      total_game += 1
      if game["away_goals"] > game["home_goals"]
        away_wins += 1
      else
      end
    end
    x = (away_wins.to_f / total_game.to_f)
    (x * 100.0).round(2)
  end

  def percentage_ties
    @game_data = CSV.parse(File.read("./data/sample_games.csv"), headers: true)
    total_game = 0
    total_ties = 0
    @game_data.each do |game|
      total_game += 1
      if game["home_goals"] == game["away_goals"]
        total_ties += 1
      else
      end
    end
    x = (total_ties.to_f / total_game.to_f)
    (x * 100.0).round(2)
  end
  
end
