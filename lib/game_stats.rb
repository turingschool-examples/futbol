class GameStats
  attr_reader :games_collection
  
  def initialize(games_collection)
    @games_collection = games_collection
  end
end
