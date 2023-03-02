require_relative 'classes'

class Game
attr_reader :id,
            :season,
            :type,
            :date_time,
            :away,
            :home,
            :away_goals,
            :home_goals,
            :venue,
            :venue_link

  def initialize(info)
    @id = info["game_id"].to_i
    @season = info["season"]
    @type = info["type"]
    @date_time = info["date_time"]
    @away = info["away_team_id"]
    @home = info["home_team_id"]
    @away_goals = info["away_goals"].to_i
    @home_goals = info["home_goals"].to_i
    @venue = info["venue"]
    @venue_link = info["venue_link"]
  end
end