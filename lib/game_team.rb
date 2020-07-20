class GameTeam

  attr_reader :game_id, :team_id, :hoa, :result, :settled_in, :head_coach, :goals

  def initialize(game_team_param)
    @game_id = game_team_param[:game_id]
    @team_id = game_team_param[:team_id]
    @hoa = game_team_param[:hoa]
    @result = game_team_param[:result]
    @settled_in = game_team_param[:settled_in]
    @head_coach = game_team_param[:head_coach]
    @goals = game_team_param[:goals].to_i
  end


end
