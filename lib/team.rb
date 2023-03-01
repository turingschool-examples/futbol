class Team
  attr_reader :team_id,
              :franchiseid, 
              :teamname, 
              :abbreviation, 
              :stadium
  
  def initialize(team_data)
    @team_id = team_data[:team_id]
    @franchiseid = team_data[:franchiseid]
    @teamname = team_data[:teamname]
    @abbreviation = team_data[:abbreviation]
    @stadium = team_data[:stadium]
  end
end