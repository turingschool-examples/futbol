require_relative './helper'

class StatTracker
  attr_reader :game_manager,
              :team_manager,
              :game_teams_manager

  def self.from_csv(file_locations)
    new(file_locations)
  end

  def initialize(file_locations)
    @game_manager       = GameManager.new(file_locations[:games])
    @team_manager       = TeamManager.new(file_locations[:teams])
    @game_teams_manager = GameTeamsManager.new(file_locations[:game_teams])
  end

  def highest_total_score
    game_manager.highest_total_score
  end

  def lowest_total_score
    game_manager.lowest_total_score
  end

  def percentage_home_wins
    game_manager.percentage_home_wins
  end

  def percentage_visitor_wins
    game_manager.percentage_visitor_wins
  end

  def percentage_ties
    game_manager.percentage_ties
  end

  def count_of_games_by_season
    game_manager.count_of_games_by_season
  end

  def average_goals_per_game
    game_manager.average_goals_per_game
  end

  def average_goals_by_season
    game_manager.average_goals_by_season
  end

  def count_of_teams
    team_manager.count_of_teams
  end

  def best_offense
    team_manager.team_name(game_teams_manager.best_offense)
  end

  def worst_offense
    team_manager.team_name(game_teams_manager.worst_offense)
  end

  def highest_scoring_visitor
    team_manager.team_name(game_teams_manager.highest_scoring_visitor)
  end

  def highest_scoring_home_team
    team_manager.team_name(game_teams_manager.highest_scoring_home_team)
  end

  def lowest_scoring_visitor
    team_manager.team_name(game_teams_manager.lowest_scoring_visitor)
  end

  def lowest_scoring_home_team
    team_manager.team_name(game_teams_manager.lowest_scoring_home_team)
  end

  def winningest_coach(season)
    game_teams_manager.winningest_coach(game_manager.game_ids_by_season(season))
  end

  def worst_coach(season)
    game_teams_manager.worst_coach(game_manager.game_ids_by_season(season))
  end

  def most_accurate_team(season)
    team_manager.team_name(game_teams_manager.most_accurate_team(game_manager.game_ids_by_season(season)))
  end

  def least_accurate_team(season)
    team_manager.team_name(game_teams_manager.least_accurate_team(game_manager.game_ids_by_season(season)))
  end

  def most_tackles(season)
    team_manager.team_name(game_teams_manager.most_tackles(game_manager.game_ids_by_season(season)))
  end

  def fewest_tackles(season)
    team_manager.team_name(game_teams_manager.fewest_tackles(game_manager.game_ids_by_season(season)))
  end

  def team_info(id)
    team_manager.team_info(id)
  end

  def best_season(id)
    game_manager.best_season(id)
  end

  def worst_season(id)
    game_manager.worst_season(id)
  end

  def average_win_percentage(id)
    game_manager.average_win_percentage(id)
  end

  def most_goals_scored(id)
    game_manager.most_goals_scored(id)
  end

  def fewest_goals_scored(id)
    game_manager.fewest_goals_scored(id)
  end

  def favorite_opponent(id)
    team_manager.team_name(game_manager.favorite_opponent(id))
  end

  def rival(id)
    team_manager.team_name(game_manager.rival(id))
  end

  def test_with_mocks(mock)
    @game_manager = mock
    @game_teams_manager = mock
    @team_manager = mock
  end
end
