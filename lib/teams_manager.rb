class TeamsManager

  def initialize(locations, stat_tracker)
    @teams = {}
    @stat_tracker = stat_tracker
    team_from_csv(locations)
  end
end
