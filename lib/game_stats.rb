require_relative './helper'

module GameStats
  include Helper

  def game_rspec_test
    true
  end

  def highest_total_score
    highest_game = @games.max_by do |game|
      game.away_goals + game.home_goals
    end
    highest_game.away_goals + highest_game.home_goals
  end

  def lowest_total_score
    lowest_game = @games.min_by do |game|
      game.away_goals + game.home_goals
    end
    lowest_game.away_goals + lowest_game.home_goals
  end

  def percentage_home_wins

  end

  def percentage_visitor_wins

  end

  def percentage_ties

  end

  def count_of_games_by_season

  end

  def average_goals_per_game
    total_games = @games.count
    total_goals = @games.map do |game|
      game.away_goals + game.home_goals
    end.sum

    total_goals.fdiv(total_games)
  end

  def average_goals_per_season

  end
end