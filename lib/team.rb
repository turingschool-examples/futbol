class Team
  attr_reader :team_id,
              :franchiseId,
              :teamName,
              :abbreviation,
              :stadium,
              :link

  def initialize(team_data)
    @team_id = team_data[:team_id].to_i
    @franchiseId = team_data[:franchiseId].to_i
    @teamName = team_data[:teamName]
    @abbreviation = team_data[:abbreviation]
    @stadium = team_data[:stadium]
    @link = team_data[:link]
  end
end
