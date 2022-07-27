class LeagueStatistics
  attr_reader :data_set

  def initialize(data_set)
    @data_set = data_set
  end

  def count_of_teams
    team_id_array = []
    @data_set[0].each do |row|
      team_id_array << row[1]
    end
    team_id_array.uniq.count
  end

  def total_team_goal_averages

  end
end
