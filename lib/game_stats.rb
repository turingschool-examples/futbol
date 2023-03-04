require_relative 'stats'
require_relative 'game_statables'

class GameStats < Stats 
include GameStatables
  def initialize(files)
    super
  end

  def highest_total_score
    high_score = @games.max_by{ |game| game.total_score }
    high_score.total_score
  end

  def lowest_total_score
    low_score = @games.min_by{ |game| game.total_score }
    low_score.total_score
  end

  def percentage_home_wins
   all_home_wins.length.fdiv(@games.length).round(2)
  end

  def percentage_visitor_wins
    all_away_wins.length.fdiv(@games.length).round(2)
  end

  def percentage_ties
    all_ties.length.fdiv(@games.length).round(2)
  end

  def count_of_games_by_season
    count = Hash.new(0)
    @games.map do |game|
      count[game.season_year] += 1
    end
    count
  end

  def average_goals_per_game
    sum_of_scores = @games.sum do |game|
      game.total_score
    end
    sum_of_scores.fdiv(@games.length).round(2)
  end

  def average_goals_by_season
    goals_by_season.merge!(count_of_games_by_season) do |season, goals, games| 
      goals.fdiv(games).round(2)
    end
  end

end