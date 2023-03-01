class Game
  attr_reader :id,
              :season,
              :season_type,
              :date,
              :away_id,
              :home_id,
              :away_goals,
              :home_goals

  def initialize(game_details)
    @id = game_details[:id]
    @season = game_details[:season]
    @season_type = game_details[:season_type]
    @date = game_details[:date]
    @away_id = game_details[:away_id]
    @home_id = game_details[:home_id]
    @away_goals = game_details[:away_goals]
    @home_goals = game_details[:home_goals]
  end
end
