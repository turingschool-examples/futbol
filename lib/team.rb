class Team
  attr_reader :team_id,
              :franchiseid,
              :teamName,
              :abbreviation,
              :stadium,
              :link
  def initialize(data)
    @team_id = data[:team_id]
    @franchiseid = data[:franchiseid]
    @teamName = data[:teamname]
    @abbreviation = data[:abbreviation]
    @stadium = data[:stadium]
    @link = data[:link]
  end
end
