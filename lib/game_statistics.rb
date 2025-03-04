class GameStatistics
  def initialize(games)
    @games = games
  end

  # Helper Method
  def calculate_percentage
    count = @games.count { |game| yield(game) }
    (count.to_f / @games.size).round(2)
  end

  def highest_score # Unnecessary methods but if these values are required in the future, they are already here! DRY!
    @games.map { |game| game[:home_goals].to_i + game[:away_goals].to_i }.max
  end

  def lowest_score
    @games.map { |game| game[:home_goals].to_i + game[:away_goals].to_i }.min
  end
  
  # Game Statistics
  def highest_total_score
    highest_score
  end

  def lowest_total_score
    lowest_score
  end

  def percentage_home_wins
    calculate_percentage { |game| game[:home_goals].to_i > game[:away_goals].to_i }
  end

  def percentage_visitor_wins
    calculate_percentage { |game| game[:away_goals].to_i > game[:home_goals].to_i }
  end

  def percentage_ties
    calculate_percentage { |game| game[:home_goals].to_i == game[:away_goals].to_i }
  end

  def count_of_games_by_season
    @games.group_by { |game| game[:season] }.transform_values(&:count)
  end

  def average_goals_per_game
    total_goals = @games.sum { |game| game[:home_goals].to_i + game[:away_goals].to_i }
    (total_goals.to_f / @games.size).round(2)
  end

  def average_goals_by_season
    goals_by_season = @games.group_by { |game| game[:season] }
    goals_by_season.transform_values do |games|
      total_goals = games.sum { |game| game[:home_goals].to_i + game[:away_goals].to_i }
      (total_goals.to_f / games.size).round(2)
    end
  end
end