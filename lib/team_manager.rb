require_relative './team'

class TeamManager
  attr_reader :teams

  def initialize(locations)
    @teams = Team.read_file(locations[:teams])
  end
end
