module GameStat

  def highest_total_score
    highest_game = all_games.max_by{ |game| game.home_goals + game.away_goals}
    highest_game.home_goals + highest_game.away_goals
  end

  def lowest_total_score
    lowest_game = all_games.min_by { |game| game.home_goals + game.away_goals }
    lowest_game.home_goals + lowest_game.away_goals
  end

  def biggest_blowout
    bb_game = all_games.max_by{ |game| (game.home_goals - game.away_goals).abs}
    (bb_game.home_goals - bb_game.away_goals).abs
  end

  def percentage_home_wins
    all_games.count { |game| game.home_goals > game.away_goals} \
      / all_games.length.to_f * 100
  end

  def percentage_visitor_wins
    all_games.count { |game| game.home_goals < game.away_goals} \
      / all_games.length.to_f * 100
  end

  def percentage_ties
    all_games.count { |game| game.home_goals == game.away_goals} \
      / all_games.length.to_f * 100
  end

  def count_of_games_by_season
    seasons = all_games.map { |game| game.season}.uniq
    count_result = Hash.new
    seasons.each do |season|
      count_result[season] = all_games.count {|game| game.season == season}
    end
    count_result
  end
end
