class Game

  def initialize(row, parent)
    @parent = parent
    @game_id = row[:game_id]
    @season = row[:season]
    @type = row[:type]
    @date_time = row[:date_time].to_date
    @away_team_id = row[:away_team_id].to_i
    @home_team_id = row[:home_team_id].to_i
    @away_goals = row[:away_goals].to_i
    @home_goals = row[:home_goals].to_i
end