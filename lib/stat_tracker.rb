require 'csv'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    games = CSV.open(locations[:games], headers: true, header_converters: :symbol )
    teams = CSV.open(locations[:teams], headers: true, header_converters: :symbol)
    game_teams = CSV.open(locations[:game_teams], headers: true, header_converters: :symbol)
    StatTracker.new(games, teams, game_teams)
  end

end
