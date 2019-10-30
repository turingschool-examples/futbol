class Team
  attr_reader :team_id, :franchise_id, :team_name, :abbreviation,
  :stadium, :link

  def initialize(teams_info)
    @team_id = teams_info[:team_id].to_i
    @franchise_id = teams_info[:franchiseId].to_i
    @team_name = teams_info[:teamName]
    @abbreviation = teams_info[:abbreviation]
  end
end
