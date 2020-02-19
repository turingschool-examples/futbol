require './lib/game'

class GameCollection
  attr_reader :games, :csv_file_path

  def initialize(csv_file_path)
    @games = []
    @csv_file_path = csv_file_path
  end

  def instantiate_game(info)
    Game.new(info)
  end
end
