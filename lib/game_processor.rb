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
    if value == 'home'
      home_wins = 0.0
      games.each do |game|
        if game.home_goals.to_i > game.away_goals.to_i
          home_wins += 1
        end
      end
      (home_wins / games.count).round(2)

    elsif value == 'visitor'
      visitor_wins = 0.0
      games.each do |game|
        if game.home_goals.to_i < game.away_goals.to_i
          visitor_wins += 1
        end
      end
      (visitor_wins / games.count).round(2)

    else
      ties = 0.0
      games.each do |game|
        if game.home_goals.to_i == game.away_goals.to_i
          ties += 1
        end
      end
      (ties / games.count).round(2)
    end
  end

  def total_goals_by_season(games)
    total_season_goals = Hash.new(0.0)
    games.each do |game|
      total_season_goals[game.season] += game.total_goals_game
    end
    total_season_goals
  end




end
