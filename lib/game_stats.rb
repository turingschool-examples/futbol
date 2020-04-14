require_relative "stats"
require_relative 'calculable'

class GameStats < Stats
  include Calculable


  def highest_total_score
    highest_scoring_game = @games.max_by {|game| game.away_goals + game.home_goals}
    highest_scoring_game.away_goals + highest_scoring_game.home_goals
  end

  def lowest_total_score
    lowest_scoring_game = @games.min_by {|game| game.away_goals + game.home_goals}
    lowest_scoring_game.away_goals + lowest_scoring_game.home_goals
  end

  def percentage_home_wins
    home_wins = @games.find_all {|game| game.home_goals > game.away_goals}
    average(home_wins.length, @games.length)
  end

  def percentage_visitor_wins
    away_wins = @games.find_all {|game| game.away_goals > game.home_goals}
    average(away_wins.length, @games.length)
  end

  def percentage_ties
    ties = @game_teams.find_all {|team| team.result == "TIE"}
    average(ties.length, @game_teams.length)
  end

  def count_of_games_by_season
    games_by_season = @games.group_by {|game| game.season}
    games_by_season.transform_values {|season| season.length}
  end

  def average_goals_per_game
    sum_of_goals = @games.sum {|game| game.home_goals + game.away_goals}
    average(sum_of_goals, @games.length)
  end

  def average_goals_by_season
    average_goals_by_season = @games.group_by {|game| game.season}
    average_goals_by_season.transform_values do |season|
      average_of_goals_in_a_season(season.first.season)
    end
  end
end
