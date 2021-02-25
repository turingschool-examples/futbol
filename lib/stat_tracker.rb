require 'CSV'
require './lib/game_manager'
require './lib/team_manager'
require './lib/game_team_manager'

class StatTracker

  def initialize(games_path, team_path, game_teams_path)
    @games = GamesManager.new(games_path)
    @teams = TeamsManager.new(team_path)
    @game_teams = GameTeamsManager(game_team_path)

     # require "pry"; binding.pry
  end

  def self.from_csv(data_locations)

    games_path = data_locations[:games]
    teams_path = data_locations[:teams]
    game_teams_path = data_locations[:game_teams]
    # CSV.foreach(data_locations[:teams], headers: true, header_converters: :symbol) do |row|
    #   teams << Team.new(row)
    # end
    # CSV.foreach(data_locations[:game_teams], headers: true, header_converters: :symbol) do |row|
    #   game_teams << GameTeam.new(row)
    # end
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
