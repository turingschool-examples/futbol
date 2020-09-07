require_relative "stat_tracker"

class TeamStatistics
  attr_reader :stat_tracker_copy, :csv_team_table
  def initialize(csv_files, stat_tracker)
    @csv_team_table = csv_files.teams
    @stat_tracker_copy = stat_tracker
  end

  def team_info
    hash = {}
    @csv_team_table.each do |team|
      if hash[team[1].team_id].nil?
        hash[team[1].team_id] = [team[1].abbreviation, team[1].franchiseId,
        team[1].link, team[1].team_id, team[1].team_name]
      end
      @stat_tracker_copy.team_info_stat = hash
    end
  end

end
