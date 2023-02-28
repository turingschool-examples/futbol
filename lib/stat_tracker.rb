require 'csv'

class StatTracker
  @@games = []
  @@teams = []
  @@game_teams = []

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end
  
  def self.from_csv(locations)
    StatTracker.new(locations[:games], locations[:teams], locations[:game_teams])
  end
  
  def games
    games = CSV.open @games, headers: true, header_converters: :symbol
    # require 'pry-byebug'; require 'pry'; binding.pry
    games.each { |game| print game }

    # game = Game.new()
  end

  def teams
    teams = CSV.open @teams, headers: true, header_converters: :symbol
    teams.each { |team| print team }
  end

  def game_teams
    game_teams = CSV.open @game_teams, headers: true, header_converters: :symbol
    game_teams.each { |game_teams| print game_teams }
  end
end