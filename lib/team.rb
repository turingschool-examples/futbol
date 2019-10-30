class Team
  attr_reader :team_id, :teamName

  def initialize(teams_info)
    @team_id = teams_info[:team_id].to_i
    @teamName = teams_info[:teamname]
  end
end
