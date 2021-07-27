require_relative './stat_tracker'

class GameStatistics
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def highest_total_score
    highest_scoring_game =
    @data.games.max_by do |game|
      game[:away_goals].to_i + game[:home_goals].to_i
    end
    highest_scoring_game[:away_goals].to_i + highest_scoring_game[:home_goals].to_i
  end
end
