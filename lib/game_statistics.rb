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

  def percentage_home_wins
    percent_wins = percentage_home_win_helper
    ((percent_wins.to_f / @games.length.to_f) * 100).round(2)
  end

  def percentage_home_win_helper
    @games.count do |game|
      game.home_goals > game.away_goals
    end
  end

  def percentage_visitor_wins
    percent_wins = percentage_visitor_win_helper
    ((percent_wins.to_f / @games.length.to_f) * 100).round(2)
  end

  def percentage_visitor_win_helper
    @games.count do |game|
      game.home_goals < game.away_goals
    end
  end
end