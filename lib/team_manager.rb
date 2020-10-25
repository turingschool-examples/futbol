require 'csv'

class TeamManager
  attr_reader :teams_data, :teams

  def initialize(file_locations)
    @teams_data = file_locations[:teams]
  end

end
