class Team
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :link
              
  def initialize(team)
    @team_id = team[:team_id]
    @franchise_id = team[:franchiseid]
    @team_name = team[:teamname]
    @abbreviation = team[:abbreviation]
    @link = team[:link]
  end
end