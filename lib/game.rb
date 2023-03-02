class Game
  attr_reader :id,
              :season,
              :season_type,
              :date,
              :away_id,
              :home_id,
              :away_goals,
              :home_goals

  def initialize(row)
    @id = row[:game_id].to_i
    @season = row[:season]
    @season_type = row[:type]
    @date = row[:date_time]
    @away_id = row[:away_team_id].to_i
    @home_id = row[:home_team_id].to_i
    @away_goals = row[:away_goals].to_i
    @home_goals = row[:home_goals].to_i
  end
end
