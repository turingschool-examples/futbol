# use require_relative
class Game 
initialize games.csv
#^this was in the miro board so I included it but I'm not sure where it goes/if it needs more to it, etc.

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

  def initialize(row_info)
    @game_id = row_info[:game_id]
    @season = row_info[:season]
    @type = row_info[:type]
    @date_time = row_info[:date_time]
    @away_team_id = row_info[:away_team_id]
    @home_team_id = row_info[:home_team_id]
    @away_goals = row_info[:away_goals]
    @home_goals = row_info[:home_goals]
    @venue = row_info[:venue]
    @venue_link = row_info[:venue_link]
  end
end
