class Team
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :link 

  def initialize(stats)
    @team_id = stats[:team_id].to_i
    @franchise_id = stats[:franchise_id].to_i
    @team_name = stats[:team_name]
    @abbreviation = stats[:abbreviation]
    @link = stats[:link]
  end
end