class Team
  attr_reader :team_id, :franchiseid, :teamname, :abbreviation, :link

  def initialize(row)
    @team_id = row[:team_id]
    @franchiseid = row[:franchiseid]
    @teamname = row[:teamname]
    @abbreviation = row[:abbreviation]
    @link = row[:link]
  end

  def team_info
    {
    "team_id" => @team_id,
    "franchise_id"=> @franchiseid,
    "team_name"=> @teamname,
    "abbreviation"=> @abbreviation,
    "link"=> @link
    }
  end
end
