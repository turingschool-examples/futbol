require 'CSV'
require_relative './game_data'
require_relative './team_data'
require_relative './game_stats_data'
require 'pry'

class StatTracker

  attr_reader :game_data, :team_data, :game_stats

  def initialize(locations)
    @game_data = GameData.new(locations[:games], self)
    @team_data = TeamData.new(locations[:teams], self)
    @game_stats = GameStatsData.new(locations[:game_stats], self)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def highest_total_score
    @game_data.game_with_highest_total_score.total_goals
  end

  def lowest_total_score
    @game_data.game_with_lowest_total_score.total_goals
  end

  def percentage_home_wins
    @game_data.percentage_home_wins
  end

  def percentage_visitor_wins
    @game_data.percentage_visitor_wins
  end

  def percentage_ties
    @game_data.percentage_ties
  end

  def count_of_games_by_season
    @game_data.count_of_games_by_season
  end
end
