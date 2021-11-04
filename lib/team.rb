class Team

  attr_reader :team_id, :franchiseId, :teamName, :abbreviation, :stadium, :link

  def initialize(row)
    @team_id = row['team_id'].to_i
    @franchiseId = row['franchiseId'].to_i
    @teamName = row['teamName']
    @abbreviation = row['abbreviation']
    @stadium = row['Stadium']
    @link = row['link']
  end
end
