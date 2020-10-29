class GameTeams
  attr_reader :parent,
              :game_id,
              :team_id,
              :hoa,
              :result,
              :settled_in,
              :head_coach,
              :goals,
              :shots,
              :tackles
  def initialize(row, parent)
    @parent     = parent
    @game_id    = row[:game_id]
    @team_id    = row[:team_id].to_i
    @hoa        = row[:hoa]
    @result     = row[:result]
    @settled_in = row[:settled_in]
    @head_coach = row[:head_coach]
    @goals      = row[:goals].to_i
    @shots      = row[:shots].to_i
    @tackles    = row[:tackles].to_i
  end
end
