require './lib/helper_modules/csv_to_hashable'
require './lib/instances/team'
require './lib/helper_modules/team_returnable'
class TeamsTable
  include CsvToHash
  include ReturnTeamable
  attr_reader :team_data

  def initialize(locations)
    @team_data = from_csv(locations, 'Team')
  end

  def count_of_teams
    @team_data.length
  end


end