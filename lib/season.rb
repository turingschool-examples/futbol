require "CSV"
require_relative './game'

class Season
  attr_reader :id, :games_by_type

  def initialize(season_hash)
    @id = season_hash[:id].to_i
    @games_by_type = games_gather(season_hash[:path])
  end

  def games_gather(games_path)
    game_sort_hash = Hash.new { |hash, key| hash[key] = [] }
    CSV.foreach(games_path, :headers => true, header_converters: :symbol) do |row|
      if row[1].to_i == @id
        game_sort_hash[(row[2])].push((Game.new(row)))
      end
    end
    game_sort_hash
  end

  def number_of_games_by_type(type)
    games_by_type[type].length
  end
end
