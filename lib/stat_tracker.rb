require 'CSV'

class StatTracker
  attr_reader :games

  def initialize
  end

  def self.from_csv(locations)
    StatTracker.new
  end
end
