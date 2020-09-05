module GameStatistics
  def highest_total_score
    highest_score = highest_total_score_helper
    highest_score.away_goals + highest_score.home_goals
  end

  def highest_total_score_helper
    @games.max_by do |game|
      game.away_goals + game.home_goals
    end
  end
end