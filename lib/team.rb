# Team knows about each individual team
class Team
  attr_reader :team_id, :franchise_id, :team_name, :abbreviation, :stadium, :link

  def initialize(row)
    @team_id = row[0].to_i
    @franchise_id = row[1].to_i
    @team_name = row[2]
    @abbreviation = row[3]
    @stadium = row[4]
    @link = row[5]
  end
end
