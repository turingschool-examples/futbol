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

  def initialize(attributes)
    @game_id = attributes[:game_id]
    @team_id = attributes[:team_id]
    @hoa = attributes[:hoa]
    @result = attributes[:result]
    @settled_in = attributes[:settled_in]
    @head_coach = attributes[:head_coach]
    @goals = attributes[:goals]
    @shots = attributes[:shots]
    @tackles = attributes[:tackles]
  end
end
