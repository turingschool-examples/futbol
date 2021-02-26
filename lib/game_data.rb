require 'CSV'
require 'pry'
require './lib/game'

class GameData
  def initialize(locations, stat_tracker)
    @all_game_data = []
    @stat_tracker = stat_tracker

    CSV.foreach(locations, headers: true, header_converters: :symbol) do |row|
      @all_game_data << Game.new(row)
    end
  end

  def game_with_highest_total_score
    @all_game_data.max_by do |game|
      game.total_goals
    end.total_goals
  end

  def game_with_lowest_total_score
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
    (home_wins_array.count / @all_game_data.count) * 100
  end
end
