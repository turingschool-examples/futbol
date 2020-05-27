class GameCollection

  @@game_path = './data/games.csv'

  def initialize
    rows = CSV.read(@@game_path, headers: true, header_converters: :symbol)
    @games = []
    rows.each do |row|
      @games << Game.new(row)
    end
  end

  def all
    @games
  end

end
