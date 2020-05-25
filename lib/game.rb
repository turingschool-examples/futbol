class Game

  attr_reader :id,
              :season,
              :type,
              :date_time,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals,
              :venue

  def initialize(info)
    @id           = info[:id]
    @season       = info[:season]
    @type         = info[:type]
    @date_time    = info[:date_time]
    @away_team_id = info[:away_team_id]
    @home_team_id = info[:home_team_id]
    @away_goals   = info[:away_goals]
    @home_goals   = info[:home_goals]
    @venue        = info[:venue]
  end

end
