require 'Time'

class Games
  attr_reader :game_id, :season, :type, :date_time, :away_team_id,
  :home_team_id, :away_goals, :home_goals, :venue, :venue_link

  def initialize(games_info)
    @game_id = games_info[:game_id].to_i
    @season = games_info[:season].to_i
    @type = games_info[:type]
    @date_time = games_info[:date_time]
    @away_team_id = games_info[:away_team_id]to_i
    @home_team_id = games_info[:home_team_id]to_i
    @away_goals = games_info[:away_goals].to_i
    @home_goals = games_info[:home_goals].to_i
    @venue = games_info[:venue]
    @venue_link = games_info[:venue_link]
  end
end
