class Game
  attr_reader :game_id, :team_id, :goals

  def initialize(game_id, team_id, goals)
    @game_id = game_id
    @team_id = team_id
    @goals = goals
  end

end