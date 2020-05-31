require "csv"
require_relative "./teams_collection"
require_relative "./games_collection"
require_relative "./game_teams_collection"

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize
    @games = @@games
    @teams = @@teams
    @game_teams = @@game_teams
  end

  def self.from_csv(locations)
    collect_games(locations[:games])
    collect_teams(locations[:teams])
    collect_game_teams(locations[:game_teams])
    self.new
  end

  def self.collect_game_teams(location)
    game_teams = GameTeamsCollection.new(location)
    game_teams.load_csv
    @@game_teams = game_teams.collection
  end

  def self.collect_teams(location)
    teams = TeamsCollection.new(location)
    teams.load_csv
    @@teams = teams.collection
  end

  def self.collect_games(location)
    games = GamesCollection.new(location)
    games.load_csv
    @@games = games.collection
  end

end
