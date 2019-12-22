class Game
  attr_reader :game_id,
              :season,
              :type,
              :date_time,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals,
              :venue,
              :venue_link

  def initialize(row)
    @game_id = game_id[:game_id]
    @season = game_id[:season]
    @type = game_id[:type]
    @date_time = game_id[:date_time]
    @home_team_id = game_id[:home_team_id]
    @away_team_id = game_id[:away_team_id]
    @away_goals = game_id[:away_goals]
    @home_goals = game_id[:home_goals]
    @venue = game_id[:venue]
    @venue_link = game_id[:venue_link]
  end
end
