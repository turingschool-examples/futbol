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
    @teams_manager = TeamsManager.new(locations[:teams], self)
    @game_teams_manager = GameTeamsManager.new(locations[:game_teams], self)
  end

  def count_of_teams
    @teams_manager.count_of_teams
  end

  def find_team_name(team_number)
    @teams_manager.find_team_name(team_number)
  end

  def average_number_of_goals_scored_by_team(team_id)
binding.pry
    @game_teams_manager.average_number_of_goals_scored_by_team(team_id)
  end
end
