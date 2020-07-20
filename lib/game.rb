# frozen_string_literal: true

# Game
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

  def initialize(args)
    @game_id      = args[:game_id]
    @season       = args[:season]
    @type         = args[:type]
    @date_time    = args[:date_time]
    @away_team_id = args[:away_team_id]
    @home_team_id = args[:home_team_id]
    @away_goals   = args[:away_goals]
    @home_goals   = args[:home_goals]
    @venue        = args[:venue]
    @venue_link   = args[:venue_link]
  end
end
