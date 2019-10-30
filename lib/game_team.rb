class GameTeam
  attr_reader :team_id, :HoA, :result, :goals

  def initialize(game_teams_info)

    @team_id = game_teams_info[:team_id].to_i
    @HoA = game_teams_info[:hoa]
    @result = game_teams_info[:result]
    @goals = game_teams_info[:goals].to_i
  end
end
