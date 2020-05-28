require 'csv'
class GameTeamCollection

  def initialize(game_teams_data)
    rows = CSV.read(game_teams_data, headers: true, header_converters: :symbol)
    @game_teams = []
    rows.each do |row|
      @game_teams << GameTeam.new(row)
    end
  end

  def all
    @game_teams
  end

end
