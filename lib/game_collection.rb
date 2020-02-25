require_relative './game'
require "CSV"

class GameCollection
  attr_reader :games

  def initialize(csv_file_path)
    @games = create_games(csv_file_path)
  end

  def create_games(csv_file_path)
    csv = CSV.read(csv_file_path, headers: true, header_converters: :symbol)
    csv.map do |row|
       Game.new(row)
    end
  end

  def count_of_games_by_season
    @games.reduce(Hash.new(0)) do |acc, game|
      acc[game.season] += 1
      acc
    end
  end

  def average_goals_per_game
    (@games.map {|game| game.total_score}.sum / @games.length.to_f).round(2)
  end

  def average_goals_per_season
    @games.reduce(Hash.new(0)) do |acc, game|
      #fix method
      acc[game.season] = (game.total_goals / game.season.length.to_f).round(2)
      acc
    end
  end
end
