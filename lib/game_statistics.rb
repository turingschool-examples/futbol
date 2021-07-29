module GameStatistics

  def highest_total_score
    game_sums = @games.map do |game|
      game.home_goals + game.away_goals
    end
    game_sums.max
  end

  def lowest_total_score
    game_sums = @games.map do |game|
      game.home_goals + game.away_goals
    end
    game_sums.min
  end

  def percentage_home_wins
    home_wins = @games.find_all do |game|
        game.home_goals > game.away_goals
    end.length
    (home_wins.to_f / (games.length)).round(2)
  end

  def percentage_visitor_wins
    vistor_wins = @games.find_all do |game|
      game.away_goals > game.home_goals
    end.length
    (vistor_wins.to_f / (games.length)).round(2)
  end

  def percentage_ties
    ties = @games.find_all do |game|
      game.away_goals == game.home_goals
    end.length
    (ties.to_f / (games.length)).round(2)
  end

  def count_of_games_by_season
    count = {}
    @games.each do |game|
      if count[game.season].nil?
        count[game.season] = 1
      else
        count[game.season] += 1
      end
    end
    count
  end

  def average_goals_per_game
    total_goals = @games.sum do |game|
      game.away_goals + game.home_goals
    end
    (total_goals.to_f / (@games.length)).round(2)
  end

  def average_goals_by_season
    hash = {}
    @games.each do |game|
      if hash[game.season].nil?
        hash[game.season] = [1, game.home_goals + game.away_goals]
      else
        hash[game.season][0] += 1
        hash[game.season][1] += game.home_goals + game.away_goals
      end
    end
    results = {}
    hash.each do |season, stats|
      results[season] = (stats[1].to_f / stats[0]).round(2)
    end
    results
  end
end
