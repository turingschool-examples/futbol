class TeamStatistics
  attr_reader :stat_tracker

  def initialize(stat_tracker)
    @stat_tracker = stat_tracker
  end

  def team_info_data_set
    @stat_tracker[:teams]['team_id'].zip(@stat_tracker[:teams]['franchiseId'], @stat_tracker[:teams]['teamName'], @stat_tracker[:teams]['abbreviation'], @stat_tracker[:teams]['link'])
  end

  def find_team_id(team_id)
    team_info_data_set.map do |item|
      return item if item[0] == team_id
    end
  end

  def team_info(team_id)
    team_data = {}
    headers = [:team_id, :franchise_id, :team_name, :abbreviation, :link]
    headers.each_with_index do |header, index|
      team_data[header] = find_team_id(team_id)[index]
    end
    team_data
  end
end
