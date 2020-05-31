class GameTeam
  attr_reader :game_id, :team_id, :hoa, :result, :settled_in, :head_coach, :goals

  def initialize(game_team_params)
    @game_id = game_team_params[:game_id]
    @team_id = game_team_params[:team_id].to_i
    @hoa = game_team_params[:hoa]
    @result = game_team_params[:result]
    @settled_in = game_team_params[:settled_in]
    @head_coach = game_team_params[:head_coach]
    @goals = game_team_params[:goals].to_i
  end
end
