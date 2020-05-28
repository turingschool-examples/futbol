require 'csv'
class GameCollection
  #
  # @@game_path = './data/games.csv'

  def initialize(game_data)
    rows = CSV.read(game_data, headers: true, header_converters: :symbol)
    @games = []
    rows.each do |row|
      @games << Game.new(row)
    end
  end

  def all
    @games
  end

end
