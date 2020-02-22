class Team
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium,
              :link

  def initialize(details)
    @team_id = details[:team_id].to_i
    @franchise_id = details[:franchiseid].to_i
    @team_name = details[:teamname]
    @abbreviation = details[:abbreviation]
    @stadium = details[:stadium]
    @link = details[:link]
  end
end
