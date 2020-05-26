class StatTracker

  attr_reader :from_csv

  def initialize(locations)
    @locations = locations
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

end
