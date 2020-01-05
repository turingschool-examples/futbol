require_relative 'team'
require_relative 'csv_loadable'

class TeamCollection
  include CsvLoadable

  attr_reader :teams_array

  def initialize(file_path)
    @teams_array = create_teams_array(file_path)
  end

  def create_teams_array(file_path)
    load_from_csv(file_path, Team)
  end

  # def find_name_by_id(id)
    #will use id argrument that will return team name
end
