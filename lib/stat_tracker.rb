require './parsers/games_parser'
require './parsers/teams_parser'
require './parsers/game_teams_parser'

class StatTracker
  def self.from_csv(locations)
    games = GamesParser.parse(locations[:games])
    teams = TeamsParser.parse(locations[:teams])
    game_teams = GameTeamsParser.parse(locations[:game_teams])

    StatTracker.new(games, teams, game_teams)
  end

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  # Implement the remaining methods for statistics calculations
  # ...
end
