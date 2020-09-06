class GameStatistics
  attr_reader :game_id

  def initialize(hashed_game_data)
    @game_id = hashed_game_data
  end

  def get_all_scores_by_game_id
    game_id.flat_map do |game|
      game[:away_goals] + game[:home_goals]
    end
  end

  def highest_total_score
    get_all_scores_by_game_id.max
  end
end
