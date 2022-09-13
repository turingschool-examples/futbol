class Team
  attr_reader :team_id, :franchiseid, :teamname, :abbreviation, :stadium, :link

  def initialize(team_info)
    @team_id = team_info[:team_id]
    @franchiseid = team_info[:franchiseid]
    @teamname = team_info[:teamname]
    @abbreviation = team_info[:abbreviation]
    @stadium = team_info[:stadium]
    @link = team_info[:link]
  end

end
