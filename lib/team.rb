class Team
  attr_reader :teamname,
              :team_id

  def initialize(team_details)
    @teamname = team_details[:teamname]
    @team_id = team_details[:team_id]
  end
end
