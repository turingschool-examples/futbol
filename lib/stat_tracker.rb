class StatTracker
  def initialize(game, game_team, team)
    @game = game
    @game_team = game_team
    @team = team
  end

  def average_goals_by_season
    @game.average_goals_by_season
  end
end