require './lib/csv_parser'
class Team
  attr_reader :team_id, :franchise_id, :team_name, :abbreviation, :link

  def initialize(team_data)
    @team_id = team_data["team_id"],
    @franchise_id = team_data["franchise_id"],
    @team_name = team_data["team_name"],
    @abbreviation = team_data["abbreviation"],
    @link = team_data["link"]
  end
end
