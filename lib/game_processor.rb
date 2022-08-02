module GameProcessor
  def total_score(value, games)
    if value == 'highest'
      score_sum = 0
      games.each do |game|
        if score_sum < game.total_goals_game
          score_sum = game.total_goals_game
        end
      end

    else
      score_sum = Float::INFINITY
      games.each do |game|
          if score_sum > game.total_goals_game
          score_sum = game.total_goals_game
        end
      end
    end
    return score_sum
  end

  def win_percentage(value, games)
    total_games = 0.0
    if value == 'home'
      home_wins = 0.0
      games.each do |game|
        total_games += 1
        if game.home_goals.to_i > game.away_goals.to_i
          home_wins += 1
        end
      end
      (home_wins / total_games).round(2)
    elsif value == 'visitor'
      visitor_wins = 0.0
      games.each do |game|
        total_games += 1
        if game.home_goals.to_i < game.away_goals.to_i
          visitor_wins += 1
        end
      end
      (visitor_wins / total_games).round(2)
    else
      ties = 0.0
      games.each do |game|
        total_games += 1
        if game.home_goals.to_i == game.away_goals.to_i
          ties += 1
        end
      end
      (ties / total_games).round(2)
    end
  end
end
