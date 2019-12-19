class GameTeams
  attr_reader :team_id, :hoa, :result

  def initialize(game_teams_info)
    @team_id = game_teams_info[:team_id]
    @hoa = game_teams_info[:hoa]
    @result = game_teams_info[:result]
  end
end
