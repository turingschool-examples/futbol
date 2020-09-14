require 'csv'
require_relative './game_manager'
require_relative './game_teams_manager'
require_relative './team_manager'
# require_relative './helper_class'

class StatTracker
  attr_reader :games_manager,
              :teams_manager,
              :game_teams_manager

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    load_managers(locations)
  end

  def load_managers(locations)
    @games_manager = GamesManager.new(locations[:games], self)
    @game_teams_manager = GameTeamsManager.new(locations[:game_teams], self)
    @teams_manager = TeamsManager.new(locations[:teams], self)
  end

  def count_of_teams
    @teams_manager.count_of_teams
  end

  def find_season_id(game_id)
    @games_manager.find_season_id(game_id)
  end

  def find_team_name(team_number)
    @teams_manager.find_team_name(team_number)
  end

  def average_number_of_goals_scored_by_team(team_id)
    @game_teams_manager.average_number_of_goals_scored_by_team(team_id)
  end

  def average_number_of_goals_scored_by_team_by_type(team_id, home_away)
    @game_teams_manager.average_number_of_goals_scored_by_team_by_type(team_id, home_away)
  end

  def highest_scoring_visitor
    @teams_manager.highest_scoring_visitor
  end

  def lowest_scoring_visitor
    @teams_manager.lowest_scoring_visitor
  end

  def highest_scoring_home_team
    @teams_manager.highest_scoring_home
  end

  def lowest_scoring_home_team
    @teams_manager.lowest_scoring_home
  end
end
