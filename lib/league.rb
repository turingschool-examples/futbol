class League
  attr_reader :team_id,
              :team_name
  
  def initialize(locations)
  
    team_file = CSV.read locations[:teams], headers: true, header_converters: :symbol
    game_team_file = CSV.read locations[:game_teams], headers: true, header_converters: :symbol
    @team_id = team_file[:team_id]
    @team_name = team_file[:teamname]
  end

  def count_of_teams
    @team_id.count
  end
end