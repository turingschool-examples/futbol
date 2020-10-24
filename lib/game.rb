class Game
  def initialize(row)
    @season = row[1]
    @type = row[2]
    @date_time = row[3]
    @away_team_id = row[4]
    @home_team_id = row[5]
    @away_goals = row[6]
    @home_goals = row[7]
    @venue = row[8]
    @venue_link = row[9]
  end

end
