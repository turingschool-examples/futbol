require_relative 'team'
require_relative 'data_loadable'

class TeamStats
  include DataLoadable
  attr_reader :teams

  def initialize(file_path, object)
    @teams = csv_data(file_path, object)
  end

end
