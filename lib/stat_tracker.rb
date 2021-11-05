require 'csv'
require 'pry'
require_relative './game_team'
require_relative './game'
require_relative './team'
require_relative './season_methods'
require_relative './teams_methods'
require_relative './league_methods'

class StatTracker
  include SeasonMethods
  include Teams_Methods
  include LeagueMethods

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
                       game_teams: './data/game_teams_test.csv' })
