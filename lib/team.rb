class Team
  @@teams = []
  attr_reader :teamname,
              :team_id

  def initialize(team_details)
    @teamname = team_details[:teamname]
    @team_id = team_details[:team_id]
    @@teams << self
  end

  def self.teams
    @@teams
  end
end
