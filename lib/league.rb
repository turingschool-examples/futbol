class League
  attr_reader :team_id,
              :team_name,
              :season,
              :type,
              :away_goals,
              :home_goals,
              :goals

  def initialize(data)
    @team_id = data[:team_id]
    @team_name = data[:team_name]
    @season = data[:season]
    @type = data[:type]
    @away_goals = data[:away_goals]
    @home_goals = data[:home_goals]
    @goals = data[:goals]
  end
end