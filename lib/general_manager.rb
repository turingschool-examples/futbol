require_relative 'teams_manager'
require_relative 'games_manager'
require_relative 'game_teams_manager'

class GeneralManager
  attr_reader :teams_manager, :games_manager, :game_teams_manager

  def initialize(locations)
    @teams_manager = TeamsManager.new(locations[:teams])
    @games_manager = GamesManager.new(locations[:games])
    @game_teams_manager = GameTeamsManager.new(locations[:game_teams])
  end

  def team_info(team_id)
    @teams_manager.team_info(team_id)
  end

  def count_of_teams
    @teams_manager.count_of_teams
  end

  def highest_total_score
    @games_manager.score_results(:max)
  end

  def lowest_total_score
    @games_manager.score_results(:min)
  end

  def count_of_games_by_season
    @games_manager.count_of_games_by_season
  end

  def average_goals_by_season
    @games_manager.average_goals_by_season
  end

  def average_goals_per_game
    @games_manager.average_goals_per_game
  end

  def highest_scoring_home_team
    @teams_manager.team_by_id(@games_manager.highest_scoring_home_team)
  end

  def lowest_scoring_home_team
    @teams_manager.team_by_id(@games_manager.lowest_scoring_home_team)
  end

  def highest_scoring_visitor
    @teams_manager.team_by_id(@games_manager.highest_scoring_visitor)
  end

  def lowest_scoring_visitor
    @teams_manager.team_by_id(@games_manager.lowest_scoring_visitor)
  end

  def favorite_opponent(team_id)
    @teams_manager.team_by_id(@games_manager.favorite_opponent(team_id))
  end

  def rival(team_id)
    @teams_manager.team_by_id(@games_manager.rival(team_id))
  end

  def winningest_coach(season)
    @game_teams_manager.coach_results(season)[:max].call
  end

  def worst_coach(season)
    @game_teams_manager.coach_results(season)[:min].call
  end

  def most_accurate_team(season)
    @teams_manager.team_by_id(@game_teams_manager.accuracy_results(season)[:max].call)
  end

  def least_accurate_team(season)
    @teams_manager.team_by_id(@game_teams_manager.accuracy_results(season)[:min].call)
  end

  def most_tackles(season)
    @teams_manager.team_by_id(@game_teams_manager.tackle_results(season)[:max].call)
  end

  def fewest_tackles(season)
    @teams_manager.team_by_id(@game_teams_manager.tackle_results(season)[:min].call)
  end

  def best_season(team_id)
    @game_teams_manager.season_results(team_id)[:max].call
  end

  def worst_season(team_id)
    @game_teams_manager.season_results(team_id)[:min].call
  end

  def average_win_percentage(team_id)
    @game_teams_manager.average_win_percentage(team_id)
  end

  def most_goals_scored(team_id)
    @game_teams_manager.goal_results(team_id)[:max].call
  end

  def fewest_goals_scored(team_id)
    @game_teams_manager.goal_results(team_id)[:min].call
  end

  def best_offense
    @teams_manager.team_by_id(@game_teams_manager.offense_results[:max].call)
  end

  def worst_offense
    @teams_manager.team_by_id(@game_teams_manager.offense_results[:min].call)
  end

  def percentage_home_wins
    @game_teams_manager.percentage_home_wins
  end

  def percentage_visitor_wins
    @game_teams_manager.percentage_visitor_wins
  end

  def percentage_ties
    @game_teams_manager.percentage_ties
  end
end
