require 'csv'
require_relative 'collection'

class TeamStats < Collection
  attr_reader :team_stats

  def initialize(file_path)
    @team_stats = create_objects(file_path, Game)
  end
end
