require 'CSV'

class StatTracker
  attr_reader :games, :teams, :game_teams

  def self.from_csv(locations)
    games = CSV.read(locations[:games])
    teams = CSV.read(locations[:teams])
    game_teams = CSV.read(locations[:game_teams])

    StatTracker.new(games, teams, game_teams)
  end

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end
end
