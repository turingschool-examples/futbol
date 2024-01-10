class Game
  attr_reader :game_id,
              :season,
              :type,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals

  def initialize(data)
    @game_id = data[:game_id].to_i
    @season = data[:season].to_i
    @type = data[:type]
    @away_team_id = data[:away_team_id]
    @home_team_id = data[:home_team_id]
    @away_goals = data[:away_goals].to_i
    @home_goals = data[:home_goals].to_i
  end
end
