class Game
  def initialize(info)
    @game_id= info[:game_id]
    @season= info[:season]
    @type= info[:type]
    @away_team_id= info[:away_team_id]
    @home_team_id= info[:home_team_id]
    @away_goals= info[:away_goals]
    @home_goals= info[:home_goals]
  end
end
