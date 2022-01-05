require 'csv'
class Game
  attr_reader :game_id,
              :type,
              :date_time,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals,
              :venue,
              :venue_link,
              :season
  def initialize(game_id,type,date_time,away_team_id,home_team_id,away_goals,home_goals,venue,venue_link,season)
    @game_id = game_id
    @type = type
    @date_time = date_time
    @away_team_id = away_team_id
    @home_team_id = home_team_id
    @away_goals = away_goals
    @home_goals = home_goals
    @venue = venue
    @venue_link = venue
    @season = season
  end

end
