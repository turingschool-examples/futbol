class Team

  attr_reader :id, :franchise_id, :team_name, :abbreviation,
              :stadium, :link
  def initialize(csv_row)
    @id = csv_row[:team_id]
    @franchise_id = csv_row[:franchiseid]
    @team_name = csv_row[:teamname]
    @abbreviation = csv_row[:abbreviation]
    @stadium = csv_row[:stadium]
    @link = csv_row[:link]
  end
end
