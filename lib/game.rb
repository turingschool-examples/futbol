class Game

  attr_reader :id,
              :season,
              :type,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals,
              :venue

  def initialize(info)
    @id           = info["game_id"]
    @season       = info["season"]
    @type         = info["type"]
    @away_team_id = info["away_team_id"]
    @home_team_id = info["home_team_id"]
    @away_goals   = info["away_goals"]
    @home_goals   = info["home_goals"]
    @venue        = info["venue"]
  end
end
