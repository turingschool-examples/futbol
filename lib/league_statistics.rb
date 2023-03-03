require_relative 'stats'

class LeagueStatistics < Stats
  def initialize(locations)
    super
  end

  def count_of_teams
    @teams.count
  end
end