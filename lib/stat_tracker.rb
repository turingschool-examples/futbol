require 'csv'
require_relative './game'
require_relative './game_manager'
require_relative './game_team_manager'
require_relative './game_team'
require_relative './team'
require_relative './team_manager'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(games, teams, game_teams, locations)
    @games = games
    @teams = teams
    @game_teams = game_teams
    @game_manager = GameManager.new(locations[:games], self)
    @game_team_manager = GameTeamManager.new(locations[:game_teams], self)
    @team_manager = TeamManager.new(locations[:teams], self)
  end

  def self.from_csv(locations)
    games = CSV.read(locations[:games], headers:true)
    teams = CSV.read(locations[:teams], headers:true)
    game_teams = CSV.read(locations[:game_teams], headers:true)

    new(games, teams, game_teams, locations)
  end
  #-------traffic cop methods-------#
  def find_winningest_coach(game_ids, expected_result)
    @game_team_manager.find_winningest_coach(game_ids, expected_result)
  end

  def find_worst_coach(game_ids)
    @game_team_manager.find_worst_coach(game_ids)
  end
  #-----end traffic cop methods-----#
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
    @game_team_manager.best_offense
  end

  def get_team_name(team_id)
    @team_manager.get_team_name(team_id)
  end

  def worst_offense
    @game_team_manager.worst_offense
  end

  def highest_scoring_visitor
    @game_manager.highest_scoring_visitor
  end

  def highest_scoring_home_team
    @game_manager.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    @game_manager.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    @game_manager.lowest_scoring_home_team
  end

  def winningest_coach(season)
    @game_manager.winningest_coach(season)
  end

  def worst_coach(season)
    @game_manager.worst_coach(season)
  end

  def get_season_game_ids(season)
    @game_manager.get_season_game_ids(season)
  end

  def most_accurate_team(season)
    @game_team_manager.most_accurate_team(season)
  end

  def least_accurate_team(season)
    @game_team_manager.least_accurate_team(season)
  end

  def most_tackles(season)
    @game_team_manager.most_tackles(season)
  end

  def fewest_tackles(season)
    @game_team_manager.fewest_tackles(season)
  end

  def team_info(team_id)
    @team_manager.team_info(team_id)
  end

  def best_season(team_id)
    @game_manager.best_season(team_id)
  end

  def worst_season(team_id)
    @game_manager.worst_season(team_id)
  end

  def average_win_percentage(team_id)
    @game_team_manager.average_win_percentage(team_id)
  end

  def most_goals_scored(team_id)
    @game_team_manager.most_goals_scored(team_id)
  end

  def fewest_goals_scored(team_id)
    @game_team_manager.fewest_goals_scored(team_id)
  end

  def favorite_opponent(team_id)
    @game_team_manager.favorite_opponent(team_id)
  end

  def rival(team_id)
    @game_team_manager.rival(team_id)
  end
end
