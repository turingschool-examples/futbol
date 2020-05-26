require "csv"

class GameCollection
  def initialize(games_csv)
    @games_csv = games_csv
  end

  def all
    rows = CSV.read(@games_csv, headers: true, header_converters: :symbol)
    rows.reduce([]) do |games, row|
      games << Game.new(row)
      games
    end
  end
end
