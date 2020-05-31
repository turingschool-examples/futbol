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

  def self.from_csv(file_path_locations)
    @@games = GamesCollection.new(file_path_locations[:games]).collection
    @@teams = TeamsCollection.new(file_path_locations[:teams]).collection
    @@game_teams = GameTeamsCollection.new(file_path_locations[:game_teams]).collection
    self.new
  end

end
