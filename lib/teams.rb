class Team
  # attr_reader :team_id, 
  #             :franchise_id, 
  #             :team_name, 
  #             :abbreviation, 
  #             :stadium
  
  def initialize(team_id, 
                franchiseid, 
                teamname, 
                abbreviation, 
                stadium)
  
  @team_id = team_id
  @franchise_id = franchiseid
  @team_name = teamname
  @abbreviation = abbreviation
  end
end