class TeamsCollection

  def initialize()
    @teams = {}
  end

  def add(team_to_add)
    @teams[team_to_add.team_id] = team_to_add
  end

end
