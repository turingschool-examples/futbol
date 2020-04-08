class Team
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :link

  def initialize(team_info)
    @team_id = team_info[:team_id]
    @franchise_id = team_info[:franchise_id]
    @team_name = team_info[:team_name]
    @abbreviation = team_info[:abbreviation]
    @link = team_info[:link]
  end
end
