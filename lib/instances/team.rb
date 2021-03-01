require_relative './helper_modules/csv_to_hashable'
require_relative './instances/team'
require_relative './helper_modules/team_returnable'

class TeamsTable
  include CsvToHash
  include ReturnTeamable
  attr_reader :team_data
  def initialize(locations)
    @team_data = from_csv(locations, 'Team')
    @hash = Hash.new
  end

  def count_of_teams
    @team_data.length
  end
  def team_info(team)
    hash = Hash.new
    #takes in team object, creates hash key value pair for each instance var
    team.instance_variables.each{|variable|  hash[variable.to_s.delete("@")] = team.instance_variable_get(variable) }
    hash
  end
end
