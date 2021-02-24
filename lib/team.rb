class Team
  attr_reader :team_id, :franchiseId, :teamName, :abbreviation, :stadium, :link

  def initialize(team_data)
    @team_data = team_data
    @team_id = team_data[:team_id]
    @franchiseId = team_data[:franchiseId]
    @teamName = team_data[:teamName]
    @abbreviation = team_data[:abbreviation]
    @stadium = team_data[:Stadium]
    @link = team_data[:link]
  end
end
