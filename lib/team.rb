class Team
  attr_reader :team_id, :franchiseid, :teamname, :abbreviation, :stadium, :link

  def initialize(row)
    @team_id = row[:team_id].to_i
    @franchiseid = row[:franchiseid].to_i
    @teamname = row[:teamname]
    @abbreviation = row[:abbreviation]
    @stadium = row[:stadium]
    @link = row[:link]
  end
end
