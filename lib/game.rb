class Game

  attr_reader :game_id,
              :season,
              :type,
              :date_time,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals,
              :venue

  def initialize(info)
    @game_id      = info[:game_id].to_i
    @season       = info[:season]
    @type         = info[:type]
    @date_time    = info[:date_time]
    @away_team_id = info[:away_team_id].to_i
    @home_team_id = info[:home_team_id].to_i
    @away_goals   = info[:away_goals].to_i
    @home_goals   = info[:home_goals].to_i
    @venue        = info[:venue]
  end
end
