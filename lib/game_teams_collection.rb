require 'csv'

class GameTeamsCollection
  attr_reader :game_teams
  def initialize(game_teams_file_path)
    @game_teams = create_game_teams(game_teams_file_path)
  end

  def create_game_teams(game_teams_file_path)
    game_teams_data = CSV.read(game_teams_file_path, headers: true, header_converters: :symbol)
    game_teams_data = game_teams_data.map do |row|
      GameTeams.new(row.to_h)
    end
  end
end
