# require_relative 'stat_tracker'

class Game
  attr_reader :id,
              :season,
              :type,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals,
              :venue

  def initialize(id, season, type, away_team_id, home_team_id, away_goals, home_goals, venue)
    @id = id
    @season = season
    @type = type
    @away_team_id = away_team_id
    @home_team_id = home_team_id
    @away_goals = away_goals.to_i
    @home_goals = home_goals.to_i
    @venue = venue
  end
end