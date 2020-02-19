require_relative 'team'
require_relative 'data_loadable'

module TeamStats
  include DataLoadable
  attr_reader :teams

  def initialize(file_path, object)
    @teams = csv_data('./data/teams.csv', Team)
  end

  def find_name(id)
    team = @teams.find { |team| team.team_id == id}
    team.teamname
  end

end
