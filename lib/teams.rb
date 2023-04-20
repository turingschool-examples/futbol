class Team
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :link 

  def initialize(stats)
    @team_id = stats[:team_id]
    @franchise_id = stats[:franchise_id]
    @team_name = stats[:team_name]
    @abbreviation = stats[:abbreviation]
    @link = stats[:link]
  end
end