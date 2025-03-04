require 'csv'  # Requires the CSV library to handle CSV file operations
require './lib/game_statistics'
require './lib/season_statistics'
require './lib/league_statistics'

class StatTracker
  attr_reader :games, :teams, :game_teams, :game_statistics :season_statistics

  # Initializes a new instance of StatTracker with games, teams, and game_teams data
  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
    @game_statistics = GameStatistics.new(games)
    @season_statistics = SeasonStatistics.new(game_teams,games,teams)
    @league_statistics = LeagueStatistics.new(games, teams, game_teams)
  end

  # Class method to create a new instance of StatTracker from CSV files
  def self.from_csv(locations)
    # Reads the games CSV file and converts headers to symbols
    games = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    # Reads the teams CSV file and converts headers to symbols
    teams = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    # Reads the game_teams CSV file and converts headers to symbols
    game_teams = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
    
    # Creates and returns a new instance of StatTracker with the read data
    self.new(games, teams, game_teams)
  end
end