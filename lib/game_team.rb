class GameTeam
  attr_reader :game_id, :team_id, :goals, :hoa, :result

  def initialize(game_id, team_id, goals, hoa, result)
    @game_id = game_id
    @team_id = team_id
    @goals = goals
    @hoa = hoa
    @result = result
  end
end