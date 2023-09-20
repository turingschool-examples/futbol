class Game
  attr_reader :game_id, :season, :away_goals, :home_goals, :away_team_id, :home_team_id

  def initialize(game_id,season, away_goals, home_goals, away_team_id, home_team_id)
    @game_id = game_id
    @season = season
    @away_goals = away_goals
    @home_goals = home_goals
    @away_team_id = away_team_id
    @home_team_id = home_team_id
  end
end