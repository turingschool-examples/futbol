class GameTeams
  attr_reader :game_id,
              :team_id,
              :hoa,
              :result,
              :head_coach,
              :goals,
              :tackles

  def initialize(game_id, team_id, hoa, result, head_coach, goals, tackles)
    @game_id = game_id
    @team_id = team_id
    @hoa = hoa
    @result = result
    @head_coach = head_coach
    @goals = goals
    @tackles = tackles
  end
end