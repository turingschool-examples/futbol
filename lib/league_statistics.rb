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
    teams = read_csv(@file)

    offense = Hash.new { |hash, key| hash[key] = [] }

    teams.each do |row|
      team = row["Team"]
      goals = row["Goals"].to_i
      offense[team] << goals
    end

    
  end
end