class Team
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :link

  def initialize(info)
    @team_id = info[:team_id]
    @franchise_id = info[:franchise_id]
    @team_name = info[:team_name]
    @abbreviation = info[:abbreviation]
    @link = info[:link]
  end

  def team_info
    info = {
      team_id: @team_id,
      franchise_id: @franchise_id,
      team_name: @team_name,
      abbreviation: @abbreviation,
      link: @link
    }
  end
end
