require_relative "stat_tracker"

class GameStatistics
  # def self.from_csv(files)
  #   require 'pry'; binding.pry
  # end

  def initialize(locations)
  end

  # def highest_total_score
  #   method
  # end

  # def lowest_total_score
  #   method
  # end

  # def percentage_home_wins
  #   # method
  # end

  # def percentage_visitor_wins
  #   method
  # end

  # def percentage_ties
  #   method
  # end

  # def count_of_games_by_season
  #   method
  # end

  
  def average_goals_per_game
    total_goals = games.map do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end
    (total_goals.sum / games.length.to_f).round(2)
  end
  # # Pseudocode:
  #   for each game (away_goals + home_goals)
  #   sum all games total goals
  #   divide by total number of games
  #   (rounded to the nearest 100th)
  #   return Float
  # Description: Average number of goals scored in a game across all seasons including both home and away goals (rounded to the nearest 100th)
  # Return Value: Float


  # def average_goals_by_season
  #   see stat_tracker class for updates
  # end

  # # Pseudocode:
  #   separate season
  #   for each season: (away_goals + home_goals)
  #   create a hash (season => (total goals by season divided by season by count_of_games_by_season)
  #   (rounded to the nearest 100th)
  #   return Hash

  # Description: Average number of goals scored in a game organized in a hash with season names (e.g. 20122013) as keys and a float representing the average number of goals in a game for that season as values (rounded to the nearest 100th)
  # Return Value: Hash

end
