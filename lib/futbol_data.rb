require 'csv'
require 'pry'
require_relative './game_team'
require_relative './game'
require_relative './team'

class FutbolData
  attr_reader :games, :teams, :game_teams

  def initialize(filenames)
    @games = make_games(filenames)
    @teams = make_teams(filenames)
    @game_teams = make_game_teams(filenames)
  end

  def make_games(filenames)
    games = []
    CSV.foreach(filenames[:games], headers: true) do |row|
      games << Game.new(row)
    end
    games
  end

  def make_teams(filenames)
    teams = []
    CSV.foreach(filenames[:teams], headers: true) do |row|
      teams << Team.new(row)
    end
    teams
  end

  def make_game_teams(filenames)
    game_teams =[]
    CSV.foreach(filenames[:game_teams], headers: true) do |row|
      game_teams << GameTeam.new(row)
    end
    game_teams
  end

end
