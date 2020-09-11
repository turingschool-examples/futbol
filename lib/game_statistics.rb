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

  def percentage_ties
    tie_games = 0
    total_games = 0
    @game_table.each do |key, value|
      total_games += 1
      if value.away_goals == value.home_goals
        tie_games += 1
      end
    end
    (tie_games.to_f/total_games.to_f).round(2)
  end

  def count_of_games_by_season
    total_games_per_season = {}
    @game_table.each do |game_id, game|
      if total_games_per_season[game.season].nil?
        total_games_per_season[game.season] = [game]
      else
        total_games_per_season[game.season] << game
      end
    end
    total_games_per_season.each do |key, value|
      total_games_per_season[key] = value.length
    end
  end

  def average_goals_per_game
    game_goals_total = 0
    game_count = 0
    @game_table.each do |game_id, game|
      game_count += 1
      game_goals_total += (game.home_goals + game.away_goals)
    end
    (game_goals_total.to_f / game_count).round(2)
  end

  def average_goals_by_season
    average_goals_per_season = {}
    game_count = 0
    total_game_count = count_of_games_by_season

    @game_table.each do |game_id, game|
      if average_goals_per_season[game.season].nil?
        average_goals_per_season[game.season] = (game.away_goals + game.home_goals)
      else
        average_goals_per_season[game.season] += (game.away_goals + game.home_goals)
      end
    end
    average_goals_per_season.each do |key, value|
      average_goals_per_season[key] = (value.to_f / total_game_count[key]).round(2)
    end
  end
end
