require "csv"
require_relative "./teams_statistics_collection"
require_relative "./games_statistics_collection"
require_relative "./game_teams_statistics_collection"

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
    @games = GameStatisticsCollection.new(file_path_locations[:games]).collection
    @teams = TeamsStatisticsCollection.new(file_path_locations[:teams]).collection
    @game_teams = GameTeamsStatisticsCollection.new(file_path_locations[:game_teams]).collection
    self.new
  end

end
