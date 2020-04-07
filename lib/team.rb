class Team
  attr_reader :team_id, :franchiseid, :teamname, :abbreviation, :stadium, :link

  def initialize(team_info)
    @team_id = team_info[:team_id]
    @franchiseid = team_info[:franchiseId]
    @teamname = team_info[:teamName]
    @abbreviation = team_info[:abbreviation]
    @stadium = team_info[:Stadium]
    @link = team_info[:link]
  end
end
