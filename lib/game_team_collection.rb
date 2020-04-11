require_relative 'game_team'
require 'csv'
class GameTeams
  attr_reader :game_teams

  def initialize(csv_file_path)
    @game_teams = create_game_teams(csv_file_path)
  end

  def create_game_teams(csv_file_path)
    csv = CSV.read("#{csv_file_path}", headers: true, header_converters: :symbol)
    csv.map do |row|
       GameTeam.new(row)
    end
  end
end
