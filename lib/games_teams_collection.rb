require './lib/games_teams'
class GamesTeamsCollection

  attr_reader :games_teams, :games_teams_file

  def initialize(games_teams_file)
    @games_teams_file = games_teams_file
    @games_teams = self.read_file
  end
#read file module? vvv
  def read_file
    data = CSV.read(@games_teams_file, headers: true, header_converters: :symbol)
    data.map do |row|
      GamesTeams.new(row)
    end
  end

end
