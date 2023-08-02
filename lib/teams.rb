class Team
  attr_reader :team_id, :franchise_id, :team_name, :abbreviation, :stadium

  def initialize(team_id, franchise_id, team_name, abbreviation, stadium)
    @team_id = team_id
    @franchise_id = franchise_id
    @team_name = team_name
    @abbreviation = abbreviation
    @stadium = stadium
  end
end