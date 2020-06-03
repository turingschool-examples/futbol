require_relative './game'
require_relative './team'
require_relative './game_teams'
require_relative './team_collection'
require_relative './game_collection'
require_relative './game_team_collection'
require_relative './season_stats'
require 'csv'
require 'pry'

class StatTracker
  include Loadable

  attr_reader :games_collection,
              :teams_collection,
              :game_teams_collection


  def self.from_csv(csv_files)
    game_collection = GameCollection.new(csv_files[:games])
    team_collection = TeamCollection.new(csv_files[:teams])
    game_team_collection = GameTeamCollection.new(csv_files[:game_teams])
    StatTracker.new(game_collection, team_collection, game_team_collection)
  end

  def initialize(game_collection, team_collection, game_team_collection)
    @games_collection = game_collection
    @teams_collection = team_collection
    @game_teams_collection = game_team_collection
    @season_stats = SeasonStats.new(game_collection, game_team_collection, team_collection)
  end

  def highest_total_score
    games_collection.highest_total_score
  end

  def lowest_total_score
    games_collection.lowest_total_score
  end

  def percentage_home_wins
    games_collection.percentage_home_wins
  end

  def percentage_visitor_wins
    games_collection.percentage_visitor_wins
  end

  def percentage_ties
    games_collection.percentage_ties
  end

  def count_of_games_by_season
    games_collection.count_of_games_by_season
  end

  def average_goals_per_game
    games_collection.average_goals_per_game
  end

  def average_goals_by_season
    games_collection.average_goals_by_season
  end

  def count_of_teams
    teams_collection.teams_array.count
  end

  def best_offense
    @season_stats.best_offense
  end

  def worst_offense
    @season_stats.worst_offense
  end

  def highest_scoring_visitor
    @season_stats.highest_scoring_visitor
  end

  def highest_scoring_home_team
    @season_stats.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    @season_stats.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    @season_stats.lowest_scoring_home_team
  end

  def winningest_coach(season_id)
    @season_stats.winningest_coach(season_id)
  end

  def worst_coach(season_id)
    @season_stats.worst_coach(season_id)
  end

  def most_accurate_team(season_id)
    @season_stats.most_accurate_team(season_id)
  end

  def least_accurate_team(season_id)
    @season_stats.least_accurate_team(season_id)
  end

  def most_tackles(season_id)
    @season_stats.most_tackles(season_id)
  end

  def least_tackles(season_id)
    @season_stats.least_tackles(season_id)
  end

  def team_info(team_id)
    @teams_collection.team_info(team_id)
  end

  def best_season(team_id)
    @game_teams_collection.best_season(team_id)
  end

  def worst_season(team_id)
    @game_teams_collection.worst_season(team_id)
  end

  def average_win_percentage(team_id)
    @game_teams_collection.average_win_percentage(team_id)
  end

  def most_goals_scored(team_id)
    @game_teams_collection.most_goals_scored(team_id)
  end

  def fewest_goals_scored(team_id)
    @game_teams_collection.fewest_goals_scored(team_id)
  end

  def favorite_opponent(team_id)
    @season_stats.favorite_opponent(team_id)
  end

  def rival(team_id)
    @season_stats.rival(team_id)
  end
end
