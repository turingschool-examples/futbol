require 'csv'
require 'simplecov'
require_relative './game_stats'
require_relative './league_stats.rb'
require_relative './season_stats.rb'
require_relative './team_stats.rb'

SimpleCov.start

class StatTracker

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    @game_teams_path = locations[:game_teams]
    @teams_path = locations[:teams]
    @games_path = locations[:games]
  end

  def count_of_teams
    league_stats = LeagueStats.new(@game_teams_path)
    league_stats.count_of_teams
  end

  def best_offense
    league_stats = LeagueStats.new(@game_teams_path)
    league_stats.best_offense
  end

  def worst_offense
    league_stats = LeagueStats.new(@game_teams_path)
    league_stats.worst_offense
  end

  def highest_scoring_visitor
    league_stats = LeagueStats.new(@game_teams_path)
    league_stats.highest_scoring_visitor
  end

  def highest_scoring_home_team
    league_stats = LeagueStats.new(@game_teams_path)
    league_stats.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    league_stats = LeagueStats.new(@game_teams_path)
    league_stats.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    league_stats = LeagueStats.new(@game_teams_path)
    league_stats.lowest_scoring_home_team
  end

  def winningest_coach(season_id)
    season_stats = SeasonStats.new(@game_teams_path, @games_path, @teams_path)
    season_stats.winningest_coach(season_id)
  end

  def worst_coach(season_id)
    season_stats = SeasonStats.new(@game_teams_path, @games_path, @teams_path)
    season_stats.worst_coach(season_id)
  end

  def most_accurate_team(season_id)
    season_stats = SeasonStats.new(@game_teams_path, @games_path, @teams_path)
    season_stats.most_accurate_team(season_id)
  end

  def least_accurate_team(season_id)
    season_stats = SeasonStats.new(@game_teams_path, @games_path, @teams_path)
    season_stats.least_accurate_team(season_id)
  end

  def most_tackles(season_id)
    season_stats = SeasonStats.new(@game_teams_path, @games_path, @teams_path)
    season_stats.most_tackles(season_id)
  end

  def fewest_tackles(season_id)
    season_stats = SeasonStats.new(@game_teams_path, @games_path, @teams_path)
    season_stats.fewest_tackles(season_id)
  end
end
