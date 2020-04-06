class Team

  #
  # CSV.read(./data/teams.csv)
  attr_reader :team_id, :franchise_id, :name, :abbreviation, :stadium, :link
  def initialize(info)
    @team_id = info[:team_id]
    @franchise_id = info[:franchise_id]
    @name = info[:name]
    @abbreviation = info[:abbreviation]
    @stadium = info[:stadium]
    @link = info[:link]
  end




end
