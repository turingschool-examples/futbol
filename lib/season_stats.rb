class SeasonStats
  attr_reader :game_collection,
              :game_team_collection,
              :team_collection

  def initialize(game_collection, game_team_collection, team_collection)
    @game_collection = game_collection
    @game_team_collection = game_team_collection
    @team_collection = team_collection
  end
end
