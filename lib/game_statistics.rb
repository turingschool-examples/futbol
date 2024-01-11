require 'csv'
require './lib/game.rb'

class GameStatistics
  attr_reader :games

  def initialize(games)
    @games = games
  end

  def self.from_csv(filepath)
    games = []

    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
      games << Games.new(row)
    end

    new(games)
  end



end
