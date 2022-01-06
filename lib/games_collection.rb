require 'pry'

class GamesCollection
  attr_reader :games
  def initialize(games_file)
    @games = read_file(games_file)
  end

  def read_file(games_file)
    data = CSV.read(games_file, headers: true, header_converters: :symbol)
    data.map do |row|
      Game.new(row)
    end
  end
end
