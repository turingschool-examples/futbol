module Percentageable
  def hash_average(data)
    count, total = data.keys
    data[count].fdiv(data[total])
  end

  def average(num1, num2)
    num1.fdiv(num2)
  end

#helper
  def get_accuracy_average(accuracy_data)
    accuracy_data.reduce({}) do |acc, data|
      acc[data.first] = hash_average(data.last)
      acc
    end
  end

#Helper
  def season_averages(win_data)
    win_data.map do |season, stats|
      [season, hash_average(stats)]
    end
  end

  # Helper
  def get_offense_averages(goal_data)
     goal_data.map do |team, data|
      [team, hash_average(data).round(2)]
    end.to_h
  end

  def get_percentage_ties(games)
    tie_stats = games.reduce({ties: 0, total: 0}) do |acc, game|
      acc[:total] += 1
      if game.result == "TIE"
        acc[:ties] += 1
      end
      acc
    end
    hash_average(tie_stats).round(2)
  end

  def get_percentage_hoa_wins(team, games)
    stats = games.reduce({wins: 0, total: 0}) do |acc, game|
      acc[:total] += 0.5
      if game.won? && game.home_away == team
        acc[:wins] += 1
      end
      acc
    end
    hash_average(stats).round(2)
  end
end
