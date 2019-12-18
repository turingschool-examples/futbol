class Team
  attr_reader :team_id, :franchiseId, :teamName, :abbreviation, :Stadium

  def initialize(team_info)
    @team_id = team_info[:team_id].to_i
    @franchiseId = team_info[:franchiseId].to_i
    @teamName = team_info[:teamName].to_s
    @abbreviation = team_info[:abbreviation].to_s
    @Stadium = team_info[:Stadium].to_s
  end
end
