require 'CSV'
require_relative 'game_stats'
require_relative 'game_teams_stats'
require_relative 'team_stats'
require_relative 'game'
require_relative 'game_teams'
require_relative 'team'

class StatTracker
  attr_reader :game_stats,
              :game_teams_stats,
              :team_stats

  def initialize(locations)
    @game_stats = GameStats.new(locations[:games], self)
    @game_teams_stats = GameTeamsStats.new(locations[:game_teams], self)
    @team_stats = TeamStats.new(locations[:teams], self)
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
    @team_stats.count_of_teams
  end

  def best_offense
    @team_stats.best_offense_stats
    @team_stats.best_offense
  end

  def worst_offense
    @team_stats.worst_offense_stats
    @team_stats.worst_offense
  end

  def highest_scoring_visitor
    @team_stats.team_highest_away_goals
    @team_stats.highest_scoring_visitor
  end

  def highest_scoring_home_team
    @team_stats.team_highest_home_goals
    @team_stats.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    @team_stats.team_lowest_away_goals
    @team_stats.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    @team_stats.team_lowest_home_goals
    @team_stats.lowest_scoring_home_team
  end

  def winningest_coach(season)
    @game_teams_stats.hash_of_seasons(season)
    @game_teams_stats.group_by_coach(season)
    @game_teams_stats.coach_wins(season)
    @game_teams_stats.winningest_coach(season)
  end

  def worst_coach(season)
    @game_teams_stats.hash_of_seasons(season)
    @game_teams_stats.group_by_coach(season)
    @game_teams_stats.coach_wins(season)
    @game_teams_stats.worst_coach(season)
  end

  def most_accurate_team(season)
    @game_teams_stats.hash_of_seasons(season)
    @game_teams_stats.find_by_team_id(season)
    @game_teams_stats.goals_to_shots_ratio_per_season(season)
    @game_teams_stats.find_most_accurate_team(season)
    @game_teams_stats.most_accurate_team(season)
  end

  def least_accurate_team(season)
    @game_teams_stats.hash_of_seasons(season)
    @game_teams_stats.find_by_team_id(season)
    @game_teams_stats.goals_to_shots_ratio_per_season(season)
    @game_teams_stats.find_least_accurate_team(season)
    @game_teams_stats.least_accurate_team(season)
  end

  def most_tackles(season)
    @game_teams_stats.hash_of_seasons(season)
    @game_teams_stats.find_by_team_id(season)
    @game_teams_stats.total_tackles(season)
    @game_teams_stats.find_team_with_most_tackles(season)
    @game_teams_stats.most_tackles(season)
  end

  def fewest_tackles(season)
    @game_teams_stats.hash_of_seasons(season)
    @game_teams_stats.find_by_team_id(season)
    @game_teams_stats.total_tackles(season)
    @game_teams_stats.find_team_with_fewest_tackles(season)
    @game_teams_stats.fewest_tackles(season)
  end

  def team_info(team_id)
    @team_stats.team_info(team_id)
  end

  def best_season(team_id)
    @team_stats.all_team_games(team_id)
    @team_stats.group_by_season(team_id)
    @team_stats.percent_wins_by_season(team_id)
    @team_stats.best_season(team_id)
  end

  def worst_season(team_id)
    @team_stats.all_team_games(team_id)
    @team_stats.group_by_season(team_id)
    @team_stats.percent_wins_by_season(team_id)
    @team_stats.worst_season(team_id)
  end

  def average_win_percentage(team_id)
    @team_stats.all_team_games(team_id)
    @team_stats.total_wins(team_id)
    @team_stats.average_win_percentage(team_id)
  end

  def most_goals_scored(team_id)
    @team_stats.all_team_games(team_id)
    @team_stats.most_goals_scored(team_id)
  end

  def fewest_goals_scored(team_id)
    @team_stats.all_team_games(team_id)
    @team_stats.fewest_goals_scored(team_id)
  end

  def favorite_opponent(team_id)
    @team_stats.find_all_game_ids_by_team(team_id)
    @team_stats.find_opponent_id(team_id)
    @team_stats.hash_by_opponent_id(team_id)
    @team_stats.sort_games_against_rival(team_id)
    @team_stats.find_count_of_games_against_rival(team_id)
    @team_stats.find_percent_of_winning_games_against_rival(team_id)
    @team_stats.favorite_opponent_id(team_id)
    @team_stats.favorite_opponent(team_id)
  end

  def rival(team_id)
    @team_stats.find_all_game_ids_by_team(team_id)
    @team_stats.find_opponent_id(team_id)
    @team_stats.hash_by_opponent_id(team_id)
    @team_stats.sort_games_against_rival(team_id)
    @team_stats.find_percent_of_winning_games_against_rival(team_id)
    @team_stats.rival_opponent_id(team_id)
    @team_stats.rival(team_id)
  end
end
