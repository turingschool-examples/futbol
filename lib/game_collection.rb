class GameCollection
  attr_reader :game_path

  def initialize(game_path)
    @game_path = game_path
  end

  def parse
    CSV.parse("CSV,data,String", **options) do |row|
  end
end
