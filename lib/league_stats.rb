class LeagueStatistics
  attr_reader :teams_data
  def initialize(array_teams_data)
    @teams_data = array_teams_data
  end

  def count_of_teams
    @teams_data.length
  end
end
