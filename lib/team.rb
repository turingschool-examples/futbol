class Team
  attr_reader :team_id,
              :team_name,
              :Stadium
 
  def initialize(data)
    @team_id = data["team_id"]
    @team_name = data["teamName"]
    @stadium = data["Stadium"]
  end
end