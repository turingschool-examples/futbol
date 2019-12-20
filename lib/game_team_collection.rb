require 'csv'
require_relative 'game_team'
require_relative 'collection'

class GameTeamCollection < Collection
  def initialize(csv_file_path)
    super(csv_file_path, GameTeam)
  end
end
