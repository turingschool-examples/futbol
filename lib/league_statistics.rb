require 'pry'

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
    teams_goals_hash = {}
    @data_set[0].each do |row|
      if teams_goals_hash[row[:team_id]] == nil
        teams_goals_hash[row[:team_id]] = []
      end
      teams_goals_hash[row[:team_id]] << row[:goals].to_f
    end
    average_teams_goals = teams_goals_hash.each do |team, goals|
      teams_goals_hash[team] = (goals.sum / goals.count)
    end
    average_teams_goals
  end
end
