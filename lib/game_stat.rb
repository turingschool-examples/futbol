module GameStat

  def highest_total_score
    highest_game = all_games.max_by{|game_id, game| game.home_goals + game.away_goals}
    highest_game[1].home_goals + highest_game[1].away_goals
  end

  def lowest_total_score
    lowest_game = all_games.min_by { |game_id, game| game.home_goals + game.away_goals }
    lowest_game[1].home_goals + lowest_game[1].away_goals
  end

  def biggest_blowout
    bb_game = all_games.max_by{ |game_id, game| (game.home_goals - game.away_goals).abs}
    (bb_game[1].home_goals - bb_game[1].away_goals).abs
  end

  def percentage_home_wins
    (all_games.count { |game_id, game| game.home_goals > game.away_goals} \
      / all_games.length.to_f).round(2)
  end

  def percentage_visitor_wins
    (all_games.count { |game_id, game| game.home_goals < game.away_goals} \
      / all_games.length.to_f).round(2)
  end

  def percentage_ties
    (all_games.count { |game_id, game| game.home_goals == game.away_goals} \
      / all_games.length.to_f).round(2)
  end

  def count_of_games_by_season
    seasons = all_games.map { |game_id, game| game.season}.uniq
    count_result = Hash.new
    seasons.each do |season|
      count_result[season] = all_games.count {|game_id, game| game.season == season}
    end
    count_result
  end

  def average_goals_per_game
    (all_games.map { |game_id, game| game.home_goals + game.away_goals}.sum \
    / all_games.length.to_f).round(2)
  end

  def average_goals_by_season
    seasons = all_games.map { |game_id, game| game.season}.uniq
    count_result = Hash.new

    seasons.each do |season|
      total_goals = all_games.map { |game_id, game|
        game.home_goals + game.away_goals if game.season == season
      }.compact.sum

      num_games = all_games.count {
        |game_id, game| game.season == season
      }

      count_result[season] = (total_goals / num_games.to_f).round(2)
    end
    count_result
  end
end
