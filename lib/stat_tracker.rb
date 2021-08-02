require_relative './game'
require_relative './team'
require_relative './game_team'
require_relative './game_manager'
require_relative './game_team_manager'
require_relative './season_manager'
require_relative './team_manager'
require 'csv'
require 'pry'


class StatTracker
  attr_reader :game_manager, :team_manager, :game_team_manager, :season_manager

  def initialize(locations)
    @game_manager = GameManager.new(locations)
    @team_manager = TeamManager.new(locations)
    @game_team_manager = GameTeamManager.new(locations)
    @season_manager = SeasonManager.new(@game_manager.games_by_season)
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

  def highest_total_score
    @game_manager.highest_total_score
  end

  def percentage_home_wins
    @game_manager.percentage_home_wins
  end

  def winningest_coach(season)
    season_games = @season_manager.game_id_by_season(season) #returns array of game ids
    @game_team_manager.winningest_coach(season_games)
  end

  def worst_coach(season)
    season_games = @season_manager.game_id_by_season(season) #returns array of game ids
    @game_team_manager.worst_coach(season_games)
  end

  def most_accurate_team(season)
    season_teams = @season_manager.team_id_by_season(season)
    team_id = @game_team_manager.most_accurate_team(season_teams)
    @team_manager.team_name(team_id)
  end

  def least_accurate_team(season)
    season_teams = @season_manager.team_id_by_season(season)
    team_id = @game_team_manager.least_accurate_team(season_teams)
    @team_manager.team_name(team_id)
  end

  def most_tackles(season)
    season_teams = @season_manager.team_id_by_season(season)
    team_id = @game_team_manager.most_tackles(season_teams)
    @team_manager.team_name(team_id)
  end

  def fewest_tackles(season)
    season_teams = @season_manager.team_id_by_season(season)
    team_id = @game_team_manager.fewest_tackles(season_teams)
    @team_manager.team_name(team_id)
  end

  # LEAGUES METHODS
  def count_of_teams
    @team_manager.count_teams
  end

  def best_offense
    @team_manager.team_name(@game_team_manager.best_average_score_team)
  end

  def worst_offense
    @team_manager.team_name(@game_team_manager.worst_average_score_team)
  end

  def highest_scoring_visitor
    @team_manager.team_name(@game_team_manager.best_average_score_team_away)
  end

  def highest_scoring_home_team
    @team_manager.team_name(@game_team_manager.best_average_score_team_home)
  end

  def lowest_scoring_visitor
    @team_manager.team_name(@game_team_manager.worst_average_score_team_away)
  end

  def lowest_scoring_home_team
    @team_manager.team_name(@game_team_manager.worst_average_score_team_home)
  end
end
