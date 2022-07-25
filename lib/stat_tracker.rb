require 'csv'

class StatTracker
  attr_reader :files

  def initialize(locations)
    @files = {}
    @files = locations.each_key do |key|
      @files[key] = CSV.open locations[key]
    end

  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end
end
