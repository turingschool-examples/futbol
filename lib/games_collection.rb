require_relative './game'
require 'csv'

class GamesCollection
  attr_reader :path,
              :all_games

  def initialize(path)
    @path      = path
    @all_games = []
    from_csv(path)
  end

  def from_csv(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |game_data|
      add_game(game_data)
    end
  end

  def add_game(data)
    @all_games << Game.new(data)
  end
end
