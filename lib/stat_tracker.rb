require "csv"
require "./lib/games_statistics_collection"
require "./lib/game_teams_statistics_collection"
require "./lib/teams_statistics_collection"

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize
    @games = games_collection
    @teams = teams_collection
    @game_teams = game_teams_collection
  end

  def self.from_csv(file_path_locations)
    @@games_path = file_path_locations[:games]
    @@teams_path = file_path_locations[:teams]
    @@game_teams_path = file_path_locations[:game_teams]
    self.new
  end

  def games_collection
    GameStatisticsCollection.new(@@games_path).collection
  end

  def teams_collection
    TeamsStatisticsCollection.new(@@teams_path).collection
  end

  def game_teams_collection
    GameTeamsStatisticsCollection.new(@@game_teams_path).collection
  end

end
