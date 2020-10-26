require './lib/game'

class GamesCollection
  attr_reader :games

  def initialize(file_path)
    @games = []
    create_games(file_path)
  end

  def create_games(file_path)
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @games << Game.new(row)
    end
  end
end
