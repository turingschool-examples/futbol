class Game
  attr_reader :home_goals, :away_goals
  def initialize(row)
    @season = row[1].to_i
    @type = row[2]
    @date_time = row[3]
    @away_team_id = row[4].to_i
    @home_team_id = row[5].to_i
    @away_goals = row[6].to_i
    @home_goals = row[7].to_i
    @venue = row[8]
    @venue_link = row[9]
  end

end
