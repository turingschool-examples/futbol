class TeamsTable
  attr_reader :team_data
  def initialize(stat_tracker)
    @team_data = stat_tracker
  end

  def can_communicate
    p 'yes'
  end

end