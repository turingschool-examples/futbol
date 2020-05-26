
class GameTeam

  attr_reader :game_id,
              :team_id,
              :hoa,
              :result,
              :head_coach,
              :goals,
              :shots,
              :tackles

  def initialize(info)
    @game_id    = info["game_id"]
    @team_id    = info["team_id"]
    @hoa        = info["HoA"]
    @result     = info["result"]
    @head_coach = info["head_coach"]
    @goals      = info["goals"]
    @shots      = info["shots"]
    @tackles    = info["tackles"]
  end
end
