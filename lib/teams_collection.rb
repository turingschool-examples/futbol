class TeamsCollection

  def initialize(teams = {})
    @teams = teams
  end

  def add_team(team_to_add)
    @teams[team_to_add.team_id] = team_to_add
  end

end
