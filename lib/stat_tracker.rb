require 'csv'
require_relative './game_manager'
require_relative './team_manager'
require_relative './game_teams_manager'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(file_locations)
    @games      = file_locations[:games]
    @teams      = file_locations[:teams]
    @game_teams = file_locations[:game_teams]
    @game_manager       = GameManager.new(@games)
    @team_manager       = TeamManager.new(@teams)
    @game_teams_manager = GameTeamsManager.new(@game_teams)
  end

  def self.from_csv(file_locations)
    StatTracker.new(file_locations)
  end

  def highest_total_score
    @game_manager.all
    @game_manager.highest_total_score
  end

  def count_of_teams
    @team_manager.all
    @team_manager.count_of_teams
  end
end
