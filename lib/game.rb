class Game
  attr_reader :game_id, :season, :type, :date_time, :away_team_id, :home_team_id, :away_goals, :home_goals, :venue

  def initialize(details)
    @game_id = details[:game_id]
    @season  = details[:season]
    @type = details[:type]
    @date_time = details[:date_time]
    @away_team_id = details[:away_team_id]
    @home_team_id = details[:home_team_id]
    @away_goals = details[:away_goals].to_i
    @home_goals = details[:home_goals].to_i
    @venue = details[:venue]
  end
end
