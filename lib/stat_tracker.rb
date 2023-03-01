require 'csv'
require_relative 'game'
require_relative 'team'

class StatTracker 
  #include modules

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)

  end
end
