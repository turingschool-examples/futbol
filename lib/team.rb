class Team
  attr_reader :team_id, :franchiseid, :teamname, :abbreviation, :stadium, :link

  def initialize(team_id, franchiseid, teamname, abbreviation, stadium, link)
    @team_id = team_id
    @franchiseid = franchiseid
    @teamname = teamname
    @abbreviation = abbreviation
    @stadium = stadium
    @link = link
  end

end
