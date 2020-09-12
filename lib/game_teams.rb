class GameTeams
  attr_reader :game_id,
              :team_id,
              :hoa,
              :result,
              :settled_in,
              :head_coach,
              :goals,
              :shots,
              :tackles

  def initialize(game_teams_data, manager)
    @game_id    = game_teams_data[:game_id]
    @team_id    = game_teams_data[:team_id]
    @hoa        = game_teams_data[:hoa]
    @result     = game_teams_data[:result]
    @settled_in = game_teams_data[:settled_in]
    @head_coach = game_teams_data[:head_coach]
    @goals      = game_teams_data[:goals]
    @shots      = game_teams_data[:shots]
    @tackles    = game_teams_data[:tackles]
  end
end
