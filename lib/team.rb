class Team
  attr_reader :team_id, :franchise_id, :team_name, :abbreviation, :stadium

  def initialize(attributes)
    @team_id = attributes[:team_id]
    @franchise_id = attributes[:franchiseId]
    @team_name = attributes[:teamName]
    @abbreviation = attributes[:abbreviation]
    @stadium = attributes[:Stadium]
  end


end
