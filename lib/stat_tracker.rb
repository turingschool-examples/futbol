require "csv"
require_relative "game"

class StatTracker
  attr_reader :games
  def initialize(games)
    @games = games
  end

  def self.from_csv(locations)
    games = self.generate_games(locations[:games])
    self.new(games)
  end

  def self.generate_games(location)
    array = Array.new
    CSV.foreach(location, headers: true) do |row|
      array << Game.new(row.to_hash)
    end
    array
  end
end