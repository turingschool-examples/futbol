require_relative './game_team'
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



  def winningest_team
    win = []
    winning = @game_team.find_all do |gt|
    gt.result == "LA Galaxy" && gt.team_id == gt.team_id
      end
    end
#need to iterate over the game_team csv to find the team ID associated with the most
#WINS. then refernce the teams.csv to grab the name of the team associated with that
#team_id

end
