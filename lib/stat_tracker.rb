require 'csv'
require './lib/game_teams_collection'
require './lib/game_collection'
require './lib/teams_collection'
require './lib/games'

class StatTracker
  include Game
  attr_reader :games

  def initialize(games)
    #@game_teams = game_teams
    @games = games
    #@teams = teams
  end

  def self.from_csv(locations)
    #game_teams = GameTeamsCollection.create(locations[:game_teams])
    games = Game.create(locations[:games])
    # teams =  TeamsCollection.create
    self.new(games)
    #self.new(game_teams, games, teams)
  end

end

# game_teams = CSV.foreach(locations[:game_teams]), headers: true)
# games = CSV.foreach(locations[:games]), headers: true)
# teams = CSV.foreach(locations[:teams]), headers: true)
