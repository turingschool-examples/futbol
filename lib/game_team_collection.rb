require './lib/game_team'
require 'CSV'

class GameTeamCollection
  attr_reader :game_team, :game_team_objs

  def initialize(csv_file_path)
    @game_team_objs = []
    @game_team = create_game_teams(csv_file_path)
  end

  def create_game_teams(csv_file_path)
    csv = CSV.read("#{csv_file_path}", headers: true, header_converters: :symbol)
    game_team_obj = 0
    csv.map do |row|
      game_team_obj = GameTeam.new(row)
      @game_team_objs << game_team_obj
    end
  end

  def count_of_game_teams
    @game_team.team_id.uniq.count
  end

end
