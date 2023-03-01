require 'csv'
require './lib/game_teams'

class StatTracker
  @@games = []
  @@teams = []
  @@game_teams = []

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end
  
  def self.from_csv(locations)
    StatTracker.new(locations[:games], locations[:teams], locations[:game_teams])
  end
  
  def games
    games = CSV.open @games, headers: true, header_converters: :symbol
    games.each do |game|
      @@games << game = Game.new(game) 
    end
    @@games
  end

  def teams
    teams = CSV.open @teams, headers: true, header_converters: :symbol
    teams.each do |team|
      @@teams << teams = GameTeams.new(team)
    end
    @@teams
  end

  def game_teams
    game_teams = CSV.open @game_teams, headers: true, header_converters: :symbol
    game_teams.each do |game_teams|
      @@game_teams << game_teams = GameTeams.new(game_teams)
    end
     @@game_teams
  end
end