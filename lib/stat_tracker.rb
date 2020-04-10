require_relative './game'
require_relative './team'
require_relative './game_team'
rrequire_relative './game_statistics'
rrequire_relative './lib/league_statistics'
require 'CSV'
require 'pry'
class StatTracker
  attr_reader :games, :teams, :game_teams, :league_statistics, :game_statistics
  def initialize(data_files)
    @games = data_files[:games]
    @teams = data_files[:teams]
    @game_teams = data_files[:game_teams]

    @game_collection = create_games
    @game_teams_collection = create_game_teams
    @teams_collection = create_teams

    @league_statistics = LeagueStatistics.new(@game_collection, @game_teams_collection, @teams_collection)
    @game_statistics = GameStatistics.new(@game_collection, @game_teams_collection, @teams_collection)

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
    @game_statistics.highest_total_score
  end

  def lowest_total_score
    @game_statistics.lowest_total_score
  end

  def percentage_home_wins
    @game_statistics.percentage_home_wins
  end

  def percentage_ties
    @game_statistics.percentage_ties
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

end
