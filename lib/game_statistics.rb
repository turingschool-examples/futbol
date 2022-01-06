class GameStatistics
  attr_reader :games

  def initialize(game_manager)
    @games = game_manager
  end

  def highest_total_score
    game_with_highest_total_score = games.data.max_by do |game|
      game.total_score
    end
    game_with_highest_total_score.total_score
  end

  def lowest_total_score
    game_with_lowest_total_score = games.data.min_by do |game|
      game.total_score
    end
    game_with_lowest_total_score.total_score
  end
end
