class LeagueStatistics
  attr_reader :stats

  def initialize(stats)
    @stats = stats
  end
  def count_of_teams
    @stats.count 
  end
end