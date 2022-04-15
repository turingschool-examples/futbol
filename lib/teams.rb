class Teams
  attr_reader :team_id,
              :franchiseid,
              :teamname,
              :abbreviation,
              :stadium,
              :link

  def initialize(data)
    @team_id = data[:team_id]
    @franchiseid = data[:franchiseid]
    @teamname = data[:teamname]
    @abbreviation = data[:abbreviation]
    @stadium = data[:stadium]
    @link = data[:link]
  end

end
