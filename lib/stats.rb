class Stats 
  attr_reader :games_data, :teams_data, :game_teams_data
  
  def initialize(games_data, teams_data, game_teams_data)
    @games_data = games_data
    @teams_data = teams_data
    @game_teams_data = game_teams_data
    @percentage_results = nil
  end

end