require 'CSV'
require_relative 'game_manager'
require_relative 'team_manager'
require_relative 'game_teams_manager'
require_relative 'game'
require_relative 'game_teams'
require_relative 'team'

class StatTracker
  attr_reader :game_manager,
              :game_teams_manager,
              :team_manager

  def initialize(locations)
    @game_manager = GameManager.new(locations[:games], self)
    @game_teams_manager = GameTeamsManager.new(locations[:game_teams], self)
    @team_manager = TeamManager.new(locations[:teams], self)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def highest_total_score
    @game_manager.highest_total_score
  end

  def lowest_total_score
    @game_manager.lowest_total_score
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

  def average_goals_per_game
    @game_manager.average_goals_per_game
  end

  def average_goals_by_season
    @game_manager.average_goals_by_season
  end

  def count_of_teams
    @team_manager.count_of_teams
  end

  def best_offense
    @team_manager.best_offense_stats
    @team_manager.best_offense
  end

  def worst_offense
    @team_manager.worst_offense_stats
    @team_manager.worst_offense
  end

  def highest_scoring_visitor
    @team_manager.team_highest_away_goals
    @team_manager.highest_scoring_visitor
  end

  def highest_scoring_home_team
    @team_manager.team_highest_home_goals
    @team_manager.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    @team_manager.team_lowest_away_goals
    @team_manager.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    @team_manager.team_lowest_home_goals
    @team_manager.lowest_scoring_home_team
  end
end
