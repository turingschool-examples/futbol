class Team
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium,
              :link

  def initialize(team_info)
    @team_id = team_info[:team_id]
    @franchise_id = team_info[:franchiseId]
    @team_name = team_info[:teamName]
    @abbreviation = team_info[:abbreviation]
    @stadium = team_info[:Stadium]
    @link = team_info[:link]
  end
end
