class Team
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :link 

  def initialize(stats)
    @team_id = stats[:team_id].to_s
    @franchise_id = stats[:franchise_id].to_s
    @team_name = stats[:team_name].to_s
    @abbreviation = stats[:abbreviation].to_s
    @link = stats[:link].to_s
  end
end