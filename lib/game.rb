require 'CSV'
require './runner'

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

  def initialize(row)
    @row = row
    @game_id = row["game_id"]
    @season = row["season"]
    @type = row["type"]
    @date_time = row["date_time"]
    @away_team_id = row["away_team_id"]
    @home_team_id = row["home_team_id"]
    @away_goals = row["away_goals"].to_i
    @home_goals = row["home_goals"].to_i
    @venue = row["venue"]
    @venue_link = row["venue_link"]
  end
end
