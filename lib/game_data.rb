require 'CSV'
require 'pry'
require_relative './game'

class GameData
  def initialize(locations, stat_tracker)
    @all_game_data = []
    @stat_tracker = stat_tracker

    CSV.foreach(locations, headers: true, header_converters: :symbol) do |row|
      @all_game_data << Game.new(row, self)
    end
  end

  def highest_total_score_in_game
    @all_game_data.max_by do |game|
      game.total_goals
    end.total_goals
  end

  def lowest_total_score_in_game
    @all_game_data.min_by do |game|
      game.total_goals
    end.total_goals
  end

  def home_wins_array
    @all_game_data.find_all do |game|
      game.winner == :home
    end
  end

  def percentage_home_wins
    ((home_wins_array.count).to_f / (@all_game_data.count)).round(2)
  end

  def visitor_wins_array
    @all_game_data.find_all do |game|
      game.winner == :visitor
    end
  end

  def percentage_visitor_wins
    ((visitor_wins_array.count).to_f / (@all_game_data.count)).round(2)
  end

  def game_tie_array
    @all_game_data.find_all do |game|
      game.winner == :tie
    end
  end

  def percentage_ties
    ((game_tie_array.count).to_f / (@all_game_data.count)).round(2)
  end

  def make_game_ids_by_season_hash
    by_season = {}
    @all_game_data.each do |game|
      by_season[game.season.to_i] = []
    end

    @all_game_data.each do |game|
      by_season[game.season.to_i] << game.game_id
    end
      by_season
  end

  def count_of_games_by_season
    by_season = make_game_ids_by_season_hash
    by_season.each { |key, value| by_season[key] = value.count }
  end
end
