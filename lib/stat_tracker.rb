require './lib/game_teams'
require './lib/teams'
require './lib/games'

class StatTracker < Games
  attr_reader :games, :teams, :game_teams

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

  def all_games
    @games
  end

  def all_game_teams
    @game_teams
  end

  def all_teams
    @teams
  end

end
