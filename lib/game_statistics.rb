require_relative "./stat_tracker"
require_relative "./stat_helper"

class GameStatistics < StatHelper

  def initialize(files)
    super
  end

  def scores
    scores = @games.map { |game| (game.away_goals + game.home_goals)}
  end

  def highest_total_score
    scores.max
  end

  def lowest_total_score
    scores.min
  end

  def percentage_home_wins
    
  end

  # def percentage_visitor_wins
  #   method
  # end

  # def percentage_ties
  #   method
  # end

  # def count_of_games_by_season
  #   method
  # end

  # def average_goals_per_game
  #   method
  # end

  # def average_goals_by_season
  #   method
  # end
end
