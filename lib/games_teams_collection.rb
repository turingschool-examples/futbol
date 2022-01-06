class GamesTeamsCollection

  attr_reader :games_teams

  def initialize(games_teams_file)
    @games = read_file(games_teams_file)
  end

  def read_file(games_teams_file)
    data = CSV.read(games_teams_file, headers: true, header_converters: :symbol)
    data.map do |row|
      GamesTeams.new(row)
    end
  end

end
