class Team
  attr_reader :team_id,
              :franchiseid,
              :teamname,
              :abbreviation,
              :stadium,
              :link,
              :team_list
  
  def initialize(row, team_list)
    @team_id       = row[:team_id]
    @franchiseid   = row[:franchiseid]
    @teamname      = row[:teamname]
    @abbreviation  = row[:abbreviation]
    @stadium       = row[:stadium]
    @link          = row[:link]
    @team_list     = team_list
  end
  
end