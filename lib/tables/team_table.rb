require './lib/helper_modules/csv_to_hashable.rb'
require './lib/instances/team'

class TeamsTable
  include CsvToHash
  attr_reader :team_data
  def initialize(locations)
    @team_data = from_csv(locations, 'Team')
  end

  def random_task
    super
  end

end