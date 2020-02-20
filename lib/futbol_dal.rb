require "./lib/team_collection"
require "./lib/game_team_collection"
require "./lib/game_collection"

class FutbolDAL

  def self.from_csv(csv_file_paths)
    self.new(csv_file_paths)

  end

  attr_reader :team_collection, :game_collection, :game_team_collection
  def initialize(files)
    @team_collection = TeamCollection.new(files[:team])
    @game_collection = GameCollection.new(files[:game])
    @game_team_collection = GameTeamCollection.new(files[:game_team])
    @team_collection.create_team_collection
    @game_collection.create_game_collection
    @game_team_collection.create_game_team_collection
  end

end
