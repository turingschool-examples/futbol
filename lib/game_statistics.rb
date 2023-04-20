# use require_relative
class GameStatistics

  def initialize(files)
    @games = CSV.open(<file> headers: true, header_converters: :symbol)
  end

  def highest_total_score
    method
  end

  def lowest_total_score
    method
  end

  def percentage_home_wins
    @games. (method for calculating this)
  end

  def percentage_visitor_wins
    method
  end

  def percentage_ties
    method
  end

  def count_of_games_by_season
    method
  end

  def average_goals_per_game
    method
  end

  def average_goals_by_season
    method
  end
end
