class StatTracker
  attr_reader :game_collection, :team_collection, :gtc
  def initialize(locations)
    @game_file_path = locations[:games]
    @teams_file_path = locations[:teams]
    @game_teams_file_path = locations[:game_teams]
    @gtc = nil
    @game_collection = nil
    @team_collection = nil
  end

  def load_game_team_data
    @gtc = GameTeamsCollection.new(@game_teams_file_path)
  end

  def load_game_data
    @game_collection = GameCollection.new(@game_file_path)
  end

  def load_team_data
    @team_collection = TeamCollection.new(@teams_file_path)
  end

end
