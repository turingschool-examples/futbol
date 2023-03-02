class Team
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium
  attr_accessor :games

  def initialize(row)
    @team_id = row[:team_id]
    @franchise_id = row[:franchiseid]
    @team_name = row[:teamname]
    @abbreviation = row[:abbreviation]
    @stadium = row[:stadium]
    @games = []
  end
end
