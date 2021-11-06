require_relative './stat_tracker'
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
              :venue_link,
              :home_team_stat,
              :away_team_stat

  def initialize(game, home_team_stat, away_team_stat)
    @game_id = game[:game_id]
    @season = game[:season]
    @type = game[:type]
    @date_time = game[:date_time]
    @away_team_id = game[:away_team_id]
    @home_team_id = game[:home_team_id]
    @away_goals = game[:away_goals].to_i
    @home_goals = game[:home_goals].to_i
    @venue = game[:venue]
    @venue_link = game[:venue_link]
    @home_team_stat = home_team_stat
    @away_team_stat = away_team_stat
  end

end
