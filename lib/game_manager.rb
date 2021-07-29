require 'game'

class GameManager
  attr_reader :games

  def initialize(locations)
    @games = Game.read_file(locations[:games])
  end


  def array_of_seasons
    @games.map do |game|
      game.season
    end.uniq
  end
end
