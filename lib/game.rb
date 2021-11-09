class Game
  attr_reader :away_goals,
              :away_team_id,
              :date_time,
              :game_id,
              :season,
              :type,
              :home_goals,
              :venue,
              :venue_link,
              :home_team_id

  def initialize(data)
    @away_goals   = data[:away_goals]
    @away_team_id = data[:away_team_id]
    @home_team_id = data[:home_team_id]
    @date_time    = data[:date_time]
    @game_id      = data[:game_id]
    @home_goals   = data[:home_goals]
    @season       = data[:season]
    @type         = data[:type]
    @venue        = data[:venue]
    @venue_link   = data[:venue_link]
  end
end
