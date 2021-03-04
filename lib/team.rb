class Team
  attr_reader :team_id,
              :franchiseid,
              :teamname,
              :abbreviation,
              :stadium,
              :link,
              :count

  def initialize(data)
    @team_id = data[:team_id].to_i
    @franchiseid = data[:franchiseid].to_i
    @teamname = data[:teamname]
    @abbreviation = data[:abbreviation]
    @stadium = data[:stadium]
    @link = data[:link]
    # @count = 0
  end
end
