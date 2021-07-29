require 'CSV'
require './lib/game'

class GameManager
  attr_reader :games

  def initialize(file_path)
    @file_path = file_path
    @games = {}
    load
  end

  def load
    data = CSV.read(@file_path, headers: true)
    data.each do |row|
      @games[row["game_id"]] = Game.new(row)
    end
  end

  def highest_total_score
    max = 0
    @games.each do |game_id, game|
      current = game.away_goals.to_i + game.home_goals.to_i
      max = current if current > max
    end
    max
  end

  def lowest_total_score
    min = 100000
    @games.each do |game_id, game|
      current = game.away_goals.to_i + game.home_goals.to_i
      min = current if current < min
    end
    min
  end
end
