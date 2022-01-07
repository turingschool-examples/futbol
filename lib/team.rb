class Team
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium,
              :link

  def initialize(team_id, franchise_id, team_name, abbreviation, stadium, link)
    @team_id = row[:team_id]
    @franchise_id = row[:franchise_id]
    @team_name = row[:team_name]
    @abbreviation = row[:abbreviation]
    @stadium = row[:stadium]
    @link = row[:link]
  end
end
