class TeamStatistics
  attr_reader :stat_tracker

  def initialize(stat_tracker)
    @stat_tracker = stat_tracker
  end

  def team_info_data_set
    @stat_tracker[:teams]['team_id'].zip(@stat_tracker[:teams]['franchiseId'], @stat_tracker[:teams]['teamName'], @stat_tracker[:teams]['abbreviation'], @stat_tracker[:teams]['link'])
  end

  def team_info(team_id)

  end
end
