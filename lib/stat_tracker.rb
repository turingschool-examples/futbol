require 'CSV'
require_relative 'relative_helper'

class StatTracker
  include Calculatable
  include Hashable
  include Groupable
  attr_reader :game_manager, :game_teams_manager, :team_manager

  def initialize(locations)
    @game_manager = GameManager.new(locations[:games], self)
    @game_teams_manager = GameTeamsManager.new(locations[:game_teams], self)
    @team_manager = TeamManager.new(locations[:teams], self)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def best_offense
    @team_manager.best_offense_stats
    @team_manager.best_offense
  end

  def worst_offense
    @team_manager.worst_offense_stats
    @team_manager.worst_offense
  end

  def highest_scoring_visitor
    @team_manager.team_highest_away_goals
    @team_manager.highest_scoring_visitor
  end

  def highest_scoring_home_team
    @team_manager.team_highest_home_goals
    @team_manager.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    @team_manager.team_lowest_away_goals
    @team_manager.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    @team_manager.team_lowest_home_goals
    @team_manager.lowest_scoring_home_team
  end

  def winningest_coach(season)
    @game_teams_manager.games_from_season(season)
    @game_teams_manager.group_by_coach(season)
    @game_teams_manager.coach_wins(season)
    @game_teams_manager.winningest_coach(season)
  end

  def worst_coach(season)
    @game_teams_manager.games_from_season(season)
    @game_teams_manager.group_by_coach(season)
    @game_teams_manager.coach_wins(season)
    @game_teams_manager.worst_coach(season)
  end

  def most_accurate_team(season)
    @game_teams_manager.games_from_season(season)
    @game_teams_manager.find_by_team_id(season)
    @game_teams_manager.goals_to_shots_ratio_per_season(season)
    @game_teams_manager.find_most_accurate_team(season)
    @game_teams_manager.most_accurate_team(season)
  end

  def least_accurate_team(season)
    @game_teams_manager.games_from_season(season)
    @game_teams_manager.find_by_team_id(season)
    @game_teams_manager.goals_to_shots_ratio_per_season(season)
    @game_teams_manager.find_least_accurate_team(season)
    @game_teams_manager.least_accurate_team(season)
  end

  def most_tackles(season)
    @game_teams_manager.games_from_season(season)
    @game_teams_manager.find_by_team_id(season)
    @game_teams_manager.total_tackles(season)
    @game_teams_manager.find_team_with_most_tackles(season)
    @game_teams_manager.most_tackles(season)
  end

  def fewest_tackles(season)
    @game_teams_manager.games_from_season(season)
    @game_teams_manager.find_by_team_id(season)
    @game_teams_manager.total_tackles(season)
    @game_teams_manager.find_team_with_fewest_tackles(season)
    @game_teams_manager.fewest_tackles(season)
  end

  def team_info(team_id)
    @team_manager.team_info(team_id)
  end

  def best_season(team_id)
    @team_manager.all_team_games(team_id)
    @team_manager.group_by_season(team_id)
    @team_manager.percent_wins_by_season(team_id)
    @team_manager.best_season(team_id)
  end

  def worst_season(team_id)
    @team_manager.all_team_games(team_id)
    @team_manager.group_by_season(team_id)
    @team_manager.percent_wins_by_season(team_id)
    @team_manager.worst_season(team_id)
  end

  def most_goals_scored(team_id)
    @team_manager.all_team_games(team_id)
    @team_manager.most_goals_scored(team_id)
  end

  def fewest_goals_scored(team_id)
    @team_manager.all_team_games(team_id)
    @team_manager.fewest_goals_scored(team_id)
  end

  def favorite_opponent(team_id)
    @team_manager.find_all_game_ids_by_team(team_id)
    @team_manager.find_opponent_id(team_id)
    @team_manager.hash_by_opponent_id(team_id)
    @team_manager.sort_games_against_rival(team_id)
    @team_manager.find_count_of_games_against_rival(team_id)
    @team_manager.find_percent_of_winning_games_against_rival(team_id)
    @team_manager.favorite_opponent_id(team_id)
    @team_manager.favorite_opponent(team_id)
  end

  def rival(team_id)
    @team_manager.find_all_game_ids_by_team(team_id)
    @team_manager.find_opponent_id(team_id)
    @team_manager.hash_by_opponent_id(team_id)
    @team_manager.sort_games_against_rival(team_id)
    @team_manager.find_percent_of_winning_games_against_rival(team_id)
    @team_manager.rival_opponent_id(team_id)
    @team_manager.rival(team_id)
  end
end
