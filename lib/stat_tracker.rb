require './lib/game'
require './lib/team'
require './lib/game_team'
require './lib/game_statistics'
require 'CSV'
require 'pry'
class StatTracker
  attr_reader :games, :teams, :game_teams, :game_statistics

  def initialize(data_files)
    @games = data_files[:games]
    @teams = data_files[:teams]
    @game_teams = data_files[:game_teams]

    @game_collection = create_games
    @game_teams_collection = create_game_teams
    @teams_collection = create_teams

    @game_statistics = GameStatistics.new(@game_collection, @game_teams_collection, @teams_collection)
    #@leagues_statistics = LeaguesStatistics.new(@game_collection, @game_teams_collection, @teams_collection)
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
end
