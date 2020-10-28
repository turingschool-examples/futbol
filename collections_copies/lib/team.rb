class Team
  attr_reader :team_id, :franchiseid, :teamname, :abbreviation, :stadium, :link

  def initialize(team_id,franchiseid,teamname,abbreviation,stadium,link)
    @team_id = team_id.to_i
    @franchiseid = franchiseid.to_i
    @teamname = teamname
    @abbreviation = abbreviation
    @stadium = stadium
    @link = link
  end
end
