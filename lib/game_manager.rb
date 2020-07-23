require './lib/game'

class GameManager
  attr_reader :game_hash

  def initialize(game_path)
    @game_path = game_path
    @game_hash = {} ######## can easily modify to array
    CSV.foreach(game_path, headers: true) do |row|
      game_hash[row[0]] = Game.new(row)
    end

  end

end
