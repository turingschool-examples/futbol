require "csv"
require_relative "./teams_collection"
require_relative "./games_collection"
require_relative "./game_teams_collection"

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize
    # @games = @@games
    # @teams = @@teams
    @game_teams = @@game_teams
  end

  def self.from_csv(locations)
    @@games = GamesCollection.new(locations[:games]).collection
    @@teams = TeamsCollection.new(locations[:teams]).collection

    collect_game_teams(locations[:game_teams])
    self.new
  end

  def self.collect_game_teams(location)

    game_teams = GameTeamsCollection.new(location)

    game_teams.load_csv
    @@game_teams = game_teams.collection
  end

  

end
