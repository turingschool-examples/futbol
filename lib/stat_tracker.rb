require 'CSV'
require './lib/game'

class StatTracker

  def initialize
    # @games = []
  end

  def self.from_csv(data_locations)
    @games = []
    stat_tracker = StatTracker.new
    CSV.foreach(data_locations[:games], headers: true, header_converters: :symbol) do |row|
      @games << Game.new(row)
    end
    require "pry"; binding.pry
  end

end
