class Team 
  attr_reader :team_id, :franchiseId, :teamName, :abbreviation, :stadium, :link

  def initialize(team_id, franchiseId, teamName, abbreviation, stadium, link)
    @team_id = team_id
    @franchiseId = franchiseId
    @teamName = teamName
    @abbreviation = abbreviation
    @stadium = stadium
    @link = link
  end
end
