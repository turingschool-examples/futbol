class GameTeam
  attr_reader :game_id, :team_id, :hoa, :result, :settled_in,
              :head_coach, :goals, :shots, :tackles

  def initialize(attributes)
    @game_id = attributes[:game_id].to_i
    @team_id = attributes[:team_id].to_i
    @hoa = attributes[:hoa]
    @result = attributes[:result]
    @settled_in = attributes[:settled_in]
    @head_coach = attributes[:head_coach]
    @goals = attributes[:goals].to_i
    @shots = attributes[:shots].to_i
    @tackles = attributes[:tackles].to_i
  end
end
