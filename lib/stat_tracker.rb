require 'csv'
require_relative 'team_stats'
require_relative 'game_teams_stats'
require_relative 'game_stats'
require_relative 'game'

class StatTracker
  include DataLoadable
  attr_accessor :games_path, :team_path, :game_teams_path

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    @games_path = locations[:games]
    @team_path = locations[:teams]
    @game_teams_path = locations[:game_teams]
    @games_stats = GameStats.new(@games_path, Game)
    @team_stats = TeamStats.new(@team_path, Team)
    @game_teams_stats = GameTeamStats.new(@game_teams_path, GameTeams)
  end

  def count_of_teams
    @team_stats.count_of_teams
  end

  def best_offense
    @team_stats.find_name(@game_teams_stats.best_offense)
  end

  def worst_offense
    @team_stats.find_name(@game_teams_stats.worst_offense)
  end

  def highest_scoring_visitor
    @team_stats.find_name(@game_teams_stats.highest_scoring_visitor)
  end

  def highest_scoring_home_team
    @team_stats.find_name(@game_teams_stats.highest_scoring_home_team)
  end

  def lowest_scoring_visitor
    @team_stats.find_name(@game_teams_stats.lowest_scoring_visitor)
  end

  def lowest_scoring_home_team
    @team_stats.find_name(@game_teams_stats.lowest_scoring_home_team)
  end

  def winningest_team
    @team_stats.find_name(@games_stats.winningest_team)
  end

  def best_fans
    @team_stats.find_name(@game_teams_stats.best_fans)
  end

  def worst_fans
    @game_teams_stats.worst_fans.map {|fan| @team_stats.find_name(fan)}
  end

  def percentage_ties
    @games_stats.percentage_ties
  end

  def count_of_games_by_season
    @games_stats.count_of_games_by_season
  end

  def percentage_home_wins
    @games_stats.percentage_home_wins
  end

  def percentage_visitor_wins
    @games_stats.percentage_visitor_wins
  end

  def average_goals_per_game
    @games_stats.average_goals_per_game
  end

  def average_goals_by_season
    @games_stats.average_goals_by_season
  end

  def highest_total_score
    @games_stats.highest_total_score
  end

  def lowest_total_score
    @games_stats.lowest_total_score
  end

  def biggest_blowout
    @games_stats.biggest_blowout
  end
end
