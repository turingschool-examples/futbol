require 'csv'
require_relative 'game'

class GameCollection
  def initialize(game_collection_path)
    @game_collection_path = game_collection_path
  end

  def all_games
    csv = CSV.read("#{@game_collection_path}", headers: true, header_converters: :symbol)

    csv.map do |row|
      Game.new(row)
    end
  end

  def count_of_games_by_season
    games_per_season = Hash.new{0}
    all_games.each do |game|
      games_per_season[game.season] += 1
    end
    games_per_season.sort.to_h
  end
end
