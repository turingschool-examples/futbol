class Team

  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbr,
              :stadium,
              :link

  def initialize(data)
    @team_id = data[:team_id]
    @franchise_id = data[:franchise_id]
    @team_name = data[:team_name]
    @abbr = data[:abbr]
    @stadium = data[:stadium]
    @link = data[:link]
  end

end
