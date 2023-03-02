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
    @id = row[:id].to_i
    @season = row[:season]
    @season_type = row[:season_type]
    @date = row[:date]
    @away_id = row[:away_id].to_i
    @home_id = row[:home_id].to_i
    @away_goals = row[:away_goals].to_i
    @home_goals = row[:home_goals].to_i
  end
end
