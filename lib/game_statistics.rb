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

  def lowest_total_score
    min_score = lowest_total_score_helper
    min_score.away_goals + min_score.home_goals
  end

  def lowest_total_score_helper
    @games.min_by do |game|
      game.away_goals + game.home_goals
    end
  end
end