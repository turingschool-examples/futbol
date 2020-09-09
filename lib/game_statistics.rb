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


end
