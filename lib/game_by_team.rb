class Game_By_Team
  attr_reader :game_id,
              :team_id,
              :hoa,
              :result,
              :settled_in,
              :head_coach,
              :goals,
              :shots,
              :tackles

  def initialize(row)
    @game_id      = row[:game_id]
    @team_id      = row[:team_id]
    @hoa          = row[:hoa]
    @result       = row[:result]
    @settled_in   = row[:settled_in]
    @head_coach   = row[:head_coach]
    @goals        = row[:goals]
    @shots        = row[:shots]
    @tackles      = row[:tackles]
  end
end


