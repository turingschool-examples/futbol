class GameTeams
  attr_reader :game_id,
              :team_id,
              :hoa,
              :result,
              :head_coach,
              :goals,
              :shots,
              :tackles

  def initialize(hash)
    @game_id    = hash[:game_id]
    @team_id    = hash[:team_id]
    @hoa        = hash[:hoa]
    @result     = hash[:result]
    @head_coach = hash[:head_coach]
    @goals      = hash[:goals]
    @shots      = hash[:shots]
    @tackles    = hash[:tackles]
  end

  def win?
    @result == 'WIN'
  end
end
