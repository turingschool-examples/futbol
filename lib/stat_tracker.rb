require 'CSV'

class StatTracker
  def initialize(params)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)  #This gets the test to pass but is probably wrong
  end
end
