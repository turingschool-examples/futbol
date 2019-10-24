require './lib/game_team'
require 'CSV'

class GameTeamCollection
  attr_reader :game_team

  def initialize(csv_file_path)
    @game_team = create_game_teams(csv_file_path)
  end

  def create_game_teams(csv_file_path)
    csv = CSV.foreach("#{csv_file_path}", headers: true, header_converters: :symbol)
    csv.map do |row|
      GameTeam.new(row)
    end
  end

  def count_of_teams
    team_id_array = @game_team.map { |gt| gt.team_id }
    team_id_array.uniq.length
  end

end
