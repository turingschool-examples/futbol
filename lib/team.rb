class Team
  attr_reader :team_id, :franchise_id, :team_name, :abbreviation, :stadium, :link
  def initialize(row)
    @team_id = row["team_id"]
    @franchise_id = row["franchiseId"]
    @team_name = row["teamName"]
    @abbreviation = row["abbreviation"]
    @stadium = row["Stadium"]
    @link = row["link"]
  end

  def team_info
    team_hash = {}
    team_hash['team_id'] = team.team_id
    team_hash['franchise_id'] = team.franchise_id
    team_hash['team_name'] = team.team_name
    team_hash['abbreviation'] = team.abbreviation
    team_hash['link'] = team.link

    team_hash
  end
end
