class GamesCollection
  attr_reader :games

  def initialize
    @games = generate_objects_from_csv
  end

  def generate_objects_from_csv
    objects = []
    CSV.foreach('./data/dummy_games.csv', headers: true, header_converters: :symbol) do |row_object|
      objects << Game.new
    end
    objects
  end
end
