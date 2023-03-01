require_relative './helper'

module GameStats
  include Helper

  def game_rspec_test
    true
  end

  def highest_total_score
    @games.max_by do |game|
      game.away_goals + game.home_goals
    end
  end

  def lowest_total_score
    @games.min_by do |game|
      game.away_goals + game.home_goals
    end
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

  end

  def average_goals_per_season

  end
end