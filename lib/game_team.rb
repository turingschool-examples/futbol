class GameTeam
  attr_reader :game_id, :team_id, :goals, :hoa, :result, :tackles, :head_coach

  def initialize(game_id, team_id, goals, hoa, result, tackles, head_coach)
    @game_id = game_id
    @team_id = team_id
    @goals = goals
    @hoa = hoa
    @result = result
    @tackles = tackles.to_i
    @head_coach = head_coach
  end
end