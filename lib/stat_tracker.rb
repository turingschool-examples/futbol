class StatTracker
  attr_reader :game_collection, :gtc
  def initialize(locations)
    @game_data = locations[:games]
    @teams_data = locations[:teams]
    @game_teams_data = locations[:game_teams]
    @gtc = nil
  end

  def load_game_team_data
    @gtc = GameTeamsCollection.new(@game_teams_data)
  end

end
