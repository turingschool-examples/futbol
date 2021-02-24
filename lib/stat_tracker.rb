require 'CSV'
require './lib/game'
require './lib/team'
require './lib/game_team'

class StatTracker

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
    # require "pry"; binding.pry
  end

  def self.from_csv(data_locations)
    games = []
    teams = []
    game_teams = []
    CSV.foreach(data_locations[:games], headers: true, header_converters: :symbol) do |row|
      games << Game.new(row)
    end
    CSV.foreach(data_locations[:teams], headers: true, header_converters: :symbol) do |row|
      teams << Team.new(row)
    end
    CSV.foreach(data_locations[:game_teams], headers: true, header_converters: :symbol) do |row|
      game_teams << GameTeam.new(row)
    end
    stat_tracker = StatTracker.new(games, teams, game_teams)
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
