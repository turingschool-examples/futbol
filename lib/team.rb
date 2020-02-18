class Team
  attr_reader :team_id,
              :franchise_id,
              :team_name
              
  def initialize(attributes)
    @team_id = attributes[:team_id]
    @franchise_id = attributes[:franchiseId]
    @team_name = attributes[:teamName]
  end
end
