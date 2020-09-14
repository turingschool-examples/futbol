require 'CSV'
require_relative 'game_stats'
require_relative 'team_manager'
require_relative 'game_teams_manager'
require_relative 'game'
require_relative 'game_teams'
require_relative 'team'

class StatTracker
  attr_reader :game_stats,
              :game_teams_manager,
              :team_manager

  def initialize(locations)
    @game_stats = GameStats.new(locations[:games], self)
    @game_teams_manager = GameTeamsManager.new(locations[:game_teams], self)
    @team_manager = TeamManager.new(locations[:teams], self)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def highest_total_score
    @game_stats.highest_total_score
  end

  def lowest_total_score
    @game_stats.lowest_total_score
  end

  def percentage_home_wins
    @game_stats.percentage_home_wins
  end

  def percentage_visitor_wins
    @game_stats.percentage_visitor_wins
  end

  def percentage_ties
    @game_stats.percentage_ties
  end

  def count_of_games_by_season
    @game_stats.count_of_games_by_season
  end

  def average_goals_per_game
    @game_stats.average_goals_per_game
  end

  def average_goals_by_season
    @game_stats.average_goals_by_season
  end

  def count_of_teams
    @team_manager.count_of_teams
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
    @game_teams_manager.hash_of_seasons(season)
    @game_teams_manager.group_by_coach(season)
    @game_teams_manager.coach_wins(season)
    @game_teams_manager.winningest_coach(season)
  end

  def worst_coach(season)
    @game_teams_manager.hash_of_seasons(season)
    @game_teams_manager.group_by_coach(season)
    @game_teams_manager.coach_wins(season)
    @game_teams_manager.worst_coach(season)
  end

  def most_accurate_team(season)
    @game_teams_manager.hash_of_seasons(season)
    @game_teams_manager.find_by_team_id(season)
    @game_teams_manager.goals_to_shots_ratio_per_season(season)
    @game_teams_manager.find_most_accurate_team(season)
    @game_teams_manager.most_accurate_team(season)
  end

  def least_accurate_team(season)
    @game_teams_manager.hash_of_seasons(season)
    @game_teams_manager.find_by_team_id(season)
    @game_teams_manager.goals_to_shots_ratio_per_season(season)
    @game_teams_manager.find_least_accurate_team(season)
    @game_teams_manager.least_accurate_team(season)
  end

  def most_tackles(season)
    @game_teams_manager.hash_of_seasons(season)
    @game_teams_manager.find_by_team_id(season)
    @game_teams_manager.total_tackles(season)
    @game_teams_manager.find_team_with_most_tackles(season)
    @game_teams_manager.most_tackles(season)
  end

  def fewest_tackles(season)
    @game_teams_manager.hash_of_seasons(season)
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

  def average_win_percentage(team_id)
    @team_manager.all_team_games(team_id)
    @team_manager.total_wins(team_id)
    @team_manager.average_win_percentage(team_id)
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
