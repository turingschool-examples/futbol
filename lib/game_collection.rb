require_relative "game"
require "csv"

class GameCollection
  attr_reader :games

  def initialize(file_path)
    @games = create_games(file_path)
  end

  def create_games(file_path)
    csv = CSV.read(file_path, headers: true, header_converters: :symbol)

    csv.map { |row| Game.new(row) }
  end

  def average_goals_per_game
    total_goals = @games.reduce(0) do |sum, game|
      sum += game.away_goals
      sum += game.home_goals
      sum
    end
    (total_goals.to_f / @games.length).round(2)
  end

  def games_by_season
    @games.reduce({}) do |hash, game|
      hash[game.season] = [game] if hash[game.season].nil?
      hash[game.season] << game if hash[game.season]
      hash
    end
  end
end
