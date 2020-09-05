require 'csv'
require_relative 'game'
require_relative 'game_teams'
require_relative 'team'
require_relative 'team_statistics'

class StatTracker
  include TeamStatistics

  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    games = generate_games(locations[:games])
    teams = generate_teams(locations[:teams])
    game_teams = generate_game_teams(locations[:game_teams])
    self.new(games, teams, game_teams)
  end

  def self.generate_games(location)
    array = []
    CSV.foreach(location, headers: true) do |row|
      array << Game.new(row.to_hash)
    end
    array
  end

  def self.generate_teams(location)
    array = []
    CSV.foreach(location, headers: true) do |row|
      array << Team.new(row.to_hash)
    end
    array
  end

  def self.generate_game_teams(location)
    array = []
    CSV.foreach(location, headers: true) do |row|
      array << GameTeams.new(row.to_hash)
    end
    array
  end
end
