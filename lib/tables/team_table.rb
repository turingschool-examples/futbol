require './lib/helper_modules/csv_to_hashable.rb'

class TeamsTable < StatTracker
  include CsvToHash
  attr_reader :team_data
  def initialize(locations)
    @team_data = from_csv(locations)
    #@stats = StatTracker.
  end

  def random_task
    super
  end

end