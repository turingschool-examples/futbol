class GameTeams
  attr_reader :hoa, :result, :team_id

  def initialize(game_teams_info)
    @hoa = game_teams_info[:hoa]
    @result = game_teams_info[:result]
    @team_id = game_teams_info[:team_id]
  end
end
