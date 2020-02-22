class Team
  attr_reader :team_id, :franchise_id, :teamname

  def initialize(attributes)
    @team_id = attributes[:team_id].to_i
    @franchise_id = attributes[:franchiseid].to_i
    @teamname = attributes[:teamname]
  end
end
