require 'csv'
require_relative './game_teams'

class GameTeamsCollection
  attr_reader :game_teams
  def initialize(game_teams_data)
    @game_teams = create_game_teams(game_teams_data)
  end

  def create_game_teams(game_teams_data)
    game_teams_data = game_teams_data.map do |row|
      GameTeams.new(row.to_h)
    end
  end
end
