class Team
  attr_reader :team_id, :franchise_id, :teamName, :abbreviation,
  :stadium, :link

  def initialize(teams_info)
    @team_id = teams_info[:team_id].to_i
    @franchise_id = teams_info[:franchiseid].to_i
    @teamName = teams_info[:teamname]
    @abbreviation = teams_info[:abbreviation]
  end
end
