require 'csv'
require './lib/game'
require './lib/team'
require './lib/game_teams'
require_relative 'stats'


class StatTracker 
  attr_reader :games, :teams, :game_teams

  def initialize(locations)
    @games = locations[:games]
    @teams = locations[:teams]
    @game_teams = locations[:game_teams]
  end
  
  def self.from_csv(locations)
    Stats.new(locations)
    StatTracker.new(locations)
  end
end

