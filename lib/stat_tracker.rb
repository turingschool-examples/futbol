require './lib/teams.rb'
require './lib/game.rb'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams,
              :game_path,
              :team_path,
              :game_teams_path,
              :locations

  def initialize(games, teams, game_teams)
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }
    @games = Game.create_multiple_games(@locations[:games])
    @teams = Teams.create_multiple_teams(@locations[:teams])
    @game_teams = GameTeams.create_multiple_game_teams(@location[:game_teams])
  end


  def self.from_csv(locations)
    @games
    @teams
    @game_teams
    StatTracker.new(@games, @teams, @game_teams)
  end
end
