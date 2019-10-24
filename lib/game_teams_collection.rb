require './lib/game_team'
require 'CSV'

class GameTeamsCollection
  attr_reader :game_teams, :game_teams_objs

  def initialize(csv_file_path)
    @game_teams_objs = []
    @game_teams = create_game_teams(csv_file_path)
  end

  def create_game_teams(csv_file_path)
    csv = CSV.read("#{csv_file_path}", headers: true, header_converters: :symbol)
    game_team_obj = 0
    csv.map do |row|
      game_team_obj = GameTeams.new(row)
      @game_teams_objs << game_team_obj
    end
  end
end
