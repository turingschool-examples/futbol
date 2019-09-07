module GameStatistics
  def highest_total_score
    sum = 0
    @games.each_value do |game|
      new_sum = game.away_goals + game.home_goals
      sum = new_sum if new_sum > sum
    end
    sum
  end

  def lowest_total_score
    sum = 0
    @games.each_value do |game|
      new_sum = game.away_goals + game.home_goals
      sum = new_sum if new_sum <= sum
    end
    sum
  end

  def biggest_blowout
    sum = 0
    @games.each_value do |game|
      new_sum = (game.away_goals - game.home_goals).abs
      sum = new_sum if new_sum > sum
    end
    sum
  end

  def percentage_home_wins
    wins = 0
    @games.each_value do |game|
      if game.home_goals > game.away_goals
        wins += 1
      end
    end
    (wins.to_f / @games.length).round(2)
  end

  def percentage_visitor_wins
    wins = 0
    @games.each_value do |game|
      if game.home_goals < game.away_goals
        wins += 1
      end
    end
    (wins.to_f / @games.length).round(2)
  end

  def percentage_ties
    (@games.select do |game_id, game|
      game.away_goals == game.home_goals
    end.length.to_f / @games.length).round(2)
  end

  def count_of_games_by_season
    total_games = Hash.new(0)
    @games.each_value do |game|
      if !total_games.has_key?(game.season)
        total_games[game.season] = 1
      else
        total_games[game.season] += 1
      end
    end
    total_games
  end

  def average_goals_per_game
    sums = 0
    @games.each_value do |game|
      sums += game.home_goals + game.away_goals
    end
    (sums / @games.length).round(2)
  end

  def average_goals_by_season
    total_goals = Hash.new(0)
    total_games = count_of_games_by_season
    @games.each_value do |game|
      if !total_goals.has_key?(game.season)
        total_goals[game.season] = (game.away_goals + game.home_goals) / total_games[game.season]
      else
        total_goals[game.season] += game.away_goals + game.home_goals
      end
    end
    total_goals.each do |season, goals|
      total_goals[season] = (goals / total_games[season]).ceil(2)
    end
    total_goals
  end
end
