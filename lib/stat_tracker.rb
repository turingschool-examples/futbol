require './lib/game_teams.rb'
require './lib/games.rb'
require './lib/teams.rb'

class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(game_teams, games, teams)
    @game_teams = game_teams
    @games = games
    @teams = teams
  end

  def self.from_csv(locations)
    game_teams = GameTeams.create_game_teams_data_objects(locations[:game_teams])
    games = Games.create_games_data_objects(locations[:games])
    teams = Teams.create_teams_data_objects(locations[:teams])

    StatTracker.new(game_teams, games, teams)
  end

end


