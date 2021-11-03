class Team

  attr_reader :team_id, :franchise_id, :team_name, :abbreviation, :stadium, :link

  def initialize(row)
    @team_id = row['team_id']
    @franchiseId = row['franchiseId']
    @teamName = row['teamName']
    @abbreviation = row['abbreviation']
    @stadium = row['Stadium']
    @link = row['link']
  end
end
