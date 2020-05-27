class LeagueStats
  attr_reader :teams_collection,
              :game_teams_collection

  def initialize(file_path)
    @teams_collection = file_path[:teams_collection]
    @game_teams_collection = file_path[:game_teams_collection]
  end
end
