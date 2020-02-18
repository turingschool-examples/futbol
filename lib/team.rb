class Team
  attr_reader :team_id,
              :franchiseid,
              :teamname

  def initialize(attributes)
    @team_id = attributes[:team_id].to_i
    @franchiseid = attributes[:franchiseid].to_i
    @teamname = attributes[:teamname]
  end
end
