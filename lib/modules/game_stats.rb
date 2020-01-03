module GameStats
  def highest_total_score
    total_scores = @game_collection.collection.map do |game|
      game[1].away_goals.to_i + game[1].home_goals.to_i
    end
    total_scores.max
  end

  def lowest_total_score
    total_scores = @game_collection.collection.map do |game|
      game[1].away_goals.to_i + game[1].home_goals.to_i
    end
    total_scores.min
  end

  def biggest_blowout
    blowout = @game_collection.collection.max_by do |_id, game|
      (game.home_goals.to_i - game.away_goals.to_i).abs
    end
    (blowout[1].home_goals.to_i - blowout[1].away_goals.to_i).abs
  end

  def percentage_home_wins
    home_wins = 0
    total_games = @game_collection.collection.length

    @game_collection.collection.each do |game|
      home_wins += 1 if game[1].home_goals.to_i > game[1].away_goals.to_i
    end
    (home_wins / total_games.to_f).abs.round(2)
  end

  def percentage_visitor_wins
    visitor_wins = 0
    total_games = @game_collection.collection.length

    @game_collection.collection.each do |game|
      visitor_wins += 1 if game[1].home_goals.to_i < game[1].away_goals.to_i
    end
    (visitor_wins / total_games.to_f).abs.round(2)
  end

  def percentage_ties
    ties_sum = 0.0
    @game_collection.collection.each do |game|
      ties_sum += 1 if game[1].home_goals == game[1].away_goals
    end
    (ties_sum / @game_collection.collection.length).round(2)
  end

  def count_of_games_by_season
    @game_collection.collection.each_with_object(Hash.new { 0 }) do |game, hash|
      hash[game[1].season] += 1
    end
  end

  def average_goals_per_game
    sum = 0
    @game_collection.collection.each do |game|
      sum += (game[1].away_goals.to_i + game[1].home_goals.to_i)
    end
    (sum.to_f / @game_collection.collection.length).round(2)
  end

  def average_goals_by_season
    avg_gpg = Hash.new(0)
    @season_collection.collection.each_pair do |key, season_array|
      season_array.find_all { |game| avg_gpg[key] += (game.home_goals.to_f + game.away_goals.to_f) }
      avg_gpg[key] = (avg_gpg[key] / season_array.length).round(2)
    end
    avg_gpg
  end
end
