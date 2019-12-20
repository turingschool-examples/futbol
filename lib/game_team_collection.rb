require 'csv'
require_relative 'game_team'

class GameTeamCollection
  attr_accessor :game_teams

  def initialize(csv_file_path)
    @game_teams = create_game_teams(csv_file_path)
  end

  def from_csv(csv_file_path)
    CSV.read(csv_file_path, headers: true, header_converters: :symbol)
  end

  def create_game_teams(csv_file_path)
    from_csv(csv_file_path).map do |row|
      GameTeam.new(row)
    end
  end
end
