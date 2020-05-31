require_relative "./stat_tracker"
require "csv"

class GameStatistics < StatTracker

  # Highest sum of the winning and losing teams’ scores
  def highest_total_score # Integer
  end

  # Lowest sum of the winning and losing teams’ scores
  def lowest_total_score # Integer
  end

  # Percentage of games that a home team has won (rounded to the nearest 100th)
  def percentage_home_wins # Float
  end

  # Percentage of games that a visitor has won (rounded to the nearest 100th)
  def percentage_visitor_wins # Float
  end

  # Percentage of games that has resulted in a tie (rounded to the nearest 100th)
  def percentage_ties # Float
  end

  # A hash with season names (e.g. 20122013) as keys and counts of games as values
  def count_of_games_by_season # Hash
  end

  # Average number of goals scored in a game across all seasons
  # including both home and away goals (rounded to the nearest 100th)
  def average_goals_per_game # Float
  end

  # Average number of goals in a game by season
  # ie, {"20172018"=>4.44, ... }
  def average_goals_by_season # Hash
  end

end
