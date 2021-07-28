class GameTeam
  attr_reader :team_id,
              :hoa,
              :result,
              :head_coach,
              :goal,
              :shots,
              :tackles

  def initialize(params)
    @team_id = params[:team_id]
    @hoa = params[:hoa]
    @result = params[:result]
    @head_coach = params[:head_coach]
    @goals = params[:goals]
    @shots = params[:shots]
    @tackles = params[:tackles]
  end
end
