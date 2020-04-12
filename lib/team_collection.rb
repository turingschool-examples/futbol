require 'csv'
require_relative 'team'
require_relative 'collection'

class TeamCollection < Collection
  attr_reader :teams

  def initialize(csv_file_path)
    @teams = create_objects(csv_file_path, Team)
  end

  def count_of_teams
    @teams.length
  end
end
