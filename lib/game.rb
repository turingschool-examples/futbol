class Game
  attr_reader :game_id,
              :season,
              :season_type,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals
  def initialize(game_info)
    @game_id = game_info[:game_id]
    @season = game_info[:season]
    @season_type = game_info[:type]
    @away_team_id = game_info[:away_team_id]
    @home_team_id = game_info[:home_team_id]
    @away_goals = game_info[:away_goals].to_i
    @home_goals = game_info[:home_goals].to_i
  end
end