require './lib/game.rb'
require './lib/team.rb'
require './lib/game_team.rb'
require 'CSV'

class StatTracker
  attr_reader :games, :teams, :game_teams
  def initialize(locations)
    @locations = locations
    @file_hashes = {}
    @games = {}
    @teams = {}
    @game_teams = {}
  end

  def process_files
    retrieve_game_teams
    retrieve_games
    retrieve_teams
  end

  def retrieve_game_teams
    CSV.foreach(@locations[:game_teams], headers: true) do |row|
      @game_teams[row[0]] = {} if !@game_teams[row[0]]
      @game_teams[row[0]][row[2]] = GameTeam.new(row)
    end
  end

  def retrieve_games
    CSV.foreach(@locations[:games], headers: true) do |row|
      @games[row[0]] = Game.new(row)
    end
  end

  def retrieve_teams
    CSV.foreach(@locations[:teams], headers: true) do |row|
      @teams[row[0]] = Team.new(row)
    end
  end

end
