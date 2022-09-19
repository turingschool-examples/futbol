
module GameStatistics
  
  def highest_total_score
    sum_goals_array.max
  end
  
  def lowest_total_score
    sum_goals_array.min
  end
  
  def sum_goals_array
     @games.map do |game|
      game[:home_goals].to_i + game[:away_goals].to_i
    end
  end

  def percentage_home_wins
    home_wins = @games.count do |game|
      game[:home_goals] > game[:away_goals]
    end
    (home_wins.to_f / @games.length).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = @games.count do |game|
      game[:home_goals] < game[:away_goals]
    end
    (visitor_wins.to_f / @games.length).round(2)
  end

  def percentage_ties
    results = return_column(@game_teams, :result)
    tie_results = results.find_all { |result| result == "TIE"}
    (tie_results.length.to_f / results.length.to_f).round(2)
  end

  def return_column(data_set, column)
    all_results = []
    data_set.each do |rows|
      all_results << rows[column]
    end
    all_results
  end
  
  def count_of_games_by_season
    count = Hash.new(0)
    @games.each do |game|
      count[game[:season]] += 1
    end
    count
  end

  def average_goals_per_game
    goals_array = @games.map do |game|
      game[:home_goals].to_f + game[:away_goals].to_f
    end
    sum_goals_array = goals_array.sum
    (sum_goals_array / @games.length).round(2)
  end

  def average_goals_by_season 
    seasons = Hash.new { |h,k| h[k] = [] }
    @games.each do |csv_row|
      seasons[csv_row[:season]] << csv_row[:away_goals].to_i + csv_row[:home_goals].to_i
    end
    seasons.each do |k,v|
      seasons[k] = (seasons[k].sum / seasons[k].count.to_f).round(2)
    end
    seasons
  end
end