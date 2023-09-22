class GameTeam
  attr_reader :game_id, :team_id, :goals, :hoa, :result, :tackles

  def initialize(game_id, team_id, goals, hoa, result, tackles)
    @game_id = game_id
    @team_id = team_id
    @goals = goals
    @hoa = hoa
    @result = result
    @tackles = tackles.to_i
  end
end