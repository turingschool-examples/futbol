module GameStatistics

# Highest sum of the winning and losing teams’ scores
  def highest_total_score
    highest_total = 0
    @game_table.each do |key, value|
      total = value.away_goals + value.home_goals
      if total > highest_total
        highest_total = total
      end
    end
    highest_total
  end

  def lowest_total_score
    lowest_total = 11
    @game_table.each do |key, value|
      total = value.away_goals + value.home_goals
      if lowest_total > total
        lowest_total = total
      end
    end
    lowest_total
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
