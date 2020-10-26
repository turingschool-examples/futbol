class Game
  attr_reader :game_id, :season, :type, :date_time, :away_team_id, :home_team_id, :away_goals, :home_goals, :venue, :venue_link

  def initialize(game_id,season,type,date_time,away_team_id,home_team_id,away_goals,home_goals,venue,venue_link)
    @game_id = game_id.to_i
    @season = season
    @type = type
    @date_time = date_time
    @away_team_id = away_team_id.to_i
    @home_team_id = home_team_id.to_i
    @away_goals = away_goals.to_i
    @home_goals = home_goals.to_i
    @venue = venue
    @venue_link = venue_link
  end

  def total_score
    away_goals + home_goals
  end

end
