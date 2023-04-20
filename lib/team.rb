class Team
  attr_reader

  def initialize(team)
    @team_id = team[:team_id]
    @name = team[:teamname]
  end
end