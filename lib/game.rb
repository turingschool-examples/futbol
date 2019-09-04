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

  def initialize(info)
    @game_id = info[0]
    @season = info[1]
    @type = info[2]
    @date_time = info[3]
    @away_team_id = info[4]
    @home_team_id = info[5]
    @away_goals = info[6]
    @home_goals = info[7]
    @venue = info[8]
    @venue_link = info[9]
  end
end
