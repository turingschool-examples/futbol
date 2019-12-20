require 'csv'
require_relative 'game_team'
require_relative 'csvloadable'

class GameTeamsCollection
  include CsvLoadable

  attr_reader :game_teams

  def initialize(game_teams_path)
    @game_teams = create_game_teams(game_teams_path)
  end

  def create_game_teams(game_teams_path)
    create_instances(game_teams_path, GameTeam)
  end

  def best_defense

  end
end
