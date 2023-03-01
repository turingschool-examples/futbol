class Team
  attr_reader :team_id, 
              :team_name
  
  def initialize(details)
    @team_id = details[:team_id]
    @team_name = details[:teamname]
  end
end