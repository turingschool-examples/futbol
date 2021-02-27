require 'CSV'
require_relative './game_manager'
require_relative './team_manager'
require_relative './game_stats_manager'
require 'pry'

class StatTracker # < MethodsClass?

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    @game_manager = GameManager.new(locations[:games], self)
    @team_manager = TeamManager.new(locations[:teams], self)
    @game_manager = GameStatsManager.new(locations[:game_stats], self)
  end

  def highest_total_score
    @game_manager.game_with_highest_total_score.total_goals
  end

  def lowest_total_score
    @game_manager.game_with_lowest_total_score.total_goals
  end

  def percentage_home_wins
    @game_manager.percentage_home_wins
  end

  def percentage_visitor_wins
    @game_manager.percentage_visitor_wins
  end

  def percentage_ties
    @game_manager.percentage_ties
  end

  def count_of_games_by_season
    @game_manager.count_of_games_by_season
  end
end
