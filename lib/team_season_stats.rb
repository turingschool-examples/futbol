require 'csv'
require_relative 'collection'

class TeamSeasonStats < Collection
  attr_reader :team_stats

  def initialize(file_path)
    @games = create_objects(file_path, Game)
  end
end
