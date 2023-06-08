class Team
  attr_reader :team_id, :franchise_id, :team_name, :abbreviation, :stadium, :link
  
  def initialize(team_id, franchiseid, teamname, abbreviation, stadium, link) 

    @team_id = team_id
    @franchise_id = franchiseid
    @team_name = teamname
    @abbreviation = abbreviation
    @stadium = stadium
    @link = link
  end
end