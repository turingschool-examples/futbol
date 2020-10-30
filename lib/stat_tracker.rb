require_relative './game.rb'
require_relative './team.rb'
require_relative './game_team.rb'
require 'CSV'

class StatTracker
  attr_reader :games, :teams, :game_teams
  def initialize(locations)
    @locations = locations
     #because we are creating an object without initialize, we have to manually return the instance that was created.
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def retrieve_game_teams
    output_hash = {}
    CSV.foreach(@locations[:game_teams], headers: true) do |row|
      output_hash[row[0]] = {} if !output_hash[row[0]]
      output_hash[row[0]][row[2]] = GameTeam.new(row)
    end
    output_hash
  end

  def retrieve_games
    output_hash = {}
    CSV.foreach(@locations[:games], headers: true) do |row|
      output_hash[row[0]] = Game.new(row)
    end
    output_hash
  end

  def retrieve_teams
    output_hash = {}
    CSV.foreach(@locations[:teams], headers: true) do |row|
      output_hash[row[0]] = Team.new(row)
    end
    output_hash
  end
  
end
