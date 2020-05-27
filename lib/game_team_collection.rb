require 'csv'
class GameTeamCollection

  @@game_teams_path = './data/game_teams.csv'

  def initialize
    rows = CSV.read(@@game_teams_path, headers: true, header_converters: :symbol)
    @game_teams = []
    rows.each do |row|
      @game_teams << GameTeam.new(row)
    end
  end

  def all
    @game_teams
  end

end
