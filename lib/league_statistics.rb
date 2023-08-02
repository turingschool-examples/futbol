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
end