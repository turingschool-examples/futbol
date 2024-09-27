class FutbolData
  attr_reader :teams_data, :game_teams_data
  
  def initialize(teams_data, game_teams_data)
    @teams_data = teams_data
    @game_teams_data = game_teams_data
  end
end