require_relative 'helper_class'

class Team
  @@teams = []
  @@teams_lookup = {}

  attr_reader :teamname,
              :team_id

  def initialize(team_details)
    @teamname = team_details[:teamname]
    @team_id = team_details[:team_id]
    @@teams << self
    @@teams_lookup[@team_id] = @teamname
  end

  def self.teams
    @@teams
  end

  def self.teams_lookup
    @@teams_lookup
  end
end
