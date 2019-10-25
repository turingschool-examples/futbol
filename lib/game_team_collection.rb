require 'csv'
require_relative 'game'

class GameTeamCollection
  attr_reader :games_team 

  def initialize(csv_path)
    @game_teams = create_game_teams(csv_path)
  end

  def create_game_teams(csv_path)
    csv = CSV.read("#{csv_path}", headers: true, header_converters: :symbol)
    csv.map { |row| GameTeam.new(row) }
  end

  def total_game_teams
    @game_teams.length
  end
end
