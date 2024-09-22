class Team
  attr_reader :team_id,
              :team_name,
              :Stadium
 
  def initialize(data)
    @team_id = data["team_id"]
    @franchise_id = data["franchiseId"]
    @team_name = data["teamName"]
    @abbreviation = data["abbreviation"]
    @stadium = data["Stadium"]
    @link = data["link"]
  end
end