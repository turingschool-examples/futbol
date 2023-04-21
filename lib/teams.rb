class Team
  attr_reader :team_id, 
              :franchiseid, 
              :teamname, 
              :stadium 
            
  def initialize(team_id, franchiseid, teamname, stadium)
    @team_id = team_id
    @franchiseid = franchiseid
    @teamname = teamname
    @stadium = stadium
  end
end