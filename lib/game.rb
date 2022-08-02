require './lib/stat_tracker2'
require './lib/league'

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

  def initialize(info)
    @game_id = info[:game_id]
    @season = info[:season]
    @type = info[:type]
    @date_time = info[:date_time]
    @away_team_id = info[:away_team_id]
    @home_team_id = info[:home_team_id]
    @away_goals = info[:away_goals]
    @home_goals = info[:home_goals]
    @venue = info[:venue]
    @venue_link = info[:venue_link]
  end

  def teams_in_game
    teams = [@away_team_id.to_i, @home_team_id.to_i].sort
  end

  def winning_team_id
    if @away_goals > @home_goals
      @away_team_id
    elsif @away_goals < @home_goals
      @home_team_id
    end
  end
end
