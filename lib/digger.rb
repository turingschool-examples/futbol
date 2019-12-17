module Digger

  def team(team_id)
    @teams.find {|team| team.id == team_id}
  end

  def game(game_id)

  end

end
