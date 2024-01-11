class Team
  attr_reader :team_id, :franchise_id, :team_name, :abbreviation, :stadium

  def initialize(attributes)
    @team_id = attributes[:team_id]
    @franchise_id = attributes[:franchise_id]
    @team_name = attributes[:team_name]
    @abbreviation = attributes[:abbreviation]
    @stadium = attributes[:stadium]
  end


end
