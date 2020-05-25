class GameStats
  attr_reader :games_collection

  def initialize(games_collection)
    @games_collection = games_collection
  end

  def total_score
    @games_collection.games.map do |game|
      game.away_goals + game.home_goals
    end
  end
end
