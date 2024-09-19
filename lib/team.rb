class Team
  attr_reader :team_id,
              :teamName,
              :Stadium
 
  def initialize(data)
    @team_id = data["team_id"]
    @teamName = data["teamName"]
    @stadium = data["Stadium"]
  end
end