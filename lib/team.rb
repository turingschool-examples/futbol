class Team

  attr_reader :team_id,
              :franchise_id,
              :teamname,
              :abbreviation,
              :stadium,
              :link

  def initialize(data)
    @team_id = data[:team_id].to_i
    @franchise_id = data[:franchiseid].to_i
    @teamname = data[:teamname]
    @abbreviation = data[:abbreviation]
    @stadium = data[:stadium]
    @link = data[:link]
  end

end
