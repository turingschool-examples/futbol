module GameStatistics
  def highest_total_score
    sum = 0
    @games.each do |game|
      new_sum = game.away_goals + game.home_goals
      sum = new_sum if new_sum > sum
    end
    sum
  end

  def lowest_total_score
    sum = 0
    @games.each do |game|
      new_sum = game.away_goals + game.home_goals
      sum = new_sum if new_sum <= sum
    end
    sum
  end

  def biggest_blowout
    sum = 0
    @games.each do |game|
      new_sum = (game.away_goals - game.home_goals).abs
      sum = new_sum if new_sum > sum
    end
    sum
  end
end
