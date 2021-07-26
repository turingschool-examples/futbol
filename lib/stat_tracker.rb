class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    # require "pry"; binding.pry
    games = {}
    teams = {}
    game_teams = {}

    games[:games] = CSV.read(locations[:games])
    teams[:teams] =  CSV.read(locations[:teams])
    game_teams[:game_teams] =  CSV.read(locations[:game_teams])

    StatTracker.new(games, teams, game_teams)
  end


end
