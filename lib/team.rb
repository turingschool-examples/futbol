class Team
  attr_reader :team_id,
              :franchiseid,
              :teamname,
              :abbreviation,
              :link

  def initialize(team_data)
    @team_id = team_data[:team_id].to_i
    @franchiseid = team_data[:franchiseid].to_i
    @teamname = team_data[:teamname]
    @abbreviation = team_data[:abbreviation]
    @link = team_data[:link]
  end
end
