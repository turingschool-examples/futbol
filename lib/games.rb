class Game
  attr_reader :game_id,
              :season,
              :type,
              :date_time,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals,
              :venue

  def initialize(game_path)
    @game_id = game_path[:game_id]
    @season = game_path[:season]
    @type = game_path[:type]
    @date_time = game_path[:date_time]
    @away_team_id = game_path[:away_team_id].to_i
    @home_team_id = game_path[:home_team_id].to_i
    @away_goals = game_path[:away_goals].to_i
    @home_goals = game_path[:home_goals].to_i
    @venue = game_path[:venue]
  end



end
