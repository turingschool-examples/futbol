# Psuedocode
# ------------
# this Game Class will only feature game attributes, no methods.
class Game
  attr_reader :game_id,
              :away_team_id,
              :home_team_id,
              :home_team_goals,
              :away_team_goals,
              :season

  def initialize(details)
    @game_id = details[:game_id]
    @away_team_id = details[:away_team_id]
    @home_team_id = details[:home_team_id]
    @home_goals = details[:home_goals]
    @away_goals = details[:away_goals]
    @season = details[:season]
  end
end