require 'CSV'
require 'pry'
require_relative './game'

class GameData
  def initialize(locations, stat_tracker)
    @all_game_data = []
    @stat_tracker = stat_tracker

    CSV.foreach(locations, headers: true, header_converters: :symbol) do |row|
      @all_game_data << Game.new(row)
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
end
