class Game
  attr_reader :game_id, :season, :type, :away_team_id,
              :home_team_id, :away_goals, :home_goals

  def initialize(attributes)
    @game_id = attributes[:game_id]
    @season = attributes[:season]
    @type = attributes[:type]
    @away_team_id = attributes[:away_team_id].to_i
    @home_team_id = attributes[:home_team_id].to_i
    @away_goals = attributes[:away_goals].to_i
    @home_goals = attributes[:home_goals].to_i
  end
end
