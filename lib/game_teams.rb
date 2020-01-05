class GameTeams
  attr_reader :team_id, :hoa, :result, :goals

  def initialize(game_teams_info)
    @team_id = game_teams_info[:team_id]
    @hoa = game_teams_info[:hoa]
    @result = game_teams_info[:result]
    @goals = game_teams_info[:goals]
  end

end
