require 'CSV'
require 'pry'
require_relative './game'

class GameManager
  def initialize(locations, stat_tracker)
    @all_games = []
    @stat_tracker = stat_tracker

    CSV.foreach(locations, headers: true, header_converters: :symbol) do |row|
      @all_games << Game.new(row)
    end
  end

  def highest_total_score_in_game
    @all_games.max_by do |game|
      game.total_goals
    end.total_goals
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
