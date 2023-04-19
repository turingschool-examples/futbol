require "csv"
require_relative './game'

class StatTracker
  attr_reader :games

  def self.from_csv(files)
    StatTracker.new(files)
  end

  def initialize(files)
    @games = (CSV.open files[:games], headers: true, header_converters: :symbol).map do |row|
      game = Game.new(row)
    end
    require 'pry'; binding.pry
  end
end
