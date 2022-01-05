require './lib/GameManager'

class GameStatistics
  def initialize(game_manager)
    @games = game_manager
  end

  # def total_score
  #   @games.data.sum { |game| game.away_goals }
  # end
end
