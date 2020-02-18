class Team
  attr_reader :team_id,
              :franchiseId,
              :teamName

  def initialize(attributes)
    @team_id = attributes[:team_id]
    @franchiseId = attributes[:franchiseId]
    @teamName = attributes[:teamName]
  end
end
