require 'csv'
class GameTeamCollection

  def initialize(game_team_data)
    rows = CSV.read(game_team_data, headers: true, header_converters: :symbol)
    @game_teams = []
    rows.each do |row|
      @game_teams << GameTeam.new(row)
    end
  end

  def all
    @game_teams
  end
end
