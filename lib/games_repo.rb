require 'CSV'
require './lib/game'
class GamesRepo
  attr_reader :parent, :games 
  
  def initialize(path, parent)
    @parent = parent 
    @games = create_games(path)
  end

  def create_games(path)
    rows = CSV.readlines('./data/games.csv', headers: :true , header_converters: :symbol)

    rows.map do |row|
      Game.new(row, self)
    end
  end
end