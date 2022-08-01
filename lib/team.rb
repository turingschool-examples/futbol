class Team
  attr_reader :team_id, :franchise_id, :team_name, :abbv, :link
  def initialize(row)
    @team_id = row[:team_id]
    @franchise_id = row[:franchiseId]
    @team_name = row[:teamName]
    @abbv = row[:abbreviation]
    @link = row[:link]
  end
end
