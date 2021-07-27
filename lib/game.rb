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
  
  def initialize(stats)
    @game_id = stats[0].to_i
    @season = stats[1].to_i
    @type = stats[2]
    @date_time = stats[3]
    @away_team_id = stats[4].to_i
    @home_team_id = stats[5].to_i
    @away_goals = stats[6].to_i
    @home_goals = stats[7].to_i
    @venue = stats[8]
    @venue_link = stats[9]
  end
end
