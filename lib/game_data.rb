require 'CSV'
require 'pry'
require './lib/game'

class GameData
  def initialize(data)
    @all_game_data = []

    CSV.foreach('./data/games.csv', headers: true, header_converters: :symbol) do |row|
      @all_game_data << Game.new(row)
    end
    # binding.pry
  end

  def get_goals_per_game
    @all_game_data.map do |game|
      (game.away_goals + game.home_goals)
    end
  end

  def highest_total_score
    get_goals_per_game.max
  end

  def lowest_total_score
    get_goals_per_game.min
  end

  # def get_home_wins
  #   home_wins = 0
  #   @all_game_data.each do |game|
  #     home_wins += 1 if game.home_goals > game.away_goals
  #   end
  #   home_wins
  # end

  # def percentage_home_wins
  #   (get_home_wins / @all_game_data.count).to_f
  # end
end
