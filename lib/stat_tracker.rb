require './lib/game_collection'
require './lib/team_collection'
require './lib/game_team_collection'

class StatTracker
  attr_reader :game_collection,
              :team_collection,
              :game_team_collection

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    load_collections(locations)
  end

  def load_collections(locations)
    @game_collection = GameCollection.new(locations[:games], self)
    @team_collection = TeamCollection.new(locations[:teams], self)
    @game_team_collection = GameTeamCollection.new(locations[:game_teams], self)
  end
# LeagueStatistics
  def find_team_name(team_id)
    @team_collection.find_team_name(team_id)
  end
end
