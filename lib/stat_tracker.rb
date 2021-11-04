require 'csv'
require 'pry'
require './lib/game'
require './lib/team'
require './lib/game_team'

require './lib/season_methods'

class StatTracker
  include SeasonMethods

  attr_reader :games, :teams, :game_teams

  def initialize
    @games = []
    @teams = []
    @game_teams = []
  end

  def self.from_csv(filenames)
    stat_tracker = StatTracker.new
    stat_tracker.make_games(filenames)
    stat_tracker.make_teams(filenames)
    stat_tracker.make_game_teams(filenames)
    stat_tracker
  end

  def make_games(filenames)
    CSV.foreach(filenames[:games], headers: true) do |row|
      @games << Game.new(row)
    end
  end

  def make_teams(filenames)
    CSV.foreach(filenames[:teams], headers: true) do |row|
      @teams << Team.new(row)
    end
  end

  def make_game_teams(filenames)
    CSV.foreach(filenames[:game_teams], headers: true) do |row|
      @game_teams << GameTeam.new(row)
    end
  end


end






StatTracker.from_csv({ games: './data/games.csv',
                       teams: './data/teams.csv',
                       game_teams: './data/game_teams.csv' })
