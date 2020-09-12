# frozen_string_literal: true

require_relative './game_methods'
require_relative './team_methods'
require_relative './game_teams_methods'

# Stat tracker class
class StatTracker
  attr_reader :games_path, :teams_path, :game_teams_path
  attr_accessor :game_methods, :team_methods, :game_teams_methods

  def initialize(locations)
    @games_path = locations[:games]
    @teams_path = locations[:teams]
    @game_teams_path = locations[:game_teams]
    @game_methods = GameMethods.new(@games_path)
    @team_methods = TeamMethods.new(@teams_path)
    @game_teams_methods = GameTeamsMethods.new(@game_teams_path)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def highest_total_score
    @highest_total_score ||= @game_methods.highest_total_score
  end

  def best_offense
    best_team = @game_teams_methods.best_offense_team
    @team_methods.find_by_id(best_team)
  end

  def worst_offense
    worst_team = @game_teams_methods.worst_offense_team
    @team_methods.find_by_id(worst_team)
  end

  def highest_scoring_visitor_team
    highest_visitor = @game_teams_methods.highest_scoring_team("away")
    @team_methods.find_by_id(highest_visitor)
  end

  def highest_scoring_home_team
    highest_visitor = @game_teams_methods.highest_scoring_team("home")
    @team_methods.find_by_id(highest_visitor)
  end

  def lowest_scoring_visitor_team
    lowest_visitor = @game_teams_methods.lowest_scoring_team("away")
    @team_methods.find_by_id(lowest_visitor)
  end

  def lowest_scoring_home_team
    lowest_visitor = @game_teams_methods.lowest_scoring_team("home")
    @team_methods.find_by_id(lowest_visitor)
  end
end
