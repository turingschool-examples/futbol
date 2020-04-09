class Team

  attr_reader :id, :franchise_id, :team_name, :abbreviation,
              :stadium, :link
  def initialize(csv_row)
    @id = csv_row[:id]
    @franchise_id = csv_row[:franchiseId]
    @team_name = csv_row[:teamName]
    @abbreviation = csv_row[:abbreviation]
    @stadium = csv_row[:Stadium]
    @link = csv_row[:link]
  end
end
