class Team
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :team_abbreviation,
              :team_stadium,
              :team_link

  def initialize(data)
    @team_id = data[:team_id]
    @franchise_id = data[:franchiseid]
    @team_name = data[:teamname]
    @team_abbreviation = data[:abbreviation]
    @team_stadium = data[:stadium]
    @team_link = data[:link]
  end
end
