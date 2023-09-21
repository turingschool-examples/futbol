class Game
  attr_reader :game_id, :season, :away_goals, :home_goals

  def initialize(game_id,season, away_goals, home_goals, away_team_id, home_team_id)
    @game_id = game_id
    @season = season
    @away_goals = away_goals.to_i
    @home_goals = home_goals.to_i
    @away_team_id = away_team_id.to_s
    @home_team_id = home_team_id.to_s
  end
end