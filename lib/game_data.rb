require 'CSV'
require 'pry'
require './lib/game'

class GameData
  def initialize(path, stat_tracker)
    @all_game_data = []
    @stat_tracker = stat_tracker

    CSV.foreach('./data/games.csv', headers: true, header_converters: :symbol) do |row|
      @all_game_data << Game.new(row)
    end
  end

  def get_goals_per_game
    @all_game_data.map do |game|
      (game.away_goals + game.home_goals)
    end
  end

  def game_with_highest_total_score
    @all_game_data.max_by do |game|
      game.total_goals
    end
  end

  def game_with_lowest_total_score
    @all_game_data.min_by do |game|
      game.total_goals
    end
  end

  def get_home_wins
    # home_wins = 0
    # @all_game_data.each do |game|
    #   home_wins += 1 if game.home_goals > game.away_goals
    # end
    # home_wins

    @all_game_data.find_all do |game|
      game.winner == :home
    end
  end

  def percentage_home_wins
    (get_home_wins.count / @all_game_data.count)
  end
end
