require './lib/team_manager'
# TeamStatistics knows about multiple teams
class TeamStatistics
  attr_reader :manager

  def initialize(team_manager))
    @team_manager = team_manager
  end
end
