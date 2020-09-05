require "csv"
require "./lib/teams"
require "./lib/games"
require "./lib/game_teams"

class StatTracker
  attr_reader :teams, :games, :game_teams

  def initialize(teams, games, game_teams)
    @teams = teams
    @games = games
    @game_teams = game_teams
  end

  def self.from_csv(locations = {games: './data/games.csv', teams: './data/teams_test.csv', game_teams: './data/game_teams_test.csv'})
    Games.from_csv(locations[:games])
    Teams.from_csv(locations[:teams])
    GameTeams.from_csv(locations[:game_teams])
    self.new(Teams.all_teams, Games.all_games, GameTeams.all_game_teams)
  end
end
