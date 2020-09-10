module GameStatistics
  def highest_total_score
    game ||= @game_table.values.max_by do |game|
      game.away_goals + game.home_goals
    end
    return game.away_goals + game.home_goals
  end

  def lowest_total_score
    game ||= @game_table.values.min_by do |game|
      game.away_goals + game.home_goals
    end
    return game.away_goals + game.home_goals
  end

  def percentage_home_wins
    home_wins = 0
    total_games = 0
    @game_table.each do |key, value|
      if value.home_goals > value.away_goals
        home_wins += 1
        total_games += 1
      elsif value.home_goals <= value.away_goals
        total_games += 1
      end
    end
    (home_wins.to_f/total_games.to_f).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = 0
    total_games = 0
    @game_table.each do |key, value|
      if value.away_goals > value.home_goals
        visitor_wins += 1
        total_games += 1
      elsif value.away_goals <= value.home_goals
        total_games += 1
      end
    end
    (visitor_wins.to_f/total_games.to_f).round(2)
  end
end
