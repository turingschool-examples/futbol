class GameTeam
  attr_reader :game_id, :team_id, :goals, :hoa, :result, :tackles, :head_coach, :shots

  def initialize(game_id, team_id, goals, hoa, result, tackles, head_coach, shots)
    @game_id = game_id
    @team_id = team_id
    @goals = goals.to_f
    @hoa = hoa
    @result = result
    @tackles = tackles.to_i
    @head_coach = head_coach
    @shots = shots.to_f
  end
end