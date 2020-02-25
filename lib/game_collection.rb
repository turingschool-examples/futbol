require 'csv'
require_relative './game'

class GameCollection
  attr_reader :games
  def initialize(game_data)
    @games = create_games(game_data)
  end

  def create_games(game_data)
    game_data.map do |row|
      Game.new(row.to_h)
    end
  end

  def highest_total_score
    games.map do |game|
      game.home_goals + game.away_goals
    end.max
  end

  def lowest_total_score
    games.map do |game|
      game.home_goals + game.away_goals
    end.min
  end
end
