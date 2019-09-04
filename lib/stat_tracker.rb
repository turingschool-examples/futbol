require 'CSV'
require './lib/team'
require './lib/game'
require 'pry'

class StatTracker
  attr_reader :teams, :games

  def initialize(teams, games)
    @teams = teams
    @games = games
  end

  def self.from_csv(locations)
    teams = []
    games = []
    CSV.read(locations[:teams]).each_with_index do |line, index|
      unless index == 0
        teams << Team.new(line)
      end
    end
    CSV.read(locations[:games]).each_with_index do |line, index|
      unless index == 0
        games << Game.new(line)
      end
    end
    StatTracker.new(teams, games)
  end
  #binding.pry
end
