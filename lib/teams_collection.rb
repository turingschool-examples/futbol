require 'csv'
require_relative 'team'
require_relative 'csvloadable'

class TeamsCollection
  include CsvLoadable

  attr_reader :teams

  def initialize(teams_path)
    @teams = create_teams(teams_path)
  end

  def create_teams(teams_path)
    create_instances(teams_path, Team)
  end
end
