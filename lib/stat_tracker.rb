require 'CSV'
require_relative './game'
require_relative './team'
require_relative './game_teams'
require_relative './league_statistics'
require_relative './team_statistics'
require_relative './game_statistics'
require_relative './season_statistics'

class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize (games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)

    games = []
    teams = []
    game_teams = []

    CSV.foreach(locations[:games], headers: true, header_converters: :symbol) do |row|
      headers ||= row.headers

      games << Game.new(row)
    end

    CSV.foreach(locations[:teams], headers: true, header_converters: :symbol) do |row|
      headers ||= row.headers

      teams << Team.new(row)
    end

    CSV.foreach(locations[:game_teams], headers: true, header_converters: :symbol) do |row|
      headers ||= row.headers

      game_teams << GameTeams.new(row)
    end

    StatTracker.new(games, teams, game_teams)
  end

  def game_statistics
    GameStatistics.new(@games, @teams, @game_teams)
  end

  def season_statistics
    SeasonStatistics.new(@games, @teams, @game_teams)
  end

  def league_statistics
    LeagueStatistics.new(@games, @teams, @game_teams)
  end

  def team_statistics
    TeamStatistics.new(@games, @teams, @game_teams)
  end

  def highest_total_score
    game_statistics.highest_total_score
  end

  def lowest_total_score
    game_statistics.lowest_total_score
  end

  def percentage_home_wins
    game_statistics.percentage_home_wins
  end

  def percentage_visitor_wins
    game_statistics.percentage_visitor_wins
  end

  def percentage_ties
    game_statistics.percentage_ties
  end

  def home_team_wins
    game_statistics.home_team_wins
  end

  def visitor_team_wins
    game_statistics.visitor_team_wins
  end

  def ties
    game_statistics.ties
  end

  def count_of_games_by_season
    game_statistics.count_of_games_by_season
  end

  def average_goals_per_game
    game_statistics.average_goals_per_game
  end

  def total_goals_by_season
    game_statistics.total_goals_by_season
  end

  def average_goals_by_season
    game_statistics.average_goals_by_season
  end

  def most_accurate_team(season)
    season_statistics.most_accurate_team(season)
  end

  def least_accurate_team(season)
    season_statistics.least_accurate_team(season)
  end

  def winningest_coach(season)
    season_statistics.winningest_coach(season)
  end

  def worst_coach(season)
    season_statistics.worst_coach(season)
  end

  def most_tackles(season)
    season_statistics.most_tackles(season)
  end

  def fewest_tackles(season)
    season_statistics.fewest_tackles(season)
  end

  #league statistics methods

  def count_of_teams
    league_statistics.count_of_teams
  end

  def best_offense
    league_statistics.best_offense
  end

  def worst_offense
    league_statistics.worst_offense
  end

  def highest_scoring_visitor
    league_statistics.highest_scoring_visitor
  end

  def lowest_scoring_visitor
    league_statistics.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    league_statistics.lowest_scoring_home_team
  end

  def highest_scoring_home_team
    league_statistics.highest_scoring_home_team
  end

  #team statistics methods

  def team_info(team_id)
    team_statistics.team_info(team_id)
  end

  def best_season(team_id)
    team_statistics.best_season(team_id)
  end

  def worst_season(team_id)
    team_statistics.worst_season(team_id)
  end

  def average_win_percentage(team_id)
    team_statistics.average_win_percentage(team_id)
  end

  def most_goals_scored(team_id)
    team_statistics.most_goals_scored(team_id)
  end

  def fewest_goals_scored(team_id)
    team_statistics.fewest_goals_scored(team_id)
  end

  def favorite_opponent(team_id)
    team_statistics.favorite_opponent(team_id)
  end

  def rival(team_id)
    team_statistics.rival(team_id)
  end


end
