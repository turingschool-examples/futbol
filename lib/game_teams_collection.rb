require_relative 'game_teams'
require 'csv'

class GameTeamCollection < Collection
  def initialize(csv_file_path)
    super(csv_file_path, GameTeams)
  end
end
