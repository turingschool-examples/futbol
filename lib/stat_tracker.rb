require 'csv'
require_relative './game'
require_relative './team'
require_relative './game_team'
require_relative './game_statistics'
require_relative './league_statistics'


class StatTracker
  include GameStatistics
  include LeagueStatistics

  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    games = {}
    CSV.foreach(locations[:games], :headers=> true) do |row|
      game = Game.new(row)
      games[game.game_id] = game
    end

    teams = {}
    CSV.foreach(locations[:teams], :headers=> true) do |row|
      team = Team.new(row)
      teams[team.team_id] = team
    end

    game_teams = []
    CSV.foreach(locations[:game_teams], :headers=> true) do |row|
      game_teams.push(GameTeam.new(row))
    end

    new(games, teams, game_teams)
  end
end
