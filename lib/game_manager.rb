require 'CSV'
require 'pry'
require_relative './game'
require_relative './csv_parser'

class GameManager
  include CsvParser

  def initialize(file)
    @all_games = load_it_up(file, Game)
  end

  def highest_total_score
    @all_games.map do |game|
      game.total_score
    end.max
  end

  def lowest_total_score
    @all_games.min_by do |game|
      game.total_score
    end.total_score
  end

  def home_wins_array
    @all_games.find_all do |game|
      game.winner == :home
    end
  end

  def percentage_home_wins
    ((home_wins_array.count).to_f / (@all_games.count)).round(2)
  end

  def visitor_wins_array
    @all_games.find_all do |game|
      game.winner == :visitor
    end
  end

  def percentage_visitor_wins
    ((visitor_wins_array.count).to_f / (@all_games.count)).round(2)
  end

  def game_tie_array
    @all_games.find_all do |game|
      game.winner == :tie
    end
  end

  def percentage_ties
    ((game_tie_array.count).to_f / (@all_games.count)).round(2)
  end

  def make_game_ids_by_season_hash
    by_season = {}
    @all_games.each do |game|
      by_season[game.season.to_i] = []
    end

    @all_games.each do |game|
      by_season[game.season.to_i] << game.game_id
    end
      by_season
  end

  def count_of_games_by_season
    by_season = make_game_ids_by_season_hash
    by_season.each { |key, value| by_season[key] = value.count }
  end

  def average_goals_per_game
    @total_goals = @all_games.sum do |game|
      game.total_score
    end
    (@total_goals.to_f / @all_games.count).round(2)
  end

  def average_goals_in_a_season(season)
    per_season = 0
    count = 0
    @all_games.map do |game|
      if game.season == season
        per_season += game.total_score
        count += 1
      end
    end
    (per_season.to_f / count).round(2)
  end

  def average_goals_by_season
    avg_by_season = {}
    @all_games.each do |game|
      avg_by_season[game.season.to_s] = average_goals_in_a_season(game.season)
    end
    avg_by_season
  end
  
end
