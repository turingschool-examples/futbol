class Team
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbr,
              :stadium,
              :link


  def initialize(team_info)
    @team_id = team_info[:team_id]
    @franchise_id = team_info[:franchiseId]
    @team_name = team_info[:teamName]
    @abbr = team_info[:abbreviation]
    @stadium = team_info[:Stadium]
    @link = team_info[:link]
  end
end
