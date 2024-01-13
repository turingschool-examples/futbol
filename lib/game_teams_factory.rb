require 'csv'

class GameTeamFactory

  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
    @game_teams = []
  end
end