require 'csv'
require './lib/game_teams_collection'
require './lib/games_collection'
require './lib/teams_collection'

class StatTracker

  def initialize(game_teams, games, teams)
    @game_teams = game_teams
    @games = games
    @teams = teams
  end

  def self.from_csv(locations)
    game_teams = GameTeamsCollection.create
    games =  GamesCollection.create
    teams =  TeamsCollection.create
    self.new(game_teams, games, teams)
  end

end


# game_teams = CSV.foreach(locations[:game_teams]), headers: true)
# games = CSV.foreach(locations[:games]), headers: true)
# teams = CSV.foreach(locations[:teams]), headers: true)
