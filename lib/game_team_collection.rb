require 'CSV'
require_relative 'game_team'

class GameTeamCollection
  attr_reader :game_teams

  def initialize(game_teams_file_path)
    @game_teams = from_csv(game_teams_file_path)
  end

  def from_csv(game_teams_file_path)
    game_teams = CSV.read(game_teams_file_path, headers: true, header_converters: :symbol)
    game_teams.map do |row|
      GameTeam.new(row)
    end
  end
end
