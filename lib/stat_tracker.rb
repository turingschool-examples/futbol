require './lib/game_teams'
require './lib/teams'
require './lib/games'

class StatTracker
  attr_reader :games

  def initialize(game_teams, games, teams)
    @game_teams = game_teams
    @games = games
    @teams = teams
  end

  def self.from_csv(locations)
    game_teams = GameTeams.create(locations[:game_teams])
    games = Games.create(locations[:games])
    teams =  Teams.create(locations[:teams])
    self.new(game_teams, games, teams)
  end

end
