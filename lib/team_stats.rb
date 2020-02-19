require_relative 'team'
require_relative 'data_loadable'

class TeamStats
  include DataLoadable
  attr_reader :teams

  def initialize(file_path, object)
    @teams = csv_data('./data/teams.csv', Team)
  end

  def count_of_teams
    @teams.count
  end

end
