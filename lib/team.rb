class Team

  attr_reader :team_id, :team_name

  def initialize(team)
    @team_id = team["team_id"].to_i
    @franchise_id = team["franchiseId"].to_i
    @team_name = team["teamName"]
    @abbreviation = team["abbreviation"]
    @stadium = team["Stadium"]
    @link = team["link"]
  end
end
