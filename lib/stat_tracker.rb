require 'csv'
require_relative './game'
require_relative './team'
require_relative './game_team'
require_relative './game_statistics'


class StatTracker
  include GameStatistics
  
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    games = []
    CSV.foreach(locations[:games], :headers=> true) do |row|
      games.push(Game.new(row))
    end

    teams = []
    CSV.foreach(locations[:teams], :headers=> true) do |row|
      teams.push(Team.new(row))
    end

    game_teams = []
    CSV.foreach(locations[:game_teams], :headers=> true) do |row|
      game_teams.push(GameTeam.new(row))
    end

    StatTracker.new(games, teams, game_teams)
  end
end
