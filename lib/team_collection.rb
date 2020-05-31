require_relative 'loadable'
require_relative 'team'

class TeamCollection
  include Loadable
  attr_reader :teams_array

  def initialize(file_path)
    @teams_array = create_teams_array(file_path)
  end

  def create_teams_array(file_path)
    load_from_csv(file_path, Team)
  end


end
