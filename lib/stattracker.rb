require 'CSV'

class StatTracker
  attr_reader :file

  def initialize(file)
    @file = file
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end
end
