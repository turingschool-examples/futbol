class TeamStatistics

  def initialize(stat_tracker)
    @stat_tracker = stat_tracker
  end

  def team_info(team_id)
    team_info = @stat_tracker[:teams]["team_id"].zip(@stat_tracker[:teams]["franchise_id"])
binding.pry
  end

end
