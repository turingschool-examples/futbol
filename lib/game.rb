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

  def return_winner
    if home_goals > away_goals
     home_team_id
    elsif away_goals > home_goals
      away_team_id
    elsif home_goals == away_goals
      puts "tie"
    end
  end
end
