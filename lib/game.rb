class Game

  attr_reader :game_id, :season, :type, :date_time, :away_team_id,
              :home_team_id, :away_goals, :home_goals, :venue,
              :venue_link
  def initialize(game_info)
    @game_id = game_info[0]
    @season = game_info[1]
    @type = game_info[2]
    @date_time = game_info[3]
    @away_team_id = game_info[4]
    @home_team_id = game_info[5]
    @away_goals = game_info[6]
    @home_goals = game_info[7]
    @venue = game_info[8]
    @venue_link = game_info[9]
  end
end