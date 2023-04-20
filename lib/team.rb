class Team
  attr_reader :team_id,
              :name

  def initialize(team)
    @team_id = team[:team_id]
    @name = team[:teamname]
  end
end