class GameTeamsHelper
  def initialize(manager)
    @manager = manager
  end

  def total_goals(team_id)
    @manager.games_played(team_id).sum do |game|
      game.goals
    end.to_f
  end
end
