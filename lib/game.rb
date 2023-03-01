class Game
  attr_reader :game_id,
              :season,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals

  def initialize(game)
    @game_id = game[:game_id]
    @season = game[:season]
    @away_team_id = game[:away_team_id]
    @home_team_id = game[:home_team_id]
    @away_goals = game[:away_goals]
    @home_goals = game[:home_goals]
  end
end