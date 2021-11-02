require 'csv'
require 'simplecov'

SimpleCov.start

class StatTracker

  def self.from_csv(locations)
    StatTracker.new(locations)
    
  end

  def initialize(locations)

  end

end
