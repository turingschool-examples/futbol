class Team
  attr_reader :team_id, :franchise_id, :teamName, :abbreviation, :stadium, :link

  def initialize(team_id,franchiseid,teamName,abbreviation,stadium,link)
    @team_id = team_id
    @franchise_id = franchiseid
    @teamName = teamName
    @abbreviation = abbreviation
    @stadium = stadium
    @link = link
  end
end