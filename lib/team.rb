class Teams
  attr_reader :franchise_id,
              :team_name,
              :abbreviation,
              :stadium

  def initialize(team_data)
    @franchise_id = team_data[:franchiseId]
    @team_name = team_data[:teamName]
    @abbreviation = team_data[:abbreviation]
    @stadium = team_data[:stadium]
  end
end
