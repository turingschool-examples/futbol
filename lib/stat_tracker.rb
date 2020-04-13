require_relative './game'
require_relative './team'
require_relative './game_team'
require_relative './game_statistics'
require_relative './league_statistics'
require_relative './team_statistics'
require_relative './season_statistics'
require 'CSV'
require 'pry'
class StatTracker
  attr_reader :games, :teams, :game_teams, :league_statistics, :game_statistics, :team_statistics, :season_statistics
  def initialize(data_files)
    @games = data_files[:games]
    @teams = data_files[:teams]
    @game_teams = data_files[:game_teams]

    @game_collection = create_games
    @game_teams_collection = create_game_teams
    @teams_collection = create_teams

    @league_statistics = LeagueStatistics.new(@game_collection, @game_teams_collection, @teams_collection)
    @game_statistics = GameStatistics.new(@game_collection, @game_teams_collection, @teams_collection)
    @team_statistics = TeamStatistics.new(@game_collection, @game_teams_collection, @teams_collection)
    @season_statistics = SeasonStatistics.new(@game_collection, @game_teams_collection, @teams_collection)
  end

  def self.from_csv(data_files)
      StatTracker.new(data_files)
  end

  def create_games
    csv_games = CSV.read(@games, headers: true, header_converters: :symbol)
    csv_games.map { |row| Game.new(row) }
  end

  def create_game_teams
    csv_game_teams = CSV.read(@game_teams, headers: true, header_converters: :symbol)
    csv_game_teams.map { |row| GameTeam.new(row) }
  end

  def create_teams
    csv_teams = CSV.read(@teams, headers: true, header_converters: :symbol)
    csv_teams.map { |row| Team.new(row) }
  end

  def highest_total_score
    @game_statistics.total_score("high")
  end

  def lowest_total_score
    @game_statistics.total_score("low")
  end

  def percentage_home_wins
    @game_statistics.percentage_outcomes("home")
  end

  def percentage_visitor_wins
    @game_statistics.percentage_outcomes("away")
  end

  def percentage_ties
    @game_statistics.percentage_outcomes("tie")
  end

  def count_of_games_by_season
    @game_statistics.count_of_games_by_season
  end

  def average_goals_per_game
    @game_statistics.average_goals_per_game
  end

  def average_goals_by_season
    @game_statistics.average_goals_by_season
  end

  def count_of_teams
    @league_statistics.count_of_teams
  end

  def best_offense
    @league_statistics.best_offense
  end

  def worst_offense
    @league_statistics.worst_offense
  end

  def highest_scoring_visitor
    @league_statistics.highest_scoring_visitor
  end

  def lowest_scoring_visitor
    @league_statistics.lowest_scoring_visitor
  end

  def highest_scoring_home_team
    @league_statistics.highest_scoring_home_team
  end

  def lowest_scoring_home_team
    @league_statistics.lowest_scoring_home_team
  end

  def team_info(team_id)
    @team_statistics.team_info(team_id)
  end

  def best_season(team_id)
    @team_statistics.best_season(team_id)
  end

  def worst_season(team_id)
    @team_statistics.worst_season(team_id)
  end

  def average_win_percentage(team_id)
    @team_statistics.average_win_percentage(team_id)
  end

  def most_goals_scored(team_id)
    @team_statistics.most_goals_scored(team_id)
  end

  def fewest_goals_scored(team_id)
    @team_statistics.fewest_goals_scored(team_id)
  end

  def favorite_opponent(team_id)
    @team_statistics.opponent_preference(team_id, "high")
  end

  def rival(team_id)
    @team_statistics.opponent_preference(team_id, "low")
  end

  def winningest_coach(season)
    @season_statistics.coach_win_loss_results(season, "high")
  end

  def worst_coach(season)
    @season_statistics.coach_win_loss_results(season, "low")
  end

  def most_tackles(season)
    @season_statistics.most_least_tackles(season, "high")
  end

  def fewest_tackles(season)
    @season_statistics.most_least_tackles(season, "low")
  end

  def most_accurate_team(season)
  @season_statistics.team_accuracy(season,"high")
  end

  def least_accurate_team(season)
  @season_statistics.team_accuracy(season, "low")
  end
end
