class Game
  attr_reader :game_id, :season, :away_goals, :home_goals

  def initialize(game_id,season, away_goals, home_goals)
    @game_id = game_id
    @season = season
    @away_goals = away_goals.to_i
    @home_goals = home_goals.to_i
  end
end