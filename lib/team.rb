class Team
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium,
              :link,
              :team_list #this is changed for clarity because it is an instance of team_list, not just a list in team
  
  def initialize(row, list)
    @team_id       = row[:team_id]
    @franchise_id  = row[:franchise_id]
    @team_name     = row[:team_name]
    @abbreviation  = row[:abbreviation]
    @stadium       = row[:stadium]
    @link          = row[:link]
    @team_list     = team_list
  end
  
end