class Game
  attr_reader :game_id,
              :season,
              :away_team_id, 
              :home_team_id, 
              :away_goals, 
              :home_goals

  def initialize(stats)
    @game_id = stats[:game_id].to_s
    @season = stats[:season].to_s
    @away_team_id = stats[:away_team_id].to_s
    @home_team_id = stats[:home_team_id].to_s
    @away_goals = stats[:away_goals]
    @home_goals = stats[:home_goals]
  end
end