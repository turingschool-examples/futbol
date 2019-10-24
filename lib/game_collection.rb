require 'CSV'
require_relative './game'

class GameCollection
  attr_reader :games

  def self.load_data(path)
    games = {}
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      games[row[:game_id]] = Game.new(row)
    end

    GameCollection.new(games)
  end

  def initialize(games)
    @games = games
  end

  def high_score
    highest = @games.values.max_by do |game|
      game.away_goals + game.home_goals
    end
    highest.away_goals + highest.home_goals
  end
end
