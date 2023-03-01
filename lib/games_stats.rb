require 'csv'

class GamesStats

  def initialize
    @games = CSV.open('./data/games.csv', headers: true, header_converters: :symbol).map { |row| Game.new(row) }
  end

  
end