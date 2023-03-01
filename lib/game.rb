class Game
  attr_reader :id,
              :season,
              :season_type, 
              :date,
              :away_id, 
              :home_id,
              :away_goals,
              :home_goals
  def initialize(data)
    @id = data[:id]
    @season = data[:season]
    @season_type = data[:season_type]
    @date  = data[:date]
    @away_id = data[:away_id]
    @home_id = data[:home_id]
    @away_goals = data[:away_goals]
    @home_goals = data[:home_goals]
  end
end