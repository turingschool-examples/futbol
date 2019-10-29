class Team
  attr_reader :team_id, :franchiseId, :teamName, :abbreviation,
  :Stadium, :link

  def initialize(teams_info)
    @team_id = teams_info[:team_id].to_i
    @franchiseId = teams_info[:franchiseid].to_i
    @teamName = teams_info[:teamname]
    @abbreviation = teams_info[:abbreviation]
    @Stadium = teams_info[:stadium]
    @link = teams_info[:link]
  end
end
