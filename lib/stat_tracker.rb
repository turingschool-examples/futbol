# frozen_string_literal: true

require_relative './game_methods'

# Stat tracker class
class StatTracker
  attr_reader :games_path, :teams_path, :game_teams_path

  def initialize(locations)
    @games_path = locations[:games]
    @teams_path = locations[:teams]
    @game_teams_path = locations[:game_teams]
    @game_methods = GameMethods.new(@games_path)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def highest_total_score
    @highest_total_score ||= @game_methods.highest_total_score
  end

  def lowest_total_score
    @lowest_total_score ||= @game_methods.lowest_total_score
  end

  def percentage_home_wins
    @percentage_home_wins ||= @game_methods.percentage_home_wins
  end

  def percentage_visitor_wins
    @percentage_visitor_wins ||= @game_methods.percentage_visitor_wins
  end

  def percentage_ties
    @percentage_ties ||= @game_methods.percentage_ties
  end

  def count_of_games_by_season
    @count_of_games_by_season ||= @game_methods.count_of_games_by_season
  end

  def average_goals_per_game
    @average_goals_per_game ||= @game_methods.average_goals_per_game
  end

  def average_goals_by_season
    @average_goals_by_season ||= @game_methods.average_goals_by_season
  end
end
