require 'CSV'
require_relative './lib/games_manager'
require_relative './lib/teams_manager'
require_relative './lib/game_teams_manager'

class StatTracker

  def initialize(games_path, team_path, game_team_path)
    @games = GamesManager.new(games_path)
    @teams = TeamsManager.new(team_path)
    @game_teams = GameTeamsManager.new(game_team_path)
  end

  def self.from_csv(data_locations)
    games_path = data_locations[:games]
    teams_path = data_locations[:teams]
    game_teams_path = data_locations[:game_teams]

    StatTracker.new(games_path, teams_path, game_teams_path)
  end

  ####### Game Stats ########

  ###########################

  ###### Team Stats #########

  ###########################

  ###### League Stats #######

  ###########################

  ###### Season Stats #######

  ###########################
end 
