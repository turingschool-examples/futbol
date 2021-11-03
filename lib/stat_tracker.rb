require 'csv'
require 'pry'
require './lib/game'

class StatTracker
  attr_reader :games

  def initialize
    @games = []
  end

  def self.from_csv(filenames)
    stat_tracker = StatTracker.new
    stat_tracker.make_games(filenames)
    binding.pry
    stat_tracker
  end

  def make_games(filenames)
    CSV.foreach(filenames[:games], headers: true) do |row|
      @games << Game.new(row)
    end
  end
end

StatTracker.from_csv({ games: './data/games.csv' })
