class AllData
attr_reader :games,
            :teams,
            :game_teams

  def initialize
    @games = CSV.open('../data/games.csv', headers: true, header_converters: :symbol)
    @teams = CSV.open('../data/teams.csv', headers: true, header_converters: :symbol)
    @game_teams = CSV.open('../data/game_teams.csv', headers: true, header_converters: :symbol)
  end
end