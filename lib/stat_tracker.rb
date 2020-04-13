require 'csv'
require_relative 'team_collection'
require_relative 'game_stats_collection'
require_relative 'game_collection'
require_relative 'season_stats'

class StatTracker
  attr_reader :games, :teams, :game_stats

  def self.from_csv(csv_files)
    games = CSV.read(csv_files[:games], headers: true, header_converters: :symbol)
    teams = CSV.read(csv_files[:teams], headers: true, header_converters: :symbol)
    game_stats = CSV.read(csv_files[:game_teams], headers: true, header_converters: :symbol)
    StatTracker.new(games, teams, game_stats)
  end

  def initialize(game_path, team_path, game_teams_path)
    @games = game_path
    @teams = team_path
    @game_stats = game_teams_path
    @game_stats_collection = GameStatsCollection.new("./data/game_teams.csv")
    @team_collection = TeamCollection.new('./data/teams.csv')
    @game_collection = GameCollection.new('./data/games.csv')
    @season_stats = SeasonStats.new("./data/teams.csv", "./data/game_teams.csv")
  end

  def count_of_teams
    @teams.length
  end

  def best_offense
    @game_stats_collection.best_offense
  end

  def worst_offense
    @game_stats_collection.worst_offense
  end

  def highest_scoring_visitor
    @game_stats_collection.highest_scoring_visitor
  end

  def highest_scoring_home_team
    @game_stats_collection.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    @game_stats_collection.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    @game_stats_collection.lowest_scoring_home_team
  end

  def team_info(teamid)
    @team_collection.team_info(teamid)
  end

  def most_goals_scored(teamid)
    @game_stats_collection.most_goals_scored(teamid)
  end

  def fewest_goals_scored(teamid)
    @game_stats_collection.fewest_goals_scored(teamid)
  end

  def average_win_percentage(teamid)
    @game_stats_collection.average_win_percentage(teamid)
  end

  def best_season(teamid)
    @game_collection.best_season(teamid)
  end

  def worst_season(teamid)
    @game_collection.worst_season(teamid)
  end

  def favorite_opponent(teamid)
    number = @game_collection.favorite_opponent_id(teamid)
    team_info(number)["team_name"]
  end

  def rival(teamid)
    number = @game_collection.rival_id(teamid)
    team_info(number)["team_name"]

  def winningest_coach(season)
    @season_stats.winningest_coach(season)
  end

  def worst_coach(season)
    @season_stats.worst_coach(season)
  end

  def most_accurate_team(season)
    @season_stats.most_accurate_team(season)
  end

  def least_accurate_team(season)
    @season_stats.least_accurate_team(season)
  end

  def most_tackles(season)
    @season_stats.most_tackles(season)
  end

  def fewest_tackles(season)
    @season_stats.fewest_tackles(season)
  end
end
