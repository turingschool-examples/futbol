require 'csv'
require 'pry'
require './lib/game'
require './lib/team'

class StatTracker
  attr_reader :games, :teams

  def initialize
    @games = []
    @teams = []
  end

  def self.from_csv(filenames)
    stat_tracker = StatTracker.new
    stat_tracker.make_games(filenames)
    stat_tracker.make_teams(filenames)
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


  #def count_of_games_by_season
    #@season.tally
  #end

  #def count_of_teams
   # @team_id.count
 # end

end

StatTracker.from_csv({ games: './data/games.csv' })
