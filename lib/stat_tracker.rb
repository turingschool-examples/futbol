require_relative './team'
require_relative './game'
require_relative './game_team'
require_relative './helper_methods'
require_relative './game_stats'
require 'csv'
require 'pry'

class StatTracker
  include GameStats
  include HelperMethods

  attr_reader :teams, :games, :game_teams

  def initialize(teams, games, game_teams)
    @teams = teams
    @games = games
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    teams = []
    CSV.foreach(locations[:teams], :headers => true) do |line|
      teams << Team.new(line)
    end

    games = []
    CSV.foreach(locations[:games], :headers => true) do |line|
      games << Game.new(line)
    end

    game_teams = []
    CSV.foreach(locations[:game_teams], :headers => true) do |line|
      game_teams << GameTeam.new(line)
    end

    StatTracker.new(teams, games, game_teams)
  end

end
