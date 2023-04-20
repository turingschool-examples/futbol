class Team
  attr_reader :team_id,
              :teamname

  def initialize(team)
    @team_id = team[:team_id]
    @teamname = team[:teamname]
  end
end