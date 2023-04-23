class Team
  attr_reader :team_id,
              :franchiseid,
              :teamname,
              :stadium

  def initialize(row)
    @team_id = row[:team_id]
    @franchiseid = row[:franchiseid]
    @teamname = row[:teamname]
    @stadium = row[:stadium]
  end
end