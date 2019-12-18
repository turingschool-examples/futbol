require 'csv'

class GameTeamCollection
  attr_accessor :game_teams
  attr_reader :game_teams_file_path

  def initialize
    @game_teams = nil
    @game_teams_file_path = './data/game_teams.csv'
  end

  def from_csv
    @game_teams = CSV.read(@game_teams_file_path, headers: true, header_converters: :symbol)
  end
end
