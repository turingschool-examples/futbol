require 'CSV'
require 'pry'
require_relative './game'
require_relative './csv_parser'

class GameManager
  include CsvParser

  def initialize(locations)
    @all_games = load_it_up(locations, Game)
  end

  def highest_total_score_in_game
    @all_games.max_by do |game|
      game.total_goals
    end
  end

  def lowest_total_score_in_game
    @all_games.min_by do |game|
      game.total_goals
    end.total_goals
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
end
