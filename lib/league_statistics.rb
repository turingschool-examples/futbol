require 'csv'

class LeagueStatistics
  def initialize(file)
    @file = file
  end

  def read_csv(file)
    CSV.read(file, headers:true)
  end

  def count_of_teams 
    teams = read_csv(@file)
    teams.size
  end

  def best_offense
    games = read_csv(@file)

    offense = Hash.new { |hash, key| hash[key] = [] }

    games.each do |row|
      team = row["team_id"].to_i
      goals = row["goals"].to_i
      offense[team] << goals
    end

    best_offense_team_id = nil
    highest_average_goals = -1

    offense.each do |team_id, goals|
      average_goals = goals.sum.to_f / goals.size
      if average_goals > highest_average_goals
        highest_average_goals = average_goals
        best_offense_team_id = team_id
      end
    end

    best_offense_team_id
  end
end